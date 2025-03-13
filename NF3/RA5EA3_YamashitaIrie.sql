/*EA3. Estructures de control de flux*/


/*1)Exercici 1. Escriu un programa PL/SQL que introduirem per teclat dos números.
Els dos números han de ser positius, en cas contrari s’ha de mostrar a l’usuari el missatge  corresponent.
S’ha de realitzar la següent operació amb aquests números: dividir entre ells i sumar-li el segon i mostrar el resultat de l'operació.*/
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



/*2) Exercici 2. Escriu el mateix programa PL/SQL de l’exercici 1, però ara també s’ha de controlar que el primer número sigui més gran que el segon.
En cas contrari s’ha de mostrar el següent missatge: ‘Error! el primer número ha de ser més gran que el segon’.*/
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



/*3)Exercici 3. Escriu un programa PL/SQL que demani a l’usuari la seva edat i mostri el missatge corresponent, si:
a) Entre 0 i 17 mostres 'Ets menor de edat!'
b) Entre 18 i 40 mostres 'Ja ets major de edat!'
d) > 40 mostres 'ja ets força gran'
e) Si és negatiu (<0) mostres 'L ́edat no pot ser negativa'.*/
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

-- Correcció:
DO $$
DECLARE
var_edat INTEGER :=:vedat;
BEGIN
    IF var_edat BETWEEN 0 AND 17 THEN
    RAISE NOTICE 'Ets menor d"edat!';
    ELSIF var_edat BETWEEN 18 AND 40 THEN
    RAISE NOTICE 'Ja ets major d`edat!';
    ELSIF var_edat > 40 THEN
    RAISE NOTICE 'ja ets força gran!';
    ELSIF var_edat <0 THEN
    RAISE NOTICE 'Error ! L´edat no pot ser negativa';
    END IF;
END;
$$ LANGUAGE PLPGSQL;

/*4)Exercici 4. Escriu un programa PL/SQL que demani quina operació es farà:
opció 1 SUMAR, opció 2 RESTAR, opció 3 MULTIPLICAR, opció 4 DIVIDIR .
Després el programa també demana dos números i ha de realitzar la operació escollida amb els dos números introduits per teclat. S’ha de mostrar l’operació escollida, els números  introduïts i el resultat.*/
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

-- Correcció: A la divisió afegir-li un if per l'error


/*5)Exercici 5. Escriu un programa PL/SQL que ens mostri els números entre un rang. El rang mínim és 1 i el màxim se li ha de preguntar a l’usuari i no pot ser menor que 2. Si no és 2 o més gran es mostra un missatge a l'usuari i finalitza el programa. Resol l’exercici utilitzant l’estructura FOR i després l’estructura WHILE.*/

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


/*6)Exercici 6. Escriu un programa PL/SQL que mostri els números entre un rang amb un salt. Tant el rang mínim, com el màxim i el salt se li ha de preguntar a l’usuari. A més, s’ha de tenir en compte que el rang mínim sempre ha de ser més petit que el rang màxim i que el el salt ha de ser més gran que 1. En cas contrari s’ha de mostrar el missatge corresponent i acabar el programa.Utilitza l'estructura de control de flux LOOP.*/
DO
$$
    DECLARE
        min NUMERIC = :v_min;
        max NUMERIC = :v_max;
        salt NUMERIC = :v_salt;
        i NUMERIC;
    BEGIN
        i= min;
        IF min > max THEN
            raise notice 'El mínim no pot ser superior al màxim!';
        ELSEIF salt <= 1 THEN
            raise notice 'El salt ha de ser superior a 1!';
        ELSE
            WHILE i <= max LOOP
                raise notice '% ', i;
                i = i+salt;
            END LOOP;
        END IF;
    END;
$$ language plpgsql;

