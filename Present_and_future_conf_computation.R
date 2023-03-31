# (All DHS clusters covered in quarter 3 and 4)
final_data_DHS2019 %>%   
  distinct(DHSQUARTER)

DHS2019_conflicts_civ_pf <- 
  
  final_data_DHS2019 %>% 
  filter(conflict_year == 2019 | conflict_year == 2020) %>% 
  select(-violent_conflict_occurred, -present_violent_conflict, -civil_unrest_occured) %>%
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)  %>% #conflict_month 
  summarise(number_of_civ_conflicts = sum(present_civil_unrest),
            .groups = "drop") %>%
  mutate(conflict_map = 
           case_when(
             (DHSYEAR == conflict_year) &  (DHSQUARTER==conflict_quarter) ~ "present_conflicts",
             (DHSYEAR == conflict_year) &  (DHSQUARTER<conflict_quarter ) ~ "future_conflicts",
             (DHSYEAR == conflict_year - 1) &  (conflict_quarter==1) &  (DHSQUARTER!=1) ~ "future_conflicts",
           )) %>% 
  filter(!is.na(conflict_map)) %>% 
  pivot_wider(names_from = conflict_map, values_from = number_of_civ_conflicts) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)

Final_DHS2019_conflicts_civ_pf <- 
  DHS2019_conflicts_civ_pf %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM) %>% 
  summarise(civ_present_number_of_conflicts = sum(present_conflicts, na.rm = T),
            civ_future_number_of_conflicts = sum(future_conflicts, na.rm= T),
            .groups = "drop") 

#Final data set for 2017 ouput in csv
Final_DHS2019_conflicts_civ_pf %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/Present_fut/FinalData_civ_2019_try2.csv")



##########For One-sided Violence######################

DHS2019_conflicts_viol_pf <- 
  
  final_data_DHS2019 %>% 
  filter(conflict_year == 2019 | conflict_year == 2020) %>% 
  select(-civil_unrest_occured, -violent_conflict_occurred,-present_civil_unrest) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter) %>%  #conflict_month 
  summarise(number_of_viol_conflicts = sum(present_violent_conflict),
            .groups = "drop") %>%
  mutate(conflict_map = 
           case_when(
             (DHSYEAR == conflict_year) &  (DHSQUARTER==conflict_quarter) ~ "present_conflicts",
             (DHSYEAR == conflict_year) &  (DHSQUARTER<conflict_quarter ) ~ "future_conflicts",
             (DHSYEAR == conflict_year - 1) &  (conflict_quarter==1) &  (DHSQUARTER!=1) ~ "future_conflicts",
           )) %>% 
  filter(!is.na(conflict_map)) %>% 
  pivot_wider(names_from = conflict_map, values_from = number_of_viol_conflicts) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)

Final_DHS2019_conflicts_viol_pf <- 
  DHS2019_conflicts_viol_pf %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM) %>% 
  summarise(present_number_of_viol_conflicts = sum(present_conflicts, na.rm = T),
            future_number_of_viol_conflicts = sum(future_conflicts, na.rm= T),
            .groups = "drop") 

#Final data set for 2017 ouput in csv
Final_DHS2019_conflicts_viol_pf %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/Present_fut/FinalData_viol_2019_try2.csv")

################################################################################  
################################################################################



################################################################################  
################################################################################
################################################################################
#For 2016  DHS
################################################################################  
################################################################################
################################################################################


################For civil unrest ####################

# (All DHS clusters covered in quarter 3 and 4)

#final_data_DHS2016 <-
# read.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/buffer_conflict_2016.csv")

final_data_DHS2016 %>%   
  distinct(DHSQUARTER)

DHS2016_conflicts_civ_pf <- 
  
  final_data_DHS2016 %>% #filter(conflict_year == 2017 & DHSCLUST == 1) %>% View()
  filter(conflict_year == 2016 | conflict_year == 2017) %>% 
  select(-violent_conflict_occurred, -present_violent_conflict, -civil_unrest_occured) %>%
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)  %>% #conflict_month 
  summarise(number_of_civ_conflicts = sum(present_civil_unrest),
            .groups = "drop") %>%
  mutate(conflict_map = 
           case_when(
             (DHSYEAR == conflict_year) &  (DHSQUARTER==conflict_quarter) ~ "present_conflicts",
             (DHSYEAR == conflict_year) &  (DHSQUARTER<conflict_quarter ) ~ "future_conflicts",
             (DHSYEAR == conflict_year - 1) &  (conflict_quarter==1) &  (DHSQUARTER!=1) ~ "future_conflicts",
           )) %>% 
  filter(!is.na(conflict_map)) %>% 
  pivot_wider(names_from = conflict_map, values_from = number_of_civ_conflicts) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)

