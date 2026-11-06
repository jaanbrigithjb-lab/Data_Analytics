# MediCare Healthcare Database Analysis

## Business Problem

### How can MediCare optimize its doctor and hospital capacity while improving access to the most in-demand medical specializations?

MediCare's healthcare database contains information about hospitals, doctors, departments, specializations, beds, appointments and consultation fees. The analysis focuses on understanding how medical resources are distributed across hospitals and specializations and where capacity and workload may require attention.

The SQL analysis examines doctor availability, hospital staffing, bed capacity, specialization distribution, appointments and consultation-fee patterns to support better healthcare resource planning.

### Business Objective

**Identify high-demand specializations, evaluate hospital staffing and capacity, and support better allocation of doctors and healthcare resources.**

### Solution

MediCare can use the analysis to:

1. **Identify high-demand specializations**
   - Compare doctor availability across specializations.
   - Focus staffing and capacity planning on specializations with higher demand.

2. **Optimize hospital staffing**
   - Compare the number of doctors across hospitals.
   - Identify hospitals with relatively high or low doctor availability.

3. **Monitor hospital capacity**
   - Analyze hospital bed capacity to understand available infrastructure.
   - Support capacity planning across hospitals.

4. **Evaluate consultation-fee patterns**
   - Compare average consultation fees across specializations.
   - Analyze fee variation among doctors.

5. **Improve workforce allocation**
   - Analyze appointment volume and doctor availability.
   - Support workload balancing and staffing decisions.

---

## Dataset / Database Structure

The MediCare project uses a relational healthcare database containing information about hospitals, doctors, departments, patients and appointments.

### Main Tables

| Table | Purpose |
|---|---|
| `Hospitals` | Hospital information and hospital-level details |
| `Doctors` | Doctor details including specialization and consultation fee |
| `Departments` | Department information associated with hospitals |
| `Patients` | Patient information used in the healthcare database |
| `Appointments` | Appointment records used to analyze doctor and service utilization |

The database is analyzed using SQL queries to identify operational patterns and support healthcare resource planning.

---

## SQL Analysis

The SQL analysis focuses on the following business areas:

### Hospital Analysis
- Count total hospitals.
- Identify unique hospital names.
- Analyze hospital-level information.
- Identify hospitals with higher doctor availability.
- Analyze hospital capacity and resources.

### Doctor Analysis
- Count total doctors.
- Analyze doctors by specialization.
- Identify doctors with more than 10 years of experience.
- Identify specializations with more than 20 doctors.
- Find the top specializations by doctor count.
- Compare doctors across hospitals.

### Department Analysis
- Count and analyze departments.
- Examine department distribution across hospitals.
- Identify hospitals based on department availability.

### Appointment Analysis
- Analyze appointment records.
- Compare appointment volumes across doctors.
- Identify doctors and hospitals with higher appointment activity.

### Consultation Fee Analysis
- Calculate average consultation fees by specialization.
- Rank doctors based on consultation fees.
- Compare consultation-fee patterns across doctors and specializations.
- Use window functions such as `LAG()` and ranking functions for comparisons.

---

## Tools & Technologies

The project was developed using **MySQL** and SQL-based analytical techniques.

### Technologies
- MySQL
- SQL
- Relational Database Management System

### SQL Techniques
- `SELECT`
- `DISTINCT`
- `WHERE`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- Aggregate Functions
- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`
- `INNER JOIN`
- `LEFT JOIN`
- Subqueries
- Window Functions
- `ROW_NUMBER()`
- `RANK()`
- `LAG()`
- `LEAD()`

---

## Data Profiling / Preparation

Before performing the analysis, the healthcare tables were examined to understand their structure, fields and relationships.

The analysis included:

- Reviewing table structures.
- Identifying available columns and business attributes.
- Checking hospital, doctor, department and appointment records.
- Using distinct-value analysis for categorical fields.
- Validating relationships between related tables.
- Applying filters and aggregations to produce meaningful business summaries.

The SQL queries were then used to transform the raw relational data into analysis-ready results.

---

## Key Metrics / Analysis Areas

The project evaluates several important healthcare metrics:

### Hospital Count
Measures the number of hospitals available in the database.

### Doctor Count
Measures the total number of doctors and supports workforce analysis.

### Department Availability
Helps understand how departments are distributed across hospitals.

### Bed Capacity
Provides an indication of available hospital infrastructure.

### Doctor Experience
Identifies experienced doctors, including doctors with more than 10 years of experience.

### Specialization Distribution
Shows how doctors are distributed across medical specializations.

### Appointment Volume
Helps identify doctors and hospitals with higher service utilization.

### Consultation Fee
Supports comparison of average and individual consultation fees.

---

## Key Insights

Based on the SQL analysis:

### 1. Doctor availability differs across specializations

The analysis identifies specializations with higher doctor counts and highlights areas where workforce availability is concentrated.

### 2. Some specializations have significantly higher representation

Specializations with more than 20 doctors and the top specializations by doctor count can be identified through the SQL analysis.

### 3. Hospital staffing is not uniform

The number of doctors differs across hospitals, allowing MediCare to identify hospitals with relatively higher or lower staffing levels.

### 4. Experienced doctors form an important workforce segment

The analysis identifies doctors with more than 10 years of experience, providing a basis for understanding the experienced workforce.

### 5. Consultation fees vary across specializations and doctors

Average consultation fees by specialization and doctor-level fee rankings highlight differences in consultation pricing.

### 6. Appointment activity provides a workload indicator

Doctor-level appointment analysis helps identify differences in service utilization and can support workload and staffing decisions.

---

## Recommendations / Conclusion

### Recommendations

Based on the analysis, MediCare should:

- Monitor specializations with high doctor and appointment demand.
- Review staffing levels across hospitals to identify potential resource imbalances.
- Use bed capacity and doctor availability together when planning hospital resources.
- Monitor workload through appointment volumes.
- Compare consultation fees across specializations when reviewing pricing patterns.
- Use experienced doctors strategically for mentoring, specialized care and workforce planning.
- Continue monitoring doctor, appointment and capacity metrics to support data-driven healthcare decisions.

### Conclusion

The MediCare SQL analysis provides a structured view of hospital resources, doctor availability, specialization distribution, appointment activity and consultation fees.

The analysis can help MediCare move from simple data reporting toward **data-driven workforce and capacity planning**, allowing management to identify areas requiring staffing, capacity or service-level attention.

---

## Project Outcome

This project demonstrates practical skills in:

- SQL database analysis
- Relational database concepts
- Healthcare data analysis
- Data profiling
- Data aggregation
- Multi-table joins
- Subqueries
- Grouping and filtering
- Window functions
- Ranking analysis
- Business insight generation
- Data-driven recommendations

The final output is a SQL-based **MediCare Healthcare Database Analysis** designed to convert relational healthcare data into meaningful operational insights and support resource-planning decisions.
