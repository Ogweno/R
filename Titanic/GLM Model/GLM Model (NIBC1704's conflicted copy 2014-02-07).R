### Models 82 and 81

install.packages("caret")
install.packages("e1071")
library(caret)
library(e1071)
## Clearing the Work Space
rm(list=ls())

## Reading in the training Data Use Train_Title
train=read.csv(file.choose())
names(train)
attach(train)

Title

## Predicting Age
agemodel = lm(train_titanic$Age~train_titanic$Fare+as.factor(train_titanic$Title)+train_titanic$SibSp+train_titanic$Parch)
agemodel

for(i in 1:nrow(train)){
  if(is.na(train[i,"Age"])){
    train[i,"Age"]=predict(agemodel,newdata=train[i,])
  }  
}
write.csv(train,"train_lm_Age.csv")



## Building the model with GLM on Training Data
model=glm(Survived~Pclass+Fare+SibSp+Sex+Age+Pclass:Sex+Age:Sex+SibSp:Sex,
          train, family=binomial(link="logit"))
summary(model)

## Predicitng the data
p=predict(model,train,type="response")
## ROunding Off
p.survive=round(p)
confusionMatrix(p.survive,Survived)
## Accuracy of 82%


########### Model 2 ###################
## Building missing age values with Mean
train1=read.csv(file.choose())
names(train1)
summary(train1)
train1$Age[is.na(train1$Age)]=median(train1$Age[!is.na(train1$Age)])
write.csv(train1,"train_mean_Age.csv")
## manually added the title Column

model1=glm(Survived~Pclass+Fare+SibSp+Sex+Age+Pclass:Sex+Age:Sex+SibSp:Sex,
          train1, family=binomial(link="logit"))
summary(model1)
## Predicitng the data
p1=predict(model1,train,type="response")
## ROunding Off
p1.survive=round(p1)
confusionMatrix(p1.survive,Survived)
## Accuracy of 81.37%



##########################################################
## Clearing the Work Space
test= read.csv(file.choose())
summary(test)
attach(test)

for(i in 1:nrow(test)){
  if(is.na(test[i,"Age"])){
    test[i,"Age"]=predict(agemodel,newdata=test[i,])
  }  
}
names(test)

### 153 row has NA 
## Taking all the rows that are in 3rd Class
class3=subset(test,Pclass==3)
## Talking the mean of 3rd Class
class3_mean=mean(class3$Fare,na.rm="TRUE")
class3_mean

## fares
test$Fare[153]=class3_mean
summary(test)

## Predicting on Test Data
p.survive.test=round(predict(model,test,type="response"))
Survived=p.survive.test


## Writing the Output to a File
submission=data.frame(PassengerId,Survived)
submission
write.csv(submission,"RegressionModel.csv")