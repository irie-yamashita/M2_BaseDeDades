# DDL
Contingut: `CREATE, DROP, ALTER I RENAME`  
Metacomandes comprovació: `\l \du \d \d+`

## ÍNDICE

1. [CREATE](#crear-taules)
2. [Omplir taula amb els ATRIBUTS](#omplir-taula-amb-els-atributs)
3. [Restriccions (DEFAULT, NOT NULL)](#restriccions-inici)
4. [CONSTRAINTS PK i FK](#constraints--restriccions)
5. [Restriccions: CHECK](#check)
6. [COMENTARIS](#comentaris)
7. [ALTER](#alter)
    - [Canviar nom taula](#canivar-nom-taula)
    - [Eliminar TAULA](#eliminar-taula)
    - [Afegir COLUMNA](#afegir-columna)
    - [Canviar nom COLUMNA](#canviar-nom-columna)
    - [Eliminar COLUMNA]()
    - [Canviar nom CONSTRAINT](#canviar-nom-constraintrestricció)
    - [Modificar "especificació" tipus](#modificar-tamany-tipus)
    - [Canviar tipus de dada](#canivar-tipus-de-dada)
    - [Afegir RESTRICCIÓ](#afegir-restricció)
    - [Esborro RESTRICCIÓ](#esborro-restricció)
8. [COMPROVAR](#comprovar)
9. [ELIMINAR](#eliminar)

---
### Crear TAULES  

```sql
CREATE TABLE IF NOT EXISTS REGION ();
```
O també:
```sql
CREATE TABLE REGION ();
```
>[!NOTE]
>Comprovació: `\dt`

>![!TIP]  
> Comença creant les taules que no tenen cap dependència


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
    >* NUMERIC -> INTEGER, DECIMAL NUMERIC(P,S)  
    Més info a: [ enllaç diapositiva 4](https://docs.google.com/presentation/d/1r-hXZWLp6z_aXMl97AiiOFVvT_6t8HuUHqNFj5t58aU/edit#slide=id.gb7c51ac3b8_0_3)


  
>[!WARNING]
> Si posem `NUMERIC (8,2)` estem dient que acceptem un num de **8 xifres** i **2 decimals**.

---
### RESTRICCIONS INICI
Quan estem "definint" els atributs, hi ha 3 restriccions que podem posar:
* `NULL`: accepta valors nulls (no resposta) 
* `NOT NULL`: NO accepta valors nulls,obliga a introduir un valor
* `DEFAULT`: defineix un valor per defecte per si no li fem un insert
* `UNIQUE`: el valor introduit no es pot repetir

Exemple:
```sql
Nom varchar(30) DEFAULT 'Irie'
```

> [!NOTE]
>Per posar una data per defecte:  
>`DATA_NAIX DATE DEFAULT CURRENT_DATE;`


---
### CONSTRAINTS / RESTRICCIONS
* **PRIMARY KEY**  
Nomenclatura: PK_NomTaula
```sql
CONSTRAINT PK_TAULA PRIMARY KEY (nomAtribut),
```
 
* **FOREING KEY**  
Nomenclatura: FK_TaulaActual_TaulaForeing_nomAtribut  

```sql
CONSTRAINT FK_ALUMNE_PERSONA_nom FOREIGN KEY (nomAtribut) REFERENCES TAULAFOREING(nomAtribut)
```

>[!NOTE]  
> `ON DELETE CASCADE` al final de la FK per si borrem una dada es borri a tots llocs (a la taula actual i a la que fa referència)

---
### CHECK
Nomenclatura: CK_nomAtribut
```sql
CONSTRAINT CK_preu CHECK (preuVenda >0),
```
Tipus:  
* Més gran, més petit: `CHECK (atribut >0)`

* Valors concrets: `CHECK (nomAtribut IN ('valor1', 'valor2', 'valor3')`

* OR || : `CHECK (nomAtribut IN ('C', 'B'))`

* MAJUS : ` CHECK (nomAtribut = UPPER(nomAtribut))`  

* Primera lletra MAJUS:`CHECK (nomAtribut = INITCAP(nomAtribut)),`

+ Not null: `CHECK (nomAtribut IS NOT NULL)`

+ UNIQUE: `CONSTRAINT unique_name UNIQUE (nomAtribut)` !!!No CHECK! 


* ...

---

### COMENTARIS
* Comentari a la **taula**:
```sql
COMMENT ON TABLE nomTaula IS 'comentari que vull posar';
```

* Comentari a **columna** (atribut):
```sql
COMMENT ON COLUMN nomTaula.atribut IS 'comentari que vull posar';
```

>[!TIP]  
> Per veure el comentari: `\d+ nomTaula`

---


### ALTER
Per afegir/modificar algun atribut o restricció després d'haver creat la taula:  

* #### Canivar nom taula
```sql
-- canvio nom de la taula
ALTER TABLE nomTaula RENAME TO nomNou;
```
* #### Eliminar TAULA
```sql
--elimino taula
DROP TABLE nomTaula;
```
>[!WARNING]  
> Si no et deixa esborrar la taula perquè hi ha dependències (FK), afegeix `CASCADE`:  
```sql
--elimino taula
DROP TABLE nomTaula CASCADE;
```

---

* #### Afegir COLUMNA
```sql
-- afegeixo una columna
ALTER TABLE FITXA
    ADD nomColumna VARCHAR(5);

```

* #### Canviar nom COLUMNA
```sql
-- canvio nom d'una columna
ALTER TABLE FITXA
    RENAME COLUMN nomColumna TO CODI_POSTAL;
```

* #### Eliminar COLUMNA
```sql
ALTER TABLE nomTaula
DROP COLUMN nomColumna;
```

---

* #### Modificar tamany tipus
```sql
-- canvio longitud varchar
ALTER TABLE FITXA
ALTER COLUMN CODI_POSTAL TYPE VARCHAR(10);
```
> Si no et surt bé prova: `SET DATA TYPE VARCHAR(10)`

* #### Canivar tipus de dada
```sql
ALTER TABLE fitxa ALTER COLUMN Codi_Postal TYPE NUMERIC USING Codi_Postal::NUMERIC(5);
```

---
* #### Afegir RESTRICCIÓ
```sql
-- afegeixo restricció
ALTER TABLE FITXA
ADD CONSTRAINT CK_UPPER_PROV CHECK (PROVINCIA = UPPER(PROVINCIA));
```

* #### Canviar nom CONSTRAINT/RESTRICCIÓ
```sql
-- canvio nom d'una constraint
ALTER TABLE FITXA
    RENAME CONSTRAINT PK_FITXA TO PrimKey_Fitxa;
```

* #### Esborro RESTRICCIÓ
```sql
-- esborro restricció
ALTER TABLE FITXA
DROP CONSTRAINT CK_UPPER_PROV;
```

---

* #### Afegir DEFAULT o NOT NULL  o UNIQUE
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
UNIQUE
```sql
ALTER TABLE nomTaula
ADD CONSTRAINT nomColumna UNIQUE (telefono);
```

* Esborrar DEFAULT o NOT NULL
```sql
ALTER TABLE nomTaula
ALTER COLUMN nomColumna DROP DEFAULT;
```
---

### COMPROVAR
* Base de dades: `\l`
* Usuari: `\du`
* Taules: `\d`
* Comentaris: `\d+`
* Atributs i restriccions: `\d nomTaula`

### ELIMINAR
* #### Eliminar DATABASE
```sql
DROP DATABASE nomBaseDades;
```
* #### Eliminar TAULA
```sql
--elimino taula
DROP TABLE nomTaula;
```
>[!WARNING]  
> Si no et deixa esborrar la taula perquè hi ha dependències (FK), afegeix `CASCADE`:  
```sql
--elimino taula
DROP TABLE nomTaula CASCADE;
```

* #### Eliminar COLUMNA
```sql
ALTER TABLE nomTaula
DROP COLUMN nomColumna;
```

* #### Eliminar RESTRICCIÓ
```sql
-- eliminar restricció
ALTER TABLE FITXA
DROP CONSTRAINT CK_UPPER_PROV;
```
