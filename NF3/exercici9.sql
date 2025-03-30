

/*EA9. Excepcions - Irie Yamashita*/


/*Exercici1*/
CREATE OR REPLACE PROCEDURE proc_alta_dept (par_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE, par_dept_name DEPARTMENTS.DEPARTMENT_NAME%TYPE, par_man_id DEPARTMENTS.MANAGER_ID%TYPE, par_loc_id DEPARTMENTS.LOCATION_ID%TYPE)
    AS $$
    BEGIN

        INSERT INTO departments VALUES (par_dept_id, par_dept_name, par_man_id, par_loc_id);
        RAISE NOTICE 'INSERT FET';
    END;
$$ LANGUAGE plpgsql;

DO $$
    DECLARE
        var_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE = :v_dept_id;
        var_dept_name DEPARTMENTS.DEPARTMENT_NAME%TYPE = :v_dept_name;
        var_man_id DEPARTMENTS.MANAGER_ID%TYPE = :v_man_id;
        var_loc_id DEPARTMENTS.LOCATION_ID%TYPE = :v_loc_id;
    BEGIN

        IF func_compv_dept(var_dept_id) THEN
            RAISE NOTICE 'El departament ja existeix!';
        ELSIF NOT func_comprovar_mng(var_man_id) THEN
            RAISE NOTICE 'El manager no existeix!';
        ELSIF NOT func_comprovar_loc(var_loc_id) THEN
            RAISE NOTICE 'La localització no existeix!';
        ELSE
            CALL proc_alta_dept(var_dept_id, var_dept_name, var_man_id, var_loc_id);
        END if;

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
$$LANGUAGE plpgsql;



/*JOCS DE PROVA

    -- Departament ja existent
    /*
        Entrada: 10, 'IY', 100, 1000
        Sortida: El departament ja existeix!
    */

    -- Manager inexistent
    /*
        Entrada: 404, 'IY', 4, 1000
        Sortida: El manager no existeix!
    */

    -- Localització inexistent
    /*
        Entrada: 404, 'IY', 100, 4
        Sortida: La localització no existeix!
    */

    -- Manager i localització inexistents
    /*
        Entrada: 404, 'IY', 4, 4
        Sortida: El manager no existeix!
    */

    -- Tot correcte
    /*
        Entrada: 404, 'IY', 100, 1000
        Sortida: INSERT FET
    */

    -- Comprovació
    /*
        SELECT *
        FROM departments
        WHERE department_id = 404;
    */

*/

/*Correcció
    - Les funcions tenen el tipus de les taules originals.
    - Els ifs on cridem les funcions es ffan en el bloc anònim. Vaig sumant un comptador per les dades correctes. Si tinc totes les dades bé llavors crido al procediment
    - En el procediment faig una comprovació amb el FOUND
*/


/*Exercici 2: Realitzar un programa que pregunti a l’usuari el codi de l’empleat per tal de retornar el nom de l’empleat.
El nom de l’empleat ho retornarà una funció que es crearà anomenada func_nom_emp. A aquesta
funció se li passarà per paràmetre el codi de l’empleat que l’usuari ha introduït per teclat. S’ha de controlar els errors al bloc anònim utilitzant el SQLSTATE i incloure el JOC DE PROVES que has utilitzat.*/

DO $$
    DECLARE
        var_emplID EMPLOYEES.EMPLOYEE_ID%TYPE = :v_emplID;
        var_emplNom EMPLOYEES.FIRST_NAME%TYPE;
    BEGIN
        var_emplNom = (func_nom_emp(var_emplID));


        RAISE NOTICE 'Nom empleat amb id %: %', var_emplID, var_emplNom;
        EXCEPTION
            WHEN no_data_found  THEN
                RAISE EXCEPTION 'Alguna cosa està malament. Aquí error: descripció %: %',SQLSTATE, SQLERRM;
            WHEN others THEN
                RAISE EXCEPTION 'Error desconegut';


    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_nom_emp(par_emplID EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURNS EMPLOYEES.FIRST_NAME%TYPE AS $$
    DECLARE
        var_nom EMPLOYEES.FIRST_NAME%TYPE;
    BEGIN
        SELECT first_name
        INTO STRICT var_nom
        FROM employees
        WHERE employee_id = par_emplID;

        RETURN var_nom;
    END;
$$ LANGUAGE plpgsql;