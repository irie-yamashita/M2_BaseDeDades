CREATE DATABASE escola;
CREATE USER escola WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'escola';
ALTER DATABASE escola OWNER TO escola;
GRANT ALL PRIVILEGES ON DATABASE escola TO escola;

psql -U escola -W -d escola

CREATE TABLE Persona(
    DNI VARCHAR(12) NOT NULL,
    nom VARCHAR(20) NOT NULL,
    primer_cognom VARCHAR(25),
    segon_cognom VARCHAR(25),
    adreça VARCHAR(60),
    telefon VARCHAR(11),

    CONSTRAINT PK_Persona PRIMARY KEY (DNI)
);

CREATE TABLE Alumne(
    DNI VARCHAR(12) NOT NULL,
    data_naix DATE DEFAULT CURRENT_DATE,
    DNI_delegat VARCHAR(12) NOT NULL,

    CONSTRAINT PK_Alumne PRIMARY KEY (DNI),
    CONSTRAINT FK_Alumne_Pers_DNI FOREIGN KEY (DNI) REFERENCES Persona(DNI),
    CONSTRAINT FK_Alumne_DNI FOREIGN KEY (DNI_delegat) REFERENCES Alumne(DNI)
);

CREATE TABLE Professor(
    DNI VARCHAR(12) NOT NULL,
    especialitat VARCHAR(20),

    CONSTRAINT PK_Professor PRIMARY KEY (DNI),
    CONSTRAINT FK_Prof_Pers_DNI FOREIGN KEY (DNI) REFERENCES Persona(DNI)
);

CREATE TABLE Assignatura(
    cod_assignatura NUMERIC(10) NOT NULL,
    nom VARCHAR(40),

    CONSTRAINT PK_Assignatura PRIMARY KEY (cod_assignatura)
);

CREATE TABLE Aula(
    numero VARCHAR(10) NOT NULL,
    metres NUMERIC,

    CONSTRAINT PK_Aula PRIMARY KEY (numero)
);

CREATE TABLE Modul(
    cod_modul VARCHAR(15) NOT NULL,
    nom VARCHAR(20),
    numero VARCHAR(10) NOT NULL,

    CONSTRAINT PK_Modul PRIMARY KEY (cod_modul),
    CONSTRAINT Modul_Aula_numero FOREIGN KEY (numero)  REFERENCES Aula(numero)
);

/*RESTRICCIONS: CHECK, DEFAULT i NOT NULL*/

-- afegeixo restricció NOT NULL
ALTER TABLE Persona ALTER COLUMN nom SET NOT NULL;
ALTER TABLE Persona ALTER COLUMN primer_cognom SET NOT NULL;

-- afegeixo un DEFAULT
ALTER TABLE Assignatura ALTER COLUMN cod_assignatura SET DEFAULT 000000001;
ALTER TABLE Modul ALTER COLUMN cod_modul SET DEFAULT 'M0';
--Conprovació amb: \d nomColumna

-- afegeixo restriccions
ALTER TABLE Persona
ADD CONSTRAINT CK_Inicap_NomPers CHECK (nom = INITCAP(nom));

ALTER TABLE Persona
ADD CONSTRAINT CK_Inicap_Cognom1Pers CHECK (primer_cognom = INITCAP(primer_cognom));

ALTER TABLE Persona
ADD CONSTRAINT CK_Inicap_Cognom2Pers CHECK (segon_cognom = INITCAP(segon_cognom));

ALTER TABLE Modul ALTER cod_modul TYPE VARCHAR(5);

/*INSERTS*/
--PERSONA
INSERT INTO Persona (DNI,nom,primer_cognom,segon_cognom,adreça,telefon) VALUES ('2348871', 'Felipe', 'Rodriguez', 'Gonzalez', 'Carrer de la Virtud, 34, 2n 2a', '634567333' );

--comprovació:
SELECT * FROM Persona;

INSERT INTO Persona (DNI,nom,primer_cognom,segon_cognom,adreça,telefon)
VALUES ('18766458', 'Arnau', 'Marquez', 'Heredia', NULL, '684325914' );

INSERT INTO Persona (DNI,nom,primer_cognom,segon_cognom,adreça,telefon)
VALUES ('14574478', 'Saray', 'Torrejon', 'Bernabeu', 'Passatge del Safareig, 24-26, 1r 2a', '625798555' );

INSERT INTO Persona (DNI,nom,primer_cognom,segon_cognom,adreça,telefon)
VALUES ('44788951', 'Manel', 'Hernandez', 'Puig', 'Carrer Balmes, 192', NULL );

