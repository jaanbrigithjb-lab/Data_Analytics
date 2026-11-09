print("1. WITHOUT EXCEPTION HANDLING")
print("-" * 40)

try:
    # This would crash the program
    result = 10 / 0
except:
    print("  ⚠️ (Caught: Division by zero would crash here)")

# ---- Basic try-except ----
print("\n2. BASIC TRY-EXCEPT")
print("-" * 40)

try:
    num = int("abc")  # This will fail
except ValueError as e:
    print(f"  ❌ Error caught: {e}")
    print(f"  ✅ Program continues running!")

# ---- Multiple Exceptions ----
print("\n3. MULTIPLE EXCEPTIONS")
print("-" * 40)

def divide(a, b):
    try:
        result = a / b
        return result
    except ZeroDivisionError:
        return "Error: Cannot divide by zero"
    except TypeError:
        return "Error: Invalid data types"

print(f"  divide(10, 2): {divide(10, 2)}")
print(f"  divide(10, 0): {divide(10, 0)}")
print(f"  divide(10, 'a'): {divide(10, 'a')}")

# ---- try-except-else-finally ----
print("\n4. TRY-EXCEPT-ELSE-FINALLY")
print("-" * 40)

def process_file(filename):
    try:
        file = open(filename, "r")
    except FileNotFoundError:
        print(f"  ❌ File '{filename}' not found")
    else:
        print(f"  ✅ File opened successfully")
        content = file.read()
        print(f"  Content: {content[:50]}...")
        file.close()
    finally:
        print(f"  🔄 Cleanup completed for '{filename}'")

# Create a test file
with open("test.txt", "w") as f:
    f.write("Hello, this is a test file with some content.")

process_file("test.txt")
process_file("nonexistent.txt")

# ---- Raising Exceptions ----
print("\n5. RAISING EXCEPTIONS")
print("-" * 40)

def validate_age(age):
    if not isinstance(age, int):
        raise TypeError("Age must be an integer")
    if age < 0:
        raise ValueError("Age cannot be negative")
    if age > 150:
        raise ValueError("Age seems unrealistic")
    return f"Valid age: {age}"

test_ages = [25, -5, "twenty", 200]

for age in test_ages:
    try:
        result = validate_age(age)
        print(f"  ✅ {result}")
    except (TypeError, ValueError) as e:
        print(f"  ❌ {age}: {e}")

# ---- Custom Exceptions ----
print("\n6. CUSTOM EXCEPTIONS")
print("-" * 40)

class InsufficientBalanceError(Exception):
    """Custom exception for insufficient bank balance."""
    def __init__(self, balance, amount):
        self.balance = balance
        self.amount = amount
        super().__init__(f"Insufficient balance: ₹{balance} < ₹{amount}")

class InvalidAmountError(Exception):
    """Custom exception for invalid transaction amounts."""
    pass

def withdraw(balance, amount):
    if amount <= 0:
        raise InvalidAmountError("Amount must be positive")
    if amount > balance:
        raise InsufficientBalanceError(balance, amount)
    return balance - amount

# Test custom exceptions
transactions = [
    (5000, 2000),   # Valid
    (5000, 10000),  # Insufficient
    (5000, -500),   # Invalid
]

for balance, amount in transactions:
    try:
        new_balance = withdraw(balance, amount)
        print(f"  ✅ Withdrew ₹{amount}. New balance: ₹{new_balance}")
    except InsufficientBalanceError as e:
        print(f"  ❌ {e}")
    except InvalidAmountError as e:
        print(f"  ❌ {e}")