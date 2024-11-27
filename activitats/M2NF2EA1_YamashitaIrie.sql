
CREATE TABLE IF NOT EXISTS REGION (
COD_REGION NUMERIC NOT NULL,
NOMBRE TEXT,
CONSTRAINT PK_REGION PRIMARY KEY (COD_REGION));

CREATE TABLE IF NOT EXISTS PROVINCIA(
COD_PROVINCIA NUMERIC NOT NULL,
NOMBRE TEXT,
COD_REGION NUMERIC,
CONSTRAINT PK_PROVINCIA PRIMARY KEY (COD_PROVINCIA),
CONSTRAINT FK_COD_REG FOREIGN KEY (COD_REGION) REFERENCES REGION(COD_REGION));

CREATE TABLE IF NOT EXISTS LOCALIDAD(
COD_LOCALIDAD NUMERIC NOT NULL,
NOMBRE TEXT,
COD_PROVINCIA NUMERIC,
CONSTRAINT PK_LOCALIDAD PRIMARY KEY (COD_LOCALIDAD),
CONSTRAINT FK_COD_PROV FOREIGN KEY (COD_PROVINCIA) REFERENCES PROVINCIA (COD_PROVINCIA));

CREATE TABLE IF NOT EXISTS EMPLEADO (
ID NUMERIC NOT NULL,
DNI VARCHAR(9)UNIQUE,
NOMBRE TEXT,
FECHA_NAC DATE,
TELEFONO NUMERIC,
SALARIO NUMERIC,
COD_LOCALIDAD NUMERIC,
CONSTRAINT PK_EMPLEADO PRIMARY KEY (ID),
CONSTRAINT FK_COD_LOC FOREIGN KEY (COD_LOCALIDAD) REFERENCES LOCALIDAD(COD_LOCALIDAD));