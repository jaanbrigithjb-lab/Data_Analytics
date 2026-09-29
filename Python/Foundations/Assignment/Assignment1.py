student_name = input("Enter Student Name: ")
age = int(input("Enter Age: "))
degree = input("Enter Degree: ")
percentage = float(input("Enter Percentage: "))


print("\nStudent Details")
print("Name:", student_name)
print("Age:", age)
print("Degree:", degree)
print("Percentage:", percentage)


if percentage >= 60:
    print("Admission Status: Eligible")
else:
    print("Admission Status: Not Eligible")

years_remaining = 30 - age

percentage_required = 100 - percentage

print("\nAdditional Information")
print("Years remaining to reach age 30:", years_remaining)
print("Percentage required to reach 100:", percentage_required)