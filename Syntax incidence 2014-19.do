* Every yearly dataset has to be set in a long format. After the datasets can be added together by appending using the "append" command

*2014
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2014\MERGED2014FINAL.dta", clear
keep rinpersoon rinpersoons gbageslacht BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld*
reshape long BeginLRTIDBC EindLRTIDBC date_LRTI_SEH_Beeld CLRTI_adm CLRTI_Death, i(rinpersoon) j(CLRTI_measurement) 
drop CLRTI_measurement
duplicates drop
rename BeginLRTIDBC BeginCLRTI
rename EindLRTIDBC EindCLRTI
rename CLRTI_adm CLRTI
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2014\CLRTILong2014.dta", replace

*2015
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\MERGED2015FINAL.dta", clear
keep rinpersoon rinpersoons gbageslacht BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld*
reshape long BeginLRTIDBC EindLRTIDBC date_LRTI_SEH_Beeld CLRTI_adm CLRTI_Death, i(rinpersoon) j(CLRTI_measurement) 
drop CLRTI_measurement
duplicates drop
rename BeginLRTIDBC BeginCLRTI
rename EindLRTIDBC EindCLRTI
rename CLRTI_adm CLRTI
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\CLRTILong2015.dta", replace

*2016
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2016\MERGED2016FINAL.dta", clear
keep rinpersoon rinpersoons gbageslacht BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld*
reshape long BeginLRTIDBC EindLRTIDBC date_LRTI_SEH_Beeld CLRTI_adm CLRTI_Death, i(rinpersoon) j(CLRTI_measurement) 
drop CLRTI_measurement
duplicates drop
rename BeginLRTIDBC BeginCLRTI
rename EindLRTIDBC EindCLRTI
rename CLRTI_adm CLRTI
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2016\CLRTILong2016.dta", replace

*2017
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2017\MERGED2017FINAL.dta", clear
keep rinpersoon rinpersoons gbageslacht BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld*
reshape long BeginLRTIDBC EindLRTIDBC date_LRTI_SEH_Beeld CLRTI_adm CLRTI_Death, i(rinpersoon) j(CLRTI_measurement) 
drop CLRTI_measurement
duplicates drop
rename BeginLRTIDBC BeginCLRTI
rename EindLRTIDBC EindCLRTI
rename CLRTI_adm CLRTI
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2017\CLRTILong2017.dta", replace

*2018
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2018\MERGED2018FINAL.dta", clear
keep rinpersoon rinpersoons gbageslacht BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld*
reshape long BeginLRTIDBC EindLRTIDBC date_LRTI_SEH_Beeld CLRTI_adm CLRTI_Death, i(rinpersoon) j(CLRTI_measurement) 
drop CLRTI_measurement
duplicates drop
rename BeginLRTIDBC BeginCLRTI
rename EindLRTIDBC EindCLRTI
rename CLRTI_adm CLRTI
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2018\CLRTILong2018.dta", replace

*2019
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MERGED2019FINAL.dta", clear
keep rinpersoon rinpersoons gbageslacht BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld*
reshape long BeginLRTIDBC EindLRTIDBC date_LRTI_SEH_Beeld CLRTI_adm CLRTI_Death, i(rinpersoon) j(CLRTI_measurement) 
drop CLRTI_measurement
duplicates drop
rename BeginLRTIDBC BeginCLRTI
rename EindLRTIDBC EindCLRTI
rename CLRTI_adm CLRTI
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\CLRTILong2019.dta", replace

*aparte datasets voor wel CLRTI en geen CLRTI
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2014\CLRTILong2014.dta", clear
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\CLRTILong2015.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2016\CLRTILong2016.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2017\CLRTILong2017.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2018\CLRTILong2018.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\CLRTILong2019.dta"

