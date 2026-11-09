student = {
    "name": "Rahul",
    "age": 20,
    "marks": 85
}
print("Dict:", student)

# ---- Access by Key ----
print("Name:", student["name"])          # Rahul
print("Age:", student.get("age"))        # 20 (safer method)

# ---- Add / Update ----
student["city"] = "Mumbai"               # Add new key
student["marks"] = 90                    # Update existing
print("After update:", student)

# ---- Remove ----
del student["city"]
print("After delete:", student)

# ---- Loop through ----
print("\n--- Looping ---")
for key, value in student.items():
    print(f"{key} → {value}")

print("\nKeys:", list(student.keys()))
print("Values:", list(student.values()))