#Buffer Calculation
devtools::install_github("tidyverse/tidyr")
library(tidyr)
library(dplyr)
library(readr)
################################################################################
rm(list=ls())

#Utils required
suppressMessages(if (!require("pacman")) install.packages("pacman"))
suppressMessages(pacman::p_load(tidyverse, sf, mapview, units, haven, janitor))

################################################################################
#Reading the Philippines shapefile (Not necessary)
eth_shp <- 
  read_sf("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/Shapefile/eth_admbnda_adm1_csa_bofedb_2021.shp")
################################################################################

#Reading the Ethiopia Conflicts file (ACLED) 
eth_conflicts <- 
  haven::read_dta("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/Final Data/ACLED_raw_ETH.dta") %>% 
  dplyr::select(year, quarter, month, latitude, longitude, event_type)  
eth_conflicts$event <- ifelse(eth_conflicts$event_type != "NA", 1, NA ) 
#Aggregating conflicts over the years and GPS points-- ASK ZEESHAN, we should not aggregate
#Fatalities in conflicts (Even fatalities =0, still a conflict incident)
eth_conflicts <-   
  eth_conflicts %>% 
  filter(event_type == "Violent Conflicts" | 
           event_type == "Civil Unrest") %>% 
  group_by(year, quarter, month, longitude, latitude, event_type) %>% #month
  summarise(event = sum(event), 
            .groups = "drop") %>% 
  filter(!is.na(event)) %>%  
  pivot_wider(names_from = event_type, 
              values_from = event) %>% 
  janitor::clean_names()




dhsclust_quarter_map <- 
  haven::read_dta( "E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/Final Data/GPS_DHS_year_month.dta") %>% 
  rename(LONGNUM = longitude, LATNUM = latitude, DHSCLUST = hv001, DHSYEAR = year, QUARTER= quarter)  %>% 
  distinct(LONGNUM, LATNUM, DHSYEAR, DHSCLUST, QUARTER) %>% 
  st_as_sf(coords= c("LONGNUM", "LATNUM"), crs=4326) %>%
  mutate(LONGNUM = st_coordinates(.)[, 1],
         LATNUM = st_coordinates(.)[, 2])

################################################################################
#Buffer Calculation around DHS coordinates

#Years for which DHS Clusters are available 
#(adjust according to the DHS clusters years availability)

dhs_years <- c(2000,2005,2010,2011,2016,2019)

################################################################################

#Change distance based on the country specific context

dist <- set_units(50, km) %>% 
  set_units(km) %>% 
  set_units(m)

dist = dist   # 22km    change if other needed 50000 = 50 Km

#All years buffers calculation  (With shapefile)

# for(yr in dhs_years){
#   
#   data_shp <- get(str_c("PH_",yr))
#   
#   assign(
#     str_c("buffer_", yr),
#     data_shp %>%
#       st_transform(crs = 3123) %>% #Philippines zone 3 (For speedy and accurate calculation):    https://epsg.io/3123
#       st_buffer(
#         dist = dist,
#         nQuadSegs = 20,   #70  change to control the segments of a circle quadrant, if high for more perfect circles, file size and calculation time would go up
#         endCapStyle = "ROUND",
#         joinStyle = "ROUND",
#         mitreLimit = 1,
#         singleSide = FALSE)%>% 
#       st_transform(crs = 4326)  #Back to 4326 for plotting and merging with conflict features
#   ) 
# }
#buffer_2003
#buffer_2008
#buffer_2017

# Combining all buffers for simplicity  (Change as per your DHS years)
# buffer_all <- 
#   buffer_2003 %>% 
#   bind_rows(buffer_2008) %>% 
#   bind_rows(buffer_2017)

#All years buffers calculation  (Without shapefile: with quarters calculation)
buffer_all_new <- 
  dhsclust_quarter_map %>%
  st_transform(crs = 20137) %>% #Philippines zone 3 (For speedy and accurate calculation):    https://epsg.io/3123  need to adapt to Ethiopia 
  st_buffer(
    dist = dist,
    nQuadSegs = 70,   #70  change to control the segments of a circle quadrant, if high for more perfect circles, file size and calculation time would go up
    endCapStyle = "ROUND",
    joinStyle = "ROUND",
    mitreLimit = 1,
    singleSide = FALSE) %>% 
  st_transform(crs = 4326)  #Back to 4326 for plotting and merging with conflict features

