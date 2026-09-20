"""
============================================================
             STUDENT REGISTRATION SYSTEM
============================================================

HOW IT WORKS (simple explanation):

1. ONE student record  ->  a DICTIONARY, like:
        {
            "id": "S001",
            "name": "Ravi",
            "department": "CSE",
            "year": 2,
            "email": "ravi@college.edu",
            "phone": "9876543210",
            "attendance": 88.5,
            "marks": {"Maths": 80, "Physics": 65}
        }

2. MANY student records  ->  a DICTIONARY OF DICTIONARIES:
        {
            "S001": { ...student 1 details... },
            "S002": { ...student 2 details... }
        }
   The KEY is the student ID. The VALUE is the student dictionary.

3. "Academic status" is NOT stored inside the student dictionary.
   We CALCULATE it with a function whenever we need it.

Run:  python student_registration.py
============================================================
"""

# ================================================================
# GLOBAL STORAGE
# ================================================================
# This one dictionary holds ALL students.
students = {}          # { student_id : student_dictionary }


# ================================================================
# CALCULATED VALUES
# ================================================================
def get_average(student):
    """Return the average mark of one student."""
    marks = student["marks"]
    if len(marks) == 0:
        return 0
    return sum(marks.values()) / len(marks)


def get_academic_status(student):
    """Return the academic status of one student (calculated, not stored)."""
    if len(student["marks"]) == 0:
        return "Not evaluated"

    if student["attendance"] < 75:
        return "Detained (low attendance)"

    avg = get_average(student)

    if avg >= 75:
        return "Distinction"
    elif avg >= 60:
        return "First class"
    elif avg >= 50:
        return "Second class"
    elif avg >= 40:
        return "Pass"
    else:
        return "Fail"


# ================================================================
# PRINTING ONE STUDENT
# ================================================================
def show_student(student):
    """Print full details of one student dictionary."""
    print("  Student ID      :", student["id"])
    print("  Name            :", student["name"])
    print("  Department      :", student["department"])
    print("  Year            :", student["year"])
    print("  Email           :", student["email"])
    print("  Phone           :", student["phone"])
    print("  Attendance      :", student["attendance"], "%")

    if len(student["marks"]) == 0:
        print("  Marks           : -")
    else:
        for subject in student["marks"]:
            print("  Mark -", subject, ":", student["marks"][subject])

    print("  Average         :", round(get_average(student), 2))
    print("  Academic status :", get_academic_status(student))


def show_student_one_line(student):
    """Print one student in a single short line (for tables)."""
    line = student["id"].ljust(8)
    line = line + student["name"].ljust(20)
    line = line + student["department"].ljust(14)
    line = line + ("Year " + str(student["year"])).ljust(8)
    line = line + ("Att " + str(student["attendance"]) + "%").ljust(12)
    line = line + ("Avg " + str(round(get_average(student), 1))).ljust(10)
    line = line + get_academic_status(student)
    print(line)


# ================================================================
# INPUT HELPERS (ask the user and check the answer)
# ================================================================
def ask_text(message):
    while True:
        answer = input(message).strip()
        if answer != "":
            return answer
        print("  ! Please type something.")


def ask_number(message, low, high):
    while True:
        answer = input(message).strip()
        try:
            number = float(answer)
        except:
            print("  ! Please type a number.")
            continue
        if number < low or number > high:
            print("  ! Number must be between", low, "and", high)
            continue
        return number


def ask_integer(message, low, high):
    while True:
        answer = input(message).strip()
        try:
            number = int(answer)
        except:
            print("  ! Please type a whole number.")
            continue
        if number < low or number > high:
            print("  ! Number must be between", low, "and", high)
            continue
        return number


def ask_email(message):
    while True:
        answer = input(message).strip()
        if "@" in answer and "." in answer and " " not in answer:
            return answer
        print("  ! Please type a valid email like name@college.edu")


def ask_phone(message):
    while True:
        answer = input(message).strip()
        answer = answer.replace(" ", "").replace("-", "")
        if answer.isdigit() and 7 <= len(answer) <= 15:
            return answer
        print("  ! Please type a phone number with 7 to 15 digits.")


def ask_marks():
    """Ask for subject + mark pairs, return a dictionary."""
    marks = {}
    print("  Enter subject and mark. Leave subject empty to stop.")
    while True:
        subject = input("    Subject : ").strip()
        if subject == "":
            break
        mark = ask_number("    Mark for " + subject + " (0-100): ", 0, 100)
        marks[subject] = mark
    return marks


