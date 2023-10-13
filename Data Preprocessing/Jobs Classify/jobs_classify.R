library(writexl)
library(tidyverse)
library(readxl)
library(writexl)


### WAC_dc_ data (All jobs)
S000_DC <-read_excel("../../Data/WAC Data_2019_DC/dc_wac_S000_JT00_2019.xlsx")
SI01_DC <-read_excel("../../Data/WAC Data_2019_DC/dc_wac_SI01_JT00_2019.xlsx")
SI02_DC <-read_excel("../../Data/WAC Data_2019_DC/dc_wac_SI02_JT00_2019.xlsx")
SI03_DC <-read_excel("../../Data/WAC Data_2019_DC/dc_wac_SI03_JT00_2019.xlsx")


SA01_DC <-read_excel("../../Data/WAC Data_2019_DC/dc_wac_SA01_JT00_2019.xlsx")
SA02_DC <-read_excel("../../Data/WAC Data_2019_DC/dc_wac_SA02_JT00_2019.xlsx")
SA03_DC <-read_excel("../../Data/WAC Data_2019_DC/dc_wac_SA03_JT00_2019.xlsx")

SE01_DC <-read_excel("../../Data/WAC Data_2019_DC/dc_wac_SE01_JT00_2019.xlsx")
SE02_DC <-read_excel("../../Data/WAC Data_2019_DC/dc_wac_SE02_JT00_2019.xlsx")
SE03_DC <-read_excel("../../Data/WAC Data_2019_DC/dc_wac_SE03_JT00_2019.xlsx")

### WAC_MD_data (All jobs)
S000_MD <-read_excel("../../Data/WAC Data_2019_MD/md_wac_S000_JT00_2019.xlsx")
SI01_MD <-read_excel("../../Data/WAC Data_2019_MD/md_wac_SI01_JT00_2019.xlsx")
SI02_MD <-read_excel("../../Data/WAC Data_2019_MD/md_wac_SI02_JT00_2019.xlsx")
SI03_MD <-read_excel("../../Data/WAC Data_2019_MD/md_wac_SI03_JT00_2019.xlsx")

SA01_MD <-read_excel("../../Data/WAC Data_2019_MD/md_wac_SA01_JT00_2019.xlsx")
SA02_MD <-read_excel("../../Data/WAC Data_2019_MD/md_wac_SA02_JT00_2019.xlsx")
SA03_MD <-read_excel("../../Data/WAC Data_2019_MD/md_wac_SA03_JT00_2019.xlsx")

SE01_MD <-read_excel("../../Data/WAC Data_2019_MD/md_wac_SE01_JT00_2019.xlsx")
SE02_MD <-read_excel("../../Data/WAC Data_2019_MD/md_wac_SE02_JT00_2019.xlsx")
SE03_MD <-read_excel("../../Data/WAC Data_2019_MD/md_wac_SE03_JT00_2019.xlsx")

## WAC_VA_data (All jobs)
S000_VA <-read_excel("../../Data/WAC Data_2019_VA/va_wac_S000_JT00_2019.xlsx")
SI01_VA <-read_excel("../../Data/WAC Data_2019_VA/va_wac_SI01_JT00_2019.xlsx")
SI02_VA <-read_excel("../../Data/WAC Data_2019_VA/va_wac_SI02_JT00_2019.xlsx")
SI03_VA <-read_excel("../../Data/WAC Data_2019_VA/va_wac_SI03_JT00_2019.xlsx")

SA01_VA <-read_excel("../../Data/WAC Data_2019_VA/va_wac_SA01_JT00_2019.xlsx")
SA02_VA <-read_excel("../../Data/WAC Data_2019_VA/va_wac_SA02_JT00_2019.xlsx")
SA03_VA <-read_excel("../../Data/WAC Data_2019_VA/va_wac_SA03_JT00_2019.xlsx")

SE01_VA <-read_excel("../../Data/WAC Data_2019_VA/va_wac_SE01_JT00_2019.xlsx")
SE02_VA <-read_excel("../../Data/WAC Data_2019_VA/va_wac_SE02_JT00_2019.xlsx")
SE03_VA <-read_excel("../../Data/WAC Data_2019_VA/va_wac_SE03_JT00_2019.xlsx")

##Combine VA Jobs tabel

#library(dplyr)
#test3 <- test1 %>%
 # full_join(test2, by = "ID", suffix = c("", "_test2")) %>%
  #mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
   #      X = X + X_test2, Y = Y + Y_test2, Z = Z + Z_test2) %>%
  #select(-ends_with("_test2"))

### SI_VA
NEW_SI_0_VA<- SI01_VA %>%
  full_join(SI02_VA, by = "w_geocode", suffix = c("", "_SI02_VA")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_SI02_VA, CA01 = CA01  + CA01_SI02_VA,
         CA02 = CA02  + CA02_SI02_VA,CA03 = CA03  + CA03_SI02_VA,
         CA03 = CA03  + CA03_SI02_VA,
         CE01 = CE01  + CE01_SI02_VA,
         CE02 = CE02  + CE02_SI02_VA,
         CE03 = CE03  + CE03_SI02_VA,
         CNS01 = CNS01  + CNS01_SI02_VA,
         CNS02 = CNS02  + CNS02_SI02_VA,
         CNS03 = CNS03  + CNS03_SI02_VA,
         CNS04 = CNS04  + CNS04_SI02_VA,
         CNS05 = CNS05  + CNS05_SI02_VA,
         CNS06 = CNS06  + CNS06_SI02_VA,
         CNS07 = CNS07  + CNS07_SI02_VA,
         CNS08 = CNS08  + CNS08_SI02_VA,
         CNS09 = CNS09  + CNS09_SI02_VA,
         CNS10 = CNS10  + CNS10_SI02_VA,
         CNS11 = CNS11  + CNS11_SI02_VA,
         CNS12 = CNS12  + CNS12_SI02_VA,
         CNS13 = CNS13  + CNS13_SI02_VA,
         CNS14 = CNS14  + CNS14_SI02_VA,
         CNS15 = CNS15  + CNS15_SI02_VA,
         CNS16 = CNS16  + CNS16_SI02_VA,
         CNS17 = CNS17  + CNS17_SI02_VA,
         CNS18 = CNS18  + CNS18_SI02_VA,
         CNS19 = CNS19  + CNS19_SI02_VA,
         CNS20 = CNS20  + CNS20_SI02_VA,) %>%
  select(-ends_with("_SI02_VA"))

NEW_SI_2_VA<- SI03_VA %>%
  full_join(NEW_SI_0_VA, by = "w_geocode", suffix = c("", "_NEW_SI_0_VA")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SI_0_VA, CA01 = CA01  + CA01_NEW_SI_0_VA,
         CA02 = CA02  + CA02_NEW_SI_0_VA,CA03 = CA03  + CA03_NEW_SI_0_VA,
         CA03 = CA03  + CA03_NEW_SI_0_VA,
         CE01 = CE01  + CE01_NEW_SI_0_VA,
         CE02 = CE02  + CE02_NEW_SI_0_VA,
         CE03 = CE03  + CE03_NEW_SI_0_VA,
         CNS01 = CNS01  + CNS01_NEW_SI_0_VA,
         CNS02 = CNS02  + CNS02_NEW_SI_0_VA,
         CNS03 = CNS03  + CNS03_NEW_SI_0_VA,
         CNS04 = CNS04  + CNS04_NEW_SI_0_VA,
         CNS05 = CNS05  + CNS05_NEW_SI_0_VA,
         CNS06 = CNS06  + CNS06_NEW_SI_0_VA,
         CNS07 = CNS07  + CNS07_NEW_SI_0_VA,
         CNS08 = CNS08  + CNS08_NEW_SI_0_VA,
         CNS09 = CNS09  + CNS09_NEW_SI_0_VA,
         CNS10 = CNS10  + CNS10_NEW_SI_0_VA,
         CNS11 = CNS11  + CNS11_NEW_SI_0_VA,
         CNS12 = CNS12  + CNS12_NEW_SI_0_VA,
         CNS13 = CNS13  + CNS13_NEW_SI_0_VA,
         CNS14 = CNS14  + CNS14_NEW_SI_0_VA,
         CNS15 = CNS15  + CNS15_NEW_SI_0_VA,
         CNS16 = CNS16  + CNS16_NEW_SI_0_VA,
         CNS17 = CNS17  + CNS17_NEW_SI_0_VA,
         CNS18 = CNS18  + CNS18_NEW_SI_0_VA,
         CNS19 = CNS19  + CNS19_NEW_SI_0_VA,
         CNS20 = CNS20  + CNS20_NEW_SI_0_VA,) %>%
  select(-ends_with("_NEW_SI_0_VA"))

