# HealthPlus Healthcare Database Analysis

## Business Problem

### How can HealthPlus improve healthcare utilization and revenue by understanding member demand, consultation patterns and clinic performance?

HealthPlus maintains information about members, consultations, clinics, specialists and billing. The SQL analysis focuses on understanding where healthcare demand is concentrated, how members use consultation services, which clinics handle higher consultation volumes and how different services contribute to revenue.

### Business Objective

**Understand member demand, consultation utilization, clinic performance and revenue contribution to support better healthcare service planning.**

### Solution

HealthPlus can use the analysis to:

1. **Understand member demand**
   - Identify cities with higher member concentration.
   - Analyze the distribution of members across membership types and demographics.

2. **Improve clinic utilization**
   - Identify clinics with higher consultation volumes.
   - Use consultation activity to understand where demand is concentrated.

3. **Optimize specialist availability**
   - Identify specializations handling high consultation volumes.
   - Compare specialist availability and consultation fees.

4. **Strengthen revenue management**
   - Monitor total billing revenue and average bill value.
   - Analyze revenue contributions from consultation, laboratory and medicine services.

5. **Improve consultation services**
   - Analyze consultation modes and consultation status.
   - Use service-utilization patterns to support operational improvements.

---

## Dataset / Database Structure

The HealthPlus project uses a relational healthcare database containing information about members, consultations, clinics, specialists and billing.

### Main Tables

| Table | Purpose |
|---|---|
| `Members` | Member demographic, city and membership information |
| `Consultations` | Consultation records, consultation mode and status |
| `Clinics` | Clinic information and clinic-level service details |
| `Specialists` | Specialist information, specialization and consultation fees |
| `Billing` | Billing information used to analyze revenue and bill values |

The database is analyzed using SQL queries to understand healthcare utilization and financial performance.

---

## SQL Analysis

The SQL analysis focuses on the following business areas:

### Member Analysis
- Count members by membership type.
- Analyze members by gender.
- Analyze member distribution by city.
- Understand membership-type distribution.

### Consultation Analysis
- Count consultations by mode.
- Analyze consultation status.
- Identify specializations with more than 100 consultations.
- Analyze consultation volume across clinics.
- Identify the top 5 clinics by consultation volume.

### Specialist Analysis
- Count specialists.
- Compare specialists across specializations.
- Rank specialists based on consultation fees.
- Compare consultation fees within specializations.
- Use window functions such as `LAG()` and `LEAD()` to compare fee values.

### Billing / Revenue Analysis
- Calculate total billing revenue.
- Calculate average bill value.
- Analyze consultation revenue.
- Analyze laboratory revenue.
- Analyze medicine revenue.
- Identify billing ranges and revenue patterns.

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

Before performing the analysis, the HealthPlus tables were reviewed to understand their structure, fields and relationships.

The analysis included:

- Reviewing table structures.
- Identifying available columns and business attributes.
- Checking member, consultation, clinic, specialist and billing records.
- Reviewing distinct values for categorical fields.
- Validating relationships between related tables.
- Applying filters, joins and aggregations to produce business-level summaries.

The SQL queries were then used to transform the relational data into analysis-ready results.

---

## Key Metrics / Analysis Areas

The project evaluates several important healthcare metrics:

### Member Count
Measures the size of the HealthPlus member base.

### Membership Distribution
Shows how members are distributed across membership types.

### Consultation Volume
Measures consultation activity across modes, statuses, clinics and specializations.

### Clinic Performance
Identifies clinics with higher consultation volumes.

### Specialist Availability
Measures the number and distribution of specialists across specializations.

### Consultation Fee
Supports comparison of specialist consultation fees.

### Total Revenue
Measures the overall billing revenue generated.

### Average Bill Value
Provides an indication of the average value of a billing transaction.

### Service Revenue
Separates revenue contributions from consultation, laboratory and medicine services.

---

## Key Insights

Based on the SQL analysis:

### 1. Member demand varies by location and membership type

The analysis identifies cities and membership types with higher member concentration, providing a basis for service planning and targeted member engagement.

### 2. Consultation demand is concentrated in specific specializations

The analysis identifies specializations with more than 100 consultations, highlighting areas that may require closer attention to specialist availability and service capacity.

### 3. Clinic consultation volumes differ

The top 5 clinics by consultation volume provide an indication of where healthcare demand is concentrated.

### 4. Specialist consultation fees vary

Specialist rankings and within-specialization fee comparisons highlight differences in consultation pricing.

### 5. Revenue comes from multiple healthcare services

The billing analysis separates consultation, laboratory and medicine revenue, allowing HealthPlus to understand how different services contribute to total revenue.

### 6. Consultation utilization provides an operational indicator

Consultation mode and status analysis helps HealthPlus understand how members access services and how consultations are distributed across service outcomes.

---

## Recommendations / Conclusion

### Recommendations

Based on the analysis, HealthPlus should:

- Focus service capacity on cities and membership segments with higher member concentration.
- Monitor specializations with high consultation volumes and ensure adequate specialist availability.
- Review high-volume clinics for staffing and operational capacity.
- Monitor specialist consultation-fee variation across and within specializations.
- Track consultation, laboratory and medicine revenue separately to understand service-level contribution.
- Use consultation mode and status patterns to improve service delivery.
- Monitor average bill value together with total revenue to understand financial performance.
- Use member and consultation trends to support future clinic and specialist planning.

### Conclusion

The HealthPlus SQL analysis provides a structured view of member demand, consultation utilization, clinic performance, specialist availability and revenue contribution.

The analysis helps HealthPlus move beyond basic reporting by connecting **member demand → consultation activity → clinic utilization → specialist capacity → revenue performance**.

This provides a foundation for data-driven decisions related to healthcare service planning, specialist allocation and revenue management.

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
- Revenue analysis
- Business insight generation
- Data-driven recommendations

The final output is a SQL-based **HealthPlus Healthcare Database Analysis** designed to convert relational healthcare data into meaningful operational and financial insights and support data-driven healthcare decisions.
