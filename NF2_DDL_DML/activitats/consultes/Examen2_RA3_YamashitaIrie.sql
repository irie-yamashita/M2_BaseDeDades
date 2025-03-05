
/*Correccio Examen 2 RA3 - Irie Yamashita*/

-- 01
SELECT nombre
FROM repventas
WHERE num_empl IN (SELECT rep
                   FROM pedidos
                   GROUP BY rep
                   HAVING SUM(importe) > 50000);
/*1 row*/


-- 02
SELECT o.oficina, o.ciudad, d.nombre "director"
FROM oficinas o
LEFT JOIN repventas d ON (o.dir = d.num_empl)
AND lower(o.region) = 'este';
/*5 rows*/

-- 03
SELECT v.nombre, v.edad, c.empresa, p.fecha_pedido, p.producto, p.cant
FROM repventas v
LEFT JOIN pedidos p ON (v.num_empl = p.rep)
LEFT JOIN clientes c ON (c.num_clie = p.clie)
ORDER BY c.empresa;
/*31 rows*/

-- 04
SELECT *
FROM repventas
WHERE oficina_rep IN (SELECT oficina
                      FROM oficinas
                      WHERE lower(region) = 'oeste');
/*3 rows*/

-- 05
SELECT *
FROM clientes
WHERE num_clie IN (SELECT clie
                   FROM pedidos
                   GROUP BY clie
                   HAVING SUM(importe) > 40000);
/*1 row*/

-- 06
SELECT *
FROM pedidos
WHERE clie IN (SELECT num_clie
               FROM clientes
               WHERE rep_clie = (SELECT num_empl
                                 FROM repventas
                                 WHERE nombre LIKE 'Sue%'));
/*5 row*/

-- 07
SELECT v.nombre "nom_venedor", COUNT(p.num_pedido) "quantitat_comandes", SUM(importe) "importe_total", MIN(importe) "import_minim", MAX(importe) "import_maxim", AVG(importe) "import_promig"
FROM pedidos p
JOIN repventas v ON (p.rep = v.num_empl)
GROUP BY p.rep, v.nombre;
/*9 rows*/


-- 08
SELECT empresa
FROM clientes
WHERE num_clie IN (SELECT DISTINCT clie
                   FROM pedidos
                   WHERE importe > 15000);
/*6 rows*/


-- 09
SELECT v.nombre, c.nombre "cap", o.ciudad, d.nombre "director"
FROM repventas v
LEFT JOIN repventas c ON (v.director = c.num_empl)
LEFT JOIN oficinas o ON (v.oficina_rep = o.oficina)
LEFT JOIN repventas d ON (o.dir = d.num_empl);
/*10 rows*/


-- 10
SELECT rep, COUNT(num_pedido) "Num comandes"
FROM pedidos
GROUP BY rep
HAVING COUNT(num_pedido) = (SELECT MAX(nComandes)
                            FROM (SELECT COUNT(num_pedido) nComandes
                                  FROM pedidos
                                  GROUP BY rep) AS a);
/*1 row*/
/*Correcció: els àlies sense cometes dobles*/