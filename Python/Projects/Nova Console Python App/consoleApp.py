students = {}
dept = {
    "CSE": "Computer Science & Engineering",
    "IT": "Information Technology",
    "AI&DS": "Artificial Intelligence & Data Science",
    "ECE": "Electronics & Communication Engineering",
    "BBA": "Business Administration"
}
course = {"Python", "Excel", "SQL", "Power BI"}
SUBJECTS = ["Python", "SQL", "Excel", "Power BI"]


def read_int(prompt, minimum=None, maximum=None):
    """Read and validate an integer without terminating the application."""
    while True:
        try:
            value = int(input(prompt))
            if minimum is not None and value < minimum:
                print(f"Value must be at least {minimum}.")
                continue
            if maximum is not None and value > maximum:
                print(f"Value must not exceed {maximum}.")
                continue
            return value
        except ValueError:
            print("Please enter a valid whole number.")


def read_float(prompt, minimum=None, maximum=None):
    """Read and validate a decimal number without terminating the application."""
    while True:
        try:
            value = float(input(prompt))
            if minimum is not None and value < minimum:
                print(f"Value must be at least {minimum}.")
                continue
            if maximum is not None and value > maximum:
                print(f"Value must not exceed {maximum}.")
                continue
            return value
        except ValueError:
            print("Please enter a valid number.")


def read_phone():
    """Read a valid ten-digit phone number."""
    while True:
        phone = input("Enter your phone number: ").strip()
        if phone.isdigit() and len(phone) == 10:
            return phone
        print("Enter a valid 10-digit phone number.")


def choose_department():
    """Display departments and return the selected department code."""
    dept_codes = list(dept.keys())
    print("\nChoose your department:")
    for index, code in enumerate(dept_codes, start=1):
        print(f"{index}. {code} - {dept[code]}")

    choice = read_int("Enter your department choice: ", 1, len(dept_codes))
    return dept_codes[choice - 1]


def read_marks():
    """Collect marks for all subjects with validation."""
    marks_dict = {}
    for subject in SUBJECTS:
        marks_dict[subject] = read_int(
            f"Enter marks for {subject}: ", 0, 100
        )
    return marks_dict


def calculate_total(marks_dict):
    """Return total marks."""
    return sum(marks_dict.values())


def calculate_average(marks_dict):
    """Return average marks."""
    if not marks_dict:
        return 0
    return calculate_total(marks_dict) / len(marks_dict)


def is_passed(marks_dict):
    """Return True when every subject mark is at least 50."""
    return bool(marks_dict) and all(mark >= 50 for mark in marks_dict.values())


def calculate_grade(average):
    """Return the grade based on the BRD grading scale."""
    if average >= 90:
        return "A"
    if average >= 80:
        return "B"
    if average >= 70:
        return "C"
    if average >= 60:
        return "D"
    if average >= 50:
        return "E"
    return "F"


def is_active(student):
    return student.get("status", "Active") == "Active"


def student_reg():
    """Register a new student and prevent duplicate Student IDs."""
    s_id = input("Enter your student ID: ").strip()

    if not s_id:
        print("Student ID cannot be empty.")
        return

    if s_id in students:
        print("Student ID already exists.")
        return

    s_name = input("Enter your name: ").strip()
    if not s_name:
        print("Name cannot be empty.")
        return

    s_dept = choose_department()
    s_year = read_int("Enter year (1-4): ", 1, 4)
    s_email = input("Enter your email address: ").strip()
    s_phno = read_phone()
    s_attendance = read_float(
        "Enter your attendance percentage (%): ", 0, 100
    )
    s_marks = read_marks()
    s_academic_status = input("Enter your academic status: ").strip()

    students[s_id] = {
        "name": s_name,
        "department": s_dept,
        "year": s_year,
        "email": s_email,
        "phone": s_phno,
        "attendance": s_attendance,
        "marks": s_marks,
        "academic_status": s_academic_status,
        "courses": set(),
        "status": "Active"
    }

    print("Student registered successfully!")


