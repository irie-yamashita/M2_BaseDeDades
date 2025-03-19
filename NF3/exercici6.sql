


/*01*/
CREATE OR REPLACE PROCEDURE proc_alta_pais (par_country_id countries.country_id%TYPE, par_country_name countries.country_name%TYPE, par_region_name regions.region_name%TYPE) AS
    $$
    DECLARE
        var_regiond_id regions.region_id%TYPE;
    BEGIN
        SELECT region_id
        INTO var_regiond_id
        FROM regions
        WHERE region_name = par_region_name;

        INSERT INTO countries (country_id, country_name, region_id) VALUES (par_country_id, par_country_name, var_regiond_id);
    END;
$$ language plpgsql;

DO $$
    DECLARE
        var_country_id countries.country_id%TYPE = :v_country_id;
        var_country_name countries.country_name%TYPE = :vr_country_name;
        var_region_name regions.region_name%TYPE = :vr_region_name;
        row_countries countries%ROWTYPE;
    BEGIN
        CALL proc_alta_pais(var_country_id, var_country_name, var_region_name);

        SELECT *
        INTO row_countries
        FROM countries
        WHERE country_name = var_country_name;

        RAISE NOTICE 'Country_id: % - Country_name: % - Region_id: %', row_countries.country_id, row_countries.country_name, row_countries.region_id;

    END;
$$ language plpgsql;

/*Comprovar
    SELECT * FROM countries;
    DELETE FROM countries WHERE country_name = 'Xina';
*/



/*02*/
CREATE OR REPLACE FUNCTION func_nom_manager (par_deparment_id employees.department_id%TYPE)
    RETURNS employees.first_name%TYPE AS
    $$
    DECLARE
        var_manager_name employees.first_name%TYPE;
    BEGIN

    END;
$$ language plpgsql;