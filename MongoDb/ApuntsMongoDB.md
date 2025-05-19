# Apuntes Mongo DB
!!! Vigila amb el nom de la db i de la taula/collection.

## INTRODUCCIÓ

### INSERT
+ **.insertOne**
```js
db.productos.insertOne({"name": "MacBook Pro"});
```
+ **.insertMany**
```js
db.productos.insertMany([
{"name": "iPhone 8"},
{"name": "iPhone 6s"},
{"name": "iPhone X"},
{"name": "iPhone SE"},
{"name": "iPhone 7"}
])

```
## SELECT *

## FIND -> FILTRE

### Literal
```js
db.productos.find({ "name": "MacBook Air" })
```

També puc buscar per més d'un filtre:
```js
db.productos.find({"name": "1", "price": 1});
```

### Arrays
Que compleixi les dues:
```js
db.productos.find({"categories": ["macbook", "notebook"]});
```

Que tingui una:
```js
db.productos.find({"categories": "watch"});
```

#### Afegir element - `$push`
Per afegir un element utilitzem el .push() com a JS. Amb la diferència que aquí hem de fer un UPDATE:
```js
db.products.updateOne(
	{ "name": "MacBook"},
	{ $push: { "categories": "power"}}
)
```

#### Eliminar element - `$pop`
```js
db.products.updateOne(
	{ "name": "MacBook"},
	{ $pop: { "categories": 1}}
)
```


### Regex
Ho puc fer de dues maneres:
+ **$regex**
```js
db.productos.find({"name":{$regex:"iPhone 7"}})
db.productos.find({"name":{$regex:"iPhone X",$options:"$i"}})
```
+ **/ /**
```js
db.productos.find({name : /iPhone 7/})
db.productos.find({name : /iPhone 7/i}) //i per ser incasensitive
```


## FIND -> MOSTRAR
Puc a més decidir quins camps mostrar en el segon paràmetre de .find(). Si no poso res em mostrarà tots.
```js
db.productos.find({"price": 2399}, {"name" : 1}); //mostro només name --  0-> no mostrar, 1-> mostrar
```

No mostrar:    
```js
//Ocultar las propiedad stock y picture del resultado
db.productos.find({"categories" : "iphone"}, {"stock": 0, "picture": 0});
```


### Operadors
+ > -> db.productos.find({"price": {$gt : 2000}});
+ >= -> db.productos.find({"price": {$gte : 2000}});
+ < -> db.productos.find({"price": {$lt : 500}});
+ <= -> db.productos.find({"price": {$lte : 500}});

+ BETWEEN  AND -> db.productos.find({"price": {$lte : 1000, $gte: 500}}); //[500-1000]

+ IN -> db.productos.find( { "price": { $in: [399, 699, 1299]}});


+ AND -> db.productos.find({$and: [{"stock": 200}, {"categories": "iphone"}]});
+ OR -> db.productos.find({$or: [{"stock": 329}, {"categories": "tv"}]});


## UPDATE

### UPDATE ONE
Per actualitzar un document (fila).
```js
db.productos.updateOne(
	{ "name": "Mac mini"},
	{ $set: { "stock": 50}}
)
```
### UPDATE MANY
Per actualitzar diversos documents (files).
```js
db.productos.updateMany(
    {"price": {$gt : 2000}},
    {$push: {"categories": "expensive"}}
)
```

## DELETE
```js
db.productos.deleteOne({"_id": ObjectId("6825034c332cbfec6b167173")});
```
```js
db.productos.deleteMany({"categories": "tv"});
```

## SORT

+ Si el criterio utilizado para una propiedad es **1** ordena de forma ascendente
+ Si el criterio utilizado para una propiedad es **-1** ordena de forma descendente

Ordenar números:  
```js
db.productos.find({}, {name:1, _id: 0}).sort({name: 1})
```

Ordenar strings:  
Com passa a JS, per ordenar strings hem d'utilitzar una altra manera:
```js
db.products.find({}, {name:1, _id: 0}).collation({ locale: 'en_US', strength: 1 }).sort({name: 1})
```


## LIMIT
´´´js
db.products.find({}, {name: 1, _id: 0}).limit(2);
´´´

## SKIP
```js
db.products.find().skip(2).limit(2).pretty();
```
