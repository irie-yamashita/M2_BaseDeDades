
/*1. Mostra els departaments que el salari mitja dels seus treballadors és major o igual que la
mitja de tots els salaris.*/

-- Versió 1: (amb la mitjana de TOTS els sous, els que no tenen departament també)
SELECT *
FROM departments d
WHERE d.department_id IN (SELECT e.department_id
                            FROM employees e
                            GROUP BY e.department_id
                            HAVING AVG(e.salary) >= (SELECT AVG(e2.salary)
                                                        FROM employees e2));

-- Versió 2:
SELECT *
FROM departments d
WHERE d.department_id IN (SELECT e.department_id
                            FROM employees e
                            GROUP BY e.department_id
                            HAVING AVG(e.salary) >= (SELECT AVG(e2.salary)
                                                        FROM employees e2
                                                        WHERE e2.department_id = d.department_id));


/* PASSOS

-- part 1 (tot de departaments)
SELECT *
FROM departments;
--WHERE id = ...

-- part 2 (mitjana de cada departament)
SELECT e.department_id,  round(AVG(e.salary), 2)
FROM employees e
GROUP BY e.department_id;
-- HAVING AVG(e.salary) >= ...

-- part 3  (mitajana de tots els sous)
SELECT AVG(e2.salary) as "mitjanaTotal"
FROM employees e2;

*/

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

/* PASSOS
-- part 1
SELECT d.department_name
FROM departments d
WHERE d.department_id = ... 

-- part 2      
SELECT e.department_id -- Compte, que he posat d.department_id en comptes de e.department_id
FROM employees e
WHERE d.department_id = e.department_id -- !! important això
GROUP BY e.department_id
HAVING sum(e.salary) = ...;

-- part 3
SELECT MAX(alies)
FROM (consulta)

-- part 4
SELECT sum(e2.employee_id)
FROM employees e2
GROUP BY e2.department_id;

*/

/*3. Mostra els noms i cognoms dels empleats més antics de cada departament.*/
SELECT e.first_name, e.last_name
FROM employees e
WHERE e.department_id IS NOT NULL
  AND e.hire_date IN (SELECT MIN(e2.hire_date)
                      FROM employees e2
                      GROUP BY e2.department_id);

/*PASSOS
-- part 1
SELECT e.first_name, e.last_name, e.department_id -- department_id (provisional)
FROM employees e
WHERE e.hire_date IN ('4564');

-- part 2
SELECT MIN(hire_date) --Aclaració: el més antic és el MIN()
FROM employees
GROUP BY department_id;
*/



/*4. Mostra totes les dades d'aquells departaments que tinguin empleats que hagin finalitzat el seu contracte entre el gener de l'any 1992 i el desembre de l'any 2001.*/
SELECT d.*
FROM departments d
WHERE d.department_id IN (SELECT e.department_id
                          FROM employees e
                          WHERE e.job_id IN (SELECT j.job_id
                                             FROM job_history j
                                             WHERE j.end_date BETWEEN '1992-01-01' AND '2001-12-31'));

--data en format YYYY-MM-DD
/*PASSOS

-- part 1
SELECT *
FROM departments d
WHERE d.department_id IN ('');

-- part 2
SELECT e.department_id
FROM employees e
WHERE e.job_id IN ('');

-- part 3
SELECT j.job_id
FROM job_history j
WHERE j.end_date BETWEEN '1992-01-01' AND '2001-12-31';

*/
