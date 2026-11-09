# Graphics Rendering
class Shape:
    def draw(self):
        pass

class Rectangle(Shape):
    def draw(self):
        print("Drawing a Rectangle")

class Circle(Shape):
    def draw(self):
        print("Drawing a Circle")

def Graphics_Rendering():
    Shapes = [Circle(),Rectangle()]
    for shape in Shapes:
        shape.draw()

print("|-|"*10)

Graphics_Rendering()

# User Interface Components
class UIComponent:
    def click(self):
        pass

class Button(Shape):
    def click(self):
        print("Button Clicked!")

class TextField(Shape):
    def click(self):
        print("TextField clicked!")

def User_Interface_Components():
    Components = [Button(),TextField()]
    for Component in Components:
        Component.click()
print("|-|"*10)

User_Interface_Components()

# Data Processing
class DataProcessor:
    def process(self):
        pass

class CSVProcessor(DataProcessor):
    def process(self):
        print("Processing CSV data")

class JSONProcessor(DataProcessor):
    def process(self):
        print("Processing JSON data")

def Data_Processing():
    processors = [CSVProcessor(),JSONProcessor()]
    for processor in processors:
        processor.process()
print("|-|"*10)

Data_Processing()