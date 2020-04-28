## * Load Packages -----------------------------------------------------------
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

## * Set up Tokens ===========================================================
options(RCurlOptions = list(
  verbose = FALSE,
  capath = system.file("CurlSSL", "cacert.pem", package = "RCurl"),
  ssl.verifypeer = FALSE
))

## -----BEGIN PGP MESSAGE-----
##
## jA0ECQMClqDOdZ22OWj/0ukBP+GobsGEIuYwIjk7+9c6MSFzpNx2beXfBWPtvN4s
## 1XFim8Mvi2imEeQznCDCo5hLKe4FouPMHsU2Y+Rp0q54NHCbWR8iYalqohmc52rY
## VPnzSVcFtH5y7juOcFirOmZ5BPGizEFx/OIQNECmsyA5P3e5cGt7+kezvunSGKL1
## CuwgstsiSZCIjysou1cSoP0/Fx308gox287ZvYlHHA9L+54RlypCNDRtYMRc1ln6
## Xh0CGbW01vt1LmA++n8l/zafqeu5iHCRWSEmlrJdXf0Dj2iCbTvtt0gWCO9eAOyu
## N248+q7pRMDl0DOx9xOZL+ZaeS5hBSaKpyL3E8abtqZ8D/IcI6cUpRhVp3Qo4p49
## dxli/Je1ulhXPYLeg1S8rKC9mm6QyU8dtwMl5LhL0s5gHqWemwdmsqojGFCZhj5t
## rm2ZnD9uwrYSrDXE5BztvYayvRO6JU96LphDdnNXV2vJjLVh0+uUqAJWXm0poi6i
## msB92v8Y+zEktXHtEWUYtrzHw/8Jg5Ddjv4YeRyPbCQb5YGZmd7tdmDbqYUCH0WI
## V7RtOHEo7rF/cPlf6QZzoLBmpsR4CCQPOhl0rWG7sK3QjHT7g2iYxv9fj+0pB6+E
## a73kebYTxh3D0S/g6nvZ08iBdTo+a7kMn1g6kd29AkpDD+PB+4Vu9NJESzCrcaDZ
## WwEP
## =8/Cr
## -----END PGP MESSAGE-----

## * 8.1.1   Pull the Tweets --------------------------------------------------------
##  n <- 1000
##  tweets.company <- search_tweets(q = 'ubisoft', n = n, token = tk,
##                                  include_rts = FALSE)
##  save(tweets.company, file = "resources/Download_1.Rdata")
## ** Extra just in Case ===========================================================
##   n <- 10000
##   tweets.company <- search_tweets(q = 'ubisoft', n = n, token = tk,
##                                   include_rts = FALSE)
##   save(tweets.company, file = "resources/Download_1_Huge.Rdata")

## ** Load the Tweets ==============================================================
mise(); load("./resources/Download_1.Rdata")

## * 8.1.2 Friend and Follower Count ----------------------------------------------------
(users <- unique(tweets.company$name)) %>% length()
(x <- tweets.company$followers_count[!duplicated(tweets.company$name)]) %>% length()
(y <- tweets.company$friends_count[!duplicated(tweets.company$name)]) %>% length()

## ** 8.1.3  Summary Statistics -----------------------------------------------------------
(xbar <- mean(x))
(ybar <- mean(y))

## * 8.1.4 Above Average Followers ------------------------------------------------
(px_hat <- mean(x>xbar))
(py_hat <- mean(y>ybar))

## ** 8.1.5 BootStrap --------------------------------------------------------------
## ** a.)  Generate Bootstrap Distribution ===========================================
## Re-Sampling with replacement is 
## bt_pop <- replicate(10^2, {
##  sample(x, replace = TRUE)
## })

(bt_pop <- sample(x, size = 10^6, replace = TRUE)) %>% head()


## ** b.) Plot the Bootstrap Distribution ==========================================
bt_pop_data <- tibble("Followers" = bt_pop)
ggplot(data = bt_pop_data, aes(x = Followers)) +
  geom_histogram(aes(y = ..density..), fill = "lightblue", bins = 35, col = "pink") +
  geom_density(col = "violetred2") +
  scale_x_continuous(limits = c(1, 800)) +
  theme_bw() +
  labs(x = "Number of Followers", y = "Density",
       title = "Bootstrapped population of Follower Numbers")

## ** c.) Estimate a Conf. Int. for the pop mean Follower Count ================
## *** Percentile Method #######################################################
## Resampling inside a loop/map is better syntax and is
## equivalent to constructing infinitely large bootstrap distribution and
## sampling from that population (ISL, 194)

