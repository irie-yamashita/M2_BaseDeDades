CREATE TYPE loc_pais_type AS (
    vr_nom_pais varchar(40),
    vr_total_loc numeric );

CREATE OR REPLACE FUNCTION func_loc_pais (nom_pais countries.country_name%TYPE)
    RETURNS loc_pais_type language plpgsql AS
$$
    DECLARE
        var_dades_pais loc_pais_type;
    BEGIN
        SELECT c.country_name, COUNT(l.location_id)
        INTO var_dades_pais
        FROM countries c JOIN locations l USING (country_id)
        WHERE c.country_name ILIKE nom_pais
        GROUP BY c.country_name;

        RETURN var_dades_pais;
    END;
$$;

SELECT func_loc_pais('Italy');

CREATE OR REPLACE PROCEDURE proc_loc_pais (nom_pais countries.country_name%TYPE) language plpgsql AS
    $$
    DECLARE
        var_dades_pais loc_pais_type = func_loc_pais(nom_pais);
    BEGIN
        raise notice 'El pasís % té % localitzacions', var_dades_pais.vr_nom_pais, var_dades_pais.vr_total_loc;
    END;
$$;

DO
$$
    DECLARE
        var_pais countries.country_name%TYPE = :v_pais;
    BEGIN
        CALL proc_loc_pais(var_pais);
    END;
$$ language plpgsql;