USE Hospital_Analytics_DB;

CREATE TABLE Employees (
employee_id VARCHAR(15) NOT NULL,
first_name VARCHAR(15) NOT NULL,
last_name VARCHAR(15) NOT NULL,
gender VARCHAR(15) NOT NULL,
hospital_id VARCHAR(15) NOT NULL,
department_id VARCHAR(15) NOT NULL,
designation VARCHAR(30) NOT NULL,
employment_type VARCHAR(20) NOT NULL,
salary INT NOT NULL,
joining_date DATE NOT NULL,
phone_number INT NOT NULL,
email VARCHAR(50) NOT NULL,

CONSTRAINT medicare PRIMARY KEY (employee_id)
);