*Syntax to prepare datasets for regression analyses and descriptive analyses for population characteristics

*in order to have an CLRTI case correspond to the period of residence, every yearly dataset has to be set in a long format based on the postalcodes of that year and the CLRTI cases in that particular year. After the datasets can be added together by appending using the "append" command

*datasets used are the result of the previously merged files

*2014
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2014\MERGED2014FINAL.dta", clear
drop rinpersoonshkw rinpersoonhkw inhahl inhahlmi INHP100HBESTES INHP100HBRUT INHP100HGESTES  inhsamaow inhsamhh MSZSTRZorgtrajectnummer* DTC_codes* LRTI_SEH_Beeld* diff_Deathdate* excl_adm* diff_Hospitalisation* gbageslacht BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld* merge_mortality IrisMainInjury
rename DEELSCOREWELVAART DEELSCOREWELVAART2014
rename DEELSCORERECENTARBEIDSVERLEDEN DEELSCOREARBEID2014
rename DeelscoreOpleidingsniveau DEELSCOREOPLEIDINGSNIVEAU2014
rename INHP100HGEST INHP100HGEST2014
rename VEHP100WELVAART VEHP100WELVAART2014
rename VEHP100HVERM VEHP100HVERM2014
rename VEHW1000VERH VEHW1000VERH2014
rename start_Huishouden1 start_Huishouden1_2014
rename household1 household1_2014
rename stop_Huishouden1 stop_Huishouden1_2014
rename start_Huishouden2 start_Huishouden2_2014
rename household2 household2_2014
rename stop_Huishouden2 stop_Huishouden2_2014
rename start_Huishouden3 start_Huishouden3_2014
rename household3 household3_2014
rename stop_Huishouden3 stop_Huishouden3_2014
rename start_Huishouden4 start_Huishouden4_2014
rename household4 household4_2014
rename stop_Huishouden4 stop_Huishouden4_2014
rename start_Huishouden5 start_Huishouden5_2014
rename household5 household5_2014
rename stop_Huishouden5 stop_Huishouden5_2014
rename start_Huishouden6 start_Huishouden6_2014
rename household6 household6_2014
rename stop_Huishouden6 stop_Huishouden6_2014
rename start_Huishouden7 start_Huishouden7_2014
rename household7 household7_2014
rename stop_Huishouden7 stop_Huishouden7_2014
rename start_Huishouden8 start_Huishouden8_2014
rename household8 household8_2014
rename stop_Huishouden8 stop_Huishouden8_2014
rename start_Huishouden9 start_Huishouden9_2014
rename household9 household9_2014
rename stop_Huishouden9 stop_Huishouden9_2014
rename start_Huishouden10 start_Huishouden10_2014
rename household10 household10_2014
rename stop_Huishouden10 stop_Huishouden10_2014
rename start_Huishouden11 start_Huishouden11_2014
rename household11 household11_2014
rename stop_Huishouden11 stop_Huishouden11_2014
rename Neoplastic_Disease Neoplastic_Disease2014 
rename StNeoplastic_Disease StNeoplastic_Disease2014
rename Liver_Disease Liver_Disease2014
rename StLiver_Disease StLiver_Disease2014
rename Congestive_HF Congestive_HF2014
rename StCongestive_HF StCongestive_HF2014
rename Cerebrovascular_Disease Cerebrovascular_Disease2014
rename StCerebrovascular_Disease StCerebrovascular_Disease2014
rename Renal_Disease Renal_Disease2014 
rename StRenal_Disease StRenal_Disease2014
rename Pulmonary_Disease Pulmonary_Disease2014
rename StPulmonary_Disease StPulmonary_Disease2014
rename Dementia Dementia2014
rename StDementia StDementia2014
rename Neurologic_Disease Neurologic_Disease2014
rename StNeurologic_Disease StNeurologic_Disease2014
rename Diabetes Diabetes2014
rename StDiabetes StDiabetes2014
rename HIV HIV2014
rename StHIV StHIV2014
rename Immunocompromised Immunocompromised2014
rename StImmunocompromised StImmunocompromised2014
rename Cardiovascular_Disease_other Cardiovascular_Disease_other2014
rename StCardiovascular_Disease_other StCardiovascular_other2014
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2014\Survival2014.dta", replace

*2015
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\MERGED2015FINAL.dta", clear
drop rinpersoonshkw rinpersoonhkw inhahl inhahlmi  INHP100HBESTES INHP100HBRUT  INHP100HGESTES inhsamaow inhsamhh MSZSTRZorgtrajectnummer* DTC_codes* LRTI_SEH_Beeld* diff_Deathdate* excl_adm* gbageslacht BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld* merge_mortality IrisMainInjury
rename DEELSCOREWELVAART DEELSCOREWELVAART2015
rename DEELSCORERECENTARBEIDSVERLEDEN DEELSCOREARBEID2015
rename DeelscoreOpleidingsniveau DEELSCOREOPLEIDINGSNIVEAU2015
rename INHP100HGEST INHP100HGEST2015
rename VEHP100WELVAART VEHP100WELVAART2015
rename VEHP100HVERM VEHP100HVERM2015
rename VEHW1000VERH VEHW1000VERH2015
rename start_Huishouden1 start_Huishouden1_2015
rename household1 household1_2015
rename stop_Huishouden1 stop_Huishouden1_2015
rename start_Huishouden2 start_Huishouden2_2015
rename household2 household2_2015
rename stop_Huishouden2 stop_Huishouden2_2015
rename start_Huishouden3 start_Huishouden3_2015
rename household3 household3_2015
rename stop_Huishouden3 stop_Huishouden3_2015
rename start_Huishouden4 start_Huishouden4_2015
rename household4 household4_2015
rename stop_Huishouden4 stop_Huishouden4_2015
rename start_Huishouden5 start_Huishouden5_2015
rename household5 household5_2015
rename stop_Huishouden5 stop_Huishouden5_2015
rename start_Huishouden6 start_Huishouden6_2015
rename household6 household6_2015
rename stop_Huishouden6 stop_Huishouden6_2015
rename start_Huishouden7 start_Huishouden7_2015
rename household7 household7_2015
rename stop_Huishouden7 stop_Huishouden7_2015
rename start_Huishouden8 start_Huishouden8_2015
rename household8 household8_2015
rename stop_Huishouden8 stop_Huishouden8_2015
rename start_Huishouden9 start_Huishouden9_2015
rename household9 household9_2015
rename stop_Huishouden9 stop_Huishouden9_2015
rename start_Huishouden10 start_Huishouden10_2015
rename household10 household10_2015
rename stop_Huishouden10 stop_Huishouden10_2015
rename start_Huishouden11 start_Huishouden11_2015
rename household11 household11_2015
rename stop_Huishouden11 stop_Huishouden11_2015
rename Neoplastic_Disease Neoplastic_Disease2015
rename StNeoplastic_Disease StNeoplastic_Disease2015
rename Liver_Disease Liver_Disease2015
rename StLiver_Disease StLiver_Disease2015
rename Congestive_HF Congestive_HF2015
rename StCongestive_HF StCongestive_HF2015
rename Cerebrovascular_Disease Cerebrovascular_Disease2015
rename StCerebrovascular_Disease StCerebrovascular_Disease2015
rename Renal_Disease Renal_Disease2015
rename StRenal_Disease StRenal_Disease2015
rename Pulmonary_Disease Pulmonary_Disease2015
rename StPulmonary_Disease StPulmonary_Disease2015
rename Dementia Dementia2015
rename StDementia StDementia2015
rename Neurologic_Disease Neurologic_Disease2015
rename StNeurologic_Disease StNeurologic_Disease2015
rename Diabetes Diabetes2015
rename StDiabetes StDiabetes2015
rename HIV HIV2015
rename StHIV StHIV2015
rename Immunocompromised Immunocompromised2015
rename StImmunocompromised StImmunocompromised2015
rename Cardiovascular_Disease_other Cardiovascular_Disease_other2015
rename StCardiovascular_Disease_other StCardiovascular_other2015
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2015\Survival2015.dta", replace

*2016
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2016\MERGED2016FINAL.dta", clear
drop rinpersoonshkw rinpersoonhkw inhahl inhahlmi INHP100HBESTES INHP100HBRUT INHP100HGESTES inhsamaow inhsamhh VEKTMSZZorgtrajectnummer* DTC_codes* LRTI_SEH_Beeld* diff_Deathdate* excl_adm* gbageslacht BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld* merge_mortality IrisMainInjury
rename DEELSCOREWELVAART DEELSCOREWELVAART2016
rename DEELSCORERECENTARBEIDSVERLEDEN DEELSCOREARBEID2016
rename DeelscoreOpleidingsniveau DEELSCOREOPLEIDINGSNIVEAU2016
rename INHP100HGEST INHP100HGEST2016
rename VEHP100WELVAART VEHP100WELVAART2016
rename VEHP100HVERM VEHP100HVERM2016
rename VEHW1000VERH VEHW1000VERH2016
rename start_Huishouden1 start_Huishouden1_2016
rename household1 household1_2016
rename stop_Huishouden1 stop_Huishouden1_2016
rename start_Huishouden2 start_Huishouden2_2016
rename household2 household2_2016
rename stop_Huishouden2 stop_Huishouden2_2016
rename start_Huishouden3 start_Huishouden3_2016
rename household3 household3_2016
rename stop_Huishouden3 stop_Huishouden3_2016
rename start_Huishouden4 start_Huishouden4_2016
rename household4 household4_2016
rename stop_Huishouden4 stop_Huishouden4_2016
rename start_Huishouden5 start_Huishouden5_2016
rename household5 household5_2016
rename stop_Huishouden5 stop_Huishouden5_2016
rename start_Huishouden6 start_Huishouden6_2016
rename household6 household6_2016
rename stop_Huishouden6 stop_Huishouden6_2016
rename start_Huishouden7 start_Huishouden7_2016
rename household7 household7_2016
rename stop_Huishouden7 stop_Huishouden7_2016
rename start_Huishouden8 start_Huishouden8_2016
rename household8 household8_2016
rename stop_Huishouden8 stop_Huishouden8_2016
rename start_Huishouden9 start_Huishouden9_2016
rename household9 household9_2016
rename stop_Huishouden9 stop_Huishouden9_2016
rename start_Huishouden10 start_Huishouden10_2016
rename household10 household10_2016
rename stop_Huishouden10 stop_Huishouden10_2016
rename Neoplastic_Disease Neoplastic_Disease2016
rename StNeoplastic_Disease StNeoplastic_Disease2016
rename Liver_Disease Liver_Disease2016
rename StLiver_Disease StLiver_Disease2016
rename Congestive_HF Congestive_HF2016
rename StCongestive_HF StCongestive_HF2016
rename Cerebrovascular_Disease Cerebrovascular_Disease2016
rename StCerebrovascular_Disease StCerebrovascular_Disease2016
rename Renal_Disease Renal_Disease2016
rename StRenal_Disease StRenal_Disease2016
rename Pulmonary_Disease Pulmonary_Disease2016
rename StPulmonary_Disease StPulmonary_Disease2016
rename Dementia Dementia2016
rename StDementia StDementia2016
rename Neurologic_Disease Neurologic_Disease2016
rename StNeurologic_Disease StNeurologic_Disease2016
rename Diabetes Diabetes2016
rename StDiabetes StDiabetes2016
rename HIV HIV2016
rename StHIV StHIV2016
rename Immunocompromised Immunocompromised2016
rename StImmunocompromised StImmunocompromised2016
rename Cardiovascular_Disease_other Cardiovascular_Disease_other2016
rename StCardiovascular_Disease_other StCardiovascular_other2016
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2016\Survival2016.dta", replace

