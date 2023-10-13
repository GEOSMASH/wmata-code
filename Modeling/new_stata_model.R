library(readxl)
library(lme4)
library(lmerTest)
library(car)
library(tidyverse)
library(data.table)

# Read in the data frames of complied variables in each time period
amdata <- read.csv("Outputs/am_dataframe_new2.csv")
pmdata <- read.csv("Outputs/pm_dataframe_new2.csv")
offdata <- read.csv("Outputs/off_dataframe_new2.csv")


### AM Model ###

#Remove Arlington and Reagan Stations
amdata <- amdata[!(amdata$O == "Arlington Cemetery" |amdata$D == "Arlington Cemetery"|amdata$O == "Ronald Reagan Washington National Airport" |amdata$D == "Ronald Reagan Washington National Airport"),]

#Run the Model
modelam <- lmer(log_riders_miles ~ log_peak_fare_per_mile + 
                  log_auto_tt_per_mile_2 + log_bus_tt_per_mile + log_parking_user  + terminal_dummy_2023_D + 
                       log_PARKING_CAPACITY_O + log_bus_line_count_O + log_proportionhouses_O + 
                       log_distance_to_core_O + log_All_Jobs_D+log_AVG_TRAINS_D +
                  log_bus_line_count_D +  (1 | ID_O)+(1 | ID_D),
               data = amdata)
#Print the Summary
summary(modelam)

#get r2 value by squaring the correlation between predicted and actual rider miles
example <- summary(modelam)
amdata$pred_pmt <- example$coefficients[1] + (example$coefficients[2]*amdata$log_peak_fare_per_mile) + (example$coefficients[3]*amdata$log_auto_tt_per_mile_2) + (example$coefficients[4]*amdata$log_bus_tt_per_mile) +
  (example$coefficients[5] *amdata$log_parking_user) +  (example$coefficients[6]*amdata$terminal_dummy_2023_D) +
+  (example$coefficients[7]*amdata$log_PARKING_CAPACITY_O)+(example$coefficients[8]*amdata$log_bus_line_count_O)+
  (example$coefficients[9] * amdata$log_proportionhouses_O) + (example$coefficients[10] * amdata$log_distance_to_core_O) + (example$coefficients[11] *amdata$log_All_Jobs_D) + (example$coefficients[12]*amdata$log_AVG_TRAINS_D) + 
  (example$coefficients[13]*amdata$log_bus_line_count_D)
(cor(amdata$pred_pmt, amdata$log_riders_miles, use="complete.obs"))^2

# Get r2 value via the MuMIn package
MuMIn::r.squaredGLMM(modelam)

#Save the coefficients in a table
ammodel_df <- data.table(coef(summary(modelam)), keep.rownames = 'term')
setDF(ammodel_df)
ammodel_df
write.csv(ammodel_df, "am_modeltable.csv", row.names=FALSE)



### PM Model ###

# Remove Arlington and Regan Stations
pmdata <- pmdata[!(pmdata$O == "Arlington Cemetery" |pmdata$D == "Arlington Cemetery"|pmdata$O == "Ronald Reagan Washington National Airport" |pmdata$D == "Ronald Reagan Washington National Airport"),]

#Run the PM Model
model_pm <- lmer(log_riders_miles ~ log_peak_fare_per_mile + 
                   log_new_auto_tt_per_mile2 + log_bus_tt_per_mile +
                   log_parking_user+log_All_Jobs_O +log_bus_line_count_O +
                   log_proportionhouses_D + 
                    log_bus_line_count_D  + terminal_dummy_2023_O + terminal_dummy_2023_D +
                   (1 | ID_O)+(1 | ID_D),
                 data = pmdata)
#Print the results
summary(model_pm)

#get r2 value by squaring the correlation between predicted and actual rider miles
example <- summary(model_pm)
pmdata$pred_pmt <- example$coefficients[1] + (example$coefficients[2]*pmdata$log_peak_fare_per_mile) + (example$coefficients[3]*pmdata$log_new_auto_tt_per_mile2) + (example$coefficients[4]*pmdata$log_bus_tt_per_mile) +
  (example$coefficients[5] *pmdata$log_parking_user) + (example$coefficients[6] * pmdata$log_All_Jobs_O) + (example$coefficients[7] * pmdata$log_bus_line_count_O) + (example$coefficients[8]*pmdata$log_proportionhouses_D) +
  (example$coefficients[9] * pmdata$log_bus_line_count_D) + (example$coefficients[10]*pmdata$terminal_dummy_2023_O) +(example$coefficients[11]*pmdata$terminal_dummy_2023_D) 
(cor(pmdata$pred_pmt, pmdata$log_riders_miles, use="complete.obs"))^2

# Get r2 value via the MuMIn package
MuMIn::r.squaredGLMM(model_pm)