#Making separate Buffers for 3 DHS years again to make separate tables

buffer_2000 <- buffer_all_new %>% 
  filter(DHSYEAR == dhs_years[1])

buffer_2005 <- buffer_all_new %>% 
  filter(DHSYEAR == dhs_years[2])

buffer_2010 <- buffer_all_new %>% 
  filter(DHSYEAR == dhs_years[3])

buffer_2011 <- buffer_all_new %>% 
  filter(DHSYEAR == dhs_years[4])

buffer_2016 <- buffer_all_new %>% 
  filter(DHSYEAR == dhs_years[5])

buffer_2019 <- buffer_all_new %>% 
  filter(DHSYEAR == dhs_years[6])

################################################################################

#To make a complete time series of conflicts as sf object to overlay on buffers
conflicts_all <- 
  eth_conflicts %>%
  filter(!is.na(civil_unrest) |
           !is.na(violent_conflicts)) %>% 
  # year>2000) %>%   #Since 1995 and 1996 have december missing
  rename(LONGNUM=longitude, LATNUM=latitude) %>%
  st_as_sf(coords= c("LONGNUM", "LATNUM"), crs=4326) %>%
  mutate(LONGNUM = st_coordinates(.)[, 1],
         LATNUM = st_coordinates(.)[, 2]) 

# conflicts_all %>% as_tibble() %>%  filter(year == 2020) %>% distinct(month) 
#Raw conflict data is monthly except for  1995 & 1996 where December is missing
################################################################################

#For whole time series of conflicts overlapping buffers

#Overlapping features of buffers and conflicts

################################################################################
#Looping each month (1:12) of conflict years from 1989-2020 over the buffers of the each DHS year
#Keeping the buffers which have 0 conflicts
#Final Data at month granularity
################################################################################

conflict_years <- unique(conflicts_all$year)

conflict_month <- c(1:12)

dhs_years <- dhs_years


# Making separate datasets of conflict datasets at month level within conflict years


for(yr in conflict_years){
  
  for(mn in conflict_month){
    
    assign(paste0("conflicts_", yr, "_", mn),
           eth_conflicts %>%
             filter(!is.na(civil_unrest) |
                      !is.na(violent_conflicts),
                    year == yr,
                    month== mn) %>%   
             rename(LONGNUM=longitude, 
                    LATNUM=latitude) %>%
             st_as_sf(coords= c("LONGNUM", "LATNUM"), crs=4326) %>%
             mutate(LONGNUM = st_coordinates(.)[, 1],
                    LATNUM = st_coordinates(.)[, 2]) 
    )
    
  }
}


#For All DHS years complete calculation in 1 go - Use this loop

for(dhs in dhs_years){
  
  for(yr in conflict_years){
    
    for(mn in conflict_month){
      
      assign(paste0("conf_count_", yr, "_", mn), 
             st_intersects(get(paste0("buffer_",dhs)) %>%  st_transform(crs = 20137) , 
                           get(paste0("conflicts_", yr, "_", mn)) %>% st_transform(crs = 20137)) 
      )
      
      assign(paste0("intersects_", yr, "_", mn),  lengths(get(paste0("conf_count_", yr, "_", mn)))     >  0)
      assign(paste0("nointersects_", yr, "_", mn),  lengths(get(paste0("conf_count_" , yr, "_", mn))) == 0)
      
      
      assign(paste0("conf_count_", yr, "_", mn, "_overlap"),
             filter(get(paste0("buffer_",dhs)), get(paste0("intersects_", yr, "_", mn)))
      )
      
      assign(paste0("conf_count_", yr,"_", mn, "_nooverlap"),
             filter(get(paste0("buffer_",dhs)), get(paste0("nointersects_", yr, "_", mn)))
      )
      
      suppressWarnings(
        assign(paste0("conflict_intersect_", yr, "_", mn),
               st_intersection(get(paste0('conf_count_', yr, "_", mn, "_overlap")) %>%  st_transform(crs = 20137),
                               get(paste0("conflicts_", yr, "_", mn))  %>% st_transform(crs = 20137)) %>%
                 st_transform(crs=4326)
        )
      )
      
      assign(paste0("DHS_", dhs ,"_conflict_intersect_", yr, "_", mn),
             get(paste0("conflict_intersect_", yr, "_", mn)) %>%
               bind_rows(get(paste0("conf_count_", yr,"_", mn, "_nooverlap"))) %>% 
               arrange(DHSCLUST) %>% 
               as_tibble() %>% 
               select(-geometry) %>% 
               mutate(year = ifelse(is.na(year), yr , year),
                      month=ifelse(is.na(month), mn , month),#for month NAs, which are not overlapped<<<<<<<<<<<<<<<<<<<<Check (Might try pivoting here)
                      civil_unrest = ifelse(is.na(civil_unrest), 0, civil_unrest),
                      violent_conflicts = ifelse(is.na(violent_conflicts), 0 , violent_conflicts)) %>% 
               rename(conflict_long= LONGNUM.1,
                      conflict_lat = LATNUM.1,
                      present_civil_unrest = civil_unrest,
                      present_violent_conflict = violent_conflicts,
                      conflict_year = year,
                      conflict_quarter = quarter,
                      conflict_month = month) 
      )
    }
  }
  
}


