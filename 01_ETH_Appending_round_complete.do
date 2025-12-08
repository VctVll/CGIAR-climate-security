*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
* Ethiopia 2000
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************

*********************************************************************************************************************************
* Individual records WOMEN - IR 
*********************************************************************************************************************************
*set more off

*run when there are too many variables

*set maxvar 15000
*set max_memory 8000m

global datadir  "E:\WORK ROMA\African Obsevatory\Ethiopia\DHS\Complete\2000" 
use "$datadir/ETIR41DT/ETIR41FL.dta", clear
keep caseid v000 v001 v002 v003 v004 v005 v006 v007 v008 sintmg sintyg v042 v455 v457 v208 m45_1 m46_1 v213 b3_01 v012 v024 v025 v101 v102 v106 v107 v133 v131 v717 v714 v705 v719 v440 v444a v445 v446 v439 v150 v151 v152 v501
sort v001 v002 v003

gen year = sintyg
gen month = sintmg
* ID
tostring v001 v002,g (v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s v000
rename caseid hhid_dhs

* Number of women in the HH
bysort hhid: g n=_n
bysort hhid: egen tot_wmen=max(n)
sum tot_w
lab var tot_wm "Number of women in the HH"
drop n 

* Employment in agriculture
tab v717
tab v717, g(occ)
bysort hhid: egen tot_wmen_ag_s=sum(occ5)
sum tot_wmen_ag_s
bysort hhid: egen tot_wmen_ag_w=sum(occ6)
sum tot_wmen_ag_w

bysort hhid: g tot_wmen_ag=tot_wmen_ag_s+tot_wmen_ag_w
lab var tot_wmen_ag_s "Number of women in agri-self-employed"
lab var tot_wmen_ag_w "Number of women in agri-wage"
lab var tot_wmen_ag "Number of women in agriculture"
sum tot_wmen_ag

bysort hhid: egen tot_wmen_un=sum(occ1)
bysort hhid: egen tot_wmen_Prof=sum(occ2)
bysort hhid: egen tot_wmen_cler=sum(occ3)
bysort hhid: egen tot_wmen_sales=sum(occ4)
bysort hhid: egen tot_wmen_serv=sum(occ7)
bysort hhid: egen tot_wmen_skman=sum(occ8)
bysort hhid: egen tot_wmen_unskman=sum(occ9)
bysort hhid: egen tot_wmen_other=sum(occ10)

lab var tot_wmen_Prof "Number of women in the HH - Professional jobs"
lab var tot_wmen_cler "Number of women in the HH - clerical employment"
lab var tot_wmen_sales "Number of women in the HH - sales employment"
lab var tot_wmen_serv "Number of women in the HH - services employment"
lab var tot_wmen_skman "Number of women in the HH - skilled manual employment"
lab var tot_wmen_unskman "Number of women in the HH - unskilled manual employment"
lab var tot_wmen_un "Number of women in the HH - unemployment"
lab var tot_wmen_other "Number of women in other employment"


* Currently working
tab v714
bysort hhid: egen tot_wmen_work=sum(v714)
br v714 tot_wmen_work
bysort hhid: egen tot_wmen_work_hd=sum(v714) if v150==1

*HH head occupation 
bysort hhid: g x=1 if occ5==1 & v150==1
bysort hhid: egen head_ag_s_wm=max (x)
drop x

bysort hhid: g x=1 if occ6==1  & v150==1
bysort hhid: egen head_ag_w_wm=max (x)
drop x

bysort hhid: g x=1 if head_ag_w_wm==1 & head_ag_s_wm==1
bysort hhid: egen head_ag_wm=max (x)
drop x


bysort hhid: g x=1 if occ2==1 & v150==1
bysort hhid: egen head_prof_wm=max (x)
drop x

bysort hhid: g x=1 if occ3==1 & v150==1
bysort hhid: egen head_cler_wm=max (x)
drop x

bysort hhid: g x=1 if occ4==1 & v150==1
bysort hhid: egen head_sales_wm=max (x)
drop x

bysort hhid: g x=1 if occ7==1 & v150==1
bysort hhid: egen head_serv_wm=max (x)
drop x

bysort hhid: g x=1 if occ8==1 & v150==1
bysort hhid: egen head_skman_wm=max (x)
drop x

bysort hhid: g x=1 if occ9==1 & v150==1
bysort hhid: egen head_unskman_wm=max (x)
drop x

bysort hhid: g x=1 if occ10==1 & v150==1
bysort hhid: egen head_other_wm=max (x)
drop x

bysort hhid: g x=1 if occ1==1 & v150==1
bysort hhid: egen head_un_wm=max (x)
drop x

lab var tot_wmen_work "Number of women currently working in the HH"
lab var tot_wmen_work_hd "Women head(s) currently working in the HH"
lab var head_ag_wm "Female head in the HH - agriculture"
lab var head_prof_wm "Female head in the HH - Professional"
lab var head_un_wm "Female head in the HH - domestic employed"
lab var head_cler_wm "Female head in the HH - clerical employment"
lab var head_sales_wm "Female head in the HH - sales employment"
lab var head_serv_wm "Female head in the HH - services employment"
lab var head_skman_wm "Female head in the HH - skilled manual employment"
lab var head_unskman_wm "Female head in the HH - unskilled manual employment"
lab var head_other_wm "Female head in other employment"


* Education
tab v106, g(edu)
bysort hhid: egen tot_wmen_noedu=sum(edu1)
bysort hhid: egen tot_wmen_pri=sum(edu2)
bysort hhid: egen tot_wmen_sec=sum(edu3)
bysort hhid: egen tot_wmen_high=sum(edu4)

* Head 
bysort hhid: g x=1 if edu1==1 & v150==1
bysort hhid: egen head_noedu_wm=max (x)
drop x

bysort hhid: g x=1 if edu2==1 & v150==1
bysort hhid: egen head_pri_wm=max (x)
drop x

bysort hhid: g x=1 if edu3==1 & v150==1
bysort hhid: egen head_sec_wm=max (x)
drop x

bysort hhid: g x=1 if edu4==1 & v150==1
bysort hhid: egen head_high_wm=max (x)
drop x

lab var tot_wmen_noedu "Number of women in the HH - no education"
lab var tot_wmen_pri "Number of women in the HH - primary education"
lab var tot_wmen_sec "Number of women in the HH - secondary education"
lab var tot_wmen_high "Number of women in the HH - higher education"
lab var head_noedu_wm "Female head in the HH - no education"
lab var head_pri_wm "Female head in the HH - primary education"
lab var head_sec_wm "Female head in the HH - secondary education"
lab var head_high_wm "Female head in the HH - higher education"

* Ethnicity
* Two major ethnic groups: Wolof and Poular = 1 versus others =0 

* Ethnicity
tab v131
tab v131, g(ethn)
/*
bysort hhid: egen tot_wmen_wolof=sum(ethn1)
bysort hhid: egen tot_wmen_poular=sum(ethn2)
bysort hhid: egen tot_wmen_serer=sum(ethn3) 
bysort hhid: egen tot_wmen_msm=sum(ethn4)
bysort hhid: egen tot_wmen_diola=sum(ethn5)
bysort hhid: egen tot_wmen_ss=sum(ethn6) 
bysort hhid: egen tot_wmen_other=sum(ethn8) 
bysort hhid: egen tot_wmen_nonseg=sum(ethn7)

*/
* Head 
bysort hhid: g x=1 if ethn1==1 & v150==1
bysort hhid: egen head_affar_wm=max (x)
drop x

bysort hhid: g x=1 if ethn4==1 & v150==1
bysort hhid: egen head_amharra_wm=max (x)
drop x

bysort hhid: g x=1 if ethn14==1 & v150==1
bysort hhid: egen head_guragie_wm=max (x)
drop x

bysort hhid: g x=1 if ethn34==1 & v150==1
bysort hhid: egen head_oromo_wm=max (x)
drop x

bysort hhid: g x=1 if ethn39==1 & v150==1
bysort hhid: egen head_sidama_wm=max (x)
drop x

bysort hhid: g x=1 if ethn40==1 & v150==1
bysort hhid: egen head_somalie_wm=max (x)
drop x

bysort hhid: g x=1 if ethn41==1 & v150==1
bysort hhid: egen head_tigray_wm=max (x)
drop x

bysort hhid: g x=1 if ethn43==1 & v150==1
bysort hhid: egen head_welaita_wm=max (x)
drop x

 
bysort hhid: g x=1 if v150==1 &	head_welaita_wm!=1 & head_tigray_wm!=1 & head_somalie_wm!=1 & head_sidama_wm!=1 & head_oromo_wm!=1 & head_guragie_wm!=1 ///
                              &	head_amharra_wm!=1 & head_affar_wm!=1 
bysort hhid: egen head_other_ethn_wm=max (x)
drop x



// Anthropometry indicators

* Age of most recent child - to select women that are not post partum 
gen age = v008 - b3_01
	
* To check if survey has b19, which should be used instead to compute age
scalar b19_included=1
capture confirm numeric variable b19_01, exact 
		if _rc>0 {
		* b19 is not present
        scalar b19_included=0
		}
		
		if _rc==0 {
		* b19 is present; check for values
		summarize b19_01
		if r(sd)==0 | r(sd)==. {
		scalar b19_included=0
		  }
		}

	    if b19_included==1 {
	    drop age
	    gen age=b19_01
	    }

// Rohrer index (RI) ie Index  of Corpulence - NON PREGNANT-POST PARTUM WOMEN

// The range variation of RI (According to Pignet, cited in Bhasin and Singh, 2004) is also mentioned in this study: Rohrer Index=(Body weight (gm)/Stature 3 (cm)) × 100 //
/*
• Very low ≤ 1.12

• Low (1.13-1.19)

• Middle (1.20-1.25)

• Upper middle (1.26-1.32)

• High (1.33-1.39)

• Very high=1.40

• Healthy range 1.2-1.6
*/

* Substitute with missing
sum v446
codebook v446
tab v446, nolabel
tab v445
foreach var of varlist v445 v446 {
replace `var' =. if `var'==9998 | `var'==9999
}

* RI creation
g RI_Low_w=1 if v446<=1190 //RI for low and very low//
replace RI_Low_w=0 if v446>1190
replace RI_Low_w= . if (v446==.| v213==1 | age<2)
lab var RI_Low_w "Rohrer Index - low or very low - women"
br v446 RI_Low_w
label define RI_Low_w 1 "Low or Very low Rohrer's Index" 0 "High Rohrer Index"
label values RI_Low_w RI_Low_w
br v446 RI_Low_w
tab RI_Low_w
bysort hhid: egen tot_RI_Low_w=total(RI_Low_w), missing
br tot_RI_Low_w hhid RI_Low_w
sum tot_RI_Low_w
lab var tot_RI_Low_w "Number of women in HH with low or very low Rohrer Index"

// BMI - NON PREGNANT-POST PARTUM WOMEN

/* https://dhsprogram.com/pubs/pdf/MR6/MR6.pdf
With standard terminology for this
measure, if the BMI is less than 16.0, the woman is ―severely thin;‖ if 16.0 to 16.9, she is ―moderately
thin;‖ if 17.0 to 18.4, she is ―mildly thin.‖ The entire range below 18.5 is ―thin.‖ If the BMI is 25.0 to
29.9, the woman is ―overweight;‖ if 30.0 or higher, she is ―obese.‖ For example, if v437 = 400 (40.0 kg)
and v438 = 1500 (1.500 meters) then v445 = 1778, the BMI is 17.78, and the woman is ―mildly thin.‖
For the ―malnourished‖ woman described in the last paragraph of section 4.2.2, with a weight of 35.1 kg
and a height of 1.500 meters, the BMI is 15.6, so she is ―severely thin.‖
*/

/* The DHS Guide to Statistics offers the following guidelines for interpreting BMI scores for women age 15-49:
 Severely thin: less than 16.0
Moderately thin: 16.0 to 16.9
Mildly thin: 17.0 to 18.4
Normal: 18.5 to 24.9
Overweight: 25.0 to 29.9
Obese: 30.0 or more*/

* BMI - moderately or severely thin DHS
gen nt_wm_modsevthin= inrange(v445,1200,1699) if inrange(v445,1200,6000)
replace nt_wm_modsevthin=. if (v445 ==. | v213==1 | age<2)
label values nt_wm_modsevthin yesno
label var nt_wm_modsevthin "Moderately and severely thin BMI - women"
bysort hhid: egen DHS_tot_BMI_low_w=total(nt_wm_modsevthin), missing 
lab var DHS_tot_BMI_low_w "Number of women in HH with BMI <16.9 (severe or moderately thin)"

/*
// TOOK IRON supplements during last pregnancy
gen nt_wm_micro_iron= .
replace nt_wm_micro_iron=0 if m45_1==0
replace nt_wm_micro_iron=1 if inrange(m46_1,0,59)
replace nt_wm_micro_iron=2 if inrange(m46_1,60,89)
replace nt_wm_micro_iron=3 if inrange(m46_1,90,300)
replace nt_wm_micro_iron=4 if m45_1==8 | m45_1==9 | m46_1==998 | m46_1==999
replace nt_wm_micro_iron= . if v208==0
label define nt_wm_micro_iron 0"None" 1"<60" 2"60-89" 3"90+" 4"Don't know/missing"
label values nt_wm_micro_iron nt_wm_micro_iron
label var nt_wm_micro_iron "Number of days women took iron supplements during last pregnancy"
*/

// SEVERE ANEMIA
gen nt_wm_sev_anem=0 if v042==1 & v455==0
replace nt_wm_sev_anem=1 if v457==1 | v457==2
label values nt_wm_sev_anem yesno
label var nt_wm_sev_anem "Severe and Moderate anemia - women"
bysort hhid: egen sev_mod_anemia_hh=total(nt_wm_sev_anem), missing 
lab var sev_mod_anemia_hh "Number of women in HH with severe-moderate anemia"

* Collapsing at HH level
sum  v001 v002
collapse tot_wmen* head* RI_Low_w tot_RI_Low_w nt_wm_modsevthin DHS_tot_BMI_low_w sev_mod_anemia_hh  , by (hhid v001 v002)

sum
order hhid v001 v002
sort hhid 

save "$datadir/cleaned/HHwomen_00.dta", replace

*********************************************************************************************************************************
* Individual records MEN -MR 
*********************************************************************************************************************************

use "$datadir/ETMR41DT/ETMR41FL.dta", clear
keep mcaseid mv000 mv001 mv002 mv003 mv004 mv005 mv006 mv007 smintmg smintyg mv012 mv024 mv025 mv101 mv102 mv106 mv107 mv133 mv131 mv717 mv714 mv150 mv151 mv152 mv501
gen v001 = mv001
gen v002 = mv002
gen v003 = mv003
sort v001 v002 v003

gen year=smintyg
gen month=smintmg

* ID
tostring mv001 mv002,g (mv001s mv002s)
g hhid=mv001s+mv002s
replace hhid =mv001s+"0"+mv002s if mv002<10
order hhid 
destring hhid, replace
drop mv001s mv002s

* Gen person id without spaces
/* tostring mv001 mv002 mv003,g (mv001s mv002s mv003s)
g mid=mv001s+mv002s+mv003s
replace mid =mv001s+"0"+mv002s+mv003s if mv002<10
replace mid =mv001s+mv002s+"0"+mv003s if mv003<10
order hhid mid
destring mid, replace
drop mv001s mv002s mv003s*/ // not necessary

* Number of men in the HH
bysort hhid: g n=_n
bysort hhid: egen tot_men=max(n)
sum tot_m
lab var tot_m "Number of men in the HH"
drop n 


*Employment in agriculture
tab mv717
tab mv717, g(occ)
bysort hhid: egen tot_men_ag=sum(occ5)
sum tot_men_ag
lab var tot_men_ag "Number of men in agriculture"

*Other occupations
bysort hhid: egen tot_men_un=sum(occ1)
bysort hhid: egen tot_men_prof=sum(occ2)
bysort hhid: egen tot_men_cler=sum(occ3)
bysort hhid: egen tot_men_sales=sum(occ4)
bysort hhid: egen tot_men_serv=sum(occ6)
bysort hhid: egen tot_men_skman=sum(occ7)
bysort hhid: egen tot_men_unskman=sum(occ8)
bysort hhid: egen tot_men_other=sum(occ9)

lab var tot_men_un "Number of men in the HH - unemployed"
lab var tot_men_prof "Number of men in the HH - Professional jobs"
lab var tot_men_cler "Number of men in the HH - clerical employment"
lab var tot_men_sales "Number of men in the HH - sales employment"
lab var tot_men_serv "Number of men in the HH - services employment"
lab var tot_men_skman "Number of men in the HH - skilled manual employment"
lab var tot_men_unskman "Number of men in the HH - ubskilled manual employment"
lab var tot_men_other "Number of men in other employment"

*Currently working
bysort hhid: egen tot_men_work=sum(mv714)
bysort hhid: egen tot_men_work_hd=sum(mv714) if mv150==1


*HH head occupation 
bysort hhid: g x=1 if occ5==1 & mv150==1
bysort hhid: egen head_ag_m=max (x)
drop x

bysort hhid: g x=1 if occ1==1 & mv150==1
bysort hhid: egen head_un_m=max (x)
drop x

bysort hhid: g x=1 if occ2==1 & mv150==1
bysort hhid: egen head_prof_m=max (x)
drop x

bysort hhid: g x=1 if occ3==1 & mv150==1
bysort hhid: egen head_cler_m=max (x)
drop x

bysort hhid: g x=1 if occ4==1 & mv150==1
bysort hhid: egen head_sales_m=max (x)
drop x

bysort hhid: g x=1 if occ6==1 & mv150==1
bysort hhid: egen head_serv_m=max (x)
drop x

bysort hhid: g x=1 if occ7==1 & mv150==1
bysort hhid: egen head_skman_m=max (x)
drop x

bysort hhid: g x=1 if occ8==1 & mv150==1
bysort hhid: egen head_unskman_m=max (x)
drop x

bysort hhid: g x=1 if occ9==1 & mv150==1
bysort hhid: egen head_other_m=max (x)
drop x

lab var tot_men_work "Number of men currently working in the HH"
lab var tot_men_work_hd "men head(s) currently working in the HH"
lab var head_ag_m "Male head in the HH - agriculture"
lab var head_un_m "Male head in the HH - unemployed"
lab var head_prof_m "Male head in the HH - Professional"
lab var head_cler_m "Male head in the HH - clerical employment"
lab var head_sales_m "Male head in the HH - sales employment"
lab var head_serv_m "Male head in the HH - services employment"
lab var head_skman_m "Male head in the HH - skilled manual employment"
lab var head_unskman_m "Male head in the HH - unskilled manual employment"
lab var head_other_m "Male head in other employment"

* Education
tab mv106, g(edu)
bysort hhid: egen tot_men_noedu=sum(edu1)
bysort hhid: egen tot_men_pri=sum(edu2)
bysort hhid: egen tot_men_sec=sum(edu3)
bysort hhid: egen tot_men_high=sum(edu4)

lab var tot_men_noedu "Number of men in the HH - no education"
lab var tot_men_pri "Number of men in the HH - primary education"
lab var tot_men_sec "Number of men in the HH - secondary education"
lab var tot_men_high "Number of men in the HH - higher education"

* Head - Education
bysort hhid: g x=1 if edu1==1 & mv150==1
bysort hhid: egen head_noedu_m=max (x)
drop x

bysort hhid: g x=1 if edu2==1 & mv150==1
bysort hhid: egen head_pri_m=max (x)
drop x

bysort hhid: g x=1 if edu3==1 & mv150==1
bysort hhid: egen head_sec_m=max (x)
drop x

bysort hhid: g x=1 if edu4==1 & mv150==1
bysort hhid: egen head_high_m=max (x)
drop x

lab var head_noedu_m "Male head in the HH - no education"
lab var head_pri_m "Male head in the HH - primary education"
lab var head_sec_m "Male head in the HH - secondary education"
lab var head_high_m "Male head in the HH - higher education"

* Ethnicity
* Two major ethnic groups: Wolof and Poular = 1 versus others =0 
/*
bysort hhid: egen tot_men_affar=sum(ethn1)
bysort hhid: egen tot_men_amhara=sum(ethn5)
bysort hhid: egen tot_men_serer=sum(ethn3) 
bysort hhid: egen tot_men_msm=sum(ethn4)
bysort hhid: egen tot_men_diola=sum(ethn5)
bysort hhid: egen tot_men_ss=sum(ethn6) 
bysort hhid: egen tot_men_other=sum(ethn8) 
bysort hhid: egen tot_men_nonseg=sum(ethn7)
*/
* Ethnicity
tab mv131
tab mv131, g(ethn)

* Head 
bysort hhid: g x=1 if ethn1==1 & mv150==1
bysort hhid: egen head_affar_m=max (x)
drop x

bysort hhid: g x=1 if ethn4==1 & mv150==1
bysort hhid: egen head_amharra_m=max (x)
drop x

bysort hhid: g x=1 if ethn14==1 & mv150==1
bysort hhid: egen head_guragie_m=max (x)
drop x

bysort hhid: g x=1 if ethn30==1 & mv150==1
bysort hhid: egen head_oromo_m=max (x)
drop x

bysort hhid: g x=1 if ethn33==1 & mv150==1
bysort hhid: egen head_sidama_m=max (x)
drop x

bysort hhid: g x=1 if ethn34==1 & mv150==1
bysort hhid: egen head_somalie_m=max (x)
drop x

bysort hhid: g x=1 if ethn35==1 & mv150==1
bysort hhid: egen head_tigray_m=max (x)
drop x

bysort hhid: g x=1 if ethn36==1 & mv150==1
bysort hhid: egen head_welaita_m=max (x)
drop x

 
bysort hhid: g x=1 if mv150==1 &	head_welaita_m!=1 & head_tigray_m!=1 & head_somalie_m!=1 & head_sidama_m!=1 & head_oromo_m!=1  ///
                              & head_guragie_m!=1 &	head_amharra_m!=1 & head_affar_m!=1 
bysort hhid: egen head_other_ethn_m=max (x)
drop x

/*
* Urban rural
tab mv102
tab mv102, nol
g rural=1 if mv102==2
tab rural
replace rural=0 if rural==.
tab rural

bysort hhid: egen tot_men_rural=sum(rural)
sum tot_men_rural

bysort hhid: g x=1 if rural==1 & mv150==1
bysort hhid: egen head_rural=max (x)
drop x

lab var head_rural "Male head in the HH - in rural"
lab var tot_men_rural "Number of men in rural area"
*/

* Collapsing at HH level
sum  mv001 mv002
collapse tot_men*  head*  , by (hhid mv001 mv002)
rename mv001 v001
rename mv002 v002
sum
/*
foreach var of varlist tot_men_work_hd head_ag_s_m head_ag_w_m head_un_m head_serv_m head_prof_m head_dom_m head_cler_m head_sales_m head_skman_m head_unskman_m head_noedu_m head_pri_m head_sec_m head_high_m   {
replace `var'=0 if `var'==.
}
sum
*/
order hhid v001 v002

save "$datadir/cleaned/HHmen_00.dta", replace

*********************************************************************************************************************************
* Household members - PR for FOOD SECURITY
*********************************************************************************************************************************

use "$datadir/ETPR41DT/ETPR41FL.dta", clear
keep hhid hvidx hv001 hv002 hv003 hv004 hv005 hv007 shintm shinty hv021 hv022 hv023 hv024 hv025  hv101 hv103 hv104 hv105 hv106 hv107 hc5 hc8 hc11  hc57 hv006 hv007 hv008 hv009 hv220 hv219 hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215 ha5 ha11 hc1 hc56 
gen v001 = hv001
gen v002 = hv002
gen v003 = hv003
sort v001 v002 v003

gen year = shinty
gen month = shintm

* ID
rename hhid hhid_dhs
tostring v001 v002,g (v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s
* STUNTING
*tab hc70, nolabel
*tab hc71, nolabel
*tab hc72 


*STUNTING
foreach var of varlist hc5 hc8 hc11 {
replace `var' =. if `var'==9998
}
gen stunted_ch = 1 if hc5<=-200 
replace stunted_ch=0 if hc5>-200
replace stunted_ch= . if hc5==.
tab stunted_ch
* count if hc5 <-200
bysort hhid: egen stunting_c_hh=total(stunted_ch), missing 
lab var stunting_c_hh "Number of stunted children in the HH"

* WASTING
gen wasted_ch = 1 if hc11<=-200
replace wasted_ch=0 if hc11>-200
replace wasted_ch = . if hc11==.
tab wasted_ch
* count if hc11 <-200
bysort hhid: egen wasted_c_hh=total(wasted_ch), missing 
lab var wasted_c_hh "Number of wasted children in the HH"

* UNDERWWEIGHT

gen underwht_ch = 1 if hc8<=-200
replace underwht_ch=0 if hc8>-200
replace underwht_ch = . if hc8==.
tab underwht_ch
bysort hhid: egen underwht_ch_hh=total(underwht_ch), missing 
lab var underwht_ch_hh "Number of underweighted children in the HH"
tab underwht_ch_hh
* count if hc8 <-200
sum *c_hh 

* MODERATE AND SEVERE ANEMIA AMONG CHILDREN
gen nt_ch_sev_anem=0 if hc1>5 & hc1<60
replace nt_ch_sev_anem=1 if hc56<100 & hc1>5 & hc1<60
replace nt_ch_sev_anem=. if hc56==.
label values nt_ch_sev_anem yesno
label var nt_ch_sev_anem "Moderate/severe anemia - child 6-59 months"
bysort hhid: egen anemia_ch_hh=total(nt_ch_sev_anem), missing 
label var anemia_ch_hh "Moderate/severe anemia HH - child 6-59 months"

* Sex
tab hv104, g(sex)
bysort hhid: egen tot_men_HH=total(sex1)
bysort hhid: egen tot_wmen_HH=total(sex2)
lab var tot_men_HH "Number of men in the HH"
lab var tot_wmen_HH "Number of women in the HH"
bysort hhid:egen tot_teen15=total(hv105<16)
lab var tot_teen15 "Number of teen below 16 in the HH"

* Head educational level 
gen head_no_edu = 1 if hv101==1 & hv106==0
replace head_no_edu=0 if head_no_edu==.
gen head_primary = 1 if hv101==1 & hv106==1
replace head_primary=0 if head_primary==.
gen head_secondary = 1 if hv101==1 & hv106==2
replace head_secondary = 0 if head_secondary==.
gen head_higher=1 if hv101==1 & hv106==3
replace head_higher=0 if head_higher==.

bysort hhid: egen hh_head_no_edu =total(head_no_edu), missing
bysort hhid: egen hh_head_primary =total(head_primary), missing
bysort hhid: egen hh_head_secondary =total(head_secondary), missing
bysort hhid: egen hh_head_higher =total(head_higher), missing


* Collapsing at HH level 
collapse  v003 hv001 hv002 hv003 hv009 tot_men_HH tot_wmen_HH tot_teen15 stunted_ch stunting_c_hh wasted_ch wasted_c_hh underwht_ch underwht_ch_hh hh_head_no_edu hh_head_primary hh_head_secondary hh_head_higher anemia_ch_hh nt_ch_sev_anem, by(hhid v001 v002)
sort hhid

save "$datadir/cleaned/HH_counts_00.dta", replace

*********************************************************************************************************************************
                         *CHILDREN FOOD SECURITY* KR 
*********************************************************************************************************************************
use "$datadir/ETKR41DT/ETKR41FL.dta", clear
// Child's age 

gen age = v008 - b3 // ok, in line with hw1
keep if _n == 1 | caseid != caseid[_n-1]

/*		
* To check if survey has b19, which should be used instead to compute age. 
scalar b19_included=1
capture confirm numeric variable b19, exact 
		if _rc>0 {
	    * b19 is not present
		scalar b19_included=0
		}
		if _rc==0 {
		* b19 is present; check for values
		summarize b19
		if r(sd)==0 | r(sd)==. {
		scalar b19_included=0
			  }
			}

		if b19_included==1 {
		drop age
		gen age=b19
		}
*/

* HHID
tostring v001 v002, g(v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s
order hhid

// Given formula
gen nt_formula= 1 if v469f>=1 & v469f<=7
label values nt_formula yesno
label var nt_formula "Child given infant formula in day/night before survey - last-born under 2 years"

// Given other milk
gen nt_milk=1 if v469h>=1 & v469h<=7
label values nt_milk yesno 
label var nt_milk "Child given other milk in day/night before survey- last-born under 2 years"

// Given grains
gen nt_grains_tuber = 0
gen loc_grain = 1 if v469q >= 1 & v469q <=7
gen tubers = 1 if v469r >= 1 & v469r <=7
replace nt_grains_tuber = 1 if loc_grain== 1 | tubers == 1
replace nt_grains_tuber = . if v469q == . & v469r == .
label var nt_grains_tuber "Child given grains in day/night before survey- last-born under 2 years"

// Given Vit rich foods
gen nt_vit = 0
gen vitamin_food_h = 1 if v469o >= 1 & v469o <=7
replace nt_vit = 1 if vitamin_food_h == 1
replace nt_vit = . if v469o == .
label var nt_vit "Child given vitamin A rich food in day/night before survey- last-born under 2 years"

// Given other fruits or vegetables
gen nt_frtveg = 0
gen oth_fruit_veg_h = 1 if v469u >= 1 & v469u <=7
replace nt_frtveg = 1 if oth_fruit_veg_h == 1
replace nt_frtveg = . if v469u == .
label var nt_frtveg "Child given other fruits or vegetables in day/night before survey- last-born under 2 years"

// Given nuts or legumes
gen nt_nuts = 0
gen legume_nuts_h = 1 if v469w >= 1 & v469w <=7
replace nt_nuts = 1 if legume_nuts_h == 1
replace nt_nuts = . if v469w == .
label var nt_nuts "Child given legumes or nuts in day/night before survey- last-born under 2 years"

// Given meat
gen nt_meat = 0
gen flesh_food_h = 1 if v469v >= 1 & v469v <=7
replace nt_meat = 1 if flesh_food_h
replace nt_meat = . if v469v == .

// Given eggs
gen nt_eggs = 0
replace nt_eggs=. if v469v == .
label var nt_eggs "Child given eggs in day/night before survey- last-born under 2 years"

// Given dairy
egen dairy_prod_amount = rowtotal(v469e v469f v469x), missing
label var dairy_prod_amount "Number of times child had dairy product"
gen nt_dairy = 0
gen dairy_products_h = 1 if v469h >= 1 & v469h <=7
replace nt_dairy = 1 if dairy_products_h == 1
replace nt_dairy = . if v469h == . & dairy_prod_amount == .
label var nt_dairy "Child given cheese, yogurt, or other milk products in day/night before survey- last-born under 2 years"

// Given other solid or semi-solid foods
gen nt_solids= nt_grains_tuber==1 | nt_vit==1 | nt_frtveg==1 | nt_nuts==1 |  nt_eggs==1 | nt_dairy==1 | nt_meat==1
label values nt_solids yesno 
label var nt_solids "Child given any solid or semisolid food in day/night before survey- last-born under 2 years"

// Fed milk or milk products
gen totmilkf = 0
replace totmilkf=totmilkf + v469e if v469e<8
replace totmilkf=totmilkf + v469f if v469f<8
replace totmilkf=totmilkf + v469x if v469x<8
gen nt_fed_milk= (totmilkf>=2 | m4==95) if inrange(age,6,23)
label var nt_fed_milk "Child given milk or milk products- last-born 6-23 months"

// Min dietary diversity

	* 8 food groups
	*1. breastmilk
	gen group1= m4==95

	*2. infant formula, milk other than breast milk, cheese or yogurt or other milk products
	gen group2= nt_formula==1 | nt_milk==1 | nt_dairy==1

	*3. foods made from grains, roots, tubers, and bananas/plantains, including porridge and fortified baby food from grains
	gen group3= nt_grains_tuber==1 
	 
	*4. vitamin A-rich fruits and vegetables
	gen group4= nt_vit==1

	*5. other fruits and vegetables
	gen group5= nt_frtveg==1

	*6. eggs
	gen group6= nt_eggs==1

	*7. legumes and nuts
	gen group7= nt_nuts==1
	
	*8. meat
	gen group8= nt_meat==1

// Min dietary diversity
egen foodsum = rsum(group1 group2 group3 group4 group5 group6 group7 group8) 
recode foodsum (1/4=0 "No") (5/8=1 "Yes"), gen(nt_mdd)
replace nt_mdd=. if age<6 | age >=24
label var nt_mdd "Child with minimum dietary diversity, 5 out of 8 food groups- last-born 6-23 months"

gen non_mdd = 1 if nt_mdd == 0 
replace non_mdd=0 if nt_mdd==1 
bys hhid : egen new_No_min_diet_diversity_hh = max(non_mdd) if non_mdd!=.
la var new_No_min_diet_diversity_hh "HH has at least one young child that is not fed with the min food diversity"

/*older surveys are 4 out of 7 food groups, can use code below
egen foodsum = rsum(group2 group3 group4 group5 group6 group7 group8) 
recode foodsum (1/3 .=0 "No") (4/7=1 "Yes"), gen(nt_mdd)
*/

// Min meal frequency
gen feedings=totmilkf
replace feedings= feedings + m39 if m39>0 & m39<8
gen nt_mmf = (m4==95 & inrange(m39,2,7) & inrange(age,6,8)) | (m4==95 & inrange(m39,3,7) & inrange(age,9,23)) | (m4!=95 & feedings>=4 & inrange(age,6,23))
replace nt_mmf=. if age<6 | age >=24
label var nt_mmf "Child with minimum meal frequency- last-born 6-23 months"

gen non_mmf =1 if nt_mmf==0 
replace non_mmf=0 if nt_mmf==1 
bys hhid : egen new_No_min_meal_freq_hh = max(non_mmf) if non_mmf!=.
la var new_No_min_meal_freq_hh "HH has at least one young child that is not fed min frequency"

// Min acceptable diet
egen foodsum2 = rsum(nt_grains nt_grains_tuber nt_nuts nt_meat nt_vit nt_frtveg nt_eggs)
gen nt_mad = (m4==95 & nt_mdd==1 & nt_mmf==1) | (m4!=95 & foodsum2>=4 & nt_mmf==1 & totmilkf>=2)
replace nt_mad=. if age<6 | age>=24
label values nt_mad yesno
label var nt_mad "Child with minimum acceptable diet- last-born 6-23 months"
 
gen non_mad =1 if nt_mad==0 
replace non_mad=0 if nt_mad==1 
bys hhid : egen new_No_min_acc_diet_hh = max(non_mad) if non_mad!=.
la var new_No_min_acc_diet_hh "HH has at least one young child that is not fed min acceptable diet"

count
sort hhid
collapse (max) nt_mmf nt_mdd new_No_min_diet_diversity_hh new_No_min_meal_freq_hh new_No_min_acc_diet_hh, by (hhid v001 v002)
*hh_young_ch

save "$datadir/cleaned/NEW_1_food_00.dta", replace


*********************************************************************************************************************************
* MERGING
*********************************************************************************************************************************

use "$datadir/ETPR41DT/ETPR41FL.dta", clear
keep hhid hv001 hv002 hv003 hv005 hv007 shintm shinty  hv021 hv022 hv023 hv024 hv025 hv006 hv008 hv009  hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215  /* hv270  hv271 sh28k sh28m hv244 hv245 hv246 hv246a hv246c hv246d hv246e hv246f hv246g missing */ hv219 hv220  


gen month=shintm 
gen year=shinty 


rename hv025 type_place 
rename hv024 region
gen v001 = hv001
gen v002 = hv002
gen v003 = hv003
sort v001 v002 v003

* ID
tostring v001 v002, g(v001s v002s)
rename hhid hhid_dhs
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s
order hhid

* Year

* Collapse
collapse hv003 hv005 hv007 hv021 hv022 hv023 hv006 hv008 hv009 type_place region hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215 year month/*hv244 hv270 hv271 sh28k sh28m hv245 hv246 hv246a hv246c hv246d hv246e hv246f hv246g */ hv219 hv220, by (hhid v001 v002)
sort hhid 

* Merging

merge 1:1 hhid v001 v002 using "$datadir/cleaned/HHwomen_00.dta"
drop _merge

merge 1:1 hhid v001 v002 using "$datadir/cleaned/HHmen_00.dta"
drop _merge

merge 1:1 hhid v001 v002 using "$datadir/cleaned/HH_counts_00.dta"
drop _merge

*merge 1:1 hhid v001 v002 using "$datadir/cleaned/food_00.dta"
*drop _merge

merge 1:1 hhid  v001 v002 using "$datadir/cleaned/NEW_1_food_00.dta"
drop _merge


order hhid year month

*************************************************************************************************************************
* WEIGHTS
*************************************************************************************************************************

rename hv005 HH_wgt
gen wgt = HH_wgt/1000000

*************************************************************************************************************************
* LABELLING and DROPPING
*************************************************************************************************************************

label list
label values hv023 HV023
label values region HV024
label values type_place HV025
label values hv201 HV201
label values hv205 HV205
label values hv206 HV206
label values hv207 HV207
label values hv208 HV208
label values hv213 HV213
label values hv214 HV214
label values hv215 HV215
label values hv204 HV204
*label values hv270 HV270
*label values hv271 HV271

*label define sh28 ///
*0 "No" ///
*1 "Yes" 
*lab values sh28k sh28 
*lab values sh28m sh28 

label var hv001 "Cluster number"
label var hv002 "HH number"
label var hv003 "Respondent line number"
label var hv006 "Month of interview Ethiopian"
label var hv007 "Year of interview Ethiopian"
label var year "year of interview Gregorian"
label var month "month of interview Gregorian"
label var hv008 "Date interview"
label var hv009 "HH size"
label var HH_wgt "Weights DHS"
label var hv021 "Primary sampling unit"
label var hv022 "Sample struts number"
label var hv023 "Sample domain"
label var type_place "Type place of residence"
label var region "Region"
label var hv201 "Source of drinking water"
label var hv204 "Time to get water"
label var hv205 "Toilet facilities"
label var hv206 "Electricity dummy"
label var hv207 "Radio dummy"
label var hv208 "Television dummy"
label var hv213 "Main fllor material"
label var hv214 "Main wall material"
label var hv215 "Main roof material"
*label var hv270 "Wealth Index"
label var hv219 "Sex head household"
*rename hv270 wealth_index
*label var hv271 "Wealth Index score"
*rename hv271 wealth_index_score
*label var sh28k "Sheep"
*rename sh28k sheep
*label var sh28m "Poultry"
*rename sh28m poultry
lab var tot_wmen "Number of women in the HH"
lab var tot_wmen_ag "Number of women in agriculture"
lab var tot_wmen_serv "Number of women in the HH - service employment"
lab var tot_wmen_sales "Number of women in the HH - sales employment"
lab var tot_wmen_skman "Number of women in the HH - skilled manual employment"
lab var tot_wmen_un "Number of women in the HH - unemployment"
lab var tot_wmen_work "Number of women currently working in the HH"
lab var tot_wmen_work_hd "Women head(s) currently working in the HH"
lab var head_ag_s_wm "Female head in the HH - agri-self-employed"
lab var head_ag_w_wm "Female head in the HH - agri-wage-employed"
lab var head_serv_wm "Female head in the HH - services employment"
lab var head_sales_wm "Female head in the HH - sales employment"
lab var head_skman_wm "Female head in the HH - skilled manual employment"
lab var head_un_wm "Female head in the HH - unemployed"
lab var tot_wmen_noedu "Number of women in the HH - no education"
lab var tot_wmen_pri "Number of women in the HH - primary education"
lab var tot_wmen_sec "Number of women in the HH - secondary education"
lab var tot_wmen_high "Number of women in the HH - higher education"
lab var head_noedu_wm "Women head in the HH - no education"
lab var head_pri_wm "Women head in the HH - primary education"
lab var head_sec_wm "Women head in the HH - secondary education"
lab var head_high_wm "Women head in the HH - higher education"
lab var tot_RI_Low_w "Number of women in HH with low or very low Rohrer Index"
*lab var tot_BMI_low_w "Number of women in HH with BMI <16.9 (severe or moderately thin)"
*lab var hh_young_ch "Number of children younger than 24 months in the household"
*lab var No_min_diet_diversity_hh "HH has at least one young child that is not fed with the min food diversity" 
lab var stunting_c_hh "Number of stunted children in the HH"
lab var wasted_c_hh "Number of wasted children in the HH"
lab var underwht_ch_hh "Number of underweight children in the HH"
lab var tot_men_HH "Number of men in the HH"
lab var tot_wmen_HH "Number of women in the HH"
lab var tot_teen15 "Number of teen below 16 in the HH"
lab var tot_men "Number of men in the HH"
lab var tot_men_ag "Number of men in agriculture"
lab var tot_men_un "Number of men in the HH - unemployed"
lab var tot_men_serv "Number of men in the HH - services employment"
lab var tot_men_prof "Number of men in the HH - Professional jobs"
lab var tot_men_sales "Number of men in the HH - sales employment"
lab var tot_men_skman "Number of men in the HH - skilled manual employment"
lab var tot_men_work "Number of men currently working in the HH"
lab var tot_men_work_hd "Male head currently working in the HH"
lab var head_ag_m "Male head in the HH - agriculture"
lab var head_un_m "Male head in the HH - unemployed"
lab var head_prof_m "Male head in the HH - Professional"
lab var head_cler_m "Male head in the HH - clerical employment"
lab var head_sales_m "Male head in the HH - sales employment"
lab var head_serv_m "Male head in the HH - services employment"
lab var head_skman_m "Male head in the HH - skilled manual employment"
lab var head_unskman_m "Male head in the HH - unskilled manual employment"
lab var head_other_m "Male Head in other employment"
lab var tot_men_noedu "Number of men in the HH - no education"
lab var tot_men_pri "Number of men in the HH - primary education"
lab var tot_men_sec "Number of men in the HH - secondary education"
lab var tot_men_high "Number of men in the HH - higher education"
lab var head_noedu_m "Male head in the HH - no education"
lab var head_pri_m "Male head in the HH - primary education"
lab var head_sec_m "Male head in the HH - secondary education"
lab var head_high_m "Male head in the HH - higher education"
lab var wgt "Weights - to use"
lab var head_prof_wm "Female head of the HH - professional employment"
lab var tot_wmen_Prof "Number of women in the HH - professional employment"

save "$datadir\cleaned\final_00.dta", replace


*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
* Ethiopia 2005 
*******************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************


*********************************************************************************************************************************
* Individual records WOMEN - IR 
*********************************************************************************************************************************

global datadir  "E:\WORK ROMA\African Obsevatory\Ethiopia\DHS\Complete\2005" 
use "$datadir/ETIR51DT/ETIR51FL.dta", clear
keep caseid v000 v001 v002 v003 v004 v005 v006 v007 v008 sintmg v042 v455 v457 v208 m45_1 m46_1 v213 b3_01 v012 v024 v025 v101 v102 v106 v107 v133 v131 v717 v714 v705 v719 v440 v444a v445 v446 v439 v150 v151 v152 v501
sort v001 v002 v003


*generate year variable
gen vg008=v008+92
gen year=int((vg008-1)/12)
replace year=year+1900

gen month=sintmg
* ID
tostring v001 v002,g (v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s v000
rename caseid hhid_dhs

* Number of women in the HH
bysort hhid: g n=_n
bysort hhid: egen tot_wmen=max(n)
sum tot_w
lab var tot_wm "Number of women in the HH"
drop n 

* Employment in agriculture
tab v717
tab v717, g(occ)

bysort hhid: egen tot_wmen_ag=sum(occ5)

bysort hhid: egen tot_wmen_Prof=sum(occ2)
bysort hhid: egen tot_wmen_cler=sum(occ3)
bysort hhid: egen tot_wmen_sales=sum(occ4)
bysort hhid: egen tot_wmen_serv=sum(occ6)
bysort hhid: egen tot_wmen_skman=sum(occ7)
bysort hhid: egen tot_wmen_unskman=sum(occ8)
bysort hhid: egen tot_wmen_other=sum(occ9)
bysort hhid: egen tot_wmen_un=sum(occ1) 
lab var tot_wmen_Prof "Number of women in the HH - Professional jobs"
lab var tot_wmen_cler "Number of women in the HH - clerical employment"
lab var tot_wmen_sales "Number of women in the HH - sales employment"
lab var tot_wmen_serv "Number of women in the HH - services employment"
lab var tot_wmen_skman "Number of women in the HH - skilled manual employment"
lab var tot_wmen_unskman "Number of women in the HH - unskilled manual employment"
lab var tot_wmen_un "Number of women in the HH - unemployment"


*Currently working
bysort hhid: egen tot_wmen_work=sum(v714)
bysort hhid: egen tot_wmen_work_hd=sum(v714) if v150==1


*HH head occupation 
bysort hhid: g x=1 if occ5==1 & v150==1
bysort hhid: egen head_ag_wm=max (x)
drop x

bysort hhid: g x=1 if occ2==1 & v150==1
bysort hhid: egen head_prof_wm=max (x)
drop x

bysort hhid: g x=1 if occ3==1 & v150==1
bysort hhid: egen head_cler_wm=max (x)
drop x

bysort hhid: g x=1 if occ4==1 & v150==1
bysort hhid: egen head_sales_wm=max (x)
drop x

bysort hhid: g x=1 if occ6==1 & v150==1
bysort hhid: egen head_serv_wm=max (x)
drop x

bysort hhid: g x=1 if occ7==1 & v150==1
bysort hhid: egen head_skman_wm=max (x)
drop x

bysort hhid: g x=1 if occ8==1 & v150==1
bysort hhid: egen head_unskman_wm=max (x)
drop x

bysort hhid: g x=1 if occ9==1 & v150==1
bysort hhid: egen head_other_wm=max (x)
drop x

bysort hhid: g x=1 if occ1==1 & v150==1
bysort hhid: egen head_un_wm=max (x)
drop x

lab var tot_wmen_work "Number of women currently working in the HH"
lab var tot_wmen_work_hd "Women head(s) currently working in the HH"
lab var head_ag_wm "Female head in the HH - agriculture"
lab var head_prof_wm "Female head in the HH - Professional"
lab var head_un_wm "Female head in the HH - domestic employed"
lab var head_cler_wm "Female head in the HH - clerical employment"
lab var head_sales_wm "Female head in the HH - sales employment"
lab var head_serv_wm "Female head in the HH - services employment"
lab var head_skman_wm "Female head in the HH - skilled manual employment"
lab var head_unskman_wm "Female head in the HH - unskilled manual employment"



* Education
tab v106, g(edu)
bysort hhid: egen tot_wmen_noedu=sum(edu1)
bysort hhid: egen tot_wmen_pri=sum(edu2)
bysort hhid: egen tot_wmen_sec=sum(edu3)
bysort hhid: egen tot_wmen_high=sum(edu4)

* Head 
bysort hhid: g x=1 if edu1==1 & v150==1
bysort hhid: egen head_noedu_wm=max (x)
drop x

bysort hhid: g x=1 if edu2==1 & v150==1
bysort hhid: egen head_pri_wm=max (x)
drop x

bysort hhid: g x=1 if edu3==1 & v150==1
bysort hhid: egen head_sec_wm=max (x)
drop x

bysort hhid: g x=1 if edu4==1 & v150==1
bysort hhid: egen head_high_wm=max (x)
drop x

lab var tot_wmen_noedu "Number of women in the HH - no education"
lab var tot_wmen_pri "Number of women in the HH - primary education"
lab var tot_wmen_sec "Number of women in the HH - secondary education"
lab var tot_wmen_high "Number of women in the HH - higher education"
lab var head_noedu_wm "Female head in the HH - no education"
lab var head_pri_wm "Female head in the HH - primary education"
lab var head_sec_wm "Female head in the HH - secondary education"
lab var head_high_wm "Female head in the HH - higher education"

* Ethnicity
* Two major ethnic groups: Wolof and Poular = 1 versus others =0 

* Ethnicity
tab v131
tab v131, g(ethn)

* Head 
bysort hhid: g x=1 if ethn1==1 & v150==1
bysort hhid: egen head_affar_wm=max (x)
drop x

bysort hhid: g x=1 if ethn4==1 & v150==1
bysort hhid: egen head_amharra_wm=max (x)
drop x

bysort hhid: g x=1 if ethn19==1 & v150==1
bysort hhid: egen head_guragie_wm=max (x)
drop x

bysort hhid: g x=1 if ethn45==1 & v150==1
bysort hhid: egen head_oromo_wm=max (x)
drop x

bysort hhid: g x=1 if ethn52==1 & v150==1
bysort hhid: egen head_sidama_wm=max (x)
drop x

bysort hhid: g x=1 if ethn53==1 & v150==1
bysort hhid: egen head_somalie_wm=max (x)
drop x

bysort hhid: g x=1 if ethn55==1 & v150==1
bysort hhid: egen head_tigray_wm=max (x)
drop x

bysort hhid: g x=1 if ethn57==1 & v150==1
bysort hhid: egen head_welaita_wm=max (x)
drop x

bysort hhid: g x=1 if v150==1 &	head_welaita_wm!=1 & head_tigray_wm!=1 & head_somalie_wm!=1 & head_sidama_wm!=1 & head_oromo_wm!=1 & head_guragie_wm!=1 ///
                              &	head_amharra_wm!=1 & head_affar_wm!=1 
bysort hhid: egen head_other_ethn_wm=max (x)
drop x


// Anthropometry indicators

* Age of most recent child - to select women that are not post partum 
gen age = v008 - b3_01
	
* To check if survey has b19, which should be used instead to compute age
scalar b19_included=1
capture confirm numeric variable b19_01, exact 
		if _rc>0 {
		* b19 is not present
        scalar b19_included=0
		}
		
		if _rc==0 {
		* b19 is present; check for values
		summarize b19_01
		if r(sd)==0 | r(sd)==. {
		scalar b19_included=0
		  }
		}

	    if b19_included==1 {
	    drop age
	    gen age=b19_01
	    }

// Rohrer index (RI) ie Index  of Corpulence - NON PREGNANT-POST PARTUM WOMEN

// The range variation of RI (According to Pignet, cited in Bhasin and Singh, 2004) is also mentioned in this study: Rohrer Index=(Body weight (gm)/Stature 3 (cm)) × 100 //
/*
• Very low ≤ 1.12

• Low (1.13-1.19)

• Middle (1.20-1.25)

• Upper middle (1.26-1.32)

• High (1.33-1.39)

• Very high=1.40

• Healthy range 1.2-1.6
*/

* Substitute with missing
sum v446
codebook v446
tab v446, nolabel
tab v445
foreach var of varlist v445 v446 {
replace `var' =. if `var'==9998 | `var'==9999
}

* RI creation
g RI_Low_w=1 if v446<=1190 //RI for low and very low//
replace RI_Low_w=0 if v446>1190
replace RI_Low_w= . if (v446==.| v213==1 | age<2)
lab var RI_Low_w "Rohrer Index - low or very low - women"
br v446 RI_Low_w
label define RI_Low_w 1 "Low or Very low Rohrer's Index" 0 "High Rohrer Index"
label values RI_Low_w RI_Low_w
br v446 RI_Low_w
tab RI_Low_w
bysort hhid: egen tot_RI_Low_w=total(RI_Low_w), missing
br tot_RI_Low_w hhid RI_Low_w
sum tot_RI_Low_w
lab var tot_RI_Low_w "Number of women in HH with low or very low Rohrer Index"

// BMI - NON PREGNANT-POST PARTUM WOMEN

/* https://dhsprogram.com/pubs/pdf/MR6/MR6.pdf
With standard terminology for this
measure, if the BMI is less than 16.0, the woman is ―severely thin;‖ if 16.0 to 16.9, she is ―moderately
thin;‖ if 17.0 to 18.4, she is ―mildly thin.‖ The entire range below 18.5 is ―thin.‖ If the BMI is 25.0 to
29.9, the woman is ―overweight;‖ if 30.0 or higher, she is ―obese.‖ For example, if v437 = 400 (40.0 kg)
and v438 = 1500 (1.500 meters) then v445 = 1778, the BMI is 17.78, and the woman is ―mildly thin.‖
For the ―malnourished‖ woman described in the last paragraph of section 4.2.2, with a weight of 35.1 kg
and a height of 1.500 meters, the BMI is 15.6, so she is ―severely thin.‖
*/

/* The DHS Guide to Statistics offers the following guidelines for interpreting BMI scores for women age 15-49:
 Severely thin: less than 16.0
Moderately thin: 16.0 to 16.9
Mildly thin: 17.0 to 18.4
Normal: 18.5 to 24.9
Overweight: 25.0 to 29.9
Obese: 30.0 or more*/

* BMI - moderately or severely thin DHS
gen nt_wm_modsevthin= inrange(v445,1200,1699) if inrange(v445,1200,6000)
replace nt_wm_modsevthin=. if (v445 ==. | v213==1 | age<2)
label values nt_wm_modsevthin yesno
label var nt_wm_modsevthin "Moderately and severely thin BMI - women"
bysort hhid: egen DHS_tot_BMI_low_w=total(nt_wm_modsevthin), missing 
lab var DHS_tot_BMI_low_w "Number of women in HH with BMI <16.9 (severe or moderately thin)"

/*
// TOOK IRON supplements during last pregnancy
gen nt_wm_micro_iron= .
replace nt_wm_micro_iron=0 if m45_1==0
replace nt_wm_micro_iron=1 if inrange(m46_1,0,59)
replace nt_wm_micro_iron=2 if inrange(m46_1,60,89)
replace nt_wm_micro_iron=3 if inrange(m46_1,90,300)
replace nt_wm_micro_iron=4 if m45_1==8 | m45_1==9 | m46_1==998 | m46_1==999
replace nt_wm_micro_iron= . if v208==0
label define nt_wm_micro_iron 0"None" 1"<60" 2"60-89" 3"90+" 4"Don't know/missing"
label values nt_wm_micro_iron nt_wm_micro_iron
label var nt_wm_micro_iron "Number of days women took iron supplements during last pregnancy"
*/

// SEVERE ANEMIA
gen nt_wm_sev_anem=0 if v042==1 & v455==0
replace nt_wm_sev_anem=1 if v457==1 | v457==2
label values nt_wm_sev_anem yesno
label var nt_wm_sev_anem "Severe and Moderate anemia - women"
bysort hhid: egen sev_mod_anemia_hh=total(nt_wm_sev_anem), missing 
lab var sev_mod_anemia_hh "Number of women in HH with severe-moderate anemia"

* Collapsing at HH level
sum  v001 v002
collapse tot_wmen* head* RI_Low_w tot_RI_Low_w nt_wm_modsevthin DHS_tot_BMI_low_w sev_mod_anemia_hh  , by (hhid v001 v002)

sum
order hhid v001 v002
sort hhid 

save "$datadir/cleaned/HHwomen_05.dta", replace

*********************************************************************************************************************************
* Individual records MEN 
*********************************************************************************************************************************

use "$datadir/ETMR51DT/ETMR51FL.dta", clear
keep mcaseid mv000 mv001 mv002 mv003 mv004 mv005 mv006 mv007 mv008 smintmg mv012 mv024 mv025 mv101 mv102 mv106 mv107 mv133 mv131 mv717 mv714 mv150 mv151 mv152 mv501
gen v001 = mv001
gen v002 = mv002
gen v003 = mv003
sort v001 v002 v003

*generate year


*generate year variable
gen vg008=mv008+92
gen year=int((vg008-1)/12)
replace year=year+1900


gen month=smintmg



* ID
tostring mv001 mv002,g (mv001s mv002s)
g hhid=mv001s+mv002s
replace hhid =mv001s+"0"+mv002s if mv002<10
order hhid 
destring hhid, replace
drop mv001s mv002s

* Gen person id without spaces
/* tostring mv001 mv002 mv003,g (mv001s mv002s mv003s)
g mid=mv001s+mv002s+mv003s
replace mid =mv001s+"0"+mv002s+mv003s if mv002<10
replace mid =mv001s+mv002s+"0"+mv003s if mv003<10
order hhid mid
destring mid, replace
drop mv001s mv002s mv003s*/ // not necessary

* Number of men in the HH
bysort hhid: g n=_n
bysort hhid: egen tot_men=max(n)
sum tot_m
lab var tot_m "Number of men in the HH"
drop n 

*Employment in agriculture
tab mv717
tab mv717, g(occ)
bysort hhid: egen tot_men_ag=sum(occ5)
sum tot_men_ag
lab var tot_men_ag "Number of men in agriculture"

*Other occupations
bysort hhid: egen tot_men_un=sum(occ1)
bysort hhid: egen tot_men_prof=sum(occ2)
bysort hhid: egen tot_men_cler=sum(occ3)
bysort hhid: egen tot_men_sales=sum(occ4)
bysort hhid: egen tot_men_serv=sum(occ6)
bysort hhid: egen tot_men_skman=sum(occ7)
bysort hhid: egen tot_men_unskman=sum(occ8)
bysort hhid: egen tot_men_other=sum(occ9)

lab var tot_men_un "Number of men in the HH - unemployed"
lab var tot_men_prof "Number of men in the HH - Professional jobs"
lab var tot_men_cler "Number of men in the HH - clerical employment"
lab var tot_men_sales "Number of men in the HH - sales employment"
lab var tot_men_serv "Number of men in the HH - services employment"
lab var tot_men_skman "Number of men in the HH - skilled manual employment"
lab var tot_men_unskman "Number of men in the HH - ubskilled manual employment"
lab var tot_men_other "Number of men in other employment"

*Currently working
bysort hhid: egen tot_men_work=sum(mv714)
bysort hhid: egen tot_men_work_hd=sum(mv714) if mv150==1


*HH head occupation 
bysort hhid: g x=1 if occ5==1 & mv150==1
bysort hhid: egen head_ag_m=max (x)
drop x

bysort hhid: g x=1 if occ1==1 & mv150==1
bysort hhid: egen head_un_m=max (x)
drop x

bysort hhid: g x=1 if occ2==1 & mv150==1
bysort hhid: egen head_prof_m=max (x)
drop x

bysort hhid: g x=1 if occ3==1 & mv150==1
bysort hhid: egen head_cler_m=max (x)
drop x

bysort hhid: g x=1 if occ4==1 & mv150==1
bysort hhid: egen head_sales_m=max (x)
drop x

bysort hhid: g x=1 if occ6==1 & mv150==1
bysort hhid: egen head_serv_m=max (x)
drop x

bysort hhid: g x=1 if occ7==1 & mv150==1
bysort hhid: egen head_skman_m=max (x)
drop x

bysort hhid: g x=1 if occ8==1 & mv150==1
bysort hhid: egen head_unskman_m=max (x)
drop x

bysort hhid: g x=1 if occ9==1 & mv150==1
bysort hhid: egen head_other_m=max (x)
drop x

lab var tot_men_work "Number of men currently working in the HH"
lab var tot_men_work_hd "men head(s) currently working in the HH"
lab var head_ag_m "Male head in the HH - agriculture"
lab var head_un_m "Male head in the HH - unemployed"
lab var head_prof_m "Male head in the HH - Professional"
lab var head_cler_m "Male head in the HH - clerical employment"
lab var head_sales_m "Male head in the HH - sales employment"
lab var head_serv_m "Male head in the HH - services employment"
lab var head_skman_m "Male head in the HH - skilled manual employment"
lab var head_unskman_m "Male head in the HH - unskilled manual employment"
lab var head_other_m "Male Head in other employment"

* Education
tab mv106, g(edu)
bysort hhid: egen tot_men_noedu=sum(edu1)
bysort hhid: egen tot_men_pri=sum(edu2)
bysort hhid: egen tot_men_sec=sum(edu3)
bysort hhid: egen tot_men_high=sum(edu4)

lab var tot_men_noedu "Number of men in the HH - no education"
lab var tot_men_pri "Number of men in the HH - primary education"
lab var tot_men_sec "Number of men in the HH - secondary education"
lab var tot_men_high "Number of men in the HH - higher education"

* Head - Education
bysort hhid: g x=1 if edu1==1 & mv150==1
bysort hhid: egen head_noedu_m=max (x)
drop x

bysort hhid: g x=1 if edu2==1 & mv150==1
bysort hhid: egen head_pri_m=max (x)
drop x

bysort hhid: g x=1 if edu3==1 & mv150==1
bysort hhid: egen head_sec_m=max (x)
drop x

bysort hhid: g x=1 if edu4==1 & mv150==1
bysort hhid: egen head_high_m=max (x)
drop x

lab var head_noedu_m "Male head in the HH - no education"
lab var head_pri_m "Male head in the HH - primary education"
lab var head_sec_m "Male head in the HH - secondary education"
lab var head_high_m "Male head in the HH - higher education"

* Ethnicity
* Two major ethnic groups: Wolof and Poular = 1 versus others =0 
tab mv131
tab mv131, g(ethn)



* Head 
bysort hhid: g x=1 if ethn1==1 & mv150==1
bysort hhid: egen head_affar_m=max (x)
drop x

bysort hhid: g x=1 if ethn4==1 & mv150==1
bysort hhid: egen head_amharra_m=max (x)
drop x

bysort hhid: g x=1 if ethn16==1 & mv150==1
bysort hhid: egen head_guragie_m=max (x)
drop x

bysort hhid: g x=1 if ethn36==1 & mv150==1
bysort hhid: egen head_oromo_m=max (x)
drop x

bysort hhid: g x=1 if ethn41==1 & mv150==1
bysort hhid: egen head_sidama_m=max (x)
drop x

bysort hhid: g x=1 if ethn42==1 & mv150==1
bysort hhid: egen head_somalie_m=max (x)
drop x

bysort hhid: g x=1 if ethn43==1 & mv150==1
bysort hhid: egen head_tigray_m=max (x)
drop x

bysort hhid: g x=1 if ethn44==1 & mv150==1
bysort hhid: egen head_welaita_m=max (x)
drop x


bysort hhid: g x=1 if mv150==1 &	head_welaita_m!=1 & head_tigray_m!=1 & head_somalie_m!=1 & head_sidama_m!=1 & head_oromo_m!=1  ///
                              & head_guragie_m!=1 &	head_amharra_m!=1 & head_affar_m!=1 
bysort hhid: egen head_other_ethn_m=max (x)
drop x

/*
* Urban rural
tab mv102
tab mv102, nol
g rural=1 if mv102==2
tab rural
replace rural=0 if rural==.
tab rural

bysort hhid: egen tot_men_rural=sum(rural)
sum tot_men_rural

bysort hhid: g x=1 if rural==1 & mv150==1
bysort hhid: egen head_rural=max (x)
drop x

lab var head_rural "Male head in the HH - in rural"
lab var tot_men_rural "Number of men in rural area"
*/

* Collapsing at HH level
sum  mv001 mv002
collapse tot_men*  head*  , by (hhid mv001 mv002)
rename mv001 v001
rename mv002 v002
sum
/*
foreach var of varlist tot_men_work_hd head_ag_s_m head_ag_w_m head_un_m head_serv_m head_prof_m head_dom_m head_cler_m head_sales_m head_skman_m head_unskman_m head_noedu_m head_pri_m head_sec_m head_high_m   {
replace `var'=0 if `var'==.
}
sum
*/
order hhid v001 v002

save "$datadir/cleaned/HHmen_05.dta", replace

*********************************************************************************************************************************
* Household members - PR for FOOD SECURITY
*********************************************************************************************************************************

use "$datadir/ETPR51DT/ETPR51FL.dta", clear


keep hhid hvidx hv001 hv002 hv003 hv004 hv005 hv007 shintmg hv021 hv022 hv023 hv024 hv025  hv101 hv103 hv104 hv105 hv106 hv107 hc5 hc8 hc11  hc57 hv006 hv007 hv008 hv009 hv220 hv219 hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215 ha5 ha11 hc1 hc56 
gen v001 = hv001
gen v002 = hv002
gen v003 = hv003
sort v001 v002 v003

*generate year variable
gen vg008=hv008+92
gen year=int((vg008-1)/12)
replace year=year+1900

gen month=shintmg

* ID
rename hhid hhid_dhs
tostring v001 v002,g (v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s
* STUNTING
*tab hc70, nolabel
*tab hc71, nolabel
*tab hc72 


*STUNTING
foreach var of varlist hc5 hc8 hc11 {
replace `var' =. if `var'==9998
}
gen stunted_ch = 1 if hc5<=-200 
replace stunted_ch=0 if hc5>-200
replace stunted_ch= . if hc5==.
tab stunted_ch
* count if hc5 <-200
bysort hhid: egen stunting_c_hh=total(stunted_ch), missing 
lab var stunting_c_hh "Number of stunted children in the HH"

* WASTING
gen wasted_ch = 1 if hc11<=-200
replace wasted_ch=0 if hc11>-200
replace wasted_ch = . if hc11==.
tab wasted_ch
* count if hc11 <-200
bysort hhid: egen wasted_c_hh=total(wasted_ch), missing 
lab var wasted_c_hh "Number of wasted children in the HH"

* UNDERWWEIGHT

gen underwht_ch = 1 if hc8<=-200
replace underwht_ch=0 if hc8>-200
replace underwht_ch = . if hc8==.
tab underwht_ch
bysort hhid: egen underwht_ch_hh=total(underwht_ch), missing 
lab var underwht_ch_hh "Number of underweighted children in the HH"
tab underwht_ch_hh
* count if hc8 <-200
sum *c_hh 

* MODERATE AND SEVERE ANEMIA AMONG CHILDREN
gen nt_ch_sev_anem=0 if hc1>5 & hc1<60
replace nt_ch_sev_anem=1 if hc56<100 & hc1>5 & hc1<60
replace nt_ch_sev_anem=. if hc56==.
label values nt_ch_sev_anem yesno
label var nt_ch_sev_anem "Moderate/severe anemia - child 6-59 months"
bysort hhid: egen anemia_ch_hh=total(nt_ch_sev_anem), missing 
label var anemia_ch_hh "Moderate/severe anemia HH - child 6-59 months"

* Sex
tab hv104, g(sex)
bysort hhid: egen tot_men_HH=total(sex1)
bysort hhid: egen tot_wmen_HH=total(sex2)
lab var tot_men_HH "Number of men in the HH"
lab var tot_wmen_HH "Number of women in the HH"
bysort hhid:egen tot_teen15=total(hv105<16)
lab var tot_teen15 "Number of teen below 16 in the HH"

* Head educational level 
gen head_no_edu = 1 if hv101==1 & hv106==0
replace head_no_edu=0 if head_no_edu==.
gen head_primary = 1 if hv101==1 & hv106==1
replace head_primary=0 if head_primary==.
gen head_secondary = 1 if hv101==1 & hv106==2
replace head_secondary = 0 if head_secondary==.
gen head_higher=1 if hv101==1 & hv106==3
replace head_higher=0 if head_higher==.

bysort hhid: egen hh_head_no_edu =total(head_no_edu), missing
bysort hhid: egen hh_head_primary =total(head_primary), missing
bysort hhid: egen hh_head_secondary =total(head_secondary), missing
bysort hhid: egen hh_head_higher =total(head_higher), missing


* Collapsing at HH level 
collapse  v003 hv001 hv002 hv003 hv009 tot_men_HH tot_wmen_HH tot_teen15 stunted_ch stunting_c_hh wasted_ch wasted_c_hh underwht_ch underwht_ch_hh hh_head_no_edu hh_head_primary hh_head_secondary hh_head_higher anemia_ch_hh nt_ch_sev_anem, by(hhid v001 v002)
sort hhid

save "$datadir/cleaned/HH_counts_05.dta", replace



*********************************************************************************************************************************
use "$datadir/ETKR51DT/ETKR51FL.dta", clear
// Child's age 

gen age = v008 - b3 // ok, in line with hw1
keep if _n == 1 | caseid != caseid[_n-1]

/*		
* To check if survey has b19, which should be used instead to compute age. 
scalar b19_included=1
capture confirm numeric variable b19, exact 
		if _rc>0 {
	    * b19 is not present
		scalar b19_included=0
		}
		if _rc==0 {
		* b19 is present; check for values
		summarize b19
		if r(sd)==0 | r(sd)==. {
		scalar b19_included=0
			  }
			}

		if b19_included==1 {
		drop age
		gen age=b19
		}
*/

* HHID
tostring v001 v002, g(v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s
order hhid

// Given formula
gen nt_formula= 1 if v469f>=1 & v469f<=7
label values nt_formula yesno
label var nt_formula "Child given infant formula in day/night before survey - last-born under 2 years"

// Given other milk
gen nt_milk=1 if v469h>=1 & v469h<=7
label values nt_milk yesno 
label var nt_milk "Child given other milk in day/night before survey- last-born under 2 years"

// Given grains
gen nt_grains_tuber = 0
gen loc_grain = 1 if v469q >= 1 & v469q <=7
gen tubers = 1 if v469r >= 1 & v469r <=7
replace nt_grains_tuber = 1 if loc_grain== 1 | tubers == 1
replace nt_grains_tuber = . if v469q == . & v469r == .
label var nt_grains_tuber "Child given grains in day/night before survey- last-born under 2 years"

// Given Vit rich foods
gen nt_vit = 0
gen vitamin_food_h = 1 if v469o >= 1 & v469o <=7
replace nt_vit = 1 if vitamin_food_h == 1
replace nt_vit = . if v469o == .
label var nt_vit "Child given vitamin A rich food in day/night before survey- last-born under 2 years"

// Given other fruits or vegetables
gen nt_frtveg = 0
gen oth_fruit_veg_h = 1 if v469u >= 1 & v469u <=7
replace nt_frtveg = 1 if oth_fruit_veg_h == 1
replace nt_frtveg = . if v469u == .
label var nt_frtveg "Child given other fruits or vegetables in day/night before survey- last-born under 2 years"

// Given nuts or legumes
gen nt_nuts = 0
gen legume_nuts_h = 1 if v469w >= 1 & v469w <=7
replace nt_nuts = 1 if legume_nuts_h == 1
replace nt_nuts = . if v469w == .
label var nt_nuts "Child given legumes or nuts in day/night before survey- last-born under 2 years"

// Given meat
gen nt_meat = 0
gen flesh_food_h = 1 if v469v >= 1 & v469v <=7
replace nt_meat = 1 if flesh_food_h
replace nt_meat = . if v469v == .

// Given eggs
gen nt_eggs = 0
replace nt_eggs=. if v469v == .
label var nt_eggs "Child given eggs in day/night before survey- last-born under 2 years"

// Given dairy
egen dairy_prod_amount = rowtotal(v469e v469f v469x), missing
label var dairy_prod_amount "Number of times child had dairy product"
gen nt_dairy = 0
gen dairy_products_h = 1 if v469h >= 1 & v469h <=7
replace nt_dairy = 1 if dairy_products_h == 1
replace nt_dairy = . if v469h == . & dairy_prod_amount == .
label var nt_dairy "Child given cheese, yogurt, or other milk products in day/night before survey- last-born under 2 years"

// Given other solid or semi-solid foods
gen nt_solids= nt_grains_tuber==1 | nt_vit==1 | nt_frtveg==1 | nt_nuts==1 |  nt_eggs==1 | nt_dairy==1 | nt_meat==1
label values nt_solids yesno 
label var nt_solids "Child given any solid or semisolid food in day/night before survey- last-born under 2 years"

// Fed milk or milk products
gen totmilkf = 0
replace totmilkf=totmilkf + v469e if v469e<8
replace totmilkf=totmilkf + v469f if v469f<8
replace totmilkf=totmilkf + v469x if v469x<8
gen nt_fed_milk= (totmilkf>=2 | m4==95) if inrange(age,6,23)
label var nt_fed_milk "Child given milk or milk products- last-born 6-23 months"

// Min dietary diversity

	* 8 food groups
	*1. breastmilk
	gen group1= m4==95

	*2. infant formula, milk other than breast milk, cheese or yogurt or other milk products
	gen group2= nt_formula==1 | nt_milk==1 | nt_dairy==1

	*3. foods made from grains, roots, tubers, and bananas/plantains, including porridge and fortified baby food from grains
	gen group3= nt_grains_tuber==1 
	 
	*4. vitamin A-rich fruits and vegetables
	gen group4= nt_vit==1

	*5. other fruits and vegetables
	gen group5= nt_frtveg==1

	*6. eggs
	gen group6= nt_eggs==1

	*7. legumes and nuts
	gen group7= nt_nuts==1
	
	*8. meat
	gen group8= nt_meat==1

// Min dietary diversity
egen foodsum = rsum(group1 group2 group3 group4 group5 group6 group7 group8) 
recode foodsum (1/4=0 "No") (5/8=1 "Yes"), gen(nt_mdd)
replace nt_mdd=. if age<6 | age >=24
label var nt_mdd "Child with minimum dietary diversity, 5 out of 8 food groups- last-born 6-23 months"

gen non_mdd = 1 if nt_mdd == 0 
replace non_mdd=0 if nt_mdd==1 
bys hhid : egen new_No_min_diet_diversity_hh = max(non_mdd) if non_mdd!=.
la var new_No_min_diet_diversity_hh "HH has at least one young child that is not fed with the min food diversity"

/*older surveys are 4 out of 7 food groups, can use code below
egen foodsum = rsum(group2 group3 group4 group5 group6 group7 group8) 
recode foodsum (1/3 .=0 "No") (4/7=1 "Yes"), gen(nt_mdd)
*/

// Min meal frequency
gen feedings=totmilkf
replace feedings= feedings + m39 if m39>0 & m39<8
gen nt_mmf = (m4==95 & inrange(m39,2,7) & inrange(age,6,8)) | (m4==95 & inrange(m39,3,7) & inrange(age,9,23)) | (m4!=95 & feedings>=4 & inrange(age,6,23))
replace nt_mmf=. if age<6 | age >=24
label var nt_mmf "Child with minimum meal frequency- last-born 6-23 months"

gen non_mmf =1 if nt_mmf==0 
replace non_mmf=0 if nt_mmf==1 
bys hhid : egen new_No_min_meal_freq_hh = max(non_mmf) if non_mmf!=.
la var new_No_min_meal_freq_hh "HH has at least one young child that is not fed min frequency"

// Min acceptable diet
egen foodsum2 = rsum(nt_grains nt_grains_tuber nt_nuts nt_meat nt_vit nt_frtveg nt_eggs)
gen nt_mad = (m4==95 & nt_mdd==1 & nt_mmf==1) | (m4!=95 & foodsum2>=4 & nt_mmf==1 & totmilkf>=2)
replace nt_mad=. if age<6 | age>=24
label values nt_mad yesno
label var nt_mad "Child with minimum acceptable diet- last-born 6-23 months"
 
gen non_mad =1 if nt_mad==0 
replace non_mad=0 if nt_mad==1 
bys hhid : egen new_No_min_acc_diet_hh = max(non_mad) if non_mad!=.
la var new_No_min_acc_diet_hh "HH has at least one young child that is not fed min acceptable diet"

count
sort hhid
collapse (max) nt_mmf nt_mdd new_No_min_diet_diversity_hh new_No_min_meal_freq_hh new_No_min_acc_diet_hh, by (hhid v001 v002)
*hh_young_ch

save "$datadir/cleaned/NEW_1_food_05.dta", replace


*********************************************************************************************************************************
* MERGING
*********************************************************************************************************************************

use "$datadir/ETPR51DT/ETPR51FL.dta", clear


keep hhid hv001 hv002 hv003 hv005 hv007 hv008 shintmg hv021 hv022 hv023 hv024 hv025 hv006 hv008 hv009  hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215 hv270  hv271 /* hv244 hv245 hv246 hv246a hv246c hv246d hv246e hv246f hv246g sh28k sh28m missing */ hv219 hv220 

*generate year variable
gen vg008=hv008+92
gen year=int((vg008-1)/12)
replace year=year+1900

gen month=shintmg

rename hv025 type_place 
rename hv024 region
gen v001 = hv001
gen v002 = hv002
gen v003 = hv003
sort v001 v002 v003

* ID
tostring v001 v002, g(v001s v002s)
rename hhid hhid_dhs
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s
order hhid

* Year

* Collapse
collapse hv003 hv005 hv007 hv021 hv022 hv023 hv006 hv008 hv009 type_place region hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215 year month hv270 hv271  /*hv244 hv245 hv246 hv246a hv246c hv246d hv246e hv246f hv246g  sh28k sh28m*/ hv219 hv220, by (hhid v001 v002)
sort hhid 

* Merging

merge 1:1 hhid v001 v002 using "$datadir/cleaned/HHwomen_05.dta"
drop _merge

merge 1:1 hhid v001 v002 using "$datadir/cleaned/HHmen_05.dta"
drop _merge

merge 1:1 hhid v001 v002 using "$datadir/cleaned/HH_counts_05.dta"
drop _merge

*merge 1:1 hhid v001 v002 using "$datadir/cleaned/food_05.dta"
*drop _merge

merge 1:1 hhid  v001 v002 using "$datadir/cleaned/NEW_1_food_05.dta"
drop _merge


order hhid year month 

*************************************************************************************************************************
* WEIGHTS
*************************************************************************************************************************

rename hv005 HH_wgt
gen wgt = HH_wgt/1000000

*************************************************************************************************************************
* LABELLING and DROPPING
*************************************************************************************************************************

label list
label values hv023 HV023
label values region HV024
label values type_place HV025
label values hv201 HV201
label values hv205 HV205
label values hv206 HV206
label values hv207 HV207
label values hv208 HV208
label values hv213 HV213
label values hv214 HV214
label values hv215 HV215
label values hv204 HV204
label values hv270 HV270
label values hv271 HV271

*label define sh28 ///
*0 "No" ///
*1 "Yes" 
*lab values sh28k sh28 
*lab values sh28m sh28 

label var hv001 "Cluster number"
label var hv002 "HH number"
label var hv003 "Respondent line number"
label var hv006 "Month of interview"
label var hv007 "Year of interview"
label var hv008 "Date interview"
label var hv009 "HH size"
label var HH_wgt "Weights DHS"
label var hv021 "Primary sampling unit"
label var hv022 "Sample struts number"
label var hv023 "Sample domain"
label var type_place "Type place of residence"
label var region "Region"
label var hv201 "Source of drinking water"
label var hv204 "Time to get water"
label var hv205 "Toilet facilities"
label var hv206 "Electricity dummy"
label var hv207 "Radio dummy"
label var hv208 "Television dummy"
label var hv213 "Main fllor material"
label var hv214 "Main wall material"
label var hv215 "Main roof material"
label var hv270 "Wealth Index"
label var hv219 "Sex head household"
rename hv270 wealth_index
label var hv271 "Wealth Index score"
rename hv271 wealth_index_score
*label var sh28k "Sheep"
*rename sh28k sheep
*label var sh28m "Poultry"
*rename sh28m poultry
lab var tot_wmen "Number of women in the HH"
lab var tot_wmen_ag "Number of women in agriculture"
lab var tot_wmen_serv "Number of women in the HH - service employment"
lab var tot_wmen_sales "Number of women in the HH - sales employment"
lab var tot_wmen_skman "Number of women in the HH - skilled manual employment"
lab var tot_wmen_un "Number of women in the HH - unemployment"
lab var tot_wmen_work "Number of women currently working in the HH"
lab var tot_wmen_work_hd "Women head(s) currently working in the HH"
lab var head_ag_wm "Female head in the HH - agriculture employment"
lab var head_serv_wm "Female head in the HH - services employment"
lab var head_sales_wm "Female head in the HH - sales employment"
lab var head_skman_wm "Female head in the HH - skilled manual employment"
lab var head_un_wm "Female head in the HH - unemployed"
lab var tot_wmen_noedu "Number of women in the HH - no education"
lab var tot_wmen_pri "Number of women in the HH - primary education"
lab var tot_wmen_sec "Number of women in the HH - secondary education"
lab var tot_wmen_high "Number of women in the HH - higher education"
lab var head_noedu_wm "Women head in the HH - no education"
lab var head_pri_wm "Women head in the HH - primary education"
lab var head_sec_wm "Women head in the HH - secondary education"
lab var head_high_wm "Women head in the HH - higher education"
lab var tot_RI_Low_w "Number of women in HH with low or very low Rohrer Index"
*lab var tot_BMI_low_w "Number of women in HH with BMI <16.9 (severe or moderately thin)"
*lab var hh_young_ch "Number of children younger than 24 months in the household"
*lab var No_min_diet_diversity_hh "HH has at least one young child that is not fed with the min food diversity" 
lab var stunting_c_hh "Number of stunted children in the HH"
lab var wasted_c_hh "Number of wasted children in the HH"
lab var underwht_ch_hh "Number of underweight children in the HH"
lab var tot_men_HH "Number of men in the HH"
lab var tot_wmen_HH "Number of women in the HH"
lab var tot_teen15 "Number of teen below 16 in the HH"
lab var tot_men "Number of men in the HH"
lab var tot_men_ag "Number of men in agriculture"
lab var tot_men_un "Number of men in the HH - unemployed"
lab var tot_men_serv "Number of men in the HH - services employment"
lab var tot_men_prof "Number of men in the HH - Professional jobs"
lab var tot_men_sales "Number of men in the HH - sales employment"
lab var tot_men_skman "Number of men in the HH - skilled manual employment"
lab var tot_men_work "Number of men currently working in the HH"
lab var tot_men_work_hd "Male head currently working in the HH"
lab var head_ag_m "Male head in the HH - agriculture employment"
lab var head_un_m "Male head in the HH - unemployed"
lab var head_prof_m "Male head in the HH - Professional"
lab var head_sales_m "Male head in the HH - sales employment"
lab var head_skman_m "Male head in the HH - skilled manual employment"
lab var head_serv_m "Male head in the HH - services employment"
lab var tot_men_noedu "Number of men in the HH - no education"
lab var tot_men_pri "Number of men in the HH - primary education"
lab var tot_men_sec "Number of men in the HH - secondary education"
lab var tot_men_high "Number of men in the HH - higher education"
lab var head_noedu_m "Male head in the HH - no education"
lab var head_pri_m "Male head in the HH - primary education"
lab var head_sec_m "Male head in the HH - secondary education"
lab var head_high_m "Male head in the HH - higher education"
lab var wgt "Weights - to use"
lab var head_prof_wm "Female head of the HH - professional employment"
lab var tot_wmen_Prof "Number of women in the HH - professional employment"

save "$datadir\cleaned\final_05.dta", replace





*********************************************************************************************************************************
* Individual records WOMEN -IR 2011
*********************************************************************************************************************************

global datadir  "E:\WORK ROMA\African Obsevatory\Ethiopia\DHS\Complete\2011" 
use "$datadir/ETIR61DT/ETIR61FL", clear
keep caseid v000 v001 v002 v003 v004 v005 v006 v007 v008 v042 v455 v457 v208 m45_1 m46_1 v213 b3_01 v012 v024 v025 v101 v102 v106 v107 v133 v131 v717 v714 v705 v719 v440 v444a v445 v446 v439 v150 v151 v152 v501
sort v001 v002 v003

*generate year variable
*gen vg008=v008+92
*gen year=int((vg008-1)/12)
*replace year=year+1900

*gen vg006=(vg008-12)*v007




* ID
tostring v001 v002,g (v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s v000
rename caseid hhid_dhs

* Number of women in the HH
bysort hhid: g n=_n
bysort hhid: egen tot_wmen=max(n)
sum tot_w
lab var tot_wm "Number of women in the HH"
drop n 

* Employment in agriculture
tab v717
replace v717=96 if v717==99
tab v717, g(occ)

bysort hhid: egen tot_wmen_ag=sum(occ5)

bysort hhid: egen tot_wmen_Prof=sum(occ2)
bysort hhid: egen tot_wmen_cler=sum(occ3)
bysort hhid: egen tot_wmen_sales=sum(occ4)
bysort hhid: egen tot_wmen_serv=sum(occ6)
bysort hhid: egen tot_wmen_skman=sum(occ7)
bysort hhid: egen tot_wmen_unskman=sum(occ8)
bysort hhid: egen tot_wmen_other=sum(occ9)
bysort hhid: egen tot_wmen_un=sum(occ1) 
lab var tot_wmen_Prof "Number of women in the HH - Professional jobs"
lab var tot_wmen_cler "Number of women in the HH - clerical employment"
lab var tot_wmen_sales "Number of women in the HH - sales employment"
lab var tot_wmen_serv "Number of women in the HH - services employment"
lab var tot_wmen_skman "Number of women in the HH - skilled manual employment"
lab var tot_wmen_unskman "Number of women in the HH - ubskilled manual employment"
lab var tot_wmen_un "Number of women in the HH - unemployment"


*Currently working
bysort hhid: egen tot_wmen_work=sum(v714)
bysort hhid: egen tot_wmen_work_hd=sum(v714) if v150==1


*HH head occupation 
bysort hhid: g x=1 if occ5==1 & v150==1
bysort hhid: egen head_ag_wm=max (x)
drop x

bysort hhid: g x=1 if occ2==1 & v150==1
bysort hhid: egen head_prof_wm=max (x)
drop x

bysort hhid: g x=1 if occ3==1 & v150==1
bysort hhid: egen head_cler_wm=max (x)
drop x

bysort hhid: g x=1 if occ4==1 & v150==1
bysort hhid: egen head_sales_wm=max (x)
drop x

bysort hhid: g x=1 if occ6==1 & v150==1
bysort hhid: egen head_serv_wm=max (x)
drop x

bysort hhid: g x=1 if occ7==1 & v150==1
bysort hhid: egen head_skman_wm=max (x)
drop x

bysort hhid: g x=1 if occ8==1 & v150==1
bysort hhid: egen head_unskman_wm=max (x)
drop x

bysort hhid: g x=1 if occ9==1 & v150==1
bysort hhid: egen head_other_wm=max (x)
drop x

bysort hhid: g x=1 if occ1==1 & v150==1
bysort hhid: egen head_un_wm=max (x)
drop x

lab var tot_wmen_work "Number of women currently working in the HH"
lab var tot_wmen_work_hd "Women head(s) currently working in the HH"
lab var head_ag_wm "Female head in the HH - agriculture"
lab var head_prof_wm "Female head in the HH - Professional"
lab var head_un_wm "Female head in the HH - domestic employed"
lab var head_cler_wm "Female head in the HH - clerical employment"
lab var head_sales_wm "Female head in the HH - sales employment"
lab var head_serv_wm "Female head in the HH - services employment"
lab var head_skman_wm "Female head in the HH - skilled manual employment"
lab var head_unskman_wm "Female head in the HH - unskilled manual employment"




* Education
tab v106, g(edu)
bysort hhid: egen tot_wmen_noedu=sum(edu1)
bysort hhid: egen tot_wmen_pri=sum(edu2)
bysort hhid: egen tot_wmen_sec=sum(edu3)
bysort hhid: egen tot_wmen_high=sum(edu4)

* Head 
bysort hhid: g x=1 if edu1==1 & v150==1
bysort hhid: egen head_noedu_wm=max (x)
drop x

bysort hhid: g x=1 if edu2==1 & v150==1
bysort hhid: egen head_pri_wm=max (x)
drop x

bysort hhid: g x=1 if edu3==1 & v150==1
bysort hhid: egen head_sec_wm=max (x)
drop x

bysort hhid: g x=1 if edu4==1 & v150==1
bysort hhid: egen head_high_wm=max (x)
drop x

lab var tot_wmen_noedu "Number of women in the HH - no education"
lab var tot_wmen_pri "Number of women in the HH - primary education"
lab var tot_wmen_sec "Number of women in the HH - secondary education"
lab var tot_wmen_high "Number of women in the HH - higher education"
lab var head_noedu_wm "Female head in the HH - no education"
lab var head_pri_wm "Female head in the HH - primary education"
lab var head_sec_wm "Female head in the HH - secondary education"
lab var head_high_wm "Female head in the HH - higher education"

* Ethnicity
* Two major ethnic groups: Wolof and Poular = 1 versus others =0 

* Ethnicity
tab v131
tab v131, g(ethn)

* Head 
bysort hhid: g x=1 if ethn1==1 & v150==1
bysort hhid: egen head_affar_wm=max (x)
drop x

bysort hhid: g x=1 if ethn5==1 & v150==1
bysort hhid: egen head_amharra_wm=max (x)
drop x

bysort hhid: g x=1 if ethn22==1 & v150==1
bysort hhid: egen head_guragie_wm=max (x)
drop x

bysort hhid: g x=1 if ethn41==1 & v150==1
bysort hhid: egen head_oromo_wm=max (x)
drop x

bysort hhid: g x=1 if ethn46==1 & v150==1
bysort hhid: egen head_sidama_wm=max (x)
drop x

bysort hhid: g x=1 if ethn48==1 & v150==1
bysort hhid: egen head_somalie_wm=max (x)
drop x

bysort hhid: g x=1 if ethn49==1 & v150==1
bysort hhid: egen head_tigray_wm=max (x)
drop x

bysort hhid: g x=1 if ethn51==1 & v150==1
bysort hhid: egen head_welaita_wm=max (x)
drop x


bysort hhid: g x=1 if v150==1 &	head_welaita_wm!=1 & head_tigray_wm!=1 & head_somalie_wm!=1 & head_sidama_wm!=1 & head_oromo_wm!=1 & head_guragie_wm!=1 ///
                              &	head_amharra_wm!=1 & head_affar_wm!=1 
bysort hhid: egen head_other_ethn_wm=max (x)
drop x


// Anthropometry indicators

* Age of most recent child
gen age = v008 - b3_01
	
* To check if survey has b19, which should be used instead to compute age

scalar b19_included=1
capture confirm numeric variable b19_01, exact 
		if _rc>0 {
		* b19 is not present
        scalar b19_included=0
		}
		
		if _rc==0 {
		* b19 is present; check for values
		summarize b19_01
		if r(sd)==0 | r(sd)==. {
		scalar b19_included=0
		  }
		}

	    if b19_included==1 {
	    drop age
	    gen age=b19_01
	    }


// Rohrer index (RI) ie Index  of Corpulence - NON PREGNANT-POST PARTUM WOMEN

// The range variation of RI (According to Pignet, cited in Bhasin and Singh, 2004) is also mentioned in this study: Rohrer Index=(Body weight (gm)/Stature 3 (cm)) × 100 //
/*
• Very low ≤ 1.12

• Low (1.13-1.19)

• Middle (1.20-1.25)

• Upper middle (1.26-1.32)

• High (1.33-1.39)

• Very high=1.40

• Healthy range 1.2-1.6
*/

* Replace missing
sum v446
codebook v446
tab v446, nolabel
tab v445
foreach var of varlist v445 v446 {
replace `var' =. if `var'==9998 | `var'==9999
}

* RI creation
g RI_Low_w=1 if v446<=1190 //RI for low and very low//
replace RI_Low_w=0 if v446>1190
replace RI_Low_w= . if (v446==.| v213==1 | age<2)
lab var RI_Low_w "Rohrer Index - low or very low - women"
br v446 RI_Low_w
label define RI_Low_w 1 "Low or Very low Rohrer's Index" 0 "High Rohrer Index"
label values RI_Low_w RI_Low_w
br v446 RI_Low_w
tab RI_Low_w
bysort hhid: egen tot_RI_Low_w=total(RI_Low_w), missing
br tot_RI_Low_w hhid RI_Low_w
sum tot_RI_Low_w
lab var tot_RI_Low_w "Number of women in HH with low or very low Rohrer Index"

// BMI - NON PREGNANT-POST PARTUM WOMEN

/* https://dhsprogram.com/pubs/pdf/MR6/MR6.pdf
With standard terminology for this
measure, if the BMI is less than 16.0, the woman is ―severely thin;‖ if 16.0 to 16.9, she is ―moderately
thin;‖ if 17.0 to 18.4, she is ―mildly thin.‖ The entire range below 18.5 is ―thin.‖ If the BMI is 25.0 to
29.9, the woman is ―overweight;‖ if 30.0 or higher, she is ―obese.‖ For example, if v437 = 400 (40.0 kg)
and v438 = 1500 (1.500 meters) then v445 = 1778, the BMI is 17.78, and the woman is ―mildly thin.‖
For the ―malnourished‖ woman described in the last paragraph of section 4.2.2, with a weight of 35.1 kg
and a height of 1.500 meters, the BMI is 15.6, so she is ―severely thin.‖
*/

/* The DHS Guide to Statistics offers the following guidelines for interpreting BMI scores for women age 15-49:
 Severely thin: less than 16.0
Moderately thin: 16.0 to 16.9
Mildly thin: 17.0 to 18.4
Normal: 18.5 to 24.9
Overweight: 25.0 to 29.9
Obese: 30.0 or more*/

* BMI - Moderately or severely thin DHS
gen nt_wm_modsevthin= inrange(v445,1200,1699) if inrange(v445,1200,6000)
replace nt_wm_modsevthin=. if (v213==1 | age<2)
label values nt_wm_modsevthin yesno
label var nt_wm_modsevthin "Moderately and severely thin BMI - women"
bysort hhid: egen DHS_tot_BMI_low_w=total(nt_wm_modsevthin), missing 
lab var DHS_tot_BMI_low_w "Number of women in HH with BMI <16.9 (severe or moderately thin)"

/*
// TOOK IRON supplements during last pregnancy
gen nt_wm_micro_iron= .
replace nt_wm_micro_iron=0 if m45_1==0
replace nt_wm_micro_iron=1 if inrange(m46_1,0,59)
replace nt_wm_micro_iron=2 if inrange(m46_1,60,89)
replace nt_wm_micro_iron=3 if inrange(m46_1,90,300)
replace nt_wm_micro_iron=4 if m45_1==8 | m45_1==9 | m46_1==998 | m46_1==999
replace nt_wm_micro_iron= . if v208==0
label define nt_wm_micro_iron 0"None" 1"<60" 2"60-89" 3"90+" 4"Don't know/missing"
label values nt_wm_micro_iron nt_wm_micro_iron
label var nt_wm_micro_iron "Number of days women took iron supplements during last pregnancy"
*/

// SEVERE ANEMIA
gen nt_wm_sev_anem=0 if v042==1 & v455==0
replace nt_wm_sev_anem=1 if v457==1 | v457==2
label values nt_wm_sev_anem yesno
label var nt_wm_sev_anem "Severe and Moderate anemia - women"
bysort hhid: egen sev_mod_anemia_hh=total(nt_wm_sev_anem), missing 
lab var sev_mod_anemia_hh "Number of women in HH with severe-moderate anemia"


* Collapsing at HH level
sum  v001 v002
collapse tot_wmen* head* RI_Low_w tot_RI_Low_w nt_wm_modsevthin DHS_tot_BMI_low_w sev_mod_anemia_hh  , by (hhid v001 v002)
sum
order hhid v001 v002
sort hhid 

save "$datadir/cleaned/HHwomen_11.dta", replace

*********************************************************************************************************************************
* Individual records MEN 
*********************************************************************************************************************************

use "$datadir\ETMR61DT\ETMR61FL.dta", clear
keep mcaseid mv000 mv001 mv002 mv003 mv004 mv005 mv006 mv007 mv012 mv024 mv025 mv101 mv102 mv106 mv107 mv133 mv131 mv717 mv714   mv150 mv151 mv152 mv501
gen v001 = mv001
gen v002 = mv002
gen v003 = mv003
sort v001 v002 v003

* ID
tostring mv001 mv002,g (mv001s mv002s)
g hhid=mv001s+mv002s
replace hhid =mv001s+"0"+mv002s if mv002<10
order hhid 
destring hhid, replace
drop mv001s mv002s

* Gen person id without spaces
/* tostring mv001 mv002 mv003,g (mv001s mv002s mv003s)
g mid=mv001s+mv002s+mv003s
replace mid =mv001s+"0"+mv002s+mv003s if mv002<10
replace mid =mv001s+mv002s+"0"+mv003s if mv003<10
order hhid mid
destring mid, replace
drop mv001s mv002s mv003s*/ // not necessary

* Number of men in the HH
bysort hhid: g n=_n
bysort hhid: egen tot_men=max(n)
sum tot_m
lab var tot_m "Number of men in the HH"
drop n 

*Employment in agriculture
tab mv717
tab mv717, g(occ)
bysort hhid: egen tot_men_ag=sum(occ5)
sum tot_men_ag
lab var tot_men_ag "Number of men in agriculture"

*Other occupations
bysort hhid: egen tot_men_un=sum(occ1)
bysort hhid: egen tot_men_prof=sum(occ2)
bysort hhid: egen tot_men_cler=sum(occ3)
bysort hhid: egen tot_men_sales=sum(occ4)
bysort hhid: egen tot_men_serv=sum(occ6)
bysort hhid: egen tot_men_skman=sum(occ7)
bysort hhid: egen tot_men_unskman=sum(occ8)
bysort hhid: egen tot_men_other=sum(occ9)

lab var tot_men_un "Number of men in the HH - unemployed"
lab var tot_men_prof "Number of men in the HH - Professional jobs"
lab var tot_men_cler "Number of men in the HH - clerical employment"
lab var tot_men_sales "Number of men in the HH - sales employment"
lab var tot_men_serv "Number of men in the HH - services employment"
lab var tot_men_skman "Number of men in the HH - skilled manual employment"
lab var tot_men_unskman "Number of men in the HH - ubskilled manual employment"
lab var tot_men_other "Number of men in other employment"

*Currently working
bysort hhid: egen tot_men_work=sum(mv714)
bysort hhid: egen tot_men_work_hd=sum(mv714) if mv150==1


*HH head occupation 
bysort hhid: g x=1 if occ5==1 & mv150==1
bysort hhid: egen head_ag_m=max (x)
drop x

bysort hhid: g x=1 if occ1==1 & mv150==1
bysort hhid: egen head_un_m=max (x)
drop x

bysort hhid: g x=1 if occ2==1 & mv150==1
bysort hhid: egen head_prof_m=max (x)
drop x

bysort hhid: g x=1 if occ3==1 & mv150==1
bysort hhid: egen head_cler_m=max (x)
drop x

bysort hhid: g x=1 if occ4==1 & mv150==1
bysort hhid: egen head_sales_m=max (x)
drop x

bysort hhid: g x=1 if occ6==1 & mv150==1
bysort hhid: egen head_serv_m=max (x)
drop x

bysort hhid: g x=1 if occ7==1 & mv150==1
bysort hhid: egen head_skman_m=max (x)
drop x

bysort hhid: g x=1 if occ8==1 & mv150==1
bysort hhid: egen head_unskman_m=max (x)
drop x

bysort hhid: g x=1 if occ9==1 & mv150==1
bysort hhid: egen head_other_m=max (x)
drop x

lab var tot_men_work "Number of men currently working in the HH"
lab var tot_men_work_hd "men head(s) currently working in the HH"
lab var head_ag_m "Male head in the HH - agriculture"
lab var head_un_m "Male head in the HH - unemployed"
lab var head_prof_m "Male head in the HH - Professional"
lab var head_cler_m "Male head in the HH - clerical employment"
lab var head_sales_m "Male head in the HH - sales employment"
lab var head_serv_m "Male head in the HH - services employment"
lab var head_skman_m "Male head in the HH - skilled manual employment"
lab var head_unskman_m "Male head in the HH - unskilled manual employment"
lab var head_other_m "Male head in other employment"

* Education
tab mv106, g(edu)
bysort hhid: egen tot_men_noedu=sum(edu1)
bysort hhid: egen tot_men_pri=sum(edu2)
bysort hhid: egen tot_men_sec=sum(edu3)
bysort hhid: egen tot_men_high=sum(edu4)

lab var tot_men_noedu "Number of men in the HH - no education"
lab var tot_men_pri "Number of men in the HH - primary education"
lab var tot_men_sec "Number of men in the HH - secondary education"
lab var tot_men_high "Number of men in the HH - higher education"

* Head - Education
bysort hhid: g x=1 if edu1==1 & mv150==1
bysort hhid: egen head_noedu_m=max (x)
drop x

bysort hhid: g x=1 if edu2==1 & mv150==1
bysort hhid: egen head_pri_m=max (x)
drop x

bysort hhid: g x=1 if edu3==1 & mv150==1
bysort hhid: egen head_sec_m=max (x)
drop x

bysort hhid: g x=1 if edu4==1 & mv150==1
bysort hhid: egen head_high_m=max (x)
drop x

lab var head_noedu_m "Male head in the HH - no education"
lab var head_pri_m "Male head in the HH - primary education"
lab var head_sec_m "Male head in the HH - secondary education"
lab var head_high_m "Male head in the HH - higher education"

* Ethnicity
* Two major ethnic groups: Wolof and Poular = 1 versus others =0 


* Head 
* Ethnicity
tab mv131
tab mv131, g(ethn)

* Head 
bysort hhid: g x=1 if ethn1==1 & mv150==1
bysort hhid: egen head_affar_m=max (x)
drop x

bysort hhid: g x=1 if ethn5==1 & mv150==1
bysort hhid: egen head_amharra_m=max (x)
drop x

bysort hhid: g x=1 if ethn23==1 & mv150==1
bysort hhid: egen head_guragie_m=max (x)
drop x

bysort hhid: g x=1 if ethn40==1 & mv150==1
bysort hhid: egen head_oromo_m=max (x)
drop x

bysort hhid: g x=1 if ethn45==1 & mv150==1
bysort hhid: egen head_sidama_m=max (x)
drop x

bysort hhid: g x=1 if ethn47==1 & mv150==1
bysort hhid: egen head_somalie_m=max (x)
drop x

bysort hhid: g x=1 if ethn48==1 & mv150==1
bysort hhid: egen head_tigray_m=max (x)
drop x

bysort hhid: g x=1 if ethn50==1 & mv150==1
bysort hhid: egen head_welaita_m=max (x)
drop x

 
bysort hhid: g x=1 if mv150==1 &	head_welaita_m!=1 & head_tigray_m!=1 & head_somalie_m!=1 & head_sidama_m!=1 & head_oromo_m!=1  ///
                              & head_guragie_m!=1 &	head_amharra_m!=1 & head_affar_m!=1 
bysort hhid: egen head_other_ethn_m=max (x)
drop x

/*
* Urban rural
tab mv102
tab mv102, nol
g rural=1 if mv102==2
tab rural
replace rural=0 if rural==.
tab rural

bysort hhid: egen tot_men_rural=sum(rural)
sum tot_men_rural

bysort hhid: g x=1 if rural==1 & mv150==1
bysort hhid: egen head_rural=max (x)
drop x

lab var head_rural "Male head in the HH - in rural"
lab var tot_men_rural "Number of men in rural area"
*/

* Collapsing at HH level
sum  mv001 mv002
collapse tot_men*  head*  , by (hhid mv001 mv002)
rename mv001 v001
rename mv002 v002
sum
/*
foreach var of varlist tot_men_work_hd head_ag_s_m head_ag_w_m head_un_m head_serv_m head_prof_m head_dom_m head_cler_m head_sales_m head_skman_m head_unskman_m head_noedu_m head_pri_m head_sec_m head_high_m   {
replace `var'=0 if `var'==.
}
sum
*/
order hhid v001 v002

save "$datadir/cleaned/HHmen_11.dta", replace

*********************************************************************************************************************************
* Household members - PR for FOOD SECURITY
*********************************************************************************************************************************

use "$datadir/ETPR61DT/ETPR61FL.dta", clear
keep hhid hvidx hv001 hv002 hv003 hv004 hv005 hv007 hv021 hv022 hv023 hv024 hv025  hv101 hv103 hv104 hv105 hv106 hv107  hc70 hc71 hc72 hc73 hv270 hv271  hc57 hv006 hv007 hv008 hv009 hv220 hv219 hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215 hv247 ha5 ha11 hc1 hc56
gen v001 = hv001
gen v002 = hv002
gen v003 = hv003
sort v001 v002 v003

* ID
rename hhid hhid_dhs
tostring v001 v002,g (v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s

* STUNTING
tab hc70, nolabel
tab hc71, nolabel
tab hc72, nolabel

foreach var of varlist hc70 hc71 hc72 {
replace `var' =. if `var'==9998 |`var'==9996 | `var'==9997 |`var'==9999
}

tab hc70
gen stunted_ch = 1 if hc70<=-200
replace stunted_ch=0 if hc70>-200
replace stunted_ch= . if hc70==.
tab stunted_ch
* count if hc70 <-200
bysort hhid: egen stunting_c_hh=total(stunted_ch), missing 
lab var stunting_c_hh "Number of stunted children in the HH"

* WASTING
gen wasted_ch = 1 if hc72<=-200
replace wasted_ch=0 if hc72>-200
replace wasted_ch = . if hc72==.
tab wasted_ch
* count if hc72 <-200
bysort hhid: egen wasted_c_hh=total(wasted_ch) , missing
lab var wasted_c_hh "Number of wasted children in the HH"


* UNDERWWEIGHT
gen underwht_ch = 1 if hc71<=-200
replace underwht_ch=0 if hc71>-200
replace underwht_ch = . if hc71==.
tab underwht_ch
bysort hhid: egen underwht_ch_hh=total(underwht_ch) , missing
lab var underwht_ch_hh "Number of underweighted children in the HH"
tab underwht_ch_hh
* count if hc71 <-200
sum *c_hh 

* MODERATE AND SEVERE ANEMIA AMONG CHILDREN
gen nt_ch_sev_anem=0 if hc1>5 & hc1<60
replace nt_ch_sev_anem=1 if hc56<100 & hc1>5 & hc1<60
replace nt_ch_sev_anem=. if hc56==.
label values nt_ch_sev_anem yesno
label var nt_ch_sev_anem "Moderate/severe anemia - child 6-59 months"
bysort hhid: egen anemia_ch_hh=total(nt_ch_sev_anem), missing 
label var anemia_ch_hh "Moderate/severe anemia HH - child 6-59 months"

* Sex
tab hv104, g(sex)
bysort hhid: egen tot_men_HH=total(sex1)
bysort hhid: egen tot_wmen_HH=total(sex2)
lab var tot_men_HH "Number of men in the HH"
lab var tot_wmen_HH "Number of women in the HH"
bysort hhid:egen tot_teen15=total(hv105<16)
lab var tot_teen15 "Number of teen below 16 in the HH"

* Head educational level 
gen head_no_edu = 1 if hv101==1 & hv106==0
replace head_no_edu=0 if head_no_edu==.
gen head_primary = 1 if hv101==1 & hv106==1
replace head_primary=0 if head_primary==.
gen head_secondary = 1 if hv101==1 & hv106==2
replace head_secondary = 0 if head_secondary==.
gen head_higher=1 if hv101==1 & hv106==3
replace head_higher=0 if head_higher==.

bysort hhid: egen hh_head_no_edu =total(head_no_edu), missing
bysort hhid: egen hh_head_primary =total(head_primary), missing
bysort hhid: egen hh_head_secondary =total(head_secondary), missing
bysort hhid: egen hh_head_higher =total(head_higher), missing

* Collapsing at HH level 
collapse  v003 hv247 hv001 hv002 hv003 hv009 tot_men_HH tot_wmen_HH tot_teen15 stunted_ch stunting_c_hh wasted_ch wasted_c_hh underwht_ch underwht_ch_hh hh_head_no_edu hh_head_primary hh_head_secondary hh_head_higher anemia_ch_hh nt_ch_sev_anem, by(hhid v001 v002)
sort hhid

save "$datadir/cleaned/HH_counts_11.dta", replace

*********************************************************************************************************************************
* Children data for FOOD DIVERSITY AND FREQUENCY
*********************************************************************************************************************************
*********************************************************************************************************************************
use "$datadir/ETKR61DT/ETKR61FL.dta", clear

// Child's age 

gen age = v008 - b3
keep if _n == 1 | caseid != caseid[_n-1]

/*		
* To check if survey has b19, which should be used instead to compute age. 
scalar b19_included=1
capture confirm numeric variable b19, exact 
		if _rc>0 {
	    * b19 is not present
		scalar b19_included=0
		}
		if _rc==0 {
		* b19 is present; check for values
		summarize b19
		if r(sd)==0 | r(sd)==. {
		scalar b19_included=0
			  }
			}

		if b19_included==1 {
		drop age
		gen age=b19
		}
*/
	
* HHID
tostring v001 v002, g(v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s
order hhid

// Given formula
gen nt_formula= v411a==1
label values nt_formula yesno
label var nt_formula "Child given infant formula in day/night before survey - last-born under 2 years"

// Give fortified baby food
gen nt_bbyfood= v412a==1
label values nt_bbyfood yesno 
label var nt_bbyfood "Child given fortified baby food in day/night before survey- last-born under 2 years"

// Given other milk
gen nt_milk= v411==1
label values nt_milk yesno 
label var nt_milk "Child given other milk in day/night before survey- last-born under 2 years"

// Given grains
gen nt_grains_tuber = v412a==1 | v414e==1 | v414f==1
label values nt_grains_tuber yesno 
label var nt_grains_tuber "Child given grains in day/night before survey- last-born under 2 years"

// Given Vit rich foods
gen nt_vit = v414i==1 | v414j==1 | v414k==1
label values nt_vit yesno 
label var nt_vit "Child given vitamin A rich food in day/night before survey- last-born under 2 years"

// Given other fruits or vegetables
gen nt_frtveg = v414l==1
label values nt_frtveg yesno 
label var nt_frtveg "Child given other fruits or vegetables in day/night before survey- last-born under 2 years"

// Given nuts or legumes
gen nt_nuts = v414o==1
label values nt_nuts yesno 
label var nt_nuts "Child given legumes or nuts in day/night before survey- last-born under 2 years"

// Given meat
gen nt_meat = v414h==1 | v414m==1 | v414n==1
label values nt_meat yesno 
label var nt_meat "Child given meat, fish, shellfish, or poultry in day/night before survey- last-born under 2 years"

// Given eggs
gen nt_eggs = v414g==1
label values nt_eggs yesno 
label var nt_eggs "Child given eggs in day/night before survey- last-born under 2 years"

// Given dairy
gen nt_dairy = v414p==1 | v411==1 | v411a==1
label values nt_dairy yesno 
label var nt_dairy "Child given cheese, yogurt, or other milk products in day/night before survey- last-born under 2 years"

// Given other solid or semi-solid foods
gen nt_solids= nt_bbyfood==1 | nt_grains_tuber==1 | nt_vit==1 | nt_frtveg==1 | nt_nuts==1 |  nt_eggs==1 | nt_dairy==1 | nt_meat==1
label values nt_solids yesno 
label var nt_solids "Child given any solid or semisolid food in day/night before survey- last-born under 2 years"

// Fed milk or milk products
gen totmilkf = 0
replace totmilkf=totmilkf + v411 if v411==1
replace totmilkf=totmilkf + v411a if v411a==1
replace totmilkf=totmilkf + v414p if v414p==1
gen nt_fed_milk= ( totmilkf>=2 | m4==95) if inrange(age,6,23)
label values nt_fed_milk yesno
label var nt_fed_milk "Child given milk or milk products- last-born 6-23 months"

// Min dietary diversity

	* 8 food groups
	*1. breastmilk
	gen group1= m4==95

	*2. infant formula, milk other than breast milk, cheese or yogurt or other milk products
	gen group2= nt_formula==1 | nt_milk==1 | nt_dairy==1

	*3. foods made from grains, roots, tubers, and bananas/plantains, including porridge and fortified baby food from grains
	gen group3= nt_grains_tuber==1 
	 
	*4. vitamin A-rich fruits and vegetables
	gen group4= nt_vit==1

	*5. other fruits and vegetables
	gen group5= nt_frtveg==1

	*6. eggs
	gen group6= nt_eggs==1

	*7. legumes and nuts
	gen group7= nt_nuts==1
	
	*8. meat
	gen group8= nt_meat==1

// Min dietary diversity
egen foodsum = rsum(group1 group2 group3 group4 group5 group6 group7 group8) 
recode foodsum (1/4 =0 "No") (5/8=1 "Yes"), gen(nt_mdd)
replace nt_mdd=. if age<6 | age>=24
label var nt_mdd "Child with minimum dietary diversity, 5 out of 8 food groups- last-born 6-23 months"

gen non_mdd =1 if nt_mdd==0 
replace non_mdd=0 if nt_mdd==1 
bys hhid : egen new_No_min_diet_diversity_hh = max(non_mdd) if non_mdd!=.
la var new_No_min_diet_diversity_hh "HH has at least one young child that is not fed with the min food diversity"

/*older surveys are 4 out of 7 food groups, can use code below
egen foodsum = rsum(group2 group3 group4 group5 group6 group7 group8) 
recode foodsum (1/3 .=0 "No") (4/7=1 "Yes"), gen(nt_mdd)
*/

// Min meal frequency
gen feedings=totmilkf
replace feedings= feedings + m39 if m39>0 & m39<8
gen nt_mmf = (m4==95 & inrange(m39,2,7) & inrange(age,6,8)) | (m4==95 & inrange(m39,3,7) & inrange(age,9,23)) | (m4!=95 & feedings>=4 & inrange(age,6,23))
replace nt_mmf=. if age<6 | age>=24
label var nt_mmf "Child with minimum meal frequency- last-born 6-23 months"

gen non_mmf =1 if nt_mmf==0 
replace non_mmf=0 if nt_mmf==1 
bys hhid : egen new_No_min_meal_freq_hh = max(non_mmf) if non_mmf!=.
la var new_No_min_meal_freq_hh "HH has at least one young child that is not fed min frequency"

// Min acceptable diet
egen foodsum2 = rsum(nt_grains nt_grains_tuber nt_nuts nt_meat nt_vit nt_frtveg nt_eggs)
gen nt_mad = (m4==95 & nt_mdd==1 & nt_mmf==1) | (m4!=95 & foodsum2>=4 & nt_mmf==1 & totmilkf>=2)
replace nt_mad=. if age<6 | age>=24
label values nt_mad yesno
label var nt_mad "Child with minimum acceptable diet- last-born 6-23 months"
 
gen non_mad =1 if nt_mad==0 
replace non_mad=0 if nt_mad==1 
bys hhid : egen new_No_min_acc_diet_hh = max(non_mad) if non_mad!=.
la var new_No_min_acc_diet_hh "HH has at least one young child that is not fed min acceptable diet"

count
sort hhid
collapse (max) nt_mmf nt_mdd new_No_min_diet_diversity_hh new_No_min_meal_freq_hh new_No_min_acc_diet_hh, by (hhid v001 v002)
*hh_young_ch

save "$datadir/cleaned/NEW_1_food_11.dta", replace

*********************************************************************************************************************************
* MERGING
*********************************************************************************************************************************

use "$datadir/ETPR61DT/ETPR61FL.dta", clear
keep hhid hv001 hv002 hv003 hv005 hv007 hv016 hv021 hv022 hv023 hv024 hv025 hv006 hv008 hv009  hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215 hv270  hv271  hv244 hv245 hv246 hv246a hv246c hv246d hv246e hv246f hv246g hv219 hv220



gen month = .
gen year = .

replace year = 2010 if hv007==2003 & hv006==4 & hv016<23
replace month= 12 if hv007==2003 & hv006==4 & hv016<23

replace year = 2011 if hv007==2003 & hv006==4 & hv016>=23
replace month= 1 if hv007==2003 & hv006==4 & hv016>=23

replace year = 2011 if hv007==2003 & hv006==5 & hv016<24
replace month= 1 if hv007==2003 & hv006==5 & hv016<24

replace year = 2011 if hv007==2003 & hv006==5 & hv016>=24
replace month= 2 if hv007==2003 & hv006==5 & hv016>=24

replace year = 2011 if hv007==2003 & hv006==6 & hv016 <22
replace month= 2 if hv007==2003 & hv006==6 & hv016<22

replace year = 2011 if hv007==2003 & hv006==6 & hv016 >=22
replace month= 3 if hv007==2003 & hv006==6 & hv016 >=22

replace year = 2011 if hv007==2003 & hv006==7 & hv016 <23
replace month= 3 if hv007==2003 & hv006==7 & hv016 <23

replace year = 2011 if hv007==2003 & hv006==7 & hv016 >=23
replace month= 4 if hv007==2003 & hv006==7 & hv016 >=23


replace year = 2011 if hv007==2003 & hv006==8 & hv016 <23
replace month= 4 if hv007==2003 & hv006==8 & hv016 <23

replace year = 2011 if hv007==2003 & hv006==8 & hv016 >=23
replace month= 5 if hv007==2003 & hv006==8 & hv016 >=23


replace year = 2011 if hv007==2003 & hv006==9 & hv016 <24
replace month= 5 if hv007==2003 & hv006==9 & hv016 <24

replace year = 2011 if hv007==2003 & hv006==9 & hv016 >=24
replace month= 6 if hv007==2003 & hv006==9 & hv016 >=24





rename hv025 type_place 
rename hv024 region
gen v001 = hv001
gen v002 = hv002
gen v003 = hv003
sort v001 v002 v003

* ID
tostring v001 v002, g(v001s v002s)
rename hhid hhid_dhs
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s
order hhid

* Year

* Collapse
collapse hv003 hv005 year month hv021 hv022 hv023 hv006 hv008 hv009 type_place region hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215  hv270 hv271 hv244 hv245 hv246 hv246a hv246c hv246d hv246e hv246f hv246g hv219 hv220, by (hhid v001 v002 )
sort hhid 

* Merging

merge 1:1 hhid v001 v002 using "$datadir/cleaned/HHwomen_11.dta"
drop _merge

merge 1:1 hhid v001 v002 using "$datadir/cleaned/HHmen_11.dta"
drop _merge

merge 1:1 hhid v001 v002 using "$datadir/cleaned/HH_counts_11.dta"
drop _merge

*merge 1:1 hhid v001 v002 using "$datadir/food_10.dta"
*drop _merge

merge 1:1 hhid v001 v002 using "$datadir/cleaned/NEW_1_food_11.dta"
drop _merge

order hhid year month
drop v001 v002 v003

*************************************************************************************************************************
* WEIGHTS
*************************************************************************************************************************

rename hv005 HH_wgt
gen wgt = HH_wgt/1000000

*************************************************************************************************************************
* LABELLING and DROPPING
*************************************************************************************************************************

label list
label values hv023 HV023
label values region HV024
label values type_place HV025
label values hv201 HV201
label values hv205 HV205
label values hv206 HV206
label values hv207 HV207
label values hv208 HV208
label values hv213 HV213
label values hv214 HV214
label values hv215 HV215
label values hv204 HV204
label values hv270 HV270
label values hv271 HV271
label values hv244 HV244 
label values hv245 HV245 
label values hv246 HV246 
label values hv246a HV246A 
label values hv246c HV246C 
label values hv246d HV246D 
label values hv246e HV246E 
label values hv246f HV246F 
label values hv246g HV246G 
label values hv219 HV219
label var hv001 "Cluster number"
label var hv002 "HH number"
label var hv003 "Respondent line number"
*label var hv006 "Month of interview"
*label var hv007 "Year of interview"
label var hv008 "Date interview"
label var hv009 "HH size"
label var HH_wgt "Weights DHS"
label var hv021 "Primary sampling unit"
label var hv022 "Sample struts number"
label var hv023 "Sample domain"
label var type_place "Type place of residence"
label var region "Region"
label var hv201 "Source of drinking water"
label var hv204 "Time to get water"
label var hv205 "Toilet facilities"
label var hv206 "Electricity dummy"
label var hv207 "Radio dummy"
label var hv208 "Television dummy"
label var hv213 "Main fllor material"
label var hv214 "Main wall material"
label var hv215 "Main roof material"
label var hv270 "Wealth Index"
label var hv219 "Sex head household"
rename hv270 wealth_index
label var hv271 "Wealth Index score"
rename hv271 wealth_index_score
label var hv244 "Owns agricultural land"
rename hv244 dummy_agr_land
label var hv245 "Hectares agricultural land"
rename hv245 hectares_acres_ag_land
label var hv246 "Livestock, herds and farm animals"
rename hv246 livestock
label var hv246a "Cattle"
rename hv246a cattle
label var hv246c "Horses,mules"
rename hv246c horses_mules
label var hv246d "Goats"
rename hv246d goats
label var hv246e "Sheep"
rename hv246e sheep
label var hv246f "Poultry"
rename hv246f poultry
label var hv246g "Rabbits"
rename hv246g rabbits
lab var tot_wmen "Number of women in the HH"
lab var tot_wmen_ag "Number of women in agriculture"
lab var tot_wmen_Prof "Number of women in the HH - professional jobs"
lab var tot_wmen_serv "Number of women in the HH - service employment"
lab var tot_wmen_cler "Number of women in the HH - clerical employment"
lab var tot_wmen_other "Number of women in the HH - other employment"
lab var tot_wmen_skman "Number of women in the HH - skilled manual employment"
lab var tot_wmen_unskman "Number of women in the HH - unskilled manual employment"
lab var tot_wmen_un "Number of women in the HH - unemployment"
lab var tot_wmen_work "Number of women currently working in the HH"
lab var tot_wmen_work_hd "Women head(s) currently working in the HH"
lab var head_ag_wm "Female head in the HH - agriculture"
lab var head_prof_wm "Female head in the HH - Professional"
lab var head_other_wm "Female head in the HH - other employement"
lab var head_cler_wm "Female head in the HH - clerical employment"
lab var head_skman_wm "Female head in the HH - skilled manual employment"
lab var head_un_wm "Female head in the HH - unemployed"
lab var head_unskman_wm "Female head in the HH - unskilled manual employment"
lab var tot_wmen_noedu "Number of women in the HH - no education"
lab var tot_wmen_pri "Number of women in the HH - primary education"
lab var tot_wmen_sec "Number of women in the HH - secondary education"
lab var tot_wmen_high "Number of women in the HH - higher education"
lab var head_noedu_wm "Women head in the HH - no education"
lab var head_pri_wm "Women head in the HH - primary education"
lab var head_sec_wm "Women head in the HH - secondary education"
lab var head_high_wm "Women head in the HH - higher education"
lab var tot_RI_Low_w "Number of women in HH with low or very low Rohrer Index"
*lab var tot_BMI_low_w "Number of women in HH with BMI <16.9 (severe or moderately thin)"
*lab var hh_young_ch "Number of children younger than 24 months in the household"
*lab var No_min_diet_diversity_hh "HH has at least one young child that is not fed with the min food diversity" 
lab var stunting_c_hh "Number of stunted children in the HH"
lab var wasted_c_hh "Number of wasted children in the HH"
lab var underwht_ch_hh "Number of underweight children in the HH"
lab var tot_men_HH "Number of men in the HH"
lab var tot_wmen_HH "Number of women in the HH"
lab var tot_teen15 "Number of teen below 16 in the HH"
lab var tot_men_ag "Number of men in agriculture"
lab var tot_men_un "Number of men in the HH - unemployed"
lab var tot_men_serv "Number of men in the HH - services employment"
lab var tot_men_prof "Number of men in the HH - Professional jobs"
lab var tot_men_cler "Number of men in the HH - clerical employment"
lab var tot_men_skman "Number of men in the HH - skilled manual employment"
lab var tot_men_unskman "Number of men in the HH - unskilled manual employment"
lab var tot_men_other "Number of men in other employment"
lab var tot_men_work "Number of men currently working in the HH"
lab var tot_men_work_hd "Male head currently working in the HH"
lab var head_ag_m "Male head in the HH - agriculture employment"
lab var head_un_m "Male head in the HH - unemployed"
lab var head_prof_m "Male head in the HH - Professional"
lab var head_cler_m "Male head in the HH - clerical employment"
lab var head_skman_m "Male head in the HH - skilled manual employment"
lab var head_unskman_m "Male head in the HH - unskilled manual employment"
lab var head_other_m "Male head in other employment"
lab var head_serv_m "Male head in the HH - services employment"
lab var tot_men_noedu "Number of men in the HH - no education"
lab var tot_men_pri "Number of men in the HH - primary education"
lab var tot_men_sec "Number of men in the HH - secondary education"
lab var tot_men_high "Number of men in the HH - higher education"
lab var head_noedu_m "Male head in the HH - no education"
lab var head_pri_m "Male head in the HH - primary education"
lab var head_sec_m "Male head in the HH - secondary education"
lab var head_high_m "Male head in the HH - higher education"
lab var wgt "Weights - to use"

save "$datadir\cleaned\final_11.dta", replace


*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
* Ethiopia 2016
*******************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************

*********************************************************************************************************************************
* Individual records WOMEN 
*********************************************************************************************************************************

global datadir  "E:\WORK ROMA\African Obsevatory\Ethiopia\DHS\Complete\2016" 
use "$datadir/ETIR71DT/ETIR71FL.dta", clear

	

keep caseid v000 v001 v002 v003 v004 v005 v006 v007 v008 v042 v455 v457 v208 m45_1 m46_1 v213 b3_01 v012 v024 v025 v101 v102 v106 v107 v133 v131 v717 v714 v705 v719 v440 v444a v445 v446 v439 v150 v151 v152 v501
sort v001 v002 v003

* ID
tostring v001 v002,g (v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s v000
rename caseid hhid_dhs

* Number of women in the HH
bysort hhid: g n=_n
bysort hhid: egen tot_wmen=max(n)
sum tot_w
lab var tot_wm "Number of women in the HH"
drop n 

* Employment in agriculture
tab v717
tab v717, g(occ)

bysort hhid: egen tot_wmen_ag=sum(occ5)

bysort hhid: egen tot_wmen_Prof=sum(occ2)
bysort hhid: egen tot_wmen_cler=sum(occ3)
bysort hhid: egen tot_wmen_sales=sum(occ4)
bysort hhid: egen tot_wmen_serv=sum(occ6)
bysort hhid: egen tot_wmen_skman=sum(occ7)
bysort hhid: egen tot_wmen_unskman=sum(occ8)
bysort hhid: egen tot_wmen_other=sum(occ9)
bysort hhid: egen tot_wmen_un=sum(occ1) 
lab var tot_wmen_Prof "Number of women in the HH - Professional jobs"
lab var tot_wmen_cler "Number of women in the HH - clerical employment"
lab var tot_wmen_sales "Number of women in the HH - sales employment"
lab var tot_wmen_serv "Number of women in the HH - services employment"
lab var tot_wmen_skman "Number of women in the HH - skilled manual employment"
lab var tot_wmen_unskman "Number of women in the HH - unskilled manual employment"
lab var tot_wmen_un "Number of women in the HH - unemployment"


*Currently working
bysort hhid: egen tot_wmen_work=sum(v714)
bysort hhid: egen tot_wmen_work_hd=sum(v714) if v150==1


*HH head occupation 
bysort hhid: g x=1 if occ5==1 & v150==1
bysort hhid: egen head_ag_wm=max (x)
drop x

bysort hhid: g x=1 if occ2==1 & v150==1
bysort hhid: egen head_prof_wm=max (x)
drop x

bysort hhid: g x=1 if occ3==1 & v150==1
bysort hhid: egen head_cler_wm=max (x)
drop x

bysort hhid: g x=1 if occ4==1 & v150==1
bysort hhid: egen head_sales_wm=max (x)
drop x

bysort hhid: g x=1 if occ6==1 & v150==1
bysort hhid: egen head_serv_wm=max (x)
drop x

bysort hhid: g x=1 if occ7==1 & v150==1
bysort hhid: egen head_skman_wm=max (x)
drop x

bysort hhid: g x=1 if occ8==1 & v150==1
bysort hhid: egen head_unskman_wm=max (x)
drop x

bysort hhid: g x=1 if occ9==1 & v150==1
bysort hhid: egen head_other_wm=max (x)
drop x

bysort hhid: g x=1 if occ1==1 & v150==1
bysort hhid: egen head_un_wm=max (x)
drop x

lab var tot_wmen_work "Number of women currently working in the HH"
lab var tot_wmen_work_hd "Women head(s) currently working in the HH"
lab var head_ag_wm "Female head in the HH - agriculture"
lab var head_prof_wm "Female head in the HH - Professional"
lab var head_un_wm "Female head in the HH - domestic employed"
lab var head_cler_wm "Female head in the HH - clerical employment"
lab var head_sales_wm "Female head in the HH - sales employment"
lab var head_serv_wm "Female head in the HH - services employment"
lab var head_skman_wm "Female head in the HH - skilled manual employment"
lab var head_unskman_wm "Female head in the HH - unskilled manual employment"


* Education
tab v106, g(edu)
bysort hhid: egen tot_wmen_noedu=sum(edu1)
bysort hhid: egen tot_wmen_pri=sum(edu2)
bysort hhid: egen tot_wmen_sec=sum(edu3)
bysort hhid: egen tot_wmen_high=sum(edu4)

* Head 
bysort hhid: g x=1 if edu1==1 & v150==1
bysort hhid: egen head_noedu_wm=max (x)
drop x

bysort hhid: g x=1 if edu2==1 & v150==1
bysort hhid: egen head_pri_wm=max (x)
drop x

bysort hhid: g x=1 if edu3==1 & v150==1
bysort hhid: egen head_sec_wm=max (x)
drop x

bysort hhid: g x=1 if edu4==1 & v150==1
bysort hhid: egen head_high_wm=max (x)
drop x

lab var tot_wmen_noedu "Number of women in the HH - no education"
lab var tot_wmen_pri "Number of women in the HH - primary education"
lab var tot_wmen_sec "Number of women in the HH - secondary education"
lab var tot_wmen_high "Number of women in the HH - higher education"
lab var head_noedu_wm "Female head in the HH - no education"
lab var head_pri_wm "Female head in the HH - primary education"
lab var head_sec_wm "Female head in the HH - secondary education"
lab var head_high_wm "Female head in the HH - higher education"

* Ethnicity
* Two major ethnic groups: Wolof and Poular = 1 versus others =0 

* Ethnicity
tab v131
tab v131, g(ethn)

* Head 
bysort hhid: g x=1 if ethn4==1 & v150==1
bysort hhid: egen head_affar_wm=max (x)
drop x

bysort hhid: g x=1 if ethn1==1 & v150==1
bysort hhid: egen head_amharra_wm=max (x)
drop x

bysort hhid: g x=1 if ethn6==1 & v150==1
bysort hhid: egen head_guragie_wm=max (x)
drop x

bysort hhid: g x=1 if ethn2==1 & v150==1
bysort hhid: egen head_oromo_wm=max (x)
drop x

bysort hhid: g x=1 if ethn7==1 & v150==1
bysort hhid: egen head_sidama_wm=max (x)
drop x

bysort hhid: g x=1 if ethn5==1 & v150==1
bysort hhid: egen head_somalie_wm=max (x)
drop x

bysort hhid: g x=1 if ethn3==1 & v150==1
bysort hhid: egen head_tigray_wm=max (x)
drop x

bysort hhid: g x=1 if ethn9==1 & v150==1
bysort hhid: egen head_welaita_wm=max (x)
drop x

 
bysort hhid: g x=1 if v150==1 &	head_welaita_wm!=1 & head_tigray_wm!=1 & head_somalie_wm!=1 & head_sidama_wm!=1 & head_oromo_wm!=1 & head_guragie_wm!=1 ///
                              &	head_amharra_wm!=1 & head_affar_wm!=1 
bysort hhid: egen head_other_ethn_wm=max (x)
drop x


 
// Anthropometry indicators

* Age of most recent child
gen age = v008 - b3_01
	
* To check if survey has b19, which should be used instead to compute age

scalar b19_included=1
capture confirm numeric variable b19_01, exact 
		if _rc>0 {
		* b19 is not present
        scalar b19_included=0
		}
		
		if _rc==0 {
		* b19 is present; check for values
		summarize b19_01
		if r(sd)==0 | r(sd)==. {
		scalar b19_included=0
		  }
		}

	    if b19_included==1 {
	    drop age
	    gen age=b19_01
	    }


// Rohrer index (RI) ie Index  of Corpulence - NON PREGNANT-POST PARTUM WOMEN

// The range variation of RI (According to Pignet, cited in Bhasin and Singh, 2004) is also mentioned in this study: Rohrer Index=(Body weight (gm)/Stature 3 (cm)) × 100 //
/*
• Very low ≤ 1.12

• Low (1.13-1.19)

• Middle (1.20-1.25)

• Upper middle (1.26-1.32)

• High (1.33-1.39)

• Very high=1.40

• Healthy range 1.2-1.6
*/

* Replace missing
sum v446
codebook v446
tab v446, nolabel
tab v445
foreach var of varlist v445 v446 {
replace `var' =. if `var'==9998 | `var'==9999
}

* RI creation
g RI_Low_w=1 if v446<=1190 //RI for low and very low//
replace RI_Low_w=0 if v446>1190
replace RI_Low_w= . if (v446==.| v213==1 | age<2)
lab var RI_Low_w "Rohrer Index - low or very low - women"
br v446 RI_Low_w
label define RI_Low_w 1 "Low or Very low Rohrer's Index" 0 "High Rohrer Index"
label values RI_Low_w RI_Low_w
br v446 RI_Low_w
tab RI_Low_w
bysort hhid: egen tot_RI_Low_w=total(RI_Low_w), missing
br tot_RI_Low_w hhid RI_Low_w
sum tot_RI_Low_w
lab var tot_RI_Low_w "Number of women in HH with low or very low Rohrer Index"

// BMI - NON PREGNANT-POST PARTUM WOMEN

/* https://dhsprogram.com/pubs/pdf/MR6/MR6.pdf
With standard terminology for this
measure, if the BMI is less than 16.0, the woman is ―severely thin;‖ if 16.0 to 16.9, she is ―moderately
thin;‖ if 17.0 to 18.4, she is ―mildly thin.‖ The entire range below 18.5 is ―thin.‖ If the BMI is 25.0 to
29.9, the woman is ―overweight;‖ if 30.0 or higher, she is ―obese.‖ For example, if v437 = 400 (40.0 kg)
and v438 = 1500 (1.500 meters) then v445 = 1778, the BMI is 17.78, and the woman is ―mildly thin.‖
For the ―malnourished‖ woman described in the last paragraph of section 4.2.2, with a weight of 35.1 kg
and a height of 1.500 meters, the BMI is 15.6, so she is ―severely thin.‖
*/

/* The DHS Guide to Statistics offers the following guidelines for interpreting BMI scores for women age 15-49:
 Severely thin: less than 16.0
Moderately thin: 16.0 to 16.9
Mildly thin: 17.0 to 18.4
Normal: 18.5 to 24.9
Overweight: 25.0 to 29.9
Obese: 30.0 or more*/

* BMI - Moderately or severely thin DHS
gen nt_wm_modsevthin= inrange(v445,1200,1699) if inrange(v445,1200,6000)
replace nt_wm_modsevthin=. if (v213==1 | age<2)
label values nt_wm_modsevthin yesno
label var nt_wm_modsevthin "Moderately and severely thin BMI - women"
bysort hhid: egen DHS_tot_BMI_low_w=total(nt_wm_modsevthin), missing 
lab var DHS_tot_BMI_low_w "Number of women in HH with BMI <16.9 (severe or moderately thin)"

/*
// TOOK IRON supplements during last pregnancy
gen nt_wm_micro_iron= .
replace nt_wm_micro_iron=0 if m45_1==0
replace nt_wm_micro_iron=1 if inrange(m46_1,0,59)
replace nt_wm_micro_iron=2 if inrange(m46_1,60,89)
replace nt_wm_micro_iron=3 if inrange(m46_1,90,300)
replace nt_wm_micro_iron=4 if m45_1==8 | m45_1==9 | m46_1==998 | m46_1==999
replace nt_wm_micro_iron= . if v208==0
label define nt_wm_micro_iron 0"None" 1"<60" 2"60-89" 3"90+" 4"Don't know/missing"
label values nt_wm_micro_iron nt_wm_micro_iron
label var nt_wm_micro_iron "Number of days women took iron supplements during last pregnancy"
*/

// SEVERE ANEMIA
gen nt_wm_sev_anem=0 if v042==1 & v455==0
replace nt_wm_sev_anem=1 if v457==1 | v457==2
label values nt_wm_sev_anem yesno
label var nt_wm_sev_anem "Severe and Moderate anemia - women"
bysort hhid: egen sev_mod_anemia_hh=total(nt_wm_sev_anem), missing 
lab var sev_mod_anemia_hh "Number of women in HH with severe-moderate anemia"


* Collapsing at HH level
sum  v001 v002
collapse tot_wmen* head* RI_Low_w tot_RI_Low_w nt_wm_modsevthin DHS_tot_BMI_low_w sev_mod_anemia_hh  , by (hhid v001 v002)
sum
order hhid v001 v002
sort hhid 

save "$datadir/cleaned/HHwomen_16.dta", replace

*********************************************************************************************************************************
* Individual records MEN 
*********************************************************************************************************************************

use "$datadir\ETMR71DT\ETMR71FL.dta", clear
keep mcaseid mv000 mv001 mv002 mv003 mv004 mv005 mv006 mv007 mv012 mv024 mv025 mv101 mv102 mv106 mv107 mv133 mv131 mv717 mv714   mv150 mv151 mv152 mv501
gen v001 = mv001
gen v002 = mv002
gen v003 = mv003
sort v001 v002 v003

* ID
tostring mv001 mv002,g (mv001s mv002s)
g hhid=mv001s+mv002s
replace hhid =mv001s+"0"+mv002s if mv002<10
order hhid 
destring hhid, replace
drop mv001s mv002s

* Gen person id without spaces
/* tostring mv001 mv002 mv003,g (mv001s mv002s mv003s)
g mid=mv001s+mv002s+mv003s
replace mid =mv001s+"0"+mv002s+mv003s if mv002<10
replace mid =mv001s+mv002s+"0"+mv003s if mv003<10
order hhid mid
destring mid, replace
drop mv001s mv002s mv003s*/ // not necessary

* Number of men in the HH
bysort hhid: g n=_n
bysort hhid: egen tot_men=max(n)
sum tot_m
lab var tot_m "Number of men in the HH"
drop n 

*Employment in agriculture
tab mv717
tab mv717, g(occ)
bysort hhid: egen tot_men_ag=sum(occ5)
sum tot_men_ag
lab var tot_men_ag "Number of men in agriculture"

*Other occupations
bysort hhid: egen tot_men_un=sum(occ1)
bysort hhid: egen tot_men_prof=sum(occ2)
bysort hhid: egen tot_men_cler=sum(occ3)
bysort hhid: egen tot_men_sales=sum(occ4)
bysort hhid: egen tot_men_serv=sum(occ6)
bysort hhid: egen tot_men_skman=sum(occ7)
bysort hhid: egen tot_men_unskman=sum(occ8)
bysort hhid: egen tot_men_other=sum(occ9)

lab var tot_men_un "Number of men in the HH - unemployed"
lab var tot_men_prof "Number of men in the HH - Professional jobs"
lab var tot_men_cler "Number of men in the HH - clerical employment"
lab var tot_men_sales "Number of men in the HH - sales employment"
lab var tot_men_serv "Number of men in the HH - services employment"
lab var tot_men_skman "Number of men in the HH - skilled manual employment"
lab var tot_men_unskman "Number of men in the HH - unskilled manual employment"
lab var tot_men_other "Number of men in other employment"

*Currently working
bysort hhid: egen tot_men_work=sum(mv714)
bysort hhid: egen tot_men_work_hd=sum(mv714) if mv150==1


*HH head occupation 
bysort hhid: g x=1 if occ5==1 & mv150==1
bysort hhid: egen head_ag_m=max (x)
drop x

bysort hhid: g x=1 if occ1==1 & mv150==1
bysort hhid: egen head_un_m=max (x)
drop x

bysort hhid: g x=1 if occ2==1 & mv150==1
bysort hhid: egen head_prof_m=max (x)
drop x

bysort hhid: g x=1 if occ3==1 & mv150==1
bysort hhid: egen head_cler_m=max (x)
drop x

bysort hhid: g x=1 if occ4==1 & mv150==1
bysort hhid: egen head_sales_m=max (x)
drop x

bysort hhid: g x=1 if occ6==1 & mv150==1
bysort hhid: egen head_serv_m=max (x)
drop x

bysort hhid: g x=1 if occ7==1 & mv150==1
bysort hhid: egen head_skman_m=max (x)
drop x

bysort hhid: g x=1 if occ8==1 & mv150==1
bysort hhid: egen head_unskman_m=max (x)
drop x

bysort hhid: g x=1 if occ9==1 & mv150==1
bysort hhid: egen head_other_m=max (x)
drop x

lab var tot_men_work "Number of men currently working in the HH"
lab var tot_men_work_hd "men head(s) currently working in the HH"
lab var head_ag_m "Male head in the HH - agriculture"
lab var head_un_m "Male head in the HH - unemployed"
lab var head_prof_m "Male head in the HH - Professional"
lab var head_cler_m "Male head in the HH - clerical employment"
lab var head_sales_m "Male head in the HH - sales employment"
lab var head_serv_m "Male head in the HH - services employment"
lab var head_skman_m "Male head in the HH - skilled manual employment"
lab var head_unskman_m "Male head in the HH - unskilled manual employment"
lab var head_other_m "Male head in other employment"

* Education
tab mv106, g(edu)
bysort hhid: egen tot_men_noedu=sum(edu1)
bysort hhid: egen tot_men_pri=sum(edu2)
bysort hhid: egen tot_men_sec=sum(edu3)
bysort hhid: egen tot_men_high=sum(edu4)

lab var tot_men_noedu "Number of men in the HH - no education"
lab var tot_men_pri "Number of men in the HH - primary education"
lab var tot_men_sec "Number of men in the HH - secondary education"
lab var tot_men_high "Number of men in the HH - higher education"

* Head - Education
bysort hhid: g x=1 if edu1==1 & mv150==1
bysort hhid: egen head_noedu_m=max (x)
drop x

bysort hhid: g x=1 if edu2==1 & mv150==1
bysort hhid: egen head_pri_m=max (x)
drop x

bysort hhid: g x=1 if edu3==1 & mv150==1
bysort hhid: egen head_sec_m=max (x)
drop x

bysort hhid: g x=1 if edu4==1 & mv150==1
bysort hhid: egen head_high_m=max (x)
drop x

lab var head_noedu_m "Male head in the HH - no education"
lab var head_pri_m "Male head in the HH - primary education"
lab var head_sec_m "Male head in the HH - secondary education"
lab var head_high_m "Male head in the HH - higher education"

* Ethnicity
* Two major ethnic groups: Wolof and Poular = 1 versus others =0 

* Ethnicity
tab mv131
tab mv131, g(ethn)

* Head 
bysort hhid: g x=1 if ethn4==1 & mv150==1
bysort hhid: egen head_affar_m=max (x)
drop x

bysort hhid: g x=1 if ethn1==1 & mv150==1
bysort hhid: egen head_amharra_m=max (x)
drop x

bysort hhid: g x=1 if ethn6==1 & mv150==1
bysort hhid: egen head_guragie_m=max (x)
drop x

bysort hhid: g x=1 if ethn2==1 & mv150==1
bysort hhid: egen head_oromo_m=max (x)
drop x

bysort hhid: g x=1 if ethn7==1 & mv150==1
bysort hhid: egen head_sidama_m=max (x)
drop x

bysort hhid: g x=1 if ethn5==1 & mv150==1
bysort hhid: egen head_somalie_m=max (x)
drop x

bysort hhid: g x=1 if ethn3==1 & mv150==1
bysort hhid: egen head_tigray_m=max (x)
drop x

bysort hhid: g x=1 if ethn9==1 & mv150==1
bysort hhid: egen head_welaita_m=max (x)
drop x

 
bysort hhid: g x=1 if mv150==1 &	head_welaita_m!=1 & head_tigray_m!=1 & head_somalie_m!=1 & head_sidama_m!=1 & head_oromo_m!=1 & head_guragie_m!=1 ///
                              &	head_amharra_m!=1 & head_affar_m!=1 
bysort hhid: egen head_other_ethn_m=max (x)
drop x





/*
* Urban rural
tab mv102
tab mv102, nol
g rural=1 if mv102==2
tab rural
replace rural=0 if rural==.
tab rural

bysort hhid: egen tot_men_rural=sum(rural)
sum tot_men_rural

bysort hhid: g x=1 if rural==1 & mv150==1
bysort hhid: egen head_rural=max (x)
drop x

lab var head_rural "Male head in the HH - in rural"
lab var tot_men_rural "Number of men in rural area"
*/

* Collapsing at HH level
sum  mv001 mv002
collapse tot_men*  head* , by (hhid  mv001 mv002)
rename mv001 v001
rename mv002 v002
sum
/*
foreach var of varlist tot_men_work_hd head_ag_s_m head_ag_w_m head_un_m head_serv_m head_prof_m head_dom_m head_cler_m head_sales_m head_skman_m head_unskman_m head_noedu_m head_pri_m head_sec_m head_high_m   {
replace `var'=0 if `var'==.
}
sum
*/
order hhid v001 v002

save "$datadir/cleaned/HHmen_16.dta", replace

*********************************************************************************************************************************
* Household members - PR for FOOD SECURITY
*********************************************************************************************************************************

use "$datadir/ETPR71DT/ETPR71FL.dta", clear
keep hhid hvidx hv001 hv002 hv003 hv004 hv005 hv007 hv021 hv022 hv023 hv024 hv025  hv101 hv103 hv104 hv105 hv106 hv107  hc70 hc71 hc72 hc73 hv270 hv271  hc57 hv006 hv007 hv008 hv009 hv220 hv219 hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215 hv247 ha5 ha11 hc1 hc56
gen v001 = hv001
gen v002 = hv002
gen v003 = hv003
sort v001 v002 v003

* ID
rename hhid hhid_dhs
tostring v001 v002,g (v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s

* STUNTING
tab hc70, nolabel
tab hc71, nolabel
tab hc72, nolabel

foreach var of varlist hc70 hc71 hc72 {
replace `var' =. if `var'==9998 |`var'==9996 | `var'==9997 |`var'==9999
}

tab hc70
gen stunted_ch = 1 if hc70<=-200
replace stunted_ch=0 if hc70>-200
replace stunted_ch= . if hc70==.
tab stunted_ch
* count if hc70 <-200
bysort hhid: egen stunting_c_hh=total(stunted_ch), missing 
lab var stunting_c_hh "Number of stunted children in the HH"

* WASTING
gen wasted_ch = 1 if hc72<=-200
replace wasted_ch=0 if hc72>-200
replace wasted_ch = . if hc72==.
tab wasted_ch
* count if hc72 <-200
bysort hhid: egen wasted_c_hh=total(wasted_ch) , missing
lab var wasted_c_hh "Number of wasted children in the HH"


* UNDERWWEIGHT
gen underwht_ch = 1 if hc71<=-200
replace underwht_ch=0 if hc71>-200
replace underwht_ch = . if hc71==.
tab underwht_ch
bysort hhid: egen underwht_ch_hh=total(underwht_ch) , missing
lab var underwht_ch_hh "Number of underweighted children in the HH"
tab underwht_ch_hh
* count if hc71 <-200
sum *c_hh 

* MODERATE AND SEVERE ANEMIA AMONG CHILDREN
gen nt_ch_sev_anem=0 if hc1>5 & hc1<60
replace nt_ch_sev_anem=1 if hc56<100 & hc1>5 & hc1<60
replace nt_ch_sev_anem=. if hc56==.
label values nt_ch_sev_anem yesno
label var nt_ch_sev_anem "Moderate/severe anemia - child 6-59 months"
bysort hhid: egen anemia_ch_hh=total(nt_ch_sev_anem), missing 
label var anemia_ch_hh "Moderate/severe anemia HH - child 6-59 months"

* Sex
tab hv104, g(sex)
bysort hhid: egen tot_men_HH=total(sex1)
bysort hhid: egen tot_wmen_HH=total(sex2)
lab var tot_men_HH "Number of men in the HH"
lab var tot_wmen_HH "Number of women in the HH"
bysort hhid:egen tot_teen15=total(hv105<16)
lab var tot_teen15 "Number of teen below 16 in the HH"

* Head educational level 
gen head_no_edu = 1 if hv101==1 & hv106==0
replace head_no_edu=0 if head_no_edu==.
gen head_primary = 1 if hv101==1 & hv106==1
replace head_primary=0 if head_primary==.
gen head_secondary = 1 if hv101==1 & hv106==2
replace head_secondary = 0 if head_secondary==.
gen head_higher=1 if hv101==1 & hv106==3
replace head_higher=0 if head_higher==.

bysort hhid: egen hh_head_no_edu =total(head_no_edu), missing
bysort hhid: egen hh_head_primary =total(head_primary), missing
bysort hhid: egen hh_head_secondary =total(head_secondary), missing
bysort hhid: egen hh_head_higher =total(head_higher), missing

* Collapsing at HH level 
collapse  v003 hv247 hv001 hv002 hv003 hv009 tot_men_HH tot_wmen_HH tot_teen15 stunted_ch stunting_c_hh wasted_ch wasted_c_hh underwht_ch underwht_ch_hh hh_head_no_edu hh_head_primary hh_head_secondary hh_head_higher anemia_ch_hh nt_ch_sev_anem, by(hhid v001 v002)
sort hhid

save "$datadir/cleaned/HH_counts_16.dta", replace

*********************************************************************************************************************************
* Children data for FOOD DIVERSITY AND FREQUENCY
*********************************************************************************************************************************
*********************************************************************************************************************************
use "$datadir/ETKR71DT/ETKR71FL.dta", clear

// Child's age 

gen age = v008 - b3
keep if _n == 1 | caseid != caseid[_n-1]

/*		
* To check if survey has b19, which should be used instead to compute age. 
scalar b19_included=1
capture confirm numeric variable b19, exact 
		if _rc>0 {
	    * b19 is not present
		scalar b19_included=0
		}
		if _rc==0 {
		* b19 is present; check for values
		summarize b19
		if r(sd)==0 | r(sd)==. {
		scalar b19_included=0
			  }
			}

		if b19_included==1 {
		drop age
		gen age=b19
		}
*/
	
* HHID
tostring v001 v002, g(v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s
order hhid

// Given formula
gen nt_formula= v411a==1
label values nt_formula yesno
label var nt_formula "Child given infant formula in day/night before survey - last-born under 2 years"

// Give fortified baby food
gen nt_bbyfood= v412a==1
label values nt_bbyfood yesno 
label var nt_bbyfood "Child given fortified baby food in day/night before survey- last-born under 2 years"

// Given other milk
gen nt_milk= v411==1
label values nt_milk yesno 
label var nt_milk "Child given other milk in day/night before survey- last-born under 2 years"

// Given grains
gen nt_grains_tuber = v412a==1 | v414e==1 | v414f==1
label values nt_grains_tuber yesno 
label var nt_grains_tuber "Child given grains in day/night before survey- last-born under 2 years"

// Given Vit rich foods
gen nt_vit = v414i==1 | v414j==1 | v414k==1
label values nt_vit yesno 
label var nt_vit "Child given vitamin A rich food in day/night before survey- last-born under 2 years"

// Given other fruits or vegetables
gen nt_frtveg = v414l==1
label values nt_frtveg yesno 
label var nt_frtveg "Child given other fruits or vegetables in day/night before survey- last-born under 2 years"

// Given nuts or legumes
gen nt_nuts = v414o==1
label values nt_nuts yesno 
label var nt_nuts "Child given legumes or nuts in day/night before survey- last-born under 2 years"

// Given meat
gen nt_meat = v414h==1 | v414m==1 | v414n==1
label values nt_meat yesno 
label var nt_meat "Child given meat, fish, shellfish, or poultry in day/night before survey- last-born under 2 years"

// Given eggs
gen nt_eggs = v414g==1
label values nt_eggs yesno 
label var nt_eggs "Child given eggs in day/night before survey- last-born under 2 years"

// Given dairy
gen nt_dairy = v414p==1 | v411==1 | v411a==1
label values nt_dairy yesno 
label var nt_dairy "Child given cheese, yogurt, or other milk products in day/night before survey- last-born under 2 years"

// Given other solid or semi-solid foods
gen nt_solids= nt_bbyfood==1 | nt_grains_tuber==1 | nt_vit==1 | nt_frtveg==1 | nt_nuts==1 |  nt_eggs==1 | nt_dairy==1 | nt_meat==1
label values nt_solids yesno 
label var nt_solids "Child given any solid or semisolid food in day/night before survey- last-born under 2 years"

// Fed milk or milk products
gen totmilkf = 0
replace totmilkf=totmilkf + v411 if v411==1
replace totmilkf=totmilkf + v411a if v411a==1
replace totmilkf=totmilkf + v414p if v414p==1
gen nt_fed_milk= ( totmilkf>=2 | m4==95) if inrange(age,6,23)
label values nt_fed_milk yesno
label var nt_fed_milk "Child given milk or milk products- last-born 6-23 months"

// Min dietary diversity

	* 8 food groups
	*1. breastmilk
	gen group1= m4==95

	*2. infant formula, milk other than breast milk, cheese or yogurt or other milk products
	gen group2= nt_formula==1 | nt_milk==1 | nt_dairy==1

	*3. foods made from grains, roots, tubers, and bananas/plantains, including porridge and fortified baby food from grains
	gen group3= nt_grains_tuber==1 
	 
	*4. vitamin A-rich fruits and vegetables
	gen group4= nt_vit==1

	*5. other fruits and vegetables
	gen group5= nt_frtveg==1

	*6. eggs
	gen group6= nt_eggs==1

	*7. legumes and nuts
	gen group7= nt_nuts==1
	
	*8. meat
	gen group8= nt_meat==1

// Min dietary diversity
egen foodsum = rsum(group1 group2 group3 group4 group5 group6 group7 group8) 
recode foodsum (1/4 =0 "No") (5/8=1 "Yes"), gen(nt_mdd)
replace nt_mdd=. if age<6 | age>=24
label var nt_mdd "Child with minimum dietary diversity, 5 out of 8 food groups- last-born 6-23 months"

gen non_mdd =1 if nt_mdd==0 
replace non_mdd=0 if nt_mdd==1 
bys hhid : egen new_No_min_diet_diversity_hh = max(non_mdd) if non_mdd!=.
la var new_No_min_diet_diversity_hh "HH has at least one young child that is not fed with the min food diversity"

/*older surveys are 4 out of 7 food groups, can use code below
egen foodsum = rsum(group2 group3 group4 group5 group6 group7 group8) 
recode foodsum (1/3 .=0 "No") (4/7=1 "Yes"), gen(nt_mdd)
*/

// Min meal frequency
gen feedings=totmilkf
replace feedings= feedings + m39 if m39>0 & m39<8
gen nt_mmf = (m4==95 & inrange(m39,2,7) & inrange(age,6,8)) | (m4==95 & inrange(m39,3,7) & inrange(age,9,23)) | (m4!=95 & feedings>=4 & inrange(age,6,23))
replace nt_mmf=. if age<6 | age>=24
label var nt_mmf "Child with minimum meal frequency- last-born 6-23 months"

gen non_mmf =1 if nt_mmf==0 
replace non_mmf=0 if nt_mmf==1 
bys hhid : egen new_No_min_meal_freq_hh = max(non_mmf) if non_mmf!=.
la var new_No_min_meal_freq_hh "HH has at least one young child that is not fed min frequency"

// Min acceptable diet
egen foodsum2 = rsum(nt_grains nt_grains_tuber nt_nuts nt_meat nt_vit nt_frtveg nt_eggs)
gen nt_mad = (m4==95 & nt_mdd==1 & nt_mmf==1) | (m4!=95 & foodsum2>=4 & nt_mmf==1 & totmilkf>=2)
replace nt_mad=. if age<6 | age>=24
label values nt_mad yesno
label var nt_mad "Child with minimum acceptable diet- last-born 6-23 months"
 
gen non_mad =1 if nt_mad==0 
replace non_mad=0 if nt_mad==1 
bys hhid : egen new_No_min_acc_diet_hh = max(non_mad) if non_mad!=.
la var new_No_min_acc_diet_hh "HH has at least one young child that is not fed min acceptable diet"

count
sort hhid
collapse (max) nt_mmf nt_mdd new_No_min_diet_diversity_hh new_No_min_meal_freq_hh new_No_min_acc_diet_hh, by (hhid v001 v002)
*hh_young_ch

save "$datadir/cleaned/NEW_1_food_16.dta", replace

*********************************************************************************************************************************
* MERGING
*********************************************************************************************************************************

use "$datadir/ETPR71DT/ETPR71FL.dta", clear
keep hhid hv001 hv002 hv003 hv005 hv007 hv016 hv021 hv022 hv023 hv024 hv025 hv006 hv008 hv009  hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215 hv270  hv271  hv244 hv245 hv246 hv246a hv246c hv246d hv246e hv246f hv246g hv219 hv220

rename hv025 type_place 
rename hv024 region
gen v001 = hv001
gen v002 = hv002
gen v003 = hv003
sort v001 v002 v003


gen month = .
gen year = .

replace year = 2016 if hv007==2008 & hv006==5 & hv016<23
replace month= 1 if hv007==2008 & hv006==5 & hv016<23

replace year = 2016 if hv007==2008 & hv006==5 & hv016>=23
replace month= 2 if hv007==2008 & hv006==5 & hv016>=23
***

replace year = 2016 if hv007==2008 & hv006==6 & hv016<22
replace month= 2 if hv007==2008 & hv006==6 & hv016<22

replace year = 2016 if hv007==2008 & hv006==6 & hv016>=22
replace month= 3 if hv007==2008 & hv006==6 & hv016>=22
***

replace year = 2016 if hv007==2008 & hv006==7 & hv016 <23
replace month= 3 if hv007==2008 & hv006==7 & hv016<23

replace year = 2016 if hv007==2008 & hv006==7 & hv016 >=23
replace month= 4 if hv007==2008 & hv006==7 & hv016 >=23
***

replace year = 2016 if hv007==2008 & hv006==8 & hv016 <23
replace month= 4 if hv007==2008 & hv006==8 & hv016 <23

replace year = 2016 if hv007==2008 & hv006==8 & hv016 >=23
replace month= 5 if hv007==2008 & hv006==8 & hv016 >=23
***

replace year = 2016 if hv007==2008 & hv006==9 & hv016 <24
replace month= 5 if hv007==2008 & hv006==9 & hv016 <24

replace year = 2016 if hv007==2008 & hv006==9 & hv016 >=24
replace month= 6 if hv007==2008 & hv006==9 & hv016 >=24
***

replace year = 2016 if hv007==2008 & hv006==10 & hv016 <24
replace month= 6 if hv007==2008 & hv006==10 & hv016 <24

replace year = 2016 if hv007==2008 & hv006==10 & hv016 >=24
replace month= 7 if hv007==2008 & hv006==10 & hv016 >=24


* ID
tostring v001 v002, g(v001s v002s)
rename hhid hhid_dhs
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s
order hhid

* Year

* Collapse
collapse hv003 hv005 hv007 hv021 hv022 hv023 hv006 hv008 hv009 type_place region hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215 year month hv270 hv271 hv244 hv245 hv246 hv246a hv246c hv246d hv246e hv246f hv246g hv219 hv220, by (hhid v001 v002 )
sort hhid 

* Merging

merge 1:1 hhid v001 v002 using "$datadir/cleaned/HHwomen_16.dta"
drop _merge

merge 1:1 hhid v001 v002 using "$datadir/cleaned/HHmen_16.dta"
drop _merge

merge 1:1 hhid v001 v002 using "$datadir/cleaned/HH_counts_16.dta"
drop _merge

*merge 1:1 hhid v001 v002 using "$datadir/cleaned/food_16.dta"
*drop _merge

merge 1:1 hhid v001 v002 using "$datadir/cleaned/NEW_1_food_16.dta"
drop _merge

order hhid year month
drop v001 v002 v003

*************************************************************************************************************************
* WEIGHTS
*************************************************************************************************************************

rename hv005 HH_wgt
gen wgt = HH_wgt/1000000

*************************************************************************************************************************
* LABELLING and DROPPING
*************************************************************************************************************************

label list
label values hv023 HV023
label values region HV024
label values type_place HV025
label values hv201 HV201
label values hv205 HV205
label values hv206 HV206
label values hv207 HV207
label values hv208 HV208
label values hv213 HV213
label values hv214 HV214
label values hv215 HV215
label values hv204 HV204
label values hv270 HV270
label values hv271 HV271
label values hv244 HV244 
label values hv245 HV245 
label values hv246 HV246 
label values hv246a HV246A 
label values hv246c HV246C 
label values hv246d HV246D 
label values hv246e HV246E 
label values hv246f HV246F 
label values hv246g HV246G 
label values hv219 HV219
label var hv001 "Cluster number"
label var hv002 "HH number"
label var hv003 "Respondent line number"
label var hv006 "Month of interview"
label var hv007 "Year of interview"
label var hv008 "Date interview"
label var hv009 "HH size"
label var HH_wgt "Weights DHS"
label var hv021 "Primary sampling unit"
label var hv022 "Sample struts number"
label var hv023 "Sample domain"
label var type_place "Type place of residence"
label var region "Region"
label var hv201 "Source of drinking water"
label var hv204 "Time to get water"
label var hv205 "Toilet facilities"
label var hv206 "Electricity dummy"
label var hv207 "Radio dummy"
label var hv208 "Television dummy"
label var hv213 "Main fllor material"
label var hv214 "Main wall material"
label var hv215 "Main roof material"
label var hv270 "Wealth Index"
label var hv219 "Sex head household"
rename hv270 wealth_index
label var hv271 "Wealth Index score"
rename hv271 wealth_index_score
label var hv244 "Owns agricultural land"
rename hv244 dummy_agr_land
label var hv245 "Hectares agricultural land"
rename hv245 hectares_acres_ag_land
label var hv246 "Livestock, herds and farm animals"
rename hv246 livestock
label var hv246a "Cattle"
rename hv246a cattle
label var hv246c "Horses,mules"
rename hv246c horses_mules
label var hv246d "Goats"
rename hv246d goats
label var hv246e "Sheep"
rename hv246e sheep
label var hv246f "Poultry"
rename hv246f poultry
label var hv246g "Rabbits"
rename hv246g rabbits
lab var tot_wmen "Number of women in the HH"
lab var tot_wmen_ag "Number of women in agriculture"
lab var tot_wmen_Prof "Number of women in the HH - professional jobs"
lab var tot_wmen_serv "Number of women in the HH - service employment"
lab var tot_wmen_cler "Number of women in the HH - clerical employment"
lab var tot_wmen_other"Number of women in the HH - other employed"
lab var tot_wmen_skman "Number of women in the HH - skilled manual employment"
lab var tot_wmen_unskman "Number of women in the HH - unskilled manual employment"
lab var tot_wmen_un "Number of women in the HH - unemployment"
lab var tot_wmen_work "Number of women currently working in the HH"
lab var tot_wmen_work_hd "Women head(s) currently working in the HH"
lab var head_ag_wm "Female head in the HH - agriculture"
lab var head_serv_wm "Female head in the HH - services employment"
lab var head_prof_wm "Female head in the HH - Professional"
lab var head_other_wm "Female head in the HH - other employed"
lab var head_cler_wm "Female head in the HH - clerical employment"
lab var head_skman_wm "Female head in the HH - skilled manual employment"
lab var head_un_wm "Female head in the HH - unemployed"
lab var head_unskman_wm "Female head in the HH - unskilled manual employment"
lab var tot_wmen_noedu "Number of women in the HH - no education"
lab var tot_wmen_pri "Number of women in the HH - primary education"
lab var tot_wmen_sec "Number of women in the HH - secondary education"
lab var tot_wmen_high "Number of women in the HH - higher education"
lab var head_noedu_wm "Women head in the HH - no education"
lab var head_pri_wm "Women head in the HH - primary education"
lab var head_sec_wm "Women head in the HH - secondary education"
lab var head_high_wm "Women head in the HH - higher education"
lab var tot_RI_Low_w "Number of women in HH with low or very low Rohrer Index"
*lab var tot_BMI_low_w "Number of women in HH with BMI <16.9 (severe or moderately thin)"
*lab var hh_young_ch "Number of children younger than 24 months in the household"
*lab var No_min_diet_diversity_hh "HH has at least one young child that is not fed with the min food diversity" 
lab var stunting_c_hh "Number of stunted children in the HH"
lab var wasted_c_hh "Number of wasted children in the HH"
lab var underwht_ch_hh "Number of underweight children in the HH"
lab var tot_men_HH "Number of men in the HH"
lab var tot_wmen_HH "Number of women in the HH"
lab var tot_teen15 "Number of teen below 16 in the HH"
lab var tot_men_ag "Number of men in agriculture"
lab var tot_men_un "Number of men in the HH - unemployed"
lab var tot_men_serv "Number of men in the HH - services employment"
lab var tot_men_prof "Number of men in the HH - Professional jobs"
lab var tot_men_cler "Number of men in the HH - clerical employment"
lab var tot_men_skman "Number of men in the HH - skilled manual employment"
lab var tot_men_unskman "Number of men in the HH - unskilled manual employment"
lab var tot_men_other "Number of men in other employment"
lab var tot_men_work "Number of men currently working in the HH"
lab var tot_men_work_hd "Male head currently working in the HH"
lab var head_ag_m "Male head in the HH - agric"
lab var head_un_m "Male head in the HH - unemployed"
lab var head_prof_m "Male head in the HH - Professional"
lab var head_cler_m "Male head in the HH - clerical employment"
lab var head_skman_m "Male head in the HH - skilled manual employment"
lab var head_unskman_m "Male head in the HH - unskilled manual employment"
lab var head_other_m "Male Head in other employment"
lab var head_serv_m "Male head in the HH - services employment"
lab var tot_men_noedu "Number of men in the HH - no education"
lab var tot_men_pri "Number of men in the HH - primary education"
lab var tot_men_sec "Number of men in the HH - secondary education"
lab var tot_men_high "Number of men in the HH - higher education"
lab var head_noedu_m "Male head in the HH - no education"
lab var head_pri_m "Male head in the HH - primary education"
lab var head_sec_m "Male head in the HH - secondary education"
lab var head_high_m "Male head in the HH - higher education"
lab var wgt "Weights - to use"


save "$datadir\cleaned\final_16.dta", replace


*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
* ETHIOPIA 2019
*******************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************


*********************************************************************************************************************************
* Individual records WOMEN 
*********************************************************************************************************************************

global datadir  "E:\WORK ROMA\African Obsevatory\Ethiopia\DHS\Complete\2019" 
use "$datadir/ETIR81DT/ETIR81FL.dta", clear

	
keep caseid v000 v001 v002 v003 v004 v005 v006 v007 v008 v042 v455 v457 v208 m45_1 m46_1 v213 b3_01 v012 v024 v025 v101 v102 v106 v107 v133 v131 v717 v714 v705 v719 v440 v444a v445 v446 v439 v150 v151 v152 v501
sort v001 v002 v003

* ID
tostring v001 v002,g (v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s v000
rename caseid hhid_dhs

* Number of women in the HH
bysort hhid: g n=_n
bysort hhid: egen tot_wmen=max(n)
sum tot_w
lab var tot_wm "Number of women in the HH"
drop n 

* Employment in agriculture
tab v717
tab v717, g(occ)
/*
bysort hhid: egen tot_wmen_ag=sum(occ5)

bysort hhid: egen tot_wmen_Prof=sum(occ2)
bysort hhid: egen tot_wmen_cler=sum(occ3)
bysort hhid: egen tot_wmen_sales=sum(occ4)
bysort hhid: egen tot_wmen_serv=sum(occ6)
bysort hhid: egen tot_wmen_skman=sum(occ7)
bysort hhid: egen tot_wmen_unskman=sum(occ8)
bysort hhid: egen tot_wmen_other=sum(occ9)
bysort hhid: egen tot_wmen_un=sum(occ1) 
lab var tot_wmen_Prof "Number of women in the HH - Professional jobs"
lab var tot_wmen_cler "Number of women in the HH - clerical employment"
lab var tot_wmen_sales "Number of women in the HH - sales employment"
lab var tot_wmen_serv "Number of women in the HH - services employment"
lab var tot_wmen_skman "Number of women in the HH - skilled manual employment"
lab var tot_wmen_unskman "Number of women in the HH - ubskilled manual employment"
lab var tot_wmen_un "Number of women in the HH - unemployment"


*Currently working
bysort hhid: egen tot_wmen_work=sum(v714)
bysort hhid: egen tot_wmen_work_hd=sum(v714) if v150==1


*HH head occupation 
bysort hhid: g x=1 if occ5==1 & v150==1
bysort hhid: egen head_ag_wm=max (x)
drop x

bysort hhid: g x=1 if occ2==1 & v150==1
bysort hhid: egen head_prof_wm=max (x)
drop x

bysort hhid: g x=1 if occ3==1 & v150==1
bysort hhid: egen head_cler_wm=max (x)
drop x

bysort hhid: g x=1 if occ4==1 & v150==1
bysort hhid: egen head_sales_wm=max (x)
drop x

bysort hhid: g x=1 if occ6==1 & v150==1
bysort hhid: egen head_serv_wm=max (x)
drop x

bysort hhid: g x=1 if occ7==1 & v150==1
bysort hhid: egen head_skman_wm=max (x)
drop x

bysort hhid: g x=1 if occ8==1 & v150==1
bysort hhid: egen head_unskman_wm=max (x)
drop x

bysort hhid: g x=1 if occ9==1 & v150==1
bysort hhid: egen head_dom_wm=max (x)
drop x

bysort hhid: g x=1 if occ1==1 & v150==1
bysort hhid: egen head_un_wm=max (x)
drop x

lab var tot_wmen_work "Number of women currently working in the HH"
lab var tot_wmen_work_hd "Women head(s) currently working in the HH"
lab var head_ag_wm "Female head in the HH - agriculture"
lab var head_prof_wm "Female head in the HH - Professional"
lab var head_un_wm "Female head in the HH - domestic employed"
lab var head_cler_wm "Female head in the HH - clerical employment"
lab var head_sales_wm "Female head in the HH - sales employment"
lab var head_serv_wm "Female head in the HH - services employment"
lab var head_skman_wm "Female head in the HH - skilled manual employment"
lab var head_unskman_wm "Female head in the HH - unskilled manual employment"

*/
* Education
tab v106, g(edu)
bysort hhid: egen tot_wmen_noedu=sum(edu1)
bysort hhid: egen tot_wmen_pri=sum(edu2)
bysort hhid: egen tot_wmen_sec=sum(edu3)
bysort hhid: egen tot_wmen_high=sum(edu4)

* Head 
bysort hhid: g x=1 if edu1==1 & v150==1
bysort hhid: egen head_noedu_wm=max (x)
drop x

bysort hhid: g x=1 if edu2==1 & v150==1
bysort hhid: egen head_pri_wm=max (x)
drop x

bysort hhid: g x=1 if edu3==1 & v150==1
bysort hhid: egen head_sec_wm=max (x)
drop x

bysort hhid: g x=1 if edu4==1 & v150==1
bysort hhid: egen head_high_wm=max (x)
drop x

lab var tot_wmen_noedu "Number of women in the HH - no education"
lab var tot_wmen_pri "Number of women in the HH - primary education"
lab var tot_wmen_sec "Number of women in the HH - secondary education"
lab var tot_wmen_high "Number of women in the HH - higher education"
lab var head_noedu_wm "Female head in the HH - no education"
lab var head_pri_wm "Female head in the HH - primary education"
lab var head_sec_wm "Female head in the HH - secondary education"
lab var head_high_wm "Female head in the HH - higher education"

* Ethnicity
* Two major ethnic groups: Wolof and Poular = 1 versus others =0 

* Ethnicity
tab v131
tab v131, g(ethn)
/*
* Head 
bysort hhid: g x=1 if ethn4==1 & v150==1
bysort hhid: egen head_affar_wm=max (x)
drop x

bysort hhid: g x=1 if ethn1==1 & v150==1
bysort hhid: egen head_amharra_wm=max (x)
drop x

bysort hhid: g x=1 if ethn6==1 & v150==1
bysort hhid: egen head_guragie_wm=max (x)
drop x

bysort hhid: g x=1 if ethn2==1 & v150==1
bysort hhid: egen head_oromo_wm=max (x)
drop x

bysort hhid: g x=1 if ethn7==1 & v150==1
bysort hhid: egen head_sidama_wm=max (x)
drop x

bysort hhid: g x=1 if ethn5==1 & v150==1
bysort hhid: egen head_somalie_wm=max (x)
drop x

bysort hhid: g x=1 if ethn3==1 & v150==1
bysort hhid: egen head_tigray_wm=max (x)
drop x

bysort hhid: g x=1 if ethn9==1 & v150==1
bysort hhid: egen head_welaita_wm=max (x)
drop x

 
bysort hhid: g x=1 if v150==1 &	head_welaita_wm!=1 & head_tigray_wm!=1 & head_somalie_wm!=1 & head_sidama_wm!=1 & head_oromo_wm!=1 & head_guragie_wm!=1 ///
                              &	head_amharra_wm!=1 & head_affar_wm!=1 
bysort hhid: egen head_other_wm=max (x)
drop x

 */
// Anthropometry indicators

* Age of most recent child
gen age = v008 - b3_01
	
* To check if survey has b19, which should be used instead to compute age

scalar b19_included=1
capture confirm numeric variable b19_01, exact 
		if _rc>0 {
		* b19 is not present
        scalar b19_included=0
		}
		
		if _rc==0 {
		* b19 is present; check for values
		summarize b19_01
		if r(sd)==0 | r(sd)==. {
		scalar b19_included=0
		  }
		}

	    if b19_included==1 {
	    drop age
	    gen age=b19_01
	    }


// Rohrer index (RI) ie Index  of Corpulence - NON PREGNANT-POST PARTUM WOMEN

// The range variation of RI (According to Pignet, cited in Bhasin and Singh, 2004) is also mentioned in this study: Rohrer Index=(Body weight (gm)/Stature 3 (cm)) × 100 //
/*
• Very low ≤ 1.12

• Low (1.13-1.19)

• Middle (1.20-1.25)

• Upper middle (1.26-1.32)

• High (1.33-1.39)

• Very high=1.40

• Healthy range 1.2-1.6
*/

* Replace missing
sum v446
codebook v446
tab v446, nolabel
tab v445
foreach var of varlist v445 v446 {
replace `var' =. if `var'==9998 | `var'==9999
}

* RI creation
g RI_Low_w=1 if v446<=1190 //RI for low and very low//
replace RI_Low_w=0 if v446>1190
replace RI_Low_w= . if (v446==.| v213==1 | age<2)
lab var RI_Low_w "Rohrer Index - low or very low - women"
br v446 RI_Low_w
label define RI_Low_w 1 "Low or Very low Rohrer's Index" 0 "High Rohrer Index"
label values RI_Low_w RI_Low_w
br v446 RI_Low_w
tab RI_Low_w
bysort hhid: egen tot_RI_Low_w=total(RI_Low_w), missing
br tot_RI_Low_w hhid RI_Low_w
sum tot_RI_Low_w
lab var tot_RI_Low_w "Number of women in HH with low or very low Rohrer Index"

// BMI - NON PREGNANT-POST PARTUM WOMEN

/* https://dhsprogram.com/pubs/pdf/MR6/MR6.pdf
With standard terminology for this
measure, if the BMI is less than 16.0, the woman is ―severely thin;‖ if 16.0 to 16.9, she is ―moderately
thin;‖ if 17.0 to 18.4, she is ―mildly thin.‖ The entire range below 18.5 is ―thin.‖ If the BMI is 25.0 to
29.9, the woman is ―overweight;‖ if 30.0 or higher, she is ―obese.‖ For example, if v437 = 400 (40.0 kg)
and v438 = 1500 (1.500 meters) then v445 = 1778, the BMI is 17.78, and the woman is ―mildly thin.‖
For the ―malnourished‖ woman described in the last paragraph of section 4.2.2, with a weight of 35.1 kg
and a height of 1.500 meters, the BMI is 15.6, so she is ―severely thin.‖
*/

/* The DHS Guide to Statistics offers the following guidelines for interpreting BMI scores for women age 15-49:
 Severely thin: less than 16.0
Moderately thin: 16.0 to 16.9
Mildly thin: 17.0 to 18.4
Normal: 18.5 to 24.9
Overweight: 25.0 to 29.9
Obese: 30.0 or more*/

* BMI - Moderately or severely thin DHS
gen nt_wm_modsevthin= inrange(v445,1200,1699) if inrange(v445,1200,6000)
replace nt_wm_modsevthin=. if (v213==1 | age<2)
label values nt_wm_modsevthin yesno
label var nt_wm_modsevthin "Moderately and severely thin BMI - women"
bysort hhid: egen DHS_tot_BMI_low_w=total(nt_wm_modsevthin), missing 
lab var DHS_tot_BMI_low_w "Number of women in HH with BMI <16.9 (severe or moderately thin)"

/*
// TOOK IRON supplements during last pregnancy
gen nt_wm_micro_iron= .
replace nt_wm_micro_iron=0 if m45_1==0
replace nt_wm_micro_iron=1 if inrange(m46_1,0,59)
replace nt_wm_micro_iron=2 if inrange(m46_1,60,89)
replace nt_wm_micro_iron=3 if inrange(m46_1,90,300)
replace nt_wm_micro_iron=4 if m45_1==8 | m45_1==9 | m46_1==998 | m46_1==999
replace nt_wm_micro_iron= . if v208==0
label define nt_wm_micro_iron 0"None" 1"<60" 2"60-89" 3"90+" 4"Don't know/missing"
label values nt_wm_micro_iron nt_wm_micro_iron
label var nt_wm_micro_iron "Number of days women took iron supplements during last pregnancy"
*/

// SEVERE ANEMIA
gen nt_wm_sev_anem=0 if v042==1 & v455==0
replace nt_wm_sev_anem=1 if v457==1 | v457==2
label values nt_wm_sev_anem yesno
label var nt_wm_sev_anem "Severe and Moderate anemia - women"
bysort hhid: egen sev_mod_anemia_hh=total(nt_wm_sev_anem), missing 
lab var sev_mod_anemia_hh "Number of women in HH with severe-moderate anemia"


* Collapsing at HH level
sum  v001 v002
collapse tot_wmen* head* RI_Low_w tot_RI_Low_w nt_wm_modsevthin DHS_tot_BMI_low_w sev_mod_anemia_hh  , by (hhid v001 v002)
sum
order hhid v001 v002
sort hhid 

save "$datadir/cleaned/HHwomen_19.dta", replace

*********************************************************************************************************************************
* Individual records MEN - not existing for 2019
*********************************************************************************************************************************
/*
use "$datadir\ETMR71DT\ETMR71FL.dta", clear
keep mcaseid mv000 mv001 mv002 mv003 mv004 mv005 mv006 mv007 mv012 mv024 mv025 mv101 mv102 mv106 mv107 mv133 mv131 mv717 mv714   mv150 mv151 mv152 mv501
gen v001 = mv001
gen v002 = mv002
gen v003 = mv003
sort v001 v002 v003

* ID
tostring mv001 mv002,g (mv001s mv002s)
g hhid=mv001s+mv002s
replace hhid =mv001s+"0"+mv002s if mv002<10
order hhid 
destring hhid, replace
drop mv001s mv002s

* Gen person id without spaces
/* tostring mv001 mv002 mv003,g (mv001s mv002s mv003s)
g mid=mv001s+mv002s+mv003s
replace mid =mv001s+"0"+mv002s+mv003s if mv002<10
replace mid =mv001s+mv002s+"0"+mv003s if mv003<10
order hhid mid
destring mid, replace
drop mv001s mv002s mv003s*/ // not necessary

* Number of men in the HH
bysort hhid: g n=_n
bysort hhid: egen tot_men=max(n)
sum tot_m
lab var tot_m "Number of men in the HH"
drop n 

*Employment in agriculture
tab mv717
tab mv717, g(occ)
bysort hhid: egen tot_men_ag=sum(occ5)
sum tot_men_ag
lab var tot_men_ag "Number of men in agriculture"

*Other occupations
bysort hhid: egen tot_men_un=sum(occ1)
bysort hhid: egen tot_men_prof=sum(occ2)
bysort hhid: egen tot_men_cler=sum(occ3)
bysort hhid: egen tot_men_sales=sum(occ4)
bysort hhid: egen tot_men_serv=sum(occ6)
bysort hhid: egen tot_men_skman=sum(occ7)
bysort hhid: egen tot_men_unskman=sum(occ8)
bysort hhid: egen tot_men_other=sum(occ9)

lab var tot_men_un "Number of men in the HH - unemployed"
lab var tot_men_prof "Number of men in the HH - Professional jobs"
lab var tot_men_cler "Number of men in the HH - clerical employment"
lab var tot_men_sales "Number of men in the HH - sales employment"
lab var tot_men_serv "Number of men in the HH - services employment"
lab var tot_men_skman "Number of men in the HH - skilled manual employment"
lab var tot_men_unskman "Number of men in the HH - ubskilled manual employment"
lab var tot_men_other "Number of men in other employment"

*Currently working
bysort hhid: egen tot_men_work=sum(mv714)
bysort hhid: egen tot_men_work_hd=sum(mv714) if mv150==1


*HH head occupation 
bysort hhid: g x=1 if occ5==1 & mv150==1
bysort hhid: egen head_ag_m=max (x)
drop x

bysort hhid: g x=1 if occ1==1 & mv150==1
bysort hhid: egen head_un_m=max (x)
drop x

bysort hhid: g x=1 if occ2==1 & mv150==1
bysort hhid: egen head_prof_m=max (x)
drop x

bysort hhid: g x=1 if occ3==1 & mv150==1
bysort hhid: egen head_cler_m=max (x)
drop x

bysort hhid: g x=1 if occ4==1 & mv150==1
bysort hhid: egen head_sales_m=max (x)
drop x

bysort hhid: g x=1 if occ6==1 & mv150==1
bysort hhid: egen head_serv_m=max (x)
drop x

bysort hhid: g x=1 if occ7==1 & mv150==1
bysort hhid: egen head_skman_m=max (x)
drop x

bysort hhid: g x=1 if occ8==1 & mv150==1
bysort hhid: egen head_unskman_m=max (x)
drop x

bysort hhid: g x=1 if occ9==1 & mv150==1
bysort hhid: egen head_other_m=max (x)
drop x

lab var tot_men_work "Number of men currently working in the HH"
lab var tot_men_work_hd "men head(s) currently working in the HH"
lab var head_ag_m "Male head in the HH - agriculture"
lab var head_un_m "Male head in the HH - unemployed"
lab var head_prof_m "Male head in the HH - Professional"
lab var head_cler_m "Male head in the HH - clerical employment"
lab var head_sales_m "Male head in the HH - sales employment"
lab var head_serv_m "Male head in the HH - services employment"
lab var head_skman_m "Male head in the HH - skilled manual employment"
lab var head_unskman_m "Male head in the HH - unskilled manual employment"
lab var head_other_m "Male Head in other employment"

* Education
tab mv106, g(edu)
bysort hhid: egen tot_men_noedu=sum(edu1)
bysort hhid: egen tot_men_pri=sum(edu2)
bysort hhid: egen tot_men_sec=sum(edu3)
bysort hhid: egen tot_men_high=sum(edu4)

lab var tot_men_noedu "Number of men in the HH - no education"
lab var tot_men_pri "Number of men in the HH - primary education"
lab var tot_men_sec "Number of men in the HH - secondary education"
lab var tot_men_high "Number of men in the HH - higher education"

* Head - Education
bysort hhid: g x=1 if edu1==1 & mv150==1
bysort hhid: egen head_noedu_m=max (x)
drop x

bysort hhid: g x=1 if edu2==1 & mv150==1
bysort hhid: egen head_pri_m=max (x)
drop x

bysort hhid: g x=1 if edu3==1 & mv150==1
bysort hhid: egen head_sec_m=max (x)
drop x

bysort hhid: g x=1 if edu4==1 & mv150==1
bysort hhid: egen head_high_m=max (x)
drop x

lab var head_noedu_m "Male head in the HH - no education"
lab var head_pri_m "Male head in the HH - primary education"
lab var head_sec_m "Male head in the HH - secondary education"
lab var head_high_m "Male head in the HH - higher education"

* Ethnicity
* Two major ethnic groups: Wolof and Poular = 1 versus others =0 

* Ethnicity
tab mv131
tab mv131, g(ethn)

* Head 
bysort hhid: g x=1 if ethn4==1 & mv150==1
bysort hhid: egen head_affar_m=max (x)
drop x

bysort hhid: g x=1 if ethn1==1 & mv150==1
bysort hhid: egen head_amharra_m=max (x)
drop x

bysort hhid: g x=1 if ethn6==1 & mv150==1
bysort hhid: egen head_guragie_m=max (x)
drop x

bysort hhid: g x=1 if ethn2==1 & mv150==1
bysort hhid: egen head_oromo_m=max (x)
drop x

bysort hhid: g x=1 if ethn7==1 & mv150==1
bysort hhid: egen head_sidama_m=max (x)
drop x

bysort hhid: g x=1 if ethn5==1 & mv150==1
bysort hhid: egen head_somalie_m=max (x)
drop x

bysort hhid: g x=1 if ethn3==1 & mv150==1
bysort hhid: egen head_tigray_m=max (x)
drop x

bysort hhid: g x=1 if ethn9==1 & mv150==1
bysort hhid: egen head_welaita_m=max (x)
drop x

 
bysort hhid: g x=1 if mv150==1 &	head_welaita_m!=1 & head_tigray_m!=1 & head_somalie_m!=1 & head_sidama_m!=1 & head_oromo_m!=1 & head_guragie_m!=1 ///
                              &	head_amharra_m!=1 & head_affar_m!=1 
bysort hhid: egen head_other_m=max (x)
drop x




/*
* Urban rural
tab mv102
tab mv102, nol
g rural=1 if mv102==2
tab rural
replace rural=0 if rural==.
tab rural

bysort hhid: egen tot_men_rural=sum(rural)
sum tot_men_rural

bysort hhid: g x=1 if rural==1 & mv150==1
bysort hhid: egen head_rural=max (x)
drop x

lab var head_rural "Male head in the HH - in rural"
lab var tot_men_rural "Number of men in rural area"
*/

* Collapsing at HH level
sum  mv001 mv002
collapse tot_men*  head* , by (hhid  mv001 mv002)
rename mv001 v001
rename mv002 v002
sum
/*
foreach var of varlist tot_men_work_hd head_ag_s_m head_ag_w_m head_un_m head_serv_m head_prof_m head_dom_m head_cler_m head_sales_m head_skman_m head_unskman_m head_noedu_m head_pri_m head_sec_m head_high_m   {
replace `var'=0 if `var'==.
}
sum
*/
order hhid v001 v002

save "$datadir/cleaned/HHmen_16.dta", replace
*/
*********************************************************************************************************************************
* Household members - PR for FOOD SECURITY
*********************************************************************************************************************************

use "$datadir/ETPR81DT/ETPR81FL.dta", clear
keep hhid hvidx hv001 hv002 hv003 hv004 hv005 hv007 hv021 hv022 hv023 hv024 hv025  hv101 hv103 hv104 hv105 hv106 hv107  hc70 hc71 hc72 hc73 hv270 hv271  hc57 hv006 hv007 hv008 hv009 hv220 hv219 hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215 hv247 ha5 ha11 hc1 hc56
gen v001 = hv001
gen v002 = hv002
gen v003 = hv003
sort v001 v002 v003

* ID
rename hhid hhid_dhs
tostring v001 v002,g (v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s

* STUNTING
tab hc70, nolabel
tab hc71, nolabel
tab hc72, nolabel

foreach var of varlist hc70 hc71 hc72 {
replace `var' =. if `var'==9998 |`var'==9996 | `var'==9997 |`var'==9999
}

tab hc70
gen stunted_ch = 1 if hc70<=-200
replace stunted_ch=0 if hc70>-200
replace stunted_ch= . if hc70==.
tab stunted_ch
* count if hc70 <-200
bysort hhid: egen stunting_c_hh=total(stunted_ch), missing 
lab var stunting_c_hh "Number of stunted children in the HH"

* WASTING
gen wasted_ch = 1 if hc72<=-200
replace wasted_ch=0 if hc72>-200
replace wasted_ch = . if hc72==.
tab wasted_ch
* count if hc72 <-200
bysort hhid: egen wasted_c_hh=total(wasted_ch) , missing
lab var wasted_c_hh "Number of wasted children in the HH"


* UNDERWWEIGHT
gen underwht_ch = 1 if hc71<=-200
replace underwht_ch=0 if hc71>-200
replace underwht_ch = . if hc71==.
tab underwht_ch
bysort hhid: egen underwht_ch_hh=total(underwht_ch) , missing
lab var underwht_ch_hh "Number of underweighted children in the HH"
tab underwht_ch_hh
* count if hc71 <-200
sum *c_hh 

* MODERATE AND SEVERE ANEMIA AMONG CHILDREN
gen nt_ch_sev_anem=0 if hc1>5 & hc1<60
replace nt_ch_sev_anem=1 if hc56<100 & hc1>5 & hc1<60
replace nt_ch_sev_anem=. if hc56==.
label values nt_ch_sev_anem yesno
label var nt_ch_sev_anem "Moderate/severe anemia - child 6-59 months"
bysort hhid: egen anemia_ch_hh=total(nt_ch_sev_anem), missing 
label var anemia_ch_hh "Moderate/severe anemia HH - child 6-59 months"

* Sex
tab hv104, g(sex)
bysort hhid: egen tot_men_HH=total(sex1)
bysort hhid: egen tot_wmen_HH=total(sex2)
lab var tot_men_HH "Number of men in the HH"
lab var tot_wmen_HH "Number of women in the HH"
bysort hhid:egen tot_teen15=total(hv105<16)
lab var tot_teen15 "Number of teen below 16 in the HH"

* Head educational level 
gen head_no_edu = 1 if hv101==1 & hv106==0
replace head_no_edu=0 if head_no_edu==.
gen head_primary = 1 if hv101==1 & hv106==1
replace head_primary=0 if head_primary==.
gen head_secondary = 1 if hv101==1 & hv106==2
replace head_secondary = 0 if head_secondary==.
gen head_higher=1 if hv101==1 & hv106==3
replace head_higher=0 if head_higher==.

bysort hhid: egen hh_head_no_edu =total(head_no_edu), missing
bysort hhid: egen hh_head_primary =total(head_primary), missing
bysort hhid: egen hh_head_secondary =total(head_secondary), missing
bysort hhid: egen hh_head_higher =total(head_higher), missing

* Collapsing at HH level 
collapse  v003 hv247 hv001 hv002 hv003 hv009 tot_men_HH tot_wmen_HH tot_teen15 stunted_ch stunting_c_hh wasted_ch wasted_c_hh underwht_ch underwht_ch_hh hh_head_no_edu hh_head_primary hh_head_secondary hh_head_higher anemia_ch_hh nt_ch_sev_anem, by(hhid v001 v002)
sort hhid

save "$datadir/cleaned/HH_counts_19.dta", replace

*********************************************************************************************************************************
* Children data for FOOD DIVERSITY AND FREQUENCY
*********************************************************************************************************************************
*********************************************************************************************************************************
use "$datadir/ETKR81DT/ETKR81FL.dta", clear

// Child's age 

gen age = v008 - b3
keep if _n == 1 | caseid != caseid[_n-1]

/*		
* To check if survey has b19, which should be used instead to compute age. 
scalar b19_included=1
capture confirm numeric variable b19, exact 
		if _rc>0 {
	    * b19 is not present
		scalar b19_included=0
		}
		if _rc==0 {
		* b19 is present; check for values
		summarize b19
		if r(sd)==0 | r(sd)==. {
		scalar b19_included=0
			  }
			}

		if b19_included==1 {
		drop age
		gen age=b19
		}
*/
	
* HHID
tostring v001 v002, g(v001s v002s)
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s
order hhid

// Given formula
gen nt_formula= v411a==1
label values nt_formula yesno
label var nt_formula "Child given infant formula in day/night before survey - last-born under 2 years"

// Give fortified baby food
gen nt_bbyfood= v412a==1
label values nt_bbyfood yesno 
label var nt_bbyfood "Child given fortified baby food in day/night before survey- last-born under 2 years"

// Given other milk
gen nt_milk= v411==1
label values nt_milk yesno 
label var nt_milk "Child given other milk in day/night before survey- last-born under 2 years"

// Given grains
gen nt_grains_tuber = v412a==1 | v414e==1 | v414f==1
label values nt_grains_tuber yesno 
label var nt_grains_tuber "Child given grains in day/night before survey- last-born under 2 years"

// Given Vit rich foods
gen nt_vit = v414i==1 | v414j==1 | v414k==1
label values nt_vit yesno 
label var nt_vit "Child given vitamin A rich food in day/night before survey- last-born under 2 years"

// Given other fruits or vegetables
gen nt_frtveg = v414l==1
label values nt_frtveg yesno 
label var nt_frtveg "Child given other fruits or vegetables in day/night before survey- last-born under 2 years"

// Given nuts or legumes
gen nt_nuts = v414o==1
label values nt_nuts yesno 
label var nt_nuts "Child given legumes or nuts in day/night before survey- last-born under 2 years"

// Given meat
gen nt_meat = v414h==1 | v414m==1 | v414n==1
label values nt_meat yesno 
label var nt_meat "Child given meat, fish, shellfish, or poultry in day/night before survey- last-born under 2 years"

// Given eggs
gen nt_eggs = v414g==1
label values nt_eggs yesno 
label var nt_eggs "Child given eggs in day/night before survey- last-born under 2 years"

// Given dairy
gen nt_dairy = v414p==1 | v411==1 | v411a==1
label values nt_dairy yesno 
label var nt_dairy "Child given cheese, yogurt, or other milk products in day/night before survey- last-born under 2 years"

// Given other solid or semi-solid foods
gen nt_solids= nt_bbyfood==1 | nt_grains_tuber==1 | nt_vit==1 | nt_frtveg==1 | nt_nuts==1 |  nt_eggs==1 | nt_dairy==1 | nt_meat==1
label values nt_solids yesno 
label var nt_solids "Child given any solid or semisolid food in day/night before survey- last-born under 2 years"

// Fed milk or milk products
gen totmilkf = 0
replace totmilkf=totmilkf + v411 if v411==1
replace totmilkf=totmilkf + v411a if v411a==1
replace totmilkf=totmilkf + v414p if v414p==1
gen nt_fed_milk= ( totmilkf>=2 | m4==95) if inrange(age,6,23)
label values nt_fed_milk yesno
label var nt_fed_milk "Child given milk or milk products- last-born 6-23 months"

// Min dietary diversity

	* 8 food groups
	*1. breastmilk
	gen group1= m4==95

	*2. infant formula, milk other than breast milk, cheese or yogurt or other milk products
	gen group2= nt_formula==1 | nt_milk==1 | nt_dairy==1

	*3. foods made from grains, roots, tubers, and bananas/plantains, including porridge and fortified baby food from grains
	gen group3= nt_grains_tuber==1 
	 
	*4. vitamin A-rich fruits and vegetables
	gen group4= nt_vit==1

	*5. other fruits and vegetables
	gen group5= nt_frtveg==1

	*6. eggs
	gen group6= nt_eggs==1

	*7. legumes and nuts
	gen group7= nt_nuts==1
	
	*8. meat
	gen group8= nt_meat==1

// Min dietary diversity
egen foodsum = rsum(group1 group2 group3 group4 group5 group6 group7 group8) 
recode foodsum (1/4 =0 "No") (5/8=1 "Yes"), gen(nt_mdd)
replace nt_mdd=. if age<6 | age>=24
label var nt_mdd "Child with minimum dietary diversity, 5 out of 8 food groups- last-born 6-23 months"

gen non_mdd =1 if nt_mdd==0 
replace non_mdd=0 if nt_mdd==1 
bys hhid : egen new_No_min_diet_diversity_hh = max(non_mdd) if non_mdd!=.
la var new_No_min_diet_diversity_hh "HH has at least one young child that is not fed with the min food diversity"

/*older surveys are 4 out of 7 food groups, can use code below
egen foodsum = rsum(group2 group3 group4 group5 group6 group7 group8) 
recode foodsum (1/3 .=0 "No") (4/7=1 "Yes"), gen(nt_mdd)
*/

// Min meal frequency
gen feedings=totmilkf
replace feedings= feedings + m39 if m39>0 & m39<8
gen nt_mmf = (m4==95 & inrange(m39,2,7) & inrange(age,6,8)) | (m4==95 & inrange(m39,3,7) & inrange(age,9,23)) | (m4!=95 & feedings>=4 & inrange(age,6,23))
replace nt_mmf=. if age<6 | age>=24
label var nt_mmf "Child with minimum meal frequency- last-born 6-23 months"

gen non_mmf =1 if nt_mmf==0 
replace non_mmf=0 if nt_mmf==1 
bys hhid : egen new_No_min_meal_freq_hh = max(non_mmf) if non_mmf!=.
la var new_No_min_meal_freq_hh "HH has at least one young child that is not fed min frequency"

// Min acceptable diet
egen foodsum2 = rsum(nt_grains nt_grains_tuber nt_nuts nt_meat nt_vit nt_frtveg nt_eggs)
gen nt_mad = (m4==95 & nt_mdd==1 & nt_mmf==1) | (m4!=95 & foodsum2>=4 & nt_mmf==1 & totmilkf>=2)
replace nt_mad=. if age<6 | age>=24
label values nt_mad yesno
label var nt_mad "Child with minimum acceptable diet- last-born 6-23 months"
 
gen non_mad =1 if nt_mad==0 
replace non_mad=0 if nt_mad==1 
bys hhid : egen new_No_min_acc_diet_hh = max(non_mad) if non_mad!=.
la var new_No_min_acc_diet_hh "HH has at least one young child that is not fed min acceptable diet"

count
sort hhid
collapse (max) nt_mmf nt_mdd new_No_min_diet_diversity_hh new_No_min_meal_freq_hh new_No_min_acc_diet_hh, by (hhid v001 v002)
*hh_young_ch

save "$datadir/cleaned/NEW_1_food_19.dta", replace

*********************************************************************************************************************************
* MERGING
*********************************************************************************************************************************

use "$datadir/ETPR81DT/ETPR81FL.dta", clear
keep hhid hv001 hv002 hv003 hv005 hv007 hv016 hv021 hv022 hv023 hv024 hv025 hv006 hv008 hv009  hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215 hv270  hv271  hv244 hv245 hv246 hv246a hv246c hv246d hv246e hv246f hv246g hv219 hv220

rename hv025 type_place 
rename hv024 region
gen v001 = hv001
gen v002 = hv002
gen v003 = hv003
sort v001 v002 v003


gen month = .
gen year = 2019

replace month= 3 if hv006==7 & hv016<23

replace month= 4 if hv006==7 & hv016>=23
***

replace month= 4 if  hv006==8 & hv016<23

replace month= 5 if  hv006==8 & hv016>=23
***

replace month= 5 if  hv006==9 & hv016 <24

replace month= 6 if  hv006==9 & hv016 >=24
***

replace month= 6 if  hv006==10 & hv016 <24

replace month= 7 if  hv006==10 & hv016 >=24


* ID
tostring v001 v002, g(v001s v002s)
rename hhid hhid_dhs
g hhid=v001s+v002s
replace hhid =v001s+"0"+v002s if v002<10
order hhid
destring hhid, replace
drop v001s v002s
order hhid

* Year

* Collapse
collapse hv003 hv005 hv007 hv021 hv022 hv023 hv006 hv008 hv009 type_place region hv204 hv205 hv206 hv207 hv208 hv201 hv213 hv214 hv215 year month hv270 hv271 hv244 hv245 hv246 hv246a hv246c hv246d hv246e hv246f hv246g hv219 hv220, by (hhid v001 v002 )
sort hhid 

* Merging

merge 1:1 hhid v001 v002 using "$datadir/cleaned/HHwomen_19.dta"
drop _merge

*merge 1:1 hhid v001 v002 using "$datadir/cleaned/HHmen_16.dta"
*drop _merge

merge 1:1 hhid v001 v002 using "$datadir/cleaned/HH_counts_19.dta"
drop _merge

*merge 1:1 hhid v001 v002 using "$datadir/cleaned/food_16.dta"
*drop _merge

merge 1:1 hhid v001 v002 using "$datadir/cleaned/NEW_1_food_19.dta"
drop _merge

order hhid year month
drop v001 v002 v003

*************************************************************************************************************************
* WEIGHTS
*************************************************************************************************************************

rename hv005 HH_wgt
gen wgt = HH_wgt/1000000

*************************************************************************************************************************
* LABELLING and DROPPING
*************************************************************************************************************************

label list
label values hv023 HV023
label values region HV024
label values type_place HV025
label values hv201 HV201
label values hv205 HV205
label values hv206 HV206
label values hv207 HV207
label values hv208 HV208
label values hv213 HV213
label values hv214 HV214
label values hv215 HV215
label values hv204 HV204
label values hv270 HV270
label values hv271 HV271
label values hv244 HV244 
label values hv245 HV245 
label values hv246 HV246 
label values hv246a HV246A 
label values hv246c HV246C 
label values hv246d HV246D 
label values hv246e HV246E 
label values hv246f HV246F 
label values hv246g HV246G 
label values hv219 HV219
label var hv001 "Cluster number"
label var hv002 "HH number"
label var hv003 "Respondent line number"
label var hv006 "Month of interview"
label var hv007 "Year of interview"
label var hv008 "Date interview"
label var hv009 "HH size"
label var HH_wgt "Weights DHS"
label var hv021 "Primary sampling unit"
label var hv022 "Sample struts number"
label var hv023 "Sample domain"
label var type_place "Type place of residence"
label var region "Region"
label var hv201 "Source of drinking water"
label var hv204 "Time to get water"
label var hv205 "Toilet facilities"
label var hv206 "Electricity dummy"
label var hv207 "Radio dummy"
label var hv208 "Television dummy"
label var hv213 "Main fllor material"
label var hv214 "Main wall material"
label var hv215 "Main roof material"
label var hv270 "Wealth Index"
label var hv219 "Sex head household"
rename hv270 wealth_index
label var hv271 "Wealth Index score"
rename hv271 wealth_index_score
label var hv244 "Owns agricultural land"
rename hv244 dummy_agr_land
label var hv245 "Hectares agricultural land"
rename hv245 hectares_acres_ag_land
label var hv246 "Livestock, herds and farm animals"
rename hv246 livestock
label var hv246a "Cattle"
rename hv246a cattle
label var hv246c "Horses,mules"
rename hv246c horses_mules
label var hv246d "Goats"
rename hv246d goats
label var hv246e "Sheep"
rename hv246e sheep
label var hv246f "Poultry"
rename hv246f poultry
label var hv246g "Rabbits"
rename hv246g rabbits
/*
lab var tot_wmen "Number of women in the HH"
lab var tot_wmen_ag "Number of women in agriculture"
lab var tot_wmen_Prof "Number of women in the HH - professional jobs"
lab var tot_wmen_serv "Number of women in the HH - service employment"
lab var tot_wmen_cler "Number of women in the HH - clerical employment"
lab var tot_wmen_other"Number of women in the HH - other employed"
lab var tot_wmen_skman "Number of women in the HH - skilled manual employment"
lab var tot_wmen_unskman "Number of women in the HH - unskilled manual employment"
lab var tot_wmen_un "Number of women in the HH - unemployment"
lab var tot_wmen_work "Number of women currently working in the HH"
lab var tot_wmen_work_hd "Women head(s) currently working in the HH"
lab var head_ag_wm "Female head in the HH - agriculture"
lab var head_serv_wm "Female head in the HH - services employment"
lab var head_prof_wm "Female head in the HH - Professional"
lab var head_other_wm "Female head in the HH - other employed"
lab var head_cler_wm "Female head in the HH - clerical employment"
lab var head_skman_wm "Female head in the HH - skilled manual employment"
lab var head_un_wm "Female head in the HH - unemployed"
lab var head_unskman_wm "Female head in the HH - unskilled manual employment"
*/
lab var tot_wmen_noedu "Number of women in the HH - no education"
lab var tot_wmen_pri "Number of women in the HH - primary education"
lab var tot_wmen_sec "Number of women in the HH - secondary education"
lab var tot_wmen_high "Number of women in the HH - higher education"
lab var head_noedu_wm "Women head in the HH - no education"
lab var head_pri_wm "Women head in the HH - primary education"
lab var head_sec_wm "Women head in the HH - secondary education"
lab var head_high_wm "Women head in the HH - higher education"
lab var tot_RI_Low_w "Number of women in HH with low or very low Rohrer Index"
*lab var tot_BMI_low_w "Number of women in HH with BMI <16.9 (severe or moderately thin)"
*lab var hh_young_ch "Number of children younger than 24 months in the household"
*lab var No_min_diet_diversity_hh "HH has at least one young child that is not fed with the min food diversity" 
lab var stunting_c_hh "Number of stunted children in the HH"
lab var wasted_c_hh "Number of wasted children in the HH"
lab var underwht_ch_hh "Number of underweight children in the HH"
lab var tot_men_HH "Number of men in the HH"
lab var tot_wmen_HH "Number of women in the HH"
lab var tot_teen15 "Number of teen below 16 in the HH"
/*
lab var tot_men_ag "Number of men in agriculture"
lab var tot_men_un "Number of men in the HH - unemployed"
lab var tot_men_serv "Number of men in the HH - services employment"
lab var tot_men_prof "Number of men in the HH - Professional jobs"
lab var tot_men_cler "Number of men in the HH - clerical employment"
lab var tot_men_skman "Number of men in the HH - skilled manual employment"
lab var tot_men_unskman "Number of men in the HH - ubskilled manual employment"
lab var tot_men_other "Number of men in other employment"
lab var tot_men_work "Number of men currently working in the HH"
lab var tot_men_work_hd "Male head currently working in the HH"
lab var head_ag_m "Male head in the HH - agric"
lab var head_un_m "Male head in the HH - unemployed"
lab var head_prof_m "Male head in the HH - Professional"
lab var head_cler_m "Male head in the HH - clerical employment"
lab var head_skman_m "Male head in the HH - skilled manual employment"
lab var head_unskman_m "Male head in the HH - unskilled manual employment"
lab var head_other_m "Male Head in other employment"
lab var head_serv_m "Male head in the HH - services employment"
lab var tot_men_noedu "Number of men in the HH - no education"
lab var tot_men_pri "Number of men in the HH - primary education"
lab var tot_men_sec "Number of men in the HH - secondary education"
lab var tot_men_high "Number of men in the HH - higher education"
lab var head_noedu_m "Male head in the HH - no education"
lab var head_pri_m "Male head in the HH - primary education"
lab var head_sec_m "Male head in the HH - secondary education"
lab var head_high_m "Male head in the HH - higher education"
*/
lab var wgt "Weights - to use"


save "$datadir\cleaned\final_19.dta", replace

*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
* APPENDING
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************

use "E:\WORK ROMA\African Obsevatory\Ethiopia\DHS\Complete\2000\cleaned\final_00.dta", clear
append using "E:\WORK ROMA\African Obsevatory\Ethiopia\DHS\Complete\2005\cleaned\final_05.dta"
append using "E:\WORK ROMA\African Obsevatory\Ethiopia\DHS\Complete\2011\cleaned\final_11.dta"
append using "E:\WORK ROMA\African Obsevatory\Ethiopia\DHS\Complete\2016\cleaned\final_16.dta"
append using "E:\WORK ROMA\African Obsevatory\Ethiopia\DHS\Complete\2019\cleaned\final_19.dta"

tab year
*ren hv007 year_surv
order hhid year month

lab var hv220 "Age head household"
lab var tot_wmen_ag_s "Number of women in agri-self-employed"
lab var tot_wmen_serv "Number of women in the HH - service employment"
lab var head_serv_wm "Female head in the HH - services employment"
lab var tot_men_serv "Number of men in the HH - services employment"
lab var head_serv_m "Male head in the HH - services employment"


save "E:\WORK ROMA\African Obsevatory\Ethiopia\New FAO- Alberta strategy\Final Data\Final_ROUNDS_DHS.dta", replace



*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
* MERGING WITH LOCATIONS
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************

use  "E:\WORK ROMA\African Obsevatory\Ethiopia\New FAO- Alberta strategy\Final Data\Final_ROUNDS_DHS.dta", clear
sort hv001 year month
*** problem with the year and location - first I change them to change them back after the merging. 


*usual problem with dhs year-coordinates, it contains only 2010, so I will replace it and then replace it back

*2010 have only month==12 ; while 2011 have month == 1,2,3,4,5

replace year = 2010 if year == 2011


merge m:1 hv001 year using "E:\WORK ROMA\African Obsevatory\Ethiopia\New FAO- Alberta strategy\Final Data\GPS_location_all.dta"

replace year = 2011 if year ==2010 & month!=12
sort hhid year month


drop if _merge==1
drop if _merge==2
drop _merge


rename ADM1NAME NAME_1
*encode LOC_NAME, gen(LOC_ID)
* tab2xl LOC_ID using "$datadir/LOC_DHS.xls", replace row(1) col(1) 
*drop NAME_3
*order hhid hv001 hv002 hv003 wgt HH_wgt year year_surv month_surv NAME_1 NAME_2 LOC_NAME LOC_ID type_place 
sort hhid year 

*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
* DISTRICT LEVEL VARIABLES
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************
*********************************************************************************************************************************


***head ethnicity ***


egen head_affar_etn = rowtotal(head_affar_wm head_affar_m)
egen head_amharra_etn = rowtotal(head_amharra_wm head_amharra_m)
egen head_guragie_etn = rowtotal(head_guragie_wm head_guragie_m)
egen head_oromo_etn = rowtotal(head_oromo_wm head_oromo_m)
egen head_sidama_etn = rowtotal(head_sidama_wm head_sidama_m)
egen head_somalie_etn = rowtotal(head_somalie_wm head_somalie_m)
egen head_tigray_etn = rowtotal(head_tigray_wm head_tigray_m)
egen head_welaita_etn = rowtotal(head_welaita_wm head_welaita_m)
egen head_other_ethn = rowtotal(head_other_ethn_wm head_other_ethn_m)



// MEN AND WOMEN

egen total_mw_hh = rowtotal(tot_wmen tot_men)
la var total_mw_hh "Total number men and women in the household"

egen tot_mw_agr_work_hh = rowtotal(tot_men_ag tot_wmen_ag)
la var tot_mw_agr_work_hh "Total number men and women that works in agriculture in the household" 

egen tot_mw_unemployed_hh = rowtotal(tot_men_un tot_wmen_un)
la var tot_mw_unemployed_hh "Total number unemployed men and women in the household" 

egen tot_mw_noeducation_hh = rowtotal(tot_men_noedu tot_wmen_noedu)
la var tot_mw_noeducation_hh "Total number of uneducated men and women in the household" 

egen tot_mw_work_hh = rowtotal(tot_men_work tot_wmen_work)
la var tot_mw_work_hh "Total number working men and women in the household" 

sort hhid year
*** dropping 1997 since we don't have info on food sec
*setting the svy mode on stata 
gen urban_rural = type_place 

replace urban_rural = 0 if type_place==2

rename hv009 HH_size
rename hv219 HH_head_sex
encode NAME_1, generate(NAME_1_ID)
codebook NAME_1_ID
rename hv220 HH_head_age


replace HH_head_sex = 0 if HH_head_sex ==2 

la define HH_head_sex 0"female" 1"male"
la values HH_head_sex HH_head_sex 
replace HH_head_sex =. if HH_head_sex!=1 & HH_head_sex!=0

* tot_RI_Low_w tot_BMI_low_w stunting_c_hh wasted_c_hh No_min_meal_freq_hh No_min_diet_diversity_hh battles_12f explosions_remote_violence_12f protests_12f riots_12f strategic_developments_12f violence_against_civilians_12f total_conflicts_12f {
*** creating dummy variables for food security 

gen Low_RI_dummy = 1 if tot_RI_Low_w > 0 & tot_RI_Low_w !=. 
replace Low_RI_dummy = 0 if tot_RI_Low_w == 0


gen Low_BMI_dummy = 1 if DHS_tot_BMI_low_w > 0 & DHS_tot_BMI_low_w !=. 
replace Low_BMI_dummy = 0 if DHS_tot_BMI_low_w == 0

gen stunting_ch_dummy = 1 if stunting_c_hh > 0 & stunting_c_hh !=. 
replace stunting_ch_dummy = 0 if stunting_c_hh == 0

gen wasted_ch_dummy = 1 if wasted_c_hh > 0 & wasted_c_hh !=. 
replace wasted_ch_dummy = 0 if wasted_c_hh == 0

**** fixing hectares ***

 replace hectares_acres_ag_land = 0 if  dummy_agr_land == 0 

gen very_poor_hh = 0 
replace very_poor_hh = 1 if wealth_index == 1
label var very_poor_hh "Very poor households"

rename hv204 dist_water_time
rename hv201 source_drink_water
rename hv206 access_electricity
rename hv247 bank_account
replace bank_account = . if bank_account == 8  
gen dummy_agri_work = 1 if tot_mw_agr_work_hh >=1 & tot_mw_agr_work_hh!=.
replace dummy_agri_work =0 if tot_mw_agr_work_hh ==0

gen dummy_wm_unemployed = 1 if tot_wmen_un >=1 & tot_wmen_un!=.
replace dummy_wm_unemployed =0 if tot_wmen_un ==0

gen dummy_wm_work = 1 if tot_wmen_work >=1 & tot_wmen_work!=.
replace dummy_wm_work =0 if tot_wmen_work ==0

gen head_working_age = 0 
replace head_working_age = 1 if HH_head_age >= 15 & HH_head_age <= 64 

replace hectares_acres_ag_land = . if hectares_acres_ag_land == 998
replace dist_water_time = 0 if dist_water_time == 996
replace dist_water_time = . if dist_water_time == 998 | dist_water_time == 999

gen underch_dummy = 1 if underwht_ch_hh >=1 & underwht_ch_hh!=.
replace underch_dummy =0 if underwht_ch_hh ==0


save "E:\WORK ROMA\African Obsevatory\Ethiopia\New FAO- Alberta strategy\Final Data\NEW_final_ANALYSIS.dta", replace


ex 


*** create dataset for compute conflict 


keep hv001 year month LATNUM LONGNUM 

duplicates drop 

sort  year month hv001 LATNUM LONGNUM


gen quarter= 1 if month<=3
replace quarter =2 if month>3 & month<=6
replace quarter =3 if month>6 & month<=9
replace quarter =4 if month>9 & month<=12

drop if LATNUM ==0 | LONGNUM==0 

save "E:\WORK ROMA\African Obsevatory\Ethiopia\New FAO- Alberta strategy\Final Data\GPS_DHS_year_month.dta", replace


