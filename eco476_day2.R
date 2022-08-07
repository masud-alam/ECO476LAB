#Data frame

# A data frame is a kind of list. More precisely, a data frame is a list of items with
# the same structure; e.g., all vectors or matrices included in a data frame have the
# same dimensions (i.e., number of rows and columns).

##A data frame example

# Define a year vector for all:

year     <- c(2008,2009,2010,2011,2012,2013)

# Define a matrix of y values:
product1<-c(0,3,6,9,7,8); product2<-c(1,2,3,5,9,6); product3<-c(2,4,4,2,3,2)
sales_mat <- cbind(product1,product2,product3)
rownames(sales_mat) <- year
# The matrix looks like this:
sales_mat
str(sales_mat)
# Create a data frame and display it:
sales <- as.data.frame(sales_mat)
sales
str(sales)


# Accessing a single variable:
sales$product2
# Generating a new  variable in the data frame:
sales$totalv1 <- sales$product1 + sales$product2 + sales$product3

# Subset: all years in which sales of product 3 were >=3
subset(sales, product3>=3)


# Note: "sales" is defined in Data-frames.R, so it has to be run first!
# save data frame as RData file (in the current working directory)
#save(sales, file = "oursalesdata.RData")

#write.csv(sales,"sales.csv")

#Now close and restart R-studio from your original lab_476 folder and import sales csv data file
df_sales <- read.csv(file = "sales.csv", header = TRUE, stringsAsFactors=FALSE)





### Module 3

## Built in data set
data()## see all the available data sets
data(ChickWeight)
View(ChickWeight)


install.packages("readxl") 
library("readxl")
library("xlsx")
?summary

##Importing Data in R Script
# Import  the sales csv dataset 

Data_sales <- read.csv(file.choose(), header=T)
df_sales <- read.csv(file = "sales.csv", header = TRUE, stringsAsFactors=FALSE)

# Import the flower xls|xlsx dataset 
my_data <- read_excel("flower.xls")

# Import the flower.txt dataset 
flowers <- read.table(file = 'flower.txt', header = TRUE, sep = "\t", stringsAsFactors = TRUE)


#If we just wanted to see the names of our variables (columns) in the data frame 
#we can use the names() function which will return a character vector of the variable names.


#Import data from online

df <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data",header = FALSE)
View(df)



# Activate the `foreign` library
library(foreign)
# Read Stata data into R
mydata <- read.dta("affairs.dta")

# Read the SPSS data
mySPSSData <- read.spss("dataFileName.sav", to.data.frame=TRUE, use.value.labels=FALSE)


# Activate the `sas7bdat` library
library(sas7bdat)
# Read in the SAS data
mySASData <- read.sas7bdat("dataFileName.sas7bdat")


##The wooldridge data package aims to loading any data set from the text
#Introductory Econometrics: A Modern Approach, 6e.

library(wooldridge)
data("wage1")
View(wage1)

##For Data Sets from "Basic Econometrics, 5ed" by Damodar N. Gujarati and Dawn Porter

#install.packages('devtools')
require(devtools)
devtools::install_github('https://github.com/brunoruas2/gujarati')
require(gujarati)
data('Table1_1')
View(Table1_1)
df11 <- gujarati::Table1_1

##See all the Gujarati data set on 
##https://rdrr.io/github/brunoruas2/gujarati/man/

## Package yfR facilitates importing stock prices from Yahoo finance, organizing the data in the tidy format
install.packages("yfR")
require(yfR)

my_ticker <- 'FB'
first_date <- Sys.Date() - 30
last_date <- Sys.Date()

# fetch data
df_yf <- yf_get(tickers = my_ticker, 
                first_date = first_date,
                last_date = last_date)
head(df_yf)


options("getSymbols.warning4.0"=FALSE)
suppressPackageStartupMessages(library(quantmod))
getSymbols(Symbols = c("AMZN", "GOOG"), from="2015-01-03", to="2022-01-03",
           auto.assign=TRUE, warnings=FALSE)
class(AMZN)
head(AMZN, 3)
tail(AMZN)


