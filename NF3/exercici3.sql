
/*1)*/
DO
$$
    DECLARE
        numA NUMERIC = :v_numA;
        numB NUMERIC = :v_numB;
        resultat NUMERIC;
    BEGIN
        IF numA<0 OR numB<0 THEN
            raise notice 'Els números han de ser positius!';
        ELSE
            resultat = numA/numB+numB;
            raise notice '%/%+%= %', numA, numB, numB, round(resultat,2);
        end if;
    END;
$$ language plpgsql;


/*2)*/
DO
$$
    DECLARE
        numA NUMERIC = :v_numA;
        numB NUMERIC = :v_numB;
        resultat NUMERIC;
    BEGIN
        IF numA<0 OR numB<0 THEN
            raise notice 'Els números han de ser positius!';
        ELSEIF numA <= numB THEN
            raise notice 'El primer número ha de ser més gran que el segon!';
        ELSE
            resultat = numA/numB+numB;
            raise notice '%/%+%= %', numA, numB, numB, round(resultat,2);
        END IF;
    END;
$$ language plpgsql;


/*3)*/
DO
$$
    DECLARE
        edat NUMERIC = :v_edat;
    BEGIN
        CASE
        WHEN (edat>=0 AND edat<=17) THEN
            raise notice 'Ets menor de edat!';
        WHEN (edat >= 18 AND edat <= 40) THEN
            raise notice 'Ja ets major de edat!';
        WHEN (edat > 40) THEN
            raise notice 'Ja ets força gran...';
        ELSE
            raise notice 'L ́edat no pot ser negativa';
        END CASE;

    END;
$$ language plpgsql;


-- Opció alternativa
DO
$$
    DECLARE
        edat NUMERIC = :v_edat;
    BEGIN
        CASE
        WHEN (edat<0) THEN
            raise notice 'L ́edat no pot ser negativa';
        WHEN (edat < 18) THEN
            raise notice 'Ets menor de edat!';
        WHEN (edat < 41) THEN
            raise notice 'Ja ets major de edat!';
        ELSE
            raise notice 'Ja ets força gran...';
        END CASE;
    END;
$$ language plpgsql;


/*4)*/
DO
$$
    DECLARE
        operacio NUMERIC = :v_operacio;
        numA NUMERIC = :v_numA;
        numB NUMERIC = :v_numB;
        resultat NUMERIC;
    BEGIN
        CASE (operacio)
            WHEN 1 THEN
                resultat = numA+numB;
            WHEN 2 THEN
                resultat = numA-numB;
            WHEN 3 THEN
                resultat = numA*numB;
            WHEN 4 THEN
                resultat = numA/numB;
            ELSE
                raise notice 'Operació no vàlida! [SUMAR, RESTAR, MULTIPLICAR, DIVIDIR]';
        END CASE;
        IF operacio  BETWEEN 1 AND 4 THEN
            RAISE NOTICE 'El resultat és %', resultat;
        END IF;
    END;
$$ language plpgsql;


/*5)*/

    --for
DO
$$
    DECLARE
        min NUMERIC = 1;
        max NUMERIC = :v_max;
    BEGIN
        IF max >= 2 THEN
            FOR i IN min..max LOOP
                raise notice '% ', i;
            END LOOP;
        ELSE
            raise notice 'El màxim no pot ser inferior a 2!';
        END IF;
    END;
$$ language plpgsql;



    --while
DO
$$
    DECLARE
        min NUMERIC = 1;
        max NUMERIC = :v_max;
    BEGIN
        IF max >= 2 THEN
            WHILE min <= max LOOP
                raise notice '% ', min;
                min = min+1;
            END LOOP;
        ELSE
            raise notice 'El màxim no pot ser inferior a 2!';
        END IF;
    END;
$$ language plpgsql;


/*6)*/


