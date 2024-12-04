    
--Creem una base de dades i usuari:
CREATE DATABASE proves;
CREATE USER proves WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'proves';
ALTER DATABASE proves OWNER TO proves;
GRANT ALL PRIVILEGES ON DATABASE proves TO proves;

\q
-- comprovació: \l
psql -U proves -W -d proves

-------------------------------------------------

(\S+)
$1,

(?<!\d)\b[A-Za-z]+\b(?!\d)
'$&'

------------------------------------------------------

CREATE TABLE VIVENDA(
    CARRER VARCHAR(80) UNIQUE NOT NULL,
    NOMBRE NUMERIC(4) UNIQUE NOT NULL,
    TIPUS_VIVENDA VARCHAR(1),
    CODI_POSTAL NUMERIC(5) DEFAULT 00001,
    METRES NUMERIC(5),
    NOM_ZONA VARCHAR(60),

    CONSTRAINT PK_VIVENDA PRIMARY KEY (CARRER),
    CONSTRAINT PK_VIVENDA PRIMARY KEY (CARRER,NOMBRE),

    CONSTRAINT FK_VIVENDA_ZONAURBANA_NOMZONA FOREIGN KEY (NOM_ZONA) REFERENCES ZONAURBANA(NOM_ZONA),

    CONSTRAINT CK_CARRER_MAJUS CHECK (CARRER = INITCAP(CARRER)),
    CONSTRAINT CK_NOMBRE CHECK (NOMBRE > 0),
    CONSTRAINT CK_TIPUS_VIVENDA CHECK (TIPUS_VIVENDA IN ('C', 'B'))
);

---------------------------------------------------

    INSERT INTO nomTaula()
    VALUES ();

------------------------------------------------

/*MISSATGE ERROR*/
PK: -- El valor de la clau primària ja existeix, està duplicada.

FK: -- El valor que estem intentant inserir a "nomCamp" és una foreing key i fa referència a un valor que no existeix. 

--No la podem inserir perqué el order_id 4003 no existeix.
-- És un valor d'una foreing key i fa referència a un valor que no existeix. mov_id = 730 no existeix.


CK: -- el valor del "nomCamp" no compleix amb la restricció "nom_ck" de la taula "nomTaula". 

-- La data de shipped_date és inferior a la data de order_date.
-- Dona error per escriure ‘EUROP’ en comptes de 'EUROPA'

NOT NULL: -- El valor del camp "nomCamp" no pot ser NULL, ja que té una restricció not-null.

DELETE ON CASCADE: -- no em deixa eliminar perquè el valor "valor" està referenciat a una altra taula (nomTaula).



--------------------------------

/*ON DELETE CASCADE*/
--Solució: borrar constraint i crear-la amb l'opció ON CASACADE DELETE
ALTER TABLE ORDER_DETAILS
DROP CONSTRAINT fk_orderdetails_orderf;

ALTER TABLE ORDER_DETAILS
DROP CONSTRAINT fk_orderdetails_orderf;

-- també tenim ON UPDATE CASCADE

----------------------------------------


/*Data format EUROPA*/

-- Per canviar format data a Europeu posar: dd/mm/aaaa
SET DATESTYLE TO PostgreSQL,European;
SHOW datestyle;

-- Si volem canviar a model altre: SET DATESTYLE TO ISO;



----------------------------------------------------------------------------

CREATE TABLE PERSONA (
    ID NUMERIC(10),
    nom VARCHAR(10),

    CONSTRAINT PK_PERSONA PRIMARY KEY (ID)
);

/*TRUC SEQÜÈNCIA*/
--SEQUENCE
--1. crees seqüència
CREATE SEQUENCE PROVA_SQ
INCREMENT 10
START WITH 100
MAXVALUE 999999;

--2. insert sense seqüència
INSERT INTO PERSONA(ID,nom)
VALUES (10,'Joana');

--3. si no hi ha error -> borro taula
TRUNCATE TABLE PERSONA;

-- 4. Primer INSERT amb NEXTVAL
INSERT INTO PERSONA(ID,nom)
VALUES (NEXTVAL('PROVA_SQ'),'Joana');

--5. Altres INSERT amb CURRVAL
SELECT NEXTVAL('PROVA_SQ');
INSERT INTO PERSONA(ID,nom)
VALUES (CURRVAL('PROVA_SQ'),'Emma');

SELECT NEXTVAL('PROVA_SQ');
INSERT INTO PERSONA(ID,nom)
VALUES (CURRVAL('PROVA_SQ'),'Amber');

-- error: TRUNCATE TABLE PERSONA;
-- compr: SELECT * FROM PERSONA;
