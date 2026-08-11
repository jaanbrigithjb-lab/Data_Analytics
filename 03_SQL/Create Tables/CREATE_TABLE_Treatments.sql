USE Hospital_Analytics_DB;

CREATE TABLE Treatments (
treatment_id VARCHAR(20) NOT NULL,
admission_id VARCHAR(15),
patient_id VARCHAR(10) NOT NULL,
doctor_id VARCHAR(11) NOT NULL,
treatment_name VARCHAR(50) NOT NULL,
treatment_date DATE NOT NULL,
treatment_cost INT NOT NULL,
treatment_status VARCHAR(15) NOT NULL,

CONSTRAINT medicare PRIMARY KEY (treatment_id)
);