# CONSULTES

[Apunts internet](https://es.slideshare.net/nicola51980/)  

## INTRODUCCIÓ
Una consulta bàsica conté:
+ `SELECT`: per seleccionar les dades que es mostraran
+ `FROM`: per indicar de quina o quines taules són les dades
+ `WHERE`: la condició, limita les dades a seleccionar


```sql
SELECT *
FROM employees;
```
```sql
SELECT *
FROM employees
WHERE salary > 1000;
```
> [!NOTE]  
> `*` -> selecciona tot de la taula


## CONSULTES BÀSIQUES
[Apunts Consultes Bàsiques](https://es.slideshare.net/nicola51980/postgresql-leccin-2-restringiendo-y-ordenando-los-datos-retornados-por-el-comando-select)

### OPERADORS
* **LÒGICS**  
Per poder fer **condicions múltiples** necessito utilitzar els **operadors lògics**:  `AND, OR i NOT`
> Equivalent a kotlin: &&, ||

* **COMPARACIÓ**  
Aquests són tots els operadors de comparació:  

|      **Operadors de COMPARACIÓ**    |
|-------------------------------------|
|      `=, >, <, >=, <=, !=, < >`     |
|  `IN, NOT IN, BETWEEN, NOT BETWEEN` |
|     `DISTINCT` `LIKE` `ILIKE`       |
|             `IS NULL`               |