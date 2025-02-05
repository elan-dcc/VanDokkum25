*Data preparation CLRTI data; E. van Dokkum, H. Borgdorff, april 2024

*preparation of personal data
use "G:\Bevolking\GBAPERSOONTAB\2015\geconverteerde data\GBAPERSOON2015TABV1.dta"
sort rinpersoon rinpersoons
*dropping variables not needed for analyses
drop gbageslachtmoeder gbageslachtvader gbageboortejaarmoeder gbageboortemaandmoeder gbageboortedagmoeder gbageboortejaarvader gbageboortemaandvader gbageboortedagvader
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\PERSOONTAB2015.dta", replace
*date of birth, country of birth, sex

*preparation of postal codes to make datasets smaller and stick to The Hague cases
use "G:\BouwenWonen\VSLPOSTCODEBUS\geconverteerde data\VSLPOSTCODEBUSV2020031.DTA", clear
*Transforming rinobjectnummer from strL to str# to allow merging on rinobjectnummer
generate str rinobjectnummer_string = rinobjectnummer
replace rinobjectnummer = "."
compress rinobjectnummer
replace rinobjectnummer = rinobjectnummer_string
drop rinobjectnummer_string
describe rinobjectnummer
*only keeping postal codes corresponding to the Hague
destring postcodenum, replace force
keep if postcodenum == 2490 | postcodenum == 2491 | postcodenum == 2492 | postcodenum == 2493 | postcodenum == 2494 | postcodenum == 2495 | postcodenum == 2496 | postcodenum == 2497 | postcodenum == 2498 | postcodenum == 2500 | postcodenum == 2501 | postcodenum == 2502 | postcodenum == 2503 | postcodenum == 2504 | postcodenum == 2505 | postcodenum == 2506 | postcodenum == 2507 | postcodenum == 2508 | postcodenum == 2509 | postcodenum == 2511 | postcodenum == 2512 | postcodenum == 2513 | postcodenum == 2514 | postcodenum == 2515 | postcodenum == 2516 | postcodenum == 2517 | postcodenum == 2518 | postcodenum == 2521 | postcodenum == 2522 | postcodenum == 2523 | postcodenum == 2524 | postcodenum == 2525 | postcodenum == 2526 | postcodenum == 2531 | postcodenum == 2532 | postcodenum == 2533 | postcodenum == 2541 | postcodenum == 2542 | postcodenum == 2543 | postcodenum == 2544 | postcodenum == 2545 | postcodenum == 2546 | postcodenum == 2547 | postcodenum == 2548 | postcodenum == 2551 | postcodenum == 2552 | postcodenum == 2553 | postcodenum == 2554 | postcodenum == 2555 | postcodenum == 2561 | postcodenum == 2562 | postcodenum == 2563 | postcodenum == 2564 | postcodenum == 2565 | postcodenum == 2566 | postcodenum == 2571 | postcodenum == 2572 | postcodenum == 2573 | postcodenum == 2574 | postcodenum == 2581 | postcodenum == 2582 | postcodenum == 2583 | postcodenum == 2584 | postcodenum == 2585 | postcodenum == 2586 | postcodenum == 2587 | postcodenum == 2591 | postcodenum == 2592 | postcodenum == 2593 | postcodenum == 2594 | postcodenum == 2595 | postcodenum == 2596 | postcodenum == 2597
rename datumaanvpostcodenumadres datumaanvpostcodenumadres1
rename datumeindpostcodenumadres datumeindpostcodenumadres1
generate datumaanvpostcodenumadres = date(datumaanvpostcodenumadres1, "YMD")
generate datumeindpostcodenumadres = date(datumeindpostcodenumadres1, "YMD")
format datumaanvpostcodenumadres %td
format datumeindpostcodenumadres %td
drop datumaanvpostcodenumadres1 datumeindpostcodenumadres1
sort rinobjectnummer soortobjectnummer datumaanvpostcodenumadres
by rinobjectnummer: generate measurement = _n
*some houses change postal code over time
reshape wide datumaanvpostcodenumadres datumeindpostcodenumadres postcodenum, i(rinobjectnummer) j(measurement)
sort soortobjectnummer rinobjectnummer 
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\POSTCODES2015.dta", replace
*houses with corresponding postal codes in The Hague.

