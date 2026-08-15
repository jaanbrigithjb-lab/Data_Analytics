USE Hospital_Analytics_DB;

CREATE TABLE Appointments (
appointment_id VARCHAR(20) NOT NULL,
patient_id VARCHAR(15) NOT NULL,
doctor_id VARCHAR(10) NOT NULL,
hospital_id VARCHAR(11) NOT NULL,
appointment_date DATE NOT NULL,
appointment_time TIME NOT NULL,
status VARCHAR(30) NOT NULL,
reason_for_visit VARCHAR(30) NOT NULL,
created_at DATETIME NOT NULL,

CONSTRAINT medicare PRIMARY KEY (appointment_id)
);