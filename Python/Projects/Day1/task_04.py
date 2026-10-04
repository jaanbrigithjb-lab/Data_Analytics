# Student marks
maths_marks = 85
science_marks = 78
english_marks = 90

# 1. Total marks of three subjects
total_marks = maths_marks + science_marks + english_marks
print("Total marks:", total_marks)

# 2. Average marks
average_marks = total_marks / 3
print("Average marks:", average_marks)

# 3. Remaining fee
total_fee = 50000
paid_fee = 30000
remaining_fee = total_fee - paid_fee
print("Remaining fee:", remaining_fee)

# 4. Compare two marks
is_maths_higher = maths_marks > science_marks
print("Is Maths mark higher than Science mark?", is_maths_higher)

# 5. Check two conditions together
is_eligible = maths_marks >= 50 and science_marks >= 50
print("Is the student eligible?", is_eligible)

# 6. Update a value
attendance_days = 20
attendance_days += 1
print("Updated attendance days:", attendance_days)