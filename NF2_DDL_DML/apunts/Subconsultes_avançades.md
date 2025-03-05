# SUBCONSULTES AVANÇADES


Prenem com exemple el següent exercici:

```sql
/*3.	Mostra el cognom, el número de departament i el salari dels empleats que tenen el salari més alt del seu departament. Ordena els resultats 
per número de departament  */
select last_name, department_id , salary 
from employees e1 
where salary = (select(max(e2.salary)) 
				from employees e2 
				where e1.department_id = e2.department_id )
order by department_id;
```
Aquí trobem 2 CONSULTES: consulta externa + subconsulta .  
La subconsulta està **correlacionada** en el moment que fem `where e1.department_id = e2.department_id`.

FILES:  
García	1	3000
Pérez	1	5000
Sánchez	1	4000
Ruiz 	2	3500
López	2	4500
Torres	3	6000
Ruiz	3	6500  


Procediment:  
1. Anem a la **subconsulta**. Com és una subconsulta correlacionada repetirà/evaluarà la subconsulta per cada fila de la consulta externa (7 cops). Mira valor de `e1.department_id` = 1.
2. Ara la subconsulta només seleccionarà les files amb el `department_id = 1` i farà el `MAX()` de les files seleccionades (les que tenen dept_id = 1) i el retorna. -> 5000
3. Ara passem a la **consulta externa**... El salary de la primera fila és = 5000? No -> no passa el filtre (WHERE), no el mostrarà.
4. Passem a la següent fila (Pérez	1	5000);


A mi em sortiria fer un GROUP BY, però no fa falta.