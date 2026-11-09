# ---- 1. Local Variable ----
def show():
    x = 10          # Local — only exists inside show()
    print("Inside:", x)

show()
# print(x)          # ❌ NameError — x is not defined outside

# ---- 2. Global Variable ----
counter = 0         # Global — accessible everywhere

def display():
    print("Global counter:", counter)   # Reading is OK

display()

# ---- 3. Modifying Global (requires 'global' keyword) ----
def increment():
    global counter  # tells Python: use global counter
    counter += 1

increment()
increment()
print("After increment:", counter)   # 2

# ---- 4. Nonlocal (for nested functions) ----
def outer():
    x = 10
    def inner():
        nonlocal x   # refers to outer()'s x, not a new one
        x = 20
    inner()
    print("Outer x after inner:", x)   # 20

outer()

# ---- 5. Shadowing (local overrides global) ----
value = 100
def shadow():
    value = 200     # creates new LOCAL variable, doesn't affect global
    print("Inside shadow:", value)

shadow()
print("Outside value:", value)         # still 100

# ---- Bank Account ----
print("\n--- BANK ACCOUNT ---")
balance = 1000   # global

def deposit(amount):
    global balance
    balance += amount
    print(f"Deposited ₹{amount} | Balance: ₹{balance}")

def withdraw(amount):
    global balance
    if amount > balance:
        print(f"❌ Insufficient! Balance: ₹{balance}")
    else:
        balance -= amount
        print(f"Withdrew ₹{amount} | Balance: ₹{balance}")

deposit(500)
withdraw(300)
withdraw(2000)