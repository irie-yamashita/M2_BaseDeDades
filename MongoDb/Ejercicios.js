//https://github.com/nisnardi/comunidad-it-js/blob/master/contenido/mongodb.md

/*Ejercicio: 01*/

// Conectarse al cliente de MongoDB
mongo

// Crear una base de datos con el nombre catalogo
use catalogo

// Crear la colección productos
db.createCollection("productos")

// Crear los siguientes documentos de a uno
db.productos.insertOne({"name": "MacBook Pro"});
db.productos.insertOne({"name": "MacBook Air"});
db.productos.insertOne({"name": "MacBook"});


//Listar las bases de datos disponibles
show dbs

//Listar las colecciones disponibles para la base de datos catalogo
use catalogo
show collections

//Desconectar el cliente de MongoDB
exit

//Volver a levantar el cliente de MongoDB pero en esta oportunidad queremos que se conecte directamente a la base de catalogo sin pasar por la base de test
mongo catalogo




/*Ejercicio 02*/
//Levantar el cliente de MongoDB en la base de datos `catalogo`
mongo catalogo

//Buscar todos los documentos de la colección `productos`
db.productos.find()

//Buscar el documento que tiene la propiedad `name` con el valor `MacBook Air`
db.productos.find({ "name": "MacBook Air" })



/*Ejercicio 03*/
//Levantar el cliente de MongoDB en la base de datos catalogo
mongo catalogo

//Buscar todos los documentos de la colección productos utilizando un cursor
var cursor = db.productos.find();
cursor.next();
cursor.next();
cursor.next();


//Iterar sobre los documento utilizando hasNext y next para cada documento /*!!!!*/
while ( cursor.hasNext() ) {
    printjson( cursor.next() );
} 


/*Ejercicio 04*/

//Levantar el cliente de MongoDB en la base de datos catalogo
mongo catalogo

//Insertar los siguientes documentos en la colección productos utilizando un sólo comando de MongoDB
/*
{"name": "iPhone 8"}
{"name": "iPhone 6s"}
{"name": "iPhone X"}
{"name": "iPhone SE"}
{"name": "iPhone 7"}
*/

db.productos.insertMany([
{"name": "iPhone 8"},
{"name": "iPhone 6s"},
{"name": "iPhone X"},
{"name": "iPhone SE"},
{"name": "iPhone 7"}
])


//Listar todos los documentos de la colección productos
db.productos.find().pretty()

//Buscar el docuemnto que tiene la propiedad name con el valor iPhone 7
db.productos.find({name : /iPhone 7/}) //expressió regular

//Buscar el documento que tiene la propiedad name con el valor MacBook
db.productos.find({name : /MacBook/})




/*Ejercicio 05*/
//Levantar el cliente de MongoDB en la base de datos catalogo
mongo catalogo

//Borrar la colección productos
db.productos.drop()

/*show collections*/

//Borrar la base de datos catalogo
db.dropDatabase()

//Crear la base de datos catalogo y colección productos de nuevo
use catalogo

db.createCollection("productos")

//Insertar los siguientes documentos utilizando un sólo comando de MongoDB
/*
{"name": "iPhone 8"}
{"name": "MacBook Pro"}
{"name": "iPhone 6s"}
{"name": "MacBook Air"}
{"name": "iPhone X"}
{"name": "iPhone SE"}
{"name": "MacBook"})
{"name": "iPhone 7"}
*/

db.productos.insertMany([
{"name": "iPhone 8"},
{"name": "MacBook Pro"},
{"name": "iPhone 6s"},
{"name": "MacBook Air"},
{"name": "iPhone X"},
{"name": "iPhone SE"},
{"name": "MacBook"},
{"name": "iPhone 7"}
]);



//Buscar el producto que tiene la propiedad name con el valor iPhone X
db.productos.find({"name": /iPhone X/})
db.productos.find({"name":{$regex:"iPhone 7"}})


/*Ejercicio 06*/
// Importar el archivos de documentos products.json en la base de datos catalogo y utilizar la colección productos
exit
mongoimport --db catalogo --collection productos --drop --file C:\Users\Usuario\Desktop\MongoDb\arxius\products.json
//mongoimport --db catalogo --collection productos --drop --file C:\Users\argo\Desktop\IrieYamashita\MongoDB\arxius\products.json


