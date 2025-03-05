/*1.	Mostra els noms dels departaments que tinguin empleats */
SELECT department_name
FROM departments d
WHERE exists(SELECT *
             FROM employees e
             WHERE e.department_id = d.department_id);


--sense EXISTS
SELECT department_name
FROM departments d
WHERE d.department_id IN (SELECT d.department_id
             FROM employees e
             WHERE e.department_id = d.department_id);


/* 2.	Mostra els identificadors d'ofici, el nom i el cognom dels empleats que guanyen el salari mínim corresponent a seu lloc de treball (job_id).*/

SELECT e.job_id, e.first_name, e.last_name
FROM employees e
WHERE salary = (SELECT min_salary
                FROM jobs j
                WHERE e.job_id = j.job_id);



/*3.	Mostra el cognom, el número de departament i el salari dels empleats que tenen el salari més alt del seu departament. Ordena els resultats per número de departament  */
SELECT e.last_name, e.department_id, e.salary
FROM employees e
WHERE e.salary = (SELECT MAX(e2.salary)
                  FROM employees e2
                  WHERE e.department_id = e2.department_id
                  GROUP BY e2.department_id)
ORDER BY e.department_id;

-- sense group by
select last_name, department_id , salary
from employees e1
where salary=(select(max(e2.salary))
				from employees e2
				where e1.department_id = e2.department_id )
order by department_id;

/*4.	Mostra totes les dades dels departaments que comencin per R que no tinguin empleats.*/
SELECT d.*
FROM departments d
WHERE d.department_name ILIKE 'R%'
AND NOT EXISTS(SELECT *
               FROM employees e
               WHERE d.department_id = e.department_id);


/*5. 	Mostra el id i el número d'empleats del departament que té més empleats.*/
SELECT e1.department_id, count(e1.employee_id)
FROM employees e1
GROUP BY e1.department_id
HAVING count(e1.employee_id) = (SELECT MAX("nEmpleats")
FROM (SELECT count(e2.employee_id) "nEmpleats"
      FROM employees e2
      GROUP BY e2.department_id) as a);

/*6. Fes servir la consulta anterior per trobar el nom del departament que més empleats té.*/
SELECT e1.department_id, COUNT(e1.employee_id), d.department_name
FROM employees e1
JOIN departments d USING (department_id)
GROUP BY e1.department_id, d.department_name
HAVING COUNT(e1.employee_id) = (
    SELECT MAX(a)
        FROM( SELECT COUNT(e2.employee_id) as "a"
                FROM employees e2
                WHERE e1.department_id = e2.department_id) as "c");