#For one dhs year complete calculation at a time : Use the loop below

# conflict_years <- unique(conflicts_all$year)
# 
# conflict_month <- c(1:12)
# 
# dhs_years <- dhs_years
# 
# for(yr in conflict_years){
#   
#   for(mn in conflict_month){
#     
#     assign(paste0("conflicts_", yr, "_", mn),
#            php_conflicts %>%
#              filter(!is.na(state_based_conf) |
#                       !is.na(one_sided_violence),
#                     year == yr,
#                     month== mn) %>%   
#              rename(LONGNUM=longitude, 
#                     LATNUM=latitude) %>%
#              st_as_sf(coords= c("LONGNUM", "LATNUM"), crs=4326) %>%
#              mutate(LONGNUM = st_coordinates(.)[, 1],
#                     LATNUM = st_coordinates(.)[, 2]) 
#     )
#     
#     assign(paste0("conf_count_", yr , "_", mn), 
#            st_intersects(buffer_2003 %>%  st_transform(crs = 3123) , 
#                          get(paste0("conflicts_", yr, "_", mn)) %>% st_transform(crs = 3123) ) 
#           
#     )
#     
#     assign(paste0("intersects_", yr, "_", mn),  lengths(get(paste0("conf_count_", yr, "_", mn)))     >  0)
#     assign(paste0("nointersects_", yr, "_", mn),  lengths(get(paste0("conf_count_" , yr, "_", mn))) == 0)
#     
#     
#     assign(paste0("conf_count_", yr, "_", mn, "_overlap"),
#            filter(buffer_2003, get(paste0("intersects_", yr, "_", mn)))
#     )
#     
#     assign(paste0("conf_count_", yr,"_", mn, "_nooverlap"),
#            filter(buffer_2003, get(paste0("nointersects_", yr, "_", mn)))
#     )
#     
#     suppressWarnings(
#       assign(paste0("conflict_intersect_", yr, "_", mn),
#              st_intersection(get(paste0('conf_count_', yr, "_", mn, "_overlap")) %>%  st_transform(crs = 3123),
#                              get(paste0("conflicts_", yr, "_", mn))  %>% st_transform(crs = 3123)) %>%
#                st_transform(crs=4326)
#       )
#     )
#     
#     assign(paste0("DHS_2003" ,"_conflict_intersect_", yr, "_", mn),
#            get(paste0("conflict_intersect_", yr, "_", mn)) %>%
#              bind_rows(get(paste0("conf_count_", yr,"_", mn, "_nooverlap"))) %>% 
#              arrange(DHSCLUST) %>% 
#              as_tibble() %>% 
#              select(-geometry) %>% 
#              mutate(year = ifelse(is.na(year), yr , year),
#                     month=ifelse(is.na(month), mn , month),#for month NAs, which are not overlapped<<<<<<<<<<<<<<<<<<<<Check (Might try pivoting here)
#                     state_based_conf = ifelse(is.na(state_based_conf), 0, state_based_conf),
#                     one_sided_violence = ifelse(is.na(one_sided_violence), 0 , one_sided_violence)) %>% 
#              rename(conflict_long= LONGNUM.1,
#                     conflict_lat = LATNUM.1,
#                     present_state_based_conf_fatalities = state_based_conf,
#                     present_one_sided_violence_fatalities = one_sided_violence,
#                     conflict_year = year,
#                     conflict_quarter = quarter,
#                     conflict_month = month) 
#     )
#   }
# }
################################################################################
################################################################################

