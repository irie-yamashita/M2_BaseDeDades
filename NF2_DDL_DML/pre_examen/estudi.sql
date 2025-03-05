CREATE DATABASE studio;
CREATE USER studio WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'studio';
ALTER DATABASE studio OWNER TO studio;
GRANT ALL PRIVILEGES ON DATABASE studio TO studio;

\q
psql -U studio -W -d studio

CREATE TABLE actor(
    act_id NUMERIC(10) UNIQUE NOT NULL,
    act_fname VARCHAR(30),
    act_lname VARCHAR(30),
    act_gender VARCHAR(1) NOT NULL,

    CONSTRAINT PK_actor PRIMARY KEY (act_id),
    CONSTRAINT CK_gender CHECK (act_gender IN ('D', 'H'))
);

CREATE TABLE director(
    dir_id NUMERIC(10) UNIQUE NOT NULL,
    dir_fname VARCHAR(20),
    dir_lname VARCHAR(20),

    CONSTRAINT PK_director PRIMARY KEY (dir_id)
);

CREATE TABLE movie(
    mov_id NUMERIC(10) UNIQUE NOT NULL,
    mov_title VARCHAR(60) UNIQUE NOT NULL,
    mov_year NUMERIC(10),
    mov_time NUMERIC(10) NOT NULL DEFAULT 60,
    mov_lang VARCHAR(20) NOT NULL,
    mov_dt_rel DATE NOT NULL,
    mov_rel_country VARCHAR(10) NOT NULL,

    CONSTRAINT PK_movie PRIMARY KEY (mov_id),
    CONSTRAINT CK_lang_MAJ CHECK (mov_lang = UPPER(mov_lang)),
    CONSTRAINT CK_count_MAJ CHECK (mov_rel_country = UPPER(mov_rel_country))
);

/*COMENTARIS*/


\d

\d actor
\d director
\d movie


/*Exercici 2 (0,75 punts)
Un cop creades les taules, ens hem adonat que hi ha errors en les taules «movie» i «director» i hem de modificar un quants camps. Escriu el codi per realitzar aquests canvis.*/
ALTER TABLE movie
ALTER COLUMN mov_time TYPE NUMERIC(4);

ALTER TABLE movie
ALTER COLUMN mov_lang TYPE VARCHAR(40);

\d movie

/*Exercici 3: Inserts. Explica ERROR i canviar.*/

--ACTOR
INSERT INTO actor(act_id, act_fname, act_lname, act_gender)
VALUES (101, 'James', 'Stewart', 'H');
-- insert correcte

INSERT INTO actor(act_id, act_fname, act_lname, act_gender)
VALUES (102, 'Deborah', 'Kerr', 'M');
/*ERROR:  el nuevo registro para la relación «actor» viola la restricción «check» «ck_gender»
DETALLE:  La fila que falla contiene (102, Deborah, Kerr, M).*/

-- Explicació error: el camp act_gender només accepta els valors D o M.
-- Solució:  Tornar a fer INSERT amb D en compte de M
INSERT INTO actor(act_id, act_fname, act_lname, act_gender)
VALUES (102, 'Deborah', 'Kerr', 'D');

INSERT INTO actor(act_id, act_fname, act_lname, act_gender)
VALUES (103, 'Peter', 'O Toole', 'H');
-- insert correcte

INSERT INTO actor(act_id, act_fname, act_lname, act_gender)
VALUES (104, 'Robert', 'De Niro', 'H');
-- insert correcte

INSERT INTO actor(act_id, act_fname, act_lname, act_gender)
VALUES (105, 'F.Murray', 'Abraham', 'H');
-- insert correcte

SELECT * FROM actor;

--DIRECTOR
INSERT INTO director(dir_id, dir_fname, dir_lname)
VALUES (201, 'Alfred', 'Hitchcock');

INSERT INTO director(dir_id, dir_fname, dir_lname)
VALUES (202, 'jack', 'Clayton');

