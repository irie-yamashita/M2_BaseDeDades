# Apuntes Mongo DB


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
