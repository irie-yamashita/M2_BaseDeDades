
/*Ex2RA5 Part2 - Irie Yamashita*/


/*Exercici 01*/
CREATE OR REPLACE PROCEDURE proc_pac (par_dniM PERSONA.DNI%TYPE) AS
$$
    DECLARE
        curs_pac CURSOR FOR
        SELECT DISTINCT p.dni, p.cognom1, p.data_naix, p.telefon
        FROM persona p
        JOIN visita v ON v.dni_pacient = p.dni AND dni_metge = par_dniM;

        num_visites NUMERIC;
        cognom_metge PERSONA.COGNOM1%TYPE;

    BEGIN

        SELECT COUNT(*) INTO num_visites FROM visita WHERE dni_metge = par_dniM;
        SELECT cognom1 INTO cognom_metge FROM persona WHERE dni = par_dniM;

        IF (SELECT dni_metge FROM metge WHERE dni_metge = par_dniM) IS NULL THEN
            RAISE EXCEPTION 'No existeix un metge amb el dni %', par_dniM;
        ELSIF num_visites = 0 THEN
              RAISE EXCEPTION 'El metge amb dni %, no té cap visita', par_dniM;
        ELSE
            FOR var_pac IN curs_pac LOOP
                RAISE NOTICE '% % % %', var_pac.dni, var_pac.cognom1, var_pac.data_naix, var_pac.telefon;
                UPDATE persona SET mail = CONCAT(cognom_metge,'_',persona.mail) WHERE persona.dni = var_pac.dni;
            END LOOP;
        END IF;

        -- Capturo altres possibles errors
        EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION '[%] % ', SQLSTATE, SQLERRM;

    END;
$$ LANGUAGE plpgsql;

--Proveu el procediment amb aquests DNIs de metges:
CALL proc_pac(30995635);
/*
    38002245 Santis 1972-05-22 625791452
    38702444 Neal 1940-06-18 680010217
    43827345 Rocafort 1977-11-16 633970053
 */

CALL proc_pac(30995999);
/*
[P0001] ERROR: No existeix un metge amb el dni 30995999
Where: PL/pgSQL function proc_pac(numeric) line 16 at RAISE
 */

--Inserim un nou metge a la base de dades
INSERT INTO PERSONA VALUES(82344561,'Sara','Rius','Clavell','1967-11-15','654811345','srius@mail.cat');
INSERT INTO METGE VALUES(82344561,'Dermatoleg');

--I provem que salti l’excepció del metge sense visites
CALL proc_pac(82344561);
/*
[2025-05-08 11:45:50] [P0001] ERROR: El metge amb dni 82344561, no té cap visita
[2025-05-08 11:45:50] Where: PL/pgSQL function proc_pac(numeric) line 20 at RAISE
 */

 --comprovació UPDATE mail: SELECT mail FROM persona WHERE dni = '38002245'; -> Laguía_vsantis@mail.cat




/*Exercici 02*/
--Creació nova taula
CREATE TABLE ingressos_visites(total NUMERIC(14,3));
--I farem un INSERT per inicialitzar el comptador.
INSERT INTO ingressos_visites (total) VALUES (0);

CREATE OR REPLACE PROCEDURE proc_act_ingressos () AS
    $$
    DECLARE
        var_total INGRESSOS_VISITES.TOTAL%TYPE;
    BEGIN
        SELECT SUM(preu)
        INTO var_total
        FROM visita;

        UPDATE ingressos_visites SET total = var_total;

    END;
$$ LANGUAGE plpgsql;

CALL proc_act_ingressos();

-- comprovació: SELECT * FROM ingressos_visites;


-- TRIGGER 1: AFTER INSERT
CREATE OR REPLACE FUNCTION func_act_ingressos()
   RETURNS TRIGGER
AS $$
DECLARE
    suma INGRESSOS_VISITES.TOTAL%TYPE;
BEGIN
    suma = (SELECT total FROM ingressos_visites) + NEW.preu;
    UPDATE ingressos_visites SET total = suma;
    RAISE NOTICE 'Els ingressos actuals per les visites són %', suma;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trig_act_ingressos AFTER INSERT
ON visita
FOR EACH ROW
EXECUTE PROCEDURE func_act_ingressos();


-- TRIGGER 2: BERFORE INSERT, UPDATE O DELETE

CREATE OR REPLACE FUNCTION func_comprovar_data(par_dataVisita VISITA.DATA_VISITA%TYPE)
RETURNS BOOLEAN AS $$
    BEGIN
        IF par_dataVisita <= CURRENT_DATE THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END;
$$LANGUAGE plpgsql;

/*SELECT  func_comprovar_data('2027-08-15');*/ -- false
/*SELECT  func_comprovar_data('2015-04-23');*/ -- true


CREATE OR REPLACE FUNCTION func_visit_audit()
   RETURNS TRIGGER
AS $$
BEGIN
    IF TG_OP = 'INSERT' AND func_comprovar_data(NEW.data_visita) IS FALSE THEN
        RAISE EXCEPTION 'Data incorrecte';
    ELSIF TG_OP = 'UPDATE' AND NEW.preu <> OLD.preu THEN
        RAISE 'No es pot modificar el preu';
    ELSIF TG_OP = 'DELETE' THEN
        RAISE 'No es pot esborrar una visita';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trig_visit_aud BEFORE INSERT OR UPDATE OR DELETE
ON visita
FOR EACH ROW
EXECUTE PROCEDURE func_visit_audit();


-- insert correcte
--Operacions
INSERT INTO visita VALUES(589995499,38702232,43995635,000028,'https://www.cemedioc.cat/infomes/pdfs/589995497.pdf','2025-05-02',125);

-- error data INSERT
INSERT INTO visita VALUES(677749866,38702232,43995635,24,'https://www.cemedioc.cat/infomes/pdfs/v.pdf','2027-12-12',200);
/*
 [P0001] ERROR: Data incorrecte Where: PL/pgSQL function func_visit_audit() line 4 at RAISE
 */

 -- error preu UPDATE
UPDATE visita SET preu = 500 WHERE codi_visita = 57898998;
/*
 [P0001] ERROR: No es pot modificar el preu
 Where: PL/pgSQL function func_visit_audit() line 6 at RAISE
 */

 -- error DELETE
DELETE FROM visita WHERE codi_visita = 57898998;
/*
[2025-05-08 12:31:34] [P0001] ERROR: No es pot esborrar una visita
[2025-05-08 12:31:34] Where: PL/pgSQL function func_visit_audit() line 8 at RAISE
 */
