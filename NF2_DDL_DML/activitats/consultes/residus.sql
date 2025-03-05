

--1
SELECT nom_empresa, ciutat_empresa, activitat
FROM empresaproductora
WHERE nif_empresa IN (SELECT DISTINCT nif_empresa
                        FROM residu_constituent
                        WHERE cod_constituent = 9912)
ORDER BY nom_empresa;

-- afegeix DISTINCT (té 2 claus primàries, es podria repetir)


--2
SELECT e.nom_empresa, r.quantitat_residu
FROM residu r JOIN empresaproductora e USING(nif_empresa)
WHERE r.quantitat_residu = (SELECT MAX(quantitat_residu)
                          FROM residu r2);