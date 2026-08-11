USE Hospital_Analytics_DB;

CREATE TABLE Rooms (
room_id VARCHAR(10) NOT NULL,
hospital_id VARCHAR(10) NOT NULL,
room_number INT NOT NULL,
room_type VARCHAR(11) NOT NULL,
floor_number INT NOT Null,
daily_charge VARCHAR(10) NOT NULL,

CONSTRAINT medicare PRIMARY KEY (room_id)  
);