
/*Crea una base de dades i usuari anomenats shop. Es crearà l’estructura de la base de dades d’una
botiga d’informàtica.*/
CREATE DATABASE shop;
CREATE USER shop WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'shop';
ALTER DATABASE shop OWNER TO shop;
GRANT ALL PRIVILEGES ON DATABASE shop TO shop;

-- comprovació: \l
psql -U shop -W -d shop


/*EXERCICI 1*/

/*a) Crear taules ORDERF, PRODUCT i ORDER_DETAILS*/

CREATE TABLE ORDERF (
    order_id NUMERIC(12) UNIQUE,
    order_date DATE,
    shipped_date DATE,
    ship_address VARCHAR(50) NOT NULL,
    ship_city VARCHAR(20),
    ship_region VARCHAR(20),

    CONSTRAINT PK_FORDERF PRIMARY KEY (order_id),
    CONSTRAINT CK_shipDate_sup CHECK (shipped_date > order_date),
    CONSTRAINT CK_shipReg CHECK (ship_region IN ('USA', 'EUROPA', 'ASIA', 'AMERICA', 'RUSIA'))
);
--comprovació: \d ORDERF

--comentaris
COMMENT ON TABLE ORDERF IS 'Taula amb registre de les comandes de la botiga.';
COMMENT ON COLUMN ORDERF.order_id IS 'Identificador de comanda';
COMMENT ON COLUMN ORDERF.order_date IS 'Data de comanda';
COMMENT ON COLUMN ORDERF.shipped_date IS 'Data enviament';
COMMENT ON COLUMN ORDERF.ship_address IS 'Adreça enviament';
COMMENT ON COLUMN ORDERF.ship_city IS 'Ciutat enviament';
COMMENT ON COLUMN ORDERF.ship_region IS 'Regió enviament';

--comprovació: \d+ ORDERF


CREATE TABLE PRODUCT (
    product_id NUMERIC(12) UNIQUE,
    product_name VARCHAR(50) NOT NULL,
    unitprice DOUBLE PRECISION NOT NULL,
    unitstock NUMERIC(3) NOT NULL,
    unitonorder NUMERIC(3) NOT NULL DEFAULT 1,

    CONSTRAINT PK_PRODUCT PRIMARY KEY (product_id)
);

--comentaris
COMMENT ON TABLE PRODUCT IS 'Taula amb registre dels productes de la botiga.';
COMMENT ON COLUMN PRODUCT.product_id IS 'Identificador de comanda';
COMMENT ON COLUMN PRODUCT.product_name IS 'Nom del producte';
COMMENT ON COLUMN PRODUCT.unitprice IS 'Preu unitat';
COMMENT ON COLUMN PRODUCT.unitstock IS 'Número unitats en stock';
COMMENT ON COLUMN PRODUCT.unitonorder IS 'Número unitats de comanda';

--comprovació: \d+ PRODUCT



CREATE TABLE ORDER_DETAILS (
    order_id NUMERIC(12) NOT NULL,
    product_id NUMERIC(12) NOT NULL,
    quantity NUMERIC(3) NOT NULL,
    discount NUMERIC(3),

    CONSTRAINT PK_ORDER_DETAILS PRIMARY KEY (order_id,product_id),
    CONSTRAINT FK_DETAIL_ORD FOREIGN KEY (order_id) REFERENCES ORDERF(order_id),
    CONSTRAINT FK_DETAIL_PROD FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);

--comentaris
COMMENT ON TABLE ORDER_DETAILS IS 'Taula amb registre els detalls de les comandes de la botiga.';
COMMENT ON COLUMN ORDER_DETAILS.order_id IS 'Identificadors de detall de comanda';
COMMENT ON COLUMN ORDER_DETAILS.product_id IS 'Identificadors de detall de comanda';
COMMENT ON COLUMN ORDER_DETAILS.quantity IS 'Quantitat de porducte';
COMMENT ON COLUMN ORDER_DETAILS.discount IS 'Descompte';

--comprovació: \d+ ORDER_DETAILS


/*b) Comprova que les taules s'han creat correctament.*/

    --- comprovaciótotes les taules
    \d+

    --- comprovaciótotes de cada una
    \d+ ORDERF
    \d+ PRODUCT
    \d+ ORDER_DETAILS


/*c) Modifica ORDERF: */

     --ship_city VARCHAR(40)
     ALTER TABLE ORDERF
     ALTER ship_city TYPE VARCHAR(40);

     --ship_region VARCHAR(40))
     ALTER TABLE ORDERF
     ALTER ship_region TYPE VARCHAR(40);

/*d) Crea una seqüència per product_id que autoincrementi. Comença per 1, incrementa 1 i el màxim és 99999: */

-- creo seqüència
CREATE SEQUENCE PRODUCTID_SEQ
INCREMENT 1
START WITH 1
MAXVALUE 99999;

-- comprovació creació seq: \d  | miro valor seq: SELECT CURRVAL('PRODUCTID_SEQ');

