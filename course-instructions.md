<details>
<summary><h2>Pipelines Overview</h2></summary>

**Welcome to the first installment of "introduction to data pipelines"** at USGS!! :sparkles:

Data analyses are often complex. Data pipelines are ways of managing that complexity. Our data pipelines have two foundational pieces:

* Good organization of code scripts helps you quickly find the file you need, whether you or a teammate created it.

* Dependency managers such as `remake`, `scipiper`, `snakemake`, `drake`, and `targets` formalize the relationships among the datasets and functions to ensure reproducibility while also minimizing the amount of unnecessary runtime as you're creating or modifying parts of the pipeline.

</details>

<hr> 

<details>
<summary><h2>Getting Started With USGS Data Science Pipelines</h2></summary>

<h3>:keyboard: Installing tools</h3>

Before getting started, you'll need some R packages. You will need to install `targets` and its companion package, `tarchetypes`. 

```r
install.packages(c("targets", "tarchetypes"))
```

While you are at it, please install a few other packages that you'll use along the way:

```r
install.packages(c("tidyverse", "sbtools", "whisker", "dataRetrieval"))
```

When all packages are installed, check the version of the `targets` package with `packageVersion("targets")`, and verify that the number you just output is greater than or equal to `0.3.1`. 

If not, try re-installing:

```r
install.packages(c("targets", "tarchetypes"))
library(targets)
```

If you can't get it to work, try contacting your designated course instructor!

</details>

<hr>

<details>
<summary><h2>Create a Branch in Your Code Repository</h2></summary>

You'll be revising files in this repository shortly. To follow our team's standard git workflow, you should first clone this training repository to your local machine so that you can make file changes and commits there. 

Open a git bash shell (Windows) or a terminal window (Mac) and change (`cd`) into the directory you work in for projects in R (for me, this is `~/Documents/R`). There, clone the repository and set your working directory to the new project folder that was created:
```
git clone git@github.com:<username>/ds-pipelines-targets-1-course.git
cd ds-pipelines-targets-1-course
```

Now you should create a local branch called "structure" and push that branch up to the "remote" location (which is the github host of your repository). We're naming this branch "structure" to represent concepts in this section of the lab. In the future you'll probably choose branch names according to the type of work they contain - for example, "pull-oxygen-data" or "fix-issue-17".

```
git checkout -b structure
git push -u origin structure
```

By using `checkout`, you have switched your local branch from "main" to "structure", and any changes you make from here on out to _tracked_ files will not show up on the main branch. To take a look back at "main", you can always use `git checkout main` and return to "structure" with `git checkout structure`. We needed the `-b` flag initially because we wanted to combine two operations - creating a new branch (`-b`) and switching to that new branch (`checkout`). 

