#====================================================================================================================================================================================================
# Data Profiling
#===========================================================================================================================================================================================================
# 1. Members - gender is in different format
SELECT distinct gender from Members;

# 2. Members - email has blanks
SELECT * from Members where email is null;

# 3. Members - emails are in different formats
SELECT * from Members where email not like '%@%.%';

# 4. Claims - consultation_id is blank
SELECT * from Claims where consultation_id is null;

# 5. Claims - insurance_provider is blank
SELECT * from Claims where insurance_provider is null;

# 6. Billing - consultation_id is blank
SELECT * from Billing where consultation_id is null;

# 7. Payments - Payment_mode is blank
SELECT * FROM Payments where payment_mode is null;