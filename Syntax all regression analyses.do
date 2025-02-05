* survival Analyses 2014 -2019
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2014-2019_Final.dta", clear
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
drop N measurement_postalcode CLRTI_yes lagged_variable id_count tag newv2 newv NN DEELSCOREWELVAART* DEELSCOREARBEID* DEELSCOREOPLEIDINGSNIVEAU* diff_Hospitalisation* merge_mortality huishouden1_2018 huishouden2_2018 huishouden3_2018 huishouden4_2018 huishouden5_2018 huishouden6_2018 huishouden7_2018 huishouden8_2018 huishouden9_2018 huishouden10_2018 huishouden11_2018 huishouden12_2018 huishouden13_2018 huishouden14_2018 INHP100HBEST INHP100HGEST20* INHP100HPRIM VEHP100WELVAART20* VEHP100HVERM20* VEHW1000VERH20*
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace
* splitsen europa in oost europees
recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2

*leeftijdscategorie
gen age = (Exposure - birthday)/365.25
drop if age > 80
gen age_category = .
recode age_category (.=1) if (age >= 18 & age < 50)
recode age_category (.=2) if (age >= 50 & age < 60)
recode age_category (.=3) if (age >= 60 & age < 70)
recode age_category (.=4) if (age >= 70 & age <= 80)

/*tijd meenemen! seizoen en kwartaal*/
gen seizoen = 1314 if jaar==2014 & (kwartaal==1 | kwartaal==2)
replace seizoen = 1415 if (jaar==2014 & (kwartaal ==3 | kwartaal==4)) | (jaar==2015 & (kwartaal==1| kwartaal==2))
replace seizoen = 1516 if (jaar==2015 & (kwartaal ==3 | kwartaal==4)) | (jaar==2016 & (kwartaal==1| kwartaal==2))
replace seizoen = 1617 if (jaar==2016 & (kwartaal ==3 | kwartaal==4)) | (jaar==2017 & (kwartaal==1| kwartaal==2))
replace seizoen = 1718 if (jaar==2017 & (kwartaal ==3 | kwartaal==4)) | (jaar==2018 & (kwartaal==1| kwartaal==2))
replace seizoen = 1819 if (jaar==2018 & (kwartaal ==3 | kwartaal==4)) | (jaar==2019 & (kwartaal==1| kwartaal==2))
replace seizoen = 1920 if (jaar==2019 & (kwartaal ==3 | kwartaal==4))

* Variabele voor al eerder doorgemaakte infectie

gen recurrent_infection = .
sort rinpersoon CLRTI Exposure
by rinpersoon CLRTI: gen N = _n if CLRTI == 1
tab N
by rinpersoon: gen lagged_seizoen = seizoen[_n-1] if N > 1 & rinpersoon == rinpersoon[_n-1]
recode recurrent_infection (.=1) if N == 2 & (seizoen == lagged_seizoen)
recode recurrent_infection (.=1) if N == 3 & (seizoen == lagged_seizoen)
recode recurrent_infection (.=1) if N == 4 & (seizoen == lagged_seizoen)
recode recurrent_infection (.=0)

egen ever_CLRTI =  max(CLRTI), by(rinpersoon)
egen number_CLRTI = max(N), by(rinpersoon)
gen date_CLRTI1 = BeginCLRTI if CLRTI==1 & N==1
gen date_CLRTI2 = BeginCLRTI if CLRTI==1 & N==2
gen date_CLRTI3 = BeginCLRTI if CLRTI==1 & N==3
gen date_CLRTI4 = BeginCLRTI if CLRTI==1 & N==4

egen date_CLRTI1_2 = max(date_CLRTI1), by(rinpersoon)
egen date_CLRTI2_2 = max(date_CLRTI2), by(rinpersoon)
egen date_CLRTI3_2 = max(date_CLRTI3), by(rinpersoon)
egen date_CLRTI4_2 = max(date_CLRTI4), by(rinpersoon)

format date_CLRTI1_2 %td
format date_CLRTI2_2 %td
format date_CLRTI3_2 %td
format date_CLRTI4_2 %td

gen diff_prev_CLRTI1 = Exposure - date_CLRTI1_2
gen diff_prev_CLRTI2 = Exposure - date_CLRTI2_2
gen diff_prev_CLRTI3 = Exposure - date_CLRTI3_2
gen diff_prev_CLRTI4 = Exposure - date_CLRTI4_2

gen previous_CLRTI = 0 if ever_CLRTI==0
replace previous_CLRTI = 1 if diff_prev_CLRTI1>1 & diff_prev_CLRTI1!=.
replace previous_CLRTI = 0 if diff_prev_CLRTI1<0 & diff_prev_CLRTI1!=.

foreach n of numlist 1/4 {
	gen years_since_CLRTI`n' = 1 if previous_CLRTI==1 & diff_prev_CLRTI`n'<=365 & diff_prev_CLRTI`n'>0
	replace years_since_CLRTI`n' = 2 if previous_CLRTI==1 & diff_prev_CLRTI`n'>365 & diff_prev_CLRTI`n'<=730
	replace years_since_CLRTI`n' = 3 if previous_CLRTI==1 & diff_prev_CLRTI`n'>730 & diff_prev_CLRTI`n'<=1095
	replace years_since_CLRTI`n' = 4 if previous_CLRTI==1 & diff_prev_CLRTI`n'>1095 & diff_prev_CLRTI`n'<=1460
	replace years_since_CLRTI`n' = 5 if previous_CLRTI==1 & diff_prev_CLRTI`n'>1460 & diff_prev_CLRTI`n'<=1825
	replace years_since_CLRTI`n' = 6 if previous_CLRTI==1 & diff_prev_CLRTI`n'>1825 & diff_prev_CLRTI`n'<=2190
}

egen years_since_last_CLRTI = rowmin(years_since_CLRTI1 years_since_CLRTI2 years_since_CLRTI3 years_since_CLRTI4)

gen CLRTI_in_past_year = 1 if previous_CLRTI==1 & years_since_last_CLRTI==1
replace CLRTI_in_past_year = 0 if CLRTI_in_past_year==.

drop lagged_seizoen date_CLRTI* diff_prev_CLRTI* years_since_CLRTI*

* assessing mean and variance
summarize _d, detail


*Univariable association
gen interval = (_t - _t0)

*SES/welvaart in kwintielen
*xtile Welvaart_quintiles = Welvaart, nq(5)
gen Welvaart_quintiles_reversed = .
recode Welvaart_quintiles_reversed (.=1) if (Welvaart > 80 & Welvaart <= 100)
recode Welvaart_quintiles_reversed (.=2) if (Welvaart > 60 & Welvaart <= 80)
recode Welvaart_quintiles_reversed (.=3) if (Welvaart > 40 & Welvaart <= 60)
recode Welvaart_quintiles_reversed (.=4) if (Welvaart > 20 & Welvaart <= 40)
recode Welvaart_quintiles_reversed (.=5) if (Welvaart > 0 & Welvaart <= 20)

