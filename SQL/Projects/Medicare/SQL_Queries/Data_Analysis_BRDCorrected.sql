-- =================================================================================================
-- MEDICARE - DATA ANALYSIS & BUSINESS KPI QUERIES
-- BRD-aligned, schema-validated against the supplied Medicare database
-- MySQL 8.0+
-- =================================================================================================

-- ================================= CORE COUNTS =================================
-- 1. Total hospitals
SELECT COUNT(*) AS total_hospitals FROM Hospitals;
-- 2. Total departments
SELECT COUNT(*) AS total_departments FROM Departments;
-- 3. Total doctors
SELECT COUNT(*) AS total_doctors FROM Doctors;
-- 4. Total patients
SELECT COUNT(*) AS total_patients FROM Patients;
-- 5. Total appointments
SELECT COUNT(*) AS total_appointments FROM Appointments;
-- 6. Total admissions
SELECT COUNT(*) AS total_admissions FROM Admissions;
-- 7. Total treatments
SELECT COUNT(*) AS total_treatments FROM Treatments;
-- 8. Total laboratory activity
SELECT COUNT(*) AS total_lab_activity FROM Laboratory;
-- 9. Total pharmacy activity
SELECT COUNT(*) AS total_pharmacy_activity FROM Pharmacy;

-- ================================= HOSPITAL / DEPARTMENT / DOCTOR =================================
-- 10. Hospital bed capacity
SELECT hospital_id, hospital_name, bed_capacity
FROM Hospitals ORDER BY bed_capacity DESC;

-- 11. Doctors by specialization
SELECT specialization, COUNT(*) AS doctor_count
FROM Doctors GROUP BY specialization ORDER BY doctor_count DESC;

-- 12. Specializations with more than 20 doctors
SELECT specialization, COUNT(*) AS doctor_count
FROM Doctors GROUP BY specialization
HAVING COUNT(*) > 20 ORDER BY doctor_count DESC;

-- 13. Top 5 specializations by doctor count
SELECT specialization, COUNT(*) AS doctor_count
FROM Doctors GROUP BY specialization ORDER BY doctor_count DESC LIMIT 5;

-- 14. Departments with their hospitals
SELECT d.department_id, d.department_name, h.hospital_name
FROM Departments d INNER JOIN Hospitals h ON d.hospital_id = h.hospital_id
ORDER BY h.hospital_name, d.department_name;

-- 15. Doctor count by hospital, including hospitals with zero doctors
SELECT h.hospital_id, h.hospital_name, COUNT(d.doctor_id) AS doctor_count
FROM Hospitals h LEFT JOIN Doctors d ON h.hospital_id = d.hospital_id
GROUP BY h.hospital_id, h.hospital_name ORDER BY doctor_count DESC;

-- 16. Doctor count by department
SELECT dp.department_id, dp.department_name, COUNT(d.doctor_id) AS doctor_count
FROM Departments dp LEFT JOIN Doctors d ON dp.department_id = d.department_id
GROUP BY dp.department_id, dp.department_name ORDER BY doctor_count DESC;

-- 17. Average consultation fee by specialization
SELECT specialization, ROUND(AVG(consultation_fee),2) AS avg_consultation_fee
FROM Doctors GROUP BY specialization ORDER BY avg_consultation_fee DESC;

-- 18. Highest consultation fee by specialization
SELECT specialization, MAX(consultation_fee) AS highest_consultation_fee
FROM Doctors GROUP BY specialization ORDER BY highest_consultation_fee DESC;

-- 19. Doctors with more than 10 years experience
SELECT doctor_id, first_name, last_name, specialization, experience_years
FROM Doctors WHERE experience_years > 10 ORDER BY experience_years DESC;

-- ================================= PATIENT / APPOINTMENT =================================
-- 20. Appointments by status
SELECT status, COUNT(*) AS appointment_count
FROM Appointments GROUP BY status ORDER BY appointment_count DESC;

