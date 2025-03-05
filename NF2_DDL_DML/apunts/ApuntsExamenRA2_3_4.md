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


## Test existència
Seria equivalent a fer un `IN (SUBCONSULTA)` on la SUBCONSULTA, però relacionant la subconsulta amb la consulta exterior.

`WHERE EXISTS` -> `IN (SUBCONSULTA)`
`WHERE NOT EXISTS` -> `NOT IN (SUBCONSULTA)`

**EXEMPLE 1:**  
```sql
/*1.	Mostra els noms dels departaments que tinguin empleats */

--Amb test d'existència
SELECT department_name
FROM departments d1
WHERE EXISTS (SELECT *
              FROM employees e
              WHERE d1.department_id = e.department_id);
```

> És indiferent el que posem en el SELECT de la subconsulta. Posem `*` per exemple.

```sql
--Amb subconsulta simple
select department_id, department_name
from departments
where department_id in (select distinct department_id from employees);
```
  
**EXEMPLE 2:**  

```sql
/*4.	Mostra totes les dades dels departaments que comencin per R que no tinguin empleats.*/

select * 
from departments d 
where d.department_name like 'R%'and NOT EXISTS
(select *
from employees e 
where e.department_id=d.department_id );
```

## TRUCS
* [consulta + subconsulta] Per saber si he de fer un `GROUP BY` a la consulta exterior, fixa't si et demana que mostris un COUNT o MAX o MIN o AVG o SUM...