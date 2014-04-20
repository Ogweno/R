#Package fix missing values
install.packages("Amelia")
install.packages("imputation")
install.packages("Hmisc")
install.packages("caret", dependencies = c("Depends", "Suggests"))
source("http://bioconductor.org/biocLite.R")
biocLite("impute")

setwd("C:\\Users\\saikrishnak\\Dropbox\\Kaggle\\Titanic")

library(Amelia)
test=read.csv(file.choose(),header=T)
train=read.csv(file.choose(),header=T)
#Caret Package

# 2 plots side by side
par(mfrow=c(1,2))
#missing values Plot
missmap(test, main = "Missingness Map Train")
missmap(train, main = "Missingness Map Test")
# Back to 1 Picture
par(mfrow=c(1,1))

#http://www.philippeadjiman.com/blog/2013/09/12/a-data-science-exploration-from-the-titanic-in-r/
head(train)
??gbm

summary(train)
names(train)
attach(train)
dim(train)


traini=kNNImpute(train[,c(1,2,3,6,7,8,10)], 6,verbose = F)
missmap(train[,c(1,2,3,6,7,8,10)], main = "Missingness Map Test")
missmap(traini$x, main = "Missingness Map Test")

#data after imputing
train1=data.frame(traini$x,Name,Sex,Ticket,Parch,Cabin,Embarked)
edit(train1)
write.csv(train1,file = "train1.csv",row.names = FALSE)
getwd()

#understanding Impute
library(imputation)

DF <- data.frame(age = c(10, 20, NA, 40),height=c(172,134,156,123), sex = c('male','female'))
head(DF)


head(DF[,1:2])
i=kNNImpute(DF[,1:2], 3,verbose = T)
i$x


head(meani)
DF["imputedval"]=meani
head(DF)


x = matrix(rnorm(100),10,10)
edit(x)
x.missing = x > 1
x[x.missing] = NA
head(x)
i=gbmImpute(x)
