*additional tables for incidence per migration background 2014-2019
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2014-2019_Final.dta", clear
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
drop N measurement_postalcode CLRTI_yes lagged_variable id_count tag newv2 newv NN DEELSCOREWELVAART* DEELSCOREARBEID* DEELSCOREOPLEIDINGSNIVEAU* diff_Hospitalisation* merge_mortality huishouden1_2018 huishouden2_2018 huishouden3_2018 huishouden4_2018 huishouden5_2018 huishouden6_2018 huishouden7_2018 huishouden8_2018 huishouden9_2018 huishouden10_2018 huishouden11_2018 huishouden12_2018 huishouden13_2018 huishouden14_2018 INHP100HBEST INHP100HGEST20* INHP100HPRIM VEHP100WELVAART20* VEHP100HVERM20* VEHW1000VERH20*
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace
recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2

*age category
gen age = (Exposure - birthday)/365.25
gen age_category = .
recode age_category (.=1) if (age >= 18 & age < 50)
recode age_category (.=2) if (age >= 50 & age < 60)
recode age_category (.=3) if (age >= 60 & age < 70)
recode age_category (.=4) if (age >= 70 & age < 80)
recode age_category (.=5) if age >= 80


*kruistabelen absoluut aantal per migrantengroep
keep if Exposure == date("20170101", "YMD")
*drop if age > 80
tab age_category Migratieachtergrond, column

*Welvaart
sort Migratieachtergrond age_category
*SES
by Migratieachtergrond age_category: summarize Welvaart, detail
by Migratieachtergrond: summarize Welvaart, detail

*kruistabellen overige variabelen
*2014-2019
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2014-2019_Final.dta", clear
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
drop N measurement_postalcode CLRTI_yes lagged_variable id_count tag newv2 newv NN DEELSCOREWELVAART* DEELSCOREARBEID* DEELSCOREOPLEIDINGSNIVEAU* diff_Hospitalisation* merge_mortality huishouden1_2018 huishouden2_2018 huishouden3_2018 huishouden4_2018 huishouden5_2018 huishouden6_2018 huishouden7_2018 huishouden8_2018 huishouden9_2018 huishouden10_2018 huishouden11_2018 huishouden12_2018 huishouden13_2018 huishouden14_2018 INHP100HBEST INHP100HGEST20* INHP100HPRIM VEHP100WELVAART20* VEHP100HVERM20* VEHW1000VERH20*
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace
recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2

*leeftijdscategorie
gen age = (Exposure - birthday)/365.25
gen age_category = .
recode age_category (.=1) if (age >= 18 & age < 50)
recode age_category (.=2) if (age >= 50 & age < 60)
recode age_category (.=3) if (age >= 60 & age < 70)
recode age_category (.=4) if (age >= 70 & age < 80)
recode age_category (.=5) if age >= 80
*drop if age > 80

*CLRTI
stset date_end_exposure, failure(CLRTI==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)
stptime, title(person-years) by(Migratieachtergrond) per(1000) dd(2)
stsplit agecat, at(50 60 70 80) after(time=birthday)
strate Migratieachtergrond agecat, per(1000) 

*LRTI_mortality mortality
generate LRTI_mortality = .
generate diff_mortality = overlijdensdatum - BeginCLRTI
replace LRTI_mortality = 1 if CLRTI_cause == 1 & CLRTI == 1
replace LRTI_mortality = 1 if diff_mortality < 30 & CLRTI == 1
replace LRTI_mortality = 0 if CLRTI == 0
stset date_end_exposure, failure(LRTI_mortality==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)
stptime, title(person-years) by(Migratieachtergrond) per(1000) dd(2)
strate Migratieachtergrond agecat, per(1000)

*Overall_mortality
sort rinpersoon overlijdensdatum
by rinpersoon overlijdensdatum: gen N = _n
gen Overall_mortality = .
replace Overall_mortality = 1 if overlijdensdatum != . & N == 1
recode Overall_mortality (.=0)
drop N
stset date_end_exposure, failure(Overall_mortality==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)
stptime, title(person-years) by(Migratieachtergrond) per(1000) dd(2)
strate Migratieachtergrond agecat, per(1000)


*kruistabellen absoluut aantal per migrantengroep 2020
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2020_Final.dta", clear
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace
*1 Nederland
*2 Europa (exclusief Nederland)
*3	Turkije 
*4	Marokko
*5	Suriname
*6	Voormalige Nederlandse Antillen en Aruba
*7	Indonesia
*8	Overig Afrika
*9	Overig Azie
*10 Overig Amerika en Oceanie
recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2

