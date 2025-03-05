
https://learnsql.es/blog/10-ejercicios-de-subconsultas-correlacionadas-con-soluciones/



SELECT c.name, p.product_name, p.unit_price
FROM product p1 JOIN category c USING(category_id)
WHERE p1.unit_price > (SELECT AVG(p2.unit_price)
                        FROM product p2
                        WHERE p2.category_id = p1.category_id
                        GROUP BY p2.category_id);


/*S Consultes avançades*/

--1
