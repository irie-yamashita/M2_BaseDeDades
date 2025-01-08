/*EA10. Consultes multitaula*/

/*1. Mostra el nom del departament, el nom i el cognom dels empleats que el seu departament
sigui Sales.*/
SELECT d.department_name, e.first_name, e.last_name
FROM departments d, employees e
WHERE d.department_id = e.department_id AND
      d.department_name LIKE 'Sales';

/*2.Mostra el nom del departament i totes les dades dels empleats que no treballen en el
departament 'IT' ni 'Purchasing'.*/
SELECT d.department_name, e.*
FROM departments d, employees e
WHERE d.department_id = e.department_id AND
      d.department_name NOT IN ('IT','Purchasing');

/*3. Mostra els noms de les ciutats que els noms dels departaments tinguin una u en la segona
posició.*/
SELECT l.city
FROM departments d, locations l
WHERE d.location_id = l.location_id AND
      department_name LIKE '_u%';

-- no fa falta posar l a locations (perquè city no existeix a departments)
      

/*4. Mostra la ciutat i totes les dades dels departaments que es troben al codi postal '98199'.*/
SELECT l.city, d.*
FROM departments d, locations l
WHERE d.location_id = l.location_id AND
l.postal_code LIKE '98199';

/*5. Mostra el job_title i totes les dades dels empleats que el seu job_title sigui Programmer.*/
SELECT j.job_title, e.*
FROM jobs j, employees e
WHERE j.job_id = e.job_id AND
      j.job_title LIKE 'Programmer';


-- pots posar ILIKE o lower(j.job_title) perquè no sigui case sensitive


/*6. Mostra els noms dels països (country_name) i el nom del continent (region_name) d'Àsia i
Europa.*/
SELECT c.country_name, r.region_name
FROM countries c, regions r
WHERE c.region_id = r.region_id AND
      r.region_name IN ('Asia', 'Europe');

/*7. Mostra els departaments que tinguin empleats que hagin finalitzat el seu contracte a l'any
1993.*/
SELECT d.*
FROM departments d, job_history jh
WHERE e.employee_id = jh.employee_id AND
      to_char(jh.end_date,'YYYY') = '1993';

-- to_char(jh.end_date,'YY') = '93';
-- no fa falta FROM employees, perquè no necessitem cap informació d'aquí


/*8. Mostra el nom, el cognom i el nom del departament dels empleats que treballen a Seattle.*/
SELECT e.first_name, e.last_name, d.department_name
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND
      d.location_id = l.location_id AND
      l.city LIKE 'Seattle';


/*9. Mostra els noms de tots els departaments i la ciutat i país on estiguin ubicats.*/
SELECT d.department_name, l.city, c.country_name
FROM departments d, locations l, countries c
WHERE d.location_id = l.location_id AND
      l.country_id = c.country_id;

/*10. Mostra el cognom i el job_id dels empleats que tinguin el mateix ofici que el seu cap i
mostra el nom del cap.*/
SELECT e.last_name, e.job_id
FROM employees e, employees m
WHERE e.manager_id = m.employee_id AND
      e.job_id = m.job_id;

-- agafo forana d'una i la primària de l'altra per unir taules

/*11. Mostra el cognom dels empleats que tinguin el mateix ofici que el seu cap, el nom del cap
i mostra també el nom de l'ofici (job_title).*/
SELECT e.last_name, m.first_name, j.job_title
FROM employees e, employees m, jobs j
WHERE e.manager_id = m.employee_id AND
      e.job_id = j.job_id AND
      e.job_id = m.job_id;