*door met poisson regressie
poisson _d i.age_category, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(age_cat) stats(mean v n)

poisson _d i.gbageslacht, exposure(interval) vce(cluster rinpersoon) irr nolog
*niet significant
tabstat _d, by(gbageslacht) stats(mean v n)

poisson _d i.huishouden, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(huishouden) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Migratieachtergrond, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Migratieachtergrond) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Migratieachtergrond, exposure(interval) vce(robust) irr nolog
poisson _d i.Migratieachtergrond i.age_category, exposure(interval) vce(robust) irr nolog
poisson _d i.Migratieachtergrond i.age_category i.gbageslacht, exposure(interval) vce(robust) irr nolog
poisson _d i.Migratieachtergrond i.age_category i.gbageslacht i.Migratieachtergrond##i.gbageslacht, exposure(interval) vce(robust) irr nolog
poisson _d i.Migratieachtergrond i.age_category i.gbageslacht i.Migratieachtergrond##i.age_category, exposure(interval) vce(robust) irr nolog
poisson _d i.Migratieachtergrond i.age_category i.Welvaart_quintiles_reversed, exposure(interval) vce(robust) irr nolog
poisson _d i.Migratieachtergrond i.age_category i.Welvaart_quintiles_reversed i.Migratieachtergrond##i.Welvaart_quintiles_reversed, exposure(interval) vce(robust) irr nolog
margins Migratieachtergrond#Welvaart_quintiles_reversed
poisson _d i.age_category i.Welvaart_quintiles_reversed if Migratieachtergrond==4, exposure(interval) vce(robust) irr nolog
poisson _d i.age_category i.Welvaart_quintiles_reversed if Migratieachtergrond==4 | Migratieachtergrond==3 | Migratieachtergrond==5, exposure(interval) vce(robust) irr nolog
poisson _d i.Migratieachtergrond i.age_category i.gbageslacht i.Welvaart_quintiles_reversed, exposure(interval) vce(cluster rinpersoon) irr nolog
poisson _d i.Migratieachtergrond i.age_category i.gbageslacht i.Welvaart_quintiles_reversed Migratieachtergrond##Welvaart_quintiles_reversed, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic


bysort age_category: sum age, d

poisson _d i.Welvaart_quintiles_reversed, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Welvaart_quintiles_reversed) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Neoplastic_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Neoplastic_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Liver_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Liver_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Congestive_HF, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Congestive_HF) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Cerebrovascular_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Cerebrovascular_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Renal_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Renal_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Pulmonary_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Pulmonary_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Dementia, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Dementia	) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Neurologic_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Neurologic_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Diabetes, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Diabetes) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.HIV, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(HIV) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Immunocompromised, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Immunocompromised) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Cardiovascular_Disease_other, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(Cardiovascular_Disease_other) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.kwartaal, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(kwartaal) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.seizoen, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(seizoen) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(CLRTI_in_past_year) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.previous_CLRTI, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(previous_CLRTI) stats(mean v n)
/*conditional mean en variance hetzelfde*/

*multivariabel (backwards selection) (estat ic to compare model fit according to AIC)

*full model
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.kwartaal i.seizoen i.CLRTI_in_past_year, exposure(interval) vce(robust) irr nolog

/*cluster on rinpersoon*/
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.kwartaal i.seizoen i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog

*full model (only first episode)
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.kwartaal i.seizoen if previous_CLRTI==0, exposure(interval) vce(cluster rinpersoon) irr nolog
* vergelijkbare resultaten

*definitieve multivariabel model
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.kwartaal i.seizoen i.CLRTI_in_past_year, exposure(interval) vce(robust) irr
*goodness of fit for assumptions 
estat gof

/* Definitive poisson regression models
1. univariable models described above
2. multivariable model with structural determinants
3. multivariable with all determinants
*/
*2
poisson _d i.Migratieachtergrond i.age_category i.gbageslacht i.Welvaart_quintiles_reversed i.kwartaal i.seizoen i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic

*3
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.kwartaal i.seizoen i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic

*check influence of multimorbidity
gen multimorbidity = .
egen count_comorbidity = rowtotal(Neoplastic_Disease Liver_Disease Congestive_HF Cerebrovascular_Disease Renal_Disease Pulmonary_Disease Dementia Neurologic_Disease Diabetes HIV Cardiovascular_Disease_other)
replace multimorbidity = 1 if count_comorbidity > 1
recode multimorbidity (.=0)
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.multimorbidity i.huishouden i.Migratieachtergrond i.kwartaal i.seizoen i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic


* Migration background Dutch vs Non-Dutch en Suriname, Turkije, Marokko
gen DvsnonD = .
* Nederland
replace DvsnonD = 1 if Migratieachtergrond == 1
* Migratieachtergrond - Turkije Marokko Suriname
replace DvsnonD = 5 if Migratieachtergrond != 1
* Turkije
replace DvsnonD = 2 if Migratieachtergrond == 3
* Marokko
replace DvsnonD = 3 if Migratieachtergrond == 4
*Suriname
replace DvsnonD = 4 if Migratieachtergrond == 5

*interaction age migrationbackground?
poisson _d i.kwartaal i.seizoen i.Welvaart_quintiles_reversed i.gbageslacht i.age_category i.DvsnonD i.age_category##i.DvsnonD i.huishouden i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic

*interaction migration background ses?
poisson _d i.kwartaal i.seizoen i.Welvaart_quintiles_reversed i.gbageslacht i.age_category i.DvsnonD i.Welvaart_quintiles_reversed##i.DvsnonD i.huishouden i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic

*SES and Migration background seperately to assess the independent effects
poisson _d i.kwartaal i.seizoen i.gbageslacht i.age_category i.huishouden i.Migratieachtergrond i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic

poisson _d i.kwartaal i.seizoen i.Welvaart_quintiles_reversed i.gbageslacht i.age_category i.huishouden i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic

* stratified for age and sex
poisson _d i.kwartaal i.seizoen i.gbageslacht i.Welvaart_quintiles_reversed i.Migratieachtergrond i.huishouden i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other, exposure(interval) vce(cluster rinpersoon) irr strata(age_category) nolog
estat ic

poisson _d i.kwartaal i.seizoen i.age_category i.Welvaart_quintiles_reversed i.Migratieachtergrond  i.huishouden i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other, exposure(interval) vce(cluster rinpersoon) irrstrata(gbageslacht) nolog
estat ic
 

