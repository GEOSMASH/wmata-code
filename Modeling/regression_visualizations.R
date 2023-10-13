library(tidyverse)


#data visualizations
off_fare <- data.frame(variable = c("Ln(peak or off-peak fare per track mile)", "Ln(auto travel time per mile)",
                                     "Ln(parking users)","Ln(1,000 households in 0.5 miles) O","Ln(bus line count at station) O", "Terminal Station (0,1) O", "Ln(1,000 households in 0.5 miles) D", "Ln(night and weekend jobs) D", "Ln(bus line count at station) D", "Ln(median household income) D", "Terminal Station (0,1) D", "Ln(peak or off-peak fare per track mile)", "Ln(auto travel time per mile)",
                                     "Ln(parking users)","Ln(1,000 households in 0.5 miles) O","Ln(bus line count at station) O", "Terminal Station (0,1) O", "Ln(1,000 households in 0.5 miles) D", "Ln(night and weekend jobs) D", "Ln(bus line count at station) D", "Ln(median household income) D", "Terminal Station (0,1) D"), coeff = c(-0.430  ,0.354,0.356 ,0.025 ,0.484 ,0.493 ,0.139  ,0.130 ,0.305 ,-0.382 ,0.512 ,-0.410,0.289,0.148, 0.232,0.138, 0.272,0.274,0.007,0.133,-0.075,0.338)
                                  , error=c(0.024 , 0.030 , 0.009 , 0.013 , 0.080 , 0.141 ,0.037 ,0.041, 0.103 , 0.111 , 0.165 ,0.027, 0.034,0.004,0.049,0.033,0.180,0.057,0.017,0.034,0.034,0.186), year=c(2015,
                     2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2023, 2023, 2023, 2023,2023, 2023,2023, 2023, 2023, 2023,2023))

off_fare$upper <- off_fare$coeff+off_fare$error #create upper error bound
off_fare$lower <- off_fare$coeff-off_fare$error #create low error bound
off_fare$variable <- factor(off_fare$variable, levels = unique(off_fare$variable)) #create the variable to a factor so that the variable names stay in the same order


am_fare <- data.frame(variable=c("Ln(peak or off-peak fare per track mile)", "Ln(auto travel time per mile)", "Ln(bus travel time per mile)", "Ln(parking users)", "Ln(1,000 households in 0.5 miles) O", "Ln(parking capacity) O", "Ln(bus line count at station) O","Ln(miles from the core of an origin station) O"
                                 , "Ln(jobs in 0.5 miles) D", "Ln(trains per hour in the peak period) D", "Ln(bus line count at station) D", "Terminal Station (0,1) D", "Ln(peak or off-peak fare per track mile)", "Ln(auto travel time per mile)", "Ln(bus travel time per mile)", "Ln(parking users)", "Ln(1,000 households in 0.5 miles) O", "Ln(parking capacity) O", "Ln(bus line count at station) O","Ln(miles from the core of an origin station) O"
                                 , "Ln(jobs in 0.5 miles) D", "Ln(trains per hour in the peak period) D", "Ln(bus line count at station) D", "Terminal Station (0,1) D"),
                      coeff=c(-0.623  ,0.337  ,0.284 ,0.485 ,0.068, 0.085 ,0.448 ,0.210 ,0.718 ,0.684 ,0.269 , 0.933,-1.012, 0.247, 0.060, 0.129, 0.225, 0.048, 0.106, 0.054, 0.045, 0.773, 0.101, 0.068 ),
                      error=c(0.032,0.047  ,0.043  ,0.023, 0.020 , 0.026 , 0.127 , 0.090 , 0.107  , 0.174 , 0.121  , 0.204, 0.037, 0.046, 0.009, 0.006, 0.072, 0.015, 0.045, 0.040, 0.022, 0.195, 0.044, 0.230),
                      year= c(2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015, 2023,2023,2023,2023,2023,2023,2023,2023,2023,2023,2023,2023))
am_fare$upper <- am_fare$coeff+am_fare$error #create upper error bound
am_fare$lower <- am_fare$coeff-am_fare$error #create low error bound
am_fare$variable <- factor(am_fare$variable, levels = unique(am_fare$variable)) #create the variable to a factor so that the variable names stay in the same order

