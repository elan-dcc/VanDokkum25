* Analyses to answer research questions

* Describing population characteristics

* Creating a dataset with only person, CLRTI, postal code, gender age and 30-day mortality
*dataset with only CLRTI
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2020\DATA2020Complete.dta", clear
keep rinpersoon rinpersoons gbageslacht gbageneratie BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld*  GBADATUMAANVANGADRESHOUDING* GBADATUMEINDEADRESHOUDING* postalcode*
reshape long BeginLRTIDBC EindLRTIDBC date_LRTI_SEH_Beeld CLRTI_adm CLRTI_Death, i(rinpersoon) j(CLRTI_measurement) 
drop CLRTI_measurement
duplicates drop
rename BeginLRTIDBC BeginCLRTI
rename EindLRTIDBC EindCLRTI
rename CLRTI_adm CLRTI 
replace CLRTI = 1 if CLRTI_Death == 1
* doodsoorzaak J100 t/m J22 houdt verband met onderste luchtweginfecties, U071 & U072 bij COVID --> zoeken welke gecodeerde cijfers daarbij horen = 299 300 301 302 303 304 305 306 307 308 309 310
tab doodsoorzaak
generate CLRTI_cause2 = .
foreach val of numlist 299 300 301 302 303 304 305 306 307 308 309 310 439 440 {
	replace CLRTI_cause2 = 1 if doodsoorzaak==`val'
}
drop CLRTI_cause
rename CLRTI_cause2 CLRTI_cause
replace CLRTI = 1 if (CLRTI_cause == 1)
keep if CLRTI == 1
*zit nog een aantal dubbele overlijdens in
sort rinpersoon Thirtydaymortality
by rinpersoon Thirtydaymortality: gen N = _n if Thirtydaymortality == 1
drop if N == 2 & CLRTI_cause == 1
drop N
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTILong2020.dta", replace

*dataset with non-CLRTI
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2020\DATA2020Complete.dta", clear
keep rinpersoon rinpersoons gbageslacht gbageneratie BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld*  GBADATUMAANVANGADRESHOUDING* GBADATUMEINDEADRESHOUDING* postalcode*
reshape long BeginLRTIDBC EindLRTIDBC date_LRTI_SEH_Beeld CLRTI_adm CLRTI_Death, i(rinpersoon) j(CLRTI_measurement) 
drop CLRTI_measurement
duplicates drop
rename BeginLRTIDBC BeginCLRTI
rename EindLRTIDBC EindCLRTI
rename CLRTI_adm CLRTI 
replace CLRTI = 1 if CLRTI_Death == 1
generate CLRTI_cause2 = .
foreach val of numlist 299 300 301 302 303 304 305 306 307 308 309 310 439 440 {
	replace CLRTI_cause2 = 1 if doodsoorzaak==`val'
}
drop CLRTI_cause
rename CLRTI_cause2 CLRTI_cause
replace CLRTI = 1 if (CLRTI_cause == 1)
sort rinpersoon CLRTI
bysort rinpersoon: egen newv = max(CLRTI)
drop CLRTI
rename newv CLRTI
sort rinpersoon
keep if CLRTI != 1
duplicates drop
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\NonCLRTILong2020.dta", replace


* reshaping dataset to entail "survival data" and to stset the dataset (eerst CLRTI)
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTILong2020.dta", clear
sort rinpersoon rinpersoons
by rinpersoon: generate N = _n
reshape long GBADATUMAANVANGADRESHOUDING GBADATUMEINDEADRESHOUDING postalcode, i(rinpersoon N) j(measurement_postalcode)
*dataset met 15 mogelijke postcodes bij elke geincludeerde persoon gebaseerd op de jaarlijkse datasets
drop if postalcode ==.
drop if (GBADATUMEINDEADRESHOUDING < date("20200101", "YMD") | GBADATUMAANVANGADRESHOUDING >= date("20210101", "YMD"))
replace CLRTI = 0 if (BeginCLRTI < GBADATUMAANVANGADRESHOUDING & BeginCLRTI != .)
replace CLRTI = 0 if (BeginCLRTI > GBADATUMEINDEADRESHOUDING & BeginCLRTI != .)
replace CLRTI = 0 if (BeginCLRTI ==. & CLRTI_cause != 1)
tab CLRTI


generate Exposure = date("20200101", "YMD")
format Exposure %td
/*exposure begint later als persoon pas na 1 januari in Den Haag kwam wonen*/
replace Exposure = GBADATUMAANVANGADRESHOUDING if GBADATUMAANVANGADRESHOUDING>Exposure 
/*follow-up stopt niet als persoon uitkomst heeft gehad*/
generate date_end_exposure = GBADATUMEINDEADRESHOUDING if GBADATUMEINDEADRESHOUDING < date("20210101", "YMD")
replace date_end_exposure = date("20201231", "YMD") if GBADATUMEINDEADRESHOUDING >= date("20210101", "YMD")
replace date_end_exposure = overlijdensdatum if (overlijdensdatum>=Exposure & overlijdensdatum<date_end_exposure  & overlijdensdatum !=.) 
format date_end_exposure %td

