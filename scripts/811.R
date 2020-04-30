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
## mise()
load("./resources/Download_1.Rdata")

## * 8.1.2 Friend and Follower Count ----------------------------------------------------
## <<8.1.2>>
(users <- unique(tweets.company$name)) %>% length()
(x <- tweets.company$followers_count[!duplicated(tweets.company$name)]) %>% length()
(y <- tweets.company$friends_count[!duplicated(tweets.company$name)]) %>% length()

## ** 8.1.3  Summary Statistics -----------------------------------------------------------
## <<8.1.3>>
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
rownames(vals) <- c("Followers.x", "Friends.y")
vals 

## **** Calculate Summary Stats
n  <- sum(vals)
sz <- prod(dim(vals))
p  <- vals/n
o  <- vals
e  <- rowSums(vals) %o% colSums(vals) / n

chi_obs <- sum((e-o)^2/e)

## **** Simulate False Positive
## ***** Create a Matrix of Counts
vals <- t(cbind(x_freq, y_freq))
rownames(vals) <- c("Followers.x", "Friends.y")
t(vals)
## ***** Create Vectors of factor levels
brackets <- unique(x_df$cat)
metrics <- c("follower", "friend")


n <- sum(vals)
bracket_prop <- colSums(vals) / n
metric_prop  <- rowSums(vals) / n
o <- vals
e <- rowSums(vals) %o% colSums(vals) / n
chi_obs <- sum((e-o)^2/e)

## ***** Simulate the data Assuming H_0
## I.e. assuming that the null hypothesis is true in that
## the brackets assigned to followers are independent of the friends
## (this is a symmetric relation)
## [[file:~/Notes/Org/AbstractAlgebraNotes.org::#relation-types][Relation Types]]

s <- replicate(10^4,{
  ## Sample the set of Metrics
  m <- sample(metrics, size = n, replace = TRUE, prob = metric_prop)

  ## Sample the set of Brackets (i.e. which performance bracket the user falls in)
  b <- sample(brackets, size = n, replace = TRUE, prob = bracket_prop)

  ## Make a table of results
  o <- table(m, b)
  o

  ## Find What the expected value would be
  e_sim <- t(colSums(e) %o% rowSums(e) / n)

  ## Calculate the Chi Stat
  chi_sim <- sum((e_sim-o)^2/e_sim)
  chi_sim

  ## Is this more extreme, i.e. would we reject null hypothesis?
  chi_sim > chi_obs

})

mean(s)


## * 8.2.8 Find users with Above Average Friend Count-------------------------------
##
## <<8.2.8>>
## y is friends count, see [[8.1.3]]
## Remember these users must not be duplicated

## <<dplyr812>>
select <- dplyr::select
filter <- dplyr::filter
interested_vars <- c("name", "followers_count")

(follower_counts <- tweets.company %>%
  select(interested_vars) %>%
  filter(!duplicated(name)))

(high_friends <- follower_counts %>%
  filter(followers_count > mean(followers_count, na.rm = TRUE)))

## * 8.2.8 Find users with Below Average Friend Count-------------------------------

(low_friends <- follower_counts %>%
  filter(followers_count <= mean(followers_count, na.rm = TRUE)))


if ((nrow(low_friends) + nrow(high_friends))!=length(users)) {
  print("More users identified that exist, review the method to count high_friends")

}

## * 8.2.10 Find the tweets of those users indentified above --------------------
tweets_high <- tweets.company$text[tweets.company$name %in%  high_friends$name]
tweets_low  <- tweets.company$text[tweets.company$name %in%  low_friends$name]
tweets <- c(tweets_high, tweets_low)

## * 8.2.11 Clean the tweets----------------------------------------------------
## ** Create a Corpus -----------------------------------------------------------

## the `tm` library can be used to analyse the text (the `SnowballC` package
## will be used for word stemming).

## It's first necessary to create a `corpus` object:

