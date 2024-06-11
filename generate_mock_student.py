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
num_students = 600

# Enums per il dipartimento
departments = [
    "AGRICOLA", "ARCHITETTURA", "BIOMEDICHE", "FORMAZIONE_BENICULTURALI", 
    "CHIMICHE", "ECONOMICHE_STATISTICHE", "GIURIDICHE", "INGEGNERIA_ELETTRICA", 
    "INGEGNERIA_EDILE", "INGEGNERIA_INDUSTRIALE", "INFORMATICA", "MATEMATICA_FISICA", 
    "MEDICINA_CHIRURGIA_ODONTOIATRIA", "FARMACIA", "MOTORIE_UMANE_SOCIALI", 
    "POLITICHE_SOCIALI", "LINGUAGGIO_BENICULTURALI", "FISICA", "SCUOLA_MEDICINA"
]

# Dati mockati
data = []
for _ in range(num_students):
    student_id = str(uuid.uuid4())
    full_name = fake.name()
    biography =" " 
    name_parts = full_name.split()
    first_name = name_parts[0].lower()
    last_name = name_parts[-1].lower()
    email = f"{first_name}.{last_name}@gmail.com"
    password_hash = hash_password("Ciao1002!")
    departement_unisa = fake.random_element(departments)
    data.append([student_id, full_name, email, password_hash, departement_unisa,biography])

# Crea un DataFrame e salva in un CSV
df = pd.DataFrame(data, columns=["ID", "fullName", "email", "passwordHash", "departementUnisa","biography"])
df.to_csv("mock_students.csv", index=False)