def display_student(s_id, student):
    """Display a complete student record."""
    print(f"\nStudent ID: {s_id}")
    print(f"Name: {student['name']}")
    print(f"Department: {student['department']} - "
          f"{dept.get(student['department'], 'Unknown')}")
    print(f"Year: {student['year']}")
    print(f"Email: {student['email']}")
    print(f"Phone number: {student['phone']}")
    print(f"Attendance (%): {student['attendance']}")
    print(f"Marks: {student['marks']}")
    print(f"Academic Status: {student['academic_status']}")
    print(f"Registered Courses: {sorted(student['courses'])}")
    print(f"Status: {student['status']}")


def student_search():
    """Search for a student by Student ID."""
    s_id = input("Enter your student ID: ").strip()

    if s_id in students:
        display_student(s_id, students[s_id])
    else:
        print("Student ID does not exist.")


def student_update():
    """Update editable information for an existing active student."""
    s_id = input("Enter Student ID to update: ").strip()

    if s_id not in students:
        print("Student ID does not exist.")
        return

    student = students[s_id]

    if not is_active(student):
        print("Withdrawn students cannot be updated.")
        return

    while True:
        print("\n----- Update Student Information -----")
        print("1. Name")
        print("2. Department")
        print("3. Year")
        print("4. Email")
        print("5. Phone")
        print("6. Academic Status")
        print("7. Display Updated Record")
        print("8. Finish Update")

        choice = read_int("Enter your choice: ", 1, 8)

        if choice == 1:
            name = input("Enter new name: ").strip()
            if name:
                student["name"] = name
                print("Name updated successfully.")
            else:
                print("Name cannot be empty.")

        elif choice == 2:
            student["department"] = choose_department()
            print("Department updated successfully.")

        elif choice == 3:
            student["year"] = read_int("Enter new year (1-4): ", 1, 4)
            print("Year updated successfully.")

        elif choice == 4:
            student["email"] = input("Enter new email: ").strip()
            print("Email updated successfully.")

        elif choice == 5:
            student["phone"] = read_phone()
            print("Phone updated successfully.")

        elif choice == 6:
            student["academic_status"] = input(
                "Enter new academic status: "
            ).strip()
            print("Academic status updated successfully.")

        elif choice == 7:
            display_student(s_id, student)

        elif choice == 8:
            print("Student update completed.")
            return


def course_reg():
    """Add, display, and withdraw courses using a set."""
    s_id = input("Enter your Student ID: ").strip()

    if s_id not in students:
        print("Student ID does not exist.")
        return

    if not is_active(students[s_id]):
        print("Withdrawn students cannot register for courses.")
        return

    registered_courses = students[s_id]["courses"]
    courses = sorted(course)

    while True:
        print("\n----- Course Registration -----")
        print("1. Add a course")
        print("2. Display registered courses")
        print("3. Withdraw a course")
        print("4. Finish")

        action = read_int("Enter your choice: ", 1, 4)

        if action == 1:
            for index, course_name in enumerate(courses, start=1):
                print(f"{index}. {course_name}")

            choice = read_int("Enter your course choice: ", 1, len(courses))
            selected = courses[choice - 1]

            if selected in registered_courses:
                print("Course already registered.")
            else:
                registered_courses.add(selected)
                print("Course registered successfully.")

        elif action == 2:
            if registered_courses:
                print("Registered courses:")
                for course_name in sorted(registered_courses):
                    print(course_name)
            else:
                print("No courses registered.")

        elif action == 3:
            if not registered_courses:
                print("No courses registered.")
                continue

            course_list = sorted(registered_courses)
            for index, course_name in enumerate(course_list, start=1):
                print(f"{index}. {course_name}")

            choice = read_int(
                "Enter course number to withdraw: ", 1, len(course_list)
            )
            removed = course_list[choice - 1]
            registered_courses.remove(removed)
            print(f"{removed} withdrawn successfully.")

        elif action == 4:
            return


