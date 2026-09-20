-- =================================================================================================
-- HEALTHPLUS CARE - DATA ANALYSIS
-- BRD-aligned analytical SQL
-- Covers healthcare utilization, telemedicine, chronic care, packages, corporate engagement,
-- prescriptions, laboratory services, claims, billing/payments, feedback and workforce.
-- =================================================================================================

USE HealthPlus;

-- 1. Total members by membership type and gender
SELECT membership_type, gender, COUNT(*) AS total_members
FROM Members
GROUP BY membership_type, gender
ORDER BY total_members DESC;

-- 2. Member distribution by city
SELECT city, COUNT(*) AS total_members
FROM Members
GROUP BY city
ORDER BY total_members DESC;

-- 3. Total specialists
SELECT COUNT(*) AS total_specialists
FROM Specialists;

-- 4. Total consultations
SELECT COUNT(*) AS total_consultations
FROM Consultations;

-- 5. Consultation volume by clinic
SELECT cl.clinic_id, cl.clinic_name, COUNT(c.consultation_id) AS consultation_volume
FROM Clinics cl
LEFT JOIN Consultations c ON cl.clinic_id = c.clinic_id
GROUP BY cl.clinic_id, cl.clinic_name
ORDER BY consultation_volume DESC;

-- 6. Consultation workload by specialist
SELECT s.specialist_id, CONCAT(s.first_name, ' ', s.last_name) AS specialist_name,
       s.specialization, COUNT(c.consultation_id) AS consultation_volume
FROM Specialists s
LEFT JOIN Consultations c ON s.specialist_id = c.specialist_id
GROUP BY s.specialist_id, specialist_name, s.specialization
ORDER BY consultation_volume DESC;

-- 7. Activity by specialization
SELECT s.specialization, COUNT(c.consultation_id) AS consultation_volume
FROM Specialists s
INNER JOIN Consultations c ON s.specialist_id = c.specialist_id
GROUP BY s.specialization
ORDER BY consultation_volume DESC;

-- 8. Consultation mode comparison
SELECT consultation_mode, COUNT(*) AS total_consultations
FROM Consultations
GROUP BY consultation_mode
ORDER BY total_consultations DESC;

-- 9. Consultation status mix
SELECT status, COUNT(*) AS total_consultations
FROM Consultations
GROUP BY status
ORDER BY total_consultations DESC;

-- 10. Most common reasons for visit
SELECT reason_for_visit, COUNT(*) AS visit_count
FROM Consultations
GROUP BY reason_for_visit
ORDER BY visit_count DESC
LIMIT 10;

-- 11. Specializations with more than 100 consultations
SELECT s.specialization, COUNT(c.consultation_id) AS total_consultations
FROM Specialists s
INNER JOIN Consultations c ON s.specialist_id = c.specialist_id
GROUP BY s.specialization
HAVING COUNT(c.consultation_id) > 100
ORDER BY total_consultations DESC;

-- 12. Most active members
SELECT m.member_id, CONCAT(m.first_name, ' ', m.last_name) AS member_name,
       COUNT(c.consultation_id) AS consultation_count
FROM Members m
INNER JOIN Consultations c ON m.member_id = c.member_id
GROUP BY m.member_id, member_name
ORDER BY consultation_count DESC
LIMIT 20;

-- 13. Registered members with no consultations
SELECT m.member_id, CONCAT(m.first_name, ' ', m.last_name) AS member_name
FROM Members m
LEFT JOIN Consultations c ON m.member_id = c.member_id
WHERE c.consultation_id IS NULL
ORDER BY m.member_id;

-- 14. Consultations with no feedback
SELECT c.consultation_id, c.member_id, c.consultation_date, c.consultation_mode
FROM Consultations c
LEFT JOIN Feedback f ON c.consultation_id = f.consultation_id
WHERE f.feedback_id IS NULL
ORDER BY c.consultation_date DESC;

-- 15. Telemedicine sessions and status
SELECT session_status, COUNT(*) AS total_sessions
FROM Telemedicine_Sessions
GROUP BY session_status
ORDER BY total_sessions DESC;

-- 16. Telemedicine platform usage
SELECT platform, COUNT(*) AS session_count
FROM Telemedicine_Sessions
GROUP BY platform
ORDER BY session_count DESC;

