# Clean the datasets

# Calories
calories_hourly <- read.csv("Calories/hourlyCalories_merged.csv")
calories_daily <- read.csv("Calories/dailyCalories_merged.csv")
calories_daily <- as.data.frame(calories_daily)
calories_hourly <- as.data.frame(calories_hourly)

# 1.Null data
colnames(calories_hourly)

calories_hourly %>%
  filter(is.na(calories_hourly$ActivityHour))

calories_hourly %>%
  filter(is.na(calories_hourly$Id))

calories_hourly %>%
  filter(is.na(calories_hourly$Calories))

# There is no NULL data in calories_hourly.

# 2. See the number of Id 
length(calories_hourly$Id[!duplicated(calories_hourly$Id)])

# 3. Check if the data range is reasonable

min(calories_hourly$Calories)
max(calories_hourly$Calories)

min(calories_hourly$ActivityHour)
max(calories_hourly$ActivityHour)

# 4. check data type
typeof(calories_hourly$ActivityHour)
typeof(calories_hourly$Id)  
typeof(calories_hourly$Calories)

# 5. Transform the data type into a correct data format

library(lubridate)
calories_hourly <- calories_hourly %>% arrange(mdy_hms(calories_hourly$ActivityHour)) %>%
  arrange(Id)

View(calories_hourly)

min(mdy_hms(calories_hourly$ActivityHour))
max(mdy_hms(calories_hourly$ActivityHour))

# 6. See if there's any duplicated row

calories_hourly[duplicated(calories_hourly),]

# There is no duplicated row in this dataset.

# 7. Check how many observations each user has provided.

Id_count <- calories_hourly %>%
  group_by(Id) %>%
  count()

View(Id_count %>% group_by(n) %>% count())

# There are only 6 users who have provided a full set of 736 obsservations. And 6 others provided more than
# 700 observations. 
# The completeness level of this dataset is 90.99 %. (22099 rows/ (33 Ids * 736))

# Now we know that this dataset contains the calories burned of 33 Fitbit users in each hour from 2016-04-12 00:00:00 to
# 2016-05-12 15:00:00.The completeness level of this dataset is 90.99 %.

# To save my cleaned datasets into a CSV file.
write.csv(calories_hourly, file = "calories_hourly_cleaned.csv")

# Now I will perform the same cleaning process for another dataset : calories_daily

# 1.Null data
colnames(calories_daily)

calories_daily %>%
  filter(is.na(calories_daily$ActivityDay))

calories_daily %>%
  filter(is.na(calories_daily$Id))

calories_daily %>%
  filter(is.na(calories_daily$Calories))

# There is no NULL data in calories_daily.

# 2. See the number of Id 

length(calories_daily$Id[!duplicated(calories_daily$Id)])

# we have 33 distinct Id involved in this study, which is consistent with the Id number in other datasets.

# 3. Check if the data range is reasonable

min(calories_daily$Calories)
max(calories_daily$Calories)

min(calories_daily$ActivityDay)
max(calories_daily$ActivityDay)

# 4. check data type
typeof(calories_daily$ActivityDay)
typeof(calories_daily$Id)  
typeof(calories_daily$Calories)

# 5. Transform the data type into a correct data format

library(lubridate)
calories_daily <- calories_daily %>% arrange(mdy(calories_daily$ActivityDay)) %>% arrange(Id)

View(calories_daily)


min(mdy(calories_daily$ActivityDay))
max(mdy(calories_daily$ActivityDay))

# 6.Check how many observations each user has provided.

Id_count_daily <- calories_daily %>%
  group_by(Id) %>%
  count()

View(Id_count_daily %>% group_by(n) %>% count())

# 21 Fitbit users have provided the full set of 31 days of observations.
# The completeness level of this dataset is 91.89%.(940 rows/(33 Ids *31))

# Now we know that this dataset contains the calories burned of 33 Fitbit users on each day 
# from 2016-04-12 to 2016-05-12.The completeness level of this dataset is 91.89%.

write.csv(calories_daily,file = "calories_daily_cleaned.csv")





