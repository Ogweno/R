install.packages("Rserve")
install.packages("Rstem")
install.packages("tm")
download.file("http://cran.cnr.berkeley.edu/src/contrib/Archive/Rstem/Rstem_0.4-1.tar.gz", "Rstem_0.4-1.tar.gz") 
install.packages("Rstem_0.4-1.tar.gz", repos=NULL, type="source")
library(Rserve)
Rserve(args="--no-save")

x=Rserve()
download.file("http://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.2.tar.gz", "sentiment.tar.gz")
install.packages("sentiment.tar.gz", repos=NULL, type="source")
installed.packages("hiR")

hello <- "hello word1"
