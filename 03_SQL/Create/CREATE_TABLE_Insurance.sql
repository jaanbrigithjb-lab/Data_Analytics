USE Hospital_Analytics_DB;

CREATE TABLE Insurance (
insurance_id VARCHAR(20) NOT NULL,
patient_id VARCHAR(15) NOT NULL,
insurance_provider VARCHAR(30),
policy_number VARCHAR(15) NOT NULL,
coverage_amount INT NOT NULL,
policy_start_date DATE NOT NULL,
policy_end_date DATE NOT NULL,
claim_status VARCHAR(15)NOT NULL,

CONSTRAINT medicare PRIMARY KEY (insurance_id)
);