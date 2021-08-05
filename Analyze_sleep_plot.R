
Asleep_inbed <- subset(mean_sleep_daily, select = c(Date,avg_minutes_asleep,avg_TimeInBed) )

head(Asleep_inbed)

install.packages("flexdashboard")

###############################################################

Asleep_inbed_long <-
  melt(Asleep_inbed,id = "Date")

sleep_time <- ggplot(data = Asleep_inbed_long, aes(x = Date, y = value, color = variable)) + 
  geom_line() +
  scale_x_date(date_labels = "%m-%d") +
  ylab("Minutes") +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10)) +
  labs(title = "The total time spent in bed and the time spent asleep in bed",
       subtitle = "Average data per person from 2016 April 12th to 2016 May 12th")

sleep_time
###############################################################

Asleep_inbed_2 <- Asleep_inbed %>% mutate(sleep_quality = (avg_minutes_asleep/avg_TimeInBed)*100)

head(Asleep_inbed_2)

sleep_quality <- ggplot(data = Asleep_inbed_2, aes(x = Date, y = sleep_quality))+
  geom_line(color = "purple") +
  scale_x_date(date_labels = "%m-%d") +
  ylab("time asleep/time in bed (%)") +
  labs(title = "The percentage of time alseep to time spent in bed",
       subtitle = "Avergae data per person from 2016 April 12th to 2016 May 12th")

sleep_quality
###############################################################

head(Asleep_inbed)

time_awake <- ggplot(data = Asleep_inbed, aes(y = avg_TimeInBed - avg_minutes_asleep,
                                              x = Date)) + geom_line(color = "blue") +
  scale_x_date(date_labels = "%m-%d") + 
  ylab("Time awake in bed/minuntes") +
  labs(title = "Time spent in bed awake each day",
       subtitle = "Average time per person from 2016 Apr 12th to 2016 May 12th")

time_awake  
###############################################################
