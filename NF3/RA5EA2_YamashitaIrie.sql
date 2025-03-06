-- Irie Yamashita

/*Exercici 1. Programa un tipus de dades TYPE personalitzat anomenat loc_pais_type. Aquest tipus de dades no deixa fer servir dades del tipus %ROWTYPE ni %TYPE perquè es pot utilitzar en qualsevol taula. Aquest tipus de dades ha de poder guardar el nom del país i el número de localitzacions.
Programa una funció anomenada func_loc_pais que calculi el número de localitzacions que hi ha al país que li passes el nom del país com a paràmetre, i retorni el resultat utilitzant una variable TYPE del tipus de dades creat anteriorment loc_pais_type.

Programa un procediment anomenat proc_loc_pais que cridi la funció func_loc_pais i mostri el missatge:
'El país (COUNTRY_NAME) té (X) localitzacions'.
Al procediment i la funció se’ls ha de passar com a paràmetre el nom del país.
Programa un bloc anònim que demanarà a l'usuari el nom del país i cridi el procediment proc_loc_pais.
Prova el procediment escrivint per pantalla 'Italy'..
*/
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


/*Exercici 2. Realitzar un procediment que s’anomeni PROC_EMP_INFO i que es passi com a paràmetre l’Id d’un empleat i mostri el seu ID, el seu nom, el seu càrrec (job_title) i el seu salari.
Has de canviar els nom de les columnes perquè sigui (codi_empleat, nom_empleat, càrrec, salari). Per realitzar aquest exercici has de fer servir una variable de tipus %ROWTYPE. S’ha de programar un bloc principal que pregunti a l’usuari pel ID de l’empleat i cridi al procediment PROC_EMP_INFO, passant el paràmetre corresponent.*/

CREATE OR REPLACE PROCEDURE proc_emp_info (id_empl employees.employee_id%TYPE) language plpgsql AS
    $$
    DECLARE
        info_empl employees%ROWTYPE;
        var_job_title jobs.job_title%TYPE;
    BEGIN
        SELECT e.employee_id "codi_empleat", e.first_name "nom_empleat", j.job_title "càrrec", e.salary "salari"
        INTO info_empl.employee_id, info_empl.first_name, var_job_title, info_empl.salary
        FROM employees e JOIN jobs j USING (job_id)
        WHERE e.employee_id =  id_empl;

        RAISE NOTICE '% (ID: %) - % - %€', info_empl.first_name, info_empl.employee_id, var_job_title, info_empl.salary;
    END
$$;

DO
$$
    DECLARE
        id employees.employee_id%TYPE = :v_id;
    BEGIN
        CALL proc_emp_info(id);
    END;
$$ language plpgsql;