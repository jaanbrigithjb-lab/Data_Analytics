-- =================================================================================================
-- MEDICARE - DATA PROFILING & VALIDATION
-- BRD-aligned. MySQL 8.0+
-- Profiling investigates NULLs, duplicates, dates, numerics and referential integrity.
-- =================================================================================================

-- 1. Departments - missing head doctor
SELECT * FROM Departments WHERE head_doctor_id IS NULL;

-- 2. Doctors - gender values and frequencies
SELECT gender, COUNT(*) AS record_count FROM Doctors GROUP BY gender ORDER BY record_count DESC;

-- 3. Doctors - missing department / hospital
SELECT * FROM Doctors WHERE department_id IS NULL OR hospital_id IS NULL;

-- 4. Doctors - invalid email format
SELECT * FROM Doctors WHERE email IS NOT NULL
AND email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';

-- 5. Doctors - invalid experience / consultation fee / joining date
SELECT * FROM Doctors WHERE experience_years < 0 OR consultation_fee < 0;
SELECT * FROM Doctors WHERE joining_date IS NULL OR joining_date > CURDATE();

-- 6. Patients - name whitespace and missing core fields
SELECT * FROM Patients WHERE first_name <> TRIM(first_name) OR last_name <> TRIM(last_name);
SELECT * FROM Patients WHERE first_name IS NULL OR last_name IS NULL OR registration_date IS NULL;

-- 7. Patients - gender values and frequencies
SELECT gender, COUNT(*) AS record_count FROM Patients GROUP BY gender ORDER BY record_count DESC;

-- 8. Patients - invalid email and date relationship
SELECT * FROM Patients WHERE email IS NOT NULL
AND email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
SELECT * FROM Patients WHERE date_of_birth IS NOT NULL AND registration_date IS NOT NULL
AND date_of_birth > registration_date;

-- 9. Hospitals - invalid capacity / established year
SELECT * FROM Hospitals WHERE bed_capacity < 0 OR established_year < 0;

-- 10. Appointments - missing core references / invalid dates
SELECT * FROM Appointments
WHERE patient_id IS NULL OR doctor_id IS NULL OR hospital_id IS NULL OR appointment_date IS NULL;

-- 11. Admissions - missing references / invalid dates
SELECT * FROM Admissions
WHERE patient_id IS NULL OR hospital_id IS NULL OR department_id IS NULL
   OR admitting_doctor_id IS NULL OR room_id IS NULL;
SELECT * FROM Admissions
WHERE discharge_date IS NOT NULL AND discharge_date < admission_date;

-- 12. Treatments - missing references / invalid cost
SELECT * FROM Treatments
WHERE admission_id IS NULL OR patient_id IS NULL OR doctor_id IS NULL OR treatment_cost < 0;

-- 13. Insurance - missing provider / policy and invalid coverage / dates
SELECT * FROM Insurance WHERE insurance_provider IS NULL OR policy_number IS NULL;
SELECT * FROM Insurance WHERE coverage_amount < 0
   OR (policy_start_date IS NOT NULL AND policy_end_date IS NOT NULL AND policy_end_date < policy_start_date);

-- 14. Employees - gender, department and numeric/date validation
SELECT gender, COUNT(*) AS record_count FROM Employees GROUP BY gender ORDER BY record_count DESC;
SELECT * FROM Employees WHERE department_id IS NULL OR joining_date IS NULL OR joining_date > CURDATE();
SELECT * FROM Employees WHERE salary < 0;

-- 15. Billing - missing references and invalid monetary values
SELECT * FROM Billing WHERE admission_id IS NULL AND appointment_id IS NULL;
SELECT * FROM Billing
WHERE room_charges < 0 OR doctor_charges < 0 OR medicine_charges < 0
   OR lab_charges < 0 OR other_charges < 0 OR total_amount < 0;

-- 16. Billing - validate total calculation with NULL-safe arithmetic
SELECT * FROM Billing
WHERE total_amount <> (
    COALESCE(room_charges,0) + COALESCE(doctor_charges,0) + COALESCE(medicine_charges,0)
    + COALESCE(lab_charges,0) + COALESCE(other_charges,0)
);

-- 17. Payments - invalid amount and missing bill reference
SELECT * FROM Payments WHERE bill_id IS NULL OR payment_amount < 0;

