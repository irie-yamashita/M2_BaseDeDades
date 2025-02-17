

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
