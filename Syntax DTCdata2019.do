* Preparation of datasets in order to create seperate datasets with all CLRTI cases, all complicated Asthma/COPD exacerbations and a separate dataset with comorbidities of everyone in The Hague

*merging the standard MSZPrestatie DTC dataset with the MSZZorgactiviteiten dataset to link a zorgactiviteit to a prestatie in order to link a possibl admission to a diagnosis
*merging datasets first with postal codes to only include people living in The Hague in 2019
use "G:\GezondheidWelzijn\MSZPRESTATIESVEKTTAB\2019\geconverteerde data\MSZPrestatiesVEKT2019TABV3.dta", clear
drop VEKTMSZDeclaratiecode VEKTMSZDeclaratietype VEKTMSZVergoedbedragZVW VEKTMSZVergoedbedragAV VEKTMSZIndicatorZVWAV VEKTMSZVerwijzer VEKTMSZAfsluitreden VEKTMSZIndicatieOngeval vektmszuzovi VEKTMSZInstellingPrest VEKTMSZSoortDeclaratie VEKTMSZSpecialismeZorgvraagCombi VEKTMSZDeclaratiecode VEKTMSZDeclaratietype VEKTMSZVergoedbedragZVW VEKTMSZVergoedbedragAV VEKTMSZIndicatorZVWAV VEKTMSZVerwijzer VEKTMSZAfsluitreden VEKTMSZIndicatieOngeval VEKTMSZSegment VEKTMSZSpecialismeVerwijzer
sort rinpersoon rinpersoons
merge m:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\INHABITANTS_THEHAGUE_2019.dta"
keep if _merge == 3 
drop _merge
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MSZ2019.dta", replace

* sorting the MSZ Zorgactiviteiten dataset to link them to each other based on the specific dtc (has to be exported from another data source)
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MSZZorgactiviteitenVEKT2019TABV2.dta", clear
rename RINPERSOON rinpersoon
rename RINPERSOONS rinpersoons
sort rinpersoon rinpersoons
merge m:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\INHABITANTS_THEHAGUE_2019.dta"
keep if _merge == 3 
drop _merge
sort VEKTMSZKoppelIDPrestZa VEKTMSZBeginjaarPrest
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MSZZorgactiviteiten2019.dta", replace

*merge MSZ prestaties met MSZ zorgactiviteit
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MSZ2019.dta"
sort VEKTMSZKoppelIDPrestZa VEKTMSZBeginjaarPrest
merge m:m VEKTMSZKoppelIDPrestZa VEKTMSZBeginjaarPrest using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MSZZorgactiviteiten2019.dta"

drop _merge
sort rinpersoon rinpersoons
generate DTC_stringed = VEKTMSZSpecialismeDiagnoseCombin
destring DTC_stringed, generate(DTC_codes) ignore ("- A B C D E F G H I J K L M V Z") 
format %15.0g DTC_codes
*check which code stands for missing ()
replace DTC_codes = . if DTC_codes == 999999999999
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MSZMERGED2019.dta", replace

*MSZ merge with Medication to combine for the specification of comorbidities
*sorting of medication use dataset
use "G:\GezondheidWelzijn\MEDICIJNTAB\2019\geconverteerde data\MEDICIJN2019TABV1.dta", clear
sort rinpersoon rinpersoons
*only keeping the relevant medication to make the dataset smaller, in order to do so we have to recode the letters to corresponding numbers to make ATC4 numeric. 
encode ATC4, generate(ATC4_numeric)
*check which coded numbers correspond to (A10A A10B =1) (R03A R03B R03C R03D = 2) (L04A=3) (L01B L01X = 4) (H02A=5) 
generate ATC4_category = ATC4_numeric
recode ATC4_category (16/17=1) (173/176=2) (136=3) (131/132=4) (106=5) (else=0)
drop if ATC4_category == 0
drop ATC4
rename ATC4_numeric ATC4
merge m:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\INHABITANTS_THEHAGUE_2019.dta"
keep if _merge == 3
drop _merge
sort rinpersoon rinpersoons
by rinpersoon: generate measurement = _n
reshape wide ATC4 ATC4_category, i(rinpersoon) j(measurement)
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MEDICIJNEN2019.dta", replace

