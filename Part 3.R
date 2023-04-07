#Saman Zargarzadeh
#Section A - Take Home Final

############################### Question 1 ####################################
#import data
setwd("/Users/macbook/Desktop/Uni/Quarter 1/Foundation of BA/Final")
starbucks = read.table("Starbucks HW2 Data.txt", header=T, sep="\t")

#a. divide the data
starbucks_training <- as.data.frame(starbucks[1:5000,])
starbucks_test <-as.data.frame(starbucks[5001:6121,])

#b. Run a multiple regression
attach(starbucks_training)
options(scipen = 999)
regt <- lm(recommend ~ X1 + X2 + X3 + 
            X4 + X5 + X6 + X7 + X8 + 
            X9 + X10 + X11 + X12 + 
            X13 + X14 + X15 + X16 + 
            X17 + X18 + X19 + X20 + 
            X21 + X22)
regt
summary(regt)

#c. Using your regression model and calculate R2 value for the test sample
test_indepX <- starbucks_test[,1:22]
test_dep <- starbucks_test$recommend

test_prediction <- as.vector(predict(object=regt, newdata=test_indepX))
test_prediction

# compute training and test sample R-squared value
library(miscTools)
train.r2 <- rSquared(y=starbucks_training$recommend, resid=resid(regt))
test.r2  <- rSquared(y=test_dep, resid=(test_dep - test_prediction))

round(train.r2,4)
round(test.r2,4)


############################### Question 2 ####################################

#forward variable selection 
detach(starbucks_training)
attach(starbucks_training)

train.X <- cbind(X1 ,X2 ,X3 ,X4 ,X5 ,X6 ,X7 ,X8 ,X9 ,X10 ,X11 ,X12 
             ,X13 ,X14 ,X15 ,X16 ,X17 ,X18 ,X19 ,X20 ,X21 ,X22)

# create a data frame that has Y and your X variables all in one place
new.train.data <- cbind.data.frame(recommend, train.X)

# forward selection
# first fit a model with no variables (only the intercept)
null.model <- lm(recommend ~ 1) # intercept only model
summary(null.model)

as.vector(fitted(null.model))
mean(recommend)

#the full model with all X variables
full.model <- lm(recommend ~ ., data = new.train.data)
summary(full.model) # it looks like some of the variables don't matter

# now perform a forward variable selection regression model 
# it looks like 20 out of the 33 variables are retained
forward.results <- step(object=null.model, direction="forward", scope=formula(full.model))
summary(forward.results)


# which variables are selected in forward selection?
forward.vars.used <- as.data.frame(sort(names(coef(forward.results)[-1])))
colnames(forward.vars.used) <- "Forward"

forward.vars.used

#R square value
library(miscTools)
full.model.r2 <- rSquared(y=new.train.data$recommend, resid=resid(full.model))

forward.data<-cbind.data.frame(recommend,X1,X10,X11,X12,X13
                    ,X14,X15,X16,X19,X2,X20,X21,
                    X22,X3,X4,X5,X7,X8,X9)

regf <- lm(recommend ~ ., data = forward.data)
summary(regf)

############################### Question 3 ####################################

#a. create a data matrix called “X” which includes the 22 predictor variables
detach(starbucks_training)
attach(starbucks)

X <- as.matrix(starbucks[,1:22])
#b. the optimal number of segments
library(ggplot2)
library(cluster)
library(NbClust)
library(factoextra)
library(MASS)

nb <- NbClust(X, distance="euclidean", min.nc=2, max.nc=10, method="kmeans")
fviz_nbclust(nb) 


#c.perform a k-means cluster analysis on the X matrix
cluster.results = kmeans(x = X, centers = 2, iter.max=1000, nstart=100)

# which cluster is each person assigned to?
cluster.numbers = cluster.results$cluster
cluster.numbers

# create a frequency table summarizing the number of people in each cluster
segment_sizes = table(cluster.numbers)
segment_sizes


#d. identify the “most satisfied” segment of customers
as.data.frame(cluster.numbers)

Xclus<-cbind.data.frame(X,cluster.numbers)
sum1=0
sum2=0

for (i in 1:nrow(Xclus)){
  if (Xclus$cluster.numbers[i]==1){
    sum1=sum1+sum(Xclus[i,1:22])
  } else if (Xclus$cluster.numbers[i]==2){
    sum2=sum2+sum(Xclus[i,1:22])
  } 
  
}

meanvec <- c(sum1/(22*segment_sizes[1]),sum2/(22*segment_sizes[2]))
meanvec
#simple way

m1<-mean(apply(Xclus[Xclus$cluster.numbers==1,],2,mean)[1:22])
m2<-mean(apply(Xclus[Xclus$cluster.numbers==2,],2,mean)[1:22])
m1
m2

i=0
j=0
if(max(meanvec)==m1)
{ i=1
  j=2} else{
    i=2
    j=1}
i  
j

#The Max is for cluster i

round(apply(Xclus[Xclus$cluster.numbers==i,],2,mean), digits=2)

#e. Part 1

XclusRec<-cbind.data.frame(X,recommend,cluster.numbers)
MostSat <-XclusRec[XclusRec$cluster.numbers==i,][,1:23]
Other <-XclusRec[XclusRec$cluster.numbers==j,][,1:23]

#e. Part 2
RegMost <- lm(recommend ~ ., data = MostSat)
RegOther <- lm(recommend ~ ., data = Other)

summary(RegMost)
summary(RegOther)

#e. Part 3

# the model spits out the probability of of each person being in each of the four categories
fitsMost <- as.data.frame(fitted.values(RegMost))
fitsOther <- as.data.frame(fitted.values(RegOther))

round(mean(fitsMost[,1]),digits = 2)
round(mean(fitsOther[,1]),digits = 2)

############################### Question 4 ####################################

#a.
increase <- Other 
increase$X1 <- increase$X1 + 1
increase$X2 <- increase$X2 + 1
increase$X7 <- increase$X7 + 1
increase$X8 <- increase$X8 + 1
increase$X10 <- increase$X10 + 1
increase[,1:22][increase[,1:22]==6]<-5

#b.
indepX <- increase[,1:22]
dep <- increase$recommend

OtherPrediction <- as.vector(predict(object=RegOther, newdata=indepX))
OtherPrediction

#c.
round(mean(as.data.frame(OtherPrediction)[,1]),2)

round(mean(Other$recommend),2)
#Comment on whether the change seems significant or not

100*(mean(as.data.frame(OtherPrediction)[,1])-mean(Other$recommend))/mean(Other$recommend)


# The End