### SE_VA
NEW_SE_0_VA<- SE01_VA %>%
  full_join(SE02_VA, by = "w_geocode", suffix = c("", "_SE02_VA")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_SE02_VA, CA01 = CA01  + CA01_SE02_VA,
         CA02 = CA02  + CA02_SE02_VA,CA03 = CA03  + CA03_SE02_VA,
         CA03 = CA03  + CA03_SE02_VA,
         CE01 = CE01  + CE01_SE02_VA,
         CE02 = CE02  + CE02_SE02_VA,
         CE03 = CE03  + CE03_SE02_VA,
         CNS01 = CNS01  + CNS01_SE02_VA,
         CNS02 = CNS02  + CNS02_SE02_VA,
         CNS03 = CNS03  + CNS03_SE02_VA,
         CNS04 = CNS04  + CNS04_SE02_VA,
         CNS05 = CNS05  + CNS05_SE02_VA,
         CNS06 = CNS06  + CNS06_SE02_VA,
         CNS07 = CNS07  + CNS07_SE02_VA,
         CNS08 = CNS08  + CNS08_SE02_VA,
         CNS09 = CNS09  + CNS09_SE02_VA,
         CNS10 = CNS10  + CNS10_SE02_VA,
         CNS11 = CNS11  + CNS11_SE02_VA,
         CNS12 = CNS12  + CNS12_SE02_VA,
         CNS13 = CNS13  + CNS13_SE02_VA,
         CNS14 = CNS14  + CNS14_SE02_VA,
         CNS15 = CNS15  + CNS15_SE02_VA,
         CNS16 = CNS16  + CNS16_SE02_VA,
         CNS17 = CNS17  + CNS17_SE02_VA,
         CNS18 = CNS18  + CNS18_SE02_VA,
         CNS19 = CNS19  + CNS19_SE02_VA,
         CNS20 = CNS20  + CNS20_SE02_VA,) %>%
  select(-ends_with("_SE02_VA"))


NEW_SE_2_VA<- SE03_VA %>%
  full_join(NEW_SE_0_VA, by = "w_geocode", suffix = c("", "_NEW_SE_0_VA")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SE_0_VA, CA01 = CA01  + CA01_NEW_SE_0_VA,
         CA02 = CA02  + CA02_NEW_SE_0_VA,CA03 = CA03  + CA03_NEW_SE_0_VA,
         CA03 = CA03  + CA03_NEW_SE_0_VA,
         CE01 = CE01  + CE01_NEW_SE_0_VA,
         CE02 = CE02  + CE02_NEW_SE_0_VA,
         CE03 = CE03  + CE03_NEW_SE_0_VA,
         CNS01 = CNS01  + CNS01_NEW_SE_0_VA,
         CNS02 = CNS02  + CNS02_NEW_SE_0_VA,
         CNS03 = CNS03  + CNS03_NEW_SE_0_VA,
         CNS04 = CNS04  + CNS04_NEW_SE_0_VA,
         CNS05 = CNS05  + CNS05_NEW_SE_0_VA,
         CNS06 = CNS06  + CNS06_NEW_SE_0_VA,
         CNS07 = CNS07  + CNS07_NEW_SE_0_VA,
         CNS08 = CNS08  + CNS08_NEW_SE_0_VA,
         CNS09 = CNS09  + CNS09_NEW_SE_0_VA,
         CNS10 = CNS10  + CNS10_NEW_SE_0_VA,
         CNS11 = CNS11  + CNS11_NEW_SE_0_VA,
         CNS12 = CNS12  + CNS12_NEW_SE_0_VA,
         CNS13 = CNS13  + CNS13_NEW_SE_0_VA,
         CNS14 = CNS14  + CNS14_NEW_SE_0_VA,
         CNS15 = CNS15  + CNS15_NEW_SE_0_VA,
         CNS16 = CNS16  + CNS16_NEW_SE_0_VA,
         CNS17 = CNS17  + CNS17_NEW_SE_0_VA,
         CNS18 = CNS18  + CNS18_NEW_SE_0_VA,
         CNS19 = CNS19  + CNS19_NEW_SE_0_VA,
         CNS20 = CNS20  + CNS20_NEW_SE_0_VA,) %>%
  select(-ends_with("_NEW_SE_0_VA"))


##### SA_VA
NEW_SA_0_VA<- SA01_VA %>%
  full_join(SA02_VA, by = "w_geocode", suffix = c("", "_SA02_VA")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_SA02_VA, CA01 = CA01  + CA01_SA02_VA,
         CA02 = CA02  + CA02_SA02_VA,CA03 = CA03  + CA03_SA02_VA,
         CA03 = CA03  + CA03_SA02_VA,
         CE01 = CE01  + CE01_SA02_VA,
         CE02 = CE02  + CE02_SA02_VA,
         CE03 = CE03  + CE03_SA02_VA,
         CNS01 = CNS01  + CNS01_SA02_VA,
         CNS02 = CNS02  + CNS02_SA02_VA,
         CNS03 = CNS03  + CNS03_SA02_VA,
         CNS04 = CNS04  + CNS04_SA02_VA,
         CNS05 = CNS05  + CNS05_SA02_VA,
         CNS06 = CNS06  + CNS06_SA02_VA,
         CNS07 = CNS07  + CNS07_SA02_VA,
         CNS08 = CNS08  + CNS08_SA02_VA,
         CNS09 = CNS09  + CNS09_SA02_VA,
         CNS10 = CNS10  + CNS10_SA02_VA,
         CNS11 = CNS11  + CNS11_SA02_VA,
         CNS12 = CNS12  + CNS12_SA02_VA,
         CNS13 = CNS13  + CNS13_SA02_VA,
         CNS14 = CNS14  + CNS14_SA02_VA,
         CNS15 = CNS15  + CNS15_SA02_VA,
         CNS16 = CNS16  + CNS16_SA02_VA,
         CNS17 = CNS17  + CNS17_SA02_VA,
         CNS18 = CNS18  + CNS18_SA02_VA,
         CNS19 = CNS19  + CNS19_SA02_VA,
         CNS20 = CNS20  + CNS20_SA02_VA,) %>%
  select(-ends_with("_SA02_VA"))


NEW_SA_2_VA<- SA03_VA %>%
  full_join(NEW_SA_0_VA, by = "w_geocode", suffix = c("", "_NEW_SA_0_VA")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SA_0_VA, CA01 = CA01  + CA01_NEW_SA_0_VA,
         CA02 = CA02  + CA02_NEW_SA_0_VA,CA03 = CA03  + CA03_NEW_SA_0_VA,
         CA03 = CA03  + CA03_NEW_SA_0_VA,
         CE01 = CE01  + CE01_NEW_SA_0_VA,
         CE02 = CE02  + CE02_NEW_SA_0_VA,
         CE03 = CE03  + CE03_NEW_SA_0_VA,
         CNS01 = CNS01  + CNS01_NEW_SA_0_VA,
         CNS02 = CNS02  + CNS02_NEW_SA_0_VA,
         CNS03 = CNS03  + CNS03_NEW_SA_0_VA,
         CNS04 = CNS04  + CNS04_NEW_SA_0_VA,
         CNS05 = CNS05  + CNS05_NEW_SA_0_VA,
         CNS06 = CNS06  + CNS06_NEW_SA_0_VA,
         CNS07 = CNS07  + CNS07_NEW_SA_0_VA,
         CNS08 = CNS08  + CNS08_NEW_SA_0_VA,
         CNS09 = CNS09  + CNS09_NEW_SA_0_VA,
         CNS10 = CNS10  + CNS10_NEW_SA_0_VA,
         CNS11 = CNS11  + CNS11_NEW_SA_0_VA,
         CNS12 = CNS12  + CNS12_NEW_SA_0_VA,
         CNS13 = CNS13  + CNS13_NEW_SA_0_VA,
         CNS14 = CNS14  + CNS14_NEW_SA_0_VA,
         CNS15 = CNS15  + CNS15_NEW_SA_0_VA,
         CNS16 = CNS16  + CNS16_NEW_SA_0_VA,
         CNS17 = CNS17  + CNS17_NEW_SA_0_VA,
         CNS18 = CNS18  + CNS18_NEW_SA_0_VA,
         CNS19 = CNS19  + CNS19_NEW_SA_0_VA,
         CNS20 = CNS20  + CNS20_NEW_SA_0_VA,) %>%
  select(-ends_with("_NEW_SA_0_VA"))


