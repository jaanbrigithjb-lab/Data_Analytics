USE Hospital_Analytics_DB;

CREATE TABLE Medicines (
medicine_id VARCHAR(20) NOT NULL,
medicine_name VARCHAR(40) NOT NULL,
category VARCHAR(25) NOT NULL,
manufacturer VARCHAR(30) NOT NULL,
unit_price INT NOT NULL,
stock_quantity INT NOT NULL,

CONSTRAINT medicare PRIMARY KEY (medicine_id)
);