-- 18. Medicines / Pharmacy - invalid quantity and price
SELECT * FROM Medicines WHERE unit_price < 0 OR stock_quantity < 0;
SELECT * FROM Pharmacy WHERE quantity <= 0 OR total_price < 0;

-- 19. Laboratory - invalid cost and missing core references
SELECT * FROM Laboratory
WHERE patient_id IS NULL OR doctor_id IS NULL OR hospital_id IS NULL OR test_cost < 0;

-- 20. Duplicate primary-key checks - all entity tables
SELECT hospital_id, COUNT(*) AS duplicate_count FROM Hospitals GROUP BY hospital_id HAVING COUNT(*) > 1;
SELECT department_id, COUNT(*) AS duplicate_count FROM Departments GROUP BY department_id HAVING COUNT(*) > 1;
SELECT doctor_id, COUNT(*) AS duplicate_count FROM Doctors GROUP BY doctor_id HAVING COUNT(*) > 1;
SELECT patient_id, COUNT(*) AS duplicate_count FROM Patients GROUP BY patient_id HAVING COUNT(*) > 1;
SELECT room_id, COUNT(*) AS duplicate_count FROM Rooms GROUP BY room_id HAVING COUNT(*) > 1;
SELECT appointment_id, COUNT(*) AS duplicate_count FROM Appointments GROUP BY appointment_id HAVING COUNT(*) > 1;
SELECT admission_id, COUNT(*) AS duplicate_count FROM Admissions GROUP BY admission_id HAVING COUNT(*) > 1;
SELECT treatment_id, COUNT(*) AS duplicate_count FROM Treatments GROUP BY treatment_id HAVING COUNT(*) > 1;
SELECT insurance_id, COUNT(*) AS duplicate_count FROM Insurance GROUP BY insurance_id HAVING COUNT(*) > 1;
SELECT medicine_id, COUNT(*) AS duplicate_count FROM Medicines GROUP BY medicine_id HAVING COUNT(*) > 1;
SELECT pharmacy_sale_id, COUNT(*) AS duplicate_count FROM Pharmacy GROUP BY pharmacy_sale_id HAVING COUNT(*) > 1;
SELECT lab_test_id, COUNT(*) AS duplicate_count FROM Laboratory GROUP BY lab_test_id HAVING COUNT(*) > 1;
SELECT employee_id, COUNT(*) AS duplicate_count FROM Employees GROUP BY employee_id HAVING COUNT(*) > 1;
SELECT bill_id, COUNT(*) AS duplicate_count FROM Billing GROUP BY bill_id HAVING COUNT(*) > 1;
SELECT payment_id, COUNT(*) AS duplicate_count FROM Payments GROUP BY payment_id HAVING COUNT(*) > 1;

