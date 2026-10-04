# ---- Example 1: Simple Input ----
name = input("Enter your name: ")
# Program waits; user types "Rahul" and presses Enter
print("Hello,", name, "! Welcome to Python.")
# Output: Hello, Rahul ! Welcome to Python.

# ---- Example 2: Converting Input to Number ----
age = input("Enter your age: ")     # Returns "20" (string)
age = int(age)                      # Convert string to integer
print("Next year you will be", age + 1)
# If user typed 20, output: Next year you will be 21

# ---- Example 3: Direct Conversion ----
marks = float(input("Enter your marks: "))  # Convert on the spot
print("Your marks are:", marks)

# ---- Simple Calculator ----
print("\n--- SIMPLE CALCULATOR ---")
num1 = float(input("Enter first number : "))
num2 = float(input("Enter second number: "))

print("Addition       :", num1 + num2)
print("Subtraction    :", num1 - num2)
print("Multiplication :", num1 * num2)
print("Division       :", num1 / num2)