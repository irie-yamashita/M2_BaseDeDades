
-- 1
SELECT v.*
FROM repventas v
WHERE 30000 > (SELECT SUM(importe)
               FROM pedidos p
               WHERE v.num_empl = p.rep);

-- amb JOIN
SELECT v.*
FROM repventas v
JOIN pedidos p ON (p.rep = v.num_empl)
GROUP BY v.num_empl
HAVING SUM(p.importe) < 30000;

-- 2
SELECT c.*
FROM clientes c
WHERE 2000 > (SELECT SUM(importe)
              FROM pedidos p
              WHERE c.num_clie = p.clie);


-- 3
SELECT v.nombre,
       (SELECT COUNT(p.num_pedido) "quantitat_comandes" FROM pedidos p WHERE p.rep = v.num_empl),
       (SELECT SUM(p.importe) "import_total" FROM pedidos p WHERE p.rep = v.num_empl),
       (SELECT MIN(p.importe) "import_minim" FROM pedidos p WHERE p.rep = v.num_empl),
       (SELECT MAX(p.importe) "import_max" FROM pedidos p WHERE p.rep = v.num_empl),
       (SELECT ROUND(AVG(p.importe), 2) "import_promig" FROM pedidos p WHERE p.rep = v.num_empl)
FROM repventas v
WHERE (SELECT COUNT(p.num_pedido) "quantitat_comandes" FROM pedidos p WHERE p.rep = v.num_empl) > 0;

-- amb JOIN
SELECT v.nombre "nom_venedor", COUNT(p.num_pedido) "quantitat_comandes", SUM(importe) "importe_total", MIN(importe) "import_minim", MAX(importe) "import_maxim", AVG(importe) "import_promig"
FROM pedidos p
JOIN repventas v ON (p.rep = v.num_empl)
GROUP BY p.rep, v.nombre;


-- 4
SELECT c.*
FROM clientes c
WHERE (SELECT MIN(importe) FROM pedidos p WHERE p.clie = c.num_clie) < 10000;

-- o també...
SELECT c.*
FROM clientes c
WHERE 10000 >ANY (SELECT importe
              FROM pedidos p
              WHERE p.clie = c.num_clie);

/*
>ANY -> MIN
<ALL -> MAX
*/


-- 5
SELECT p.clie, COUNT(num_pedido)
FROM pedidos p
GROUP BY p.clie
HAVING COUNT(num_pedido) >=ALL (SELECT COUNT(num_pedido)
                                FROM pedidos p2
                                GROUP BY p2.clie);

-- o també...
SELECT p.clie, COUNT(num_pedido)
FROM pedidos p
GROUP BY p.clie
HAVING COUNT(num_pedido) = (SELECT MAX(c)
                                FROM (SELECT COUNT(num_pedido) AS c
                                FROM pedidos p2
                                GROUP BY p2.clie) as a);