*New seperate databases for CAP+ILI, Asthma, Comorbidities, SEH, beeldvorming en opname

*New dataset for comorbidities 
*nieuwe variabele Neoplastic Disease
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MSZMERGED2019.dta", clear
*MSZ to include only needed comorbidities and diagnoses
generate double Neoplastic_Disease = DTC_codes
format %15.0g Neoplastic_Disease
gen Neoplastic_Disease2 =.
foreach val of numlist 30201000021 30203000060 30203000061 30203000062 30203000063 30203000064 30203000065 30203000066 30203000067 30203000068 30203000069 30204000072 30205000084 30303300303 30303300306 30303300315 30303300318 30303300319 30303320330 30303320331 30303320332 30303320333 30303320334 30303320335 30303320346 30303320347 30303320349 30303320367 30303320370 30303330350 30303330352 30303330353 30303330357 30303330358 30303430352 30303430360 30303400363 30511001110 30511001140 30511001150 30601000010 30601000016 30602000020 30603000030 30604000040 30605000050 30606000060 30606000069 30607000070 30607000078 30603000084 30605000092 307000011 307000012 307000013 307000014 307000015 307000016 307000099 31302000214 31302000264 31306000621 31306000622 31306000623 31306000624 31306000629 31307000751 31307000752 31307000753 31307000754 31307000756 31307000757 31307000761 31307000771 31308000801 31308000802 31308000811 31308000821 31308000822 31308000823 31308000831 31308000832 31308000833 31308000834 31308000839 31308000841 31308000842 31308000843 31308000899 31309000904 31309000914 31309000964 31309000979 3180000307 3180000407 3180000408 3180000610 3180000712 3180000735 32213001303 32213001304 32213001305 32213001306 32213001308 33002000202 33002000203 33002000213 33002000223 33002000233 33002000242 33002000243  {
	replace Neoplastic_Disease2 = 1 if DTC_codes ==`val'
}
drop Neoplastic_Disease
rename Neoplastic_Disease2 Neoplastic_Disease
*Liver disease 
generate double Liver_Disease = DTC_codes
format %15.0g Liver_Disease
gen Liver_Disease2 =.
foreach val of numlist 31304000463 31309000942 31309000943 31309000944 31309000945 31309000946 3180000701 3180000705 3180000707 3180000708 3180000709 3180000713 3180000718  {
	replace Liver_Disease2 = 1 if DTC_codes ==`val'
}
drop Liver_Disease
rename Liver_Disease2 Liver_Disease
*Congestive Heart failure:
generate double Congestive_HF = DTC_codes
format %15.0g Congestive_HF
gen Congestive_HF2 =.
foreach val of numlist 31301000107 32003000301 32003000302 33526000262  {
	replace Congestive_HF2 = 1 if DTC_codes ==`val'
}
drop Congestive_HF
rename Congestive_HF2 Congestive_HF
*Cerebrovascular disease: 
generate double Cerebrovascular_Disease = DTC_codes
format %15.0g Cerebrovascular_Disease
gen Cerebrovascular_Disease2 = .
foreach val of numlist 31301000121 33011001102 33011001111 33011001112 33526000263  {
	replace Cerebrovascular_Disease2 = 1 if DTC_codes ==`val'
}
drop Cerebrovascular_Disease
rename Cerebrovascular_Disease2 Cerebrovascular_Disease
*Renal disease: 
generate double Renal_Disease = DTC_codes
format %15.0g Renal_Disease
gen Renal_Disease2 = .
foreach val of numlist 31303000324 31303000325 31303000331 31303000332 31303000336 31303000339  {
	replace Renal_Disease2 = 1 if DTC_codes ==`val'
}
drop Renal_Disease
rename Renal_Disease2 Renal_Disease

*Pulmonary disease (other): 
generate double Pulmonary_Disease = DTC_codes
format %15.0g Pulmonary_Disease
gen Pulmonary_Disease2 = .
foreach val of numlist 30303310309 31306000601 32212001201 32212001241 32214001403 33527000272 32212001202 32212001203 {
	replace Pulmonary_Disease2 = 1 if DTC_codes ==`val'
}
drop Pulmonary_Disease
rename Pulmonary_Disease2 Pulmonary_Disease