def attendance():
    """Retrieve, update, and check attendance eligibility."""
    s_id = input("Enter your Student ID: ").strip()

    if s_id not in students:
        print("Student ID does not exist.")
        return

    if not is_active(students[s_id]):
        print("Withdrawn students cannot manage attendance.")
        return

    while True:
        print("\n----- Attendance Management -----")
        print("1. Display Attendance Percentage")
        print("2. Display Eligibility")
        print("3. Update Attendance")
        print("4. Finish")

        choice = read_int("Enter your choice: ", 1, 4)
        student = students[s_id]

        if choice == 1:
            print(f"Attendance: {student['attendance']}%")

        elif choice == 2:
            result = "Eligible" if student["attendance"] >= 75 else "Not Eligible"
            print(f"Exam Eligibility: {result}")

        elif choice == 3:
            updated = read_float(
                "Enter updated attendance percentage: ", 0, 100
            )
            student["attendance"] = updated
            print(f"Attendance updated to {updated}%.")

        elif choice == 4:
            return


def marks():
    """Retrieve, update, and summarize subject marks."""
    s_id = input("Enter your Student ID: ").strip()

    if s_id not in students:
        print("Student ID does not exist.")
        return

    if not is_active(students[s_id]):
        print("Withdrawn students cannot manage marks.")
        return

    student = students[s_id]
    marks_dict = student["marks"]

    while True:
        print("\n----- Marks Management -----")
        print("1. Retrieve Subject Mark")
        print("2. Update Marks")
        print("3. Calculate Total Marks")
        print("4. Calculate Average Marks")
        print("5. Identify Highest Mark")
        print("6. Identify Failed Subjects")
        print("7. Display Academic Summary")
        print("8. Finish")

        choice = read_int("Enter your choice: ", 1, 8)

        if choice == 1:
            subjects = list(marks_dict.keys())
            for index, subject in enumerate(subjects, start=1):
                print(f"{index}. {subject}")

            subject_choice = read_int(
                "Choose subject number: ", 1, len(subjects)
            )
            selected = subjects[subject_choice - 1]
            print(f"{selected}: {marks_dict[selected]}")

        elif choice == 2:
            subjects = list(marks_dict.keys())
            for index, subject in enumerate(subjects, start=1):
                print(f"{index}. {subject}")

            subject_choice = read_int(
                "Choose subject number: ", 1, len(subjects)
            )
            selected = subjects[subject_choice - 1]
            marks_dict[selected] = read_int(
                "Enter updated mark: ", 0, 100
            )
            print("Marks updated successfully.")

        elif choice == 3:
            print(f"Total Marks: {calculate_total(marks_dict)}")

        elif choice == 4:
            print(f"Average Marks: {calculate_average(marks_dict):.2f}")

        elif choice == 5:
            highest_subject = max(marks_dict, key=marks_dict.get)
            print(f"Highest Subject: {highest_subject}")
            print(f"Highest Mark: {marks_dict[highest_subject]}")

        elif choice == 6:
            failed = [
                subject for subject, mark in marks_dict.items()
                if mark < 50
            ]
            print("Failed Subjects:" if failed else "No failed subjects")
            for subject in failed:
                print(subject)

        elif choice == 7:
            print("\n----- Academic Summary -----")
            for subject, mark in marks_dict.items():
                print(f"{subject}: {mark}")

            print(f"Total Marks: {calculate_total(marks_dict)}")
            print(f"Average Marks: {calculate_average(marks_dict):.2f}")

            highest_subject = max(marks_dict, key=marks_dict.get)
            print(f"Highest Subject: {highest_subject} "
                  f"({marks_dict[highest_subject]})")

            failed = [
                subject for subject, mark in marks_dict.items()
                if mark < 50
            ]
            print("Failed Subjects:" if failed else "No failed subjects")
            for subject in failed:
                print(subject)

        elif choice == 8:
            return