#Okay
#paste0("DHS_", "2017" ,"_conflict_intersect_", 2003, "_", 2) %>%
# get() %>%
#filter(DHSCLUST==81) %>%
#distinct(conflict_month)

#Data lists at month and year level for all DHS Years

year_list_2000 <- list()
year_list_2000 = vector("list", length = length(conflict_years))

month_list_2000 <- list()
month_list_2000 <- vector("list", length=length(conflict_month))


year_list_2005 <- list()
year_list_2005 = vector("list", length = length(conflict_years))

month_list_2005 <- list()
month_list_2005 <- vector("list", length=length(conflict_month))

year_list_2010 <- list()
year_list_2010 = vector("list", length = length(conflict_years))

month_list_2010 <- list()
month_list_2010 <- vector("list", length=length(conflict_month))

year_list_2011 <- list()
year_list_2011 = vector("list", length = length(conflict_years))

month_list_2011 <- list()
month_list_2011 <- vector("list", length=length(conflict_month))

year_list_2016 <- list()
year_list_2016 = vector("list", length = length(conflict_years))

month_list_2016 <- list()
month_list_2016 <- vector("list", length=length(conflict_month))

year_list_2019 <- list()
year_list_2019 = vector("list", length = length(conflict_years))

month_list_2019 <- list()
month_list_2019 <- vector("list", length=length(conflict_month))


# For DHS-2000 final list

for(yr in conflict_years){
  
  year_list_2000[[yr]]  <-   year_list_2000
  
  for(mn in conflict_month){
    
    month_list_2000[[mn]]  <-
      get(paste0("DHS_", "2000","_conflict_intersect_", yr, "_", mn))
    
  }
  
  year_list_2000[[yr]] = bind_rows(month_list_2000)
  
}

# For DHS-2005 final list

for(yr in conflict_years){
  
  year_list_2005[[yr]]  <-   year_list_2005
  
  for(mn in conflict_month){
    
    month_list_2005[[mn]]  <-
      get(paste0("DHS_", "2005","_conflict_intersect_", yr, "_", mn))
    
  }
  
  year_list_2005[[yr]] = bind_rows(month_list_2005)
  
}

# For DHS-2010 final list

for(yr in conflict_years){
  
  year_list_2010[[yr]]  <-   year_list_2010
  
  for(mn in conflict_month){
    
    month_list_2010[[mn]]  <-
      get(paste0("DHS_", "2010","_conflict_intersect_", yr, "_", mn))
    
  }
  
  year_list_2010[[yr]] = bind_rows(month_list_2010)
  
}

# For DHS-2011 final list

for(yr in conflict_years){
  
  year_list_2011[[yr]]  <-   year_list_2011
  
  for(mn in conflict_month){
    
    month_list_2011[[mn]]  <-
      get(paste0("DHS_", "2011","_conflict_intersect_", yr, "_", mn))
    
  }
  
  year_list_2011[[yr]] = bind_rows(month_list_2011)
  
}

# For DHS-2016 final list

for(yr in conflict_years){
  
  year_list_2016[[yr]]  <-   year_list_2016
  
  for(mn in conflict_month){
    
    month_list_2016[[mn]]  <-
      get(paste0("DHS_", "2016","_conflict_intersect_", yr, "_", mn))
    
  }
  
  year_list_2016[[yr]] = bind_rows(month_list_2016)
  
}

# For DHS-2019 final list

for(yr in conflict_years){
  
  year_list_2019[[yr]]  <-   year_list_2019
  
  for(mn in conflict_month){
    
    month_list_2019[[mn]]  <-
      get(paste0("DHS_", "2019","_conflict_intersect_", yr, "_", mn))
    
  }
  
  year_list_2019[[yr]] = bind_rows(month_list_2019)
  
}

