# ---- Create Tuple ----
coordinates = (10, 20)
days = ("Mon", "Tue", "Wed", "Thu", "Fri")
print("Tuple:", coordinates)
print("Type:", type(coordinates))

# ---- Access ----
print("X:", coordinates[0])   # 10
print("Y:", coordinates[1])   # 20

# ---- Cannot Modify (uncommenting will error) ----
# coordinates[0] = 99  # ❌ TypeError

# ---- Unpacking ----
x, y = coordinates
print(f"x={x}, y={y}")   # x=10, y=20

# ---- Single Item Tuple needs comma ----
single = (5,)     # ✅ Tuple
not_tuple = (5)   # ❌ This is just integer 5
print(type(single), type(not_tuple))

# ---- Methods ----
numbers = (1, 2, 3, 2, 4, 2)
print("Count of 2:", numbers.count(2))    # 3
print("Index of 3:", numbers.index(3))    # 2
print("Length:", len(numbers))            # 6