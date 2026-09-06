# ==============================================================================================================================================================================================
# Data Cleaning
#=====================================================================================================================================================================================================
set sql_SAFE_UPDATES=0;
# 2. Update the changed male and female column in the tables - Doctors
 UPDATE Doctors 
 SET gender=
 CASE 
WHEN LOWER(TRIM(gender)) IN ('male','m')
THEN 'Male'
WHEN LOWER(TRIM(gender)) IN ('female','f')
THEN 'Female'
ELSE gender
END;

# 5. Doctors - Cleaning the emails which are in wrong format
# This is previewing
SELECT 
email AS old_email,
CASE
WHEN email LIKE '%gmail.com' AND email NOT LIKE '%@%'
THEN REPLACE(email,'gmail.com','@gmail.com') 
WHEN email LIKE '%@gmail'
THEN REPLACE(email,'@gmail','@gmail.com') # THEN CONCAT(email,'.com')
WHEN email LIKE '%@@gmail.com' 
THEN REPLACE(email,'@@gmail.com','@gmail.com')
ELSE email
END AS new_email
FROM Doctors;

# Updating
update Doctors 
SET email=
CASE
WHEN email LIKE '%gmail.com' AND email NOT LIKE '%@%'
THEN REPLACE(email,'gmail.com','@gmail.com') 
WHEN email LIKE '%@gmail'
THEN REPLACE(email,'@gmail','@gmail.com') # THEN CONCAT(email,'.com')
WHEN email LIKE '%@@gmail.com' 
THEN REPLACE(email,'@@gmail.com','@gmail.com')
ELSE email
END 
WHERE email not like '%@%.%' or
	email like '%@@%.%';
#SET SQL_SAFE_UPDATES = 0; - When using the Upadate query where condition is applicable for id alone but when we try to use other columns in where condition then it shows sql safe error so to fix it we use this query 

# 6. Patients - Trim the first_name column
UPDATE Patients 
SET first_name=ltrim(first_name)
WHERE first_name <> LTRIM(first_name);

# 7. Patients - gender in different format
SELECT DISTINCT gender from Patients;
# Preview
SELECT gender ,
CASE
WHEN lower(trim(gender)) in ('m','male')
THEN 'Male'
WHEN lower(trim(gender)) in ('f','female')
THEN 'Female'
END
FROM Patients;

# Update 
update Patients 
set gender =
CASE
WHEN lower(trim(gender)) in ('m','male')
THEN 'Male'
WHEN lower(trim(gender)) in ('f','female')
THEN 'Female'
ELSE gender
END;

# 9. Patients - email format is not correct
SELECT email AS old_email, 
CASE
WHEN email LIKE '%gmail.com' AND email not like '%@%'
THEN REPLACE(email,'%gmail.com','%@gmail.com')
WHEN email like '%gmail'
then concat(email,'.com')
else email
end as new_email
FROM Patients;

# Update 
UPDATE Patients 
set email=
CASE
WHEN email LIKE '%gmail.com' AND email not like '%@%'
THEN REPLACE(email,'gmail.com','@gmail.com')
WHEN email like '%gmail'
then concat(email,'.com')
else email
end
where email not like '%@%.%';

# 14. Employee - gender in different format 
select distinct gender from Employees;
UPDATE Employees
set gender =
CASE
when lower(trim(gender)) in ('male','m')
then 'Male'
when lower(trim(gender)) in ('female','f')
then 'Female'
else gender
end;
