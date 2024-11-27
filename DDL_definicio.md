# DDL

Contingut: `CREATE, DROP, ALTER I RENAME`  
Metacomandes comprovació: `\l \du \d \d+`

## ÍNDICE

1. [Crear TAULES](#crear-taules)
2. [Omplir taula amb els ATRIBUTS](#omplir-taula-amb-els-atributs)
3. [Restriccions (DEFAULT, NOT NULL)](#restriccions-inici)
4. [CONSTRAINS PK i FK](#constriants-restriccions)
5. [Restricció: CHECK](#check)
6. [COMENTARIS](#comentaris)
7. [ALTER](#alter)
    - [Canviar nom taula](#canviar-nom-taula)
    - [Eliminar TAULA](#eliminar-taula)
    - [Afegir COLUMNA](#afegir-columna)
    - [Canviar nom COLUMNA](#canviar-nom-columna)
    - [Canviar nom CONSTRAIN](#canviar-nom-constrain)
    - [Modificar "especificació" tipus](#modificar-especificacio-tipus)
    - [Canviar tipus de dada](#canviar-tipus-de-dada)
    - [Afegir RESTRICCIÓ](#afegir-restriccio)
    - [Esborro RESTRICCIÓ](#esborro-restriccio)

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

---

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

---
* Afegir RESTRICCIÓ
```sql
-- afegeixo restricció
ALTER TABLE FITXA
ADD CONSTRAINT CK_UPPER_PROV CHECK (PROVINCIA = UPPER(PROVINCIA));
```

* Canviar nom CONSTRAIN/RESTRICCIÓ
```sql
-- canvio nom d'una constrain
ALTER TABLE FITXA
    RENAME CONSTRAINT PK_FITXA TO PrimKey_Fitxa;
```

* Esborro RESTRICCIÓ
```sql
-- esborro restricció
ALTER TABLE FITXA
DROP CONSTRAINT CK_UPPER_PROV;
```

---

* Afegir DEFAULT o NOT NULL  
DEFAULT
```sql
ALTER TABLE nomTaula
ALTER COLUMN nomColumna SET DEFAULT valorDefault;
```
NOT NULL
```sql
ALTER TABLE nomTaula
ALTER COLUMN nomColumna SET NOT NULL;
```
* Esborrar DEFAULT o NOT NULL
```sql
ALTER TABLE nomTaula
ALTER COLUMN nomColumna DROP DEFAULT;
```
---