def result():
    """Calculate and display examination results."""
    s_id = input("Enter your Student ID: ").strip()

    if s_id not in students:
        print("Student ID does not exist.")
        return

    if not is_active(students[s_id]):
        print("Withdrawn students are excluded from active processing.")
        return

    student = students[s_id]
    marks_dict = student["marks"]
    attendance_percentage = student["attendance"]

    while True:
        print("\n----- Examination Result -----")
        print("1. Calculate total marks")
        print("2. Calculate average marks")
        print("3. Determine Pass/Fail")
        print("4. Assign a grade")
        print("5. Check exam eligibility")
        print("6. Display complete result summary")
        print("7. Finish")

        choice = read_int("Enter your choice: ", 1, 7)
        total = calculate_total(marks_dict)
        average = calculate_average(marks_dict)
        passed = is_passed(marks_dict)
        grade = calculate_grade(average)
        eligibility = attendance_percentage >= 75

        if choice == 1:
            print(f"Total Marks: {total}")
        elif choice == 2:
            print(f"Average Marks: {average:.2f}")
        elif choice == 3:
            print(f"Result: {'PASS' if passed else 'FAIL'}")
        elif choice == 4:
            print(f"Grade: {grade}")
        elif choice == 5:
            print("Eligible for exam" if eligibility else "Not eligible for exam")
        elif choice == 6:
            print("\n----- Complete Result Summary -----")
            print(f"Student ID: {s_id}")
            print(f"Name: {student['name']}")
            for subject, mark in marks_dict.items():
                print(f"{subject}: {mark}")
            print(f"Total Marks: {total}")
            print(f"Average Marks: {average:.2f}")
            print(f"Grade: {grade}")
            print(f"Result: {'PASS' if passed else 'FAIL'}")
            print(f"Attendance: {attendance_percentage}%")
            print(f"Exam Eligibility: {'Eligible' if eligibility else 'Not Eligible'}")
        elif choice == 7:
            return




def dept_info():
    """Display department details and active-student information."""
    dept_codes = list(dept.keys())

    while True:
        print("\n----- Department Information -----")
        print("1. Display all departments")
        print("2. View a particular department")
        print("3. Count students in a department")
        print("4. Display students in a department")
        print("5. Finish")

        choice = read_int("Enter your choice: ", 1, 5)

        if choice == 5:
            return

        if choice == 1:
            for code, name in dept.items():
                print(f"{code} - {name}")

        elif choice in (2, 3, 4):
            for index, code in enumerate(dept_codes, start=1):
                print(f"{index}. {code} - {dept[code]}")

            dept_choice = read_int("Choose department number: ", 1, len(dept_codes))
            selected_code = dept_codes[dept_choice - 1]

            if choice == 2:
                print(f"Department Code: {selected_code}")
                print(f"Department Name: {dept[selected_code]}")

            elif choice == 3:
                count = sum(
                    1 for student in students.values()
                    if is_active(student) and student["department"] == selected_code
                )
                print(f"Department: {dept[selected_code]}")
                print(f"Number of Students: {count}")

            elif choice == 4:
                found = False
                print(f"\nStudents in {dept[selected_code]}:")

                for s_id, student in students.items():
                    if is_active(student) and student["department"] == selected_code:
                        print(f"Student ID: {s_id}")
                        print(f"Name: {student['name']}")
                        print(f"Year: {student['year']}")
                        print("-" * 30)
                        found = True

                if not found:
                    print("No active students registered in this department.")



def get_active_students():
    """Return active students only."""
    return {
        s_id: student for s_id, student in students.items()
        if is_active(student)
    }