tab doodsoorzaak
* doodsoorzaak J108 t/m J22 houdt verband met onderste luchtweginfecties --> zoeken welke gecodeerde cijfers daarbij horen = 315 t/m 321
generate CLRTI_cause2 = .
foreach val of numlist 315 316 317 318 319 320 321 {
	replace CLRTI_cause2 = 1 if doodsoorzaak==`val'
}
drop CLRTI_cause
rename CLRTI_cause2 CLRTI_cause
replace CLRTI = 1 if (CLRTI_cause == 1)
sort rinpersoon
replace CLRTI = 1 if CLRTI_Death == 1
keep if CLRTI == 1
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTILongMerged.dta", replace
*dataset with all included episodes of CLRTI (5,484)
******************
* dataset with everyone who did not have a CLRTI episode
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2014\CLRTILong2014.dta", clear
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\CLRTILong2015.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2016\CLRTILong2016.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2017\CLRTILong2017.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2018\CLRTILong2018.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\CLRTILong2019.dta"
drop if BeginCLRTI < date("20140101", "YMD") & BeginCLRTI != .
generate CLRTI_cause2 = .
foreach val of numlist 315 316 317 318 319 320 321 {
	replace CLRTI_cause2 = 1 if doodsoorzaak==`val'
}
drop CLRTI_cause
rename CLRTI_cause2 CLRTI_cause
replace CLRTI = 1 if (CLRTI_cause == 1)
replace CLRTI = 1 if CLRTI_Death == 1
sort rinpersoon CLRTI
* bij elke observatie per rinpersoon CLRTI toevoegen als er 1 positief is om CLRTI en niet CLRTI personen te splitsen
bysort rinpersoon: egen newv = max(CLRTI)
drop CLRTI
rename newv CLRTI
sort rinpersoon
keep if CLRTI != 1
duplicates drop
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\NonCLRTILongMerged.dta", replace

*adding postal codes for incidence and survival analyses
*first for the CLRTI dataset
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTILongMerged.dta", clear
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
drop if (GBADATUMEINDEADRESHOUDING < date("20140101", "YMD") | GBADATUMAANVANGADRESHOUDING >= date("20200101", "YMD"))
generate CLRTI_yes = 1 if (BeginCLRTI >= GBADATUMAANVANGADRESHOUDING & BeginCLRTI <= GBADATUMEINDEADRESHOUDING)
replace CLRTI = 0 if (CLRTI_yes ==. & CLRTI_cause != 1)
tab CLRTI

replace date_LRTI_SEH_Beeld = . if (BeginCLRTI < date("20140101", "YMD") & BeginCLRTI != .)
replace EindCLRTI = . if (BeginCLRTI < date("20140101", "YMD") & BeginCLRTI != .)
replace BeginCLRTI = . if (BeginCLRTI < date("20140101", "YMD") & BeginCLRTI != .)
replace date_LRTI_SEH_Beeld = . if CLRTI == 0
replace EindCLRTI = . if CLRTI == 0
replace BeginCLRTI = . if CLRTI == 0

generate Exposure = date("20140101", "YMD")
format Exposure %td
/*exposure begint later als persoon pas na 1 januari in Den Haag kwam wonen*/
replace Exposure = GBADATUMAANVANGADRESHOUDING if GBADATUMAANVANGADRESHOUDING>Exposure 
/*follow-up stopt niet als persoon uitkomst heeft gehad*/
generate date_end_exposure = GBADATUMEINDEADRESHOUDING if GBADATUMEINDEADRESHOUDING < date("20200101", "YMD")
replace date_end_exposure = date("20191231", "YMD") if GBADATUMEINDEADRESHOUDING >= date("20200101", "YMD")
replace date_end_exposure = overlijdensdatum if (overlijdensdatum>=Exposure & overlijdensdatum<date_end_exposure  & overlijdensdatum !=.) 
format date_end_exposure %td


*replacing thirty day mortality to adhere to the criteria
generate diff_mortality = overlijdensdatum - BeginCLRTI
replace Thirtydaymortality = 1 if (diff_mortality < 30 & CLRTI == 1)
replace Thirtydaymortality = 0 if diff_mortality >= 30
drop diff_mortality

.
tab CLRTI

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
format rinpersoon %15.0g
sort rinpersoon GBADATUMAANVANGADRESHOUDING BeginCLRTI exposure_after_infection  
by rinpersoon: gen lagged_variable = exposure_after_infection[_n-1] if _n > 1 & rinpersoon == rinpersoon[_n-1]
format lagged_variable %td
sort rinpersoon GBADATUMAANVANGADRESHOUDING BeginCLRTI
by rinpersoon GBADATUMAANVANGADRESHOUDING: generate NN = _n
replace Exposure = lagged_variable if (NN != 1 & lagged_variable != .)
replace date_end_exposure = BeginCLRTI if (CLRTI==1 & BeginCLRTI !=.)
drop NN