Final_DHS2016_conflicts_civ_pf <- 
  DHS2016_conflicts_civ_pf %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM) %>% 
  summarise(civ_present_number_of_conflicts = sum(present_conflicts, na.rm = T),
            civ_future_number_of_conflicts = sum(future_conflicts, na.rm= T),
            .groups = "drop") 

#Final data set for 2017 ouput in csv
Final_DHS2016_conflicts_civ_pf %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/Present_fut/FinalData_civ_2016_try2.csv")


##########For One-sided Violence###################### line after mutate function need to be customized for each dhs round based on the quarters interview

DHS2016_conflicts_viol_pf <- 
  
  final_data_DHS2016 %>% 
  filter(conflict_year == 2016 | conflict_year == 2017) %>% 
  select(-civil_unrest_occured, -violent_conflict_occurred,-present_civil_unrest) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter) %>%  #conflict_month 
  summarise(number_of_viol_conflicts = sum(present_violent_conflict),
            .groups = "drop") %>%
  mutate(conflict_map = 
           case_when(
             (DHSYEAR == conflict_year) &  (DHSQUARTER==conflict_quarter) ~ "present_conflicts",
             (DHSYEAR == conflict_year) &  (DHSQUARTER<conflict_quarter ) ~ "future_conflicts",
             (DHSYEAR == conflict_year - 1) &  (conflict_quarter==1) &  (DHSQUARTER!=1) ~ "future_conflicts",
           )) %>% 
  filter(!is.na(conflict_map)) %>% 
  pivot_wider(names_from = conflict_map, values_from = number_of_viol_conflicts) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)

Final_DHS2016_conflicts_viol_pf <- 
  DHS2016_conflicts_viol_pf %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM) %>% 
  summarise(present_number_of_viol_conflicts = sum(present_conflicts, na.rm = T),
            future_number_of_viol_conflicts = sum(future_conflicts, na.rm= T),
            .groups = "drop") 

#Final data set for 2017 ouput in csv
Final_DHS2016_conflicts_viol_pf %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/Present_fut/FinalData_viol_2016_try2.csv")


################################################################################  
################################################################################
################################################################################
#For 2011  DHS
################################################################################  
################################################################################
################################################################################


################For civil unrest ####################


#final_data_DHS2011 <-
#  read.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/buffer_conflict_2011.csv")

final_data_DHS2011 %>%   
  distinct(DHSQUARTER)

DHS2011_conflicts_civ_pf <- 
  
  final_data_DHS2011 %>% #filter(conflict_year == 2012 & DHSCLUST == 1) %>% View()
  filter(conflict_year == 2011 | conflict_year == 2012) %>% 
  select(-violent_conflict_occurred, -present_violent_conflict, -civil_unrest_occured) %>%
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)  %>% #conflict_month 
  summarise(number_of_civ_conflicts = sum(present_civil_unrest),
            .groups = "drop") %>%
  mutate(conflict_map = 
           case_when(
             (DHSYEAR == conflict_year) &  (DHSQUARTER==conflict_quarter) ~ "present_conflicts",
             (DHSYEAR == conflict_year) &  (DHSQUARTER<conflict_quarter ) ~ "future_conflicts",
             (DHSYEAR == conflict_year - 1) &  (conflict_quarter==1) &  (DHSQUARTER!=1) ~ "future_conflicts",
           )) %>% 
  filter(!is.na(conflict_map)) %>% 
  pivot_wider(names_from = conflict_map, values_from = number_of_civ_conflicts) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)

Final_DHS2011_conflicts_civ_pf <- 
  DHS2011_conflicts_civ_pf %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM) %>% 
  summarise(civ_present_number_of_conflicts = sum(present_conflicts, na.rm = T),
            civ_future_number_of_conflicts = sum(future_conflicts, na.rm= T),
            .groups = "drop") 

#Final data set for 2012 ouput in csv
Final_DHS2011_conflicts_civ_pf %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/Present_fut/FinalData_civ_2011_try2.csv")


##########For One-sided Violence######################

DHS2011_conflicts_viol_pf <- 
  
  final_data_DHS2011 %>% 
  filter(conflict_year == 2011 | conflict_year == 2012) %>% 
  select(-civil_unrest_occured, -violent_conflict_occurred,-present_civil_unrest) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter) %>%  #conflict_month 
  summarise(number_of_viol_conflicts = sum(present_violent_conflict),
            .groups = "drop") %>%
  mutate(conflict_map = 
           case_when(
             (DHSYEAR == conflict_year) &  (DHSQUARTER==conflict_quarter) ~ "present_conflicts",
             (DHSYEAR == conflict_year) &  (DHSQUARTER<conflict_quarter ) ~ "future_conflicts",
             (DHSYEAR == conflict_year - 1) &  (conflict_quarter==1) &  (DHSQUARTER!=1) ~ "future_conflicts",
           )) %>% 
  filter(!is.na(conflict_map)) %>% 
  pivot_wider(names_from = conflict_map, values_from = number_of_viol_conflicts) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)