*preparation of adresses dataset to link with postal codes
use "G:\Bevolking\GBAADRESOBJECTBUS\geconverteerde data\GBAADRESOBJECT2021BUSV1.dta",clear
rename SOORTOBJECTNUMMER soortobjectnummer
rename RINOBJECTNUMMER rinobjectnummer
rename RINPERSOON rinpersoon
rename RINPERSOONS rinpersoons
sort rinobjectnummer soortobjectnummer
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\ADRESSEN2015.dta", replace
*which person in which house during which period

*Linking adressess with postal codes to assign every house a postal code to link a person to a postal code and only include people residing in the hague
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\ADRESSEN2015.dta", clear
merge m:1 rinobjectnummer soortobjectnummer using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\POSTCODES2015.dta"


rename _merge merge_postalcodes
keep if merge_postalcodes == 3
sort rinpersoon rinpersoons
rename GBADATUMAANVANGADRESHOUDING GBADATUMAANVANGADRESHOUDING1
rename GBADATUMEINDEADRESHOUDING GBADATUMEINDEADRESHOUDING1
generate GBADATUMAANVANGADRESHOUDING = date(GBADATUMAANVANGADRESHOUDING1, "YMD")
format GBADATUMAANVANGADRESHOUDING %td
generate GBADATUMEINDEADRESHOUDING = date(GBADATUMEINDEADRESHOUDING1, "YMD")
format GBADATUMEINDEADRESHOUDING %td
drop GBADATUMAANVANGADRESHOUDING1 GBADATUMEINDEADRESHOUDING1
drop if GBADATUMEINDEADRESHOUDING < date("20141231", "YMD") 
drop if GBADATUMAANVANGADRESHOUDING > date("20160101", "YMD")
*taking the last postal code per house to compare the same neighbourhoods
sort rinpersoon rinpersoons
by rinpersoon: generate measurement = _n
gen postalcode = postcodenum1 if postcodenum2==.
replace postalcode = postcodenum2 if postcodenum3 ==. & postcodenum2 !=.
replace postalcode = postcodenum3 if postcodenum3 !=.
drop postcodenum1 datumaanvpostcodenumadres1 datumeindpostcodenumadres1 postcodenum2 datumaanvpostcodenumadres2 datumeindpostcodenumadres2 postcodenum3 datumaanvpostcodenumadres3 datumeindpostcodenumadres3 merge_postalcodes
reshape wide soortobjectnummer rinobjectnummer postalcode GBADATUMAANVANGADRESHOUDING GBADATUMEINDEADRESHOUDING, i(rinpersoon) j(measurement)
*dropping all variables that are not necessary to link a dataset based on a person and adress: drop all variables except rinpersoon?
keep rinpersoon rinpersoons
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\INHABITANTS_THEHAGUE_2015.dta", replace

*Merging the personal data file with the merged postal code file to only include people in the final dataset that have lived in the Hague
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\PERSOONTAB2015.dta", clear
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\INHABITANTS_THEHAGUE_2015.dta"

keep if _merge == 3 
drop _merge
sort rinpersoon rinpersoons
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\MERGED2015V1.dta", replace

