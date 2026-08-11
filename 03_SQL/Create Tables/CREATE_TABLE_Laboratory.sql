USE Hospital_Analytics_DB;

CREATE TABLE Laboratory (
lab_test_id VARCHAR(15) NOT NULL,
patient_id VARCHAR(15) NOT NULL,
doctor_id VARCHAR(15) NOT NULL,
hospital_id VARCHAR(15) NOT NULL,
test_name VARCHAR(40) NOT NULL,
test_date DATE NOT NULL,
test_result VARCHAR(20) NOT NULL,
test_cost INT NOT NULL,
test_status VARCHAR(15) NOT NULL,

CONSTRAINT medicare PRIMARY KEY (lab_test_id)
);