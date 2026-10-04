# Nested if - Marks
# marks = 55
# if marks >= 50:
#     if marks >= 60:
#         print("Passed with First Class")
#     else:
#         print("Passed")
# else:
#     print("Failed")



# age = 22

# if age >= 18:
#     if age >= 21:
#         if age >= 25:
#             print("Age is 25 or above")
#         else:
#             print("Age is between 21 and 24")
#     else:
#         print("Age is between 18 and 20")
# else:
#     print("Below 18")



# # Elif ladder

# marks = 78

# if marks >= 90:
#     grade = "A+"
# elif marks >= 80:
#     grade = "A"
# elif marks >= 70:
#     grade = "B"
# elif marks >= 60:
#     grade = "C"
# elif marks >= 50:
#     grade = "D"
# else:
#     grade = "F"

# print("Grade:", grade)



# # match case
# choice = 7

# match choice:
#     case 1:
#         print("Pizza selected")
#     case 2:
#         print("Burger selected")
#     case 3:
#         print("Pasta selected")
#     case 4:
#         print("Biryani selected")
#     case _:
#         print("Invalid choice")






# age = 19
# if age > 18: print("Eligible to Vote.")






# #Nested if - Atm withdrawal
# balance = 10000
# amount = 5000
# pin_correct = True
# card_active = True

# if card_active:
#     if pin_correct:
#         if amount <= balance:
#             if amount % 100 == 0:
#                 print("Withdrawal successful")
#             else:
#                 print("Enter amount in multiples of 100")
#         else:
#             print("Insufficient balance")
#     else:
#         print("Incorrect PIN")
# else:
#     print("Card is inactive")





# age = 19
# marks = 54
# income = 150000

# if age >= 18:
#     if marks >= 60:
#         if income <= 200000:
#             print("Eligible for scholarship")
#         else:
#             print("Eligible for admission but no scholarship")
#     else:
#         print("Marks are too low")
# else:
#     print("Age requirement not met")