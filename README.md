# M2_BaseDeDades

### Instal·lació POstgreSQL Portable

[Instal·lació PostgreSQL POrtable Linux - Classroom](https://classroom.google.com/c/NzA1MTYyMjgyNDU1/m/NzI2NDA1NDEzOTI1/details)

[Instal·lació PostgreSQL Portable WINDOWS - Classroom](https://classroom.google.com/c/NzA1MTYyMjgyNDU1/m/NzI2NjI1NjE5OTgx/details)

### Iniciar PostgreSQl Portable
Inicio programa:  
`bash startSql.sh`

Ens connectem al client de PostgreSQL.  
`psql postgres`
  
-- Crea un **base de dades** anomenada training  
`CREATE DATABASE training;`

-- Crea un **usuari** amb **contrasenya** i perfil de **superusuari**   
`CREATE USER training WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'training';`

-- Assigna l'usuari training com a **propietari** de la BBDD training  
`ALTER DATABASE training OWNER TO training;`

-- Assigna tots els **privilegis** a l'usuari training sobre la BBDD training  
`GRANT ALL PRIVILEGES ON DATABASE training TO training;`

>[!NOTE]
> Compovació que base de dades s'ha creat: `\l`

>[!NOTE]
> Compovació que l'usuari s'ha creat: `\du`

Surto del client PostgreSQL  
`\q`

--Ara ens connectarem a la BBDD training amb l'usuari training.  
`psql -U training -W -d training`

>[!NOTE]
>Comprova quin usuari està connectat: `SELECT CURRENT_USER;`

Comencem a crear taules (següent apartat)

### DDL
---

#### Crear TAULES  

```sql
CREATE TABLE IF NOT EXISTS REGION ();
```
O també:
```sql
CREATE TABLE REGION ();
```
>[!NOTE]
>Comprovació: `\dt`

#### Omplir taula amb els ATRIBUTS:
```sql
CREATE TABLE FITXA (
    DNI NUMERIC(10) NOT NULL,
    NOM VARCHAR(30) NOT NULL,
    COGNOMS VARCHAR(70) NOT NULL,
    ADREÇA VARCHAR(60),
    TELEFON VARCHAR(11) NOT NULL,
    PROVINCIA VARCHAR(30),
    DATA_NAIX DATE DEFAULT CURRENT_DATE
    );
```  

>[!NOTE]
> Hi ha diferent tipus pels atributs:
    >* CHAR, VARCHAR(), TEXT
    >* BOOLEAN
    >* DATE, TIMESTAMP
    >* NUMERIC -> INTEGER, DECIMAL NUMRIC(P,S)

  
>[!WARNING]
> Si posem `NUMERIC (8,2)` estem dient que acceptem un num de **8 xifres** i **2 decimals**.

---
#### RESTRICCIONS INICI
Quan estem "definint" els atributs, hi ha 2 restriccions qu podem posar:
* NULL: accepta valors nulls (no resposta) 
* NOT NULL: NO accepta valors nulls,obliga a introduir un valor
* DEFAULT: defineix un valor per defecte per si no li fem un insert

Exemple:
```sql
Nom varchar(30) DEFAULT 'Irie'
```

> [!NOTE]
>Per posar una data per defecte:  
>`DATA_NAIX DATE DEFAULT CURRENT_DATE;`


---
#### CONSTRIANS / RESTRICCIONS
* PRIMARY KEY  
Nomenclatura: PK_NomTaula
```sql
CONSTRAINT PK_TAULA PRIMARY KEY (nomAtribut),
```

* FOREING KEY
Nomenclatura: FK_TaulaActual_TaulaForeing_nomAtribut  

```sql
CONSTRAINT FK_ALUMNE_PERSONA_nom FOREIGN KEY (nomAtribut) REFERENCES TAULAFOREING(nomAtribut)
```

>[!NOTE]  
> `ON DELETE CASCADE`
---
#### CHECK
Nomenclatura: CK_nomAtribut_descripció
```sql
CONSTRAINT CK_preuV_sup CHECK (preuVenda >0),
```
Tipus:  
* Més gran, més petit: `CHECK (atribut >0)`

* Valors concrets: `CHECK (nomAtribut IN ('valor1', 'valor2', 'valor3')`

* OR || : `CHECK (nomAtribut IN ('C', 'B')`

* MAJUS : ` CHECK (nomAtribut = UPPER(nomAtribut)`  

* Primera lletra MAJUS:`CHECK (nomAtribut = INITCAP(nomAtribut)),`

* ...

---

#### COMENTARIS
* Comentari a la taula:
```sql
COMMENT ON COLUMN TAULA IS 'comentari que vull posar';
```

* Comentari a columna (atribut):
```sql
COMMENT ON COLUMN TAULA.COLUMNA IS 'comentari que vull posar';
```

>[!NOTE]  
> Per veure el comentari: `\d+ nomTaula`

---

#### ALTER
* Canivar nom taula
```sql
-- canvio nom de la taula
ALTER TABLE FITXA RENAME TO ENTRADA;
```
* Eliminar TAULA
```sql
--elimino taula
DROP TABLE ENTRADA;
```

* Afegir COLUMNA
```sql
-- afegeixo una columna
ALTER TABLE FITXA
    ADD CP VARCHAR(5);

```

* Canviar nom COLUMNA
```sql
-- canvio nom d'una columna
ALTER TABLE FITXA
    RENAME COLUMN CP TO CODI_POSTAL;
```

* Canviar nom CONSTRAIN
```sql
-- canvio nom d'una constrain
ALTER TABLE FITXA
    RENAME CONSTRAINT PK_FITXA TO PrimKey_Fitxa;
```

* Modificar "especificació" tipus
```sql
-- canvio longitud varchar
ALTER TABLE FITXA
ALTER CODI_POSTAL TYPE VARCHAR(10);
```

* Canivar tipus de dada
```sql
ALTER TABLE fitxa ALTER COLUMN Codi_Postal TYPE NUMERIC USING Codi_Postal::NUMERIC(5);
```

* Afegir RESTRICCIÓ
```sql
-- afegeixo restricció
ALTER TABLE FITXA
ADD CONSTRAINT CK_UPPER_PROV CHECK (PROVINCIA = UPPER(PROVINCIA));
```

* Esborro RESTRICCIÓ
```sql
-- esborro restricció
ALTER TABLE FITXA
DROP CONSTRAINT CK_UPPER_PROV;
```