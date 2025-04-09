

/*01*/
DO $$
    DECLARE
        var_deptId DEPARTMENTS.DEPARTMENT_ID%TYPE = :v_deptId;
        var_deptNom DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    BEGIN
        SELECT department_name
        INTO STRICT var_deptNom
        FROM departments
        WHERE department_id = var_deptId;

        RAISE NOTICE '%', var_deptNom;
        IF var_deptNom ILIKE 'A%' THEN
            RAISE NOTICE 'COMENÇA PER LA LLETRA A';
        ELSE
            RAISE NOTICE 'NO COMENÇA PER LA LLETRA A';
        END IF;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RAISE EXCEPTION 'ERROR: no dades';
        WHEN TOO_MANY_ROWS THEN
                RAISE EXCEPTION 'ERROR: retorna més files';
        WHEN OTHERS THEN
               RAISE EXCEPTION 'ERROR (sense definir)';

    END;
$$ LANGUAGE plpgsql;

/*Jocs de proves

-- Comença per A
    Input: 10
    Output: Administration   COMENÇA PER LA LLETRA A

-- NO comença per A
    Input: 20
    Output: Marketing    NO COMENÇA PER LA LLETRA A

-- Not Found
    Input: 1
    Output: [2025-04-09 12:55:33] [P0001] ERROR: ERROR: no dades

--Others


*/