-- 17. Telemedicine connection quality
SELECT connection_quality, COUNT(*) AS session_count
FROM Telemedicine_Sessions
GROUP BY connection_quality
ORDER BY session_count DESC;

-- 18. Average telemedicine duration in minutes
SELECT ROUND(AVG(TIMESTAMPDIFF(MINUTE, session_start_time, session_end_time)), 2)
       AS average_session_duration_minutes
FROM Telemedicine_Sessions
WHERE session_start_time IS NOT NULL
  AND session_end_time IS NOT NULL
  AND session_end_time >= session_start_time;

-- 19. Telemedicine activity by clinic
SELECT cl.clinic_name, COUNT(ts.session_id) AS telemedicine_sessions
FROM Clinics cl
INNER JOIN Consultations c ON cl.clinic_id = c.clinic_id
INNER JOIN Telemedicine_Sessions ts ON c.consultation_id = ts.consultation_id
GROUP BY cl.clinic_id, cl.clinic_name
ORDER BY telemedicine_sessions DESC;

-- 20. Chronic-care condition distribution
SELECT condition_name, COUNT(*) AS program_count
FROM Chronic_Care_Programs
GROUP BY condition_name
ORDER BY program_count DESC;

-- 21. Chronic-care status distribution
SELECT program_status, COUNT(*) AS program_count
FROM Chronic_Care_Programs
GROUP BY program_status
ORDER BY program_count DESC;

-- 22. Specialists managing the most chronic-care programs
SELECT s.specialist_id, CONCAT(s.first_name, ' ', s.last_name) AS specialist_name,
       COUNT(p.program_id) AS chronic_program_count
FROM Specialists s
INNER JOIN Chronic_Care_Programs p ON s.specialist_id = p.specialist_id
GROUP BY s.specialist_id, specialist_name
ORDER BY chronic_program_count DESC;

-- 23. Chronic-care reviews approaching in the next 30 days
SELECT program_id, member_id, specialist_id, condition_name, next_review_date
FROM Chronic_Care_Programs
WHERE next_review_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY)
ORDER BY next_review_date;

-- 24. Health package subscription volume
SELECT hp.package_id, hp.package_name, hp.package_type,
       COUNT(ps.subscription_id) AS subscription_count
FROM Health_Packages hp
LEFT JOIN Package_Subscriptions ps ON hp.package_id = ps.package_id
GROUP BY hp.package_id, hp.package_name, hp.package_type
ORDER BY subscription_count DESC;

-- 25. Package adoption by package type
SELECT hp.package_type, COUNT(ps.subscription_id) AS subscription_count
FROM Health_Packages hp
INNER JOIN Package_Subscriptions ps ON hp.package_id = ps.package_id
GROUP BY hp.package_type
ORDER BY subscription_count DESC;

-- 26. Active versus expired package subscriptions
SELECT
    CASE
        WHEN expiry_date >= CURRENT_DATE THEN 'Active'
        ELSE 'Expired'
    END AS subscription_lifecycle,
    COUNT(*) AS subscription_count
FROM Package_Subscriptions
GROUP BY subscription_lifecycle;

-- 27. Package subscription payment status
SELECT payment_status, COUNT(*) AS subscription_count
FROM Package_Subscriptions
GROUP BY payment_status
ORDER BY subscription_count DESC;

-- 28. Corporate enrollment contribution
SELECT co.corporate_id, co.company_name, co.industry, co.employee_count,
       COUNT(cm.corporate_member_id) AS enrolled_members,
       ROUND(COUNT(cm.corporate_member_id) / NULLIF(co.employee_count, 0) * 100, 2)
       AS enrollment_percentage
FROM Corporates co
LEFT JOIN Corporate_Members cm ON co.corporate_id = cm.corporate_id
GROUP BY co.corporate_id, co.company_name, co.industry, co.employee_count
ORDER BY enrolled_members DESC;

-- 29. Corporate participation by industry
SELECT co.industry, COUNT(cm.corporate_member_id) AS enrolled_members
FROM Corporates co
INNER JOIN Corporate_Members cm ON co.corporate_id = cm.corporate_id
GROUP BY co.industry
ORDER BY enrolled_members DESC;