#Final 2000 Data table
final_data_DHS2000 = bind_rows(year_list_2000) %>% 
  mutate(civil_unrest_occured = ifelse(present_civil_unrest == 0, 0 , 1),
         violent_conflict_occurred = ifelse(present_violent_conflict == 0, 0 , 1)) %>% #Making separate indictors for state-based and one-sided violence
  rename(DHSQUARTER = QUARTER) %>% 
  mutate(conflict_quarter= ifelse(conflict_month %in% c(1:3), 1, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(4:6), 2, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(7:9), 3, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(10:12),4, conflict_quarter))

#Final 2005 Data table
final_data_DHS2005 = bind_rows(year_list_2005) %>% 
  mutate(civil_unrest_occured = ifelse(present_civil_unrest == 0, 0 , 1),
         violent_conflict_occurred = ifelse(present_violent_conflict == 0, 0 , 1)) %>% #Making separate indictors for state-based and one-sided violence
  rename(DHSQUARTER = QUARTER) %>% 
  mutate(conflict_quarter= ifelse(conflict_month %in% c(1:3), 1, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(4:6), 2, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(7:9), 3, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(10:12),4, conflict_quarter))

#Final 2010 Data table
final_data_DHS2010 = bind_rows(year_list_2010) %>% 
  mutate(civil_unrest_occured = ifelse(present_civil_unrest == 0, 0 , 1),
         violent_conflict_occurred = ifelse(present_violent_conflict == 0, 0 , 1)) %>% #Making separate indictors for state-based and one-sided violence
  rename(DHSQUARTER = QUARTER) %>% 
  mutate(conflict_quarter= ifelse(conflict_month %in% c(1:3), 1, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(4:6), 2, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(7:9), 3, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(10:12),4, conflict_quarter))

#Final 2011 Data table
final_data_DHS2011 = bind_rows(year_list_2011) %>% 
  mutate(civil_unrest_occured = ifelse(present_civil_unrest == 0, 0 , 1),
         violent_conflict_occurred = ifelse(present_violent_conflict == 0, 0 , 1)) %>% #Making separate indictors for state-based and one-sided violence
  rename(DHSQUARTER = QUARTER) %>% 
  mutate(conflict_quarter= ifelse(conflict_month %in% c(1:3), 1, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(4:6), 2, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(7:9), 3, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(10:12),4, conflict_quarter))

#Final 2016 Data table
final_data_DHS2016 = bind_rows(year_list_2016) %>% 
  mutate(civil_unrest_occured = ifelse(present_civil_unrest == 0, 0 , 1),
         violent_conflict_occurred = ifelse(present_violent_conflict == 0, 0 , 1)) %>% #Making separate indictors for state-based and one-sided violence
  rename(DHSQUARTER = QUARTER) %>% 
  mutate(conflict_quarter= ifelse(conflict_month %in% c(1:3), 1, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(4:6), 2, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(7:9), 3, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(10:12),4, conflict_quarter))

#Final 2019 Data table
final_data_DHS2019 = bind_rows(year_list_2019) %>% 
  mutate(civil_unrest_occured = ifelse(present_civil_unrest == 0, 0 , 1),
         violent_conflict_occurred = ifelse(present_violent_conflict == 0, 0 , 1)) %>% #Making separate indictors for state-based and one-sided violence
  rename(DHSQUARTER = QUARTER) %>% 
  mutate(conflict_quarter= ifelse(conflict_month %in% c(1:3), 1, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(4:6), 2, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(7:9), 3, conflict_quarter),
         conflict_quarter= ifelse(conflict_month %in% c(10:12),4, conflict_quarter))

################################################################################
#Whatever I change in terms of clusters, I will get 12 rows, NAs if no overlap
# final_data_DHS2017  %>% 
#     filter(DHSCLUST==1,
#            conflict_year==2019) %>% View()

################################################################################

#Final Datasets of 3 DHS years with complete time-series of conflicts

final_data_DHS2000 %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/buffer_conflict_2000.csv")


final_data_DHS2005 %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/buffer_conflict_2005.csv")


final_data_DHS2010 %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/buffer_conflict_2010.csv")

final_data_DHS2011 %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/buffer_conflict_2011.csv")


