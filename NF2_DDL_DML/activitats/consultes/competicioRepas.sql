--1
SELECT c.country_name
FROM countries c
JOIN regions r ON c.region_id = r.region_id
AND upper(r.region_name) = 'EUROPE';

--2
SELECT department_name, location_id
FROM departments;

--3
SELECT employee_id, last_name, first_name
FROM employees
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE lower(department_name) = 'marketing');

--4
SELECT job_title, min_salary, max_salary
FROM jobs;

--5
SELECT street_address, city, state_province
FROM locations l
JOIN countries c USING (country_id)
WHERE country_name = 'United States of America';

--6
SELECT r.region_name, count(country_id)
FROM countries c JOIN regions r USING (region_id)
GROUP BY r.region_name;

-- !!! GROUP BY regions, no countries


--7
SELECT e.first_name, e.last_name, j.job_title
FROM employees e JOIN jobs j USING(job_id);


--8
SELECT department_name
FROM departments
WHERE location_id = (SELECT location_id
                     FROM locations
                     WHERE city = 'Southlake');

--9
SELECT street_address
FROM locations
WHERE city = 'Tokyo';

--10
SELECT country_id, count(location_id)
FROM locations
GROUP BY country_id
ORDER BY count(location_id) DESC
LIMIT 1;

--!!!

--11
SELECT j.job_title, avg(e.salary), max(e.salary), min(e.salary)
FROM employees e RIGHT JOIN jobs j USING (job_id)
GROUP BY j.job_title
ORDER BY avg(e.salary) DESC;

-- e., j.


--12
SELECT d.department_name, l.city
FROM departments d LEFT
JOIN locations l USING (location_id);