*2017
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2017\MERGED2017FINAL.dta", clear
drop rinpersoonshkw rinpersoonhkw inhahl inhahlmi INHP100HBESTES INHP100HBRUT INHP100HGESTES inhsamaow inhsamhh VEKTMSZZorgtrajectnummer* DTC_codes* LRTI_SEH_Beeld* diff_Deathdate* excl_adm* gbageslacht BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld* diff_Hospitalisation* merge_mortality IrisMainInjury
rename DEELSCOREWELVAART DEELSCOREWELVAART2017
rename DEELSCORERECENTARBEIDSVERLEDEN DEELSCOREARBEID2017
rename DeelscoreOpleidingsniveau DEELSCOREOPLEIDINGSNIVEAU2017
rename INHP100HGEST INHP100HGEST2017
rename VEHP100WELVAART VEHP100WELVAART2017
rename VEHP100HVERM VEHP100HVERM2017
rename VEHW1000VERH VEHW1000VERH2017
rename start_Huishouden1 start_Huishouden1_2017
rename household1 household1_2017
rename stop_Huishouden1 stop_Huishouden1_2017
rename start_Huishouden2 start_Huishouden2_2017
rename household2 household2_2017
rename stop_Huishouden2 stop_Huishouden2_2017
rename start_Huishouden3 start_Huishouden3_2017
rename household3 household3_2017
rename stop_Huishouden3 stop_Huishouden3_2017
rename start_Huishouden4 start_Huishouden4_2017
rename household4 household4_2017
rename stop_Huishouden4 stop_Huishouden4_2017
rename start_Huishouden5 start_Huishouden5_2017
rename household5 household5_2017
rename stop_Huishouden5 stop_Huishouden5_2017
rename start_Huishouden6 start_Huishouden6_2017
rename household6 household6_2017
rename stop_Huishouden6 stop_Huishouden6_2017
rename start_Huishouden7 start_Huishouden7_2017
rename household7 household7_2017
rename stop_Huishouden7 stop_Huishouden7_2017
rename start_Huishouden8 start_Huishouden8_2017
rename household8 household8_2017
rename stop_Huishouden8 stop_Huishouden8_2017
rename start_Huishouden9 start_Huishouden9_2017
rename household9 household9_2017
rename stop_Huishouden9 stop_Huishouden9_2017
rename start_Huishouden10 start_Huishouden10_2017
rename household10 household10_2017
rename stop_Huishouden10 stop_Huishouden10_2017
rename start_Huishouden11 start_Huishouden11_2017
rename household11 household11_2017
rename stop_Huishouden11 stop_Huishouden11_2017
rename Neoplastic_Disease Neoplastic_Disease2017
rename StNeoplastic_Disease StNeoplastic_Disease2017
rename Liver_Disease Liver_Disease2017
rename StLiver_Disease StLiver_Disease2017
rename Congestive_HF Congestive_HF2017
rename StCongestive_HF StCongestive_HF2017
rename Cerebrovascular_Disease Cerebrovascular_Disease2017
rename StCerebrovascular_Disease StCerebrovascular_Disease2017
rename Renal_Disease Renal_Disease2017
rename StRenal_Disease StRenal_Disease2017
rename Pulmonary_Disease Pulmonary_Disease2017
rename StPulmonary_Disease StPulmonary_Disease2017
rename Dementia Dementia2017
rename StDementia StDementia2017
rename Neurologic_Disease Neurologic_Disease2017
rename StNeurologic_Disease StNeurologic_Disease2017
rename Diabetes Diabetes2017
rename StDiabetes StDiabetes2017
rename HIV HIV2017
rename StHIV StHIV2017
rename Immunocompromised Immunocompromised2017
rename StImmunocompromised StImmunocompromised2017
rename Cardiovascular_Disease_other Cardiovascular_Disease_other2017
rename StCardiovascular_Disease_other StCardiovascular_other2017
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2017\Survival2017.dta", replace

*2018
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2018\MERGED2018FINAL.dta", clear
drop rinpersoonshkw rinpersoonhkw inhahl inhahlmi INHP100HBESTES INHP100HBRUT INHP100HGESTES INHP100HPRIM inhsamaow inhsamhh VEKTMSZZorgtrajectnummer* DTC_codes* LRTI_SEH_Beeld* diff_Deathdate* excl_adm* diff_Hospitalisation* gbageslacht BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld* merge_mortality IrisMainInjury
rename DEELSCOREWELVAART DEELSCOREWELVAART2018
rename DEELSCORERECENTARBEIDSVERLEDEN DEELSCOREARBEID2018
rename DeelscoreOpleidingsniveau DEELSCOREOPLEIDINGSNIVEAU2018
rename INHP100HGEST INHP100HGEST2018
rename VEHP100WELVAART VEHP100WELVAART2018
rename VEHP100HVERM VEHP100HVERM2018
rename VEHW1000VERH VEHW1000VERH2018
rename start_Huishouden1 start_Huishouden1_2018
rename household1 household1_2018
rename stop_Huishouden1 stop_Huishouden1_2018
rename start_Huishouden2 start_Huishouden2_2018
rename household2 household2_2018
rename stop_Huishouden2 stop_Huishouden2_2018
rename start_Huishouden3 start_Huishouden3_2018
rename household3 household3_2018
rename stop_Huishouden3 stop_Huishouden3_2018
rename start_Huishouden4 start_Huishouden4_2018
rename household4 household4_2018
rename stop_Huishouden4 stop_Huishouden4_2018
rename start_Huishouden5 start_Huishouden5_2018
rename household5 household5_2018
rename stop_Huishouden5 stop_Huishouden5_2018
rename start_Huishouden6 start_Huishouden6_2018
rename household6 household6_2018
rename stop_Huishouden6 stop_Huishouden6_2018
rename start_Huishouden7 start_Huishouden7_2018
rename household7 household7_2018
rename stop_Huishouden7 stop_Huishouden7_2018
rename start_Huishouden8 start_Huishouden8_2018
rename household8 household8_2018
rename stop_Huishouden8 stop_Huishouden8_2018
rename start_Huishouden9 start_Huishouden9_2018
rename household9 household9_2018
rename stop_Huishouden9 stop_Huishouden9_2018
rename start_Huishouden10 start_Huishouden10_2018
rename household10 household10_2018
rename stop_Huishouden10 stop_Huishouden10_2018
rename start_Huishouden11 start_Huishouden11_2018
rename household11 household11_2018
rename stop_Huishouden11 stop_Huishouden11_2018
rename start_Huishouden12 start_Huishouden12_2018
rename household12 household12_2018
rename stop_Huishouden12 stop_Huishouden12_2018
rename start_Huishouden13 start_Huishouden13_2018
rename household13 household13_2018
rename stop_Huishouden13 stop_Huishouden13_2018
rename start_Huishouden14 start_Huishouden14_2018
rename household14 household14_2018
rename stop_Huishouden14 stop_Huishouden14_2018
rename Neoplastic_Disease Neoplastic_Disease2018
rename StNeoplastic_Disease StNeoplastic_Disease2018
rename Liver_Disease Liver_Disease2018
rename StLiver_Disease StLiver_Disease2018
rename Congestive_HF Congestive_HF2018
rename StCongestive_HF StCongestive_HF2018
rename Cerebrovascular_Disease Cerebrovascular_Disease2018
rename StCerebrovascular_Disease StCerebrovascular_Disease2018
rename Renal_Disease Renal_Disease2018
rename StRenal_Disease StRenal_Disease2018
rename Pulmonary_Disease Pulmonary_Disease2018
rename StPulmonary_Disease StPulmonary_Disease2018
rename Dementia Dementia2018
rename StDementia StDementia2018
rename Neurologic_Disease Neurologic_Disease2018
rename StNeurologic_Disease StNeurologic_Disease2018
rename Diabetes Diabetes2018
rename StDiabetes StDiabetes2018
rename HIV HIV2018
rename StHIV StHIV2018
rename Immunocompromised Immunocompromised2018
rename StImmunocompromised StImmunocompromised2018
rename Cardiovascular_Disease_other Cardiovascular_Disease_other2018
rename StCardiovascular_Disease_other StCardiovascular_other2018
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2018\Survival2018.dta", replace

*2019
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\MERGED2019FINAL.dta", clear
drop rinpersoonshkw rinpersoonhkw inhahl inhahlmi INHP100HBEST INHP100HBESTES INHP100HBRUT INHP100HGESTES INHP100HPRIM inhsamaow inhsamhh VEKTMSZZorgtrajectnummer* DTC_codes* LRTI_SEH_Beeld* diff_Deathdate* excl_adm* diff_Hospitalisation* gbageslacht BeginLRTIDBC* EindLRTIDBC* CLRTI_adm* birthday overlijdensdatum Thirtydaymortality doodsoorzaak CLRTI_cause CLRTI_Death* date_LRTI_SEH_Beeld*
rename DEELSCOREWELVAART DEELSCOREWELVAART2019
rename DEELSCORERECENTARBEIDSVERLEDEN DEELSCOREARBEID2019
rename DeelscoreOpleidingsniveau DEELSCOREOPLEIDINGSNIVEAU2019
rename INHP100HGEST INHP100HGEST2019
rename VEHP100WELVAART VEHP100WELVAART2019
rename VEHP100HVERM VEHP100HVERM2019
rename VEHW1000VERH VEHW1000VERH2019
rename start_Huishouden1 start_Huishouden1_2019
rename household1 household1_2019
rename stop_Huishouden1 stop_Huishouden1_2019
rename start_Huishouden2 start_Huishouden2_2019
rename household2 household2_2019
rename stop_Huishouden2 stop_Huishouden2_2019
rename start_Huishouden3 start_Huishouden3_2019
rename household3 household3_2019
rename stop_Huishouden3 stop_Huishouden3_2019
rename start_Huishouden4 start_Huishouden4_2019
rename household4 household4_2019
rename stop_Huishouden4 stop_Huishouden4_2019
rename start_Huishouden5 start_Huishouden5_2019
rename household5 household5_2019
rename stop_Huishouden5 stop_Huishouden5_2019
rename start_Huishouden6 start_Huishouden6_2019
rename household6 household6_2019
rename stop_Huishouden6 stop_Huishouden6_2019
rename start_Huishouden7 start_Huishouden7_2019
rename household7 household7_2019
rename stop_Huishouden7 stop_Huishouden7_2019
rename start_Huishouden8 start_Huishouden8_2019
rename household8 household8_2019
rename stop_Huishouden8 stop_Huishouden8_2019
rename start_Huishouden9 start_Huishouden9_2019
rename household9 household9_2019
rename stop_Huishouden9 stop_Huishouden9_2019
rename start_Huishouden10 start_Huishouden10_2019
rename household10 household10_2019
rename stop_Huishouden10 stop_Huishouden10_2019
rename start_Huishouden11 start_Huishouden11_2019
rename household11 household11_2019
rename stop_Huishouden11 stop_Huishouden11_2019
rename Neoplastic_Disease Neoplastic_Disease2019
rename StNeoplastic_Disease StNeoplastic_Disease2019
rename Liver_Disease Liver_Disease2019
rename StLiver_Disease StLiver_Disease2019
rename Congestive_HF Congestive_HF2019
rename StCongestive_HF StCongestive_HF2019
rename Cerebrovascular_Disease Cerebrovascular_Disease2019
rename StCerebrovascular_Disease StCerebrovascular_Disease2019
rename Renal_Disease Renal_Disease2019
rename StRenal_Disease StRenal_Disease2019
rename Pulmonary_Disease Pulmonary_Disease2019
rename StPulmonary_Disease StPulmonary_Disease2019
rename Dementia Dementia2019
rename StDementia StDementia2019
rename Neurologic_Disease Neurologic_Disease2019
rename StNeurologic_Disease StNeurologic_Disease2019
rename Diabetes Diabetes2019
rename StDiabetes StDiabetes2019
rename HIV HIV2019
rename StHIV StHIV2019
rename Immunocompromised Immunocompromised2019
rename StImmunocompromised StImmunocompromised2019
rename Cardiovascular_Disease_other Cardiovascular_Disease_other2019
rename StCardiovascular_Disease_other StCardiovascular_other2019
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets 2019\Survival2019.dta", replace

