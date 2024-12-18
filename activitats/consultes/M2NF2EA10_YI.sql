-- 1
SELECT d.department_name, e.first_name, e.last_name
FROM departments d, employees e
WHERE d.department_name LIKE 'Sales';

-- 2
SELECT d.department_name, e.*
FROM departments d, employees e
WHERE d.department_id = e.department_id
  AND d.department_name NOT IN ('IT','Purchasing');

-- 3
SELECT l.city
FROM departments d, locations l
WHERE d.location_id = l.location_id
    AND department_name LIKE '_u%';