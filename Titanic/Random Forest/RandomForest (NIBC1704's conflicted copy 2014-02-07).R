## Accuracy 95% an 86%
install.packages("randomForest")
library("randomForest")
library(caret)
## loading the training Data
train_titanic = read.csv(file.choose())
names(train_titanic)

summary(train_titanic)

## Dealing with Age NA Median Method
train_titanic$Age[is.na(train_titanic$Age)]=median(train_titanic$Age[!is.na(train_titanic$Age)])

##Fixing Cabin Values
norm=function(x){
  unlist(strsplit(as.character(x),""))[1]
}
# Cabin Values stripped + NA's
Cabin=sapply(train_titanic$Cabin,norm)
Cabin_rfimp= data.frame(Cabin,train_titanic$Fare,train_titanic$Pclass,train_titanic$Survived,train_titanic$Title)
imp <- missForest(Cabin_rfimp)
imp$ximp$Cabin
plot(imp$ximp$Cabin)
train_titanic$Cabin=imp$ximp$Cabin


## Building the random forest Model Name , 
model_rf=randomForest(train_titanic[,-c(4,9,2)],train_titanic$Survived)
varImpPlot(model_rf)
importance(model_rf,type=2)

rf_predict=predict(model_rf,train_titanic)
confusionMatrix(round(rf_predict),train_titanic$Survived)



## Model 2 from Internet
model2 <- randomForest(Survived ~ Sex + Pclass + Age + Fare , data = train_titanic, ntree = 5000, importance = TRUE)
varImpPlot(model2)
rf_predict2=predict(model2,train_titanic)
confusionMatrix(round(rf_predict2),train_titanic$Survived)

################### Model on Test Data ##############

titain_test = read.csv(file.choose())
names(titain_test)
summary(titain_test)
## TO Do FIx Age and Fare

## Taking all the rows that are in 3rd Class
class3=subset(titain_test,Pclass==3)
## Talking the mean of 3rd Class
class3_mean=mean(class3$Fare,na.rm="TRUE")
class3_mean
## fares
train_titanic$Fare[153]=class3_mean

## Age 
summary(titain_test)

for(i in 1:nrow(titain_test)){
  if(is.na(titain_test[i,"Age"])){
    titain_test[i,"Age"]=predict(agemodel,newdata=titain_test[i,])
  }  
}

## Predicting on Test Data
p1.survive.test=round(predict(model_rf,titain_test,type="response"))
Survived=p1.survive.test
## Writing the Output to a File
submission=data.frame(PassengerId,Survived)
submission
write.csv(submission,"RF.csv")