*Dementia: 
generate double Dementia = DTC_codes
format %15.0g Dementia
gen Dementia2 = .
foreach val of numlist 31311000091 33004000401  {
	replace Dementia2 = 1 if DTC_codes ==`val'
}
drop Dementia 
rename Dementia2 Dementia

*Neurologic disease:
generate double Neurologic_Disease = DTC_codes
format %15.0g Neurologic_Disease
gen Neurologic_Disease2 = .
foreach val of numlist 33005000501 33005000522 33005000531 33009000911 33009000999 33525000252  {
	replace Neurologic_Disease2 = 1 if DTC_codes ==`val'
}
drop Neurologic_Disease
rename Neurologic_Disease2 Neurologic_Disease

*Diabetes:
generate double Diabetes = DTC_codes
format %15.0g Diabetes
gen Diabetes2 = .
foreach val of numlist 31302000221 31302000222 31302000223 3180000902 33522000222  {
	replace Diabetes2 = 1 if DTC_codes ==`val'
}
drop Diabetes
rename Diabetes2 Diabetes

*HIV: 
generate double HIV = DTC_codes
format %15.0g HIV
gen HIV2=.
foreach val of numlist 31304000461 31304000462  {
	replace HIV2 = 1 if DTC_codes ==`val'
}
drop HIV 
rename HIV2 HIV

*Immunocompromised: 
generate double Immunocompromised = DTC_codes
format %15.0g Immunocompromised
gen Immunocompromised2 = .
foreach val of numlist 30303320325 30303320326 30305400551 30305400553 30305400554 30305400555 30305400557 30305400559 30305400560 30305400561 30305400562 30305400563 30513001394 31300000070 31300000072 31300000073 31300000074 31300000076 31300000078 31300000079 31300000081 31300000082 31300000083 31305000501 31305000503 31305000512 31305000515 31305000521 31305000522 31305000523 31305000524 31305000525 31305000526 31305000527 31309000922 31309000923 32401000101 32401000102 32401000114 32402000201 32402000202 32403000301 32403000302 32403000304 32403000305 32403000306 32403000307 32403000311 32403000312 32403000313 32403000315 32403000316 32403000317 32403000318 32403000319 32829002910 32829002920 32829002930  {
	replace Immunocompromised2 = 1 if DTC_codes ==`val'
}
drop Immunocompromised
rename Immunocompromised2 Immunocompromised

*Cardiovascular disease (other): 
generate double Cardiovascular_Disease_other = DTC_codes
format %15.0g Cardiovascular_Disease_other
gen Cardiovascular_Disease_other2 =.
foreach val of numlist 30304370412 30304370418 30304370419 30304370420 31301000124 31301000133 32002000202 32002000203 32002000204 32002000205 32006000601 32008000801 32008000802 32008000803 32008000804 32822002220 32823002320 32824002400 32824002415 32824002425 32824002470 32825002550 32825002555 32825002560 32825002570 32825002585 32826002630 32826002635 32826002640 32826002645 32826002650 32826002655 32826002665 32827002720 32827002740 32827002770 32827002785 32829002940 32832003210 32833003310  {
	replace Cardiovascular_Disease_other2 = 1 if DTC_codes ==`val'
}
drop Cardiovascular_Disease_other
rename Cardiovascular_Disease_other2 Cardiovascular_Disease_other
keep if Neoplastic_Disease == 1 | Liver_Disease == 1 | Congestive_HF == 1 | Cerebrovascular_Disease == 1 | Renal_Disease == 1 | Pulmonary_Disease == 1 | Dementia == 1| Neurologic_Disease == 1 | Diabetes == 1 | HIV == 1 | Immunocompromised == 1 | Cardiovascular_Disease_other == 1
drop VEKTMSZBegindatumPrest VEKTMSZEinddatumPrest VEKTMSZAantalPrest VEKTMSZBehandelendSpecialisme VEKTMSZZorgtype VEKTMSZDBCZorgproduct VEKTMSZSoortinstelling4cat VEKTMSZSettingZPK VEKTMSZVolgnummerZa VEKTMSZInstellingZa VEKTMSZZorgactiviteitVolgnummer VEKTMSZUitvoerendSpecialisme VEKTMSZZorgactiviteit VEKTMSZAantalZa VEKTMSZKoppelIDPrestZa VEKTMSZBeginjaarPrest VEKTMSZSubtrajectnummer VEKTMSZEinddatumZT VEKTMSZSpecialismeDiagnoseCombin VEKTMSZZorgactiviteitdatum
generate BeginZorgtraject = date(VEKTMSZBegindatumZT, "YMD")
format BeginZorgtraject %td
drop VEKTMSZBegindatumZT
*only keeping the first/earliest observation of a certain zorgtraject
/*HB: eigenlijk wil je de eerste observatie van elke comorbiditeit, toch? Aangepast*/

