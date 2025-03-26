/*Correcció

- Les funcions tenen el tipus de les taules originals.
- Els ifs on cridem les funcions es ffan en el bloc anònim. Vaig sumant un comptador per les dades correctes. Si tinc totes les dades bé llavors crido al procediment
- En el procediment faig una comprovació amb el FOUND
*/

CREATE OR REPLACE PROCEDURE proc_alta_dept (par_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE, par_dept_name DEPARTMENTS.DEPARTMENT_NAME%TYPE, par_man_id DEPARTMENTS.MANAGER_ID%TYPE, par_loc_id DEPARTMENTS.LOCATION_ID%TYPE)
    AS $$
    BEGIN
        IF func_compv_dept(par_dept_id) THEN
            RAISE NOTICE 'El departament ja existeix!';
        ELSIF NOT func_comprovar_mng(par_man_id) THEN
            RAISE NOTICE 'El manager no existeix!';
        END if;
        /*INSERT INTO departments VALUES (par_dept_id, par_dept_name, par_man_id, par_loc_id);*/
    END;
$$ LANGUAGE plpgsql;

DO $$
    DECLARE
        var_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE = :v_dept_id;
        var_dept_name DEPARTMENTS.DEPARTMENT_NAME%TYPE = :v_dept_name;
        var_man_id DEPARTMENTS.MANAGER_ID%TYPE = :v_man_id;
        var_loc_id DEPARTMENTS.LOCATION_ID%TYPE = :v_loc_id;
    BEGIN
        CALL proc_alta_dept(var_dept_id, var_dept_name, var_man_id, var_loc_id);
    END;
$$;


CREATE OR REPLACE FUNCTION func_compv_dept(param_dptId DEPARTMENTS.DEPARTMENT_ID%TYPE) RETURNS BOOLEAN language plpgsql as $$
    DECLARE
        var_dptId DEPARTMENTS.DEPARTMENT_ID%TYPE;

    BEGIN
        SELECT DEPARTMENT_ID
        INTO STRICT var_dptId
        FROM DEPARTMENTS
        WHERE DEPARTMENT_ID = param_dptId;
        RETURN TRUE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
        WHEN OTHERS THEN
            RAISE EXCEPTION 'ERROR GENERAL:';
END;$$;

CREATE OR REPLACE FUNCTION func_comprovar_mng (par_mngID EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURNS BOOLEAN AS $$
    DECLARE
        var_mngID EMPLOYEES.EMPLOYEE_ID%TYPE;
    BEGIN
        SELECT employee_id
        INTO STRICT var_mngID
        FROM employees
        WHERE employee_id = par_mngID;
        RETURN TRUE;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
        WHEN OTHERS THEN
            RAISE EXCEPTION 'ERROR GENERAL:';
    END;
$$LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_comprovar_loc (par_locID LOCATIONS.LOCATION_ID%TYPE)
RETURNS BOOLEAN AS $$
    DECLARE
        var_LOCID departments.manager_id%TYPE;
    BEGIN
        SELECT manager_id
        INTO STRICT var_mngID
        FROM departments
        WHERE manager_id = par_locID;
        RETURN TRUE;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
        WHEN OTHERS THEN
            RAISE EXCEPTION 'ERROR GENERAL:';
    END;
$$LANGUAGE plpgsql;