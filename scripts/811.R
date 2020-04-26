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
               ggwordcloud)

mise()

# Set up Tokens ===========================================================

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
n <- 1000
tweets.company <- rtweet::get_timeline("SquareEnix", n = n, token = tk)

# Save the Tweets ==============================================================
save(tweets.company, file = "resources/Download_1.Rdata")

# Load the Tweets ==============================================================
mise(); load("./resources/Download_1.Rdata")
head(tweets.company$text)

# Friend and Follower Count ----------------------------------------------------
