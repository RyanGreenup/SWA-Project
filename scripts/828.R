# * Load Packages -----------------------------------------------------------
setwd("~/Dropbox/Notes/DataSci/Social_Web_Analytics/SWA-Project/scripts/")

if (require("pacman")) {
  library(pacman)
} else{
  install.packages("pacman")
  library(pacman)
}

pacman::p_load(xts, sp, gstat, ggplot2, rmarkdown, reshape2, ggmap, parallel,
               dplyr, plotly, tidyverse, reticulate, UsingR, Rmpfr, swirl,
               corrplot, gridExtra, mise, latex2exp, tree, rpart, lattice, coin,
               primes, epitools, maps, clipr, ggmap, twitteR, ROAuth, tm,
               rtweet, base64enc, httpuv, SnowballC, RColorBrewer, wordcloud,
               ggwordcloud, boot)

mise()

# ** Load the Tweets ==============================================================
mise(); load("./resources/Download_1.Rdata")

# * Heading 1 ------------------------------------------------------------------
# ** Heading 2 =================================================================
# *** Heading 3 ################################################################
# **** Heading 4
# ***** Heading 5
# ****** Heading 6
## Comments have two `#`
                                        # right aligned have one `#`
#' Feel free to use Roxygen comments
## Work in the development branch and then we'll checkout master and merge in development as we go