*drop if BeginCLRTI does not correspond to the time at a certain adres
drop if (BeginCLRTI > GBADATUMEINDEADRESHOUDING & BeginCLRTI !=.)
drop if (BeginCLRTI < GBADATUMAANVANGADRESHOUDING & BeginCLRTI !=.)

sort rinpersoon GBADATUMAANVANGADRESHOUDING
*nog dubbele overlijdens die not corresponderen met residentie staan als CLRTI = yes gecodeerd, dus die eruit halen
replace CLRTI = 0 if (overlijdensdatum > GBADATUMEINDEADRESHOUDING & BeginCLRTI ==.)
* dubbelen maken voor als iemand episode heeft gehad in verband met het recurrent events waarbij de follow-up niet stopt
gen exposure_after_infection = BeginCLRTI + 14
format exposure_after_infection %td
destring rinpersoon, replace
sort rinpersoon exposure_after_infection BeginCLRTI GBADATUMAANVANGADRESHOUDING
by rinpersoon: gen lagged_variable = exposure_after_infection[_n-1] if _n > 1 & rinpersoon == rinpersoon[_n-1]
format lagged_variable %td
sort rinpersoon GBADATUMAANVANGADRESHOUDING BeginCLRTI
by rinpersoon GBADATUMAANVANGADRESHOUDING: generate NN = _n
replace Exposure = lagged_variable if (NN != 1 & lagged_variable != .)
replace date_end_exposure = BeginCLRTI if (CLRTI==1 & BeginCLRTI !=.)

expand 2 if NN == 2, generate(newv)
sort rinpersoon GBADATUMAANVANGADRESHOUDING
replace CLRTI = 0 if newv == 1
replace BeginCLRTI =. if newv == 1
replace EindCLRTI =. if newv == 1
replace date_LRTI_SEH_Beeld =. if newv == 1
replace Exposure = exposure_after_infection if newv==1
replace date_end_exposure = GBADATUMEINDEADRESHOUDING if (GBADATUMEINDEADRESHOUDING < date("20210101", "YMD") & newv==1)
replace date_end_exposure = date("20201231", "YMD") if (GBADATUMEINDEADRESHOUDING >= date("20210101", "YMD") & newv==1)
sort rinpersoon Exposure

egen id_count = count(rinpersoon), by(rinpersoon)
gen tag = (id_count == 1)
expand 2 if tag == 1, generate (newv2)
replace CLRTI = 0 if newv2 == 1
replace BeginCLRTI =. if newv2 == 1
replace EindCLRTI =. if newv2 == 1
replace date_LRTI_SEH_Beeld =. if newv2 == 1
replace Exposure = exposure_after_infection if newv2 == 1
replace date_end_exposure = GBADATUMEINDEADRESHOUDING if (GBADATUMEINDEADRESHOUDING < date("20210101", "YMD") & newv2 == 1)
replace date_end_exposure = date("20201231", "YMD") if (GBADATUMEINDEADRESHOUDING >= date("20210101", "YMD") & newv2 == 1)

*laatste dubbelen identificeren
duplicates report rinpersoon Exposure date_end_exposure
duplicates report rinpersoon Exposure

duplicates report rinpersoon date_end_exposure

*Altering double observations based on End date
browse if Exposure > GBADATUMEINDEADRESHOUDING 
drop if Exposure > GBADATUMEINDEADRESHOUDING
sort rinpersoon date_end_exposure newv2 newv
by rinpersoon date_end_exposure: generate PP = _n
tab PP
browse if PP == 2
drop if PP == 2
drop PP
duplicates report rinpersoon Exposure date_end_exposure
duplicates report rinpersoon Exposure
duplicates report rinpersoon date_end_exposure
bysort rinpersoon Exposure: generate PP = _n
tab PP
browse if PP == 2
browse if rinpersoon == 873321228

tab CLRTI

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTI2020_pos_postcodes.dta", replace

*nu voor non-CLRTI
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\NonCLRTILong2020.dta", clear
sort rinpersoon rinpersoons
merge m:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\LongitudinalPOSTCODES.dta"
keep if _merge == 3
drop _merge
sort rinpersoon 
by rinpersoon: generate N = _n
drop soortobjectnummer* rinobjectnummer*
reshape long GBADATUMAANVANGADRESHOUDING GBADATUMEINDEADRESHOUDING postalcode, i(rinpersoon N) j(measurement_postalcode)
*dataset met 15 mogelijke postcodes bij elke geincludeerde persoon gebaseerd op de jaarlijkse datasets
drop if postalcode ==.
drop if (GBADATUMEINDEADRESHOUDING < date("20200101", "YMD") | GBADATUMAANVANGADRESHOUDING >= date("20210101", "YMD"))

