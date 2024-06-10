Sure, here is the detailed `README.md` in English:

```markdown
# Mock Data Generation and Import into Neo4j

This document outlines the steps required to mock student data, generate it, copy it into the `/var/lib/neo4j/import` folder of the Neo4j Docker container, and import the data into the Neo4j database.

## Prerequisites

1. Docker must be installed and running.
2. A Neo4j container must be running.
3. Python must be installed on the system.

## Steps

### 1. Generate Mock Data

Create a Python script to generate mock student data and save it to a CSV file.

**Python Script to Generate Mock Data (`generate_mock_data.py`):**

```python
import bcrypt
import pandas as pd
from faker import Faker
import uuid

# Configure the salt for bcrypt
salt = b"$2a$10$Gs.PmaGJQtm0ThQF3VkX2u"

def hash_password(password):
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
    return hashed_password.decode('utf-8')

# Create an instance of Faker
fake = Faker()

# Number of students to generate
num_students = 600

# Enums for the department
departments = [
    "AGRICOLA", "ARCHITETTURA", "BIOMEDICHE", "FORMAZIONE_BENICULTURALI", 
    "CHIMICHE", "ECONOMICHE_STATISTICHE", "GIURIDICHE", "INGEGNERIA_ELETTRICA", 
    "INGEGNERIA_EDILE", "INGEGNERIA_INDUSTRIALE", "INFORMATICA", "MATEMATICA_FISICA", 
    "MEDICINA_CHIRURGIA_ODONTOIATRIA", "FARMACIA", "MOTORIE_UMANE_SOCIALI", 
    "POLITICHE_SOCIALI", "LINGUAGGIO_BENICULTURALI", "FISICA", "SCUOLA_MEDICINA"
]

# Mock data
data = []
for _ in range(num_students):
    student_id = str(uuid.uuid4())
    full_name = fake.name()
    name_parts = full_name.split()
    first_name = name_parts[0].lower()
    last_name = name_parts[-1].lower()
    email = f"{first_name}.{last_name}@gmail.com"
    password_hash = hash_password("Ciao1002!")
    departement_unisa = fake.random_element(departments)
    data.append([student_id, full_name, email, password_hash, departement_unisa])

# Create a DataFrame and save to a CSV
df = pd.DataFrame(data, columns=["ID", "fullName", "email", "passwordHash", "departementUnisa"])
df.to_csv("mock_students.csv", index=False)
```

### 2. Run the Script to Generate the CSV File

Run the Python script to generate the `mock_students.csv` file.

```sh
python generate_mock_data.py
```

### 3. Copy the CSV File to the Docker Container

Copy the `mock_students.csv` file into the `/var/lib/neo4j/import` folder of the Docker container.

```sh
docker cp mock_students.csv <container_id>:/var/lib/neo4j/import/
```

Replace `<container_id>` with your Neo4j container ID. You can get the container ID by running:

```sh
docker ps
```

### 4. Connect to the Cypher Shell

Access the Cypher Shell of the Neo4j Docker container.

```sh
docker exec -it <container_id> bin/cypher-shell -u neo4j -p uniconnect
```

### 5. Import the CSV File into the Neo4j Database

Run the following command in the Cypher Shell to import the data from the CSV file into the Neo4j database.

```cypher
LOAD CSV WITH HEADERS FROM 'file:///mock_students.csv' AS row
CREATE (:Student {ID: row.ID, fullName: row.fullName, email: row.email, passwordHash: row.passwordHash, departementUnisa: row.departementUnisa});
```

## Conclusion

By following these steps, you will be able to generate mock data, copy it into the Neo4j Docker container, and import it into the database using Cypher Shell. This README.md file contains all the necessary instructions to mock student data, copy it into the Neo4j Docker container, and import it into the database. Be sure to adjust any paths or specific details to fit your development environment.