final_data_DHS2016 %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/buffer_conflict_2016.csv")


final_data_DHS2019 %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/buffer_conflict_2019.csv")

################################################################################

#Drawing buffered dhs points
buffer_2016 %>%
  mapview()

#Conflicts points exactly ON the dhs clusters now  #OKAY ALL
buffer_2005 %>% 
  filter(LONGNUM>0) %>% 
  select(-LONGNUM, -LATNUM) %>% 
  ggplot()+
  geom_sf() +
  geom_point(aes(conflict_long, conflict_lat), 
             size=2, 
             alpha=1,
             data=final_data_DHS2005 %>% 
               filter( 
                 !is.na(present_civil_unrest_fatalities),
                 violent_conflict_occurred != 0,
                 conflict_year == 2005)
  )



# conf_count_2003 <- st_intersects(buffer_2003, conflicts_1989)

# dim(conf_count_2003)  #Okay  (buffer , conflicts)

# intersects <-  lengths(conf_count_2003)  >  0
# no_intersects <-  lengths(conf_count_2003)  ==  0

# sum(intersects)
# sum(no_intersects)

# conf_count_2003_overlap <-
#        filter(buffer_2003, intersects)
# 
# conf_count_2003_nooverlap <-
#   filter(buffer_2003, no_intersects)
# 
# conflict_intersect_2003 <-
#   st_intersection(conf_count_2003_overlap %>%  st_transform(crs = 3123),
#                    conflicts_1989  %>% st_transform(crs = 3123)) %>%
#   st_transform(crs=4326)

# conflict_intersect_2003 <- 
# conflict_intersect_2003 %>%
#   bind_rows(conf_count_2003_nooverlap) %>% 
#   arrange(DHSCLUST) %>% 
#   as_tibble() %>% 
#   select(-geometry) %>% 
#   mutate(year = ifelse(is.na(year), 1989, year),
#          state_based_conf = ifelse(is.na(state_based_conf), 0, state_based_conf),
#          one_sided_violence = ifelse(is.na(one_sided_violence), 0 , one_sided_violence)) %>% 
#   rename(conflict_long= LONGNUM.1,
#          conflict_lat = LATNUM.1)



# conf_count_final_2003 <-
#        buffer_2003  %>%
#          st_join(conf_count_2003_overlap,
#                  join = st_equals,
#                  left = TRUE) %>%
#          mutate(conf_count = if_else(is.na(LATNUM.y), 0, 1))

# 
# 
# conflict_intersect_2003 <-
#   st_intersection(conflicts_all %>%  st_transform(crs = 3123),
#                   buffer_2003 %>% st_transform(crs = 3123)) %>%
#   st_transform(crs=4326)
# 
# conflict_intersect_2003$koala <- "Yes"
# 
# st_difference(conflict_intersect_2003 ,buffer_2003) %>% View()


# conflict_count_2003 <-
#   st_intersection(buffer_2003 %>%  st_transform(crs = 3123), 
#                   conflicts_all %>% st_transform(crs = 3123)) %>% 
#   st_transform(crs=4326) %>% 
#   arrange(year) %>% 
#   as_tibble() %>% 
#   select(-geometry)

# conflict_count_all <-
#   st_intersection(buffer_all_new %>%  st_transform(crs = 3123), 
#                   conflicts_all %>% st_transform(crs = 3123)) %>% 
#   st_transform(crs=4326) %>% 
#   arrange(year)

################################

#Exporting CSV conflicts time series overlaying buffers
# conflict_count_2003 <- 
# conflict_count_2003 %>%
#   as_tibble() %>% 
#   select(
#          DHSYEAR, DHSCLUST, DHSQUARTER = QUARTER, LONGNUM, LATNUM,  
#          conflict_year = year, 
#          conflict_quarter = quarter, 
#          conflict_month = month, 
#          present_state_based_conf = state_based_conf, 
#          present_one_sided_violence  = one_sided_violence,
#          conflict_longnum = LONGNUM.1,
#          conflict_latnum = LATNUM.1) %>%
#   arrange(DHSCLUST) %>% 
#   janitor::clean_names() 
#   