generate Exposure = date("20200101", "YMD")
format Exposure %td
/*exposure begint later als persoon pas na 1 januari in Den Haag kwam wonen*/
replace Exposure = GBADATUMAANVANGADRESHOUDING if GBADATUMAANVANGADRESHOUDING>Exposure 
/*follow-up stopt niet als persoon uitkomst heeft gehad*/
generate date_end_exposure = GBADATUMEINDEADRESHOUDING if GBADATUMEINDEADRESHOUDING < date("20210101", "YMD")
replace date_end_exposure = date("20201231", "YMD") if GBADATUMEINDEADRESHOUDING >= date("20210101", "YMD")
replace date_end_exposure = overlijdensdatum if (overlijdensdatum>=Exposure & overlijdensdatum<date_end_exposure  & overlijdensdatum !=.) 
format date_end_exposure %td
* dropping duplicates
duplicates drop rinpersoon GBADATUMAANVANGADRESHOUDING GBADATUMEINDEADRESHOUDING, force
sort rinpersoon GBADATUMAANVANGADRESHOUDING
destring rinpersoon, replace
* dataset met verschillende exposure en einddatum exposure gebaseerd op postcodes
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\non_CLRTI2020_postcodes.dta", replace

*samenvoegen bestanden
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTI2020_pos_postcodes.dta", clear
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\non_CLRTI2020_postcodes.dta"
recode CLRTI (.=0)
tab CLRTI

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTI2020_Incidence_Final.dta", replace

*Incidence analyses
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTI2020_Incidence_Final.dta", clear
sort birthday
gen date_18 = birthday+(18*365.25)
format %td date_18
gen Exposure2 = Exposure if Exposure>=date_18 & Exposure!=.
replace Exposure2 = date_18 if Exposure<date_18 & date_end_exposure>= date_18 & Exposure!=.
drop if Exposure2==.
drop Exposure
rename Exposure2 Exposure
format %td Exposure

*stset for analysis 
stset date_end_exposure, failure(CLRTI==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)

* Crude incidence rate overall and per postal code
drop if postalcode==2491 | postalcode==2495
stptime, title(person-years) by(postalcode) per(1000) dd(2) 


stsplit agecat, at(10(10)130) after(time=birthday)

replace agecat = 18 if agecat==10 | agecat==20
replace agecat = 90 if agecat==100 | agecat==110

stptime, title(person-years) by(agecat) per(1000) 

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Crude_Incidence_Rates2020.dta", replace
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Crude_Incidence_Rates2020.dta", clear

strate agecat gbageslacht, per(1000) output("H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\incidence_per_age_gender2020.dta", replace)
strate agecat gbageslacht postalcode, output("H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\incidence_per_age_gender_postalcode2020.dta", replace)
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\incidence_per_age_gender2020.dta", clear
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\incidence_per_age_gender_postalcode2020.dta", clear
sort agecat gbageslacht
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\incidence_per_age_gender_postalcode2020.dta", replace

* Adjusted overall and stratified incidence rate for postal code(for age and sex) 
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2020\ADRESSEN2020.dta", clear

gen one_jan = mdy(01,01,2020)
format one_jan %td
/*destring GBADATUMAANVANGADRESHOUDING, replace
destring GBADATUMEINDEADRESHOUDING, replace*/
gen datum_start = date(GBADATUMAANVANGADRESHOUDING, "YMD")
gen datum_eind = date(GBADATUMEINDEADRESHOUDING, "YMD")
format datum_start %td
format datum_eind %td

keep if datum_start<=one_jan & datum_eind>one_jan
browse

keep rinpersoon rinpersoons

sort rinpersoon rinpersoons
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\adressen_01012020.dta", replace

use "G:\Bevolking\GBAPERSOONTAB\2020\geconverteerde data\GBAPERSOON2020TABV3.dta", clear
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\adressen_01012020.dta"
keep if _merge==3
drop _merge
destring gbageboortedag gbageboortemaand gbageboortejaar, replace
generate birthday=mdy(gbageboortemaand, gbageboortedag, gbageboortejaar)
format birthday %d
keep gbageslacht birthday
generate age2020 = (mdy(01,01,2020) - birthday)/365.25
drop if age2020<18
egen agecat = cut(age2020), at(10(10)130)
replace agecat = 18 if agecat==10 | agecat==20
replace agecat = 90 if agecat==100 | agecat==110
/*HB agecat 18-30, 30-40, ..., 90+*/

/*syntax uit -help dstdize-*/

collapse (count) count=age2020, by(agecat gbageslacht)
egen total_population = total(count)
gen pop = (count / total_population)