-- 30. Corporate members who have used consultations
SELECT COUNT(DISTINCT cm.member_id) AS corporate_members_with_consultations
FROM Corporate_Members cm
INNER JOIN Consultations c ON cm.member_id = c.member_id;

-- 31. Most frequently prescribed medicines
SELECT medicine_name, COUNT(*) AS prescription_count
FROM Prescriptions
GROUP BY medicine_name
ORDER BY prescription_count DESC
LIMIT 20;

-- 32. Specialists generating the highest prescription volume
SELECT s.specialist_id, CONCAT(s.first_name, ' ', s.last_name) AS specialist_name,
       COUNT(p.prescription_id) AS prescription_count
FROM Specialists s
INNER JOIN Prescriptions p ON s.specialist_id = p.specialist_id
GROUP BY s.specialist_id, specialist_name
ORDER BY prescription_count DESC;

-- 33. Prescription duration patterns
SELECT duration_days, COUNT(*) AS prescription_count
FROM Prescriptions
GROUP BY duration_days
ORDER BY duration_days;

-- 34. Laboratory workload by clinic
SELECT cl.clinic_id, cl.clinic_name, COUNT(lt.lab_test_id) AS lab_test_volume
FROM Clinics cl
LEFT JOIN Lab_Tests lt ON cl.clinic_id = lt.clinic_id
GROUP BY cl.clinic_id, cl.clinic_name
ORDER BY lab_test_volume DESC;

-- 35. Laboratory cost by test
SELECT test_name, COUNT(*) AS test_count,
       ROUND(SUM(test_cost), 2) AS total_test_cost
FROM Lab_Tests
GROUP BY test_name
ORDER BY total_test_cost DESC
LIMIT 20;

-- 36. Laboratory status distribution
SELECT test_status, COUNT(*) AS test_count
FROM Lab_Tests
GROUP BY test_status
ORDER BY test_count DESC;

-- 37. Claims volume, total and average amount
SELECT COUNT(*) AS total_claims,
       ROUND(SUM(claim_amount), 2) AS total_claim_amount,
       ROUND(AVG(claim_amount), 2) AS average_claim_amount
FROM Claims;

-- 38. Claim status distribution
SELECT claim_status, COUNT(*) AS claim_count
FROM Claims
GROUP BY claim_status
ORDER BY claim_count DESC;

-- 39. Insurance provider claim activity
SELECT insurance_provider, COUNT(*) AS claim_count,
       ROUND(SUM(claim_amount), 2) AS total_claim_amount
FROM Claims
GROUP BY insurance_provider
ORDER BY total_claim_amount DESC;

-- 40. Claims linked to consultations
SELECT COUNT(*) AS claims_linked_to_consultations
FROM Claims
WHERE consultation_id IS NOT NULL;

-- 41. Billing KPIs and service-charge contribution
SELECT COUNT(*) AS total_bills,
       ROUND(SUM(total_amount), 2) AS total_billed_amount,
       ROUND(AVG(total_amount), 2) AS average_bill_value,
       ROUND(SUM(consultation_charges), 2) AS consultation_charges,
       ROUND(SUM(lab_charges), 2) AS laboratory_charges,
       ROUND(SUM(medicine_charges), 2) AS medicine_charges
FROM Billing;

-- 42. Payment amount by status and payment mode
SELECT payment_status, payment_mode,
       COUNT(*) AS payment_count,
       ROUND(SUM(payment_amount), 2) AS total_payment_amount
FROM Payments
GROUP BY payment_status, payment_mode
ORDER BY total_payment_amount DESC;

-- 43. Validated collection gap at bill/payment grain
WITH billing_by_bill AS (
    SELECT bill_id, total_amount
    FROM Billing
),
payments_by_bill AS (
    SELECT bill_id, SUM(payment_amount) AS total_paid
    FROM Payments
    GROUP BY bill_id
)
SELECT ROUND(SUM(b.total_amount), 2) AS total_billed_amount,
       ROUND(SUM(COALESCE(p.total_paid, 0)), 2) AS total_recorded_payment,
       ROUND(SUM(b.total_amount - COALESCE(p.total_paid, 0)), 2) AS collection_gap
