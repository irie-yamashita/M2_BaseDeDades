
--1
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



--2
SELECT department_name
FROM departments
WHERE department_id IN (SELECT department_id
                        FROM employees
                        WHERE department_id IS NOT NULL);

--3
SELECT last_name, salary
FROM employees
WHERE salary <ANY (SELECT avg(salary)
                    FROM employees
                    WHERE job_id ILIKE 'SA_MAN');

--4
SELECT country_name
FROM countries
WHERE countries.region_id IN (SELECT region_id
                              FROM countries
                              WHERE country_name = 'Argentina');