While you are at it, this is a good time to invite a few collaborators to your repository, which will make it easier to assign them as reviewers in the future. In the :gear: Settings widget at the top of your forked repo, select "Manage access". Go ahead and invite your course labmate(s). It should look something like this: 
![add some friends](https://user-images.githubusercontent.com/2349007/81471981-c0094900-91ba-11ea-93b0-0ffd31ec4ea9.png)

You can move on from this issue when you've successfully pushed your branch to remote and added some collaborators. A successful push of the branch will result in a message that looks like this `"Branch 'structure' set up to track remote branch 'structure' from 'origin'"`

</details>

<hr>

<details>
<summary><h2>Organize Your Project Files</h2></summary>

You should organize your code into functions, targets, and conceptual "phases" of work. 

Often we create temporary code or are sent scripts that look like `my_work_R/my_happy_script.R` in this repository. Take a minute to look through that file now. 

This code has some major issues, including that it uses a directory that is specific to a user, it plots to a non-project file location, and the structure of the code makes it hard to figure out what is happening. This simple example is a starting point for understanding the investments we make to move towards code that is more reproducible, more shareable, and understandable. Additionally, we want to structure our code and our projects in a way where we can build on top of them as the projects progress. 

<hr> 

We're going to combine several tasks into this assignment. You'll be asked to make some modifications to your training repository and also to create a [pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) that captures these changes. 

### Background on phases 

We use team conventions for how our pipelines are organized, which make it easier to hop in and out of collaborative projects and to rapidly understand what is going on where. 

We refer to major elements of a pipeline as "phases", and name phases according to their purpose, such as `1_fetch` or `2_process`. These phases are used to separate files and data based on the _intent_ of the code we are writing, and make it tractable to figure out where you'd need to edit code if you were coming in fresh to the project.

For medium to large pipelines projects, you'll see these workflow phases explicitly named by a number often followed by a verb (separated by an underscore). We use these phases to create different folders :file_folder: for data and code, and also to specify how we orchestrate the running of code (more on that later).

So, if we have a `1_fetch` phase, code in the fetch folder :file_folder: would be used to do things like get data from web services, google drive, an FTP, or to scrape a website. `2_process` (or `2_munge`) might contain code that transforms the "fetched" data into more usable formats. 

We recommend having `src` and `out` folders within each phase folder that contain code _for_ this phase (`src`) and data (or other files) produced _by_ this phase (`out`). When seeing some of our existing pipelines in action, you will also see other folders :file_folder: named `in`, `log`, and `tmp` to represent manually added files, logged/diagnostic output, and temporary data files, respectively.


### :keyboard: Activity: Restructure your code repository to follow our team's conventions for folders and files

Create a two phase directory structure for "fetch" and "process" concepts, and include `src` and `out` folders. Move the example script (`my_happy_script.R`) from the `my_work_R` folder into one of the `src` folders (at this time, it doesn't matter which one you choose) and delete any existing folders that aren't part of the intended structure.

When you are done, open a `pull request` with the changes.

<hr> 

Great, your PR is open! Let's do some more work before merging it. Now that your files are organized into phases, next you will add a commit to your pull request that makes changes to the code itself.

### Background on functions 

In addition to phases, it is important to decompose high-level concepts (or existing scripts) into thoughtful functions and _targets_ that form the building blocks of data processing pipelines. In addition to being the name of the pipeline package, a target is a noun we use to describe a tangible output of function, often a file or an R object, that we can use as an end-product (like a summary map), or as an input into another function. 

We strive to create _functions_ that declare their clear purpose (combining good function naming with thoughtful arguments/inputs is helpful for this) and are designed for re-use when appropriate. When writing pipelines functions, look for areas of re-usable operations or places where simple dividing lines can be drawn between different parts of data access, processing, modeling/analysis, and visualization. We use the high-level "phases" to divide the *major* concepts, but the way we scope functions is an additional subdivide. It is a best practice to have a function do a single thing, so instead of creating two plots and a table, it might be better to use one function to generate a table, which is then used as input to another function to create a plot. There are exceptions to this pattern (a 1:1 function-to-target pairing) that we'll get into later. 


### :keyboard: Activity: Modify existing code to create functions that generate plot, table, and log file outputs

We started you off with an example script in the `my_work_R` folder, which hopefully lives in either `1_fetch/src` or `2_process/src` by now. This script loads data and generates one plot, two comma-delimited tables, and a diagnostic log file. This script isn’t great and includes some bad practices that need to be cleaned up. But it should run for you without any changes as long as you are able to install the R packages used by the script.

We’re asking that you split this single script into several functions that can be used to build the same four things. When you are happy with your changes, delete the original script and commit your new script(s) into git source control. Use your same folder structure that was created for your open PR, but feel free to add a "3_visualize" phase. Note that you should only commit the code required to run your scripts. Generally, any data or files that can be reproduced by the code should not be committed to GitHub. For this reason, add anything that ends up in `*/out/*` folders to your `.gitignore` file (read more about `.gitignore` files [here](https://www.atlassian.com/git/tutorials/saving-changes/gitignore)) so that you do not accidentally commit them to GitHub.

Since you are turning the script into functions, let others know via a comment made to the pull request conversation that specifies how to run your code. For example:
```r
data <- fetch_data()
plot_results(data)
```

Push your commit(s) to the open pull request and assign your course contact for review. 

</details>

<hr>

<details>
<summary><h2>Why Use a Dependency Manager?</h2></summary>

We're asking everyone to invest in the concepts of _reproducibility_ and _efficiency of reproducibility_, both of which are enabled via dependency management systems such as `remake`, `scipiper`, `drake`, and `targets`.

### Background on reproducibility
We hope that the case for _reproducibility_ is clear - we work for a science agency, and science that can't be reproduced does little to advance knowledge or trust. 

But, the investment in _efficiency of reproducibility_ is harder to boil down into a zingy one-liner. Many of us have embraced this need because we have been bitten by issues in our real-world collaborations, and found that data science practices and a reproducibility culture offer great solutions. Karl Broman is an advocate for reproducibility in science and is faculty at UW Madison. He has given many talks on the subject and we're going to ask you to watch part of one of them so you can be exposed to some of Karl's science challenges and solutions. Karl will be talking about [GNU make](https://www.gnu.org/software/make/), which is the inspiration for almost every modern dependency tool that we can think of. Click on the image to kick off the video.

[![reproducible workflows with make](https://user-images.githubusercontent.com/2349007/81425070-81bd4c80-911c-11ea-87ea-f044df9c1c4d.png)](https://www.youtube.com/watch?v=u-ZgiYjJ4lA "Karl Broman, reproducible workflows with make")


### :computer: Activity: Watch the above video on make and reproducible workflows up until the 11 minute mark (you are welcome to watch more)

Let your course contact know what you thought was interesting about these pipeline concepts in a few sentences. 

:sparkles: Great! :sparkles:

You could consider [GNU make](https://www.gnu.org/software/make/) to be a great grandparent of the packages we referred to early in this lesson (`remake`, `scipiper`, `drake`, and `targets`). Will Landau, the lead developer of `targets`, has added a lot of useful features to dependency management systems in R, and has a great way of summarizing why we put energy into using these tools: **"Skip the work you don't need"**

We'd like you to next check out a short part of Will's video on `targets`

[![reproducible workflows with R targets](https://user-images.githubusercontent.com/2349007/81425244-cea12300-911c-11ea-8555-0c5a61fbee21.png)](https://www.youtube.com/watch?v=Gqn7Xn4d5NI "Will Landau, Reproducible computation at scale in R with targets, NYC Data Hackers virtual meetup")


### :tv: Activity: watch video on targets from at least 7:20 to 11:05 (you are welcome to watch the full talk if you'd like)

Let your course labmate know what contrasts you identified between solutions in `make` and what is offered in R-specific tools, like `targets`. 

</details>

<hr>

<details>
<summary><h2>The Anatomy of a Makefile</h2></summary>

Our `targets` pipelines in R use a `makefile` file to orchestrate the connections among files, functions, and phases. In this issue, we're going to develop a basic understanding of how these files work, starting with the anatomy of the `_targets.R` file.

### Setting up a `targets` pipeline

In addition to phases (which we covered earlier), it is important to decompose high-level concepts (or existing scripts) into thoughtful functions and "targets" that form the building blocks of data processing pipelines. A target is a noun we use to describe a tangible output of a function, which is often a file or an R object. Targets can be used as an end-product (like a summary map) or as input _into_ another function to create _another_ target. 

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

We'll briefly explain some of the functions and conventions used here. For more extensive explanations, visit the [`targets` documentation](https://books.ropensci.org/targets/walkthrough.html). 

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

Finally, create a `pull request` that includes this new file (the file should be called `_targets.R`). In the following section, we'll provide some helpful suggestions to improve your pipeline.

</details>

<hr>

<details>
<summary><h2>Modifying Your Pipeline by Adding to Your Pull Request</h2></summary>

* Great work, but it would be great to download the `model_RMSEs.csv` to `1_fetch/out/model_RMSEs.csv` instead. Can you make a change to make sure that happens when you build this target?
* Like with the downloaded data, let's move this plot output file into the appropriate phase folder (so, something like `3_visualize/out/figure_1.png`). You can also rename the figure if you'd like to use something more descriptive. 

<hr> 

So, what does this do for you? Well, if you had this `_targets.R` file in your current working directory (which you do), and you had defined the `download_data()`, `process_data()`, `plot_data()`, and `generate_diagnostics()` functions in `code.R` (which you haven't), it would look like this when you ran `tar_make()` from the `targets` package:

![targets run image](https://user-images.githubusercontent.com/13220910/128781588-64911332-6464-4cb3-b77d-eaa7063d6bc1.png)

---

Now - adding on to this PR by pushing up additional commits - add and modify code, folders, and this makefile so you can build _your_ `3_visualize/out/figure_1.png` with `targets::tar_make()` (BTW, if you haven't run into this syntax, {package_name}::{function_name} allows you to run a function without `library({package_name})`). Build on your existing folders, functions, and code from the previous sections by continuing with the phases `1_fetch`, `2_process`, and `3_visualize`. Comment in the pull request with a screenshot of the build message, like we have in the message above :point_up:. Assign your course contact to review your PR, and they may ask for a few changes before merging. 

There is a file in your repo called `.gitignore`. Add a line with `_targets` so that git doesn't track the contents of the `targets` directory. In addition, make sure that the contents of `1_fetch/out/*` will be ignored by git because you don't want to store changes to your downloaded .csv files (you may have already added a more generic `*/out/*` to your `.gitignore` that handles all `out/` folders in this repo). 

</details>

<hr>

<details>
<summary><h2>What's Next</h2></summary>

You are doing a great job! :star2: :collision: :tropical_fish:

But you may be asking why we asked you to go through all of the hard work of connecting functions, files, and targets together using a makefile. We don't blame you for wondering...

---

The real power of depedency management is when something changes - that's the EUREKA! moment, but we haven't put you in a situation where it would show up. That will come further down the road on later training activities and also in the project work you will be exposed to. 

In the meantime, here are a few nice tricks given you have a functional pipeline. 

- [ ] run `tar_make()` again. What happens? Hopefully not much. I see this: 

![make all is fresh](https://user-images.githubusercontent.com/13220910/113453089-eb94b380-93ca-11eb-92b6-25032835c028.png)

Which means everything is up to date so all targets are :OK:

- [ ] now try making a change to one of your functions in your code. What happens after running `tar_make()` then? 

- [ ] access the `eval_data` target by using `tar_load(eval_data)`. (You may or may not have an R-object target named `eval_data` in your own repo at this point, so go ahead and try it with some target that you do have.) In this example, we have passed in the unquoted target name `eval_data` to `tar_load()` which creates a data.frame object in our environment called `eval_data` because that's what our example function `process_data()` creates. If you load a file target, like `tar_load(model_RMSEs_csv)`, the resulting object in your environment is a character vector with the path to the target's file.

- [ ] now try making a change to the `template_1` variable in your function that creates the .txt file. What happens after running `tar_make()` then? Which targets get rebuilt and which do not? 

--- 

Lastly, imagine the following comment appeared on your pull request. 

> Oh shoot, I am using your results for **FANCY BIG PROJECT** and I have coded everything to assume your outputs use a character for the experiment number (the `exper_n` column), of the form "01", "02", etc. It looks like you are using numbers. Can you update your code accordingly? 

Would your code be easy to adjust to satisfy this request? Would you need to re-run any steps that aren't associated with this naming choice? Did the use of a dependency management solution allow you to both make the change efficiently (i.e., by avoiding rebuilding any unnecessary parts of the pipeline) and increase your confidence in delivering the results?

---

### You have completed introductions to pipelines I. Great work!

</details>