foreach var of varlist Neoplastic_Disease Liver_Disease Congestive_HF Cerebrovascular_Disease Renal_Disease Pulmonary_Disease Dementia Neurologic_Disease Diabetes HIV Immunocompromised Cardiovascular_Disease_other {
	sort rinpersoon rinpersoons `var' BeginZorgtraject
	by rinpersoon rinpersoons `var': generate measurement = _n if `var'==1
	drop if `var'==1 & measurement>=2
	drop measurement
}

* Creating starting dates if DTC corresponds to a comorbidity
generate startdatum_Neoplastic = BeginZorgtraject if Neoplastic_Disease == 1
format startdatum_Neoplastic %td
generate startdatum_Liver = BeginZorgtraject if Liver_Disease == 1 
format startdatum_Liver %td
generate startdatum_CongestiveHF = BeginZorgtraject if Congestive_HF == 1 
format startdatum_CongestiveHF %td
generate startdatum_Cerebrovascular = BeginZorgtraject if Cerebrovascular_Disease == 1 
format startdatum_Cerebrovascular %td
generate startdatum_Renal = BeginZorgtraject if Renal_Disease == 1 
format startdatum_Renal %td
generate startdatum_Pulmonary = BeginZorgtraject if Pulmonary_Disease == 1 
format startdatum_Pulmonary %td
generate startdatum_Dementia = BeginZorgtraject if Dementia == 1 
format startdatum_Dementia %td
generate startdatum_Neurologic = BeginZorgtraject if Neurologic_Disease == 1 
format startdatum_Neurologic %td
generate startdatum_Diabetes = BeginZorgtraject if Diabetes == 1 
format startdatum_Diabetes %td
generate startdatum_HIV = BeginZorgtraject if HIV == 1 
format startdatum_HIV %td
generate startdatum_Immunocompromised = BeginZorgtraject if Immunocompromised == 1 
format startdatum_Immunocompromised %td
generate startdatum_Cardiovascular = BeginZorgtraject if Cardiovascular_Disease_other == 1
format startdatum_Cardiovascular %td
*merge with people living in the Hague
sort rinpersoon rinpersoons
merge m:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\INHABITANTS_THEHAGUE_2019.dta"
keep if _merge == 3
drop _merge 
sort rinpersoon rinpersoons BeginZorgtraject
drop VEKTMSZZorgtrajectnummer DTC_stringed DTC_codes
sort rinpersoon rinpersoons
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\Comorbidities_DTC_2019_temp.dta", replace

foreach comorb in Neoplastic_Disease Liver_Disease Congestive_HF Cerebrovascular_Disease Renal_Disease Pulmonary_Disease Dementia Neurologic_Disease Diabetes HIV Immunocompromised Cardiovascular_Disease_other {
	use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\Comorbidities_DTC_2019_temp.dta", clear
	keep rinpersoon rinpersoons BeginZorgtraject `comorb'
	rename BeginZorgtraject St`comorb'
	keep if `comorb'==1
	save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ `comorb'_DTC_2019_temp.dta", replace
}

use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ Neoplastic_Disease_DTC_2019_temp.dta", clear
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ Liver_Disease_DTC_2019_temp.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ Congestive_HF_DTC_2019_temp.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ Cerebrovascular_Disease_DTC_2019_temp.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ Renal_Disease_DTC_2019_temp.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ Pulmonary_Disease_DTC_2019_temp.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ Dementia_DTC_2019_temp.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ Neurologic_Disease_DTC_2019_temp.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ Diabetes_DTC_2019_temp.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ HIV_DTC_2019_temp.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ Immunocompromised_DTC_2019_temp.dta"
drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ Cardiovascular_Disease_other_DTC_2019_temp.dta"
drop _merge
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ComorbiditiesDBC2019.dta", replace

*Comorbidities based on medication
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MEDICIJNEN2019.dta", clear
generate Diabetes = .
generate Immunocompromised = .
recode Diabetes (.=1) if ATC4_category1 == 1 | ATC4_category2 == 1 | ATC4_category3 == 1 | ATC4_category4 == 1 | ATC4_category5 == 1 | ATC4_category6 == 1 | ATC4_category7 == 1
recode Immunocompromised (.=1)  if ATC4_category1 == 3 | ATC4_category2 == 3 | ATC4_category3 == 3 | ATC4_category4 == 3 | ATC4_category5 == 3 | ATC4_category6 == 3 | ATC4_category7 == 3 | ATC4_category1 == 4 | ATC4_category2 == 4 | ATC4_category3 == 4 | ATC4_category4 == 4 | ATC4_category5 == 4 | ATC4_category6 == 4 | ATC4_category7 == 4 | ATC4_category1 == 5 | ATC4_category2 == 5 | ATC4_category3 == 5 | ATC4_category4 == 5 | ATC4_category5 == 5 | ATC4_category6 == 5 | ATC4_category7 == 5 
keep if Diabetes == 1 | Immunocompromised == 1 
drop ATC41 ATC4_category1 ATC42 ATC4_category2 ATC43 ATC4_category3 ATC44 ATC4_category4 ATC45 ATC4_category5 ATC46 ATC4_category6 ATC47 ATC4_category7 
sort rinpersoon rinpersoons
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ComorbiditiesMED2019.dta", replace
*Merging DBC comorbidities and Medication comorbidites
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ComorbiditiesDBC2019.dta", clear
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ComorbiditiesMED2019.dta"
rename _merge merge_Comorbidities
sort rinpersoon rinpersoons
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\ComorbiditiesMerged2019.dta", replace

* Preparation for Datasets for CLRTI and Asthma/COPD
* nieuwe variabele voor CAP+ILI (LRTI)
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MSZMERGED2019.dta", clear
*MSZ to include only needed comorbidities and diagnoses
generate double LRTI = DTC_codes
format %15.0g LRTI
*check which coded numbers correspond to the corresponding LRTI DTCs 
gen LRTI2 = .
foreach val of numlist 31304000401 31304000409 31304000469 32214001401 32214001405 31304000402 {
	replace LRTI2 = 1 if LRTI==`val'
}
drop LRTI
rename LRTI2 LRTI
sort rinpersoon rinpersoons
*nieuwe variabele voor Asthma/COPD
generate double Asthma_COPD = DTC_codes
format %15.0g Asthma_COPD
*check which coded numbers correspond to the corresponding COPD/Asthma DTCs 
gen COPD2 = .
foreach val of numlist 31306000601 32212001201 32212001202 32212001203 32212001241  {
	replace COPD2 = 1 if Asthma_COPD ==`val'
}
drop Asthma_COPD
rename COPD2 Asthma_COPD
keep if LRTI == 1 | Asthma_COPD == 1
sort rinpersoon rinpersoons VEKTMSZZorgtrajectnummer
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\LRTI&Asthma_COPD2019.dta", replace

*New dataset for SEH
*nieuwe variabele om SEH-bezoek te specificeren
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MSZMERGED2019.dta", clear
generate SEH = VEKTMSZZorgactiviteit
destring SEH, replace
recode SEH (190015=1) (else = 0)
keep if SEH == 1
gen datum_SEH = VEKTMSZZorgactiviteitdatum

keep rinpersoon rinpersoons VEKTMSZZorgtrajectnummer SEH datum_SEH
sort rinpersoon rinpersoons VEKTMSZZorgtrajectnummer 
duplicates drop

by rinpersoon rinpersoons VEKTMSZZorgtrajectnummer: generate measurement = _n
reshape wide SEH datum_SEH, i(rinpersoon rinpersoons VEKTMSZZorgtrajectnummer) j(measurement) 
*alle SEH data per zorgtraject*
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\SEH2019.dta", replace

*New dataset for beeldvorming
*nieuwe variabele om Beeldvorming te specificeren
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MSZMERGED2019.dta", clear
generate Beeldvorming = VEKTMSZZorgactiviteit
destring Beeldvorming, replace
gen Beeldvorming2 = .
foreach val of numlist 84042 85042 86042 85000 85002  {
	replace Beeldvorming2 = 1 if Beeldvorming==`val'
}
drop Beeldvorming
rename Beeldvorming2 Beeldvorming
keep if Beeldvorming == 1
sort rinpersoon rinpersoons
gen datum_beeldvorming = VEKTMSZZorgactiviteitdatum

