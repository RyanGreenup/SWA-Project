## * Load Packages -----------------------------------------------------------
setwd("~/Dropbox/Notes/DataSci/Social_Web_Analytics/SWA-Project/scripts/")
if (require("pacman")) {
     library(pacman)
 } else {
 install.packages("pacman")
    library(pacman)
 }

pacman::p_load(xts, sp, gstat, ggplot2, rmarkdown, reshape2, ggmap, parallel,
               dplyr, plotly, tidyverse, reticulate, UsingR, Rmpfr, swirl,
               corrplot, gridExtra, mise, latex2exp, tree, rpart, lattice, coin,
               primes, epitools, maps, clipr, ggmap, twitteR, ROAuth, tm,
               rtweet, base64enc, httpuv, SnowballC, RColorBrewer, wordcloud,
               ggwordcloud, boot, SnowballC)

mise()

## Redefine head for simplicity sake
hd <- function(x, n=6) {
  if(class(x) == "matrix") {
    x[1:n, 1:n]
  } else {
    head(x)
  }
}

## * Set up Tokens -----------------------------------------------------------
options(RCurlOptions = list(
  verbose = FALSE,
  capath = system.file("CurlSSL", "cacert.pem", package = "RCurl"),
  ssl.verifypeer = FALSE
))

tk <- rtweet::create_token(
  app = "SWA",
  consumer_key    = "dE7HNKhwHxMqqWdBl1qo9OAkN",
  consumer_secret = "7ByyC6lR9d2aqLoXHHBkOtKRiU10cHhGguroiGKQ69AGDMMI9V",
  access_token    = "1240821178014388225-sFWver0NDDY3BhPdPyg8d4mtQxnl0K",
  access_secret   = "HLBWzHcemHzYJnw5ZLvKpEhQ5KaWwK6Nsj6cxBjUf51NJ",
  set_renv        = FALSE)

## * 8.2.24 Find 10 Most Popular Friends of the Twitter Handle ---------------------
## ## ** Get the User ID of Friends of Ubisoft =====================================
# t <- get_friends("ubisoft", token = tk)
## *** Get More Information of Friends ###########################################
# friends = lookup_users(t$user_id, token = tk)
## save(list = c("t", "friends"), file = "./8224_Friends.Rdata")
load("./8224_Friends.Rdata"); head(t); head(friends)
## **** Inspect the friends .......................................................
dim(friends)
names(friends)

friends$screen_name[1] #name of friend at index 1
friends$followers_count[1] #examine the follower count of the first friend
friends$screen_name[2]

## ** Find the 10 Most Popular Friends ==========================================
friendPosition = order(friends$friends_count, decreasing = TRUE)[1:10]
topFriends = friends[friendPosition,] #ids of top 10 friends
## *** Print the top 10 most popular friends #####################################
topFriends$screen_name

## * 8.2.25 2 Degree Egocentric graph-----------------------------------------------
## ** Download 2nd Degree of Friends ============================================
##
#-----------Do the following to download directly from Twitter------
# more.friends = list() #a place to store the friends of friends
# #n = length(topFriends)
# n= nrow(topFriends)
# t = get_friends(topFriends$user_id[1], token = tk) #get friends of each friend
# more.friends[[1]]=lookup_users(t$user_id, token = tk)
# t = get_friends(topFriends$user_id[2], token = tk) #get friends of each friend
# more.friends[[2]]=lookup_users(t$user_id, token = tk)
# t = get_friends(topFriends$user_id[3], token = tk) #get friends of each friend
# more.friends[[3]]=lookup_users(t$user_id, token = tk)
# t = get_friends(topFriends$user_id[4], token = tk) #get friends of each friend
# more.friends[[4]]=lookup_users(t$user_id, token = tk)
# t = get_friends(topFriends$user_id[5], token = tk) #get friends of each friend
# more.friends[[5]]=lookup_users(t$user_id, token = tk)
# t = get_friends(topFriends$user_id[6], token = tk) #get friends of each friend
# more.friends[[6]]=lookup_users(t$user_id, token = tk)
# t = get_friends(topFriends$user_id[7], token = tk) #get friends of each friend
# more.friends[[7]]=lookup_users(t$user_id, token = tk)
# t = get_friends(topFriends$user_id[8], token = tk) #get friends of each friend
# more.friends[[8]]=lookup_users(t$user_id, token = tk)
# t = get_friends(topFriends$user_id[9], token = tk) #get friends of each friend
# more.friends[[9]]=lookup_users(t$user_id, token = tk)
# t = get_friends(topFriends$user_id[10], token = tk) #get friends of each friend
# more.friends[[10]]=lookup_users(t$user_id, token = tk)
# more.friends
# class(more.friends[[1]])
# dim(more.friends[[1]])
# nrow(more.friends[[1]])
#
# save(list = ls(), file = "AllGraphData.RData")
# rm(more.friends)
load(file = "AllGraphData.RData")

#-----------------Restrict to 100 records to manage big data----------------
for(a in 1:10){
  if(nrow(more.friends[[a]])>100){
    more.friends[[a]]=more.friends[[a]][1:100,]
  }
}

more.friends[[1]]$screen_name[1]
more.friends[[1]]$screen_name[2]
more.friends[[2]]$screen_name[2]
#save(user, friends, more.friends, file="chris2019.RData")
## * 8.2.26 Compute the closeness cen. score for every user-------------------------
## * 8.2.27 Comment on the Results---------------------------------------------------
