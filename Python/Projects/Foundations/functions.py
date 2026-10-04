# ---- 1. Simple Function ----
def greet():
    print("Hello, Welcome!")

greet()   # Call the function
greet()   # Can call multiple times

# ---- 2. Function with Parameters ----
def greet_user(name):
    print(f"Hello, {name}!")

greet_user("Rahul")
greet_user("Priya")

# ---- 3. Function with Return ----
def add(a, b):
    return a + b

result = add(10, 20)
print("Sum:", result)

# ---- 4. Default Parameter ----
def greet_with_title(name, title="Mr."):
    print(f"Hello, {title} {name}")

greet_with_title("Rahul")             # Uses default "Mr."
greet_with_title("Priya", "Ms.")      # Overrides default

# ---- 5. Multiple Return Values ----
def min_max(numbers):
    return min(numbers), max(numbers)

low, high = min_max([5, 2, 8, 1, 9])
print(f"Low={low}, High={high}")

# ---- 6. *args (variable arguments) ----
def total(*numbers):
    return sum(numbers)

print("Total:", total(1, 2, 3, 4, 5))   # 15

# ---- 7. **kwargs (keyword arguments) ----
def show_info(**details):
    for key, value in details.items():
        print(f"{key}: {value}")

show_info(name="Rahul", age=20, city="Mumbai")