* Merging previous file with SESWOAInhatab/Vehtab dataset and keeping matched or only in the first dataset to stick to the the Hague population and keep de definitive Merged file of 2019
*Export SESWOA external source (spss) to stata
*preparation of SESWOA
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\SESWOA2015V3.dta", clear
rename RINPERSOONHKW rinpersoonhkw
rename RINPERSOONSHKW rinpersoonshkw
* generating the mean of the education scores and total scores to create a SESWOA variable
egen DeelscoreOpleidingsniveau = rmean(DEELSCOREOPLEIDINGSNIVEAU_1 - DEELSCOREOPLEIDINGSNIVEAU_15)
egen SESWOATOTAALSCORE = rmean (TOTAALSCORE_1 - TOTAALSCORE_15)
drop DEELSCOREOPLEIDINGSNIVEAU_1 - DEELSCOREOPLEIDINGSNIVEAU_15
drop TOTAALSCORE_1 - TOTAALSCORE_15
sort rinpersoonhkw rinpersoonshkw
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\SESWOA2015.dta", replace
* SESWOA per household
*preparation of Inhatab
*use "G:\InkomenBestedingen\INHATAB\geconverteerde data\KOPPELPERSOONHUISHOUDEN2015.dta" to match rinpersoon to household
use "G:\InkomenBestedingen\INHATAB\geconverteerde data\INHA2015TABV1.DTA"
drop inhpopiiv inhpriminkh inhuaf inhuafl inhuaftyp inharmeur inharmeurl inharmlag inharmlagl inharmsoc inharmsocl inhbbihj inhbelih inhbestinkh inhbrutinkh inhehalgr inhgestinkh
sort rinpersoonhkw rinpersoonshkw
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\INHATAB2015.dta", replace
*income per household*
use "G:\InkomenBestedingen\INHATAB\geconverteerde data\KOPPELPERSOONHUISHOUDEN2015.dta"
*to match rinpersoon to household*
rename RINPERSOON rinpersoon
rename RINPERSOONS rinpersoons
rename RINPERSOONSHKW rinpersoonshkw
rename RINPERSOONHKW rinpersoonhkw
sort rinpersoonhkw rinpersoonshkw
*merge INHATAB with Koppelpersoonhuishouden to link household income to a person
merge m:1 rinpersoonhkw rinpersoonshkw using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\INHATAB2015.dta"

sort rinpersoon rinpersoons
drop _merge
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\INHATAB2015Linked.dta", replace
*household income per person*
*preparation of Vehtab
use "G:\InkomenBestedingen\VEHTAB\geconverteerde data\VEH2015TABV2.DTA"
drop VEHW1100BEZH VEHW1110FINH VEHW1111BANH VEHW1112EFFH VEHW1120ONRH VEHW1121WONH VEHW1122OGOH VEHW1130ONDH VEHW1140ABEH VEHW1150OVEH VEHW1200STOH VEHW1210SHYH VEHW1220SSTH VEHW1230SOVH vehwverexewh
sort rinpersoonhkw rinpersoonshkw
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\VEHTAB2015.dta", replace
*'vermogen'wealth per household*

*Merging the previous 2 linked files and merging with SESWOA to get de complete dataset
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\INHATAB2015Linked.dta"
merge m:1 rinpersoonhkw rinpersoonshkw using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\VEHTAB2015.dta"

sort rinpersoonhkw rinpersoonshkw
drop _merge
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\VermogenInkomen2015.dta", replace 
*household 'vermogen'/wealth and household income per person*
*merging previous file and SESWOA to provide every person with a household SESWOA
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\VermogenInkomen2015.dta", clear
merge m:1 rinpersoonhkw rinpersoonshkw using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\SESWOA2015.dta"

sort rinpersoon rinpersoons

drop _merge 
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\SESMERGED2015.dta", replace
*household income and wealth per person, SESWOA per person *
*merging the main merged file with SESWOA
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\MERGED2015V1.dta", clear
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\SESMERGED2015.dta"
keep if _merge == 3 | _merge == 1
drop _merge
sort rinpersoon rinpersoons
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\MERGED2015V2.dta", replace

*Merging the previous Merged file with the MergedMortality file and keeping matched or only in the first dataset to stick to the the Hague population and keep all persons still alive
*sorting of date of death dataset
use "G:\Bevolking\GBAOVERLIJDENTAB\2015\geconverteerde data\GBAOVERLIJDENTAB 2015V1.DTA", clear
sort rinpersoon rinpersoons
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\OverlijdensDatum.dta", replace
*date of death per person*
*sorting of cause of death dataset
use "G:\GezondheidWelzijn\DOODOORZTAB\2015\geconverteerde data\DOODOORZ2015TABV2.dta", clear
sort rinpersoon rinpersoons
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\Doodsoorzaak2015.dta", replace
*cause of death per person*
*linking cause of death to death date 
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\OverlijdensDatum.dta"
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\Doodsoorzaak2015.dta"