### Using pipe operator 
require(tidyverse)
data("starwars")
View(starwars)


starwars %>% filter(height>150 & mass<200) %>% 
  mutate(height_in_meters=height/100) %>% 
  select(height_in_meters,mass) %>% 
  arrange(mass) %>% 
  View()

plot()

## Exploring Data structure and variable
data("msleep")
View(msleep)
glimpse(msleep)
head(msleep)
class(msleep)
class(msleep$name)
length(msleep)
length(msleep$name)
names(msleep)
unique(msleep$vore)
missing <- !complete.cases(msleep)
msleep[missing,]


## Select variables

starwars %>% 
  select(name,height,mass)
starwars %>% select(1:3)

## Changing variable name
starwars %>% 
  rename("characters"="name") %>% 
  head()

## filter rows
starwars %>% 
  select(mass,sex) %>% 
  filter(mass<55 & sex=="male")


##Recode data

starwars %>% 
  select(sex) %>% 
  mutate(sex=recode(sex,"male"="man", "female"="women"))


## Dealing with mi8ssing data

mean(starwars$height, na.rm = T)


## create or change a new variable
starwars %>% 
  mutate(height_m=height/100) %>% 
  select(name,height,height_m)


## conditional statement

starwars %>% 
  mutate(height_m=height/100) %>% 
  select(name,height,height_m) %>% 
  mutate(tallness=if_else(height_m<1,"short","tall"))


##reshape data with pivot wider data set

library(gapminder)
data("gapminder")
View(gapminder)
my_data <- select(gapminder,country,year,lifeExp)
wide_data <- my_data %>% 
  pivot_wider(names_from = year,values_from = lifeExp) 
View(wide_data)



## Describing data, use msleep data set

min(msleep$awake)
max(msleep$awake)
range(msleep$awake)
IQR(msleep$awake)
mean((msleep$awake))
median((msleep$awake))
var((msleep$awake))
summary(msleep$awake)
msleep %>% select(awake,sleep_total) %>% 
  summary()


## Visualization
data("pressure")
plot(pressure)
?plot

## The Grammar of plot or graphics
## data, mapping, geometry 
## data must in data frame format
## Bar plots
require(ggplot2)
ggplot(data = starwars, mapping = aes(x=gender))+
  geom_bar()

## Histogram

starwars %>% 
  drop_na(height) %>% 
  ggplot(mapping = aes(x=height))+
  geom_histogram()


## Box plots

starwars %>% 
  drop_na(height) %>% 
  ggplot(mapping = aes(x=height))+
  geom_boxplot(fill="steelblue")+
  theme_bw()+
  labs(title = "Boxplot of Height",x="Height of Characters")


# density plot


starwars %>% 
  drop_na(height) %>% 
  filter(sex %in% c("male","female")) %>% 
  ggplot(mapping = aes(x=height, color=sex, fill=sex))+
  geom_density(alpha=0.2)+
  theme_bw()+
  labs(title = "Boxplot of Height",x="Height of Characters")

# Scatter plot


starwars %>% 
  filter(mass<200) %>% 
  ggplot(mapping = aes(height, mass,color=sex))+
  geom_point(size=5,alpha=0.5)+
  theme_bw()+
  labs(title = "Height and mass by sex")


### T-test

library(gapminder)
gapminder %>% 
  filter(continent %in% c("Africa", "Europe")) %>% 
  t.test(lifeExp~continent,data = .,
         alternative="two.sided", paired=F)

## ANOVA

gapminder %>% 
  filter(year==2007) %>% 
  filter(continent %in% c("Americas", "Asia", "Europe")) %>% 
  aov(lifeExp~continent,data = .,) %>% 
  summary()



gapminder %>% 
  filter(year==2007) %>% 
  filter(continent %in% c("Americas", "Asia", "Europe")) %>% 
  aov(lifeExp~continent,data = .,) %>% 
  TukeyHSD()

gapminder %>% 
  filter(year==2007) %>% 
  filter(continent %in% c("Americas", "Asia", "Europe")) %>% 
  aov(lifeExp~continent,data = .,) %>% 
  TukeyHSD() %>% 
  plot()
