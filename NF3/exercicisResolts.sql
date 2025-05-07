
/*01*/
/*
- No pots utilitzar CURRENT OF amb JOIN
- Llegeix bé l'enuciat
*/

CREATE OR REPLACE FUNCTION func_comprv_dept (par_deptName DEPARTMENTS.DEPARTMENT_NAME%TYPE)
    RETURNS BOOLEAN AS
    $$
    DECLARE
        var_deptName DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    BEGIN
        SELECT department_name
        INTO STRICT var_deptName
        FROM departments
        WHERE department_name = par_deptName;
        RETURN TRUE;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
        WHEN OTHERS THEN
            RAISE EXCEPTION '%,%', SQLERRM, SQLSTATE;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE proc_elim_nous_emps (par_deptName DEPARTMENTS.DEPARTMENT_NAME%TYPE) AS
    $$
    DECLARE
        curs_emp CURSOR FOR
        SELECT e.employee_id, e.first_name, e.last_name, d.department_name
        FROM employees e
        JOIN departments d USING (department_id)
        WHERE d.department_name = par_deptName --!!!!
        ORDER BY hire_date DESC
        LIMIT 2;
    BEGIN
        IF func_comprv_dept(par_deptName) IS TRUE THEN
            FOR var_emp IN curs_emp LOOP
                RAISE NOTICE 'L`empleat %, %, amb id %', var_emp.first_name, var_emp.last_name, var_emp.employee_id;
                DELETE FROM employees
                WHERE employee_id = var_emp.employee_id;
            END LOOP;
        ELSE
            RAISE 'No existeix un departament amb el nom %!', par_deptName;
        END IF;
    END;
$$ LANGUAGE plpgsql;


SELECT * FROM employees WHERE department_id = 60 ORDER BY hire_date DESC;

CALL proc_elim_nous_emps('IT');
CALL proc_elim_nous_emps('ITB');


/*02*/
CREATE TABLE canvis_locations (
id INT GENERATED ALWAYS AS IDENTITY,
location_id numeric(11) NOT NULL,
city_old VARCHAR(30) NOT NULL,
city_new VARCHAR(30) not null,
changed_on TIMESTAMP(6) NOT NULL);

CREATE TABLE canvis (
id serial,
timestamp_ TIMESTAMP WITH TIME ZONE default NOW(),
nom_trigger text,
tipus_trigger text,
nivell_trigger text,
ordre text );



--trigger 1: comprovr si city és diferent
CREATE TRIGGER trig_registrar_canvis_loc BEFORE UPDATE
ON locations
FOR EACH ROW
EXECUTE PROCEDURE func_registrar_canvis_loc();

CREATE OR REPLACE FUNCTION func_registrar_canvis_loc()
   RETURNS TRIGGER
AS $$
BEGIN
    IF NEW.city <> OLD.city THEN
      INSERT INTO canvis_locations (location_id, city_old, city_new, changed_on)
      VALUES (NEW.location_id, OLD.city, NEW.city, NOW());
    ELSE
	    RAISE 'Update aturat. No has modificat el nom de  la ciutat!';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--trigger 2: comprovr qualsevol UPDATE
CREATE TRIGGER trig_gravar_operacions AFTER UPDATE
ON locations
FOR EACH STATEMENT --!!!!
EXECUTE PROCEDURE func_registrar_canvis();

CREATE OR REPLACE FUNCTION func_registrar_canvis()
   RETURNS TRIGGER
AS $$
BEGIN
    INSERT INTO canvis (timestamp_, nom_trigger, tipus_trigger, nivell_trigger, ordre)
    VALUES (NOW(), TG_NAME, TG_WHEN, TG_LEVEL, TG_OP);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


INSERT INTO locations VALUES ('444', 'C/ Aiguablava', '08027', 'Madrid', 'Madrid', 'IT');

SELECT * FROM locations;

-- UPDATE incorrecte:
UPDATE locations SET city = 'Madrid' WHERE location_id = '444';
/*
[2025-05-07 16:43:40] [P0001] ERROR: Update aturat. No has modificat el nom de  la ciutat!
[2025-05-07 16:43:40] Where: PL/pgSQL function func_registrar_canvis_loc() line 7 at RAISE
 */
SELECT * FROM canvis;
SELECT * FROM canvis_locations;

 -- Update correcte:
 UPDATE locations SET city = 'Barcelona' WHERE location_id = '444';
SELECT * FROM canvis;
SELECT * FROM canvis_locations;



/*03*/
CREATE TYPE dades_emp_type AS (
    vr_empl_ID NUMERIC(11),
    vr_empl_fName VARCHAR(20),
    vr_empl_lName VARCHAR(25)
);

