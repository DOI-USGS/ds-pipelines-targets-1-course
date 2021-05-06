Most of our pipelines in R use a `remakefile` file to "orchestrate" the connections among files, functions, and phases. In this issue, we're going to develop a basic understanding of how these files work, starting with the anatomy of a `remakefile`.

#### Background

A `remakefile` uses the [yaml file format](https://en.wikipedia.org/wiki/YAML). A basic understanding of YAML is important for making use of `remakefiles`, including creating your own or editing existing files. Additionally, several of the tools and workflows common to USGS data science take advantage of a YAML file to do other things too, so you may bump into them elsewhere. YAML ("YAML ain't markup language") files are fairly simple, flexible, and readable, but there is a bit of a learning curve. We're not going to get too far into YAMLs, but reading up on them or finding a good reference for future use might be a good idea.

#### Using remakefiles in data science pipelines

In addition to phases (which we covered in {{ store.structure_activity_url }}), it is important to decompose high-level concepts (or existing scripts) into thoughtful functions and "targets" that form the building blocks of data processing pipelines. A target is a noun we use to describe a tangible output of function, which is often a file or an R object. Targets can be used as an end-product (like a summary map) or as input _into_ another function to create _another_ target. 

---
The simplest version of a `remakefile` (adapted from the [remake repo](https://github.com/richfitz/remake)) might look something like this:

```yaml
sources:
  - code.R

targets:
  all:
    depends: figure_1.png

  model_RMSEs.csv:
    command: download_data(out_filepath = "model_RMSEs.csv")

  plot_data:
    command: process_data(in_filepath = "model_RMSEs.csv")

  figure_1.png:
    command: myplot(out_filepath = "figure_1.png", data = plot_data)
```


This file defines the relationships between different "targets" (see how the target `model_RMSEs.csv` is an input to the command that creates the target `plot_data`?), tells us where to find any functions that are used to build targets (see that `sources` points you to `code.R`), and isolates the output(s) that _must_ be created in order to complete the `all` target (in this case, it is only the `figure_1.png` file). 

Even though this is a simple example, there is some new syntax that may be confusing. We'll explain a few of these quickly:
 - `command` is a field that specifies what _function_ should be called in order to build each target.
 - `depends` is a field that explicity specifies a _dependency_ of a target. So when that dependency is considered "out of date" (more on that later), the target that lists that dependency in `depends` is also going to be "out of date". In this way, the "all" target can't be complete and up-to-date until `figure_1.png` is.
 - `all` is a special target that groups other targets. We'll cover group targets - like `all` - more later on.
 - `model_RMSEs.csv` shows up three times, why? `model_RMSEs.csv` is a file target that gets _created_ when the command `download_data` is run, and is an input to that same function in order to tell the function what file name to write the data to. Then `"model_RMSEs.csv"` shows up as an _input_ to another function, `process_data`, which looks like it reads in that file and changes it (or "processes" it) in some way.

---

We're going to start with this simple example, and modify it to match our pipeline structure. This will start by creating a new branch, creating a new file, adding that file to git tracking, and opening a new pull request that includes the file:

### :keyboard: Activity: get your code plugged into a remake file

First things first: We're going to want a new branch. You can delete your previous one, since that pull request was merged. 
```
git checkout master
git pull
git branch -d structure
git checkout -b remakefile
git push -u origin remakefile 
```
---
Next, create the file with the contents we've given you by entering the following from your repo directory in terminal/command line:
```
cat > remake.yml
sources:
  - code.R

targets:
  all:
    depends: figure_1.png

  model_RMSEs.csv:
    command: download_data(out_filepath = "model_RMSEs.csv")

  plot_data:
    command: process_data(in_filepath = "model_RMSEs.csv")

  figure_1.png:
    command: myplot(out_filepath = "figure_1.png", data = plot_data)
```    

then use `Ctrl+D` to exit the file creation mode and return to the prompt. 

---
Finally, create a [pull request]({{ repoUrl }}/pulls) that includes this new file (the file should be called `remake.yml`).

<hr>
<h3 align="center">When I see your pull request, I'll make some in-line suggestions for next steps.</h3>