-- 21. Referential-integrity/orphan checks for foreign keys
SELECT d.* FROM Departments d LEFT JOIN Hospitals h ON d.hospital_id = h.hospital_id
WHERE d.hospital_id IS NOT NULL AND h.hospital_id IS NULL;
SELECT d.* FROM Doctors d LEFT JOIN Departments dp ON d.department_id = dp.department_id
WHERE d.department_id IS NOT NULL AND dp.department_id IS NULL;
SELECT d.* FROM Doctors d LEFT JOIN Hospitals h ON d.hospital_id = h.hospital_id
WHERE d.hospital_id IS NOT NULL AND h.hospital_id IS NULL;
SELECT r.* FROM Rooms r LEFT JOIN Hospitals h ON r.hospital_id = h.hospital_id
WHERE r.hospital_id IS NOT NULL AND h.hospital_id IS NULL;
SELECT a.* FROM Appointments a LEFT JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.patient_id IS NOT NULL AND p.patient_id IS NULL;
SELECT a.* FROM Appointments a LEFT JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE a.doctor_id IS NOT NULL AND d.doctor_id IS NULL;
SELECT a.* FROM Appointments a LEFT JOIN Hospitals h ON a.hospital_id = h.hospital_id
WHERE a.hospital_id IS NOT NULL AND h.hospital_id IS NULL;
SELECT a.* FROM Admissions a LEFT JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.patient_id IS NOT NULL AND p.patient_id IS NULL;
SELECT a.* FROM Admissions a LEFT JOIN Hospitals h ON a.hospital_id = h.hospital_id
WHERE a.hospital_id IS NOT NULL AND h.hospital_id IS NULL;
SELECT a.* FROM Admissions a LEFT JOIN Departments d ON a.department_id = d.department_id
WHERE a.department_id IS NOT NULL AND d.department_id IS NULL;
SELECT a.* FROM Admissions a LEFT JOIN Doctors d ON a.admitting_doctor_id = d.doctor_id
WHERE a.admitting_doctor_id IS NOT NULL AND d.doctor_id IS NULL;
SELECT a.* FROM Admissions a LEFT JOIN Rooms r ON a.room_id = r.room_id
WHERE a.room_id IS NOT NULL AND r.room_id IS NULL;
SELECT t.* FROM Treatments t LEFT JOIN Admissions a ON t.admission_id = a.admission_id
WHERE t.admission_id IS NOT NULL AND a.admission_id IS NULL;
SELECT t.* FROM Treatments t LEFT JOIN Patients p ON t.patient_id = p.patient_id
WHERE t.patient_id IS NOT NULL AND p.patient_id IS NULL;
SELECT t.* FROM Treatments t LEFT JOIN Doctors d ON t.doctor_id = d.doctor_id
WHERE t.doctor_id IS NOT NULL AND d.doctor_id IS NULL;
SELECT i.* FROM Insurance i LEFT JOIN Patients p ON i.patient_id = p.patient_id
WHERE i.patient_id IS NOT NULL AND p.patient_id IS NULL;
SELECT ph.* FROM Pharmacy ph LEFT JOIN Patients p ON ph.patient_id = p.patient_id
WHERE ph.patient_id IS NOT NULL AND p.patient_id IS NULL;
SELECT ph.* FROM Pharmacy ph LEFT JOIN Medicines m ON ph.medicine_id = m.medicine_id
WHERE ph.medicine_id IS NOT NULL AND m.medicine_id IS NULL;
SELECT ph.* FROM Pharmacy ph LEFT JOIN Hospitals h ON ph.hospital_id = h.hospital_id
WHERE ph.hospital_id IS NOT NULL AND h.hospital_id IS NULL;
SELECT l.* FROM Laboratory l LEFT JOIN Patients p ON l.patient_id = p.patient_id
WHERE l.patient_id IS NOT NULL AND p.patient_id IS NULL;
SELECT l.* FROM Laboratory l LEFT JOIN Doctors d ON l.doctor_id = d.doctor_id
WHERE l.doctor_id IS NOT NULL AND d.doctor_id IS NULL;
SELECT l.* FROM Laboratory l LEFT JOIN Hospitals h ON l.hospital_id = h.hospital_id
WHERE l.hospital_id IS NOT NULL AND h.hospital_id IS NULL;
SELECT e.* FROM Employees e LEFT JOIN Hospitals h ON e.hospital_id = h.hospital_id
WHERE e.hospital_id IS NOT NULL AND h.hospital_id IS NULL;
SELECT e.* FROM Employees e LEFT JOIN Departments d ON e.department_id = d.department_id
WHERE e.department_id IS NOT NULL AND d.department_id IS NULL;
SELECT b.* FROM Billing b LEFT JOIN Patients p ON b.patient_id = p.patient_id
WHERE b.patient_id IS NOT NULL AND p.patient_id IS NULL;
SELECT b.* FROM Billing b LEFT JOIN Admissions a ON b.admission_id = a.admission_id
WHERE b.admission_id IS NOT NULL AND a.admission_id IS NULL;
SELECT b.* FROM Billing b LEFT JOIN Appointments a ON b.appointment_id = a.appointment_id
WHERE b.appointment_id IS NOT NULL AND a.appointment_id IS NULL;
SELECT py.* FROM Payments py LEFT JOIN Billing b ON py.bill_id = b.bill_id
WHERE py.bill_id IS NOT NULL AND b.bill_id IS NULL;
SELECT py.* FROM Payments py LEFT JOIN Patients p ON py.patient_id = p.patient_id
WHERE py.patient_id IS NOT NULL AND p.patient_id IS NULL;

-- BRD decision note: NULL admission_id in Treatments is investigated, not automatically replaced.
-- A NULL may be legitimate if the service was not tied to an inpatient admission.
