# ---- Create Set ----
numbers = {1, 2, 3, 3, 2, 1}
print("Set:", numbers)   # {1, 2, 3} - duplicates removed

# ---- Add / Remove ----
fruits = {"apple", "banana"}
fruits.add("cherry")
print("After add:", fruits)
fruits.remove("banana")
print("After remove:", fruits)

# ---- Set Operations ----
A = {1, 2, 3, 4}
B = {3, 4, 5, 6}
print("Union       :", A | B)          # {1,2,3,4,5,6}
print("Intersection:", A & B)          # {3,4}
print("Difference  :", A - B)          # {1,2}
print("Sym Diff    :", A ^ B)          # {1,2,5,6}

# ---- Find Unique Visitors ----
print("\n--- UNIQUE VISITORS TODAY ---")
visitors = ["Rahul", "Priya", "Rahul", "Amit", "Priya", "Rahul"]
unique = set(visitors)
print("All entries:", len(visitors))     # 6
print("Unique users:", len(unique))      # 3
print("Unique list:", unique)