CREATE OR REPLACE FUNCTION func_comprv_dep (par_deptName DEPARTMENTS.DEPARTMENT_NAME%TYPE)
    RETURNS BOOLEAN AS
    $$
    DECLARE
        var_deptName DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    BEGIN
        SELECT department_name
        INTO STRICT var_deptName
        FROM departments
        WHERE department_name = par_deptName;
        RETURN TRUE;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN FALSE;
            WHEN OTHERS THEN
                RAISE EXCEPTION '%,%', SQLERRM, SQLSTATE;
    END;
$$ LANGUAGE plpgsql;

/* Comprovacions:
SELECT func_comprv_dep('Poma');
SELECT func_comprv_dep('IT');
 */



CREATE OR REPLACE FUNCTION func_emp_mes_antic (par_deptName DEPARTMENTS.DEPARTMENT_NAME%TYPE)
    RETURNS dades_emp_type AS
    $$
    DECLARE
        var_emp DADES_EMP_TYPE;
    BEGIN
        SELECT d.department_name, e.employee_id, e.first_name, e.last_name
        INTO var_emp
        FROM departments d
        JOIN employees e USING (department_id)
        WHERE department_name = par_deptName
        ORDER BY e.hire_date
        LIMIT 1;

        RETURN var_emp;

    END;
$$ LANGUAGE plpgsql;


/* Comprovacions:
SELECT * FROM employees WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'IT') ORDER BY hire_date LIMIT 1;
SELECT func_emp_mes_antic('IT');
 */

CREATE OR REPLACE PROCEDURE proc_mostrar_emp_dept (par_deptName DEPARTMENTS.DEPARTMENT_NAME%TYPE) AS
    $$
    DECLARE
        var_emp dades_emp_type;
    BEGIN
        IF func_comprv_dep(par_deptName) IS TRUE THEN
            var_emp = func_emp_mes_antic(par_deptName);
            RAISE NOTICE 'L`empleat més antic del % té l`ID
% i es diu % %', var_emp.vr_dept_name, var_emp.vr_empl_id, var_emp.vr_empl_fname, var_emp.vr_empl_lname;
        ELSE
            RAISE EXCEPTION 'El departament no existeix';
        END IF;
    END;
$$ LANGUAGE plpgsql;

CALL proc_mostrar_emp_dept('IT');
/*
L`empleat més antic del IT té l`ID
103 i es diu Alexander Hunold
 */
CALL proc_mostrar_emp_dept('Poma');
/*
[2025-05-07 17:09:23] [P0001] ERROR: El departament no existeix
[2025-05-07 17:09:23] Where: PL/pgSQL function proc_mostrar_emp_dept(character varying) line 10 at RAISE
 */


 /*04*/
 
CREATE OR REPLACE FUNCTION func_comprv_residu(par_codiRes RESIDU.cod_residu%TYPE)
RETURNS BOOLEAN AS $$
    DECLARE
        var_codiRes RESIDU.cod_residu%TYPE;
    BEGIN
        SELECT cod_residu
        INTO STRICT var_codiRes
        FROM residu
        WHERE cod_residu = par_codiRes
        LIMIT 1;
        RETURN TRUE;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
        WHEN OTHERS THEN
            RAISE EXCEPTION '%,%', SQLERRM, SQLSTATE;
    END;
$$LANGUAGE plpgsql;

SELECT func_comprv_residu(7124);
SELECT func_comprv_residu(714);


CREATE OR REPLACE FUNCTION func_comprv_data(par_dataInici DATE, par_dataFinal DATE)
RETURNS BOOLEAN AS $$

    BEGIN
        IF(par_dataFinal < par_dataInici) THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    END;
$$LANGUAGE plpgsql;

SELECT func_comprv_data('2025-05-07', '1998-07-12');
SELECT func_comprv_data('1998-07-12', '2025-05-07');




CREATE OR REPLACE PROCEDURE proc_residus (par_codiRes RESIDU.COD_RESIDU%TYPE, par_dataInici DATE, par_dataFinal DATE) AS
    $$
    DECLARE
    curs_res CURSOR FOR
    SELECT t.cod_residu, e.nom_empresa, d.nom_desti, t.data_enviament
    FROM trasllat t
    JOIN empresaproductora e USING(nif_empresa)
    JOIN desti d USING (cod_desti)
    WHERE cod_residu = par_codiRes
    AND data_enviament BETWEEN  par_dataInici AND par_dataFinal;

    BEGIN
        IF func_comprv_residu(par_codiRes) IS TRUE THEN
            IF func_comprv_data(par_dataInici, par_dataFinal) IS TRUE THEN
                FOR var_res IN curs_res LOOP
                    RAISE NOTICE 'El residu amb codi %, ha sigut generat per l`empresa amb nom % i transportat al destí % la data %',
                    var_res.cod_residu, var_res.nom_empresa, var_res.nom_desti, var_res.data_enviament;
                END LOOP;
            ELSE
                RAISE NOTICE 'Error: les dates estan malament!';
            END IF;

        ELSE
            RAISE NOTICE 'ERROR: no existeix un residu amb el codi %!', par_codiRes;
        END IF;

    END;