Final_DHS2011_conflicts_viol_pf <- 
  DHS2011_conflicts_viol_pf %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM) %>% 
  summarise(present_number_of_viol_conflicts = sum(present_conflicts, na.rm = T),
            future_number_of_viol_conflicts = sum(future_conflicts, na.rm= T),
            .groups = "drop") 

#Final data set for 2012 ouput in csv
Final_DHS2011_conflicts_viol_pf %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/Present_fut/FinalData_viol_2011_try2.csv")

################################################################################  
################################################################################
################################################################################
#For 2010  DHS
################################################################################  
################################################################################
################################################################################


################For civil unrest ####################
#final_data_DHS2010 <-
#read.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/buffer_conflict_2010.csv")

# (All DHS clusters covered in quarter 3 and 4)
final_data_DHS2010 %>%   
  distinct(DHSQUARTER)

DHS2010_conflicts_civ_pf <- 
  
  final_data_DHS2010 %>% #filter(conflict_year == 2011 & DHSCLUST == 1) %>% View()
  filter(conflict_year == 2010 | conflict_year == 2011) %>% 
  select(-violent_conflict_occurred, -present_violent_conflict, -civil_unrest_occured) %>%
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)  %>% #conflict_month 
  summarise(number_of_civ_conflicts = sum(present_civil_unrest),
            .groups = "drop") %>%
  mutate(conflict_map = 
           case_when(
             (DHSYEAR == conflict_year) &  (DHSQUARTER==conflict_quarter) ~ "present_conflicts",
             (DHSYEAR == conflict_year - 1) &  (conflict_quarter!= 4) ~ "future_conflicts",
           )) %>%  
  filter(!is.na(conflict_map)) %>% 
  pivot_wider(names_from = conflict_map, values_from = number_of_civ_conflicts) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)

Final_DHS2010_conflicts_civ_pf <- 
  DHS2010_conflicts_civ_pf %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM) %>% 
  summarise(civ_present_number_of_conflicts = sum(present_conflicts, na.rm = T),
            civ_future_number_of_conflicts = sum(future_conflicts, na.rm= T),
            .groups = "drop") 

#Final data set for 2011 ouput in csv
Final_DHS2010_conflicts_civ_pf %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/Present_fut/FinalData_civ_2010_try2.csv")


##########For One-sided Violence######################

DHS2010_conflicts_viol_pf <- 
  
  final_data_DHS2010 %>% 
  filter(conflict_year == 2010 | conflict_year == 2011) %>% 
  select(-civil_unrest_occured, -violent_conflict_occurred,-present_civil_unrest) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter) %>%  #conflict_month 
  summarise(number_of_viol_conflicts = sum(present_violent_conflict),
            .groups = "drop") %>%
  mutate(conflict_map = 
           case_when(
             (DHSYEAR == conflict_year) &  (DHSQUARTER==conflict_quarter) ~ "present_conflicts",
             (DHSYEAR == conflict_year - 1) &  (conflict_quarter!= 4) ~ "future_conflicts",
           )) %>% 
  filter(!is.na(conflict_map)) %>% 
  pivot_wider(names_from = conflict_map, values_from = number_of_viol_conflicts) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)

Final_DHS2010_conflicts_viol_pf <- 
  DHS2010_conflicts_viol_pf %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM) %>% 
  summarise(present_number_of_viol_conflicts = sum(present_conflicts, na.rm = T),
            future_number_of_viol_conflicts = sum(future_conflicts, na.rm= T),
            .groups = "drop") 

#Final data set for 2011 ouput in csv
Final_DHS2010_conflicts_viol_pf %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/Present_fut/FinalData_viol_2010_try2.csv")



################################################################################  
################################################################################
################################################################################
#For 2005  DHS
################################################################################  
################################################################################
################################################################################

################For civil unrest ####################
#final_data_DHS2005 <-
#read.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/buffer_conflict_2005.csv")

# (All DHS clusters covered in quarter 3 and 4)
final_data_DHS2005 %>%   
  distinct(DHSQUARTER)