-- 21. Appointments per doctor
SELECT d.doctor_id, CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
       COUNT(a.appointment_id) AS appointment_count
FROM Doctors d LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name
ORDER BY appointment_count DESC;

-- 22. Appointments by hospital
SELECT h.hospital_id, h.hospital_name, COUNT(a.appointment_id) AS appointment_count
FROM Hospitals h LEFT JOIN Appointments a ON h.hospital_id = a.hospital_id
GROUP BY h.hospital_id, h.hospital_name ORDER BY appointment_count DESC;

-- 23. Patient appointment activity
SELECT p.patient_id, CONCAT(p.first_name,' ',p.last_name) AS patient_name,
       COUNT(a.appointment_id) AS appointment_count
FROM Patients p LEFT JOIN Appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
ORDER BY appointment_count DESC;

-- 24. Patient activity by hospital (unique patients and appointments)
SELECT h.hospital_id, h.hospital_name,
       COUNT(DISTINCT a.patient_id) AS unique_patients,
       COUNT(a.appointment_id) AS appointment_count
FROM Hospitals h LEFT JOIN Appointments a ON h.hospital_id = a.hospital_id
GROUP BY h.hospital_id, h.hospital_name ORDER BY appointment_count DESC;

-- 25. Appointment workload by department
SELECT dp.department_id, dp.department_name,
       COUNT(a.appointment_id) AS appointment_count
FROM Departments dp
LEFT JOIN Doctors d ON dp.department_id = d.department_id
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY dp.department_id, dp.department_name
ORDER BY appointment_count DESC;

-- ================================= ADMISSIONS / RESOURCE UTILIZATION =================================
-- 26. Admissions by status
SELECT admission_status, COUNT(*) AS admission_count
FROM Admissions GROUP BY admission_status ORDER BY admission_count DESC;

-- 27. Admissions by type
SELECT admission_type, COUNT(*) AS admission_count
FROM Admissions GROUP BY admission_type ORDER BY admission_count DESC;

-- 28. Average length of stay for valid completed admissions
SELECT ROUND(AVG(DATEDIFF(discharge_date, admission_date)),2) AS avg_length_of_stay_days
FROM Admissions
WHERE discharge_date IS NOT NULL AND discharge_date >= admission_date;

-- 29. Average length of stay by hospital
SELECT h.hospital_id, h.hospital_name,
       ROUND(AVG(DATEDIFF(a.discharge_date,a.admission_date)),2) AS avg_length_of_stay_days
FROM Admissions a INNER JOIN Hospitals h ON a.hospital_id = h.hospital_id
WHERE a.discharge_date IS NOT NULL AND a.discharge_date >= a.admission_date
GROUP BY h.hospital_id, h.hospital_name ORDER BY avg_length_of_stay_days DESC;

-- 30. Admissions by department
SELECT dp.department_id, dp.department_name,
       COUNT(a.admission_id) AS admission_count
FROM Departments dp LEFT JOIN Admissions a ON dp.department_id = a.department_id
GROUP BY dp.department_id, dp.department_name ORDER BY admission_count DESC;

-- 31. Admission activity by hospital
SELECT h.hospital_id, h.hospital_name, COUNT(a.admission_id) AS admission_count
FROM Hospitals h LEFT JOIN Admissions a ON h.hospital_id = a.hospital_id
GROUP BY h.hospital_id, h.hospital_name ORDER BY admission_count DESC;

-- 32. Room count by hospital and room type
SELECT h.hospital_id, h.hospital_name, r.room_type, COUNT(r.room_id) AS room_count
FROM Hospitals h LEFT JOIN Rooms r ON h.hospital_id = r.hospital_id
GROUP BY h.hospital_id, h.hospital_name, r.room_type
ORDER BY h.hospital_id, room_count DESC;

