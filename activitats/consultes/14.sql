SELECT job_title
FROM jobs
WHERE job_id IN (SELECT job_id
                 FROM employees
                 WHERE department_id = '80');


-- equivalent a (!!!! DISTINCT)
SELECT DISTINCT j.job_title
FROM jobs j, employees e
WHERE j.job_id = e.job_id
AND e.department_id = '80';




SELECT department_name
FROM departments
WHERE department_id IN (SELECT department_id
                        FROM employees
                        WHERE department_id IS NOT NULL);


SELECT last_name
FROM employees
WHERE salary < (SELECT AVG(salary)
              from employees
              WHERE job_id = 'SA_MAN'
              GROUP BY job_id);