FROM billing_by_bill b
LEFT JOIN payments_by_bill p ON b.bill_id = p.bill_id;

-- 44. Bills with multiple payment records (grain validation)
SELECT bill_id, COUNT(payment_id) AS payment_record_count,
       ROUND(SUM(payment_amount), 2) AS total_paid
FROM Payments
GROUP BY bill_id
HAVING COUNT(payment_id) > 1
ORDER BY payment_record_count DESC;

-- 45. Average feedback rating
SELECT ROUND(AVG(rating), 2) AS average_feedback_rating
FROM Feedback;

-- 46. Feedback rating by specialist
SELECT s.specialist_id, CONCAT(s.first_name, ' ', s.last_name) AS specialist_name,
       ROUND(AVG(f.rating), 2) AS average_rating,
       COUNT(f.feedback_id) AS feedback_count
FROM Specialists s
INNER JOIN Consultations c ON s.specialist_id = c.specialist_id
INNER JOIN Feedback f ON c.consultation_id = f.consultation_id
GROUP BY s.specialist_id, specialist_name
ORDER BY average_rating DESC, feedback_count DESC;

-- 47. Feedback rating by clinic
SELECT cl.clinic_id, cl.clinic_name,
       ROUND(AVG(f.rating), 2) AS average_rating,
       COUNT(f.feedback_id) AS feedback_count
FROM Clinics cl
INNER JOIN Consultations c ON cl.clinic_id = c.clinic_id
INNER JOIN Feedback f ON c.consultation_id = f.consultation_id
GROUP BY cl.clinic_id, cl.clinic_name
ORDER BY average_rating DESC;

-- 48. Feedback rating by consultation mode
SELECT c.consultation_mode,
       ROUND(AVG(f.rating), 2) AS average_rating,
       COUNT(f.feedback_id) AS feedback_count
FROM Consultations c
INNER JOIN Feedback f ON c.consultation_id = f.consultation_id
GROUP BY c.consultation_mode
ORDER BY average_rating DESC;

-- 49. Staff count by clinic and designation
SELECT cl.clinic_name, s.designation, COUNT(s.staff_id) AS staff_count
FROM Clinics cl
LEFT JOIN Staff s ON cl.clinic_id = s.clinic_id
GROUP BY cl.clinic_id, cl.clinic_name, s.designation
ORDER BY cl.clinic_name, staff_count DESC;

-- 50. Employment type distribution
SELECT employment_type, COUNT(*) AS staff_count
FROM Staff
GROUP BY employment_type
ORDER BY staff_count DESC;

-- 51. Salary distribution by clinic
SELECT cl.clinic_name,
       ROUND(AVG(s.salary), 2) AS average_salary,
       ROUND(MIN(s.salary), 2) AS minimum_salary,
       ROUND(MAX(s.salary), 2) AS maximum_salary
FROM Clinics cl
INNER JOIN Staff s ON cl.clinic_id = s.clinic_id
GROUP BY cl.clinic_id, cl.clinic_name
ORDER BY average_salary DESC;

-- 52. Workforce joining trend by year
SELECT YEAR(joining_date) AS joining_year, COUNT(*) AS staff_joined
FROM Staff
GROUP BY YEAR(joining_date)
ORDER BY joining_year;

-- 53. RIGHT JOIN: show all specialists, including specialists with no consultations
SELECT s.specialist_id,
       CONCAT(s.first_name, ' ', s.last_name) AS specialist_name,
       COUNT(c.consultation_id) AS consultation_count
FROM Consultations c
RIGHT JOIN Specialists s ON c.specialist_id = s.specialist_id
GROUP BY s.specialist_id, specialist_name
ORDER BY consultation_count DESC;

-- 54. RANK specialists by consultation workload
SELECT specialist_id, specialist_name, consultation_volume,
       RANK() OVER (ORDER BY consultation_volume DESC) AS workload_rank
FROM (
    SELECT s.specialist_id,
           CONCAT(s.first_name, ' ', s.last_name) AS specialist_name,
           COUNT(c.consultation_id) AS consultation_volume
    FROM Specialists s
    LEFT JOIN Consultations c ON s.specialist_id = c.specialist_id
    GROUP BY s.specialist_id, specialist_name
) x
ORDER BY workload_rank, specialist_id;

