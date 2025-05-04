/*EA12. Cursors (2) - Irie Yamashita*/

/*CORRECCIÓ:
    - Noms cursors: curs_...
    - Nom RECORD: reg_...
    - Tancar cursors (CLOSE)
*/

/*Exercici 1. Programar un bloc anònim que mostri les següents dades de tots els departaments: el nom, el location_id i el nom de la ciutat on es troben.
Aquest exercici s’ha de fer amb la clàusula:*/

-- a) OPEN, FETCH, CLOSE i utilitza només variables tipus %TYPE
DO $$
DECLARE
    dept_cur CURSOR FOR -- curs_dept
    SELECT d.department_name, d.location_id, l.city
    FROM departments d
    JOIN locations l USING (location_id);

    var_deptName DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    var_locID LOCATIONS.LOCATION_ID%TYPE;
    var_ciutat LOCATIONS.CITY%TYPE;
BEGIN
    OPEN dept_cur;
    LOOP
        FETCH dept_cur INTO var_deptName, var_locID, var_ciutat;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '* % % %', var_deptName, var_locID, var_ciutat;
    END LOOP;
    CLOSE dept_cur; --!!!!
END;
$$ LANGUAGE plpgsql;


-- b) FOR ... IN ...
DO $$
DECLARE
    dept_cur CURSOR FOR
    SELECT d.department_name, d.location_id, l.city
    FROM departments d
    JOIN locations l USING (location_id);

BEGIN
    FOR dept IN dept_cur LOOP
        RAISE NOTICE '* % % %', dept.department_name, dept.location_id, dept.city ;
    END LOOP;
END;
$$ LANGUAGE plpgsql;




/*Exercici 2. Programar un bloc que mostri les següents dades de tots els empleats: codi i nom de l’empleat i codi i nom del departament al que pertany.
Aquest exercici s’ha de fer amb la clàusula:*/

-- a) OPEN, FETCH, CLOSE i utilitza una variable tipus RECORD.
DO $$
DECLARE
    emp_cur CURSOR FOR --curs_emp
    SELECT e.employee_id, e.first_name, e.department_id, d.department_name
    FROM employees e
    JOIN departments d USING (department_id);

    rec_employee RECORD; --reg_emp
BEGIN
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO rec_employee;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '% % - % %', rec_employee.employee_id, rec_employee.first_name,
        rec_employee.department_id, rec_employee.department_name;
    END LOOP;
    CLOSE emp_cur;
END;
$$ LANGUAGE plpgsql;

-- b) FOR ... IN ...
DO $$
DECLARE
    emp_cur CURSOR FOR
    SELECT e.employee_id, e.first_name, e.department_id, d.department_name
    FROM employees e
    JOIN departments d USING (department_id);

BEGIN
    FOR emp IN emp_cur LOOP
        RAISE NOTICE '% % - % %', emp.employee_id, emp.first_name, emp.department_id, emp.department_name;
    END LOOP;
END;
$$ LANGUAGE plpgsql;