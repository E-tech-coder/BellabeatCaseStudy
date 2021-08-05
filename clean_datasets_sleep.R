# Clean the datasets in the Sleep category

# sleep_daily dataset
# 1.Get an overview of the dataset

str(sleep_daily <- as.data.frame(read.csv("Sleep/sleepDay_merged.csv")))

# 2.Check if there is any NULLL data.

sleep_daily %>%
  filter(is.na(sleep_daily$Id))

sleep_daily %>%
  filter(is.na(sleep_daily$SleepDay))

sleep_daily %>%
  filter(is.na(sleep_daily$TotalSleepRecords))


sleep_daily %>%
  filter(is.na(sleep_daily$TotalMinutesAsleep))

sleep_daily %>%
  filter(is.na(sleep_daily$TotalTimeInBed))

#No NULL data in this dataset.

# 3.Check the data range or data value of the column TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed.

sleep_daily$TotalSleepRecords[!duplicated(sleep_daily$TotalSleepRecords)]

# There are three values : 1,2,3 in the TotalSleepRecords column

max(sleep_daily$TotalMinutesAsleep)
min(sleep_daily$TotalMinutesAsleep)

# The date range of the TotalMinutesAsleep column is from 58 to 796.

max(sleep_daily$TotalTimeInBed)
min(sleep_daily$TotalTimeInBed)

# The data range if the TotalTimeInBed columnn is from 61 to 961.

# 4.Convert the data format of SleepDay from characters to datetime and check the datetime range.

max(mdy_hms(sleep_daily$SleepDay))
min(mdy_hms(sleep_daily$SleepDay))

# The datetime range of this date set is from 2016-04-12 14:00:00 to 2016-05-12 00:00:00.

# The number of unique Ids in this dataset.

length(sleep_daily$Id[!duplicated(sleep_daily$Id)])

# There are 24 Fitbit users involved in this dataset, instead of 33 users in other datasets in this study.

# 5. Check if there is any duplicated row in this dataset.

sleep_daily[duplicated(sleep_daily),]

# There are three duplicated rows that need to be removed in the sleep_daily dataset.

# Conclusion:
# The sleep daily dataset contains the how many times they sleep, how long they stay in bed
# and how long they are really sleeping of each of the 33 Fitbit users each day from 2016-04-12 to 2016-05-12.
# But the completeness of this data set is only around 55.11%.(410 rows/(24 Ids* 31 days))

sleep_daily_cleaned <-
  sleep_daily[!duplicated(sleep_daily),]%>% arrange(mdy_hms(SleepDay)) %>% arrange(Id)

write.csv(sleep_daily_cleaned, file = "sleep_daily_cleaned.csv")

# sleep_minute dataset

# 1.Get an overview of the dataset

sleep_minute <- as.data.frame(read.csv("Sleep/minuteSleep_merged.csv"))

str(sleep_minute)

sleep_minute$value[!duplicated(sleep_minute$value)]

# we can see from the results of the codes above that the sleep_minute dataset contains four 
# columns, which are Id, date, value and logId. And the values in the "value" column is 1,2 and 3.

# But I can't identify the relationship between value and sleep without further explanation of
# the data owner. 
# So I've decided that this dataset won't be used in the analysis this time.