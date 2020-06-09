
#Code by RJ Neel

#Learning toc code with DPLYR

#Packages
library(tidyverse)
library(dplyr)
library(hflights)

data("hflights")
head(hflights)

# convert to local data frame
flights=tbl_df(hflights) #Wrapper for a data frame and better for printing and viewing
head(flights) #Only shows the ones that can fit the screen

print(flights,n=20) #Shows 20 rows

#Now we'll convert the local dataframe to a regular dataframe

data=data.frame(flights)
head(data) # All columns shown

## Q: View all flights on Jan 1 2011
head(data)
data[data$Month=='1' & data$DayofMonth=='1', ]
nrow(data[data$Month=='1' & data$DayofMonth=='1', ])

filter(data,Month=='1' & data$DayofMonth=='1') #DPLYR approach

#Using Pipe
head(data)
filter(data,data$FlightNum=='428' | data$UniqueCarrier=="A") #DPLYR approach

## Q: Shown only FlightNum and DepTime

#Use SELECT
# use colon to select multiple contiguous columns, and use `contains` to match columns by name
# note: `starts_with`, `ends_with`, and `matches` (for regular expressions) can also be used to match columns by name
select(data, DepTime, ArrTime)
select(flights, Year:DayofMonth, contains("Taxi"), contains("Delay"))
select(flights, DepTime:AirTime)
select(flights, DepTime:AirTime,starts_with('Dest'))

#Chaining USE OF %>%
# Find Flight Num and Arrival times for Dest==ABQ on 10th February
 
data %>% select(FlightNum) %>% filter(Dest=='ABQ') #Note Error

data %>% select(FlightNum,Dest,ArrTime,Month,DayofMonth) %>% filter(Dest=='ABQ' & Month=='2' & DayofMonth=='10')
data %>% select(FlightNum,Dest,ArrTime,Month,DayofMonth,Distance,TaxiOut ) %>% group_by(min(TaxiOut))

#Arrange

data %>% select(FlightNum,DepTime,ArrTime,DayofMonth,Month,Origin,Dest) %>% filter(DayofMonth=="19" & Month=='2' & Origin=='HOU'& Dest=='JFK')

data %>% select(FlightNum,DepTime,ArrTime,DayofMonth,Month,Origin,Dest) %>% filter(DayofMonth=="14" & Month=='2' & Origin=='HOU'& Dest=='JFK') %>% arrange(desc(ArrTime))

#Mutate (creating a new column)
data %>% select(FlightNum,DepTime,ArrTime,DayofMonth,Month,Origin,Dest, Distance,AirTime) %>% filter(DayofMonth=="14" & Month=='2' & Origin=='HOU'& Dest=='JFK') %>%  mutate(Speed=Distance/AirTime) #Note it does not add the new coulmn to data unless assigned

#summarize : Used for getting mean, max etc of a group

## Find avg AirTime for a Houston - Newyork flight
data %>% select(Origin,Dest,AirTime) %>% mutate(Route=paste(Origin,"-",Dest)) %>% group_by(Route) %>% summarize(Avg_Travel=mean(AirTime,na.rm = T)) %>% filter(Route=="IAH - DFW")

#Summarize_each
# Q:For each carrier, calculate the percentage of flights cancelled or diverted
data %>% select(UniqueCarrier,Cancelled,Diverted) %>% group_by(UniqueCarrier) %>% summarize_each(funs(mean),Cancelled,Diverted)

unique(data$UniqueCarrier)

#identify avg delay for f9 airlines
data %>% select(UniqueCarrier,Cancelled) %>% group_by(UniqueCarrier) %>% summarize(Total_can=sum(Cancelled)) %>% filter(UniqueCarrier=='F9')

data %>% select(UniqueCarrier,Cancelled) %>% group_by(UniqueCarrier) %>% summarize(Total_can=sum(Cancelled)) %>% filter(Total_can==min(Total_can))

