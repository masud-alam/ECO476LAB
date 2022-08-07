
#Discrete distribution----

# We will use package foreign, please install the package first, if you dont have it
#install.packages("foreign")
require(foreign)

#download wooldridge data from the web

affairs <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/affairs.dta")

#alternatively you can download data from the Blackboard
# or you can use package Wooldridge
# require(wooldridge)
# data(package="wooldridge")
# data("affairs")
# View(affairs)
View(affairs)

str(affairs)
View(affairs$kids)

class(affairs$kids)

#create factors for kids and for marriage and attach labels

haskids <- factor(affairs$kids,labels = c("no","yes"))

#for ratmarr collum, create five labels and convert the col values

mlab <- c("very unhappy","unhappy","average","happy","very happy")
marriage <- factor(affairs$ratemarr,labels = mlab)
marriage
table(haskids)#frequencies for kids
prop.table(table(marriage)) #marriage ratings and check the share/proportions


#Now make a contingency table and counts(display and store variables)

(countstab <- table(marriage,haskids))

#now we will see the share with in marriage,i.e with in a row (1)
prop.table(countstab,margin = 1)

#next check share within "haskids",i.e with in a column
prop.table(countstab,margin = 2)

#lets make some grpah to depcit above information
pie(table(marriage),col = c("blue","green","yellow","red","grey"),main = "Proportion of marriage couple")
table(marriage)

# x <- c(16,66,93,194,232)
# library(plotrix) # you need this package to draw 3D plot. it looks cool!!
# pie3D(x,labels=mlab,explode=0.1,
#       main="Distribution of marriage status ")

barplot(table(marriage),horiz = F,las=1,
        main = "Distribution of happiness",ylim = c(0,180), col = c("blue","green","yellow","red","purple"))

barplot(table(haskids, marriage),horiz = T,las=1,
        legend=T, args.legend = c(x="bottomright"),
        main = "Happiness by kids",col = c("green","purple"))



barplot(table(haskids, marriage),beside = T,las=2,
        legend=T, args.legend = c(x="topleft"),
        main = "Happiness by kids",col = c("green","purple"))



### Regression analysis


# Woolridge Book: page 33, example 2.4


data(wage1, package='wooldridge')

# OLS regression:

View(wage1)
summary(wage1$wage)
sd(wage1$wage)
regmodel2 <- lm(wage ~ educ, data=wage1)
summary(regmodel2)

require(stargazer)
stargazer(wage1, type = "text", title="Table 1: Summary Statistics",out="table1.txt")
stargazer(regmodel2, type = "text", title = "Table 2:Regression Output")

# Woolridge Book: page 34, example 2.5

#first import data
data(vote1, package='wooldridge')
str(vote1)
View(vote1)


# OLS regression (parentheses for immediate output):
( VOTEreg <- lm(voteA ~ shareA, data=vote1) )

# scatter plot with regression line:
with(vote1, plot(shareA, voteA))
abline(VOTEreg)



#Extension of ceo salary and roe regression model----

data(ceosal1, package='wooldridge')
View(ceosal1)

# extract variables as vectors:
sal <- ceosal1$salary
roe <- ceosal1$roe

# regression with vectors:
CEOregres <- lm( sal ~ roe)

# obtain predicted values and residuals (topic 2.3, page 35)
sal.hat <- fitted(CEOregres)
u.hat <- resid(CEOregres)

# Wooldridge, Table 2.2, page 36: 
cbind(roe, sal, sal.hat, u.hat)[1:15,]


#Extension of wage and education regression model, wooldridge example 2.7, page 37

data(wage1, package='wooldridge')
View(wage1)
WAGEregres <- lm(wage ~ educ, data=wage1)

# obtain coefficients, predicted values and residuals
b.hat <- coef(WAGEregres)
wage.hat <- fitted(WAGEregres)
u.hat <- resid(WAGEregres)

# Confirm property (1): eqn 2.30, page 36
mean(u.hat)

# Confirm property (2): eqn 2.31
cor(wage1$educ , u.hat)

# Confirm property (3): eqn 2.32
mean(wage1$wage)
b.hat[1] + b.hat[2] * mean(wage1$educ) 



# Estimate log-level model
lm( log(wage) ~ educ, data=wage1 )

lm( log(salary) ~ log(sales), data=ceosal1 )

# regression through the origin, with constant only, and plotting them

reg1 <- lm(salary~0+roe, data=ceosal1)
summary(reg1)

reg2 <- lm(salary~1,data = ceosal1)
summary(reg2)

mean(ceosal1$salary)
windows()

plot(ceosal1$roe,ceosal1$salary,ylim = c(0,4000),xlab="Return on Equity", ylab="CEO Salary")

abline(reg1,lwd=2,lty=1, col="red")
abline(reg2,lwd=2,lty=2, col="green")
abline(CEOregres,lwd=2,lty=3,col="blue")

legend("topleft",c("regression through the origin","constant only","Regression with intercept"),
       col=c("red","green","blue"),lwd=2,lty = 1:3)



##  multivariate regression model

data(wage1, package='wooldridge')

View(wage1)
# OLS regression:
lmres <- lm(log(wage) ~ educ+exper+tenure, data=wage1)

# Regression output:
summary(lmres)

# Load package "car" (has to be installed):
install.packages("car")
library(car)
## Check multicollinearity
# Automatically calculate VIF :
vif(lmres)


### Heteroscadasticity test

#In R, the easiest way to test for heteroscedasticity is with the "Residual vs. Fitted"-plot.
#This plot shows the distribution of the residuals against the fitted (i.e., predicted) 
#values and makes detection of heteroscedasticity straightforward. 
#Alternatively, you can perform the Breusch-Pagan Test or the White Test

model <- lm(log(wage) ~ educ+exper+tenure, data=wage1)

par(mfrow = c(2, 2))
plot(model)

#Example with heteroscedasticity

model2 <- lm(Volume~Height, data = trees)

par(mfrow = c(2, 2))
plot(model2)

#Perform the Breusch-Pagan Test

library(lmtest)
lmtest::bptest(model)
lmtest::bptest(model2)

##White test
library(skedastic)

skedastic::white_lm(model)
skedastic::white_lm(model2)



