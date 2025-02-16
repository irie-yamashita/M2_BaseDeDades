# DML
Contingut:  `INSERT, UPDATE, DELETE i SELECT`  
Comprovació: `SELECT * FROM nomTaula;` o `SELECT nomColumna FROM nomTaula WHERE (condició)`

## ÍNDEX
1. [INSERT](#insert)
2. [SELECT](#select)
3. [UPDATE](#update)
4. [BORRAR COSES](#borrar-coses)
    - [BUIDAR TAULA](#buidar-taula)
    - [BUIDAR FILA](#buidar-fila)
    - [BUIDAR VALOR](#buidar-valor)


### INSERT
| **Nomenclatura:**
|--------------------------------------------------------------------------------------|
| `INSERT INTO` nomtaula  (columna1(atribut), columna2...) `VALUES` (valor1,valor2...) |

* Puc fer-ho posat els atributs i valors:
```sql
INSERT INTO empleat (ID,LAST_NAME, FIRST_NAME, USERID, SALARY) VALUES (1, 'Patel',
'Ralph', 'rpatel', 895);
```

* Posant només tots els VALORS:
```sql
INSERT INTO empleat VALUES (1, 'Patel', 'Ralph', 'rpatel', '895');
```

>[!NOTE]  
> Sino vull posar-li un valor puc posar: `NULL` o `DEFAULT`

>[!WARNING]
> `NULL` i `DEFAULT` NO són el mateix. 

Comprovació: `SELECT * FROM nomTaula`  
`SELECT nomColumna FROM nomTaula`


### SELECT
Em serveix per consultar valors inserits:
* Tota la BASE de DADES
```sql
SELECT *;
```
* Tots els valors TAULA
```sql
SELECT * FROM nomTaula;
```

* Tots els valors d'una COLUMNA
```sql
SELECT nomColumna FROM nomTaula;
```
>[!NOTE]  
>També pots mirar dos columnes a l'hora posant `SELECT nomColumna1,nomColumna2 FROM nomTaula;`


* VALOR concret filtrada (amb WHERE)
```sql
SELECT nomColumna FROM nomTaula WHERE atribut='valor';
```

### UPDATE
```sql
UPDATE nomTaula SET nomColumna = valor WHERE condició;
```
Comprovació: `SELECT nomColumna FROM nomTaula`

### BORRAR COSES

* #### BUIDAR TAULA
`  TRUNCATE TABLE  `  
```sql
TRUNCATE TABLE nomTaula;
```
o també:
`  DELETE  `  
```sql
DELETE FROM nomTaula;
```
>[!WARNING]
> No és el mateix que `DROP`. DROP borra TOT,  estructura i valors de la taula.


* #### BUIDAR FILA
`  DELETE  `  
Normalment triem la `primary key` en el WHERE perquè així no es repeteix.
```sql
DELETE FROM nomTaula WHERE nomColumna = 'valorPK';
```

* #### BUIDAR VALOR
`  UPDATE  `  
En comptes de `NULL` pots utilitzar `DEFAULT`.
```sql
UPDATE nomTaula SET nomColumna = NULL WHERE nomColumna = 'valorPK';
```