-- 33. Room utilization by status
SELECT h.hospital_id, h.hospital_name, r.room_status, COUNT(r.room_id) AS room_count
FROM Hospitals h LEFT JOIN Rooms r ON h.hospital_id = r.hospital_id
GROUP BY h.hospital_id, h.hospital_name, r.room_status
ORDER BY h.hospital_id, room_count DESC;

-- 34. Room status overall
SELECT room_status, COUNT(*) AS room_count
FROM Rooms GROUP BY room_status ORDER BY room_count DESC;

-- ================================= TREATMENT / LAB / PHARMACY =================================
-- 35. Treatment volume and cost
SELECT treatment_name, COUNT(*) AS treatment_count,
       COALESCE(SUM(treatment_cost),0) AS total_treatment_cost
FROM Treatments GROUP BY treatment_name ORDER BY total_treatment_cost DESC;

-- 36. Treatment cost by doctor
SELECT d.doctor_id, CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
       COUNT(t.treatment_id) AS treatment_count,
       COALESCE(SUM(t.treatment_cost),0) AS total_treatment_cost
FROM Doctors d LEFT JOIN Treatments t ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name
ORDER BY total_treatment_cost DESC;

-- 37. Treatment activity by patient
SELECT p.patient_id, CONCAT(p.first_name,' ',p.last_name) AS patient_name,
       COUNT(t.treatment_id) AS treatment_count,
       COALESCE(SUM(t.treatment_cost),0) AS total_treatment_cost
FROM Patients p LEFT JOIN Treatments t ON p.patient_id = t.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
ORDER BY treatment_count DESC, total_treatment_cost DESC;

-- 38. Treatment activity by hospital through admission relationship
SELECT h.hospital_id, h.hospital_name,
       COUNT(t.treatment_id) AS treatment_count,
       COALESCE(SUM(t.treatment_cost),0) AS total_treatment_cost
FROM Hospitals h
LEFT JOIN Admissions a ON h.hospital_id = a.hospital_id
LEFT JOIN Treatments t ON a.admission_id = t.admission_id
GROUP BY h.hospital_id, h.hospital_name
ORDER BY treatment_count DESC, total_treatment_cost DESC;

-- 39. Treatment status analysis
SELECT treatment_status, COUNT(*) AS treatment_count,
       COALESCE(SUM(treatment_cost),0) AS total_treatment_cost
FROM Treatments GROUP BY treatment_status ORDER BY treatment_count DESC;

-- 40. Laboratory activity and cost by test
SELECT test_name, COUNT(*) AS test_count,
       COALESCE(SUM(test_cost),0) AS total_lab_cost
FROM Laboratory GROUP BY test_name ORDER BY total_lab_cost DESC;

-- 41. Laboratory activity by hospital
SELECT h.hospital_id, h.hospital_name, COUNT(l.lab_test_id) AS lab_activity,
       COALESCE(SUM(l.test_cost),0) AS total_lab_cost
FROM Hospitals h LEFT JOIN Laboratory l ON h.hospital_id = l.hospital_id
GROUP BY h.hospital_id, h.hospital_name ORDER BY lab_activity DESC;

-- 42. Laboratory activity by doctor
SELECT d.doctor_id, CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
       COUNT(l.lab_test_id) AS lab_test_count,
       COALESCE(SUM(l.test_cost),0) AS total_lab_cost
FROM Doctors d LEFT JOIN Laboratory l ON d.doctor_id = l.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name
ORDER BY lab_test_count DESC, total_lab_cost DESC;

-- 43. Laboratory activity by status
SELECT test_status, COUNT(*) AS test_count,
       COALESCE(SUM(test_cost),0) AS total_lab_cost
FROM Laboratory GROUP BY test_status ORDER BY test_count DESC;

-- 44. Pharmacy sales by medicine
SELECT m.medicine_id, m.medicine_name,
       COALESCE(SUM(p.quantity),0) AS total_quantity,
       COALESCE(SUM(p.total_price),0) AS total_sales
