
So, what does this do for you? Well, if you had this `remake.yml` file in your current working directory (which you do), and you had defined the `download_data()`, `process_data()`, and `myplot()` functions in `code.R` (which you haven't), it would look like this when you ran `scmake` from the `scipiper` package:

![scmake run image](https://user-images.githubusercontent.com/2349007/82728127-16df4a00-9cb4-11ea-927a-a68a1d5dea00.png)

---
Now - adding on to this PR by pushing up additional commits - add and modify code, folders, and this remake file so you can build _your_ `3_visualize/out/figure_1.png` with `scipiper::scmake()` (BTW, if you haven't run into this syntax, {package_name}::{function_name} allows you to run a function without `library({package_name})`). Build on your existing folders, functions, and code from the previous sections. Comment in the pull request with a screenshot of the build message, like we have in the message above :point_up:. Assign Alison or Jordan to review your PR, and we may ask for a few changes before merging. 

Also, there is a file in your repo called `.gitignore`. add a line with `.remake` and a line with `1_fetch/out/*.csv` so that git doesn't track the contents of the remake directory and doesn't store changes to your downloaded .csv files in `1_fetch`. 