pm_fare <-data.frame(variable=c("Ln(peak or off-peak fare per track mile)", "Ln(auto travel time per mile)", "Ln(bus travel time per mile)", "Ln(parking users)",
                                "Ln(jobs in 0.5 miles) O" , "Ln(bus line count at station) O", "Terminal Station (0,1) O", "Ln(1,000 households in 0.5 miles) D", "Ln(bus line count at station) D", "Terminal Station (0,1) D", "Ln(peak or off-peak fare per track mile)", "Ln(auto travel time per mile)", "Ln(bus travel time per mile)", "Ln(parking users)",
"Ln(jobs in 0.5 miles) O" , "Ln(bus line count at station) O", "Terminal Station (0,1) O", "Ln(1,000 households in 0.5 miles) D", "Ln(bus line count at station) D", "Terminal Station (0,1) D") ,
                      coeff=c(-0.522  ,0.201  , 0.288  , 0.313, 0.620  ,0.371 , 0.706 , 0.196  ,0.526 ,0.459 ,-0.745,0.178,0.044,0.139,0.060,0.182,-0.189, 0.227,0.106, 0.584),
                      error=c(0.027  ,0.041  ,0.033  ,0.008, 0.085 ,0.103 ,0.171 , 0.041 ,0.094  ,0.169 ,0.032, 0.040, 0.008, 0.004, 0.026, 0.048, 0.268, 0.057, 0.038, 0.208),
                      year=c(2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2023,2023,2023,2023,2023,2023,2023,2023,2023,2023))
pm_fare$upper <- pm_fare$coeff+pm_fare$error #create upper error bound
pm_fare$lower <- pm_fare$coeff-pm_fare$error #create low error bound
pm_fare$variable <- factor(pm_fare$variable, levels = unique(pm_fare$variable)) #create the variable to a factor so that the variable names stay in the same order

off_fare %>%
  ggplot() + 
  geom_segment(aes(y = factor(variable), yend = factor(variable), x = lower, xend = upper,
                   colour = factor(year)), size = 2, alpha=.5) +
  geom_point(aes(y=factor(variable), x=coeff), colour="black", size = 2)+
  geom_vline(xintercept = 0, colour = 'red', linetype=3, size=.75) +
  scale_color_manual(values = c("orange" ,"deepskyblue4" )) +
  facet_grid(variable~., switch = "y") +
  scale_y_discrete(expand = c(0.5, 0.5)) + scale_x_continuous(breaks = round(seq(min(full_fare$lower), max(full_fare$upper), by = 0.2),1)) +
  theme_classic() +
  labs(x = "Coefficient", y = "Variable", colour="Year") +
  theme(panel.grid.major.x = element_line(),
        panel.grid.major.y = element_blank(),
        strip.text.y.left = element_text(angle = 0, size =18, face = 2),
        strip.placement = "outside",
        strip.background = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(size=10),
        axis.title.x = element_text(size=18,color='black',face='bold'),
        plot.title = element_text(size=22),
        axis.title.y = element_text(size=18,color='black',face='bold'),
        legend.position= "bottom",
        legend.text=element_text(size=12),
        legend.title=element_text(size=12)) +
  ggtitle( "Comparison of 2015 and 2023 Model Results for the Off Peak Period") 

am_fare %>%
  ggplot() + 
  geom_segment(aes(y = factor(variable), yend = factor(variable), x = lower, xend = upper,
                   colour = factor(year)), size = 2, alpha=.5) +
  geom_point(aes(y=factor(variable), x=coeff), colour="black", size = 1.5) +
  geom_vline(xintercept = 0, colour = 'red', linetype=3, size=.75) +
  scale_color_manual(values = c("orange" ,"deepskyblue4" )) +
  facet_grid(variable~., switch = "y") +
  scale_y_discrete(expand = c(0.5, 0.5)) + scale_x_continuous(breaks = round(seq(min(am_fare$lower), max(am_fare$upper), by = 0.2),1)) +
  theme_classic() +
  labs(x = "Coefficient", y = "Variable", colour="Year") +
  theme(panel.grid.major.x = element_line(),
        panel.grid.major.y = element_blank(),
        strip.text.y.left = element_text(angle = 0, size =18, face = 2),
        strip.placement = "outside",
        strip.background = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(size=10),
        axis.title.x = element_text(size=18,color='black',face='bold'),
        plot.title = element_text(size=22),
        axis.title.y = element_text(size=18,color='black',face='bold'),
        legend.position= "bottom",
        legend.text=element_text(size=12),
        legend.title=element_text(size=12)) +
  ggtitle( "Comparison of 2015 and 2023 Model Results for the AM Peak Period") 