##COMBINE SI $ SE VA
NEW_SI_SE_VA<- NEW_SI_2_VA %>%
  full_join(NEW_SE_2_VA, by = "w_geocode", suffix = c("", "_NEW_SE_2_VA")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SE_2_VA, CA01 = CA01  + CA01_NEW_SE_2_VA,
         CA02 = CA02  + CA02_NEW_SE_2_VA,CA03 = CA03  + CA03_NEW_SE_2_VA,
         CA03 = CA03  + CA03_NEW_SE_2_VA,
         CE01 = CE01  + CE01_NEW_SE_2_VA,
         CE02 = CE02  + CE02_NEW_SE_2_VA,
         CE03 = CE03  + CE03_NEW_SE_2_VA,
         CNS01 = CNS01  + CNS01_NEW_SE_2_VA,
         CNS02 = CNS02  + CNS02_NEW_SE_2_VA,
         CNS03 = CNS03  + CNS03_NEW_SE_2_VA,
         CNS04 = CNS04  + CNS04_NEW_SE_2_VA,
         CNS05 = CNS05  + CNS05_NEW_SE_2_VA,
         CNS06 = CNS06  + CNS06_NEW_SE_2_VA,
         CNS07 = CNS07  + CNS07_NEW_SE_2_VA,
         CNS08 = CNS08  + CNS08_NEW_SE_2_VA,
         CNS09 = CNS09  + CNS09_NEW_SE_2_VA,
         CNS10 = CNS10  + CNS10_NEW_SE_2_VA,
         CNS11 = CNS11  + CNS11_NEW_SE_2_VA,
         CNS12 = CNS12  + CNS12_NEW_SE_2_VA,
         CNS13 = CNS13  + CNS13_NEW_SE_2_VA,
         CNS14 = CNS14  + CNS14_NEW_SE_2_VA,
         CNS15 = CNS15  + CNS15_NEW_SE_2_VA,
         CNS16 = CNS16  + CNS16_NEW_SE_2_VA,
         CNS17 = CNS17  + CNS17_NEW_SE_2_VA,
         CNS18 = CNS18  + CNS18_NEW_SE_2_VA,
         CNS19 = CNS19  + CNS19_NEW_SE_2_VA,
         CNS20 = CNS20  + CNS20_NEW_SE_2_VA,) %>%
  select(-ends_with("_NEW_SE_2_VA"))



NEW_SA_S000_VA<- S000_VA %>%
  full_join(NEW_SA_2_VA, by = "w_geocode", suffix = c("", "_NEW_SA_2_VA")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SA_2_VA, CA01 = CA01  + CA01_NEW_SA_2_VA,
         CA02 = CA02  + CA02_NEW_SA_2_VA,CA03 = CA03  + CA03_NEW_SA_2_VA,
         CA03 = CA03  + CA03_NEW_SA_2_VA,
         CE01 = CE01  + CE01_NEW_SA_2_VA,
         CE02 = CE02  + CE02_NEW_SA_2_VA,
         CE03 = CE03  + CE03_NEW_SA_2_VA,
         CNS01 = CNS01  + CNS01_NEW_SA_2_VA,
         CNS02 = CNS02  + CNS02_NEW_SA_2_VA,
         CNS03 = CNS03  + CNS03_NEW_SA_2_VA,
         CNS04 = CNS04  + CNS04_NEW_SA_2_VA,
         CNS05 = CNS05  + CNS05_NEW_SA_2_VA,
         CNS06 = CNS06  + CNS06_NEW_SA_2_VA,
         CNS07 = CNS07  + CNS07_NEW_SA_2_VA,
         CNS08 = CNS08  + CNS08_NEW_SA_2_VA,
         CNS09 = CNS09  + CNS09_NEW_SA_2_VA,
         CNS10 = CNS10  + CNS10_NEW_SA_2_VA,
         CNS11 = CNS11  + CNS11_NEW_SA_2_VA,
         CNS12 = CNS12  + CNS12_NEW_SA_2_VA,
         CNS13 = CNS13  + CNS13_NEW_SA_2_VA,
         CNS14 = CNS14  + CNS14_NEW_SA_2_VA,
         CNS15 = CNS15  + CNS15_NEW_SA_2_VA,
         CNS16 = CNS16  + CNS16_NEW_SA_2_VA,
         CNS17 = CNS17  + CNS17_NEW_SA_2_VA,
         CNS18 = CNS18  + CNS18_NEW_SA_2_VA,
         CNS19 = CNS19  + CNS19_NEW_SA_2_VA,
         CNS20 = CNS20  + CNS20_NEW_SA_2_VA,) %>%
  select(-ends_with("_NEW_SA_2_VA"))


ALLJOBS_VA<- NEW_SA_S000_VA %>%
  full_join(NEW_SI_SE_VA, by = "w_geocode", suffix = c("", "_NEW_SI_SE_VA")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SI_SE_VA, CA01 = CA01  + CA01_NEW_SI_SE_VA,
         CA02 = CA02  + CA02_NEW_SI_SE_VA,CA03 = CA03  + CA03_NEW_SI_SE_VA,
         CA03 = CA03  + CA03_NEW_SI_SE_VA,
         CE01 = CE01  + CE01_NEW_SI_SE_VA,
         CE02 = CE02  + CE02_NEW_SI_SE_VA,
         CE03 = CE03  + CE03_NEW_SI_SE_VA,
         CNS01 = CNS01  + CNS01_NEW_SI_SE_VA,
         CNS02 = CNS02  + CNS02_NEW_SI_SE_VA,
         CNS03 = CNS03  + CNS03_NEW_SI_SE_VA,
         CNS04 = CNS04  + CNS04_NEW_SI_SE_VA,
         CNS05 = CNS05  + CNS05_NEW_SI_SE_VA,
         CNS06 = CNS06  + CNS06_NEW_SI_SE_VA,
         CNS07 = CNS07  + CNS07_NEW_SI_SE_VA,
         CNS08 = CNS08  + CNS08_NEW_SI_SE_VA,
         CNS09 = CNS09  + CNS09_NEW_SI_SE_VA,
         CNS10 = CNS10  + CNS10_NEW_SI_SE_VA,
         CNS11 = CNS11  + CNS11_NEW_SI_SE_VA,
         CNS12 = CNS12  + CNS12_NEW_SI_SE_VA,
         CNS13 = CNS13  + CNS13_NEW_SI_SE_VA,
         CNS14 = CNS14  + CNS14_NEW_SI_SE_VA,
         CNS15 = CNS15  + CNS15_NEW_SI_SE_VA,
         CNS16 = CNS16  + CNS16_NEW_SI_SE_VA,
         CNS17 = CNS17  + CNS17_NEW_SI_SE_VA,
         CNS18 = CNS18  + CNS18_NEW_SI_SE_VA,
         CNS19 = CNS19  + CNS19_NEW_SI_SE_VA,
         CNS20 = CNS20  + CNS20_NEW_SI_SE_VA,) %>%
  select(-ends_with("_NEW_SI_SE_VA"))


