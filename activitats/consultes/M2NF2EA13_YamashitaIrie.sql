/**EA13. JOINs (2)**/

/*1. Mostra els noms de tots els venedors i si tenen assigant un cap mostra el nom del seu cap com a "cap.*/
SELECT v.nombre "Venedors", c.nombre "Cap"
FROM repventas v LEFT JOIN repventas c ON v.director = c.num_empl;


/*2. Mostra els noms de tots els venedors i si tenen una oficina assignada mostra la ciutat on es troba l'oficina,*/
SELECT v.nombre "Venedors", o.ciudad "Ciutat Oficina"
FROM repventas v LEFT JOIN oficinas o ON v.oficina_rep = o.oficina;


/*3. Mostra els noms de tots els venedors i si tenen assigant un cap mostra el nom del seu cap
com a "cap", si tenen una oficina assignada mostra la ciutat on es troba l'oficina, i si l'oficina té assignat un director mostra també el nom del director de l'oficina on treballa el venedor com a "director". Només es pot utilitzar JOINs.*/
SELECT v.nombre "Venedors", c.nombre "Cap", o.ciudad "Ciutat Oficina", d.nombre "Director"
FROM repventas v LEFT JOIN repventas c ON v.director = c.num_empl
LEFT JOIN oficinas o ON v.oficina_rep = o.oficina
LEFT JOIN repventas d ON d.num_empl = o.dir;
