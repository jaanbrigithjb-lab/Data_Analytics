#=======================================================================================================================================
#Data analysis
#================================================================================================================================================

#1. What is the total number of members, and how are they distributed across membership types and gender?
select membership_type,gender,count(*)
from Members
group by membership_type,gender
order by count(member_id) desc;

#2.Which cities have the highest number of members?
SELECT city,COUNT(*) AS total_members
FROM Members
GROUP BY city
ORDER BY total_members DESC;

#3. What is the total revenue generated, average bill value, and contribution of consultation, laboratory and medicine charges?
SELECT
COUNT(*) AS total_bills,
ROUND(SUM(total_amount), 2) AS total_revenue,
ROUND(AVG(total_amount), 2) AS average_bill_value,
ROUND(SUM(consultation_charges), 2) AS consultation_revenue,
ROUND(SUM(lab_charges), 2) AS lab_revenue,
ROUND(SUM(medicine_charges), 2) AS medicine_revenue
FROM Billing;

# 4. How many specialists are there?
SELECT COUNT(*) AS Total_no_of_Specialists
FROM Specialists;

# 5. What is the total revenue generated from billing?
SELECT SUM(total_amount) AS Total_Revenue
FROM Billing;

#6. What is the highest and lowest billing amount?
SELECT 
MAX(total_amount) AS Highest_Bill,
MIN(total_amount) AS Lowest_Bill
FROM Billing;

#7. How many members are there in each membership type?
SELECT membership_type,COUNT(member_id) AS Total_Members
FROM Members
GROUP BY membership_type;

#8. How many consultations are there for each consultation mode?
SELECT consultation_mode,COUNT(consultation_id) AS Total_Consultations
FROM Consultations
GROUP BY consultation_mode;

#9. How many consultations are there for each consultation status?
SELECT status,COUNT(consultation_id) AS Total_Consultations
FROM Consultations
GROUP BY status;

#10. Which specializations have more than 100 consultations?
SELECT s.specialization,COUNT(c.consultation_id) AS Total_Consultations
FROM Specialists s
INNER JOIN Consultations c
ON s.specialist_id = c.specialist_id
GROUP BY s.specialization
HAVING COUNT(c.consultation_id) > 100
ORDER BY Total_Consultations DESC;

#11. Which are the top 5 clinics based on number of consultations?
SELECT cl.clinic_name, COUNT(c.consultation_id) AS Total_Consultations
FROM Clinics cl
INNER JOIN Consultations c ON cl.clinic_id = c.clinic_id
GROUP BY cl.clinic_name
ORDER BY Total_Consultations DESC
LIMIT 5;

#12. Rank specialists based on consultation fee from highest to lowest.
SELECT first_name,last_name,specialization,consultation_fee,
ROW_NUMBER() OVER (ORDER BY consultation_fee DESC) AS rnk
FROM Specialists;

#13. Rank specialists based on consultation fee within each specialization.
SELECT first_name,last_name,specialization,consultation_fee,
ROW_NUMBER() OVER (PARTITION BY specialization ORDER BY consultation_fee DESC) AS rnk
FROM Specialists;

#14. Display the previous consultation fee for each specialist.
SELECT first_name,last_name,specialization,consultation_fee,
LAG(consultation_fee) OVER (ORDER BY consultation_fee DESC) 
FROM Specialists;

# 15. Display the next consultation fee for each specialist.
SELECT first_name,last_name,specialization,consultation_fee,
LEAD(consultation_fee) OVER (ORDER BY consultation_fee DESC) 
FROM Specialists;