//Al importar los datos se deben borrar todos los datos anteriores de la colección
mongo catalogo

//Buscar todos los documentos importados
db.productos.find();

//Mostrar los resultados de una forma más linda y fácil de ver
db.productos.find().pretty();

//Buscar los documentos que tienen la propiedad price con el valor de 329
db.productos.find({"price": 329}).pretty();

//Buscar los documentos que tienen la propiedad stock con el valor de 100
db.productos.find({"stock": 100}).pretty();

//Buscar los documentos que tienen la propiedad name con el valor de Apple Watch Nike+
db.productos.find({"name": 'Apple Watch Nike+'}).pretty();



/*Ejercicio 07*/

//Levantar el cliente de MongoDB en la base de datos catalogo
mongo catalogo

//Buscar los productos que tienen la propiedad name con el valor 1 y la propiedad price con el valor 1
db.productos.find({"name": "1", "price": 1});

//Buscar los productos que tienen las categorías macbook y notebook
db.productos.find({"categories": ["macbook", "notebook"]});

//Buscar los productos que tienen la categoría watch
db.productos.find({"categories": "watch"});




/*Ejercicio 08*/

//Levantar el cliente de MongoDB en la base de datos catalogo
mongo catalogo

//Buscar los productos que tienen la propiedad price con el valor 2399 y mostrar sólo la propiedad name en el resultado
db.productos.find({"price": 2399}, {"name" : 1});

//Buscar los productos que tienen la propiedad categories con el valor iphone y ocultar las propiedad stock y picture del resultado
db.productos.find({"categories" : "iphone"}, {"stock": 0, "picture": 0});

//Repetir todas las búsquedas anteriores y ocultar la propiedad _id en todas ellas
db.productos.find({"price": 2399}, {"name" : 1, "_id": 0 });
db.productos.find({"categories" : "iphone"}, {"stock": 0, "picture": 0, "_id": 0});



/*Ejercicio 09*/

//Levantar el cliente de MongoDB en la base de datos catalogo
mongo catalogo

//Buscar los productos que tienen la propiedad price mayor a 2000
db.productos.find({"price": {$gt : 2000}});

//Buscar los productos que tienen la propiedad price menor a 500
db.productos.find({"price": {$lt : 500}});

//Buscar los productos que tienen la propiedad price menor o igual que 500
db.productos.find({"price": {$lte : 500}});

//Buscar los productos que tienen la propiedad price en el rango de 500 a 1000
db.productos.find({"price": {$lte : 1000, $gte: 500}});

//Buscar los productos que tienen la propiedad price con alguno de los siguientes valores 399 o 699 o 1299 (hacer en un solo query)
db.productos.find( { "price": { $in: [399, 699, 1299]}});




/*Ejercicio 10*/

//Levantar el cliente de MongoDB en la base de datos catalogo
mongo catalogo

//Buscar los productos que tienen la propiedad stock con el valor 200 Y tienen la categoría iphone (utlizar el operador and)
db.productos.find({$and: [{"stock": 200}, {"categories": "iphone"}]});

//Buscar los productos que tienen la propiedad price con el valor 329 O tienen la categoría tv (utlizar el operador or)
db.productos.find({$or: [{"stock": 329}, {"categories": "tv"}]});



/*Ejercicio 11*/

//Levantar el cliente de MongoDB en la base de datos catalogo
mongo catalogo

//Actualizar el producto que tiene la propiedad name con el valor Mac mini y establecer la propiedad stock con el valor 50
 db.productos.find({"name" : "Mac mini"},  {"stock": 1}); // Estat inicial: 20

db.productos.updateOne(
	{ "name": "Mac mini"},
	{ $set: { "stock": 50}}
)

db.productos.find({"name" : "Mac mini"},  {"stock": 1}); // Estat inicial: 50


//Actualizar el producto que tiene la propiead name con el valor iPhone X y agregarle la propiedad prime con el valor true
db.productos.updateOne(
    {"name": "iPhone X"},
    {$set: {"prime" : true}}
);

db.productos.find({"name" : "iPhone X"}); //comrpovar

//Buscar los documentos actualizados y listarlos mostrando los datos de forma más linda y ocultando las propiedades stock, categories y _id
db.productos.find({"name": {$in: ["Mac mini", "iPhone X"]}}, {"stock": 0, "categories": 0, "_id": 0}).pretty();

