
/*Exercici 1. BBDD HR
Crear una nova taula utilitzant una consulta que s’anomeni emps_com que contingui totes les dades dels empleats que tenen comissió. */
CREATE TABLE emps_com AS
(SELECT *
 FROM employees
 WHERE commission_pct IS NOT NULL);


 /*Exercici 2. BBDD HR
Crear una vista anomenada emps_low_sal que contingui els noms, el cognoms, el salari i el nom del departament on treballen dels empleats que tenen un salari inferior a 3000. Els noms dels camps de la vista han de ser nom, cognom, salari i departament.*/

CREATE VIEW emps_low_sal ("nom", "cognom", "salari", "departament")
AS (SELECT first_name, last_name, salary, department_name
    FROM employees e
    JOIN departments d USING (department_id)
    WHERE salary < 3000);


/*Exercici 3. BBDD HR
Insertar un nou país a la taula countries. La clau primària és 'J2'. El nom del país s’ha d’obtenir d’una consulta a la taula countries que retorni el país que comença per J, i el codi de la regió s’ha d’obtenir d’una consulta a la BBDD que retorni el codi de la regió d’Asia.*/

INSERT INTO countries VALUES ('J2',
                              (SELECT country_name
                               FROM countries
                               WHERE country_name ILIKE 'J%'),
                              (SELECT region_id
                               FROM regions
                               WHERE region_name LIKE 'Asia'));


/*Exercici 4. BBDD HR
Reassigna els treballadors que treballen al departament 'Finance' al departament 'Sales'. */

UPDATE employees
SET department_id = (SELECT department_id FROM departments WHERE department_name = 'Sales')
WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Finance');


/*Exercici 5. BBDD HR
Utilitzant una consulta crea una taula anomenada emps amb totes les dades de la taula employees. Elimina de la taula emps tots els treballadors que treballen als departaments 'Purchasing' i 'Shipping'. */  
CREATE TABLE emps
AS (SELECT * FROM employees);

DELETE FROM emps 
WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Purchasing')
OR department_id = (SELECT department_id FROM departments WHERE department_name = 'Shipping');



SELECT department_id, COUNT(*)
FROM employees e
GROUP BY department_id
HAVING COUNT(*) >=ALL (SELECT COUNT(*)
                        FROM employees e2
                        WHERE e1.department_id = e2.department_id);