INSERT INTO director(dir_id, dir_fname, dir_lname)
VALUES (203, 'david', 'Lean');

INSERT INTO director(dir_id, dir_fname, dir_lname)
VALUES (204, 'michael', 'Cimino');

-- tots inserts fets sense errors
SELECT * FROM director;


/*Exercici 4
Crea una seqüència anomenada seq_mov_id perquè el mov_id de la taula "movie" es pugui
autoincrementar. Que comenci per 610, que incrementi 10 i el valor màxim sigui 999999.*/

CREATE SEQUENCE seq_mov_id
INCREMENT 10
START WITH 610
MAXVALUE 999999;

\d

/*Exercici 5 (0,75 punts)
Introdueix les dades següents a la taula "movie", utilitzant la seqüència que has creat en l’anterior exercici. Explica error i canvia.*/



INSERT INTO movie(mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country)
VALUES ('Vertigo', 1958, 128, 'ENGLISH', '08/24/1958', 'UK');

/*
    ERROR:  el valor de hora/fecha está fuera de rango: «08/24/1958»
    LÍNEA 2: VALUES ('Vertigo', 1958, 128, 'ENGLISH', '08/24/1958', 'UK')...                                                   ^
    SUGERENCIA:  Quizás necesite una configuración diferente de «datestyle».
*/

--Explicació: em dona error perquè la data hauria de ser en format DD/MM/AAAA i està MM/DD/AAAA
-- Solució: canviar el datestyle i canviar d'ordre el mes i els dies
SET DATESTYLE TO PostgreSQL,European;
INSERT INTO movie(mov_id,mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country)
VALUES (NEXTVAL('seq_mov_id'),'Vertigo', 1958, 128, 'ENGLISH', '24/08/1958', 'UK');

SELECT NEXTVAL('seq_mov_id');

INSERT INTO movie(mov_id,mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country)
VALUES (CURRVAL('seq_mov_id'),'The Innocents', DEFAULT, 1961, 'ENGLISH', '19/02/1962', 'SW');
SELECT NEXTVAL('seq_mov_id');

INSERT INTO movie(mov_id,mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country)
VALUES (CURRVAL('seq_mov_id'),'Lawrence of Arabia', 1962, 216, 'ENGLISH', '11/12/1962', 'Uk');
/*
ERROR:  el nuevo registro para la relación «movie» viola la restricción «check» «ck_count_maj»
DETALLE:  La fila que falla contiene (630, Lawrence of Arabia, 1962, 216, ENGLISH, 11-12-1962, Uk).
*/

--Explicació: el valor 'Uk' del camp 'mov_rel_country' ha d'estar en majúscules.
-- Solució:
INSERT INTO movie(mov_id,mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country)
VALUES (CURRVAL('seq_mov_id'),'Lawrence of Arabia', 1962, 216, 'ENGLISH', '11/12/1962', 'UK');
SELECT NEXTVAL('seq_mov_id');

INSERT INTO movie(mov_id,mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country)
VALUES (CURRVAL('seq_mov_id'),'The Deer Hunter', 1978, 183, 'ENGLISH', '08/03/1979', 'UK');
SELECT NEXTVAL('seq_mov_id');

INSERT INTO movie(mov_id,mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country)
VALUES (CURRVAL('seq_mov_id'),'Amadeus', 1984, 160, 'ENGLISH', '07/01/1985', 'UK');
SELECT NEXTVAL('seq_mov_id');

SELECT * FROM movie;

/*UPDATE movie SET mov_id = 650 WHERE mov_id = 640 ;*/

/*Exercici 6 (1,5 punts)*/

