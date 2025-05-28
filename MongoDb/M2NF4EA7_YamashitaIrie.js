
/*EA7. CRUD i Agregacions - Irie Yamashita*/

//use itb;


/*Exercici 1. Insercions
Inserta els dos registres que trobaras al fitxer dadesInserts.json dins la col·lecció "people".
Si hi ha algun registre que no pots insertar degut a la sintàxis, corregeix el que sigui necessari
per insertar el registre.*/


//a)
    db.people.find().count(); //459

    db.people.insertOne(
    {
        "isActive" : false,
        "balance" : "$7,640.00",
        "picture" : "http://placehold.cat/32x32",
        "age" : 46,
        "name" : "Manuel Pares",
        "company" : "Tutor",
        "phone":  "843-729-40809",
        "email" : "mpares@tutor.com",
        "address" : "33785, Rome,Rescue aveniu",
        "about" : "Ad nostrud aliquip elit labore. Tempor consequat laboris incididunt consequat. Minim ex magna mollit laborum occaecat aliqua enim veniam. In culpa eiusmod irure do et et laborum non exercitation consequat sit voluptate exercitation id.\r\n",
        "registered" : "2000-02-12T01:35:45 -01:00",
        "latitude" : -12,
        "tags" : [
            "do",
            "qui",
            "adipisicing",
            "siusmod",
            "dolore",
            "magna",
            "reprehenderit",
        ],
        "friends" : [
            {
                "id" : 1,
                "name":  "Alyssa Oldman"
            },
            {
                "id" : 2,
                "name" : "Serenity Oswald"
            },
            {
                "id" : 3,
                "name" : "Sofia Webster"
            }
        ],
        "gender" : "male",
        "randomArrayItem" : "teacher",
    }
    )

    db.people.find().count(); //460
    db.people.find({"name": "Manuel Pares"});


//b)

    db.people.find().count(); //460
    db.people.insertOne({
        "isActive" : false,
        "balance" : "$6,540.00",
        "picture" : "http://placehold.it/32x32",
        "age" : 39,
        "name" : "Aly Sheldon",
        "company" : "Cobbs",
        "phone": "655-733-32802",
        "email" : "asheldon@cobbs.com",
        "address" : "32687, Cincinnati,,Alisson street",
        "about" : "Ad nostrud aliquip elit labore. Tempor consequat laboris incididunt consequat. Minim ex magna mollit laborum occaecat aliqua enim veniam. In culpa eiusmod irure do et et laborum non exercitation consequat sit voluptate exercitation id.\r\n",
        "registered" : "1994-05-29T03:14:10 -02:00",
        "latitude" : -9,
        "tags" : [
            "do",
            "qui",
            "incididunt",
            "siusmod",
            "dolore",
            "qui",
            "reprehenderit"
        ],
        "friends" : [
            {
                "id" : 1,
                "name" : "Mariah Campbell"
            },
            {
                "id": 2,
                "name" : "Serenity Oswald"
            },
            {
                "id" : 3,
                "name" : "Layla WifKinson"
            }
        ],
        "gender" : "female",
        "randomArrayItem" : "student"
    }
    );

   db.people.find().count(); //461
   db.people.find({"name": "Aly Sheldon"});




/*Exercici 2. Consultes*/

//a) Mostra les persones que el camp "name" acabi amb la lletra "n" però mostra només el camp "email".
db.people.find({"name": /n$/i}, {"email":1, "_id": 0});

//b) Mostra les persones que tinguin dins el camp "tags" o la paraula "qui" o la paraula "sunt". Limita que es mostrin només 8 documents, i que es vegin en un format "bonic".
db.people.find({"tags": {$in : ["qui", "sunt"]}}).limit(8).pretty();


//c) Mostra les persones que tenen com a amiga a "Serenity Nelson". Mostra els resultats en un format "bonic".
db.people.find({"friends.name":  "Serenity Nelson"}).pretty();


//d) Quantes persones s’han registrat entre l'any 2001 i 2018 (inclosos) i que en el camp "company" aparegui l’expressió regular "jam"? Has de mostrar el número de persones.
db.people.find({"registered": {$gte: '2001-01-01', $lte: '2018-12-31'}, "company": /jam/i}).count(); //8
db.people.find({"registered": {$gte: '2001-01-01', $lte: '2018-12-31'}, "company": {$regex: "jam", $options: "$i"}}).count(); //8


//e) Mostra les persones que no tinguin com tags ni "tempor" ni "nulla". Mostra només el camp "tags".
db.people.find({"tags": {$nin: ["tempor", "nulla"]}}, {"tags": 1, "_id":0}).count(); //!!!

//f) Mostra totes les persones de sexe femeni que tinguin 3 amics i que no estiguin actives. Mostra els resultats en un format "bonic".
db.people.find({
  "gender": "female",
  "isActive": false,
  $where: "this.friends.length === 3"
}).pretty(); //!!!!!

db.people.find({
  "gender": "female",
  "isActive": false,
  "$expr": { "$eq": [{ "$size": "$friends" }, 3] }
}).pretty();



/*Exercici 3. Actualitzacions*/

