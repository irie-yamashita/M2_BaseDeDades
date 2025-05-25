/*EA4. Expressions regulars en MongoDB - Irie Yamashita*/

/*1. Consulta de dades utilitzant expressions regulars a la col·lecció “movieDetails”.*/

//a. Cerca totes les pel·lícules que a la seva sinopsis conté la paraula “Bilbo”.
db.movieDetails.find({"synopsis":/Bilbo/i});

//b. Compta les pel·lícules que al camp "plot" no contngui la paraula "Bilbo".
db.movieDetails.find({"plot": {$not: /Bilbo/i}}).count(); //!!!!!

//c. Cerca totes les pel·lícules que a la seva sinopsis conté la paraula "Bilbo" o al camp "plot" conté la paraula "Bilbo".
db.movieDetails.find({$or : [{"synopsis": /Bilbo/i}, {"plot": /Bilbo/i}]});

//d. Cerca totes les pel·lícules que al camp "plot" conté les paraules "dwarves" o "hobbit".
db.movieDetails.find({$or : [{"plot": /dwarves/i}, {"plot": /hobbit/i}]});
db.movieDetails.find({"plot": /dwarves|hobbit/i}); //!!!!!

//e. Cerca totes les pel·lícules que al seu títol conté les paraules "Battle" i "Armies".
db.movieDetails.find({$and : [{"title": /Battle/i}, {"title": /Armies/i}]});