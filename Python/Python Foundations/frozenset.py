# ---- 1. Create Frozenset ----
fs = frozenset([1, 2, 3, 3, 2, 1])
print("Frozenset:", fs)
print("Type:", type(fs))

# ---- 2. Cannot Add/Remove (will error if uncommented) ----
# fs.add(4)      # ❌ AttributeError
# fs.remove(1)   # ❌ AttributeError

# ---- 3. Set Operations work ----
A = frozenset([1, 2, 3, 4])
B = frozenset([3, 4, 5, 6])
print("Union       :", A | B)
print("Intersection:", A & B)
print("Difference  :", A - B)
