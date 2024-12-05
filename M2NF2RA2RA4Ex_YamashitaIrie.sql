CREATE DATABASE bicirent;
CREATE USER bicirent WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'bicirent';
ALTER DATABASE bicirent OWNER TO bicirent;
GRANT ALL PRIVILEGES ON DATABASE bicirent TO bicirent;

\q
psql -U bicirent -W -d bicirent


/*Exercici 1
Escriu les sentències necessàries per crear les taules BICICLETA, CLIENT i LLOGUER a la base de
dades bicirent. tenint en compte les restriccions indicades. Afegeix a la base de dades un comentari a la
taula CLIENT i els comentaris dels camps només de la taual CLIENT. 
*/
CREATE TABLE CLIENT(
    idclient SERIAL UNIQUE,
    nom VARCHAR(30) NOT NULL,
    cognom1 VARCHAR(40) NOT NULL,
    cognom2 VARCHAR(40) NOT NULL,
    dni VARCHAR(10) UNIQUE,
    telefon NUMERIC(10) UNIQUE,
    email VARCHAR(35) UNIQUE,

    CONSTRAINT PK_CLIENT PRIMARY KEY (idclient)
);

COMMENT ON TABLE CLIENT IS 'Taula amb dades del client';
COMMENT ON COLUMN CLIENT.idclient IS 'Identificador del client';
COMMENT ON COLUMN CLIENT.nom IS 'Nom del client';
COMMENT ON COLUMN CLIENT.cognom1 IS 'Primer cognom del client';
COMMENT ON COLUMN CLIENT.cognom2 IS 'Segon cognom del client';
COMMENT ON COLUMN CLIENT.dni IS 'NIF del client amb lletra';
COMMENT ON COLUMN CLIENT.telefon IS 'Telèfon del client';
COMMENT ON COLUMN CLIENT.email IS 'Email del client';


CREATE TABLE BICICLETA (
    idbici NUMERIC(15) UNIQUE,
    marca VARCHAR(30) NOT NULL,
    model VARCHAR(30),
    preu DOUBLE PRECISION NOT NULL DEFAULT 250,

    CONSTRAINT PK_BICICLETA PRIMARY KEY (idbici),
    CONSTRAINT CK_preu_bici CHECK (preu >0)
);

CREATE TABLE LLOGUER(
    idlloguer NUMERIC(35) UNIQUE,
    bici NUMERIC(35) NOT NULL,
    datalloguer DATE DEFAULT CURRENT_DATE,
    dataretorn DATE,
    client INTEGER NOT NULL,
    retorn CHAR(3) NOT NULL,
    penalitzacio NUMERIC(20),
    preu NUMERIC(15) NOT NULL,

    CONSTRAINT PK_LLOGUER PRIMARY KEY (idlloguer),
    CONSTRAINT FK_LLOG_BIC FOREIGN KEY (bici) REFERENCES BICICLETA(idbici),
    CONSTRAINT FK_LLOG_CLI FOREIGN KEY (client) REFERENCES CLIENT(idclient),
    CONSTRAINT CK_retorn CHECK (retorn IN ('PEN', 'RET')),
    CONSTRAINT CK_preu_llog CHECK (preu >0)
);


/*Exercici 2. (0,25 punts)
Comprova que les 3 taules s'han creat correctament amb la comanda que mostra la definició de
les taules amb els camps de les taules, tipus de dades, etc.*/
\d

\d+ CLIENT
\d BICICLETA
\d LLOGUER

/*Exercici 3. (0,25 punts)
Canvia el nom de la restricció que obliga que el camp retorn de la taula LLOGUER només accepti ‘PEN’
o ‘REP’. Ara es diu ck_ret. Comprova si s’ha realitzat el canvi de nom.*/

ALTER TABLE LLOGUER
RENAME CONSTRAINT CK_retorn TO ck_ret;

\d LLOGUER

/*Exercici 4. (0,25 punts)
Elimina la columna preu de la taula lloguer i comprova l’estructura de la taula lloguer.*/
ALTER TABLE LLOGUER
DROP COLUMN preu;

\d LLOGUER