tweet_source <- tm::VectorSource(tweets)
tweet_corpus <- tm::Corpus(x = tweet_source)

## A corpus object is a list where each entry contains author, description,
## content et cetera.

tweet_corpus$content[1:5]
tweet_corpus[[1]]$content
tweet_corpus[1] %>% str()

## Then use the `tm_map` function to apply a function to every document in the
## corpus, in this case we will convert the text encoding to UTF8:

encode <- function(x) {
  iconv(x, to = "UTF-8")
#  iconv(x, to = "ASCII")
}
tweet_corpus <- tm_map(x = tweet_corpus, FUN = encode)
tweet_corpus_raw <- tweet_corpus

#TODO Maybe I should Remove Bad terms before inspection and before cleaning?
tweet_corpus[[1]]$content
## ** Clean the Corpus ---------------------------------------------------------
##
## In order to clean the corpus it will be necessary to:
##
## 1. remove numbers
## 2. remove punctuation
## 3. remove whitespace
## 4. case fold all characters to lower case
## 5. remove a set of stop words
## 6. reduce each word to its stem
##
## So for example to remove the numbers it would be ideal to use the
## `tm::removeNumbers()` function, in order to apply this to the entire corpus the
## `tm_map` package.

mystop <- c(stopwords(), "’s", "can", "ubisoft", "@ubisoft", "#ubisoft")# <<stphere>>

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
  corpus <- tm_map(corpus, FUN = removeWords, mystop)
      ## stopwords() returns characters and is fead as second argument
  corpus <- tm_map(corpus, FUN = stemDocument)
  ## return(corpus)
}

tweet_corpus_clean <- clean_corp(tweet_corpus)

## These warnings are expected, they remove fluff from our data
## Make a plot and consider adding stop words to [[stphere]]
## Make plot
# wordcloud(tweet_corpus_clean)
## TODO should katakana be removed?

## * 8.2.12 Display the first two tweets before/after processing ---------------
tweet_corpus_raw[[1]]$content
tweet_corpus_clean[[1]]$content
tweet_corpus_raw[[2]]$content
tweet_corpus_clean[[2]]$content

## * 8.2.13 Create a Term Document Matrix---------------------------------------
## ** Calculate by hand via DTM (Moving forward, it's more convenient)==========
tweet_matrix_dtm <- DocumentTermMatrix(tweet_corpus_clean)
null = which(rowSums(as.matrix(tweet_matrix_dtm)) == 0)
length(null)

(rowSums(as.matrix(tweet_matrix_dtm))) %>% table()
if(length(null)!=0){
  tweet_matrix_dtm = tweet_matrix_dtm[-null,]
}
(rowSums(as.matrix(tweet_matrix_dtm))) %>% table()

if (nrow(tweet_matrix_dtm) == length(tweet_corpus_clean)-length(null) ) {
  print("Success! Empty Documents removed from DTM")
} else {
  "Error! Number of documents exceeds non-empty documents in DTM"
}

colnames(as.matrix(tweet_matrix_dtm)) %>% head() #Colnames are working



## *** Use Term-Frequency and Inter-Document Frequency##########################
N <- nrow(as.matrix(tweet_matrix_dtm))   # Number of Documents
ft=colSums(as.matrix(tweet_matrix_dtm) > 0) #in how many documents term t appeared in,

TF <- log(as.matrix(tweet_matrix_dtm) + 1)  # built in uses log2()
IDF <- log(N/ft)

    # Because each term in TF needs to be multiplied through
    # each column of IDF there would be two ways to do it,
      # a for loop which will be really slow
      # Diagonalise the matrix then use Matrix multiplication

tweet_weighted           <- TF %*% diag(IDF)
colnames(tweet_weighted) <- colnames(tweet_matrix_dtm)

                         ### RowColumnMatrix
tweet_weighted[1:6, 1:6]

## ** Use built in method (via TDM)=============================================
## *** Make a Term Document Matrix===============================================
                         ### RowColumnMatrix
