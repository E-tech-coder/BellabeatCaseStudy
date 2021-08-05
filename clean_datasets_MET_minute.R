# Clean the dataset MET_minute

# Get an overview of the data structure and its content

head(MET_minute)
str(MET_minute)

# 1. Check how many Ids are involved in this dataset to see if the number is consistent with other datasets 
# and the dataset is complete.

length(MET_minute$Id[!duplicated(MET_minute$Id)])

# The result returned is 33, which is the correct number.

# 2.Check if there is any NULL data.

MET_minute %>%
  filter(is.na(MET_minute$Id))

MET_minute %>%
  filter(is.na(MET_minute$ActivityMinute))

MET_minute %>%
  filter(is.na(MET_minute$METs))

#No NULL data in this dataset.

# 3.Check the data range of the METs columnn

max(MET_minute$METs)
min(MET_minute$METs)
 
# The value of the METs column ranges from 0 to 157.

# 3. Since the ActivityMinute column now is in the string format, we need to 
# convert it into a datetime format and figure our the datetime range.

max(mdy_hms(MET_minute$ActivityMinute))
min(mdy_hms(MET_minute$ActivityMinute))

# The minimum datetime is 2016-04-12 00:00:00 and the maximum datetime is 2016-05-12 15:59:00.

# 4. Check how many observations each Id has, whether the dataset is complete.

Rows_per_Id <- MET_minute %>% group_by(Id) %>% count() %>% arrange(n)
View(Rows_per_Id %>% group_by(n) %>% count())

# From the result we can see that users have provided different number of observations.
# The completeness level of this data set is 90.96% (1325580 rows/ (44159 minutes * 33 Ids))

# Conclusion:
# The MET_minutes data set contains the observation of the MET value of each of the 33 Fitbit users
# each minute during 2016-04-12 00:00:00 and 2016-05-12 15:59:00.
# The completeness level of this data set is 90.96%

MET_minute_cleaned <- MET_minute %>% arrange(mdy_hms(MET_minute$ActivityMinute)) %>% arrange(Id)
head(MET_minute_cleaned)

write.csv(MET_minute_cleaned, file = "MET_minute_cleaned.csv")


# Fitbit calculates active minutes through a metric called metabolic equivalent of tasks (METs), 
# also sometimes just called metabolic equivalents. 
# METs measure the intensity of a particular physical exercise by comparing against a base rate.

# Create a dataset that counts METs hourly so that it's consistent with other data sets for further analysis.

MET_hourly <- MET_minute_cleaned %>%
  group_by(Id,Date = date(mdy_hms(ActivityMinute)),Hour = hour(mdy_hms(ActivityMinute))) %>%
  summarise(mean(METs))

MET_hourly <- MET_hourly %>%
  unite("Datetime",Date,Hour, sep = " ")

MET_hourly$Datetime <- paste0(MET_hourly$Datetime, ":00:00")

View(MET_hourly)

write.csv(MET_hourly,file = "MET_hourly_cleaned.csv")

