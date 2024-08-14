#bảng job_history
select distinct(emp_id),hire_date,termdate 
from hr;

#bảng jobtitle
with distinct_jobtitle as (
select distinct(jobtitle) 
from hr)
select jobtitle, 
row_number() over() as job_id 
from distinct_jobtitle;

#bảng department
with distinct_department as (
select distinct (department)
from hr)
select department, row_number() over() as dep_id from distinct_department;


#bảng location
with distinct_location as (
select distinct (location),
location_city,
location_state
from hr)
select location,location_city,location_state, row_number() over() as loc_id from distinct_location;

#bảng employee
with distinct_jobtitle as (
select distinct(jobtitle) 
from hr),
jobtitle as (
select jobtitle, 
row_number() over() as job_id 
from distinct_jobtitle),

distinct_department as (
select distinct (department)
from hr),
deparment as (
select department, row_number() over() as dep_id from distinct_department)
,

distinct_location as (
select distinct (location),
location_city,
location_state
from hr),
location as (
select location,location_city,location_state, row_number() over() as loc_id from distinct_location)
,

job_history as (
select distinct (emp_id),
hire_date,
termdate
from hr)
select hr.emp_id,hr.first_name,hr.last_name,hr.age,hr.age_range,hr.gender,hr.race,j.job_id,d.dep_id,loc.loc_id  
from hr 
left join jobtitle as j on hr.jobtitle=j.jobtitle
left join department as d on hr.department=d.department
left join location as loc 
on hr.location=loc.location 
and hr.location_city = loc.location_city 
and hr.location_state = loc.location_state;
