the `all` lists the targets that _must_ be created to complete the project (or phase). yaml files are flexible, so there are various ways to list more than one critical target, such as:
```yaml
depends: [figure_1.png, figure_2.png]
# - or - 
depends:
  - figure_1.png
  - figure_2.png
```

That's something to keep in mind for the future. But, what's bugging me about this file is that it doesn't put the figure output where we'd want it, namely somewhere like `3_visualize/out/`. You can also rename the figure if you'd like to use something more descriptive. Keep in mind that any changes to this target should also mimic changes made below where the recipe for this target is defined.

---
Please make some changes to this part of the file. You are doing great, @{{ user.username }}! :sparkles:

