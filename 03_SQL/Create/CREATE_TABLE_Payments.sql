USE Hospital_Analytics_DB;

CREATE TABLE Payments (
payment_id VARCHAR(15) NOT NULL,
bill_id VARCHAR(15) NOT NULL,
patient_id VARCHAR(15) NOT NULL,
payment_date DATE NOT NULL,
payment_amount INT NOT NULL,
payment_mode VARCHAR(30) NOT NULL,
payment_status VARCHAR(20) NOT NULL,

CONSTRAINT medicare PRIMARY KEY (payment_id)
);