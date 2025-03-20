/*EA08*/

/*01*/
CREATE OR REPLACE PROCEDURE proc_info_pacient (par_dni PACIENT.DNI_PACIENT%TYPE) AS
$$
    DECLARE
        var_genere PACIENT.GENERE%TYPE;
        var_dades_pacient PERSONA%ROWTYPE;
    BEGIN
        SELECT pe.nom, pe.cognom1, pe.data_naix, pa.genere
        INTO var_dades_pacient.nom, var_dades_pacient.cognom1, var_dades_pacient.data_naix, var_genere
        FROM persona pe
        JOIN pacient pa ON pe.dni = pa.dni_pacient
        AND pe.dni = par_dni;

        RAISE NOTICE 'PACIENT: % % | DNI: % | Data Naixement: % | Gènere: %', var_dades_pacient.nom, var_dades_pacient.cognom1, par_dni, var_dades_pacient.data_naix, var_genere;
    END;
$$ LANGUAGE plpgsql;

DO $$
    DECLARE
        var_dni PERSONA.DNI%TYPE = :v_dni;
    BEGIN
        CALL proc_info_pacient(var_dni);
    END;
$$ LANGUAGE plpgsql;

/*Comprovació:
    SELECT pe.nom, pe.cognom1, pe.data_naix, pa.genere
    FROM persona pe JOIN pacient pa ON pe.dni = pa.dni_pacient
    WHERE pe.dni = '48004645';
*/


/*02*/

CREATE TYPE info_reactiu_type AS (
    vr_nom_reac VARCHAR(20),
    vr_preu_reac NUMERIC(8,2) );

CREATE OR REPLACE FUNCTION func_reactiu_info (par_codi_reac REACTIU.CODI_REAC%TYPE) RETURNS INFO_REACTIU_TYPE AS
$$
    DECLARE
        var_info_reac INFO_REACTIU_TYPE;
    BEGIN
        SELECT nom, preu
        INTO var_info_reac
        FROM reactiu
        WHERE codi_reac = par_codi_reac;

        RETURN var_info_reac;
    END;
$$