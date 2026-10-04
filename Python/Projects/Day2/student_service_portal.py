id=int(input("Enter student ID: "))
name=input("Enter student name: ")

print("\n----- Student Details -----")
print("Student ID:",id)
print("Student Name:",name)

while True:
    print("\n---- Welcome to Student Service Portal ----")
    print("1. Check Attendance")
    print("2. Check Result & Grade ")
    print("3. Select Department")
    print("4. Exit")

    choice=int(input("Enter your choice: "))
    if choice==1:
        attendance = float(input("Enter attendance percentage: "))

        if attendance<0 or attendance>100:
            print("Invalid attendance percentage. Please enter a value between 0 and 100")
        elif attendance>=75:
            print("Eligible for exam")
        else:
            print("Not eligible for exam")

    elif choice==2:
        marks = float(input("Enter marks: "))
        if marks < 0 or marks > 100:
            print("Invalid marks. Marks must be between 0 and 100")
        else:
            if marks >= 40:
                print("Result: Pass")
            else:
                print("Result: Fail")

        if marks >= 90:
            grade = "A"
        elif marks >= 80:
            grade = "B"
        elif marks >= 70:
            grade = "C"
        elif marks >= 60:
            grade = "D"
        elif marks >= 50:
            grade = "E"
        else:
            grade = "F"

        print("Grade:", grade)

    elif choice==3:
        print("\n ---- Departments ----")
        print("1. CSE - Computer Science & Engineering")
        print("2. IT - Information Technology")
        print("3. AI&DS - Artificial Intelligence & Data Science")
        print("4. ECE - Electronics & Communication Engineering")
        print("5. BBA - Business Administration")

        dept_choice=int(input("Enter your department choice: "))
        match dept_choice:
            case 1:
                print("You have selected CSE - Computer Science & Engineering")
            case 2:
                print("You have selected IT - Information Technology")
            case 3:
                print("You have selected AI&DS - Artificial Intelligence & Data Science")
            case 4:
                print("You have selected ECE - Electronics & Communication Engineering")
            case 5:
                print("You have selected BBA - Business Administration")
            case _:
                print("Invalid department choice. Please select a valid option.")

    elif choice==4:
        print("Thank you for using the Student Service Portal")
        break
    else:
        print("Invalid service choice. Please select 1, 2, 3, or 4.")
        continue