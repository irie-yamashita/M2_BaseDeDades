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

//Iterar sobre los documento utilizando hasNext y next para cada documento /*ERROR*/
var cursor = db.productos.find();
while (cursor.hasNext() == true) {
    cursor.next();
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
db.productos.find({name: /iPhone X/})


/*Ejercicio 06*/
// Importar el archivos de documentos products.json en la base de datos catalogo y utilizar la colección productos
exit
mongoimport --db catalogo --collection productos --drop --file C:\Users\Usuario\Desktop\MongoDb\arxius\products.json



//Al importar los datos se deben borrar todos los datos anteriores de la colección
mongo catalogo

//Buscar todos los documentos importados
db.productos.find();

//Mostrar los resultados de una forma más linda y fácil de ver
db.productos.find().pretty();

//Buscar los documentos que tienen la propiedad price con el valor de 329
db.productos.find({price: 329}).pretty()

//Buscar los documentos que tienen la propiedad stock con el valor de 100
db.productos.find({stock: 100}).pretty()

//Buscar los documentos que tienen la propiedad name con el valor de Apple Watch Nike+
db.productos.find({name: 'Apple Watch Nike+'}).pretty()



/*Ejercicio 07*/
