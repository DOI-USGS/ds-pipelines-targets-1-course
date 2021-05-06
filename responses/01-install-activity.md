

### :keyboard: Installing tools

To complete this section, you'll need some R packages. You will need to install `remake`, `scipiper`, and `drake`. 

`drake` is available through CRAN, but `remake` and `scipiper` both require installation from github. 

`scipiper` depends on `remake`, so install `remake` and its dependencies first:

```r
install.packages(c("R6", "yaml", "digest", "crayon", "optparse", "storr", "remotes"))
remotes::install_github('richfitz/remake')
```

While you are at it, please install a few other packages that you'll use along the way:

```r
install.packages(c("dplyr", "readr", "stringr", "sbtools", "whisker", "dataRetrieval", "ggplot2", "purrr"))
```

Next, install `scipiper`
```r
remotes::install_github('USGS-R/scipiper')
```

Also install `drake`
```r
install.packages('drake')
```

When all three pipeline packages are installed, comment with the message that appears after you run `library(scipiper)`.

<hr><h3 align="center">I'll respond when I detect you've commented to this issue.</h3>