sort agecat gbageslacht
destring gbageslacht, replace
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\reference population2020.dta", replace

use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\incidence_per_age_gender_postalcode2020.dta", clear
sort agecat gbageslacht

merge m:1 agecat gbageslacht using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\reference population2020.dta"
gen rate = _D/_Y
gen product = rate*pop
by postalcode, sort: egen adj_rate = sum(product)
gen rate_per_1000 = (adj_rate * 1000)

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\adjusted_incidence_per_postalcode2020.dta", replace

format %9.3g rate_per_1000
browse postalcode adj_rate rate_per_1000
by postalcode, sort: egen total_exposure = sum(_Y)
gen se = sqrt(adj_rate/total_exposure)
gen z = invnorm(0.975)
gen lower_limit = adj_rate - z*se
gen upper_limit = adj_rate + z*se
replace lower_limit = (lower_limit * 1000)
replace upper_limit = (upper_limit * 1000)
duplicates drop adj_rate lower_limit upper_limit, force

* Crude overall CLRTI related mortality rate
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2020\DATA2020Complete.dta", clear
keep rinpersoon rinpersoons gbageslacht gbageneratie BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld*  GBADATUMAANVANGADRESHOUDING* GBADATUMEINDEADRESHOUDING* postalcode*
reshape long BeginLRTIDBC EindLRTIDBC date_LRTI_SEH_Beeld CLRTI_adm CLRTI_Death, i(rinpersoon) j(CLRTI_measurement) 
drop CLRTI_measurement
duplicates drop
rename BeginLRTIDBC BeginCLRTI
rename EindLRTIDBC EindCLRTI
rename CLRTI_adm CLRTI 
sort rinpersoon 
by rinpersoon: generate N = _n
reshape long GBADATUMAANVANGADRESHOUDING GBADATUMEINDEADRESHOUDING postalcode, i(rinpersoon N) j(measurement_postalcode)
*dataset met 15 mogelijke postcodes bij elke geincludeerde persoon gebaseerd op de jaarlijkse datasets
drop if postalcode ==.
drop if (GBADATUMEINDEADRESHOUDING < date("20200101", "YMD") | GBADATUMAANVANGADRESHOUDING >= date("20210101", "YMD"))
generate Exposure = date("20200101", "YMD")
format Exposure %td
/*HB: exposure begint later als persoon pas na 1 januari in Den Haag kwam wonen*/
replace Exposure = GBADATUMAANVANGADRESHOUDING if GBADATUMAANVANGADRESHOUDING>Exposure 
/*HB: follow-up stopt niet als persoon uitkomst heeft gehad*/
generate date_end_exposure = GBADATUMEINDEADRESHOUDING if GBADATUMEINDEADRESHOUDING < date("20210101", "YMD")
replace date_end_exposure = date("20201231", "YMD") if GBADATUMEINDEADRESHOUDING >= date("20210101", "YMD")
replace date_end_exposure = overlijdensdatum if (overlijdensdatum>=Exposure & overlijdensdatum<date_end_exposure  & overlijdensdatum !=.) 
format date_end_exposure %td