FROM Medicines m LEFT JOIN Pharmacy p ON m.medicine_id = p.medicine_id
GROUP BY m.medicine_id, m.medicine_name ORDER BY total_sales DESC;

-- 45. Pharmacy activity by hospital
SELECT h.hospital_id, h.hospital_name, COUNT(p.pharmacy_sale_id) AS pharmacy_transactions,
       COALESCE(SUM(p.quantity),0) AS total_quantity,
       COALESCE(SUM(p.total_price),0) AS total_sales
FROM Hospitals h LEFT JOIN Pharmacy p ON h.hospital_id = p.hospital_id
GROUP BY h.hospital_id, h.hospital_name ORDER BY total_sales DESC;

-- 46. Pharmacy activity by medicine category (schema uses Medicines.category)
SELECT m.category,
       COALESCE(SUM(p.quantity),0) AS total_quantity,
       COALESCE(SUM(p.total_price),0) AS total_sales
FROM Medicines m LEFT JOIN Pharmacy p ON m.medicine_id = p.medicine_id
GROUP BY m.category ORDER BY total_sales DESC;

-- 47. Medicine inventory attention areas
SELECT medicine_id, medicine_name, category, unit_price, stock_quantity
FROM Medicines ORDER BY stock_quantity ASC, medicine_name;

-- ================================= BILLING / PAYMENTS =================================
-- 48. Total billed amount
SELECT COALESCE(SUM(total_amount),0) AS total_billed_amount FROM Billing;

-- 49. Billing by status
SELECT bill_status, COUNT(*) AS bill_count,
       COALESCE(SUM(total_amount),0) AS billed_amount
FROM Billing GROUP BY bill_status ORDER BY billed_amount DESC;

-- 50. Billing charge-component analysis
SELECT COALESCE(SUM(room_charges),0) AS total_room_charges,
       COALESCE(SUM(doctor_charges),0) AS total_doctor_charges,
       COALESCE(SUM(medicine_charges),0) AS total_medicine_charges,
       COALESCE(SUM(lab_charges),0) AS total_lab_charges,
       COALESCE(SUM(other_charges),0) AS total_other_charges,
       COALESCE(SUM(total_amount),0) AS total_billed_amount
FROM Billing;

-- 51. Billing by hospital, supporting both admission-linked and appointment-linked bills
SELECT h.hospital_id, h.hospital_name,
       COUNT(DISTINCT b.bill_id) AS bill_count,
       COALESCE(SUM(b.total_amount),0) AS billed_amount
FROM Hospitals h
LEFT JOIN Billing b
  ON h.hospital_id = COALESCE(
       (SELECT ad.hospital_id FROM Admissions ad WHERE ad.admission_id = b.admission_id),
       (SELECT ap.hospital_id FROM Appointments ap WHERE ap.appointment_id = b.appointment_id)
     )
GROUP BY h.hospital_id, h.hospital_name
ORDER BY billed_amount DESC;

-- 52. Successful payment collected
SELECT COALESCE(SUM(payment_amount),0) AS total_payment_collected
FROM Payments WHERE LOWER(TRIM(payment_status)) = 'success';

-- 53. Payments by status
SELECT payment_status, COUNT(*) AS payment_count,
       COALESCE(SUM(payment_amount),0) AS payment_amount
FROM Payments GROUP BY payment_status ORDER BY payment_amount DESC;

-- 54. Successful payments by mode
SELECT payment_mode, COUNT(*) AS payment_count,
       COALESCE(SUM(payment_amount),0) AS collected_amount
FROM Payments
WHERE LOWER(TRIM(payment_status)) = 'success'
GROUP BY payment_mode ORDER BY collected_amount DESC;

-- 55. Payment collection by hospital without duplicate counting