****************************************************************************
*mortality 2014 - 2019
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2014-2019_Final.dta", clear
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
drop N measurement_postalcode CLRTI_yes lagged_variable id_count tag newv2 newv NN DEELSCOREWELVAART* DEELSCOREARBEID* DEELSCOREOPLEIDINGSNIVEAU* diff_Hospitalisation* merge_mortality huishouden1_2018 huishouden2_2018 huishouden3_2018 huishouden4_2018 huishouden5_2018 huishouden6_2018 huishouden7_2018 huishouden8_2018 huishouden9_2018 huishouden10_2018 huishouden11_2018 huishouden12_2018 huishouden13_2018 huishouden14_2018 INHP100HBEST INHP100HGEST20* INHP100HPRIM VEHP100WELVAART20* VEHP100HVERM20* VEHW1000VERH20*
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace
* splitsen europa in oost europees
recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2
generate diff_mortality = overlijdensdatum - BeginCLRTI
generate LRTI_mortality = .
replace LRTI_mortality = 1 if diff_mortality < 30 & CLRTI_cause != 1
replace LRTI_mortality = 1 if CLRTI_cause == 1 & BeginCLRTI == .
replace LRTI_mortality = 0 if CLRTI == 0

*onbekende doodsoorzaken R99 meenemen
*bysort rinpersoon doodsoorzaak: gen P = _n
*replace LRTI_mortality = 1 if doodsoorzaak == 467  & P == 1

*adding covariable for season
gen seizoen = 1314 if jaar==2014 & (kwartaal==1 | kwartaal==2)
replace seizoen = 1415 if (jaar==2014 & (kwartaal ==3 | kwartaal==4)) | (jaar==2015 & (kwartaal==1| kwartaal==2))
replace seizoen = 1516 if (jaar==2015 & (kwartaal ==3 | kwartaal==4)) | (jaar==2016 & (kwartaal==1| kwartaal==2))
replace seizoen = 1617 if (jaar==2016 & (kwartaal ==3 | kwartaal==4)) | (jaar==2017 & (kwartaal==1| kwartaal==2))
replace seizoen = 1718 if (jaar==2017 & (kwartaal ==3 | kwartaal==4)) | (jaar==2018 & (kwartaal==1| kwartaal==2))
replace seizoen = 1819 if (jaar==2018 & (kwartaal ==3 | kwartaal==4)) | (jaar==2019 & (kwartaal==1| kwartaal==2))
replace seizoen = 1920 if (jaar==2019 & (kwartaal ==3 | kwartaal==4))


* Variable for CLRTI in the ast year
gen recurrent_infection = .
sort rinpersoon CLRTI Exposure
by rinpersoon CLRTI: gen N = _n if CLRTI == 1
tab N

egen ever_CLRTI =  max(CLRTI), by(rinpersoon)
egen number_CLRTI = max(N), by(rinpersoon)
gen date_CLRTI1 = BeginCLRTI if CLRTI==1 & N==1
gen date_CLRTI2 = BeginCLRTI if CLRTI==1 & N==2
gen date_CLRTI3 = BeginCLRTI if CLRTI==1 & N==3
gen date_CLRTI4 = BeginCLRTI if CLRTI==1 & N==4

egen date_CLRTI1_2 = max(date_CLRTI1), by(rinpersoon)
egen date_CLRTI2_2 = max(date_CLRTI2), by(rinpersoon)
egen date_CLRTI3_2 = max(date_CLRTI3), by(rinpersoon)
egen date_CLRTI4_2 = max(date_CLRTI4), by(rinpersoon)

format date_CLRTI1_2 %td
format date_CLRTI2_2 %td
format date_CLRTI3_2 %td
format date_CLRTI4_2 %td

gen diff_prev_CLRTI1 = Exposure - date_CLRTI1_2
gen diff_prev_CLRTI2 = Exposure - date_CLRTI2_2
gen diff_prev_CLRTI3 = Exposure - date_CLRTI3_2
gen diff_prev_CLRTI4 = Exposure - date_CLRTI4_2

gen previous_CLRTI = 0 if ever_CLRTI==0
replace previous_CLRTI = 1 if diff_prev_CLRTI1>1 & diff_prev_CLRTI1!=.
replace previous_CLRTI = 0 if diff_prev_CLRTI1<0 & diff_prev_CLRTI1!=.

foreach n of numlist 1/4 {
	gen years_since_CLRTI`n' = 1 if previous_CLRTI==1 & diff_prev_CLRTI`n'<=365 & diff_prev_CLRTI`n'>0
	replace years_since_CLRTI`n' = 2 if previous_CLRTI==1 & diff_prev_CLRTI`n'>365 & diff_prev_CLRTI`n'<=730
	replace years_since_CLRTI`n' = 3 if previous_CLRTI==1 & diff_prev_CLRTI`n'>730 & diff_prev_CLRTI`n'<=1095
	replace years_since_CLRTI`n' = 4 if previous_CLRTI==1 & diff_prev_CLRTI`n'>1095 & diff_prev_CLRTI`n'<=1460
	replace years_since_CLRTI`n' = 5 if previous_CLRTI==1 & diff_prev_CLRTI`n'>1460 & diff_prev_CLRTI`n'<=1825
	replace years_since_CLRTI`n' = 6 if previous_CLRTI==1 & diff_prev_CLRTI`n'>1825 & diff_prev_CLRTI`n'<=2190
}

egen years_since_last_CLRTI = rowmin(years_since_CLRTI1 years_since_CLRTI2 years_since_CLRTI3 years_since_CLRTI4)

gen CLRTI_in_past_year = 1 if previous_CLRTI==1 & years_since_last_CLRTI==1
replace CLRTI_in_past_year = 0 if CLRTI_in_past_year==.

drop date_CLRTI* diff_prev_CLRTI* years_since_CLRTI*

stset date_end_exposure, failure(LRTI_mortality==1) origin(time Exposure) time0(Exposure) id(rinpersoon) scale(365.25)


gen age = (Exposure - birthday)/365.25
drop if age > 80
gen age_category = .
recode age_category (.=1) if (age >= 18 & age < 50)
recode age_category (.=2) if (age >= 50 & age < 60)
recode age_category (.=3) if (age >= 60 & age < 70)
recode age_category (.=4) if (age >= 70 & age <= 80)


*Univariable association
gen interval = (_t - _t0)

*SES/welvaart in kwintielen
gen Welvaart_quintiles_reversed = .
recode Welvaart_quintiles_reversed (.=1) if (Welvaart > 80 & Welvaart <= 100)
recode Welvaart_quintiles_reversed (.=2) if (Welvaart > 60 & Welvaart <= 80)
recode Welvaart_quintiles_reversed (.=3) if (Welvaart > 40 & Welvaart <= 60)
recode Welvaart_quintiles_reversed (.=4) if (Welvaart > 20 & Welvaart <= 40)
recode Welvaart_quintiles_reversed (.=5) if (Welvaart > 0 & Welvaart <= 20)