*leeftijdscategorie
gen age = (Exposure - birthday)/365.25
gen age_category = .
recode age_category (.=1) if (age >= 18 & age < 50)
recode age_category (.=2) if (age >= 50 & age < 60)
recode age_category (.=3) if (age >= 60 & age < 70)
recode age_category (.=4) if (age >= 70 & age < 80)
recode age_category (.=5) if age >= 80

*kruistabelen absoluut aantal per migrantengroep
keep if Exposure == date("20200101", "YMD")
*drop if age > 80
drop if age <18
tab age_category Migratieachtergrond, column

sort Migratieachtergrond age_category
*SES mediaan met IQR
by Migratieachtergrond: summarize Welvaart, detail
by Migratieachtergrond age_category: summarize Welvaart, detail

*kruistabellen overige variabelen 2020
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2020_Final.dta", clear
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace
*1 Nederland
*2 Europa (exclusief Nederland)
*3	Turkije 
*4	Marokko
*5	Suriname
*6	Voormalige Nederlandse Antillen en Aruba
*7	Indonesia
*8	Overig Afrika
*9	Overig Azie
*10 Overig Amerika en Oceanie
recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2

*leeftijdscategorie
gen age = (Exposure - birthday)/365.25
gen age_category = .
recode age_category (.=1) if (age >= 18 & age < 50)
recode age_category (.=2) if (age >= 50 & age < 60)
recode age_category (.=3) if (age >= 60 & age < 70)
recode age_category (.=4) if (age >= 70 & age < 80)
recode age_category (.=5) if age >= 80

drop if age <18
*drop if age >80
*CLRTI
stset date_end_exposure, failure(CLRTI==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)
stptime, title(person-years) by(Migratieachtergrond) per(1000) dd(2)
stsplit agecat, at(50 60 70 80) after(time=birthday)
strate Migratieachtergrond agecat, per(1000) 

