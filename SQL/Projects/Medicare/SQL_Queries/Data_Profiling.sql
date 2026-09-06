# =========================================================================================================================================================================================
# Data Profiling
#====================================================================================================================================================================================================
# 1. Departments table- head_doctor_id is null
SELECT * from Departments where head_doctor_id is null ;

# 2. Doctors - gender is in different formats
SELECT DISTINCT gender, COUNT(*)
from Doctors
Group by gender;

# 3. Doctors - department_id is blank
SELECT * FROM Doctors where department_id IS NULL;

# 4. Doctors - email is blank
SELECT * FROM Doctors where email IS NULL;
# 5. Check email format
SELECT * FROM Doctors where email NOT REGEXP '^[A-Za-z0-9_%.-]+@[A-Za-z0-9-_.]+\\.[A-Za-z]{2,}$';

# 6. Patients - Traling and leading spaces in first name
SELECT * from Patients where first_name <> ltrim(first_name);

# 7. Patients - gender in different formats
SELECT gender, count(*) 
FROM Patients 
group by gender;

# 8. Patient - Check for email blanks
SELECT * FROM Patients where email is null;
# 9. to check the email format 
SELECT * from Patients where email not regexp '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[a-zA-Z]{2,}';
SELECT * from Patients where email NOT like '%@%.%'; # this is another method to find invalid email, % includes any character

# 10. Admissions - check for blanks in department_id
SELECT * from Admissions where department_id is null;

# 11. Admissions - check for blanks in discharge_date
SELECT * from Admissions where discharge_date is null;

# 12. Treatments - check for blanks in Admission_id
SELECT  * FROM Treatments where Admission_id is null;

# 13. Insurance - check for blanks in insurance_provider
SELECT  * FROM Insurance where insurance_provider is null;

# 14. Employee gender different formats 
SELECT gender, count(*) 
from Employee
group by gender;

# 15. Employees - blanks in department_id
SELECT * FROM Employees where department_id is null;


# 16. Billing - blanks in admission_id
SELECT * FROM Billing where admission_id is null;

# 17. Employees - blanks in appointment_id
SELECT * FROM Billing where appointment_id is null;