##### MD ######


### SI_MD
NEW_SI_0_MD<- SI01_MD %>%
  full_join(SI02_MD, by = "w_geocode", suffix = c("", "_SI02_MD")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_SI02_MD, CA01 = CA01  + CA01_SI02_MD,
         CA02 = CA02  + CA02_SI02_MD,CA03 = CA03  + CA03_SI02_MD,
         CA03 = CA03  + CA03_SI02_MD,
         CE01 = CE01  + CE01_SI02_MD,
         CE02 = CE02  + CE02_SI02_MD,
         CE03 = CE03  + CE03_SI02_MD,
         CNS01 = CNS01  + CNS01_SI02_MD,
         CNS02 = CNS02  + CNS02_SI02_MD,
         CNS03 = CNS03  + CNS03_SI02_MD,
         CNS04 = CNS04  + CNS04_SI02_MD,
         CNS05 = CNS05  + CNS05_SI02_MD,
         CNS06 = CNS06  + CNS06_SI02_MD,
         CNS07 = CNS07  + CNS07_SI02_MD,
         CNS08 = CNS08  + CNS08_SI02_MD,
         CNS09 = CNS09  + CNS09_SI02_MD,
         CNS10 = CNS10  + CNS10_SI02_MD,
         CNS11 = CNS11  + CNS11_SI02_MD,
         CNS12 = CNS12  + CNS12_SI02_MD,
         CNS13 = CNS13  + CNS13_SI02_MD,
         CNS14 = CNS14  + CNS14_SI02_MD,
         CNS15 = CNS15  + CNS15_SI02_MD,
         CNS16 = CNS16  + CNS16_SI02_MD,
         CNS17 = CNS17  + CNS17_SI02_MD,
         CNS18 = CNS18  + CNS18_SI02_MD,
         CNS19 = CNS19  + CNS19_SI02_MD,
         CNS20 = CNS20  + CNS20_SI02_MD,) %>%
  select(-ends_with("_SI02_MD"))


NEW_SI_2_MD<- SI03_MD %>%
  full_join(NEW_SI_0_MD, by = "w_geocode", suffix = c("", "_NEW_SI_0_MD")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SI_0_MD, CA01 = CA01  + CA01_NEW_SI_0_MD,
         CA02 = CA02  + CA02_NEW_SI_0_MD,CA03 = CA03  + CA03_NEW_SI_0_MD,
         CA03 = CA03  + CA03_NEW_SI_0_MD,
         CE01 = CE01  + CE01_NEW_SI_0_MD,
         CE02 = CE02  + CE02_NEW_SI_0_MD,
         CE03 = CE03  + CE03_NEW_SI_0_MD,
         CNS01 = CNS01  + CNS01_NEW_SI_0_MD,
         CNS02 = CNS02  + CNS02_NEW_SI_0_MD,
         CNS03 = CNS03  + CNS03_NEW_SI_0_MD,
         CNS04 = CNS04  + CNS04_NEW_SI_0_MD,
         CNS05 = CNS05  + CNS05_NEW_SI_0_MD,
         CNS06 = CNS06  + CNS06_NEW_SI_0_MD,
         CNS07 = CNS07  + CNS07_NEW_SI_0_MD,
         CNS08 = CNS08  + CNS08_NEW_SI_0_MD,
         CNS09 = CNS09  + CNS09_NEW_SI_0_MD,
         CNS10 = CNS10  + CNS10_NEW_SI_0_MD,
         CNS11 = CNS11  + CNS11_NEW_SI_0_MD,
         CNS12 = CNS12  + CNS12_NEW_SI_0_MD,
         CNS13 = CNS13  + CNS13_NEW_SI_0_MD,
         CNS14 = CNS14  + CNS14_NEW_SI_0_MD,
         CNS15 = CNS15  + CNS15_NEW_SI_0_MD,
         CNS16 = CNS16  + CNS16_NEW_SI_0_MD,
         CNS17 = CNS17  + CNS17_NEW_SI_0_MD,
         CNS18 = CNS18  + CNS18_NEW_SI_0_MD,
         CNS19 = CNS19  + CNS19_NEW_SI_0_MD,
         CNS20 = CNS20  + CNS20_NEW_SI_0_MD,) %>%
  select(-ends_with("_NEW_SI_0_MD"))


### SE_MD

NEW_SE_0_MD<- SE01_MD %>%
  full_join(SE02_MD, by = "w_geocode", suffix = c("", "_SE02_MD")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_SE02_MD, CA01 = CA01  + CA01_SE02_MD,
         CA02 = CA02  + CA02_SE02_MD,CA03 = CA03  + CA03_SE02_MD,
         CA03 = CA03  + CA03_SE02_MD,
         CE01 = CE01  + CE01_SE02_MD,
         CE02 = CE02  + CE02_SE02_MD,
         CE03 = CE03  + CE03_SE02_MD,
         CNS01 = CNS01  + CNS01_SE02_MD,
         CNS02 = CNS02  + CNS02_SE02_MD,
         CNS03 = CNS03  + CNS03_SE02_MD,
         CNS04 = CNS04  + CNS04_SE02_MD,
         CNS05 = CNS05  + CNS05_SE02_MD,
         CNS06 = CNS06  + CNS06_SE02_MD,
         CNS07 = CNS07  + CNS07_SE02_MD,
         CNS08 = CNS08  + CNS08_SE02_MD,
         CNS09 = CNS09  + CNS09_SE02_MD,
         CNS10 = CNS10  + CNS10_SE02_MD,
         CNS11 = CNS11  + CNS11_SE02_MD,
         CNS12 = CNS12  + CNS12_SE02_MD,
         CNS13 = CNS13  + CNS13_SE02_MD,
         CNS14 = CNS14  + CNS14_SE02_MD,
         CNS15 = CNS15  + CNS15_SE02_MD,
         CNS16 = CNS16  + CNS16_SE02_MD,
         CNS17 = CNS17  + CNS17_SE02_MD,
         CNS18 = CNS18  + CNS18_SE02_MD,
         CNS19 = CNS19  + CNS19_SE02_MD,
         CNS20 = CNS20  + CNS20_SE02_MD,) %>%
  select(-ends_with("_SE02_MD"))



NEW_SE_2_MD<- SE03_MD %>%
  full_join(NEW_SE_0_MD, by = "w_geocode", suffix = c("", "_NEW_SE_0_MD")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SE_0_MD, CA01 = CA01  + CA01_NEW_SE_0_MD,
         CA02 = CA02  + CA02_NEW_SE_0_MD,CA03 = CA03  + CA03_NEW_SE_0_MD,
         CA03 = CA03  + CA03_NEW_SE_0_MD,
         CE01 = CE01  + CE01_NEW_SE_0_MD,
         CE02 = CE02  + CE02_NEW_SE_0_MD,
         CE03 = CE03  + CE03_NEW_SE_0_MD,
         CNS01 = CNS01  + CNS01_NEW_SE_0_MD,
         CNS02 = CNS02  + CNS02_NEW_SE_0_MD,
         CNS03 = CNS03  + CNS03_NEW_SE_0_MD,
         CNS04 = CNS04  + CNS04_NEW_SE_0_MD,
         CNS05 = CNS05  + CNS05_NEW_SE_0_MD,
         CNS06 = CNS06  + CNS06_NEW_SE_0_MD,
         CNS07 = CNS07  + CNS07_NEW_SE_0_MD,
         CNS08 = CNS08  + CNS08_NEW_SE_0_MD,
         CNS09 = CNS09  + CNS09_NEW_SE_0_MD,
         CNS10 = CNS10  + CNS10_NEW_SE_0_MD,
         CNS11 = CNS11  + CNS11_NEW_SE_0_MD,
         CNS12 = CNS12  + CNS12_NEW_SE_0_MD,
         CNS13 = CNS13  + CNS13_NEW_SE_0_MD,
         CNS14 = CNS14  + CNS14_NEW_SE_0_MD,
         CNS15 = CNS15  + CNS15_NEW_SE_0_MD,
         CNS16 = CNS16  + CNS16_NEW_SE_0_MD,
         CNS17 = CNS17  + CNS17_NEW_SE_0_MD,
         CNS18 = CNS18  + CNS18_NEW_SE_0_MD,
         CNS19 = CNS19  + CNS19_NEW_SE_0_MD,
         CNS20 = CNS20  + CNS20_NEW_SE_0_MD,) %>%
  select(-ends_with("_NEW_SE_0_MD"))


