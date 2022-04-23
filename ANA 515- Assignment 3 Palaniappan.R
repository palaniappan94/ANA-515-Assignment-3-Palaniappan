#Question 1

getwd()
library(tidyverse)
stromevents <- read.csv("StormEvents_details-ftp_v1.0_d1994_c20210803.csv")

#Question 2
myvars <-c("BEGIN_DATE_TIME","END_DATE_TIME","EPISODE_ID","EVENT_ID","STATE","STATE_FIPS","CZ_NAME","CZ_TYPE","CZ_FIPS","EVENT_TYPE","SOURCE","BEGIN_LAT","BEGIN_LON","END_LAT","END_LON")
newdata <- stromevents[myvars]
head(newdata,6)

#Question 3
library(dplyr)
arrange(stromevents, BEGIN_YEARMONTH)

#Question 4
myvars <-c("STATE", "CZ_NAME")
newdata1 <- stromevents[myvars]
str_to_title(newdata1)


#QUestion 5
filter(stromevents, CZ_TYPE == 'C')
select(stromevents,-c(CZ_TYPE))

#Question 6
str_pad(newdata$STATE_FIPS, width=3, side = "left", pad = "0")
unite(newdata, "fips",c("STATE_FIPS","CZ_FIPS"), sep = "", remove = TRUE, na.rm = FALSE)

#Question 7
rename_all(newdata, tolower)

#Question 8
us_state_info<-data.frame(state = state.name, region = state.region, area = state.area)
view(us_state_info)
head(us_state_info)

#Question 9
Newset<- data.frame(table(newdata$STATE))
head(Newset)

us_state_info1 <- mutate_all(us_state_info, toupper)


newset1<-rename(Newset, c("state"="Var1"))
merged <- merge(x=newset1,y=us_state_info1,by.x="state", by.y="state")
head(merged)

#Question 10
library(ggplot2)
storm_plot <- ggplot(merged, aes(x = area, y = Freq)) + geom_point(aes(color = region)) + labs(x = "Land area (square miles)", y = "# of storm events in 1994")
storm_plot