CREATE TABLE movie_direction(
    dir_id_dir NUMERIC(10),
    mov_id_dir NUMERIC(5),

    CONSTRAINT PK_mov_dir PRIMARY KEY (dir_id_dir,mov_id_dir),
    CONSTRAINT CK_mov_dir_unique UNIQUE (dir_id_dir,mov_id_dir),
 
    CONSTRAINT FK_mov_dir  FOREIGN KEY (dir_id_dir) REFERENCES director(dir_id),
    CONSTRAINT FK_mov_dir_mov  FOREIGN KEY (mov_id_dir) REFERENCES movie(mov_id)
);

CREATE TABLE movie_cast(
    act_id_cast VARCHAR (10),
    mov_id_cast NUMERIC (5),
    role VARCHAR(30),

    CONSTRAINT PK_mov_cast PRIMARY KEY (act_id_cast,mov_id_cast),
    CONSTRAINT CK_mov_dir_unique UNIQUE (act_id_cast,mov_id_cast),
 
    CONSTRAINT FK_movCast_act  FOREIGN KEY (act_id_cast) REFERENCES actor(act_id),
    CONSTRAINT FK_movCast_mov FOREIGN KEY (mov_id_cast) REFERENCES movie(mov_id),
    CONSTRAINT CK_role_lower CHECK (role = LOWER(role))
);

/*ERROR:  la restricción de llave foránea «fk_movcast_act» no puede ser implementada
DETALLE:  Las columnas llave «act_id_cast» y «act_id» son de tipos incompatibles: character varying y numeric*/
-- «act_id_cast» ha de ser del mateix tipus que «act_id» -> NUMERIC (10)
CREATE TABLE movie_cast(
    act_id_cast NUMERIC (10),
    mov_id_cast NUMERIC (5),
    role VARCHAR(30),

    CONSTRAINT PK_mov_cast PRIMARY KEY (act_id_cast,mov_id_cast),
    CONSTRAINT CK_mov_dir_unique UNIQUE (act_id_cast,mov_id_cast),
 
    CONSTRAINT FK_movCast_act  FOREIGN KEY (act_id_cast) REFERENCES actor(act_id),
    CONSTRAINT FK_movCast_mov FOREIGN KEY (mov_id_cast) REFERENCES movie(mov_id),
    CONSTRAINT CK_role_lower CHECK (role = LOWER(role))
);


/*Exercici 7 (0,5 punts). INSERTS i explica error (no canviar)*/
INSERT INTO movie_direction(dir_id_dir, mov_id_dir)
VALUES (201,610);

INSERT INTO movie_direction(dir_id_dir, mov_id_dir)
VALUES (202,620);

INSERT INTO movie_direction(dir_id_dir, mov_id_dir)
VALUES (203, 730);

/*ERROR:  inserción o actualización en la tabla «movie_direction» viola la llave foránea «fk_mov_dir_mov» DETALLE:  La llave (mov_id_dir)=(730) no está presente en la tabla «movie».*/

-- És un valor d'una foreing key i fa referència a un valor que no existeix. mov_id = 730 no existeix.

SELECT * FROM movie_direction;

/*Exercici 8 (0,5 punts)*/
/*Introdueix les següents dades a les taula movie_cast. Si hi ha alguna fila que no es pot insertar perquè dona un error, explica l’error que dona, i canvia el que sigui necessari per poder insertar la fila.*/

INSERT INTO movie_cast(act_id_cast, mov_id_cast, role)
VALUES (101, 610, 'John Scottie Ferguson');
/*ERROR:  el nuevo registro para la relación «movie_cast» viola la restricción «check» «ck_role_lower» DETALLE:  La fila que falla contiene (101, 610, John Scottie Ferguson).*/
-- el valor del camp "role" ha d'estar en mínuscules
INSERT INTO movie_cast(act_id_cast, mov_id_cast, role)
VALUES (101, 610, 'john scottie ferguson');


INSERT INTO movie_cast(act_id_cast, mov_id_cast, role)
VALUES (102, 620, 'miss giddens');