#Save the results in a table
pmmodel_df <- data.table(coef(summary(model_pm)), keep.rownames = 'term')
setDF(pmmodel_df)
pmmodel_df
write.csv(pmmodel_df, "pm_modeltable.csv", row.names=FALSE)


### Off Peak Model ###

# Remove Arlington and Regan Stations
offdata <- offdata[!(offdata$O == "Arlington Cemetery" |offdata$D == "Arlington Cemetery"|offdata$O == "Ronald Reagan Washington National Airport" |offdata$D == "Ronald Reagan Washington National Airport"),]

#Run the model
model_OFF1 <- lmer(log_riders_miles ~ log_off_peak_fare_per_mile + 
                    log_new_auto_tt_per_mile2 + log_parking_user+
                    log_proportionhouses_O + log_bus_line_count_O +log_proportionhouses_D +
                     `log_Proportion.night.weekend.jobs_D` +log_bus_line_count_D + `log_Median.household.income_D` + 
                    terminal_dummy_2023_O + terminal_dummy_2023_D +
                    
                    
                    (1 | ID_O)+(1 | ID_D),
                  data = offdata) 
#Print the results
summary(model_OFF1)

#get r2 value by squaring the correlation between predicted and actual rider miles
example <- summary(model_OFF1)
offdata$pred_pmt <- example$coefficients[1] + (example$coefficients[2]*offdata$log_off_peak_fare_per_mile) + (example$coefficients[3]*offdata$log_new_auto_tt_per_mile2) + 
  (example$coefficients[4] *offdata$log_parking_user) +  (example$coefficients[5] * offdata$log_proportionhouses_O) +(example$coefficients[6]*offdata$log_bus_line_count_O ) +
  (example$coefficients[7] * offdata$log_proportionhouses_D) + (example$coefficients[8] * offdata$log_Proportion.night.weekend.jobs_D) + (example$coefficients[9]*offdata$log_bus_line_count_D) +
  (example$coefficients[10] * offdata$log_Median.household.income_D) +
  (example$coefficients[11]*offdata$terminal_dummy_2023_O) +(example$coefficients[12]*offdata$terminal_dummy_2023_D) 
(cor(offdata$pred_pmt, offdata$log_riders_miles, use="complete.obs"))^2

# Get r2 value via the MuMIn package
MuMIn::r.squaredGLMM(model_OFF1)

#Save the results in a table
offmodel_df <- data.table(coef(summary(model_OFF1)), keep.rownames = 'term')
setDF(offmodel_df)
offmodel_df
write.csv(offmodel_df, "off_modeltable.csv", row.names=FALSE)

#######################################################################################
#VIFS

##### VIF #####

vif(modelam)

vif(model_pm)

vif(model_OFF1)


#################################################################################################################################
##Old Model Results##


oldam <- read_excel("../Data/Inputs/100_AM_Peak_Other_Regular_Riders.xlsx")
oldpm <- read_excel("../Data/Inputs/200_PMPeak_Model_Long_file.xlsx")
oldoff <- read_excel("../Data/Inputs/300_OffPeak_Other_Regular_Riders.xlsx")
termstat <- read_csv("../Data/Inputs/metro_ternimal_dummy.csv")

### AM Model ###

#merge terminal stations
termstat$MSTN <- str_replace_all(termstat$MSTN, '[A-Z]{4}_0', '')
termstat$MSTN <- str_remove(termstat$MSTN, "^0+")
term2 <- termstat[, c('MSTN', 'terminal_dummy_2015')]
term2[is.na(term2)] <- 0

oldam <- merge(oldam, term2, by.x='mstn_id_o', by.y='MSTN', all.x=TRUE )
oldam <- merge(oldam, term2, by.x='mstn_id_d', by.y='MSTN', all.x=TRUE )

#Run the model
model_oldam <- lmer(log_rider_mile_track ~ log_peak_fare_per_mile_track +
                 log_auto_tt_per_mile + log_bus_tt_per_mile +
                log_parking_users +
                 terminal_dummy_2015.y +
                 log_ParkingCapacityNew_O + log_buslinescount_O +
                 logHouseholds000050milesUp_O + logMilesfromCore_O +
                 logjobshalfUp_D + log_tphpeakv2_D + log_buslinescount_D +
                 (1 | mstn_id_d)+(1 | mstn_id_o),
               data = oldam)

#Print the results
summary(model_oldam)