INSERT INTO Persona (DNI,nom,primer_cognom,segon_cognom,adreça,telefon)
VALUES ('23894567', 'Irene', 'Xu', NULL, 'Carrer del Misteri, 154, 4t 2a', '611234788' );

INSERT INTO Persona (DNI,nom,primer_cognom,segon_cognom,adreça,telefon)
VALUES ('78451999', 'Alex', 'Ruiz', 'Grau', 'Avinguda Sabastida 66-68, esc A 1r 3a', '678444561' );

INSERT INTO Persona (DNI,nom,primer_cognom,segon_cognom,adreça,telefon)
VALUES ('12345678', 'Laura', 'Martinez', 'Lopez', 'Carrer de la Pau, 12, 3r 1a', '622334455' );

INSERT INTO Persona (DNI,nom,primer_cognom,segon_cognom,adreça,telefon)
VALUES ('87654321', 'Carlos', 'Sanchez', 'Vila', 'Passeig de Gracia, 45, 1r 2a', '615789123' );


-- Alumne !!posat primer el delegat
INSERT INTO Alumne (DNI, data_naix, DNI_delegat) 
VALUES ('14574478', '10-04-2004', '14574478');

INSERT INTO Alumne (DNI, data_naix, DNI_delegat)
VALUES ('2348871', '15-06-2005', '14574478');

INSERT INTO Alumne (DNI, data_naix, DNI_delegat) 
VALUES ('18766458', '22-09-2006', '14574478');

INSERT INTO Alumne (DNI, data_naix, DNI_delegat) 
VALUES ('44788951', '05-11-2005', '14574478');

INSERT INTO Alumne (DNI, data_naix, DNI_delegat) 
VALUES ('23894567', '17-04-2004', '14574478');

--Professor
INSERT INTO Professor (DNI, especialitat)
VALUES ('44788951', 'Història art');

INSERT INTO Professor (DNI, especialitat)
VALUES ('23894567', 'Francès');

INSERT INTO Professor (DNI, especialitat)
VALUES ('78451999', 'Informàtica');

INSERT INTO Professor (DNI, especialitat)
VALUES ('12345678', 'Filosofia');

INSERT INTO Professor (DNI, especialitat)
VALUES ('87654321', 'Audiovisual');

--Assignatura
INSERT INTO Assignatura (cod_assignatura,nom)
VALUES (015578, 'EF');

INSERT INTO Assignatura (cod_assignatura,nom)
VALUES (0147866, 'Filosofia');

INSERT INTO Assignatura (cod_assignatura,nom)
VALUES (017811, 'Llengua catalana');

INSERT INTO Assignatura (cod_assignatura,nom)
VALUES (088333, 'Història contemporànea');

INSERT INTO Assignatura (cod_assignatura,nom)
VALUES (DEFAULT, 'Tutoria');


-- Aula
INSERT INTO Aula (numero, metres)
VALUES ('A0101', 30.5);

INSERT INTO Aula (numero, metres)
VALUES ('A0102', 32.0);

INSERT INTO Aula (numero, metres)
VALUES ('A0103', 24.0);

INSERT INTO Aula (numero, metres)
VALUES ('A0201', 45.0);

INSERT INTO Aula (numero, metres)
VALUES ('A0202', 55.5);

INSERT INTO Aula (numero, metres)
VALUES ('A0203', 33.33);

-- Mòdul
INSERT INTO Modul (cod_modul, nom, numero)
VALUES ('M02', 'Base de dades', 'A0101');

INSERT INTO Modul (cod_modul, nom, numero)
VALUES ('M03', 'Programació', 'A0102');

INSERT INTO Modul (cod_modul, nom, numero)
VALUES ('M04', 'HTML i CSS', 'A0103');

INSERT INTO Modul (cod_modul, nom, numero)
VALUES ('M00', 'Tutoria', 'A0201');

INSERT INTO Modul (cod_modul, nom, numero)
VALUES ('M08', 'Desplegament', 'A0202');

/*MODIFICACIONS VALORS*/
UPDATE Alumne SET data_naix = '04-04-2004' WHERE DNI = '23894567';
UPDATE Persona SET nom = 'Bambino' WHERE DNI = '18766458';
UPDATE Modul SET cod_modul = 'M01' WHERE nom = 'Tutoria';
UPDATE Aula SET metres = '44.44' WHERE numero = 'A0201';

/*ELIMINACIÓ*/
DELETE FROM Modul WHERE cod_modul = 'M01';
DELETE FROM Assignatura WHERE cod_assignatura = '0147866';
UPDATE Aula SET metres = NULL WHERE numero = 'A0101' ; --Borro valor concret
TRUNCATE TABLE Modul;