-- 55. ROW_NUMBER consultations within each member
SELECT consultation_id, member_id, consultation_date, consultation_mode,
       ROW_NUMBER() OVER (
           PARTITION BY member_id
           ORDER BY consultation_date, consultation_id
       ) AS consultation_sequence
FROM Consultations
ORDER BY member_id, consultation_sequence;

-- 56. LAG: previous consultation date for each member
SELECT consultation_id, member_id, consultation_date,
       LAG(consultation_date) OVER (
           PARTITION BY member_id
           ORDER BY consultation_date, consultation_id
       ) AS previous_consultation_date
FROM Consultations
ORDER BY member_id, consultation_date, consultation_id;

-- 57. LEAD: next consultation date for each member
SELECT consultation_id, member_id, consultation_date,
       LEAD(consultation_date) OVER (
           PARTITION BY member_id
           ORDER BY consultation_date, consultation_id
       ) AS next_consultation_date
FROM Consultations
ORDER BY member_id, consultation_date, consultation_id;

-- 58. Consultation gap in days using LAG
WITH consultation_history AS (
    SELECT member_id, consultation_id, consultation_date,
           LAG(consultation_date) OVER (
               PARTITION BY member_id
               ORDER BY consultation_date, consultation_id
           ) AS previous_consultation_date
    FROM Consultations
)
SELECT member_id, consultation_id, consultation_date, previous_consultation_date,
       DATEDIFF(consultation_date, previous_consultation_date) AS days_since_previous_consultation
FROM consultation_history
WHERE previous_consultation_date IS NOT NULL
ORDER BY member_id, consultation_date;

-- 59. Members with consultations but no feedback
SELECT DISTINCT c.member_id
FROM Consultations c
LEFT JOIN Feedback f ON c.consultation_id = f.consultation_id
WHERE f.feedback_id IS NULL
ORDER BY c.member_id;

-- 60. Business areas: activity and financial/experience indicators
SELECT
    (SELECT COUNT(*) FROM Consultations) AS total_consultations,
    (SELECT COUNT(*) FROM Lab_Tests) AS total_lab_tests,
    (SELECT COUNT(*) FROM Prescriptions) AS total_prescriptions,
    (SELECT COUNT(*) FROM Claims) AS total_claims,
    (SELECT ROUND(SUM(total_amount),2) FROM Billing) AS total_billed_amount,
    (SELECT ROUND(SUM(payment_amount),2) FROM Payments) AS total_payment_amount,
    (SELECT ROUND(AVG(rating),2) FROM Feedback) AS average_feedback_rating;

-- 61. KPI summary aligned to the BRD
SELECT
    (SELECT COUNT(*) FROM Members) AS total_members,
    (SELECT COUNT(*) FROM Consultations) AS total_consultations,
    (SELECT ROUND(COUNT(*) / NULLIF((SELECT COUNT(*) FROM Members),0),2) FROM Consultations) AS consultations_per_member,
    (SELECT COUNT(*) FROM Telemedicine_Sessions) AS telemedicine_sessions,
    (SELECT COUNT(*) FROM Chronic_Care_Programs WHERE program_status = 'Active') AS active_chronic_care_programs,
    (SELECT COUNT(*) FROM Package_Subscriptions) AS package_subscriptions,
    (SELECT COUNT(*) FROM Lab_Tests) AS total_lab_tests,
    (SELECT ROUND(SUM(test_cost),2) FROM Lab_Tests) AS total_lab_test_cost,
    (SELECT COUNT(*) FROM Claims) AS total_claims,
    (SELECT ROUND(SUM(claim_amount),2) FROM Claims) AS total_claim_amount,
    (SELECT ROUND(SUM(total_amount),2) FROM Billing) AS total_billed_amount,
    (SELECT ROUND(SUM(payment_amount),2) FROM Payments) AS total_payment_amount,
    (SELECT ROUND(AVG(rating),2) FROM Feedback) AS average_feedback_rating,
    (SELECT COUNT(*) FROM Corporate_Members) AS corporate_member_enrollment,
    (SELECT COUNT(*) FROM Staff) AS total_staff;