WITH bill_hospital AS (
    SELECT
        b.bill_id,
        b.total_amount,
        COALESCE(ad.hospital_id, ap.hospital_id) AS hospital_id
    FROM Billing b
    LEFT JOIN Admissions ad
        ON b.admission_id = ad.admission_id
    LEFT JOIN Appointments ap
        ON b.appointment_id = ap.appointment_id
),

billing_by_hospital AS (
    SELECT
        hospital_id,
        COUNT(*) AS bill_count,
        SUM(total_amount) AS billed_amount
    FROM bill_hospital
    GROUP BY hospital_id
),

payments_by_bill AS (
    SELECT
        bill_id,
        SUM(
            CASE
                WHEN LOWER(TRIM(payment_status)) = 'success'
                THEN payment_amount
                ELSE 0
            END
        ) AS collected_amount
    FROM Payments
    GROUP BY bill_id
),

collection_by_hospital AS (
    SELECT
        bh.hospital_id,
        SUM(COALESCE(pb.collected_amount, 0)) AS collected_amount
    FROM bill_hospital bh
    LEFT JOIN payments_by_bill pb
        ON bh.bill_id = pb.bill_id
    GROUP BY bh.hospital_id
)

SELECT
    h.hospital_id,
    h.hospital_name,
    COALESCE(bh.bill_count, 0) AS bill_count,
    COALESCE(bh.billed_amount, 0) AS billed_amount,
    COALESCE(ch.collected_amount, 0) AS collected_amount,
    COALESCE(bh.billed_amount, 0)
        - COALESCE(ch.collected_amount, 0) AS collection_gap,
    ROUND(
        COALESCE(ch.collected_amount, 0)
        / NULLIF(COALESCE(bh.billed_amount, 0), 0) * 100,
        2
    ) AS collection_rate_percent
FROM Hospitals h
LEFT JOIN billing_by_hospital bh
    ON h.hospital_id = bh.hospital_id
LEFT JOIN collection_by_hospital ch
    ON h.hospital_id = ch.hospital_id
ORDER BY collected_amount DESC;

-- 56. Collection gap and collection rate; billing and payments are aggregated separately
WITH billing_total AS (
    SELECT COALESCE(SUM(total_amount),0) AS total_billed FROM Billing
), payment_total AS (
    SELECT COALESCE(SUM(payment_amount),0) AS total_collected
    FROM Payments WHERE LOWER(TRIM(payment_status)) = 'success'
)
SELECT total_billed, total_collected,
       total_billed - total_collected AS collection_gap,
       ROUND(total_collected / NULLIF(total_billed,0) * 100,2) AS collection_rate_percent
FROM billing_total CROSS JOIN payment_total;

-- ================================= KPI SUMMARY =================================
-- 57. Core KPI summary
SELECT
    (SELECT COUNT(*) FROM Patients) AS total_patients,
    (SELECT COUNT(*) FROM Appointments) AS total_appointments,
    (SELECT COUNT(*) FROM Admissions) AS total_admissions,
    (SELECT COUNT(*) FROM Treatments) AS total_treatments,
    (SELECT COALESCE(SUM(treatment_cost),0) FROM Treatments) AS total_treatment_cost,
    (SELECT COUNT(*) FROM Laboratory) AS total_lab_activity,
    (SELECT COUNT(*) FROM Pharmacy) AS total_pharmacy_activity,
    (SELECT COALESCE(SUM(total_amount),0) FROM Billing) AS total_billed_amount,
    (SELECT COALESCE(SUM(payment_amount),0) FROM Payments WHERE LOWER(TRIM(payment_status))='success') AS total_payment_collected;

-- ================================= JOINS =================================
-- 58. INNER JOIN - departments with hospitals
SELECT d.department_id, d.department_name, h.hospital_name
FROM Departments d INNER JOIN Hospitals h ON d.hospital_id = h.hospital_id;

