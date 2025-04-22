/*EA10. Excepcions (2)*/

/*CORRECCIÓ:
- En l'última excepció que és OTHERS, imprimeix l'error amb SQLERRM i SQLSTATE:
    WHEN OTHERS THEN
        RAISE EXCEPTION '%,%', SQLERRM, SQLSTATE;
*/


/*01 Exercici 1. Realitzar un programa que ens comprovi si un departament existeix o no a la taula corresponent
consultant pel codi del departament. En cas d’existir el departament s’ha d’imprimir per pantalla i s’ha de comprovar
si comença o no per la lletra A. Si comença per la lletra A, després de mostrar el nom del departament, ha de mostrar
també el missatge: COMENÇA PER LA LLETRA A, i si no comença per la lletra A, ha de mostrar el missatge: NO
COMENÇA PER LA LLETRA A.
...*/

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
        IF var_deptNom ILIKE 'A%' THEN          /*UPPER(SUBSTR(var_deptNom,1,1))*/
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
               RAISE EXCEPTION 'ERROR (sense definir)'; /*RAISE EXCEPTION '%,%', SQLERRM, SQLSTATE;*/

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



/*02*/
CREATE OR REPLACE PROCEDURE proc_loc_address (par_locID  LOCATIONS.LOCATION_ID%TYPE, par_adress LOCATIONS.STREET_ADDRESS%TYPE) AS
    $$
    BEGIN
        UPDATE locations
        SET street_address = par_adress
        WHERE location_id = par_locID;

        RAISE NOTICE 'Update fet!';
    END;
$$ LANGUAGE plpgsql;


DO $$
    DECLARE
    var_locId LOCATIONS.LOCATION_ID%TYPE = :v_locId;
    var_adress LOCATIONS.STREET_ADDRESS%TYPE = :v_adress;
    BEGIN
        IF (func_comprovar_loc(var_locId)) THEN
            CALL proc_loc_address(var_locId, var_adress);
        ELSE
            RAISE NOTICE 'El ID de la localització no existeix!';
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



CREATE OR REPLACE FUNCTION func_comprovar_loc (par_locID  LOCATIONS.LOCATION_ID%TYPE)
    RETURNS BOOLEAN AS
    $$
    DECLARE
        var_locID LOCATIONS.LOCATION_ID%TYPE;
    BEGIN
        SELECT location_id
        INTO STRICT var_locID
        FROM locations
        WHERE location_id = par_locID;
        RETURN TRUE;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
        WHEN OTHERS THEN
            RAISE EXCEPTION 'ERROR GENERAL:';
    END;
$$ LANGUAGE plpgsql;

/*Jocs de proves

-- ID correcte
    Input: 1000, 'Carrer Aiguablava'
    Output: Update fet!

-- ID incorrecte
    Input: 1, 'Carrer Aiguablava'
    Output: El ID de la localització no existeix!

*/