use "K:\Utilities\Code_Listings\SSBreferentiebestanden\geconverteerde data\LANDAKTUEELREFV12.DTA", clear
rename land gbaherkomstgroepering
sort gbaherkomstgroepering
keep gbaherkomstgroepering landtiendeling landachtdeling etngrp
destring gbaherkomstgroepering, replace ignore(-)
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta", replace


*merge
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

*Generating a variable on migrationbackground
sort gbaherkomstgroepering
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
generate Migratieachtergrond = landtiendeling


*new risk every quartile 
generate Kwartaal2014_1 = date("20140101", "YMD")
generate Kwartaal2014_2 = date("20140401", "YMD")
generate Kwartaal2014_3 = date("20140701", "YMD")
generate Kwartaal2014_4 = date("20141001", "YMD")
generate Kwartaal2015_1 = date("20150101", "YMD")
generate Kwartaal2015_2 = date("20150401", "YMD")
generate Kwartaal2015_3 = date("20150701", "YMD")
generate Kwartaal2015_4 = date("20151001", "YMD")
generate Kwartaal2016_1 = date("20160101", "YMD")
generate Kwartaal2016_2 = date("20160401", "YMD")
generate Kwartaal2016_3 = date("20160701", "YMD")
generate Kwartaal2016_4 = date("20161001", "YMD")
generate Kwartaal2017_1 = date("20170101", "YMD")
generate Kwartaal2017_2 = date("20170401", "YMD")
generate Kwartaal2017_3 = date("20170701", "YMD")
generate Kwartaal2017_4 = date("20171001", "YMD")
generate Kwartaal2018_1 = date("20180101", "YMD")
generate Kwartaal2018_2 = date("20180401", "YMD")
generate Kwartaal2018_3 = date("20180701", "YMD")
generate Kwartaal2018_4 = date("20181001", "YMD")
generate Kwartaal2019_1 = date("20190101", "YMD")
generate Kwartaal2019_2 = date("20190401", "YMD")
generate Kwartaal2019_3 = date("20190701", "YMD")
generate Kwartaal2019_4 = date("20191001", "YMD")
format Kwartaal2014_1 %td
format Kwartaal2014_2 %td
format Kwartaal2014_3 %td
format Kwartaal2014_4 %td
format Kwartaal2015_1 %td
format Kwartaal2015_2 %td
format Kwartaal2015_3 %td
format Kwartaal2015_4 %td
format Kwartaal2016_1 %td
format Kwartaal2016_2 %td
format Kwartaal2016_3 %td
format Kwartaal2016_4 %td
format Kwartaal2017_1 %td
format Kwartaal2017_2 %td
format Kwartaal2017_3 %td
format Kwartaal2017_4 %td
format Kwartaal2018_1 %td
format Kwartaal2018_2 %td
format Kwartaal2018_3 %td
format Kwartaal2018_4 %td
format Kwartaal2019_1 %td
format Kwartaal2019_2 %td
format Kwartaal2019_3 %td
format Kwartaal2019_4 %td

*aanpassing comorbiditeit m.b.t starttijd
generate Neoplastic_Disease = 1 if (Neoplastic_Disease2014 == 1 | Neoplastic_Disease2015 == 1 | Neoplastic_Disease2016 == 1 | Neoplastic_Disease2017 == 1 | Neoplastic_Disease2018 == 1 | Neoplastic_Disease2019 == 1)
generate Liver_Disease = 1 if (Liver_Disease2014 == 1 | Liver_Disease2015 == 1 | Liver_Disease2016 == 1 | Liver_Disease2017 == 1 | Liver_Disease2018 == 1 | Liver_Disease2019 == 1)
generate Congestive_HF = 1 if (Congestive_HF2014 == 1 | Congestive_HF2015 == 1 | Congestive_HF2016 == 1 | Congestive_HF2017 == 1 | Congestive_HF2018 == 1 | Congestive_HF2019 == 1)
generate Cerebrovascular_Disease = 1 if (Cerebrovascular_Disease2014 == 1 | Cerebrovascular_Disease2015 == 1 | Cerebrovascular_Disease2016 == 1 | Cerebrovascular_Disease2017 == 1 | Cerebrovascular_Disease2018 == 1 | Cerebrovascular_Disease2019 == 1)
generate Renal_Disease = 1 if (Renal_Disease2014 == 1 | Renal_Disease2015 == 1 | Renal_Disease2016 == 1 | Renal_Disease2017 == 1 | Renal_Disease2018 == 1 | Renal_Disease2019 == 1)
generate Pulmonary_Disease = 1 if (Pulmonary_Disease2014 == 1 | Pulmonary_Disease2015 == 1 | Pulmonary_Disease2016 == 1 | Pulmonary_Disease2017 == 1 | Pulmonary_Disease2018 == 1 | Pulmonary_Disease2019 == 1)
generate Dementia = 1 if (Dementia2014 == 1 | Dementia2015 == 1 | Dementia2016 == 1 | Dementia2017 == 1 | Dementia2018 == 1 | Dementia2019 == 1)
generate Neurologic_Disease = 1 if (Neurologic_Disease2014 == 1 | Neurologic_Disease2015 == 1 | Neurologic_Disease2016 == 1 | Neurologic_Disease2017 == 1 | Neurologic_Disease2018 == 1 | Neurologic_Disease2019 == 1)
generate Diabetes = 1 if (Diabetes2014 == 1 | Diabetes2015 == 1 | Diabetes2016 == 1 | Diabetes2017 == 1 | Diabetes2018 == 1 | Diabetes2019 == 1)
generate HIV = 1 if (HIV2014 == 1 | HIV2015 == 1 | HIV2016 == 1 | HIV2017 == 1 | HIV2018 == 1 | HIV2019 == 1)
generate Immunocompromised = 1 if (Immunocompromised2014 == 1 | Immunocompromised2015 == 1 | Immunocompromised2016 == 1 | Immunocompromised2017 == 1 | Immunocompromised2018 == 1 | Immunocompromised2019 == 1) 
generate Cardiovascular_Disease_other = 1 if (Cardiovascular_Disease_other2014 == 1 | Cardiovascular_Disease_other2015 == 1 | Cardiovascular_Disease_other2016 == 1 | Cardiovascular_Disease_other2017 == 1 | Cardiovascular_Disease_other2018 == 1 | Cardiovascular_Disease_other2019 == 1)
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


generate StNeoplastic_Disease = .
format StNeoplastic_Disease %td
replace StNeoplastic_Disease = StNeoplastic_Disease2014 if StNeoplastic_Disease2014 != .
replace StNeoplastic_Disease = date("20140630", "YMD") if Neoplastic_Disease2014==1 & StNeoplastic_Disease2014 == .
replace StNeoplastic_Disease = StNeoplastic_Disease2015 if (StNeoplastic_Disease2015 != . & StNeoplastic_Disease == .) | (StNeoplastic_Disease2015!=. & StNeoplastic_Disease != . & StNeoplastic_Disease2015<StNeoplastic_Disease)
replace StNeoplastic_Disease = date("20150630", "YMD") if (Neoplastic_Disease2015==1 & StNeoplastic_Disease == .)
replace StNeoplastic_Disease = StNeoplastic_Disease2016 if (StNeoplastic_Disease2016 != . & StNeoplastic_Disease == .)  | (StNeoplastic_Disease2016!=. & StNeoplastic_Disease != . & StNeoplastic_Disease2016<StNeoplastic_Disease)
replace StNeoplastic_Disease = date("20160630", "YMD") if (Neoplastic_Disease2016==1 & StNeoplastic_Disease == .)
replace StNeoplastic_Disease = StNeoplastic_Disease2017 if (StNeoplastic_Disease2017 != . & StNeoplastic_Disease == .) | (StNeoplastic_Disease2017!=. & StNeoplastic_Disease != . & StNeoplastic_Disease2017<StNeoplastic_Disease)
replace StNeoplastic_Disease = date("20170630", "YMD") if (Neoplastic_Disease2017==1 & StNeoplastic_Disease == .)
replace StNeoplastic_Disease = StNeoplastic_Disease2018 if (StNeoplastic_Disease2018 != . & StNeoplastic_Disease == .) | (StNeoplastic_Disease2018!=. & StNeoplastic_Disease != . & StNeoplastic_Disease2018<StNeoplastic_Disease)
replace StNeoplastic_Disease = date("20180630", "YMD") if (Neoplastic_Disease2018==1 & StNeoplastic_Disease == .)
replace StNeoplastic_Disease = StNeoplastic_Disease2019 if (StNeoplastic_Disease2019 != . & StNeoplastic_Disease == .) | (StNeoplastic_Disease2019!=. & StNeoplastic_Disease != . & StNeoplastic_Disease2019<StNeoplastic_Disease)
replace StNeoplastic_Disease = date("20190630", "YMD") if (Neoplastic_Disease2019==1 & StNeoplastic_Disease == .)

