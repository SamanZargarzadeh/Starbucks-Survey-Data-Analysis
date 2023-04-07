############################### Question 1 ####################################
setwd("/Users/macbook/Desktop/Uni/Quarter 1/Foundation of BA/HW #2")

ZipSatis <- read.table("zip.txt", header=T, sep="\t")
attach(ZipSatis)

maprank <- cbind.data.frame(unique(Zip),unique(Zip))
c=Zip[1]
m=1
j=1
for (i in 1:nrow(ZipSatis)){
  if(Zip[i]!=c){
    maprank[m,2]=sum(sat[j:(i-1)])/(i-j)
    c=Zip[i]
    m=m+1
    j=i
  }
}


maprank[m,2]=sum(sat[j:i])/(i-j+1)
#I Plot it in excel








# Library
library(ggplot2)
library(hrbrthemes)

# Data is aggregated in excel
SBPlot <- read.table("plot.txt", header=T, sep="\t")
attach(SBPlot)
data <- as.data.frame(cbind(satP1, profP1))



# Impact of Customer Satisfaction on Profitability
ggplot(data, aes(x=satP1, y=profP1)) +
  geom_point(
    color="black",
    fill="cornflowerblue",
    shape=22,
    alpha=0.5,
    size=6,
    stroke = 1
  ) +
  geom_smooth(method=lm , color="gray", se=FALSE) +
  theme_ipsum()+labs(title="Impact of Customer Satisfaction on Profitability") +
  xlab("Satisfaction") + ylab("Avg monthly profits on each customer [$]") + xlim(c(0,100))

# Impact of Customer Satisfaction on Recommendation
ggplot(data, aes(x=satP1, y=recP1)) +
  geom_point(
    color="black",
    fill="#FFFF99",
    shape=21,
    alpha=0.5,
    size=6,
    stroke = 1
  ) +
  geom_smooth(method=lm , color="gray", se=FALSE) +
  theme_ipsum()+labs(title="Impact of Customer Satisfaction on Recommendation") +
  xlab("Satisfaction") + ylab("Recommendation") + xlim(c(0,100))

  
# Library
library(fmsb)


#for the worst

data <- as.data.frame(matrix( c(3.40555556,	2.99333333,	2.68333333,	3.66190476) , ncol=4))
colnames(data) <- c("beverages" , "food" , "price" , "staff" )

# To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each topic to show on the plot!
data <- rbind(rep(5,4) , rep(0,4) , data)


# Custom the radarChart !
radarchart( data  , axistype=1 , 
            
            #custom polygon
            pcol=rgb(0.2,0.4,0.6,0.9) , pfcol=rgb(0.2,0.4,0.6,0.5) , plwd=4 , 
            
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,7,1), cglwd=0.8,
            
            #custom labels
            vlcex=0.8 
)

#Total

tot <- as.data.frame(matrix( c(3.808745848,	3.404209552,	3.057180199,	3.857866362),c(3.40555556,	2.99333333,	2.68333333,	3.66190476) , ncol=4))
colnames(tot) <- c("beverages" , "food" , "price" , "staff" )

# To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each topic to show on the plot!
tot <- rbind(rep(5,4) , rep(0,4) , tot)


# Custom the radarChart !
radarchart( tot  , axistype=1 , 
            
            #custom polygon
            pcol=c(rgb(0.0,0.0,0.0,0.2),rgb(0.2,0.4,0.6,0.9)) , pfcol=c(rgb(0.0,0.0,0.0,0.1),rgb(0.2,0.4,0.6,0.5)) , plwd=4 , 
            
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,6,1), cglwd=0.8,
            
            #custom labels
            vlcex=0.8 
)


################################# Question 2 #######################################

#importing Data

SB <- read.table("Starbucks HW2 Data.txt", header=T, sep="\t")
attach(SB)



#Reg
options(scipen = 999)
regS <- lm(profits ~ satis100 + recommend + Income )
regS
summary(regS)



################################# Question 3 #######################################

fail<-as.data.frame(satis100)
exceed<-as.data.frame(satis100)


fail=ifelse(fail<20,1,0)
exceed=ifelse(exceed>80,1,0)


SBD=cbind(SB,fail,exceed)
attach(SBD)

options(scipen = 999)
regD <- lm(profits ~ fail + exceed + recommend + Income )
regD
summary(regD)

#Part a and b
sum(fail)
sum(exceed)
