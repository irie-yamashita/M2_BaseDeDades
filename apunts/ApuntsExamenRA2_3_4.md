# APUNTS EXAMEN RA2 + RA3 + RA4
Apunts per utilitzar les consultes a DDL i DML (crec).


## Comprovar
Consulta per comprovar si un INSERT, UPDATE o DELETE ha estat realitzat correctament.

```sql

--tots els valors de la taula
SELECT *
FROM nomTaula;

--tots els valors d'una columna (ex: department_name)
SELECT nomColumna
FROM nomTaula;

--amb filtre WHERE
SELECT nomColumna
FROM nomTaula
WHERE nomColumna ='valor';
```

## UPDATE
Per canviar un valor concret:  
```sql
UPDATE nomTaula
SET nomColumna = 'valor'
WHERE condició;
```

Exemple:
```sql
Update Fitxa
SET telefon = 969231256
WHERE dni = 3421232;
```

## DELETE
Per esborrar una fila(row) concreta:
```sql
DELETE
FROM nomTaula
WHERE nomColumna = 'valor';
```
Exemple:  
```sql
DELETE
FROM Fitxa
WHERE dni = '3421232';
```