/*Exercici 5. (0,5 punts)
Torna a afegir la columma preu a la taula lloguer amb el tipus de dades DOUBLE PRECISION i que
sigui obligatori i comprova l’estructura de la taula lloguer.*/
ALTER TABLE LLOGUER
ADD preu DOUBLE PRECISION NOT NULL;

\d LLOGUER

/*Exercici 6. (0,25 punts)
Afegeix la restricció que el preu de la taula lloguer sigui més gran de zero i comprova el canvi de
l’estructura de la taula.*/
ALTER TABLE LLOGUER
ADD CONSTRAINT CK_LLOG_preu CHECK (preu >0);

\d LLOGUER

/*Exercici 7. (0,25 punts)
Afegeix una nova restricció a la taula lloguer per controlar que la data de retorn de la bicicleta ha de ser
posterior a la data del lloguer de la bicicleta i comprova el canvi de l’estructura de la taula.*/
ALTER TABLE LLOGUER
ADD CONSTRAINT CK_dates CHECK (dataretorn>datalloguer);

\d LLOGUER

/*Exercici 8. (0,25 punts)
Canvia el tipus de dades del camp client de la taula lloguer. El nou tipus de dades d’aquest camp ha de ser
NUMERIC(35). Si no es pot fer el canvi explica perquè.*/
ALTER TABLE LLOGUER
ALTER COLUMN client TYPE NUMERIC(35);

/*ERROR:  foreign key constraint "fk_llog_cli" cannot be implemented
DETAIL:  Key columns "client" and "idclient" are of incompatible types: numeric and integer.*/
-- em dona error perquè client fa referència a un camp d'una altra taula, i per tant ha de ser del mateix tipus, ha de ser INTEGER

ALTER TABLE LLOGUER
ALTER COLUMN client TYPE INTEGER;

\d LLOGUER


/*Exercici 9. (0,5 punts)
Insereix 5 socis a la taula client amb dades inventades. Tots els camps han de tenir un valor, i
comprova que s’han insertat correctament.*/

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email)
VALUES ('Maria', 'Lopez', 'Ruiz', '21578946Z', 888777444, 'mlop@gmail.com');

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email)
VALUES ('Jose', 'Mendez', 'Coll', '14785634C', 123456789, 'jMendez@gmail.com');

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email)
VALUES ('Emma', 'Stone', 'Williams', '78785454N', 454656124, 'eStone@gmail.com');

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email)
VALUES ('Roberto', 'Gil', 'Coma', '12455687X', 747652145, 'rGil@gmail.com');

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email)
VALUES ('Pepe', 'Martin', 'Hernandez', '15746987L', 654875326, 'pMartin@gmail.com');

SELECT * FROM CLIENT;


/*Exercici 10. (0,75 punts)
Introdueix les següents dades a la taula bicicleta. Si a l’introduir les dades et dona errors, explica el
motiu de l’error que et dona i no insereixis el registre. Comprova quins són els registres que s’han
inserit.*/

INSERT INTO BICICLETA (idbici, marca, model, preu)
VALUES (333456, 'Acepac', 'XTS23', 1500);
-- insert correcte

INSERT INTO BICICLETA (idbici, marca, model, preu)
VALUES (4233456, 'Aevor', 'Alpine', 2000);
-- insert correcte

INSERT INTO BICICLETA (idbici, marca, model, preu)
VALUES (5633456, NULL, 'BTH', 3000);
/*
# ERROR:  null value in column "marca" violates not-null constraint
DETAIL:  Failing row contains (5633456, null, BTH, 3000).
*/
-- el camp 'marca' té una restricció NOT NULL, per tant, és obligatori inserir un valor.


INSERT INTO BICICLETA (idbici, marca, model, preu)
VALUES (333774, 'Capsuled', 'Lumen', 0);
/*ERROR:  new row for relation "bicicleta" violates check constraint "ck_preu_bici"
DETAIL:  Failing row contains (333774, Capsuled, Lumen, 0).
*/
-- el valor del camp "preu" ha de ser major que 0 (té una restricció)


INSERT INTO BICICLETA (idbici, marca, model, preu)
VALUES (24334562, 'Lazer', NULL, 2500);
-- insert correcte

