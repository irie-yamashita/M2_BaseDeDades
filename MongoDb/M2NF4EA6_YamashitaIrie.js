/*EA6. Eliminacions en MongoDB - Irie Yamashita*/
/*1. Eliminar Documents de la col·lecció “movieDetails”.*/

//a. Elimina la pel·lícula que en el títol tingui Star Trek.
db.movieDetails.find({"title": "Star Trek"}).count(); //1

db.movieDetails.deleteOne({"title": "Star Trek"});

db.movieDetails.find({"title": "Star Trek"}).count(); //0


//b. Elimina la pel·lícula Love Actually.
db.movieDetails.find({"title": "Love Actually"}).count(); //1

db.movieDetails.deleteOne({"title": "Love Actually"});

db.movieDetails.find({"title": "Love Actually"}).count(); //0


//c. Elimina les pel·lícules que en el camp rated tingui "G".
db.movieDetails.find({"rated": "G"}).count(); //31

db.movieDetails.deleteMany({"rated": "G"});

db.movieDetails.find({"rated": "G"}).count(); //0


//d. Elimina les pel·lícules que siguin etiquetades com "Western".
db.movieDetails.find({"genres": "Western"}).count(); //33

db.movieDetails.deleteMany({"genres": "Western"});

db.movieDetails.find({"genres": "Western"}).count(); //0


//e. Elimina les pel·lícules que no hagin guanyat cap premi.
db.movieDetails.find({"awards.wins" : 0}).count(); //1607

db.movieDetails.deleteMany({"awards.wins" : 0});

db.movieDetails.find({"awards.wins" : 0}).count(); //1607