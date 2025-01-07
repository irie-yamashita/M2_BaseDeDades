/*EA10. Consultes multitaula*/

-- 1
SELECT d.department_name, e.first_name, e.last_name
FROM departments d, employees e
WHERE d.department_id = e.department_id AND
      d.department_name LIKE 'Sales';

/** Versió amb JOIN:
SELECT d.department_name, e.first_name, e.last_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
WHERE d.department_name LIKE 'Sales';
**/

-- 2
SELECT d.department_name, e.*
FROM departments d, employees e
WHERE d.department_id = e.department_id AND
      d.department_name NOT IN ('IT','Purchasing');

-- 3
SELECT l.city
FROM departments d, locations l
WHERE d.location_id = l.location_id AND
      department_name LIKE '_u%';

-- 4
SELECT l.city, d.*
FROM departments d, locations l
WHERE d.location_id = l.location_id AND
l.postal_code LIKE '98199';

-- 5
SELECT j.job_title, e.*
FROM jobs j, employees e
WHERE j.job_id = e.job_id AND
      j.job_title LIKE 'Programmer';


-- 6
SELECT c.country_name, r.region_name
FROM countries c, regions r
WHERE c.region_id = r.region_id AND
      r.region_name IN ('Asia', 'Europe');

-- 7
SELECT d.*
FROM employees e, departments d, job_history jh
WHERE e.department_id = d.department_id AND
      e.employee_id = jh.employee_id AND
      to_char(jh.end_date,'YYYY') = '1993';

-- 8
SELECT e.first_name, e.last_name, d.department_name
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND
      d.location_id = l.location_id AND
      l.city LIKE 'Seattle';

-- 9
SELECT d.department_name, l.city, c.country_name
FROM departments d, locations l, countries c
WHERE d.location_id = l.location_id AND
      l.country_id = c.country_id;

-- 10
SELECT e.last_name, e.job_id
FROM employees e, employees m
WHERE e.manager_id = m.employee_id AND
      e.job_id = m.job_id;

-- agafo forana d'una i la primària de l'altra per unir taules

-- 11
SELECT e.last_name, m.first_name, j.job_title
FROM employees e, employees m, jobs j
WHERE e.manager_id = m.employee_id AND
      m.job_id = j.job_id AND
      e.job_id = m.job_id;
