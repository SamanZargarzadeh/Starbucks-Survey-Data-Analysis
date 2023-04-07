#Saman Zargarzadeh - Section A
#BANA 200 Assignment 1
#Summer 2022


##########################################Question 1##########################################

#Import the dataset
setwd("/Users/macbook/Desktop/Uni/Quarter 1/Foundation of BA/HW #1")
starbucks = read.table("starbucks final data.txt", header=T, sep="\t")
starbucks
copystar <- starbucks

#Report the number of missing values (NA values) 
star.missing <- is.na(starbucks)*1
star.missing

#For each one of the 27 variables
colSums(star.missing)

#For the entire dataset
sum(star.missing)

#Just for checking
sum(colSums(star.missing))

##########################################Question 2##########################################

#Removing any and all rows with missing values
starbucks.clean <- na.omit(starbucks)

#Number of non-missing rows
nrow(starbucks.clean)

#Percentage of the removed rows to the all data set rows
((nrow(starbucks)-nrow(starbucks.clean))/nrow(starbucks))*100

#Just for check
sum(is.na(starbucks.clean))

##########################################Question 3##########################################

starbucks.clean[,1:22]

#The number of impossible values for each variable
#I do this t(data.frame()) to have the frequency like a table for the report of homework
X1<-t(data.frame(table(starbucks.clean$X1)))
X2<-t(data.frame(table(starbucks.clean$X2)))
X3<-t(data.frame(table(starbucks.clean$X3)))
X4<-t(data.frame(table(starbucks.clean$X4)))
X5<-t(data.frame(table(starbucks.clean$X5)))
X6<-t(data.frame(table(starbucks.clean$X6)))
X7<-t(data.frame(table(starbucks.clean$X7)))
X8<-t(data.frame(table(starbucks.clean$X8)))
X9<-t(data.frame(table(starbucks.clean$X9)))
X10<-t(data.frame(table(starbucks.clean$X10)))
X11<-t(data.frame(table(starbucks.clean$X11)))
X12<-t(data.frame(table(starbucks.clean$X12)))
X13<-t(data.frame(table(starbucks.clean$X13)))
X14<-t(data.frame(table(starbucks.clean$X14)))
X15<-t(data.frame(table(starbucks.clean$X15)))
X16<-t(data.frame(table(starbucks.clean$X16)))
X17<-t(data.frame(table(starbucks.clean$X17)))
X18<-t(data.frame(table(starbucks.clean$X18)))
X19<-t(data.frame(table(starbucks.clean$X19)))
X20<-t(data.frame(table(starbucks.clean$X20)))
X21<-t(data.frame(table(starbucks.clean$X21)))
X22<-t(data.frame(table(starbucks.clean$X22)))

#We can simply use for loop

for (i in 1:22) {
print(table(starbucks.clean[,i]))
print(sum((starbucks.clean[,i]>5 | starbucks.clean[,i]<1)*1))
}


#The total number of impossible values across all 22 variables 
SumImp <- 0
for (i in 1:22) {
  SumImp=SumImp+sum((starbucks.clean[,i]>5 | starbucks.clean[,i]<1)*1)
}
SumImp

#Second way 
sum((starbucks.clean[,1:22]>5 | starbucks.clean[,1:22]<1)*1)

##########################################Question 4##########################################

#Replace all of impossible values for X1 – X22
starbucks.clean[,1:22][starbucks.clean[,1:22]>5]<-5
starbucks.clean[,1:22][starbucks.clean[,1:22]<1]<-1

#The total numbers of 1s, 2s, 3s, 4s, and 5s 

f<-c(0,0,0,0,0)

for (i in 1:22) {
  for (j in 1:nrow(starbucks.clean)){
  if(starbucks.clean[j,i]==5){
    f[5]=f[5]+1
  }else if (starbucks.clean[j,i]==4){
    f[4]=f[4]+1
  }else if (starbucks.clean[j,i]==3){
    f[3]=f[3]+1
  }else if (starbucks.clean[j,i]==2){
    f[2]=f[2]+1
  }else if (starbucks.clean[j,i]==1){
    f[1]=f[1]+1
  }else{
    print("data is not clean!")
  }
  }
}

print(f) #The total

#As for loop may take more time for run we can simply use unlist function
table(unlist(starbucks.clean[,1:22]))

#Double Check 
sum((starbucks.clean[,1:22]>5 | starbucks.clean[,1:22]<1)*1)


##########################################Question 5##########################################

#satis100
starbucks.clean[,23][starbucks.clean[,23]>100]<-100
starbucks.clean[,23][starbucks.clean[,23]<0]<-0

#recommend
starbucks.clean[,24][starbucks.clean[,24]>10]<-10
starbucks.clean[,24][starbucks.clean[,24]<0]<-0

#The counts of the number of unique values for “recommend”
table(starbucks.clean$recommend)


#The average values (means) for all variables
apply(starbucks.clean,2,mean)

#The end
write.table(starbucks.clean,"starbucks clean.txt", sep="\t",row.names = F)
