/*EA9. Funcions i Agrupacions*/

/* CORRECCIONS (importants)
    - DISTINCT
*/

/*1. Mostra el nom i cognom de tots els empleats. S'han de mostrar amb la primera lletra en
majúscula i la resta en minúscules.*/
SELECT initcap(first_name), initcap(last_name)
FROM employees;


/*2. Mostra els empleats que han sigut contractats durant el més de maig.*/
SELECT *
FROM employees
WHERE to_char(hire_date,'MM') = '03';

-- quan posa mostra empleats, és només el nom o tot? -> tot
-- CORRECCIÓ: WHERE to_char(hire_date,'MON') = 'MAY';


/*3. Mostra els oficis (job_title) diferents que hi ha a la base de dades.*/
SELECT job_title
FROM jobs;

    -- CORRECCIÓ: SELECT DISTINCT job_title FROM jobs;
        SELECT DISTINCT job_title
        FROM jobs;


/*4. Calcula quants empleats hi ha en cada departament.*/
SELECT department_id, count(*)
FROM employees
GROUP BY department_id;

/*5. Calcula quants empleats hi ha de cada tipus d'ocupació (JOB_ID).*/
SELECT job_id, count(*)
FROM employees
GROUP BY job_id;

/*6. Mostra el número de països que tenen cadascun dels continents que tinguin com
identificador de regió 1,2 o 3;*/
SELECT region_id, count(*)
FROM countries
WHERE region_id IN (1,2,3)
GROUP BY region_id;

/*7. Mostra per cada manager el manager_id, el nombre d'emplets que té al seu carrec i la mitja dels salaris d'aquests empleats.*/
SELECT manager_id, count(*), sum(salary)/count(*)
FROM employees
WHERE manager_id IS NOT null
GROUP BY manager_id;

/* Alternativa:
SELECT manager_id, count(*), AVG(salary)
FROM employees
WHERE manager_id IS NOT null
GROUP BY manager_id;

*/

/*8. Mostra l’id del departament i el número d’empleats dels departaments amb més de 4
empleats.*/
SELECT department_id, count(*)
FROM employees
GROUP BY department_id
HAVING count(*) > 4;

 
