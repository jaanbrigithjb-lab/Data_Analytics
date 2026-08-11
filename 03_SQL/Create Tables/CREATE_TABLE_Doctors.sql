USE Hospital_Analytics_DB;

CREATE TABLE Doctors (
doctor_id VARCHAR(10) NOT NULL,
first_name VARCHAR(10) NOT NULL,
last_name VARCHAR(10) NOT NULL,
gender VARCHAR(11) NOT NULL,
specialization VARCHAR(25) NOT NULL,
department_id VARCHAR(10),
hospital_id VARCHAR(10) NOT NULL,
qualification VARCHAR(25) NOT NULL,
experience_years INT NOT NULL,
consultation_fee INT NOT NULL,
phone_number INT UNIQUE,
email VARCHAR(25) UNIQUE,
joining_date DATE NOT NULL,
CONSTRAINT medicare PRIMARY KEY (doctor_id)
);