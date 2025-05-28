
/*EA8. Agregacions - Irie Yamashita*/

//mongoimport --db itb --collection books --drop --type json --file C:\Users\argo\Desktop\IrieYamashita\MongoDB\arxius\books.json
//mongoimport --db itb --collection restaurants --drop --type json --file C:\Users\argo\Desktop\IrieYamashita\MongoDB\arxius\restaurants.json

//use itb

//1) De la col·lecció «books» mostra tots els llibres que tinguin com a mínim 5 authors.
db.books.aggregate([
    {$project: {authors:1, _id:0,"mida": { $size: "$authors" }}},
    {$match: {"mida":{$gte:5}}}
]);


//2) De la col·lecció «books» mostra els llibres ordenats per número d’autors de forma descendent. Primer els llibres amb més autors i al final els llibres amb menys autors.
db.books.aggregate([
    {$project: {authors:1, _id:0, "mida": { $size: "$authors" }}},
    {$sort: {"mida": -1}}
]);


//3) De la col·lecció «books» mostra els ISBN per cada Status "status". Utilitza l’estructura aggregate, i utilitza les funcions $group i $addToSet.

db.books.find();

db.books.aggregate([
   {
       $group:
         {
           _id: '$status',
           "llistat_isbn": { $addToSet:  "$isbn"}
         }
     }
]);

/*_id: {Status: '$status'}*/



//4) De la col·lecció «restaurants» mostra quantes valoracions "grades" té cada restaurant.
db.restaurants.find();

db.restaurants.aggregate([
    {
        $project: {name: 1, _id:0, "num_grades": {$size: "$grades"}}
    }
]);


//5) De la col·lecció «restaurants» mostra quantes vegades apareix cada valoració "score" del camp grades.
db.restaurants.aggregate([
    {$unwind: '$grades'},
    {
        $group: {
            _id : "$grades.score",
            "num_score": {$sum: 1}
        }
    },
    {$sort: {"_id": 1}}
]);

//6) De la col·lecció «restaurants» mostra quantes vegades la valoració "score" del camp grades ha sigut 11.

db.restaurants.aggregate([
    {$unwind: '$grades'},
    {
        $group: {
            _id : "$grades.score",
            "num_score": {$sum: 1}
        }
    },
    {$match: {_id: 11}}
]);



//7) De la col·lecció «restaurants» mostra quantes vegades apareix cada valoració "score" del camp grades però mostra només les valoracions que apareixen més de 60 vegades.
db.restaurants.aggregate([
    {$unwind: '$grades'},
    {
        $group: {
            _id : "$grades.score",
            "num_score": {$sum: 1}
        }
    },
    {$match: {"num_score": {$gt: 60}}}
]);



//8) De la col·lecció «restaurants» mostra els tipus de cuina "cuisine" de cada barri "borough".
db.restaurants.find();

db.restaurants.aggregate([
   {
       $group:
         {
           _id: '$borough', //_id: {Barris:'$borough'}
           "Tipus_cuina": { $addToSet:  "$cuisine"}
         }
     }
]);


//9) De la col·lecció "restaurants" mostra els noms dels carrers per cada codi postal.
db.restaurants.find();

db.restaurants.aggregate([
    {$unwind: "$address"},
    {
        $group: {
            _id: {"CODI_POSTAL": "$address.zipcode"},
            "Carrers": {$addToSet: "$address.street"}
        }
    }
]);


//10) De la col·lecció "restaurants" mostra quants restaurants hi ha en cada codi postal.
db.restaurants.aggregate([
    {$unwind: "$address"},
    {
        $group: {
            _id: {"CODI_POSTAL": "$address.zipcode"},
            "num_restaurants": {$sum: 1}
        }
    }
]);
