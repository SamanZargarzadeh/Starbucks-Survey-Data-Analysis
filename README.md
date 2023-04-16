# Starbucks' Survey Data Analysis
•	Working with survey data on a random sample of 10,000 Starbucks Coffee customers for 27 variables. Cleaning the data with the help of R, visualizing data, and telling the story of data by analyzing graphs, regression analysis and building multiple regression models of dummy variables, and segmenting data based on cluster analysis (NbClust procedure).


Skills: Data Cleaning, Data clustering, Regression Model, R, Excel

## Table of Contents

- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Regression Analysis](#regression-analysis)
- [Test and Train](#test-and-train)
- [Variable Selection](#variable-selection)
- [Cluster Analysis and Interpretation](#cluster-analysis-and-interpretation)
- ["What-If" Analysis](#what-if-analysis)




## Exploratory Data Analysis
Increasing the profits and finding new clients is one the top concerns of every business. Based on the data, we could say satisfaction is the key to finding new customers and increasing profit. In the bellow, two diagrams are shown the impact of customer satisfaction on Profitability and how the customer recommends Starbucks to others. As it is revealed, the relation between profits and satisfaction and recommendation has Linearity. For each point increase in satisfaction, Starbucks' profit and people’s recommendations go up, which is also a value for our company. 

Method: The data is aggregated into separate segments based on the satisfaction point. Ten segments are calculated so the relationship between variables can be defined more clearly. For example, the satisfaction of 5 represents the segment of satisfaction points from 0 to 10. And the profit for this segment is the average of every profit data that we have for this range of satisfaction. And I do the same for other segments. Therefore we have 10 points which represent satisfaction and profit. For the recommendation data, I use the same method as what I explained for profit.

<img width="450" alt="image" src="https://user-images.githubusercontent.com/88157400/230541214-1573dae1-7f04-4b31-b048-de13ce7c04db.png">

<img width="429" alt="image" src="https://user-images.githubusercontent.com/88157400/230541244-0069d1ff-19ed-42ed-9c43-40739d0fc138.png">

In General, the main point is if our customers become satisfied with the quality of food and drink and behavior of staff, without doubt, our company gains more profit and more customers as Starbucks would be recommended more.
As a suggestion, the Starbucks store could be equipped with a Customer Satisfaction Kiosk and track their happiness after each buy, and make a goal of having happier costumer because happier customers buy more, and it means more profit and more new customers.

Moreover, this relationship which was plotted, is an essential point always to have in mind, but for having strategy, we should look deeply at the data and find the cons of our business. So I aggregate satisfaction data which we already know that this is key to success. This time, the data is categorized by their zip code and plotted on the orange county map. 

<img width="468" alt="image" src="https://user-images.githubusercontent.com/88157400/230541300-309dc244-759b-4bca-b797-c5a9b9e1dcd5.png">

Although these zip codes are not for our stores' exact location, we can say the customer gets service from the nearest place to their residence zip code. 



Every store in these five areas should be inspected. But I look more deeply at the worst one as a sample. In our survey, we had four types of questions that could help us to find the problem better. The questions were in three categories of food, beverage, and staff, and one question around price. In the bellow, we have the graphs of the average score of people who lives in zip code 90680.

<img width="306" alt="image" src="https://user-images.githubusercontent.com/88157400/230541408-6d34bf24-ac81-422e-acc5-359d35198165.png">

Looking at the graph, we can understand that the price is the first problem to take care of. Moreover, the average income of people in this zip code is below the average of orange county. So, I suggest in this area we should add a half portion food to our menu and give promo code more than other stores.

## Regression Analysis

Multiple R-squared:  0.907

p-value: < 0.00000000000000022

From the R code, the Multiple R-squared is calculated as 0.907, which is higher than 0.9. Hence, the regression model fits very well, and it could be claimed that the three predictor variables do a very good job of predicting the average monthly profits of each customer. The R2 statistic can be interpreted as “the percentage of the variation in Starbucks’ average monthly profits that is explained by the customer’s satisfaction, their annual income, and How likely are they to recommend Starbucks to others”. It reveals that 90.7% of the variability observed in the average monthly profits is explained by the regression model.

From the result, the p-value is calculated < 0.00000000000000022, and based on the guideline, When the p-value is smaller than 0.01, the result could be called very significant. To put it in a nutshell, customer satisfaction, their annual income, and How likely they are to recommend Starbucks to others have a meaningful impact on Starbucks’ average monthly profits and matters in our regression model.

## Test and Train

starbucks_training <- as.data.frame(starbucks[1:5000,])
starbucks_test <-as.data.frame(starbucks[5001:6121,])

17 variables are significant at the 5% level: X1 + X2 + X3 + X4 + X5 + X7 + X8 + X9 + X10 + X12 + X13 + X14 + X15 + X16 + X19 + X20 + X22
(All except X6, X11, X17, X18, and X21)
R-squared:  0.3547 
The linear relationship with these dependent and independent variables is not a good fit, but it reveals that 35.47% of the variability observed in the recommend (the variation in Y) is explained by the X variables in our regression model.

R2 Train = 0.3547
R2 Test= 0.2944
Difference = 0.3547 - 0.2944 = 0.0603
The R-square for the test sample is 0.2944, which is 0.0603 less than the R-square for the training sample. As this difference is a small amount, so the model’s ability to predict “recommend” in the test sample is acceptable.


## Variable Selection

X6, X17, and X18 are the variables that are not selected.
R2 of the forward selection model is 0.3543, which is 0.0004 less than the R2 Training sample. So, we can conclude that these three variables do not play role in our model. Thus, dropping these variables does not matter for the model. Moreover, the p-value results (question one), show that X6, X17, and X18, are not significant at the level of 5%. So, these variables are dropped in the forward selection. 

## Cluster Analysis and Interpretation

X <- as.matrix(starbucks[,1:22])
dim(X) = 6121   22

The NbClust method recommends 2 clusters, per the bar chart.
The bar chart:

 <img width="222" alt="image" src="https://user-images.githubusercontent.com/88157400/230542843-c6866e34-f7d8-46cf-8e02-78f117e453fb.png">

 
Extra charts:

 <img width="352" alt="image" src="https://user-images.githubusercontent.com/88157400/230542853-7d579121-80e6-4718-8351-408e4062dd52.png">


The cluster one has 3230, and cluster two has 2891customers.


The “most satisfied” segment is cluster 1 based on the highest average ratings, which are reported above. For cluster 1 average is 4.04 for cluster 2 is 3.28, so cluster 1 has the highest. 
The cluster center values for X1, X2, X3, X4, and X5 (rounded to two decimal places) for this most satisfied segment of customers:

X1              X2              X3              X4              X5 
4.13            4.16            4.22            4.17            4.24            



The average predicted value for “Most Satisfied” is 7.33, and it is 2.14 more than the Others’ average predicted value (5.19). Thus, the customers in Most Satisfied segment are more likely to recommend Starbucks by 2.14 points more than other customers’ segment.

  
## “What-If” Analysis


round(mean(as.data.frame(OtherPrediction)[,1]),2)
 =7.05

round(mean(Other$recommend),2)
 =5.19

100*(mean(as.data.frame(OtherPrediction)[,1])-mean(Other$recommend))/mean(Other$recommend)
 =35.73745
 

The average of these new predicted values is 7.05, and if we compare it to the average of recommendations of the “Other” Segment, we can assert that the willingness to recommend goes up by 35.7%, which is a significant amount. In Homework 2, we understood that the level of recommendation has a relationship with our profits, so this increase is a worthwhile thing to do.












