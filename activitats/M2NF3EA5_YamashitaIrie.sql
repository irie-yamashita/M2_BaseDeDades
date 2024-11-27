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

/*INSERTS*/
--PERSONA
INSERT INTO Persona (DNI,nom,primer_cognom,segon_cognom,adreça,telefon) VALUES (2348871, 'Felipe', 'Rodriguez', 'Gonzalez', 'Carrer de la Virtud, 34, 2n 2a', 634567333 );

--comprovació:
SELECT * FROM Persona;

INSERT INTO Persona (DNI,nom,primer_cognom,segon_cognom,adreça,telefon) VALUES (18766458, 'Arnau', 'Marquez', 'Heredia', NULL, 684325914 );

INSERT INTO Persona (DNI,nom,primer_cognom,segon_cognom,adreça,telefon) VALUES (14574478, 'Saray', 'Torrejon', 'Bernabeu', 'Passatge del Safareig, 24-26, 1r 2a', 625798555 );

INSERT INTO Persona (DNI,nom,primer_cognom,segon_cognom,adreça,telefon) VALUES (44788951, 'Manel', 'Hernandez', 'Puig', 'Carrer Balmes, 192', NULL );

INSERT INTO Persona (DNI,nom,primer_cognom,segon_cognom,adreça,telefon) VALUES (23894567, 'Irene', 'Xu', NULL, 'Carrer del Misteri, 154, 4t 2a', 611234788 );