# ---- Create a List ----
fruits = ["apple", "banana", "cherry"]
print("List:", fruits)
print("Type:", type(fruits))

# ---- Access Items (Index) ----
print("First:", fruits[0])     # apple
print("Last:", fruits[-1])     # cherry

# ---- Slicing ----
numbers = [10, 20, 30, 40, 50]
print("First 3:", numbers[0:3])   # [10, 20, 30]
print("Last 2:", numbers[-2:])    # [40, 50]

# ---- Modify (Lists are MUTABLE) ----
fruits[1] = "mango"
print("After change:", fruits)    # ['apple', 'mango', 'cherry']

# ---- Add Items ----
fruits.append("orange")           # Add at end
print("After append:", fruits)
fruits.insert(1, "grape")         # Insert at index 1
print("After insert:", fruits)

# ---- Remove Items ----
fruits.remove("mango")            # Remove by value
print("After remove:", fruits)
last = fruits.pop()               # Remove and return last
print("Popped:", last)
print("Remaining:", fruits)

# ---- Useful Methods ----
nums = [3, 1, 4, 1, 5]
print("Length:", len(nums))
print("Max:", max(nums))
print("Min:", min(nums))
print("Sum:", sum(nums))
print("Sorted:", sorted(nums))
nums.sort()                       # sorts in place
print("After sort:", nums)
nums.reverse()                    # reverses in place
print("After reverse:", nums)

# ---- Loop through List ----
print("\n--- Looping ---")
for fruit in fruits:
    print("Fruit:", fruit)

# ---- Student Marks ----
print("\n--- STUDENT MARKS ---")
marks = [85, 92, 78, 90, 88]
print("All marks:", marks)
print("Highest:", max(marks))
print("Lowest:", min(marks))
print("Average:", sum(marks) / len(marks))
print("Above 85:", [m for m in marks if m > 85])