-- =================================================================================================
-- HEALTHPLUS CARE - DATA CLEANING
-- BRD-aligned data preparation and safe standardization
-- Do not delete pending/cancelled records or invent missing business values.
-- =================================================================================================

USE HealthPlus;

SET SQL_SAFE_UPDATES = 0;

-- 1. Standardize member gender values
UPDATE Members
SET gender = CASE
    WHEN LOWER(TRIM(gender)) IN ('male', 'm') THEN 'Male'
    WHEN LOWER(TRIM(gender)) IN ('female', 'f') THEN 'Female'
    ELSE TRIM(gender)
END
WHERE gender IS NOT NULL;

-- 2. Trim and normalize member email values without overwriting valid emails
UPDATE Members
SET email = CASE
    WHEN email IS NULL THEN NULL
    WHEN LOWER(TRIM(email)) LIKE '%gmail'
         AND LOWER(TRIM(email)) NOT LIKE '%@%'
        THEN CONCAT(
            LEFT(TRIM(email), LENGTH(TRIM(email)) - 5),
            '@gmail.com'
        )
    WHEN LOWER(TRIM(email)) LIKE '%@gmail'
        THEN CONCAT(TRIM(email), '.com')
    ELSE TRIM(email)
END
WHERE email IS NOT NULL;

-- 3. Trim text fields where whitespace can affect grouping and joins
UPDATE Members
SET membership_type = TRIM(membership_type),
    city = TRIM(city)
WHERE membership_type IS NOT NULL OR city IS NOT NULL;

UPDATE Consultations
SET consultation_mode = TRIM(consultation_mode),
    status = TRIM(status),
    reason_for_visit = TRIM(reason_for_visit)
WHERE consultation_mode IS NOT NULL
   OR status IS NOT NULL
   OR reason_for_visit IS NOT NULL;

UPDATE Payments
SET payment_mode = TRIM(payment_mode),
    payment_status = TRIM(payment_status)
WHERE payment_mode IS NOT NULL OR payment_status IS NOT NULL;

UPDATE Claims
SET claim_status = TRIM(claim_status),
    insurance_provider = TRIM(insurance_provider)
WHERE claim_status IS NOT NULL OR insurance_provider IS NOT NULL;

UPDATE Lab_Tests
SET test_name = TRIM(test_name),
    test_status = TRIM(test_status)
WHERE test_name IS NOT NULL OR test_status IS NOT NULL;

UPDATE Staff
SET designation = TRIM(designation),
    employment_type = TRIM(employment_type)
WHERE designation IS NOT NULL OR employment_type IS NOT NULL;

UPDATE Package_Subscriptions
SET payment_status = TRIM(payment_status)
WHERE payment_status IS NOT NULL;

UPDATE Chronic_Care_Programs
SET program_status = TRIM(program_status),
    condition_name = TRIM(condition_name)
WHERE program_status IS NOT NULL OR condition_name IS NOT NULL;

-- 4. Validate email values after cleaning; unresolved invalid values are not invented.
SELECT member_id, email
FROM Members
WHERE email IS NOT NULL
  AND email NOT LIKE '%@%.%';

-- 5. Review unresolved foreign-key values before adding/changing constraints.
SELECT claim_id, consultation_id
FROM Claims
WHERE consultation_id IS NULL;

SELECT bill_id, consultation_id
FROM Billing
WHERE consultation_id IS NULL;

-- 6. Review missing business attributes that cannot be safely inferred.
SELECT claim_id, insurance_provider
FROM Claims
WHERE insurance_provider IS NULL;

SELECT payment_id, payment_mode
FROM Payments
WHERE payment_mode IS NULL;

-- 7. Verify date logic before final constrained loading.
SELECT consultation_id, consultation_date
FROM Consultations
WHERE consultation_date IS NULL;

SELECT subscription_id, subscription_date, expiry_date
FROM Package_Subscriptions
WHERE expiry_date < subscription_date;

SELECT session_id, session_start_time, session_end_time
FROM Telemedicine_Sessions
WHERE session_start_time IS NOT NULL
  AND session_end_time IS NOT NULL
  AND session_end_time < session_start_time;

-- 8. Verify billing arithmetic where all components are present.
SELECT bill_id, consultation_charges, lab_charges, medicine_charges, total_amount
FROM Billing
WHERE ROUND(
          COALESCE(consultation_charges, 0)
        + COALESCE(lab_charges, 0)
        + COALESCE(medicine_charges, 0), 2
      ) <> ROUND(total_amount, 2);