generate StopNeoplastic_Disease = . 
format StopNeoplastic_Disease %td
replace StopNeoplastic_Disease = date("20150101", "YMD") if Neoplastic_Disease2014==1 & Neoplastic_Disease2015!=1 & Neoplastic_Disease2016!=1 & Neoplastic_Disease2017!=1 & Neoplastic_Disease2018!=1 & Neoplastic_Disease2019!=1
replace StopNeoplastic_Disease = date("20160101", "YMD") if Neoplastic_Disease2015==1 & Neoplastic_Disease2016!=1 & Neoplastic_Disease2017!=1 & Neoplastic_Disease2018!=1 & Neoplastic_Disease2019!=1
replace StopNeoplastic_Disease = date("20170101", "YMD") if Neoplastic_Disease2016==1 & Neoplastic_Disease2017!=1 & Neoplastic_Disease2018!=1 & Neoplastic_Disease2019!=1
replace StopNeoplastic_Disease = date("20180101", "YMD") if Neoplastic_Disease2017==1 & Neoplastic_Disease2018!=1 & Neoplastic_Disease2019!=1
replace StopNeoplastic_Disease = date("20190101", "YMD") if Neoplastic_Disease2018==1 & Neoplastic_Disease2019!=1
replace StopNeoplastic_Disease = date("20191231", "YMD") if Neoplastic_Disease2019==1 
generate StImmunocompromised = .
format StImmunocompromised %td
replace StImmunocompromised = StImmunocompromised2014 if StImmunocompromised2014 != .
replace StImmunocompromised = date("20140630", "YMD") if Immunocompromised2014==1 & StImmunocompromised2014 == .
replace StImmunocompromised = StImmunocompromised2015 if (StImmunocompromised2015 != . & StImmunocompromised == .) | (StImmunocompromised2015!=. & StImmunocompromised != . & StImmunocompromised2015<StImmunocompromised)
replace StImmunocompromised = date("20150630", "YMD") if (Immunocompromised2015==1 & StImmunocompromised == .)
replace StImmunocompromised = StImmunocompromised2016 if (StImmunocompromised2016 != . & StImmunocompromised == .)  | (StImmunocompromised2016!=. & StImmunocompromised != . & StImmunocompromised2016<StImmunocompromised)
replace StImmunocompromised = date("20160630", "YMD") if (Immunocompromised2016==1 & StImmunocompromised == .)
replace StImmunocompromised = StImmunocompromised2017 if (StImmunocompromised2017 != . & StImmunocompromised == .) | (StImmunocompromised2017!=. & StImmunocompromised != . & StImmunocompromised2017<StImmunocompromised)
replace StImmunocompromised = date("20170630", "YMD") if (Immunocompromised2017==1 & StImmunocompromised == .)
replace StImmunocompromised = StImmunocompromised2018 if (StImmunocompromised2018 != . & StImmunocompromised == .) | (StImmunocompromised2018!=. & StImmunocompromised != . & StImmunocompromised2018<StImmunocompromised)
replace StImmunocompromised = date("20180630", "YMD") if (Immunocompromised2018==1 & StImmunocompromised == .)
replace StImmunocompromised = StImmunocompromised2019 if (StImmunocompromised2019 != . & StImmunocompromised == .) | (StImmunocompromised2019!=. & StImmunocompromised != . & StImmunocompromised2019<StImmunocompromised)
replace StImmunocompromised = date("20190630", "YMD") if (Immunocompromised2019==1 & StImmunocompromised == .)

generate StopImmunocompromised = . 
format StopImmunocompromised %td
replace StopImmunocompromised = StImmunocompromised2014 if (StImmunocompromised2014 != . & (StImmunocompromised2015 == . &StImmunocompromised2016 == . & StImmunocompromised2017 == . & StImmunocompromised2018 == . & StImmunocompromised2019 == .))
replace StopImmunocompromised = StImmunocompromised2015 if (StImmunocompromised2015 != . & (StImmunocompromised2016 == . & StImmunocompromised2017 == . & StImmunocompromised2018 == . & StImmunocompromised2019 == .))
replace StopImmunocompromised = StImmunocompromised2016 if (StImmunocompromised2016 != . & (StImmunocompromised2017 == . &StImmunocompromised2018 == . & StImmunocompromised2019 == .))
replace StopImmunocompromised = StImmunocompromised2017 if (StImmunocompromised2017 != . & (StImmunocompromised2018 == . &StImmunocompromised2019 == .))
replace StopImmunocompromised = StImmunocompromised2018 if (StImmunocompromised2018 != . & StImmunocompromised2019 == .)
replace StopImmunocompromised = StImmunocompromised2019 if StImmunocompromised2019 != . 

replace StopImmunocompromised = date("20150101", "YMD") if Immunocompromised2014==1 & Immunocompromised2015!=1 & Immunocompromised2016!=1 & Immunocompromised2017!=1 & Immunocompromised2018!=1 & Immunocompromised2019!=1
replace StopImmunocompromised = date("20160101", "YMD") if Immunocompromised2015==1 & Immunocompromised2016!=1 & Immunocompromised2017!=1 & Immunocompromised2018!=1 & Immunocompromised2019!=1
replace StopImmunocompromised = date("20170101", "YMD") if Immunocompromised2016==1 & Immunocompromised2017!=1 & Immunocompromised2018!=1 & Immunocompromised2019!=1
replace StopImmunocompromised = date("20180101", "YMD") if Immunocompromised2017==1 & Immunocompromised2018!=1 & Immunocompromised2019!=1
replace StopImmunocompromised = date("20190101", "YMD") if Immunocompromised2018==1 & Immunocompromised2019!=1
replace StopImmunocompromised = date("20191231", "YMD") if Immunocompromised2019==1

generate StLiver_Disease = StLiver_Disease2014 if StLiver_Disease2014 != .
format StLiver_Disease %td
replace StLiver_Disease = StLiver_Disease2015 if (StLiver_Disease2015 != . & StLiver_Disease == .) | (StLiver_Disease2015!=. & StLiver_Disease != . & StLiver_Disease2015<StLiver_Disease)
replace StLiver_Disease = StLiver_Disease2016 if (StLiver_Disease2016 != . & StLiver_Disease == .)  | (StLiver_Disease2016!=. & StLiver_Disease != . & StLiver_Disease2016<StLiver_Disease)
replace StLiver_Disease = StLiver_Disease2017 if (StLiver_Disease2017 != . & StLiver_Disease == .) | (StLiver_Disease2017!=. & StLiver_Disease != . & StLiver_Disease2017<StLiver_Disease)
replace StLiver_Disease = StLiver_Disease2018 if (StLiver_Disease2018 != . & StLiver_Disease == .) | (StLiver_Disease2018!=. & StLiver_Disease != . & StLiver_Disease2018<StLiver_Disease)
replace StLiver_Disease = StLiver_Disease2019 if (StLiver_Disease2019 != . & StLiver_Disease == .) | (StLiver_Disease2019!=. & StLiver_Disease != . & StLiver_Disease2019<StLiver_Disease)
replace StLiver_Disease = date("20140630", "YMD") if Liver_Disease2014==1 & StLiver_Disease2014 == .
replace StLiver_Disease = date("20150630", "YMD") if (Liver_Disease2015==1 & StLiver_Disease == .)
replace StLiver_Disease = date("20160630", "YMD") if (Liver_Disease2016==1 & StLiver_Disease == .)
replace StLiver_Disease = date("20170630", "YMD") if (Liver_Disease2017==1 & StLiver_Disease == .)
replace StLiver_Disease = date("20180630", "YMD") if (Liver_Disease2018==1 & StLiver_Disease == .)
replace StLiver_Disease = date("20190630", "YMD") if (Liver_Disease2019==1 & StLiver_Disease == .)

generate StCongestive_HF = StCongestive_HF2014 if StCongestive_HF2014 != .
format StCongestive_HF %td
replace StCongestive_HF = StCongestive_HF2015 if (StCongestive_HF2015 != . & StCongestive_HF == .) | (StCongestive_HF2015!=. & StCongestive_HF != . & StCongestive_HF2015<StCongestive_HF)
replace StCongestive_HF = StCongestive_HF2016 if (StCongestive_HF2016 != . & StCongestive_HF == .)  | (StCongestive_HF2016!=. & StCongestive_HF != . & StCongestive_HF2016<StCongestive_HF)
replace StCongestive_HF = StCongestive_HF2017 if (StCongestive_HF2017 != . & StCongestive_HF == .) | (StCongestive_HF2017!=. & StCongestive_HF != . & StCongestive_HF2017<StCongestive_HF)
replace StCongestive_HF = StCongestive_HF2018 if (StCongestive_HF2018 != . & StCongestive_HF == .) | (StCongestive_HF2018!=. & StCongestive_HF != . & StCongestive_HF2018<StCongestive_HF)
replace StCongestive_HF = StCongestive_HF2019 if (StCongestive_HF2019 != . & StCongestive_HF == .) | (StCongestive_HF2019!=. & StCongestive_HF != . & StCongestive_HF2019<StCongestive_HF)
replace StCongestive_HF = date("20140630", "YMD") if Congestive_HF2014==1 & StCongestive_HF2014 == .
replace StCongestive_HF = date("20150630", "YMD") if (Congestive_HF2015==1 & StCongestive_HF == .)
replace StCongestive_HF = date("20160630", "YMD") if (Congestive_HF2016==1 & StCongestive_HF == .)
replace StCongestive_HF = date("20170630", "YMD") if (Congestive_HF2017==1 & StLiver_Disease == .)
replace StCongestive_HF = date("20180630", "YMD") if (Congestive_HF2018==1 & StLiver_Disease == .)
replace StCongestive_HF = date("20190630", "YMD") if (Congestive_HF2019==1 & StCongestive_HF == .)


generate StCerebrovascular_Disease = StCerebrovascular_Disease2014 if StCerebrovascular_Disease2014 != .
format StCerebrovascular_Disease %td
replace StCerebrovascular_Disease = StCerebrovascular_Disease2015 if (StCerebrovascular_Disease2015 != . & StCerebrovascular_Disease == .) | (StCerebrovascular_Disease2015!=. & StCerebrovascular_Disease != . & StCerebrovascular_Disease2015<StCerebrovascular_Disease)
replace StCerebrovascular_Disease = StCerebrovascular_Disease2016 if (StCerebrovascular_Disease2016 != . & StCerebrovascular_Disease == .)  | (StCerebrovascular_Disease2016!=. & StCerebrovascular_Disease != . & StCerebrovascular_Disease2016<StCerebrovascular_Disease)
replace StCerebrovascular_Disease = StCerebrovascular_Disease2017 if (StCerebrovascular_Disease2017 != . & StCerebrovascular_Disease == .) | (StCerebrovascular_Disease2017!=. & StCerebrovascular_Disease != . & StCerebrovascular_Disease2017<StCerebrovascular_Disease)
replace StCerebrovascular_Disease = StCerebrovascular_Disease2018 if (StCerebrovascular_Disease2018 != . & StCerebrovascular_Disease == .) | (StCerebrovascular_Disease2018!=. & StCerebrovascular_Disease != . & StCerebrovascular_Disease2018<StCerebrovascular_Disease)
replace StCerebrovascular_Disease = StCerebrovascular_Disease2019 if (StCerebrovascular_Disease2019 != . & StCerebrovascular_Disease == .) | (StCerebrovascular_Disease2019!=. & StCerebrovascular_Disease != . & StCerebrovascular_Disease2019<StCerebrovascular_Disease)
replace StCerebrovascular_Disease = date("20140630", "YMD") if Cerebrovascular_Disease2014==1 & StCerebrovascular_Disease2014 == .
replace StCerebrovascular_Disease = date("20150630", "YMD") if (Cerebrovascular_Disease2015==1 & StCerebrovascular_Disease == .)
replace StCerebrovascular_Disease = date("20160630", "YMD") if (Cerebrovascular_Disease2016==1 & StCerebrovascular_Disease == .)
replace StCerebrovascular_Disease = date("20170630", "YMD") if (Cerebrovascular_Disease2017==1 & StCerebrovascular_Disease == .)
replace StCerebrovascular_Disease = date("20180630", "YMD") if (Cerebrovascular_Disease2018==1 & StCerebrovascular_Disease == .)
replace StCerebrovascular_Disease = date("20190630", "YMD") if (Cerebrovascular_Disease2019==1 & StCerebrovascular_Disease == .)


