from typing import List, Dict, Optional, Union, Tuple

# ---- 1. Basic Type Hints ----
def greet(name: str) -> str:
    return f"Hello, {name}"

def add(a: int, b: int) -> int:
    return a + b

def divide(a: float, b: float) -> float:
    return a / b

print(greet("Rahul"))
print(add(5, 3))
print(divide(10, 3))

# ---- 2. Lists, Dicts, Tuples ----
def process_marks(marks: List[int]) -> float:
    return sum(marks) / len(marks)

def get_student(name: str) -> Dict[str, Union[str, int]]:
    return {"name": name, "age": 20}

def get_coordinates() -> Tuple[int, int]:
    return (10, 20)

print("\nAverage:", process_marks([85, 92, 78]))
print("Student:", get_student("Priya"))
print("Coords :", get_coordinates())

# ---- 3. Optional (can be None) ----
def find_user(user_id: int) -> Optional[str]:
    users = {1: "Rahul", 2: "Priya"}
    return users.get(user_id)      # may return None

print("\nUser 1:", find_user(1))
print("User 9:", find_user(9))

# ---- 4. Union (multiple types allowed) ----
def show_id(id_value: Union[int, str]) -> str:
    return f"ID: {id_value}"

print("\n", show_id(101))
print("", show_id("ABC-101"))

# ---- 5. Type hints for variables ----
name: str = "Rahul"
age: int = 25
scores: List[int] = [85, 92, 78]
config: Dict[str, str] = {"theme": "dark"}

print(f"\n{name}, {age}, {scores}, {config}")

# ---- Real-Time Example: API Response Type ----
print("\n--- API RESPONSE ---")
def format_response(
    status: int,
    data: List[Dict[str, Union[str, int]]],
    message: Optional[str] = None
) -> Dict[str, Union[int, list, str]]:
    return {
        "status": status,
        "message": message or "OK",
        "data": data
    }

response = format_response(
    200,
    [{"id": 1, "name": "Rahul"}, {"id": 2, "name": "Priya"}]
)
print(response)