    
    --Creem una seqüència:
CREATE SEQUENCE PROVA_SQ
INCREMENT 10
START WITH 100
MAXVALUE 999999;

SELECT CURRVAL('PROVA_SQ');

INSERT INTO PERSONA(DNI,nom,primer_cognom,segon_cognom,adreça,telefon)
VALUES (NEXTVAL('PROVA_SQ'),'Maria','Lopez','Ruiz','C/ Balmes 54', '23465464');

UPDATE PERSONA SET DNI = NEXTVAL('PROVA_SQ') WHERE DNI = '110' ;

INSERT INTO PERSONA(DNI,nom,primer_cognom,segon_cognom,adreça,telefon)
VALUES (NEXTVAL('PROVA_SQ'),'Juan','Lopez','Ruiz','C/ Balmes 54', '23465464');