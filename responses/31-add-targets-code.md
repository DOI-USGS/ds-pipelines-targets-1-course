So, what does this do for you? Well, if you had this `_targets.R` file in your current working directory (which you do), and you had defined the `download_data()`, `process_data()`, `plot_data()`, and `generate_diagnostics()` functions in `code.R` (which you haven't), it would look like this when you ran `tar_make()` from the `targets` package:

![targets run image](https://user-images.githubusercontent.com/13220910/128781588-64911332-6464-4cb3-b77d-eaa7063d6bc1.png)

---
Now - adding on to this PR by pushing up additional commits - add and modify code, folders, and this makefile so you can build _your_ `3_visualize/out/figure_1.png` with `targets::tar_make()` (BTW, if you haven't run into this syntax, {package_name}::{function_name} allows you to run a function without `library({package_name})`). Build on your existing folders, functions, and code from the previous sections by continuing with the phases `1_fetch`, `2_process`, and `3_visualize`. Comment in the pull request with a screenshot of the build message, like we have in the message above :point_up:. Assign your course contact to review your PR, and we may ask for a few changes before merging. 

There is a file in your repo called `.gitignore`. Add a line with `_targets` so that git doesn't track the contents of the `targets` directory. In addition, make sure that the contents of `1_fetch/out/*` will be ignored by git because you don't want to store changes to your downloaded .csv files (you may have already added a more generic `*/out/*` to your `.gitignore` that handles all `out/` folders in this repo). 

