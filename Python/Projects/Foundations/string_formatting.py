name = "Rahul"
age = 25
salary = 55000.4567

# ---- 1. f-string (Most Modern — Python 3.6+) ----
print(f"Name: {name}, Age: {age}")
# You can run expressions inside {}
print(f"Next year age: {age + 1}")
print(f"Name in UPPER: {name.upper()}")

# ---- 2. Format Numbers inside f-string ----
print(f"Salary: ₹{salary:.2f}")           # 2 decimal places
print(f"Salary: ₹{salary:,.2f}")         # comma separator
print(f"Salary: ₹{salary:>15,.2f}")      # right align width 15
print(f"Salary: ₹{salary:<15,.2f}|")     # left align width 15
print(f"Salary: ₹{salary:^15,.2f}|")     # center align

# ---- 3. Percentage formatting ----
ratio = 0.8567
print(f"Ratio: {ratio:.2%}")             # 85.67%

# ---- 4. Padding with zeros ----
id_num = 42
print(f"ID: {id_num:05d}")               # 00042

# ---- 5. format() method (older way) ----
print("Hello {}, you are {} years old".format(name, age))
print("Hello {n}, you are {a} years old".format(n=name, a=age))

# ---- 6. % formatting (oldest — rarely used) ----
print("Hello %s, you are %d years old" % (name, age))

# ---- 7. Multi-line f-string ----
message = f"""
========== RECEIPT ==========
Customer : {name}
Age      : {age}
Salary   : ₹{salary:,.2f}
=============================
"""
print(message)

# ---- Invoice Printing ----
print("\n--- INVOICE ---")
items = [
    ("Laptop",  1, 55000.00),
    ("Mouse",   2,   800.50),
    ("Keyboard",1,  1500.75)
]

print(f"{'Item':<12}{'Qty':>5}{'Price':>12}{'Total':>14}")
print("-" * 43)
grand_total = 0
for item, qty, price in items:
    line_total = qty * price
    grand_total += line_total
    print(f"{item:<12}{qty:>8}{price:>12,.2f}{line_total:>14,.2f}")
print("-" * 43)
print(f"{'Grand Total':<29}{grand_total:>14,.2f}")