
CREATE TABLE clientes (
    num_clie smallint NOT NULL,
    empresa character varying(20) NOT NULL,
    rep_clie smallint NOT NULL,
    limite_credito numeric(8,2)
);

CREATE TABLE oficinas (
    oficina smallint NOT NULL,
    ciudad character varying(15) NOT NULL,
    region character varying(10) NOT NULL,
    dir smallint,
    objetivo numeric(9,2),
    ventas numeric(9,2) NOT NULL
);

CREATE TABLE pedidos (
    num_pedido integer NOT NULL,
    fecha_pedido date NOT NULL,
    clie smallint NOT NULL,
    rep smallint,
    fab character(3) NOT NULL,
    producto character(5) NOT NULL,
    cant smallint NOT NULL,
    importe numeric(7,2) NOT NULL
);

CREATE TABLE productos (
    id_fab character(3) NOT NULL,
    id_producto character(5) NOT NULL,
    descripcion character varying(20) NOT NULL,
    precio numeric(7,2) NOT NULL,
    existencias integer NOT NULL
);

CREATE TABLE repventas (
    num_empl smallint NOT NULL,
    nombre character varying(15) NOT NULL,
    edad smallint,
    oficina_rep smallint,
    titulo character varying(10),
    contrato date NOT NULL,
    director smallint,
    cuota numeric(8,2),
    ventas numeric(8,2) NOT NULL
);


insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2111,	'JCP Inc.',	103,	50000.00) ;
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2102,	'First Corp.',	101,	65000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2103,	'Acme Mfg.',	105,	50000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2123,	'Carter & Sons',	102,	40000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2107,	'Ace International',	110,	35000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2115,	'Smithson Corp.',	101,	20000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2101,	'Jones Mfg.',	106,	65000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2112,	'Zetacorp',	108,	50000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2121,	'QMA Assoc.',	103,	45000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2114,	'Orion Corp',	102,	20000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2124,	'Peter Brothers',	107,	40000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2108,	'Holm & Landis',	109,	55000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2117,	'J.P. Sinclair',	106,	35000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2122,	'Three-Way Lines',	105,	30000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2120,	'Rico Enterprises',	102,	50000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2106,	'Fred Lewis Corp.',	102,	65000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2119,	'Solomon Inc.',	109,	25000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2118,	'Midwest Systems',	108,	60000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2113,	'Ian & Schmidt',	104,	20000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2109,	'Chen Associates',	103,	25000.00);
insert into Clientes (num_clie, empresa, rep_clie, limite_credito) values (2105,	'AAA Investments',	101,	45000.00);


insert into oficinas (oficina, ciudad, region, dir, objetivo, ventas) values (22,	'Denver',	'Oeste',	108,	300000.00,	186042.00);
insert into oficinas (oficina, ciudad, region, dir, objetivo, ventas) values (11,	'New York',	'Este',	106,	575000.00,	692637.00);
insert into oficinas (oficina, ciudad, region, dir, objetivo, ventas) values (12,	'Chicago',	'Este',	104,	800000.00,	735042.00);
insert into oficinas (oficina, ciudad, region, dir, objetivo, ventas) values (13,	'Atlanta',	'Este',	105,	350000.00,	367911.00);
insert into oficinas (oficina, ciudad, region, dir, objetivo, ventas) values (21,	'Los Angeles',	'Oeste',	108,	725000.00,	835915.00);

insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (112961,	'1989-12-17',	2117,	106,	'rei',	'2a44l',	7,	31500.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113012,	'1990-01-11',	2111,	105,	'aci',	'41003',	35,	3745.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (112989,	'1990-01-03',	2101,	106,	'fea',	'114',  	6,	1458.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113051,	'1990-02-10',	2118,	108,	'qsa',	'xk47',  	4,	1420.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (112968,	'1989-10-12',	2102,	101,	'aci',	'41004',	34,	3978.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (110036,	'1990-01-30',	2107,	110,	'aci',	'4100z',	9,	22500.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113045,	'1990-02-02',	2112,	108,	'rei',	'2a44r',	10,	45000.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (112963,	'1989-12-17',	2103,	105,	'aci',	'41004',	28,	3276.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113013,	'1990-01-14',	2118,	108,	'bic',	'41003',	1,	652.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113058,	'1990-02-23',	2108,	109,	'fea',	'112',  	10,	1480.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (112997,	'1990-01-08',	2124,	107,	'bic',	'41003',	1,	652.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (112983,	'1989-12-27',	2103,	105,	'aci',	'41004',	6,	702.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113024,	'1990-01-20',	2114,	108,	'qsa',	'xk47', 	20,	7100.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113062,	'1990-02-24',	2124,	107,	'fea',	'114',  	10,	2430.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (112979,	'1989-10-12',	2114,	102,	'aci',	'4100z',	6,	15000.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113027,	'1990-01-22',	2103,	105,	'aci',	'41002',	54,	4104.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113007,	'1990-01-08',	2112,	108,	'imm',	'773c', 	3,	2925.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113069,	'1990-03-02',	2109,	107,	'imm',	'775c', 	22,	31350.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113034,	'1990-01-29',	2107,	110,	'rei',	'2a45c',	8,	632.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (112992,	'1989-11-04',	2118,	108,	'aci',	'41002',	10,	760.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (112975,	'1989-12-12',	2111,	103,	'rei',	'2a44g',	6,	2100.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113055,	'1990-02-15',	2108,	101,	'aci',	'4100x',	6,	150.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113048,	'1990-02-10',	2120,	102,	'imm',	'779c', 	2,	3750.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (112993,	'1989-01-04',	2106,	102,	'rei',	'2a45c',	24,	1896.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113065,	'1990-02-27',	2106,	102,	'qsa',	'xk47', 	6,	2130.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113003,	'1990-01-25',	2108,	109,	'imm',	'779c', 	3,	5625.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113049,	'1990-02-10',	2118,	108,	'qsa',	'xk47', 	2,	776.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (112987,	'1989-12-31',	2103,	105,	'aci',	'4100y',	11,	27500.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113057,	'1990-02-18',	2111,	103,	'aci',	'4100x',	24,	600.00);
insert into pedidos (num_pedido, fecha_pedido, clie, rep, fab, producto, cant, importe) values (113042,	'1990-02-02',	2113,	101,	'rei',	'2a44r',	5,	22500.00);

insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('rei',	'2a45c',	'V Stago Trinquete',	79.00,	210);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('aci',	'4100y',	'Extractor',	2750.00,	25);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('qsa',	'xk47', 	'Reductor',	355.00,	38);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('bic',	'41672',	'Plate',	180.00,	0);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('imm',	'779c', 	'Riostra 2-Tm',	1875.00,	9);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('aci',	'41003',	'Articulo Tipo 3',	107.00,	207);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('aci',	'41004',	'Articulo Tipo 4',	117.00,	139);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('bic',	'41003',	'Manivela',	652.00,	3);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('imm',	'887p', 	'Perno Riostra',	250.00,	24);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('qsa',	'xk48', 	'Reductor',	134.00,	203);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('rei',	'2a44l',	'Bisagra Izqda.',	4500.00,	12);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('fea',	'112',  	'Cubierta',	148.00,	115);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('imm',	'887h', 	'Soporte Riostra',	54.00,	223);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('bic',	'41089',	'Retn',	225.00,	78);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('aci',	'41001',	'Articulo Tipo 1',	55.00,	277);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('imm',	'775c', 	'Riostra 1-Tm',	1425.00,	5);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('aci',	'4100z',	'Montador',	2500.00,	28);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('qsa',	'xk48a',	'Reductor',	117.00,	37);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('aci',	'41002',	'Articulo Tipo 2',	76.00,	167);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('rei',	'2a44r',	'Bisagra Dcha.',	4500.00,	12);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('imm',	'773c', 	'Riostra 1/2-Tm',	975.00,	28);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('aci',	'4100x',	'Ajustador',	25.00,	37);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('fea',	'114',  	'Bancada Motor',	243.00,	15);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('imm',	'887x', 	'Retenedor Riostra',	475.00,	32);
insert into productos(id_fab, id_producto, descripcion, precio, existencias) values ('rei',	'2a44g',	'Pasador Bisagra',	350.00,	14);

insert into repventas (num_empl, nombre, edad, oficina_rep, titulo, contrato, director, cuota, ventas) values (105,	'Bill Adams',	37,	13,	'Rep Ventas',	'1988-02-12',	104,	350000.00,	367911.00);
insert into repventas (num_empl, nombre, edad, oficina_rep, titulo, contrato, director, cuota, ventas) values (109,	'Mary Jones',	31,	11,	'Rep Ventas',	'1989-10-12',	106,	300000.00,	392725.00);
insert into repventas (num_empl, nombre, edad, oficina_rep, titulo, contrato, director, cuota, ventas) values (102,	'Sue Smith',	48,	21,	'Rep Ventas',	'1986-12-10',	108,	350000.00,	474050.00);
insert into repventas (num_empl, nombre, edad, oficina_rep, titulo, contrato, director, cuota, ventas) values (106,	'Sam Clark',	52,	11,	'VP Ventas',	'1988-06-14',	null,	275000.00,	299912.00);
insert into repventas (num_empl, nombre, edad, oficina_rep, titulo, contrato, director, cuota, ventas) values (104,	'Bob Smith',	33,	12,	'Dir Ventas',	'1987-05-19',	106,	200000.00,	142594.00);
insert into repventas (num_empl, nombre, edad, oficina_rep, titulo, contrato, director, cuota, ventas) values (101,	'Dan Roberts',	45,	12,	'Rep Ventas',	'1986-10-20',	104,	300000.00,	305673.00);
insert into repventas (num_empl, nombre, edad, oficina_rep, titulo, contrato, director, cuota, ventas) values (110,	'Tom Snyder',	41,	null,	'Rep Ventas',	'1990-01-13',	101,	null,	75985.00);
insert into repventas (num_empl, nombre, edad, oficina_rep, titulo, contrato, director, cuota, ventas) values (108,	'Larry Fitch',	62,	21,	'Dir Ventas',	'1989-10-12',	106,	350000.00,	361865.00);
insert into repventas (num_empl, nombre, edad, oficina_rep, titulo, contrato, director, cuota, ventas) values (103,	'Paul Cruz',	29,	12,	'Rep Ventas',	'1987-03-01',	104,	275000.00,	286775.00);
insert into repventas (num_empl, nombre, edad, oficina_rep, titulo, contrato, director, cuota, ventas) values (107,	'Nancy Angelli',	49,	22,	'Rep Ventas',	'1988-11-14',	108,	300000.00,	186042.00);


ALTER TABLE ONLY clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (num_clie);

ALTER TABLE ONLY oficinas
    ADD CONSTRAINT oficinas_pkey PRIMARY KEY (oficina);

ALTER TABLE ONLY pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (num_pedido);

ALTER TABLE ONLY productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id_fab, id_producto);

ALTER TABLE ONLY repventas
    ADD CONSTRAINT repventas_pkey PRIMARY KEY (num_empl);


ALTER TABLE ONLY oficinas ADD CONSTRAINT director_fk FOREIGN KEY (dir) REFERENCES repventas(num_empl) ON DELETE CASCADE;

ALTER TABLE ONLY clientes ADD CONSTRAINT representate_fk FOREIGN KEY (rep_clie) REFERENCES repventas(num_empl) ON DELETE CASCADE;

ALTER TABLE ONLY repventas ADD CONSTRAINT opera_fk FOREIGN KEY (oficina_rep) REFERENCES oficinas(oficina) ON DELETE CASCADE; 
ALTER TABLE ONLY repventas ADD CONSTRAINT director_repventas_fk FOREIGN KEY (director) REFERENCES repventas(num_empl) ON DELETE CASCADE;

ALTER TABLE ONLY pedidos ADD CONSTRAINT pedido_por_fk FOREIGN KEY (clie) REFERENCES clientes(num_clie) ON DELETE CASCADE;
ALTER TABLE ONLY pedidos ADD CONSTRAINT tomado_por_fk FOREIGN KEY (rep) REFERENCES repventas(num_empl) ON DELETE CASCADE;
ALTER TABLE ONLY pedidos ADD CONSTRAINT es_por_fk FOREIGN KEY (fab, producto) REFERENCES productos(id_fab, id_producto) ON DELETE CASCADE;




