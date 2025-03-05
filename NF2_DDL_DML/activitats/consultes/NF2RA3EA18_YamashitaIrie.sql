/*NF2RA3EA18 - training*/

/*1) Mostrar totes les dades dels venedors que la suma total dels imports de les comandes que ha tramitat
és més petit de 30000. (Utilitza una subconsulta correlacionada).*/
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

/*2) Mostrar totes les dades d’aquells clients que la suma dels imports de les seves comandes sigui inferior
a 20000. (Utilitza una subconsulta correlacionada).*/
SELECT c.*
FROM clientes c
WHERE 2000 > (SELECT SUM(importe)
              FROM pedidos p
              WHERE c.num_clie = p.clie);


/*3) Mostrar les següents dades de les comandes tramitades per cada venedor: nom_venedor, quantitat_comandes, import_total, import_minim, import_maxim, importe_promig.
Si el venedor no ha fet cap comanda no el mostris. (Utilitza subconsultes correlaciondes per mostrar els resultat quan pertorqui).*/
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


/*4) Mostrar totes les dades dels clients que ha fet alguna comanda amb un import de comanda inferior a 10000. Utilitza una subconsulta correlacionada.*/
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


/*5) Mostra l'identificador dels clients que han fet més compres (que ha fet més comandes) i el número de comandes que ha fet.*/
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


/*6) Mostrar el nom del venedor i quantes comandes (pedidos) ha tramitat, però mostra només els
venedors que han tramitat més de 5 comandes. Utilitza una subconsulta correlacionada.*/

SELECT v.nombre, COUNT(p.num_pedido)
FROM repventas v
JOIN pedidos p ON (p.rep = v.num_empl)
GROUP BY v.nombre, p.rep
HAVING 5 <ANY (SELECT COUNT(p.num_pedido)
               FROM pedidos p2
               WHERE p2.rep = p.rep);