#roll sum to calculate future conflicts
# conflict_count_all %>% 
#   group_by(conflict_year,	conflict_quarter, conflict_latnum, conflict_longnum) %>% 
#   dplyr::mutate(future_statebased_conf = zoo::rollapply(state_based_conf,
#                                     3,
#                                     sum,
#                                     fill= NA,
#                                     align = "right"),
#                 future_onesided_conf = zoo::rollapply(one_sided_violence,
#                                            3,
#                                            sum,
#                                            fill= NA,
#                                            align = "right")
#                 # future_statebased_conf = future_statebased_conf - state_based_conf,
#                 # future_onesided_conf = future_onesided_conf - one_sided_violence
#          ) %>%
# # haven::write_dta("../output/conlflict_timeseries.dta")
#   write.csv("../xlsx/buffers/buffer_conflict_all.csv")

#Making presnt and future conflicts for merge in STATA
# For Instance: Philippines 2003 has quarters 2 and 3 in which HHds are interviewed
# year 2003: quarter 2 & 3
###########################Here

# Fr one DHS year at a time

# for(yr in conflict_years){
#   
#   for(mn in conflict_month){
#     
#     assign(paste0("conflicts_", yr, "_", mn),
#            php_conflicts %>%
#              filter(!is.na(state_based_conf) |
#                       !is.na(one_sided_violence),
#                     year == yr,
#                     month== mn) %>%   
#              rename(LONGNUM=longitude, 
#                     LATNUM=latitude) %>%
#              st_as_sf(coords= c("LONGNUM", "LATNUM"), crs=4326) %>%
#              mutate(LONGNUM = st_coordinates(.)[, 1],
#                     LATNUM = st_coordinates(.)[, 2]) 
#     )
#     
#     assign(paste0("conf_count_", yr , "_", mn), 
#            st_intersects(buffer_2003 %>%  st_transform(crs = 3123) , 
#                          get(paste0("conflicts_", yr, "_", mn)) %>% st_transform(crs = 3123) ) 
#            
#     )
#     
#     assign(paste0("intersects_", yr, "_", mn),  lengths(get(paste0("conf_count_", yr, "_", mn)))     >  0)
#     assign(paste0("nointersects_", yr, "_", mn),  lengths(get(paste0("conf_count_" , yr, "_", mn))) == 0)
#     
#     
#     assign(paste0("conf_count_", yr, "_", mn, "_overlap"),
#            filter(buffer_2003, get(paste0("intersects_", yr, "_", mn)))
#     )
#     
#     assign(paste0("conf_count_", yr,"_", mn, "_nooverlap"),
#            filter(buffer_2003, get(paste0("nointersects_", yr, "_", mn)))
#     )
#     
#     suppressWarnings(
#       assign(paste0("conflict_intersect_", yr, "_", mn),
#              st_intersection(get(paste0('conf_count_', yr, "_", mn, "_overlap")) %>%  st_transform(crs = 3123),
#                              get(paste0("conflicts_", yr, "_", mn))  %>% st_transform(crs = 3123)) %>%
#                st_transform(crs=4326)
#       )
#     )
#     
#     assign(paste0("DHS_2003" ,"_conflict_intersect_", yr, "_", mn),
#            get(paste0("conflict_intersect_", yr, "_", mn)) %>%
#              bind_rows(get(paste0("conf_count_", yr,"_", mn, "_nooverlap"))) %>% 
#              arrange(DHSCLUST) %>% 
#              as_tibble() %>% 
#              select(-geometry) %>% 
#              mutate(year = ifelse(is.na(year), yr , year),
#                     month=ifelse(is.na(month), mn , month),#for month NAs, which are not overlapped<<<<<<<<<<<<<<<<<<<<Check (Might try pivoting here)
#                     state_based_conf = ifelse(is.na(state_based_conf), 0, state_based_conf),
#                     one_sided_violence = ifelse(is.na(one_sided_violence), 0 , one_sided_violence)) %>% 
#              rename(conflict_long= LONGNUM.1,
#                     conflict_lat = LATNUM.1,
#                     present_state_based_conf_fatalities = state_based_conf,
#                     present_one_sided_violence_fatalities = one_sided_violence,
#                     conflict_year = year,
#                     conflict_quarter = quarter,
#                     conflict_month = month) 
#     )
#   }
# }