pm_fare %>%
  ggplot() + 
  geom_segment(aes(y = factor(variable), yend = factor(variable), x = lower, xend = upper,
                   colour = factor(year)), size = 2, alpha=.5) + 
  geom_point(aes(y=factor(variable), x=coeff), colour="black", size = 1.5)+
  geom_vline(xintercept = 0, colour = 'red', linetype=3, size=.75) +
  scale_color_manual(values = c("orange" ,"deepskyblue4" )) +
  facet_grid(variable~., switch = "y") +
  scale_y_discrete(expand = c(0.5, 0.5)) + scale_x_continuous(breaks = round(seq(min(pm_fare$lower), max(pm_fare$upper), by = 0.2),1)) +
  theme_classic() +
  labs(x = "Coefficient", y = "Variable", colour="Year") +
  theme(panel.grid.major.x = element_line(),
        panel.grid.major.y = element_blank(),
        strip.text.y.left = element_text(angle = 0, size =18, face = 2),
        strip.placement = "outside",
        strip.background = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(size=10),
        axis.title.x = element_text(size=18,color='black',face='bold'),
        plot.title = element_text(size=22),
        axis.title.y = element_text(size=18,color='black',face='bold'),
        legend.position= "bottom",
        legend.text=element_text(size=12),
        legend.title=element_text(size=12)) +
  ggtitle( "Comparison of 2015 and 2023 Model Results for the PM Peak Period") 

#######################################################################################################

#other model Results from file
#transit benefits has sheets 1-3 (am, pm, off)
transit <- read_excel("model_results_for_plotting.xlsx", sheet=3)
transit <- transit %>%
  rename(
    "variable" = "Independent Variables",
    "coeff"="Coef.",
    "error" = "Std. Err.",
    "year" = "Year"
  )
transit$upper <- transit$coeff+transit$error
transit$lower <- transit$coeff-transit$error
transit$variable <- factor(transit$variable, levels = unique(transit$variable))


transit %>%
  ggplot() + 
  geom_segment(aes(y = factor(variable), yend = factor(variable), x = lower, xend = upper,
                   colour = factor(year)), size = 2, alpha=.5) + 
  geom_point(aes(y=factor(variable), x=coeff), colour="black", size = 1.5)+
  geom_vline(xintercept = 0, colour = 'red', linetype=3, size=.75) +
  scale_color_manual(values = c("orange" ,"deepskyblue4" )) +
  facet_grid(variable~., switch = "y") +
  scale_y_discrete(expand = c(0.5, 0.5)) + scale_x_continuous(breaks = round(seq(min(transit$lower, na.rm=T), max(transit$upper, na.rm = T), by = 0.2),1)) +
  theme_classic() +
  labs(x = "Coefficient", y = "Variable", colour="Year") +
  theme(panel.grid.major.x = element_line(),
        panel.grid.major.y = element_blank(),
        strip.text.y.left = element_text(angle = 0, size =18, face = 2),
        strip.placement = "outside",
        strip.background = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(size=10),
        axis.title.x = element_text(size=18,color='black',face='bold'),
        plot.title = element_text(size=22),
        axis.title.y = element_text(size=18,color='black',face='bold'),
        legend.position= "bottom",
        legend.text=element_text(size=12),
        legend.title=element_text(size=12)) 

###################################################################################################################
#senior full fare
#this variable is in sheets 4-6 (am, pm, off)


#other model Results from file
senior <- read_excel("model_results_for_plotting.xlsx", sheet=6)
senior <- senior %>%
  rename(
    "variable" = "Independent Variables",
    "coeff"="Coef.",
    "error" = "Std. Err.",
    "year" = "Year"
  )
senior$upper <- senior$coeff+senior$error
senior$lower <- senior$coeff-senior$error
senior$variable <- factor(senior$variable, levels = unique(senior$variable))

senior %>%
  ggplot() + 
  geom_segment(aes(y = factor(variable), yend = factor(variable), x = lower, xend = upper,
                   colour = factor(year)), size = 2, alpha=.5) + 
  geom_point(aes(y=factor(variable), x=coeff), colour="black", size = 1.5)+
  geom_vline(xintercept = 0, colour = 'red', linetype=3, size=.75) +
  scale_color_manual(values = c("orange" ,"deepskyblue4" )) +
  facet_grid(variable~., switch = "y") +
  scale_y_discrete(expand = c(0.5, 0.5)) + scale_x_continuous(breaks = round(seq(min(senior$lower, na.rm=T), max(senior$upper, na.rm=T), by = 0.2),1)) +
  theme_classic() +
  labs(x = "Coefficient", y = "Variable", colour="Year") +
  theme(panel.grid.major.x = element_line(),
        panel.grid.major.y = element_blank(),
        strip.text.y.left = element_text(angle = 0, size =18, face = 2),
        strip.placement = "outside",
        strip.background = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(size=10),
        axis.title.x = element_text(size=18,color='black',face='bold'),
        plot.title = element_text(size=22),
        axis.title.y = element_text(size=18,color='black',face='bold'),
        legend.position= "bottom",
        legend.text=element_text(size=12),
        legend.title=element_text(size=12)) 


