# Clean and organize the dataset heartrate_second

heartrate_second <- as.data.frame(read.csv("heartrate_seconds_merged.csv"))

glimpse(heartrate_second)

# 1.Transform the dataset that shows the average heartrate each five seconds into a dataset
# that shows the average heart rate each hour for future analysis.

heartrate_hour <- heartrate_second %>% 
  mutate(HOUR = hour(mdy_hms(Time))) %>%
  group_by(Id, Date = date(mdy_hms(Time)), HOUR) %>%
  dplyr::summarise(avg_heartrate_hour = mean(Value)) %>%
  as.data.frame() %>%
  arrange(Id,Date)


heartrate_hour <- unite(heartrate_hour,"Datetime",Date,HOUR, sep = " ")

heartrate_hour$Datetime <- paste0(heartrate_hour$Datetime,":00:00")

heartrate_hour$avg_heartrate_hour <- round(heartrate_hour$avg_heartrate_hour, digits = 0)

View(heartrate_hour)

# 2. Check NULL data

heartrate_hour[is.null(heartrate_hour),]

# Zero row of null data in the dataset.

# 3.Check if tehre is any duplicated row

heartrate_hour[duplicated(heartrate_hour),]

# Zero duplicated row in the heartrate_hour dataset.

# 4.Check how many unique Ids there are in the dataset.

length(heartrate_hour$Id[!duplicated(heartrate_hour$Id)])

# There are only data from 14 Ids in this dataset，which is incomplete and inconsistent from other datasets.

# Check the data range of the Datetime column and the avg_heartrate_hour column.

max(ymd_hms(heartrate_hour$Datetime))
min(ymd_hms(heartrate_hour$Datetime))

max(heartrate_hour$avg_heartrate_hour)
min(heartrate_hour$avg_heartrate_hour)

# The datetime range of this dataset is from 2016-04-12 00:00:00 to 2016-05-12 16:00:00.
# There is an interval of 736 hours in between.
# The value range of the heartrate_hour column is from 43 to 162.

# 5.Check how many observation each Id has.

heartrate_hour %>%
  group_by(Id) %>%
  count() %>%
  arrange(n)

# From the result we can see that each Id provided different number of observations.
# The completeness level of this dataset is 58.36% (6013 rows/(736 hours *14 Ids).

# Conclusion:
# This heartrate_hour dateset contains the average heart rate per hour of the 14 Fitbit users in this study from
# 2016-04-12 00:00:00 to 2016-05-12 16:00:00. But the dataset is very incomplete. 
# The complete level of this dataset is 58.36%

write.csv(heartrate_hour, file = "heartrate_hour_cleaned.csv")
