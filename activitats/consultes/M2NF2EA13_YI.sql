/**EA13. JOINs (2)**/

--1
SELECT c.empresa "Venedors", r.nombre "Cap"
FROM clientes c RIGHT JOIN repventas r ON c.rep_clie = r.num_empl;

--2
SELECT c.empresa "Venedors", o.ciudad "Ciutat"
FROM clientes c LEFT JOIN repventas r ON (c.rep_clie = r.num_empl)
LEFT JOIN oficinas o ON (r.oficina_rep = o.oficina);
