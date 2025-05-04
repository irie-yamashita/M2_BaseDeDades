/*EA16. Triggers (2) - Irie Yamashita*/

/*Exercici 1. Programar un trigger associat a la taula EMPLOYEES. El trigger s’anomenarà trig_restriccions_emp i ha de controlar les següents situacions:
    - Quan inserim un nou empleat no pot tenir un salari negatiu.
    - Quan modifiquem les dades d’un empleat, si es modifica el camp salari, només es podrà incrementar i només si té
    comissió al camp commission_pct. Mostra els missatges d’error*/

CREATE OR REPLACE FUNCTION func_restriccions_emp()
   RETURNS TRIGGER
AS $$
BEGIN
    IF TG_OP = 'INSERT' AND NEW.salary < 0 THEN
        RAISE 'El salari no pot ser negatiu!';
    ELSIF TG_OP = 'UPDATE' AND NEW.salary < OLD.salary THEN
        RAISE 'El salari nou no pot ser inferior al salari antic.';
    ELSIF TG_OP = 'UPDATE' AND OLD.commission_pct IS NULL THEN
        RAISE 'El employee a modificar no pot tenir comission_pct NULL';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trig_restriccions_emp BEFORE INSERT OR UPDATE
ON employees
FOR EACH ROW
EXECUTE PROCEDURE func_restriccions_emp();

/*JOC DE PROVES*/

-- Error Insert -> salari negatiu
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (444, 'Pep', 'López', 'pep@itb.cat', '123.456.7890',  '2025-04-29', 'IT_PROG', -1000, 0.1, 100, 90);

/*
[2025-05-04 12:40:00] [P0001] ERROR: El salari no pot ser negatiu!
[2025-05-04 12:40:00] Where: PL/pgSQL function func_restriccions_emp() line 4 at RAISE
*/

-- Insert correcte
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (444, 'Pep', 'López', 'pep@itb.cat', '123.456.7890',  '2025-04-29', 'IT_PROG', 1000, 0.1, 100, 90);

-- Error Update -> salari inferior
UPDATE employees SET salary = 400 WHERE employee_id = 444;
/*
[2025-05-04 12:42:46] [P0001] ERROR: El salari nou no pot ser inferior al salari antic.
[2025-05-04 12:42:46] Where: PL/pgSQL function func_restriccions_emp() line 6 at RAISE
*/


-- Error Update -> comissió NULL
UPDATE employees SET salary = 15000 WHERE employee_id = 206;
/*
[2025-05-04 12:44:01] [P0001] ERROR: El employee a modificar no pot tenir comission_pct NULL
[2025-05-04 12:44:01] Where: PL/pgSQL function func_restriccions_emp() line 8 at RAISE
*/




/*Exercici 2. Programar un trigger associat a la taula EMPLOYEES que faci fallar qualsevol operació de modificació del first_name o del codi de l’empleat o que suposi una pujada de sou superior al 10%. El trigger s’anomenarà trig_errada_modificacio. Mostra els missatges d’error corresponents quan es dispari el trigger i escriu el joc de proves que has fet per provar el trigger.*/

CREATE TRIGGER trig_errada_modificacio BEFORE UPDATE
ON employees
FOR EACH ROW
EXECUTE PROCEDURE func_errada_modificacio();

CREATE OR REPLACE FUNCTION func_errada_modificacio()
   RETURNS TRIGGER
AS $$
BEGIN
    IF NEW.first_name <> OLD.first_name THEN
      RAISE EXCEPTION 'No està permesa la modificació del nom.';
    ELSIF NEW.employee_id <> OLD.employee_id THEN
	    RAISE EXCEPTION 'No està permesa la modificació del ID.';
    ELSIF NEW.salary > OLD.salary * 1.1 THEN
	    RAISE EXCEPTION 'El salari nou no pot ser superior al 10%% del salari antic.';
    ELSE
	    RAISE NOTICE 'Update fet correctament';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



/*JOC DE PROVES*/

-- Error Update -> modificació first_name
UPDATE employees SET first_name = 'Felip' WHERE employee_id = 444;

/*
[2025-05-04 12:59:26] [P0001] ERROR: No està permesa la modificació del nom.
[2025-05-04 12:59:26] Where: PL/pgSQL function func_errada_modificacio() line 4 at RAISE
*/

-- Error Update -> modificació employee_id
UPDATE employees SET employee_id = 800 WHERE employee_id = 444;

/*
[2025-05-04 13:00:54] [P0001] ERROR: No està permesa la modificació del ID.
[2025-05-04 13:00:54] Where: PL/pgSQL function func_errada_modificacio() line 6 at RAISE
*/

-- Error Update -> modificació salari superior al 10%
-- salari antic: 1000.0
UPDATE employees SET salary = 2000 WHERE employee_id = 444;

/*
[2025-05-04 13:02:19] [P0001] ERROR: El salari nou no pot ser superior al 10% del salari antic.
[2025-05-04 13:02:19] Where: PL/pgSQL function func_errada_modificacio() line 8 at RAISE
*/

-- Update correcte
UPDATE employees SET last_name = 'Font' WHERE employee_id = 444;

/*Update fet correctament*/