//a) Afegeix un nou camp anomenat "longitude" a totes les persones que en la seva adreça
//contingui la paraula "Berkeley". El valor d'aquest nou camp serà de 1. Has de tenir en
//compte el case sensitive.

db.people.find({"longitude": {$exists:true}}).count(); //6
db.people.find({"address": /Berkeley/i}).count(); //4

db.people.updateMany(
    {"address": /Berkeley/i},
    {$set: {"longitude": 1}}
);

db.people.find({"longitude": {$exists:true}}).count(); //10


//b) Afegeix un altre tag anomenat "foot", a la persona anomenada "Bella Carrington".
db.people.find({"name": "Bella Carrington"}, {"tags": 1});
db.people.updateOne(
    {"name": "Bella Carrington"},
    {$push: {"tags": "foot"}}
);

db.people.find({"name": "Bella Carrington"}, {"tags": 1});


//c) Afegeix un altre subdocument (amic) al camp «friends» de la persona anomenada "Julia
  //Young". El nou subdocument té al camp "id" el valor "1" i al camp "name" el valor
  //"Trinity Ford".

db.people.find({"name": "Julia Young", "friends.name": "Trinity Ford"}, {"friends": 1});

db.people.updateOne(
    {"name": "Julia Young"},
    {$push: {"friends": {
                            "id": 1,
                            "name": "Trinity Ford"
                        }
    }}
);

db.people.find({"name": "Julia Young", "friends.name": "Trinity Ford"}, {"friends": 1});


//d) Modifica el segon tag de la persona anomenada "Ava Miers"", el segon tag s'ha de dir "sunt".
db.people.find({"name": "Ava Miers"}, {"tags": 1}); //do

db.people.updateOne(
    {"name": "Ava Miers"},
    {$set: {"tags.1": "sunt"}}
);

db.people.find({"name": "Ava Miers"}, {"tags": 1}); //sunt




/*Exercici 4. Eliminacions*/
//a) Elimina totes les persones que el nom continguin l’expressió regular "berl" . Has de tenir en compte el case sensitive.
db.people.find({"name": /berl/i}).count(); //7

db.people.deleteMany(
    {"name": /berl/i}
);

db.people.find({"name": /berl/i}).count(); //0


//b) Elimina el camp «latitude» de tots els documents de la col·lecció.
db.people.find({"latitude": {$exists: true}}).count(); //454

db.people.updateMany(
    {},
    {$unset: {"latitude": 1}}
);

db.people.find({"latitude": {$exists: true}}).count(); //0


//c) Elimina el tag "enim" del camp "tags" de la persona anomenda "Aubrey Calhoun".
db.people.find({"name": "Aubrey Calhoun"}, {"tags":1}); //["incididunt", "enim", "ullamco", "sit", "commodo", "excepteur", "non"]

db.people.updateMany(
    {"name": "Aubrey Calhoun"},
    {$pull: {"tags": "enim"}}
);

db.people.find({"name": "Aubrey Calhoun"}, {"tags":1}); //["incididunt", "ullamco", "sit", "commodo", "excepteur", "non"]


//d) Elimina l'últim element del camp tags de la persona anomenada "Caroline Webster".
db.people.find({"name": "Caroline Webster"}, {"tags":1}); //"veniam"

db.people.updateMany(
    {"name": "Caroline Webster"},
    {$pop: {"tags": 1}}
);

db.people.find({"name": "Caroline Webster"}, {"tags":1}); //"eiusmod"




/*Exercici 5. Agregacions*/

//a) Mostra una llista amb el nom de tots els amics de les persones. Utilitza l’estructura aggregate.
db.people.aggregate([
       {$unwind: "$friends"},
       {$project: {"friends.name": 1, "_id": 0}}
])


//b) Cada persona té un array d’etiquetes (tags). Mostra quantes vegades apareix cada etiqueta. Utilitza l'estructura aggregate.
db.people.aggregate([
        {$unwind: "$tags"}, //separo array
        //agrupo i faig recompte
        {$group:{
            "_id": "$tags",
            "total": { $sum: 1}
        }}
])


//c) Calcula la mitjana d’edat del homes i la mitjana d’edat de les dones. Utilitza l’estructura
  //aggregate, i utilitza les funcions $group i $avg. Mostra el gènere (camp "gender") i la
  //mitjana d’edat del gènere (camp "age").

db.people.aggregate([
    {$group:{
        "_id": "$gender",
        "mitjanaEdat": {$avg: "$age"}
    }},
    {$project: {"gender": "$_id", "mitjanaEdat":1, "_id": 0}}
]);

//!!!!!! si vull mostrar la dada que fa el group by: "gender": "$_id"
//!!!! compte amb els claudàtors


//d) Mostra totes les persones que tinguin 7 o més etiquetes (tags). Utilitza l’estructura
  //aggregate. Utilitza les funcions $project i $match, i mostra només el nom de la persona i
  //número d’etiquetes.

db.people.aggregate([
    { $project: { "name": 1, "numTags": { $size: "$tags" }, "_id": 0} },
    { $match: { "numTags": { $gte: 7 } } }
]);

//!!!!!!!!!!!!!