tweet_matrix_tdm   <- (TermDocumentMatrix(tweet_corpus_clean))
tweet_matrix_dtm   <- (DocumentTermMatrix(tweet_corpus_clean))

## *** Weight the Matrix
tweet_weighted_tdm <- as.matrix(weightTfIdf(tweet_matrix_tdm))
tweet_weighted_tdm[1:6, 1:6]

## Need DTM for Unsupervised Learning
(tweet_weighted_dtm <- t(tweet_weighted_tdm)) %>% hd()
colnames(tweet_weighted_dtm) <- rownames(tweet_weighted_tdm)
# TODO why are these different??
#
## *** Remove Empty tweets#######################################################
## Do this after the weighting because a TDM object needs to given to
## weightTFIdf
## This was done in the solutions
## [[~/Dropbox/Studies/2020Autumn/Social_Web_Analytics/06_Solutions_Clustering.R]]
## <<empties>>
null = which(rowSums(as.matrix(tweet_weighted_dtm)) == 0)
rowSums(as.matrix(tweet_weighted_dtm)==0)
null
length(null)

if(length(null)!=0){
  tweet_weighted_dtm = tweet_weighted_dtm[-null,]
}

if (nrow(tweet_weighted_dtm) == length(tweet_corpus_clean)-length(null) ) {
  print("Success! Empty Documents removed from TDM")
} else {
  "Error! Number of documents exceeds non-empty documents in TDM"
}



# TODO rename tweet_weighted as tweet_weighted_dtm below here VVV
## ** Visualise the Cleaned Tweets to Find stop words or issues==================
## Only consider the first 30 words
(relevant <- sort(apply(tweet_weighted_dtm, 2, mean), decreasing = TRUE)[1:30]) %>% head()

p <- brewer.pal(n = 5, name = "Set2")
wordcloud(
  words = names(relevant),
  freq = relevant,
  colors = p,
  random.color = FALSE
)


data <- tibble(word = names(relevant), weight = relevant)

ggplot(data, aes(label = word, size = weight)) +
  scale_radius(range = c(0, 20), limits = c(0, NA)) +
 scale_size_area(max_size = 24) +
  geom_text_wordcloud()

## ** How many documents are empty after processing=============================
## this was shown in [[empties]]
## We can see the distribution of frequencies like so:
(colSums(as.matrix(tweet_matrix_tdm))) %>% table()
length(null)
## No document was empty, each had atleast >= 18 terms

## * 8.2.14 How many clusters are there?-----------------------------------------
## <<8214Clust>>
norm.tweet_weighted_dtm = diag(1/sqrt(rowSums(tweet_weighted_dtm^2))) %*% tweet_weighted_dtm
## then create the distance matrix
D =dist(norm.tweet_weighted_dtm, method = "euclidean")^2/2
#To visualise the clustering, we will use multidimensional
#scaling to project the data into a 2d space
## perform MDS using 100 dimensions

## Use the rank of the matrix to determine the dimension to project into
(l <- min(nrow(tweet_weighted_dtm),
         ncol(tweet_weighted_dtm)))
ev <- eigen(tweet_weighted_dtm[1:l, 1:l]) 
k <- (ev$values != 0) %>% sum()

## Take only the top 20% of the eigenvalues.
x <- quantile(abs(ev$values), 0.2) # TODO is this meaningful?
k <- sum(abs(ev$values) < x)

mds.tweet_weighted_dtm <- cmdscale(D, k=k) #TODO What should K be? see issue #10
n = 15 #we assume elbow bends at 5 clusters
SSW = rep(0, n)
for (a in 1:n) {
  ## use nstart to reduce the effect of the random initialisation
  set.seed(40)#seed for random number generator to ensure consistency in our results
  K = kmeans(mds.tweet_weighted_dtm, a, nstart = 20)
  SSW[a] = K$tot.withinss
  paste(a*100/n, "%") %>% print()
}
SSW

## plot the results
plot(1:n, SSW, type = "b")