keep rinpersoon rinpersoons VEKTMSZZorgtrajectnummer Beeldvorming datum_beeldvorming
duplicates drop
sort rinpersoon rinpersoons VEKTMSZZorgtrajectnummer 

by rinpersoon rinpersoons VEKTMSZZorgtrajectnummer: generate measurement = _n
reshape wide Beeldvorming datum_beeldvorming, i(rinpersoon rinpersoons VEKTMSZZorgtrajectnummer) j(measurement) 
*alle Beeldvorming data per zorgtraject*
sort rinpersoon rinpersoons VEKTMSZZorgtrajectnummer
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\Beeldvorming2019.dta", replace

*Gecombineerde dataset LRTI&Asthma_COPD + SEH + Beeldvorming
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\LRTI&Asthma_COPD2019.dta", clear
sort rinpersoon rinpersoons VEKTMSZZorgtrajectnummer 
keep if LRTI == 1
* merging based on rinpersoon rinpersoons and the Zorgtrajectnummer to link a SEH visit belonging to a certain corresponding Zorgtraject and person in the other dataset
merge m:1 rinpersoon rinpersoons VEKTMSZZorgtrajectnummer using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\SEH2019.dta"


/*hier selectie van zorgtrajecten met SEH bezoek*/
*keep if _merge == 3 | _merge == 1
keep if _merge == 3
drop _merge
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\LRTI_SEH2019.dta", replace
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\LRTI_SEH2019.dta", clear
sort rinpersoon rinpersoons VEKTMSZZorgtrajectnummer
* merging based on rinpersoon rinpersoons and the Zorgtrajectnummer to link Beeldvorming belonging to a certain corresponding Zorgtraject and person in the other dataset
merge m:1 rinpersoon rinpersoons VEKTMSZZorgtrajectnummer using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\Beeldvorming2019.dta"

