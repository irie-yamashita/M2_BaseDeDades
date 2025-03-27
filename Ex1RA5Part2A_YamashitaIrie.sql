/*Examen 1 RA5 Part2A*/

/*Exercici 1 (3 punts). BBDD training*/
CREATE OR REPLACE FUNCTION func_num_venedors (par_fab PRODUCTOS.ID_FAB%TYPE, par_prod PRODUCTOS.ID_PRODUCTO%TYPE)
    RETURNS NUMERIC AS
    $$
    DECLARE
        var_num_ven NUMERIC;
    BEGIN
        SELECT COUNT(DISTINCT rep)
        INTO var_num_ven
        FROM pedidos
        WHERE fab = par_fab AND producto = par_prod;

        RETURN var_num_ven;
    END;
$$ LANGUAGE plpgsql;

-- comprv: SELECT func_num_venedors('aci', '41004');


CREATE OR REPLACE FUNCTION func_num_clients (par_fab PRODUCTOS.ID_FAB%TYPE, par_prod PRODUCTOS.ID_PRODUCTO%TYPE)
    RETURNS NUMERIC AS
    $$
    DECLARE
        var_num_clie NUMERIC;
    BEGIN
        SELECT COUNT(DISTINCT clie)
        INTO var_num_clie
        FROM pedidos
        WHERE fab = par_fab AND producto = par_prod;

        RETURN var_num_clie;
    END;
$$ LANGUAGE plpgsql;

-- comprv: SELECT func_num_clients('aci', '41004');


CREATE OR REPLACE FUNCTION func_mitja_imports (par_fab PRODUCTOS.ID_FAB%TYPE, par_prod PRODUCTOS.ID_PRODUCTO%TYPE)
    RETURNS NUMERIC AS
    $$
    DECLARE
        var_mitjana NUMERIC;
    BEGIN
        SELECT AVG(importe)
        INTO var_mitjana
        FROM pedidos
        WHERE fab = par_fab AND producto = par_prod;

        RETURN var_mitjana;
    END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION func_min_quantitat (par_fab PRODUCTOS.ID_FAB%TYPE, par_prod PRODUCTOS.ID_PRODUCTO%TYPE)
    RETURNS NUMERIC AS
    $$
    DECLARE
        var_min_cant NUMERIC;
    BEGIN
        SELECT MIN(cant)
        INTO var_min_cant
        FROM pedidos
        WHERE fab = par_fab AND producto = par_prod;

        RETURN var_min_cant;
    END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION func_max_quantitat (par_fab PRODUCTOS.ID_FAB%TYPE, par_prod PRODUCTOS.ID_PRODUCTO%TYPE)
    RETURNS NUMERIC AS
    $$
    DECLARE
        var_max_cant NUMERIC;
    BEGIN
        SELECT MAX(cant)
        INTO var_max_cant
        FROM pedidos
        WHERE fab = par_fab AND producto = par_prod;

        RETURN var_max_cant;
    END;
$$ LANGUAGE plpgsql;


CREATE TYPE info_producte_type AS (
    vr_num_ven NUMERIC,
    vr_num_clie NUMERIC,
    vr_avg_imp NUMERIC,
    vr_min_cant NUMERIC,
    vr_max_cant NUMERIC
);

DO $$
    DECLARE
        var_fab PRODUCTOS.ID_FAB%TYPE = :v_fab;
        var_prod PRODUCTOS.ID_PRODUCTO%TYPE = :v_prod;
        var_info INFO_PRODUCTE_TYPE;
    BEGIN
        var_info.vr_num_ven = (func_num_venedors(var_fab, var_prod));
        var_info.vr_num_clie = (func_num_clients(var_fab, var_prod));
        var_info.vr_avg_imp = (func_mitja_imports(var_fab, var_prod));
        var_info.vr_min_cant = (func_min_quantitat(var_fab, var_prod));
        var_info.vr_max_cant = (func_max_quantitat(var_fab, var_prod));

        RAISE NOTICE 'Nº venedors: % - Nº clients: % - Mitjana: % - Mínim: % - Màxim: %', var_info.vr_num_ven, var_info.vr_num_clie, ROUND(var_info.vr_avg_imp, 2), var_info.vr_min_cant, var_info.vr_max_cant;
    END;
$$;


/*Exercici 2 (2 punts). BBDD training*/

/*Situació inicial - CAS PROVA*/
SELECT titulo
FROM repventas
WHERE num_empl= '101'; --Rep Ventas

SELECT COUNT(*)
FROm clientes
WHERE rep_clie= '101'; -- 3

SELECT COUNT(*)
FROm clientes
WHERE rep_clie= '104'; --1


CREATE OR REPLACE PROCEDURE proc_baixa_ven (par_id REPVENTAS.NUM_EMPL%TYPE) AS
    $$
    DECLARE
        var_ven_min REPVENTAS.NUM_EMPL%TYPE;
    BEGIN
        --trobo venedor amb menys clients
        SELECT rep_clie
        INTO var_ven_min
        FROM clientes
        GROUP BY rep_clie
        ORDER BY COUNT(*)
        LIMIT 1;

        -- 'elimino' venedor passat per paràmetre
        UPDATE repventas SET titulo = 'Baixa' WHERE num_empl = par_id;

        -- reassigno clients
        UPDATE clientes SET rep_clie = var_ven_min WHERE rep_clie = par_id;

    END;
$$ LANGUAGE plpgsql;

DO $$
    DECLARE
        var_id_ven REPVENTAS.NUM_EMPL%TYPE = :v_id_ven;
    BEGIN
        CALL proc_baixa_ven(var_id_ven);
    END;
$$;

/*Comprovació:*/
SELECT titulo
FROM repventas
WHERE num_empl= '101'; --'Baixa'

SELECT COUNT(*)
FROm clientes
WHERE rep_clie= '101'; -- '0'

SELECT COUNT(*)
FROm clientes
WHERE rep_clie= '104'; -- '4'



/*Exercici 3 (2 punts). BBDD medlab*/
CREATE OR REPLACE PROCEDURE proc_tests_fets (par_cognom PERSONA.COGNOM1%TYPE, par_preu TEST.PREU%TYPE) AS
    $$
    DECLARE
        var_total_test NUMERIC;
    BEGIN
        SELECT COUNT(*)
        INTO var_total_test
        FROM test
        WHERE dni_tecnic = (SELECT dni
                    FROM persona
                    WHERE cognom1 = par_cognom)
        AND preu > par_preu;

        IF var_total_test <= 0 THEN
            RAISE NOTICE 'El tècnic % no ha realitzat cap test amb preu superior a %.', par_cognom, par_preu;
        ELSE
            RAISE NOTICE 'El tècnic % ha realitzat % tests amb preu superior a: %.', par_cognom, var_total_test, par_preu;
        END IF;
    END;
$$ LANGUAGE plpgsql;

CALL proc_tests_fets('Fraser', 300);
CALL proc_tests_fets('Fraser', 170);


/*Comprovació:
    SELECT COUNT(*)
    INTO var_total_test
    FROM test
    WHERE dni_tecnic = (SELECT dni
                FROM persona
                WHERE cognom1 = 'Fraser')
    AND preu > 300; -- 0

    SELECT COUNT(*)
    INTO var_total_test
    FROM test
    WHERE dni_tecnic = (SELECT dni
                FROM persona
                WHERE cognom1 = 'Fraser')
    AND preu > 170; -- 8
*/