########################################################################################################################
#all riders
# all riders are in sheets 7-9 (am, pm, off)
#am and pm combined is sheet 10
#all 3 combined is sheet 11

all_riders <- read_excel("model_results_for_plotting.xlsx", sheet=11)
all_riders <- all_riders %>%
  rename(
    "variable" = "Independent Variables",
    "coeff"="Coef.",
    "error" = "Std. Err.",
    "period" = "Time Period"
  )
all_riders$upper <- all_riders$coeff+all_riders$error
all_riders$lower <- all_riders$coeff-all_riders$error
all_riders$variable <- factor(all_riders$variable, levels = unique(all_riders$variable))

all_riders %>%
  ggplot() + 
  geom_segment(aes(y = factor(variable), yend = factor(variable), x = lower, xend = upper,
                   colour = factor(period, levels=c("AM Peak", "PM Peak", "Off Peak"))), size = 2, alpha=.5) + 
  geom_point(aes(y=factor(variable), x=coeff), colour="black", size = 1.5)+
  geom_vline(xintercept = 0, colour = 'red', linetype=3, size=.75) +
  scale_color_manual(values = c("orange", "deepskyblue4", "darkgreen")) +
  facet_grid(variable~., switch = "y") +
  scale_y_discrete(expand = c(0.5, 0.5)) + scale_x_continuous(breaks = round(seq(min(all_riders$lower, na.rm = T), max(all_riders$upper, na.rm = T), by = 0.2),1)) +
  theme_classic() +
  labs(x = "Coefficient", y = "Variable", colour="Time Period") +
  theme(panel.grid.major.x = element_line(),
        panel.grid.major.y = element_blank(),
        strip.text.y.left = element_text(angle = 0, size =18, face = 2),
        strip.placement = "outside",
        strip.background = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(size=10),
        axis.title.x = element_text(size=18,color='black',face='bold'),
        plot.title = element_text(size=22),
        axis.title.y = element_text(size=18,color='black',face='bold'),
        legend.position= "bottom",
        legend.text=element_text(size=12),
        legend.title=element_text(size=12)) 

#############################################################################################################

all_riders <- read_excel("model_results_for_plotting.xlsx", sheet=11)
all_riders <- all_riders %>%
  rename(
    "variable" = "Independent Variables",
    "coeff"="Coef.",
    "error" = "Std. Err.",
    "period" = "Time Period"
  )
all_riders$upper <- all_riders$coeff+all_riders$error
all_riders$lower <- all_riders$coeff-all_riders$error
all_riders$variable <- factor(all_riders$variable, levels = unique(all_riders$variable))

all_riders %>%
  ggplot() + 
  geom_segment(aes(y = factor(variable), yend = factor(variable), x = lower, xend = upper,
                   colour = factor(period, levels=c("AM Peak", "PM Peak", "Off Peak"))), size = 2, alpha=.5) + 
  geom_point(aes(y=factor(variable), x=coeff), colour="black", size = 1.5)+
  geom_vline(xintercept = 0, colour = 'red', linetype=3, size=.75) +
  scale_color_manual(values = c("orange", "deepskyblue4", "gray")) +
  facet_grid(variable~., switch = "y") +
  scale_y_discrete(expand = c(0.5, 0.5)) + scale_x_continuous(breaks = round(seq(min(all_riders$lower, na.rm = T), max(all_riders$upper, na.rm = T), by = 0.2),1)) +
  theme_classic() +
  labs(x = "Coefficient", y = "Variable", colour="Time Period") +
  theme(panel.grid.major.x = element_line(),
        panel.grid.major.y = element_blank(),
        strip.text.y.left = element_text(angle = 0, size =18, face = 2),
        strip.placement = "outside",
        strip.background = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(size=10),
        axis.title.x = element_text(size=18,color='black',face='bold'),
        plot.title = element_text(size=22),
        axis.title.y = element_text(size=18,color='black',face='bold'),
        legend.position= "bottom",
        legend.text=element_text(size=12),
        legend.title=element_text(size=12)) 

