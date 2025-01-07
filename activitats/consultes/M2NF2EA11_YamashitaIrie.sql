
/*EA11. Agrupacions en multitaules*/


/*1. Calcular el nombre empleats que realitzen cada ofici a cada departament.
Les dades que es visualitzen són: codi del departament, ofici i nombre empleats.*/
SELECT d.department_id, j.job_id, count(*)
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id AND
      e.job_id = j.job_id
GROUP BY d.department_id, j.job_id;

/*2. Mostra el nom del departament i el número d'emplets que té cada departament.*/
SELECT  d.department_name, count(*)
FROM departments d, employees e
WHERE d.department_id = e.department_id
GROUP BY d.department_id;

/*3. Mostra el número d'empletas del departamant de 'SALES'.*/
SELECT department_name, count(*)
FROM employees e, departments d
WHERE d.department_id = e.department_id AND
    upper(d.department_name) LIKE 'SALES'
GROUP BY d.department_name;

/*Alternativa amb HAVING:
SELECT department_name, count(*)
FROM employees e, departments d
WHERE d.department_id = e.department_id
GROUP BY d.department_name
HAVING upper(d.department_name) LIKE 'SALES';
*/


/*4. Mostra quants departaments diferents hi ha a Seattle.*/
SELECT d.department_id, count(*)
FROM departments d, locations l
WHERE d.location_id = l.location_id AND
       l.city LIKE 'Seattle'
GROUP BY d.department_id;


/*5. Mostra per cada cap (manager_id), la suma dels salaris dels seus empleats, però només, per aquells casos en els quals la suma del salari dels seus empleats sigui més gran que 50000. */
SELECT m.manager_id, sum(e.salary)
FROM employees e, employees m
WHERE e.manager_id = m.employee_id AND m.manager_id IS NOT NULL
GROUP BY m.manager_id
HAVING sum(e.salary) > 50000;

/*6. Mostra per cada cap (manager_id) quants empleats tenen al seu carrec i quin és el salari
màxim, però només per aquells caps amb més de 6 empleats al seu càrrec.*/
SELECT m.manager_id, count(*) AS n_empleats, MAX(e.salary)
FROM employees e, employees m
WHERE m.manager_id = e.employee_id
GROUP BY m.manager_id
HAVING count(*) > 6;


/*7. Fes al mateix que a la consulta anterior, però només per aquells caps que tinguin com a
id_manager_id 100, 121 o 122. Ordena els resultats per manager_id.*/
SELECT m.manager_id, count(*) AS n_empleats, MAX(e.salary)
FROM employees e, employees m
WHERE m.manager_id = e.employee_id AND
      m.manager_id IN ('100','121','122')
GROUP BY m.manager_id
HAVING count(*) > 6
ORDER BY  m.manager_id;