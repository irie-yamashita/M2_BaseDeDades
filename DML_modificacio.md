# DML
Contingut:  `INSERT, UPDATE, DELETE i SELECT`

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
|----------------------------------------------------|
| `INSERT INTO` nomtaula  (camps/atributs Taula) `VALUES` (valors) |

* Puc fer-ho posat els atributs i valors:
```sql
INSERT INTO empleat (ID,LAST_NAME, FIRST_NAME, USERID, SALARY) VALUES (1, 'Patel',
'Ralph', 'rpatel', 895);
```

* Posant només TOTS els valors:
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
```sql
SELECT * FROM nomTaula;
```

```sql
SELECT nomColumna FROM nomTaula WHERE atribut='valor';
```

### UPDATE
```sql
UPDATE nomTaula SET nomColumna = valor WHERE condició;
```
Comprovació: `SELECT nomColumna FROM nomTaula`

### BORRAR COSES

* **BUIDAR TAULA**:  TRUNCATE TABLE  
```sql
TRUNCATE TABLE nomTaula;
```
o també:
```sql
DELETE FROM nomTaula;
```
>[!WARNING]
> No és el mateix que `DROP`. DROP borra TOT,  estructura i valors de la taula.


* **BUIDAR FILA**:  DELETE  
Normalment triem la `primary key` en el WHERE perquè així no es repeteix.
```sql
DELETE FROM nomTaula WHERE nomColumna = "valorPK";
```

* **BUIDAR VALOR**:  UPDATE  
En comptes de `NULL` pots utilitzar `DEFAULT`.
```sql
UPDATE nomTaula SET nomColumna = NULL WHERE nomColumna = "valorPK" ;
```

