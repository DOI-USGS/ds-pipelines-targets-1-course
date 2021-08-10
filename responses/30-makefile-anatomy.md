Our `targets` pipelines in R use a `makefile` file to orchestrate the connections among files, functions, and phases. In this issue, we're going to develop a basic understanding of how these files work, starting with the anatomy of the `_targets.R` file.

#### Setting up a `targets` data science pipeline

In addition to phases (which we covered in {{ store.structure_activity_url }}), it is important to decompose high-level concepts (or existing scripts) into thoughtful functions and "targets" that form the building blocks of data processing pipelines. A target is a noun we use to describe a tangible output of a function, which is often a file or an R object. Targets can be used as an end-product (like a summary map) or as input _into_ another function to create _another_ target. 

To set up a `targets` pipeline, you will need to create the base makefile named `_targets.R` that will declare and orchestrate the rest of the pipeline connections.

---
A simple version of `_targets.R` might look something like this:

```r
library(targets)
source("code.R")
tar_option_set(packages = c("tidyverse", "sbtools", "whisker"))

list(
  tar_target(
    model_RMSEs_csv,
    download_data(out_filepath = "model_RMSEs.csv"),
    format = "file"
  ), 
  tar_target(
    eval_data,
    process_data(in_filepath = model_RMSEs_csv),
  ),
  tar_target(
    figure_1_png,
    make_plot(out_filepath = "figure_1.png", data = eval_data), 
    format = "file"
  )
)
```


This file defines the relationships between different "targets" (see how the target `model_RMSEs_csv` is an input to the command that creates the target `eval_data`?), tells us where to find any functions that are used to build targets (see the `source` call that points you to `code.R`), and declares the package dependencies needed to build the different targets (see the `target_option_set()` command that passes in a vector of packages). 

We'll briefly explain some of the functions and conventions used here. For more extensive explanations, visit [the `targets` documentation](https://books.ropensci.org/targets/walkthrough.html). 

  - As you would with normal R scripts, put any `source` commands for loading R files and `library` commands for loading packages at the top of the file. The packages loaded here should be only those needed to build the targets _plan_; packages needed to build specific _targets_ can be loaded later.
  - Declare each target by using the function `tar_target()` and passing in a target name (`name` arg) and the expression to run to build the target (`command` arg).
  - There are two types of targets - objects and files. If your target is a file, you need to add `format = "file"` to your `tar_target()` call and the command needs to return the filename of the new file.
  - Setup the full pipeline by combining all targets into a single `list` object.
  - There are 2 ways to define packages used to build targets: 1) declare using the `packages` argument in `tar_option_set()` in your makefile to specify packages used by all targets or 2) use the `packages` argument in individual `tar_target()` functions for packages that are specific to those targets.
  - `model_RMSEs_csv` shows up two times - why? `model_RMSEs_csv` is the name of a target that creates the file `model_RMSEs.csv` when the command `download_data()` is run. When passed in as input to other functions (unquoted), it represents the filename of the file that was created when it was built. So when `model_RMSEs_csv` shows up as an _argument_ to another function, `process_data()`, it is really passing in the filename. The `process_data()` function then reads the files and changes the data (or "processes" it) in some way. 
  
---

We're going to start with this simple example, and modify it to match our pipeline structure. This will start by creating a new branch, creating a new file, adding that file to git tracking, and opening a new pull request that includes the file:

### :keyboard: Activity: get your code plugged into a makefile

First things first: We're going to want a new branch. You can delete your previous one, since that pull request was merged. 
```
git checkout main
git pull
git branch -d structure
git checkout -b makefile
git push -u origin makefile 
```
---
Next, create the file with the contents we've given you by entering the following from your repo directory in terminal/command line:
```
cat > _targets.R
library(targets)
source("code.R")
tar_option_set(packages = c("tidyverse", "sbtools", "whisker"))

list(
  # Get the data from ScienceBase
  tar_target(
    model_RMSEs_csv,
    download_data(out_filepath = "model_RMSEs.csv"),
    format = "file"
  ), 
  # Prepare the data for plotting
  tar_target(
    eval_data,
    process_data(in_filepath = model_RMSEs_csv),
  ),
  # Create a plot
  tar_target(
    figure_1_png,
    make_plot(out_filepath = "figure_1.png", data = eval_data), 
    format = "file"
  ),
  # Save the processed data
  tar_target(
    model_summary_results_csv,
    write_csv(eval_data, file = "model_summary_results.csv"), 
    format = "file"
  ),
  # Save the model diagnostics
  tar_target(
    model_diagnostic_text_txt,
    generate_model_diagnostics(out_filepath = "model_diagnostic_text.txt", data = eval_data), 
    format = "file"
  )
)
```    

then use `Ctrl+D` to exit the file creation mode and return to the prompt. 

---
Finally, create a [pull request]({{ repoUrl }}/pulls) that includes this new file (the file should be called `_targets.R`).

<hr>
<h3 align="center">When I see your pull request, I'll make some in-line suggestions for next steps.</h3>