INSERT INTO BICICLETA (idbici, marca, model, preu)
VALUES (333456, 'FAZUA', 'Remix', 1700);
/*ERROR:  duplicate key value violates unique constraint "pk_bicicleta"
DETAIL:  Key (idbici)=(333456) already exists.*/
-- dona error perquè ja existeix un idbici = 333456 i com que és clau primària ha de ser UNIQUE, no pot estar duplicada

INSERT INTO BICICLETA (idbici, marca, model, preu)
VALUES (33334568, 'Octane One', 'Collage', DEFAULT);
-- insert correcte

SELECT * FROM BICICLETA; --comprv

/*Exercici 11. (0,25 punts)
Crea una seqüència perquè el camp idlloguer de la taula lloguer es pugui autoincrementar. Que
comenci per 100, que incrementi 10 i el valor màxim sigui 99999999. La seqüència s’ha d’anomenar
idlloguer_seq.*/

CREATE SEQUENCE idlloguer_seq
INCREMENT 10
START WITH 100
MAXVALUE 99999999;

\d

/*Exercici 12. (0,75 punts)
Intenta inserir els següents registres a la taula lloguer. Utilitza la seqüencia creada en l’exercici
anterior. Si a l’introduir les dades et dona errors, explica l’error que et dona i no insereixis el registre.
La informació que s’ha d’intentar inserir és la següent:*/
INSERT INTO LLOGUER (idlloguer,bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu)
VALUES (NEXTVAL('idlloguer_seq'),4233456, '2017-01-29', '2017-05-28', 3, 'RET', 0, 200);
SELECT NEXTVAL('idlloguer_seq');
-- insert correcte

INSERT INTO LLOGUER (idlloguer, bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu)
VALUES (CURRVAL('idlloguer_seq'), 333456, '2019-07-14', '2019-08-20', 10, 'RET', 0, 400);
/*
# ERROR:  insert or update on table "lloguer" violates foreign key constraint "fk_llog_cli"
DETAIL:  Key (client)=(10) is not present in table "client".
*/
-- no podem fer el insert perquè el camp client = 10 no existeix a la taula CLIENT, taula a la qual fa referència (és una foreing key).

INSERT INTO LLOGUER (idlloguer, bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu)
VALUES (NEXTVAL('idlloguer_seq'),4233456, '2020-06-21', '2020-09-12', 2, 'RET', 50, 300);
-- insert correcte

INSERT INTO LLOGUER (idlloguer, bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu)
VALUES (NEXTVAL('idlloguer_seq'),33334568, '2021-04-20', '2021-02-02', 2, 'RET', 0, 260);
/*ERROR:  new row for relation "lloguer" violates check constraint "ck_dates"
DETAIL:  Failing row contains (130, 33334568, 2021-04-20, 2021-02-02, 2, RET, 0, 260).
*/
-- dona error perquè la data de lloguer ('2021-04-20') no pot ser més antiga que la de retorn (2021-02-02). Està violant una restricció que té la taula LLOGUER.


INSERT INTO LLOGUER (idlloguer, bici, datalloguer, dataretorn, client, retorn, penalitzacio)
VALUES (NEXTVAL('idlloguer_seq'),333456, '2022-06-20', '2022-07-01', 1, 'PEN', 0);
/*ERROR:  null value in column "preu" violates not-null constraint
DETAIL:  Failing row contains (140, 333456, 2022-06-20, 2022-07-01, 1, PEN, 0, null).
*/
-- dona error perquè el camp "preu" és obligatori, no pot ser NULL. Té una restricció NOT NULL i no té valor per defecte.

INSERT INTO LLOGUER (idlloguer, bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu)
VALUES (NEXTVAL('idlloguer_seq'),333456, '2023-09-13', '2023-10-11', 2, 'SET', 100, 370);
/*ERROR:  new row for relation "lloguer" violates check constraint "ck_ret"
DETAIL:  Failing row contains (150, 333456, 2023-09-13, 2023-10-11, 2, SET, 100, 370).*/
-- dona error perquè el valor del camp "retorn" només pot ser 'RET' o 'PEN', no accepta més possibilitats perquè té una restricció.

