USE Hospital_Analytics_DB;

CREATE TABLE Departments (
department_id VARCHAR(6) NOT NULL,
department_name VARCHAR(30) NOT NULL,
hospital_id VARCHAR(10) NOT NULL,
floor_number INT NOT NULL,
head_doctor_id VARCHAR(10),
CONSTRAINT medicare PRIMARY KEY (department_id)  
);