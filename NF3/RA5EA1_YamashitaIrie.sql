
/*Exercici 1. Crea un bloc anònim amb tres variables de tipus NUMERIC. Aquestes variables han de tenir un valor inicial de 15, 40 i 35 respectivament.
El bloc ha de sumar aquestes tres variables i mostrar per pantalla ‘LA SUMA TOTAL ÉS: (la suma de les variables)’.*/
do $$
    declare
        numA numeric := 15;
        numB numeric := 40;
        numC numeric := 35;
        resultat numeric;
    BEGIN
        resultat = numA+numB+numC;
    raise notice 'LA SUMA TOTAL ÉS: %', resultat;
    end;
$$


/*Exercici 2. Crea un bloc anònim que ha d'imprimir el cognom de l'empleat en majúscules amb codi número 104 de la taula (EMPLOYEES), on has de declarar una variable de tipus last_name.*/
do $$
    DECLARE
        cognom EMPLOYEES.last_name%TYPE;
    BEGIN
        SELECT last_name
        INTO cognom
        FROM employees
        WHERE employee_id = 104;

        raise notice 'El cognom del empleat 104 és: %',upper(cognom);
    end;
$$


/*Exercici 3. Crea un bloc anònim que ha d'imprimir el cognom en majúscules de l'empleat amb l’id introduït per pantalla.*/
do $$
    DECLARE
    cognom EMPLOYEES.last_name%TYPE;
    id_empl EMPLOYEES.employee_id%TYPE := :id_empl;

    BEGIN
        SELECT last_name
        INTO cognom
        FROM employees
        WHERE employee_id = id_empl;

        raise notice 'El cognom del empleat % és: %', id_empl, upper(cognom);
    end;
$$

--correcció: millor crear variable en comptes del WHERE


/*Exercici 4. Crea un bloc anònim amb variables PL/SQL que mostri el salari de l'empleat amb id=120, has
de declarar una variable de tipus salary.*/
do $$
    DECLARE
        salari EMPLOYEES.salary%TYPE;
    BEGIN
        SELECT salary
        INTO salari
        FROM employees
        WHERE employee_id = 120;

        raise notice 'Salari del empleat 120: %€', salari;
    end;
$$

-- Correcció: ell a les variables li posa 'v_' davant


/*Exercici 5. Crea un bloc anònim amb una variable PL/SQL que imprimeixi el salari més alt dels treballadors que treballen al departament 'SALES'.*/
do $$
    DECLARE
        salari EMPLOYEES.salary%TYPE;
    BEGIN
        SELECT max(e.salary)
        INTO salari
        FROM employees e
        JOIN departments d USING(department_id)
        WHERE d.department_name ILIKE 'SALES';

        raise notice 'El salari màxim de SALES és: %€', salari;
    end;
$$