*Univariabel
poisson _d ib4.age_category, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(age_cat) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.gbageslacht, exposure(interval) vce(cluster rinpersoon) irr nolog
*niet significant
tabstat _d, by(gbageslacht) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.huishouden, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(huishouden) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Migratieachtergrond, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Migratieachtergrond) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Welvaart_quintiles_reversed, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Welvaart_quintiles_reversed) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Neoplastic_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Neoplastic_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Liver_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Liver_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Congestive_HF, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Congestive_HF) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Cerebrovascular_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Cerebrovascular_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Renal_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Renal_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Pulmonary_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Pulmonary_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Dementia, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Dementia	) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Neurologic_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Neurologic_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Diabetes, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Diabetes) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.HIV, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(HIV) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Immunocompromised, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Immunocompromised) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Cardiovascular_Disease_other, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(Cardiovascular_Disease_other) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.kwartaal, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(kwartaal) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.seizoen, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(seizoen) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(CLRTI_in_past_year) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.previous_CLRTI, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(previous_CLRTI) stats(mean v n)
/*conditional mean en variance hetzelfde*/

*multivariabel (backwards selection for time purposes)
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.kwartaal i.seizoen i.CLRTI_in_past_year, exposure(interval) vce(robust) irr

*cluster voor rinpersoon
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.kwartaal i.seizoen i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog

* gestratificeerd voor leeftijd 
stcox i.gbageslacht i.Welvaart_quintiles_reversed i.Migratieachtergrond i.huishouden i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.kwartaal i.seizoen i.CLRTI_in_past_year, vce(robust) strata(age_category) nolog
*gestratificeerd voor geslacht
stcox i.kwartaal i.seizoen i.age_category i.Welvaart_quintiles_reversed i.Migratieachtergrond  i.huishouden i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.CLRTI_in_past_year, vce(robust) strata(gbageslacht) nolog

*full model
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.kwartaal i.seizoen i.CLRTI_in_past_year, exposure(interval) vce(robust) irr nolog

/*cluster on rinpersoon*/
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.kwartaal i.seizoen i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic 

/*without CLRTI in past year*/
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.kwartaal i.seizoen, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic


/* Definitive poisson regression models
1. univariable models described above
2. multivariable model with structural determinants
3. multivariable with all determinants
*/
*2
poisson _d i.Migratieachtergrond ib4.age_category i.gbageslacht i.Welvaart_quintiles_reversed i.kwartaal i.seizoen i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic

*3
poisson _d i.gbageslacht ib4.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.kwartaal i.seizoen i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic


*******************************************************************************
*survival Analyses 2020
*linken cases 2019 voor CLRTI in past year 
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2014-2019_Final.dta", clear
keep rinpersoon rinpersoons Exposure CLRTI BeginCLRTI birthday
keep if CLRTI == 1 & Exposure >= date("20190101", "YMD")
sort rinpersoon rinpersoons
append using "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2020_Final.dta"

save "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2020_Final.dta", replace

* Comorbiditeit
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2014\Survival2014.dta", clear
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\Survival2015.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2016\Survival2016.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2017\Survival2017.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2018\Survival2018.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\Survival2019.dta"
drop _merge
keep rinpersoons rinpersoon Neoplastic_Disease* Liver_Disease* Congestive_HF* Cerebrovascular_Disease* Renal_Disease* Pulmonary_Disease* Dementia* Neurologic_Disease* Diabetes* HIV* Immunocompromised* Cardiovascular_Disease_other* 
destring rinpersoon, replace
merge 1:m rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2020_Final.dta"
drop if _merge == 1
drop _merge
replace Neoplastic_Disease = 1 if (Neoplastic_Disease2014 == 1 | Neoplastic_Disease2015 == 1 | Neoplastic_Disease2016 == 1 | Neoplastic_Disease2017 == 1 | Neoplastic_Disease2018 == 1 | Neoplastic_Disease2019 == 1)
replace Liver_Disease = 1 if (Liver_Disease2014 == 1 | Liver_Disease2015 == 1 | Liver_Disease2016 == 1 | Liver_Disease2017 == 1 | Liver_Disease2018 == 1 | Liver_Disease2019 == 1)
replace Congestive_HF = 1 if (Congestive_HF2014 == 1 | Congestive_HF2015 == 1 | Congestive_HF2016 == 1 | Congestive_HF2017 == 1 | Congestive_HF2018 == 1 | Congestive_HF2019 == 1)
replace Cerebrovascular_Disease = 1 if (Cerebrovascular_Disease2014 == 1 | Cerebrovascular_Disease2015 == 1 | Cerebrovascular_Disease2016 == 1 | Cerebrovascular_Disease2017 == 1 | Cerebrovascular_Disease2018 == 1 | Cerebrovascular_Disease2019 == 1)
replace Renal_Disease = 1 if (Renal_Disease2014 == 1 | Renal_Disease2015 == 1 | Renal_Disease2016 == 1 | Renal_Disease2017 == 1 | Renal_Disease2018 == 1 | Renal_Disease2019 == 1)
replace Pulmonary_Disease = 1 if (Pulmonary_Disease2014 == 1 | Pulmonary_Disease2015 == 1 | Pulmonary_Disease2016 == 1 | Pulmonary_Disease2017 == 1 | Pulmonary_Disease2018 == 1 | Pulmonary_Disease2019 == 1)
replace Dementia = 1 if (Dementia2014 == 1 | Dementia2015 == 1 | Dementia2016 == 1 | Dementia2017 == 1 | Dementia2018 == 1 | Dementia2019 == 1)
replace Neurologic_Disease = 1 if (Neurologic_Disease2014 == 1 | Neurologic_Disease2015 == 1 | Neurologic_Disease2016 == 1 | Neurologic_Disease2017 == 1 | Neurologic_Disease2018 == 1 | Neurologic_Disease2019 == 1)
replace Diabetes = 1 if (Diabetes2014 == 1 | Diabetes2015 == 1 | Diabetes2016 == 1 | Diabetes2017 == 1 | Diabetes2018 == 1 | Diabetes2019 == 1)
replace HIV = 1 if (HIV2014 == 1 | HIV2015 == 1 | HIV2016 == 1 | HIV2017 == 1 | HIV2018 == 1 | HIV2019 == 1)
replace Cardiovascular_Disease_other = 1 if (Cardiovascular_Disease_other2014 == 1 | Cardiovascular_Disease_other2015 == 1 | Cardiovascular_Disease_other2016 == 1 | Cardiovascular_Disease_other2017 == 1 | Cardiovascular_Disease_other2018 == 1 | Cardiovascular_Disease_other2019 == 1)
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace
* splitsen europa in oost europees
recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2

