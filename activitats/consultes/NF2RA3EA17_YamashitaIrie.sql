/*NF2RA3EA17 - residus*/

/*Mostra el nom de les empreses, les seves ciutats i les seves activitats, d'aquelles empreses
que generen residus amb el constituent amb codi 9912. Mostra el resultats ordenats pel nom
de l'empresa. (Utilitza la subconsulta).*/

SELECT nom_empresa, ciutat_empresa, activitat
FROM empresaproductora
WHERE nif_empresa IN (SELECT nif_empresa
                     FROM residu_constituent
                     WHERE cod_constituent = 9912)
ORDER BY nom_empresa;

-- Correcció: t'ha faltat el ORDER BY

/*2. Mostra el nom de l’empresa i la quantitat de residus de l’empresa productora que genera
més residus tóxics. (Utilitza la cláusula JOIN).*/

SELECT e.nif_empresa, e.nom_empresa, r.quantitat_residu
FROM empresaproductora e JOIN residu r USING(nif_empresa)
ORDER BY r.quantitat_residu DESC
LIMIT 1;

-- Correcció:
select e.nom_empresa, r.quantitat_residu
from empresaproductora e JOIN residu r
ON e.nif_empresa = r.nif_empresa
WHERE r.quantitat_residu = (select max(quantitat_residu) from residu);


/*3. Mostra per cada tipus de tractament, la quantitat màxima de residus traslladats i la quantitat
mínima. Has de mostrar la informació en tres columnes anomenades com "max_quantitat",
"min_quantitat" i "tractament". Mostra només els tractaments que la quantitat mínima sigui
més gran que 1, i ordena els resultats per tractament.*/

SELECT tractament "tractament", MAX(quantitat_trasllat) "max_quantitat", MIN(quantitat_trasllat) "min_quantitat"
FROM trasllat
GROUP BY tractament
HAVING MIN(quantitat_trasllat) > 1
ORDER BY tractament;


/*4. Mostra els nom del destí com a "Destí", els nom de les ciutats de destí com a "Ciutat de
destí" de tots els trasllats que ha realitzat l'empresa transportista 'A-22300325' d'una distància
superior als 4297 kms. (Utilitza una subconsulta).*/

SELECT nom_desti "Destí", ciutat_desti "Ciutat de destí"
FROM desti
WHERE cod_desti IN (SELECT DISTINCT cod_desti
                    FROM trasllat_empresatransport
                    WHERE nif_emptransport = 'A-22300325'
                    AND kms > 4297);


/*5. Mostra els nom de l'empresa i el total de kilòmetres recorreguts per cada empresa de
transport de residus entre l’1 d’octubre del 2016 i el 30 de novembre del 2016. Mostra només
les empreses que han recorregut més de 3400 Km i ordena els resultats per total de
kilòmetres de forma descendent.*/

SELECT e.nom_emptransport, SUM(tr.kms) "Total kms"
FROM trasllat_empresatransport tr
JOIN empresatransportista e USING (nif_emptransport)
WHERE tr.data_enviament BETWEEN '2016-10-01' AND '2016-11-30'
GROUP BY e.nif_emptransport, e.nom_emptransport
HAVING SUM(tr.kms) > 3400
ORDER BY 2 DESC;