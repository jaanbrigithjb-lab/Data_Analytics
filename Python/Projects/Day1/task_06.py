# Student information
student_name = "Kevin Levan"
student_id = "Ben101"
department = "Computer Application"
age = 25
java_marks = 85
python_marks = 90
attendance = 88.5

# 1. Calculate total marks
total_marks = java_marks + python_marks

# 2. Calculate average marks
average_marks = total_marks / 2

# 3. Calculate remaining marks
remaining_marks = 200 - total_marks

# 4. Comparison operator
is_passed = average_marks >= 50

# 5. Logical operator
is_eligible = average_marks >= 50 and attendance >= 75

# 6. Type casting
age_as_string = str(age)

# Display student profile
print("----- Nova University Student Profile -----")
print("Student Name:", student_name)
print("Student ID:", student_id)
print("Department:", department)
print("Age:", age)
print("Age as String:", age_as_string)
print("Maths Marks:", java_marks)
print("Python Marks:", python_marks)
print("Total Marks:", total_marks)
print("Average Marks:", average_marks)
print("Remaining Marks:", remaining_marks)
print("Attendance:", attendance)
print("Passed:", is_passed)
print("Eligible:", is_eligible)