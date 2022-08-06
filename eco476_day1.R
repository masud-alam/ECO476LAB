### Day1_module 2

#The Absolute Basics
#add 
1 + 1
#subtract them 
8-4
#divide
13/2
#multiply
4*pi
#exponentiation
2^10 

##Strings or character variable (text) 

'Econometrics is awesome'

#R delimits strings with EITHER double or single quotes.
#  There is only a very minimal difference
"Econometrics is still awesome"

#Variables
#Creating object

x = 42
x / 2

#if we assign something else to x,
#  the old value is deleted

x = "Melody to Funkytown!"
x
x = 5
x
foo = 3
bar = 5
foo.bar = foo + bar
foo.bar

#Logical Comparison
x == 5
3 < 4
3 > 4
#contrast with 3 = 4; see section about variables below
3 == 4
#!= means "not equal to"
3 != 4 
4 >= 5
4 <= 5
2 + 2 == 5
10 - 6 == 4

#Lists

x = list(TRUE, 1, "Frank")
x = list(c(1, 2), c("a", "b"), c(TRUE, FALSE), c(5L, 6L))
y = list(list(1, 2, 3), list(4:5), 6)


#Matrices

# Generating matrix A from one vector with all values
v <- c(2,-4,-1,5,7,0)

## The <- is called the assignment operator. type Alt and -
#This operator assigns values to variables. The command above is translated into a sentence as: 
#The result variable gets the value of one plus two. C stand for concatenation. 

( A <- matrix(v,nrow=2) )

# Generating matrix A from two vectors corresponding to rows:

row1 <- c(2,-1,7); row2 <- c(-4,5,0)

( A <- rbind(row1, row2) )


B = matrix(c(2, 4, 3, 1, 5, 7), nrow=3,ncol=2) 
C = matrix(c(7, 4, 2),nrow=3,ncol=1) 
# combine the columns of B and C with cbind
cbind(B, C)
# combine the rows of two matrices if they have the same number of columns 
D = matrix(c(6, 2),nrow=1,ncol=2)
rbind(B, D)

# Generating matrix from three vectors corresponding to columns:
 
col1 <- c(1,6); col2 <- c(2,3); col3 <- c(7,2)

 ( US40Chart <- cbind(col1, col2, col3) )

# Giving names to rows and columns:

colnames(US40Chart) <- c("Drake","Maroon5","Dua Lipa")
rownames(US40Chart) <- c("weekTop","totPeak") 
US40Chart

# Diagonal and identity matrices: 

diag( c(4,2,6) )
diag( 3 )

# Indexing for extracting elements (still using US40Chart from above):
US40Chart[2,1]
US40Chart[,2]
US40Chart[,c(1,3)] 
US40Chart[2,c(1,2)]
US40Chart[2,]

#Matrices
# Generating matrix A and B

A <- matrix( c(2,-4,-1,5,7,0), nrow=2)
B <- matrix( c(2,1,0,3,-1,5), nrow=2)
A
B
A*B

# Transpose:
(C <- t(B) )
# Matrix multiplication:
 (D <- A %*% C ) 
# Inverse:
 solve(D) 


#Data frame
 
# A data frame is a kind of list. More precisely, a data frame is a list of items with
# the same structure; e.g., all vectors or matrices included in a data frame have the
# same dimensions (i.e., number of rows and columns).

 topHit <-  c(1, 3, 5) 
s <-  c("Drake", "Swift", "Selina") 
at40 <-  c(TRUE, FALSE, TRUE) 
df <- data.frame(topHit, s, at40) 

#To remove everything from the environment: rm(list=ls())

##Another data frame example

# Define one x vector for all:
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

install.packages("readxl") 
library("readxl")
library("xlsx")


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
mySPSSData <- read.spss("example.sav", to.data.frame=TRUE, use.value.labels=FALSE)


# Activate the `sas7bdat` library
library(sas7bdat)
# Read in the SAS data
mySASData <- read.sas7bdat("example.sas7bdat")


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