## SA ####

NEW_SA_0_MD<- SA01_MD %>%
  full_join(SA02_MD, by = "w_geocode", suffix = c("", "_SA02_MD")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_SA02_MD, CA01 = CA01  + CA01_SA02_MD,
         CA02 = CA02  + CA02_SA02_MD,CA03 = CA03  + CA03_SA02_MD,
         CA03 = CA03  + CA03_SA02_MD,
         CE01 = CE01  + CE01_SA02_MD,
         CE02 = CE02  + CE02_SA02_MD,
         CE03 = CE03  + CE03_SA02_MD,
         CNS01 = CNS01  + CNS01_SA02_MD,
         CNS02 = CNS02  + CNS02_SA02_MD,
         CNS03 = CNS03  + CNS03_SA02_MD,
         CNS04 = CNS04  + CNS04_SA02_MD,
         CNS05 = CNS05  + CNS05_SA02_MD,
         CNS06 = CNS06  + CNS06_SA02_MD,
         CNS07 = CNS07  + CNS07_SA02_MD,
         CNS08 = CNS08  + CNS08_SA02_MD,
         CNS09 = CNS09  + CNS09_SA02_MD,
         CNS10 = CNS10  + CNS10_SA02_MD,
         CNS11 = CNS11  + CNS11_SA02_MD,
         CNS12 = CNS12  + CNS12_SA02_MD,
         CNS13 = CNS13  + CNS13_SA02_MD,
         CNS14 = CNS14  + CNS14_SA02_MD,
         CNS15 = CNS15  + CNS15_SA02_MD,
         CNS16 = CNS16  + CNS16_SA02_MD,
         CNS17 = CNS17  + CNS17_SA02_MD,
         CNS18 = CNS18  + CNS18_SA02_MD,
         CNS19 = CNS19  + CNS19_SA02_MD,
         CNS20 = CNS20  + CNS20_SA02_MD,) %>%
  select(-ends_with("_SA02_MD"))


NEW_SA_2_MD<- SA03_MD %>%
  full_join(NEW_SA_0_MD, by = "w_geocode", suffix = c("", "_NEW_SA_0_MD")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SA_0_MD, CA01 = CA01  + CA01_NEW_SA_0_MD,
         CA02 = CA02  + CA02_NEW_SA_0_MD,CA03 = CA03  + CA03_NEW_SA_0_MD,
         CA03 = CA03  + CA03_NEW_SA_0_MD,
         CE01 = CE01  + CE01_NEW_SA_0_MD,
         CE02 = CE02  + CE02_NEW_SA_0_MD,
         CE03 = CE03  + CE03_NEW_SA_0_MD,
         CNS01 = CNS01  + CNS01_NEW_SA_0_MD,
         CNS02 = CNS02  + CNS02_NEW_SA_0_MD,
         CNS03 = CNS03  + CNS03_NEW_SA_0_MD,
         CNS04 = CNS04  + CNS04_NEW_SA_0_MD,
         CNS05 = CNS05  + CNS05_NEW_SA_0_MD,
         CNS06 = CNS06  + CNS06_NEW_SA_0_MD,
         CNS07 = CNS07  + CNS07_NEW_SA_0_MD,
         CNS08 = CNS08  + CNS08_NEW_SA_0_MD,
         CNS09 = CNS09  + CNS09_NEW_SA_0_MD,
         CNS10 = CNS10  + CNS10_NEW_SA_0_MD,
         CNS11 = CNS11  + CNS11_NEW_SA_0_MD,
         CNS12 = CNS12  + CNS12_NEW_SA_0_MD,
         CNS13 = CNS13  + CNS13_NEW_SA_0_MD,
         CNS14 = CNS14  + CNS14_NEW_SA_0_MD,
         CNS15 = CNS15  + CNS15_NEW_SA_0_MD,
         CNS16 = CNS16  + CNS16_NEW_SA_0_MD,
         CNS17 = CNS17  + CNS17_NEW_SA_0_MD,
         CNS18 = CNS18  + CNS18_NEW_SA_0_MD,
         CNS19 = CNS19  + CNS19_NEW_SA_0_MD,
         CNS20 = CNS20  + CNS20_NEW_SA_0_MD,) %>%
  select(-ends_with("_NEW_SA_0_MD"))




##COMBINE SI $ SE MD

NEW_SI_SE_MD<- NEW_SI_2_MD %>%
  full_join(NEW_SE_2_MD, by = "w_geocode", suffix = c("", "_NEW_SE_2_MD")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SE_2_MD, CA01 = CA01  + CA01_NEW_SE_2_MD,
         CA02 = CA02  + CA02_NEW_SE_2_MD,CA03 = CA03  + CA03_NEW_SE_2_MD,
         CA03 = CA03  + CA03_NEW_SE_2_MD,
         CE01 = CE01  + CE01_NEW_SE_2_MD,
         CE02 = CE02  + CE02_NEW_SE_2_MD,
         CE03 = CE03  + CE03_NEW_SE_2_MD,
         CNS01 = CNS01  + CNS01_NEW_SE_2_MD,
         CNS02 = CNS02  + CNS02_NEW_SE_2_MD,
         CNS03 = CNS03  + CNS03_NEW_SE_2_MD,
         CNS04 = CNS04  + CNS04_NEW_SE_2_MD,
         CNS05 = CNS05  + CNS05_NEW_SE_2_MD,
         CNS06 = CNS06  + CNS06_NEW_SE_2_MD,
         CNS07 = CNS07  + CNS07_NEW_SE_2_MD,
         CNS08 = CNS08  + CNS08_NEW_SE_2_MD,
         CNS09 = CNS09  + CNS09_NEW_SE_2_MD,
         CNS10 = CNS10  + CNS10_NEW_SE_2_MD,
         CNS11 = CNS11  + CNS11_NEW_SE_2_MD,
         CNS12 = CNS12  + CNS12_NEW_SE_2_MD,
         CNS13 = CNS13  + CNS13_NEW_SE_2_MD,
         CNS14 = CNS14  + CNS14_NEW_SE_2_MD,
         CNS15 = CNS15  + CNS15_NEW_SE_2_MD,
         CNS16 = CNS16  + CNS16_NEW_SE_2_MD,
         CNS17 = CNS17  + CNS17_NEW_SE_2_MD,
         CNS18 = CNS18  + CNS18_NEW_SE_2_MD,
         CNS19 = CNS19  + CNS19_NEW_SE_2_MD,
         CNS20 = CNS20  + CNS20_NEW_SE_2_MD,) %>%
  select(-ends_with("_NEW_SE_2_MD"))