*doodsoorzaken checken en thirtydaymortality maken
generate diff_mortality = overlijdensdatum - BeginCLRTI
replace Thirtydaymortality = 1 if (diff_mortality < 30 & CLRTI == 1)
replace Thirtydaymortality = 0 if diff_mortality >= 30
replace Thirtydaymortality = 1 if CLRTI_cause == 1
tab doodsoorzaak
generate CLRTI_cause2 = .
foreach val of numlist 299 300 301 302 303 304 305 306 307 308 309 310 439 440{
	replace CLRTI_cause2 = 1 if doodsoorzaak==`val'
}
drop CLRTI_cause
rename CLRTI_cause2 CLRTI_cause
replace Thirtydaymortality = 1 if CLRTI_cause == 1

* dropping duplicates
sort rinpersoon GBADATUMAANVANGADRESHOUDING
destring rinpersoon, replace
drop N
recode CLRTI_cause (0=.)
duplicates drop
recode Thirtydaymortality (0=.)
sort rinpersoon Exposure date_end_exposure Thirtydaymortality CLRTI
by rinpersoon Exposure date_end_exposure: gen NN = _n
drop if NN != 1
duplicates report rinpersoon Exposure date_end_exposure
*no duplicates
recode CLRTI_cause (.=0)
recode Thirtydaymortality (.=0)
replace Thirtydaymortality = 0 if overlijdensdatum > GBADATUMEINDEADRESHOUDING
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Mortality2020.dta", replace

* Crude CLRTI related mortality rate per postal code and overall
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Mortality2020.dta", clear
sort birthday
gen date_18 = birthday+(18*365.25)
format %td date_18
gen Exposure2 = Exposure if Exposure>=date_18 & Exposure!=.
replace Exposure2 = date_18 if Exposure<date_18 & date_end_exposure>= date_18 & Exposure!=.
drop if Exposure2==.
drop Exposure
rename Exposure2 Exposure
format %td Exposure

stset date_end_exposure, failure(Thirtydaymortality==1) origin(time Exposure) time0(Exposure) id(rinpersoon) scale(365.25)

* Crude CLRTI related mortality rate per postal code and overall
drop if postalcode==2491 | postalcode==2495
stptime, title(person-years) by(postalcode) per(1000) dd(2)

stsplit agecat, at(10(10)130) after(time=birthday)

replace agecat = 18 if agecat==10 | agecat==20
replace agecat = 90 if agecat==100 | agecat==110

stptime, title(person-years) by(agecat) per(1000) 

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Crude_Mortality_Rates2020.dta", replace
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Crude_Mortality_Rates2020.dta", clear

strate agecat gbageslacht, per(1000) output("H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\mortality_per_age_gender2020.dta", replace)
strate agecat gbageslacht postalcode, output("H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\mortality_per_age_gender_postalcode2020.dta", replace)
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\mortality_per_age_gender2020.dta", clear
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\mortality_per_age_gender_postalcode2020.dta", clear
sort agecat gbageslacht
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\mortality_per_age_gender_postalcode2020.dta", replace

* Adjusted overall and stratified incidence rate for postal code(for age and sex) 
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\mortality_per_age_gender_postalcode2020.dta", clear
sort agecat gbageslacht

merge m:1 agecat gbageslacht using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\reference population2020.dta"
gen rate = _D/_Y
gen product = rate*pop
by postalcode, sort: egen adj_rate = sum(product)
gen rate_per_1000 = (adj_rate * 1000)

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\adjusted_mortality_per_postalcode2020.dta", replace

format %9.3g rate_per_1000
browse postalcode adj_rate rate_per_1000

*****************************************************************************

*preparing for regression analyses and descriptive population characteristics
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2020\DATA2020Complete.dta", clear 
drop rinpersoonshkw rinpersoonhkw inhahl inhahlmi INHP100HBEST INHP100HBESTES INHP100HBRUT INHP100HGEST INHP100HGESTES INHP100HPRIM inhsamaow inhsamhh VEKTMSZZorgtrajectnummer* DTC_codes* LRTI_SEH_Beeld* diff_Deathdate* excl_adm* gbageslacht BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld* merge_mortality IrisMainInjury

*new risk every quartile
generate Kwartaal2020_1 = date("20200101", "YMD")
generate Kwartaal2020_2 = date("20200401", "YMD")
generate Kwartaal2020_3 = date("20200701", "YMD")
generate Kwartaal2020_4 = date("20201001", "YMD")
format Kwartaal2020_1 %td
format Kwartaal2020_2 %td
format Kwartaal2020_3 %td
format Kwartaal2020_4 %td

replace StNeoplastic_Disease = date("20200630", "YMD") if (Neoplastic_Disease==1 & StNeoplastic_Disease == .)
replace StImmunocompromised = date("20200630", "YMD") if (Immunocompromised==1 & StImmunocompromised == .)
replace StLiver_Disease = date("20200630", "YMD") if (Liver_Disease==1 & StLiver_Disease == .)
replace StCongestive_HF = date("20200630", "YMD") if (Congestive_HF==1 & StCongestive_HF == .)
replace StCerebrovascular_Disease = date("2020630", "YMD") if (Cerebrovascular_Disease==1 & StCerebrovascular_Disease == .)
replace StRenal_Disease = date("20200630", "YMD") if (Renal_Disease==1 & StRenal_Disease == .)
replace StPulmonary_Disease = date("20200630", "YMD") if (Pulmonary_Disease==1 & StPulmonary_Disease == .)
replace StDementia = date("20200630", "YMD") if (Dementia==1 & StDementia == .)
replace StNeurologic_Disease = date("20200630", "YMD") if (Neurologic_Disease==1 & StNeurologic_Disease == .)
replace StDiabetes = date("20200630", "YMD") if (Diabetes==1 & StDiabetes == .)
replace StHIV = date("20200630", "YMD") if (HIV==1 & StHIV == .)
replace StCardiovascular_Disease_other = date("20200630", "YMD") if (Cardiovascular_Disease_other==1 & StCardiovascular_Disease_other == .)
destring rinpersoon, replace
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2020\Survival2020.dta", replace

*mergen met CLRTI dataset
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTI2020_Incidence_Final.dta", clear
sort rinpersoon rinpersoons
merge m:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2020\Survival2020.dta"
drop if _merge == 2
drop _merge

stset date_end_exposure, failure(CLRTI==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)

* hier dan StSplitten

*splitten kwartaal
gen kwartaal = .
gen jaar = .

stsplit kwart_2_2020, after(Kwartaal2020_2) at(0)
replace kwartaal = 1 if kwart_2_2020==-1
replace jaar = 2020 if kwart_2_2020==-1
drop kwart_2_2020

stsplit kwart_3_2020, after(Kwartaal2020_3) at(0)
replace kwartaal = 2 if kwart_3_2020==-1 & kwartaal==.
replace jaar = 2020 if kwart_3_2020==-1 & jaar==.
drop kwart_3_2020

stsplit kwart_4_2020, after(Kwartaal2020_4) at(0)
replace kwartaal = 3 if kwart_4_2020==-1 & kwartaal==.
replace jaar = 2020 if kwart_4_2020==-1  & kwartaal==.
drop kwart_4_2020

replace kwartaal = 4 if kwartaal==0
replace kwartaal = 4 if Exposure==date("20201001", "YMD")
replace kwartaal = 4 if Exposure>=date("20201001", "YMD")

gen month = month(Exposure)
gen year = year(Exposure)
drop jaar
rename year jaar
browse rinpersoon Exposure date_end_exposure month jaar if kwartaal==.
replace kwartaal = 1 if (month==1 | month==2 | month==3) & kwartaal==.
replace kwartaal = 2 if (month==4 | month==5 | month==6) & kwartaal==.
replace kwartaal = 3 if (month==7 | month==8 | month==9) & kwartaal==.
replace kwartaal = 4 if (month==10 | month==11 | month==12) & kwartaal==.

drop if Exposure>=date("20210101", "YMD")

*splitten comorbiditeit
stsplit comorbMalig if Neoplastic_Disease == 1, after(StNeoplastic_Disease) at(0)
drop comorbMalig
stsplit comorbLiver if Liver_Disease == 1, after(StLiver_Disease) at(0)
drop comorbLiver
stsplit comorbHF if Congestive_HF == 1, after(StCongestive_HF) at(0)
drop comorbHF
stsplit comorbCerebro if Cerebrovascular_Disease == 1, after(StCerebrovascular_Disease) at(0)
drop comorbCerebro
stsplit comorbRenal if Renal_Disease == 1, after(StRenal_Disease) at(0)
drop comorbRenal
stsplit comorbPulmo if Pulmonary_Disease == 1, after(StPulmonary_Disease) at(0)
drop comorbPulmo
stsplit comorbDement if Dementia == 1, after(StDementia) at(0)
drop comorbDement
stsplit comorbNeuro if Neurologic_Disease == 1, after(StNeurologic_Disease) at(0)
drop comorbNeuro
stsplit comorbDM if Diabetes == 1, after(StDiabetes) at(0)
drop comorbDM
stsplit comorbHIV if HIV == 1, after(StHIV) at(0)
drop comorbHIV
stsplit comorbImmuno if Immunocompromised == 1, after(StImmunocompromised) at(0)
drop comorbImmuno
stsplit comorbCardio if Cardiovascular_Disease_other == 1, after(StCardiovascular_Disease_other) at(0)
drop comorbCardio

*splitten huishouden
gen huishouden = .

replace huishouden = household1 if start_Huishouden1 <=Exposure & stop_Huishouden1 >= Exposure
replace huishouden = household2 if start_Huishouden2 <=Exposure & stop_Huishouden2 >= Exposure
replace huishouden = household3 if start_Huishouden3 <=Exposure & stop_Huishouden3>=Exposure
replace huishouden = household4 if start_Huishouden4 <=Exposure & stop_Huishouden4>=Exposure
replace huishouden = household5 if start_Huishouden5 <=Exposure & stop_Huishouden5>=Exposure
replace huishouden = household6 if start_Huishouden6 <=Exposure & stop_Huishouden6>=Exposure
replace huishouden = household7 if start_Huishouden7 <=Exposure & stop_Huishouden7>=Exposure
replace huishouden = household8 if start_Huishouden8 <=Exposure & stop_Huishouden8>=Exposure
replace huishouden = household9 if start_Huishouden9 <=Exposure & stop_Huishouden9>=Exposure
replace huishouden = household10 if start_Huishouden10 <=Exposure & stop_Huishouden10>=Exposure
replace huishouden = household11 if start_Huishouden11 <=Exposure & stop_Huishouden11>=Exposure
replace huishouden = household12 if start_Huishouden12 <=Exposure & stop_Huishouden12>=Exposure
replace huishouden = household13 if start_Huishouden13 <=Exposure & stop_Huishouden13>=Exposure 
replace huishouden = household14 if start_Huishouden14 <=Exposure & stop_Huishouden14>=Exposure
replace huishouden = household15 if start_Huishouden15 <=Exposure & stop_Huishouden15>=Exposure

stsplit huishouden1, after(start_Huishouden1) at(0)
stsplit huishouden2, after(start_Huishouden2) at(0)
stsplit huishouden3, after(start_Huishouden3) at(0)
stsplit huishouden4, after(start_Huishouden4) at(0)
stsplit huishouden5, after(start_Huishouden5) at(0)
stsplit huishouden6, after(start_Huishouden6) at(0)
stsplit huishouden7, after(start_Huishouden7) at(0)
stsplit huishouden8, after(start_Huishouden8) at(0)
stsplit huishouden9, after(start_Huishouden9) at(0)
stsplit huishouden10, after(start_Huishouden10) at(0)
stsplit huishouden11, after(start_Huishouden11) at(0)
stsplit huishouden12, after(start_Huishouden12) at(0)
stsplit huishouden13, after(start_Huishouden13) at(0)
stsplit huishouden14, after(start_Huishouden14) at(0)
stsplit huishouden15, after(start_Huishouden15) at(0)
drop huishouden1 huishouden2 huishouden3 huishouden4 huishouden5 huishouden6 huishouden7 huishouden8 huishouden9 huishouden10 huishouden11 huishouden12 huishouden13 huishouden14 huishouden15 

replace huishouden = household1 if start_Huishouden1 <=Exposure & stop_Huishouden1 >= Exposure
replace huishouden = household2 if start_Huishouden2 <=Exposure & stop_Huishouden2 >= Exposure
replace huishouden = household3 if start_Huishouden3 <=Exposure & stop_Huishouden3>=Exposure
replace huishouden = household4 if start_Huishouden4 <=Exposure & stop_Huishouden4>=Exposure
replace huishouden = household5 if start_Huishouden5 <=Exposure & stop_Huishouden5>=Exposure
replace huishouden = household6 if start_Huishouden6 <=Exposure & stop_Huishouden6>=Exposure
replace huishouden = household7 if start_Huishouden7 <=Exposure & stop_Huishouden7>=Exposure
replace huishouden = household8 if start_Huishouden8 <=Exposure & stop_Huishouden8>=Exposure
replace huishouden = household9 if start_Huishouden9 <=Exposure & stop_Huishouden9>=Exposure
replace huishouden = household10 if start_Huishouden10 <=Exposure & stop_Huishouden10>=Exposure
replace huishouden = household11 if start_Huishouden11 <=Exposure & stop_Huishouden11>=Exposure
replace huishouden = household12 if start_Huishouden12 <=Exposure & stop_Huishouden12>=Exposure
replace huishouden = household13 if start_Huishouden13 <=Exposure & stop_Huishouden13>=Exposure 
replace huishouden = household14 if start_Huishouden14 <=Exposure & stop_Huishouden14>=Exposure
replace huishouden = household15 if start_Huishouden15 <=Exposure & stop_Huishouden15>=Exposure


foreach huish of numlist 1/15 {
	drop household`huish'
	drop start_Huishouden`huish'
	drop stop_Huishouden`huish'
}

