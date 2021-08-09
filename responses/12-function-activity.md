Great, your PR is open! Let's do some more work before merging it. Now that your files are organized into phases, next you will add a commit to your pull request that makes changes to the code itself.

#### Background

In addition to phases, it is important to decompose high-level concepts (or existing scripts) into thoughtful functions and _targets_ that form the building blocks of data processing pipelines. In addition to being the name of the pipeline package, a target is a noun we use to describe a tangible output of function, often a file or an R object, that we can use as an end-product (like a summary map), or as an input into another function. 

We strive to create _functions_ that declare their clear purpose (combining good function naming with thoughtful arguments/inputs is helpful for this) and are designed for re-use when appropriate. When writing pipelines functions, look for areas of re-usable operations or places where simple dividing lines can be drawn between different parts of data access, processing, modeling/analysis, and visualization. We use the high-level "phases" to divide the *major* concepts, but the way we scope functions is an additional subdivide. It is a best practice to have a function do a single thing, so instead of creating two plots and a table, it might be better to use one function to generate a table, which is then used as input to another function to create a plot. There are exceptions to this pattern (a 1:1 function-to-target pairing) that we'll get into later. 


### :keyboard: Activity: Modify existing code to create functions that generate plot, table, and log file outputs

We started you off with an example script in the `my_work_R` folder, which hopefully lives in either `1_fetch/src` or `2_process/src` by now. This script loads data and generates one plot, two comma-delimited tables, and a diagnostic log file. This script isn’t great and includes some bad practices that need to be cleaned up. But it should run for you without any changes as long as you are able to install the R packages used by the script.

We’re asking that you split this single script into several functions that can be used to build the same four things. When you are happy with your changes, delete the original script and commit your new script(s) into git source control. Use your same folder structure that was created for your open PR, but feel free to add a "3_visualize" phase. Note that you should only commit the code required to run your scripts. Generally, any data or files that can be reproduced by the code should not be committed to GitHub. For this reason, add anything that ends up in `*/out/*` folders to your `.gitignore` file (read more about `.gitignore` files [here](https://www.atlassian.com/git/tutorials/saving-changes/gitignore)) so that you do not accidentally commit them to GitHub.

Since you are turning the script into functions, let us know via a comment made to the pull request conversation that specifies how to run your code. For example:
```r
data <- fetch_data()
plot_results(data)
```

It is harder for us to connect robot responses up to assignments related to writing good functions, so we're going to be tagging the humans too...

Push your commit(s) to the open pull request and assign your course contact for review. 

<hr><h3 align="center">A real live human will review your pull request when you've added them as a reviewer.</h3>
