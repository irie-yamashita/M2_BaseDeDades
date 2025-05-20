/*EA2. Consultes avançades en MongoDB - Irie Yamashita*/

/*Utilitzant la col·lecció “Students” que vam importar en l’EA1 realitza les següents consultes:*/

//mongo itb

db.students.find().pretty();


//1. Busqueu els estudiants de gènere masculí
db.students.find({"gender": "H"});

//2. Busqueu el estudiants de gènere femení
db.students.find({"gender": "M"});

//3. Busqueu els estudiants nascuts l’any 1993
db.students.find({"birth_year": 1993});

//4. Busqueu els estudiants de gènere masculí nascuts a l’any 1993
db.students.find({"gender": "H", "birth_year": 1993});

//5. Busqueu els estudiant nascuts a la dècada dels 90
db.students.find({"birth_year": {$gte: 1990, $lt:2000}});

//6. Busqueu els estudiants de gènere masculí nascuts abans del l’any 90
db.students.find({"gender": "H", "birth_year": {$lt: 1990}});

//7. Busqueu els estudiants de gènere femení nascuts abans del l’any 90
db.students.find({"gender": "M", "birth_year": {$lt: 1990}});

//8. Busqueu els estudiants nascuts a la dècada dels 80 i de gènere femení
db.students.find({"gender": "M", "birth_year": {$gte: 1980, $lt: 1990}});

//9. Busqueu els estudiants de gènere masculí nascuts a la dècada dels 80
db.students.find({"gender": "H", "birth_year": {$gte: 1980, $lt: 1990}});

//10. Busqueu els estudiants de gènere femení nascuts a la dècada dels 80
db.students.find({"gender": "M", "birth_year": {$gte: 1980, $lt: 1990}});

//11. Busqueu els estudiants que no han nascut a l’any 1985
db.students.find({"birth_year": {$ne: 1985}});

//12. Busqueu els estudiants nascuts als anys 1970, 1980 o 1990
db.students.find({"birth_year": {$in: [1970, 1980, 1990]}});

//13. Busqueu els estudiants no nascuts als anys 1970, 1980 o 1990
db.students.find({"birth_year": {$nin: [1970, 1980, 1990]}});

//14. Busqueu els estudiants nascuts en any parell
db.students.find({"birth_year": {$mod: [2, 0]}});

//15. Busqueu els estudiants nascuts en any múltiple de 10
db.students.find({"birth_year": {$mod: [10, 0]}});

//16. Busqueu els estudiants que tinguin telèfon auxiliar
db.students.find({"phone_aux": {$ne: ""}});

//17. Busqueu els estudiants que no tinguin segon cognom
db.students.find({"lastname2": {$eq: ""}});

//18. Busqueu els estudiants que tinguin telèfon auxiliar i un sol cognom
db.students.find({"phone_aux": {$ne: ""}, "lastname2": {$eq: ""}});

//19. Busqueu els estudiants que tinguin un email que acabi en .net
db.students.find({"email": /\.net$/});
db.students.find({"email": {$regex:"\.net$"}});

//20. Busqueu els estudiants que tinguin un nom que comenci per vocal
db.students.find({"firstname": /^[AEIOU]/i});
db.students.find({"firstname": {$regex:"^[AEIOU]", $options:"$i"}});

//21. Busqueu els estudiants que tinguin un nom més llarg de 13 caràcters
db.students.find({"firstname": /.{13,}/});
db.students.find({"firstname": {$regex:".{13,}", $options:"$i"}});

//22. Busqueu els estudiants que tinguin un nom amb més de 3 vocals
db.students.find({"firstname": /[aeiuo]{3,}/i});
db.students.find({"firstname": {$regex:"[aeiuo]{3,}", $options:"$i"}});

//23. Busqueu els estudiants que tinguin un dni que comenci per lletra
db.students.find({$and: [{"dni": /^[A-Z]/i}, {"dni" : {$ne: "NULL"}}]});

//24. Busqueu els estudiants que tinguin un dni que comenci i acabi per lletra
db.students.find({$and: [{"dni": /^[A-Z].*[A-Z]$/i}, {"dni" : {$ne: "NULL"}}]});

//25. Busqueu els estudiants que tinguin telèfon que comenci per 622
db.students.find({"phone": /^622/});
