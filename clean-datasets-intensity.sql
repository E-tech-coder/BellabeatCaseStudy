-- Clean dataset intensity_daily
-- 1.Use the following syntax to check if there is any null data in each column.

SELECT * 
from intensity_daily
where VeryActiveDistance IS Null


-- After checking, there is no NULL value in this dataset.

-- 2. Check if the number of unique Id is correct.


SELECT count(DISTINCT Id)
from intensity_daily


-- The number returned is 33, which is correct and consistent with other datasets.

-- 3. Check if the data range is reasonable. We can't set a limit on the distance, but we know that the sum of 
-- the number of minutes in the four columns should equal to the minutes of a day, which is 24*60 = 1440.


SELECT 
	Id, 
	ActivityDay, 
	(SedentaryMinutes + LightlyActiveMinutes + FairlyActiveMinutes + VeryActiveMinutes) As Total_min,
    count(*) AS Count_min_amount
FROM intensity_daily
group by Total_min
Order by Total_min


-- From the result, we can see that only 478 records out of 940 records have a correct sum of total minutes in a day,
-- which is 1440 minutes. Other records don't have a complete measurement of the intensity level of each minute 
-- in a day of the user.

-- 4. Transform the datatype of ActivityDay from text to Date. And sort out the dataset based
-- on the activity date.


SELECT *
from intensity_daily
Order by CAST(ActivityDay AS DATE)


-- 5. check the date range

select MIN(str_to_date(ActivityDay,'%m/%d/%Y')), MAX(str_to_date(ActivityDay,'%m/%d/%Y'))
from intensity_daily

-- from the result we can see that the date range is from 2016-04-12 to 2016-05-12

-- 6. Check how many observations each Id has

WITH Count_Id_Daily AS (
SELECT Id, count(Id) as ObservationPerId
from intensity_daily
group by Id 
)
SELECT ObservationPerId, count(*)
from Count_Id_Daily 
group by ObservationPerId
order by count(*) DESC

-- Only 21 users have provided a full set of 31 records. 
-- Completeness level of this dataset is 91.89 %. (940 rows/ (33 Ids * 31 days))

-- Conclusion:
-- This intense_daily dataset contains the activity level of 33 users in each day measured by the 
-- activity level of the minutes and the distance travelled from April 12 th 2016 to May 12th 2016.
-- But this dataset is very incomplete because only around half of the observations have the full record 
-- of activity level of the 1440 minutes in a day. And only the observation for one month is recorded.
-- Completeness level of this dataset is 91.89 %.

-- Arrang the dataset by Activity Day and Id , and then export the cleaned dataset.

SELECT * 
FROM intensity_daily
ORDER BY Id, str_to_date(ActivityDay,'%m/%d/%Y')


-- Clean dataset intensity_hourly

-- 1.Use the following syntax to check if there is any null data in each column.


SELECT * 
from intensity_hourly
where AverageIntensity IS Null


-- After checking, there is no NULL value in this dataset.

-- 2. Check if the number of unique Id is correct.


SELECT count(DISTINCT Id)
from intensity_hourly


-- The number returned is 33, which is correct and consistent with other datasets.

-- 3. Check the data range


SELECT MAX(TotalIntensity), MIN(TotalIntensity), MAX(AverageIntensity), MIN(AverageIntensity)
from intensity_hourly


-- The Maximum and minimum of toal intensity is 180 and 0.
-- The Maximum and minimum if Average intensity is 3 and 0.

-- 4. Check the type of datetime and the its range.


select str_to_date(ActivityHour, "%c/%e/%Y %I:%i:%S")
from intensity_hourly


-- 5. Transform ActivityHour from the string format into a datetime format

WITH Temp_table AS (
select Id,ActivityHour, TotalIntensity,AverageIntensity,
CASE 
    WHEN RIGHT(ActivityHour,2) = "PM" THEN DATE_ADD(str_to_date(ActivityHour,"%c/%e/%Y %I:%i:%S"), INTERVAL 12 HOUR)
    ELSE str_to_date(ActivityHour, "%c/%e/%Y %I:%i:%S")
END AS Activity_Datetime
from intensity_hourly)

SELECT MAX(Activity_Datetime), MIN(Activity_Datetime)
FROM Temp_table

-- It shows that the datetime range of this dataset is 
-- from 2016-04-12 00:00:00 to 2016-05-12 15:00:00

-- 6. Check how many observations each Id has

WITH Count_Id_Hourly AS (
SELECT Id, count(Id) as ObservationPerId
from intensity_hourly
group by Id 
)
SELECT ObservationPerId, count(*)
from Count_Id_Hourly
group by ObservationPerId
order by count(*) DESC


-- Only 6 users have provided a full set of 736 records,6 others have 735 records. Others have less than that.
-- Completeness level of this dataset is 90.99 %. (22099 rows/ (33 Ids * 736))

-- Concluson:
-- This dataset "intensity_hourly" contains the total intensity per day and the average intensity per minute
-- in a day of those 33 fitbit users from 2016-04-12 00:00:00 to 2016-05-12 15:00:00.
-- Completeness level of this dataset is 90.99 %.

-- Arrange the dataset by Activity Hour and Id, and then export the cleaned dataset.

SELECT * 
FROM intensity_hourly
ORDER BY Id, str_to_date(ActivityHour, "%c/%e/%Y %I:%i:%S")





