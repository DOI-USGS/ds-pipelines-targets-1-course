Uh oh, I didn't find the message I was looking for. Here are some troubleshooting steps:

1. Check the library start-up message. We're checking specifically for the following: `USGS Support Package`.
2. Perhaps the package failed to install -- try again. 

Let's try again!

```r
install.packages(c("R6", "yaml", "digest", "crayon", "optparse", "storr", "remotes"))
remotes::install_github('richfitz/remake')
remotes::install_github('USGS-R/scipiper')
install.packages('drake')
library(scipiper)
```

When all three pipeline packages are installed, comment with the message that appears after you run `library(scipiper)`.

<hr><h3 align="center">I'll respond when I detect you've commented to this issue.</h3>
