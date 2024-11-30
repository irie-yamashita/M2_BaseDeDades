/*EXERCICI 1*/

/*a) Si has fet correctament l’EA4 pots passar directament a l’apartat b). */
-- recupero codi fet a l'EA4:

CREATE DATABASE agenda;
CREATE USER agenda WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'agenda';
ALTER DATABASE agenda OWNER TO agenda;
GRANT ALL PRIVILEGES ON DATABASE agenda TO agenda;

psql -U agenda -W -d agenda

CREATE TABLE FITXA (
    DNI NUMERIC(10) NOT NULL,
    NOM VARCHAR(30) NOT NULL,
    COGNOMS VARCHAR(70) NOT NULL,
    ADREÇA VARCHAR(60),
    TELEFON VARCHAR(11) NOT NULL,
    PROVINCIA VARCHAR(30),
    DATA_NAIX DATE DEFAULT CURRENT_DATE,

    CONSTRAINT PK_FITXA PRIMARY KEY (DNI)
);

--Comentaris
    COMMENT ON COLUMN FITXA.DNI IS 'DNI de la persona';
    COMMENT ON COLUMN FITXA.NOM IS 'Nom de la persona';
    COMMENT ON COLUMN FITXA.COGNOMS IS 'Cognoms de la persona';
    COMMENT ON COLUMN FITXA.ADREÇA IS 'Adreça de la persona';
    COMMENT ON COLUMN FITXA.TELEFON IS 'Telèfon de la persona';
    COMMENT ON COLUMN FITXA.PROVINCIA IS 'Provincia on resideix la persona';
    COMMENT ON COLUMN FITXA.DATA_NAIX IS 'Data de naixement de la persona';

/*b) Afegir un nou camp a la taula Fitxa, anomenat Equip de tipus INTEGER.*/
ALTER TABLE FITXA
ADD COLUMN Equip INTEGER;

/*c) Inserir els següents registres a la taula, i una vegada afegits comprovar que existeixen -> INSERTS*/

-- Per canviar format data a Europeu posar: dd/mm/aaaa
SET DATESTYLE TO PostgreSQL,European;
SHOW datestyle;

-- Si volem canviar a model altre: SET DATESTYLE TO ISO;

