#==================================================================================================================================
# Data Cleaning
#=======================================================================================================================================
set sql_safe_updates=0;
# 1, Members - gender is in different format
UPDATE Members
set gender=
CASE
WHEN lower(trim(gender)) in ('male','m')
THEN 'Male'
WHEN lower(trim(gender)) in ('female','f')
THEN 'Female'
ELSE gender
END;

# 2. Members - email is in different format 
update Members 
set email=
CASE
WHEN email like '%gmail' and email not like '%@%'
THEN REPLACE(email,'gmail','@gmail')
END
where email not like '%@%.%';
