# AGGREGATE()

### SIZE
Utilitza `$project` i dintre "crear una variable/camp" per guardar elo `$size`:  
```js
//1) De la col·lecció «books» mostra tots els llibres que tinguin com a mínim 5 authors.
    db.books.aggregate([
        {$project: {authors:1, _id:0,"mida": { $size: "$authors" }}},
        {$match: {"mida":{$gte:5}}}
    ]);
```

### SIZE + ORDRE
Pots utilitzar el "camp nou creat" per ordenar:
```js
//2) De la col·lecció «books» mostra els llibres ordenats per número d’autors de forma descendent. Primer els llibres amb més autors i al final els llibres amb menys autors.

    db.books.aggregate([
        {$project: {authors:1, _id:0, "mida": { $size: "$authors" }}},
        {$sort: {"mida": -1}}
    ]);

```

### GROUP + PUSH/ADDTOSET

```js
//3) De la col·lecció «books» mostra els ISBN per cada Status "status". Utilitza l’estructura aggregate, i utilitza les funcions $group i $addToSet.

db.books.aggregate([
   {
       $group:
         {
           _id: '$status', //_id: {Status: '$status'}
           "llistat_isbn": { $addToSet:  "$isbn"}
         }
     }
]);
```

### ARRAY + COUNT + GROUP BY
Si vull fer un count d'elements d'una array he de fer `unwind` i després ja puc accedir als elements de dintre l'array amb `array.propietat`.

```js
    //5) De la col·lecció «restaurants» mostra quantes vegades apareix cada valoració "score" del camp grades.
    db.restaurants.aggregate([
        {$unwind: '$grades'},
        {
            $group: {
                _id : "$grades.score",
                "num_score": {$sum: 1}
            }
        },
        {$sort: {"_id": 1}} //extra
    ]);
```


### ARRAY + COUNT + GROUP BY + MATCH
Jo veig el `$match` com unn `HAVING` (condició després d'haver fet el GROUPBY).

```js
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

```

```js
//a) Mostra una llista amb el nom de tots els amics de totes les persones. Utilitza l’estructura aggregate.

db.people.aggregate([{$unwind: "$friends"}, {$group: {_id:
{NomAmic:"$friends.name"}}}]);
```



```js

```