# ---- Encapsulation (Private Attributes) ----
print("\n3. ENCAPSULATION")
print("-" * 40)

class Student:
    def __init__(self, name, marks):
        self.name = name
        self._marks = marks        # Protected (convention)
        self.__grade = None        # Private (name mangling)
        self._calculate_grade()
    
    def _calculate_grade(self):
        avg = sum(self._marks) / len(self._marks)
        if avg >= 90: self.__grade = "A+"
        elif avg >= 80: self.__grade = "A"
        elif avg >= 70: self.__grade = "B"
        else: self.__grade = "C"
    
    def get_grade(self):
        return self.__grade
    
    def display(self):
        print(f"  Name: {self.name}")
        print(f"  Marks: {self._marks}")
        print(f"  Grade: {self.__grade}")

s = Student("Sneha", [88, 92, 85])
s.display()

# Grade Is Private Attribute and Cannot Accessed By Def 
# print(s.__grade)

# Marks Is Protected Attribute and Accessed By Def 
print(s._marks)

# Accessing private (not recommended but possible)
# print(s.__grade)  # Error
print(f"  Via method: {s.get_grade()}")