fruits = ["apple", "banana", "cherry"]

# OLD way (ugly)
print("Without enumerate:")
for i in range(len(fruits)):
    print(f"  {i}: {fruits[i]}")

# NEW way (clean!)
print("\nWith enumerate:")
for index, fruit in enumerate(fruits):
    print(f"  {index}: {fruit}")

# Start from custom index
print("\nStart from 1:")
for index, fruit in enumerate(fruits, start=1):
    print(f"  {index}. {fruit}")

# ---- 2. zip() — combine multiple iterables ----
names = ["Rahul", "Priya", "Amit"]
marks = [85, 92, 78]
cities = ["Mumbai", "Delhi", "Pune"]

print("\n--- ZIP EXAMPLE ---")
for name, mark, city in zip(names, marks, cities):
    print(f"{name:8} | {mark} | {city}")

# ---- 3. zip() into dictionary ----
student_dict = dict(zip(names, marks))
print("\nAs dictionary:", student_dict)

# ---- 4. Unzip (transpose) ----
pairs = [(1, 'a',True), (2, 'b',False), (3, 'c',True)]
numbers, letters,boolean = zip(*pairs)
print("\nNumbers:", numbers)
print("Letters:", letters)
print("Booleans:", boolean)