egen id_count = count(rinpersoon), by(rinpersoon)
gen tag = (id_count == 1)
expand 2 if tag == 1 & BeginCLRTI !=., generate (newv2)
replace CLRTI = 0 if newv2 == 1
replace BeginCLRTI =. if newv2 == 1
replace EindCLRTI =. if newv2 == 1
replace date_LRTI_SEH_Beeld =. if newv2 == 1
replace Exposure = exposure_after_infection if newv2 == 1
replace date_end_exposure = GBADATUMEINDEADRESHOUDING if (GBADATUMEINDEADRESHOUDING < date("20200101", "YMD") & newv2 == 1)
replace date_end_exposure = date("20191231", "YMD") if (GBADATUMEINDEADRESHOUDING >= date("20200101", "YMD") & newv2 == 1)
sort rinpersoon GBADATUMAANVANGADRESHOUDING BeginCLRTI

sort rinpersoon Exposure GBADATUMAANVANGADRESHOUDING BeginCLRTI CLRTI_cause CLRTI_yes 
by rinpersoon Exposure: generate NN = _n
drop if NN != 1 
drop NN

duplicates report rinpersoon Exposure date_end_exposure
duplicates report rinpersoon Exposure
duplicates report rinpersoon date_end_exposure
*nog 40 duplicates met date_end_exposure
sort rinpersoon date_end_exposure GBADATUMAANVANGADRESHOUDING BeginCLRTI CLRTI_cause CLRTI_yes 
by rinpersoon date_end_exposure: generate NN = _n
drop if NN != 1
drop NN

expand 2 if CLRTI_yes == 1 & tag == 0 , generate(newv)
sort rinpersoon GBADATUMAANVANGADRESHOUDING
replace CLRTI = 0 if newv == 1
replace BeginCLRTI =. if newv == 1
replace EindCLRTI =. if newv == 1
replace date_LRTI_SEH_Beeld =. if newv == 1
replace CLRTI_yes =. if newv == 1
replace Exposure = exposure_after_infection if newv==1
replace date_end_exposure = GBADATUMEINDEADRESHOUDING if (GBADATUMEINDEADRESHOUDING < date("20200101", "YMD") & newv==1)
replace date_end_exposure = date("20191231", "YMD") if (GBADATUMEINDEADRESHOUDING >= date("20200101", "YMD") & newv==1)

*Dropping double observations that are CLRTI based on diagnosis at death (these do not have a BeginCLRTI, but are CLRTI due to cause of death. A double observation has been made, but this is not necessary) These observations have missing Exposure as there is no exposure after infection.
drop if Exposure == .
drop if Exposure > GBADATUMEINDEADRESHOUDING

recode CLRTI (0=.)

*laatste dubbelen identificeren
sort rinpersoon Exposure date_end_exposure CLRTI
by rinpersoon Exposure date_end_exposure: generate PP = _n
browse if PP != 1
drop if PP != 1
drop PP
duplicates report rinpersoon Exposure date_end_exposure

* Altering double observations based on Exposure
sort rinpersoon Exposure newv2 newv CLRTI
by rinpersoon Exposure: generate PP = _n
browse if PP != 1
drop if PP != 1
drop PP
* observations that overlap and are not CLRTI yes

/*repeating the same process as a loop
sort rinpersoon Exposure newv2 newv CLRTI
by rinpersoon Exposure: generate PP = _n
by rinpersoon: gen lagged_variable2 = exposure_after_infection[_n-1] if _n > 1 & rinpersoon == rinpersoon[_n-1]
format lagged_variable2 %td
replace Exposure = lagged_variable2 if (PP==2 & lagged_variable2 != .)
drop PP*/


*Altering double observations based on End date
sort rinpersoon date_end_exposure newv2 newv CLRTI
by rinpersoon date_end_exposure: generate PP = _n
tab PP

format rinpersoon %15.0g
browse if PP==2
* Allemaal onnodige dubbelen die Exposure > date_end_exposure hebben
drop if PP == 2
drop PP
duplicates report rinpersoon Exposure date_end_exposure
duplicates report rinpersoon date_end_exposure
duplicates report rinpersoon Exposure 
*Geen dubbelen meer
recode CLRTI (.=0)
tab CLRTI

*dataset met start en end gebaseerd op postcode en CLRTI
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTI_pos_postcodes.dta", replace

* zelfde proces maar dan voor mensen zonder CLRTI, dus alleen verschillende start en einddatum bij verhuizing
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\NonCLRTILongMerged.dta", clear
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
drop if (GBADATUMEINDEADRESHOUDING < date("20140101", "YMD") | GBADATUMAANVANGADRESHOUDING >= date("20200101", "YMD"))

