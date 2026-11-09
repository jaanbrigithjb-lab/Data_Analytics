# ---- Basic Inheritance ----
print("1. BASIC INHERITANCE")
print("-" * 40)

class Animal:
    """Parent class."""
    def __init__(self, name, sound):
        self.name = name
        self.sound = sound
    
    def speak(self):
        return f"{self.name} says {self.sound}"
    
    def info(self):
        return f"I am {self.name}, a {type(self).__name__}"

class Dog(Animal):
    """Child class inheriting from Animal."""
    def __init__(self, name):
        super().__init__(name, "Woof")  # Call parent constructor
    
    def fetch(self):
        return f"{self.name} fetches the ball!"

class Cat(Animal):
    def __init__(self, name):
        super().__init__(name, "Meow")
    
    def scratch(self):
        return f"{self.name} scratches the couch!"

# Using inheritance
dog = Dog("Buddy")
cat = Cat("Whiskers")

print(f"  {dog.speak()}")
print(f"  {dog.info()}")
print(f"  {dog.fetch()}")

print(f"\n  {cat.speak()}")
print(f"  {cat.info()}")
print(f"  {cat.scratch()}")

# ---- Method Overriding ----
print("\n2. METHOD OVERRIDING")
print("-" * 40)

class Vehicle:
    def __init__(self, brand, model):
        self.brand = brand
        self.model = model
    
    def start(self):
        return "Vehicle starting..."
    
    def describe(self):
        return f"{self.brand} {self.model}"

class Car(Vehicle):
    def start(self):  # Override parent method
        return f"🚗 {self.brand} {self.model} engine started!"
    
    def honk(self):
        return "Beep beep!"

class Bike(Vehicle):
    def start(self):
        return f"🏍️ {self.brand} {self.model} kick-started!"

car = Car("Toyota", "Camry")
bike = Bike("Honda", "CBR")

print(f"  Car: {car.start()}")
print(f"  Bike: {bike.start()}")
print(f"  Car describe: {car.describe()}")

# ---- Multiple Inheritance ----
print("\n3. MULTIPLE INHERITANCE")
print("-" * 40)

class Swimmer:
    def swim(self):
        return "Swimming..."

class Flyer:
    def fly(self):
        return "Flying..."

class Duck(Swimmer, Flyer):
    def __init__(self, name):
        self.name = name
    
    def quack(self):
        return f"{self.name} says Quack!"

duck = Duck("Donald")
print(f"  {duck.quack()}")
print(f"  {duck.swim()}")
print(f"  {duck.fly()}")

# ---- isinstance() and issubclass() ----
print("\n4. TYPE CHECKING")
print("-" * 40)

print(f"  isinstance(dog, Dog): {isinstance(dog, Dog)}")
print(f"  isinstance(dog, Animal): {isinstance(dog, Animal)}")
print(f"  isinstance(cat, Dog): {isinstance(cat, Dog)}")
print(f"  issubclass(Dog, Animal): {issubclass(Dog, Animal)}")
print(f"  issubclass(Cat, Dog): {issubclass(Cat, Dog)}")