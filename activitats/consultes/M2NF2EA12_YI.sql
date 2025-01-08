/*EA12.*/

/*1. */
--JOIN USING
SELECT e.first_name, d.department_name, e.manager_id
FROM employees e JOIN departments d USING (department_id);

--JOIN ON
SELECT e.first_name, d.department_name, e.manager_id
FROM employees e JOIN departments d ON (e.department_id = d.department_id);

/*2. */
--JOIN USING
SELECT l.city, d.department_name
FROM departments d JOIN locations l USING (location_id)
WHERE d.location_id = '1400';


--JOIN ON
SELECT l.city, d.department_name
FROM departments d JOIN locations l ON (d.location_id = l.location_id)
WHERE d.location_id = '1400';

    -- o també...
SELECT l.city, d.department_name
FROM departments d JOIN locations l ON (d.location_id = l.location_id)
AND d.location_id = '1400';