rename SESWOA2020 SESWOA
drop Kwartaal20*
recode CLRTI (.=0)

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\SurvivalData2020_Final.dta", replace


*analyses
*de laatst bekende SESWOA pakken indien missing
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\SurvivalData2014-2019joined.dta", clear
keep VEHP100WELVAART20* SESWOA* rinpersoon rinpersoons
merge m:m rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\SurvivalData2020_Final.dta"
drop if _merge==1
drop _merge
replace SESWOA = SESWOA2019 if SESWOA==.
replace SESWOA = SESWOA2018 if SESWOA==.
replace SESWOA = SESWOA2017 if SESWOA==.
replace SESWOA = SESWOA2016 if SESWOA==.
replace SESWOA = SESWOA2015 if SESWOA==.
replace SESWOA = SESWOA2014 if SESWOA==.
drop SESWOA2014 SESWOA2015 SESWOA2016 SESWOA2017 SESWOA2018 SESWOA2019 N measurement_postalcode
gen Welvaart = .
replace Welvaart = VEHP100WELVAART2019 if (VEHP100WELVAART2019 != -1 & VEHP100WELVAART2019 != -2)
replace Welvaart = VEHP100WELVAART2020 if Welvaart ==. & (VEHP100WELVAART2020 != -1 & VEHP100WELVAART2020 != -2)
replace Welvaart = VEHP100WELVAART2018 if Welvaart ==. & (VEHP100WELVAART2018 != -1 & VEHP100WELVAART2018 != -2)
replace Welvaart = VEHP100WELVAART2017 if Welvaart ==. & (VEHP100WELVAART2017 != -1 & VEHP100WELVAART2017 != -2)
replace Welvaart = VEHP100WELVAART2016 if Welvaart ==. & (VEHP100WELVAART2016 != -1 & VEHP100WELVAART2016 != -2)
replace Welvaart = VEHP100WELVAART2015 if Welvaart ==. & (VEHP100WELVAART2015 != -1 & VEHP100WELVAART2015 != -2)
replace Welvaart = VEHP100WELVAART2014 if Welvaart ==. & (VEHP100WELVAART2014 != -1 & VEHP100WELVAART2014 != -2)
replace Welvaart = VEHP100WELVAART2013 if Welvaart ==. & (VEHP100WELVAART2013 != -1 & VEHP100WELVAART2013 != -2)
drop VEHP100WELVAART20*
duplicates drop
save "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2020_Final.dta", replace

