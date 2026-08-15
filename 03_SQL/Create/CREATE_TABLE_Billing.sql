USE Hospital_Analytics_DB;

CREATE TABLE Billing (
bill_id VARCHAR(15) NOT NULL,
patient_id VARCHAR(15) NOT NULL,
admission_id VARCHAR(15),
appointment_id VARCHAR(15),
bill_date DATE NOT NULL,
room_charges INT NOT NULL,
doctor_charges FLOAT NOT NULL,
medicine_charges FLOAT NOT NULL,
lab_charges FLOAT NULL,
other_charges FLOAT NOT NULL,
total_amount FLOAT NOT NULL,
bill_status VARCHAR(15) NOT NULL,

CONSTRAINT medicare PRIMARY KEY (bill_id)
);