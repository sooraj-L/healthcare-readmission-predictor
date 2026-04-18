/* ---------------------------------------------------------------------*/
/* Query 1 */
/* Readmission rate by race */
select race,
count(*) as total_patients,
avg(time_in_hospital) as avg_stay,
sum(readmit_30) as readmit_count_30d,
round(avg(readmit_30) * 100.0,2 )as readmit_rate_30d
from hospital_readmissions
group by race
order by readmit_rate_30d desc limit 10;

/* Query 2 — Readmission Rate by Age Group */
select age,
count(*) as total_patients,
avg(time_in_hospital) as avg_stay,
sum(readmit_30) as readmit_count_30d,
round(avg(readmit_30)*100.0,2) as readmit_rate_30d
from hospital_readmissions
group by age
order by readmit_rate_30d desc;

/*  Query 3 — High-Risk Patients (Multiple Readmission Indicators) */
select patient_nbr, time_in_hospital,
num_lab_procedures,num_medications,
readmitted from hospital_readmissions
where readmitted = '<30'
and num_medications > 15
and number_diagnoses > 7
order by num_medications desc;
/* approch 2 */
select 
count(*) as high_risk_patients,
avg(time_in_hospital) as avg_stay,
avg(num_medications) as avg_medications
from hospital_readmissions
where readmitted = '<30'
and num_medications > 15
and number_diagnoses >7;

/* approach 3 */
select patient_nbr,time_in_hospital,
num_medications,number_diagnoses,readmitted,
case 
when num_medications > 20 then 'Very Hish Risk'
when num_medications between 15 and 20 then 'High Risk'
else 'Low Risk' end as Risk_Category
from hospital_readmissions
where readmitted = '<30'
order by num_medications desc;

/*Query 4 — Medication Count vs Readmission (Binned Analysis) */
select 
case 
when num_medications between 0 and 5 then '0-5 meds'
when num_medications between 6 and 10 then '6-10 meds'
when num_medications between 11 and 15 then '11-15 meds'
else '16+ meds'
end as medication_category,
count(*) as total_patients,
sum(readmit_30) as patient_count_30d,
round(avg(readmit_30)* 100.0, 2) as readmission_rate
from 
hospital_readmissions
group by medication_category;

/* Query 5 — Length of Stay & Lab Procedures by Readmission Status */
select readmitted,
count(*) as total_patients,
round(avg(time_in_hospital),2) as avg_stay,
round(avg(num_lab_procedures),2) as avg_lab_procedures,
round(avg(num_medications),2) as avg_medications,
round(avg(number_diagnoses),2) as avg_diagnoses,
round(count(*) * 100.0 / sum(count(*)) over(), 2) as pct_distribution
from hospital_readmissions
group by readmitted;

/* Query 6 — Does more medications = higher readmission? */
select 
case 
when num_medications < 10 then 'Low_risk'
when num_medications between 10 and 20 then 'High Risk'
else 'Very High Risk'
end as medication_level,
count(*) as total_patients,
round(avg(readmit_30) * 100.0 , 2) as readmission_rate
from hospital_readmissions
group by medication_level;

/* Query 7 — Which medical specialty has the most readmissions? */
select 
medical_specialty,
round(avg(time_in_hospital),2) as avg_stay,
round(avg(num_medications),2) as avg_medications,
count(*) as total_patients,
round(sum(case when readmitted = '<30' then 1 else 0 end) * 100.0 /count(*),2 )
as readmission_rate
from hospital_readmissions
group by medical_specialty
having count(*) >200
order by readmission_rate desc;