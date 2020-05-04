#!/usr/bin/R
# Execute with Rscript filename.R



## * Load the Packages
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
               ggwordcloud, boot, SnowballC, tm)

mise()


hd <- function(x) {
  if ((class(x) == c("matrix"))>0) {
      x[1:4, 1:4]
  } else {
      head(x)
  }
}


load("resources/Download_1.Rdata")
tweets.company <- tweets.company[order(tweets.company$friends_count, decreasing = TRUE), ]
n <- sample(1:200)
tweets.company <- tweets.company[n,]
tweets_vector  <- tweets.company$text
tweets_source  <- tm::VectorSource(tweets_vector)
tweets_corpus <- tm::Corpus(tweets_source)



clean_corp <- function(corpus) {
  ## Remove URL's
  corpus <- tm_map(corpus,content_transformer(function(x) gsub("(f|ht)tp(s?)://\\S+","",x)))
  ## Remove Usernames
  corpus <- tm_map(corpus,content_transformer(function(x) gsub("@\\w+","",x)))
  ## Misc
  corpus <- tm_map(corpus, FUN = removeNumbers)
  corpus <- tm_map(corpus, FUN = removePunctuation)
  corpus <- tm_map(corpus, FUN = stripWhitespace)
  corpus <- tm_map(corpus, FUN = tolower)
  corpus <- tm_map(corpus, FUN = removeWords, stopwords())
  ## stopwords() returns characters and is fead as second argument
  corpus <- tm_map(corpus, FUN = stemDocument)
  return(corpus)
}

tweets_corpus_clean <- clean_corp(tweets_corpus)


tweets_tdm <- tm::TermDocumentMatrix(x = tweets_corpus_clean, control = list(weighting = weightTfIdf))
tweets_tdm <- tm::TermDocumentMatrix(x = tweets_corpus_clean, control = list(weighting = weightSMART))
weightSMART
tweets_dtm  <- as.DocumentTermMatrix(tweets_tdm)
tweets_dtm_mat <- as.matrix(tweets_dtm)
hd(tweets_dtm_mat)

## Look for empty Documents
empties  <- which(x = rowSums(tweets_dtm_mat)<=0)

## Remove Empty Documents

if (empties > 0) {
    tweets_dtm_mat  <- tweets_dtm_mat[-empties,]
}

## Find the Cosine Distance
norm.tweet_weighted_dtm = diag(1/sqrt(rowSums(tweets_dtm_mat^2))) %*% tweets_dtm_mat
D =dist(norm.tweet_weighted_dtm, method = "euclidean")^2/2

## PerformClustering
data_hd  <- cmdscale(d = D, k =(nrow(tweets_dtm_mat)-1)) 
K <- kmeans(x = data_hd, 3, nstart = 20)
K$cluster

## Project into 2D Euclidean Space
data <- cmdscale(d = D, k = 2)
 ?TermDocumentMatrix

## Identify high Friend Counts
hf <- tweets.company$friends_count > mean(tweets.company$friends_count)
hf <- tweets.company$friends_count > quantile(tweets.company$friends_count, 0.90)
hf <- factor(hf)

plot(data[,1], data[,2], col = c("red", "blue")[hf])
plot(prcomp(tweets_dtm_mat)$x[,1], prcomp(tweets_dtm_mat)$x[,2], col = c("red", "blue")[hf])

## Take the First Two PC's
tweets.pca <- prcomp(tweets_dtm_mat)
tddata <- as_tibble(cbind(data, hf))
names(tddata)  <- c("PC1", "PC2", "Friends")
tddata$Friends  <- factor(tddata$Friends)

ggplot(tddata, aes(x = PC1, y = PC2, col = Friends)) + 
    geom_point() +
    stat_ellipse(level = 0.9) +
    theme_classic()

## vim:fdm=expr:fdl=0
## vim:fde=getline(v\:lnum)=~'^##'?'>'.(matchend(getline(v\:lnum),'##*')-2)\:'='

