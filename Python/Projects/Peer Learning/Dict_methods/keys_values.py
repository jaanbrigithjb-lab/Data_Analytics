print("-"*50)
#int
student = {
    101: {"name":"Jaan Brigith","ph_no": 2584298547,"credits": 8.32,"is_completed": True,"is_placed": False,"Skills": ["Python", "SQL", "JS"],"courses": {"Python", "Java", "SQL"},"coordinates": (10, 20)},
    102: {"name":"John Prince","ph_no": 2584298547,"credits": 8.32,"is_completed": True,"is_placed": False,"Skills": ["Python", "SQL", "JS"],"courses": {"Python", "Java", "SQL"},"coordinates": (10, 20)},
    103: {"name":"Cheran","ph_no": 2584298547,"credits": 8.32,"is_completed": True,"is_placed": False,"Skills": ["Python", "SQL", "JS"],"courses": {"Python", "Java", "SQL"},"coordinates": (10, 20)},
    104: {"name":"Rahul","ph_no": 2584298547,"credits": 8.32,"is_completed": True,"is_placed": False,"Skills": ["Python", "SQL", "JS"],"courses": {"Python", "Java", "SQL"},"coordinates": (10, 20)},
    105: {"name":"Bala","ph_no": 2584298547,"credits": 8.32,"is_completed": True,"is_placed": False,"Skills": ["Python", "SQL", "JS"],"courses": {"Python", "Java", "SQL"},"coordinates": (10, 20)},
}

print("key and value of Entire Dictonary Data: {}")
print(student)
print("-"*50)


print("key and value of Particular Dictonary Data: 101")
print(student[101])
print("-"*50)


print("find Particular nested Dictonary Data of skills : 101")
print(student[101]["Skills"])
print("-"*50)