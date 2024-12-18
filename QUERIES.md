# QUERIES

[Apunts senyor](https://es.slideshare.net/nicola51980/)  

## INTRODUCCIÓ
Una consulta bàsica conté: `SELECT`, `FROM` (i `WHERE`).

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

* #### =
    ```sql
    WHERE employee_id = 176;
    ```

* #### LIKE (equals)
Amb els textos no podem utilitzar el `=`, llavors hem d'usar el `LIKE`:


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



ORDER BY
puc fer-lo amb el nom del camp o amb l'índex.

---

COALESCE

---

**FUNCIONS**: max, min, average, count, sum

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