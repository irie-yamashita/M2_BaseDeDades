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

CREATE TABLE ALUMNE(
    DNI VARCHAR(12) NOT NULL,
    data_naix DATE DEFAULT CURRENT_DATE,
    DNI_delegat VARCHAR(12) NOT NULL,

    CONSTRAINT PK_ALUMNE PRIMARY KEY (DNI),
    CONSTRAINT FK_ALUMNE_PERS_DNI FOREIGN KEY (DNI) REFERENCES PERSONA(DNI),
    CONSTRAINT FK_ALUMNE_DNI FOREIGN KEY (DNI_delegat) REFERENCES ALUMNE(DNI)
);

CREATE TABLE PROFESSOR(
    DNI VARCHAR(12) NOT NULL,
    especialitat VARCHAR(20),

    CONSTRAINT PK_PROFESSOR PRIMARY KEY (DNI),
    CONSTRAINT FK_PROF_PERS_DNI FOREIGN KEY (DNI) REFERENCES PERSONA(DNI)
);

CREATE ASSIGNATURA(
    cod_assignatura NUMERIC(10) NOT NULL,
    nom VARCHAR(40),

    CONSTRAINT PK_ASSIGNATURA PRIMARY KEY (cod_assignatura)
);

/*INCOMPLETA*/
CREATE AULA(
    numero VARCHAR(10) NOT NULL,
    metres NUMERIC,

    CONSTRAINT PK_AULA
);


CREATE TABLE IF NOT EXISTS PROVINCIA(
COD_PROVINCIA NUMERIC NOT NULL,
NOMBRE TEXT,
COD_REGION NUMERIC,
CONSTRAINT PK_PROVINCIA PRIMARY KEY (COD_PROVINCIA),
CONSTRAINT FK_COD_REG FOREIGN KEY (COD_REGION) REFERENCES REGION(COD_REGION));

PERSONA(DNI, nom, primer_cognom, segon_cognom, adreça, telf)
ALUMNE(DNI, dataNaix, DNI_delegat)
PROFESSOR(DNI, especialitat)
ASSIGNATURA(cod_assignatura, nom)
MODUL(cod_modul, nom, numero)
AULA(numero, metres)

Matricular(DNI, codi)
Ensenyar(cod_assignatura, DNI)
Te(cod_assignatura, cod_modul)
