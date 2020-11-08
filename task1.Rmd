---
title: "Linear Regression with R"
author: "Manav Jain"
output: html_document
---

## Simple Linear Regression

In this regression task we will predict the percentage of marks that a student is expected to score based upon the number of hours they studied. This is a simple linear regression task as it involves just two variables.

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

### Reading data from remote link

```{r}
url <- "http://bit.ly/w-data"
data<-read.csv(url)
print("Data imported successfully")
head(data)
```

Let's plot our data points on 2-D graph to eyeball our dataset and see if we can manually find any relationship between the data. We can create the plot with the following script:


```{r}
plot(data$Hours,data$Scores,col="red",main="Hours vs Percentage",xlab="Hours studied",ylab="Percentage Scores")
```

From the graph above, we can clearly see that there is a positive linear relation between the number of hours studied and percentage of score.

## Preparing the data

Now that we have our attributes and labels, the next step is to split this data into training and test sets.
We'll do this by using caret library and under that createDataPartition.

```{r warning=FALSE}
library(caret)
intrain<-createDataPartition(y=data$Hours,p=0.8,list=FALSE)
train<-data[intrain,]
test<-data[-intrain,]
head(train)
```

## Training the Algorithm and Fit a Linear Model
We have split our data into training and testing sets, and now is finally the time to train our algorithm.

```{r}
lm1<-lm(Scores~Hours,data=train)
print("Training complete.")
summary(lm1)
```

## Plotting the regression line

```{r}
plot(train$Hours,train$Scores,pch=19,col="blue",xlab="Hours studied",ylab="Percentage Scores")
lines(train$Hours,lm1$fitted,lwd=3)
```

## Making Predictions
Now that we have trained our algorithm, it's time to make some predictions.

```{r}
#This our the values for testing data
neww<-data.frame(Hours=test$Hours)#testing data
predict(lm1,neww)
#When hours = 9.25
new<-data.frame(Hours=9.25)
predict(lm1,new)
```

## Evaluating the model
The final step is to evaluate the performance of algorithm. This step is particularly important to compare how well different algorithms perform on a particular dataset. For simplicity here, we have chosen the root mean square error. There are many such metrics.

```{r}
#Calculate RMSE on training
sqrt(sum((lm1$fitted-train$Scores)^2))
#Calculate RMSE on testing
sqrt(sum((predict(lm1,newdata = test)-test$Scores)^2))
```


