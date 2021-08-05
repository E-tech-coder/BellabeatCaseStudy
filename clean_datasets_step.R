# Clean datasets of the  category steps

# steps_daily

steps_daily <- as.data.frame(read.csv("Steps/dailySteps_merged.csv"))

# 1.Get an overview of the data structure and its content

head(steps_daily)
str(steps_daily)

# 2.Check how mand Ids are involved in this dataset to see if the number is consistent with other datasets 
# and the dataset is complete.

length(steps_daily$Id[!duplicated(steps_daily$Id)])

# The result returned is 33, which is the correct number.

# 2.Check if there is any NULLL data.

steps_daily$Id[is.na(steps_daily$Id)]
steps_daily$ActivityDay[is.na(steps_daily$ActivityDay)]
steps_daily$StepTotal[is.na(steps_daily$StepTotal)]

# No NULL data in this dataset.

# 3.Check the data range of the StepTotal columnn

max(steps_daily$StepTotal)
min(steps_daily$StepTotal)

# The value range of the StepTotal column is from 0 to 36019.

# 4. Convert the ActivityDay column format from characters to Date and check out the date range.

max(mdy(steps_daily$ActivityDay))
min(mdy(steps_daily$ActivityDay))

# The date range of this dataset is from 2016-04-12 to 2016-05-12.

# 5. Check if each Id has submitted their records every day, whether this data set is complete.

count_daily <- steps_daily %>%
  group_by(Id) %>%
  count()

count_daily %>% group_by(n) %>% count()

# From the result we can see that only 21 users have a full set of 31 observations, and 3 have 30 records.
# Others have less than 30 records and the least one is 4. 
# The comleteness of the dataset is 91.89% (940 observations /(31*33 Ids ))

steps_daily_cleaned <- steps_daily %>% arrange(mdy(ActivityDay)) %>% arrange(Id)
write.csv(steps_daily_cleaned, file = "steps_daily_cleaned.csv")

# Conclusion:
# The steps_daily dataset contains data of the steps taken by each of the 33 Fitbit users each 
# day from 2016-04-12 to 2016-05-12.
# But the dataset is incomplete. It has a completeness level of 91.89%.


# steps_hourly

steps_hourly <- as.data.frame(read.csv("Steps/hourlySteps_merged.csv"))

# 1.Get an overview of the data structure and its content

glimpse(steps_hourly)
str(steps_hourly)

# 2.Check if there is any NULLL data.

steps_hourly$Id[is.na(steps_hourly)]
steps_hourly$ActivityHour[is.na(steps_hourly$ActivityHour)]
steps_hourly$StepTotal[is.na(steps_hourly$StepTotal)]

#No NULL data in this dataset.

# 3.Check the data range of the StepTotal column.

max(steps_hourly$StepTotal)
min(steps_hourly$StepTotal)

# The maximum number in the StepTotal column is 10554 and the minimum is 0.

# 4. Since the ActivityHour column now is in the string format, we need to 
# convert it into a datetime format and figure our the datetime range.

max(mdy_hms(steps_hourly$ActivityHour))
min(mdy_hms(steps_hourly$ActivityHour))

# The datetime range in this dataset is from 2016-04-12 00:00:00 to 2016-05-12 15:00:00.

# 5. Check if the dataset is complete, whether if Id has a complete steps record for each hour
# during 2016-04-12 00:00:00 to 2016-05-12 15:00:00

Id_count <- steps_hourly %>%
  group_by(Id) %>%
  count()

# To see the completeness of the records of each Id

Id_count %>% group_by(n) %>% count()

# From the result we can see that only 6 users have a complete set of record, which should be 736 
# observations. And 6 others have 735 observations, 11 users have more than 700 observations.
# And  6 users have more than 600 but less than 700 observations. 2 users have 414 and 431 records
# respectively and 1 user has only submitted 88 observations.
# The completeness ratio of this dataset is 90.99% (22099 columns/(736*33 Id))

glimpse(steps_hourly)

steps_hourly_cleaned <- steps_hourly %>% arrange(ActivityHour) %>% arrange(Id)

write.csv(steps_hourly_cleaned, file = "steps_hourly_cleaned.csv")

# Conclusion: 
# The steps_hourly dataset contains data of the steps taken by each of the 33 Fitbit users each 
# hour during 2016-04-12 00:00:00 and 2016-05-12 15:00:00. But the dataset is not complete. It has 
# a completeness level of 90.99% 
