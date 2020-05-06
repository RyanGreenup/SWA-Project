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
               ggwordcloud, boot, SnowballC, igraph, ggrepel)

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
if (!file.exists("./8224_Friends.Rdata")) {

    user <- lookup_users(c("ubisoft"), token = tk) # Get all Details
    t <- get_friends("ubisoft", token = tk)

    ## *** Get More Information of Friends ####################################
    friends = lookup_users(t$user_id, token = tk)

    ## *** Save the Data ######################################################
    save(list = c("t", "friends", "user"), file = "./8224_Friends.Rdata")
} else {
    load("./8224_Friends.Rdata"); head(t); head(friends)
}

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
        further_friends[[i]] <- lookup_users(t$user_id, token <- tk)

        ## Save the Data
        save(list = ls(), file = "AllGraphData.RData")
    }
} else {
    load(file = "AllGraphData.RData")
}

## *** Inspect the Data #######################################################

class(further_friends[[1]])
dim(further_friends[[1]])
nrow(further_friends[[1]])

## ** Set How many 2nd Degree Friends =========================================
n  <- 13
for (a in 1:10) {
  if (nrow(further_friends[[a]]) > n) {
    further_friends[[a]] <- further_friends[[a]][1:n, ]
  }
}

## ** Build the Edge List =====================================================
Edges <- cbind(rep(user$screen_name, 10),
           topFriends$screen_name[1:10])  # bind the columns to create a matrix

## *** Append Friends-of-Friends to Edge List #################################
user.to.edgelist <- function(user, friends) {
  # create the list of friend screen names
  user.name <- rep(user$screen_name, nrow(friends))   # repeat user's name
  (Edges       <- cbind(user.name, friends$screen_name))  # bind the columns
}
for (a in c(1:length(further_friends))) {
  el.friend = user.to.edgelist(topFriends[a,], further_friends[[a]])
  Edges = rbind(Edges, el.friend)  # append the new edge list to the old one.
}
Edges

## ** Make The Graph ==========================================================
## Now that we have the edge list, we can create the graph:
g = graph.edgelist(Edges)
g
## Let's plot the graph. Since there are many vertices,
## we will reduce the vertex size and use a special plot layout:
plot(g, layout = layout.fruchterman.reingold, vertex.size = 7)

## ** Use GGPlot2 =============================================================
## *** Get Edges ##############################################################
Edges <- as.data.frame(Edges)
names(Edges) <- c("Source", "Target")

## *** Build the Data Frame ###################################################
ne <- nrow(Edges) # Number of Edges
laytg <- as.data.frame(igraph::layout.kamada.kawai(g, dim = 2))
laytg$node <- vertex_attr(g)[[1]]
names(laytg)  <- c("xval", "yval", "node")

laytg$xval[laytg$node==Edges$Source[2]]

  ys <- xe <- ye <- xs <- vector(length = ne)
  for (i in seq_len(length(xs))) {
    xs[i] <- laytg$xval[laytg$node==Edges$Source[i]]
    ys[i] <- laytg$yval[laytg$node==Edges$Source[i]]
    xe[i] <- laytg$xval[laytg$node==Edges$Target[i]]
    ye[i] <- laytg$yval[laytg$node==Edges$Target[i]]
  }

  starts    <- data.frame("xval" = xs, "yval" = ys, edgenum = 1:ne) # TODO Make a factor
  ends      <- data.frame("xval" = xe, "yval" = ye, edgenum = 1:ne)
  Edges_val <- as_tibble(rbind(starts,ends))

## *** Call ggplot to make the plot ###########################################
ggplot(Edges_val, aes(x = xval, y = yval)) +
geom_label_repel(data = laytg,
    mapping = aes(x = xval, y = yval, label = node),
    col = "darkblue", size = 1.5, nudge_x = 0, nudge_y = 0) +
    geom_line(aes(group = edgenum)) +
    geom_point(data = laytg,
        aes(x = xval,
                y = yval,
                col = node),
                size = 2) +
    theme_classic() +
    guides(col = FALSE)

## ** Heirarchical ggplot2 ====================================================
## *** Set How many 2nd Degree Friends #########################################
n  <- 1
for (a in 1:10) {
  if (nrow(further_friends[[a]]) > n) {
    further_friends[[a]] <- further_friends[[a]][1:n, ]
  }
}

## *** Build the Edge List #####################################################
Edges <- cbind(rep(user$screen_name, 10),
           topFriends$screen_name[1:10])  # bind the columns to create a matrix