generate StRenal_Disease = StRenal_Disease2014 if StRenal_Disease2014 != .
format StRenal_Disease %td
replace StRenal_Disease = StRenal_Disease2015 if (StRenal_Disease2015 != . & StRenal_Disease == .) | (StRenal_Disease!=. & StRenal_Disease != . & StRenal_Disease2015<StRenal_Disease)
replace StRenal_Disease = StRenal_Disease2016 if (StRenal_Disease2016 != . & StRenal_Disease == .)  | (StRenal_Disease2016!=. & StRenal_Disease != . & StRenal_Disease2016<StRenal_Disease)
replace StRenal_Disease = StRenal_Disease2017 if (StRenal_Disease2017 != . & StRenal_Disease == .) | (StRenal_Disease2017!=. & StRenal_Disease != . & StRenal_Disease2017<StRenal_Disease)
replace StRenal_Disease = StRenal_Disease2018 if (StRenal_Disease2018 != . & StRenal_Disease == .) | (StRenal_Disease2018!=. & StRenal_Disease != . & StRenal_Disease2018<StRenal_Disease)
replace StRenal_Disease = StRenal_Disease2019 if (StRenal_Disease2019 != . & StRenal_Disease == .) | (StRenal_Disease2019!=. & StRenal_Disease != . & StRenal_Disease2019<StRenal_Disease)
replace StRenal_Disease = date("20140630", "YMD") if Renal_Disease2014==1 & StRenal_Disease2014 == .
replace StRenal_Disease = date("20150630", "YMD") if (Renal_Disease2015==1 & StRenal_Disease == .)
replace StRenal_Disease = date("20160630", "YMD") if (Renal_Disease2016==1 & StRenal_Disease == .)
replace StRenal_Disease = date("20170630", "YMD") if (Renal_Disease2017==1 & StRenal_Disease == .)
replace StRenal_Disease = date("20180630", "YMD") if (Renal_Disease2018==1 & StRenal_Disease == .)
replace StRenal_Disease = date("20190630", "YMD") if (Renal_Disease2019==1 & StRenal_Disease == .)

generate StPulmonary_Disease = StPulmonary_Disease2014 if StPulmonary_Disease2014 != .
format StPulmonary_Disease %td
replace StPulmonary_Disease = date("20140630", "YMD") if Pulmonary_Disease2014==1 & StPulmonary_Disease2014 == .
replace StPulmonary_Disease = StPulmonary_Disease2015 if (StPulmonary_Disease2015 != . & StPulmonary_Disease == .) | (StPulmonary_Disease2015!=. & StPulmonary_Disease != . & StPulmonary_Disease2015<StPulmonary_Disease)
replace StPulmonary_Disease = date("20150630", "YMD") if (Pulmonary_Disease2015==1 & StPulmonary_Disease == .)
replace StPulmonary_Disease = StPulmonary_Disease2016 if (StPulmonary_Disease2016 != . & StPulmonary_Disease == .)  | (StPulmonary_Disease2016!=. & StPulmonary_Disease != . & StPulmonary_Disease2016<StPulmonary_Disease)
replace StPulmonary_Disease = date("20160630", "YMD") if (Pulmonary_Disease2016==1 & StPulmonary_Disease == .)
replace StPulmonary_Disease = StPulmonary_Disease2017 if (StPulmonary_Disease2017 != . & StPulmonary_Disease == .) | (StPulmonary_Disease2017!=. & StPulmonary_Disease != . & StPulmonary_Disease2017<StPulmonary_Disease)
replace StPulmonary_Disease = date("20170630", "YMD") if (Pulmonary_Disease2017==1 & StPulmonary_Disease == .)
replace StPulmonary_Disease = StPulmonary_Disease2018 if (StPulmonary_Disease2018 != . & StPulmonary_Disease == .) | (StPulmonary_Disease2018!=. & StPulmonary_Disease != . & StPulmonary_Disease2018<StPulmonary_Disease)
replace StPulmonary_Disease = date("20180630", "YMD") if (Pulmonary_Disease2018==1 & StPulmonary_Disease == .)
replace StPulmonary_Disease = StPulmonary_Disease2019 if (StPulmonary_Disease2019 != . & StPulmonary_Disease == .) | (StPulmonary_Disease2019!=. & StPulmonary_Disease != . & StPulmonary_Disease2019<StPulmonary_Disease)
replace StPulmonary_Disease = date("20190630", "YMD") if (Pulmonary_Disease2019==1 & StPulmonary_Disease == .)

generate StDementia = StDementia2014 if StDementia2014 != . 
format StDementia %td
replace StDementia = StDementia2015 if (StDementia2015 != . & StDementia == .) | (StDementia!=. & StDementia != . & StDementia2015<StDementia)
replace StDementia = StDementia2016 if (StDementia2016 != . & StDementia == .)  | (StDementia2016!=. & StDementia != . & StDementia2016<StDementia)
replace StDementia = StDementia2017 if (StDementia2017 != . & StDementia == .) | (StDementia2017!=. & StDementia != . & StDementia2017<StDementia)
replace StDementia = StDementia2018 if (StDementia2018 != . & StDementia == .) | (StDementia2018!=. & StDementia != . & StDementia2018<StDementia)
replace StDementia = StDementia2019 if (StDementia2019 != . & StDementia == .) | (StDementia2019!=. & StDementia != . & StDementia2019<StDementia)
replace StDementia = date("20140630", "YMD") if Dementia2014==1 & StDementia2014 == .
replace StDementia = date("20150630", "YMD") if (Dementia2015==1 & StDementia == .)
replace StDementia = date("20160630", "YMD") if (Dementia2016==1 & StDementia == .)
replace StDementia = date("20170630", "YMD") if (Dementia2017==1 & StDementia == .)
replace StDementia = date("20180630", "YMD") if (Dementia2018==1 & StDementia == .)
replace StDementia = date("20190630", "YMD") if (Dementia2019==1 & StDementia == .)

generate StNeurologic_Disease = StNeurologic_Disease2014 if StNeurologic_Disease2014 != .
format StNeurologic_Disease %td
replace StNeurologic_Disease = StNeurologic_Disease2015 if (StNeurologic_Disease2015 != . & StNeurologic_Disease == .) | (StNeurologic_Disease!=. & StNeurologic_Disease != . & StNeurologic_Disease2015<StNeurologic_Disease)
replace StNeurologic_Disease = StNeurologic_Disease2016 if (StNeurologic_Disease2016 != . & StNeurologic_Disease == .)  | (StNeurologic_Disease2016!=. & StNeurologic_Disease != . & StNeurologic_Disease2016<StNeurologic_Disease)
replace StNeurologic_Disease = StNeurologic_Disease2017 if (StNeurologic_Disease2017 != . & StNeurologic_Disease == .) | (StNeurologic_Disease2017!=. & StNeurologic_Disease != . & StNeurologic_Disease2017<StNeurologic_Disease)
replace StNeurologic_Disease = StNeurologic_Disease2018 if (StNeurologic_Disease2018 != . & StNeurologic_Disease == .) | (StNeurologic_Disease2018!=. & StNeurologic_Disease != . & StNeurologic_Disease2018<StNeurologic_Disease)
replace StNeurologic_Disease = StNeurologic_Disease2019 if (StNeurologic_Disease2019 != . & StNeurologic_Disease == .) | (StNeurologic_Disease2019!=. & StNeurologic_Disease != . & StNeurologic_Disease2019<StNeurologic_Disease)
replace StNeurologic_Disease = date("20140630", "YMD") if Neurologic_Disease2014==1 & StNeurologic_Disease2014 == .
replace StNeurologic_Disease = date("20150630", "YMD") if (Neurologic_Disease2015==1 & StNeurologic_Disease == .)
replace StNeurologic_Disease = date("20160630", "YMD") if (Neurologic_Disease2016==1 & StNeurologic_Disease == .)
replace StNeurologic_Disease = date("20170630", "YMD") if (Neurologic_Disease2017==1 & StNeurologic_Disease == .)
replace StNeurologic_Disease = date("20180630", "YMD") if (Neurologic_Disease2018==1 & StNeurologic_Disease == .)
replace StNeurologic_Disease = date("20190630", "YMD") if (Neurologic_Disease2019==1 & StNeurologic_Disease == .)

generate StDiabetes = StDiabetes2014 if StDiabetes2014 != .
format StDiabetes %td
replace StDiabetes = date("20140630", "YMD") if Diabetes2014==1 & StDiabetes2014 == .
replace StDiabetes = StDiabetes2015 if (StDiabetes2015 != . & StDiabetes == .) | (StDiabetes2015!=. & StDiabetes != . & StDiabetes2015<StDiabetes)
replace StDiabetes = date("20150630", "YMD") if (Diabetes2015==1 & StDiabetes == .)
replace StDiabetes = StDiabetes2016 if (StDiabetes2016 != . & StDiabetes == .)  | (StDiabetes2016!=. & StDiabetes != . & StDiabetes2016<StDiabetes)
replace StDiabetes = date("20160630", "YMD") if (Diabetes2016==1 & StDiabetes == .)
replace StDiabetes = StDiabetes2017 if (StDiabetes2017 != . & StDiabetes == .) | (StDiabetes2017!=. & StDiabetes != . & StDiabetes2017<StDiabetes)
replace StDiabetes = date("20170630", "YMD") if (Diabetes2017==1 & StDiabetes == .)
replace StDiabetes = StDiabetes2018 if (StDiabetes2018 != . & StDiabetes == .) | (StDiabetes2018!=. & StDiabetes != . & StDiabetes2018<StDiabetes)
replace StDiabetes = date("20180630", "YMD") if (Diabetes2018==1 & StDiabetes== .)
replace StDiabetes = StDiabetes2019 if (StDiabetes2019 != . & StDiabetes == .) | (StDiabetes2019!=. & StDiabetes != . & StDiabetes2019<StDiabetes)
replace StDiabetes = date("20190630", "YMD") if (Diabetes2019==1 & StDiabetes == .)

generate StHIV = StHIV2014 if StHIV2014 != .
format StHIV %td
replace StHIV = StHIV2015 if (StHIV2015 != . & StHIV == .) | (StHIV!=. & StHIV != . & StHIV2015<StHIV)
replace StHIV = StHIV2016 if (StHIV2016 != . & StHIV == .)  | (StHIV2016!=. & StHIV != . & StHIV2016<StHIV)
replace StHIV = StHIV2017 if (StHIV2017 != . & StHIV == .) | (StHIV2017!=. & StHIV != . & StHIV2017<StHIV)
replace StHIV = StHIV2018 if (StHIV2018 != . & StHIV == .) | (StHIV2018!=. & StHIV != . & StHIV2018<StHIV)
replace StHIV = StHIV2019 if (StHIV2019 != . & StHIV == .) | (StHIV2019!=. & StHIV != . & StHIV2019<StHIV)
replace StHIV = date("20140630", "YMD") if HIV2014==1 & StHIV2014 == .
replace StHIV = date("20150630", "YMD") if (HIV2015==1 & StHIV == .)
replace StHIV = date("20160630", "YMD") if (HIV2016==1 & StHIV == .)
replace StHIV = date("20170630", "YMD") if (HIV2017==1 & StHIV == .)
replace StHIV = date("20180630", "YMD") if (HIV2018==1 & StHIV == .)
replace StHIV = date("20190630", "YMD") if (HIV2019==1 & StHIV == .)

