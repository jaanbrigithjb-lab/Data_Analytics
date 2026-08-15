USE Hospital_Analytics_DB;

CREATE TABLE Admissions (
admission_id VARCHAR(20) NOT NULL,
patient_id VARCHAR(15) NOT NULL,
hospital_id VARCHAR(10) NOT NULL,
department_id VARCHAR(11),
admitting_doctor_id VARCHAR(15) NOT NULL,
room_id VARCHAR(15) NOT NULL,
admission_date DATE NOT NULL,
discharge_date DATE,
admission_type VARCHAR(15) NOT NULL,
admission_status VARCHAR(15) NOT NULL,

CONSTRAINT medicare PRIMARY KEY (admission_id)
);