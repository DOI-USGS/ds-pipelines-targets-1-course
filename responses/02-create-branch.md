You'll be revising files in this repository shortly. To follow our team's standard git workflow, you should first clone this training repository to your local machine so that you can make file changes and commits there. 

Open a git bash shell (Windows) or a terminal window (Mac) and change (`cd`) into the directory you work in for projects in R (for me, this is `~/Documents/R`). There, clone the repository and set your working directory to the new project folder that was created:
```
git clone git@github.com:{{ user.username }}/{{ repo }}.git
cd ds-pipelines-targets-1
```

Now you should create a local branch called "structure" and push that branch up to the "remote" location (which is the github host of your repository). We're naming this branch "structure" to represent concepts in this section of the lab. In the future you'll probably choose branch names according to the type of work they contain - for example, "pull-oxygen-data" or "fix-issue-17".

```
git checkout -b structure
git push -u origin structure
```

By using `checkout`, you have switched your local branch from "main" to "structure", and any changes you make from here on out to _tracked_ files will not show up on the main branch. To take a look back at "main", you can always use `git checkout main` and return to "structure" with `git checkout structure`. We needed the `-b` flag initially because we wanted to combine two operations - creating a new branch (`-b`) and switching to that new branch (`checkout`). 

While you are at it, this is a good time to invite a few collaborators to your repository, which will make it easier to assign them as reviewers in the future. In the :gear: Settings widget at the top of [your repo]({{ repoUrl }}), select "Manage access". Go ahead and invite your course contact(s). It should look something like this: 
![add some friends](https://user-images.githubusercontent.com/2349007/81471981-c0094900-91ba-11ea-93b0-0ffd31ec4ea9.png)

Close this issue when you've successfully pushed your branch to remote and added some collaborators. (A successful push of the branch will result in a message that looks like this `"Branch 'structure' set up to track remote branch 'structure' from 'origin'"`)

<hr>
<h3 align="center">I'll send you to the next issue once you've closed this one.</h3>

