CREATE DATABASE escola;
CREATE USER escola WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'escola';
ALTER DATABASE escola OWNER TO escola;
GRANT ALL PRIVILEGES ON DATABASE escola TO escola;

psql -U escola -W -d escola

CREATE TABLE Persona(
    DNI VARCHAR(12) NOT NULL,
    nom VARCHAR(20) NOT NULL,
    primer_cognom VARCHAR(25) NOT NULL,
    segon_cognom VARCHAR(25),
    adreça VARCHAR(60),
    telefon VARCHAR(11),

    CONSTRAINT PK_Persona PRIMARY KEY (primer_cognom)
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