INSERT INTO LLOGUER (idlloguer, bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu)
VALUES (NEXTVAL('idlloguer_seq'),5633456, '2020-09-13', '2020-10-11', 2, 'PEN', 100, 500);
/*ERROR:  insert or update on table "lloguer" violates foreign key constraint "fk_llog_bic"
DETAIL:  Key (bici)=(5633456) is not present in table "bicicleta".*/
-- dona error perquè el camp bici = 5633456 no existeix a la taula BICICLETA, taula a la qual fa referència (és una foreing key).


SELECT * FROM LLOGUER; --comprv


/*Exercici 13. (0,5 punts)
Actualitza els valors del camp retorn de la taula lloguer de tots els lloguers que el preu sigui més
gran que 150. El retorn de tots aquests lloguers ha de ser PEN. Comprova que l’actualització s’ha
realitzat correctament.*/
UPDATE LLOGUER SET retorn = 'PEN' WHERE preu > 150;

--comprv
SELECT retorn FROM LLOGUER; 
SELECT * FROM LLOGUER; 

/*Exercici 14. (0,5 punts)
Elimina el la bicicleta amb l’identificador el codi del llibre sigui igual a 2126219*/
DELETE FROM BICICLETA WHERE idbici = '2126219';

/*DELETE 0*/
-- no hi ha cap bicileta amb idbici = '2126219', llavors no elimina res
SELECT * FROM BICICLETA; 


/*Exercici 15. (0,25 punts)
Intenta eliminar la taula client. Ho pots fer? En cas negatiu explica perquè. Torna-la a crear afegint les
5 files inicials si l’has pogut eliminar.*/
DROP TABLE CLIENT;

/*ERROR:  cannot drop table client because other objects depend on it
DETAIL:  constraint fk_llog_cli on table lloguer depends on table client
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
*/
--no em deixa eliminar-la perquè tinc la taula LLOGUER que té una foreing key que fa referència a la taula CLIENT.
-- Solució: 
DROP TABLE CLIENT CASCADE;

\d --comprovar

-- la torno a crear i fer inserts
CREATE TABLE CLIENT(
    idclient SERIAL UNIQUE,
    nom VARCHAR(30) NOT NULL,
    cognom1 VARCHAR(40) NOT NULL,
    cognom2 VARCHAR(40) NOT NULL,
    dni VARCHAR(10) UNIQUE,
    telefon NUMERIC(10) UNIQUE,
    email VARCHAR(35) UNIQUE,

    CONSTRAINT PK_CLIENT PRIMARY KEY (idclient)
);

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email)
VALUES ('Maria', 'Lopez', 'Ruiz', '21578946Z', 888777444, 'mlop@gmail.com');

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email)
VALUES ('Jose', 'Mendez', 'Coll', '14785634C', 123456789, 'jMendez@gmail.com');

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email)
VALUES ('Emma', 'Stone', 'Williams', '78785454N', 454656124, 'eStone@gmail.com');

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email)
VALUES ('Roberto', 'Gil', 'Coma', '12455687X', 747652145, 'rGil@gmail.com');

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email)
VALUES ('Pepe', 'Martin', 'Hernandez', '15746987L', 654875326, 'pMartin@gmail.com');

\d --comprovar
SELECT * FROM CLIENT;


/*Exercici 16. (0,25 punts)
Intenta eliminar tot els valors de la taula bicicleta. Ho pots fer? En cas negatiu explica perquè.*/
TRUNCATE TABLE BICICLETA;

/*ERROR:  cannot truncate a table referenced in a foreign key constraint
DETAIL:  Table "lloguer" references "bicicleta".
HINT:  Truncate table "lloguer" at the same time, or use TRUNCATE ... CASCADE.
*/
--no em deixa esborrar els valors perquè tinc la taula LLOGUER que té una foreing key que fa referència a la taula BICICLETA.
-- Solució: 
TRUNCATE TABLE BICICLETA CASCADE;

SELECT * FROM BICICLETA; --comprovo

/*Exercici 17. (0,5 punts)
Crea una vista anomenada telfclient amb el nom, primer cognom i telèfons dels clients.
Comprova el contingut de la vista creada.*/

CREATE VIEW telfclient
AS (SELECT nom, cognom1, telefon
FROM CLIENT);

\d
SELECT * FROM telfclient;