generate Exposure = date("20140101", "YMD")
format Exposure %td
/*exposure begint later als persoon pas na 1 januari in Den Haag kwam wonen*/
replace Exposure = GBADATUMAANVANGADRESHOUDING if GBADATUMAANVANGADRESHOUDING>Exposure 
/*follow-up stopt niet als persoon uitkomst heeft gehad*/
generate date_end_exposure = GBADATUMEINDEADRESHOUDING if GBADATUMEINDEADRESHOUDING < date("20200101", "YMD")
replace date_end_exposure = date("20191231", "YMD") if GBADATUMEINDEADRESHOUDING >= date("20200101", "YMD")
replace date_end_exposure = overlijdensdatum if (overlijdensdatum>=Exposure & overlijdensdatum<date_end_exposure  & overlijdensdatum !=.) 
format date_end_exposure %td
* dropping duplicates
duplicates drop rinpersoon GBADATUMAANVANGADRESHOUDING GBADATUMEINDEADRESHOUDING, force
sort rinpersoon GBADATUMAANVANGADRESHOUDING
destring rinpersoon, replace
* dataset met verschillende exposure en einddatum exposure gebaseerd op postcodes
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\non_CLRTI_postcodes.dta", replace

*samenvoegen bestanden
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTI_pos_postcodes.dta", clear
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\non_CLRTI_postcodes.dta"
recode CLRTI (.=0)
tab CLRTI

sort birthday
gen date_18 = birthday+(18*365.25)
format %td date_18
gen Exposure2 = Exposure if Exposure>=date_18 & Exposure!=.
replace Exposure2 = date_18 if Exposure<date_18 & date_end_exposure>= date_18 & Exposure!=.
drop if Exposure2==.
drop Exposure
rename Exposure2 Exposure
format %td Exposure

