install.packages("missForest")
library(vcd)
library(corrgram)
library(impute)
library(randomForest)
library(Hmisc)
library(missForest)
## Normalising the data fields
## Read In the Train data
train = read.csv(file.choose())
names(train)
summary(train)
plot(train)

## Only for discrete data
corrgram(train, order=TRUE, lower.panel=panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt,
         main="Correlogram of mtcars intercorrelations")

## Mosiac Barplot Used for Cateorigacal Analysis
mosaic(~Sex+Survived, data=train, shade=TRUE, legend=TRUE)

## Fixing Cabin values == Random FOrest Imputing 
Cabin_1= data.frame(Cabin,train$Fare,train$Pclass)
dim(Cabin_1)
summary(Cabin_1)
plot(Cabin_1)
Cabin_1[Cabin_1 == "X"] <- NA
imp <- missForest(Cabin_1)
cabin_2=imp$ximp
cabin2

########### Sapply for the Vector  ###########
# Creating a Function #
norm=function(x){
  unlist(strsplit(as.character(x),""))[1]
}
## Cabin 
Cabin=sapply(train$Cabin,norm)

## Denormalizing Cabin reducing Factors

Cabin[is.na(Cabin)]="X"
Cabin



cabin_to_deck <- function(data) {
  data = as.character(data)
  for(i in seq(along=data)) {
    if (is.na(data[i]))
      next
    data[i] <- substr(data[i], 1, 1)
  }
  return (data)
}



test$Cabin = cabin_to_deck(test$Cabin)
test$Cabin = factor(test$Cabin, levels=c('A', 'B', 'C', 'D', 'E', 'F', 'G', 'T'))
train$Cabin = impute(train$Cabin, max)
train$Cabin
## Analysing Cabin Data with fare
## Replacing X as the missing values
summary(train$Cabin)
train$Cabin[is.na(train$Cabin)]="X"