NEW_SA_S000_MD<- S000_MD %>%
  full_join(NEW_SA_2_MD, by = "w_geocode", suffix = c("", "_NEW_SA_2_MD")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SA_2_MD, CA01 = CA01  + CA01_NEW_SA_2_MD,
         CA02 = CA02  + CA02_NEW_SA_2_MD,CA03 = CA03  + CA03_NEW_SA_2_MD,
         CA03 = CA03  + CA03_NEW_SA_2_MD,
         CE01 = CE01  + CE01_NEW_SA_2_MD,
         CE02 = CE02  + CE02_NEW_SA_2_MD,
         CE03 = CE03  + CE03_NEW_SA_2_MD,
         CNS01 = CNS01  + CNS01_NEW_SA_2_MD,
         CNS02 = CNS02  + CNS02_NEW_SA_2_MD,
         CNS03 = CNS03  + CNS03_NEW_SA_2_MD,
         CNS04 = CNS04  + CNS04_NEW_SA_2_MD,
         CNS05 = CNS05  + CNS05_NEW_SA_2_MD,
         CNS06 = CNS06  + CNS06_NEW_SA_2_MD,
         CNS07 = CNS07  + CNS07_NEW_SA_2_MD,
         CNS08 = CNS08  + CNS08_NEW_SA_2_MD,
         CNS09 = CNS09  + CNS09_NEW_SA_2_MD,
         CNS10 = CNS10  + CNS10_NEW_SA_2_MD,
         CNS11 = CNS11  + CNS11_NEW_SA_2_MD,
         CNS12 = CNS12  + CNS12_NEW_SA_2_MD,
         CNS13 = CNS13  + CNS13_NEW_SA_2_MD,
         CNS14 = CNS14  + CNS14_NEW_SA_2_MD,
         CNS15 = CNS15  + CNS15_NEW_SA_2_MD,
         CNS16 = CNS16  + CNS16_NEW_SA_2_MD,
         CNS17 = CNS17  + CNS17_NEW_SA_2_MD,
         CNS18 = CNS18  + CNS18_NEW_SA_2_MD,
         CNS19 = CNS19  + CNS19_NEW_SA_2_MD,
         CNS20 = CNS20  + CNS20_NEW_SA_2_MD,) %>%
  select(-ends_with("_NEW_SA_2_MD"))



ALLJOBS_MD<- NEW_SA_S000_MD %>%
  full_join(NEW_SI_SE_MD, by = "w_geocode", suffix = c("", "_NEW_SI_SE_MD")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SI_SE_MD, CA01 = CA01  + CA01_NEW_SI_SE_MD,
         CA02 = CA02  + CA02_NEW_SI_SE_MD,CA03 = CA03  + CA03_NEW_SI_SE_MD,
         CA03 = CA03  + CA03_NEW_SI_SE_MD,
         CE01 = CE01  + CE01_NEW_SI_SE_MD,
         CE02 = CE02  + CE02_NEW_SI_SE_MD,
         CE03 = CE03  + CE03_NEW_SI_SE_MD,
         CNS01 = CNS01  + CNS01_NEW_SI_SE_MD,
         CNS02 = CNS02  + CNS02_NEW_SI_SE_MD,
         CNS03 = CNS03  + CNS03_NEW_SI_SE_MD,
         CNS04 = CNS04  + CNS04_NEW_SI_SE_MD,
         CNS05 = CNS05  + CNS05_NEW_SI_SE_MD,
         CNS06 = CNS06  + CNS06_NEW_SI_SE_MD,
         CNS07 = CNS07  + CNS07_NEW_SI_SE_MD,
         CNS08 = CNS08  + CNS08_NEW_SI_SE_MD,
         CNS09 = CNS09  + CNS09_NEW_SI_SE_MD,
         CNS10 = CNS10  + CNS10_NEW_SI_SE_MD,
         CNS11 = CNS11  + CNS11_NEW_SI_SE_MD,
         CNS12 = CNS12  + CNS12_NEW_SI_SE_MD,
         CNS13 = CNS13  + CNS13_NEW_SI_SE_MD,
         CNS14 = CNS14  + CNS14_NEW_SI_SE_MD,
         CNS15 = CNS15  + CNS15_NEW_SI_SE_MD,
         CNS16 = CNS16  + CNS16_NEW_SI_SE_MD,
         CNS17 = CNS17  + CNS17_NEW_SI_SE_MD,
         CNS18 = CNS18  + CNS18_NEW_SI_SE_MD,
         CNS19 = CNS19  + CNS19_NEW_SI_SE_MD,
         CNS20 = CNS20  + CNS20_NEW_SI_SE_MD,) %>%
  select(-ends_with("_NEW_SI_SE_MD"))





##### DC #####


### SI_DC
NEW_SI_0_DC<- SI01_DC %>%
  full_join(SI02_DC, by = "w_geocode", suffix = c("", "_SI02_DC")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_SI02_DC, CA01 = CA01  + CA01_SI02_DC,
         CA02 = CA02  + CA02_SI02_DC,CA03 = CA03  + CA03_SI02_DC,
         CA03 = CA03  + CA03_SI02_DC,
         CE01 = CE01  + CE01_SI02_DC,
         CE02 = CE02  + CE02_SI02_DC,
         CE03 = CE03  + CE03_SI02_DC,
         CNS01 = CNS01  + CNS01_SI02_DC,
         CNS02 = CNS02  + CNS02_SI02_DC,
         CNS03 = CNS03  + CNS03_SI02_DC,
         CNS04 = CNS04  + CNS04_SI02_DC,
         CNS05 = CNS05  + CNS05_SI02_DC,
         CNS06 = CNS06  + CNS06_SI02_DC,
         CNS07 = CNS07  + CNS07_SI02_DC,
         CNS08 = CNS08  + CNS08_SI02_DC,
         CNS09 = CNS09  + CNS09_SI02_DC,
         CNS10 = CNS10  + CNS10_SI02_DC,
         CNS11 = CNS11  + CNS11_SI02_DC,
         CNS12 = CNS12  + CNS12_SI02_DC,
         CNS13 = CNS13  + CNS13_SI02_DC,
         CNS14 = CNS14  + CNS14_SI02_DC,
         CNS15 = CNS15  + CNS15_SI02_DC,
         CNS16 = CNS16  + CNS16_SI02_DC,
         CNS17 = CNS17  + CNS17_SI02_DC,
         CNS18 = CNS18  + CNS18_SI02_DC,
         CNS19 = CNS19  + CNS19_SI02_DC,
         CNS20 = CNS20  + CNS20_SI02_DC,) %>%
  select(-ends_with("_SI02_DC"))


NEW_SI_2_DC<- SI03_DC %>%
  full_join(NEW_SI_0_DC, by = "w_geocode", suffix = c("", "_NEW_SI_0_DC")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SI_0_DC, CA01 = CA01  + CA01_NEW_SI_0_DC,
         CA02 = CA02  + CA02_NEW_SI_0_DC,CA03 = CA03  + CA03_NEW_SI_0_DC,
         CA03 = CA03  + CA03_NEW_SI_0_DC,
         CE01 = CE01  + CE01_NEW_SI_0_DC,
         CE02 = CE02  + CE02_NEW_SI_0_DC,
         CE03 = CE03  + CE03_NEW_SI_0_DC,
         CNS01 = CNS01  + CNS01_NEW_SI_0_DC,
         CNS02 = CNS02  + CNS02_NEW_SI_0_DC,
         CNS03 = CNS03  + CNS03_NEW_SI_0_DC,
         CNS04 = CNS04  + CNS04_NEW_SI_0_DC,
         CNS05 = CNS05  + CNS05_NEW_SI_0_DC,
         CNS06 = CNS06  + CNS06_NEW_SI_0_DC,
         CNS07 = CNS07  + CNS07_NEW_SI_0_DC,
         CNS08 = CNS08  + CNS08_NEW_SI_0_DC,
         CNS09 = CNS09  + CNS09_NEW_SI_0_DC,
         CNS10 = CNS10  + CNS10_NEW_SI_0_DC,
         CNS11 = CNS11  + CNS11_NEW_SI_0_DC,
         CNS12 = CNS12  + CNS12_NEW_SI_0_DC,
         CNS13 = CNS13  + CNS13_NEW_SI_0_DC,
         CNS14 = CNS14  + CNS14_NEW_SI_0_DC,
         CNS15 = CNS15  + CNS15_NEW_SI_0_DC,
         CNS16 = CNS16  + CNS16_NEW_SI_0_DC,
         CNS17 = CNS17  + CNS17_NEW_SI_0_DC,
         CNS18 = CNS18  + CNS18_NEW_SI_0_DC,
         CNS19 = CNS19  + CNS19_NEW_SI_0_DC,
         CNS20 = CNS20  + CNS20_NEW_SI_0_DC,) %>%
  select(-ends_with("_NEW_SI_0_DC"))


### SE_DC


