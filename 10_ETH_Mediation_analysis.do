clear
clear matrix
clear mata
set maxvar 20000
use "D:\OneDrive - CGIAR\ClimBer\Ethiopia\New FAO- Alberta strategy\Final Data\ETH_final_complete.dta" 

******************************************************************
// Climate Variables
******************************************************************

* STATES
tab NAME_1_ID
rename NAME_1_ID region_id
*encode state, gen (state_id)
*drop N_States N_States_ID

* dummy conflict 
   
gen dummy_vio_pres = 0

replace dummy_vio_pres = 1 if conf_pres_viol > 0 

gen dummy_vio_fut = 0

replace dummy_vio_fut = 1 if conf_fut_viol > 0 


gen dummy_civ_pres = 0

replace dummy_civ_pres = 1 if conf_pres_civ > 0

gen dummy_civ_fut = 0

replace dummy_civ_fut = 1 if conf_fut_civ > 0 


gen log_Livestock_Sheep = log(Livestock_Sheep + 1) 
gen log_Maize_white = log(Maize_white + 1) 
gen log_Sorghum = log(Sorghum + 1) // millet 
gen log_Wheat = log(Wheat + 1) 
gen log_Livestock_Sheep_usd= log(Livestock_Sheep_usd + 1) 
gen log_Maize_white_usd= log(Maize_white_usd + 1) 
gen log_usd_Sorghum = log(usd_Sorghum + 1) 
gen log_usd_Wheat = log(usd_Wheat + 1) 


        

/*
* SPEI DUMMIES 
gen spei9_dummy= (spei9<=-1) | (spei9>=1)
gen spei9_pos_dummy=  (spei9>=1)
gen spei9_neg_dummy=  (spei9<=-1)
gen spei6_dummy= (spei6<=-1) | (spei6>=1)
gen spei6_pos_dummy=  (spei6>=1)
gen spei6_neg_dummy=  (spei6<=-1)
gen spei3_dummy= (spei3<=-1) | (spei3>=1)
gen spei3_pos_dummy=  (spei3>=1)
gen spei3_neg_dummy=  (spei3<=-1)
*/
* TEMP DUMMIES
gen anom_tmax12_pos= 1 if anom_tmax_12 >0 & anom_tmax_12!=.
replace anom_tmax12_pos=0 if anom_tmax_12<0 & anom_tmax_12!=.
gen anom_tmax9_pos= 1 if anom_tmax_9 >0 & anom_tmax_9!=.
replace anom_tmax9_pos=0 if anom_tmax_9<0 & anom_tmax_9!=.
gen anom_tmax6_pos= 1 if anom_tmax_6 >0 & anom_tmax_6!=.
replace anom_tmax6_pos=0 if anom_tmax_6<0 & anom_tmax_6!=.
gen anom_tmax3_pos= 1 if anom_tmax_3 >0 & anom_tmax_3!=.
replace anom_tmax3_pos=0 if anom_tmax_3<0 & anom_tmax_3!=.

* TEMP POSITIVE CONTINUOUS
gen anom_tmax3_POS = anom_tmax_3 if anom_tmax_3 >0 
replace anom_tmax3_POS =0 if anom_tmax_3<=0 & anom_tmax_3!=. 
gen anom_tmax6_POS = anom_tmax_6 if anom_tmax_6 >0 
replace anom_tmax6_POS =0 if anom_tmax_6<=0 & anom_tmax_6!=. 
gen anom_tmax9_POS = anom_tmax_9 if anom_tmax_9 >0 
replace anom_tmax9_POS =0 if anom_tmax_9<=0 & anom_tmax_9!=.
gen anom_tmax12_POS = anom_tmax_12 if anom_tmax_12 >0 
replace anom_tmax12_POS =0 if anom_tmax_12<=0 & anom_tmax_12!=.

* TEMP EXTREME 12
xtile temp_quartile_2=anom_tmax_12 if anom_tmax_12>0,n(4)
gen temp_Q1_12=0
gen temp_Q2_12=0
gen temp_Q3_12=0
gen temp_Q4_12=0
replace temp_Q1_12=anom_tmax_12 if temp_quartile_2==1
replace temp_Q2_12=anom_tmax_12 if temp_quartile_2==2
replace temp_Q3_12=anom_tmax_12 if temp_quartile_2==3
replace temp_Q4_12=anom_tmax_12 if temp_quartile_2==4
replace temp_Q1_12=. if anom_tmax_12==. 
replace temp_Q2_12=. if anom_tmax_12==. 
replace temp_Q3_12=. if anom_tmax_12==. 
replace temp_Q4_12=. if anom_tmax_12==. 

gen dummy_temp_ext_12 = 0 
replace dummy_temp_ext_12= 1 if temp_Q3_12 > 0 | temp_Q4_12 > 0 

* TEMP EXTREME 9 QUARTILE
xtile temp_quartile_=anom_tmax_9 if anom_tmax_9>0,n(4)
gen temp_Q1_9=0
gen temp_Q2_9=0
gen temp_Q3_9=0
gen temp_Q4_9=0
replace temp_Q1_9=anom_tmax_9 if temp_quartile_==1
replace temp_Q2_9=anom_tmax_9 if temp_quartile_==2
replace temp_Q3_9=anom_tmax_9 if temp_quartile_==3
replace temp_Q4_9=anom_tmax_9 if temp_quartile_==4
replace temp_Q1_9=. if anom_tmax_9==. 
replace temp_Q2_9=. if anom_tmax_9==. 
replace temp_Q3_9=. if anom_tmax_9==. 
replace temp_Q4_9=. if anom_tmax_9==. 

gen dummy_temp_ext_9 = 0 
replace dummy_temp_ext_9= 1 if temp_Q3_9 > 0 | temp_Q4_9 > 0 


* TEMP EXTREME 9 TERTILE
xtile temp_quartile_4=anom_tmax_9 if anom_tmax_9>0,n(3)
gen tert_temp_Q1_9=0
gen tert_temp_Q2_9=0
gen tert_temp_Q3_9=0
replace tert_temp_Q1_9=anom_tmax_9 if temp_quartile_4==1
replace tert_temp_Q2_9=anom_tmax_9 if temp_quartile_4==2
replace tert_temp_Q3_9=anom_tmax_9 if temp_quartile_4==3
replace tert_temp_Q1_9=. if anom_tmax_9==. 
replace tert_temp_Q2_9=. if anom_tmax_9==. 
replace tert_temp_Q3_9=. if anom_tmax_9==. 

* TEMP EXTREME 6
xtile temp_quartile_1=anom_tmax_6 if anom_tmax_6>0,n(4)
gen temp_Q1_6=0
gen temp_Q2_6=0
gen temp_Q3_6=0
gen temp_Q4_6=0
replace temp_Q1_6=anom_tmax_6 if temp_quartile_1==1
replace temp_Q2_6=anom_tmax_6 if temp_quartile_1==2
replace temp_Q3_6=anom_tmax_6 if temp_quartile_1==3
replace temp_Q4_6=anom_tmax_6 if temp_quartile_1==4
replace temp_Q1_6=. if anom_tmax_6==. 
replace temp_Q2_6=. if anom_tmax_6==. 
replace temp_Q3_6=. if anom_tmax_6==. 
replace temp_Q4_6=. if anom_tmax_6==. 

gen dummy_temp_ext_6 = 0 
replace dummy_temp_ext_6= 1 if temp_Q3_6 > 0 | temp_Q4_6 > 0 


* TEMP EXTREME 3
xtile temp_quartile_3=anom_tmax_3 if anom_tmax_3>0,n(4)
gen temp_Q1_3=0
gen temp_Q2_3=0
gen temp_Q3_3=0
gen temp_Q4_3=0
replace temp_Q1_3=anom_tmax_3 if temp_quartile_3==1
replace temp_Q2_3=anom_tmax_3 if temp_quartile_3==2
replace temp_Q3_3=anom_tmax_3 if temp_quartile_3==3
replace temp_Q4_3=anom_tmax_3 if temp_quartile_3==4
replace temp_Q1_3=. if anom_tmax_3==. 
replace temp_Q2_3=. if anom_tmax_3==. 
replace temp_Q3_3=. if anom_tmax_3==. 
replace temp_Q4_3=. if anom_tmax_3==. 

gen dummy_temp_ext_3 = 0 
replace dummy_temp_ext_3= 1 if temp_Q3_3 > 0 | temp_Q4_3 > 0 




* RAIN DUMMIES - NEG and POS
gen anom_rain9_pos= 1 if anom_rain_9 >0 & anom_rain_9!=.
replace anom_rain9_pos=0 if anom_rain_9<0 & anom_rain_9!=.
gen anom_rain6_pos= 1 if anom_rain_6 >0 & anom_rain_6!=.
replace anom_rain6_pos=0 if anom_rain_6<0 & anom_rain_6!=.
gen anom_rain3_pos= 1 if anom_rain_3 >0 & anom_rain_3!=.
replace anom_rain3_pos=0 if anom_rain_3<0 & anom_rain_3!=.
gen anom_rain9_neg= 1 if anom_rain_9 <0 & anom_rain_9!=.
replace anom_rain9_neg=0 if anom_rain_9>0 & anom_rain_9!=.
gen anom_rain6_neg= 1 if anom_rain_6 <0 & anom_rain_6!=.
replace anom_rain6_neg=0 if anom_rain_6>0 & anom_rain_6!=.
gen anom_rain3_neg= 1 if anom_rain_3 <0 & anom_rain_3!=.
replace anom_rain3_neg=0 if anom_rain_3>0 & anom_rain_3!=.
gen anom_rain12_neg= 1 if anom_rain_12 <0 & anom_rain_12!=.
replace anom_rain12_neg=0 if anom_rain_12>0 & anom_rain_12!=.

* RAIN POSITIVE AND NEGATIVE CONTINUOUS

gen anom_rain3_NEG = anom_rain_3 if anom_rain_3 <0 
replace anom_rain3_NEG =0 if anom_rain_3>=0 & anom_rain_3!=.

gen anom_rain12_NEG = anom_rain_12 if anom_rain_12 <0 
replace anom_rain12_NEG =0 if anom_rain_12>=0 & anom_rain_12!=.

gen anom_rain12_POS = anom_rain_12 if anom_rain_12 >0 
replace anom_rain12_POS =0 if anom_rain_12<=0 & anom_rain_12!=.

gen anom_rain9_POS = anom_rain_9 if anom_rain_9 >0 
replace anom_rain9_POS =0 if anom_rain_9<=0 & anom_rain_9!=.
gen anom_rain9_NEG = anom_rain_9 if anom_rain_9 <0 
replace anom_rain9_NEG =0 if anom_rain_9>=0 & anom_rain_9!=.
gen anom_rain6_NEG = anom_rain_6 if anom_rain_6 <0 
replace anom_rain6_NEG =0 if anom_rain_6>=0 & anom_rain_6!=.
gen anom_rain6_POS = anom_rain_6 if anom_rain_6 >0 
replace anom_rain6_POS =0 if anom_rain_6 <=0 & anom_rain_6!=.
gen anom_rain3_POS = anom_rain_3 if anom_rain_3 >0 
replace anom_rain3_POS =0 if anom_rain_3<=0 & anom_rain_3!=.

* RAIN EXTREME 12 NEGATIVE 
xtile rain_quartile_12=anom_rain_12 if anom_rain_12<0,n(4)
gen rain_Q1_12=0 // most negative one
gen rain_Q2_12=0
gen rain_Q3_12=0
gen rain_Q4_12=0
replace rain_Q1_12=anom_rain_12 if rain_quartile_12==1
replace rain_Q2_12=anom_rain_12 if rain_quartile_12==2
replace rain_Q3_12=anom_rain_12 if rain_quartile_12==3
replace rain_Q4_12=anom_rain_12 if rain_quartile_12==4
replace rain_Q1_12=. if anom_rain_12==. 
replace rain_Q2_12=. if anom_rain_12==. 
replace rain_Q3_12=. if anom_rain_12==. 
replace rain_Q4_12=. if anom_rain_12==. 

gen dummy_neg_rain_ext_12 = 0 
replace dummy_neg_rain_ext_12= 1 if rain_Q2_12 < 0 | rain_Q1_12 < 0 



* RAIN EXTREME 9 NEGATIVE
xtile rain_quartile_9=anom_rain_9 if anom_rain_9<0,n(4)
gen rain_Q1_9=0 // most negative one
gen rain_Q2_9=0
gen rain_Q3_9=0
gen rain_Q4_9=0
replace rain_Q1_9=anom_rain_9 if rain_quartile_9==1
replace rain_Q2_9=anom_rain_9 if rain_quartile_9==2
replace rain_Q3_9=anom_rain_9 if rain_quartile_9==3
replace rain_Q4_9=anom_rain_9 if rain_quartile_9==4
replace rain_Q1_9=. if anom_rain_9==. 
replace rain_Q2_9=. if anom_rain_9==. 
replace rain_Q3_9=. if anom_rain_9==. 
replace rain_Q4_9=. if anom_rain_9==. 

gen dummy_neg_rain_ext_9 = 0 
replace dummy_neg_rain_ext_9= 1 if rain_Q2_9 < 0 | rain_Q1_9 < 0 



* RAIN EXTREME 6 NEGATIVE
xtile rain_quartile_6=anom_rain_6 if anom_rain_6<0,n(4)
gen rain_Q1_6=0 // most negative one
gen rain_Q2_6=0
gen rain_Q3_6=0
gen rain_Q4_6=0
replace rain_Q1_6=anom_rain_6 if rain_quartile_6==1
replace rain_Q2_6=anom_rain_6 if rain_quartile_6==2
replace rain_Q3_6=anom_rain_6 if rain_quartile_6==3
replace rain_Q4_6=anom_rain_6 if rain_quartile_6==4
replace rain_Q1_6=. if anom_rain_6==. 
replace rain_Q2_6=. if anom_rain_6==. 
replace rain_Q3_6=. if anom_rain_6==. 
replace rain_Q4_6=. if anom_rain_6==. 

gen dummy_neg_rain_ext_6 = 0 
replace dummy_neg_rain_ext_6= 1 if rain_Q2_6 < 0 | rain_Q1_6 < 0 


* RAIN EXTREME 3 NEGATIVE
xtile rain_quartile_3=anom_rain_3 if anom_rain_3<0,n(4)
gen rain_Q1_3=0 // most negative one
gen rain_Q2_3=0
gen rain_Q3_3=0
gen rain_Q4_3=0
replace rain_Q1_3=anom_rain_3 if rain_quartile_3==1
replace rain_Q2_3=anom_rain_3 if rain_quartile_3==2
replace rain_Q3_3=anom_rain_3 if rain_quartile_3==3
replace rain_Q4_3=anom_rain_3 if rain_quartile_3==4
replace rain_Q1_3=. if anom_rain_3==. 
replace rain_Q2_3=. if anom_rain_3==. 
replace rain_Q3_3=. if anom_rain_3==. 
replace rain_Q4_3=. if anom_rain_3==. 

gen dummy_neg_rain_ext_3 = 0 
replace dummy_neg_rain_ext_3= 1 if rain_Q2_3 < 0 | rain_Q1_3 < 0 

* RAIN EXTREME 12 POS CONTINUOUS
xtile rain_quartile_12pos=anom_rain_12 if anom_rain_12>0,n(4)
gen rain_Q1_12_pos=0 
gen rain_Q2_12_pos=0
gen rain_Q3_12_pos=0
gen rain_Q4_12_pos=0 // most positive one
replace rain_Q1_12_pos=anom_rain_12 if rain_quartile_12pos==1
replace rain_Q2_12_pos=anom_rain_12 if rain_quartile_12pos==2
replace rain_Q3_12_pos=anom_rain_12 if rain_quartile_12pos==3
replace rain_Q4_12_pos=anom_rain_12 if rain_quartile_12pos==4
replace rain_Q1_12_pos=. if anom_rain_12==. 
replace rain_Q2_12_pos=. if anom_rain_12==. 
replace rain_Q3_12_pos=. if anom_rain_12==. 
replace rain_Q4_12_pos=. if anom_rain_12==. 

* RAIN EXTREME 12 POSITIVE DUMMY
gen dummy_rain_12_ext_pos = 0
replace dummy_rain_12_ext_pos=1 if rain_Q4_12_pos>0 | rain_Q3_12_pos>0


* RAIN EXTREME 9 POS CONTINUOUS
xtile rain_quartile_9pos=anom_rain_9 if anom_rain_9>0,n(4)
gen rain_Q1_9_pos=0 
gen rain_Q2_9_pos=0
gen rain_Q3_9_pos=0
gen rain_Q4_9_pos=0 // most positive one
replace rain_Q1_9_pos=anom_rain_9 if rain_quartile_9pos==1
replace rain_Q2_9_pos=anom_rain_9 if rain_quartile_9pos==2
replace rain_Q3_9_pos=anom_rain_9 if rain_quartile_9pos==3
replace rain_Q4_9_pos=anom_rain_9 if rain_quartile_9pos==4
replace rain_Q1_9_pos=. if anom_rain_9==. 
replace rain_Q2_9_pos=. if anom_rain_9==. 
replace rain_Q3_9_pos=. if anom_rain_9==. 
replace rain_Q4_9_pos=. if anom_rain_9==. 

* RAIN EXTREME 9 POSITIVE DUMMY
gen dummy_rain_9_ext_pos = 0
replace dummy_rain_9_ext_pos=1 if rain_Q4_9_pos>0 | rain_Q3_9_pos>0



* RAIN EXTREME 6 POS CONTINUOUS
xtile rain_quartile_6pos=anom_rain_6 if anom_rain_6>0,n(4)
gen rain_Q1_6_pos=0 
gen rain_Q2_6_pos=0
gen rain_Q3_6_pos=0
gen rain_Q4_6_pos=0 // most positive one
replace rain_Q1_6_pos=anom_rain_6 if rain_quartile_6pos==1
replace rain_Q2_6_pos=anom_rain_6 if rain_quartile_6pos==2
replace rain_Q3_6_pos=anom_rain_6 if rain_quartile_6pos==3
replace rain_Q4_6_pos=anom_rain_6 if rain_quartile_6pos==4
replace rain_Q1_6_pos=. if anom_rain_6==. 
replace rain_Q2_6_pos=. if anom_rain_6==. 
replace rain_Q3_6_pos=. if anom_rain_6==. 
replace rain_Q4_6_pos=. if anom_rain_6==. 

* RAIN EXTREME 6 POSITIVE DUMMY
gen dummy_rain_6_ext_pos = 0
replace dummy_rain_6_ext_pos=1 if rain_Q4_6_pos>0 | rain_Q3_6_pos>0


* RAIN EXTREME 3 POS CONTINUOUS
xtile rain_quartile_3pos=anom_rain_3 if anom_rain_3>0,n(4)
gen rain_Q1_3_pos=0 
gen rain_Q2_3_pos=0
gen rain_Q3_3_pos=0
gen rain_Q4_3_pos=0 // most positive one
replace rain_Q1_3_pos=anom_rain_3 if rain_quartile_3pos==1
replace rain_Q2_3_pos=anom_rain_3 if rain_quartile_3pos==2
replace rain_Q3_3_pos=anom_rain_3 if rain_quartile_3pos==3
replace rain_Q4_3_pos=anom_rain_3 if rain_quartile_3pos==4
replace rain_Q1_3_pos=. if anom_rain_3==. 
replace rain_Q2_3_pos=. if anom_rain_3==. 
replace rain_Q3_3_pos=. if anom_rain_3==. 
replace rain_Q4_3_pos=. if anom_rain_3==. 

* RAIN EXTREME 3 POSITIVE DUMMY
gen dummy_rain_3_ext_pos = 0
replace dummy_rain_3_ext_pos=1 if rain_Q4_3_pos>0 | rain_Q3_3_pos>0

   
* LOG
gen log_civ_pres = log(conf_pres_civ + 1)
gen log_civ_fut= log(conf_fut_civ +1)
gen log_vio_pres = log(conf_pres_viol + 1)
gen log_vio_fut= log(conf_fut_viol +1)

* INVERSE HYPERBOLIC sine transf (for right skewed vars with zeros and neg values)
gen ihs_civ_fut = log(conf_fut_civ + sqrt(conf_fut_civ^2 + 1))
gen ihs_civ_pres= log(conf_pres_civ + sqrt(conf_pres_civ^2 + 1))
gen ihs_vio_fut = log(conf_fut_viol + sqrt(conf_fut_viol^2 + 1))
gen ihs_vio_pres= log(conf_pres_viol + sqrt(conf_pres_viol^2 + 1))

* DUMMY TOTAL CONFLICT 
gen tot_conf_dummy_pres = 1 if conf_pres_civ==1 | conf_pres_viol==1
replace tot_conf_dummy_pres=0 if tot_conf_dummy_pres==.

* TOTAL CONFLICT 
egen tot_conf_future = rowtotal (conf_fut_civ conf_fut_viol)
egen tot_conf_present = rowtotal (conf_pres_civ conf_pres_viol)

gen ihs_tot_fut = log(tot_conf_future + sqrt(tot_conf_future^2 + 1))
gen ihs_tot_pres= log(tot_conf_present + sqrt(tot_conf_present^2 + 1))

