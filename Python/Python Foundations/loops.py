# ---- 1. for loop with range() ----
# range(5) gives 0,1,2,3,4
for i in range(5):
    print("Number:", i)
# Output: 0 1 2 3 4

# ---- 2. range(start, end) ----
for i in range(1, 6):    # 1 to 5 (end excluded)
    print(i, end=" ")    # end=" " keeps on same line
print()                  # new line
# Output: 1 2 3 4 5

# ---- 3. range(start, end, step) ----
for i in range(0, 10, 2):   # 0,2,4,6,8
    print(i, end=" ")
print()
# Output: 0 2 4 6 8

# ---- 4. Loop through string ----
for ch in "Python":
    print(ch, end="-")
print()
# Output: P-y-t-h-o-n-

# ---- 5. while loop ----
count = 1
while count <= 5:
    print("Count:", count)
    count += 1     # IMPORTANT: increment, else infinite loop
# Output: 1 2 3 4 5

# ---- 6. break and continue ----
print("\n--- break example ---")
for i in range(10):
    if i == 5:
        break        # Exits the loop completely
    print(i, end=" ")
print()
# Output: 0 1 2 3 4

print("--- continue example ---")
for i in range(5):
    if i == 2:
        continue     # Skips rest for this iteration
    print(i, end=" ")
print()
# Output: 0 1 3 4

# ---- Multiplication Table ----
print("\n--- MULTIPLICATION TABLE OF 7 ---")
num = 7
for i in range(1, 11):
    print(f"{num} x {i} = {num * i}")