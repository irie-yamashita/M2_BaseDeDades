
/*1. Mostra els departaments que el salari mitja dels seus treballadors és major o igual que la
mitja de tots els salaris.*/

-- Versió 1: (amb la mitjana de TOTS els sous, els que no tenen departament també)
SELECT *
FROM departments d
WHERE d.department_id IN (SELECT e.department_id
                            FROM employees e
                            GROUP BY e.department_id
                            HAVING AVG(e.salary) IN (SELECT AVG(e2.salary)
                                                        FROM employees e2));


/*CORRECCIÓ:
  * SOBRA la primera consulta, ja que només em demana el dept_id
  * NO és IN, és >=
*/

SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) >= (SELECT AVG(salary)
                      FROM employees);


/*2. Mostra el nom del departament que gasta més diners en les nòmines dels seus empleats i
quants són aquests diners.*/
SELECT d.department_name
FROM departments d
WHERE d.department_id = (SELECT e.department_id 
                         FROM employees e
                         GROUP BY e.department_id
                         HAVING sum(e.salary) = (SELECT MAX(sumes)
                                                 FROM (SELECT sum(e2.salary) as "sumes"
                                                       FROM employees e2
                                                       GROUP BY e2.department_id) as "a"));


-- no fa falta WHERE d.department_id = e.department_id en la primera subconsulta
SELECT e.department_id, sum(e.salary)
FROM employees e JOIN d.departament_id USING(departament_id)
GROUP BY department_id
HAVING sum(e.salary) = (SELECT MAX(sumes)
                        FROM (SELECT sum(e2.salary) as "sumes"
                              FROM employees e2
                              GROUP BY e2.department_id) as "a");


/*3. Mostra els noms i cognoms dels empleats més antics de cada departament.*/
SELECT e.first_name, e.last_name
FROM employees e
WHERE e.department_id IS NOT NULL
  AND e.hire_date IN (SELECT MIN(e2.hire_date)
                      FROM employees e2
                      GROUP BY e2.department_id);

-- o també...
SELECT e.first_name, e.last_name
FROM employees e
WHERE e.hire_date = (SELECT MIN(e2.hire_date)
                      FROM employees e2
                      WHERE e.department_id = e2.department_id);



/*4. Mostra totes les dades d'aquells departaments que tinguin empleats que hagin finalitzat el seu contracte entre el gener de l'any 1992 i el desembre de l'any 2001.*/
SELECT d.*
FROM departments d
WHERE d.department_id IN (SELECT e.department_id
                          FROM employees e
                          WHERE e.job_id IN (SELECT j.job_id
                                             FROM job_history j
                                             WHERE j.end_date BETWEEN '1992-01-01' AND '2001-12-31'));

--data en format YYYY-MM-DD

SELECT *
FROM departments d
WHERE EXISTS (SELECT *
              FROM job_history j
              WHERE d.department_id= j.department_id
                AND j.end_date BETWEEN '1992-01-01' AND '2001-12-31');
