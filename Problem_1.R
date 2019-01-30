## Based on the solution of the "stu" team.

## Load libraries
## Leave the following line uncommented when submitting, otherwise your build will fail!
install.packages('xts')
## to install it.

library(xts)

store <- read.csv('https://s3.eu-central-1.amazonaws.com/sf-timeseries/data/rossmann1.csv', stringsAsFactors = FALSE)

## a)


## b)
n <-length(store$Date)

lasttObs <- store$Date[1]
## the last observation is on 2015-07-31

firstObs <- store$Date[n]
## the first observation is on 2013-01-01

## c)
dates <- store$Date

## d)
timeIndex <- as.Date(dates)
sales <- xts(store$Sales, order.by= timeIndex)

plot(sales)

## e) 
##The graph doesn't show a clear trend, the values are changing above and below 5000.

## f)
## The sales are usually higher in december (Christmas shopping).
## The sales equal zero every sunday as the store is closed on sudays.

## g)
firstHalf <- mean(sales['2014-01-01/2014-06-30'])
firstHalf
secondHalf <-mean(sales ['2014-07-01/2014-12-31'])
secondHalf
##The mean for the first half of 2014 (3945.7) is less than the mean for the 
##second half (4058.6

## h, i)
monthlySales <- to.monthly(apply.monthly(sales, sum))[, 1]
monthlySales

frequency(monthlySales)
monthlySales
decomp <- decompose(as.ts(monthlySales))


##j)

## m_t = (0.5*x_{t-6}+x_{t-5}+...+x_{t-1}+x_t+x_{t+1}+...0.5x_{t+6}) / 12)
## as the smallest t for our example is 7 and the biggest is 25, as we need 
## 6 steps before and 6 steps after and all observations are 31

## k)
## Ignore this question

## l)
plot(decomp$trend)
plot(decomp$seasonal)
plot(decomp$random)

## or simply

plot(decomp)

## m) 
weeklySd <- apply.weekly(sales, sd)
weeklySd
plot(weeklySd)

## The standard deviation appears to be greater in periods of high sales.
## And therefore does not appear to be constant/

## n)
## first we check for seasonality of the number of people shopping

customers <- xts(store$Customers, order.by= timeIndex)
plot(customers)

## The customers series appears to show a similar seasonal pattern as the
## sales series. There are usually more customers in december compared
## to other monts. This supports the claim of the cunsultant.
