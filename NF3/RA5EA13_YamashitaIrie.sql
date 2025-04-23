/*EA13. Cursors (3) - Irie Yamashita*/

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
    IF func_comp_dep(var_deptId) THEN
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
        END LOOP;
	    --RETURN; -- OPCIONAL
    END;
$$ LANGUAGE plpgsql;

*/

SELECT  func_emps_dep(10);




-- b) SETOF i RETURN QUERY
CREATE OR REPLACE FUNCTION func_emps_dep2 (par_emplID EMPLOYEES.EMPLOYEE_ID%TYPE) RETURNS SETOF employees AS
    $$
    DECLARE
        empl EMPLOYEES; /*EMPLOYEES%ROWTYPE*/

    BEGIN
        RETURN QUERY SELECT * FROM employees WHERE department_id= par_emplID;
        --RETURN; -- OPCIONAL
    END;
$$ LANGUAGE plpgsql;

SELECT func_emps_dep2(80);


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
        var_deptId DEPARTMENTS.DEPARTMENT_ID%TYPE = :v_deptId;

    BEGIN
        OPEN curs_empl(var_deptId);
        LOOP
            FETCH curs_empl INTO reg_empl;
            EXIT WHEN NOT FOUND;
            IF reg_empl.commission_pct IS NULL THEN
                UPDATE EMP_NOU_SALARY
                SET commission_pct = 0
                WHERE CURRENT OF curs_empl;
            ELSE
                UPDATE EMP_NOU_SALARY
                SET commission_pct = commission_pct + 0.2
                WHERE CURRENT OF curs_empl;
            END IF;
        END LOOP;

        RAISE NOTICE 'El departament % ja no té més empleats.', var_deptId;

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