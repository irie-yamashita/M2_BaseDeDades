
/*EA5. Procediments i funcions (3) - Irie Yamashita 1rDAWe*/

--Faig una còpia de la taula EMPLOYEES
CREATE TABLE EMPLOYEES2 AS
SELECT * FROM EMPLOYEES;


/*01 Exercici 1. Realitzar un procediment anomenat proc_baixa_emp que doni de baixa un empleat, i que
tingui com a paràmetre l'id de l'empleat. S'ha de programar un bloc anònim que cridi el procediment i
se li passi com a paràmetre l'id de l'empleat que l'usuari introdueixi pel teclat. Prova el procediment en
una taula que sigui còpia de la taula «employees».*/

CREATE OR REPLACE PROCEDURE proc_baixa_emp (param_id EMPLOYEES2.EMPLOYEE_ID%TYPE) AS
$$
    BEGIN
        DELETE FROM EMPLOYEES2
        WHERE EMPLOYEES2.EMPLOYEE_ID = param_id;
    END;
$$ language plpgsql;

DO
$$
    DECLARE
    var_empl_id EMPLOYEES2.EMPLOYEE_ID%TYPE = :v_empl_id;
    BEGIN
        CALL proc_baixa_emp(var_empl_id);
    END;
$$ language plpgsql;

-- Comprovació SELECT * FROM EMPLOYEES2;



/*02 Exercici 2. Realitzar un programa que contingui una funció que retorni quants empleats hi ha a un
departament. L'id del departament es passarà com a paràmetre de la funció. La funció s’anomenarà
func_num_emp i es cridarà des d’un bloc anònim o principal. El paràmetre que se li passa a la
funció se li preguntarà a l’usuari i per tant, s’ha d’introduir pel teclat.*/

CREATE OR REPLACE FUNCTION func_num_emp (param_dept_id EMPLOYEES2.DEPARTMENT_ID%TYPE)
    RETURNS NUMERIC AS
$$
    DECLARE
        var_n_empl NUMERIC;
    BEGIN
        SELECT COUNT(*)
        INTO var_n_empl
        FROM EMPLOYEES2
        WHERE DEPARTMENT_ID = param_dept_id;

        RETURN var_n_empl;
    END;
$$  language plpgsql;

DO
$$
    DECLARE
    var_dept_id EMPLOYEES2.DEPARTMENT_ID%TYPE = :v_dept_id;
    var_n_empl NUMERIC;
    BEGIN
        var_n_empl = (SELECT func_num_emp(var_dept_id));
        raise notice 'El departament % té % empleats.', var_dept_id, var_n_empl;
    END;
$$ language plpgsql;

-- Comprovació SELECT * FROM EMPLOYEES2 WHERE department_id = 50;



/*03 Exercici 3. Realitzar un programa que contingui una funció anomenada func_cost_dept que retorni la
suma total dels salaris dels empleats d’un departament en concret. La funció es cridarà des d’un bloc
anònim o principal. El paràmetre que se li passa a la funció és l’id del departament i se li preguntarà a
l’usuari, i per tant, s’ha d’introduir pel teclat.*/

CREATE OR REPLACE FUNCTION func_cost_dept (param_dept_id EMPLOYEES2.DEPARTMENT_ID%TYPE)
    RETURNS NUMERIC AS
$$
    DECLARE
        var_sum_salari NUMERIC;
    BEGIN
        SELECT SUM(SALARY)
        INTO var_sum_salari
        FROM EMPLOYEES2
        WHERE DEPARTMENT_ID = param_dept_id;

        RETURN var_sum_salari;
    END;
$$  language plpgsql;

DO
$$
    DECLARE
    var_dept_id EMPLOYEES2.DEPARTMENT_ID%TYPE = :v_dept_id;
    var_sum_salari NUMERIC;
    BEGIN
        var_sum_salari = (SELECT func_cost_dept(var_dept_id));
        raise notice 'La suma dels salaris del departament % és de: %', var_dept_id, var_sum_salari;
    END;
$$ language plpgsql;

-- SELECT SUM(salary) FROM employees2 WHERE department_id = 50;



/*04 Exercici 4. Realitzar un procediment anomenat proc_mod_com que modifiqui el valor de la comissió
d’un empleat que s’introdueixi l'id per teclat.
Per a modificar aquesta comissió hem de tenir en compte que:
    • Si el salari és menor a 3000, la nova comissió és 0.1.
    • Si el salari està entre 3000 i 7000, la nova comissió és 0.15.
    • Si el salari és més gran que 7000, la nova comissió és 0.2.
S'ha de programar un bloc anònim que cridi el procediment i se li passi com a paràmetre l'id de
l'empleat que l'usuari introdueixi pel teclat.*/

CREATE OR REPLACE PROCEDURE proc_mod_com (param_id EMPLOYEES2.EMPLOYEE_ID%TYPE) AS
$$
    DECLARE
        var_comissio EMPLOYEES2.COMMISSION_PCT%TYPE;
        var_salari EMPLOYEES2.SALARY%TYPE;
    BEGIN
        SELECT SALARY
        INTO var_salari
        FROM EMPLOYEES2
        WHERE EMPLOYEE_ID = param_id;

        IF(var_salari < 3000) THEN
            var_comissio = 0.1;
        ELSEIF (var_salari BETWEEN 3000 AND 7000) THEN
            var_comissio = 0.15;
        ELSE
            var_comissio = 0.2;
        END IF;

        UPDATE EMPLOYEES2
        SET commission_pct = var_comissio
        WHERE EMPLOYEE_ID = param_id;
    END;
$$ language plpgsql;

DO
$$
    DECLARE
    var_empl_id EMPLOYEES2.EMPLOYEE_ID%TYPE = :v_empl_id;
    BEGIN
        CALL proc_mod_com(var_empl_id);
    END;
$$ language plpgsql;

--Comprovació: SELECT * FROM employees2 WHERE employee_id = 101;