keep if _merge == 3
drop _merge

/*select LRTIs/ astma/COPD with Beeldvorming and SEH on same day as start 

destring VEKTMSZZorgactiviteit, replace
* Only keeping observations with SEH or Beeldvorming on same day as start DBC*/
generate BeginLRTIDBC = date(VEKTMSZBegindatumPrest, "YMD")
format BeginLRTIDBC %td
generate EindLRTIDBC = date(VEKTMSZEinddatumPrest , "YMD")
format EindLRTIDBC %td
drop VEKTMSZBegindatumPrest VEKTMSZEinddatumPrest

drop VEKTMSZKoppelIDPrestZa VEKTMSZBeginjaarPrest VEKTMSZSubtrajectnummer VEKTMSZBegindatumZT VEKTMSZEinddatumZT VEKTMSZAantalPrest VEKTMSZBehandelendSpecialisme VEKTMSZZorgtype VEKTMSZSpecialismeDiagnoseCombin VEKTMSZDBCZorgproduct VEKTMSZSoortinstelling4cat VEKTMSZSettingZPK VEKTMSZVolgnummerZa VEKTMSZInstellingZa VEKTMSZZorgactiviteitVolgnummer VEKTMSZZorgactiviteitdatum VEKTMSZUitvoerendSpecialisme VEKTMSZZorgactiviteit VEKTMSZAantalZa

duplicates drop

gen LRTI_SEH = .
foreach num of numlist 1/29 {
	gen date_SEH`num' = date(datum_SEH`num', "YMD")
	format date_SEH`num' %td
	replace LRTI_SEH = 1 if BeginLRTIDBC == date_SEH`num'
}

gen date_LRTI_SEH = BeginLRTIDBC if LRTI_SEH==1
format date_LRTI_SEH %td

