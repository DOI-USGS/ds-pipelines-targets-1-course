So, what does this do for you? Well, if you had this `_targets.R` file in your current working directory (which you do), and you had defined the `download_data()`, `process_data()`, and `myplot()` functions in `code.R` (which you haven't), it would look like this when you ran `tar_make()` from the `targets` package:

![targets run image](https://user-images.githubusercontent.com/13220910/113453031-ce5fe500-93ca-11eb-93ee-1485aa0b4686.png)

---
Now - adding on to this PR by pushing up additional commits - add and modify code, folders, and this makefile so you can build _your_ `3_visualize/out/figure_1.png` with `targets::tar_make()` (BTW, if you haven't run into this syntax, {package_name}::{function_name} allows you to run a function without `library({package_name})`). Build on your existing folders, functions, and code from the previous sections. Comment in the pull request with a screenshot of the build message, like we have in the message above :point_up:. Assign [Alison](https://github.com/aappling-usgs) or [Jordan](https://github.com/jread-usgs) to review your PR, and we may ask for a few changes before merging. 

Also, there is a file in your repo called `.gitignore`. add a line with `_targets` and a line with `1_fetch/out/*.csv` so that git doesn't track the contents of the `targets` directory and doesn't store changes to your downloaded .csv files in `1_fetch`. 

