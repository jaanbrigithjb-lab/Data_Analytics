# ---- Basic Class ----
print("1. BASIC CLASS")
print("-" * 40)

class Dog:
    """A simple Dog class."""
    
    # Class attribute (shared by all instances)
    species = "Canis familiaris"
    
    # Constructor (initializer)
    def __init__(self, name, age):
        # Instance attributes (unique to each object)
        self.name = name
        self.age = age
    
    # Method
    def bark(self):
        return f"{self.name} says Woof!"
    
    def info(self):
        return f"{self.name} is {self.age} years old"

# Creating objects (instances)
dog1 = Dog("Buddy", 3)
dog2 = Dog("Max", 5)

print(f"  dog1.name: {dog1.name}")
print(f"  dog2.age: {dog2.age}")
print(f"  dog1.bark(): {dog1.bark()}")
print(f"  dog2.info(): {dog2.info()}")
print(f"  dog1.species: {dog1.species}")
print(f"  Dog.species: {Dog.species}")

# ---- Class with More Features ----
print("\n2. ENHANCED CLASS")
print("-" * 40)

class BankAccount:
    """Bank account with deposit, withdraw, and statement."""
    
    # Class variable
    bank_name = "Python National Bank"
    total_accounts = 0
    
    def __init__(self, owner, balance=0):
        self.owner = owner
        self.balance = balance
        self.transactions = []
        BankAccount.total_accounts += 1
    
    def deposit(self, amount):
        if amount <= 0:
            return "Invalid amount"
        self.balance += amount
        self.transactions.append(f"+₹{amount}")
        return f"Deposited ₹{amount}. Balance: ₹{self.balance}"
    
    def withdraw(self, amount):
        if amount <= 0:
            return "Invalid amount"
        if amount > self.balance:
            return "Insufficient funds"
        self.balance -= amount
        self.transactions.append(f"-₹{amount}")
        return f"Withdrew ₹{amount}. Balance: ₹{self.balance}"
    
    def statement(self):
        print(f"\n  📋 Statement for {self.owner}")
        print(f"  Bank: {BankAccount.bank_name}")
        print(f"  {'-' * 30}")
        for t in self.transactions:
            print(f"    {t}")
        print(f"  {'-' * 30}")
        print(f"  Balance: ₹{self.balance}")
    
    def __str__(self):
        """String representation."""
        return f"Account({self.owner}, ₹{self.balance})"

# Using the class
acc1 = BankAccount("Rahul", 5000)
acc2 = BankAccount("Priya", 10000)

print(f"  {acc1}")
print(f"  {acc1.deposit(2000)}")
print(f"  {acc1.withdraw(1500)}")
acc1.statement()

print(f"\n  Total accounts created: {BankAccount.total_accounts}")