*leeftijdscategorie
gen age = (Exposure - birthday)/365.25

drop if age > 80
gen age_category = .
recode age_category (.=1) if (age >= 18 & age < 50)
recode age_category (.=2) if (age >= 50 & age < 60)
recode age_category (.=3) if (age >= 60 & age < 70)
recode age_category (.=4) if (age >= 70 & age <= 80)

*variabele voor eerdere infectie
*voor al doorgemaakte infectie
gen recurrent_infection = .
sort rinpersoon CLRTI Exposure
by rinpersoon CLRTI: gen N = _n if CLRTI == 1
tab N

egen ever_CLRTI =  max(CLRTI), by(rinpersoon)
egen number_CLRTI = max(N), by(rinpersoon)
gen date_CLRTI1 = BeginCLRTI if CLRTI==1 & N==1
gen date_CLRTI2 = BeginCLRTI if CLRTI==1 & N==2
gen date_CLRTI3 = BeginCLRTI if CLRTI==1 & N==3
gen date_CLRTI4 = BeginCLRTI if CLRTI==1 & N==4

egen date_CLRTI1_2 = max(date_CLRTI1), by(rinpersoon)
egen date_CLRTI2_2 = max(date_CLRTI2), by(rinpersoon)
egen date_CLRTI3_2 = max(date_CLRTI3), by(rinpersoon)
egen date_CLRTI4_2 = max(date_CLRTI4), by(rinpersoon)

format date_CLRTI1_2 %td
format date_CLRTI2_2 %td
format date_CLRTI3_2 %td
format date_CLRTI4_2 %td

gen diff_prev_CLRTI1 = Exposure - date_CLRTI1_2
gen diff_prev_CLRTI2 = Exposure - date_CLRTI2_2
gen diff_prev_CLRTI3 = Exposure - date_CLRTI3_2
gen diff_prev_CLRTI4 = Exposure - date_CLRTI4_2

gen previous_CLRTI = 0 if ever_CLRTI==0
replace previous_CLRTI = 1 if diff_prev_CLRTI1>1 & diff_prev_CLRTI1!=.
replace previous_CLRTI = 0 if diff_prev_CLRTI1<0 & diff_prev_CLRTI1!=.

foreach n of numlist 1/4 {
	gen years_since_CLRTI`n' = 1 if previous_CLRTI==1 & diff_prev_CLRTI`n'<=365 & diff_prev_CLRTI`n'>0
	replace years_since_CLRTI`n' = 2 if previous_CLRTI==1 & diff_prev_CLRTI`n'>365 & diff_prev_CLRTI`n'<=730
	replace years_since_CLRTI`n' = 3 if previous_CLRTI==1 & diff_prev_CLRTI`n'>730 & diff_prev_CLRTI`n'<=1095
	replace years_since_CLRTI`n' = 4 if previous_CLRTI==1 & diff_prev_CLRTI`n'>1095 & diff_prev_CLRTI`n'<=1460
	replace years_since_CLRTI`n' = 5 if previous_CLRTI==1 & diff_prev_CLRTI`n'>1460 & diff_prev_CLRTI`n'<=1825
	replace years_since_CLRTI`n' = 6 if previous_CLRTI==1 & diff_prev_CLRTI`n'>1825 & diff_prev_CLRTI`n'<=2190
}

egen years_since_last_CLRTI = rowmin(years_since_CLRTI1 years_since_CLRTI2 years_since_CLRTI3 years_since_CLRTI4)

gen CLRTI_in_past_year = 1 if previous_CLRTI==1 & years_since_last_CLRTI==1
replace CLRTI_in_past_year = 0 if CLRTI_in_past_year==.

drop if Exposure<date("20200101", "YMD")

*SES in quintiles
gen Welvaart_quintiles_reversed = .
recode Welvaart_quintiles_reversed (.=1) if (Welvaart > 80 & Welvaart <= 100)
recode Welvaart_quintiles_reversed (.=2) if (Welvaart > 60 & Welvaart <= 80)
recode Welvaart_quintiles_reversed (.=3) if (Welvaart > 40 & Welvaart <= 60)
recode Welvaart_quintiles_reversed (.=4) if (Welvaart > 20 & Welvaart <= 40)
recode Welvaart_quintiles_reversed (.=5) if (Welvaart > 0 & Welvaart <= 20)
* interval voor exposure
gen interval = (_t - _t0)

*door met poisson regressie
poisson _d i.age_category, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(age_cat) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.gbageslacht, exposure(interval) vce(cluster rinpersoon) irr nolog
*niet significant
tabstat _d, by(gbageslacht) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.huishouden, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(huishouden) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Migratieachtergrond, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Migratieachtergrond) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Welvaart_quintiles_reversed, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Welvaart_quintiles_reversed) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Neoplastic_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Neoplastic_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Liver_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Liver_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Congestive_HF, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Congestive_HF) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Cerebrovascular_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Cerebrovascular_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Renal_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Renal_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Pulmonary_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Pulmonary_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Dementia, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Dementia	) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Neurologic_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Neurologic_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Diabetes, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Diabetes) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.HIV, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(HIV) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Immunocompromised, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Immunocompromised) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Cardiovascular_Disease_other, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(Cardiovascular_Disease_other) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.kwartaal, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(kwartaal) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(CLRTI_in_past_year) stats(mean v n)
/*conditional mean en variance hetzelfde*/

/* Definitive poisson regression models
1. univariable models described above
2. multivariable model with structural determinants
3. multivariable with all determinants
*/

*multivariabel 
*2 SES, Migratieachtergrond CLRTI
poisson _d i.Migratieachtergrond i.age_category i.gbageslacht i.Welvaart_quintiles_reversed i.kwartaal i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic

*3 cluster rinpersoon multivariabel volledig model
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.kwartaal i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic

*multimorbidity in plaats van losse comorbiditeit
gen multimorbidity = .
egen count_comorbidity = rowtotal(Neoplastic_Disease Liver_Disease Congestive_HF Cerebrovascular_Disease Renal_Disease Pulmonary_Disease Dementia Neurologic_Disease Diabetes HIV Cardiovascular_Disease_other)
replace multimorbidity = 1 if count_comorbidity > 1
recode multimorbidity (.=0)
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.multimorbidity i.huishouden i.Migratieachtergrond i.kwartaal i.seizoen i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic

*interactieterm migratie leeftijd
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.Migratieachtergrond#i.age_category i.kwartaal i.previous_CLRTI, exposure(interval) vce(robust) irr
estat ic

*interactieterm migratie geslacht
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.Migratieachtergrond#i.gbageslacht i.kwartaal i.previous_CLRTI, exposure(interval) vce(robust) irr
estat ic

