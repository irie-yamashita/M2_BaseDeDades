/*EA08*/

/*01
Crea un procediment anomenat proc_info_pacient que mostri per pantalla el nom, el primer cognom, la data de naixement i i el génere del pacient que li passes el DNI per paràmetre. Una de les variables que utilitzis ha de ser del tipus %ROWTYPE.
Prova el funcionament del procediment amb el DNI 48004645
*/
CREATE OR REPLACE PROCEDURE proc_info_pacient (par_dni PACIENT.DNI_PACIENT%TYPE) AS 
$$
    DECLARE
        var_genere PACIENT.GENERE%TYPE;
        var_dades_pacient PERSONA%ROWTYPE;
    BEGIN
        SELECT *
        INTO var_dades_pacient
        FROM persona
        WHERE dni = par_dni;

        SELECT genere
        INTO var_genere
        FROM pacient
        WHERE dni_pacient = par_dni;

        /*SELECT pe.nom, pe.cognom1, pe.data_naix, pa.genere
        INTO var_dades_pacient.nom, var_dades_pacient.cognom1, var_dades_pacient.data_naix, var_genere
        FROM persona pe
        JOIN pacient pa ON pe.dni = pa.dni_pacient
        AND pe.dni = par_dni;*/

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

-- Correcció: És més fàcil fer 2 consultes.


/*02
Crea un nou tipus de dades del tipus TYPE anomenat info_reactiu_type que ens serivrà per guardar el nom i el preu d’un reactiu i el CIF i el telèfon del seu proveidor.
Crea una funció anomenad func_reactiu_info que li passem el codi d’un reactiu com a paràmetre i retorna una variable del nou tipus creat amb nom del reactiu, el preu i el CIF i el telèfon del provei- dor.

Crea un bloc anònim que demanarà a l’usuari el codi del reactiu, cridarà la funció func_reactiu_info li passarà com a paràmetre el codi introduit, guardarà el resultat en una variable del nou tipus TYPE creat i imprimirà per pantalla el contingut de la variable.
Prova el TYPE i la funció introduint per teclat el codi del reactiu 936678899991043.*/

CREATE TYPE info_reactiu_type AS (
    vr_nom_reac VARCHAR(20),
    vr_preu_reac NUMERIC(8,2),
    vr_cif_prov VARCHAR(10),
    vr_telf_prov VARCHAR(15)
                                 );

CREATE OR REPLACE FUNCTION func_reactiu_info (par_codi_reac REACTIU.CODI_REAC%TYPE) RETURNS INFO_REACTIU_TYPE AS
$$
    DECLARE
        var_info_reac INFO_REACTIU_TYPE;
    BEGIN
        SELECT r.nom, r.preu, p.cif, p.telefon
        INTO var_info_reac
        FROM reactiu r JOIN proveidor p
        ON r.cif_prov = p.cif
        WHERE codi_reac = par_codi_reac;

        RETURN var_info_reac;
    END;
$$LANGUAGE plpgsql;


DO
$$
    DECLARE
        var_codi_reac REACTIU.CODI_REAC%TYPE = :v_codi_reac;
        var_dades INFO_REACTIU_TYPE;
    BEGIN
        var_dades =  func_reactiu_info(var_codi_reac);

        RAISE NOTICE '% % % %', var_dades.vr_nom_reac, var_dades.vr_preu_reac, var_dades.vr_cif_prov, var_dades.vr_telf_prov;

    END;
$$LANGUAGE plpgsql;