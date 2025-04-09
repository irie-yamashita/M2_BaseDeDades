/*EA11. Cursors (1)*/

/*Exercici 1. Programar un bloc anònim que mostri les següents dades de tots els empleats: codi, nom, salari, comissió i data d’alta. Si la comissió és nula s’ha de mostrar 0. Aquest  exercici s’ha de fer amb la clàusula:*/

--a) OPEN, FETCH, CLOSE i utilitzar una variable tipus %ROWTYPE
DO $$
DECLARE
    emp_cur CURSOR FOR
    SELECT *
    FROM employees;
    emps_info EMPLOYEES%ROWTYPE;
BEGIN
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO emps_info;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'ID: % - Nom: % - Salari: %€ - Comissió: % - Data alta: %', emps_info.employee_id, emps_info.first_name,
        emps_info.salary, emps_info.commission_pct, emps_info.hire_date;
    END LOOP;

END;
$$ LANGUAGE plpgsql;


--b) FOR ... IN ...
DO $$
DECLARE
    emp_cur CURSOR FOR
    SELECT *
    FROM employees;
BEGIN
    FOR emp in emp_cur LOOP
        RAISE NOTICE 'ID: % - Nom: % - Salari: %€ - Comissió: % - Data alta: %', emp.employee_id, emp.first_name,
        emp.salary, emp.commission_pct, emp.hire_date;
    END LOOP;
    CLOSE emp_cur;
END;
$$ LANGUAGE plpgsql;



/*Exercici 2. Programar un bloc anònim que mostri els empleats que tinguin el salari més gran al valor que s’introdueix per teclat. S’ha de controlar mitjançant una funció anomenada  func_control_neg si el salari que s’introdueix per teclat és negatiu o no. En cas de que no sigui negatiu s’ha de mostrar el codi, nom i salari de cada empleat, en cas contrari s’ha d’imprimir “ERROR: salari negatiu i ha de ser positiu”. Aquest exercici s’ha de fer amb la clàusula:*/

--a) OPEN, FETCH, CLOSE i utilitzar una variable tipus %ROWTYPE
CREATE OR REPLACE FUNCTION func_control_neg (par_salari  EMPLOYEES.SALARY%TYPE)
    RETURNS BOOLEAN AS
    $$
    BEGIN
        IF par_salari <0 THEN
            RETURN true; --és negatiu
        ELSE
            RETURN false;
        end if;
    END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    var_minSalari NUMERIC = :v_minSalari;
    emp_cur CURSOR FOR
    SELECT *
    FROM employees
    WHERE salary > var_minSalari;
    emps_info EMPLOYEES%ROWTYPE;
BEGIN
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO emps_info;
        EXIT WHEN NOT FOUND;
        IF func_control_neg(emps_info.salary) THEN
            RAISE NOTICE 'ERROR: salari negatiu i ha de ser positiu.';
        ELSE
            RAISE NOTICE 'Codi: % - Nom: % - Salari: %€', emps_info.employee_id, emps_info.first_name,
            emps_info.salary;
        END IF;

    END LOOP;
    CLOSE emp_cur;
END;
$$ LANGUAGE plpgsql;

--comprov: 15000 (3 files)


--b) FOR ... IN ...
DO $$
DECLARE
    var_minSalari NUMERIC = :v_minSalari;
    emp_cur CURSOR FOR
    SELECT *
    FROM employees
    WHERE salary > var_minSalari;
BEGIN
    FOR emp IN emp_cur LOOP
        IF func_control_neg(emp.salary) THEN
            RAISE NOTICE 'ERROR: salari negatiu i ha de ser positiu.';
        ELSE
            RAISE NOTICE 'Codi: % - Nom: % - Salari: %€', emp.employee_id, emp.first_name,
            emp.salary;
        END IF;

    END LOOP;
END;
$$ LANGUAGE plpgsql;