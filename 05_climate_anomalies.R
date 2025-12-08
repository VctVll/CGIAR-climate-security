#### PRECIPITATION #### 

library(haven)
climate_data_prec <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/Rainfall_Ethiopia.dta")
View(climate_data_prec)
#install.packages("dplyr")
library(dplyr)
names(climate_data_prec)
#install.packages("zoo")
library(zoo)

climate_data_fin_3p <- climate_data_prec %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p3 = zoo::rollmean(lag_p, k = 3, fill = NA, align = "right"))
climate_data_fin_6p <- climate_data_fin_3p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p6 = zoo::rollmean(lag_p, k = 6, fill = NA, align = "right"))
climate_data_fin_9p <- climate_data_fin_6p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p9 = zoo::rollmean(lag_p, k = 9, fill = NA, align = "right"))
climate_data_fin_12p <- climate_data_fin_9p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p12 = zoo::rollmean(lag_p, k = 12, fill = NA, align = "right"))

write_dta(climate_data_fin_3p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/ETH_rain_anomaly_monthly_3.dta")
write_dta(climate_data_fin_6p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/ETH_rain_anomaly_monthly_6.dta")
write_dta(climate_data_fin_9p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/ETH_rain_anomaly_monthly_9.dta")
write_dta(climate_data_fin_12p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/ETH_rain_anomaly_monthly_12.dta")

### TEMPERATURES ###

library(haven)
climate_data_tmax <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/Tmmax_Ethiopia.dta")
View(climate_data_tmax)
#install.packages("dplyr")
library(dplyr)
names(climate_data_tmax)
#install.packages("zoo")
library(zoo)

climate_data_fin_3t <- climate_data_tmax %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t3 = zoo::rollmean(lag_t, k = 3, fill = NA, align = "right"))
climate_data_fin_6t <- climate_data_fin_3t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t6 = zoo::rollmean(lag_t, k = 6, fill = NA, align = "right"))
climate_data_fin_9t <- climate_data_fin_6t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t9 = zoo::rollmean(lag_t, k = 9, fill = NA, align = "right"))
climate_data_fin_12t <- climate_data_fin_9t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t12 = zoo::rollmean(lag_t, k = 12, fill = NA, align = "right"))

