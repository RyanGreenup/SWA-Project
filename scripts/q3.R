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

## * 8.2.24 Find 10 Most Popular Friends of the Twitter Handle ----------------
## ** Get the User ID of Friends of Ubisoft ================================
## user <- lookup_users(c("ubisoft"), token = tk) # Get all Ubisoft Details
# t <- get_friends("ubisoft", token = tk)
## *** Get More Information of Friends ########################################
# friends = lookup_users(t$user_id, token = tk)
## save(list = c("t", "friends", "user"), file = "./8224_Friends.Rdata")
load("./8224_Friends.Rdata"); head(t); head(friends)
## **** Inspect the friends ....................................................
dim(friends)
names(friends)

friends$screen_name[1] #name of friend at index 1
friends$followers_count[1] #examine the follower count of the first friend
friends$screen_name[2]

## ** Find the 10 Most Popular Friends =========================================
friendPosition = order(friends$friends_count, decreasing = TRUE)[1:10]
topFriends = friends[friendPosition,] #ids of top 10 friends
## *** Print the top 10 most popular friends ###################################
topFriends$screen_name

## * 8.2.25 2 Degree Egocentric graph-------------------------------------------

## ** Download 2nd Degree of Friends ===========================================
if (!file.exists("./AllGraphData.RData")) {
    for (i in 1:10) {
        ## Get friends of Each Friend
        t <- get_friends(topFriends$user_id[i], token <- tk)

        ## Get the Data from Each Friend
        more.friends[[i]] <- lookup_users(t$user_id, token <- tk)

        ## Save the Data
        save(list = ls(), file = "AllGraphData.RData")
    }
} else {
    load(file = "AllGraphData.RData")
}

## *** Inspect the Data #######################################################

class(more.friends[[1]])
dim(more.friends[[1]])
nrow(more.friends[[1]])

## ** Reduce Size of Data =====================================================
#-----------------Restrict to 100 records to manage big data----------------
for (a in 1:10) {
  if (nrow(more.friends[[a]]) > 5) {
    more.friends[[a]] <- more.friends[[a]][1:5, ]
  }
}

## *** Inspect the Data #######################################################
more.friends[[1]]$screen_name[1]
more.friends[[1]]$screen_name[2]
more.friends[[2]]$screen_name[2]



#We can now build the edge list using:
el = cbind(rep(user$screen_name, nrow(friends)),
           friends$screen_name)  # bind the columns to create a matrix

#Using what you have done above, write the function
user.to.edgelist <- function(user, friends) {
  # create the list of friend screen names
  user.name = rep(user$screen_name, nrow(friends))  # repeat user's name
  el = cbind(user.name, friends$screen_name)  # bind the columns to create a matrix
  return(el)
}

#We can use the created function user.to.edgelist to create the edge list for Chris Hemsworth:
el.chris = user.to.edgelist(user, friends)
el.chris
topFriends[1,4] #4th column is Screenname
nrow(more.friends[[4]])
topFriends[1,]
user.to.edgelist(topFriends[1,], more.friends[[1]])
#We can also build the edge list for the top 10 friends using a loop:
for (a in c(1:length(more.friends))) {
  el.friend = user.to.edgelist(topFriends[a,], more.friends[[a]])
  el.chris = rbind(el.chris, el.friend)  # append the new edge list to the old one.
}
el.chris
#Now that we have the edge list, we can create the graph:
g = graph.edgelist(el.chris)
g
#Let's plot the graph. Since there are many vertices,
#we will reduce the vertex size and use a special plot layout:
plot(g, layout = layout.fruchterman.reingold, vertex.size = 5)

#This graph contains many vertices that we did not examine. To remove these,
#let's only keep the vertices with degree (in or out) greater than 1.
g2=induced_subgraph(g, which(degree(g, mode = "all") > 1))
#This graph is now easier to visualise:
plot(g2, layout = layout.fruchterman.reingold, vertex.size = 5)

#Who is at the centre of the graph? Use the centrality measures to examine this.
g2.centres=order(closeness(g2), decreasing=TRUE)
length(g2.centres)
g2[g2.centres][,1]#names of the centres
# Examine the graph density. Is it sparse or dense?
graph.density(g2)

#Examine the degree distribution. Is this graph more similar to an Erd??s-Renyi
#graph or a Barab??si???Albert graph?
degree.distribution(g2)
## * 8.2.26 Compute the closeness cen. score for every user--------------------
## * 8.2.27 Comment on the Results---------------------------------------------
