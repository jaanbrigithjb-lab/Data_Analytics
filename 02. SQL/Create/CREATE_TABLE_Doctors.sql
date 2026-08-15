USE Hospital_Analytics_DB;

CREATE TABLE Doctors (
doctor_id VARCHAR(10) NOT NULL,
first_name VARCHAR(25) NOT NULL,
last_name VARCHAR(25) NOT NULL,
gender VARCHAR(11) NOT NULL,
specialization VARCHAR(50) NOT NULL,
department_id VARCHAR(10),
hospital_id VARCHAR(10) NOT NULL,
qualification VARCHAR(25) NOT NULL,
experience_years INT NOT NULL,
consultation_fee INT NOT NULL,
phone_number varchar(20),
email VARCHAR(50),
joining_date varchar(10) NOT NULL,
CONSTRAINT medicare PRIMARY KEY (doctor_id)
);