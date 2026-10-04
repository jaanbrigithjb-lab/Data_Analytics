# ---- 1. Arithmetic Operators ----
a = 10
b = 3
print("a + b =", a + b)   # Addition → 13
print("a - b =", a - b)   # Subtraction → 7
print("a * b =", a * b)   # Multiplication → 30
print("a / b =", a / b)   # Division → 3.333
print("a // b =", a // b) # Floor division → 3 (removes decimal)
print("a % b =", a % b)   # Modulus (remainder) → 1
print("a ** b =", a ** b) # Power → 1000 (10³)

# ---- 2. Comparison Operators (returns True/False) ----
print("\n--- Comparison ---")
print("a == b:", a == b)  # Equal? → False
print("a != b:", a != b)  # Not equal? → True
print("a > b:", a > b)    # Greater? → True
print("a < b:", a < b)    # Less? → False
print("a >= b:", a >= b)  # Greater or equal? → True
print("a <= b:", a <= b)  # Less or equal? → False

# ---- 3. Logical Operators ----
print("\n--- Logical ---")
x = True
y = False
print("x and y:", x and y)  # Both True? → False
print("x or y:", x or y)    # At least one True? → True
print("not x:", not x)      # Opposite → False

# ---- 4. Assignment Operators ----
print("\n--- Assignment ---")
num = 10
num += 5   # Same as num = num + 5
print("After += 5:", num)   # 15
num -= 3   # Same as num = num - 3
print("After -= 3:", num)   # 12
num *= 2   # Same as num = num * 2
print("After *= 2:", num)   # 24