from dataclasses import dataclass, field
from typing import List

# ---- 1. WITHOUT dataclass (lots of code) ----
class PersonOld:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def __repr__(self):
        return f"PersonOld(name={self.name!r}, age={self.age})"
    
    def __eq__(self, other):
        return self.name == other.name and self.age == other.age

# ---- 2. WITH dataclass (clean!) ----
@dataclass
class Person:
    name: str
    age: int
    city: str = "Mumbai"                    # default value

p1 = Person("Rahul", 25)
p2 = Person("Rahul", 25)
p3 = Person("Priya", 22, "Delhi")

print("p1      :", p1)
print("p3      :", p3)
print("p1 == p2:", p1 == p2)                 # True (auto __eq__)
print("p1 == p3:", p1 == p3)                 # False

# ---- 3. Default Factory for mutable defaults ----
@dataclass
class Team:
    name: str
    members: List[str] = field(default_factory=list)

t1 = Team("Alpha")
t1.members.append("Rahul")
t1.members.append("Priya")

t2 = Team("Beta")                            # gets fresh empty list
print("\nt1:", t1)
print("t2:", t2)

# ---- 4. Frozen (immutable) ----
@dataclass(frozen=True)
class Point:
    x: int
    y: int

pt = Point(10, 20)
print("\nPoint:", pt)
# pt.x = 99   # ❌ FrozenInstanceError