## **** Append Friends-of-Friends to Edge List #################################
user.to.edgelist <- function(user, friends) {
  # create the list of friend screen names
  user.name <- rep(user$screen_name, nrow(friends))   # repeat user's name
  (Edges       <- cbind(user.name, friends$screen_name))  # bind the columns
}
for (a in c(1:length(further_friends))) {
  el.friend = user.to.edgelist(topFriends[a,], further_friends[[a]])
  Edges = rbind(Edges, el.friend)  # append the new edge list to the old one.
}
Edges

## *** Get Edges ##############################################################
Edges <- as.data.frame(Edges)
names(Edges) <- c("Source", "Target")

## *** Build the Data Frame ###################################################
ne <- nrow(Edges) # Number of Edges
laytg <- as.data.frame(igraph::layout_as_tree(g))
laytg$node <- vertex_attr(g)[[1]]
names(laytg)  <- c("xval", "yval", "node")

laytg$xval[laytg$node==Edges$Source[2]]

  ys <- xe <- ye <- xs <- vector(length = ne)
  for (i in seq_len(length(xs))) {
    xs[i] <- laytg$xval[laytg$node==Edges$Source[i]]
    ys[i] <- laytg$yval[laytg$node==Edges$Source[i]]
    xe[i] <- laytg$xval[laytg$node==Edges$Target[i]]
    ye[i] <- laytg$yval[laytg$node==Edges$Target[i]]
  }

  starts    <- data.frame("xval" = xs, "yval" = ys, edgenum = 1:ne)
  ends      <- data.frame("xval" = xe, "yval" = ye, edgenum = 1:ne)

## *** Call ggplot to make the plot ###########################################

library(ggrepel)
ggplot(rbind(starts,ends), aes(x = xval, y = yval)) +
geom_line(aes(group = edgenum), lty = 3, col = "darkgrey", size = 0.3) +
geom_point(data = laytg, aes(x = xval, y = yval, col = node), size = 4) +
labs(x = "", y = "") +
geom_label_repel(data = laytg,
            aes(x = xval, y = yval, label = node, col = node),
            size = 1.5, nudge_x = 0, nudge_y = 0) +
            guides(col = FALSE) +
            theme_classic() +
            theme(axis.line = element_blank(),
                    axis.text.y=element_blank(),axis.ticks=element_blank(),
                    axis.text.x=element_blank())

## * 8.2.26 Compute the closeness cen. score for every user--------------------
## We won't all the nodes to do this
## *** Download 2nd Degree of Friends ===========================================
if (!file.exists("./AllGraphData.RData")) {
    for (i in 1:10) {
        ## Get friends of Each Friend
        t <- get_friends(topFriends$user_id[i], token <- tk)

        ## Get the Data from Each Friend
        further_friends[[i]] <- lookup_users(t$user_id, token <- tk)

        ## Save the Data
        save(list = ls(), file = "AllGraphData.RData")
    }
} else {
    load(file = "AllGraphData.RData")
}

## ** Set How many 2nd Degree Friends =========================================
## n  <- 13
## for (a in 1:10) {
##   if (nrow(further_friends[[a]]) > n) {
##     further_friends[[a]] <- further_friends[[a]][1:n, ]
##   }
## }

## ** Build the Edge List =====================================================
Edges <- cbind(rep(user$screen_name, 10),
           topFriends$screen_name[1:10])  # bind the columns to create a matrix

## *** Append Friends-of-Friends to Edge List #################################
user.to.edgelist <- function(user, friends) {
  # create the list of friend screen names
  user.name <- rep(user$screen_name, nrow(friends))   # repeat user's name
  (Edges       <- cbind(user.name, friends$screen_name))  # bind the columns
}
for (a in c(1:length(further_friends))) {
  el.friend = user.to.edgelist(topFriends[a,], further_friends[[a]])
  Edges = rbind(Edges, el.friend)  # append the new edge list to the old one.
}

## ** Make The Graph ==========================================================
## Now that we have the edge list, we can create the graph:
g = graph.edgelist(Edges)
## ** Compute Centrality ======================================================

## Inspect the Closness
closeness(g)[1:20]

## Sort the Closeness
index=order(closeness(g), decreasing = TRUE)
centrality_vector <- c(names(g[index][,1]), closeness(g)[index])

## Print the 3 most Central Users
centrality_vector[1:4]

## * 8.2.27 Comment on the Results---------------------------------------------
## Gail Simone is a comic book writer, she did like birds of prey, batgirl and
## even some deadpool It appears video game companies and comic books and fast
## food are very interconnected