$$ LANGUAGE plpgsql;


SELECT t.cod_residu, e.nom_empresa, d.nom_desti, t.data_enviament
    FROM trasllat t
    JOIN empresaproductora e USING(nif_empresa)
    JOIN desti d USING (cod_desti)
    WHERE cod_residu = 714 ORDER BY data_enviament;


-- error cod_residu
CALL proc_residus(7184, '2016-03-30', '2016-04-01');

--error dates
CALL proc_residus(714, '2030-03-30', '2016-04-01');

--correcte
CALL proc_residus(714, '2016-03-30', '2016-04-01');



/*05*/
CREATE OR REPLACE FUNCTION func_res_update()
   RETURNS TRIGGER
AS $$
BEGIN
    IF NEW.quantitat_residu < OLD.quantitat_residu THEN
      RAISE EXCEPTION 'La quantitat nova no pot ser més petita que la quantitat actual.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trig_res_update BEFORE UPDATE
ON residu
FOR EACH ROW
EXECUTE PROCEDURE func_res_update();

-- error Update
UPDATE residu SET quantitat_residu = 100 WHERE cod_residu = 714 AND nif_empresa = 'A-12000028';
/*
 [P0001] ERROR: La quantitat nova no pot ser més petita que la quantitat actual.
 Where: PL/pgSQL function func_res_update() line 4 at RAISE
 */

-- Update correcte
SELECT quantitat_residu FROM residu WHERE cod_residu = 714 AND nif_empresa = 'A-12000028'; --354
UPDATE residu SET quantitat_residu = 555 WHERE cod_residu = 714 AND nif_empresa = 'A-12000028';
SELECT quantitat_residu FROM residu WHERE cod_residu = 714 AND nif_empresa = 'A-12000028'; --555



/*06*/
CREATE OR REPLACE FUNCTION func_empresaProductora()
   RETURNS TRIGGER
AS $$
BEGIN
    IF TG_OP = 'INSERT' AND NEW.nom_empresa IS NULL THEN
        RAISE 'El nom de l''empresa mo pot ser null" i no es fa la inserció.';
    ELSIF TG_OP = 'UPDATE' AND NEW.ciutat_empresa <> OLD.ciutat_empresa THEN
        RAISE 'No es pot canviar el nom de la ciutat';
    ELSIF TG_OP = 'DELETE' THEN
        RAISE 'No està permés eliminar cap registre';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trig_empresaProductora BEFORE INSERT OR UPDATE OR DELETE
ON empresaproductora
FOR EACH ROW
EXECUTE PROCEDURE func_empresaProductora();


SELECT* FROM empresaproductora;

--error INSERT
INSERT INTO empresaproductora (nif_empresa, nom_empresa, ciutat_empresa, activitat, aa_empresa)
VALUES ('A-44440025', NULL, 'Barcelona', 'Informàtica', NULL );
/*
 [P0001] ERROR: El nom de l'empresa mo pot ser null" i no es fa la inserció.
 Where: PL/pgSQL function func_empresaproductora() line 4 at RAISE
 */

-- INSERT correcte
INSERT INTO empresaproductora (nif_empresa, nom_empresa, ciutat_empresa, activitat, aa_empresa)
VALUES ('A-44440025', 'ITB', 'Barcelona', 'Informàtica', NULL );

SELECT * from empresaproductora WHERE nom_empresa = 'ITB';

-- error UPDATE
UPDATE empresaproductora SET ciutat_empresa = 'Madrid' WHERE nif_empresa = 'A-44440025';
/*
 [P0001] ERROR: No es pot canviar el nom de la ciutat
 Where: PL/pgSQL function func_empresaproductora() line 6 at RAISE
 */

 -- UPDATE correcte
UPDATE empresaproductora SET nom_empresa = 'Institut Tecnològic de Barcelona' WHERE nif_empresa = 'A-44440025';
SELECT * from empresaproductora WHERE nif_empresa = 'A-44440025';

-- error DELETE
DELETE FROM empresaproductora WHERE nif_empresa = 'A-44440025';
/*
 [P0001] ERROR: No està permés eliminar cap registre
 Where: PL/pgSQL function func_empresaproductora() line 8 at RAISE
 */