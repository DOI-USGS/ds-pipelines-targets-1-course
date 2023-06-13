
library(dplyr)
library(readr)
library(stringr)
library(sbtools)
library(whisker)

project_output_dir <- 'my_dir'

dir.create(project_output_dir)

mendota_file <- file.path(project_output_dir, 'model_RMSEs.csv')
item_file_download('5d925066e4b0c4f70d0d0599', names = 'me_RMSE.csv', destinations = mendota_file, overwrite_file = TRUE)

eval_data <- readr::read_csv(mendota_file, col_types = 'iccd') |>
  filter(str_detect(exper_id, 'similar_[0-9]+')) |>
  mutate(
    col = case_when(
      model_type == 'pb' ~ '#1b9e77',
      model_type == 'dl' ~'#d95f02',
      model_type == 'pgdl' ~ '#7570b3'
      ), 
    pch = case_when(
      model_type == 'pb' ~ 21,
      model_type == 'dl' ~ 22,
      model_type == 'pgdl' ~ 23
      ), 
    n_prof = as.numeric(str_extract(exper_id, '[0-9]+'))
    )

# start of plot -------------------

# define plot details
n_profs <- c(2, 10, 50, 100, 500, 980)
line_wt <- 0.5
pt_size <- 3
lim_y <- c(0, 5)
lim_x <- c(1, 1000)
dist_dodge <- 0.05

# Create a plot

## add data and labels
g <- 
  ggplot(data = data_plt, 
         aes(color = model_type, shape = model_type)) +
  geom_line(aes(x = n_prof, y = mean), 
            linetype = "dashed",
            lwd = line_wt,
            position = position_dodge(width = dist_dodge)) +
  geom_linerange(aes(x = n_prof, ymin = min, ymax = max),
                 lwd = line_wt,
                 position = position_dodge(width = dist_dodge)) +
  geom_point(aes(x = n_prof, y = mean), 
             position = position_dodge(width = dist_dodge), 
             fill = "white",
             size = pt_size) +
  labs(
    x = "Training Temperature Profiles (#)",
    y = "Test RMSE (°C)"
  )

# modify scales
g <- g +
  scale_x_log10(breaks = n_profs, limits = lim_x) +
  scale_y_continuous(limits = rev(lim_y), trans = "reverse") +
  scale_color_manual("", values = c("#7570b3", "#d95f02", "#1b9e77")) +
  scale_shape_manual("", values = c(23, 22, 21))

# finalize theme
g <- g +
  theme_classic(base_size = 14) +
  theme(legend.position = c(0.3, 0.90))

# save plot 
ggsave(plot = g, filename = file_out, 
       width = 1600, height = 2000, units = "px")

# end of plot -------------------

readr::write_csv(eval_data, path = file.path(project_output_dir, 'model_summary_results.csv'))


render_data <- list(pgdl_980mean = filter(eval_data, model_type == 'pgdl', exper_id == "similar_980") |> pull(rmse) |> mean |> round(2),
                    dl_980mean = filter(eval_data, model_type == 'dl', exper_id == "similar_980") |> pull(rmse) |> mean |> round(2),
                    pb_980mean = filter(eval_data, model_type == 'pb', exper_id == "similar_980") |> pull(rmse) |> mean |> round(2),
                    dl_500mean = filter(eval_data, model_type == 'dl', exper_id == "similar_500") |> pull(rmse) |> mean |> round(2),
                    pb_500mean = filter(eval_data, model_type == 'pb', exper_id == "similar_500") |> pull(rmse) |> mean |> round(2),
                    dl_100mean = filter(eval_data, model_type == 'dl', exper_id == "similar_100") |> pull(rmse) |> mean |> round(2),
                    pb_100mean = filter(eval_data, model_type == 'pb', exper_id == "similar_100") |> pull(rmse) |> mean |> round(2),
                    pgdl_2mean = filter(eval_data, model_type == 'pgdl', exper_id == "similar_2") |> pull(rmse) |> mean |> round(2),
                    pb_2mean = filter(eval_data, model_type == 'pb', exper_id == "similar_2") |> pull(rmse) |> mean |> round(2))

template_1 <- 'resulted in mean RMSEs (means calculated as average of RMSEs from the five dataset iterations) of {{pgdl_980mean}}, {{dl_980mean}}, and {{pb_980mean}}°C for the PGDL, DL, and PB models, respectively.
  The relative performance of DL vs PB depended on the amount of training data. The accuracy of Lake Mendota temperature predictions from the DL was better than PB when trained on 500 profiles 
  ({{dl_500mean}} and {{pb_500mean}}°C, respectively) or more, but worse than PB when training was reduced to 100 profiles ({{dl_100mean}} and {{pb_100mean}}°C respectively) or fewer.
  The PGDL prediction accuracy was more robust compared to PB when only two profiles were provided for training ({{pgdl_2mean}} and {{pb_2mean}}°C, respectively). '

whisker.render(template_1 |> str_remove_all('\n') |> str_replace_all('  ', ' '), render_data ) |> cat(file = file.path(project_output_dir, 'model_diagnostic_text.txt'))




