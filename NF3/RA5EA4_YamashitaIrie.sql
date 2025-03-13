/*Exercici 1. Realitzar un programa que contingui una funció que dupliqui la quantitat rebuda com a paràmetre.
La funció rebrà el nom de FUNC_DUPLICAR_QUANTITAT.
S’ha de programar un bloc principal que demani per teclat la quantitat i que cridi a la funció FUNC_DUPLICAR_QUANTITAT
passant el paràmetre corresponent.*/
CREATE OR REPLACE FUNCTION FUNC_DUPLICAR_QUANTITAT (quantitat NUMERIC)
    RETURNS NUMERIC language plpgsql AS
$$
    DECLARE
        var_resultat NUMERIC = quantitat*2;
    BEGIN
        return var_resultat;
    END;
$$;

DO
$$
    DECLARE
        var_quantitat NUMERIC = :v_quantitat;
        var_resultat NUMERIC;
    BEGIN
        var_resultat = (SELECT FUNC_DUPLICAR_QUANTITAT(var_quantitat));
        raise notice 'El resultat és %.', var_resultat;
    END;
$$ language plpgsql;



/*Exercici 2. Realitzar un programa que contingui una funció que calculi el factorial d’un número que es passa com a paràmetre.
La funció rebrà el nom de FUNC_FACTORIAL. S’ha de programar un bloc principal que pregunti a l’usuari pel número a calcular i cridi a la funció FUNC_FACTORIAL, passant el paràmetre corresponent.*/
CREATE OR REPLACE FUNCTION FUNC_FACTORIAL (valor NUMERIC)
    RETURNS NUMERIC language plpgsql AS
$$
    DECLARE
        var_resultat NUMERIC = 1;
    BEGIN
        FOR i IN 1..valor LOOP
            var_resultat = var_resultat * i;
        END LOOP;
        return var_resultat;
    END;
$$;

DO $$
    DECLARE
        var_valor NUMERIC = :v_valor;
        var_resultat NUMERIC;
    BEGIN
        IF var_valor < 0 THEN
            raise notice 'No es pot calcular el factorial de un número negatiu!';
        ELSE
            var_resultat = (SELECT FUNC_FACTORIAL(var_valor));
            raise notice 'El resultat és %.', var_resultat;
        END IF;
    END;
$$ language plpgsql;


/*Exercici 3. Realitzar un programa que contingui un procediment anomenat PROC_ALTA_JOB que doni d’alta un nou ofici (JOB) a la taula jobs.
Totes les dades del nou ofici s’han de passat com com a paràmetre.
S’ha de programar un bloc principal que pregunti a l’usuari totes les dades del nou ofici i cridi el procediment PROC_ALTA_JOB.
Abans d’inserir s’ha de comprovar que el valor màxim i mínim del salari no sigui negatiu i a més, que el salari mínim sigui més petit que el salari màxim.
Mostra els missatges d’error corresponents.*/

CREATE OR REPLACE PROCEDURE PROC_ALTA_JOB (id jobs.job_id%type, title jobs.job_title%type, max jobs.max_salary%type, min jobs.min_salary%type) language plpgsql AS
    $$
    BEGIN
        INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES (id, title, max, min);
        RAISE NOTICE 'Insert fet';
    END
$$;

DO
    $$
    DECLARE
        var_job_id jobs.job_id%TYPE = :v_job_id;
        var_job_title jobs.job_title%TYPE = :v_job_title;
        var_max_salary jobs.max_salary%TYPE = :v_max_salary;
        var_min_salary jobs.min_salary%TYPE = :v_min_salary;
    BEGIN
        IF var_max_salary < 0 OR var_min_salary < 0 THEN
            RAISE NOTICE 'Els salaris no poden ser negatius!';
        ELSEIF var_min_salary > var_max_salary THEN
            RAISE NOTICE 'El salari màxim ha de ser superior al mínim!';
        ELSE
            CALL PROC_ALTA_JOB(var_job_id, var_job_title, var_max_salary, var_min_salary);
        END IF;
    END;
$$;

-- Comprovació: SELECT * FROM jobs;