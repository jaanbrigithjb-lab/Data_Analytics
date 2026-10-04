student = {
    "name": "Elaya Bharathi",
    "age": 20,
    "city": "Coimbatore"
}
print("Student Dictonary: ")
print(student)
print("-"*70,"\n")

#Creating a dictionary using dict Keyword
print("Creating a dictionary using dict Keyword")
b = dict(name="Sam", age=20, city="Coimbatore")
print(b)
print("-"*70,"\n")

#Print dict keys
print("Print keys")
print(student.keys())
print("-"*70,"\n")


# Print dict values
print("Print Values")
print(student.values())
print("-"*70,"\n")


# items
print("items in dict")
print(student.items())
print("-"*70,"\n")

# add
print("add")
# student["Course"] = "CSE"
# print(student)
print("-"*70,"\n")


# update
print("update")
# student.update({
#     "age": 21,
#     "city": "Chennai"
# })
# print(student)
print("-"*70,"\n")

# delete 
print("delete the key,value")
# age = student.pop("age")
# print(student)
print("-"*70,"\n")

# remove the last inserted item
print("remove the last inserted item")
# student.popitem()
# print(student)
print("-"*70,"\n")

# to remove all items 
print("remove all items")
# student.clear()
# print(student)
print("-"*70,"\n")

# duplicate keys
print("duplicate keys in dict")
# student = {
#     "name": "Arun",
#     "name": "Kumar"
# }
# print(student) 
print("-"*70,"\n")

# for loop
print("for loop to display key,value")
# for key, value in student.items():
#     print(key, value)
print("-"*70,"\n")

# #copy
print("Copy of Dictonary using copy")
# new = student.copy()
# new["name"] = "Priya"
# print(student)
# print(new)
print("-"*70,"\n")

# setdefault
print("setdefault in dictonary")
# course = student.setdefault("course", "AI")
# print(student)
print("-"*70,"\n")