*interactieterm migratie SES
poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.Migratieachtergrond#i.Welvaart_quintiles_reversed i.kwartaal i.previous_CLRTI, exposure(interval) vce(robust) irr
estat ic

*SES met migratieachtergrond om relatie te onderzoeken
poisson _d i.Welvaart_quintiles_reversed i.Migratieachtergrond i.Welvaart_quintiles_reversed#i.Migratieachtergrond, exposure(interval) vce(robust) irr
* Apart migratieachtergrond
gen Suriname = 0
replace Suriname = 1 if Migratieachtergrond == 4
gen Turkey = 0
replace Turkey = 1 if Migratieachtergrond == 5
gen Morocco = 0
replace Morocco = 1 if Migratieachtergrond == 6
gen Caribbean = 0
replace Caribbean = 1 if Migratieachtergrond == 7
gen Indonesia = 0
replace Indonesia = 1 if Migratieachtergrond == 8

poisson _d i.Welvaart_quintiles_reversed i.Suriname i.Welvaart_quintiles_reversed#i.Suriname, exposure(interval) vce(robust) irr
poisson _d i.Welvaart_quintiles_reversed i.Turkey i.Welvaart_quintiles_reversed#i.Turkey, exposure(interval) vce(robust) irr
poisson _d i.Welvaart_quintiles_reversed i.Morocco i.Welvaart_quintiles_reversed#i.Morocco, exposure(interval) vce(robust) irr
poisson _d i.Welvaart_quintiles_reversed i.Caribbean i.Welvaart_quintiles_reversed#i.Caribbean, exposure(interval) vce(robust) irr
poisson _d i.Welvaart_quintiles_reversed i.Indonesia i.Welvaart_quintiles_reversed#i.Indonesia, exposure(interval) vce(robust) irr

gen risk_profile_Suriname =. 
replace risk_profile_Suriname = 1 if Migratieachtergrond == 4 & Welvaart_quintiles_reversed == 1
replace risk_profile_Suriname = 2 if Migratieachtergrond == 4 & Welvaart_quintiles_reversed == 2
replace risk_profile_Suriname = 3 if Migratieachtergrond == 4 & Welvaart_quintiles_reversed == 3
replace risk_profile_Suriname = 4 if Migratieachtergrond == 4 & Welvaart_quintiles_reversed == 4
replace risk_profile_Suriname = 5 if Migratieachtergrond == 4 & Welvaart_quintiles_reversed == 5
recode risk_profile_Suriname (.=0)

poisson _d i.risk_profile_Suriname, exposure(interval) vce(robust) irr

gen risk_profile_Turkey =. 
replace risk_profile_Turkey = 1 if Migratieachtergrond == 5 & Welvaart_quintiles_reversed == 1
replace risk_profile_Turkey = 2 if Migratieachtergrond == 5 & Welvaart_quintiles_reversed == 2
replace risk_profile_Turkey = 3 if Migratieachtergrond == 5 & Welvaart_quintiles_reversed == 3
replace risk_profile_Turkey = 4 if Migratieachtergrond == 5 & Welvaart_quintiles_reversed == 4
replace risk_profile_Turkey = 5 if Migratieachtergrond == 5 & Welvaart_quintiles_reversed == 5
recode risk_profile_Turkey (.=0)

poisson _d i.risk_profile_Turkey, exposure(interval) vce(robust) irr

gen risk_profile_Morocco =. 
replace risk_profile_Morocco = 1 if Migratieachtergrond == 6 & SES_quintiles_reversed == 1
replace risk_profile_Morocco = 2 if Migratieachtergrond == 6 & SES_quintiles_reversed == 2
replace risk_profile_Morocco = 3 if Migratieachtergrond == 6 & SES_quintiles_reversed == 3
replace risk_profile_Morocco = 4 if Migratieachtergrond == 6 & SES_quintiles_reversed == 4
replace risk_profile_Morocco = 5 if Migratieachtergrond == 6 & SES_quintiles_reversed == 5
recode risk_profile_Morocco (.=0)

poisson _d i.risk_profile_Morocco, exposure(interval) vce(robust) irr

gen risk_profile_Caribbean =. 
replace risk_profile_Caribbean = 1 if Migratieachtergrond == 7 & Welvaart_quintiles_reversed == 1
replace risk_profile_Caribbean = 2 if Migratieachtergrond == 7 & Welvaart_quintiles_reversed == 2
replace risk_profile_Caribbean = 3 if Migratieachtergrond == 7 & Welvaart_quintiles_reversed == 3
replace risk_profile_Caribbean = 4 if Migratieachtergrond == 7 & Welvaart_quintiles_reversed == 4
replace risk_profile_Caribbean = 5 if Migratieachtergrond == 7 & Welvaart_quintiles_reversed == 5
recode risk_profile_Caribbean (.=0)

poisson _d i.risk_profile_Caribbean, exposure(interval) vce(robust) irr

gen risk_profile_Indonesia =. 
replace risk_profile_Indonesia = 1 if Migratieachtergrond == 8 & Welvaart_quintiles_reversed == 1
replace risk_profile_Indonesia = 2 if Migratieachtergrond == 8 & Welvaart_quintiles_reversed == 2
replace risk_profile_Indonesia = 3 if Migratieachtergrond == 8 & Welvaart_quintiles_reversed == 3
replace risk_profile_Indonesia = 4 if Migratieachtergrond == 8 & Welvaart_quintiles_reversed == 4
replace risk_profile_Indonesia = 5 if Migratieachtergrond == 8 & Welvaart_quintiles_reversed == 5
recode risk_profile_Indonesia (.=0)

poisson _d i.risk_profile_Indonesia, exposure(interval) vce(robust) irr

*3 cijferige postcode
gen buurt = .
replace buurt = 1 if postalcode == 2490 | postalcode == 2491 | postalcode == 2492 | postalcode == 2493 | postalcode == 2494 | postalcode == 2495 | postalcode == 2496 | postalcode == 2497 | postalcode == 2498

replace buurt = 2 if postalcode == 2511 | postalcode == 2512 | postalcode == 2513 | postalcode == 2514 | postalcode == 2515 | postalcode == 2516 | postalcode == 2517 | postalcode == 2518 
 
replace buurt = 3 if postalcode == 2521 | postalcode == 2522 | postalcode == 2523 | postalcode == 2524 | postalcode == 2525 | postalcode == 2526 
 
replace buurt = 4 if postalcode == 2531 | postalcode == 2532 | postalcode == 2533 
 
replace buurt = 5 if postalcode == 2541 | postalcode == 2542 | postalcode == 2543 | postalcode == 2544 | postalcode == 2545 | postalcode == 2546 | postalcode == 2547 | postalcode == 2548 

