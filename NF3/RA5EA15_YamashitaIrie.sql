/*EA15. Triggers (1) - Irie Yamashita*/

/*CORRECCIONS
    - Noms de les funcions que criden els triggers: el mateix nom que el trigger, però 'func' en comptes de 'trig'.
    - RETURN NULL quan és AFTER
*/

/*Exercici 1. Programar un trigger que comprovi que la comissió mai sigui més gran que el salari a l’hora d’inserir
un empleat. El trigger s’anomenarà trig_comissio. Mostra els missatges d’error corresponents quan es dispari el
trigger i escriu el joc de proves que has fet per provar el trigger.*/
CREATE OR REPLACE FUNCTION validar_comissio() --func_comissio()
   RETURNS TRIGGER
AS $$
BEGIN
    IF NEW.commission_pct > NEW.salary THEN -- CORECCIÓ: no multipliquis
        RAISE EXCEPTION 'Error: La comissió no pot ser superior al salari'; -- CORECCIÓ: si posem només RAISE és per defecte EXCEPTION
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trig_comissio BEFORE INSERT
ON employees
FOR EACH ROW
EXECUTE PROCEDURE validar_comissio();

/*JOC DE PROVES*/

--Insert correcte
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (444, 'Pep', 'López', 'pep@itb.cat', '123.456.7890',  '2025-04-29', 'IT_PROG', 1000, 0.1, 100, 90);

--Insert amb error
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (444, 'Pep', 'López', 'pep@itb.cat', '123.456.7890',  '2025-04-29', 'IT_PROG', 1000, 1.1, 100, 90); -- 0.1 (salari) , 0.9 (comissió)

--[2025-04-29 21:25:34] [P0001] ERROR: Error: La comissió no pot ser superior al salari




/*Exercici 2. Programar un trigger anomenat trig_nom_departament_notnull que s’activarà quan el nom
del departament sigui null al donar d’alta un nou departament a la taula DEPARTMENTS. Si es dispara el trigger
s’ha de mostrar el missatge d’error: 'El nom del departament no pot ser nul'. Escriu el joc de
proves que has fet per provar el trigger.*/

CREATE OR REPLACE FUNCTION func_nom_departament_notnull() -- func_nom_departament_notnull
   RETURNS TRIGGER
AS $$
BEGIN
    IF NEW.department_name IS NULL THEN
        RAISE EXCEPTION 'El nom del departament no pot ser null!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trig_nom_departament_notnull BEFORE INSERT
ON departments
FOR EACH ROW
EXECUTE PROCEDURE func_nom_departament_notnull();
    
/*JOC DE PROVES*/
--Insert correcte
INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (444, 'ITB', 200, 1700);

--Insert amb error
INSERT INTO departments (department_id, manager_id, location_id)
VALUES (444, 200, 1700);
--[2025-04-29 21:34:21] [P0001] ERROR: El nom del departament no pot ser null!




/*Exercici 3. Programar un trigger anomenat trig_auditartaulaemp i que permeti auditar les operacions
d’inserció, actualització o d’esborrat de dades que es realitzaran a la taula EMPLOYEES. El resultat de
l’auditoria es guardarà a una nova taula de la base de dades anomenada RESAUDITAREMP. Les especificacions
que s’han de tenir en compte són les següents:

Crear la taula RESAUDITAREMP amb un únic camp anomenat RESULTAT VARCHAR(200).
Quan es produeixi qualsevol operació (inserció, esborrat i/o actualitzar) sobre la taula EMPLOYEES, s’inserirà
una fila en la taula RESAUDITAREMP. El contingut d’aquesta fila serà un String (cadena de caràcters) amb la
data i hora que s’ha fet l’operació sobre la taula (utilitza la funció NOW()) i el contingut de les variables
especials asociades al Trigger TG_NAME, TG_WHEN, TG_LEVEL, TG_OP . Per obtenir una sola cadena de
caràcters amb aquesta informació utilitza la funció CONCAT. Escriu el joc de proves que has fet per provar el
trigger.
*/
CREATE TABLE RESAUDITAREMP(
    resultat VARCHAR(200)
);

CREATE OR REPLACE FUNCTION func_auditartaulaemp()
   RETURNS TRIGGER
AS $$
    DECLARE
        dades VARCHAR(200);
    BEGIN
        dades = CONCAT('Nom Trigger: ', TG_NAME, ' - Moment: ', TG_WHEN, ' - Nivell: ', TG_LEVEL, ' - Operació: ', TG_OP, ' - Data: ', NOW()); -- CORRECCIÓ: M'ha faltat: NOW(). Separar per -, sense text.
        INSERT INTO resauditaremp (resultat) VALUES (dades);
    RETURN NULL; --CORRECCIÓ: RETURN NULL!!!!!!!! (quan fem after no cal NEW, perquè l'operació ja s'ha fet)
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trig_auditartaulaemp AFTER INSERT OR UPDATE OR DELETE
ON employees
FOR EACH ROW
EXECUTE PROCEDURE func_auditartaulaemp();


/*JOC DE PROVES*/
-- INSERT
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (444, 'Pep', 'López', 'pep@itb.cat', '123.456.7890',  '2025-04-29', 'IT_PROG', 1000, 0.1, 100, 90);
-- Nom Trigger: trig_auditartaulaemp - Moment: AFTER - Nivell: ROW - Operació: INSERT

-- UPDATE
UPDATE employees SET first_name = 'Josep' WHERE employee_id = 444;
--Nom Trigger: trig_auditartaulaemp - Moment: AFTER - Nivell: ROW - Operació: UPDATE

-- DELETE
DELETE FROM employees WHERE employee_id = 444;
--Nom Trigger: trig_auditartaulaemp - Moment: AFTER - Nivell: ROW - Operació: DELETE

SELECT * FROM resauditaremp;

