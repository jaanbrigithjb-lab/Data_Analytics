from abc import ABC, abstractmethod

# Abstract class — can't create Payment() directly
class Payment(ABC):
    def __init__(self, amount):
        self.amount = amount
    
    @abstractmethod
    def process(self):
        """Child MUST implement this"""
        pass
    
    @abstractmethod
    def refund(self, amount):
        """Child MUST implement this"""
        pass
    
    # Concrete method (regular, inherited as-is)
    def receipt(self):
        print(f"Receipt: ₹{self.amount} paid via {self.__class__.__name__}")

# ---- Child 1 ----
class CreditCard(Payment):
    def process(self):
        print(f"Processing ₹{self.amount} via Credit Card")
    
    def refund(self, amount):
        print(f"Refunding ₹{amount} to Credit Card")

# ---- Child 2 ----
class UPI(Payment):
    def process(self):
        print(f"Processing ₹{self.amount} via UPI")
    
    def refund(self, amount):
        print(f"Refunding ₹{amount} to UPI")

# ---- Usage ----
# p = Payment(100)   # ❌ TypeError: Can't instantiate abstract class

cc = CreditCard(5000)
cc.process()
cc.receipt()
cc.refund(1000)

print()
upi = UPI(2000)
upi.process()
upi.receipt()

# ---- Notification System ----
print("\n--- NOTIFICATION SYSTEM ---")
class Notifier(ABC):
    @abstractmethod
    def send(self, message):
        pass

class EmailNotifier(Notifier):
    def send(self, message):
        print(f"📧 Email: {message}")

class SMSNotifier(Notifier):
    def send(self, message):
        print(f"📱 SMS  : {message}")

class PushNotifier(Notifier):
    def send(self, message):
        print(f"🔔 Push : {message}")

# Polymorphism in action
notifiers = [EmailNotifier(), SMSNotifier(), PushNotifier()]
for n in notifiers:
    n.send("Your order has shipped!")