def student_statistic():
    """Display statistics calculated only from active students."""
    while True:
        print("\n----- Student Statistics -----")
        print("1. Total Number of Students")
        print("2. Department-wise Student Count")
        print("3. Number of Eligible Students")
        print("4. Number of Failed Students")
        print("5. Highest Average")
        print("6. Lowest Average")
        print("7. Average Performance of Batch")
        print("8. Unique Departments Represented")
        print("9. Students Registered for a Course")
        print("10. Display Complete Statistics")
        print("11. Finish")

        choice = read_int("Enter your choice: ", 1, 11)

        if choice == 11:
            return

        active_students = get_active_students()

        if not active_students:
            print("No active students available.")
            continue

        student_averages = {
            s_id: calculate_average(student["marks"])
            for s_id, student in active_students.items()
        }

        if choice == 1:
            print(f"Total Students: {len(active_students)}")

        elif choice == 2:
            department_count = {code: 0 for code in dept}
            for student in active_students.values():
                department_count[student["department"]] += 1
            for code, count in department_count.items():
                print(f"{code}: {count}")

        elif choice == 3:
            count = sum(
                student["attendance"] >= 75
                for student in active_students.values()
            )
            print(f"Eligible Students: {count}")

        elif choice == 4:
            count = sum(
                not is_passed(student["marks"])
                for student in active_students.values()
            )
            print(f"Failed Students: {count}")

        elif choice == 5:
            s_id = max(student_averages, key=student_averages.get)
            print(f"Student ID: {s_id}")
            print(f"Name: {active_students[s_id]['name']}")
            print(f"Highest Average: {student_averages[s_id]:.2f}")

        elif choice == 6:
            s_id = min(student_averages, key=student_averages.get)
            print(f"Student ID: {s_id}")
            print(f"Name: {active_students[s_id]['name']}")
            print(f"Lowest Average: {student_averages[s_id]:.2f}")

        elif choice == 7:
            batch_average = sum(student_averages.values()) / len(student_averages)
            print(f"Batch Average Performance: {batch_average:.2f}")

        elif choice == 8:
            unique_departments = {
                student["department"] for student in active_students.values()
            }
            for code in sorted(unique_departments):
                print(f"{code} - {dept[code]}")
            print(f"Total Departments: {len(unique_departments)}")

        elif choice == 9:
            courses = sorted(course)
            for index, course_name in enumerate(courses, start=1):
                print(f"{index}. {course_name}")

            course_choice = read_int("Choose course number: ", 1, len(courses))
            selected_course = courses[course_choice - 1]
            found = False

            for s_id, student in active_students.items():
                if selected_course in student["courses"]:
                    print(f"Student ID: {s_id}")
                    print(f"Name: {student['name']}")
                    print("-" * 30)
                    found = True

            if not found:
                print("No active students registered for this course.")

        elif choice == 10:
            department_count = {code: 0 for code in dept}
            eligible_count = 0
            failed_count = 0
            unique_departments = set()

            for student in active_students.values():
                department_count[student["department"]] += 1
                unique_departments.add(student["department"])

                if student["attendance"] >= 75:
                    eligible_count += 1
                if not is_passed(student["marks"]):
                    failed_count += 1

            highest_id = max(student_averages, key=student_averages.get)
            lowest_id = min(student_averages, key=student_averages.get)
            batch_average = sum(student_averages.values()) / len(student_averages)

            print("\n----- Complete Student Statistics -----")
            print(f"Total Students: {len(active_students)}")
            print("\nDepartment-wise Student Count:")
            for code, count in department_count.items():
                print(f"{code}: {count}")

            print(f"Eligible Students: {eligible_count}")
            print(f"Failed Students: {failed_count}")
            print(f"Highest Average: {student_averages[highest_id]:.2f}")
            print(f"Highest Average Student ID: {highest_id}")
            print(f"Lowest Average: {student_averages[lowest_id]:.2f}")
            print(f"Lowest Average Student ID: {lowest_id}")
            print(f"Batch Average Performance: {batch_average:.2f}")

            print("\nUnique Departments Represented:")
            for code in sorted(unique_departments):
                print(f"{code} - {dept[code]}")
            print(f"Total Unique Departments: {len(unique_departments)}")