/*e) Introdueix les següents dades a la taula PRODUCT: */

    INSERT INTO PRODUCT(product_id, product_name, unitprice, unitstock,unitonorder)
    VALUES (NEXTVAL('PRODUCTID_SEQ'),'nikkon ds90', 67.09, 75, 1);

    INSERT INTO PRODUCT(product_id, product_name, unitprice, unitstock,unitonorder)
    VALUES (NEXTVAL('PRODUCTID_SEQ'),'canon t90', 82.82, 92, 1);

    INSERT INTO PRODUCT(product_id, product_name, unitprice, unitstock,unitonorder)
    VALUES (NEXTVAL('PRODUCTID_SEQ'),'dell inspirion', 182.78, 56, 2);

    INSERT INTO PRODUCT(product_id, product_name, unitprice, unitstock,unitonorder)
    VALUES (NEXTVAL('PRODUCTID_SEQ'),'ipad air', 482.83, 34, 2);

    INSERT INTO PRODUCT(product_id, product_name, unitprice, unitstock,unitonorder)
    VALUES (NEXTVAL('PRODUCTID_SEQ'),'microsoft surface', 93.84, 91, 2);

    INSERT INTO PRODUCT(product_id, product_name, unitprice, unitstock,unitonorder)
    VALUES (NEXTVAL('PRODUCTID_SEQ'),'nexus 6', 133.88,16, DEFAULT);

    INSERT INTO PRODUCT(product_id, product_name, unitprice, unitstock,unitonorder)
    VALUES (NEXTVAL('PRODUCTID_SEQ'),'thinkpad t365', 133.88, 22, DEFAULT);

    -- comprovació: SELECT * FROM PRODUCT;

/*f) Introdueix les següents dades a la taula ORDERF: */
    INSERT INTO ORDERF(order_id,order_date,shipped_date,ship_address,ship_city,ship_region)
    VALUES (4001,'2016-04-04','2016-11-06','93 Spohn Place','Manggekompo','ASIA');

    INSERT INTO ORDERF(order_id,order_date,shipped_date,ship_address,ship_city,ship_region)
    VALUES (4002,'2017-01-29','2016-05-28','46 Eliot Trail','Virginia','USA');
    /* NO puc fer INSERT
    ERROR:  new row for relation "orderf" violates check constraint "ck_shipdate_sup"
    DETAIL:  Failing row contains (4002, 2017-01-29, 2016-05-28, 46 Eliot Trail, Virginia, USA).
    */
    INSERT INTO ORDERF(order_id,order_date,shipped_date,ship_address,ship_city,ship_region)
    VALUES (4001,'2016-08-19','2016-12-08','23 Sundown Junction','Obodivka','RUSIA');
    /* NO puc fer INSERT perquè la order_id és clau primària i no pot estar repetida
    INSERT INTO ORDERF(order_id,order_date,shipped_date,ship_address,ship_city,ship_region)
    VALUES (4001,'2016-08-19','2016-12-08','23 Sundown Junction','Obodivka','RUSIA');
    */

    INSERT INTO ORDERF(order_id,order_date,shipped_date,ship_address,ship_city,ship_region)
    VALUES (4004,'2016-09-25','2016-12-24', NULL,'Nova Venécia','AMERICA');
    /*
    ERROR:  null value in column "ship_address" violates not-null constraint
    DETAIL:  Failing row contains (4004, 2016-09-25, 2016-12-24, null, Nova Venécia, AMERICA).
    */

    INSERT INTO ORDERF(order_id,order_date,shipped_date,ship_address,ship_city,ship_region)
    VALUES (4005,'2017-03-14','2017-03-19','7 Ludington Court','Sukamaju','ASIA');


    INSERT INTO ORDERF(order_id,order_date,shipped_date,ship_address,ship_city,ship_region)
    VALUES (4006,'2016-08-14','2016-12-05','859 Dahle Plaza', NULL,'ASIA');

    INSERT INTO ORDERF(order_id,order_date,shipped_date,ship_address,ship_city,ship_region)
    VALUES (4007,'2017-01-02','01-02-2017','5 Fuller Center Log pri','Brezovici','EUROP');

    /*
    ERROR:  new row for relation "orderf" violates check constraint "ck_shipreg"
    DETAIL:  Failing row contains (4007, 2017-01-02, 2017-02-01, 5 Fuller Center Log pri, Brezovici, EUROP).
    */

    -- comprovació: SELECT * FROM ORDERF;

/*g) Introdueix les següents dades a la taula ORDER_DETAILS: */
    
    INSERT INTO ORDER_DETAILS(order_id,product_id,quantity,discount)
    VALUES (4001, 1, 5, 8.73);

    INSERT INTO ORDER_DETAILS(order_id,product_id,quantity,discount)
    VALUES (4003,3,8,4.01);

    /*
    ERROR:  insert or update on table "order_details" violates foreign key constraint "fk_detail_ord"
    DETAIL:  Key (order_id)=(4003) is not present in table "orderf".
    */

    INSERT INTO ORDER_DETAILS(order_id,product_id,quantity,discount)
    VALUES (4005,601,2,3.05);
    /*
    ERROR:  insert or update on table "order_details" violates foreign key constraint "fk_detail_prod"
    DETAIL:  Key (product_id)=(601) is not present in table "product".
    */

    INSERT INTO ORDER_DETAILS(order_id,product_id,quantity,discount)
    VALUES (4006,2,4,5.78);

        -- comprovació: SELECT * FROM ORDER_DETAILS;

/*EXERCICI 2*/
CREATE INDEX ship_address_index
ON ORDERF(ship_address);

CREATE INDEX product_name_index
ON PRODUCT(product_name);

/*EXERCICI 3*/