* ETHNICITY
gen ethnic_diversity_sum = ethnic_diversity
egen ethnic_diversity_std = std(ethnic_diversity_sum)
replace ethnic_diversity_std=0 if ethnic_diversity_std==.
replace ethnic_diversity=0 if ethnic_diversity==.

* DUMMY ON POVERTY LEVELS
gen poverty = 1 if very_poor_hh>0.5 & very_poor_hh!=.
replace poverty= 0 if very_poor_hh<=0.5 & very_poor_hh!=.

* DUMMY ON RURAL URBAN
gen urban = 1 if urban_rural>0.5 & urban_rural!=.
replace urban= 0 if urban_rural<=0.5 & urban_rural!=.

* DUMMY ON AGRI WORK 
gen agri_work = 1 if dummy_agri_work>0.5 & dummy_agri_work!=.
replace agri_work= 0 if dummy_agri_work<=0.5 & dummy_agri_work!=.

* DUMMY ON WORK --- I SHOULD ALSO INCLUDE MAN 
gen work = 1 if dummy_wm_work>0.5 & dummy_wm_work!=.
replace work= 0 if dummy_wm_work<=0.5 & dummy_wm_work!=.

* DUMMY ON UNEMPLOYMENT  
gen unemployment = 1 if dummy_wm_unemployed>0.5 & dummy_wm_unemployed!=.
replace unemployment= 0 if dummy_wm_unemployed<=0.5 & dummy_wm_unemployed!=.

* DUMMY ON LAND 
gen agri_land = 1 if dummy_agr_land>0.5  & dummy_agr_land!=.
replace agri_land= 0 if dummy_agr_land<=0.5 & dummy_agr_land!=.

* DUMMY ELECTRICITY 
gen services = 1 if access_electricity>0.5 & access_electricity!=.
replace services= 0 if access_electricity<=0.5 & access_electricity!=.

* DUMMY BANK 
gen services_1 = 1 if bank_account>0.5 & bank_account!=.
replace services_1 = 0 if bank_account<=0.5 & bank_account!=.

* DUMMY SERVICES 
gen services_all = 1 if services==1 & services_1==1
replace services_all= 0 if services_all==.
replace services_all=. if services==. & services_1==.

/*
* MISSING FOOD 
replace new_meal_freq_TOT=. if new_meal_freq_sum==.
replace new_min_acc_diet_TOT=. if new_min_acc_diet_sum==.
replace new_dietary_diversity_TOT=. if new_dietary_diversity_sum==.

replace new_meal_freq_TOT_75=. if new_meal_freq_sum==.
replace new_min_acc_diet_TOT_75=. if new_min_acc_diet_sum==.
replace new_dietary_diversity_TOT_75=. if new_dietary_diversity_sum==.

replace new_meal_freq_TOT_25=. if new_meal_freq_sum==.
replace new_min_acc_diet_TOT_25=. if new_min_acc_diet_sum==.
replace new_dietary_diversity_TOT_25=. if new_dietary_diversity_sum==.

* RATIO FOOD
gen freq_ratio= (new_meal_freq_TOT/tot_clut)*100 if new_meal_freq_TOT!=.
gen div_ratio = (new_dietary_diversity_TOT/tot_clut)*100 if new_dietary_diversity_TOT!=.
*/
* DUMMY FOOD
gen freq_dummy= 1 if new_No_min_meal_freq_hh>0.5 & new_No_min_meal_freq_hh!=.
replace freq_dummy=0 if new_No_min_meal_freq_hh<=0.5 & new_No_min_meal_freq_hh!=.

gen div_dummy= 1 if new_No_min_diet_diversity_hh>0.5 & new_No_min_diet_diversity_hh!=.
replace div_dummy=0 if new_No_min_diet_diversity_hh<=0.5 & new_No_min_diet_diversity_hh!=.

gen acc_dummy= 1 if new_No_min_acc_diet_hh>0.5 & new_No_min_acc_diet_hh!=.
replace acc_dummy=0 if new_No_min_acc_diet_hh<=0.5 & new_No_min_acc_diet_hh!=.

 ****** EXTREMES BASED ON THE DISTRIBUTION*******

 

 gen dummy_rain12_ext25 = 0 
 replace dummy_rain12_ext25 = 1 if anom_rain_12 <=  -.1041278
 
  gen dummy_rain12_ext10 = 0 
 replace dummy_rain12_ext10 = 1 if anom_rain_12 <=   -.211048

  gen dummy_rain9_ext25 = 0 
 replace dummy_rain9_ext25 = 1 if anom_rain_9 <=   -.1161144 
 
  gen dummy_rain9_ext10 = 0 
 replace dummy_rain9_ext10= 1 if anom_rain_9 <=    -.2676151

 
  gen dummy_rain6_ext25 = 0 
 replace dummy_rain6_ext25 = 1 if anom_rain_6 <=  -.1390274
 
  gen dummy_rain6_ext10 = 0 
 replace dummy_rain6_ext10 = 1 if anom_rain_6 <=    -.3460249

  gen dummy_rain3_ext25 = 0 
 replace dummy_rain3_ext25 = 1 if anom_rain_3 <=  -.254624
 
  gen dummy_rain3_ext10 = 0 
 replace dummy_rain3_ext10 = 1 if anom_rain_3 <=   -.5246103

**** temperature****

 ****** EXTREMES BASED ON THE DISTRIBUTION*******
 
 gen dummy_tmax12_ext25 = 0 
 replace dummy_tmax12_ext25 = 1 if anom_tmax_12 >=  .1507666
 
  gen dummy_tmax12_ext10 = 0 
 replace dummy_tmax12_ext10 = 1 if anom_tmax_12 >=   .5753748

  gen dummy_tmax9_ext25 = 0 
 replace dummy_tmax9_ext25 = 1 if anom_tmax_9 >=    .2520666
 
  gen dummy_tmax9_ext10 = 0 
 replace dummy_tmax9_ext10= 1 if anom_tmax_9 >=    .6650752

 
  gen dummy_tmax6_ext25 = 0 
 replace dummy_tmax6_ext25 = 1 if anom_tmax_6 <=  .4779433
 
  gen dummy_tmax6_ext10 = 0 
 replace dummy_tmax6_ext10 = 1 if anom_tmax_6 <=    .7482074

  gen dummy_tmax3_ext25 = 0 
 replace dummy_tmax3_ext25 = 1 if anom_tmax_3 <=  .5624595
 
  gen dummy_tmax3_ext10 = 0 
 replace dummy_tmax3_ext10 = 1 if anom_tmax_3 <=   .9481357


gl tables "D:\OneDrive - CGIAR\ClimBer\Ethiopia\New FAO- Alberta strategy\Tables"



**** negative rainfall have a tricky interpretation, I create specular but poitive variables
gen anom_rain3_NEG_new = anom_rain3_NEG * -1
gen anom_rain6_NEG_new = anom_rain6_NEG * -1
gen anom_rain9_NEG_new = anom_rain9_NEG * -1
gen anom_rain12_NEG_new = anom_rain12_NEG * -1
 ex
gl control1v HH_size  urban work  log_vio_pres
gl control1c HH_size  urban work  log_civ_pres

gl control2v log_Maize_white urban work ethnic_diversity_std log_vio_pres

gl control2c log_Maize_white urban work ethnic_diversity_std log_civ_pres

replace region_id = 1 if region_id == 2 | region_id == 3
replace region_id = 4 if region_id==5 | region_id == 6
replace region_id = 7 if region_id==8
replace region_id = 9 if region_id == 10 | region_id == 11
replace region_id = 13 if region_id==14
replace region_id = 16 if region_id == 17 | region_id == 18
replace region_id = 19 if region_id == 20
replace region_id = 22 if region_id==23

*this to avoid that addis to be the base for the FE 
*ADDIS
replace region_id=2 if region_id ==1 
*AMHARA
replace region_id=1 if region_id==7
*AFAR
replace region_id=3 if region_id==4
*BEN-GUMZ
replace region_id=4 if region_id==9
*DIRE DAWA
replace region_id=5 if region_id==12
*GAMBELA
replace region_id=6 if region_id==13
*HARARI
replace region_id=7 if region_id==15
*OROMIA
replace region_id=8 if region_id==16
*SOMALI
replace region_id=9 if region_id==21
*TIGRAY
replace region_id=10 if region_id==22
*SNNP
replace region_id=11 if region_id==19




label define region_id 1 "AMHARA" 2 "ADDIS" 3 "AFAR" 4 "BEN-GUMZ" 5"DIRE DAWA" 6"GAMBELA" 7"HARARI" 8"OROMIA" 9"SOMALI" 10"TIGRAY" 11"SNNP"
lab values region_id region_id
ex

  
 ***** Food prices *****
 gl control1v urban log_vio_pres
 gl control2v urban log_vio_pres ethnic_diversity_std
 
 gl control1c urban log_civ_pres
 gl control2c urban log_civ_pres ethnic_diversity_std
 
rename anom_rain12_NEG_new rain_neg12

rename dummy_neg_rain_ext_12 rain_neg_ext12
rename dummy_neg_rain_ext_9 rain_neg_ext9
rename dummy_neg_rain_ext_6 rain_neg_ext6
rename dummy_neg_rain_ext_3 rain_neg_ext3

egen staple_crops= rowmean(Maize_white Sorghum Wheat)

 gen log_staple_crops = log(staple_crops + 1)

*Summary statistics table 

asdoc sum  urban ethnic_diversity_std  Maize_white Wheat conf_fut_viol conf_pres_viol conf_fut_civ conf_pres_civ anom_tmax12_POS anom_tmax9_POS anom_tmax6_POS anom_tmax3_POS anom_rain12_NEG_new anom_rain9_NEG_new anom_rain6_NEG_new anom_rain3_NEG_new rain_neg_ext12 rain_neg_ext9 rain_neg_ext6 rain_neg_ext3 , replace label tzok dec(3)
*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	

gl temp anom_tmax12_POS anom_tmax9_POS anom_tmax6_POS anom_tmax3_POS
gl temp_ext  dummy_temp_ext_12 dummy_temp_ext_9 dummy_temp_ext_6 dummy_temp_ext_3  
gl rainfall_neg rain_neg12 anom_rain9_NEG_new anom_rain6_NEG_new anom_rain3_NEG_new 
gl rain_neg_ext rain_neg_ext12 rain_neg_ext9 rain_neg_ext6 rain_neg_ext3
gl rainfall_pos anom_rain3_POS anom_rain6_POS anom_rain9_POS anom_rain12_POS


*Final Regression 
foreach var of global temp {

gsem (log_Maize_white<- `var' $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
    ( log_vio_fut<- log_Maize_white `var' $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent difficult

	
	estimates store main_`var'
	
	* Direct
nlcom  _b[ log_vio_fut:`var'], post
estimates store direct_`var'

* Indirect 
estimates restore main_`var'
nlcom _b[log_Maize_white:`var'] * _b[ log_vio_fut:log_Maize_white], post
estimates store indirect_`var'

* Total 
estimates restore main_`var'
nlcom _b[log_Maize_white:`var'] * _b[ log_vio_fut:log_Maize_white] + _b[ log_vio_fut:`var'], post
estimates store total_`var'

outreg2 [main_`var' direct_`var' indirect_`var' total_`var'] using "${tables}/temp_maize.xls", label append drop(i.quarter#i.year i.region_id) /*keep(No_min_meal_freq_hh `var' $control1 $control2)*/ dec(3) nocons 
}



*Final Regression 
foreach var of global temp_ext {

gsem (log_Maize_white<- `var' $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
    ( log_vio_fut<- log_Maize_white `var' $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent difficult

	
	estimates store main_`var'
	
	* Direct
nlcom  _b[ log_vio_fut:`var'], post
estimates store direct_`var'

* Indirect 
estimates restore main_`var'
nlcom _b[log_Maize_white:`var'] * _b[ log_vio_fut:log_Maize_white], post
estimates store indirect_`var'

* Total 
estimates restore main_`var'
nlcom _b[log_Maize_white:`var'] * _b[ log_vio_fut:log_Maize_white] + _b[ log_vio_fut:`var'], post
estimates store total_`var'

outreg2 [main_`var' direct_`var' indirect_`var' total_`var'] using "${tables}/temp_maize_ext.xls", label append drop(i.quarter#i.year i.region_id) /*keep(No_min_meal_freq_hh `var' $control1 $control2)*/ dec(3) nocons 
}




*Final regression

foreach var of global rainfall_neg {

gsem (log_Maize_white<- `var' $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
    ( log_vio_fut<- log_Maize_white `var' $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent difficult

	
	estimates store main_`var'
	
	* Direct
nlcom  _b[ log_vio_fut:`var'], post
estimates store direct_`var'

* Indirect 
estimates restore main_`var'
nlcom _b[log_Maize_white:`var'] * _b[ log_vio_fut:log_Maize_white], post
estimates store indirect_`var'

* Total 
estimates restore main_`var'
nlcom _b[log_Maize_white:`var'] * _b[ log_vio_fut:log_Maize_white] + _b[ log_vio_fut:`var'], post
estimates store total_`var'

outreg2 [main_`var' direct_`var' indirect_`var' total_`var'] using "${tables}/raifall_neg_maize.xls", label append drop(i.quarter#i.year i.region_id) /*keep(No_min_meal_freq_hh `var' $control1 $control2)*/ dec(3) nocons 
}
	
	
	
*Final regression

foreach var of global rain_neg_ext {

gsem (log_Maize_white<- `var' $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
    ( log_vio_fut<- log_Maize_white `var' $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent difficult

	
	estimates store main_`var'
	
	* Direct
nlcom  _b[ log_vio_fut:`var'], post
estimates store direct_`var'

* Indirect 
estimates restore main_`var'
nlcom _b[log_Maize_white:`var'] * _b[ log_vio_fut:log_Maize_white], post
estimates store indirect_`var'

* Total 
estimates restore main_`var'
nlcom _b[log_Maize_white:`var'] * _b[ log_vio_fut:log_Maize_white] + _b[ log_vio_fut:`var'], post
estimates store total_`var'

outreg2 [main_`var' direct_`var' indirect_`var' total_`var'] using "${tables}/raifall_neg_maiz_ext2.xls", label append drop(i.quarter#i.year i.region_id) /*keep(No_min_meal_freq_hh `var' $control1 $control2)*/ dec(3) nocons 
}
	

	
**** Wheat 


*Final Regression 
foreach var of global temp {

gsem (log_Wheat<- `var' $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
    ( log_vio_fut<- log_Wheat `var' $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent difficult

	
	estimates store main_`var'
	
	* Direct
nlcom  _b[ log_vio_fut:`var'], post
estimates store direct_`var'

* Indirect 
estimates restore main_`var'
nlcom _b[log_Wheat:`var'] * _b[ log_vio_fut:log_Wheat], post
estimates store indirect_`var'

* Total 
estimates restore main_`var'
nlcom _b[log_Wheat:`var'] * _b[ log_vio_fut:log_Wheat] + _b[ log_vio_fut:`var'], post
estimates store total_`var'

outreg2 [main_`var' direct_`var' indirect_`var' total_`var'] using "${tables}/temp_wheat.xls", label append drop(i.quarter#i.year i.region_id) /*keep(No_min_meal_freq_hh `var' $control1 $control2)*/ dec(3) nocons 
}



*Final Regression 
foreach var of global temp_ext {

gsem (log_Wheat<- `var' $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
    ( log_vio_fut<- log_Wheat `var' $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent difficult

	
	estimates store main_`var'
	
	* Direct
nlcom  _b[ log_vio_fut:`var'], post
estimates store direct_`var'

* Indirect 
estimates restore main_`var'
nlcom _b[log_Wheat:`var'] * _b[ log_vio_fut:log_Wheat], post
estimates store indirect_`var'

* Total 
estimates restore main_`var'
nlcom _b[log_Wheat:`var'] * _b[ log_vio_fut:log_Wheat] + _b[ log_vio_fut:`var'], post
estimates store total_`var'

outreg2 [main_`var' direct_`var' indirect_`var' total_`var'] using "${tables}/temp_wheat_ext.xls", label append drop(i.quarter#i.year i.region_id) /*keep(No_min_meal_freq_hh `var' $control1 $control2)*/ dec(3) nocons 
}




*Final regression

foreach var of global rainfall_neg {

gsem (log_Wheat<- `var' $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
    ( log_vio_fut<- log_Wheat `var' $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent difficult

	
	estimates store main_`var'
	
	* Direct
nlcom  _b[ log_vio_fut:`var'], post
estimates store direct_`var'

* Indirect 
estimates restore main_`var'
nlcom _b[log_Wheat:`var'] * _b[ log_vio_fut:log_Wheat], post
estimates store indirect_`var'

* Total 
estimates restore main_`var'
nlcom _b[log_Wheat:`var'] * _b[ log_vio_fut:log_Wheat] + _b[ log_vio_fut:`var'], post
estimates store total_`var'

outreg2 [main_`var' direct_`var' indirect_`var' total_`var'] using "${tables}/raifall_neg_wheate.xls", label append drop(i.quarter#i.year i.region_id) /*keep(No_min_meal_freq_hh `var' $control1 $control2)*/ dec(3) nocons 
}
	
	
	
*Final regression

foreach var of global rain_neg_ext {

gsem (log_Wheat<- `var' $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
    ( log_vio_fut<- log_Wheat `var' $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent difficult

	
	estimates store main_`var'
	
	* Direct
nlcom  _b[ log_vio_fut:`var'], post
estimates store direct_`var'

* Indirect 
estimates restore main_`var'
nlcom _b[log_Wheat:`var'] * _b[ log_vio_fut:log_Wheat], post
estimates store indirect_`var'

* Total 
estimates restore main_`var'
nlcom _b[log_Wheat:`var'] * _b[ log_vio_fut:log_Wheat] + _b[ log_vio_fut:`var'], post
estimates store total_`var'

outreg2 [main_`var' direct_`var' indirect_`var' total_`var'] using "${tables}/raifall_neg_wheat_ext.xls", label append drop(i.quarter#i.year i.region_id) /*keep(No_min_meal_freq_hh `var' $control1 $control2)*/ dec(3) nocons 
}
	



	
*Final regression

foreach var of global rainfall_pos {
gsem (stunting_ch_dummy <- `var' $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
    ( log_vio_fut<- stunting_ch_dummy `var' $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent difficult

	
	estimates store main_`var'
	
	* Direct
nlcom  _b[ log_vio_fut:`var'], post
estimates store direct_`var'

* Indirect 
estimates restore main_`var'
nlcom _b[stunting_ch_dummy:`var'] * _b[ log_vio_fut:stunting_ch_dummy], post
estimates store indirect_`var'

* Total 
estimates restore main_`var'
nlcom _b[stunting_ch_dummy:`var'] * _b[ log_vio_fut:stunting_ch_dummy] + _b[ log_vio_fut:`var'], post
estimates store total_`var'

outreg2 [main_`var' direct_`var' indirect_`var' total_`var'] using "${tables}/raifall_pos_stunting.xls", label append drop(i.quarter#i.year i.region_id) /*keep(No_min_meal_freq_hh `var' $control1 $control2)*/ dec(3) nocons 
}
	

