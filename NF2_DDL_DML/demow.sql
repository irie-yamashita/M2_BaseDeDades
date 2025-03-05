

--b
ALTER TABLE Fitxa
ADD COLUMN equip INTEGER;

--c
INSERT INTO Fitxa (dni, nom, cognoms, adreça, telefon, equip, provincia, data_naix) VALUES (3421232, 'LUIS MIGUEL', 'ACEDO GÓMEZ', 'GUZMÁN EL BUENO, 90', 969231256, 1, NULL, '05/05/1970');

INSERT INTO Fitxa (dni, nom, cognoms, adreça, telefon, equip, provincia, data_naix) VALUES (4864868, 'BEATRIZ', 'SANCHO MANRIQUE', 'ZURRIAGA, 25', 932321212, 2, 'BCN', '06/07/1978');

--d
DELETE
FROM Fitxa
WHERE dni = '3421232';

--e
INSERT INTO Fitxa (dni, nom, cognoms, adreça, telefon, equip, provincia, data_naix) VALUES (3421232, 'LUIS MIGUEL', 'ACEDO GÓMEZ', 'GUZMÁN EL BUENO, 90', 969231256, 1, NULL, DEFAULT);

--f
TRUNCATE TABLE FITXA;

-- a
INSERT INTO Fitxa (dni, nom, cognoms, adreça, telefon, equip, provincia, data_naix) VALUES (7868544, 'JONÁS', 'ALMENDROS RODRÍGUEZ', 'FEDERICO PUERTAS, 3', 915478947, 3, 'MADRID', '01/01/1987');

INSERT INTO Fitxa (dni, nom, cognoms, adreça, telefon, equip, provincia, data_naix) VALUES (8324216, 'PEDRO', 'MARTÍN HIGUERO', 'VIRGEN DEL CERRO, 154', 961522344, 5, 'SORIA', '29/04/1978');


ROLLBACK;

SELECT * FROM Fitxa; --comprovo
--han desaparegut les files insertades :(

-- !!!!!!!!!!!!!!!!! BEGIN
BEGIN;

-- b
INSERT INTO Fitxa (dni, nom, cognoms, adreça, telefon, equip, provincia, data_naix) VALUES (14948992, 'SANDRA', 'MARTÍN, GONZÁLEZ', 'PABLO NERUDA, 15', 916581515, 6, 'MADRID', '05/05/1970');

-- c
COMMIT;

-- d
INSERT INTO Fitxa (dni, nom, cognoms, adreça, telefon, equip, provincia, data_naix) VALUES (15756214, 'MIGUEL', 'CAMARGO ROMÁN', 'ARMADORES, 1', 949488588, 7, NULL,'12/12/1985');

-- e
SAVEPOINT intA;

-- f
COMMIT;

-- g
INSERT INTO Fitxa (dni, nom, cognoms, adreça, telefon, equip, provincia, data_naix) VALUES (21158230, 'SERGIO', 'ALFARO IBIRICU', 'AVENIDA, DEL, EJERCITO,, 76', 934895855, 8, 'BCN', '11/11/1987');


INSERT INTO Fitxa (dni, nom, cognoms, adreça, telefon, equip, provincia, data_naix) VALUES (34225234, 'ALEJANDRO', 'ALCOCER JARABO', 'LEONOR, DE, CORTINAS,, 7', 935321211, 9, 'MADRID', '05/05/1970');


-- h
SAVEPOINT intB;

-- i
INSERT INTO Fitxa (dni, nom, cognoms, adreça, telefon, equip, provincia, data_naix) VALUES (38624852, 'ALVARO', 'RAMÍREZ AUDIGE', 'FUENCARRAL, 33', 912451168, 10, 'MADRID', '10/09/1976');

-- j
SAVEPOINT intC;

-- k
INSERT INTO Fitxa (dni, nom, cognoms, adreça, telefon, equip, provincia, data_naix) VALUES (45824852, 'ROCÍO', 'PÉREZ DEL OLMO', 'CERVANTES, 22', 912332138, 11, 'MADRID', '06/12/1987');
INSERT INTO Fitxa (dni, nom, cognoms, adreça, telefon, equip, provincia, data_naix) VALUES (48488588, 'JESÚS', 'BOBADILLA SANCHO', 'GAZTAMBIQUE, 32', 913141111, 13, 'MADRID', '05/05/1970');

-- l
SAVEPOINT intD;

SELECT * FROM Fitxa;

-- m
DELETE
FROM Fitxa
WHERE dni = '45824852';

-- n
SAVEPOINT intE;
SELECT * FROM Fitxa;

-- o
UPDATE Fitxa
SET equip = 11
WHERE dni = '48488588';

SAVEPOINT intF;

-- p
ROLLBACK TO intE;

-- q
ROLLBACK TO intE;

-- r
UPDATE Fitxa
SET equip = 11
WHERE dni = '38624852';

INSERT INTO Fitxa (dni, nom, cognoms, adreça, telefon, equip, provincia, data_naix) VALUES ();


/*EXAMEN*/

-- 3
ALTER TABLE Lloguer
RENAME CONSTRAINT ck_retorn TO ck_ret;

-- 4
ALTER TABLE Lloguer
DROP COLUMN preu;

-- 5
ALTER TABLE Lloguer
ADD COLUMN preu DOUBLE PRECISION NOT NULL;

    -- o
ALTER TABLE Lloguer
ADD COLUMN preu DOUBLE PRECISION;

ALTER TABLE Lloguer
ALTER COLUMN preu SET NOT NULL;

-- 6
ALTER TABLE Lloguer
ADD CONSTRAINT ck_preu CHECK (preu > 0);


-- 7
ALTER TABLE Lloguer
ADD CONSTRAINT ck_data CHECK (dataretorn > datalloguer);


-- 8
ALTER TABLE Lloguer
ALTER COLUMN client TYPE NUMERIC(35);

-- Dona error perquè la columna client és una clau forana que fa referència a un altre camp que és de tipus INTEGER. Llavors client ha de ser del mateix tipus.

-- 9
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


-- 10


-- 11
CREATE SEQUENCE idlloguer_seq
INCREMENT 10
START WITH 100
MAXVALUE 99999999;


-- 13
UPDATE Lloguer
SET retorn = 'PEN'
WHERE preu > 150;

-- 14
DELETE FROM bicicleta
WHERE idbici = 2126219;

-- 15
DROP TABLE client;

-- 16
TRUNCATE TABLE bicicleta;

-- 17
CREATE VIEW telfclient
AS (SELECT nom, cognom1, telefon
FROM Client);

-- 18
CREATE UNIQUE INDEX cognom_idx
ON Client(cognom1);

-- 19
UPDATE bicicleta
SET idbici = 2233456
WHERE idbici = 4233456;

ALTER TABLE lloguer
DROP CONSTRAINT fk_llog_bic;

ALTER TABLE lloguer
ADD CONSTRAINT fk_llog_bic  FOREIGN KEY (bici) REFERENCES BICICLETA(idbici) ON UPDATE CASCADE;

-- 20
TRUNCATE TABLE Bicicleta CASCADE;

BEGIN;
INSERT INTO bicicleta VALUES ('45567', 'BH', 'Simple', '600');

-- 1 ROW

DELETE FROM bicicleta WHERE idbici='45567';
ROLLBACK;

INSERT INTO bicicleta VALUES ('533422', 'BH', 'Ramses', 970);
