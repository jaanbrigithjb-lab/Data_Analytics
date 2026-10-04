-- =================================================================================================
-- MEDICARE - DATA CLEANING & STANDARDIZATION
-- BRD-aligned. MySQL 8.0+
-- Only controlled, documented transformations are applied.
-- NULL business values are NOT automatically converted to zero.
-- =================================================================================================

SET SQL_SAFE_UPDATES = 0;

-- 1. Doctors - normalize gender labels
UPDATE Doctors
SET gender = CASE
    WHEN LOWER(TRIM(gender)) IN ('male','m') THEN 'Male'
    WHEN LOWER(TRIM(gender)) IN ('female','f') THEN 'Female'
    ELSE gender
END
WHERE gender IS NOT NULL;

-- 2. Patients - normalize gender labels
UPDATE Patients
SET gender = CASE
    WHEN LOWER(TRIM(gender)) IN ('male','m') THEN 'Male'
    WHEN LOWER(TRIM(gender)) IN ('female','f') THEN 'Female'
    ELSE gender
END
WHERE gender IS NOT NULL;

-- 3. Employees - normalize gender labels
UPDATE Employees
SET gender = CASE
    WHEN LOWER(TRIM(gender)) IN ('male','m') THEN 'Male'
    WHEN LOWER(TRIM(gender)) IN ('female','f') THEN 'Female'
    ELSE gender
END
WHERE gender IS NOT NULL;

-- 4. Doctors - remove leading/trailing whitespace from names
UPDATE Doctors
SET first_name = TRIM(first_name), last_name = TRIM(last_name)
WHERE first_name IS NOT NULL OR last_name IS NOT NULL;

-- 5. Patients - remove leading/trailing whitespace from names
UPDATE Patients
SET first_name = TRIM(first_name), last_name = TRIM(last_name)
WHERE first_name IS NOT NULL OR last_name IS NOT NULL;

-- 6. Employees - remove leading/trailing whitespace from names
UPDATE Employees
SET first_name = TRIM(first_name), last_name = TRIM(last_name)
WHERE first_name IS NOT NULL OR last_name IS NOT NULL;

-- 7. Doctors - clean common Gmail formatting issues only
UPDATE Doctors
SET email = CASE
    WHEN LOWER(TRIM(email)) LIKE '%@@gmail.com' THEN REPLACE(TRIM(email),'@@gmail.com','@gmail.com')
    WHEN LOWER(TRIM(email)) LIKE '%@gmail' THEN CONCAT(TRIM(email),'.com')
    WHEN LOWER(TRIM(email)) LIKE '%gmail.com' AND TRIM(email) NOT LIKE '%@%' THEN REPLACE(TRIM(email),'gmail.com','@gmail.com')
    ELSE TRIM(email)
END
WHERE email IS NOT NULL;

-- 8. Patients - clean common Gmail formatting issues only
UPDATE Patients
SET email = CASE
    WHEN LOWER(TRIM(email)) LIKE '%@@gmail.com' THEN REPLACE(TRIM(email),'@@gmail.com','@gmail.com')
    WHEN LOWER(TRIM(email)) LIKE '%@gmail' THEN CONCAT(TRIM(email),'.com')
    WHEN LOWER(TRIM(email)) LIKE '%gmail.com' AND TRIM(email) NOT LIKE '%@%' THEN REPLACE(TRIM(email),'gmail.com','@gmail.com')
    ELSE TRIM(email)
END
WHERE email IS NOT NULL;

-- Cleaning decisions:
-- * M/m/male -> Male and F/f/female -> Female are equivalent label standardizations.
-- * TRIM removes accidental surrounding whitespace without changing the business value.
-- * Only obvious Gmail formatting defects are repaired; other invalid emails remain for review.
-- * NULL values are preserved because the BRD requires business interpretation before replacement.

-- ================================= POST-CLEANING VALIDATION =================================
-- 9. Gender values
SELECT 'Doctors' AS table_name, gender, COUNT(*) AS record_count FROM Doctors GROUP BY gender
UNION ALL
SELECT 'Patients', gender, COUNT(*) FROM Patients GROUP BY gender
UNION ALL
SELECT 'Employees', gender, COUNT(*) FROM Employees GROUP BY gender;

-- 10. Invalid email formats after cleaning
SELECT 'Doctors' AS table_name, doctor_id AS record_id, email FROM Doctors
WHERE email IS NOT NULL AND email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
UNION ALL
SELECT 'Patients', patient_id, email FROM Patients
WHERE email IS NOT NULL AND email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';

-- 11. Invalid admission date relationship
SELECT * FROM Admissions
WHERE discharge_date IS NOT NULL AND discharge_date < admission_date;

-- 12. Invalid patient date relationship
SELECT * FROM Patients
WHERE date_of_birth IS NOT NULL AND registration_date IS NOT NULL
  AND date_of_birth > registration_date;

-- 13. Future joining dates for review
SELECT 'Doctors' AS table_name, doctor_id AS record_id, joining_date
FROM Doctors WHERE joining_date IS NULL OR joining_date > CURDATE()
UNION ALL
SELECT 'Employees', employee_id, joining_date
FROM Employees WHERE joining_date IS NULL OR joining_date > CURDATE();

-- 14. Numeric validation for key financial/operational fields
SELECT 'Hospitals' AS table_name, hospital_id AS record_id, bed_capacity AS invalid_value
FROM Hospitals WHERE bed_capacity < 0
UNION ALL
SELECT 'Doctors', doctor_id, experience_years FROM Doctors WHERE experience_years < 0
UNION ALL
SELECT 'Doctors', doctor_id, consultation_fee FROM Doctors WHERE consultation_fee < 0
UNION ALL
SELECT 'Treatments', treatment_id, treatment_cost FROM Treatments WHERE treatment_cost < 0
UNION ALL
SELECT 'Laboratory', lab_test_id, test_cost FROM Laboratory WHERE test_cost < 0
UNION ALL
SELECT 'Billing', bill_id, total_amount FROM Billing WHERE total_amount < 0
UNION ALL
SELECT 'Payments', payment_id, payment_amount FROM Payments WHERE payment_amount < 0;
