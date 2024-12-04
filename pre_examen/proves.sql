    
--Creem una base de dades i usuari:
CREATE DATABASE proves;
CREATE USER proves WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'proves';
ALTER DATABASE proves OWNER TO proves;
GRANT ALL PRIVILEGES ON DATABASE proves TO proves;

\q
-- comprovació: \l
psql -U proves -W -d proves


CREATE TABLE PERSONA (
    ID NUMERIC(10),
    nom VARCHAR(10),

    CONSTRAINT PK_PERSONA PRIMARY KEY (ID)
);


--SEQUENCE
CREATE SEQUENCE PROVA_SQ
INCREMENT 10
START WITH 100
MAXVALUE 999999;


NEXTVAL('PROVA_SQ');

INSERT INTO PERSONA(ID,nom)
VALUES (CURRVAL('PROVA_SQ'),'Joana');

SELECT NEXTVAL('PROVA_SQ');
INSERT INTO PERSONA(ID,nom)
VALUES (CURRVAL('PROVA_SQ'),'Emma');

SELECT NEXTVAL('PROVA_SQ');
INSERT INTO PERSONA(ID,nom)
VALUES (CURRVAL('PROVA_SQ'),'Amber');

-- error: TRUNCATE TABLE PERSONA;
-- compr: SELECT * FROM PERSONA;


/*MISSATGE ERROR*/
PK: -- el valor del "nomCamp" ja ha estat introduit abans, i això no pot ser perquè "nomCamp" és clau primària i ha de ser única, no es pot repetir.

FK: -- el valor del camp "nomCamp" és una foreing key i fa referència a un valor que no existeix a la taula referenciada (taula pare)

CK: -- el valor del "nomCamp" no compleix amb la restricció "nom_ck" de la taula "nomTaula".

NOT NULL: -- el valor del camp "nomCamp" no pot ser NULL, ja que té una restricció not-null.

DELETE ON CASCADE: -- no em deixa borrar-ho perquè el camp "nomCamp" on es troba el valor, té una restricció foreing key que fa referència a una altra taula.

--Solució: borrar constraint i crear-la amb ON CASACADE DELETE




