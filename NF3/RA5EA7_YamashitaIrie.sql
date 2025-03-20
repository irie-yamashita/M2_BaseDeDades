

/*EA07*/

/*01*/

CREATE OR REPLACE FUNCTION func_num_test () RETURNS NUMERIC AS
$$
    DECLARE
        var_num_test NUMERIC;
    BEGIN
        SELECT COUNT(codi_test)
        INTO var_num_test
        FROM test;

        RETURN var_num_test;
    END;
$$ LANGUAGE plpgsql;


DO $$
    DECLARE
    var_num_test NUMERIC;
    BEGIN
        var_num_test = (SELECT func_num_test());
        RAISE NOTICE 'El número de tests realitzats són: %.' , var_num_test;
    END;
$$ LANGUAGE plpgsql;


/*02*/
CREATE OR REPLACE FUNCTION func_despesa_tests (par_any NUMERIC) RETURNS NUMERIC AS
$$
    DECLARE
        var_sum_despesa NUMERIC;
    BEGIN
        SELECT SUM(preu)
        INTO var_sum_despesa
        FROM reactiu
        WHERE codi_reac IN (SELECT codi_reac
                            FROM test
                            WHERE EXTRACT(YEAR FROM data_resultat) = par_any);

        RETURN var_sum_despesa;
    END;
$$ LANGUAGE plpgsql;

DO $$
    DECLARE
        var_any NUMERIC = :v_any;
        var_sum_despesa NUMERIC;
    BEGIN
        var_sum_despesa = (SELECT func_despesa_tests(var_any));
        RAISE NOTICE 'La despesa en reactius utilitzats any % ha sigut: %.' , var_any, var_sum_despesa;
    END;
$$ LANGUAGE plpgsql;


/*Comprovació: 2015 -> 182*/
