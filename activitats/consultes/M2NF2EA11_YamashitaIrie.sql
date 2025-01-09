
/*EA11. Agrupacions en multitaules*/


/*1. Calcular el nombre empleats que realitzen cada ofici a cada departament.
Les dades que es visualitzen són: codi del departament, ofici i nombre empleats.*/
SELECT department_id, job_id, count(*) "Nº empleats"
FROM employees
GROUP BY department_id, job_id;

-- No fa falta juntar amb department, perquè department_id ja existeix a employee. (si em demanés department_name sí que ho hauria de fer)

/*2. Mostra el nom del departament i el número d'emplets que té cada departament.*/
SELECT  d.department_name, count(*)
FROM departments d, employees e
WHERE d.department_id = e.department_id
GROUP BY d.department_id;

/*3. Mostra el número d'empletas del departamant de 'SALES'.*/
SELECT d.department_name, count(*)
FROM employees e, departments d
WHERE e.department_id = d.department_id AND
      upper(d.department_name) LIKE 'SALES'
GROUP BY d.department_id;

/*Alternativa amb HAVING:
SELECT department_name, count(*)
FROM employees e, departments d
WHERE d.department_id = e.department_id
GROUP BY d.department_name
HAVING upper(d.department_name) LIKE 'SALES';
*/


/*4. Mostra quants departaments diferents hi ha a Seattle.*/
SELECT l.city, count(*) "Nº departaments"
FROM departments d, locations l
WHERE d.location_id = l.location_id AND
       l.city LIKE 'Seattle'
GROUP BY l.city;

--group by city, no department


/*5. Mostra per cada cap (manager_id), la suma dels salaris dels seus empleats, però només, per aquells casos en els quals la suma del salari dels seus empleats sigui més gran que 50000. */
SELECT manager_id, sum(salary) "Suma salaris"
FROM employees
GROUP BY manager_id
HAVING sum(salary) > 50000;
-- NO fa falta que uneixis employees i manager. Si demanés el nom del cap.


/*6. Mostra per cada cap (manager_id) quants empleats tenen al seu carrec i quin és el salari
màxim, però només per aquells caps amb més de 6 empleats al seu càrrec.*/
SELECT manager_id "Id Manager", count(*) "Nº empleats", MAX(salary) "Salari màxim"
FROM employees
GROUP BY manager_id
HAVING count(*) > 6;


/*7. Fes al mateix que a la consulta anterior, però només per aquells caps que tinguin com a
id_manager_id 100, 121 o 122. Ordena els resultats per manager_id.*/
SELECT manager_id "Id Manager", count(*) "Nº empleats", MAX(salary) "Salari màxim"
FROM employees
WHERE manager_id IN ('100','121','122')
GROUP BY manager_id
HAVING count(*) > 6
ORDER BY  manager_id;