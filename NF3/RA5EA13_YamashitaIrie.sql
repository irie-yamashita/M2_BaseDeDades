/*EA13. Cursors (3) - Irie Yamashita*/

/*Correccions:
    - Noms cursors: curs_...
    - Nom RECORD: reg_...
    - Tancar cursors (CLOSE)
    - Afegir IS TRUE (opcional)
    - Bloc IF NOT FOOUND THEN...

    Repassar ex 03 i 04.
*/

/*01*/
DO $$
DECLARE
    emp_cur CURSOR (par_dept_id INTEGER) FOR
    SELECT employee_id, last_name
    FROM employees
    WHERE department_id = par_dept_id;

    rec_employee RECORD;
BEGIN
    OPEN emp_cur (:v_deptId);
    LOOP
        FETCH emp_cur INTO rec_employee;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'ID: % - Cognom: %', rec_employee.employee_id, rec_employee.last_name;
    END LOOP;
    CLOSE emp_cur; --!!!!!
END;
$$ LANGUAGE plpgsql;


/*02*/
DO $$
DECLARE
    emp_cur CURSOR (par_dept_id INTEGER) FOR
    SELECT employee_id, last_name
    FROM employees
    WHERE department_id = par_dept_id;

    var_deptId INTEGER = :v_deptID;

BEGIN
    IF func_comp_dep(var_deptId) THEN --IS TRUE
        FOR emp IN emp_cur (var_deptId) LOOP
            RAISE NOTICE 'ID: % - Cognom: %', emp.employee_id, emp.last_name;
        END LOOP;
    ELSE
        RAISE NOTICE 'El departament no existeix!';
    END IF;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_comp_dep (par_deptId DEPARTMENTS.DEPARTMENT_ID%TYPE)
RETURNS BOOLEAN AS $$
    DECLARE
        var_locId LOCATIONS.LOCATION_ID%TYPE;
    BEGIN
        SELECT department_id
        INTO STRICT  var_locId
        FROM departments
        WHERE department_id = par_deptId;

        RETURN TRUE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
        WHEN OTHERS THEN
            RAISE EXCEPTION '%,%', SQLERRM, SQLSTATE;
    END;
$$ LANGUAGE plpgsql;


/*03*/

-- a) SETOF i RETURN NEXT
CREATE OR REPLACE FUNCTION func_emps_dep (par_emplID EMPLOYEES.EMPLOYEE_ID%TYPE) RETURNS SETOF employees AS
    $$
    DECLARE
        empl EMPLOYEES;

        curs_emp CURSOR FOR
        SELECT * FROM employees
        WHERE department_id= par_emplID;

    BEGIN
        FOR empl IN curs_emp LOOP
            RETURN  NEXT empl;
            RAISE NOTICE 'info %', empl; -- Correcció: afegir imprimir info...
        END LOOP;
	    --RETURN; -- OPCIONAL
    END;
$$ LANGUAGE plpgsql;

SELECT  func_emps_dep(10);

/* Alternativa: no declaro cursor

CREATE OR REPLACE FUNCTION func_emps_dep (par_emplID EMPLOYEES.EMPLOYEE_ID%TYPE) RETURNS SETOF employees AS
    $$
    DECLARE
        empl EMPLOYEES; /*EMPLOYEES%ROWTYPE*/

    BEGIN
        FOR empl IN SELECT * FROM employees WHERE department_id= par_emplID LOOP
            RETURN  NEXT empl;
            RAISE NOTICE 'info %', empl;
        END LOOP;
	    --RETURN; -- OPCIONAL
    END;
$$ LANGUAGE plpgsql;

*/

/*SELECT  func_emps_dep(10);*/ -- !!! Correcció: no cridis a la funció, fes un bloc anònim






-- b) SETOF i RETURN QUERY
CREATE OR REPLACE FUNCTION func_emps_dep2 (par_emplID EMPLOYEES.EMPLOYEE_ID%TYPE) RETURNS SETOF employees AS
    $$
    DECLARE
        empl EMPLOYEES; /*EMPLOYEES%ROWTYPE*/

    BEGIN
        RETURN QUERY SELECT * FROM employees WHERE department_id= par_emplID;
            RAISE NOTICE 'info %', empl; -- Correcció: afegir imprimir info...
        --RETURN; -- OPCIONAL
    END;
$$ LANGUAGE plpgsql;

/*SELECT func_emps_dep2(80);*/

/*Correcció: Afegir bloc anònim*/
DO
$$
    DECLARE
        var_department_id departments.department_id%TYPE := :v_department_id;
        cur_employees CURSOR(var_department_id NUMERIC(11) ) FOR -- Cursor amb paràmetre
        SELECT * FROM func_emps_dep(var_department_id);

        var_employee employees%ROWTYPE;
    BEGIN
        FOR var_employee IN cur_employees(var_department_id)
        LOOP
            RAISE NOTICE '%', var_employee;
        END LOOP;
    END
$$ LANGUAGE plpgsql;

/*04*/
CREATE TABLE EMP_NOU_SALARY AS
SELECT * FROM EMPLOYEES;

DO $$
    DECLARE
        curs_emps CURSOR FOR
        SELECT * FROM EMP_NOU_SALARY;

        var_nouSalari EMPLOYEES.SALARY%TYPE;

    BEGIN
        FOR empl IN curs_emps LOOP
            var_nouSalari = empl.salary * 1.18;
            UPDATE EMP_NOU_SALARY
            SET salary = var_nouSalari
            WHERE CURRENT OF curs_emps;

            RAISE NOTICE 'El salari antic de l`empleat % era % i el nou salari serà: %', empl.last_name, empl.salary, var_nouSalari;
        END LOOP;
    END;
$$ LANGUAGE plpgsql;

/*!!!*/


/*05*/
DO $$
    DECLARE
        curs_empl CURSOR (par_deptId INTEGER) FOR
        SELECT department_id, commission_pct
        FROM EMP_NOU_SALARY
        WHERE department_id = par_deptId;

        reg_empl RECORD;
        var_novaComiss EMPLOYEES.COMMISSION_PCT%TYPE;
        var_deptId DEPARTMENTS.DEPARTMENT_ID%TYPE = :v_deptId;

    BEGIN
        OPEN curs_empl(var_deptId);
        LOOP
            FETCH curs_empl INTO reg_empl;
            IF NOT FOUND THEN
                RAISE NOTICE 'El departament % ja no té més empleats.', var_deptId;
            EXIT;

            IF reg_empl.commission_pct IS NULL THEN
                var_novaComiss = 0;
            ELSE
                var_novaComiss = reg_empl.COMMISSION_PCT + 0.20;
            END IF;

            UPDATE EMP_NOU_SALARY
            SET COMMISSION_PCT = var_novaComiss
            WHERE CURRENT OF curs_emps;

            EXIT WHEN NOT FOUND;
        END LOOP;
        CLOSE curs_empl;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'ERROR (sense definir): %, %', SQLSTATE, SQLERRM;
    END;
$$ LANGUAGE plpgsql;


/*06*/
CREATE TABLE EMP_WITH_COMISS AS
SELECT * FROM EMPLOYEES;

DO $$
    DECLARE
        curs_emps CURSOR FOR
        SELECT * FROM EMP_WITH_COMISS;
    BEGIN
        FOR empl IN curs_emps LOOP
            DELETE FROM EMP_WITH_COMISS
            WHERE commission_pct IS NULL;
        END LOOP;
    END;
$$ LANGUAGE plpgsql;