generate StCardiovascular_other = StCardiovascular_other2014 if StCardiovascular_other2014 != .
format StCardiovascular_other %td
replace StCardiovascular_other = StCardiovascular_other2015 if (StCardiovascular_other2015 != . & StCardiovascular_other == .) | (StCardiovascular_other!=. & StCardiovascular_other != . & StCardiovascular_other2015<StCardiovascular_other)
replace StCardiovascular_other = StCardiovascular_other2016 if (StCardiovascular_other2016 != . & StCardiovascular_other == .)  | (StCardiovascular_other2016!=. & StCardiovascular_other != . & StCardiovascular_other2016<StCardiovascular_other)
replace StCardiovascular_other = StCardiovascular_other2017 if (StCardiovascular_other2017 != . & StCardiovascular_other == .) | (StCardiovascular_other2017!=. & StCardiovascular_other != . & StCardiovascular_other2017<StCardiovascular_other)
replace StCardiovascular_other = StCardiovascular_other2018 if (StCardiovascular_other2018 != . & StCardiovascular_other == .) | (StCardiovascular_other2018!=. & StCardiovascular_other != . & StCardiovascular_other2018<StCardiovascular_other)
replace StCardiovascular_other = StCardiovascular_other2019 if (StCardiovascular_other2019 != . & StCardiovascular_other == .) | (StCardiovascular_other2019!=. & StCardiovascular_other != . & StCardiovascular_other2019<StCardiovascular_other)
replace StCardiovascular_other = date("20140630", "YMD") if Cardiovascular_Disease_other2014==1 & StCardiovascular_other2014 == .
replace StCardiovascular_other = date("20150630", "YMD") if (Cardiovascular_Disease_other2015==1 & StCardiovascular_other == .)
replace StCardiovascular_other = date("20160630", "YMD") if (Cardiovascular_Disease_other2016==1 & StCardiovascular_other == .)
replace StCardiovascular_other = date("20170630", "YMD") if (Cardiovascular_Disease_other2017==1 & StCardiovascular_other == .)
replace StCardiovascular_other = date("20180630", "YMD") if (Cardiovascular_Disease_other2018==1 & StCardiovascular_other == .)
replace StCardiovascular_other = date("20190630", "YMD") if (Cardiovascular_Disease_other2019==1 & StCardiovascular_other == .)

destring rinpersoon, replace
drop _merge
format rinpersoon %13.0g
sort rinpersoon rinpersoons
drop if rinpersoon ==.
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Survival2014-19.dta", replace

use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTI_Incidence_Final.dta", clear
sort rinpersoon rinpersoons
merge m:1 rinpersoon rinpersoons using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Survival2014-19.dta"

keep if _merge==3
drop Neoplastic_Disease20*
drop Liver_Disease20*
drop Congestive_HF20*
drop Cerebrovascular_Disease20*
drop Renal_Disease20*
drop Pulmonary_Disease20*
drop Dementia20*
drop Neurologic_Disease20*
drop Diabetes20*
drop HIV20*
drop Immunocompromised20*
drop Cardiovascular_Disease_other20*
drop StNeoplastic_Disease20*
drop StLiver_Disease20*
drop StCongestive_HF20*
drop StCerebrovascular_Disease20*
drop StRenal_Disease20*
drop StPulmonary_Disease20*
drop StDementia20*
drop StNeurologic_Disease20*
drop StDiabetes20*
drop StHIV20*
drop StImmunocompromised20*
drop StCardiovascular_other20*
save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTI_Survival2014-19.dta", replace

use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\CLRTI_Survival2014-19.dta", clear
drop _merge
stset date_end_exposure, failure(CLRTI==1) origin(time Exposure) time0(Exposure) id(rinpersoon) exit(time .) scale(365.25)

*split data

*split on quartile
gen kwartaal = .
gen jaar = .


stsplit kwart_2_2014, after(Kwartaal2014_2) at(0)
replace kwartaal = 1 if kwart_2_2014==-1
replace jaar = 2014 if kwart_2_2014==-1
drop kwart_2_2014

stsplit kwart_3_2014, after(Kwartaal2014_3) at(0)
replace kwartaal = 2 if kwart_3_2014==-1 & kwartaal==.
replace jaar = 2014 if kwart_3_2014==-1 & jaar==.
drop kwart_3_2014

stsplit kwart_4_2014, after(Kwartaal2014_4) at(0)
replace kwartaal = 3 if kwart_4_2014==-1 & kwartaal==.
replace jaar = 2014 if kwart_4_2014==-1  & kwartaal==.
drop kwart_4_2014

foreach jaar in 2015 2016 2017 2018 2019 {
	foreach kwartaal in 1 2 3 4 {
		local i = `kwartaal'-1
		stsplit kwart_`kwartaal'_`jaar', after(Kwartaal`jaar'_`kwartaal') at(0)
		replace kwartaal = `i' if kwart_`kwartaal'_`jaar'==-1 & kwartaal==.
		replace jaar = `jaar' if kwart_`kwartaal'_`jaar'==-1 & jaar==.
		drop kwart_`kwartaal'_`jaar'
	}
}

replace kwartaal = 4 if kwartaal==0
replace kwartaal = 4 if Exposure==date("20191001", "YMD")
replace kwartaal = 4 if Exposure>=date("20191001", "YMD")

gen month = month(Exposure)
gen year = year(Exposure)
drop jaar
rename year jaar
browse rinpersoon Exposure date_end_exposure month jaar if kwartaal==.
replace kwartaal = 1 if (month==1 | month==2 | month==3) & kwartaal==.
replace kwartaal = 2 if (month==4 | month==5 | month==6) & kwartaal==.
replace kwartaal = 3 if (month==7 | month==8 | month==9) & kwartaal==.
replace kwartaal = 4 if (month==10 | month==11 | month==12) & kwartaal==.

browse rinpersoon Exposure kwartaal jaar
drop if Exposure>=date("20200101", "YMD")

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_Kwartaal2014-19.dta", replace 

use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_Kwartaal2014-19.dta", clear

*splitten comorbiditeit
stsplit comorbMalig1 if Neoplastic_Disease == 1, after(StNeoplastic_Disease) at(0)
stsplit comorbMalig2 if Neoplastic_Disease == 1, after(StopNeoplastic_Disease) at(0)
drop comorbMalig1 comorbMalig2

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
stsplit comorbImmuno1 if Immunocompromised == 1, after(StImmunocompromised) at(0)
stsplit comorbImmuno2 if Immunocompromised == 1, after(StopImmunocompromised) at(0)
drop comorbImmuno*
stsplit comorbCardio if Cardiovascular_Disease_other == 1, after(StCardiovascular_other) at(0)
drop comorbCardio




* splitten huishoudens
gen huishouden = .

/*2014*/



replace huishouden = household1_2014 if jaar==2014 & start_Huishouden1_2014 <=Exposure & stop_Huishouden1_2014>=Exposure
replace huishouden = household2_2014 if jaar==2014 & start_Huishouden2_2014 <=Exposure & stop_Huishouden2_2014>=Exposure
replace huishouden = household3_2014 if jaar==2014 & start_Huishouden3_2014 <=Exposure & stop_Huishouden3_2014>=Exposure
replace huishouden = household4_2014 if jaar==2014 & start_Huishouden4_2014 <=Exposure & stop_Huishouden4_2014>=Exposure
replace huishouden = household5_2014 if jaar==2014 & start_Huishouden5_2014 <=Exposure & stop_Huishouden5_2014>=Exposure
replace huishouden = household6_2014 if jaar==2014 & start_Huishouden6_2014 <=Exposure & stop_Huishouden6_2014>=Exposure
replace huishouden = household7_2014 if jaar==2014 & start_Huishouden7_2014 <=Exposure & stop_Huishouden7_2014>=Exposure
replace huishouden = household8_2014 if jaar==2014 & start_Huishouden8_2014 <=Exposure & stop_Huishouden8_2014>=Exposure
replace huishouden = household9_2014 if jaar==2014 & start_Huishouden9_2014 <=Exposure & stop_Huishouden9_2014>=Exposure
replace huishouden = household10_2014 if jaar==2014 & start_Huishouden10_2014 <=Exposure & stop_Huishouden10_2014>=Exposure
replace huishouden = household11_2014 if jaar==2014 & start_Huishouden11_2014 <=Exposure & stop_Huishouden11_2014>=Exposure

stsplit huishouden1_2014 if jaar==2014, after(start_Huishouden1_2014) at(0)
stsplit huishouden2_2014 if jaar==2014, after(start_Huishouden2_2014) at(0)
drop huishouden1_2014 huishouden2_2014

foreach huish of numlist 3/11 {
	stsplit huish`huish'_2014 if jaar==2014, after(start_Huishouden`huish'_2014) at(0)
	drop huish`huish'_2014
}

browse rinpersoon Exposure date_end_exposure start_Huishouden1_2014 start_Huishouden2_2014 start_Huishouden3_2014 start_Huishouden4_2014 start_Huishouden5_2014 start_Huishouden6_2014 huishouden household1_2014 household2_2014 household3_2014 household4_2014 household5_2014 household6_2014 if jaar==2014

replace huishouden = household1_2014 if jaar==2014 & start_Huishouden1_2014 <=Exposure & stop_Huishouden1_2014>=Exposure
replace huishouden = household2_2014 if jaar==2014 & start_Huishouden2_2014 <=Exposure & stop_Huishouden2_2014>=Exposure
replace huishouden = household3_2014 if jaar==2014 & start_Huishouden3_2014 <=Exposure & stop_Huishouden3_2014>=Exposure
replace huishouden = household4_2014 if jaar==2014 & start_Huishouden4_2014 <=Exposure & stop_Huishouden4_2014>=Exposure
replace huishouden = household5_2014 if jaar==2014 & start_Huishouden5_2014 <=Exposure & stop_Huishouden5_2014>=Exposure
replace huishouden = household6_2014 if jaar==2014 & start_Huishouden6_2014 <=Exposure & stop_Huishouden6_2014>=Exposure
replace huishouden = household7_2014 if jaar==2014 & start_Huishouden7_2014 <=Exposure & stop_Huishouden7_2014>=Exposure
replace huishouden = household8_2014 if jaar==2014 & start_Huishouden8_2014 <=Exposure & stop_Huishouden8_2014>=Exposure
replace huishouden = household9_2014 if jaar==2014 & start_Huishouden9_2014 <=Exposure & stop_Huishouden9_2014>=Exposure
replace huishouden = household10_2014 if jaar==2014 & start_Huishouden10_2014 <=Exposure & stop_Huishouden10_2014>=Exposure
replace huishouden = household11_2014 if jaar==2014 & start_Huishouden11_2014 <=Exposure & stop_Huishouden11_2014>=Exposure

foreach huish of numlist 1/11 {
	drop household`huish'_2014
	drop start_Huishouden`huish'_2014
	drop stop_Huishouden`huish'_2014
}

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_until_2014Households.dta", replace

keep if jaar==2014

foreach huish of numlist 1/11 {
	drop household`huish'_2015
	drop start_Huishouden`huish'_2015
	drop stop_Huishouden`huish'_2015
}

foreach huish of numlist 1/10 {
	drop household`huish'_2016
	drop start_Huishouden`huish'_2016
	drop stop_Huishouden`huish'_2016
}

foreach huish of numlist 1/11 {
	drop household`huish'_2017
	drop start_Huishouden`huish'_2017
	drop stop_Huishouden`huish'_2017
}

foreach huish of numlist 1/14 {
	drop household`huish'_2018
	drop start_Huishouden`huish'_2018
	drop stop_Huishouden`huish'_2018
}


foreach huish of numlist 1/11 {
	drop household`huish'_2019
	drop start_Huishouden`huish'_2019
	drop stop_Huishouden`huish'_2019
}


save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_2014.dta", replace

use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_until_2014Households.dta", replace

keep if jaar==2015

/*2015*/
foreach huish of numlist 1/11 {
	replace huishouden = household`huish'_2015 if jaar==2015 & start_Huishouden`huish'_2015 <=Exposure & stop_Huishouden`huish'_2015>=Exposure
}

foreach huish of numlist 1/11 {
	stsplit huishouden`huish'_2015 if jaar==2015, after(start_Huishouden`huish'_2015) at(0)
	drop huishouden`huish'_2015
}

foreach huish of numlist 1/11 {
	replace huishouden = household`huish'_2015 if jaar==2015 & start_Huishouden`huish'_2015 <=Exposure & stop_Huishouden`huish'_2015>=Exposure
}

foreach huish of numlist 1/11 {
	drop household`huish'_2015
	drop start_Huishouden`huish'_2015
	drop stop_Huishouden`huish'_2015
}