DHS2005_conflicts_civ_pf <- 
  
  final_data_DHS2005 %>% #filter(conflict_year == 2006 & DHSCLUST == 1) %>% View()
  filter(conflict_year == 2005 | conflict_year == 2006) %>% 
  select(-violent_conflict_occurred, -present_violent_conflict, -civil_unrest_occured) %>%
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)  %>% #conflict_month 
  summarise(number_of_civ_conflicts = sum(present_civil_unrest),
            .groups = "drop")  %>%
  mutate(conflict_map = 
           case_when(
             (DHSYEAR == conflict_year) &  (DHSQUARTER==conflict_quarter) ~ "present_conflicts",
             (DHSYEAR == conflict_year) &  (DHSQUARTER<conflict_quarter ) ~ "future_conflicts",
             (DHSYEAR == conflict_year - 1) &  (conflict_quarter==1) &  (DHSQUARTER!=1) ~ "future_conflicts",
             (DHSYEAR == conflict_year - 1) &  (DHSQUARTER>conflict_quarter) ~ "future_conflicts",
           )) %>%
  filter(!is.na(conflict_map)) %>% 
  pivot_wider(names_from = conflict_map, values_from = number_of_civ_conflicts) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)

Final_DHS2005_conflicts_civ_pf <- 
  DHS2005_conflicts_civ_pf %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM) %>% 
  summarise(civ_present_number_of_conflicts = sum(present_conflicts, na.rm = T),
            civ_future_number_of_conflicts = sum(future_conflicts, na.rm= T),
            .groups = "drop") 

#Final data set for 2006 ouput in csv
Final_DHS2005_conflicts_civ_pf %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/Present_fut/FinalData_civ_2005_try2.csv")


##########For One-sided Violence######################

DHS2005_conflicts_viol_pf <- 
  
  final_data_DHS2005 %>% 
  filter(conflict_year == 2005 | conflict_year == 2006) %>% 
  select(-civil_unrest_occured, -violent_conflict_occurred,-present_civil_unrest) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter) %>%  #conflict_month 
  summarise(number_of_viol_conflicts = sum(present_violent_conflict),
            .groups = "drop") %>%
  mutate(conflict_map = 
           case_when(
             (DHSYEAR == conflict_year) &  (DHSQUARTER==conflict_quarter) ~ "present_conflicts",
             (DHSYEAR == conflict_year) &  (DHSQUARTER<conflict_quarter ) ~ "future_conflicts",
             (DHSYEAR == conflict_year - 1) &  (conflict_quarter==1) &  (DHSQUARTER!=1) ~ "future_conflicts",
             (DHSYEAR == conflict_year - 1) &  (DHSQUARTER>conflict_quarter) ~ "future_conflicts",
           )) %>% 
  filter(!is.na(conflict_map)) %>% 
  pivot_wider(names_from = conflict_map, values_from = number_of_viol_conflicts) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)

Final_DHS2005_conflicts_viol_pf <- 
  DHS2005_conflicts_viol_pf %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM) %>% 
  summarise(present_number_of_viol_conflicts = sum(present_conflicts, na.rm = T),
            future_number_of_viol_conflicts = sum(future_conflicts, na.rm= T),
            .groups = "drop") 

#Final data set for 2006 ouput in csv
Final_DHS2005_conflicts_viol_pf %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/Present_fut/FinalData_viol_2005_try2.csv")



################################################################################  
################################################################################
################################################################################
#For 2000  DHS
################################################################################  
################################################################################
################################################################################

################For civil unrest ####################
#final_data_DHS2000 <-
# read.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/buffer_conflict_2000.csv")

# (All DHS clusters covered in quarter 3 and 4)
final_data_DHS2000 %>%   
  distinct(DHSQUARTER)

DHS2000_conflicts_civ_pf <- 
  
  final_data_DHS2000 %>% #filter(conflict_year == 2001 & DHSCLUST == 1) %>% View()
  filter(conflict_year == 2000 | conflict_year == 2001) %>% 
  select(-violent_conflict_occurred, -present_violent_conflict, -civil_unrest_occured) %>%
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)  %>% #conflict_month 
  summarise(number_of_civ_conflicts = sum(present_civil_unrest),
            .groups = "drop") %>%
  mutate(conflict_map = 
           case_when(
             (DHSYEAR == conflict_year) &  (DHSQUARTER==conflict_quarter) ~ "present_conflicts",
             (DHSYEAR == conflict_year) &  (DHSQUARTER<conflict_quarter ) ~ "future_conflicts",
             (DHSYEAR == conflict_year - 1) &  (conflict_quarter==1) &  (DHSQUARTER!=1) ~ "future_conflicts",
           )) %>% 
  filter(!is.na(conflict_map)) %>% 
  pivot_wider(names_from = conflict_map, values_from = number_of_civ_conflicts) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)

