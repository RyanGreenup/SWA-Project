# Load Packages -----------------------------------------------------------
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

# Set up Tokens ===========================================================
options(RCurlOptions = list(
  verbose = FALSE,
  capath = system.file("CurlSSL", "cacert.pem", package = "RCurl"),
  ssl.verifypeer = FALSE
))

# -----BEGIN PGP MESSAGE-----
#
# jA0ECQMClqDOdZ22OWj/0ukBP+GobsGEIuYwIjk7+9c6MSFzpNx2beXfBWPtvN4s
# 1XFim8Mvi2imEeQznCDCo5hLKe4FouPMHsU2Y+Rp0q54NHCbWR8iYalqohmc52rY
# VPnzSVcFtH5y7juOcFirOmZ5BPGizEFx/OIQNECmsyA5P3e5cGt7+kezvunSGKL1
# CuwgstsiSZCIjysou1cSoP0/Fx308gox287ZvYlHHA9L+54RlypCNDRtYMRc1ln6
# Xh0CGbW01vt1LmA++n8l/zafqeu5iHCRWSEmlrJdXf0Dj2iCbTvtt0gWCO9eAOyu
# N248+q7pRMDl0DOx9xOZL+ZaeS5hBSaKpyL3E8abtqZ8D/IcI6cUpRhVp3Qo4p49
# dxli/Je1ulhXPYLeg1S8rKC9mm6QyU8dtwMl5LhL0s5gHqWemwdmsqojGFCZhj5t
# rm2ZnD9uwrYSrDXE5BztvYayvRO6JU96LphDdnNXV2vJjLVh0+uUqAJWXm0poi6i
# msB92v8Y+zEktXHtEWUYtrzHw/8Jg5Ddjv4YeRyPbCQb5YGZmd7tdmDbqYUCH0WI
# V7RtOHEo7rF/cPlf6QZzoLBmpsR4CCQPOhl0rWG7sK3QjHT7g2iYxv9fj+0pB6+E
# a73kebYTxh3D0S/g6nvZ08iBdTo+a7kMn1g6kd29AkpDD+PB+4Vu9NJESzCrcaDZ
# WwEP
# =8/Cr
# -----END PGP MESSAGE-----

# Pull the Tweets --------------------------------------------------------
##  n <- 1000
##  tweets.company <- search_tweets(q = 'ubisoft', n = n, token = tk,
##                                  include_rts = FALSE)
##  save(tweets.company, file = "resources/Download_1.Rdata")
## Extra just in Case ===========================================================
##   n <- 10000
##   tweets.company <- search_tweets(q = 'ubisoft', n = n, token = tk,
##                                   include_rts = FALSE)
##   save(tweets.company, file = "resources/Download_1_Huge.Rdata")

# Load the Tweets ==============================================================
mise(); load("./resources/Download_1.Rdata")

# 8.1.2 Friend and Follower Count ----------------------------------------------------
(users <- unique(tweets.company$name)) %>% length()
(x <- tweets.company$followers_count[!duplicated(tweets.company$name)]) %>% length()
(y <- tweets.company$friends_count[!duplicated(tweets.company$name)]) %>% length()

# 8.1.3 Summary Statistics -----------------------------------------------------------
(xbar <- mean(x))
(ybar <- mean(y))

# 8.1.4 Above Average Followers ------------------------------------------------
(px_hat <- mean(x>xbar))
(py_hat <- mean(y>ybar))

# 8.1.5 BootStrap --------------------------------------------------------------
# a.) Generate Bootstrap Distribution ===========================================
## Re-Sampling with replacement is 
## bt_pop <- replicate(10^2, {
##  sample(x, replace = TRUE)
## })

(bt_pop <- sample(x, size = 10^6, replace = TRUE)) %>% head()


# b.) Plot the Bootstrap Distribution ==========================================
bt_pop_data <- tibble("Followers" = bt_pop)
ggplot(data = bt_pop_data, aes(x = Followers)) +
  geom_histogram(aes(y = ..density..), fill = "lightblue", bins = 35, col = "pink") +
  geom_density(col = "violetred2") +
  scale_x_continuous(limits = c(1, 800)) +
  theme_bw() +
  labs(x = "Number of Followers", y = "Density",
       title = "Bootstrapped population of Follower Numbers")

# c.) Estimate a Confidence Interval for the populattion mean Follower Count ===
## Resampling inside a loop/map is better syntax and is
## equivalent to constructing infinitely large bootstrap distribution and
## sampling from that population (ISL, 194)

xbar_boot_loop <- replicate(10^3, {
  s <- sample(x, replace = TRUE)
  mean(s)
  })
quantile(xbar_boot_loop, c(0.015, 0.985))

mean_val <- function(data, index) {
  X = data[index]
  return(mean(X))
}

xbar_boot <- boot(data = x, statistic = mean_val, R = 10^3)
boot.ci(xbar_boot, conf = 0.97, type = "bca", index = 1)

# d.) Estimate a Confidence Interval for the populattion mean Friend Count ===
# Using a Percentile Method #####################################################
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

# 8.1.6 High Friend Count Proportion -------------------------------------------
prop <- factor(c("Below", "Above"))
## 1 is above average, 2 is below
py_hat_bt <- replicate(10^3, {
  rs      <- sample(c("Below", "Above"),
                    size = length(y),
                    prob = c(py_hat, 1-py_hat),
                    replace = TRUE)
isabove <- rs == "Above"
mean(isabove)
})
quantile(py_hat_bt, c(0.015, 0.985))

# 8.1.7 Find Evidence to suggest independence