--INSERT 1:
INSERT INTO FITXA (DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES ('3421232','LUIS MIGUEL','ACEDO GÓMEZ','GUZMÁN EL BUENO, 90','969-23-12-56','NULL','05/05/1970','1');

    --error: valor de telèfon massa llarg -> hem de modificar el tipus perquè sigui VARCHAR(12)
    ALTER TABLE FITXA
    ALTER TELEFON TYPE VARCHAR(12);

--INSERT 2:
INSERT INTO FITXA (DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES ('4864868','BEATRIZ','SANCHO MANRIQUE','ZURRIAGA, 25', '93-232-12-12','BCN','06/07/1978','2');

    --COMPRV: SELECT * FROM FITXA;
    
/*d) Elimina la fila amb DNI = 3421223 i comprova el canvi a la taula.*/
DELETE FROM FITXA WHERE DNI = '3421223';

-- Si posem DNI = 3421223 no borrarà res perquè no hi ha cap valor així. Potsre hauria de ser 3421232.
DELETE FROM FITXA WHERE DNI = '3421232';
SELECT * FROM FITXA; --comprovació

/*e) Inserta la primera fila però per la data de naixement s’ha de posar el valor per defecte */
INSERT INTO FITXA (DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES ('3421232','LUIS MIGUEL','ACEDO GÓMEZ','GUZMÁN EL BUENO, 90','969-23-12-56','NULL',DEFAULT,'1');


/*f) Buida tota la taula amb una sola sentència.*/
TRUNCATE TABLE FITXA;

    --COMPRV: SELECT * FROM FITXA;
INSERT INTO FITXA (DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES ('3421232','LUIS MIGUEL','ACEDO GÓMEZ','GUZMÁN EL BUENO, 90','969-23-12-56','NULL',DEFAULT,'1');

INSERT INTO FITXA (DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES ('4864868','BEATRIZ','SANCHO MANRIQUE','ZURRIAGA, 25', '93-232-12-12','BCN','06/07/1978','2');


/*EXERCICI 2*/
/*a) Inserir els següents registres a la taula fes un ROLLBACK i comprovar si encara existeixen.*/
BEGIN; -- començo a fer transacció

INSERT INTO FITXA(DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES ('7868544','JONÁS','ALMENDROS RODRÍGUEZ','FEDERICO PUERTAS,3','915478947','MADRID','01/01/1987', 3);

INSERT INTO FITXA(DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES ('8324216', 'PEDRO', 'MARTÍN HIGUERO', 'VIRGEN DEL CERRO, 154', '961522344','SORIA', '29/04/1978', 5);

-- COMPRV: SELECT * FROM FITXA;

ROLLBACK;
SELECT * FROM FITXA;
-- No existeixen els registres perquè no hem fet commit

/*b) Inserir els següents registres a la taula programant les transaccions indicades.*/
BEGIN;

INSERT INTO FITXA(DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES ('14948992', 'SANDRA', 'MARTÍN GONZÁLEZ', 'PABLO NERUDA, 15', '916581515', 'MADRID', '05/05/1970', 6);

/*c) Desar el canvis permanentment.*/
COMMIT;

/*d) introduir el registre*/
INSERT INTO FITXA(DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES ('15756214','MIGUEL','CAMARGO ROMÁN','ARMADORES, 1','949488588', NULL,'12/12/1985',7);

/*e) Posar una marca anomenada intA.*/
SAVEPOINT intA;

/*f) Desar els canvis permanentment*/
COMMIT;

/*g) Introduir els registres*/
INSERT INTO FITXA(DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES ('21158230', 'SERGIO', 'ALFARO IBIRICU', 'AVENIDA DEL EJERCITO, 76', '934895855', 'BCN', '11/11/1987', 8);

INSERT INTO FITXA(DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES ('34225234', 'ALEJANDRO', 'ALCOCER JARABO', 'LEONOR DE CORTINAS, 7', '935321211', 'MADRID', '05/05/1970', 9);

/*h) Posar una marca anomenada intB. Comprova que estan els registres que hem donat d’alta de
moment.*/
SAVEPOINT intB;
SELECT * FROM FITXA;

/*i) Introduir el registre*/
INSERT INTO FITXA(DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES ('38624852', 'ALVARO', 'RAMÍREZ AUDIGE', 'FUENCARRAL, 33', '912451168', 'MADRID', '10/09/1976', 10);

/*j) Posar una marca anomenada intC. Comprova que estan els registres que hem donat d’alta de
moment.*/
SAVEPOINT intC;
SELECT * FROM FITXA;

/*k) Introduir els registres.*/
INSERT INTO FITXA(DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES ('45824852', 'ROCÍO', 'PÉREZ DEL OLMO', 'CERVANTES, 22', '912332138', 'MADRID', '06/12/1987',11);

INSERT INTO FITXA(DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES('48488588', 'JESÚS', 'BOBADILLA SANCHO', 'GAZTAMBIQUE, 32', '913141111', 'MADRID', '05/05/1970', 13);

/*l) Posar una marca anomenada intD. Comprova que estan els registres que hem donat d’alta de
moment.*/
SAVEPOINT intD;
SELECT * FROM FITXA;

/*m) Eliminar el registre amb DNI = 45824852.*/
DELETE FROM FITXA WHERE DNI = 45824852;

/*n) Posar una marca anomenada intE. Comprova que estan els registres que hem donat d’alta de
moment i que s’ha eliminat un.*/
SAVEPOINT intE;
SELECT * FROM FITXA;

/*o) Modificar l’equip de l’amic que té per DNI = 48488588. L’equip ha de ser a partir d’ara l’11 i posar una marca anomenada intF.*/
UPDATE FITXA SET EQUIP = 11 WHERE DNI=48488588;
SAVEPOINT intF;
SELECT * FROM FITXA;

/*p) Desfer les operacions fins a la marca intE. Què ha passat?. Comprova els registres.*/
ROLLBACK TO intE;
SELECT * FROM FITXA;
--Resposta: S'han desfet els canvis que hem fet en l'equip del Jesús, hem desfet els canvis fets entre la marca intE i intF.

/*q) Desfer les operacions fins a la marca intD. Què ha passat?. Comprova els registres.*/
ROLLBACK TO intD;
SELECT * FROM FITXA;

-- Resposta: hem desfet el DELETE que hem fet entre la marca intD i intE,

/*r) Modificar l’equip que té per DNI =38624852. L’equip ha de ser a partir d’ara l’11.*/
UPDATE FITXA SET EQUIP = 11 WHERE DNI =38624852;

/*s) Comprovar si tots els canvis s’han realitzat correctament a la taula i desa els canvis
permanentment.*/
SELECT * FROM FITXA;
COMMIT;

/*t) Inserir el registre:*/
INSERT INTO FITXA(DNI,NOM,COGNOMS,ADREÇA,TELEFON,PROVINCIA,DATA_NAIX,EQUIP)
VALUES ('98987765', 'PEDRO', 'RUIZ', 'RUIZ SOL, 43', '91-656-43-32', 'MADRID', '10/09/1976', 12);

/*u) Comprovar si tots els canvis s’han realitzat correctament a la taula i tancar la sessió de treball i tornar a entrar. Comprovar si està el registre que s’ha donat d’alta a l’apartat anterior.*/
SELECT * FROM FITXA;

--tanco taula
\q
psql -U agenda -W -d agenda

/*v) Està el registre?*/
--Resposta: sí que està.
BEGIN;
COMMIT;