USE Hospital_Analytics_DB;

CREATE TABLE Patients (
patient_id VARCHAR(20) NOT NULL,
first_name VARCHAR(10) NOT NULL,
last_name VARCHAR(10) NOT NULL,
gender VARCHAR(11) NOT NULL,
date_of_birth DATE NOT Null,
age INT NOT NULL,
city VARCHAR(20) NOT NULL,
state VARCHAR(10) NOT NULL,
phone_number INT  NOT NULL,
email VARCHAR(25),
blood_group VARCHAR(5) NOT NULL,
registration_date DATE NOT NULL,
CONSTRAINT medicare PRIMARY KEY (patient_id)  
);