-- =================================================================================================
-- HEALTHPLUS CARE - DATA PROFILING
-- BRD-aligned source inspection before final constraints and analysis
-- =================================================================================================

USE HealthPlus;

-- 1. Row counts for all 17 business tables
SELECT 'Clinics' AS table_name, COUNT(*) AS row_count FROM Clinics
UNION ALL SELECT 'Specialists', COUNT(*) FROM Specialists
UNION ALL SELECT 'Members', COUNT(*) FROM Members
UNION ALL SELECT 'Corporates', COUNT(*) FROM Corporates
UNION ALL SELECT 'Corporate_Members', COUNT(*) FROM Corporate_Members
UNION ALL SELECT 'Consultations', COUNT(*) FROM Consultations
UNION ALL SELECT 'Telemedicine_Sessions', COUNT(*) FROM Telemedicine_Sessions
UNION ALL SELECT 'Chronic_Care_Programs', COUNT(*) FROM Chronic_Care_Programs
UNION ALL SELECT 'Health_Packages', COUNT(*) FROM Health_Packages
UNION ALL SELECT 'Package_Subscriptions', COUNT(*) FROM Package_Subscriptions
UNION ALL SELECT 'Prescriptions', COUNT(*) FROM Prescriptions
UNION ALL SELECT 'Lab_Tests', COUNT(*) FROM Lab_Tests
UNION ALL SELECT 'Claims', COUNT(*) FROM Claims
UNION ALL SELECT 'Staff', COUNT(*) FROM Staff
UNION ALL SELECT 'Billing', COUNT(*) FROM Billing
UNION ALL SELECT 'Payments', COUNT(*) FROM Payments
UNION ALL SELECT 'Feedback', COUNT(*) FROM Feedback;

-- 2. Proposed primary-key uniqueness checks
SELECT 'Clinics' AS table_name, COUNT(*) AS total_rows, COUNT(DISTINCT clinic_id) AS distinct_keys FROM Clinics
UNION ALL SELECT 'Specialists', COUNT(*), COUNT(DISTINCT specialist_id) FROM Specialists
UNION ALL SELECT 'Members', COUNT(*), COUNT(DISTINCT member_id) FROM Members
UNION ALL SELECT 'Corporates', COUNT(*), COUNT(DISTINCT corporate_id) FROM Corporates
UNION ALL SELECT 'Corporate_Members', COUNT(*), COUNT(DISTINCT corporate_member_id) FROM Corporate_Members
UNION ALL SELECT 'Consultations', COUNT(*), COUNT(DISTINCT consultation_id) FROM Consultations
UNION ALL SELECT 'Telemedicine_Sessions', COUNT(*), COUNT(DISTINCT session_id) FROM Telemedicine_Sessions
UNION ALL SELECT 'Chronic_Care_Programs', COUNT(*), COUNT(DISTINCT program_id) FROM Chronic_Care_Programs
UNION ALL SELECT 'Health_Packages', COUNT(*), COUNT(DISTINCT package_id) FROM Health_Packages
UNION ALL SELECT 'Package_Subscriptions', COUNT(*), COUNT(DISTINCT subscription_id) FROM Package_Subscriptions
UNION ALL SELECT 'Prescriptions', COUNT(*), COUNT(DISTINCT prescription_id) FROM Prescriptions
UNION ALL SELECT 'Lab_Tests', COUNT(*), COUNT(DISTINCT lab_test_id) FROM Lab_Tests
UNION ALL SELECT 'Claims', COUNT(*), COUNT(DISTINCT claim_id) FROM Claims
UNION ALL SELECT 'Staff', COUNT(*), COUNT(DISTINCT staff_id) FROM Staff
UNION ALL SELECT 'Billing', COUNT(*), COUNT(DISTINCT bill_id) FROM Billing
UNION ALL SELECT 'Payments', COUNT(*), COUNT(DISTINCT payment_id) FROM Payments
UNION ALL SELECT 'Feedback', COUNT(*), COUNT(DISTINCT feedback_id) FROM Feedback;

-- 3. Members: gender standardization check
SELECT DISTINCT gender
FROM Members
ORDER BY gender;

-- 4. Members: missing emails
SELECT *
FROM Members
WHERE email IS NULL OR TRIM(email) = '';

-- 5. Members: invalid email formats
SELECT *
FROM Members
WHERE email IS NOT NULL
  AND TRIM(email) <> ''
  AND email NOT LIKE '%@%.%';