Final_DHS2000_conflicts_civ_pf <- 
  DHS2000_conflicts_civ_pf %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM) %>% 
  summarise(civ_present_number_of_conflicts = sum(present_conflicts, na.rm = T),
            civ_future_number_of_conflicts = sum(future_conflicts, na.rm= T),
            .groups = "drop") 

#Final data set for 2001 ouput in csv
Final_DHS2000_conflicts_civ_pf %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/Present_fut/FinalData_civ_2000_try2.csv")


##########For One-sided Violence######################

DHS2000_conflicts_viol_pf <- 
  
  final_data_DHS2000 %>% 
  filter(conflict_year == 2000 | conflict_year == 2001) %>% 
  select(-civil_unrest_occured, -violent_conflict_occurred,-present_civil_unrest) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter) %>%  #conflict_month 
  summarise(number_of_viol_conflicts = sum(present_violent_conflict),
            .groups = "drop") %>%
  mutate(conflict_map = 
           case_when(
             (DHSYEAR == conflict_year) &  (DHSQUARTER==conflict_quarter) ~ "present_conflicts",
             (DHSYEAR == conflict_year) &  (DHSQUARTER<conflict_quarter ) ~ "future_conflicts",
             (DHSYEAR == conflict_year - 1) &  (conflict_quarter==1) &  (DHSQUARTER!=1) ~ "future_conflicts",
           )) %>% 
  filter(!is.na(conflict_map)) %>% 
  pivot_wider(names_from = conflict_map, values_from = number_of_viol_conflicts) %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM,
           conflict_year, conflict_quarter)

Final_DHS2000_conflicts_viol_pf <- 
  DHS2000_conflicts_viol_pf %>% 
  group_by(DHSYEAR, DHSCLUST, DHSQUARTER, LONGNUM, LATNUM) %>% 
  summarise(present_number_of_viol_conflicts = sum(present_conflicts, na.rm = T),
            future_number_of_viol_conflicts = sum(future_conflicts, na.rm= T),
            .groups = "drop") 

#Final data set for 2001 ouput in csv
Final_DHS2000_conflicts_viol_pf %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/Present_fut/FinalData_viol_2000_try2.csv")





#To  make combined data set of present and futue conflicts of all dhsyears

Final_2000 <-
  
  Final_DHS2000_conflicts_viol_pf %>% 
  left_join(Final_DHS2000_conflicts_civ_pf, 
            by=c("DHSYEAR", "DHSCLUST", "DHSQUARTER", "LONGNUM", "LATNUM")) 

Final_2005 <-
  
  Final_DHS2005_conflicts_viol_pf %>% 
  left_join(Final_DHS2005_conflicts_civ_pf, 
            by=c("DHSYEAR", "DHSCLUST", "DHSQUARTER", "LONGNUM", "LATNUM")) 



Final_2010 <-
  
  Final_DHS2010_conflicts_viol_pf %>% 
  left_join(Final_DHS2010_conflicts_civ_pf, 
            by=c("DHSYEAR", "DHSCLUST", "DHSQUARTER", "LONGNUM", "LATNUM")) 


Final_2011 <-
  
  Final_DHS2011_conflicts_viol_pf %>% 
  left_join(Final_DHS2011_conflicts_civ_pf, 
            by=c("DHSYEAR", "DHSCLUST", "DHSQUARTER", "LONGNUM", "LATNUM")) 

Final_2016 <-
  
  Final_DHS2016_conflicts_viol_pf %>% 
  left_join(Final_DHS2016_conflicts_civ_pf, 
            by=c("DHSYEAR", "DHSCLUST", "DHSQUARTER", "LONGNUM", "LATNUM")) 


Final_2019 <-
  
  Final_DHS2019_conflicts_viol_pf %>% 
  left_join(Final_DHS2019_conflicts_civ_pf, 
            by=c("DHSYEAR", "DHSCLUST", "DHSQUARTER", "LONGNUM", "LATNUM")) 


#Final combined dataset
FinalData_OSV_SBV_ALLYEARS <-
  
  Final_2019 %>% 
  bind_rows(Final_2016) %>% 
  bind_rows(Final_2011) %>% 
  bind_rows(Final_2010) %>% 
  bind_rows(Final_2005) %>% 
  bind_rows(Final_2000)


FinalData_OSV_SBV_ALLYEARS %>% 
  write.csv("E:/WORK ROMA/African Obsevatory/Ethiopia/New FAO- Alberta strategy/conflict buffers/Present_fut/FinalData_VIOL_CIV_ALLYEARS_try2.csv")


