USE Hospital_Analytics_DB;

CREATE TABLE Pharmacy (
pharmacy_sale_id VARCHAR(15) NOT NULL,
patient_id VARCHAR(15) NOT NULL,
medicine_id VARCHAR(15) NOT NULL,
hospital_id VARCHAR(15) NOT NULL,
quantity INT NOT NULL,
sale_date DATE NOT NULL,
total_price FLOAT NOT NULL,

CONSTRAINT medicare PRIMARY KEY (pharmacy_sale_id)
);