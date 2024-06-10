import bcrypt
import pandas as pd
from faker import Faker
import uuid

# Configura il salt per bcrypt
salt = b"$2a$10$Gs.PmaGJQtm0ThQF3VkX2u"

def hash_password(password):
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
    return hashed_password.decode('utf-8')

# Crea un'istanza di Faker
fake = Faker()

# Numero di studenti da generare
num_students = 200

# Dati mockati
data = []
for _ in range(num_students):
    student_id = str(uuid.uuid4())
    full_name = fake.name()
    email = fake.user_name() + "@gmail.com"
    password_hash = hash_password("Ciao1002!")
    data.append([student_id, full_name, email, password_hash])

# Crea un DataFrame e salva in un CSV
df = pd.DataFrame(data, columns=["ID", "fullName", "email", "passwordHash"])
df.to_csv("mock_students.csv", index=False)
