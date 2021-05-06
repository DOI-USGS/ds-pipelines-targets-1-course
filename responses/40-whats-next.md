You are doing a great job, @{{ user.username }}! :star2: :collision: :tropical_fish:

But you may be asking why we asked you to go through all of the hard work of connecting functions, files, and targets together using a yaml file. We don't blame you for wondering...

---

The real power of depedency management is when something changes - that's the EUREKA! moment, but we haven't put you in a situation where it would show up. That will come further down the road on later training activities and also in the project work you will be exposed to. 

In the meantime, here are a few nice tricks given you have a functional pipeline. 

- [ ] run `scmake()` again. What happens? Hopefully not much. I see this: 
![make all is fresh](https://user-images.githubusercontent.com/2349007/82728169-763d5a00-9cb4-11ea-8ab2-ee75927b5c7e.png)
Which means everthing is up to date so all targets are :OK:

- [ ] now try making a change to one of your functions in your code. What happens after running `scmake()` then? 

- [ ] access the `plot_data` target by using `plot_data <- scmake('plot_data')`. (You may or may not have an R-object target named `plot_data` in your own repo at this point, so go ahead and try it with some target that you do have.) Here we are using the first argument of `scmake()`, which is `target_names`. Any vector of targets used will be built (the default is to build the `all` target in the case where no target names were specified). We can access the output of the target by assigning the result to a variable. In this example, we have called that variable `plot_data`, and it receives output from `scmake` in the form of a data.frame because that's what our example function `process_data()` creates. If you assign the result of a file target, like `file_name <- scmake(target_names = '1_fetch/out/model_RMSEs.csv')`, the result is the path to that file.

- [ ] now try making a change to the `template_1` variable in your function that creates the .txt file. What happens after running `scmake()` then? Which targets get rebuilt and which do not? 

--- 

Lastly, imagine the following comment appeared on your pull request. 

> Oh shoot @{{ user.username }}, I am using your results for **FANCY BIG PROJECT** and I have coded everything to assume your outputs use a character for the experiment number (the `exper_n` column), of the form "01", "02", etc. It looks like you are using numbers. Can you update your code accordingly? 

Would your code be easy to adjust to satisfy this request? Would you need to re-run any steps that aren't associated with this naming choice? Did the use of a dependency management solution allow you to both make the change efficiently (i.e., by avoiding rebuilding any unnecessary parts of the pipeline) and increase your confidence in delivering the results?

---

### You have completed introductions to pipelines I. Great work!

Below you will find some quick links that can help you review the content covered here

- [How to create a branch]({{ store.branch_issue_url }})
- [Decompose code into functions, structure folders descriptively]({{ store.structure_activity_url }})
- [Videos on dependency managers]({{ store.why_dependency_management_issue_url }})
- [The anatomy of a remakefile]( {{ store.makefile_anatomy_url }})