# ================================================================
# CREATE ONE STUDENT DICTIONARY
# ================================================================
def create_student(new_id=None):
    """Ask the user for details and RETURN one student dictionary."""
    print("\n--- Enter student details ---")

    # --- Student ID ---
    if new_id is None:
        while True:
            new_id = input("Student ID       : ").strip()
            if new_id == "":
                print("  ! Student ID cannot be empty.")
            elif new_id in students:
                print("  ! This ID is already used.")
            else:
                break

    # --- Other fields ---
    name = ask_text("Name             : ")
    department = ask_text("Department       : ")
    year = ask_integer("Year (1-6)       : ", 1, 6)
    email = ask_email("Email            : ")
    phone = ask_phone("Phone number     : ")
    attendance = ask_number("Attendance (%)   : ", 0, 100)
    marks = ask_marks()

    # --- Build the dictionary ---
    student = {
        "id": new_id,
        "name": name,
        "department": department,
        "year": year,
        "email": email,
        "phone": phone,
        "attendance": attendance,
        "marks": marks
    }
    return student


# ================================================================
# MENU ACTIONS
# ================================================================
def add_one_student():
    student = create_student()
    students[student["id"]] = student
    print("\n  Student", student["name"], "added successfully.")


def show_all_students():
    if len(students) == 0:
        print("\n  No students yet.")
        return

    print("\n--- All Students ---")
    for student_id in students:
        show_student_one_line(students[student_id])


def search_student():
    search_id = input("\nEnter Student ID to search: ").strip()
    if search_id in students:
        print("\n--- Student Found ---")
        show_student(students[search_id])
    else:
        print("  ! No student found with ID", search_id)


def update_student():
    search_id = input("\nEnter Student ID to update: ").strip()
    if search_id not in students:
        print("  ! No student found with ID", search_id)
        return

    student = students[search_id]

    print("\nCurrent record:")
    show_student(student)

    while True:
        print("\nWhat to update?")
        print("  1. Name        2. Department   3. Year")
        print("  4. Email       5. Phone        6. Attendance")
        print("  7. Add mark    8. Finish")
        choice = input("Choice: ").strip()

        if choice == "1":
            student["name"] = ask_text("New name         : ")
        elif choice == "2":
            student["department"] = ask_text("New department   : ")
        elif choice == "3":
            student["year"] = ask_integer("New year (1-6)   : ", 1, 6)
        elif choice == "4":
            student["email"] = ask_email("New email        : ")
        elif choice == "5":
            student["phone"] = ask_phone("New phone        : ")
        elif choice == "6":
            student["attendance"] = ask_number("New attendance % : ", 0, 100)
        elif choice == "7":
            subject = ask_text("Subject          : ")
            student["marks"][subject] = ask_number("Mark (0-100)     : ", 0, 100)
        elif choice == "8":
            break
        else:
            print("  ! Wrong choice.")
            continue

        print("  Updated. (Status will recalculate automatically.)")

    print("\nFinal record:")
    show_student(student)


def delete_student():
    search_id = input("\nEnter Student ID to delete: ").strip()
    if search_id in students:
        removed = students.pop(search_id)
        print("  Deleted", removed["name"], "(", search_id, ")")
    else:
        print("  ! No student found with ID", search_id)


def add_many_students():
    total = ask_integer("\nHow many students? ", 1, 100)
    added = 0

    for i in range(1, total + 1):
        print("\n===== Student", i, "of", total, "=====")
        student = create_student()
        students[student["id"]] = student
        added = added + 1
        print("  Added:", student["name"])

    print("\n", added, "of", total, "students added.")
    print("  Total records now:", len(students))


def class_report():
    if len(students) == 0:
        print("\n  No students to report.")
        return

    print("\n--- Class Report ---")
    for student_id in students:
        show_student_one_line(students[student_id])

    total_avg = 0
    count_with_marks = 0
    total_att = 0
    passed = 0

    for student_id in students:
        student = students[student_id]

        if len(student["marks"]) > 0:
            total_avg = total_avg + get_average(student)
            count_with_marks = count_with_marks + 1

        total_att = total_att + student["attendance"]

        status = get_academic_status(student)
        if status in ("Distinction", "First class", "Second class", "Pass"):
            passed = passed + 1

    print("-" * 90)
    if count_with_marks > 0:
        print("  Class average mark :", round(total_avg / count_with_marks, 2))
    print("  Average attendance :", round(total_att / len(students), 2), "%")
    print("  Passed             :", passed, "out of", len(students))


# ================================================================
# MAIN MENU
# ================================================================
def main():
    while True:
        print("""
============================================================
              STUDENT REGISTRATION SYSTEM
============================================================
  1. Add a new student
  2. Show all students
  3. Search for a student
  4. Update student information
  5. Delete a student
  6. Add many students at once
  7. Class report
  8. Exit
============================================================""")

        choice = input("Choose (1-8): ").strip()

        if choice == "1":
            add_one_student()
        elif choice == "2":
            show_all_students()
        elif choice == "3":
            search_student()
        elif choice == "4":
            update_student()
        elif choice == "5":
            delete_student()
        elif choice == "6":
            add_many_students()
        elif choice == "7":
            class_report()
        elif choice == "8":
            print("\nGoodbye! Total records:", len(students))
            break
        else:
            print("  ! Please choose 1 to 8.")


# ================================================================
# START THE PROGRAM
# ================================================================
if __name__ == "__main__":
    main()