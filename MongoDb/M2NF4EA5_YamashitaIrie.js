
/*EA5. Actualitzacions en MongoDB - Irie Yamashita*/

/*1. Actualització de Documents dins de la col·lecció “movieDetails”. Per cada modificació consulta el document afectat abans i després del canvi.*/

/*a. Afegeix un camp anomenat “synopsis” al film "The Hobbit: An Unexpected Journey" amb aquest valor :
"A reluctant hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited
group of dwarves to reclaim their mountain home - and the gold within it - from the
dragon Smaug."
*/

db.movieDetails.find({"title": "The Hobbit: An Unexpected Journey"}, {"synopsis": 1});

db.movieDetails.updateOne(
	{ "title": "The Hobbit: An Unexpected Journey"},
	{ $set: { "synopsis": "A reluctant hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home - and the gold within it - from the dragon Smaug."}}
)

db.movieDetails.find({"title": "The Hobbit: An Unexpected Journey"}, {"synopsis": 1});

/* b. Afegeix un actor anomenat "Samuel L. Jackson" al film "Pulp Fiction".*/
db.movieDetails.find({"title": "Pulp Fiction"},{"actors": 1, "_id":0});

db.movieDetails.updateOne(
    {"title": "Pulp Fiction"},
    {$push: {"actors": "Samuel L. Jackson"}}
)

db.movieDetails.find({"title": "Pulp Fiction"},{"actors": 1, "_id":0});

//c. Elimina el camp type de tots els documents de la col·lecció “movieDetails”.

db.movieDetails.find({}, {"type":1, "_id": 0}).limit(5);

db.movieDetails.updateMany({}, {$unset: {"type": 1}});

db.movieDetails.find({}, {"type":1, "_id": 0}).limit(5);


//d. Modifica el cinquè guionista (writer) de la pel·lícula amb títol (title) : "The World Is Not Enough", el cinquè gionista s'ha de dir "Bruce Harris".

db.movieDetails.find({"title": "The World Is Not Enough"}, {"writers": 1, "_id":0});

db.movieDetails.updateOne(
    {"title": "The World Is Not Enough"},
    {$set: {"writers.4": "Bruce Harris"}}
);

db.movieDetails.find({"title": "The World Is Not Enough"}, {"writers": 1, "_id":0});

//e. Elimina l'últim element del camp genres de la pel·lícula amb títol "Whisper of the Heart".
db.movieDetails.find({"title": "Whisper of the Heart"}, {"genres": 1, "_id":0});

db.movieDetails.updateOne(
    {"title": "Whisper of the Heart"},
    {$pop: {"genres": 1}}
);

db.movieDetails.find({"title": "Whisper of the Heart"}, {"genres": 1, "_id":0});

