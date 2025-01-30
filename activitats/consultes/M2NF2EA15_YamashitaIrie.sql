/*EA15*/


--1
SELECT first_name, last_name
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE first_name = 'David' && last_name = 'Austin');

--2
SELECT country_name
FROM countries 
WHERE region_id IN (SELECT region_id
                    FROM regions
                    WHERE upper(region_id) IN ('ASIA', 'EUROPE'));



--3
SELECT first_name
FROM employees 
WHERE first_name LIKE 'H%'
AND salary >ANY (SELECT salary
                FROM employees 
                WHERE department_id = '100');


-- Correcció: En comptes de > ANY podries haver posat > i a la subconsulta agafar el MIN(salary). I posa ILIKE.
/*
SELECT first_name
FROM employees 
WHERE first_name LIKE 'H%'
AND salary > (SELECT MIN(salary)
                FROM employees 
                WHERE department_id = 100);
*/


--4
SELECT last_name
FROM employees 
WHERE department_id NOT IN (SELECT department_id
                            FROM employees 
                            WHERE lower(department_name) IN ('marketing', 'sales'));