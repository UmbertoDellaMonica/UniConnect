# UniConnect

Di seguito è riportato un file README.md dettagliato con tutti i passaggi necessari per mockare i dati, generarli, copiarli all'interno della cartella `/var/lib/neo4j/import` del container Docker e per eseguire il comando della cypher-shell per importare il CSV nel database Neo4j.

```markdown
# Mock Data Generation and Import into Neo4j

Questo documento descrive i passaggi necessari per mockare i dati degli studenti, generarli, copiarli nella cartella `/var/lib/neo4j/import` del container Docker di Neo4j e importare i dati nel database Neo4j.

## Prerequisiti

1. Docker deve essere installato e in esecuzione.
2. Un container Neo4j deve essere in esecuzione.
3. Python deve essere installato nel sistema.

## Passaggi

### 1. Genera dati mockati

Creare uno script Python per generare dati mockati degli studenti e salvarli in un file CSV.

**Script Python per generare dati mockati (`generate_mock_data.py`):**

```python
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
num_students = 100

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
    email = fake.user_name() + "@gmail.com"
    password_hash = hash_password("Ciao1002!")
    departement_unisa = fake.random_element(departments)
    data.append([student_id, full_name, email, password_hash, departement_unisa])

# Crea un DataFrame e salva in un CSV
df = pd.DataFrame(data, columns=["ID", "fullName", "email", "passwordHash", "departementUnisa"])
df.to_csv("mock_students.csv", index=False)
```

### 2. Esegui lo script per generare il file CSV

Esegui lo script Python per generare il file `mock_students.csv`.

```sh
python generate_mock_data.py
```

### 3. Copia il file CSV nel container Docker

Copia il file `mock_students.csv` nella cartella `/var/lib/neo4j/import` del container Docker.

```sh
docker cp mock_students.csv <container_id>:/var/lib/neo4j/import/
```

Sostituisci `<container_id>` con l'ID del tuo container Neo4j. Puoi ottenere l'ID del container eseguendo:

```sh
docker ps
```

### 4. Connetti alla Cypher Shell

Accedi alla Cypher Shell del container Docker di Neo4j.

```sh
docker exec -it <container_id> bin/cypher-shell -u neo4j -p uniconnect
```

### 5. Importa il file CSV nel database Neo4j

Esegui il seguente comando nella Cypher Shell per importare i dati dal file CSV nel database Neo4j.

```cypher
LOAD CSV WITH HEADERS FROM 'file:///mock_students.csv' AS row
CREATE (:Student {ID: row.ID, fullName: row.fullName, email: row.email, passwordHash: row.passwordHash, departementUnisa: row.departementUnisa});
```

## Conclusione

Seguendo questi passaggi, sarai in grado di generare dati mockati, copiarli nel container Docker di Neo4j e importarli nel database utilizzando Cypher Shell.
```

Questo file README.md contiene tutte le istruzioni necessarie per mockare i dati degli studenti, copiarli nel container Docker di Neo4j e importarli nel database. Assicurati di adattare eventuali percorsi o dettagli specifici al tuo ambiente di sviluppo.