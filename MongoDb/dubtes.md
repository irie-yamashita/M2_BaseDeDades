+ db.productos.find().collation({locale: 'es', strength: 1 }).sort({"name":-1});


+ Ordre ASC i DESC

+ Dècades (gt o gte): //8. Busqueu els estudiants nascuts a la dècada dels 80 i de gènere femení
db.students.find({"gender": "M", "birth_year": {$gte: 1980, $lt: 1990}});


+ $where, $expr
