library(e1071)
library(plyr)
install.packages("caret")
library(caret)
#########  Internal Training Nous ##############
# VARIABLE DESCRIPTIONS:
#   survival        Survival
# (0 = No; 1 = Yes)
# pclass          Passenger Class
# (1 = 1st; 2 = 2nd; 3 = 3rd)
# name            Name
# sex             Sex
# age             Age
# sibsp           Number of Siblings/Spouses Aboard
# parch           Number of Parents/Children Aboard
# ticket          Ticket Number
# fare            Passenger Fare
# cabin           Cabin
# embarked        Port of Embarkation
# (C = Cherbourg; Q = Queenstown; S = Southampton)
#####################################################

## Load in the Training Data
train_data = read.csv(file.choose())
## Read the first 5 rows
head(train_data)
## Summary Of Data
summary(train_data)
## Variables Names
names(train_data)

## Building a Model
model1 = naiveBayes(as.factor(survived) ~ sex + pclass + age + fare, data = train_data)
model1

predict(model1, train_data)

train_data$survived_pred <- predict(model1, train_data)

train_data$survived_pred
train_data$survived

#### Calculating the Error
confusionMatrix(train_data$survived_pred,train_data$survived)

### TESTING THE MODEL
test_data = read.csv(file.choose())
summary(test_data)

## Prediction
test_data$survived <- predict(model1,test_data)
test_data$survived
submission=data.frame(test_data$PassengerId,Survived)

getwd()
write.csv(test_data$survived, "niave-bayes.csv")
