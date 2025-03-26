/*Test 01*/

CREATE TYPE dades_empl_type AS (
    vr_nom VARCHAR(20),
    vr_cognom VARCHAR(25),
    vr_nom_dept VARCHAR(30),
    vr_id_loc NUMERIC(11)
                            );

CREATE OR REPLACE PROCEDURE proc_dades_empl (par_id EMPLOYEES.EMPLOYEE_ID%TYPE) AS
$$
    DECLARE
        var_dades DADES_EMPL_TYPE;
    BEGIN
        SELECT e.first_name, e.last_name, d.department_name, d.location_id
        INTO var_dades
        FROM employees e JOIN departments d
        ON e.department_id = d.department_id
        AND e.employee_id = par_id;

        RAISE NOTICE '% % % %', var_dades.vr_nom, var_dades.vr_cognom, var_dades.vr_nom_dept, var_dades.vr_id_loc;
    END;

$$LANGUAGE plpgsql;

DO $$
    DECLARE
        var_id EMPLOYEES.EMPLOYEE_ID%TYPE = :v_id;
    BEGIN
        CALL proc_dades_empl(var_id);
    END;
$$LANGUAGE plpgsql;

/*Comprovació:
SELECT e.first_name, e.last_name, d.department_name, d.location_id
FROM employees e JOIN departments d
ON e.department_id = d.department_id
AND e.employee_id = 100;*/