-- 6. Claims: missing consultation_id
SELECT *
FROM Claims
WHERE consultation_id IS NULL;

-- 7. Claims: missing insurance provider
SELECT *
FROM Claims
WHERE insurance_provider IS NULL OR TRIM(insurance_provider) = '';

-- 8. Billing: missing consultation_id
SELECT *
FROM Billing
WHERE consultation_id IS NULL;

-- 9. Payments: missing payment mode
SELECT *
FROM Payments
WHERE payment_mode IS NULL OR TRIM(payment_mode) = '';

-- 10. Foreign-key validation: specialist clinic references
SELECT s.specialist_id, s.clinic_id
FROM Specialists s
LEFT JOIN Clinics c ON s.clinic_id = c.clinic_id
WHERE c.clinic_id IS NULL;

-- 11. Foreign-key validation: consultation member/specialist/clinic references
SELECT c.consultation_id, c.member_id, c.specialist_id, c.clinic_id
FROM Consultations c
LEFT JOIN Members m ON c.member_id = m.member_id
LEFT JOIN Specialists s ON c.specialist_id = s.specialist_id
LEFT JOIN Clinics cl ON c.clinic_id = cl.clinic_id
WHERE m.member_id IS NULL
   OR s.specialist_id IS NULL
   OR cl.clinic_id IS NULL;

-- 12. Foreign-key validation: payments to billing
SELECT p.payment_id, p.bill_id
FROM Payments p
LEFT JOIN Billing b ON p.bill_id = b.bill_id
WHERE b.bill_id IS NULL;

-- 13. Date validation: package subscription lifecycle
SELECT *
FROM Package_Subscriptions
WHERE expiry_date < subscription_date;

-- 14. Date validation: telemedicine session duration
SELECT *
FROM Telemedicine_Sessions
WHERE session_start_time IS NOT NULL
  AND session_end_time IS NOT NULL
  AND session_end_time < session_start_time;

-- 15. Numeric validation: non-positive amounts
SELECT 'Billing' AS source_table, bill_id AS record_id, total_amount AS amount
FROM Billing
WHERE total_amount < 0
UNION ALL
SELECT 'Payments', payment_id, payment_amount
FROM Payments
WHERE payment_amount < 0
UNION ALL
SELECT 'Claims', claim_id, claim_amount
FROM Claims
WHERE claim_amount < 0
UNION ALL
SELECT 'Lab_Tests', lab_test_id, test_cost
FROM Lab_Tests
WHERE test_cost < 0;

-- 16. Categorical profiling: consultation mode/status
SELECT 'consultation_mode' AS field_name, consultation_mode AS field_value, COUNT(*) AS row_count
FROM Consultations
GROUP BY consultation_mode
UNION ALL
SELECT 'status', status, COUNT(*)
FROM Consultations
GROUP BY status;

-- 17. Categorical profiling: payment status/mode
SELECT 'payment_status' AS field_name, payment_status AS field_value, COUNT(*) AS row_count
FROM Payments
GROUP BY payment_status
UNION ALL
SELECT 'payment_mode', payment_mode, COUNT(*)
FROM Payments
GROUP BY payment_mode;

-- 18. Categorical profiling: claims and laboratory statuses
SELECT 'claim_status' AS field_name, claim_status AS field_value, COUNT(*) AS row_count
FROM Claims
GROUP BY claim_status
UNION ALL
SELECT 'test_status', test_status, COUNT(*)
FROM Lab_Tests
GROUP BY test_status;

-- 19. Feedback rating profile
SELECT rating, COUNT(*) AS rating_count
FROM Feedback
GROUP BY rating
ORDER BY rating;

-- 20. Billing arithmetic validation
SELECT bill_id, consultation_charges, lab_charges, medicine_charges, total_amount
FROM Billing
WHERE ROUND(
          COALESCE(consultation_charges, 0)
        + COALESCE(lab_charges, 0)
        + COALESCE(medicine_charges, 0), 2
      ) <> ROUND(total_amount, 2);

-- 21. Billing-to-payment grain check
SELECT b.bill_id,
       COUNT(p.payment_id) AS payment_record_count,
       ROUND(b.total_amount, 2) AS billed_amount,
       ROUND(COALESCE(SUM(p.payment_amount), 0), 2) AS recorded_payment
FROM Billing b
LEFT JOIN Payments p ON b.bill_id = p.bill_id
GROUP BY b.bill_id, b.total_amount
HAVING COUNT(p.payment_id) > 1
ORDER BY payment_record_count DESC;