foreach var of global rainfall_pos {
gsem (stunting_ch_dummy <- `var' $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
    ( log_civ_fut<- stunting_ch_dummy `var' $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent difficult

	
	estimates store main_`var'
	
	* Direct
nlcom  _b[ log_civ_fut:`var'], post
estimates store direct_`var'

* Indirect 
estimates restore main_`var'
nlcom _b[stunting_ch_dummy:`var'] * _b[ log_civ_fut:stunting_ch_dummy], post
estimates store indirect_`var'

* Total 
estimates restore main_`var'
nlcom _b[stunting_ch_dummy:`var'] * _b[ log_civ_fut:stunting_ch_dummy] + _b[ log_civ_fut:`var'], post
estimates store total_`var'

outreg2 [main_`var' direct_`var' indirect_`var' total_`var'] using "${tables}/raifall_pos_stunting_civ.xls", label append drop(i.quarter#i.year i.region_id) /*keep(No_min_meal_freq_hh `var' $control1 $control2)*/ dec(3) nocons 
}
	
	
***GOOD***
gsem (log_Maize_white <- dummy_neg_rain_ext_12 $control1v i.quarter#i.year i.region_id M1[grid_id] ) ///
(log_vio_fut <- log_Maize_white  dummy_neg_rain_ext_12 $control2v i.quarter#i.year i.region_id M1[grid_id] ), latent(M1) nocapslatent difficult 
	
gsem (log_Maize_white <- dummy_neg_rain_ext_9 $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Maize_white  dummy_neg_rain_ext_9 $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent difficult 
	
gsem (log_Maize_white <- dummy_neg_rain_ext_6 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white  dummy_neg_rain_ext_6 $control2v i.quarter#i.year i.region_id ), 
	
gsem (log_Maize_white <- dummy_neg_rain_ext_3 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white  dummy_neg_rain_ext_3 $control2v i.quarter#i.year i.region_id ), 
	
	

	
	
***GOOD***
gsem (log_Maize_white <- anom_rain12_neg $control1v i.quarter#i.year i.region_id M1[grid_id] ) ///
(log_vio_fut <- log_Maize_white  anom_rain12_neg $control2v i.quarter#i.year i.region_id M1[grid_id] ), latent(M1) nocapslatent difficult 
	
gsem (log_Maize_white <- anom_rain9_neg $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Maize_white  anom_rain9_neg $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent difficult 
	
gsem (log_Maize_white <- anom_rain6_neg $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white  anom_rain6_neg $control2v i.quarter#i.year i.region_id ), 
	
gsem (log_Maize_white <- anom_rain3_neg $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white  anom_rain3_neg $control2v i.quarter#i.year i.region_id ), 
	
	
	
	 ** sem **
gsem (log_Maize_white <- anom_rain12_NEG_new $control1v i.quarter#i.year i.region_id ) ///
(dummy_vio_fut <- log_Maize_white anom_rain12_NEG_new $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_12month_ext_temp.xls", replace keep(log_Maize_white dummy_temp_ext_12 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_temp_ext_12]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_12]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_12] + _b[log_Maize_white:dummy_temp_ext_12]*_b[log_vio_fut:log_Maize_white]


	
	
	
	
	
	
	
	
	
	
	
	
	
		
******** VIOLENT/CIV CONFLICT ********** NUTRITIONAL / FOOD SEC 
	
	
*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	


****** Nutritional insecurity and temperatures 

***** WASTING CHILDREN*****
** sem **
gsem (wasted_ch_dummy <- anom_tmax12_POS $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- wasted_ch_dummy anom_tmax12_POS $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wasted_12month_1.xls", replace keep(wasted_ch_dummy anom_tmax12_POS $control1 $control2) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_tmax12_POS]*_b[log_vio_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax12_POS] + _b[wasted_ch_dummy:anom_tmax12_POS]*_b[log_vio_fut:wasted_ch_dummy]

** sem **
gsem (wasted_ch_dummy <- anom_tmax12_POS $control1c i.quarter#i.year i.region_id ) ///
(log_civ_fut <- wasted_ch_dummy anom_tmax12_POS $control2c i.quarter#i.year i.region_id), 
outreg2 using "$tables\GSEM_wasted_12month_civ.xls", replace keep(wasted_ch_dummy anom_tmax12_POS $control1 $control2) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_tmax12_POS]*_b[log_civ_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax12_POS] + _b[wasted_ch_dummy:anom_tmax12_POS]*_b[log_civ_fut:wasted_ch_dummy]

	* 9 months
gsem (wasted_ch_dummy <- anom_tmax9_POS $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- wasted_ch_dummy anom_tmax9_POS $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wasted_9month_1.xls", replace keep(wasted_ch_dummy anom_tmax9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_tmax9_POS]*_b[log_vio_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax9_POS] + _b[wasted_ch_dummy:anom_tmax9_POS]*_b[log_vio_fut:wasted_ch_dummy]
 
 	* 9 months
gsem (wasted_ch_dummy <- anom_tmax9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- wasted_ch_dummy anom_tmax9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_9month_civ.xls", replace keep(wasted_ch_dummy anom_tmax9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_tmax9_POS]*_b[log_civ_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax9_POS] + _b[wasted_ch_dummy:anom_tmax9_POS]*_b[log_civ_fut:wasted_ch_dummy]
	
	* 6 months
gsem (wasted_ch_dummy <- anom_tmax6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- wasted_ch_dummy anom_tmax6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_6month_1.xls", replace keep(wasted_ch_dummy anom_tmax6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_tmax6_POS]*_b[log_vio_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax6_POS] + _b[wasted_ch_dummy:anom_tmax6_POS]*_b[log_vio_fut:wasted_ch_dummy]
 
 	* 6 months
gsem (wasted_ch_dummy <- anom_tmax6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- wasted_ch_dummy anom_tmax6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_6month_civ.xls", replace keep(wasted_ch_dummy anom_tmax6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_tmax6_POS]*_b[log_civ_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax6_POS] + _b[wasted_ch_dummy:anom_tmax6_POS]*_b[log_civ_fut:wasted_ch_dummy]
	
	
	
	* 3 months
gsem (wasted_ch_dummy <- anom_tmax3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- wasted_ch_dummy anom_tmax3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_3month_1.xls", replace keep(wasted_ch_dummy anom_tmax3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_tmax3_POS]*_b[log_vio_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax3_POS] + _b[wasted_ch_dummy:anom_tmax3_POS]*_b[log_vio_fut:wasted_ch_dummy]
 
 	* 3 months
gsem (wasted_ch_dummy <- anom_tmax3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- wasted_ch_dummy anom_tmax3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_3month_civ.xls", replace keep(wasted_ch_dummy anom_tmax3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_tmax3_POS]*_b[log_civ_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax3_POS] + _b[wasted_ch_dummy:anom_tmax3_POS]*_b[log_civ_fut:wasted_ch_dummy]
	
	
****** Nutritional insecurity and lack of rainfall  

***** WASTING CHILDREN*****
** sem **
gsem (wasted_ch_dummy <- anom_rain12_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- wasted_ch_dummy anom_rain12_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_12month_1.xls", replace keep(wasted_ch_dummy anom_rain12_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain12_NEG_new]*_b[log_vio_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_NEG_new] + _b[wasted_ch_dummy:anom_rain12_NEG_new]*_b[log_vio_fut:wasted_ch_dummy]

** sem **
gsem (wasted_ch_dummy <- anom_rain12_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- wasted_ch_dummy anom_rain12_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_12month_civ.xls", replace keep(wasted_ch_dummy anom_rain12_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain12_NEG_new]*_b[log_civ_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_NEG_new] + _b[wasted_ch_dummy:anom_rain12_NEG_new]*_b[log_civ_fut:wasted_ch_dummy]

	* 9 months
gsem (wasted_ch_dummy <- anom_rain9_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- wasted_ch_dummy anom_rain9_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_9month_1.xls", replace keep(wasted_ch_dummy anom_rain9_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain9_NEG_new]*_b[log_vio_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_NEG_new] + _b[wasted_ch_dummy:anom_rain9_NEG_new]*_b[log_vio_fut:wasted_ch_dummy]
 
 	* 9 months
gsem (wasted_ch_dummy <- anom_rain9_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- wasted_ch_dummy anom_rain9_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_9month_civ.xls", replace keep(wasted_ch_dummy anom_rain9_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain9_NEG_new]*_b[log_civ_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_NEG_new] + _b[wasted_ch_dummy:anom_rain9_NEG_new]*_b[log_civ_fut:wasted_ch_dummy]
	
	* 6 months
gsem (wasted_ch_dummy <- anom_rain6_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- wasted_ch_dummy anom_rain6_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_6month_1.xls", replace keep(wasted_ch_dummy anom_rain6_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain6_NEG_new]*_b[log_vio_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_NEG_new] + _b[wasted_ch_dummy:anom_rain6_NEG_new]*_b[log_vio_fut:wasted_ch_dummy]
 
 	* 6 months
gsem (wasted_ch_dummy <- anom_rain6_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- wasted_ch_dummy anom_rain6_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_6month_civ.xls", replace keep(wasted_ch_dummy anom_rain6_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain6_NEG_new]*_b[log_civ_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_NEG_new] + _b[wasted_ch_dummy:anom_rain6_NEG_new]*_b[log_civ_fut:wasted_ch_dummy]
	
	
	
	* 3 months
gsem (wasted_ch_dummy <- anom_rain3_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- wasted_ch_dummy anom_rain3_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_3month_1.xls", replace keep(wasted_ch_dummy anom_rain3_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain3_NEG_new]*_b[log_vio_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_NEG_new] + _b[wasted_ch_dummy:anom_rain3_NEG_new]*_b[log_vio_fut:wasted_ch_dummy]
 
 	* 3 months
gsem (wasted_ch_dummy <- anom_rain3_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- wasted_ch_dummy anom_rain3_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_3month_civ.xls", replace keep(wasted_ch_dummy anom_rain3_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain3_NEG_new]*_b[log_civ_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_NEG_new] + _b[wasted_ch_dummy:anom_rain3_NEG_new]*_b[log_civ_fut:wasted_ch_dummy]
	

	
****** Nutritional insecurity and rainfall abbundace 

***** WASTING CHILDREN*****
** sem **
gsem (wasted_ch_dummy <- anom_rain12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- wasted_ch_dummy anom_rain12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_12month_1.xls", replace keep(wasted_ch_dummy anom_rain12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain12_POS]*_b[log_vio_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_POS] + _b[wasted_ch_dummy:anom_rain12_POS]*_b[log_vio_fut:wasted_ch_dummy]

** sem **
gsem (wasted_ch_dummy <- anom_rain12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- wasted_ch_dummy anom_rain12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_12month_civ.xls", replace keep(wasted_ch_dummy anom_rain12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain12_POS]*_b[log_civ_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_POS] + _b[wasted_ch_dummy:anom_rain12_POS]*_b[log_civ_fut:wasted_ch_dummy]

	* 9 months
gsem (wasted_ch_dummy <- anom_rain9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- wasted_ch_dummy anom_rain9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_9month_1.xls", replace keep(wasted_ch_dummy anom_rain9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain9_POS]*_b[log_vio_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_POS] + _b[wasted_ch_dummy:anom_rain9_POS]*_b[log_vio_fut:wasted_ch_dummy]
 
 	* 9 months
gsem (wasted_ch_dummy <- anom_rain9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- wasted_ch_dummy anom_rain9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_9month_civ.xls", replace keep(wasted_ch_dummy anom_rain9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain9_POS]*_b[log_civ_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_POS] + _b[wasted_ch_dummy:anom_rain9_POS]*_b[log_civ_fut:wasted_ch_dummy]
	
	* 6 months
gsem (wasted_ch_dummy <- anom_rain6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- wasted_ch_dummy anom_rain6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_6month_1.xls", replace keep(wasted_ch_dummy anom_rain6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain6_POS]*_b[log_vio_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_POS] + _b[wasted_ch_dummy:anom_rain6_POS]*_b[log_vio_fut:wasted_ch_dummy]
 
 	* 6 months
gsem (wasted_ch_dummy <- anom_rain6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- wasted_ch_dummy anom_rain6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_6month_civ.xls", replace keep(wasted_ch_dummy anom_rain6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain6_POS]*_b[log_civ_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_POS] + _b[wasted_ch_dummy:anom_rain6_POS]*_b[log_civ_fut:wasted_ch_dummy]
	
	
	
	* 3 months
gsem (wasted_ch_dummy <- anom_rain3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- wasted_ch_dummy anom_rain3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_3month_1.xls", replace keep(wasted_ch_dummy anom_rain3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain3_POS]*_b[log_vio_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_POS] + _b[wasted_ch_dummy:anom_rain3_POS]*_b[log_vio_fut:wasted_ch_dummy]
 
 	* 3 months
gsem (wasted_ch_dummy <- anom_rain3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- wasted_ch_dummy anom_rain3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_3month_civ.xls", replace keep(wasted_ch_dummy anom_rain3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[wasted_ch_dummy:anom_rain3_POS]*_b[log_civ_fut:wasted_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_POS] + _b[wasted_ch_dummy:anom_rain3_POS]*_b[log_civ_fut:wasted_ch_dummy]
	

	
	
	

****** Nutritional insecurity and temperatures 

***** Stunting CHILDREN*****
** sem **
gsem (stunting_ch_dummy <- anom_tmax12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- stunting_ch_dummy anom_tmax12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_12month_1.xls", replace keep(stunting_ch_dummy anom_tmax12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_tmax12_POS]*_b[log_vio_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax12_POS] + _b[stunting_ch_dummy:anom_tmax12_POS]*_b[log_vio_fut:stunting_ch_dummy]

** sem **
gsem (stunting_ch_dummy <- anom_tmax12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- stunting_ch_dummy anom_tmax12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_12month_civ.xls", replace keep(stunting_ch_dummy anom_tmax12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_tmax12_POS]*_b[log_civ_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax12_POS] + _b[stunting_ch_dummy:anom_tmax12_POS]*_b[log_civ_fut:stunting_ch_dummy]

	* 9 months
gsem (stunting_ch_dummy <- anom_tmax9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- stunting_ch_dummy anom_tmax9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_9month_1.xls", replace keep(stunting_ch_dummy anom_tmax9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_tmax9_POS]*_b[log_vio_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax9_POS] + _b[stunting_ch_dummy:anom_tmax9_POS]*_b[log_vio_fut:stunting_ch_dummy]
 
 	* 9 months
gsem (stunting_ch_dummy <- anom_tmax9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- stunting_ch_dummy anom_tmax9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_9month_civ.xls", replace keep(stunting_ch_dummy anom_tmax9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_tmax9_POS]*_b[log_civ_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax9_POS] + _b[stunting_ch_dummy:anom_tmax9_POS]*_b[log_civ_fut:stunting_ch_dummy]
	
	* 6 months
gsem (stunting_ch_dummy <- anom_tmax6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- stunting_ch_dummy anom_tmax6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_6month_1.xls", replace keep(stunting_ch_dummy anom_tmax6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_tmax6_POS]*_b[log_vio_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax6_POS] + _b[stunting_ch_dummy:anom_tmax6_POS]*_b[log_vio_fut:stunting_ch_dummy]
 
 	* 6 months
gsem (stunting_ch_dummy <- anom_tmax6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- stunting_ch_dummy anom_tmax6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_6month_civ.xls", replace keep(stunting_ch_dummy anom_tmax6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_tmax6_POS]*_b[log_civ_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax6_POS] + _b[stunting_ch_dummy:anom_tmax6_POS]*_b[log_civ_fut:stunting_ch_dummy]
	
	
	
	* 3 months
gsem (stunting_ch_dummy <- anom_tmax3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- stunting_ch_dummy anom_tmax3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_3month_1.xls", replace keep(stunting_ch_dummy anom_tmax3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_tmax3_POS]*_b[log_vio_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax3_POS] + _b[stunting_ch_dummy:anom_tmax3_POS]*_b[log_vio_fut:stunting_ch_dummy]
 
 	* 3 months
gsem (stunting_ch_dummy <- anom_tmax3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- stunting_ch_dummy anom_tmax3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_3month_civ.xls", replace keep(stunting_ch_dummy anom_tmax3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_tmax3_POS]*_b[log_civ_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax3_POS] + _b[stunting_ch_dummy:anom_tmax3_POS]*_b[log_civ_fut:stunting_ch_dummy]
	
	
****** Nutritional insecurity and lack of rainfall  

***** Stunting CHILDREN*****
** sem **
gsem (stunting_ch_dummy <- anom_rain12_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- stunting_ch_dummy anom_rain12_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_12month_1.xls", replace keep(stunting_ch_dummy anom_rain12_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain12_NEG_new]*_b[log_vio_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_NEG_new] + _b[stunting_ch_dummy:anom_rain12_NEG_new]*_b[log_vio_fut:stunting_ch_dummy]

** sem **
gsem (stunting_ch_dummy <- anom_rain12_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- stunting_ch_dummy anom_rain12_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_12month_civ.xls", replace keep(stunting_ch_dummy anom_rain12_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain12_NEG_new]*_b[log_civ_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_NEG_new] + _b[stunting_ch_dummy:anom_rain12_NEG_new]*_b[log_civ_fut:stunting_ch_dummy]

	* 9 months
gsem (stunting_ch_dummy <- anom_rain9_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- stunting_ch_dummy anom_rain9_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_9month_1.xls", replace keep(stunting_ch_dummy anom_rain9_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain9_NEG_new]*_b[log_vio_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_NEG_new] + _b[stunting_ch_dummy:anom_rain9_NEG_new]*_b[log_vio_fut:stunting_ch_dummy]
 
 	* 9 months
gsem (stunting_ch_dummy <- anom_rain9_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- stunting_ch_dummy anom_rain9_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_9month_civ.xls", replace keep(stunting_ch_dummy anom_rain9_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain9_NEG_new]*_b[log_civ_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_NEG_new] + _b[stunting_ch_dummy:anom_rain9_NEG_new]*_b[log_civ_fut:stunting_ch_dummy]
	
	* 6 months
gsem (stunting_ch_dummy <- anom_rain6_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- stunting_ch_dummy anom_rain6_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_6month_1.xls", replace keep(stunting_ch_dummy anom_rain6_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain6_NEG_new]*_b[log_vio_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_NEG_new] + _b[stunting_ch_dummy:anom_rain6_NEG_new]*_b[log_vio_fut:stunting_ch_dummy]
 
 	* 6 months
gsem (stunting_ch_dummy <- anom_rain6_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- stunting_ch_dummy anom_rain6_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_6month_civ.xls", replace keep(stunting_ch_dummy anom_rain6_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain6_NEG_new]*_b[log_civ_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_NEG_new] + _b[stunting_ch_dummy:anom_rain6_NEG_new]*_b[log_civ_fut:stunting_ch_dummy]
	
	
	
	* 3 months
gsem (stunting_ch_dummy <- anom_rain3_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- stunting_ch_dummy anom_rain3_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_3month_1.xls", replace keep(stunting_ch_dummy anom_rain3_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain3_NEG_new]*_b[log_vio_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_NEG_new] + _b[stunting_ch_dummy:anom_rain3_NEG_new]*_b[log_vio_fut:stunting_ch_dummy]
 
 	* 3 months
gsem (stunting_ch_dummy <- anom_rain3_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- stunting_ch_dummy anom_rain3_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_3month_civ.xls", replace keep(stunting_ch_dummy anom_rain3_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain3_NEG_new]*_b[log_civ_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_NEG_new] + _b[stunting_ch_dummy:anom_rain3_NEG_new]*_b[log_civ_fut:stunting_ch_dummy]
	

	
****** Nutritional insecurity and rainfall abbundace 

***** Stunting CHILDREN*****
** sem **
gsem (stunting_ch_dummy <- anom_rain12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- stunting_ch_dummy anom_rain12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_12month_1.xls", replace keep(stunting_ch_dummy anom_rain12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain12_POS]*_b[log_vio_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_POS] + _b[stunting_ch_dummy:anom_rain12_POS]*_b[log_vio_fut:stunting_ch_dummy]

** sem **
gsem (stunting_ch_dummy <- anom_rain12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- stunting_ch_dummy anom_rain12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_12month_civ.xls", replace keep(stunting_ch_dummy anom_rain12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain12_POS]*_b[log_civ_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_POS] + _b[stunting_ch_dummy:anom_rain12_POS]*_b[log_civ_fut:stunting_ch_dummy]

	* 9 months
gsem (stunting_ch_dummy <- anom_rain9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- stunting_ch_dummy anom_rain9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_9month_1.xls", replace keep(stunting_ch_dummy anom_rain9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain9_POS]*_b[log_vio_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_POS] + _b[stunting_ch_dummy:anom_rain9_POS]*_b[log_vio_fut:stunting_ch_dummy]
 
 	* 9 months
gsem (stunting_ch_dummy <- anom_rain9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- stunting_ch_dummy anom_rain9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_9month_civ.xls", replace keep(stunting_ch_dummy anom_rain9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain9_POS]*_b[log_civ_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_POS] + _b[stunting_ch_dummy:anom_rain9_POS]*_b[log_civ_fut:stunting_ch_dummy]
	
	* 6 months
gsem (stunting_ch_dummy <- anom_rain6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- stunting_ch_dummy anom_rain6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_6month_1.xls", replace keep(stunting_ch_dummy anom_rain6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain6_POS]*_b[log_vio_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_POS] + _b[stunting_ch_dummy:anom_rain6_POS]*_b[log_vio_fut:stunting_ch_dummy]
 
 	* 6 months
gsem (stunting_ch_dummy <- anom_rain6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- stunting_ch_dummy anom_rain6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_6month_civ.xls", replace keep(stunting_ch_dummy anom_rain6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain6_POS]*_b[log_civ_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_POS] + _b[stunting_ch_dummy:anom_rain6_POS]*_b[log_civ_fut:stunting_ch_dummy]
	
	
	
	* 3 months
gsem (stunting_ch_dummy <- anom_rain3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- stunting_ch_dummy anom_rain3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_3month_1.xls", replace keep(stunting_ch_dummy anom_rain3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain3_POS]*_b[log_vio_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_POS] + _b[stunting_ch_dummy:anom_rain3_POS]*_b[log_vio_fut:stunting_ch_dummy]
 
 	* 3 months
gsem (stunting_ch_dummy <- anom_rain3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- stunting_ch_dummy anom_rain3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wasted_3month_civ.xls", replace keep(stunting_ch_dummy anom_rain3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[stunting_ch_dummy:anom_rain3_POS]*_b[log_civ_fut:stunting_ch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_POS] + _b[stunting_ch_dummy:anom_rain3_POS]*_b[log_civ_fut:stunting_ch_dummy]
	
	
	
	
	
***** UNDERWEIGHT CHILDREN*****
***** underch CHILDREN*****
** sem **
gsem (underch_dummy <- anom_tmax12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- underch_dummy anom_tmax12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_12month_1.xls", replace keep(underch_dummy anom_tmax12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_tmax12_POS]*_b[log_vio_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax12_POS] + _b[underch_dummy:anom_tmax12_POS]*_b[log_vio_fut:underch_dummy]

** sem **
gsem (underch_dummy <- anom_tmax12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- underch_dummy anom_tmax12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_12month_civ.xls", replace keep(underch_dummy anom_tmax12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_tmax12_POS]*_b[log_civ_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax12_POS] + _b[underch_dummy:anom_tmax12_POS]*_b[log_civ_fut:underch_dummy]

	* 9 months
gsem (underch_dummy <- anom_tmax9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- underch_dummy anom_tmax9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_9month_1.xls", replace keep(underch_dummy anom_tmax9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_tmax9_POS]*_b[log_vio_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax9_POS] + _b[underch_dummy:anom_tmax9_POS]*_b[log_vio_fut:underch_dummy]
 
 	* 9 months
gsem (underch_dummy <- anom_tmax9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- underch_dummy anom_tmax9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_9month_civ.xls", replace keep(underch_dummy anom_tmax9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_tmax9_POS]*_b[log_civ_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax9_POS] + _b[underch_dummy:anom_tmax9_POS]*_b[log_civ_fut:underch_dummy]
	
	* 6 months
gsem (underch_dummy <- anom_tmax6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- underch_dummy anom_tmax6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_6month_1.xls", replace keep(underch_dummy anom_tmax6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_tmax6_POS]*_b[log_vio_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax6_POS] + _b[underch_dummy:anom_tmax6_POS]*_b[log_vio_fut:underch_dummy]
 
 	* 6 months
gsem (underch_dummy <- anom_tmax6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- underch_dummy anom_tmax6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_6month_civ.xls", replace keep(underch_dummy anom_tmax6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_tmax6_POS]*_b[log_civ_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax6_POS] + _b[underch_dummy:anom_tmax6_POS]*_b[log_civ_fut:underch_dummy]
	
	
	
	* 3 months
gsem (underch_dummy <- anom_tmax3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- underch_dummy anom_tmax3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_3month_1.xls", replace keep(underch_dummy anom_tmax3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_tmax3_POS]*_b[log_vio_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax3_POS] + _b[underch_dummy:anom_tmax3_POS]*_b[log_vio_fut:underch_dummy]
 
 	* 3 months
gsem (underch_dummy <- anom_tmax3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- underch_dummy anom_tmax3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_3month_civ.xls", replace keep(underch_dummy anom_tmax3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_tmax3_POS]*_b[log_civ_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax3_POS] + _b[underch_dummy:anom_tmax3_POS]*_b[log_civ_fut:underch_dummy]
	
	
****** Nutritional insecurity and lack of rainfall  

***** underch CHILDREN*****
** sem **
gsem (underch_dummy <- anom_rain12_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- underch_dummy anom_rain12_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_12month_1.xls", replace keep(underch_dummy anom_rain12_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain12_NEG_new]*_b[log_vio_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_NEG_new] + _b[underch_dummy:anom_rain12_NEG_new]*_b[log_vio_fut:underch_dummy]

** sem **
gsem (underch_dummy <- anom_rain12_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- underch_dummy anom_rain12_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_12month_civ.xls", replace keep(underch_dummy anom_rain12_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain12_NEG_new]*_b[log_civ_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_NEG_new] + _b[underch_dummy:anom_rain12_NEG_new]*_b[log_civ_fut:underch_dummy]

	* 9 months
gsem (underch_dummy <- anom_rain9_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- underch_dummy anom_rain9_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_9month_1.xls", replace keep(underch_dummy anom_rain9_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain9_NEG_new]*_b[log_vio_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_NEG_new] + _b[underch_dummy:anom_rain9_NEG_new]*_b[log_vio_fut:underch_dummy]
 
 	* 9 months
gsem (underch_dummy <- anom_rain9_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- underch_dummy anom_rain9_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_9month_civ.xls", replace keep(underch_dummy anom_rain9_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain9_NEG_new]*_b[log_civ_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_NEG_new] + _b[underch_dummy:anom_rain9_NEG_new]*_b[log_civ_fut:underch_dummy]
	
	* 6 months
gsem (underch_dummy <- anom_rain6_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- underch_dummy anom_rain6_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_6month_1.xls", replace keep(underch_dummy anom_rain6_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain6_NEG_new]*_b[log_vio_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_NEG_new] + _b[underch_dummy:anom_rain6_NEG_new]*_b[log_vio_fut:underch_dummy]
 
 	* 6 months
gsem (underch_dummy <- anom_rain6_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- underch_dummy anom_rain6_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_6month_civ.xls", replace keep(underch_dummy anom_rain6_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain6_NEG_new]*_b[log_civ_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_NEG_new] + _b[underch_dummy:anom_rain6_NEG_new]*_b[log_civ_fut:underch_dummy]
	
	
	
	* 3 months
gsem (underch_dummy <- anom_rain3_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- underch_dummy anom_rain3_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_3month_1.xls", replace keep(underch_dummy anom_rain3_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain3_NEG_new]*_b[log_vio_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_NEG_new] + _b[underch_dummy:anom_rain3_NEG_new]*_b[log_vio_fut:underch_dummy]
 
 	* 3 months
gsem (underch_dummy <- anom_rain3_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- underch_dummy anom_rain3_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_3month_civ.xls", replace keep(underch_dummy anom_rain3_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain3_NEG_new]*_b[log_civ_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_NEG_new] + _b[underch_dummy:anom_rain3_NEG_new]*_b[log_civ_fut:underch_dummy]
	

	
****** Nutritional insecurity and rainfall abbundace 

***** underch CHILDREN*****
** sem **
gsem (underch_dummy <- anom_rain12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- underch_dummy anom_rain12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_12month_1.xls", replace keep(underch_dummy anom_rain12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain12_POS]*_b[log_vio_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_POS] + _b[underch_dummy:anom_rain12_POS]*_b[log_vio_fut:underch_dummy]

** sem **
gsem (underch_dummy <- anom_rain12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- underch_dummy anom_rain12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_12month_civ.xls", replace keep(underch_dummy anom_rain12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain12_POS]*_b[log_civ_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_POS] + _b[underch_dummy:anom_rain12_POS]*_b[log_civ_fut:underch_dummy]

	* 9 months
gsem (underch_dummy <- anom_rain9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- underch_dummy anom_rain9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_9month_1.xls", replace keep(underch_dummy anom_rain9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain9_POS]*_b[log_vio_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_POS] + _b[underch_dummy:anom_rain9_POS]*_b[log_vio_fut:underch_dummy]
 
 	* 9 months
gsem (underch_dummy <- anom_rain9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- underch_dummy anom_rain9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_9month_civ.xls", replace keep(underch_dummy anom_rain9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain9_POS]*_b[log_civ_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_POS] + _b[underch_dummy:anom_rain9_POS]*_b[log_civ_fut:underch_dummy]
	
	* 6 months
gsem (underch_dummy <- anom_rain6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- underch_dummy anom_rain6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_6month_1.xls", replace keep(underch_dummy anom_rain6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain6_POS]*_b[log_vio_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_POS] + _b[underch_dummy:anom_rain6_POS]*_b[log_vio_fut:underch_dummy]
 
 	* 6 months
gsem (underch_dummy <- anom_rain6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- underch_dummy anom_rain6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_6month_civ.xls", replace keep(underch_dummy anom_rain6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain6_POS]*_b[log_civ_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_POS] + _b[underch_dummy:anom_rain6_POS]*_b[log_civ_fut:underch_dummy]
	
	
	
	* 3 months
gsem (underch_dummy <- anom_rain3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- underch_dummy anom_rain3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_3month_1.xls", replace keep(underch_dummy anom_rain3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain3_POS]*_b[log_vio_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_POS] + _b[underch_dummy:anom_rain3_POS]*_b[log_vio_fut:underch_dummy]
 
 	* 3 months
gsem (underch_dummy <- anom_rain3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- underch_dummy anom_rain3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_underch_3month_civ.xls", replace keep(underch_dummy anom_rain3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[underch_dummy:anom_rain3_POS]*_b[log_civ_fut:underch_dummy] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_POS] + _b[underch_dummy:anom_rain3_POS]*_b[log_civ_fut:underch_dummy]
	
	

	
	
	
** Food security** 

****** Nutritional insecurity and temperatures 

***** FOOD FREQUENCY CHILDREN*****
** sem **
gsem (new_No_min_meal_freq_hh <- anom_tmax12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_meal_freq_hh anom_tmax12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_12month_1.xls", replace keep(new_No_min_meal_freq_hh anom_tmax12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_tmax12_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax12_POS] + _b[new_No_min_meal_freq_hh:anom_tmax12_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh]

** sem **
gsem (new_No_min_meal_freq_hh <- anom_tmax12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_meal_freq_hh anom_tmax12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_12month_civ.xls", replace keep(new_No_min_meal_freq_hh anom_tmax12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_tmax12_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax12_POS] + _b[new_No_min_meal_freq_hh:anom_tmax12_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh]

	* 9 months
gsem (new_No_min_meal_freq_hh <- anom_tmax9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_meal_freq_hh anom_tmax9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_9month_1.xls", replace keep(new_No_min_meal_freq_hh anom_tmax9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_tmax9_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax9_POS] + _b[new_No_min_meal_freq_hh:anom_tmax9_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh]
 
 	* 9 months
gsem (new_No_min_meal_freq_hh <- anom_tmax9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_meal_freq_hh anom_tmax9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_9month_civ.xls", replace keep(new_No_min_meal_freq_hh anom_tmax9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_tmax9_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax9_POS] + _b[new_No_min_meal_freq_hh:anom_tmax9_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh]
	
	* 6 months
gsem (new_No_min_meal_freq_hh <- anom_tmax6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_meal_freq_hh anom_tmax6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_6month_1.xls", replace keep(new_No_min_meal_freq_hh anom_tmax6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_tmax6_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax6_POS] + _b[new_No_min_meal_freq_hh:anom_tmax6_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh]
 
 	* 6 months
gsem (new_No_min_meal_freq_hh <- anom_tmax6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_meal_freq_hh anom_tmax6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_6month_civ.xls", replace keep(new_No_min_meal_freq_hh anom_tmax6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_tmax6_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax6_POS] + _b[new_No_min_meal_freq_hh:anom_tmax6_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh]
	
	
	
	* 3 months
gsem (new_No_min_meal_freq_hh <- anom_tmax3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_meal_freq_hh anom_tmax3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_3month_1.xls", replace keep(new_No_min_meal_freq_hh anom_tmax3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_tmax3_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax3_POS] + _b[new_No_min_meal_freq_hh:anom_tmax3_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh]
 
 	* 3 months
gsem (new_No_min_meal_freq_hh <- anom_tmax3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_meal_freq_hh anom_tmax3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_3month_civ.xls", replace keep(new_No_min_meal_freq_hh anom_tmax3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_tmax3_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax3_POS] + _b[new_No_min_meal_freq_hh:anom_tmax3_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh]
	
	
****** Nutritional insecurity and lack of rainfall  

***** FOOD FREQUENCY CHILDREN*****
** sem **
gsem (new_No_min_meal_freq_hh <- anom_rain12_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_meal_freq_hh anom_rain12_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_12month_1.xls", replace keep(new_No_min_meal_freq_hh anom_rain12_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain12_NEG_new]*_b[log_vio_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_NEG_new] + _b[new_No_min_meal_freq_hh:anom_rain12_NEG_new]*_b[log_vio_fut:new_No_min_meal_freq_hh]

** sem **
gsem (new_No_min_meal_freq_hh <- anom_rain12_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_meal_freq_hh anom_rain12_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_12month_civ.xls", replace keep(new_No_min_meal_freq_hh anom_rain12_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain12_NEG_new]*_b[log_civ_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_NEG_new] + _b[new_No_min_meal_freq_hh:anom_rain12_NEG_new]*_b[log_civ_fut:new_No_min_meal_freq_hh]

	* 9 months
gsem (new_No_min_meal_freq_hh <- anom_rain9_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_meal_freq_hh anom_rain9_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_9month_1.xls", replace keep(new_No_min_meal_freq_hh anom_rain9_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain9_NEG_new]*_b[log_vio_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_NEG_new] + _b[new_No_min_meal_freq_hh:anom_rain9_NEG_new]*_b[log_vio_fut:new_No_min_meal_freq_hh]
 
 	* 9 months
gsem (new_No_min_meal_freq_hh <- anom_rain9_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_meal_freq_hh anom_rain9_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_9month_civ.xls", replace keep(new_No_min_meal_freq_hh anom_rain9_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain9_NEG_new]*_b[log_civ_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_NEG_new] + _b[new_No_min_meal_freq_hh:anom_rain9_NEG_new]*_b[log_civ_fut:new_No_min_meal_freq_hh]
	
	* 6 months
gsem (new_No_min_meal_freq_hh <- anom_rain6_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_meal_freq_hh anom_rain6_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_6month_1.xls", replace keep(new_No_min_meal_freq_hh anom_rain6_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain6_NEG_new]*_b[log_vio_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_NEG_new] + _b[new_No_min_meal_freq_hh:anom_rain6_NEG_new]*_b[log_vio_fut:new_No_min_meal_freq_hh]
 
 	* 6 months
gsem (new_No_min_meal_freq_hh <- anom_rain6_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_meal_freq_hh anom_rain6_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_6month_civ.xls", replace keep(new_No_min_meal_freq_hh anom_rain6_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain6_NEG_new]*_b[log_civ_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_NEG_new] + _b[new_No_min_meal_freq_hh:anom_rain6_NEG_new]*_b[log_civ_fut:new_No_min_meal_freq_hh]
	
	
	
	* 3 months
gsem (new_No_min_meal_freq_hh <- anom_rain3_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_meal_freq_hh anom_rain3_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_3month_1.xls", replace keep(new_No_min_meal_freq_hh anom_rain3_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain3_NEG_new]*_b[log_vio_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_NEG_new] + _b[new_No_min_meal_freq_hh:anom_rain3_NEG_new]*_b[log_vio_fut:new_No_min_meal_freq_hh]
 
 	* 3 months
gsem (new_No_min_meal_freq_hh <- anom_rain3_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_meal_freq_hh anom_rain3_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_3month_civ.xls", replace keep(new_No_min_meal_freq_hh anom_rain3_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain3_NEG_new]*_b[log_civ_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_NEG_new] + _b[new_No_min_meal_freq_hh:anom_rain3_NEG_new]*_b[log_civ_fut:new_No_min_meal_freq_hh]
	

	
****** Nutritional insecurity and rainfall abbundace 

***** FOOD FREQUENCY CHILDREN*****
** sem **
gsem (new_No_min_meal_freq_hh <- anom_rain12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_meal_freq_hh anom_rain12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_12month_1.xls", replace keep(new_No_min_meal_freq_hh anom_rain12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain12_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_POS] + _b[new_No_min_meal_freq_hh:anom_rain12_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh]

** sem **
gsem (new_No_min_meal_freq_hh <- anom_rain12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_meal_freq_hh anom_rain12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_12month_civ.xls", replace keep(new_No_min_meal_freq_hh anom_rain12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain12_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_POS] + _b[new_No_min_meal_freq_hh:anom_rain12_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh]

	* 9 months
gsem (new_No_min_meal_freq_hh <- anom_rain9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_meal_freq_hh anom_rain9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_9month_1.xls", replace keep(new_No_min_meal_freq_hh anom_rain9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain9_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_POS] + _b[new_No_min_meal_freq_hh:anom_rain9_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh]
 
 	* 9 months
gsem (new_No_min_meal_freq_hh <- anom_rain9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_meal_freq_hh anom_rain9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_9month_civ.xls", replace keep(new_No_min_meal_freq_hh anom_rain9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain9_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_POS] + _b[new_No_min_meal_freq_hh:anom_rain9_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh]
	
	* 6 months
gsem (new_No_min_meal_freq_hh <- anom_rain6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_meal_freq_hh anom_rain6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_6month_1.xls", replace keep(new_No_min_meal_freq_hh anom_rain6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain6_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_POS] + _b[new_No_min_meal_freq_hh:anom_rain6_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh]
 
 	* 6 months
gsem (new_No_min_meal_freq_hh <- anom_rain6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_meal_freq_hh anom_rain6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_6month_civ.xls", replace keep(new_No_min_meal_freq_hh anom_rain6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain6_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_POS] + _b[new_No_min_meal_freq_hh:anom_rain6_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh]
	
	
	
	* 3 months
gsem (new_No_min_meal_freq_hh <- anom_rain3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_meal_freq_hh anom_rain3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_3month_1.xls", replace keep(new_No_min_meal_freq_hh anom_rain3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain3_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_POS] + _b[new_No_min_meal_freq_hh:anom_rain3_POS]*_b[log_vio_fut:new_No_min_meal_freq_hh]
 
 	* 3 months
gsem (new_No_min_meal_freq_hh <- anom_rain3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_meal_freq_hh anom_rain3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_freq_3month_civ.xls", replace keep(new_No_min_meal_freq_hh anom_rain3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_meal_freq_hh:anom_rain3_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_POS] + _b[new_No_min_meal_freq_hh:anom_rain3_POS]*_b[log_civ_fut:new_No_min_meal_freq_hh]
	

	
	
	
	

** Food security** 

****** Nutritional insecurity and temperatures 

***** diet diversity CHILDREN*****
** sem **
gsem (new_No_min_diet_diversity_hh <- anom_tmax12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_diet_diversity_hh anom_tmax12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_12month_1.xls", replace keep(new_No_min_diet_diversity_hh anom_tmax12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_tmax12_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax12_POS] + _b[new_No_min_diet_diversity_hh:anom_tmax12_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh]

** sem **
gsem (new_No_min_diet_diversity_hh <- anom_tmax12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_diet_diversity_hh anom_tmax12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_12month_civ.xls", replace keep(new_No_min_diet_diversity_hh anom_tmax12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_tmax12_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax12_POS] + _b[new_No_min_diet_diversity_hh:anom_tmax12_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh]

	* 9 months
gsem (new_No_min_diet_diversity_hh <- anom_tmax9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_diet_diversity_hh anom_tmax9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_9month_1.xls", replace keep(new_No_min_diet_diversity_hh anom_tmax9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_tmax9_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax9_POS] + _b[new_No_min_diet_diversity_hh:anom_tmax9_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh]
 
 	* 9 months
gsem (new_No_min_diet_diversity_hh <- anom_tmax9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_diet_diversity_hh anom_tmax9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_9month_civ.xls", replace keep(new_No_min_diet_diversity_hh anom_tmax9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_tmax9_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax9_POS] + _b[new_No_min_diet_diversity_hh:anom_tmax9_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh]
	
	* 6 months
gsem (new_No_min_diet_diversity_hh <- anom_tmax6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_diet_diversity_hh anom_tmax6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_6month_1.xls", replace keep(new_No_min_diet_diversity_hh anom_tmax6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_tmax6_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax6_POS] + _b[new_No_min_diet_diversity_hh:anom_tmax6_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh]
 
 	* 6 months
gsem (new_No_min_diet_diversity_hh <- anom_tmax6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_diet_diversity_hh anom_tmax6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_6month_civ.xls", replace keep(new_No_min_diet_diversity_hh anom_tmax6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_tmax6_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax6_POS] + _b[new_No_min_diet_diversity_hh:anom_tmax6_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh]
	
	
	
	* 3 months
gsem (new_No_min_diet_diversity_hh <- anom_tmax3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_diet_diversity_hh anom_tmax3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_3month_1.xls", replace keep(new_No_min_diet_diversity_hh anom_tmax3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_tmax3_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax3_POS] + _b[new_No_min_diet_diversity_hh:anom_tmax3_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh]
 
 	* 3 months
gsem (new_No_min_diet_diversity_hh <- anom_tmax3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_diet_diversity_hh anom_tmax3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_3month_civ.xls", replace keep(new_No_min_diet_diversity_hh anom_tmax3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_tmax3_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax3_POS] + _b[new_No_min_diet_diversity_hh:anom_tmax3_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh]
	
	
****** Nutritional insecurity and lack of rainfall  

***** diet diversity CHILDREN*****
** sem **
gsem (new_No_min_diet_diversity_hh <- anom_rain12_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_diet_diversity_hh anom_rain12_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_12month_1.xls", replace keep(new_No_min_diet_diversity_hh anom_rain12_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain12_NEG_new]*_b[log_vio_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_NEG_new] + _b[new_No_min_diet_diversity_hh:anom_rain12_NEG_new]*_b[log_vio_fut:new_No_min_diet_diversity_hh]

** sem **
gsem (new_No_min_diet_diversity_hh <- anom_rain12_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_diet_diversity_hh anom_rain12_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_12month_civ.xls", replace keep(new_No_min_diet_diversity_hh anom_rain12_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain12_NEG_new]*_b[log_civ_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_NEG_new] + _b[new_No_min_diet_diversity_hh:anom_rain12_NEG_new]*_b[log_civ_fut:new_No_min_diet_diversity_hh]

	* 9 months
gsem (new_No_min_diet_diversity_hh <- anom_rain9_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_diet_diversity_hh anom_rain9_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_9month_1.xls", replace keep(new_No_min_diet_diversity_hh anom_rain9_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain9_NEG_new]*_b[log_vio_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_NEG_new] + _b[new_No_min_diet_diversity_hh:anom_rain9_NEG_new]*_b[log_vio_fut:new_No_min_diet_diversity_hh]
 
 	* 9 months
gsem (new_No_min_diet_diversity_hh <- anom_rain9_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_diet_diversity_hh anom_rain9_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_9month_civ.xls", replace keep(new_No_min_diet_diversity_hh anom_rain9_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain9_NEG_new]*_b[log_civ_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_NEG_new] + _b[new_No_min_diet_diversity_hh:anom_rain9_NEG_new]*_b[log_civ_fut:new_No_min_diet_diversity_hh]
	
	* 6 months
gsem (new_No_min_diet_diversity_hh <- anom_rain6_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_diet_diversity_hh anom_rain6_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_6month_1.xls", replace keep(new_No_min_diet_diversity_hh anom_rain6_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain6_NEG_new]*_b[log_vio_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_NEG_new] + _b[new_No_min_diet_diversity_hh:anom_rain6_NEG_new]*_b[log_vio_fut:new_No_min_diet_diversity_hh]
 
 	* 6 months
gsem (new_No_min_diet_diversity_hh <- anom_rain6_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_diet_diversity_hh anom_rain6_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_6month_civ.xls", replace keep(new_No_min_diet_diversity_hh anom_rain6_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain6_NEG_new]*_b[log_civ_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_NEG_new] + _b[new_No_min_diet_diversity_hh:anom_rain6_NEG_new]*_b[log_civ_fut:new_No_min_diet_diversity_hh]
	
	
	
	* 3 months
gsem (new_No_min_diet_diversity_hh <- anom_rain3_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_diet_diversity_hh anom_rain3_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_3month_1.xls", replace keep(new_No_min_diet_diversity_hh anom_rain3_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain3_NEG_new]*_b[log_vio_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_NEG_new] + _b[new_No_min_diet_diversity_hh:anom_rain3_NEG_new]*_b[log_vio_fut:new_No_min_diet_diversity_hh]
 
 	* 3 months
gsem (new_No_min_diet_diversity_hh <- anom_rain3_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_diet_diversity_hh anom_rain3_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_3month_civ.xls", replace keep(new_No_min_diet_diversity_hh anom_rain3_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain3_NEG_new]*_b[log_civ_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_NEG_new] + _b[new_No_min_diet_diversity_hh:anom_rain3_NEG_new]*_b[log_civ_fut:new_No_min_diet_diversity_hh]
	

	
****** Nutritional insecurity and rainfall abbundace 

***** diet diversity CHILDREN*****
** sem **
gsem (new_No_min_diet_diversity_hh <- anom_rain12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_diet_diversity_hh anom_rain12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_12month_1.xls", replace keep(new_No_min_diet_diversity_hh anom_rain12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain12_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_POS] + _b[new_No_min_diet_diversity_hh:anom_rain12_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh]

** sem **
gsem (new_No_min_diet_diversity_hh <- anom_rain12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_diet_diversity_hh anom_rain12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_12month_civ.xls", replace keep(new_No_min_diet_diversity_hh anom_rain12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain12_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_POS] + _b[new_No_min_diet_diversity_hh:anom_rain12_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh]

	* 9 months
gsem (new_No_min_diet_diversity_hh <- anom_rain9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_diet_diversity_hh anom_rain9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_9month_1.xls", replace keep(new_No_min_diet_diversity_hh anom_rain9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain9_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_POS] + _b[new_No_min_diet_diversity_hh:anom_rain9_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh]
 
 	* 9 months
gsem (new_No_min_diet_diversity_hh <- anom_rain9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_diet_diversity_hh anom_rain9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_9month_civ.xls", replace keep(new_No_min_diet_diversity_hh anom_rain9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain9_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_POS] + _b[new_No_min_diet_diversity_hh:anom_rain9_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh]
	
	* 6 months
gsem (new_No_min_diet_diversity_hh <- anom_rain6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_diet_diversity_hh anom_rain6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_6month_1.xls", replace keep(new_No_min_diet_diversity_hh anom_rain6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain6_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_POS] + _b[new_No_min_diet_diversity_hh:anom_rain6_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh]
 
 	* 6 months
gsem (new_No_min_diet_diversity_hh <- anom_rain6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_diet_diversity_hh anom_rain6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_6month_civ.xls", replace keep(new_No_min_diet_diversity_hh anom_rain6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain6_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_POS] + _b[new_No_min_diet_diversity_hh:anom_rain6_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh]
	
	
	
	* 3 months
gsem (new_No_min_diet_diversity_hh <- anom_rain3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_diet_diversity_hh anom_rain3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_3month_1.xls", replace keep(new_No_min_diet_diversity_hh anom_rain3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain3_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_POS] + _b[new_No_min_diet_diversity_hh:anom_rain3_POS]*_b[log_vio_fut:new_No_min_diet_diversity_hh]
 
 	* 3 months
gsem (new_No_min_diet_diversity_hh <- anom_rain3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_diet_diversity_hh anom_rain3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_div_3month_civ.xls", replace keep(new_No_min_diet_diversity_hh anom_rain3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_diet_diversity_hh:anom_rain3_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_POS] + _b[new_No_min_diet_diversity_hh:anom_rain3_POS]*_b[log_civ_fut:new_No_min_diet_diversity_hh]


 
 
 **** 
 
 
** Food security** 

****** Nutritional insecurity and temperatures 

***** Acceptable diet CHILDREN*****
** sem **
gsem (new_No_min_acc_diet_hh <- anom_tmax12_POS $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- new_No_min_acc_diet_hh anom_tmax12_POS $control2v i.quarter#i.year i.region_id ), nocapslatent
outreg2 using "$tables\GSEM_acc_12month_1.xls", replace keep(new_No_min_acc_diet_hh anom_tmax12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_tmax12_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax12_POS] + _b[new_No_min_acc_diet_hh:anom_tmax12_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh]

** sem **
gsem (new_No_min_acc_diet_hh <- anom_tmax12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_acc_diet_hh anom_tmax12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_12month_civ.xls", replace keep(new_No_min_acc_diet_hh anom_tmax12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_tmax12_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax12_POS] + _b[new_No_min_acc_diet_hh:anom_tmax12_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh]

	* 9 months
gsem (new_No_min_acc_diet_hh <- anom_tmax9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_acc_diet_hh anom_tmax9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_9month_1.xls", replace keep(new_No_min_acc_diet_hh anom_tmax9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_tmax9_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax9_POS] + _b[new_No_min_acc_diet_hh:anom_tmax9_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh]
 
 	* 9 months
gsem (new_No_min_acc_diet_hh <- anom_tmax9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_acc_diet_hh anom_tmax9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_9month_civ.xls", replace keep(new_No_min_acc_diet_hh anom_tmax9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_tmax9_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax9_POS] + _b[new_No_min_acc_diet_hh:anom_tmax9_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh]
	
	* 6 months
gsem (new_No_min_acc_diet_hh <- anom_tmax6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_acc_diet_hh anom_tmax6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_6month_1.xls", replace keep(new_No_min_acc_diet_hh anom_tmax6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_tmax6_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax6_POS] + _b[new_No_min_acc_diet_hh:anom_tmax6_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh]
 
 	* 6 months
gsem (new_No_min_acc_diet_hh <- anom_tmax6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_acc_diet_hh anom_tmax6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_6month_civ.xls", replace keep(new_No_min_acc_diet_hh anom_tmax6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_tmax6_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax6_POS] + _b[new_No_min_acc_diet_hh:anom_tmax6_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh]
	
	
	
	* 3 months
gsem (new_No_min_acc_diet_hh <- anom_tmax3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_acc_diet_hh anom_tmax3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_3month_1.xls", replace keep(new_No_min_acc_diet_hh anom_tmax3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_tmax3_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax3_POS] + _b[new_No_min_acc_diet_hh:anom_tmax3_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh]
 
 	* 3 months
gsem (new_No_min_acc_diet_hh <- anom_tmax3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_acc_diet_hh anom_tmax3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_3month_civ.xls", replace keep(new_No_min_acc_diet_hh anom_tmax3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_tmax3_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax3_POS] + _b[new_No_min_acc_diet_hh:anom_tmax3_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh]
	
	
****** Nutritional insecurity and lack of rainfall  

***** Acceptable diet CHILDREN*****
** sem **
gsem (new_No_min_acc_diet_hh <- anom_rain12_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_acc_diet_hh anom_rain12_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_12month_1.xls", replace keep(new_No_min_acc_diet_hh anom_rain12_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain12_NEG_new]*_b[log_vio_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_NEG_new] + _b[new_No_min_acc_diet_hh:anom_rain12_NEG_new]*_b[log_vio_fut:new_No_min_acc_diet_hh]

** sem **
gsem (new_No_min_acc_diet_hh <- anom_rain12_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_acc_diet_hh anom_rain12_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_12month_civ.xls", replace keep(new_No_min_acc_diet_hh anom_rain12_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain12_NEG_new]*_b[log_civ_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_NEG_new] + _b[new_No_min_acc_diet_hh:anom_rain12_NEG_new]*_b[log_civ_fut:new_No_min_acc_diet_hh]

	* 9 months
gsem (new_No_min_acc_diet_hh <- anom_rain9_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_acc_diet_hh anom_rain9_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_9month_1.xls", replace keep(new_No_min_acc_diet_hh anom_rain9_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain9_NEG_new]*_b[log_vio_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_NEG_new] + _b[new_No_min_acc_diet_hh:anom_rain9_NEG_new]*_b[log_vio_fut:new_No_min_acc_diet_hh]
 
 	* 9 months
gsem (new_No_min_acc_diet_hh <- anom_rain9_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_acc_diet_hh anom_rain9_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_9month_civ.xls", replace keep(new_No_min_acc_diet_hh anom_rain9_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain9_NEG_new]*_b[log_civ_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_NEG_new] + _b[new_No_min_acc_diet_hh:anom_rain9_NEG_new]*_b[log_civ_fut:new_No_min_acc_diet_hh]
	
	* 6 months
gsem (new_No_min_acc_diet_hh <- anom_rain6_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_acc_diet_hh anom_rain6_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_6month_1.xls", replace keep(new_No_min_acc_diet_hh anom_rain6_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain6_NEG_new]*_b[log_vio_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_NEG_new] + _b[new_No_min_acc_diet_hh:anom_rain6_NEG_new]*_b[log_vio_fut:new_No_min_acc_diet_hh]
 
 	* 6 months
gsem (new_No_min_acc_diet_hh <- anom_rain6_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_acc_diet_hh anom_rain6_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_6month_civ.xls", replace keep(new_No_min_acc_diet_hh anom_rain6_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain6_NEG_new]*_b[log_civ_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_NEG_new] + _b[new_No_min_acc_diet_hh:anom_rain6_NEG_new]*_b[log_civ_fut:new_No_min_acc_diet_hh]
	
	
	
	* 3 months
gsem (new_No_min_acc_diet_hh <- anom_rain3_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_acc_diet_hh anom_rain3_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_3month_1.xls", replace keep(new_No_min_acc_diet_hh anom_rain3_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain3_NEG_new]*_b[log_vio_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_NEG_new] + _b[new_No_min_acc_diet_hh:anom_rain3_NEG_new]*_b[log_vio_fut:new_No_min_acc_diet_hh]
 
 	* 3 months
gsem (new_No_min_acc_diet_hh <- anom_rain3_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_acc_diet_hh anom_rain3_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_3month_civ.xls", replace keep(new_No_min_acc_diet_hh anom_rain3_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain3_NEG_new]*_b[log_civ_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_NEG_new] + _b[new_No_min_acc_diet_hh:anom_rain3_NEG_new]*_b[log_civ_fut:new_No_min_acc_diet_hh]
	

	
****** Nutritional insecurity and rainfall abbundace 

***** Acceptable diet CHILDREN*****
** sem **
gsem (new_No_min_acc_diet_hh <- anom_rain12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_acc_diet_hh anom_rain12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_12month_1.xls", replace keep(new_No_min_acc_diet_hh anom_rain12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain12_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_POS] + _b[new_No_min_acc_diet_hh:anom_rain12_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh]

** sem **
gsem (new_No_min_acc_diet_hh <- anom_rain12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_acc_diet_hh anom_rain12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_12month_civ.xls", replace keep(new_No_min_acc_diet_hh anom_rain12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain12_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_POS] + _b[new_No_min_acc_diet_hh:anom_rain12_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh]

	* 9 months
gsem (new_No_min_acc_diet_hh <- anom_rain9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_acc_diet_hh anom_rain9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_9month_1.xls", replace keep(new_No_min_acc_diet_hh anom_rain9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain9_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_POS] + _b[new_No_min_acc_diet_hh:anom_rain9_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh]
 
 	* 9 months
gsem (new_No_min_acc_diet_hh <- anom_rain9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_acc_diet_hh anom_rain9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_9month_civ.xls", replace keep(new_No_min_acc_diet_hh anom_rain9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain9_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_POS] + _b[new_No_min_acc_diet_hh:anom_rain9_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh]
	
	* 6 months
gsem (new_No_min_acc_diet_hh <- anom_rain6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_acc_diet_hh anom_rain6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_6month_1.xls", replace keep(new_No_min_acc_diet_hh anom_rain6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain6_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_POS] + _b[new_No_min_acc_diet_hh:anom_rain6_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh]
 
 	* 6 months
gsem (new_No_min_acc_diet_hh <- anom_rain6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_acc_diet_hh anom_rain6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_6month_civ.xls", replace keep(new_No_min_acc_diet_hh anom_rain6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain6_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_POS] + _b[new_No_min_acc_diet_hh:anom_rain6_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh]
	
	
	
	* 3 months
gsem (new_No_min_acc_diet_hh <- anom_rain3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- new_No_min_acc_diet_hh anom_rain3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_3month_1.xls", replace keep(new_No_min_acc_diet_hh anom_rain3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain3_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_POS] + _b[new_No_min_acc_diet_hh:anom_rain3_POS]*_b[log_vio_fut:new_No_min_acc_diet_hh]
 
 	* 3 months
gsem (new_No_min_acc_diet_hh <- anom_rain3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- new_No_min_acc_diet_hh anom_rain3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_acc_3month_civ.xls", replace keep(new_No_min_acc_diet_hh anom_rain3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[new_No_min_acc_diet_hh:anom_rain3_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_POS] + _b[new_No_min_acc_diet_hh:anom_rain3_POS]*_b[log_civ_fut:new_No_min_acc_diet_hh]


 
 
 
 
 ***** Food prices *****
 gl control1v urban log_vio_pres
 gl control2v urban log_vio_pres ethnic_diversity_std
 
 gl control1c urban log_civ_pres
 gl control2c urban log_civ_pres ethnic_diversity_std
 


****** Nutritional insecurity and temperatures 

***** maizeeptable diet CHILDREN*****
** sem **
gsem (log_Maize_white <- anom_tmax12_POS $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_tmax12_POS $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_12month_1.xls", replace keep(log_Maize_white anom_tmax12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_tmax12_POS]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax12_POS] + _b[log_Maize_white:anom_tmax12_POS]*_b[log_vio_fut:log_Maize_white]

** sem **
gsem (log_Maize_white <- anom_tmax12_POS $control1c i.quarter#i.year i.region_id) ///
(log_civ_fut <- log_Maize_white anom_tmax12_POS $control2c i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_12month_civ.xls", replace keep(log_Maize_white anom_tmax12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_tmax12_POS]*_b[log_civ_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax12_POS] + _b[log_Maize_white:anom_tmax12_POS]*_b[log_civ_fut:log_Maize_white]

	* 9 months
gsem (log_Maize_white <- anom_tmax9_POS $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_tmax9_POS $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_9month_1.xls", replace keep(log_Maize_white anom_tmax9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_tmax9_POS]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax9_POS] + _b[log_Maize_white:anom_tmax9_POS]*_b[log_vio_fut:log_Maize_white]
 
 	* 9 months
gsem (log_Maize_white <- anom_tmax9_POS $control1c i.quarter#i.year i.region_id ) ///
(log_civ_fut <- log_Maize_white anom_tmax9_POS $control2c i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_9month_civ.xls", replace keep(log_Maize_white anom_tmax9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_tmax9_POS]*_b[log_civ_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax9_POS] + _b[log_Maize_white:anom_tmax9_POS]*_b[log_civ_fut:log_Maize_white]
	
	* 6 months
gsem (log_Maize_white <- anom_tmax6_POS $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_tmax6_POS $control2v i.quarter#i.year i.region_id ),
outreg2 using "$tables\GSEM_maize_6month_1.xls", replace keep(log_Maize_white anom_tmax6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_tmax6_POS]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax6_POS] + _b[log_Maize_white:anom_tmax6_POS]*_b[log_vio_fut:log_Maize_white]
 
 	* 6 months
gsem (log_Maize_white <- anom_tmax6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Maize_white anom_tmax6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_maize_6month_civ.xls", replace keep(log_Maize_white anom_tmax6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_tmax6_POS]*_b[log_civ_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax6_POS] + _b[log_Maize_white:anom_tmax6_POS]*_b[log_civ_fut:log_Maize_white]
	
	
	
	* 3 months
gsem (log_Maize_white <- anom_tmax3_POS $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_tmax3_POS $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_3month_1.xls", replace keep(log_Maize_white anom_tmax3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_tmax3_POS]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax3_POS] + _b[log_Maize_white:anom_tmax3_POS]*_b[log_vio_fut:log_Maize_white]
 
 	* 3 months
gsem (log_Maize_white <- anom_tmax3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Maize_white anom_tmax3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_maize_3month_civ.xls", replace keep(log_Maize_white anom_tmax3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_tmax3_POS]*_b[log_civ_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax3_POS] + _b[log_Maize_white:anom_tmax3_POS]*_b[log_civ_fut:log_Maize_white]
	
	
****** Nutritional insecurity and lack of rainfall  

***** maizeeptable diet CHILDREN*****
** sem **
gsem (log_Maize_white <- anom_rain12_NEG_new $control1v i.quarter#i.year i.region_id) ///
(log_vio_fut <- log_Maize_white anom_rain12_NEG_new $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_12month_1.xls", replace keep(log_Maize_white anom_rain12_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain12_NEG_new]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_NEG_new] + _b[log_Maize_white:anom_rain12_NEG_new]*_b[log_vio_fut:log_Maize_white]

** sem **
gsem (log_Maize_white <- anom_rain12_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Maize_white anom_rain12_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_maize_12month_civ.xls", replace keep(log_Maize_white anom_rain12_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain12_NEG_new]*_b[log_civ_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_NEG_new] + _b[log_Maize_white:anom_rain12_NEG_new]*_b[log_civ_fut:log_Maize_white]

	* 9 months
gsem (log_Maize_white <- anom_rain9_NEG_new $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_rain9_NEG_new $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_9month_1.xls", replace keep(log_Maize_white anom_rain9_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain9_NEG_new]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_NEG_new] + _b[log_Maize_white:anom_rain9_NEG_new]*_b[log_vio_fut:log_Maize_white]
 
 	* 9 months
gsem (log_Maize_white <- anom_rain9_NEG_new $control1c i.quarter#i.year i.region_id ) ///
(log_civ_fut <- log_Maize_white anom_rain9_NEG_new $control2c i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_9month_civ.xls", replace keep(log_Maize_white anom_rain9_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain9_NEG_new]*_b[log_civ_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_NEG_new] + _b[log_Maize_white:anom_rain9_NEG_new]*_b[log_civ_fut:log_Maize_white]
	
	* 6 months
gsem (log_Maize_white <- anom_rain6_NEG_new $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_rain6_NEG_new $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_6month_1.xls", replace keep(log_Maize_white anom_rain6_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain6_NEG_new]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_NEG_new] + _b[log_Maize_white:anom_rain6_NEG_new]*_b[log_vio_fut:log_Maize_white]
 
 	* 6 months
gsem (log_Maize_white <- anom_rain6_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Maize_white anom_rain6_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_maize_6month_civ.xls", replace keep(log_Maize_white anom_rain6_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain6_NEG_new]*_b[log_civ_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_NEG_new] + _b[log_Maize_white:anom_rain6_NEG_new]*_b[log_civ_fut:log_Maize_white]
	
	
	
	* 3 months
gsem (log_Maize_white <- anom_rain3_NEG_new $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_rain3_NEG_new $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_3month_1.xls", replace keep(log_Maize_white anom_rain3_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain3_NEG_new]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_NEG_new] + _b[log_Maize_white:anom_rain3_NEG_new]*_b[log_vio_fut:log_Maize_white]
 
 	* 3 months
gsem (log_Maize_white <- anom_rain3_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Maize_white anom_rain3_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_maize_3month_civ.xls", replace keep(log_Maize_white anom_rain3_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain3_NEG_new]*_b[log_civ_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_NEG_new] + _b[log_Maize_white:anom_rain3_NEG_new]*_b[log_civ_fut:log_Maize_white]
	

	
****** Nutritional insecurity and rainfall abbundace 

***** maizeeptable diet CHILDREN*****
** sem **
gsem (log_Maize_white <- anom_rain12_POS $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_rain12_POS $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_12month_1.xls", replace keep(log_Maize_white anom_rain12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain12_POS]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_POS] + _b[log_Maize_white:anom_rain12_POS]*_b[log_vio_fut:log_Maize_white]

** sem **
gsem (log_Maize_white <- anom_rain12_POS $control1c i.quarter#i.year i.region_id ) ///
(log_civ_fut <- log_Maize_white anom_rain12_POS $control2c i.quarter#i.year i.region_id ),
outreg2 using "$tables\GSEM_maize_12month_civ.xls", replace keep(log_Maize_white anom_rain12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain12_POS]*_b[log_civ_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_POS] + _b[log_Maize_white:anom_rain12_POS]*_b[log_civ_fut:log_Maize_white]

	* 9 months
gsem (log_Maize_white <- anom_rain9_POS $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_rain9_POS $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_9month_1.xls", replace keep(log_Maize_white anom_rain9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain9_POS]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_POS] + _b[log_Maize_white:anom_rain9_POS]*_b[log_vio_fut:log_Maize_white]
 
 	* 9 months
gsem (log_Maize_white <- anom_rain9_POS $control1c i.quarter#i.year i.region_id ) ///
(log_civ_fut <- log_Maize_white anom_rain9_POS $control2c i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_9month_civ.xls", replace keep(log_Maize_white anom_rain9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain9_POS]*_b[log_civ_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_POS] + _b[log_Maize_white:anom_rain9_POS]*_b[log_civ_fut:log_Maize_white]
	
	* 6 months
gsem (log_Maize_white <- anom_rain6_POS $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_rain6_POS $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_6month_1.xls", replace keep(log_Maize_white anom_rain6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain6_POS]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_POS] + _b[log_Maize_white:anom_rain6_POS]*_b[log_vio_fut:log_Maize_white]
 
 	* 6 months
gsem (log_Maize_white <- anom_rain6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Maize_white anom_rain6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_maize_6month_civ.xls", replace keep(log_Maize_white anom_rain6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain6_POS]*_b[log_civ_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_POS] + _b[log_Maize_white:anom_rain6_POS]*_b[log_civ_fut:log_Maize_white]
	
	
	
	* 3 months
gsem (log_Maize_white <- anom_rain3_POS $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_rain3_POS $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_3month_1.xls", replace keep(log_Maize_white anom_rain3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain3_POS]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_POS] + _b[log_Maize_white:anom_rain3_POS]*_b[log_vio_fut:log_Maize_white]
 
 	* 3 months
gsem (log_Maize_white <- anom_rain3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Maize_white anom_rain3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_maize_3month_civ.xls", replace keep(log_Maize_white anom_rain3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:anom_rain3_POS]*_b[log_civ_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_POS] + _b[log_Maize_white:anom_rain3_POS]*_b[log_civ_fut:log_Maize_white]


 
 ****** Nutritional insecurity and temperatures 

***** Wheateptable diet CHILDREN*****
** sem **
gsem (log_Wheat <- anom_tmax12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Wheat anom_tmax12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_12month_1.xls", replace keep(log_Wheat anom_tmax12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_tmax12_POS]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax12_POS] + _b[log_Wheat:anom_tmax12_POS]*_b[log_vio_fut:log_Wheat]

** sem **
gsem (log_Wheat <- anom_tmax12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Wheat anom_tmax12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_12month_civ.xls", replace keep(log_Wheat anom_tmax12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_tmax12_POS]*_b[log_civ_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax12_POS] + _b[log_Wheat:anom_tmax12_POS]*_b[log_civ_fut:log_Wheat]

	* 9 months
gsem (log_Wheat <- anom_tmax9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Wheat anom_tmax9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_9month_1.xls", replace keep(log_Wheat anom_tmax9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_tmax9_POS]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax9_POS] + _b[log_Wheat:anom_tmax9_POS]*_b[log_vio_fut:log_Wheat]
 
 	* 9 months
gsem (log_Wheat <- anom_tmax9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Wheat anom_tmax9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_9month_civ.xls", replace keep(log_Wheat anom_tmax9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_tmax9_POS]*_b[log_civ_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax9_POS] + _b[log_Wheat:anom_tmax9_POS]*_b[log_civ_fut:log_Wheat]
	
	* 6 months
gsem (log_Wheat <- anom_tmax6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Wheat anom_tmax6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_6month_1.xls", replace keep(log_Wheat anom_tmax6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_tmax6_POS]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax6_POS] + _b[log_Wheat:anom_tmax6_POS]*_b[log_vio_fut:log_Wheat]
 
 	* 6 months
gsem (log_Wheat <- anom_tmax6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Wheat anom_tmax6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_6month_civ.xls", replace keep(log_Wheat anom_tmax6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_tmax6_POS]*_b[log_civ_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax6_POS] + _b[log_Wheat:anom_tmax6_POS]*_b[log_civ_fut:log_Wheat]
	
	
	
	* 3 months
gsem (log_Wheat <- anom_tmax3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Wheat anom_tmax3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_3month_1.xls", replace keep(log_Wheat anom_tmax3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_tmax3_POS]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax3_POS] + _b[log_Wheat:anom_tmax3_POS]*_b[log_vio_fut:log_Wheat]
 
 	* 3 months
gsem (log_Wheat <- anom_tmax3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Wheat anom_tmax3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_3month_civ.xls", replace keep(log_Wheat anom_tmax3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_tmax3_POS]*_b[log_civ_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax3_POS] + _b[log_Wheat:anom_tmax3_POS]*_b[log_civ_fut:log_Wheat]
	
	
****** Nutritional insecurity and lack of rainfall  

***** Wheateptable diet CHILDREN*****
** sem **
gsem (log_Wheat <- anom_rain12_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Wheat anom_rain12_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_12month_1.xls", replace keep(log_Wheat anom_rain12_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain12_NEG_new]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_NEG_new] + _b[log_Wheat:anom_rain12_NEG_new]*_b[log_vio_fut:log_Wheat]

** sem **
gsem (log_Wheat <- anom_rain12_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Wheat anom_rain12_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_12month_civ.xls", replace keep(log_Wheat anom_rain12_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain12_NEG_new]*_b[log_civ_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_NEG_new] + _b[log_Wheat:anom_rain12_NEG_new]*_b[log_civ_fut:log_Wheat]

	* 9 months
gsem (log_Wheat <- anom_rain9_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Wheat anom_rain9_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_9month_1.xls", replace keep(log_Wheat anom_rain9_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain9_NEG_new]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_NEG_new] + _b[log_Wheat:anom_rain9_NEG_new]*_b[log_vio_fut:log_Wheat]
 
 	* 9 months
gsem (log_Wheat <- anom_rain9_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Wheat anom_rain9_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_9month_civ.xls", replace keep(log_Wheat anom_rain9_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain9_NEG_new]*_b[log_civ_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_NEG_new] + _b[log_Wheat:anom_rain9_NEG_new]*_b[log_civ_fut:log_Wheat]
	
	* 6 months
gsem (log_Wheat <- anom_rain6_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Wheat anom_rain6_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_6month_1.xls", replace keep(log_Wheat anom_rain6_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain6_NEG_new]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_NEG_new] + _b[log_Wheat:anom_rain6_NEG_new]*_b[log_vio_fut:log_Wheat]
 
 	* 6 months
gsem (log_Wheat <- anom_rain6_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Wheat anom_rain6_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_6month_civ.xls", replace keep(log_Wheat anom_rain6_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain6_NEG_new]*_b[log_civ_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_NEG_new] + _b[log_Wheat:anom_rain6_NEG_new]*_b[log_civ_fut:log_Wheat]
	
	
	
	* 3 months
gsem (log_Wheat <- anom_rain3_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Wheat anom_rain3_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_3month_1.xls", replace keep(log_Wheat anom_rain3_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain3_NEG_new]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_NEG_new] + _b[log_Wheat:anom_rain3_NEG_new]*_b[log_vio_fut:log_Wheat]
 
 	* 3 months
gsem (log_Wheat <- anom_rain3_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Wheat anom_rain3_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_3month_civ.xls", replace keep(log_Wheat anom_rain3_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain3_NEG_new]*_b[log_civ_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_NEG_new] + _b[log_Wheat:anom_rain3_NEG_new]*_b[log_civ_fut:log_Wheat]
	

	
****** Nutritional insecurity and rainfall abbundace 

***** Wheateptable diet CHILDREN*****
** sem **
gsem (log_Wheat <- anom_rain12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Wheat anom_rain12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_12month_1.xls", replace keep(log_Wheat anom_rain12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain12_POS]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_POS] + _b[log_Wheat:anom_rain12_POS]*_b[log_vio_fut:log_Wheat]

** sem **
gsem (log_Wheat <- anom_rain12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Wheat anom_rain12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_12month_civ.xls", replace keep(log_Wheat anom_rain12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain12_POS]*_b[log_civ_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_POS] + _b[log_Wheat:anom_rain12_POS]*_b[log_civ_fut:log_Wheat]

	* 9 months
gsem (log_Wheat <- anom_rain9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Wheat anom_rain9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_9month_1.xls", replace keep(log_Wheat anom_rain9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain9_POS]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_POS] + _b[log_Wheat:anom_rain9_POS]*_b[log_vio_fut:log_Wheat]
 
 	* 9 months
gsem (log_Wheat <- anom_rain9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Wheat anom_rain9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_9month_civ.xls", replace keep(log_Wheat anom_rain9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain9_POS]*_b[log_civ_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_POS] + _b[log_Wheat:anom_rain9_POS]*_b[log_civ_fut:log_Wheat]
	
	* 6 months
gsem (log_Wheat <- anom_rain6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Wheat anom_rain6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_6month_1.xls", replace keep(log_Wheat anom_rain6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain6_POS]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_POS] + _b[log_Wheat:anom_rain6_POS]*_b[log_vio_fut:log_Wheat]
 
 	* 6 months
gsem (log_Wheat <- anom_rain6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Wheat anom_rain6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_6month_civ.xls", replace keep(log_Wheat anom_rain6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain6_POS]*_b[log_civ_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_POS] + _b[log_Wheat:anom_rain6_POS]*_b[log_civ_fut:log_Wheat]
	
	
	
	* 3 months
gsem (log_Wheat <- anom_rain3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Wheat anom_rain3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_3month_1.xls", replace keep(log_Wheat anom_rain3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain3_POS]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_POS] + _b[log_Wheat:anom_rain3_POS]*_b[log_vio_fut:log_Wheat]
 
 	* 3 months
gsem (log_Wheat <- anom_rain3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Wheat anom_rain3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Wheat_3month_civ.xls", replace keep(log_Wheat anom_rain3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:anom_rain3_POS]*_b[log_civ_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_POS] + _b[log_Wheat:anom_rain3_POS]*_b[log_civ_fut:log_Wheat]


 
 
 
 
 ***** Sorghum ****** 
 
  
 ****** Nutritional insecurity and temperatures 

***** Sorghumeptable diet CHILDREN*****
** sem **
gsem (log_Sorghum <- anom_tmax12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Sorghum anom_tmax12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_12month_1.xls", replace keep(log_Sorghum anom_tmax12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_tmax12_POS]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax12_POS] + _b[log_Sorghum:anom_tmax12_POS]*_b[log_vio_fut:log_Sorghum]

** sem **
gsem (log_Sorghum <- anom_tmax12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Sorghum anom_tmax12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_12month_civ.xls", replace keep(log_Sorghum anom_tmax12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_tmax12_POS]*_b[log_civ_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax12_POS] + _b[log_Sorghum:anom_tmax12_POS]*_b[log_civ_fut:log_Sorghum]

	* 9 months
gsem (log_Sorghum <- anom_tmax9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Sorghum anom_tmax9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_9month_1.xls", replace keep(log_Sorghum anom_tmax9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_tmax9_POS]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax9_POS] + _b[log_Sorghum:anom_tmax9_POS]*_b[log_vio_fut:log_Sorghum]
 
 	* 9 months
gsem (log_Sorghum <- anom_tmax9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Sorghum anom_tmax9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_9month_civ.xls", replace keep(log_Sorghum anom_tmax9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_tmax9_POS]*_b[log_civ_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax9_POS] + _b[log_Sorghum:anom_tmax9_POS]*_b[log_civ_fut:log_Sorghum]
	
	* 6 months
gsem (log_Sorghum <- anom_tmax6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Sorghum anom_tmax6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_6month_1.xls", replace keep(log_Sorghum anom_tmax6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_tmax6_POS]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax6_POS] + _b[log_Sorghum:anom_tmax6_POS]*_b[log_vio_fut:log_Sorghum]
 
 	* 6 months
gsem (log_Sorghum <- anom_tmax6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Sorghum anom_tmax6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_6month_civ.xls", replace keep(log_Sorghum anom_tmax6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_tmax6_POS]*_b[log_civ_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax6_POS] + _b[log_Sorghum:anom_tmax6_POS]*_b[log_civ_fut:log_Sorghum]
	
	
	
	* 3 months
gsem (log_Sorghum <- anom_tmax3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Sorghum anom_tmax3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_3month_1.xls", replace keep(log_Sorghum anom_tmax3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_tmax3_POS]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax3_POS] + _b[log_Sorghum:anom_tmax3_POS]*_b[log_vio_fut:log_Sorghum]
 
 	* 3 months
gsem (log_Sorghum <- anom_tmax3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Sorghum anom_tmax3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_3month_civ.xls", replace keep(log_Sorghum anom_tmax3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_tmax3_POS]*_b[log_civ_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax3_POS] + _b[log_Sorghum:anom_tmax3_POS]*_b[log_civ_fut:log_Sorghum]
	
	
****** Nutritional insecurity and lack of rainfall  

***** Sorghumeptable diet CHILDREN*****
** sem **
gsem (log_Sorghum <- anom_rain12_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Sorghum anom_rain12_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_12month_1.xls", replace keep(log_Sorghum anom_rain12_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain12_NEG_new]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_NEG_new] + _b[log_Sorghum:anom_rain12_NEG_new]*_b[log_vio_fut:log_Sorghum]

** sem **
gsem (log_Sorghum <- anom_rain12_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Sorghum anom_rain12_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_12month_civ.xls", replace keep(log_Sorghum anom_rain12_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain12_NEG_new]*_b[log_civ_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_NEG_new] + _b[log_Sorghum:anom_rain12_NEG_new]*_b[log_civ_fut:log_Sorghum]

	* 9 months
gsem (log_Sorghum <- anom_rain9_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Sorghum anom_rain9_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_9month_1.xls", replace keep(log_Sorghum anom_rain9_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain9_NEG_new]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_NEG_new] + _b[log_Sorghum:anom_rain9_NEG_new]*_b[log_vio_fut:log_Sorghum]
 
 	* 9 months
gsem (log_Sorghum <- anom_rain9_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Sorghum anom_rain9_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_9month_civ.xls", replace keep(log_Sorghum anom_rain9_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain9_NEG_new]*_b[log_civ_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_NEG_new] + _b[log_Sorghum:anom_rain9_NEG_new]*_b[log_civ_fut:log_Sorghum]
	
	* 6 months
gsem (log_Sorghum <- anom_rain6_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Sorghum anom_rain6_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_6month_1.xls", replace keep(log_Sorghum anom_rain6_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain6_NEG_new]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_NEG_new] + _b[log_Sorghum:anom_rain6_NEG_new]*_b[log_vio_fut:log_Sorghum]
 
 	* 6 months
gsem (log_Sorghum <- anom_rain6_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Sorghum anom_rain6_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_6month_civ.xls", replace keep(log_Sorghum anom_rain6_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain6_NEG_new]*_b[log_civ_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_NEG_new] + _b[log_Sorghum:anom_rain6_NEG_new]*_b[log_civ_fut:log_Sorghum]
	
	
	
	* 3 months
gsem (log_Sorghum <- anom_rain3_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Sorghum anom_rain3_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_3month_1.xls", replace keep(log_Sorghum anom_rain3_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain3_NEG_new]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_NEG_new] + _b[log_Sorghum:anom_rain3_NEG_new]*_b[log_vio_fut:log_Sorghum]
 
 	* 3 months
gsem (log_Sorghum <- anom_rain3_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Sorghum anom_rain3_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_3month_civ.xls", replace keep(log_Sorghum anom_rain3_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain3_NEG_new]*_b[log_civ_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_NEG_new] + _b[log_Sorghum:anom_rain3_NEG_new]*_b[log_civ_fut:log_Sorghum]
	

	
****** Nutritional insecurity and rainfall abbundace 

***** Sorghumeptable diet CHILDREN*****
** sem **
gsem (log_Sorghum <- anom_rain12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Sorghum anom_rain12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_12month_1.xls", replace keep(log_Sorghum anom_rain12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain12_POS]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_POS] + _b[log_Sorghum:anom_rain12_POS]*_b[log_vio_fut:log_Sorghum]

** sem **
gsem (log_Sorghum <- anom_rain12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Sorghum anom_rain12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_12month_civ.xls", replace keep(log_Sorghum anom_rain12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain12_POS]*_b[log_civ_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_POS] + _b[log_Sorghum:anom_rain12_POS]*_b[log_civ_fut:log_Sorghum]

	* 9 months
gsem (log_Sorghum <- anom_rain9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Sorghum anom_rain9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_9month_1.xls", replace keep(log_Sorghum anom_rain9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain9_POS]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_POS] + _b[log_Sorghum:anom_rain9_POS]*_b[log_vio_fut:log_Sorghum]
 
 	* 9 months
gsem (log_Sorghum <- anom_rain9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Sorghum anom_rain9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_9month_civ.xls", replace keep(log_Sorghum anom_rain9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain9_POS]*_b[log_civ_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_POS] + _b[log_Sorghum:anom_rain9_POS]*_b[log_civ_fut:log_Sorghum]
	
	* 6 months
gsem (log_Sorghum <- anom_rain6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Sorghum anom_rain6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_6month_1.xls", replace keep(log_Sorghum anom_rain6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain6_POS]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_POS] + _b[log_Sorghum:anom_rain6_POS]*_b[log_vio_fut:log_Sorghum]
 
 	* 6 months
gsem (log_Sorghum <- anom_rain6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Sorghum anom_rain6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_6month_civ.xls", replace keep(log_Sorghum anom_rain6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain6_POS]*_b[log_civ_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_POS] + _b[log_Sorghum:anom_rain6_POS]*_b[log_civ_fut:log_Sorghum]
	
	
	
	* 3 months
gsem (log_Sorghum <- anom_rain3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Sorghum anom_rain3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_3month_1.xls", replace keep(log_Sorghum anom_rain3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain3_POS]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_POS] + _b[log_Sorghum:anom_rain3_POS]*_b[log_vio_fut:log_Sorghum]
 
 	* 3 months
gsem (log_Sorghum <- anom_rain3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Sorghum anom_rain3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sorghum_3month_civ.xls", replace keep(log_Sorghum anom_rain3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:anom_rain3_POS]*_b[log_civ_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_POS] + _b[log_Sorghum:anom_rain3_POS]*_b[log_civ_fut:log_Sorghum]


 
 
 
 
 
 
 
 *sheep *** 
 
 
  ****** Nutritional insecurity and temperatures 

** sem **
gsem (log_Livestock_Sheep <- anom_tmax12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Livestock_Sheep anom_tmax12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_12month_1.xls", replace keep(log_Livestock_Sheep anom_tmax12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_tmax12_POS]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax12_POS] + _b[log_Livestock_Sheep:anom_tmax12_POS]*_b[log_vio_fut:log_Livestock_Sheep]

** sem **
gsem (log_Livestock_Sheep <- anom_tmax12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Livestock_Sheep anom_tmax12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_12month_civ.xls", replace keep(log_Livestock_Sheep anom_tmax12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_tmax12_POS]*_b[log_civ_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax12_POS] + _b[log_Livestock_Sheep:anom_tmax12_POS]*_b[log_civ_fut:log_Livestock_Sheep]

	* 9 months
gsem (log_Livestock_Sheep <- anom_tmax9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Livestock_Sheep anom_tmax9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_9month_1.xls", replace keep(log_Livestock_Sheep anom_tmax9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_tmax9_POS]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax9_POS] + _b[log_Livestock_Sheep:anom_tmax9_POS]*_b[log_vio_fut:log_Livestock_Sheep]
 
 	* 9 months
gsem (log_Livestock_Sheep <- anom_tmax9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Livestock_Sheep anom_tmax9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_9month_civ.xls", replace keep(log_Livestock_Sheep anom_tmax9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_tmax9_POS]*_b[log_civ_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax9_POS] + _b[log_Livestock_Sheep:anom_tmax9_POS]*_b[log_civ_fut:log_Livestock_Sheep]
	
	* 6 months
gsem (log_Livestock_Sheep <- anom_tmax6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Livestock_Sheep anom_tmax6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_6month_1.xls", replace keep(log_Livestock_Sheep anom_tmax6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_tmax6_POS]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax6_POS] + _b[log_Livestock_Sheep:anom_tmax6_POS]*_b[log_vio_fut:log_Livestock_Sheep]
 
 	* 6 months
gsem (log_Livestock_Sheep <- anom_tmax6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Livestock_Sheep anom_tmax6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_6month_civ.xls", replace keep(log_Livestock_Sheep anom_tmax6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_tmax6_POS]*_b[log_civ_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax6_POS] + _b[log_Livestock_Sheep:anom_tmax6_POS]*_b[log_civ_fut:log_Livestock_Sheep]
	
	
	
	* 3 months
gsem (log_Livestock_Sheep <- anom_tmax3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Livestock_Sheep anom_tmax3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_3month_1.xls", replace keep(log_Livestock_Sheep anom_tmax3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_tmax3_POS]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_tmax3_POS] + _b[log_Livestock_Sheep:anom_tmax3_POS]*_b[log_vio_fut:log_Livestock_Sheep]
 
 	* 3 months
gsem (log_Livestock_Sheep <- anom_tmax3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Livestock_Sheep anom_tmax3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_3month_civ.xls", replace keep(log_Livestock_Sheep anom_tmax3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_tmax3_POS]*_b[log_civ_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_tmax3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_tmax3_POS] + _b[log_Livestock_Sheep:anom_tmax3_POS]*_b[log_civ_fut:log_Livestock_Sheep]
	
	
****** Nutritional insecurity and lack of rainfall  

***** Sheepeptable diet CHILDREN*****
** sem **
gsem (log_Livestock_Sheep <- anom_rain12_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Livestock_Sheep anom_rain12_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_12month_1.xls", replace keep(log_Livestock_Sheep anom_rain12_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain12_NEG_new]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_NEG_new] + _b[log_Livestock_Sheep:anom_rain12_NEG_new]*_b[log_vio_fut:log_Livestock_Sheep]

** sem **
gsem (log_Livestock_Sheep <- anom_rain12_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Livestock_Sheep anom_rain12_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_12month_civ.xls", replace keep(log_Livestock_Sheep anom_rain12_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain12_NEG_new]*_b[log_civ_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_NEG_new] + _b[log_Livestock_Sheep:anom_rain12_NEG_new]*_b[log_civ_fut:log_Livestock_Sheep]

	* 9 months
gsem (log_Livestock_Sheep <- anom_rain9_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Livestock_Sheep anom_rain9_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_9month_1.xls", replace keep(log_Livestock_Sheep anom_rain9_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain9_NEG_new]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_NEG_new] + _b[log_Livestock_Sheep:anom_rain9_NEG_new]*_b[log_vio_fut:log_Livestock_Sheep]
 
 	* 9 months
gsem (log_Livestock_Sheep <- anom_rain9_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Livestock_Sheep anom_rain9_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_9month_civ.xls", replace keep(log_Livestock_Sheep anom_rain9_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain9_NEG_new]*_b[log_civ_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_NEG_new] + _b[log_Livestock_Sheep:anom_rain9_NEG_new]*_b[log_civ_fut:log_Livestock_Sheep]
	
	* 6 months
gsem (log_Livestock_Sheep <- anom_rain6_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Livestock_Sheep anom_rain6_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_6month_1.xls", replace keep(log_Livestock_Sheep anom_rain6_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain6_NEG_new]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_NEG_new] + _b[log_Livestock_Sheep:anom_rain6_NEG_new]*_b[log_vio_fut:log_Livestock_Sheep]
 
 	* 6 months
gsem (log_Livestock_Sheep <- anom_rain6_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Livestock_Sheep anom_rain6_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_6month_civ.xls", replace keep(log_Livestock_Sheep anom_rain6_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain6_NEG_new]*_b[log_civ_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_NEG_new] + _b[log_Livestock_Sheep:anom_rain6_NEG_new]*_b[log_civ_fut:log_Livestock_Sheep]
	
	
	
	* 3 months
gsem (log_Livestock_Sheep <- anom_rain3_NEG_new $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Livestock_Sheep anom_rain3_NEG_new $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_3month_1.xls", replace keep(log_Livestock_Sheep anom_rain3_NEG_new $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain3_NEG_new]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_NEG_new] + _b[log_Livestock_Sheep:anom_rain3_NEG_new]*_b[log_vio_fut:log_Livestock_Sheep]
 
 	* 3 months
gsem (log_Livestock_Sheep <- anom_rain3_NEG_new $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Livestock_Sheep anom_rain3_NEG_new $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_3month_civ.xls", replace keep(log_Livestock_Sheep anom_rain3_NEG_new $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain3_NEG_new]*_b[log_civ_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_NEG_new]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_NEG_new] + _b[log_Livestock_Sheep:anom_rain3_NEG_new]*_b[log_civ_fut:log_Livestock_Sheep]
	

	
****** Nutritional insecurity and rainfall abbundace 

***** Sheepeptable diet CHILDREN*****
** sem **
gsem (log_Livestock_Sheep <- anom_rain12_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Livestock_Sheep anom_rain12_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_12month_1.xls", replace keep(log_Livestock_Sheep anom_rain12_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain12_POS]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain12_POS] + _b[log_Livestock_Sheep:anom_rain12_POS]*_b[log_vio_fut:log_Livestock_Sheep]

** sem **
gsem (log_Livestock_Sheep <- anom_rain12_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Livestock_Sheep anom_rain12_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_12month_civ.xls", replace keep(log_Livestock_Sheep anom_rain12_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain12_POS]*_b[log_civ_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain12_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain12_POS] + _b[log_Livestock_Sheep:anom_rain12_POS]*_b[log_civ_fut:log_Livestock_Sheep]

	* 9 months
gsem (log_Livestock_Sheep <- anom_rain9_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Livestock_Sheep anom_rain9_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_9month_1.xls", replace keep(log_Livestock_Sheep anom_rain9_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain9_POS]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain9_POS] + _b[log_Livestock_Sheep:anom_rain9_POS]*_b[log_vio_fut:log_Livestock_Sheep]
 
 	* 9 months
gsem (log_Livestock_Sheep <- anom_rain9_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Livestock_Sheep anom_rain9_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_9month_civ.xls", replace keep(log_Livestock_Sheep anom_rain9_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain9_POS]*_b[log_civ_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain9_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain9_POS] + _b[log_Livestock_Sheep:anom_rain9_POS]*_b[log_civ_fut:log_Livestock_Sheep]
	
	* 6 months
gsem (log_Livestock_Sheep <- anom_rain6_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Livestock_Sheep anom_rain6_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_6month_1.xls", replace keep(log_Livestock_Sheep anom_rain6_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain6_POS]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain6_POS] + _b[log_Livestock_Sheep:anom_rain6_POS]*_b[log_vio_fut:log_Livestock_Sheep]
 
 	* 6 months
gsem (log_Livestock_Sheep <- anom_rain6_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Livestock_Sheep anom_rain6_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_6month_civ.xls", replace keep(log_Livestock_Sheep anom_rain6_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain6_POS]*_b[log_civ_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain6_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain6_POS] + _b[log_Livestock_Sheep:anom_rain6_POS]*_b[log_civ_fut:log_Livestock_Sheep]
	
	
	
	* 3 months
gsem (log_Livestock_Sheep <- anom_rain3_POS $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Livestock_Sheep anom_rain3_POS $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_3month_1.xls", replace keep(log_Livestock_Sheep anom_rain3_POS $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain3_POS]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_vio_fut:anom_rain3_POS] + _b[log_Livestock_Sheep:anom_rain3_POS]*_b[log_vio_fut:log_Livestock_Sheep]
 
 	* 3 months
gsem (log_Livestock_Sheep <- anom_rain3_POS $control1c i.quarter#i.year i.region_id M1[grid_id]) ///
(log_civ_fut <- log_Livestock_Sheep anom_rain3_POS $control2c i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_3month_civ.xls", replace keep(log_Livestock_Sheep anom_rain3_POS $control1c $control2c) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:anom_rain3_POS]*_b[log_civ_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_civ_fut:anom_rain3_POS]

*total effect 
 nlcom  _b[log_civ_fut:anom_rain3_POS] + _b[log_Livestock_Sheep:anom_rain3_POS]*_b[log_civ_fut:log_Livestock_Sheep]


 
 
 **** ADDITIONAL TRYALS WITH PRICES****
 
  
 ***** Food prices *****
 gl control1v urban log_vio_pres
 gl control2v urban log_vio_pres ethnic_diversity_std
 
 gl control1c urban log_civ_pres
 gl control2c urban log_civ_pres ethnic_diversity_std
 
*** extremes ***
 
 ** sem **
gsem (log_Maize_white <- dummy_temp_ext_12 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_temp_ext_12 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_12month_ext_temp.xls", replace keep(log_Maize_white dummy_temp_ext_12 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_temp_ext_12]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_12]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_12] + _b[log_Maize_white:dummy_temp_ext_12]*_b[log_vio_fut:log_Maize_white]


	* 9 months
 ** sem **
gsem (log_Maize_white <- dummy_temp_ext_9 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_temp_ext_9 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_9month_ext_temp.xls", replace keep(log_Maize_white dummy_temp_ext_9 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_temp_ext_9]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_9]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_9] + _b[log_Maize_white:dummy_temp_ext_9]*_b[log_vio_fut:log_Maize_white]
 
 ** sem **
gsem (log_Maize_white <- dummy_temp_ext_6 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_temp_ext_6 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_6month_ext_temp.xls", replace keep(log_Maize_white dummy_temp_ext_6 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_temp_ext_6]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_6]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_6] + _b[log_Maize_white:dummy_temp_ext_6]*_b[log_vio_fut:log_Maize_white]
	
 ** sem **
gsem (log_Maize_white <- dummy_temp_ext_3 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_temp_ext_3 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_3month_ext_temp.xls", replace keep(log_Maize_white dummy_temp_ext_3 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_temp_ext_3]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_3]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_3] + _b[log_Maize_white:dummy_temp_ext_3]*_b[log_vio_fut:log_Maize_white]

**** RAINFALL EXTREMES**** POSSIBLE REGRESSION FOR THE REPORT
 
 **** GOOD ****
gsem (log_Maize_white <- dummy_neg_rain_ext_12 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_neg_rain_ext_12 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_12month_ext_neg_rain.xls", replace keep(log_Maize_white dummy_neg_rain_ext_12 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_neg_rain_ext_12]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_12]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_12] + _b[log_Maize_white:dummy_neg_rain_ext_12]*_b[log_vio_fut:log_Maize_white]


	* 9 months 
	**SLIGHLTY GOOD
 ** sem **
gsem (log_Maize_white <- dummy_neg_rain_ext_9 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_neg_rain_ext_9 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_9month_ext_neg_rain.xls", replace keep(log_Maize_white dummy_neg_rain_ext_9 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_neg_rain_ext_9]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_9]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_9] + _b[log_Maize_white:dummy_neg_rain_ext_9]*_b[log_vio_fut:log_Maize_white]
 
 ** sem **
gsem (log_Maize_white <- dummy_neg_rain_ext_6 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_neg_rain_ext_6 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_6month_ext_neg_rain.xls", replace keep(log_Maize_white dummy_neg_rain_ext_6 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_neg_rain_ext_6]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_6]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_6] + _b[log_Maize_white:dummy_neg_rain_ext_6]*_b[log_vio_fut:log_Maize_white]
	
 ** sem **
gsem (log_Maize_white <- dummy_neg_rain_ext_3 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_neg_rain_ext_3 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_3month_ext_neg_rain.xls", replace keep(log_Maize_white dummy_neg_rain_ext_3 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_neg_rain_ext_3]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_3]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_3] + _b[log_Maize_white:dummy_neg_rain_ext_3]*_b[log_vio_fut:log_Maize_white]

 
 
 **** RAINFALL postive EXTREMES****
 
gsem (log_Maize_white <- dummy_rain_12_ext_pos $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_rain_12_ext_pos $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_12month_ext_pos_rain.xls", replace keep(log_Maize_white dummy_rain_12_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos] + _b[log_Maize_white:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Maize_white]


	* 9 months
 
gsem (log_Maize_white <- dummy_rain_9_ext_pos $control1v i.quarter#i.year i.region_id) ///
(log_vio_fut <- log_Maize_white dummy_rain_9_ext_pos $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_9month_ext_pos_rain.xls", replace keep(log_Maize_white dummy_rain_9_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos] + _b[log_Maize_white:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Maize_white]
 
	* 6 months
gsem (log_Maize_white <- dummy_rain_6_ext_pos $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_rain_6_ext_pos $control2v i.quarter#i.year i.region_id ),
outreg2 using "$tables\GSEM_maize_6month_ext_pos_rain.xls", replace keep(log_Maize_white dummy_rain_6_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos] + _b[log_Maize_white:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Maize_white]
	
 	* 3 months
gsem (log_Maize_white <- dummy_rain_3_ext_pos $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_rain_3_ext_pos $control2v i.quarter#i.year i.region_id ), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_maize_3month_ext_pos_rain.xls", replace keep(log_Maize_white dummy_rain_3_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos] + _b[log_Maize_white:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Maize_white]

 
 
 
**** RAINFALL COMBINED *****  first extremes 

***GOOD***
gsem (log_Maize_white <- dummy_rain_12_ext_pos dummy_neg_rain_ext_12 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_rain_12_ext_pos dummy_neg_rain_ext_12 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_12month_ext_rain.xls", replace keep(log_Maize_white dummy_rain_12_ext_pos dummy_neg_rain_ext_12 $control1v $control2v) dec(3) nocons


*inderect effect 
 nlcom  _b[log_Maize_white:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos] + _b[log_Maize_white:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Maize_white]


	* 9 months
gsem (log_Maize_white <- dummy_rain_9_ext_pos dummy_neg_rain_ext_9 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_rain_9_ext_pos dummy_neg_rain_ext_9 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_9month_ext_rain.xls", replace keep(log_Maize_white dummy_rain_9_ext_pos dummy_neg_rain_ext_9 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos] + _b[log_Maize_white:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Maize_white]
 
	* 6 months
gsem (log_Maize_white <- dummy_rain_6_ext_pos dummy_neg_rain_ext_6 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_rain_6_ext_pos dummy_neg_rain_ext_6 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_6month_ext_rain.xls", replace keep(log_Maize_white dummy_rain_6_ext_pos dummy_neg_rain_ext_6 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos] + _b[log_Maize_white:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Maize_white]
	
	* 3 months
gsem (log_Maize_white <- dummy_rain_3_ext_pos dummy_neg_rain_ext_3 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white dummy_rain_3_ext_pos dummy_neg_rain_ext_3 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_3month_ext_rain.xls", replace keep(log_Maize_white dummy_rain_3_ext_pos dummy_neg_rain_ext_3 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos] + _b[log_Maize_white:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Maize_white]

 
 
 **** RAINFALL COMBINED *****  first extremes 

***only this works***
gsem (log_Maize_white <- anom_tmax12_POS anom_rain12_POS anom_rain12_NEG $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_tmax12_POS anom_rain12_POS anom_rain12_NEG $control2v i.quarter#i.year i.region_id ),
outreg2 using "$tables\GSEM_maize_12month_rain.xls", replace keep(log_Maize_white anom_rain12_POS anom_rain12_NEG $control1v $control2v) dec(3) nocons


*inderect effect 
 nlcom  _b[log_Maize_white:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos] + _b[log_Maize_white:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Maize_white]


	* 9 months
gsem (log_Maize_white <- anom_rain9_POS anom_rain9_NEG $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_rain9_POS anom_rain9_NEG $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_maize_9month_rain.xls", replace keep(log_Maize_white anom_rain9_POS anom_rain9_NEG $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos] + _b[log_Maize_white:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Maize_white]
 
	* 6 months
gsem (log_Maize_white <- anom_rain6_POS anom_rain6_NEG $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_rain6_POS anom_rain6_NEG $control2v i.quarter#i.year i.region_id ),
outreg2 using "$tables\GSEM_maize_6month_rain.xls", replace keep(log_Maize_white anom_rain6_POS anom_rain6_NEG $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos] + _b[log_Maize_white:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Maize_white]
	
	* 3 months * GOOD 
gsem (log_Maize_white <- anom_rain3_POS anom_rain3_NEG $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Maize_white anom_rain3_POS anom_rain3_NEG $control2v i.quarter#i.year i.region_id ),
outreg2 using "$tables\GSEM_maize_3month_rain.xls", replace keep(log_Maize_white anom_rain3_POS anom_rain3_NEG $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Maize_white:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Maize_white] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos] + _b[log_Maize_white:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Maize_white]

 
 
 
 ****** WHEAT ******* 
 
  ** sem **
gsem (log_Wheat <- dummy_temp_ext_12 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_temp_ext_12 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_12month_ext_temp.xls", replace keep(log_Wheat dummy_temp_ext_12 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_temp_ext_12]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_12]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_12] + _b[log_Wheat:dummy_temp_ext_12]*_b[log_vio_fut:log_Wheat]


	* 9 months
 ** sem **
gsem (log_Wheat <- dummy_temp_ext_9 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_temp_ext_9 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_9month_ext_temp.xls", replace keep(log_Wheat dummy_temp_ext_9 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_temp_ext_9]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_9]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_9] + _b[log_Wheat:dummy_temp_ext_9]*_b[log_vio_fut:log_Wheat]
 
 ** sem **
gsem (log_Wheat <- dummy_temp_ext_6 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_temp_ext_6 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_6month_ext_temp.xls", replace keep(log_Wheat dummy_temp_ext_6 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_temp_ext_6]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_6]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_6] + _b[log_Wheat:dummy_temp_ext_6]*_b[log_vio_fut:log_Wheat]
	
 ** sem **
gsem (log_Wheat <- dummy_temp_ext_3 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_temp_ext_3 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_3month_ext_temp.xls", replace keep(log_Wheat dummy_temp_ext_3 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_temp_ext_3]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_3]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_3] + _b[log_Wheat:dummy_temp_ext_3]*_b[log_vio_fut:log_Wheat]

**** RAINFALL EXTREMES**** POSSIBLE REGRESSION FOR THE REPORT
 
 **** GOOD ****
gsem (log_Wheat <- dummy_neg_rain_ext_12 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_neg_rain_ext_12 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_12month_ext_neg_rain.xls", replace keep(log_Wheat dummy_neg_rain_ext_12 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_neg_rain_ext_12]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_12]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_12] + _b[log_Wheat:dummy_neg_rain_ext_12]*_b[log_vio_fut:log_Wheat]


	* 9 months 
	**SLIGHLTY GOOD
 ** sem **
gsem (log_Wheat <- dummy_neg_rain_ext_9 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_neg_rain_ext_9 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_9month_ext_neg_rain.xls", replace keep(log_Wheat dummy_neg_rain_ext_9 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_neg_rain_ext_9]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_9]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_9] + _b[log_Wheat:dummy_neg_rain_ext_9]*_b[log_vio_fut:log_Wheat]
 
 ** sem **
gsem (log_Wheat <- dummy_neg_rain_ext_6 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_neg_rain_ext_6 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_6month_ext_neg_rain.xls", replace keep(log_Wheat dummy_neg_rain_ext_6 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_neg_rain_ext_6]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_6]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_6] + _b[log_Wheat:dummy_neg_rain_ext_6]*_b[log_vio_fut:log_Wheat]
	
 ** sem **
gsem (log_Wheat <- dummy_neg_rain_ext_3 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_neg_rain_ext_3 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_3month_ext_neg_rain.xls", replace keep(log_Wheat dummy_neg_rain_ext_3 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_neg_rain_ext_3]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_3]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_3] + _b[log_Wheat:dummy_neg_rain_ext_3]*_b[log_vio_fut:log_Wheat]

 
 
 **** RAINFALL postive EXTREMES****
 
gsem (log_Wheat <- dummy_rain_12_ext_pos $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_rain_12_ext_pos $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_12month_ext_pos_rain.xls", replace keep(log_Wheat dummy_rain_12_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos] + _b[log_Wheat:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Wheat]


	* 9 months
 
gsem (log_Wheat <- dummy_rain_9_ext_pos $control1v i.quarter#i.year i.region_id) ///
(log_vio_fut <- log_Wheat dummy_rain_9_ext_pos $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_9month_ext_pos_rain.xls", replace keep(log_Wheat dummy_rain_9_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos] + _b[log_Wheat:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Wheat]
 
	* 6 months
gsem (log_Wheat <- dummy_rain_6_ext_pos $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_rain_6_ext_pos $control2v i.quarter#i.year i.region_id ),
outreg2 using "$tables\GSEM_wheat_6month_ext_pos_rain.xls", replace keep(log_Wheat dummy_rain_6_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos] + _b[log_Wheat:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Wheat]
	
 	* 3 months
gsem (log_Wheat <- dummy_rain_3_ext_pos $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_rain_3_ext_pos $control2v i.quarter#i.year i.region_id ), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_wheat_3month_ext_pos_rain.xls", replace keep(log_Wheat dummy_rain_3_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos] + _b[log_Wheat:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Wheat]

 
 
 
**** RAINFALL COMBINED *****  first extremes 

***GOOD***
gsem (log_Wheat <- dummy_rain_12_ext_pos dummy_neg_rain_ext_12 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_rain_12_ext_pos dummy_neg_rain_ext_12 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_12month_ext_rain.xls", replace keep(log_Wheat dummy_rain_12_ext_pos dummy_neg_rain_ext_12 $control1v $control2v) dec(3) nocons


*inderect effect 
 nlcom  _b[log_Wheat:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos] + _b[log_Wheat:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Wheat]


	* 9 months
gsem (log_Wheat <- dummy_rain_9_ext_pos dummy_neg_rain_ext_9 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_rain_9_ext_pos dummy_neg_rain_ext_9 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_9month_ext_rain.xls", replace keep(log_Wheat dummy_rain_9_ext_pos dummy_neg_rain_ext_9 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos] + _b[log_Wheat:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Wheat]
 
	* 6 months
gsem (log_Wheat <- dummy_rain_6_ext_pos dummy_neg_rain_ext_6 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_rain_6_ext_pos dummy_neg_rain_ext_6 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_6month_ext_rain.xls", replace keep(log_Wheat dummy_rain_6_ext_pos dummy_neg_rain_ext_6 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos] + _b[log_Wheat:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Wheat]
	
	* 3 months
gsem (log_Wheat <- dummy_rain_3_ext_pos dummy_neg_rain_ext_3 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat dummy_rain_3_ext_pos dummy_neg_rain_ext_3 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_3month_ext_rain.xls", replace keep(log_Wheat dummy_rain_3_ext_pos dummy_neg_rain_ext_3 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos] + _b[log_Wheat:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Wheat]

 
 
 **** RAINFALL COMBINED *****  first extremes 

***only this works***
gsem (log_Wheat <- anom_rain12_POS anom_rain12_NEG $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat anom_rain12_POS anom_rain12_NEG $control2v i.quarter#i.year i.region_id ),
outreg2 using "$tables\GSEM_wheat_12month_rain.xls", replace keep(log_Wheat anom_rain12_POS anom_rain12_NEG $control1v $control2v) dec(3) nocons


*inderect effect 
 nlcom  _b[log_Wheat:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos] + _b[log_Wheat:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Wheat]


	* 9 months
gsem (log_Wheat <- anom_rain9_POS anom_rain9_NEG $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat anom_rain9_POS anom_rain9_NEG $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_wheat_9month_rain.xls", replace keep(log_Wheat anom_rain9_POS anom_rain9_NEG $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos] + _b[log_Wheat:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Wheat]
 
	* 6 months
gsem (log_Wheat <- anom_rain6_POS anom_rain6_NEG $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat anom_rain6_POS anom_rain6_NEG $control2v i.quarter#i.year i.region_id ),
outreg2 using "$tables\GSEM_wheat_6month_rain.xls", replace keep(log_Wheat anom_rain6_POS anom_rain6_NEG $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos] + _b[log_Wheat:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Wheat]
	
	* 3 months * GOOD 
gsem (log_Wheat <- anom_rain3_POS anom_rain3_NEG $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Wheat anom_rain3_POS anom_rain3_NEG $control2v i.quarter#i.year i.region_id ),
outreg2 using "$tables\GSEM_wheat_3month_rain.xls", replace keep(log_Wheat anom_rain3_POS anom_rain3_NEG $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Wheat:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Wheat] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos] + _b[log_Wheat:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Wheat]

 
 
 
 
 
  ****** sorghum ******* 
 
  ** sem **
gsem (log_Sorghum <- dummy_temp_ext_12 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_temp_ext_12 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_12month_ext_temp.xls", replace keep(log_Sorghum dummy_temp_ext_12 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_temp_ext_12]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_12]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_12] + _b[log_Sorghum:dummy_temp_ext_12]*_b[log_vio_fut:log_Sorghum]


	* 9 months
 ** sem **
gsem (log_Sorghum <- dummy_temp_ext_9 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_temp_ext_9 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_9month_ext_temp.xls", replace keep(log_Sorghum dummy_temp_ext_9 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_temp_ext_9]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_9]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_9] + _b[log_Sorghum:dummy_temp_ext_9]*_b[log_vio_fut:log_Sorghum]
 
 ** sem **
gsem (log_Sorghum <- dummy_temp_ext_6 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_temp_ext_6 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_6month_ext_temp.xls", replace keep(log_Sorghum dummy_temp_ext_6 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_temp_ext_6]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_6]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_6] + _b[log_Sorghum:dummy_temp_ext_6]*_b[log_vio_fut:log_Sorghum]
	
 ** sem **
gsem (log_Sorghum <- dummy_temp_ext_3 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_temp_ext_3 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_3month_ext_temp.xls", replace keep(log_Sorghum dummy_temp_ext_3 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_temp_ext_3]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_3]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_3] + _b[log_Sorghum:dummy_temp_ext_3]*_b[log_vio_fut:log_Sorghum]

**** RAINFALL EXTREMES**** POSSIBLE REGRESSION FOR THE REPORT
 
 **** GOOD ****
gsem (log_Sorghum <- dummy_neg_rain_ext_12 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_neg_rain_ext_12 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_12month_ext_neg_rain.xls", replace keep(log_Sorghum dummy_neg_rain_ext_12 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_neg_rain_ext_12]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_12]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_12] + _b[log_Sorghum:dummy_neg_rain_ext_12]*_b[log_vio_fut:log_Sorghum]


	* 9 months 
	**SLIGHLTY GOOD
 ** sem **
gsem (log_Sorghum <- dummy_neg_rain_ext_9 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_neg_rain_ext_9 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_9month_ext_neg_rain.xls", replace keep(log_Sorghum dummy_neg_rain_ext_9 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_neg_rain_ext_9]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_9]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_9] + _b[log_Sorghum:dummy_neg_rain_ext_9]*_b[log_vio_fut:log_Sorghum]
 
 ** sem **
gsem (log_Sorghum <- dummy_neg_rain_ext_6 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_neg_rain_ext_6 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_6month_ext_neg_rain.xls", replace keep(log_Sorghum dummy_neg_rain_ext_6 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_neg_rain_ext_6]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_6]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_6] + _b[log_Sorghum:dummy_neg_rain_ext_6]*_b[log_vio_fut:log_Sorghum]
	
 ** sem **
gsem (log_Sorghum <- dummy_neg_rain_ext_3 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_neg_rain_ext_3 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_3month_ext_neg_rain.xls", replace keep(log_Sorghum dummy_neg_rain_ext_3 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_neg_rain_ext_3]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_3]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_3] + _b[log_Sorghum:dummy_neg_rain_ext_3]*_b[log_vio_fut:log_Sorghum]

 
 
 **** RAINFALL postive EXTREMES****
 
gsem (log_Sorghum <- dummy_rain_12_ext_pos $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_rain_12_ext_pos $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_12month_ext_pos_rain.xls", replace keep(log_Sorghum dummy_rain_12_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos] + _b[log_Sorghum:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Sorghum]


	* 9 months
 
gsem (log_Sorghum <- dummy_rain_9_ext_pos $control1v i.quarter#i.year i.region_id) ///
(log_vio_fut <- log_Sorghum dummy_rain_9_ext_pos $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_9month_ext_pos_rain.xls", replace keep(log_Sorghum dummy_rain_9_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos] + _b[log_Sorghum:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Sorghum]
 
	* 6 months
gsem (log_Sorghum <- dummy_rain_6_ext_pos $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_rain_6_ext_pos $control2v i.quarter#i.year i.region_id ),
outreg2 using "$tables\GSEM_sorghum_6month_ext_pos_rain.xls", replace keep(log_Sorghum dummy_rain_6_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos] + _b[log_Sorghum:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Sorghum]
	
 	* 3 months
gsem (log_Sorghum <- dummy_rain_3_ext_pos $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_rain_3_ext_pos $control2v i.quarter#i.year i.region_id ), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_sorghum_3month_ext_pos_rain.xls", replace keep(log_Sorghum dummy_rain_3_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos] + _b[log_Sorghum:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Sorghum]

 
 
 
**** RAINFALL COMBINED *****  first extremes 

***GOOD***
gsem (log_Sorghum <- dummy_rain_12_ext_pos dummy_neg_rain_ext_12 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_rain_12_ext_pos dummy_neg_rain_ext_12 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_12month_ext_rain.xls", replace keep(log_Sorghum dummy_rain_12_ext_pos dummy_neg_rain_ext_12 $control1v $control2v) dec(3) nocons


*inderect effect 
 nlcom  _b[log_Sorghum:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos] + _b[log_Sorghum:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Sorghum]


	* 9 months
gsem (log_Sorghum <- dummy_rain_9_ext_pos dummy_neg_rain_ext_9 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_rain_9_ext_pos dummy_neg_rain_ext_9 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_9month_ext_rain.xls", replace keep(log_Sorghum dummy_rain_9_ext_pos dummy_neg_rain_ext_9 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos] + _b[log_Sorghum:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Sorghum]
 
	* 6 months
gsem (log_Sorghum <- dummy_rain_6_ext_pos dummy_neg_rain_ext_6 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_rain_6_ext_pos dummy_neg_rain_ext_6 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_6month_ext_rain.xls", replace keep(log_Sorghum dummy_rain_6_ext_pos dummy_neg_rain_ext_6 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos] + _b[log_Sorghum:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Sorghum]
	
	* 3 months
gsem (log_Sorghum <- dummy_rain_3_ext_pos dummy_neg_rain_ext_3 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum dummy_rain_3_ext_pos dummy_neg_rain_ext_3 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_3month_ext_rain.xls", replace keep(log_Sorghum dummy_rain_3_ext_pos dummy_neg_rain_ext_3 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos] + _b[log_Sorghum:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Sorghum]

 
 
 **** RAINFALL COMBINED *****  first extremes 

***only this works***
gsem (log_Sorghum <- anom_rain12_POS anom_rain12_NEG $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum anom_rain12_POS anom_rain12_NEG $control2v i.quarter#i.year i.region_id ),
outreg2 using "$tables\GSEM_sorghum_12month_rain.xls", replace keep(log_Sorghum anom_rain12_POS anom_rain12_NEG $control1v $control2v) dec(3) nocons


*inderect effect 
 nlcom  _b[log_Sorghum:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos] + _b[log_Sorghum:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Sorghum]


	* 9 months
gsem (log_Sorghum <- anom_rain9_POS anom_rain9_NEG $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum anom_rain9_POS anom_rain9_NEG $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_sorghum_9month_rain.xls", replace keep(log_Sorghum anom_rain9_POS anom_rain9_NEG $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos] + _b[log_Sorghum:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Sorghum]
 
	* 6 months
gsem (log_Sorghum <- anom_rain6_POS anom_rain6_NEG $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum anom_rain6_POS anom_rain6_NEG $control2v i.quarter#i.year i.region_id ),
outreg2 using "$tables\GSEM_sorghum_6month_rain.xls", replace keep(log_Sorghum anom_rain6_POS anom_rain6_NEG $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos] + _b[log_Sorghum:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Sorghum]
	
	* 3 months * GOOD 
gsem (log_Sorghum <- anom_rain3_POS anom_rain3_NEG $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Sorghum anom_rain3_POS anom_rain3_NEG $control2v i.quarter#i.year i.region_id ),
outreg2 using "$tables\GSEM_sorghum_3month_rain.xls", replace keep(log_Sorghum anom_rain3_POS anom_rain3_NEG $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Sorghum:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Sorghum] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos] + _b[log_Sorghum:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Sorghum]

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ***** SHEEP price ***** 
 
 
  ** sem **
gsem (log_Livestock_Sheep <- dummy_temp_ext_12 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Livestock_Sheep dummy_temp_ext_12 $control2v i.quarter#i.year i.region_id ),  nocapslatent
outreg2 using "$tables\GSEM_Sheep_12month_ext_temp.xls", replace keep(log_Livestock_Sheep dummy_temp_ext_12 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_temp_ext_12]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_12]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_12] + _b[log_Livestock_Sheep:dummy_temp_ext_12]*_b[log_vio_fut:log_Livestock_Sheep]
 

 


  
	* 9 months
 ** sem **
gsem (log_Livestock_Sheep <- dummy_temp_ext_9 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Livestock_Sheep dummy_temp_ext_9 $control2v i.quarter#i.year i.region_id ),  nocapslatent
outreg2 using "$tables\GSEM_Sheep_9month_ext_temp.xls", replace keep(log_Livestock_Sheep dummy_temp_ext_9 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_temp_ext_9]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_9]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_9] + _b[log_Livestock_Sheep:dummy_temp_ext_9]*_b[log_vio_fut:log_Livestock_Sheep]
 
 ** sem **
gsem (log_Livestock_Sheep <- dummy_temp_ext_6 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Livestock_Sheep dummy_temp_ext_6 $control2v i.quarter#i.year i.region_id ),  nocapslatent
outreg2 using "$tables\GSEM_Sheep_6month_ext_temp.xls", replace keep(log_Livestock_Sheep dummy_temp_ext_6 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_temp_ext_6]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_6]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_6] + _b[log_Livestock_Sheep:dummy_temp_ext_6]*_b[log_vio_fut:log_Livestock_Sheep]
	
 ** sem **
gsem (log_Livestock_Sheep <- dummy_temp_ext_3 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Livestock_Sheep dummy_temp_ext_3 $control2v i.quarter#i.year i.region_id ),  nocapslatent
outreg2 using "$tables\GSEM_Sheep_3month_ext_temp.xls", replace keep(log_Livestock_Sheep dummy_temp_ext_3 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_temp_ext_3]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_temp_ext_3]

*total effect 
 nlcom  _b[log_vio_fut:dummy_temp_ext_3] + _b[log_Livestock_Sheep:dummy_temp_ext_3]*_b[log_vio_fut:log_Livestock_Sheep]

**** RAINFALL EXTREMES****
 
gsem (log_Livestock_Sheep <- dummy_neg_rain_ext_12 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Livestock_Sheep dummy_neg_rain_ext_12 $control2v i.quarter#i.year i.region_id ),  nocapslatent
outreg2 using "$tables\GSEM_Sheep_12month_ext_neg_rain.xls", replace keep(log_Livestock_Sheep dummy_neg_rain_ext_12 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_neg_rain_ext_12]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_12]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_12] + _b[log_Livestock_Sheep:dummy_neg_rain_ext_12]*_b[log_vio_fut:log_Livestock_Sheep]


	* 9 months
 ** sem **
gsem (log_Livestock_Sheep <- dummy_neg_rain_ext_9 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Livestock_Sheep dummy_neg_rain_ext_9 $control2v i.quarter#i.year i.region_id ), nocapslatent
outreg2 using "$tables\GSEM_Sheep_9month_ext_neg_rain.xls", replace keep(log_Livestock_Sheep dummy_neg_rain_ext_9 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_neg_rain_ext_9]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_9]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_9] + _b[log_Livestock_Sheep:dummy_neg_rain_ext_9]*_b[log_vio_fut:log_Livestock_Sheep]
 
 ** sem **
gsem (log_Livestock_Sheep <- dummy_neg_rain_ext_6 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Livestock_Sheep dummy_neg_rain_ext_6 $control2v i.quarter#i.year i.region_id ),  nocapslatent
outreg2 using "$tables\GSEM_Sheep_6month_ext_neg_rain.xls", replace keep(log_Livestock_Sheep dummy_neg_rain_ext_6 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_neg_rain_ext_6]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_6]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_6] + _b[log_Livestock_Sheep:dummy_neg_rain_ext_6]*_b[log_vio_fut:log_Livestock_Sheep]
	
 ** sem **
gsem (log_Livestock_Sheep <- dummy_neg_rain_ext_3 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Livestock_Sheep dummy_neg_rain_ext_3 $control2v i.quarter#i.year i.region_id ),  nocapslatent
outreg2 using "$tables\GSEM_Sheep_3month_ext_neg_rain.xls", replace keep(log_Livestock_Sheep dummy_neg_rain_ext_3 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_neg_rain_ext_3]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_3]

*total effect 
 nlcom  _b[log_vio_fut:dummy_neg_rain_ext_3] + _b[log_Livestock_Sheep:dummy_neg_rain_ext_3]*_b[log_vio_fut:log_Livestock_Sheep]

 
 
 **** RAINFALL postive EXTREMES****
 
gsem (log_Livestock_Sheep <- dummy_rain_12_ext_pos $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Livestock_Sheep dummy_rain_12_ext_pos $control2v i.quarter#i.year i.region_id ),  
outreg2 using "$tables\GSEM_Sheep_12month_ext_pos_rain.xls", replace keep(log_Livestock_Sheep dummy_rain_12_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos] + _b[log_Livestock_Sheep:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep]


	* 9 months
 
gsem (log_Livestock_Sheep <- dummy_rain_9_ext_pos $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Livestock_Sheep dummy_rain_9_ext_pos $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_Sheep_9month_ext_pos_rain.xls", replace keep(log_Livestock_Sheep dummy_rain_9_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos] + _b[log_Livestock_Sheep:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep]
 
	* 6 months
gsem (log_Livestock_Sheep <- dummy_rain_6_ext_pos $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Livestock_Sheep dummy_rain_6_ext_pos $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_Sheep_6month_ext_pos_rain.xls", replace keep(log_Livestock_Sheep dummy_rain_6_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos] + _b[log_Livestock_Sheep:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep]
	
 	* 3 months
gsem (log_Livestock_Sheep <- dummy_rain_3_ext_pos $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Livestock_Sheep dummy_rain_3_ext_pos $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_Sheep_3month_ext_pos_rain.xls", replace keep(log_Livestock_Sheep dummy_rain_3_ext_pos $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos] + _b[log_Livestock_Sheep:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep]

 
 
 
**** RAINFALL COMBINED *****  first extremes 

***only this works***
gsem (log_Livestock_Sheep <- dummy_rain_12_ext_pos dummy_neg_rain_ext_12 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Livestock_Sheep dummy_rain_12_ext_pos dummy_neg_rain_ext_12 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_Sheep_12month_ext_rain.xls", replace keep(log_Livestock_Sheep dummy_rain_12_ext_pos dummy_neg_rain_ext_12 $control1v $control2v) dec(3) nocons


*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_12_ext_pos] + _b[log_Livestock_Sheep:dummy_rain_12_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep]


	* 9 months
gsem (log_Livestock_Sheep <- dummy_rain_9_ext_pos dummy_neg_rain_ext_9 $control1v i.quarter#i.year i.region_id ) ///
(log_vio_fut <- log_Livestock_Sheep dummy_rain_9_ext_pos dummy_neg_rain_ext_9 $control2v i.quarter#i.year i.region_id ), 
outreg2 using "$tables\GSEM_Sheep_9month_ext_rain.xls", replace keep(log_Livestock_Sheep dummy_rain_9_ext_pos dummy_neg_rain_ext_9 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_9_ext_pos] + _b[log_Livestock_Sheep:dummy_rain_9_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep]
 
	* 6 months
gsem (log_Livestock_Sheep <- dummy_rain_6_ext_pos dummy_neg_rain_ext_6 $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Livestock_Sheep dummy_rain_6_ext_pos dummy_neg_rain_ext_6 $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_6month_ext_rain.xls", replace keep(log_Livestock_Sheep dummy_rain_6_ext_pos dummy_neg_rain_ext_6 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_6_ext_pos] + _b[log_Livestock_Sheep:dummy_rain_6_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep]
	
	* 3 months
gsem (log_Livestock_Sheep <- dummy_rain_3_ext_pos dummy_neg_rain_ext_3 $control1v i.quarter#i.year i.region_id M1[grid_id]) ///
(log_vio_fut <- log_Livestock_Sheep dummy_rain_3_ext_pos dummy_neg_rain_ext_3 $control2v i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
outreg2 using "$tables\GSEM_Sheep_3month_ext_rain.xls", replace keep(log_Livestock_Sheep dummy_rain_3_ext_pos dummy_neg_rain_ext_3 $control1v $control2v) dec(3) nocons

*inderect effect 
 nlcom  _b[log_Livestock_Sheep:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep] 	

*direct effect 

 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos]

*total effect 
 nlcom  _b[log_vio_fut:dummy_rain_3_ext_pos] + _b[log_Livestock_Sheep:dummy_rain_3_ext_pos]*_b[log_vio_fut:log_Livestock_Sheep]

 
 
 
 ***** price with dummy 
 
  	* 3 months
gsem (log_Maize_white <- anom_rain12_NEG_new  i.quarter#i.year i.region_id M1[grid_id]) ///
(dummy_vio_fut <- log_Maize_white anom_rain12_NEG_new i.quarter#i.year i.region_id M1[grid_id]), latent(M1) nocapslatent
