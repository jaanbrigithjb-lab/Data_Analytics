text = "Python Programming"

# ---- 1. Length ----
print("Length:", len(text))   # 18 characters

# ---- 2. Indexing (position starts from 0) ----
print("First char:", text[0])   # P
print("Second char:", text[1])  # y
print("Last char:", text[-1])   # g

# ---- 3. Slicing [start:end] ----
print("First 6:", text[0:6])    # Python
print("From 7:", text[7:])      # Programming
print("Reverse:", text[::-1])   # gnimmargorP nohtyP

# ---- 4. Common Methods ----
print("Upper:", text.upper())       # PYTHON PROGRAMMING
print("Lower:", text.lower())       # python programming
print("Replace:", text.replace("Python", "Java"))  # Java Programming
print("Split:", text.split())       # ['Python', 'Programming']
print("Count 'g':", text.count("g"))  # 2

# ---- 5. Concatenation & Repetition ----
first = "Hello"
second = "World"
print(first + " " + second)   # Hello World
print("Hi " * 3)              # Hi Hi Hi

# ---- 6. f-Strings (Modern Way - Most Important!) ----
name = "Priya"
age = 20
print(f"My name is {name} and I am {age} years old.")
# Cleaner than: print("My name is " + name + " and I am " + str(age))

# ---- Email Validator ----
print("\n--- EMAIL CHECKER ---")
email = "user@example.com"
print("Has @ symbol:", "@" in email)         # True
print("Has .com:", email.endswith(".com"))   # True
print("Username:", email.split("@")[0])      # user