*population characteristics
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2020_Final.dta", clear
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace
* splitsen europa in oost europees
recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2

/*baseline dataset (voor tabel 1)*/
keep if Exposure==date("20200101", "YMD")
gen age = (Exposure - birthday)/365.25
drop if age < 18
*drop if age > 80

tab gbageslacht, m

tab Migratieachtergrond, m

tab huishouden, m

* Leeftijd

sum age, detail
gen age_category = .
recode age_category (.=1) if (age >= 18 & age < 50)
recode age_category (.=2) if (age >= 50 & age < 60)
recode age_category (.=3) if (age >= 60 & age < 70)
recode age_category (.=4) if (age >= 70 & age < 80)
recode age_category (.=5) if age >= 80

tab age_category, m
 
summarize Welvaart, detail
* berekenen gemiddelde SES per wijk
sort postalcode
by postalcode: sum Welvaart, detail

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

gen age = (Exposure - birthday)/365.25
drop if age < 18
*drop if age > 80
keep if Exposure==date("20200101", "YMD")
keep rinpersoons rinpersoon Neoplastic_Disease Liver_Disease Congestive_HF Cerebrovascular_Disease Renal_Disease Pulmonary_Disease Dementia Neurologic_Disease Diabetes HIV Immunocompromised Cardiovascular_Disease_other Exposure birthday age 

