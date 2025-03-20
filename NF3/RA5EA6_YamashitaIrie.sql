/*EA6. Procediments i funcions (4)*/


/*01 Crea un procediment anomenat proc_alta_pais que serveixi per introduir un pais nou. Has de demanar les dades per
teclat i cridar el procediment des d’un bloc anònim. Els paràmetres que passaràs al procediment són "country_id",
"country_name" i "region_name" de tipus %TYPE. Com que per insertar un pais necessites el "region_id", en el
mateix procediment primer hauràs d'obtenir el region_id consultant la taula REGIONS i utilitzant el paràmetre per
"region_name". Després de la inserció, fes un select per recuperar la nova fila insertada i imprimeix el nom del país
insertat fent servir una variable %ROWTYPE.*/
CREATE OR REPLACE PROCEDURE proc_alta_pais (par_country_id countries.country_id%TYPE, par_country_name countries.country_name%TYPE, par_region_name regions.region_name%TYPE) AS
    $$
    DECLARE
        var_regiond_id regions.region_id%TYPE;
        row_countries countries%ROWTYPE;
    BEGIN
        SELECT region_id
        INTO var_regiond_id
        FROM regions
        WHERE region_name = par_region_name;

        INSERT INTO countries (country_id, country_name, region_id) VALUES (par_country_id, par_country_name, var_regiond_id);
        
        SELECT *
        INTO row_countries
        FROM countries
        WHERE country_name = par_country_name;

        RAISE NOTICE 'Country_id: % - Country_name: % - Region_id: %', row_countries.country_id, row_countries.country_name, row_countries.region_id;
    END;
$$ language plpgsql;

DO $$
    DECLARE
        var_country_id countries.country_id%TYPE = :v_country_id;
        var_country_name countries.country_name%TYPE = :vr_country_name;
        var_region_name regions.region_name%TYPE = :vr_region_name;
    BEGIN
        CALL proc_alta_pais(var_country_id, var_country_name, var_region_name);

    END;
$$ language plpgsql;

/*Comprovar
    SELECT * FROM countries;
    DELETE FROM countries WHERE country_name = 'Xina';
*/



/*02
Crea un funció anomenada func_nom_manager a la qual és passarà el deparment_id com a paràmetre que serà
de tipus %TYPE i retornarà el nom del manager del departament. Has de fer servir una variable també de tipus
%TYPE per guardar el nom del mànager. Programa un bloc anònim per demanar a l'usuari el deparment_id,
cridar la funció func_nom_manager i imprimir per pantalla el nom del mánager.*/

CREATE OR REPLACE FUNCTION func_nom_manager (par_deparment_id employees.department_id%TYPE)
    RETURNS employees.first_name%TYPE AS
    $$
    DECLARE
        var_manager_name employees.first_name%TYPE;
    BEGIN
        SELECT first_name
        INTO var_manager_name
        FROM employees
        WHERE employee_id = (SELECT manager_id
                             FROM departments
                             WHERE departments.department_id = par_deparment_id);

        RETURN var_manager_name;
    END;
$$ language plpgsql;

DO
$$
    DECLARE
    var_dept_id departments.department_id%TYPE = :v_dept_id;
    var_nom_manager employees.first_name%TYPE;
    BEGIN
        SELECT func_nom_manager(var_dept_id)
        INTO var_nom_manager;

        RAISE NOTICE 'El nom del manager dept. % és: %', var_dept_id, var_nom_manager;
    END;
$$ language plpgsql;

/* Comprovacions:
SELECT first_name
FROM employees
WHERE employee_id = (SELECT manager_id
                     FROM departments
                     WHERE departments.department_id = 10);

*/



/*03
Crea un procediment anomentat proc_dades_empl que mostri per pantalla el nom, cognom, el nom del departament
al qual pertany, i el codi identificador de la localitat on està el departament d’un empleat que un usuari introdueixi el
codi per teclat des d'un bloc anònim. Fes servir una variable TYPE creada pel programador.*/

CREATE TYPE dades_empl_type AS (
    vr_nom_empl VARCHAR(20),
    vr_cognom_empl VARCHAR(25),
    vr_nom_dept VARCHAR(30),
    vr_id_loc NUMERIC(11)
);

CREATE OR REPLACE PROCEDURE proc_dades_empl (par_empl_id EMPLOYEES.EMPLOYEE_ID%TYPE) AS
$$
    DECLARE
        var_dades_empl DADES_EMPL_TYPE;
    BEGIN
        SELECT e.first_name, e.last_name, d.department_id, d.location_id
        INTO var_dades_empl
        FROM employees e
        JOIN departments d USING (department_id)
        WHERE e.employee_id = par_empl_id;

        RAISE NOTICE '% % % %', var_dades_empl.vr_nom_empl, var_dades_empl.vr_cognom_empl, var_dades_empl.vr_nom_dept, var_dades_empl.vr_id_loc;
    END;

$$LANGUAGE plpgsql;

DO
$$
    DECLARE
    var_empl_id departments.location_id%TYPE = :v_empl_id;
    BEGIN
        CALL proc_dades_empl(var_empl_id);
    END;
$$ language plpgsql;

