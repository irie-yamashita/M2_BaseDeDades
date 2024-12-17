/*EA8. Consultes bàsiques*/

-- hr
psql -U hr -W -d hr

/*1. Crea una consulta per mostrar el cognom i el salari dels empleats que guanyen més de
12.000.*/
SELECT last_name, salary
FROM employees
WHERE salary > 12000;

/*2. Crea una consulta per a mostrar el cognom de l’empleat i el número de departament
d’empleat amb id 176.*/
SELECT last_name, department_id
FROM EMPLOYEE
WHERE employee_id = 176;

/*3. Crea una consulta per a mostrar el cognom i el número de departament de tots els
empleats que els seus salari no estiguin dins del rang 5000 i 12000.*/
SELECT last_name, department_id
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000;


/*4. Crea una consulta per mostrar el cognom de l’empleat, l’identificador del càrrec (JOB:ID) i
la data de contractació dels empleats contractats entre el 20 de febrer de 1998 i l'1 de maig de
1998. Ordenar la consulta en ordre ascendent per data de contractació.*/
SELECT last_name, department_id, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN '20-02-1998' AND '01-05-1998'
ORDER BY hire_date;


/*5. Crea una consulta per mostrar el cognom i el número de departament de tots els empleats
dels departaments 20 i 50, ordena per ordre alfabètic per cognom.*/
SELECT last_name, department_id
FROM employees
WHERE department_id IN (20,50)
ORDER BY last_name;


/*6. Crea una consulta per mostrar el cognom i la data de contractació de tots els empleats
contractats l'any 1998.*/

SELECT last_name, hire_date
FROM employees
WHERE to_char(hire_date,'YYYY') = '1998';

-- alternativa: EXTACT(YEAR FROM hire_date)

/*7. Crea una consulta per mostrar el cognom i el càrrec (JOB_ID) de tots els empleats que no
tenen director assignat.*/
SELECT last_name, job_id
FROM employees
WHERE manager_id IS NOT Null;

/*8. Crea una consulta per a mostrar el cognom, el salari i la comissió de tots els empleats que
tenen comissions. Ordenar les dades en ordre descendent de salaris i comissions.*/
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT Null;


/*9. Crea una consulta per mostrar el cognom de tots els empleats que tingui una 'a' com tercera
lletra (en aquest camp cognom).*/
SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';

-- guió baix és per 1 char.
-- % per x chars.


/*10. Crea una consulta per mostrar el cognom de tots els empleats que tinguin una a i una e (en aquest camp cognom).*/
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%' AND last_name LIKE '%e%';

--COMPTE: has de tornar a posr last_name LIKE després de AND.

/*11. Crea una consulta per a mostrar el cognom, el càrrec (JOB_ID) i el salari de tots els
empleats on els càrrecs siguin representants de vendes (AC_ACCOUNT) o encarregats de
stock (AD_ASST) i els salaris no siguin iguals a 2500, 3500 ni 7000.*/
SELECT e.last_name, e.job_id, e.salary
FROM employees e
JOIN job_history j ON e.job_id = j.job_id
WHERE (j.job_id = 'AC_ACCOUNT' OR j.job_id = 'AD_ASST') AND e.salary NOT IN (2500,3500,7000);
