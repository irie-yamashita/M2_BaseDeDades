# Apuntes Mongo DB
!!! Vigila amb el nom de la db i de la taula/collection.

- [Crear](#CREAR)
- [Inserció](#INSERT)
- Consultes
  - [SELECT *](#select-)
  - FIND (Filtració)
    - [Literal](#literal)
    - [Arrays](#arrays)
    - [$in](#in)
    - [$push (Afegir element)](#afegir-element---push)
    - [$pop (Eliminar element)](#eliminar-element---pop)
    - [Expressions regulars (`$regex`, `/ /`)](#regex)
- Projeccions
  - [Mostrar camps específics](#projeccions)
  - [Ocultar camps](#projeccions)
- Operadors
  - [Comparació (`>`, `>=`, `<`, `<=`)](#operadors)
  - [Rang (`BETWEEN AND`)](#operadors)
  - [Inclusió (`IN`, `NOT IN`)](#operadors)
  - [Lògics (`AND`, `OR`)](#operadors)
  - [Igualtat (`==`, `!=`)](#operadors)
  - [Mòdul (`PARELL`, `IMPAR`)](#operadors)
- Actualització
  - [UPDATE ONE](#update-one)
  - [UPDATE MANY](#update-many)
- Eliminació
  - [DELETE ONE](#delete)
  - [DELETE MANY](#delete)
- Ordenació
  - [SORT (ascendent i descendent)](#sort)
  - [Ordenar cadenes amb `collation`](#sort)
- Limitació i paginació
  - [LIMIT](#limit)
  - [SKIP](#skip)

- [Cursors](#CURSORS)

## INTRODUCCIÓ

### CREAR
+ Crear database:
```js
use nomDataBase
```
> Comprovació: `show dbs`  
> [!WARNING]
> Per poder crear una database has d'estar dintre de mongo (`mongo`).

+ Crear collection:
```js
db.createCollection('productos');
```
> Comprovació: `show collections`  
> [!WARNING]
> Per poder crear una col·lecció has d'estar dintre d'una db (`use ____`).

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

Que tingui alguna:
```js
db.productos.find({ precio: { $in: [10, 20, 30] } })
```

Not in:  
```js
db.students.find({"birth_year": {$nin: [1970, 1980, 1990]}});
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
Elimina **l'últim element** d'una array.
```js
db.products.updateOne(
	{ "name": "MacBook"},
	{ $pop: { "categories": 1}}
)
```

> Si vols que sigui el primer element: -1
```js
db.productos.updateOne(
    {"name": "iPhone SE"},
    {$pop: {"categories": -1}}
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

![TIP] Per posar que **NO** compleixi:  
```js
db.movieDetails.find({"plot": {$not: /Bilbo/i}}).count();
```

## PROJECCIONS
Puc a més decidir quins camps mostrar en el segon paràmetre de .find(). Si no poso res em mostrarà tots.
```js
db.productos.find({"price": 2399}, {"name" : 1}); //mostro només name --  0-> no mostrar, 1-> mostrar
```

No mostrar:    
```js
//Ocultar las propiedad stock y picture del resultado
db.productos.find({"categories" : "iphone"}, {"stock": 0, "picture": 0});
```

### WHERE - length
```js
db.students.find({$where: 'this.firstname.length > 13'})
```

### Operadors
+ > -> db.productos.find({"price": {$gt : 2000}});
+ >= -> db.productos.find({"price": {$gte : 2000}});
+ < -> db.productos.find({"price": {$lt : 500}});
+ <= -> db.productos.find({"price": {$lte : 500}});

+ BETWEEN  AND -> db.productos.find({"price": {$lte : 1000, $gte: 500}}); //[500-1000]

+ IN -> db.productos.find( { "price": { $in: [399, 699, 1299]}});
+ NOT IN --> db.students.find({"birth_year": {$nin: [1970, 1980, 1990]}});


+ AND -> db.productos.find({$and: [{"stock": 200}, {"categories": "iphone"}]});
+ OR -> db.productos.find({$or: [{"stock": 329}, {"categories": "tv"}]});

+ == --> db.students.find({"birth_year": {$eq: 1990}});
+ != --> $ne:

+ PARELL --> db.students.find({"birth_year": {$mod: [2, 0]}});
+ IMPAR --> db.students.find({"birth_year": {$mod: [2, 1]}});


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
```js
db.products.find({}, {name: 1, _id: 0}).limit(2);
```

## SKIP

```js
db.products.find().skip(2).limit(2).pretty();
```


## DROP

+ Eliminar collection
```js
db.people.drop();
```

+ Eliminar db
```js
db.dropDatabase()
```
> Has d'estar en la base de dades que vols eliminar (use ____)


## CURSORS
```js
//Buscar todos los documentos de la colección productos utilizando un cursor
var cursor = db.productos.find();
cursor.next();
cursor.next();
cursor.next();


//Iterar sobre los documento utilizando hasNext y next para cada documento /*!!!!*/
while ( cursor.hasNext() ) {
    printjson( cursor.next() );
} 
```
