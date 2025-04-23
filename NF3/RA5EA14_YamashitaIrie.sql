
/*EA14. Sobrecàrrega de funcions - Irie Yamashita*/


/*Exercici 1: L’objectiu d’aquesta activitat és implementar, mitjançant la sobrecàrrega de funcions, una funció que, depenent del tipus de paràmetre que li passem, ens retorni un tipus de dada o una altra.
Amb aquesta funció treballareu els cursors en la iteració d’una operació de selecció de més d’un camp amb múltiples resultats mitjançant un tipus compost.*/

-- Per una banda, volem saber quins tests hem fet en una data concreta que passem com a paràmetre:
CREATE TYPE test_type1 AS (
    vr_codi_test NUMERIC(20),
    vr_codi_mostra NUMERIC(20),
    vr_dni_pacient NUMERIC(9)
);

CREATE OR REPLACE FUNCTION func_tests_sel (par_data DATE) RETURNS SETOF test_type1 AS
    $$
    DECLARE
        var_test test_type1;

        curs_test CURSOR FOR
        SELECT codi_test, codi_mostra, dni_pacient
        FROM test
        WHERE data_resultat = par_data;

    BEGIN
        FOR var_test IN curs_test LOOP
            RETURN  NEXT var_test;
        END LOOP;
        RETURN ;
    END;
$$ LANGUAGE plpgsql;


SELECT func_tests_sel ('2017-03-22'::DATE);


-- Per altra banda, volem saber quins tests tenen un preu superior al preu que passem com a paràmetre.
CREATE TYPE test_type2 AS (
    vr_codi_test NUMERIC(20),
    vr_dni_tecnic NUMERIC(9),
    vr_codi_reactiu NUMERIC(20)
);

CREATE OR REPLACE FUNCTION func_tests_sel (par_preu DECIMAL(8,2)) RETURNS SETOF test_type2 AS
    $$
    DECLARE
        var_test test_type2;

        curs_test CURSOR FOR
        SELECT codi_test, dni_tecnic, codi_reac
        FROM test
        WHERE preu > par_preu;

    BEGIN
        FOR var_test IN curs_test LOOP
            RETURN  NEXT var_test;
        END LOOP;
        RETURN ;
    END;
$$ LANGUAGE plpgsql;


SELECT func_tests_sel (150);