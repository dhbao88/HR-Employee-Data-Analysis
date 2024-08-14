use hr;
rename table `human resources` to hr;
show columns from hr;

alter table hr
rename column `ï»¿id` to emp_id;

alter table hr
modify column emp_id varchar(20);

select * from hr;

set sql_safe_updates=0;
set autocommit=off;

commit;

#clean cột birthdate
update hr
set birthdate=case
	when birthdate like '%/%' then date_format(str_to_date(birthdate,"%m/%d/%Y"),"%Y-%m-%d")
    when birthdate like'%0_' then date_format(str_to_date(concat(substring_index(birthdate,"-",2),-20,substring_index(birthdate,"-",-1)),"%m-%d-%Y"),"%Y-%m-%d")
    when birthdate like '%-%' then date_format(str_to_date(concat(substring_index(birthdate,"-",2),-19,substring_index(birthdate,"-",-1)),"%m-%d-%Y"),"%Y-%m-%d")
    else birthdate
end;

alter table hr
modify column birthdate date;

#clean cột hire_date
update hr
set hire_date=case
	when hire_date like '%/%' then date_format(str_to_date(hire_date,"%m/%d/%Y"),"%Y-%m-%d")
    when hire_date like'%-%' then date_format(str_to_date(concat(substring_index(hire_date,"-",2),-20,substring_index(hire_date,"-",-1)),"%m-%d-%Y"),"%Y-%m-%d")
    else hire_date
end;

alter table hr
modify column hire_date date;

commit;

#clean cột termdate
update hr
set termdate = case
	when termdate like '%-%' then date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
    else null
end;


alter table hr
modify column termdate date;

select *from hr;
alter table hr
add column age int
after birthdate;

update hr
set age=timestampdiff(year,birthdate,current_date());

alter table hr
add column age_range varchar(15)
after age;

update hr
set age_range=case
	when age< 18 then "Under 18"
    when age>=18 and age<30 then "18 - 30"
    when age>=30 and age<45 then "30 - 45"
    when age>=45 and age<60 then "45 - 60"
    else "60 +"
end;