replace buurt = 6 if postalcode == 2551 | postalcode == 2552 | postalcode == 2553 | postalcode == 2554 | postalcode == 2555 
 
replace buurt = 7 if postalcode == 2561 | postalcode == 2562 | postalcode == 2563 | postalcode == 2564 | postalcode == 2565 | postalcode == 2566 

replace buurt = 8 if postalcode == 2571 | postalcode == 2572 | postalcode == 2573 | postalcode == 2574 

replace buurt = 9 if postalcode == 2581 | postalcode == 2582 | postalcode == 2583 | postalcode == 2584 | postalcode == 2585 | postalcode == 2586 | postalcode == 2587 

replace buurt = 10 if postalcode == 2591 | postalcode == 2592 | postalcode == 2593 | postalcode == 2594 | postalcode == 2595 | postalcode == 2596 | postalcode == 2597

poisson _d i.Welvaart_quintiles_reversed, exposure(interval) vce(robust) irr
poisson _d i.buurt, exposure(interval) vce(robust) irr
poisson _d i.Welvaart_quintiles_reversed i.buurt, exposure(interval) vce(robust) irr

* gestratificeerd voor leeftijd, geslacht, migratieachtergrond en SES
poisson _d i.gbageslacht i.Welvaart_quintiles_reversed i.Migratieachtergrond i.huishouden i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.kwartaal, exposure(interval) vce(robust) irr strata(age_category) nolog

poisson _d i.kwartaal i.age_category i.Welvaart_quintiles_reversed i.Migratieachtergrond  i.huishouden i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other, exposure(interval) vce(robust) irr strata(gbageslacht) nolog

poisson _d i.gbageslacht i.age_category i.Welvaart_quintiles_reversed i.huishouden i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.kwartaal, exposure(interval) vce(robust) irr strata(Migratieachtergrond) nolog

poisson _d i.gbageslacht i.age_category i.huishouden i.Migratieachtergrond i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.kwartaal, exposure(interval) vce(robust) irr strata(Welvaart_quintiles_reversed) nolog

 
**************************************************************************
*mortality 2020

* Comorbiditeit
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2014\Survival2014.dta", clear
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\Survival2015.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2016\Survival2016.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2017\Survival2017.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2018\Survival2018.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\Survival2019.dta"
drop _merge
keep rinpersoons rinpersoon Neoplastic_Disease* Liver_Disease* Congestive_HF* Cerebrovascular_Disease* Renal_Disease* Pulmonary_Disease* Dementia* Neurologic_Disease* Diabetes* HIV* Immunocompromised* Cardiovascular_Disease_other* 
destring rinpersoon, replace
merge 1:m rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2020_Final.dta"
drop if _merge == 1
drop _merge
replace Neoplastic_Disease = 1 if (Neoplastic_Disease2014 == 1 | Neoplastic_Disease2015 == 1 | Neoplastic_Disease2016 == 1 | Neoplastic_Disease2017 == 1 | Neoplastic_Disease2018 == 1 | Neoplastic_Disease2019 == 1)
replace Liver_Disease = 1 if (Liver_Disease2014 == 1 | Liver_Disease2015 == 1 | Liver_Disease2016 == 1 | Liver_Disease2017 == 1 | Liver_Disease2018 == 1 | Liver_Disease2019 == 1)
replace Congestive_HF = 1 if (Congestive_HF2014 == 1 | Congestive_HF2015 == 1 | Congestive_HF2016 == 1 | Congestive_HF2017 == 1 | Congestive_HF2018 == 1 | Congestive_HF2019 == 1)
replace Cerebrovascular_Disease = 1 if (Cerebrovascular_Disease2014 == 1 | Cerebrovascular_Disease2015 == 1 | Cerebrovascular_Disease2016 == 1 | Cerebrovascular_Disease2017 == 1 | Cerebrovascular_Disease2018 == 1 | Cerebrovascular_Disease2019 == 1)
replace Renal_Disease = 1 if (Renal_Disease2014 == 1 | Renal_Disease2015 == 1 | Renal_Disease2016 == 1 | Renal_Disease2017 == 1 | Renal_Disease2018 == 1 | Renal_Disease2019 == 1)
replace Pulmonary_Disease = 1 if (Pulmonary_Disease2014 == 1 | Pulmonary_Disease2015 == 1 | Pulmonary_Disease2016 == 1 | Pulmonary_Disease2017 == 1 | Pulmonary_Disease2018 == 1 | Pulmonary_Disease2019 == 1)
replace Dementia = 1 if (Dementia2014 == 1 | Dementia2015 == 1 | Dementia2016 == 1 | Dementia2017 == 1 | Dementia2018 == 1 | Dementia2019 == 1)
replace Neurologic_Disease = 1 if (Neurologic_Disease2014 == 1 | Neurologic_Disease2015 == 1 | Neurologic_Disease2016 == 1 | Neurologic_Disease2017 == 1 | Neurologic_Disease2018 == 1 | Neurologic_Disease2019 == 1)
replace Diabetes = 1 if (Diabetes2014 == 1 | Diabetes2015 == 1 | Diabetes2016 == 1 | Diabetes2017 == 1 | Diabetes2018 == 1 | Diabetes2019 == 1)
replace HIV = 1 if (HIV2014 == 1 | HIV2015 == 1 | HIV2016 == 1 | HIV2017 == 1 | HIV2018 == 1 | HIV2019 == 1)
replace Cardiovascular_Disease_other = 1 if (Cardiovascular_Disease_other2014 == 1 | Cardiovascular_Disease_other2015 == 1 | Cardiovascular_Disease_other2016 == 1 | Cardiovascular_Disease_other2017 == 1 | Cardiovascular_Disease_other2018 == 1 | Cardiovascular_Disease_other2019 == 1)
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace

* splitsen europa in oost europees
recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2
drop Neoplastic_Disease20* Liver_Disease20* Congestive_HF20* Cerebrovascular_Disease20* Renal_Disease20* Pulmonary_Disease20* Dementia20* Neurologic_Disease20* Diabetes20* HIV20* Immunocompromised20* Cardiovascular_Disease_other20*

gen age = (Exposure - birthday)/365.25
drop if age > 80
gen age_category = .
recode age_category (.=1) if (age >= 18 & age < 50)
recode age_category (.=2) if (age >= 50 & age < 60)
recode age_category (.=3) if (age >= 60 & age < 70)
recode age_category (.=4) if (age >= 70 & age <= 80)

*SES in quintiles
gen Welvaart_quintiles_reversed = .
recode Welvaart_quintiles_reversed (.=1) if (Welvaart > 80 & Welvaart <= 100)
recode Welvaart_quintiles_reversed (.=2) if (Welvaart > 60 & Welvaart <= 80)
recode Welvaart_quintiles_reversed (.=3) if (Welvaart > 40 & Welvaart <= 60)
recode Welvaart_quintiles_reversed (.=4) if (Welvaart > 20 & Welvaart <= 40)
recode Welvaart_quintiles_reversed (.=5) if (Welvaart > 0 & Welvaart <= 20)