drop doodsoorzaak
encode UCCODE, generate(doodsoorzaak)
tab doodsoorzaak
*316 317 318 320 321 612 613 614 615 616 617 618
generate CLRTI_cause2 = .
foreach val of numlist 316 317 318 320 321 612 613 614 615 616 617 618 681 682 {
	replace CLRTI_cause2 = 1 if doodsoorzaak==`val'
}
drop CLRTI_cause
rename CLRTI_cause2 CLRTI_cause
generate diff_mortality = overlijdensdatum - BeginCLRTI 



*LRTI mortality
generate LRTI_mortality = .
replace LRTI_mortality = 1 if CLRTI_cause == 1 & CLRTI == 1
replace LRTI_mortality = 1 if diff_mortality < 30 & CLRTI == 1
replace LRTI_mortality = 0 if CLRTI == 0
stset date_end_exposure, failure(LRTI_mortality==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)
stptime, title(person-years) by(Migratieachtergrond) per(1000) dd(2)
strate Migratieachtergrond agecat, per(1000)

*Overall_mortality
sort rinpersoon overlijdensdatum
by rinpersoon overlijdensdatum: gen N = _n
gen Overall_mortality = .
replace Overall_mortality = 1 if overlijdensdatum != . & N == 1
recode Overall_mortality (.=0)
drop N
stset date_end_exposure, failure(Overall_mortality==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)
stptime, title(person-years) by(Migratieachtergrond) per(1000) dd(2)
strate Migratieachtergrond agecat, per(1000)


*Gestratificeerd op SES kwintiel 2014-2019
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2014-2019_Final.dta", clear
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
drop N measurement_postalcode CLRTI_yes lagged_variable id_count tag newv2 newv NN DEELSCOREWELVAART* DEELSCOREARBEID* DEELSCOREOPLEIDINGSNIVEAU* diff_Hospitalisation* merge_mortality huishouden1_2018 huishouden2_2018 huishouden3_2018 huishouden4_2018 huishouden5_2018 huishouden6_2018 huishouden7_2018 huishouden8_2018 huishouden9_2018 huishouden10_2018 huishouden11_2018 huishouden12_2018 huishouden13_2018 huishouden14_2018 INHP100HBEST INHP100HGEST20* INHP100HPRIM VEHP100WELVAART20* VEHP100HVERM20* VEHW1000VERH20*
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace

recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2
gen Welvaart_quintiles_reversed = .
recode Welvaart_quintiles_reversed (.=1) if (Welvaart > 80 & Welvaart <= 100)
recode Welvaart_quintiles_reversed (.=2) if (Welvaart > 60 & Welvaart <= 80)
recode Welvaart_quintiles_reversed (.=3) if (Welvaart > 40 & Welvaart <= 60)
recode Welvaart_quintiles_reversed (.=4) if (Welvaart > 20 & Welvaart <= 40)
recode Welvaart_quintiles_reversed (.=5) if (Welvaart > 0 & Welvaart <= 20)

*kruistabelen absoluut aantal per migrantengroep
keep if Exposure == date("20170101", "YMD")
gen age = (Exposure - birthday)/365.25
*drop if age >80
tab Welvaart_quintiles_reversed Migratieachtergrond, column
*leeftijd
sort Migratieachtergrond Welvaart_quintiles_reversed
by Migratieachtergrond Welvaart_quintiles_reversed: sum age, detail

*CLRTI en mortaliteit 2014-2019
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2014-2019_Final.dta", clear
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
drop N measurement_postalcode CLRTI_yes lagged_variable id_count tag newv2 newv NN DEELSCOREWELVAART* DEELSCOREARBEID* DEELSCOREOPLEIDINGSNIVEAU* diff_Hospitalisation* merge_mortality huishouden1_2018 huishouden2_2018 huishouden3_2018 huishouden4_2018 huishouden5_2018 huishouden6_2018 huishouden7_2018 huishouden8_2018 huishouden9_2018 huishouden10_2018 huishouden11_2018 huishouden12_2018 huishouden13_2018 huishouden14_2018 INHP100HBEST INHP100HGEST20* INHP100HPRIM VEHP100WELVAART20* VEHP100HVERM20* VEHW1000VERH20*
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace
recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2

gen Welvaart_quintiles_reversed = .
recode Welvaart_quintiles_reversed (.=1) if (Welvaart > 80 & Welvaart <= 100)
recode Welvaart_quintiles_reversed (.=2) if (Welvaart > 60 & Welvaart <= 80)
recode Welvaart_quintiles_reversed (.=3) if (Welvaart > 40 & Welvaart <= 60)
recode Welvaart_quintiles_reversed (.=4) if (Welvaart > 20 & Welvaart <= 40)
recode Welvaart_quintiles_reversed (.=5) if (Welvaart > 0 & Welvaart <= 20)

*CLRTI
stset date_end_exposure, failure(CLRTI==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)
gen age = (Exposure - birthday)/365.25
*drop if age >80
*stptime, title(person-years) by(Migratieachtergrond) per(1000) dd(2)
strate Migratieachtergrond Welvaart_quintiles_reversed, per(1000) 


*LRTI mortality
generate LRTI_mortality = .
generate diff_mortality = overlijdensdatum - BeginCLRTI
replace LRTI_mortality = 1 if CLRTI_cause == 1 & CLRTI == 1
replace LRTI_mortality = 1 if diff_mortality < 30 & CLRTI == 1
replace LRTI_mortality = 0 if CLRTI == 0
stset date_end_exposure, failure(LRTI_mortality==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)
strate Migratieachtergrond Welvaart_quintiles_reversed, per(1000)

*Overall_mortality
sort rinpersoon overlijdensdatum
by rinpersoon overlijdensdatum: gen N = _n
gen Overall_mortality = .
replace Overall_mortality = 1 if overlijdensdatum != . & N == 1
recode Overall_mortality (.=0)
drop N
stset date_end_exposure, failure(Overall_mortality==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)
strate Migratieachtergrond Welvaart_quintiles_reversed, per(1000)

*gestratificeerd op SES 2020
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2020_Final.dta", clear
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace

recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2
*kruistabelen absoluut aantal per migrantengroep
keep if Exposure == date("20200101", "YMD")
gen Welvaart_quintiles_reversed = .
recode Welvaart_quintiles_reversed (.=1) if (Welvaart > 80 & Welvaart <= 100)
recode Welvaart_quintiles_reversed (.=2) if (Welvaart > 60 & Welvaart <= 80)
recode Welvaart_quintiles_reversed (.=3) if (Welvaart > 40 & Welvaart <= 60)
recode Welvaart_quintiles_reversed (.=4) if (Welvaart > 20 & Welvaart <= 40)
recode Welvaart_quintiles_reversed (.=5) if (Welvaart > 0 & Welvaart <= 20)

*kruistabelen absoluut aantal per migrantengroep
gen age = (Exposure - birthday)/365.25
*drop if age >80
drop if age <18
sort Migratieachtergrond Welvaart_quintiles_reversed
tab Welvaart_quintiles_reversed Migratieachtergrond, column
by Migratieachtergrond Welvaart_quintiles_reversed: sum age, detail

*Overige kruistabellen 2020
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2020_Final.dta", clear
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace
 
recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2
gen Welvaart_quintiles_reversed = .
recode Welvaart_quintiles_reversed (.=1) if (Welvaart > 80 & Welvaart <= 100)
recode Welvaart_quintiles_reversed (.=2) if (Welvaart > 60 & Welvaart <= 80)
recode Welvaart_quintiles_reversed (.=3) if (Welvaart > 40 & Welvaart <= 60)
recode Welvaart_quintiles_reversed (.=4) if (Welvaart > 20 & Welvaart <= 40)
recode Welvaart_quintiles_reversed (.=5) if (Welvaart > 0 & Welvaart <= 20)

gen age = (Exposure - birthday)/365.25
*drop if age >80
drop if age <18
*CLRTI
stset date_end_exposure, failure(CLRTI==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)
*stptime, title(person-years) by(Migratieachtergrond) per(1000) dd(2)
strate Migratieachtergrond Welvaart_quintiles_reversed, per(1000)

drop doodsoorzaak
encode UCCODE, generate(doodsoorzaak)
tab doodsoorzaak
*316 317 318 320 321 612 613 614 615 616 617 618
generate CLRTI_cause2 = .
foreach val of numlist 316 317 318 320 321 612 613 614 615 616 617 618 681 682 {
	replace CLRTI_cause2 = 1 if doodsoorzaak==`val'
}
drop CLRTI_cause
rename CLRTI_cause2 CLRTI_cause
generate diff_mortality = overlijdensdatum - BeginCLRTI 

