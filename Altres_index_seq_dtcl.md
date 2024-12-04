# ALTRES SENTÈNCIES
Contingut:  `INDEX, VISTES, SEQUENCE i TCL: COMMIT, ROLLBACK, SAVE POINT...`  
Enllç info: [exemple4](https://classroom.google.com/c/NzA1MTYyMjgyNDU1/m/NzE2OTU5NTA0OTM3/details)  
Enllaç activitat: [M2NF3_EA6](activitats/M2NF3EA6_YamashitaIrie.sql)
## ÍNDEX DOCUMENT
1. [INDEX](#index)
2. [VISTES](#vistes)
3. [SEQUENCE](#sequence)
    - [Borrar seqüència](#borrar-sequence)
    - [Default](#sequence-per-defecte)
    - [Serial](#serial)
4. [TRANSACCIONS](#transaccions)
    - [BEGIN](#begin)
    - [COMMIT](#commit)
    - [ROLLBACK](#rollback)
    - [SAVEPOINT](#savepoint)
    - [ROLLBACK TO](#rollback-to)


Igual que podem crear TABLES, podem crear altres tipus d'objectes com `INDEX`, `VISTES` o `SEQÜÈNCIES`.

>[!TIP]  
> Comprovació:
>```sql
>\d
>```

>[!WARNING]  
> Eliminar:
>```sql
>DROP TABLE nomOBJECTE;
>```
>



### INDEX
Pel que jo he entès, l'index et serveix perquè la màquina trobi abans el que consultes. Crees com una mena de **drecera**.  
Però no es veu visualment, la millora és interna.

Hi ha **2** tipus d'ÍNDEXS:
* Index normal
* Index **UNIQUE**

**CREATE Índexs:**  
Normal:
```sql
CREATE INDEX Cognom1_index
ON PERSONA(COGNOM1);
```

Unique:  
```sql
-- Creem un nou índex per el campo TELEFON de la taula PERSONA
CREATE UNIQUE INDEX Telefon_index
ON PERSONA(TELEFON);
```

>[!TIP]  
> Comprovació: `\d nomTAULA`

### VISTES
Les vistes en serverixen per:
* Veure menys valors d'una taula
```sql
CREATE VIEW DADES_PER
AS (SELECT NOM, COGNOM1, TELEFON
FROM PERSONA);
```
>Fem consula:  
>`SELECT * FROM DADES_PER;`

* Veure valors de **dues taules**
```sql
CREATE VIEW DADES_PROF
AS (SELECT PERSONA.NOM,PERSONA.COGNOM1, PROFESSOR.ESPECIALITAT
FROM PERSONA, PROFESSOR WHERE PERSONA.DNI = PROFESSOR.DNI_PROF);
```
>Fem consula:  
>`SELECT * FROM DADES_PROF;`

>[!TIP]  
>Comprovació: `\d`


>[!WARNING]  
>Si l'has cagat i vols BORRAR (com una taula qualsevol):  
>`DROP TABLE nomVISTA;`

### SEQUENCE
*Es un objeto de base de datos que genera números de manera secuencial*  
Com una mena de funció que cada cop q la crides creix/decreix seqüencialment i retona un número. `i++`

* CREAR seqüència:
```sql
--Creem una seqüència:
CREATE SEQUENCE ARXIUID_SEQ
INCREMENT 10
START WITH 100
MAXVALUE 999999;
```

>[!TIP]  
>Compravació: `\d`

* INSERIR seqüència:  
```sql
INSERT INTO ARXIU (ID,NOM) VALUES (NEXTVAL('ARXIUID_SEQ'), 'Empreses');
```
>[!TIP]  
>Compravació: `SELECT * FROM nomTaula;`

* MIRAR valor seqüència:
```sql
--Mirem quin valor té la seqüència (has de fer mínim un NEXTVAL())
SELECT CURRVAL('ARXIUID_SEQ');
```

* #### BORRAR sequence
Si sense voler et passes una seqüència pots: BORRAR SEQ i tronar-la a cridar.  
```sql
DROP SEQUENCE PROVA_SQ;
```

>Tornar-la a crear i fer un UPDATE al valor amb la seqüència.
```sql
UPDATE nomTaula SET nomColumna = NEXTVAL('ARXIUID_SEQ') WHERE nomColumna = "valorPK" ;
```

* #### SEQUENCE per DEFECTE
>[!NOTE]  
>Podem posar una seqüència per **DEFECTE**:
```sql
CREATE TABLE ARXIU (
ID INTEGER DEFAULT NEXTVAL('ARXIUID_SEQ'),
NOM VARCHAR(60) NOT NULL,
);

```

* #### SERIAL
També puc crear un camp de tipus SERIAL.
```sql
CREATE TABLE ARXIU (
ID SERIAL,
NOM VARCHAR(60) NOT NULL,
PRIMARY KEY ( ID )
);
```

>[!WARNING]  
> A l'hora de fer l'INSERT, l'**ignorem**, com si no estigués:

```sql
INSERT INTO ARXIU (NOM) VALUES ('Empreses');
```

### TRANSACCIONS
* #### BEGIN
Com que no tenim autocommit, cada cop que vulguem fer un COMMIT, hem d'escriure la instrucció. 
```sql
BEGIN;
```

>[!WARNING]  
>Les transaccions finalitzen quan fas COMMIT; Si després de fer el COMMIT; vols seguir fent transaccions has de tonar a executar el BEGIN;


* #### COMMIT
Desar els canvis **permanentment**
```sql
COMMIT;
```
>[!WARNING]  
>Si no et funciona, comprova que has fet el `BEGIN;`

* #### ROLLBACK
Per tornar al commit anterior fer:  
```sql
ROLLBACK;
```

> Comprovació: `SELECT * FROM FITXA;`

* #### SAVEPOINT
És com un commit temporal, un breakpoint.  

**CREAR savepoint:**
```sql
SAVEPOINT nomPunt;
```

* #### ROLLBACK TO
Em serveix per refer els canvis fins un `SAVEPOINT` concret:
```sql
--Desfer les operacions fins a la marca intE.
ROLLBACK TO intE;

--Resposta: Hem desfet els canvis fets entre la marca intE i intF.
```