** interval voor exposure
gen interval = (_t - _t0)

*variabele voor eerdere infectie
*gen recurrent_infection = .
gen recurrent_infection = .
sort rinpersoon CLRTI Exposure
by rinpersoon CLRTI: gen N = _n if CLRTI == 1
tab N

egen ever_CLRTI =  max(CLRTI), by(rinpersoon)
egen number_CLRTI = max(N), by(rinpersoon)
gen date_CLRTI1 = BeginCLRTI if CLRTI==1 & N==1
gen date_CLRTI2 = BeginCLRTI if CLRTI==1 & N==2
gen date_CLRTI3 = BeginCLRTI if CLRTI==1 & N==3
gen date_CLRTI4 = BeginCLRTI if CLRTI==1 & N==4

egen date_CLRTI1_2 = max(date_CLRTI1), by(rinpersoon)
egen date_CLRTI2_2 = max(date_CLRTI2), by(rinpersoon)
egen date_CLRTI3_2 = max(date_CLRTI3), by(rinpersoon)
egen date_CLRTI4_2 = max(date_CLRTI4), by(rinpersoon)

format date_CLRTI1_2 %td
format date_CLRTI2_2 %td
format date_CLRTI3_2 %td
format date_CLRTI4_2 %td

gen diff_prev_CLRTI1 = Exposure - date_CLRTI1_2
gen diff_prev_CLRTI2 = Exposure - date_CLRTI2_2
gen diff_prev_CLRTI3 = Exposure - date_CLRTI3_2
gen diff_prev_CLRTI4 = Exposure - date_CLRTI4_2

gen previous_CLRTI = 0 if ever_CLRTI==0
replace previous_CLRTI = 1 if diff_prev_CLRTI1>1 & diff_prev_CLRTI1!=.
replace previous_CLRTI = 0 if diff_prev_CLRTI1<0 & diff_prev_CLRTI1!=.

foreach n of numlist 1/4 {
	gen years_since_CLRTI`n' = 1 if previous_CLRTI==1 & diff_prev_CLRTI`n'<=365 & diff_prev_CLRTI`n'>0
	replace years_since_CLRTI`n' = 2 if previous_CLRTI==1 & diff_prev_CLRTI`n'>365 & diff_prev_CLRTI`n'<=730
	replace years_since_CLRTI`n' = 3 if previous_CLRTI==1 & diff_prev_CLRTI`n'>730 & diff_prev_CLRTI`n'<=1095
	replace years_since_CLRTI`n' = 4 if previous_CLRTI==1 & diff_prev_CLRTI`n'>1095 & diff_prev_CLRTI`n'<=1460
	replace years_since_CLRTI`n' = 5 if previous_CLRTI==1 & diff_prev_CLRTI`n'>1460 & diff_prev_CLRTI`n'<=1825
	replace years_since_CLRTI`n' = 6 if previous_CLRTI==1 & diff_prev_CLRTI`n'>1825 & diff_prev_CLRTI`n'<=2190
}

egen years_since_last_CLRTI = rowmin(years_since_CLRTI1 years_since_CLRTI2 years_since_CLRTI3 years_since_CLRTI4)

gen CLRTI_in_past_year = 1 if previous_CLRTI==1 & years_since_last_CLRTI==1
replace CLRTI_in_past_year = 0 if CLRTI_in_past_year==.

drop if Exposure<date("20200101", "YMD")


drop doodsoorzaak
encode UCCODE, generate(doodsoorzaak)
tab doodsoorzaak
*J100 J122 J129 J189 J22 U071 U072
generate CLRTI_cause2 = .
foreach val of numlist 582 583 584 320 321 618 619 {
	replace CLRTI_cause2 = 1 if doodsoorzaak==`val'
}
drop CLRTI_cause
rename CLRTI_cause2 CLRTI_cause
generate LRTI_mortality = .
replace LRTI_mortality = 1 if CLRTI_cause == 1
generate diff_mortality = overlijdensdatum - BeginCLRTI
replace LRTI_mortality = 1 if diff_mortality < 30 & CLRTI_cause != 1
replace LRTI_mortality = 1 if CLRTI_cause == 1 & BeginCLRTI == .
replace LRTI_mortality = 0 if CLRTI == 0


stset date_end_exposure, failure(LRTI_mortality==1) origin(time Exposure) time0(Exposure) id(rinpersoon) scale(365.25)

*door met poisson regressie
poisson _d ib4.age_category, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(age_cat) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.gbageslacht, exposure(interval) vce(cluster rinpersoon) irr nolog
*niet significant
tabstat _d, by(gbageslacht) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.huishouden, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(huishouden) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Migratieachtergrond, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Migratieachtergrond) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Welvaart_quintiles_reversed, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Welvaart_quintiles_reversed) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Neoplastic_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Neoplastic_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Liver_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Liver_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Congestive_HF, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Congestive_HF) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Cerebrovascular_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Cerebrovascular_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Renal_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Renal_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Pulmonary_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Pulmonary_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Dementia, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Dementia	) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.Neurologic_Disease, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Neurologic_Disease) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Diabetes, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Diabetes) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.HIV, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(HIV) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Immunocompromised, exposure(interval) vce(cluster rinpersoon) irr nolog
*significant
tabstat _d, by(Immunocompromised) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.Cardiovascular_Disease_other, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(Cardiovascular_Disease_other) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d  i.kwartaal, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(kwartaal) stats(mean v n)
/*conditional mean en variance hetzelfde*/

poisson _d i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
tabstat _d, by(CLRTI_in_past_year) stats(mean v n)
/*conditional mean en variance hetzelfde*/

/* Definitive poisson regression models
1. univariable models described above
2. multivariable model with structural determinants
3. multivariable with all determinants
*/

*definitieve multivariabele model
*2 SES, Migratieachtergrond CLRTI
poisson _d i.Migratieachtergrond ib4.age_category i.gbageslacht i.Welvaart_quintiles_reversed i.kwartaal i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
estat ic

*3 cluster rinpersoon
poisson _d i.gbageslacht ib4.age_category i.Welvaart_quintiles_reversed i.Neoplastic_Disease i.Liver_Disease i.Congestive_HF i.Cerebrovascular_Disease i.Renal_Disease i.Pulmonary_Disease i.Dementia i.Neurologic_Disease i.Diabetes i.HIV i.Immunocompromised i.Cardiovascular_Disease_other i.huishouden i.Migratieachtergrond i.kwartaal i.CLRTI_in_past_year, exposure(interval) vce(cluster rinpersoon) irr nolog
