USE Hospital_Analytics_DB;

CREATE TABLE Hospitals (
hospital_id VARCHAR(10) NOT NULL,
hospital_name VARCHAR(100) NOT NULL,
hospital_type VARCHAR(40) NOT NULL,
city VARCHAR(30) NOT NULL,
state VARCHAR(25) NOT NULL,
region VARCHAR(20) NOT NULL,
bed_capacity INT NOT NULL,
established_year INT NOT NULL,
contact_number VARCHAR(20) NOT NULL,
email VARCHAR(100),
CONSTRAINT medicare PRIMARY KEY (hospital_id)
);