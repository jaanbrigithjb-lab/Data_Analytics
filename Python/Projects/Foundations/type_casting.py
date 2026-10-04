# ---- 1. String to Integer ----
num_str = "100"
num_int = int(num_str)          # Convert "100" → 100
print("String:", num_str, "| Type:", type(num_str))
print("Integer:", num_int, "| Type:", type(num_int))

# ---- 2. Integer to String ----
age = 25
age_str = str(age)              # Convert 25 → "25"
print("Concatenation:", "I am " + age_str + " years old")

# ---- 3. String to Float ----
price_str = "99.99"
price_float = float(price_str)  # "99.99" → 99.99
print("Float:", price_float, "| Type:", type(price_float))

# ---- 4. Float to Integer (Decimal removed!) ----
pi = 3.14159
pi_int = int(pi)                # 3.14159 → 3 (NOT rounded)
print("Float to Int:", pi_int)  # 3

# ---- 5. Integer to Boolean ----
print("bool(0)  :", bool(0))    # False (0 is falsy)
print("bool(1)  :", bool(1))    # True
print("bool(-5) :", bool(-5))   # True (any non-zero is True)

# ---- 6. String to Boolean ----
print("bool('')     :", bool(""))       # False (empty string)
print("bool('Hi')   :", bool("Hi"))     # True
print("bool('False'):", bool("False"))  # True (non-empty string!)

# ---- 7. List ↔ Tuple ↔ Set ----
my_list = [1, 2, 2, 3, 3, 3]
print("List to Tuple:", tuple(my_list))   # (1,2,2,3,3,3)
print("List to Set  :", set(my_list))     # {1,2,3}
print("Set to List  :", list({1, 2, 3}))  # [1,2,3]