write_dta(climate_data_fin_3t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/ETH_tmax_anomaly_monthly_3.dta")
write_dta(climate_data_fin_6t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/ETH_tmax_anomaly_monthly_6.dta")
write_dta(climate_data_fin_9t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/ETH_tmax_anomaly_monthly_9.dta")
write_dta(climate_data_fin_12t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/ETH_tmax_anomaly_monthly_12.dta")

### pdsi ###

library(haven)
pdsi_data <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/Pdsi_Ethiopia.dta")
View(pdsi_data)
#install.packages("dplyr")
library(dplyr)
names(pdsi_data)
#install.packages("zoo")
library(zoo)

pdsi_data_3 <- pdsi_data %>%
  mutate(pdsi_3 = zoo::rollmean(pdsi, k = 3, fill = NA, align = "right"))

pdsi_data_6 <- pdsi_data %>%
  mutate(pdsi_6 = zoo::rollmean(pdsi, k = 6, fill = NA, align = "right"))

pdsi_data_9 <- pdsi_data %>%
  mutate(pdsi_9 = zoo::rollmean(pdsi, k = 9, fill = NA, align = "right"))

pdsi_data_12<- pdsi_data %>%
  mutate(pdsi_12 = zoo::rollmean(pdsi, k = 12, fill = NA, align = "right"))


write_dta(pdsi_data_3,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/ETH_pdsi_monthly_3.dta")
write_dta(pdsi_data_6,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/ETH_pdsi_monthly_6.dta")
write_dta(pdsi_data_9,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/ETH_pdsi_monthly_9.dta")
write_dta(pdsi_data_12,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/ETH/final/ETH_pdsi_monthly_12.dta")



#### PRECIPITATION #### 

library(haven)
climate_data_prec <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/Rainfall_Tanzania.dta")
View(climate_data_prec)
#install.packages("dplyr")
library(dplyr)
names(climate_data_prec)
#install.packages("zoo")
library(zoo)

climate_data_fin_3p <- climate_data_prec %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p3 = zoo::rollmean(lag_p, k = 3, fill = NA, align = "right"))
climate_data_fin_6p <- climate_data_fin_3p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p6 = zoo::rollmean(lag_p, k = 6, fill = NA, align = "right"))
climate_data_fin_9p <- climate_data_fin_6p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p9 = zoo::rollmean(lag_p, k = 9, fill = NA, align = "right"))
climate_data_fin_12p <- climate_data_fin_9p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p12 = zoo::rollmean(lag_p, k = 12, fill = NA, align = "right"))

write_dta(climate_data_fin_3p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/TZA_rain_anomaly_monthly_3.dta")
write_dta(climate_data_fin_6p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/TZA_rain_anomaly_monthly_6.dta")
write_dta(climate_data_fin_9p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/TZA_rain_anomaly_monthly_9.dta")
write_dta(climate_data_fin_12p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/TZA_rain_anomaly_monthly_12.dta")

### TEMPERATURES ###

library(haven)
climate_data_tmax <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/Tmmax_Tanzania.dta")
View(climate_data_tmax)
#install.packages("dplyr")
library(dplyr)
names(climate_data_tmax)
#install.packages("zoo")
library(zoo)

climate_data_fin_3t <- climate_data_tmax %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t3 = zoo::rollmean(lag_t, k = 3, fill = NA, align = "right"))
climate_data_fin_6t <- climate_data_fin_3t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t6 = zoo::rollmean(lag_t, k = 6, fill = NA, align = "right"))
climate_data_fin_9t <- climate_data_fin_6t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t9 = zoo::rollmean(lag_t, k = 9, fill = NA, align = "right"))
climate_data_fin_12t <- climate_data_fin_9t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t12 = zoo::rollmean(lag_t, k = 12, fill = NA, align = "right"))

write_dta(climate_data_fin_3t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/TZA_tmax_anomaly_monthly_3.dta")
write_dta(climate_data_fin_6t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/TZA_tmax_anomaly_monthly_6.dta")
write_dta(climate_data_fin_9t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/TZA_tmax_anomaly_monthly_9.dta")
write_dta(climate_data_fin_12t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/TZA_tmax_anomaly_monthly_12.dta")

### pdsi ###

library(haven)
pdsi_data <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/Pdsi_Tanzania.dta")
View(pdsi_data)
#install.packages("dplyr")
library(dplyr)
names(pdsi_data)
#install.packages("zoo")
library(zoo)

pdsi_data_3 <- pdsi_data %>%
  mutate(pdsi_3 = zoo::rollmean(pdsi, k = 3, fill = NA, align = "right"))

pdsi_data_6 <- pdsi_data %>%
  mutate(pdsi_6 = zoo::rollmean(pdsi, k = 6, fill = NA, align = "right"))

pdsi_data_9 <- pdsi_data %>%
  mutate(pdsi_9 = zoo::rollmean(pdsi, k = 9, fill = NA, align = "right"))

pdsi_data_12<- pdsi_data %>%
  mutate(pdsi_12 = zoo::rollmean(pdsi, k = 12, fill = NA, align = "right"))


write_dta(pdsi_data_3,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/TZA_pdsi_monthly_3.dta")
write_dta(pdsi_data_6,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/TZA_pdsi_monthly_6.dta")
write_dta(pdsi_data_9,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/TZA_pdsi_monthly_9.dta")
write_dta(pdsi_data_12,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/TZA/final/TZA_pdsi_monthly_12.dta")




#### PRECIPITATION #### 

library(haven)
climate_data_prec <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/Rainfall_Congo.dta")
View(climate_data_prec)
#install.packages("dplyr")
library(dplyr)
names(climate_data_prec)
#install.packages("zoo")
library(zoo)

climate_data_fin_3p <- climate_data_prec %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p3 = zoo::rollmean(lag_p, k = 3, fill = NA, align = "right"))
climate_data_fin_6p <- climate_data_fin_3p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p6 = zoo::rollmean(lag_p, k = 6, fill = NA, align = "right"))
climate_data_fin_9p <- climate_data_fin_6p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p9 = zoo::rollmean(lag_p, k = 9, fill = NA, align = "right"))
climate_data_fin_12p <- climate_data_fin_9p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p12 = zoo::rollmean(lag_p, k = 12, fill = NA, align = "right"))

write_dta(climate_data_fin_3p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/COD_rain_anomaly_monthly_3.dta")
write_dta(climate_data_fin_6p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/COD_rain_anomaly_monthly_6.dta")
write_dta(climate_data_fin_9p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/COD_rain_anomaly_monthly_9.dta")
write_dta(climate_data_fin_12p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/COD_rain_anomaly_monthly_12.dta")

### TEMPERATURES ###

library(haven)
climate_data_tmax <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/Tmmax_Congo.dta")
View(climate_data_tmax)
#install.packages("dplyr")
library(dplyr)
names(climate_data_tmax)
#install.packages("zoo")
library(zoo)

climate_data_fin_3t <- climate_data_tmax %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t3 = zoo::rollmean(lag_t, k = 3, fill = NA, align = "right"))
climate_data_fin_6t <- climate_data_fin_3t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t6 = zoo::rollmean(lag_t, k = 6, fill = NA, align = "right"))
climate_data_fin_9t <- climate_data_fin_6t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t9 = zoo::rollmean(lag_t, k = 9, fill = NA, align = "right"))
climate_data_fin_12t <- climate_data_fin_9t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t12 = zoo::rollmean(lag_t, k = 12, fill = NA, align = "right"))

write_dta(climate_data_fin_3t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/COD_tmax_anomaly_monthly_3.dta")
write_dta(climate_data_fin_6t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/COD_tmax_anomaly_monthly_6.dta")
write_dta(climate_data_fin_9t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/COD_tmax_anomaly_monthly_9.dta")
write_dta(climate_data_fin_12t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/COD_tmax_anomaly_monthly_12.dta")

### pdsi ###

library(haven)
pdsi_data <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/Pdsi_Congo.dta")
View(pdsi_data)
#install.packages("dplyr")
library(dplyr)
names(pdsi_data)
#install.packages("zoo")
library(zoo)

pdsi_data_3 <- pdsi_data %>%
  mutate(pdsi_3 = zoo::rollmean(pdsi, k = 3, fill = NA, align = "right"))

pdsi_data_6 <- pdsi_data %>%
  mutate(pdsi_6 = zoo::rollmean(pdsi, k = 6, fill = NA, align = "right"))

pdsi_data_9 <- pdsi_data %>%
  mutate(pdsi_9 = zoo::rollmean(pdsi, k = 9, fill = NA, align = "right"))

pdsi_data_12<- pdsi_data %>%
  mutate(pdsi_12 = zoo::rollmean(pdsi, k = 12, fill = NA, align = "right"))


write_dta(pdsi_data_3,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/COD_pdsi_monthly_3.dta")
write_dta(pdsi_data_6,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/COD_pdsi_monthly_6.dta")
write_dta(pdsi_data_9,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/COD_pdsi_monthly_9.dta")
write_dta(pdsi_data_12,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/COD/final/COD_pdsi_monthly_12.dta")



#### PRECIPITATION #### 

library(haven)
climate_data_prec <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/Rainfall_Southsudan.dta")
View(climate_data_prec)
#install.packages("dplyr")
library(dplyr)
names(climate_data_prec)
#install.packages("zoo")
library(zoo)

climate_data_fin_3p <- climate_data_prec %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p3 = zoo::rollmean(lag_p, k = 3, fill = NA, align = "right"))
climate_data_fin_6p <- climate_data_fin_3p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p6 = zoo::rollmean(lag_p, k = 6, fill = NA, align = "right"))
climate_data_fin_9p <- climate_data_fin_6p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p9 = zoo::rollmean(lag_p, k = 9, fill = NA, align = "right"))
climate_data_fin_12p <- climate_data_fin_9p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p12 = zoo::rollmean(lag_p, k = 12, fill = NA, align = "right"))

write_dta(climate_data_fin_3p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/SSD_rain_anomaly_monthly_3.dta")
write_dta(climate_data_fin_6p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/SSD_rain_anomaly_monthly_6.dta")
write_dta(climate_data_fin_9p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/SSD_rain_anomaly_monthly_9.dta")
write_dta(climate_data_fin_12p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/SSD_rain_anomaly_monthly_12.dta")

### TEMPERATURES ###

library(haven)
climate_data_tmax <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/Tmmax_Southsudan.dta")
View(climate_data_tmax)
#install.packages("dplyr")
library(dplyr)
names(climate_data_tmax)
#install.packages("zoo")
library(zoo)

climate_data_fin_3t <- climate_data_tmax %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t3 = zoo::rollmean(lag_t, k = 3, fill = NA, align = "right"))
climate_data_fin_6t <- climate_data_fin_3t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t6 = zoo::rollmean(lag_t, k = 6, fill = NA, align = "right"))
climate_data_fin_9t <- climate_data_fin_6t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t9 = zoo::rollmean(lag_t, k = 9, fill = NA, align = "right"))
climate_data_fin_12t <- climate_data_fin_9t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t12 = zoo::rollmean(lag_t, k = 12, fill = NA, align = "right"))

write_dta(climate_data_fin_3t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/SSD_tmax_anomaly_monthly_3.dta")
write_dta(climate_data_fin_6t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/SSD_tmax_anomaly_monthly_6.dta")
write_dta(climate_data_fin_9t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/SSD_tmax_anomaly_monthly_9.dta")
write_dta(climate_data_fin_12t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/SSD_tmax_anomaly_monthly_12.dta")

### pdsi ###

library(haven)
pdsi_data <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/Pdsi_Southsudan.dta")
View(pdsi_data)
#install.packages("dplyr")
library(dplyr)
names(pdsi_data)
#install.packages("zoo")
library(zoo)

pdsi_data_3 <- pdsi_data %>%
  mutate(pdsi_3 = zoo::rollmean(pdsi, k = 3, fill = NA, align = "right"))

pdsi_data_6 <- pdsi_data %>%
  mutate(pdsi_6 = zoo::rollmean(pdsi, k = 6, fill = NA, align = "right"))

pdsi_data_9 <- pdsi_data %>%
  mutate(pdsi_9 = zoo::rollmean(pdsi, k = 9, fill = NA, align = "right"))

pdsi_data_12<- pdsi_data %>%
  mutate(pdsi_12 = zoo::rollmean(pdsi, k = 12, fill = NA, align = "right"))


write_dta(pdsi_data_3,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/SSD_pdsi_monthly_3.dta")
write_dta(pdsi_data_6,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/SSD_pdsi_monthly_6.dta")
write_dta(pdsi_data_9,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/SSD_pdsi_monthly_9.dta")
write_dta(pdsi_data_12,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/SSD/final/SSD_pdsi_monthly_12.dta")



#### PRECIPITATION #### 

library(haven)
climate_data_prec <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/Rainfall_Uganda.dta")
View(climate_data_prec)
#install.packages("dplyr")
library(dplyr)
names(climate_data_prec)
#install.packages("zoo")
library(zoo)

climate_data_fin_3p <- climate_data_prec %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p3 = zoo::rollmean(lag_p, k = 3, fill = NA, align = "right"))
climate_data_fin_6p <- climate_data_fin_3p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p6 = zoo::rollmean(lag_p, k = 6, fill = NA, align = "right"))
climate_data_fin_9p <- climate_data_fin_6p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p9 = zoo::rollmean(lag_p, k = 9, fill = NA, align = "right"))
climate_data_fin_12p <- climate_data_fin_9p %>%
  mutate(lag_p = (prec - prec_mean)/prec_sd, rollMean_p12 = zoo::rollmean(lag_p, k = 12, fill = NA, align = "right"))

write_dta(climate_data_fin_3p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/UGA_rain_anomaly_monthly_3.dta")
write_dta(climate_data_fin_6p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/UGA_rain_anomaly_monthly_6.dta")
write_dta(climate_data_fin_9p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/UGA_rain_anomaly_monthly_9.dta")
write_dta(climate_data_fin_12p,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/UGA_rain_anomaly_monthly_12.dta")

### TEMPERATURES ###

library(haven)
climate_data_tmax <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/Tmmax_Uganda.dta")
View(climate_data_tmax)
#install.packages("dplyr")
library(dplyr)
names(climate_data_tmax)
#install.packages("zoo")
library(zoo)

climate_data_fin_3t <- climate_data_tmax %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t3 = zoo::rollmean(lag_t, k = 3, fill = NA, align = "right"))
climate_data_fin_6t <- climate_data_fin_3t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t6 = zoo::rollmean(lag_t, k = 6, fill = NA, align = "right"))
climate_data_fin_9t <- climate_data_fin_6t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t9 = zoo::rollmean(lag_t, k = 9, fill = NA, align = "right"))
climate_data_fin_12t <- climate_data_fin_9t %>%
  mutate(lag_t = (tmax - tmax_mean)/tmax_sd, rollMean_t12 = zoo::rollmean(lag_t, k = 12, fill = NA, align = "right"))

write_dta(climate_data_fin_3t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/UGA_tmax_anomaly_monthly_3.dta")
write_dta(climate_data_fin_6t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/UGA_tmax_anomaly_monthly_6.dta")
write_dta(climate_data_fin_9t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/UGA_tmax_anomaly_monthly_9.dta")
write_dta(climate_data_fin_12t,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/UGA_tmax_anomaly_monthly_12.dta")

### pdsi ###

library(haven)
pdsi_data <- read_dta("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/Pdsi_Uganda.dta")
View(pdsi_data)
#install.packages("dplyr")
library(dplyr)
names(pdsi_data)
#install.packages("zoo")
library(zoo)

pdsi_data_3 <- pdsi_data %>%
  mutate(pdsi_3 = zoo::rollmean(pdsi, k = 3, fill = NA, align = "right"))

pdsi_data_6 <- pdsi_data %>%
  mutate(pdsi_6 = zoo::rollmean(pdsi, k = 6, fill = NA, align = "right"))

pdsi_data_9 <- pdsi_data %>%
  mutate(pdsi_9 = zoo::rollmean(pdsi, k = 9, fill = NA, align = "right"))

pdsi_data_12<- pdsi_data %>%
  mutate(pdsi_12 = zoo::rollmean(pdsi, k = 12, fill = NA, align = "right"))


write_dta(pdsi_data_3,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/UGA_pdsi_monthly_3.dta")
write_dta(pdsi_data_6,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/UGA_pdsi_monthly_6.dta")
write_dta(pdsi_data_9,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/UGA_pdsi_monthly_9.dta")
write_dta(pdsi_data_12,"D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Climate data/UGA/final/UGA_pdsi_monthly_12.dta")