def process_all_students():
    """Generate an academic summary for every active student."""
    active_students = get_active_students()

    if not active_students:
        print("No active students available.")
        return

    for s_id, student in active_students.items():
        marks_dict = student["marks"]
        total = calculate_total(marks_dict)
        average = calculate_average(marks_dict)
        passed = is_passed(marks_dict)
        grade = calculate_grade(average)
        eligible = student["attendance"] >= 75

        print("\n" + "-" * 45)
        print(f"Student ID: {s_id}")
        print(f"Name: {student['name']}")
        print(f"Attendance: {student['attendance']}%")
        print(f"Eligibility: {'Eligible' if eligible else 'Not Eligible'}")
        print(f"Marks: {marks_dict}")
        print(f"Total: {total}")
        print(f"Average: {average:.2f}")
        print(f"Result: {'PASS' if passed else 'FAIL'}")
        print(f"Grade: {grade}")
        print("-" * 45)


def course_overlap_analysis():
    """Compare actual Python and SQL registration groups using sets."""
    python_group = {
        s_id for s_id, student in students.items()
        if is_active(student) and "Python" in student["courses"]
    }

    sql_group = {
        s_id for s_id, student in students.items()
        if is_active(student) and "SQL" in student["courses"]
    }

    print("\n----- Course Overlap Analysis -----")
    print(f"Python students: {sorted(python_group)}")
    print(f"SQL students: {sorted(sql_group)}")
    print(f"Students in both courses: {sorted(python_group & sql_group)}")
    print(f"Python but not SQL: {sorted(python_group - sql_group)}")
    print(f"Registered for at least one: {sorted(python_group | sql_group)}")
    print(f"Registered for exactly one: {sorted(python_group ^ sql_group)}")
    print(f"Groups are completely different: "
          f"{python_group.isdisjoint(sql_group)}")

    raw_ids = input(
        "\nEnter IDs to check for duplicates, separated by spaces: "
    ).split()
    duplicates_exist = len(raw_ids) != len(set(raw_ids))
    print(f"Duplicate Student IDs present: {duplicates_exist}")



def student_withdrawal():
    """Withdraw students repeatedly until the user selects Finish."""
    while True:
        print("\n----- Student Withdrawal -----")
        print("1. Withdraw Student")
        print("2. Finish")

        choice = read_int("Enter your choice: ", 1, 2)

        if choice == 2:
            return

        if not students:
            print("No students registered.")
            continue

        s_id = input("Enter Student ID to withdraw: ").strip()

        if s_id not in students:
            print("Student ID not found.")
            continue

        student = students[s_id]

        if not is_active(student):
            print("This student has already been withdrawn.")
            continue

        display_student(s_id, student)
        confirm = input(
            "\nAre you sure you want to withdraw this student? (yes/no): "
        ).strip().lower()

        if confirm == "yes":
            student["status"] = "Withdrawn"
            print("Student withdrawn successfully.")
            print("Student information has been preserved.")
        elif confirm == "no":
            print("Withdrawal cancelled.")
        else:
            print("Invalid confirmation. Please enter yes or no.")



def exit_():
    """Exit the application."""
    print("Thank you for using Nova University Student Management System.")
    raise SystemExit


def display_menu():
    """Display the main console menu and execute the selected service."""
    print("\n" + "*" * 60)
    print("Nova University - Student Management System")
    print("*" * 60)
    print("1. Student Registration")
    print("2. Student Search")
    print("3. Student Update")
    print("4. Course Registration")
    print("5. Attendance")
    print("6. Marks")
    print("7. Result")
    print("8. Department Information")
    print("9. Student Statistics")
    print("10. Student Withdrawal")
    print("11. Process All Active Students")
    print("12. Course Overlap Analysis")
    print("13. Exit")

    choice = read_int("Enter your choice: ", 1, 13)

    actions = {
        1: student_reg,
        2: student_search,
        3: student_update,
        4: course_reg,
        5: attendance,
        6: marks,
        7: result,
        8: dept_info,
        9: student_statistic,
        10: student_withdrawal,
        11: process_all_students,
        12: course_overlap_analysis,
        13: exit_
    }

    actions[choice]()


def main():
    """Keep the application running until the user selects Exit."""
    while True:
        display_menu()


if __name__ == "__main__":
    main()
