
/*EA 9 - Excepcions 1*/

/*01*/
-- El IF(func) va en el bloc anònim. El procediment simplement fa l'INSERT, no comprova res.

/*02*/
--  El bloc EXCEOTION va al bloc anònim. Fas un Raise Notice del id i nom (que és el retorn de la funció). Si es null, saltarà l'excepció.

/* ???? Però no puc posar el EXCEPTION a la funció? -> perquè t'ho diu l'enunciat :)*/