tab Neoplastic_Disease 
tab Liver_Disease 
tab Congestive_HF 
tab Cerebrovascular_Disease 
tab Renal_Disease 
tab Pulmonary_Disease 
tab Dementia 
tab Neurologic_Disease 
tab Diabetes 
tab HIV 
tab Immunocompromised 
tab Cardiovascular_Disease_other 
* percentage zonder comorbidity
count if  Neoplastic_Disease == 0 & Liver_Disease == 0 & Congestive_HF == 0 & Cerebrovascular_Disease == 0 & Renal_Disease == 0 & Pulmonary_Disease == 0 & Dementia == 0 & Neurologic_Disease == 0 & Diabetes == 0 & HIV == 0 & Immunocompromised == 0 & Cardiovascular_Disease_other == 0


*voor de cases
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2020_Final.dta", clear
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace

* splitsen europa in oost europees
recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2

keep if CLRTI == 1

gen age = (Exposure - birthday)/365.25
drop if age < 18
*drop if age > 80

duplicates report rinpersoon


sort rinpersoon BeginCLRTI
duplicates drop rinpersoon, force

tab gbageslacht, m

tab Migratieachtergrond, m

sum age, detail

gen age_category = .
recode age_category (.=1) if (age >= 18 & age < 50)
recode age_category (.=2) if (age >= 50 & age < 60)
recode age_category (.=3) if (age >= 60 & age < 70)
recode age_category (.=4) if (age >= 70 & age < 80)
recode age_category (.=5) if age >= 80
tab age_category, m

tab huishouden, m

summarize Welvaart, detail

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

keep if CLRTI == 1
gen age = (Exposure - birthday)/365.25
drop if age < 18
*drop if age > 80
keep rinpersoons rinpersoon Neoplastic_Disease Liver_Disease Congestive_HF Cerebrovascular_Disease Renal_Disease Pulmonary_Disease Dementia Neurologic_Disease Diabetes HIV Immunocompromised Cardiovascular_Disease_other Exposure birthday age overlijdensdatum BeginCLRTI huishouden SESWOA
sort rinpersoon BeginCLRTI
duplicates drop rinpersoon, force 
tab Neoplastic_Disease 
tab Liver_Disease 
tab Congestive_HF 
tab Cerebrovascular_Disease 
tab Renal_Disease 
tab Pulmonary_Disease 
tab Dementia 
tab Neurologic_Disease 
tab Diabetes 
tab HIV 
tab Immunocompromised 
tab Cardiovascular_Disease_other 

count if  Neoplastic_Disease == 0 & Liver_Disease == 0 & Congestive_HF == 0 & Cerebrovascular_Disease == 0 & Renal_Disease == 0 & Pulmonary_Disease == 0 & Dementia == 0 & Neurologic_Disease == 0 & Diabetes == 0 & HIV == 0 & Immunocompromised == 0 & Cardiovascular_Disease_other == 0



