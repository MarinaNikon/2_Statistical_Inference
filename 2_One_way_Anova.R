#Assignment 2_One way Anova
#Marina Nikon

#BACKGROUND:
#A new marketing campaign was tested in 12 randomly selected stores
#of a large retail group. Usual campaign was run in another 12
#randomly selected stores during the same month. The outcome 
#variable is “Sales Growth”. 


#QUESTIONS:
#1 Is the new campaign more effective than usual campaign?
#2 In the campaign testing, store numbers 1-4 and 13-16 are
# from ‘West’, 5-8 and 17-20 are from ‘South’ and 9-12 and 
# 21-24 are from ‘East’. Test the effect of ‘Zone’ in this business experiment.


#Import data and name it as campaign.
campaign<-read.csv(file.choose(), header = TRUE)
str(campaign)
head(campaign)
dim(campaign)


#Check for normality of the data.
#Check for normality of New Campaign using QQPlot
qqnorm(subset(campaign, Campaign== "New")$Growth,
       main = "QQPlot (New Campaign)",
       col="coral", pch = 16)

qqline(subset(campaign, Campaign== "New")$Growth,
       col="blue") 
#Interpretation: The QQ Plot for the "New Campaign" 
#shows points close to the theoretical line, suggesting normality


#Check for normality of Usual Campaign using QQPlot
qqnorm(subset(campaign, Campaign== "Usual")$Growth,
       main = "QQPlot (Usual Campaign)",
       col="green", pch = 16)

qqline(subset(campaign, Campaign== "Usual")$Growth,
       col="blue") 
#Interpretation: The QQ Plot for the "Usual Campaign" 
#deviates from the theoretical line, indicating possible non-normality


#Check for normality for Growth by Campaign using Box-Whisker Plot #SYMMETRY
boxplot(Growth~Campaign, data = campaign, col = c("yellow", "green"),
        main = "Box-Whisker Plot (Growth by Campaign)",
        xlab = "Campaign", ylab = "Sales Growth")
#Interpretation: The boxplot shows sales growth for both campaigns, 
#with noticeable variability.
#New Campaign is appears symmetrical, Usual Campaign is slightly
# right skewed with one outlier


 
# Check for normality of New Campaign using Shapiro-Wilk test
shapiro.test(campaign$Growth[campaign$Campaign == 'New'])
#Interpretation: p-value = 0.8938, greater than 0.05, do not reject the
#null hypothesis. Distribution of New Campaign 
#can be assumed to be normal


# Check for normality of Usual Campaign using Shapiro-Wilk test
shapiro.test(campaign$Growth[campaign$Campaign == 'Usual'])
#Interpretation: p-value = 0.01245 less than 0.05, reject the 
#null hypothesis.  Distribution of Usual Campaign 
#can be assumed not normal


#Kolmogorov-Smirnof test to check  normality for New Campaign
#Install and use package 'nortest' (if necessary)
install.packages('nortest')

# Load the library
library(nortest)
lillie.test(campaign$Growth[campaign$Campaign == 'New'])
#Interpretation: p-value = 0.923, more than 0.05, do 
#not reject the null hypothesis.
#Distribution of New Campaign can be assumed to be normal



#Kolmogorov-Smirnof test to check  normality for Usual Campaign
lillie.test(campaign$Growth[campaign$Campaign == 'Usual'])
#Interpretation: p-value = 0.0371 less than 0.05, reject the 
#null hypothesis.  Distribution of Usual Campaign 
#can be assumed not normal



#Is the new campaign more effective than usual campaign?
#use One Way ANOVA to check effectiveness 
anovatable<-aov(formula = Growth~Campaign, data = campaign)
summary(anovatable)
#Interpretation: p-value = 0.0107, less than 0.05, reject the 
#null hypothesis. This indicates that there is difference in
#effectiveness between the New campaign and the Usual campaign 


#Post-Hoc test to check which campaign is more effective
#Use Tukey's test to check effectiveness
TukeyHSD(anovatable)
#Interpretation: diff is -1.716667. This indicates that the
#new campaign is less effective than usual campaign



#In the campaign testing, store numbers 1-4 and 13-16 are from 
#‘West’, 5-8 and 17-20 are from ‘South’ and 9-12 and 21-24 are 
#from ‘East’. Test the effect of ‘Zone’ in this business 
#experiment.
#use One Way ANOVA to check the effect of ‘Zone’ 
anovatable_zone<-aov(formula = Growth~Zone, data = campaign)
summary(anovatable_zone)
#Interpretation: p-value = 0.28, greater than 0.05, do not reject  
#the null hypothesis. The result suggesting that sales
#growth does not significantly differ across zones (West, South, East).


#Post-Hoc test to check is there differences across zones 
#Use Tukey's test to check differences
TukeyHSD(anovatable_zone)
#Interpretation: 
#South-East adjusted p-value is 0.6359032, greater than 0.05.
#West-East adjusted p-value is 0.7518379, greater than 0.05.
#West-South adjusted p-value is 0.2509417, greater than 0.05.  
#There are no significant differences in sales growth
#across the zones (West, South, East).



