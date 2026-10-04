# ---- Example 1: Simple if ----
age = 20
if age >= 18:
    # Indentation (4 spaces) is REQUIRED in Python
    print("You can vote!")
# Output: You can vote!

# ---- Example 2: if-else ----
marks = 35
if marks >= 40:
    print("Pass")
else:
    print("Fail")
# Output: Fail

# ---- Example 3: if-elif-else (multiple conditions) ----
score = 85
if score >= 90:
    grade = "A+"
elif score >= 80:      # Only checked if first is False
    grade = "A"
elif score >= 70:
    grade = "B"
elif score >= 60:
    grade = "C"
else:
    grade = "F"
print("Grade:", grade)
# Output: Grade: A

# ---- Example 4: Nested if ----
username = "admin"
password = "1234"
if username == "admin":
    if password == "1234":
        print("Login Successful")
    else:
        print("Wrong Password")
else:
    print("Invalid User")
# Output: Login Successful