INSERT INTO movie_cast(act_id_cast, mov_id_cast, role)
VALUES (103, 630, 't.e. lawrenc');

SELECT * FROM movie_cast;


/*Exercici 9 (0,75 punts) Afegeix els següents camps a la taula «movie», i comprova la nova estructura de la taula «movie»*/
ALTER TABLE movie
ADD COLUMN production_budget DECIMAL(10,2) DEFAULT 2500;

ALTER TABLE movie
ADD COLUMN profit DECIMAL(10,2);

ALTER TABLE movie
ADD COLUMN genres VARCHAR(50);

ALTER TABLE movie
ADD CONSTRAINT CK_UPPER_PROV CHECK (genres in ('comedy', 'sci-fi','horror','romance','drama'));

\d movie

/*Exercici 10 (0,5 punts) La taula movie actualment té el camp profit sense dades. Escriu una sentència que actualitzi el camp profit a 150000 d’aquelles pel·lícules que han sigut realitzades entre els anys 1958 i 1962.*/

UPDATE movie SET profit = 150000 WHERE (mov_year >= 1958 AND mov_year <=1962);
\d movie

/*Exercici 11 (0,5 punts)
Realitza les sentències pertinents
*/

-- Crea un índex únic sobre el camp «mov_id» de la taula «movie». Creus que és necessari? Raona la teva resposta.

CREATE UNIQUE INDEX mov_id_idx
ON movie(mov_id);

\d movie

-- NO fa falta perquè mov_id és clau primària i és UNIQUE per defecte.

    -- Crea un índex únic sobre el camp «mov_rel_country» de la taula «movie». Si no pots crear-lo explica perquè no es pot i crea un índex no únic.

CREATE UNIQUE INDEX mov_country_idx
ON movie(mov_rel_country);

/*ERROR:  no se pudo crear el índice único «mov_country_idx»
DETALLE:  La llave (mov_rel_country)=(UK) está duplicada.*/

-- el camp mov_rel_country té dos valors duplicats, llavors no podem crear un índex UNIQUE.
CREATE INDEX mov_country_idx
ON movie(mov_rel_country);

/*Exercici 12 (0,25 punts)
Elimina el camp production_budget de la taula movie.*/
ALTER TABLE movie
DROP COLUMN production_budget;

\d movie

/*Exercici 13 (0,5 punts)
Elimina el director amb codi «201». Si no es pot eliminar explica el motiu.*/
DELETE FROM director WHERE dir_id = 201;

/*ERROR:  update o delete en «director» viola la llave foránea «fk_mov_dir» en la tabla «movie_direction» DETALLE:  La llave (dir_id)=(201) todavía es referida desde la tabla «movie_direction».*/

-- no em deixa perquè tenim un camp a la taula «movie_direction» que té una foreing key que fa referència al dir_id. Si vull borrar el director, he de borrar el valor de l'altre taula també.

-- Solució: elimino restricció FK i la torno a crear amb ON DELETE CASCADE
ALTER TABLE movie_direction
DROP CONSTRAINT fk_mov_dir;

ALTER TABLE movie_direction
ADD CONSTRAINT FK_mov_dir  FOREIGN KEY (dir_id_dir) REFERENCES director(dir_id) ON DELETE CASCADE;


DELETE FROM director WHERE dir_id = 201;

/*Exercici 14 (0,5 punts)
Elimina l’actor amb cognom «Abraham». Si no es pot eliminar explica el motiu.*/
DELETE FROM actor WHERE act_lname = 'Abraham';

/*Exercici 15 (0,5 punts)
Crea una vista anomenada pelis_uk que només podrem veure el nom de la pel·lícula, l’any que es va fer i la duració de la pel·lícula de les pel·lícules del Regne Unit.*/
CREATE VIEW pelis_uk
AS (SELECT mov_title, mov_year, mov_time FROM movie WHERE mov_rel_country='UK');

\d

SELECT * FROM pelis_uk;