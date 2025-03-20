

/*EA07*/

/*01
Crea una funció anomenada func_num_tests que retorni el número total de tests realitzats. Crida la
funció des d’un bloc anònim que mostri el missatge: 'El número de tests realitzats
són:' <num_tests>.
*/

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


/*02
Crea una funció anomenada func_despesa_tests que retorni el total de la despesa en reactius que s’ha
produït amb els testos que la data del resultat sigui de l’any que passem com a paràmetre .
Programa un bloc anònim per demanar a l’usuari l’any, cridi la funció per obtenir el resultat i mostri

el missatge: 'La despesa en reactius utilitzats any <any> ha sigut:' <to-
tal_despesa>.

Prova el funcionament escrivint per patalla 2015.
*/
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
