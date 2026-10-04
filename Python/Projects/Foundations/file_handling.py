import os

# ---- Writing to a File ----
print("1. WRITING TO A FILE")
print("-" * 40)

# 'w' mode: Creates new file or OVERWRITES existing
with open("sample.txt", "w") as file:
    file.write("Hello, World!\n")
    file.write("This is Python file handling.\n")
    file.write("Line 3 of the file.\n")

print("  ✅ File 'sample.txt' created")

# ---- Reading from a File ----
print("\n2. READING FROM A FILE")
print("-" * 40)

# Method 1: Read entire file
with open("sample.txt", "r") as file:
    content = file.read()
    print(f"  read():\n{content}")

# Method 2: Read line by line
print("  readline() (first 2 lines):")
with open("sample.txt", "r") as file:
    print(f"    Line 1: {file.readline().strip()}")
    print(f"    Line 2: {file.readline().strip()}")

# Method 3: Read all lines as list
print("  readlines():")
with open("sample.txt", "r") as file:
    lines = file.readlines()
    for i, line in enumerate(lines, 1):
        print(f"    {i}: {line.strip()}")

# ---- Appending to a File ----
print("\n3. APPENDING TO A FILE")
print("-" * 40)

# 'a' mode: Adds to end without overwriting
with open("sample.txt", "a") as file:
    file.write("Line 4 - Appended!\n")
    file.write("Line 5 - Also appended!\n")

print("  ✅ 2 lines appended")

with open("sample.txt", "r") as file:
    print(f"  Updated content:\n{file.read()}")

# ---- File Modes Summary ----
print("4. FILE MODES")
print("-" * 40)
modes = {
    "r": "Read (default) - error if not exists",
    "w": "Write - creates or overwrites",
    "a": "Append - adds to end",
    "x": "Create - error if exists",
    "r+": "Read and write",
    "b": "Binary mode (rb, wb)",
    "t": "Text mode (default)"
}
for mode, desc in modes.items():
    print(f"  '{mode}': {desc}")

# ---- Working with Paths ----
print("\n5. FILE PATHS")
print("-" * 40)

# Check if file exists
print(f"  sample.txt exists: {os.path.exists('sample.txt')}")

# File info
if os.path.exists("sample.txt"):
    size = os.path.getsize("sample.txt")
    print(f"  File size: {size} bytes")