# ---- 1. Basic Nested Loop ----
for i in range(1, 4):           # i = 1, 2, 3
    for j in range(1, 4):       # j = 1, 2, 3
        print(f"({i},{j})", end=" ")
    print()                     # newline after inner loop
# Output:
# (1,1) (1,2) (1,3)
# (2,1) (2,2) (2,3)
# (3,1) (3,2) (3,3)

# ---- 2. Star Pattern (Right Triangle) ----
print("\n--- STAR PATTERN ---")
for i in range(1, 6):           # rows 1 to 5
    for j in range(i):          # print i stars
        print("*", end=" ")
    print()
# Output:
# *
# * *
# * * *
# * * * *
# * * * * *

# ---- 3. Number Pyramid ----
print("\n--- NUMBER PYRAMID ---")
for i in range(1, 5):
    for j in range(1, i + 1):
        print(j, end=" ")
    print()
# Output:
# 1
# 1 2
# 1 2 3
# 1 2 3 4

# ---- 4. Inverted Triangle ----
print("\n--- INVERTED TRIANGLE ---")
rows = 5
for i in range(rows, 0, -1):    # 5, 4, 3, 2, 1
    for j in range(i):
        print("*", end=" ")
    print()

# ---- 5. Nested Loop with break ----
print("\n--- BREAK IN NESTED LOOP ---")
for i in range(1, 4):
    for j in range(1, 4):
        if i * j == 6:
            print(f"Found at ({i},{j})")
            break                # breaks only inner loop

# ---- Movie Seating Chart ----
print("\n--- MOVIE SEATING CHART ---")
rows = 4
cols = 5
for r in range(1, rows + 1):
    for c in range(1, cols + 1):
        seat = f"R{r}C{c}"
        print(f"{seat:6}", end=" ")
    print()