example <- summary(model_oldam)
oldam$pred_pmt <- example$coefficients[1] + (example$coefficients[2]*oldam$log_peak_fare_per_mile_track) + (example$coefficients[3]*oldam$log_auto_tt_per_mile) + (example$coefficients[4]*oldam$log_bus_tt_per_mile) +
  (example$coefficients[5] *oldam$log_parking_users) +  (example$coefficients[6]*oldam$terminal_dummy_2015.y) +  (example$coefficients[7]*oldam$log_ParkingCapacityNew_O)+(example$coefficients[8]*oldam$log_buslinescount_O)+
  (example$coefficients[9] * oldam$logHouseholds000050milesUp_O) + (example$coefficients[10] * oldam$logMilesfromCore_O) + (example$coefficients[11] *oldam$logjobshalfUp_D) + (example$coefficients[12]*oldam$log_tphpeakv2_D) + (example$coefficients[13]*oldam$log_buslinescount_D)
(cor(oldam$pred_pmt, oldam$log_rider_mile_track, use="complete.obs"))^2

# Get r2 value via the MuMIn package
MuMIn::r.squaredGLMM(mode1_oldam)



### PM Model ###

#merge terminal stations
oldpm <- merge(oldpm, term2, by.x='mstn_id_o', by.y='MSTN', all.x=TRUE )
oldpm <- merge(oldpm, term2, by.x='mstn_id_d', by.y='MSTN', all.x=TRUE )

#Run the Model
model_oldpm <- lmer(log_rider_mile_track ~ log_peak_fare_per_mile_track + log_PMautoTT_per_mile_track + log_bus_tt_per_mile_track + 
                  log_parking_users+ logjobshalfUp_O + log_buslinescount_O + logHouseholds000050milesUp_D +
                   + log_buslinescount_D + terminal_dummy_2015.x +terminal_dummy_2015.y +
                   (1 | mstn_id_d)+(1 | mstn_id_o),
                 data = oldpm)

#Print the results
summary(model_oldpm)

#get r2 value by squaring the correlation between predicted and actual rider miles
example <- summary(model_oldpm)
oldpm$pred_pmt <- example$coefficients[1] + (example$coefficients[2]*oldpm$log_peak_fare_per_mile_track) + (example$coefficients[3]*oldpm$PMautoTT_per_mile_track) + (example$coefficients[4]*oldpm$log_bus_tt_per_mile) +
  (example$coefficients[5] *oldpm$log_parking_users) + (example$coefficients[6] * oldpm$logjobshalfUp_O) + (example$coefficients[7] * oldpm$log_buslinescount_O) + (example$coefficients[8]*oldpm$logHouseholds000050milesUp_D) +
  (example$coefficients[9] * oldpm$log_buslinescount_D) + (example$coefficients[10]*oldpm$terminal_dummy_2015.x) +(example$coefficients[11]*oldpm$terminal_dummy_2015.y) 
(cor(oldpm$pred_pmt, oldpm$log_rider_mile_track, use="complete.obs"))^2

# Get r2 value via the MuMIn package
MuMIn::r.squaredGLMM(model_oldpm)


### Off Model ###

#merge terminal stations
oldoff <- merge(oldpm, term2, by.x='mstn_id_o', by.y='MSTN', all.x=TRUE )
oldoff <- merge(oldpm, term2, by.x='mstn_id_d', by.y='MSTN', all.x=TRUE )

#Run the model
model_oldpff <- lmer(log_rider_mile_track ~ log_off_peak_fare_per_mile_track + log_auto_tt_per_mile  +
                     log_parking_users + logHouseholds000050milesUp_O + log_buslinescount_O +
                    +logHouseholds000050milesUp_D+ logNightsAndWeekendsJobsUp_D +
                    log_buslinescount_D + logMedianHHIncome_D1 + terminal_dummy_2015.x +terminal_dummy_2015.y +
                    (1 | mstn_id_d)+(1 | mstn_id_o),
                  data = oldoff) 

#Print the results
summary(model_oldoff)

#get r2 value by squaring the correlation between predicted and actual rider miles
example <- summary(model_oldoff)
oldoff$pred_pmt <- example$coefficients[1] + (example$coefficients[2]*oldoff$log_off_peak_fare_per_mile_track) + (example$coefficients[3]*oldoff$log_auto_tt_per_mile) + 
  (example$coefficients[4] *oldoff$log_parking_users) +  (example$coefficients[5] * oldoff$logHouseholds000050milesUp_O) +(example$coefficients[6]*oldoff$log_buslinescount_O) +
  (example$coefficients[7] * oldoff$logHouseholds000050milesUp_D) + (example$coefficients[8] * oldoff$logNightsAndWeekendsJobsUp_D) + (example$coefficients[9]*oldoff$log_buslinescount_D) +
  (example$coefficients[10] * oldoff$logMedianHHIncome_D1) + (example$coefficients[11]*oldoff$terminal_dummy_2015.x) +(example$coefficients[12]*oldoff$terminal_dummy_2015.y) 
(cor(oldoff$pred_pmt, oldoff$log_rider_mile_track, use="complete.obs"))^2


# Get r2 value via the MuMIn package
MuMIn::r.squaredGLMM(model_oldoff)