foreach huish of numlist 1/10 {
	drop household`huish'_2016
	drop start_Huishouden`huish'_2016
	drop stop_Huishouden`huish'_2016
}

foreach huish of numlist 1/11 {
	drop household`huish'_2017
	drop start_Huishouden`huish'_2017
	drop stop_Huishouden`huish'_2017
}

foreach huish of numlist 1/14 {
	drop household`huish'_2018
	drop start_Huishouden`huish'_2018
	drop stop_Huishouden`huish'_2018
}


foreach huish of numlist 1/11 {
	drop household`huish'_2019
	drop start_Huishouden`huish'_2019
	drop stop_Huishouden`huish'_2019
}

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_2015.dta", replace


/*2016*/

use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_until_2014Households.dta", replace

keep if jaar==2016

foreach huish of numlist 1/10 {
	replace huishouden = household`huish'_2016 if jaar==2016 & start_Huishouden`huish'_2016 <=Exposure & stop_Huishouden`huish'_2016>=Exposure
}

foreach huish of numlist 1/10 {
	stsplit huishouden`huish'_2016 if jaar==2016, after(start_Huishouden`huish'_2016) at(0)
	drop huishouden`huish'_2016
}

foreach huish of numlist 1/10 {
	replace huishouden = household`huish'_2016 if jaar==2016 & start_Huishouden`huish'_2016 <=Exposure & stop_Huishouden`huish'_2016>=Exposure
}

foreach huish of numlist 1/11 {
	drop household`huish'_2015
	drop start_Huishouden`huish'_2015
	drop stop_Huishouden`huish'_2015
}

foreach huish of numlist 1/10 {
	drop household`huish'_2016
	drop start_Huishouden`huish'_2016
	drop stop_Huishouden`huish'_2016
}

foreach huish of numlist 1/11 {
	drop household`huish'_2017
	drop start_Huishouden`huish'_2017
	drop stop_Huishouden`huish'_2017
}

foreach huish of numlist 1/14 {
	drop household`huish'_2018
	drop start_Huishouden`huish'_2018
	drop stop_Huishouden`huish'_2018
}


foreach huish of numlist 1/11 {
	drop household`huish'_2019
	drop start_Huishouden`huish'_2019
	drop stop_Huishouden`huish'_2019
}

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_2016.dta", replace

/*2017*/

use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_until_2014Households.dta", replace

keep if jaar==2017

foreach huish of numlist 1/11 {
	replace huishouden = household`huish'_2017 if jaar==2017 & start_Huishouden`huish'_2017 <=Exposure & stop_Huishouden`huish'_2017>=Exposure
}

foreach huish of numlist 1/11 {
	stsplit huishouden`huish'_2017 if jaar==2017, after(start_Huishouden`huish'_2017) at(0)
	drop huishouden`huish'_2017
}

foreach huish of numlist 1/11 {
	replace huishouden = household`huish'_2017 if jaar==2017 & start_Huishouden`huish'_2017 <=Exposure & stop_Huishouden`huish'_2017>=Exposure
}

foreach huish of numlist 1/11 {
	drop household`huish'_2015
	drop start_Huishouden`huish'_2015
	drop stop_Huishouden`huish'_2015
}

foreach huish of numlist 1/10 {
	drop household`huish'_2016
	drop start_Huishouden`huish'_2016
	drop stop_Huishouden`huish'_2016
}

foreach huish of numlist 1/11 {
	drop household`huish'_2017
	drop start_Huishouden`huish'_2017
	drop stop_Huishouden`huish'_2017
}

foreach huish of numlist 1/14 {
	drop household`huish'_2018
	drop start_Huishouden`huish'_2018
	drop stop_Huishouden`huish'_2018
}


foreach huish of numlist 1/11 {
	drop household`huish'_2019
	drop start_Huishouden`huish'_2019
	drop stop_Huishouden`huish'_2019
}

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_2017.dta", replace

/*2018*/

use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_until_2014Households.dta", replace

keep if jaar==2018

foreach huish of numlist 1/14 {
	replace huishouden = household`huish'_2018 if jaar==2018 & start_Huishouden`huish'_2018 <=Exposure & stop_Huishouden`huish'_2018>=Exposure
}

foreach huish of numlist 1/14 {
	stsplit huishouden`huish'_2018 if jaar==2018, after(start_Huishouden`huish'_2018) at(0)
}

foreach huish of numlist 1/14 {
	replace huishouden = household`huish'_2018 if jaar==2018 & start_Huishouden`huish'_2018 <=Exposure & stop_Huishouden`huish'_2018>=Exposure
}

foreach huish of numlist 1/11 {
	drop household`huish'_2015
	drop start_Huishouden`huish'_2015
	drop stop_Huishouden`huish'_2015
}

foreach huish of numlist 1/10 {
	drop household`huish'_2016
	drop start_Huishouden`huish'_2016
	drop stop_Huishouden`huish'_2016
}

foreach huish of numlist 1/11 {
	drop household`huish'_2017
	drop start_Huishouden`huish'_2017
	drop stop_Huishouden`huish'_2017
}

foreach huish of numlist 1/14 {
	drop household`huish'_2018
	drop start_Huishouden`huish'_2018
	drop stop_Huishouden`huish'_2018
}


foreach huish of numlist 1/11 {
	drop household`huish'_2019
	drop start_Huishouden`huish'_2019
	drop stop_Huishouden`huish'_2019
}

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_2018.dta", replace

/*2019*/

use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_until_2014Households.dta", replace

keep if jaar==2019

foreach huish of numlist 1/11 {
	replace huishouden = household`huish'_2019 if jaar==2019 & start_Huishouden`huish'_2019 <=Exposure & stop_Huishouden`huish'_2019>=Exposure
}

foreach huish of numlist 1/11 {
	stsplit huishouden`huish'_2019 if jaar==2019, after(start_Huishouden`huish'_2019) at(0)
	drop huishouden`huish'_2019
}

foreach huish of numlist 1/11 {
	replace huishouden = household`huish'_2019 if jaar==2019 & start_Huishouden`huish'_2019 <=Exposure & stop_Huishouden`huish'_2019>=Exposure
}

foreach huish of numlist 1/11 {
	drop household`huish'_2015
	drop start_Huishouden`huish'_2015
	drop stop_Huishouden`huish'_2015
}

foreach huish of numlist 1/10 {
	drop household`huish'_2016
	drop start_Huishouden`huish'_2016
	drop stop_Huishouden`huish'_2016
}

foreach huish of numlist 1/11 {
	drop household`huish'_2017
	drop start_Huishouden`huish'_2017
	drop stop_Huishouden`huish'_2017
}

foreach huish of numlist 1/14 {
	drop household`huish'_2018
	drop start_Huishouden`huish'_2018
	drop stop_Huishouden`huish'_2018
}


foreach huish of numlist 1/11 {
	drop household`huish'_2019
	drop start_Huishouden`huish'_2019
	drop stop_Huishouden`huish'_2019
}

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_2019.dta", replace

/*nu weer samenvoegen*/

append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_2014.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_2015.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_2016.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_2017.dta"
append using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\Split_data_2018.dta"

save "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\SurvivalData2014-2019joined.dta", replace

*Verschillende SES waarden integreren in de dataset
use "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\SurvivalData2014-2019joined.dta", clear
/*survival analyses*/
gen SESWOA = .
replace SESWOA = SESWOA2014 if jaar==2014
replace SESWOA = SESWOA2015 if jaar==2015
replace SESWOA = SESWOA2016 if jaar==2016
replace SESWOA = SESWOA2017 if jaar==2017
replace SESWOA = SESWOA2018 if jaar==2018
replace SESWOA = SESWOA2019 if jaar==2019

replace SESWOA = SESWOA2014 if jaar==2015 & SESWOA ==.
replace SESWOA = SESWOA2015 if jaar==2016 & SESWOA ==.
replace SESWOA = SESWOA2016 if jaar==2017 & SESWOA ==.
replace SESWOA = SESWOA2017 if jaar==2018 & SESWOA ==.
replace SESWOA = SESWOA2018 if jaar==2019 & SESWOA ==.

replace SESWOA = SESWOA2015 if jaar==2014 & SESWOA ==.
replace SESWOA = SESWOA2016 if jaar==2015 & SESWOA ==.
replace SESWOA = SESWOA2017 if jaar==2016 & SESWOA ==.
replace SESWOA = SESWOA2018 if jaar==2017 & SESWOA ==.
replace SESWOA = SESWOA2019 if jaar==2018 & SESWOA ==.

replace SESWOA = SESWOA2014 if jaar==2016 & SESWOA ==.
replace SESWOA = SESWOA2015 if jaar==2017 & SESWOA ==.
replace SESWOA = SESWOA2016 if jaar==2018 & SESWOA ==.
replace SESWOA = SESWOA2017 if jaar==2019 & SESWOA ==.
replace SESWOA = SESWOA2014 if jaar==2017 & SESWOA ==.
replace SESWOA = SESWOA2015 if jaar==2018 & SESWOA ==.
replace SESWOA = SESWOA2016 if jaar==2019 & SESWOA ==.
replace SESWOA = SESWOA2014 if jaar==2018 & SESWOA ==.
replace SESWOA = SESWOA2015 if jaar==2019 & SESWOA ==.
replace SESWOA = SESWOA2014 if jaar==2019 & SESWOA ==.

replace SESWOA = SESWOA2016 if jaar==2014 & SESWOA ==.
replace SESWOA = SESWOA2017 if jaar==2015 & SESWOA ==.
replace SESWOA = SESWOA2018 if jaar==2016 & SESWOA ==.
replace SESWOA = SESWOA2019 if jaar==2017 & SESWOA ==.
replace SESWOA = SESWOA2017 if jaar==2014 & SESWOA ==.
replace SESWOA = SESWOA2018 if jaar==2015 & SESWOA ==.
replace SESWOA = SESWOA2019 if jaar==2016 & SESWOA ==.
replace SESWOA = SESWOA2018 if jaar==2014 & SESWOA ==.
replace SESWOA = SESWOA2019 if jaar==2015 & SESWOA ==.
replace SESWOA = SESWOA2018 if jaar==2014 & SESWOA ==.
replace SESWOA = SESWOA2019 if jaar==2014 & SESWOA ==.