gen overlijdensdatum = date(GBADatumOverlijden, "YMD")
format overlijdensdatum %td
gen overleden_2015 = 1 if overlijdensdatum <= date("20160131", "YMD") & overlijdensdatum >= date("20150101", "YMD")
replace overleden_2015 = 0 if overleden_2015==.
tab _merge overleden_2015, m col

rename _merge merge_mortality
drop NNDLocationCode plovl statjaar overleden_2015 GBADatumOverlijden
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\SterfteMERGED.dta", replace
*merging main merged file with mortality information
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\MERGED2015V2.dta", clear
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\SterfteMERGED.dta"
sort rinpersoon rinpersoons
drop if _merge == 2
drop _merge
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\MERGED2015V3.dta", replace

*Merging the  Main Merged file with the household dataset and only keep if matched or only in the first dataset to stick to the the Hague population
*Preparation of household information
use "G:\Bevolking\GBAHUISHOUDENSBUS\geconverteerde data\GBAHUISHOUDENS2019BUSV1.DTA", clear
rename datumaanvanghh datumaanvanghh1
rename datumeindehh datumeindehh1
generate datumaanvanghh = date(datumaanvanghh1, "YMD")
format datumaanvanghh %td
generate datumeindehh = date(datumeindehh1, "YMD")
format datumeindehh %td
drop datumaanvanghh1 datumeindehh1
drop if datumeindehh < date("20150101", "YMD")
drop if datumaanvanghh > date("20151231", "YMD")
sort rinpersoon rinpersoons
merge m:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\INHABITANTS_THEHAGUE_2015.dta"
keep if _merge == 3
drop _merge
sort rinpersoon rinpersoons
rename datumaanvanghh date_start
rename datumeindehh date_end
*create categories as defined in the analysis plan: 1. One-person household without children 2. One parent household with children 3. couple without children 4. couple with children 5. more than two-person adult household withouth children 6. more than parents adult household with children (eg multigenerational) 7. Institutional household 8. Other household type with one or two adults
destring typhh plhh, replace
gen adults_in_household_children = aantalpershh - aantalkindhh
tab typhh adults_in_household_children if typhh == 6 | typhh == 4 | typhh == 5, m

generate Household2015 = 1 if typhh == 1 & plhh == 2 & aantalpershh == 1 
replace Household2015 = 2 if typhh == 6 & adults_in_household_children == 1
replace Household2015 = 3 if (typhh == 2 | typhh == 3) & aantalpershh == 2
replace  Household2015 = 4 if (typhh == 4 | typhh == 5) & adults_in_household_children == 2
replace Household2015 = 5 if aantalpershh > 2 & aantalkindhh == 0
replace Household2015 = 6 if ((typhh == 4 | typhh == 5) & adults_in_household_children > 2) | (typhh == 6 & adults_in_household_children > 1)
replace Household2015 = 7 if typhh == 8
replace Household2015 = 8 if typhh == 7 & aantalkindhh == 0 & (aantalpershh == 1 | aantalpershh == 2)

*nu nog geen duplicates verwijderen; mogelijk verschuiven ze heen-en-terug naar dezelfde categorie
keep rinpersoons rinpersoon date_end date_start Household2015
*reshaping to merge 1:1 with the main 2015 dataset 
by rinpersoon: generate measurement = _n
reshape wide date_start date_end Household2015, i(rinpersoon) j(measurement)
gen start1 = date_start1
gen household1 = Household20151

foreach i of numlist 2/38 {
	display `i'
	local j = `i'-1
	gen start`i' = date_start`i' if Household2015`j' != Household2015`i' 
	replace start`i' = date_start`i' if Household2015`j' == Household2015`i' & date_start`i' >= date_end`j'+2
	gen household`i' = Household2015`i' if Household2015`j' != Household2015`i'
	replace household`i' = Household2015`i' if Household2015`j' == Household2015`i' & date_start`i' >= date_end`j'+2
}