NEW_SE_0_DC<- SE01_DC %>%
  full_join(SE02_DC, by = "w_geocode", suffix = c("", "_SE02_DC")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_SE02_DC, CA01 = CA01  + CA01_SE02_DC,
         CA02 = CA02  + CA02_SE02_DC,CA03 = CA03  + CA03_SE02_DC,
         CA03 = CA03  + CA03_SE02_DC,
         CE01 = CE01  + CE01_SE02_DC,
         CE02 = CE02  + CE02_SE02_DC,
         CE03 = CE03  + CE03_SE02_DC,
         CNS01 = CNS01  + CNS01_SE02_DC,
         CNS02 = CNS02  + CNS02_SE02_DC,
         CNS03 = CNS03  + CNS03_SE02_DC,
         CNS04 = CNS04  + CNS04_SE02_DC,
         CNS05 = CNS05  + CNS05_SE02_DC,
         CNS06 = CNS06  + CNS06_SE02_DC,
         CNS07 = CNS07  + CNS07_SE02_DC,
         CNS08 = CNS08  + CNS08_SE02_DC,
         CNS09 = CNS09  + CNS09_SE02_DC,
         CNS10 = CNS10  + CNS10_SE02_DC,
         CNS11 = CNS11  + CNS11_SE02_DC,
         CNS12 = CNS12  + CNS12_SE02_DC,
         CNS13 = CNS13  + CNS13_SE02_DC,
         CNS14 = CNS14  + CNS14_SE02_DC,
         CNS15 = CNS15  + CNS15_SE02_DC,
         CNS16 = CNS16  + CNS16_SE02_DC,
         CNS17 = CNS17  + CNS17_SE02_DC,
         CNS18 = CNS18  + CNS18_SE02_DC,
         CNS19 = CNS19  + CNS19_SE02_DC,
         CNS20 = CNS20  + CNS20_SE02_DC,) %>%
  select(-ends_with("_SE02_DC"))



NEW_SE_2_DC<- SE03_DC %>%
  full_join(NEW_SE_0_DC, by = "w_geocode", suffix = c("", "_NEW_SE_0_DC")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SE_0_DC, CA01 = CA01  + CA01_NEW_SE_0_DC,
         CA02 = CA02  + CA02_NEW_SE_0_DC,CA03 = CA03  + CA03_NEW_SE_0_DC,
         CA03 = CA03  + CA03_NEW_SE_0_DC,
         CE01 = CE01  + CE01_NEW_SE_0_DC,
         CE02 = CE02  + CE02_NEW_SE_0_DC,
         CE03 = CE03  + CE03_NEW_SE_0_DC,
         CNS01 = CNS01  + CNS01_NEW_SE_0_DC,
         CNS02 = CNS02  + CNS02_NEW_SE_0_DC,
         CNS03 = CNS03  + CNS03_NEW_SE_0_DC,
         CNS04 = CNS04  + CNS04_NEW_SE_0_DC,
         CNS05 = CNS05  + CNS05_NEW_SE_0_DC,
         CNS06 = CNS06  + CNS06_NEW_SE_0_DC,
         CNS07 = CNS07  + CNS07_NEW_SE_0_DC,
         CNS08 = CNS08  + CNS08_NEW_SE_0_DC,
         CNS09 = CNS09  + CNS09_NEW_SE_0_DC,
         CNS10 = CNS10  + CNS10_NEW_SE_0_DC,
         CNS11 = CNS11  + CNS11_NEW_SE_0_DC,
         CNS12 = CNS12  + CNS12_NEW_SE_0_DC,
         CNS13 = CNS13  + CNS13_NEW_SE_0_DC,
         CNS14 = CNS14  + CNS14_NEW_SE_0_DC,
         CNS15 = CNS15  + CNS15_NEW_SE_0_DC,
         CNS16 = CNS16  + CNS16_NEW_SE_0_DC,
         CNS17 = CNS17  + CNS17_NEW_SE_0_DC,
         CNS18 = CNS18  + CNS18_NEW_SE_0_DC,
         CNS19 = CNS19  + CNS19_NEW_SE_0_DC,
         CNS20 = CNS20  + CNS20_NEW_SE_0_DC,) %>%
  select(-ends_with("_NEW_SE_0_DC"))


## SA ####
NEW_SA_0_DC<- SA01_DC %>%
  full_join(SA02_DC, by = "w_geocode", suffix = c("", "_SA02_DC")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_SA02_DC, CA01 = CA01  + CA01_SA02_DC,
         CA02 = CA02  + CA02_SA02_DC,CA03 = CA03  + CA03_SA02_DC,
         CA03 = CA03  + CA03_SA02_DC,
         CE01 = CE01  + CE01_SA02_DC,
         CE02 = CE02  + CE02_SA02_DC,
         CE03 = CE03  + CE03_SA02_DC,
         CNS01 = CNS01  + CNS01_SA02_DC,
         CNS02 = CNS02  + CNS02_SA02_DC,
         CNS03 = CNS03  + CNS03_SA02_DC,
         CNS04 = CNS04  + CNS04_SA02_DC,
         CNS05 = CNS05  + CNS05_SA02_DC,
         CNS06 = CNS06  + CNS06_SA02_DC,
         CNS07 = CNS07  + CNS07_SA02_DC,
         CNS08 = CNS08  + CNS08_SA02_DC,
         CNS09 = CNS09  + CNS09_SA02_DC,
         CNS10 = CNS10  + CNS10_SA02_DC,
         CNS11 = CNS11  + CNS11_SA02_DC,
         CNS12 = CNS12  + CNS12_SA02_DC,
         CNS13 = CNS13  + CNS13_SA02_DC,
         CNS14 = CNS14  + CNS14_SA02_DC,
         CNS15 = CNS15  + CNS15_SA02_DC,
         CNS16 = CNS16  + CNS16_SA02_DC,
         CNS17 = CNS17  + CNS17_SA02_DC,
         CNS18 = CNS18  + CNS18_SA02_DC,
         CNS19 = CNS19  + CNS19_SA02_DC,
         CNS20 = CNS20  + CNS20_SA02_DC,) %>%
  select(-ends_with("_SA02_DC"))


NEW_SA_2_DC<- SA03_DC %>%
  full_join(NEW_SA_0_DC, by = "w_geocode", suffix = c("", "_NEW_SA_0_DC")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SA_0_DC, CA01 = CA01  + CA01_NEW_SA_0_DC,
         CA02 = CA02  + CA02_NEW_SA_0_DC,CA03 = CA03  + CA03_NEW_SA_0_DC,
         CA03 = CA03  + CA03_NEW_SA_0_DC,
         CE01 = CE01  + CE01_NEW_SA_0_DC,
         CE02 = CE02  + CE02_NEW_SA_0_DC,
         CE03 = CE03  + CE03_NEW_SA_0_DC,
         CNS01 = CNS01  + CNS01_NEW_SA_0_DC,
         CNS02 = CNS02  + CNS02_NEW_SA_0_DC,
         CNS03 = CNS03  + CNS03_NEW_SA_0_DC,
         CNS04 = CNS04  + CNS04_NEW_SA_0_DC,
         CNS05 = CNS05  + CNS05_NEW_SA_0_DC,
         CNS06 = CNS06  + CNS06_NEW_SA_0_DC,
         CNS07 = CNS07  + CNS07_NEW_SA_0_DC,
         CNS08 = CNS08  + CNS08_NEW_SA_0_DC,
         CNS09 = CNS09  + CNS09_NEW_SA_0_DC,
         CNS10 = CNS10  + CNS10_NEW_SA_0_DC,
         CNS11 = CNS11  + CNS11_NEW_SA_0_DC,
         CNS12 = CNS12  + CNS12_NEW_SA_0_DC,
         CNS13 = CNS13  + CNS13_NEW_SA_0_DC,
         CNS14 = CNS14  + CNS14_NEW_SA_0_DC,
         CNS15 = CNS15  + CNS15_NEW_SA_0_DC,
         CNS16 = CNS16  + CNS16_NEW_SA_0_DC,
         CNS17 = CNS17  + CNS17_NEW_SA_0_DC,
         CNS18 = CNS18  + CNS18_NEW_SA_0_DC,
         CNS19 = CNS19  + CNS19_NEW_SA_0_DC,
         CNS20 = CNS20  + CNS20_NEW_SA_0_DC,) %>%
  select(-ends_with("_NEW_SA_0_DC"))


