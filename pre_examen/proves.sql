    
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
PK: -- El valor de la clau primària ja existeix, està duplicada.

FK: -- El valor que estem intentant inserir a "nomCamp" és una foreing key i fa referència a un valor que no existeix. 

--No la podem inserir perqué el order_id 4003 no existeix.


CK: -- el valor del "nomCamp" no compleix amb la restricció "nom_ck" de la taula "nomTaula". 

-- La data de shipped_date és inferior a la data de order_date.
-- Dona error per escriure ‘EUROP’ en comptes de 'EUROPA'

NOT NULL: -- El valor del camp "nomCamp" no pot ser NULL, ja que té una restricció not-null.

DELETE ON CASCADE: -- no em deixa eliminar perquè el valor "valor" està referenciat a una altra taula (nomTaula).

--Solució: borrar constraint i crear-la amb l'opció ON CASACADE DELETE
ALTER TABLE ORDER_DETAILS
DROP CONSTRAINT fk_orderdetails_orderf;

ALTER TABLE ORDER_DETAILS
DROP CONSTRAINT fk_orderdetails_orderf;

-- també tenim ON UPDATE CASCADE


### Data format Espanya
```sql
-- Per canviar format data a Europeu posar: dd/mm/aaaa
SET DATESTYLE TO PostgreSQL,European;
SHOW datestyle;

-- Si volem canviar a model altre: SET DATESTYLE TO ISO;
```