*LRTI mortality
generate LRTI_mortality = .
replace LRTI_mortality = 1 if CLRTI_cause == 1 & CLRTI == 1
replace LRTI_mortality = 1 if diff_mortality < 30 & CLRTI == 1
replace LRTI_mortality = 0 if CLRTI == 0
stset date_end_exposure, failure(LRTI_mortality==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)
strate Migratieachtergrond Welvaart_quintiles_reversed, per(1000)

*Overall_mortality
sort rinpersoon overlijdensdatum
by rinpersoon overlijdensdatum: gen N = _n
gen Overall_mortality = .
replace Overall_mortality = 1 if overlijdensdatum != . & N == 1
recode Overall_mortality (.=0)
drop N
stset date_end_exposure, failure(Overall_mortality==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)
strate Migratieachtergrond Welvaart_quintiles_reversed, per(1000)

* Aantal CLRTI episodes per SES kwintiel per griepseizoen
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2014-2019_Final.dta", clear
drop N measurement_postalcode CLRTI_yes lagged_variable id_count tag newv2 newv NN DEELSCOREWELVAART* DEELSCOREARBEID* DEELSCOREOPLEIDINGSNIVEAU* diff_Hospitalisation* merge_mortality huishouden1_2018 huishouden2_2018 huishouden3_2018 huishouden4_2018 huishouden5_2018 huishouden6_2018 huishouden7_2018 huishouden8_2018 huishouden9_2018 huishouden10_2018 huishouden11_2018 huishouden12_2018 huishouden13_2018 huishouden14_2018 INHP100HBEST INHP100HGEST20* INHP100HPRIM VEHP100WELVAART20* VEHP100HVERM20* VEHW1000VERH20*

gen Welvaart_quintiles_reversed = .
recode Welvaart_quintiles_reversed (.=1) if (Welvaart > 80 & Welvaart <= 100)
recode Welvaart_quintiles_reversed (.=2) if (Welvaart > 60 & Welvaart <= 80)
recode Welvaart_quintiles_reversed (.=3) if (Welvaart > 40 & Welvaart <= 60)
recode Welvaart_quintiles_reversed (.=4) if (Welvaart > 20 & Welvaart <= 40)
recode Welvaart_quintiles_reversed (.=5) if (Welvaart > 0 & Welvaart <= 20)

gen seizoen = 1314 if jaar==2014 & (kwartaal==1 | kwartaal==2)
replace seizoen = 1415 if (jaar==2014 & (kwartaal ==3 | kwartaal==4)) | (jaar==2015 & (kwartaal==1| kwartaal==2))
replace seizoen = 1516 if (jaar==2015 & (kwartaal ==3 | kwartaal==4)) | (jaar==2016 & (kwartaal==1| kwartaal==2))
replace seizoen = 1617 if (jaar==2016 & (kwartaal ==3 | kwartaal==4)) | (jaar==2017 & (kwartaal==1| kwartaal==2))
replace seizoen = 1718 if (jaar==2017 & (kwartaal ==3 | kwartaal==4)) | (jaar==2018 & (kwartaal==1| kwartaal==2))
replace seizoen = 1819 if (jaar==2018 & (kwartaal ==3 | kwartaal==4)) | (jaar==2019 & (kwartaal==1| kwartaal==2))
replace seizoen = 1920 if (jaar==2019 & (kwartaal ==3 | kwartaal==4))

stset date_end_exposure, failure(CLRTI==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)
strate Welvaart_quintiles_reversed seizoen, per(1000)