gen LRTI_SEH_Beeld = .
foreach num of numlist 1/40 {
	gen date_Beeld`num' = date(datum_beeldvorming`num', "YMD")
	format date_Beeld`num' %td
	replace LRTI_SEH_Beeld = 1 if BeginLRTIDBC == date_Beeld`num' & LRTI_SEH==1
}

gen date_LRTI_SEH_Beeld = date_LRTI_SEH if LRTI_SEH_Beeld==1
format date_LRTI_SEH_Beeld %td

keep rinpersoons rinpersoon DTC_stringed DTC_codes LRTI BeginLRTIDBC EindLRTIDBC LRTI_SEH_Beeld date_LRTI_SEH_Beeld VEKTMSZZorgtrajectnummer
drop if LRTI_SEH_Beeld!=1
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\LRTI_COPD_SEH_Beeld2019.dta", replace

*dropping if Asthma/COPD to have a dataset with only LRTI
keep if LRTI == 1
/*
*drop duplicate observations in the same DBC traject, as we've already established if someone has received SEH + beeldvorming in the same zorgtraject with same date of opened DBC*/
sort rinpersoon rinpersoons BeginLRTIDBC
by rinpersoon: generate measurement = _n
drop DTC_stringed LRTI 
reshape wide VEKTMSZZorgtrajectnummer DTC_codes BeginLRTIDBC EindLRTIDBC LRTI_SEH_Beeld date_LRTI_SEH_Beeld , i(rinpersoon) j(measurement)
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\LRTI_SEH_Beeld2019.dta", replace

/*alle opnames, ook niet-LRTI*/
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MSZMERGED2019.dta", clear

generate Opname = 1 if VEKTMSZSettingZPK =="3"
keep if Opname == 1
sort rinpersoon rinpersoons

generate BeginDBCopname = date(VEKTMSZBegindatumPrest, "YMD")
format BeginDBCopname %td
generate EindDBCopname = date(VEKTMSZEinddatumPrest , "YMD")
format EindDBCopname %td
drop VEKTMSZBegindatumPrest VEKTMSZEinddatumPrest 

keep rinpersoon rinpersoons VEKTMSZZorgtrajectnummer Opname BeginDBCopname EindDBCopname
sort rinpersoon rinpersoons VEKTMSZZorgtrajectnummer BeginDBCopname
duplicates drop

by rinpersoon rinpersoons: generate measurement = _n
drop Opname VEKTMSZZorgtrajectnummer
sort rinpersoon rinpersoons
reshape wide BeginDBCopname EindDBCopname, i(rinpersoon rinpersoons) j(measurement) 

*alle opname data per persoon, ook niet-LRTI*
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\HospitalAdmissions2019_all.dta", replace

*Merging datasets for LRTI, Hospital Admissions, ELV, Nursing Home admissions and mortality to create a CLRTI dataset
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\LRTI_SEH_Beeld2019.dta", clear
*merging with the mortality file to include deaths
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\SterfteMERGED.dta"
drop merge_mortality
keep if _merge == 3
drop _merge
generate diff_Deathdate1 = overlijdensdatum - BeginLRTIDBC1
generate diff_Deathdate2 = overlijdensdatum - BeginLRTIDBC2
generate diff_Deathdate3 = overlijdensdatum - BeginLRTIDBC3
*generate diff_Deathdate4 = overlijdensdatum - BeginLRTIDBC4
sort rinpersoon rinpersoons BeginLRTIDBC1
*generating CLRTI variable

generate CLRTI_Death1 = 1 if diff_Deathdate1 < 14 & diff_Deathdate1 >=0
generate CLRTI_Death2 = 1 if diff_Deathdate2 < 14 & diff_Deathdate2 >=0
generate CLRTI_Death3 = 1 if diff_Deathdate3 < 14 & diff_Deathdate3 >=0
*generate CLRTI_Death4 = 1 if diff_Deathdate4 < 14 & diff_Deathdate4 >=0
recode CLRTI_Death1 (.=0)
recode CLRTI_Death2 (.=0)
recode CLRTI_Death3 (.=0)
*recode CLRTI_Death4 (.=0)

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\InclusionDeath2019.dta", replace 