/*Exercici 18. (0,25 punts)
Crea un índex únic anomenat cognom_idx sobre el camp cognom1 de la taula client i
comprova que s’ha creat correctament. Creus que és la millor opció crear un índex únic per
aquest camp?. Raona la resposta.*/

CREATE INDEX cognom_idx
ON CLIENT(cognom1);

\d CLIENT

/*No crec que sigui millor opció, ja que el camp cognom1 normalment es repeteix.
Per exemple, pot haver 2 persones que tinguin el cognom "López". Si creem un índex UNIQUE, llavors no ens deixarà tenir "López" duplicat. */


/*Exercici 19. (0,5 punts)
Intenta actualitzar l’identificador de la bicicleta amb idbici igual a 4233456. El nou
identificador és 2233456. Si no es pot modificar explica perquè i realitza els canvis que
siguin necessaris a l‘estructura de les taules perquè aquest valor es pugui actualitzar.
Comprova que realment s'ha pogut actualitzar.*/

-- torno a fer els inserts (perquè he fet un TRUCATE a l'apartat 16)
INSERT INTO BICICLETA (idbici, marca, model, preu)
VALUES (333456, 'Acepac', 'XTS23', 1500);

INSERT INTO BICICLETA (idbici, marca, model, preu)
VALUES (4233456, 'Aevor', 'Alpine', 2000);

INSERT INTO BICICLETA (idbici, marca, model, preu)
VALUES (24334562, 'Lazer', NULL, 2500);

INSERT INTO BICICLETA (idbici, marca, model, preu)
VALUES (33334568, 'Octane One', 'Collage', DEFAULT);


INSERT INTO LLOGUER (idlloguer,bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu)
VALUES (NEXTVAL('idlloguer_seq'),4233456, '2017-01-29', '2017-05-28', 3, 'RET', 0, 200);

INSERT INTO LLOGUER (idlloguer, bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu)
VALUES (NEXTVAL('idlloguer_seq'),4233456, '2020-06-21', '2020-09-12', 2, 'RET', 50, 300);

-- intento actualitza
UPDATE BICICLETA SET idbici = 2233456 WHERE idbici = 4233456;

/*ERROR:  update or delete on table "bicicleta" violates foreign key constraint "fk_llog_bic" on table "lloguer"
DETAIL:  Key (idbici)=(4233456) is still referenced from table "lloguer".
*/
-- no puc modificar-ho perquè a la taula LLOGUER hi ha un camp que està referenciat a idbici.

-- Solució: borro constraint FK i la torno a crear amb ON UPDATE CASCADE;

ALTER TABLE LLOGUER
DROP CONSTRAINT fk_llog_bic;

ALTER TABLE LLOGUER
ADD CONSTRAINT FK_LLOG_BIC FOREIGN KEY (bici) REFERENCES BICICLETA(idbici) ON UPDATE CASCADE;

-- actualitzo
UPDATE BICICLETA SET idbici = 2233456 WHERE idbici = 4233456;


/*Exercici 20. (0,5 punts)
Exercici de transaccions. Suposem que inicialment la taula bicicleta està buida. Tenint en compte
les següents sentències respon les preguntes: Primer executem BEGIN;*/

--T1
    BEGIN;
    INSERT INTO bicicleta VALUES ('45567', 'BH', 'Simple', '600');

    /*
        a) En quin estat està la taula i perquè?
        La taula té una fila amb els valors: '45567', 'BH', 'Simple', '600', perquè li he fet un INSERT.
    */

-- T2, T3, T4
    SELECT * FROM bicicleta;
    DELETE FROM bicicleta WHERE idllibre='45567';
    ROLLBACK;

    /*  b) En quin estat està la taula i perquè?
        La taula està buida perquè hem fet un ROLLBAKC i, com que no hem fet un COMMIT després de fer l'INSERT, desfà tots els canvis fins el moment que hem fet BEGIN; (inici del tot).
    */

-- T5, T6
    INSERT INTO bicicleta VALUES ('533422', 'BH', 'Ramses', 970);
    COMMIT;

    /*c) En quin estat està la taula i perquè?
        La taula té una fila amb els valors: '533422', 'BH', 'Ramses', 970 perquè li he fet un INSERT i a més he fet un COMMIT per guardar els canvis.
    */
