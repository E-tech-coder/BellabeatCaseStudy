glimpse(intensity_daily_cleaned)

# Calculate the average value of each column per person daily

avg_intensity_daily <- intensity_daily_cleaned %>%
  group_by(day = mdy(ActivityDay)) %>%
  summarise(avg_sedantary_min = round(mean(SedentaryMinutes),2),
            avg_lightlyactive_min = round(mean(LightlyActiveMinutes),2),
            avg_fairlyactive_min = round(mean(FairlyActiveMinutes),2),
            avg_veryactive_min = round(mean(VeryActiveMinutes),2),
            avg_sedantary_distance = round(mean(SedentaryActiveDistance), 2),
            avg_lightlyactive_distance = round(mean(LightActiveDistance), 2),
            avg_moderatelyactive_distance = round(mean(ModeratelyActiveDistance), 2),
            avg_veryactive_distance = round(mean(VeryActiveDistance), 2))

glimpse(avg_intensity_daily)

avg_intensity_daily_long <- melt(avg_intensity_daily, id = "day")

write.csv(avg_intensity_daily_long, file = "avg_intensity_daily_long.csv")

glimpse(avg_intensity_daily_long)

colnames(avg_intensity_daily)

activity_minutes <- ggplot(data = avg_intensity_daily_long %>% 
         filter(variable %in% c("day","avg_sedantary_min" ,"avg_lightlyactive_min","avg_veryactive_min","avg_fairlyactive_min"))) + 
  geom_point(mapping = aes(x = day, y = value, color = variable)) +
  labs(title = "Minutes tracked in a day at different activity levels",
       subtitle = "Data on average per person each day in the month",
       y = "Minutes",x = "Date") +
  scale_x_date(date_labels = "%m-%d") +
  scale_y_continuous(breaks = seq(0, 1000, by = 100))
  # theme(legend.position = "bottom")

activity_minutes

###########################################################################################


activity_distance <- ggplot(data = avg_intensity_daily_long %>% 
         filter(variable %in% 
                  c("day","avg_sedantary_distance",
                    "avg_lightlyactive_distance",
                    "avg_moderatelyactive_distance","avg_veryactive_distance"))) + 
  geom_point(mapping = aes(x = day, y = value, color = variable)) + 
  labs(title = "Distance tracked in a day at different activity levels",
       subtitle = "Data on average per person each day in the month",
       y = "Distance",x = "Date") + 
  scale_x_date(date_labels = "%m-%d") +
  scale_y_continuous(breaks = seq(0,4.5, by = 0.5))
  # theme(legend.position = "bottom")

activity_distance

glimpse(avg_intensity_daily_long)

##################################################################################

VeryFairly_activity_minutes <- ggplot(data = avg_intensity_daily_long %>% 
                             filter(variable %in% c("day","avg_veryactive_min","avg_fairlyactive_min"))) + 
  geom_line(mapping = aes(x = day, y = value, color = variable)) +
  labs(title = "Fairly active and very active minutes tracked in a day",
       subtitle = "Data on average per person each day in the month",
       y = "Minutes",x = "Date") +
  scale_x_date(date_labels = "%m-%d") + scale_y_continuous(breaks = seq(0,50,by = 5))
# theme(legend.position = "bottom")

VeryFairly_activity_minutes

?geom_smooth