drop SESWOA2014
drop SESWOA2015
drop SESWOA2016
drop SESWOA2017
drop SESWOA2018
drop SESWOA2019

drop Kwartaal20*
drop if Exposure < date("20140101", "YMD")

gen Welvaart = .
replace Welvaart = VEHP100WELVAART2013 if jaar==2014 & (VEHP100WELVAART2013 != -1 & VEHP100WELVAART2013 != -2)
replace Welvaart = VEHP100WELVAART2014 if jaar==2015 & (VEHP100WELVAART2014 != -1 & VEHP100WELVAART2014 != -2)
replace Welvaart = VEHP100WELVAART2015 if jaar==2016 & (VEHP100WELVAART2015 != -1 & VEHP100WELVAART2015 != -2)
replace Welvaart = VEHP100WELVAART2016 if jaar==2017 & (VEHP100WELVAART2016 != -1 & VEHP100WELVAART2016 != -2)
replace Welvaart = VEHP100WELVAART2017 if jaar==2018 & (VEHP100WELVAART2017 != -1 & VEHP100WELVAART2017 != -2)
replace Welvaart = VEHP100WELVAART2018 if jaar==2019 & (VEHP100WELVAART2018 != -1 & VEHP100WELVAART2018 != -2)
replace Welvaart = VEHP100WELVAART2014 if (jaar==2014 & Welvaart ==.) & (VEHP100WELVAART2014 != -1 & VEHP100WELVAART2014 != -2)
replace Welvaart = VEHP100WELVAART2015 if (jaar==2015 & Welvaart ==.) & (VEHP100WELVAART2015 != -1 & VEHP100WELVAART2015 != -2)
replace Welvaart = VEHP100WELVAART2016 if (jaar==2016 & Welvaart ==.) & (VEHP100WELVAART2016 != -1 & VEHP100WELVAART2016 != -2)
replace Welvaart = VEHP100WELVAART2017 if (jaar==2017 & Welvaart ==.) & (VEHP100WELVAART2017 != -1 & VEHP100WELVAART2017 != -2)
replace Welvaart = VEHP100WELVAART2018 if (jaar==2018 & Welvaart ==.) & (VEHP100WELVAART2018 != -1 & VEHP100WELVAART2018 != -2)
replace Welvaart = VEHP100WELVAART2019 if (Welvaart == . & jaar == 2019) & (VEHP100WELVAART2019 != -1 & VEHP100WELVAART2019 != -2)
replace Welvaart = VEHP100WELVAART2015 if (jaar==2014 & Welvaart ==.) & (VEHP100WELVAART2015 != -1 & VEHP100WELVAART2015 != -2)
replace Welvaart = VEHP100WELVAART2016 if (jaar==2015 & Welvaart ==.) & (VEHP100WELVAART2016 != -1 & VEHP100WELVAART2016 != -2) 
replace Welvaart = VEHP100WELVAART2017 if (jaar==2016 & Welvaart ==.) & (VEHP100WELVAART2017 != -1 & VEHP100WELVAART2017 != -2)
replace Welvaart = VEHP100WELVAART2018 if (jaar==2017 & Welvaart ==.) & (VEHP100WELVAART2018 != -1 & VEHP100WELVAART2018 != -2)
replace Welvaart = VEHP100WELVAART2019 if (jaar==2018 & Welvaart ==.) & (VEHP100WELVAART2019 != -1 & VEHP100WELVAART2019 != -2)
replace Welvaart = VEHP100WELVAART2017 if (jaar==2019 & Welvaart ==.) & (VEHP100WELVAART2017 != -1 & VEHP100WELVAART2017 != -2)
replace Welvaart = VEHP100WELVAART2016 if (jaar==2019 & Welvaart ==.) & (VEHP100WELVAART2016 != -1 & VEHP100WELVAART2016 != -2)
replace Welvaart = VEHP100WELVAART2015 if (jaar==2019 & Welvaart ==.) & (VEHP100WELVAART2015 != -1 & VEHP100WELVAART2015 != -2)
replace Welvaart = VEHP100WELVAART2014 if (jaar==2019 & Welvaart ==.) & (VEHP100WELVAART2014 != -1 & VEHP100WELVAART2014 != -2)
replace Welvaart = VEHP100WELVAART2013 if (jaar==2019 & Welvaart ==.) & (VEHP100WELVAART2013 != -1 & VEHP100WELVAART2013 != -2)
replace Welvaart = VEHP100WELVAART2016 if (jaar==2018 & Welvaart ==.) & (VEHP100WELVAART2016 != -1 & VEHP100WELVAART2016 != -2)
replace Welvaart = VEHP100WELVAART2015 if (jaar==2018 & Welvaart ==.) & (VEHP100WELVAART2015 != -1 & VEHP100WELVAART2015 != -2)
replace Welvaart = VEHP100WELVAART2014 if (jaar==2018 & Welvaart ==.) & (VEHP100WELVAART2014 != -1 & VEHP100WELVAART2014 != -2)
replace Welvaart = VEHP100WELVAART2013 if (jaar==2018 & Welvaart ==.) & (VEHP100WELVAART2013 != -1 & VEHP100WELVAART2013 != -2)
replace Welvaart = VEHP100WELVAART2015 if (jaar==2017 & Welvaart ==.) & (VEHP100WELVAART2015 != -1 & VEHP100WELVAART2015 != -2)
replace Welvaart = VEHP100WELVAART2014 if (jaar==2017 & Welvaart ==.) & (VEHP100WELVAART2014 != -1 & VEHP100WELVAART2014 != -2)
replace Welvaart = VEHP100WELVAART2013 if (jaar==2017 & Welvaart ==.) & (VEHP100WELVAART2013 != -1 & VEHP100WELVAART2013 != -2)
replace Welvaart = VEHP100WELVAART2014 if (jaar==2016 & Welvaart ==.) & (VEHP100WELVAART2014 != -1 & VEHP100WELVAART2014 != -2)
replace Welvaart = VEHP100WELVAART2013 if (jaar==2016 & Welvaart ==.) & (VEHP100WELVAART2013 != -1 & VEHP100WELVAART2013 != -2)
replace Welvaart = VEHP100WELVAART2013 if (jaar==2015 & Welvaart ==.) & (VEHP100WELVAART2013 != -1 & VEHP100WELVAART2013 != -2)

gen Inkomen = .
replace Inkomen = INHP100HGEST2014 if jaar==2014
replace Inkomen = INHP100HGEST2015 if jaar==2015
replace Inkomen = INHP100HGEST2016 if jaar==2016
replace Inkomen = INHP100HGEST2017 if jaar==2017
replace Inkomen = INHP100HGEST2018 if jaar==2018
replace Inkomen = INHP100HGEST2019 if jaar==2019

gen Vermogen = .
replace Vermogen = VEHP100HVERM2013 if jaar==2014
replace Vermogen = VEHP100HVERM2014 if jaar==2015
replace Vermogen = VEHP100HVERM2015 if jaar==2016
replace Vermogen = VEHP100HVERM2016 if jaar==2017
replace Vermogen = VEHP100HVERM2017 if jaar==2018
replace Vermogen = VEHP100HVERM2018 if jaar==2019

replace Immunocompromised = 0 if (StopImmunocompromised == Exposure | StopImmunocompromised < Exposure | StImmunocompromised > date_end_exposure)

recode CLRTI (.=0)
recode Thirtydaymortality (1=0) if CLRTI == 0
recode Thirtydaymortality (0=1) if CLRTI == 1 & CLRTI_cause == 1

save "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2014-2019_Final.dta", replace

*population characteristics
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2014-2019_Final.dta", clear
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
drop if _merge==2
drop N measurement_postalcode CLRTI_yes lagged_variable id_count tag newv2 newv NN DEELSCOREWELVAART* DEELSCOREARBEID* DEELSCOREOPLEIDINGSNIVEAU* diff_Hospitalisation* merge_mortality huishouden1_2018 huishouden2_2018 huishouden3_2018 huishouden4_2018 huishouden5_2018 huishouden6_2018 huishouden7_2018 huishouden8_2018 huishouden9_2018 huishouden10_2018 huishouden11_2018 huishouden12_2018 huishouden13_2018 huishouden14_2018 INHP100HBEST INHP100HGEST20* INHP100HPRIM VEHP100WELVAART20* VEHP100HVERM20* VEHW1000VERH20*
destring Migratieachtergrond, replace ignore(--)
destring LANDAKTUEEL12, replace
recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2

/*baseline dataset (voor tabel 1)*/
keep if Exposure==date("20170101", "YMD")
gen age = (Exposure - birthday)/365.25
*drop if age > 80
*geslacht
tab gbageslacht, m
*migratieachtergrond
tab Migratieachtergrond, m

* huishouden
recode huishouden (.=4)
tab huishouden, m

* Comorbiditeit
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
by postalcode: sum Welvaart

* percentage zonder comorbidity
count if  Neoplastic_Disease == 0 & Liver_Disease == 0 & Congestive_HF == 0 & Cerebrovascular_Disease == 0 & Renal_Disease == 0 & Pulmonary_Disease == 0 & Dementia == 0 & Neurologic_Disease == 0 & Diabetes == 0 & HIV == 0 & Immunocompromised == 0 & Cardiovascular_Disease_other == 0

*voor de cases
use "H:\Datavoorbereiding\Ernst van Dokkum\Definitieve Datasets Analyse\SurvivalData2014-2019_Final.dta", clear
merge m:1 gbaherkomstgroepering using "H:\Datavoorbereiding\Ernst van Dokkum\Datasets Analyses\migratieachtergrond.dta"
drop N measurement_postalcode CLRTI_yes lagged_variable id_count tag newv2 newv NN DEELSCOREWELVAART* DEELSCOREARBEID* DEELSCOREOPLEIDINGSNIVEAU* diff_Hospitalisation* merge_mortality huishouden1_2018 huishouden2_2018 huishouden3_2018 huishouden4_2018 huishouden5_2018 huishouden6_2018 huishouden7_2018 huishouden8_2018 huishouden9_2018 huishouden10_2018 huishouden11_2018 huishouden12_2018 huishouden13_2018 huishouden14_2018 INHP100HBEST INHP100HGEST20* INHP100HPRIM VEHP100WELVAART20* VEHP100HVERM20* VEHW1000VERH20*
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
*11 Middle and Eastern Europe
* splitsen europa in oost europees
recode Migratieachtergrond (2=11) if LANDAKTUEEL12 == 2
keep if CLRTI == 1
gen age = (Exposure - birthday)/365.25
*drop if age > 80
duplicates report rinpersoon

sort rinpersoon BeginCLRTI
duplicates drop rinpersoon, force

tab gbageslacht, m

tab Migratieachtergrond, m

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

sum age, detail

gen age_category = .
recode age_category (.=1) if (age >= 18 & age < 50)
recode age_category (.=2) if (age >= 50 & age < 60)
recode age_category (.=3) if (age >= 60 & age < 70)
recode age_category (.=4) if (age >= 70 & age < 80)
recode age_category (.=5) if age >= 80

tab age_category, m

summarize Welvaart, detail

tab huishouden, m

