# QUERIES

[Apunts internet](https://es.slideshare.net/nicola51980/)  

## ÍNDEX
* [Introducció](#introducció)
* [Consultes bàsiques](#consultes-bàsiques)
  * [Operadors lògics (AND, OR, NOT)](#operadors-lògics)
  * [Operadors de comparació](#operadors-de-comparació)
    + [=, >, <, >=, <=, !=, < >](#operadors-bàsics)
    + [LIKE](#like-equals)
        + [Patrons de búsqueda: % i _](#patrons-de-búsqueda--i-_)
    + [BETWEEN AND](#between-and)
    + [IN](#in-and-and-and)
    + [IS NULL](#is-null)
  * [Operadors matemàtics](#operadors-matemàtics)
* [FUNCIONS ()](#funcions)
    + [Manipulació de TEXT](#manipulació-text)
      + [LOWER, UPPER, INITCAP](#lower-upper-i-initcap)
      + [SUBSTRING, POSITION, TRIM, LENGTH, REPLACE...](#manipulació-de-text)
    + [Manipulació numèrica (round, trunc...)](#manipulació-numèrica)


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

### Operadors lògics
Per poder fer **condicions múltiples** necessito utilitzar els **operadors lògics**:  `AND, OR i NOT`


### Operadors de COMPARACIÓ
Aquests són tots els operadors de comparació:  

|      **Operadors de COMPARACIÓ**    |
|-------------------------------------|
|      `=, >, <, >=, <=, !=, < >`     |
|  `IN, NOT IN, BETWEEN, NOT BETWEEN` |
|     `DISTINCT` `LIKE` `ILIKE`       |
|             `IS NULL`               |



* #### **Operadors bàsics**
`=, >, <, >=, <=, !=, < >`  
Funcionen igual que a programació:    
  ```sql
  WHERE employee_id = 176;
  ```

  ```sql
  WHERE salary > 12000;
  ```


* #### **LIKE (.equals)**
Amb els textos no podem utilitzar el `=`, llavors hem d'usar el `LIKE`:

  ```sql
  WHERE last_name LIKE 'Lopez';
  ```

>[!TIP]
> Pots utilitzar `ILIKE` que és el mateix, però no és **case sensitive**.

  * ##### **Patrons de búsqueda % i _**
  És molt comú utilitzar patrons de búsqueda `%` i `_` a l'hora de d'utilitzar el `LIKE`:
  ```sql
  -- noms que tinguin com a SEGONA lletra una 'a'
  WHERE first_name LIKE '_a%';
  ```
  > El `_` (guió baix) indica qualsevol caràcter, el `%` (comodín) és qualsevol cosa (d'un caràcter a molts).




* #### BETWEEN AND  
    * **Números**
    ```sql
    WHERE salary BETWEEN 5000 AND 12000;
    ```
    * **Dates**
    ```sql
    WHERE hire_date BETWEEN '20-02-1998' AND '01-05-1998;
    ```

> [!NOTE]  
> També puc fer un `NOT BETWEEN x AND x`

* #### IN (and and and)
  Per evitar fer:  
  ```sql
  WHERE department_id = 20 AND department_id = 50 AND department_id = 60;
  ```
  Puc fer un `IN`:    
  ```sql
  WHERE department_id IN(20,50,60);
  ```

> [!NOTE]  
> També puc fer un `NOT IN()`

* #### IS NULL
Per quan volem triar aquelles dades que són o no nul·les:
  ```sql
  WHERE commission_pct IS NOT Null;
  ```

### Operadors MATEMÀTICS
* `+ , -, *, /`
* mòdul: `%`
* elevat, arrel quadrada, arrel cúbica: `^, |/, ||/`

## FUNCIONS
### Manipulació TEXT
* #### LOWER, UPPER i INITCAP
Funció per posar en minúscules o majúscules una dada. Pot estar en el SELECT o en el WHERE:  

  ```sql
  SELECT UPPER(last_name), LOWER(first_name); -- LÓPEZ maria
  ```
  ```sql
  WHERE LOWER(last_name) LIKE 'lopez';
  ```
    ```sql
  SELECT initcap(first_name), initcap(last_name)
  FROM employees;
  ```
### Altres
| Funció                                | Retorna  |  Resultat | Explicació              |
|---                                    |---       |---        |---                      |
|  **SUBSTRING**('Thomas' from 1 for 3) |   text   | Tho       | Extreure text a partir d'una posició concreta (inici i fi) |
|  SUBSTR ('Thomas', 3)                 |   text   | omas      | Igual que *substring*, però només amb posició inicial   |
|  **LENGTH** ('jose')                  |   int    | 4         | Equivalent a .length() de String |
|  STRPOS ('high', 'ig')                |   int    | 2         | Equivalent a *indexOf* |
|  POSITION('ana' IN 'maria')           |   int    | -1        | Equivalent a *indexOf* |
|  REPEAT ('Pg', 4)                     |   text   | PgPgPgPg  | Repeteix un text *n* cops |
|  RPAD ('hi', 5, '*')                  |   text   | hi***     | Omple un text amb un caràcter (o més), fins arribar a la *size* especificada |
|  REPLACE ('colomer', 'o', '#')        |   text   | c#l#mer | Reemplaça totes les ocurrències d'un text per un altre. |
|  TRIM('   joan    ')                  |   text   | joan    | Treu espais inicials i finals d'un text |

>[!WARNING]
> Sembla que aquí els índexs dels texts comencen per 1!!!

### Manipulació NUMÈRICA
| Funció             | Retorna  |  Resultat | Explicació                        |
|---                 |---       |---        |---                                |
|  ROUND (42.438, 2) |   int    | 42.44     | Arrodoneix                        |
|  TRUNC (42.438, 2) |   int    | 42.43     | No arrodoneix, simplement talla   |
|  MOD (9, 4)        |   int    | 1         | Equivalent a **%**, el residu     |

**Altres:** `factorial(), log(), pi(), sqrt()`...  


ORDER BY
puc fer-lo amb el nom del camp o amb l'índex.

---

COALESCE

---

**FUNCIONS**: max, min, average, count, sumS

---

**cOUNT**: compta les files, el num d'inserts (en veritat té en compte la clau primària, però com no es pot repetir...)

---

**GROUP**: [text](https://es.slideshare.net/slideshow/postgresql-leccin-4-usando-funciones-para-manipular-grupos-de-datos/12641455)
Té sentit fer agrupacions quan els valors s'em repeteixen. No té sentit fer una agrupació per la clau primària.

---

**Having**: és per "manipular" la info que ja ha estat seleccionada. Fer com una segona selecció. Es fa després d'un GROUP BY, i normlament després d'haver fet un `sum, avg,max, min`...
```sql
/*8. Mostra l’id del departament i el número d’empleats dels departaments amb més de 4
empleats.*/
SELECT department_id, count(*)
FROM employees
GROUP BY department_id
HAVING count(*) > 4;
```

---
CANVIAR NOM COLUMNA:
```sql
SELECT job_id, SUM(salary) AS "sous"
```

> [!NOTE]  
> La taula passarà de dir-se "SUM(salary)" a "sous"

---

```sql
SELECT job_id, sum(salary) -- vull que em mostri la columna job_id i la suma de salaris (de cada un dels empleats)
FROM employees -- les dades són de la taula employees
WHERE job_id NOT LIKE '%REP%' -- descarto els empleats que siguin _REP_
GROUP BY job_id -- agrupo per jobs_id (es crearan tants grups com job_id diferents hi hagi)
HAVING sum(salary) > 1300 -- d'aquests grups fets, descarto els que la suma de tots els salaris del grup sigui > 1300
ORDER BY sum(salary) -- ordeno per salaris
```

## MULTITAULA
He de fer un **FROM** de 2 taules. Però li he d'afegir una **condició** fent referència a la clau forana.
```sql
SELECT t1.nomCamp, t2.nomCamp
FROM taula1 t1, taula2 t2
WHERE t1.nomCampPK = t2.nomCampFK;
```

**Exemple:**
```sql
SELECT e.first_name, d.department_name  --!!! He d'especificar de quina taula venen
FROM employees e, departments d         --FROM de 2 taules, li poso una abreviatura
WHERE d.department_id=e.department_id;  --CONDICIÓ: sobre la clau forana
```


## 19/12/2024
/*APUNTS*/

  lenght(last_name)>6

**REFLEXIVES**  
```sql
/*10. Mostra el cognom i el job_id dels empleats que tinguin el mateix ofici que el seu cap i
mostra el nom del cap.*/
SELECT e.last_name, e.job_id
FROM employees e, employees m
WHERE e.manager_id = m.employee_id AND
      e.job_id = m.job_id;

```



### MANIPULAR DATES
* TO_CHAR
* BETWEEN
* EXTRACT

### Renombrar COLUMNES
* AS
```sql
SELECT manager_id, count(*) AS n_empleats, MAX(salary)
FROM employees
GROUP BY m.manager_id
HAVING count(*) > 6;
```
* 
```sql
SELECT manager_id "Manager ID", sum(salary) "Suma salaris"
FROM employees
GROUP BY manager_id
HAVING sum(salary) > 50000;
```


## JOIN
Serveix per unir taules, per defecte és `INNER JOIN`.
Tenim diferents maneres de fer el `JOIN`:   

* ON  
```sql
SELECT *
FROM employees e JOIN departments d
ON (d.department_id = e.department_id)
WHERE (e.first_name LIKE 'Joan');
```
Però puc treure el `WHERE` i posar-ho tot en el `ON`
```sql
SELECT *
FROM employees e JOIN departments d
ON (d.department_id = e.department_id) AND (e.first_name LIKE 'Joan');
```

* USING  
```sql
SELECT *
FROM employees e JOIN departments d
USING (department_id)
WHERE (e.first_name LIKE 'Joan');
```

* NATURAL JOIN  
No fa falta dir-li la condició.
```sql
SELECT *
FROM employees e NATURAL JOIN departments d
WHERE (e.first_name LIKE 'Joan');
``` 

### OUTER JOIN
El problema del JOIN normal (INNER), és que no agafarà aquelles dades que no compleixin la condició de **ON PK = FK**. Per exemple, no agafaria els employees que tenen el department null i descartaria aquells departaments els quals no apareixen a la taula employees. Per això fem un `º`


**RESUM**  
* [INNER] JOIN
---
* LEFT [OUTER] JOIN
* RIGHT [OUTER] JOIN
* FULL [OUTER] JOIN
---
* CROSS JOIN
* NATURAL JOIN



### SUBCONSULTES AVANÇADES
Mostra l'ID i el número d'empleats del departament que tingui més empleats (exemple 5)

Passos:
Necessito el ID del departament amb més empleats. Però no tinc un atribut que és Nº empleats, l'he de trobar amb un count(empleat_id) i GROPU BY.


```sql
SELECT e1.department_id, count(e1.employee_id)
FROM employees e1
GROUP BY e1.department_id
HAVING  count(e1.department_id) = (SELECT MAX(maxims)
                                   FROM (SELECT count(e2.employee_id) as "maxims"
                                         FROM employees e2
                                         GROUP BY e2.department_id) as "a");
``` 

1. Trobo QUANTS empleats té cada departament amb un GROUP by department_id:
```sql
SELECT count(e2.employee_id) as "maxims"
FROM employees e2
GROUP BY e2.department_id;
```

>Li poso nom al que em retornarà (SELECT) as "maxims"

2. Ara faig la consulta per saber el MAX utilitzant el que em retorna la consulta anterior utilitzant l'àlies `maxims`:
```sql
(SELECT MAX(maxims)
FROM (SELECT count(e2.employee_id) as "maxims"
      FROM employees e2
      GROUP BY e2.department_id) as "a");
```

>Li poso nom al que em retornarà (SELECT) as "a"