##COMBINE SI $ SE MD

NEW_SI_SE_DC<- NEW_SI_2_DC %>%
  full_join(NEW_SE_2_DC, by = "w_geocode", suffix = c("", "_NEW_SE_2_DC")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SE_2_DC, CA01 = CA01  + CA01_NEW_SE_2_DC,
         CA02 = CA02  + CA02_NEW_SE_2_DC,CA03 = CA03  + CA03_NEW_SE_2_DC,
         CA03 = CA03  + CA03_NEW_SE_2_DC,
         CE01 = CE01  + CE01_NEW_SE_2_DC,
         CE02 = CE02  + CE02_NEW_SE_2_DC,
         CE03 = CE03  + CE03_NEW_SE_2_DC,
         CNS01 = CNS01  + CNS01_NEW_SE_2_DC,
         CNS02 = CNS02  + CNS02_NEW_SE_2_DC,
         CNS03 = CNS03  + CNS03_NEW_SE_2_DC,
         CNS04 = CNS04  + CNS04_NEW_SE_2_DC,
         CNS05 = CNS05  + CNS05_NEW_SE_2_DC,
         CNS06 = CNS06  + CNS06_NEW_SE_2_DC,
         CNS07 = CNS07  + CNS07_NEW_SE_2_DC,
         CNS08 = CNS08  + CNS08_NEW_SE_2_DC,
         CNS09 = CNS09  + CNS09_NEW_SE_2_DC,
         CNS10 = CNS10  + CNS10_NEW_SE_2_DC,
         CNS11 = CNS11  + CNS11_NEW_SE_2_DC,
         CNS12 = CNS12  + CNS12_NEW_SE_2_DC,
         CNS13 = CNS13  + CNS13_NEW_SE_2_DC,
         CNS14 = CNS14  + CNS14_NEW_SE_2_DC,
         CNS15 = CNS15  + CNS15_NEW_SE_2_DC,
         CNS16 = CNS16  + CNS16_NEW_SE_2_DC,
         CNS17 = CNS17  + CNS17_NEW_SE_2_DC,
         CNS18 = CNS18  + CNS18_NEW_SE_2_DC,
         CNS19 = CNS19  + CNS19_NEW_SE_2_DC,
         CNS20 = CNS20  + CNS20_NEW_SE_2_DC,) %>%
  select(-ends_with("_NEW_SE_2_DC"))



NEW_SA_S000_DC<- S000_DC %>%
  full_join(NEW_SA_2_DC, by = "w_geocode", suffix = c("", "_NEW_SA_2_DC")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SA_2_DC, CA01 = CA01  + CA01_NEW_SA_2_DC,
         CA02 = CA02  + CA02_NEW_SA_2_DC,CA03 = CA03  + CA03_NEW_SA_2_DC,
         CA03 = CA03  + CA03_NEW_SA_2_DC,
         CE01 = CE01  + CE01_NEW_SA_2_DC,
         CE02 = CE02  + CE02_NEW_SA_2_DC,
         CE03 = CE03  + CE03_NEW_SA_2_DC,
         CNS01 = CNS01  + CNS01_NEW_SA_2_DC,
         CNS02 = CNS02  + CNS02_NEW_SA_2_DC,
         CNS03 = CNS03  + CNS03_NEW_SA_2_DC,
         CNS04 = CNS04  + CNS04_NEW_SA_2_DC,
         CNS05 = CNS05  + CNS05_NEW_SA_2_DC,
         CNS06 = CNS06  + CNS06_NEW_SA_2_DC,
         CNS07 = CNS07  + CNS07_NEW_SA_2_DC,
         CNS08 = CNS08  + CNS08_NEW_SA_2_DC,
         CNS09 = CNS09  + CNS09_NEW_SA_2_DC,
         CNS10 = CNS10  + CNS10_NEW_SA_2_DC,
         CNS11 = CNS11  + CNS11_NEW_SA_2_DC,
         CNS12 = CNS12  + CNS12_NEW_SA_2_DC,
         CNS13 = CNS13  + CNS13_NEW_SA_2_DC,
         CNS14 = CNS14  + CNS14_NEW_SA_2_DC,
         CNS15 = CNS15  + CNS15_NEW_SA_2_DC,
         CNS16 = CNS16  + CNS16_NEW_SA_2_DC,
         CNS17 = CNS17  + CNS17_NEW_SA_2_DC,
         CNS18 = CNS18  + CNS18_NEW_SA_2_DC,
         CNS19 = CNS19  + CNS19_NEW_SA_2_DC,
         CNS20 = CNS20  + CNS20_NEW_SA_2_DC,) %>%
  select(-ends_with("_NEW_SA_2_DC"))



ALLJOBS_DC<- NEW_SA_S000_DC %>%
  full_join(NEW_SI_SE_DC, by = "w_geocode", suffix = c("", "_NEW_SI_SE_DC")) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.x), 0, .x)),
         C000 = C000 + C000_NEW_SI_SE_DC, CA01 = CA01  + CA01_NEW_SI_SE_DC,
         CA02 = CA02  + CA02_NEW_SI_SE_DC,CA03 = CA03  + CA03_NEW_SI_SE_DC,
         CA03 = CA03  + CA03_NEW_SI_SE_DC,
         CE01 = CE01  + CE01_NEW_SI_SE_DC,
         CE02 = CE02  + CE02_NEW_SI_SE_DC,
         CE03 = CE03  + CE03_NEW_SI_SE_DC,
         CNS01 = CNS01  + CNS01_NEW_SI_SE_DC,
         CNS02 = CNS02  + CNS02_NEW_SI_SE_DC,
         CNS03 = CNS03  + CNS03_NEW_SI_SE_DC,
         CNS04 = CNS04  + CNS04_NEW_SI_SE_DC,
         CNS05 = CNS05  + CNS05_NEW_SI_SE_DC,
         CNS06 = CNS06  + CNS06_NEW_SI_SE_DC,
         CNS07 = CNS07  + CNS07_NEW_SI_SE_DC,
         CNS08 = CNS08  + CNS08_NEW_SI_SE_DC,
         CNS09 = CNS09  + CNS09_NEW_SI_SE_DC,
         CNS10 = CNS10  + CNS10_NEW_SI_SE_DC,
         CNS11 = CNS11  + CNS11_NEW_SI_SE_DC,
         CNS12 = CNS12  + CNS12_NEW_SI_SE_DC,
         CNS13 = CNS13  + CNS13_NEW_SI_SE_DC,
         CNS14 = CNS14  + CNS14_NEW_SI_SE_DC,
         CNS15 = CNS15  + CNS15_NEW_SI_SE_DC,
         CNS16 = CNS16  + CNS16_NEW_SI_SE_DC,
         CNS17 = CNS17  + CNS17_NEW_SI_SE_DC,
         CNS18 = CNS18  + CNS18_NEW_SI_SE_DC,
         CNS19 = CNS19  + CNS19_NEW_SI_SE_DC,
         CNS20 = CNS20  + CNS20_NEW_SI_SE_DC,) %>%
  select(-ends_with("_NEW_SI_SE_DC"))

## export all jobs for MD, DC, and VA to excel ####

write_xlsx(ALLJOBS_DC,"output/ALLJOBS_DC.xlsx")

write_xlsx(ALLJOBS_MD,"output/ALLJOBS_MD.xlsx")

write_xlsx(ALLJOBS_VA,"output/ALLJOBS_VA.xlsx")

## Merge all jobs for VA, MD, and DC into one table ###
table1<-ALLJOBS_MD
table2<-ALLJOBS_DC
table3 <-ALLJOBS_VA
AlljobMDDCVA<-rbind(table1,table2,table3)

## export ALLjobsDCMDVA file to excel ####

write_xlsx(AlljobMDDCVA,"../Data/AlljobMDDCVA.xlsx")