*merging LRTI_SEH_BEELD with hospitaladmissions 
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\LRTI_SEH_Beeld2019.dta", clear
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\HospitalAdmissions2019_all.dta"
drop if _merge==2
drop _merge
sort rinpersoon rinpersoons 
* creating new variables to determine if SEH, imaging and admission were within 14 days of each other 
foreach numrti of numlist 1/3 {
	foreach numopn of numlist 1/189 {
		gen diff_adm`numopn'_`numrti' = BeginDBCopname`numopn' - date_LRTI_SEH_Beeld`numrti' 
	}
}

foreach numrti of numlist 1/3 {
	gen CLRTI_adm`numrti' = .
	foreach numopn of numlist 1/189 {
		replace CLRTI_adm`numrti' = 1 if diff_adm`numopn'_`numrti' < 14 & diff_adm`numopn'_`numrti'>=0
	}
}

foreach numrti of numlist 1/3 {
	foreach numopn of numlist 1/189 {
		gen diff_admbefore`numopn'_`numrti' = date_LRTI_SEH_Beeld`numrti' - BeginDBCopname`numopn'
	}
}

foreach numrti of numlist 1/3 {
	gen excl_adm`numrti' = .
	foreach numopn of numlist 1/189 {
		replace excl_adm`numrti' = 1 if diff_admbefore`numopn'_`numrti' < 30 & diff_admbefore`numopn'_`numrti'>=1
	}
}

sort rinpersoon rinpersoons
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\InclusionsHospital2019.dta", replace


*merge the individual inclusion datasets with eachother
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\LRTI_SEH_Beeld2019.dta", clear
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\InclusionDeath2019.dta"

drop _merge
sort rinpersoon rinpersoons
merge 1:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\InclusionsHospital2019.dta"

drop if _merge == 2
drop _merge
sort rinpersoon rinpersoon
*drop variables not needed for analyses
drop BeginDBCopname* EindDBCopname* diff_adm* diff_admbefore*
*drop if HospitalExclusion == 1 to exclude possible hospital acquired cases
foreach var of varlist CLRTI_Death1 CLRTI_adm1 {
	replace `var' = 0 if excl_adm1==1
}
foreach var of varlist CLRTI_Death2 CLRTI_adm2 {
	replace `var' = 0 if excl_adm2==1
}
foreach var of varlist CLRTI_Death3 CLRTI_adm3 {
	replace `var' = 0 if excl_adm3==1
}
*generating variables for CLRTI case in 2019 and total cases per person
*Only keeping persons that have at least one case dat adheres to inclusion criteria
keep if CLRTI_adm1 == 1 | CLRTI_adm2 == 1 | CLRTI_adm3 == 1 | CLRTI_Death1 == 1 | CLRTI_Death2 == 1 | CLRTI_Death3 == 1 
***Alleen de eerste SEH bezoek etc als iemand binnen 14 dagen meerdere keren bij de SEH verschijnt en pas later (binnen 14 dagen van de eerste presentatie) wordt opgenomen.
gen diff_Hospitalisation1 = BeginLRTIDBC2 - BeginLRTIDBC1
gen diff_Hospitalisation2 = BeginLRTIDBC3 - BeginLRTIDBC2
*gen diff_Hospitalisation3 = BeginLRTIDBC4 - BeginLRTIDBC4
replace BeginLRTIDBC2 =. if diff_Hospitalisation1 < 14
replace EindLRTIDBC2 =. if diff_Hospitalisation1 < 14
replace date_LRTI_SEH_Beeld2 =. if diff_Hospitalisation1 < 14
replace CLRTI_adm2 =. if diff_Hospitalisation1 < 14
replace BeginLRTIDBC3 =. if diff_Hospitalisation2 < 14
replace EindLRTIDBC3 =. if diff_Hospitalisation2 < 14
replace date_LRTI_SEH_Beeld3 =. if diff_Hospitalisation2 < 14
replace CLRTI_adm3 =. if diff_Hospitalisation2 < 14
*replace BeginLRTIDBC4 =. if diff_Hospitalisation3 < 14
*replace EindLRTIDBC4 =. if diff_Hospitalisation3 < 14
*replace date_LRTI_SEH_Beeld4 =. if diff_Hospitalisation3 < 14
*replace CLRTI_adm4 =. if diff_Hospitalisation3 < 14
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\CLRTI2019.dta", replace