xbar_boot_loop <- replicate(10^3, {
  s <- sample(x, replace = TRUE)
  mean(s)
  })
quantile(xbar_boot_loop, c(0.015, 0.985))

## *** BC_a Method #############################################################
mean_val <- function(data, index) {
  X = data[index]
  return(mean(X))
}

xbar_boot <- boot(data = x, statistic = mean_val, R = 10^3)
boot.ci(xbar_boot, conf = 0.97, type = "bca", index = 1)

## ** d.) Estimate a Conf Int for Pop Mean Friend Count =========================
## *** Using a Percentile Method ################################################
ybar_boot_loop <- replicate(10^3, {
  s <- sample(y, replace = TRUE)
  mean(s)
  })
quantile(ybar_boot_loop, c(0.015, 0.985))

# Using BCA Method #############################################################
mean_val <- function(data, index) {
  X = data[index]
  return(mean(X))
}

xbar_boot <- boot(data = y, statistic = mean_val, R = 10^3)
boot.ci(xbar_boot, conf = 0.97, type = "bca", index = 1)

## We just want Percentile type
## https://www.datacamp.com/community/tutorials/bootstrap-r

## * 8.1.6 High Friend Count Proportion -------------------------------------------
prop <- factor(c("Below", "Above"))
## 1 is above average, 2 is below
py_hat_bt <- replicate(10^3, {
  rs      <- sample(c("Below", "Above"),
                    size = length(y),
                    prob = c(1-py_hat, py_hat),
                    replace = TRUE)
isabove <- rs == "Above"
mean(isabove)
})
quantile(py_hat_bt, c(0.015, 0.985))


prop <- function(data, index) {
  X <- data[index]
  mean(X)
}

py_hat_boot <- boot(data = y>mean(y), statistic = prop, R = 10^3)
boot.ci(py_hat_boot, conf = 0.97, type = "bca")


## * 8.1.7 Find Evidence to suggest independence-----------------------------------
## ** a) Bin the Counts=============================================================
## variables and names should not start with numbers
## this is syntactically incorrect
## https://stat.ethz.ch/R-manual/R-devel/library/base/html/make.names.html
##
var_levels <- c("Tens","Hundreds","1Thousands","2Thousands","3Thousands",
                "4Thousands","5ThousandOrMore")

## Assign Categories
x_df <- data.frame(x)
x_df$cat[0       <= x_df$x & x_df$x < 100] <- "Tens"
x_df$cat[100     <= x_df$x & x_df$x < 1000] <- "Hundreds"
x_df$cat[1000    <= x_df$x & x_df$x < 2000] <- "1Thousands"
x_df$cat[2000    <= x_df$x & x_df$x < 3000] <- "2Thousands"
x_df$cat[3000    <= x_df$x & x_df$x < 4000] <- "3Thousands"
x_df$cat[4000    <= x_df$x & x_df$x < 5000] <- "4Thousands"
x_df$cat[5000    <= x_df$x & x_df$x < Inf] <- "5ThousandOrMore"

### Make a factor
x_df$cat <- factor(x_df$cat, levels = var_levels, ordered = TRUE)

### Determine Frequencies
(x_freq <- table(x_df$cat) %>% as.matrix())

## ** b) Find the Friend Count Frequency ===========================================
## Assign Categories
y_df <- data.frame(y)
y_df$cat[0       <= y_df$y & y_df$y < 100] <- "Tens"
y_df$cat[100     <= y_df$y & y_df$y < 1000] <- "Hundreds"
y_df$cat[1000    <= y_df$y & y_df$y < 2000] <- "1Thousands"
y_df$cat[2000    <= y_df$y & y_df$y < 3000] <- "2Thousands"
y_df$cat[3000    <= y_df$y & y_df$y < 4000] <- "3Thousands"
y_df$cat[4000    <= y_df$y & y_df$y < 5000] <- "4Thousands"
y_df$cat[5000    <= y_df$y & y_df$y < Inf]  <- "5ThousandOrMore"

### Make a factor
y_df$cat <- factor(y_df$cat, levels = var_levels, ordered = TRUE)

### Determine Frequencies
(y_freq <- table(y_df$cat) %>% as.matrix())

## ** c) Find the Expected counts under each group and Chi Test Independence =======
## *** Combine the frequencies into a matrix #######################################
vals <- t(cbind(x_freq, y_freq))
rownames(vals) <- c("Followers.x", "followers.y")
vals 