* nog sommigen die wel CLRTI 1 hbben staan maar onjuist
tab doodsoorzaak
* doodsoorzaak J108 t/m J22 houdt verband met onderste luchtweginfecties --> zoeken welke gecodeerde cijfers daarbij horen = 315 t/m 321
generate CLRTI_cause2 = .
foreach val of numlist 315 316 317 318 319 320 321 {
	replace CLRTI_cause2 = 1 if doodsoorzaak==`val'
}
drop CLRTI_cause
rename CLRTI_cause2 CLRTI_cause
replace CLRTI = 1 if (CLRTI_cause == 1)
replace CLRTI = 0 if (CLRTI_cause != 1 & BeginCLRTI ==.)
replace CLRTI = 0 if CLRTI_cause == 1 & BeginCLRTI ==. & overlijdensdatum > GBADATUMEINDEADRESHOUDING

sort rinpersoon Exposure date_end_exposure
by rinpersoon Exposure date_end_exposure: gen NN = _n
tab NN

drop if NN == 2 

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTI_Incidence_Final.dta", replace

*Incidence Analyses
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTI_Incidence_Final.dta", clear
*stset for analysis 
stset date_end_exposure, failure(CLRTI==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)

browse if _st == 0									  
browse if _st == 0 & CLRTI == 1 

* Crude incidence rate overall and per postal code
stptime, title(person-years) by(postalcode) per(1000) dd(2)

drop if postalcode==2491 | postalcode==2495
* Definitive crude incidence rate 
stptime, title(person-years) by(postalcode) per(1000) dd(2)

stsplit agecat, at(10(10)130) after(time=birthday)

replace agecat = 18 if agecat==10 | agecat==20
replace agecat = 90 if agecat==100 | agecat==110

stptime, title(person-years) by(agecat) per(1000) 

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Crude_Incidence_Rates.dta", replace
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Crude_Incidence_Rates.dta", clear

strate agecat gbageslacht, per(1000) output("H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\incidence_per_age_gender.dta", replace)
strate agecat gbageslacht postalcode, output("H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\incidence_per_age_gender_postalcode.dta", replace)
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\incidence_per_age_gender.dta", clear
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\incidence_per_age_gender_postalcode.dta", clear
sort agecat gbageslacht
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\incidence_per_age_gender_postalcode.dta", replace

* Adjusted overall and stratified incidence rate for postal code(for age and sex) 
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2017\ADRESSEN2017.dta", clear

gen one_jan = mdy(01,01,2017)
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
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\adressen_01012017.dta", replace

use "G:\Bevolking\GBAPERSOONTAB\2017\geconverteerde data\GBAPERSOON2017TABV1.dta", clear
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\adressen_01012017.dta"
keep if _merge==3
drop _merge
destring gbageboortedag gbageboortemaand gbageboortejaar, replace
generate birthday=mdy(gbageboortemaand, gbageboortedag, gbageboortejaar)
format birthday %d
keep gbageslacht birthday
generate age2017 = (mdy(01,01,2017) - birthday)/365.25
drop if age2017<18
egen agecat = cut(age2017), at(10(10)130)
replace agecat = 18 if agecat==10 | agecat==20
replace agecat = 90 if agecat==100 | agecat==110
/*HB agecat 18-30, 30-40, ..., 90+*/

/*syntax uit -help dstdize-*/

collapse (count) count=age2017, by(agecat gbageslacht)
egen total_population = total(count)
gen pop = (count / total_population)

sort agecat gbageslacht
destring gbageslacht, replace
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\reference population.dta", replace

use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\incidence_per_age_gender_postalcode.dta", clear
sort agecat gbageslacht

merge m:1 agecat gbageslacht using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\reference population.dta"
gen rate = _D/_Y
gen product = rate*pop
by postalcode, sort: egen adj_rate = sum(product)
gen rate_per_1000 = (adj_rate * 1000)

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\adjusted_incidence_per_postalcode.dta", replace

*Adjusted incidence 
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\adjusted_incidence_per_postalcode.dta", clear
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
**************************************************************************************

* Voor mortality rates
/* Dataset moet omgebouwd worden naar date_end_exposure == death waarbij een case thirtydaymortality is*/
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2014\CLRTILong2014.dta", clear
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\CLRTILong2015.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2016\CLRTILong2016.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2017\CLRTILong2017.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2018\CLRTILong2018.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\CLRTILong2019.dta"
duplicates drop
generate diff_mortality = overlijdensdatum - BeginCLRTI
replace Thirtydaymortality = 1 if (diff_mortality < 30 & CLRTI == 1)
replace Thirtydaymortality = 0 if diff_mortality >= 30
replace Thirtydaymortality = 1 if CLRTI_cause == 1
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
drop if (GBADATUMEINDEADRESHOUDING < date("20140101", "YMD") | GBADATUMAANVANGADRESHOUDING >= date("20200101", "YMD"))
generate Exposure = date("20140101", "YMD")
format Exposure %td
/*Exposure begint later als persoon pas na 1 januari in Den Haag kwam wonen*/
replace Exposure = GBADATUMAANVANGADRESHOUDING if GBADATUMAANVANGADRESHOUDING>Exposure 
/*follow-up stopt niet als persoon uitkomst heeft gehad*/
generate date_end_exposure = GBADATUMEINDEADRESHOUDING if GBADATUMEINDEADRESHOUDING < date("20200101", "YMD")
replace date_end_exposure = date("20191231", "YMD") if GBADATUMEINDEADRESHOUDING >= date("20200101", "YMD")
replace date_end_exposure = overlijdensdatum if (overlijdensdatum>=Exposure & overlijdensdatum<date_end_exposure  & overlijdensdatum !=.) 
format date_end_exposure %td
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
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Mortality14-19.dta", replace

* Crude overall CLRTI related mortality rate
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Mortality14-19.dta", clear
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

sort rinpersoon birthday 
by rinpersoon: replace birthday = birthday[_n-1] if _n > 1 & rinpersoon == rinpersoon[_n-1] 

stsplit agecat, at(10(10)130) after(time=birthday)

replace agecat = 18 if agecat==10 | agecat==20
replace agecat = 90 if agecat==100 | agecat==110

stptime, title(person-years) by(agecat) per(1000) 

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Crude_Mortality_Rates.dta", replace
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Crude_Mortality_Rates.dta", clear

strate agecat gbageslacht, per(1000) output("H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\mortality_per_age_gender.dta", replace)
strate agecat gbageslacht postalcode, output("H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\mortality_per_age_gender_postalcode.dta", replace)
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\mortality_per_age_gender.dta", clear
sort agecat gbageslacht 
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\mortality_per_age_gender.dta", replae
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\mortality_per_age_gender_postalcode.dta", clear
sort agecat gbageslacht
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\mortality_per_age_gender_postalcode.dta", replace

* Adjusted overall and stratified incidence rate for postal code(for age and sex) 
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\mortality_per_age_gender_postalcode.dta", clear
sort agecat gbageslacht

merge m:1 agecat gbageslacht using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\reference population.dta"
gen rate = _D/_Y
gen product = rate*pop
by postalcode, sort: egen adj_rate = sum(product)
gen rate_per_1000 = (adj_rate * 1000)

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\adjusted_mortality_per_postalcode.dta", replace

* To see adjusted rates
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\adjusted_mortality_per_postalcode.dta", clear 
format %9.3g rate_per_1000
browse postalcode adj_rate rate_per_1000

 