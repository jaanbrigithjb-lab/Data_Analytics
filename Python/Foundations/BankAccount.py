import datetime as dt

accounts = {
    "ABCH7854OOO0001":{
        "b_name":"Bank Of Baroda",
        "h_name":"Jaan Brigith I",
        "pin":1234,
        "t_balance":1000
    },
    "ABCH7854OOO0002":{
        "b_name":"Union Bank Of India",
        "h_name":"Jenitha Merlin J",
        "pin":1234,
        "t_balance":1000
    },
    "ABCH7854OOO0003":{
        "b_name":"IDFC",
        "h_name":"Sowmiya Juliet K",
        "pin":1234,
        "t_balance":1000
    },
    "ABCH7854OOO0004":{
        "b_name":"HDFC",
        "h_name":"Libona Jenat K",
        "pin":1234,
        "t_balance":1000
    },
    "ABCH7854OOO0005":{
        "b_name":"SBI",
        "h_name":"Albert Jerry Martin J",
        "pin":1234,
        "t_balance":1000
    },
}  

def write_log(message):
    dateFormat = dt.datetime.now().astimezone().strftime("%Y-%m-%d %H:%M:%S")
    with open("BankAccount_Transactions.txt", "a") as file:
        file.write(f"{dateFormat} - {message}\n")

# Bank Account 
class BankAccount:
    def __init__(self,acc_bankName,acc_HolderName,acc_pin,acc_Balance=0.0):
        self.acc_bankName = acc_bankName
        self.acc_HolderName = acc_HolderName  
        self.acc_pin = acc_pin
        self.acc_Balance = acc_Balance

# Deposit Function
    def deposit(self,amount):
        if amount > 0:
            self.acc_Balance +=amount
            write_log(f"Bank_Name: {self.acc_bankName}, Holder_Name: {self.acc_HolderName}, Deposit: +${self.acc_Balance:.2f}")
            return f"Successfully Deposited ${self.acc_Balance:.2f}."

        return f"Invalid Deposit Amount."

# Withdraw Function
    def withdraw(self,amount):
        if 0 < amount <= self.acc_Balance:
            self.acc_Balance -= amount
            write_log(f"Bank_Name: {self.acc_bankName}, Holder_Name: {self.acc_HolderName}, Withdraw: -${amount:.2f}")
            return f"Successfully Withdraw ${amount:.2f}."
        
        elif amount > self.acc_Balance:
            return f"Insufficient Balance!"
        
        return f"Invalid Withdraw Amount."

# Pin Check
    def pinCheck(self,pin=0000):
        if self.acc_pin == pin:
            return f"Correct Pin"
        else:
            return f"Incorrect Pin"

# Check Balance Function
    def check_balance(self):
        return f"Current Balance: ${self.acc_Balance:.2f}"

# Exit Log Function
    def exit_log(self):
         write_log(f"Bank_Name: {self.acc_bankName}, Holder_Name: {self.acc_HolderName}, Total: ${self.acc_Balance:.2f}\n\n")

# Main Function
def Main(b_name,h_name,pin,t_balance):
    attempt = 3
    # Class And Constructor
    acc = BankAccount(b_name,h_name,pin,t_balance);
    for _ in range(1,4):
        
        print(f"\n{"-"*50}")
        atmpin = int(input("Enter 4 Digit Pin: "))
        print(f"{"-"*50}\n")
        if atmpin == pin:
            while True:
                # print("\n")
                print("-"*50)
                print("--------------- Banking Main Menu ----------------")
                print("-"*50)
                print("1. Deposit")
                print("2. Withdraw")
                print("3. Check Balance")
                print("4. Exit")
                print("-"*50)
                inp = input("Enter Option(1-4): ")

                if inp == "1":
                        amt = int(input("Enter a Deposit amount: "))
                        dp = acc.deposit(amt)
                        print(dp)

                elif inp == "2":
                        amt = int(input("Enter a Withdraw amount: "))
                        wd = acc.withdraw(amt)
                        print(wd)

                elif inp == "3":
                        balance = acc.check_balance()
                        print(balance)

                elif inp == "4":
                    acc.exit_log()
                    print("Exiting...")
                    exit()

                else:
                    print("Entered Invalid Option...")

        else:
            attempt -= 1
            print(f"Wrong Pin! You Have {attempt} Attempts Left.")
            if attempt == 0:
                print("You Have Exceeded The Maximum Number Of Attempts. Please Try Again Later.")
                print("\n-------------------------------------\n")
                exit()

inp = input("Enter Account last Number:")
acc = f"ABCH7854OOO000{inp}"

if acc in accounts:
    print("-"*50)
    print("Record Found in Bank LocalDB...")
    print("-------------------------------")
    print(f"Bank: {accounts[acc]['b_name']}")
    print(f"Account_Number: {acc}")
    b_name = accounts[acc]['b_name']
    print(f"Holder's_Name: {accounts[acc]['h_name']}")
    h_name = accounts[acc]['h_name']
    print(f"Total_Balance: ${accounts[acc]['t_balance']:.2f}")
    t_balance = accounts[acc]['t_balance']
    pin = accounts[acc]['pin']
    print("-"*50)
    Main(b_name,h_name,pin,t_balance)
else:
    print("No Record Found in Bank LocalDB!")