-- 59. LEFT JOIN - hospitals with departments, including hospitals with no departments
SELECT h.hospital_id, h.hospital_name, d.department_id, d.department_name
FROM Hospitals h LEFT JOIN Departments d ON h.hospital_id = d.hospital_id
ORDER BY h.hospital_name, d.department_name;

-- 60. RIGHT JOIN - all departments with their hospital where available
SELECT h.hospital_name, d.department_name
FROM Hospitals h RIGHT JOIN Departments d ON h.hospital_id = d.hospital_id;

-- ================================= WINDOW FUNCTIONS =================================
-- 61. ROW_NUMBER - doctors ordered by consultation fee
SELECT doctor_id, first_name, last_name, specialization, consultation_fee,
       ROW_NUMBER() OVER (ORDER BY consultation_fee DESC, doctor_id) AS fee_row_number
FROM Doctors;

-- 62. ROW_NUMBER - fee position within specialization
SELECT doctor_id, first_name, last_name, specialization, consultation_fee,
       ROW_NUMBER() OVER (PARTITION BY specialization ORDER BY consultation_fee DESC, doctor_id) AS fee_position
FROM Doctors;

-- 63. RANK - equal consultation fees receive the same rank within specialization
SELECT doctor_id, first_name, last_name, specialization, consultation_fee,
       RANK() OVER (PARTITION BY specialization ORDER BY consultation_fee DESC) AS fee_rank
FROM Doctors;

-- 64. LAG - compare monthly appointment activity with previous month
WITH monthly_appointments AS (
    SELECT DATE_FORMAT(appointment_date,'%Y-%m') AS appointment_month,
           COUNT(*) AS appointment_count
    FROM Appointments GROUP BY DATE_FORMAT(appointment_date,'%Y-%m')
)
SELECT appointment_month, appointment_count,
       LAG(appointment_count) OVER (ORDER BY appointment_month) AS previous_month_appointments,
       appointment_count - LAG(appointment_count) OVER (ORDER BY appointment_month) AS change_from_previous_month
FROM monthly_appointments ORDER BY appointment_month;

-- 65. LEAD - compare monthly appointment activity with next month
WITH monthly_appointments AS (
    SELECT DATE_FORMAT(appointment_date,'%Y-%m') AS appointment_month,
           COUNT(*) AS appointment_count
    FROM Appointments GROUP BY DATE_FORMAT(appointment_date,'%Y-%m')
)
SELECT appointment_month, appointment_count,
       LEAD(appointment_count) OVER (ORDER BY appointment_month) AS next_month_appointments
FROM monthly_appointments ORDER BY appointment_month;

-- 66. Rank doctors within their department by consultation fee
SELECT dp.department_name, d.doctor_id,
       CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
       d.consultation_fee,
       ROW_NUMBER() OVER (PARTITION BY dp.department_id ORDER BY d.consultation_fee DESC, d.doctor_id) AS department_fee_rank
FROM Departments dp INNER JOIN Doctors d ON d.department_id = dp.department_id;

-- 67. Hospital doctor workload ranking
WITH hospital_doctor_counts AS (
    SELECT h.hospital_id, h.hospital_name, COUNT(d.doctor_id) AS doctor_count
    FROM Hospitals h LEFT JOIN Doctors d ON h.hospital_id = d.hospital_id
    GROUP BY h.hospital_id, h.hospital_name
)
SELECT hospital_name, doctor_count,
       RANK() OVER (ORDER BY doctor_count DESC) AS hospital_workload_rank
FROM hospital_doctor_counts;

-- 68. Doctor appointment workload ranking
WITH doctor_appointments AS (
    SELECT d.doctor_id, CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
           COUNT(a.appointment_id) AS appointment_count
    FROM Doctors d LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
    GROUP BY d.doctor_id, d.first_name, d.last_name
)
SELECT doctor_id, doctor_name, appointment_count,
       RANK() OVER (ORDER BY appointment_count DESC) AS workload_rank
FROM doctor_appointments ORDER BY workload_rank;