foreach i of numlist 1/37 {
	display `i'
	local k = `i'+1
	gen stop`i' = date_end`i' if Household2015`k' != Household2015`i'
	replace stop`i' = date_end`i' if Household2015`k' == Household2015`i' & date_start`k' >= date_end`i'+2
}
gen stop38 = date_end38

reshape long date_start date_end Household2015 start stop household, i(rinpersoon) j(measurement)
drop if Household2015==.

gen long obs_no = _n
sort rinpersoon

foreach i of numlist 2/38 {
	local j = `i'-1
	gen stop`i' = stop[_n+1] if stop==.
	replace stop = stop`i' if stop==.
	drop stop`i'
}

drop if household==.

rename start start_Huishouden
rename stop stop_Huishouden

format start_Huishouden %td
format stop_Huishouden %td

keep rinpersoon rinpersoons household start_Huishouden stop_Huishouden
sort rinpersoon rinpersoons

by rinpersoon: generate measurement = _n 
reshape wide start_Huishouden household stop_Huishouden, i(rinpersoon) j(measurement)
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\HUISHOUDEN2015.dta", replace

*merging with the main dataset
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\MERGED2015V3.dta", clear
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\HUISHOUDEN2015.dta"
sort rinpersoon rinpersoons
rename SESWOATOTAALSCORE SESWOA2015
drop _merge
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\MERGED2015V4.dta", replace

*Hier moet de dataset dan nog samengevoegd worden met de DBC data met onze inclusiecriteria (ELV data is vanaf 2017, WLZ vanaf 2015)
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\MERGED2015V4.dta", clear
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\ComorbiditiesMerged2015.dta"
drop merge_Comorbidities _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\CLRTI2015.dta"
drop _merge
*merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\Exacerbations2015.dta"
*drop _merge
*creating a birthday instead of just lose month, day, year
destring gbageboortedag gbageboortemaand gbageboortejaar, replace
generate birthday=mdy(gbageboortemaand, gbageboortedag, gbageboortejaar)
format birthday %d
generate age2019 = (mdy(12,31,2019) - birthday)/365.25
*drop everyone that could not have been 18 for at least a day in our cohort pupulation (someone to be 18 at 30-12-2019 at the latest)
drop if age2019 < 18.00000

/*repeating the process for Asthma/COPD exacerbations
generate Age_COPD_DBC2015_1 = age(birthday, BeginExacerbation2015_1)
generate Age_COPD_DBC2015_2 = age(birthday, BeginExacerbation2015_2)
generate Age_COPD_DBC2015_3 = age(birthday, BeginExacerbation2015_3)
generate Age_COPD_DBC2015_4 = age(birthday, BeginExacerbation2015_4)
generate Age_COPD_DBC2015_5 = age(birthday, BeginExacerbation2015_5)
generate Age_COPD_DBC2015_6 = age(birthday, BeginExacerbation2015_6)
generate Age_COPD_DBC2015_7 = age(birthday, BeginExacerbation2015_7)
generate Age_COPD_DBC2015_8 = age(birthday, BeginExacerbation2015_8)*/
* dropping unnecessary variables: as we already have established if someone adhered to the inclusion criteria in the DBC-dataset we can drop these variables to make the database smaller
*drop excl_HospitalAdmission* excl_HospitalAdmissionCOPD* diff_HospitalAdmission* diff_HospitalAdmissionCOPD* 

*hercoderen CLRTI uitkomst op te analyseren
recode Neoplastic_Disease (.=0)
recode Liver_Disease (.=0)
recode Congestive_HF (.=0)
recode Cerebrovascular_Disease (.=0)
recode Renal_Disease (.=0)
recode Pulmonary_Disease (.=0)
recode Dementia (.=0)
recode Neurologic_Disease (.=0)
recode Diabetes (.=0)
recode HIV (.=0)
recode Immunocompromised (.=0)
recode Cardiovascular_Disease_other (.=0)
* Generating a variable for 30dayMortality
generate Thirtydaymortality = 1 if diff_Deathdate1 < 30 | diff_Deathdate2 < 30 
recode Thirtydaymortality (.=0)
* including people who died from CLRTI but were not admissed
encode uccode, generate(doodsoorzaak)
generate CLRTI_cause = doodsoorzaak
recode CLRTI_cause (314/320= 1) 
*destring variables that are still string variables to allow data analyses
destring gbageboorteland gbageslacht gbageboortelandmoeder gbageboortelandvader gbaaantaloudersbuitenland gbaherkomstgroepering gbageneratie, replace
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\MERGED2015FINAL.dta", replace