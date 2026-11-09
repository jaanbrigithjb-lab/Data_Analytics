class Employee:
    company = "NovaTech"        # Class variable (shared by all)
    
    def __init__(self, name, salary):
        self.name = name         # Instance variable
        self.salary = salary
    
    # ---- 1. Instance Method (most common) ----
    def display(self):
        print(f"{self.name} earns ₹{self.salary}")
    
    # ---- 2. Class Method ----
    @classmethod
    def change_company(cls, new_name):
        cls.company = new_name   # changes for ALL instances
    
    @classmethod
    def from_string(cls, data):
        """Alternate constructor: 'Rahul-50000' → Employee object"""
        name, salary = data.split("-")
        return cls(name, int(salary))
    
    # ---- 3. Static Method ----
    @staticmethod
    def is_valid_salary(salary):
        """Utility — doesn't need class or instance data"""
        return salary > 0

# ---- Usage ----
emp1 = Employee("Rahul", 50000)
emp2 = Employee("Priya", 60000)

emp1.display()
emp2.display()

# Class method usage
print("Company before:", Employee.company)
Employee.change_company("NewTech")
print("Company after :", Employee.company)
print("emp1.company  :", emp1.company)   # also updated!

# Alternate constructor
emp3 = Employee.from_string("Amit-45000")
emp3.display()

# Static method
print("Valid salary 50000? :", Employee.is_valid_salary(50000))
print("Valid salary -1000? :", Employee.is_valid_salary(-1000))