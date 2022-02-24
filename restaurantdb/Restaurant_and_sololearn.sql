#SHOW DATABASES #lists the databases managed by the server
#USE {database name} #to select the database
#SHOW TABLES #to display all of the tables in the currently selected MySQL database
#SHOW COLUMNS #displays info about the columns in a given table
#SHOW COLUMNS FROM customers #displays the coluns in customers table
	#field (e.g., name), type (varchar(39)), Null (No), Key(PK, FK), default (null), extra
#SELECT #select data from a database, result stored in a result table called result-set
	#select * from table_name
#siempre hay que terminar con ;

#Este script tiene comentarios en ingles y en español

#===Usando base de datos: restaurant===

#======= Practicando con programa de restaurante + usando sololearn ========

#==========================================================================================
#====================================BASIC CONCEPTS =======================================
#==========================================================================================
#Agregando mas reservaciones
SELECT * FROM reservaciones; #categoriasid es una clave foranea
INSERT INTO reservaciones (nombre, apellido, hora, fecha, cantidadmesa) 
	VALUES ('Raul', 'Gutierrez', '15:00:00', '2020-08-29', 6);
INSERT INTO reservaciones (nombre, apellido, hora, fecha, cantidadmesa) 
	VALUES ('Omar', 'Esparza', '11:45:00', '2020-03-01', 2);
INSERT INTO reservaciones (nombre, apellido, hora, fecha, cantidadmesa) 
    VALUES ('Joaquin', 'Hernandez', '12:00:00', '2020-02-20', 3);
INSERT INTO reservaciones (nombre, apellido, hora, fecha, cantidadmesa) 
    VALUES ('Alejandro', 'Hernan', '14:00:00', '2020-08-29', 4);
INSERT INTO reservaciones (nombre, apellido, hora, fecha, cantidadmesa) 
    VALUES ('Norma', 'Narvaez', '14:00:00', '2020-08-29', 3);
INSERT INTO reservaciones (nombre, apellido, hora, fecha, cantidadmesa) 
    VALUES ('Jose', 'Calderon', '10:15:00', '2020-08-29', 5);
INSERT INTO reservaciones (nombre, apellido, hora, fecha, cantidadmesa) 
    VALUES ('Jose', 'Madero', '15:00:00', '2020-02-09', 3);
INSERT INTO reservaciones (nombre, apellido, hora, fecha, cantidadmesa) 
    VALUES ('Jose', 'Rubelas', '09:00:00', '2020-02-21', 4);
INSERT INTO reservaciones (nombre, apellido, hora, fecha, cantidadmesa) 
    VALUES ('Jose', 'Jose', '14:45:00', '2020-03-05', 2);
INSERT INTO reservaciones (nombre, apellido, hora, fecha, cantidadmesa) 
    VALUES ('Glenda', 'Ramos', '24:00:00', '2022-06-18', 2);
INSERT INTO reservaciones (nombre, apellido, hora, fecha, cantidadmesa) 
    VALUES ('Jose', 'Fernandez', '11:30:00', '2021-10-19',7);

#Making an update to the database
UPDATE reservaciones SET nombre = 'Jose Ramon' WHERE id = 41; 

#Deleting id=4 from reservaciones
DELETE FROM reservaciones WHERE id = 40;

#Updating dates
UPDATE reservaciones SET fecha = '2020-10-12' WHERE id = 33; 
UPDATE reservaciones SET fecha = '2020-09-02' WHERE id = 34; 
UPDATE reservaciones SET fecha = '2020-11-23' WHERE id = 35; 
UPDATE reservaciones SET fecha = '2020-06-26' WHERE id = 36; 

#Selecting and ordering
SELECT * FROM reservaciones ORDER BY id DESC;

#===Using Limit and Offset===
SELECT id, nombre, apellido, hora, fecha, cantidadmesa
FROM reservaciones 
ORDER BY id
LIMIT 5;

#Using offset to show id after 30
SELECT id, nombre, apellido, hora, fecha, cantidadmesa
FROM reservaciones ORDER BY id 
LIMIT 5 OFFSET 30;

SELECT id, nombre, apellido, hora, fecha, cantidadmesa
FROM reservaciones ORDER BY id 
LIMIT 30, 5; #Using LIMIT 5 OFFSET 30 is equivalent to LIMIT 30, 5

#Looking for Jose in nombre
SELECT * FROM reservaciones
WHERE nombre
LIKE '%Jose%';

#Using between
SELECT * FROM reservaciones
WHERE nombre LIKE '%Jose%'
AND cantidadmesa BETWEEN 2 AND 7;

#Using DISTINCT 
SELECT DISTINCT fecha from reservaciones; #Distinct elimina todos los duplicados y muestra unicos
SELECT * from reservaciones;
#======

#===== Full qualified name ======
SELECT reservaciones.nombre FROM reservaciones; #full qualified name

SELECT * FROM reservaciones 
ORDER BY nombre;
#=================

#Using concat
SELECT CONCAT(nombre, ' ', apellido) 
AS 'Nombre Cliente', hora, fecha, cantidadMesa
FROM reservaciones 
WHERE CONCAT(nombre, ' ', apellido)
LIKE '%%'; #To show everything


#Using count
SELECT COUNT(id), nombre 
FROM reservaciones 
GROUP BY nombre 
ORDER BY COUNT(id) DESC; 

#Using inner joing
SELECT COUNT(platillos.id), categoria.nombre 
FROM platillos
INNER JOIN categoria 
ON platillos.categoriaId = categoria.id
GROUP BY categoria.nombre;

SELECT COUNT(platillos.id), categoria.nombre 
FROM platillos
INNER JOIN categoria 
ON platillos.categoriaId = categoria.id;
#GROUP BY categoria.nombre;
SELECT nombre, apellido FROM reservaciones
ORDER BY 1; 

SELECT nombre, apellido FROM reservaciones
ORDER BY 2; 

SELECT * FROM reservaciones
ORDER BY nombre, apellido; #Ordering from nombre, then by apellido

SHOW TABLES; #to show the tables names of the database

#==========================================================================================
#========================FILTERING, FUNCTIONS AND SUBQUERIES===============================
#==========================================================================================

#===The WHERE statement====
#WHERE sirve para poner alguna condicion; to extract only those records that fulfilll a specific criterion
SELECT * FROM restaurant.reservaciones WHERE nombre = 'Jose' AND cantidadmesa = 3; #si lo que se busca
#tiene una apostrofe, se tiene que usar doble comilla para escapar la apostrofe
SELECT id, nombre, cantidadmesa FROM restaurant.reservaciones WHERE  cantidadmesa = 3; 

#Se pueden usar Comparison Operators y Logical Operators
# = : igual, != o <> : no igual, > : mayor que, < : menor que, (tambien >=, <=),
# BETWEEN : rango inclusivo (e.g., 3 AND 7;). Buscar nulos: WHERE name IS NULL 

SELECT id, nombre, cantidadmesa FROM restaurant.reservaciones WHERE cantidadmesa BETWEEN 3 AND 4;

#====Filtering with AND, OR===
#Operadores logicos: AND, OR, IN, NOT
SELECT id, nombre, apellido, cantidadmesa FROM restaurant.reservaciones WHERE nombre = 'Jose' 
AND (cantidadmesa = 3 OR cantidadmesa = 5);


#===IN, NOT IN Statements===
#IN is used when you want to compare a column with more than one value

SELECT * FROM reservaciones WHERE cantidadmesa IN (3, 5, 7); #se puede usar OR o IN

SELECT * FROM reservaciones WHERE cantidadmesa NOT IN (3, 5, 7);


#===Custom Columns===
#CONCAT function is used to concatenate two or more text values and returns the concat string
#AS le agrega el nombre a la columna

SELECT CONCAT(nombre, ' ', apellido, ', ', cantidadmesa) AS 'Mesas por nombre' 
FROM reservaciones; 
#tambien se pueden usar dobles barras en vez de concat 

#Se pueden usar operaciones aritmeticas, por ejemplo si a cada mesa se le agregan dos invitados
SELECT nombre, apellido, cantidadmesa+2 AS cantidadmesa FROM reservaciones;
#esto no cambia los datos en la db
SELECT nombre, apellido, cantidadmesa FROM reservaciones; 


#=== Functions ===
#UPPER: todas en mayuscula
#LOWER: todas en minuscula
SELECT * FROM restaurant.platillos;
SELECT id, UPPER(nombre) AS NOMBRE, precio FROM platillos;

#SQRT gives the square root of an argumen
SELECT nombre, SQRT(precio) AS 'Raiz del precio' FROM platillos;

#AVG da el promedio de una columna numerica
SELECT AVG(precio) AS 'Precio promedio de los platillos' FROM restaurant.platillos; #cool

#SUM da la suma de la columna
SELECT SUM(cantidadmesa) AS 'Total de clientes' 
FROM restaurant.reservaciones;

SELECT SUM(precio) AS 'Precio de todos los platillos' 
FROM restaurant.platillos;


#===Subqueries===
#A query within another query
#Por ejemplo, el precio promedio de los platillos es $97.15, podemos buscar los precios mayores a ese

SELECT * FROM platillos;
SELECT nombre, precio FROM platillos
WHERE precio > 97.15
ORDER BY precio DESC;

SELECT nombre, precio FROM platillos 
WHERE precio > (SELECT AVG(precio) FROM platillos) #Esto es usar una subquery
ORDER BY precio DESC; 


#===LIKE and MIN===
#LIKE sirve para especificar una busqueda en una clausula de WHERE
#Se puede usar "_" para relacionar un solo caracter o "%" para relacionar un numero arbitrario de caracteres

#Para encontrar los platillos que comienzan con F
SELECT * FROM platillos 
WHERE nombre 
LIKE 'F%';

#Para encontrar que temrine con "o"
SELECT * FROM platillos 
WHERE nombre 
LIKE '%o';

#Para encontrar que contenga la palabra 'Jugo' en algun lugar
SELECT * FROM platillos 
WHERE nombre 
LIKE '%Jugo%';

#que no contenga la letra 'o' en algun lugar
SELECT * FROM platillos 
WHERE nombre 
NOT LIKE '%o%';

SELECT * FROM platillos 
WHERE nombre 
LIKE '%no';

#Que tengan la "a" en su primera palabra como segunda letra
SELECT * FROM platillos 
WHERE nombre 
LIKE '_a%';

#la fn MIN() es para regresar el valor minimo de una expresion usando select, MAX el mayor
#imagina que quieres saber cual es el platillo mas barato y cual el mas caro
SELECT MIN(precio) AS Minimo FROM platillos;
SELECT MAX(precio) AS Maximo FROM platillos;


#==========================================================================================
#================================JOIN, Table operations====================================
#==========================================================================================

#===Joining Tables===

SELECT * FROM reservaciones;
SELECT * FROM platillos;
SELECT * FROM categoria;

#Asi se pueden unir tablas usando los comandos que se tienen hasta ahorita
SELECT platillos.id, platillos.nombre, platillos.precio, platillos.disponible, categoria.nombre
FROM platillos, categoria
WHERE platillos.categoriaId = categoria.id
ORDER BY platillos.id;

#===Custom names===
#se pueden hacer los statements mas cortos al dar apodos a las tablas usando AS
SELECT pl.id, pl.nombre, pl.precio, pl.disponible, cat.nombre
FROM platillos AS pl, categoria AS cat
WHERE pl.categoriaId = cat.id
ORDER BY pl.id; 

#tambien se puede hacer sin usar al comando AS
SELECT pl.id, pl.nombre, pl.precio, pl.disponible, cat.nombre
FROM platillos pl, categoria cat
WHERE pl.categoriaId = cat.id
ORDER BY pl.id; 
#usualmente es mejor no hacer esto 

#Tipos de JOIN: INNER JOIN,  LEFT JOIN, RIGHT JOIN; inner join es equivalente a join
#se usa la keyword ON para especificar la inner join condition

SELECT platillos.id, platillos.nombre, platillos.precio, platillos.disponible, categoria.nombre
FROM platillos INNER JOIN categoria
ON platillos.categoriaId = categoria.id
ORDER BY platillos.id;

SELECT platillos.id, platillos.nombre, platillos.precio, platillos.disponible, categoria.nombre
FROM platillos JOIN categoria
ON platillos.categoriaId = categoria.id
ORDER BY platillos.id;

SELECT *
FROM platillos JOIN categoria
ON platillos.categoriaId = categoria.id
ORDER BY platillos.id; #se puede usar el * pero en este caso hay una redundancia en el id

#LEFT JOIN regresa todas las filas de la tablaz izq aunque no haya matches en la tabla derecha
#Vamos a agregar un platillo que no tiene categoria 

INSERT INTO platillos (nombre, precio, disponible, categoriaId) 
	VALUES ('Sal extra', '2', NULL , NULL); 
INSERT INTO platillos (nombre, precio, disponible, categoriaId) 
	VALUES ('Azucar extra', '5', NULL , NULL); 
INSERT INTO platillos (nombre, precio, disponible, categoriaId) 
	VALUES ('Queso extra', '10', NULL , NULL); 
SELECT * FROM platillos ORDER BY id DESC;

#ahora si vamos a usar LEFT JOIN, ya que tendremos categorias que no matchearan
SELECT platillos.id, platillos.nombre, platillos.precio, platillos.disponible, categoria.nombre
FROM platillos LEFT OUTER JOIN categoria
ON platillos.categoriaId = categoria.id
ORDER BY platillos.id DESC; 
#como no tiene categoriaId lo que agregue, regresa NULL, si uso solo JOIN, lo que agregue no aparece

SELECT platillos.id, platillos.nombre, platillos.precio, platillos.disponible, categoria.nombre
FROM platillos LEFT JOIN categoria #se puede omitir el outer
ON platillos.categoriaId = categoria.id
ORDER BY platillos.id DESC; 

#RIGHT JOIN regresa todas las filas de la derecha, aunque no haya matches (tambien se puede omitir OUTER)
SELECT platillos.id, platillos.nombre, platillos.precio, platillos.disponible, categoria.nombre
FROM categoria RIGHT JOIN platillos #aqui solo invertimos, que el completo sea el de la derecha 
ON platillos.categoriaId = categoria.id
ORDER BY platillos.id DESC; 
#dicen que hay ocaciones donde uno sirve mas que el otro y que no necesariamente basta con invertir
#y que ejemplos se pueden ver en teoria de conjuntos, pero hay que ver que onda


#===UNION===
#para combinar datos a traves d diferentes tablas de las mismas base de datos, diferentes bases de datos
#e incluso de diferentes servidores
#UNION combina multiles set de datos en un mismo set de datos, remueve los duplicados
#UNION ALL hace lo mismo pero no elimina los duplicados
#UNION ALL es mas rapida que UNION 

#JOIN para unir columnas (propiedades) de distintas tablas dada una llave
#UNION para unir filas (registros) de tablas con propiedades similares

SELECT * FROM platillos 
WHERE precio < 100
ORDER BY precio DESC;

#Vamos a crear una nueva tabla, reservaciones 2023 donde solo se aparte una mesa para el 2023 
SELECT * FROM reservaciones;



#===UPDATE and DELETE Statements===
#UPDATE, SET, WHERE es la sintaxis, si no se usa where, todas las tablas se actualizan
#UPDATE reservaciones2023 SET fecha = '2021-11-15'; #esto funcionaria si no se tuviera el modo safe update 
CREATE TABLE reservaciones2023 (
id INT(11) NOT NULL AUTO_INCREMENT,
nombre VARCHAR(60) NOT NULL,
apellido VARCHAR(60) NOT NULL,
fecha date DEFAULT NULL,
cantidadmesa int(11) DEFAULT NULL,
PRIMARY KEY(id)
);

#DROP TABLE reservaciones2023; la borre porque la cambiare
INSERT INTO reservaciones2023 (nombre, apellido, cantidadmesa) 
	VALUES ('Joel', 'Urquidez', 2); 
INSERT INTO reservaciones2023 (nombre, apellido, cantidadmesa) 
	VALUES ('Jaziel', 'Lorona', 4); 
INSERT INTO reservaciones2023 (nombre, apellido, cantidadmesa) 
	VALUES ('Bernardo', 'Huiqui', 4); 
INSERT INTO reservaciones2023 (nombre, apellido, cantidadmesa) 
	VALUES ('Ramon', 'Rodroguez', 6);
    
SELECT * FROM reservaciones2023;

#si no tienen el mismo numero de columnas, se puede agregar un NULL, ademas de que podemos poner
#una columna extra para diferenciar entre tablas si es necesario
SELECT id, nombre, apellido, hora, fecha, cantidadmesa, 'Definidos' AS Estado FROM restaurant.reservaciones
UNION
SELECT id, nombre, apellido, NULL, fecha, cantidadmesa, 'Nuevos' AS Estado FROM restaurant.reservaciones2023;
#como en este caso no hay duplicados, usamos el UNION, aunque UNION ALL daria lo mismo

#===Creating a Table===
#varchar es para caracteres, int para enteros
#Numeric:
#FLOAT(M,D): M is length and D is number of decials
#DOUBLE(M,D): For double presicion
#Date and time
#DATE: YYYY-MM-DD, DATETIME: YYYY-MM-DD HH:MM:SS
#TIMESTAMP: calculado a la medianoche, Enero 1, 1970
#TIME: HH:MM:SS
#String type
#CHAR(M): Fixed lenght. Size is specified in parenthesismax is 255 bytes
#VARCHAR(M): Variable lenght. Max size in parenthesis
#BLOB: Binary large objects: binary data, images or other files
#TEXT: large amount of text data

#UserID is the best choice for the user's table primary key
#PRIMARY KEY() keyword

CREATE TABLE reservaciones2024 (
id INT(11) NOT NULL AUTO_INCREMENT,
nombre VARCHAR(60) NOT NULL,
apellido VARCHAR(60) NOT NULL,
fecha DATE DEFAULT NULL,
cantidadmesa INT(11) DEFAULT NULL,
PRIMARY KEY(id)
);

#===NOT NULL and AUTO_INCREMENT===
#SQL tiene constraints para las tablas
#NOT NULL: no puede ser nulo, UNIQUE: no se puede repetir el valor en la columna, mantiene la unicidad de una col
#PRIMARY KEY, CHECK: determina si el valor es valido o no por una expresion logica
#DEFAULT: si no se da un valor, la columna se tiene como default
#AUTO_INCREMENT

CREATE TABLE reservaciones2024 (
id INT(11) NOT NULL AUTO_INCREMENT,
nombre VARCHAR(60) NOT NULL,
apellido VARCHAR(60) NOT NULL,
fecha DATE DEFAULT NULL,
cantidadmesa INT(11) DEFAULT NULL,
PRIMARY KEY(id)
);


#===Alter, Drop, Rename a Table===
#ALTER TABLE se usa para anadir, borrar o modificar columnas
#tambien para quitar o agregar constraints de una tabla existente


SELECT * FROM reservaciones2023;
#ADD se usa para agregar
ALTER TABLE reservaciones2023 ADD detalle varchar(60); 

#DROP COLUMN se usa para quitar
ALTER TABLE reservaciones2023 DROP COLUMN detalle; 

#DROP TABLE es para quitar una tabla
DROP TABLE reservaciones2024; #DELETE TABLE borra la info de la tabla, mantiene intacta la estructura 

#===The INSERT Statement===
#son comandos que ya he estado utilizando, pero Sololearn los explica

SELECT * FROM reservaciones ORDER BY id DESC;

INSERT INTO reservaciones
VALUES (43, 'Jose Raul', 'Higuera', '14:15:00', '2021-08-11',3); #se puede agregar asi 

#se tiene que poner algo en las columnas que no tengan default o que no soporten null
#pero puede saltarte espacios del autoincrement
INSERT INTO reservaciones
VALUES (46, 'Omar', 'Ortega', '14:00:00', '2021-02-12', 4); 

INSERT INTO reservaciones2023 (nombre, apellido)
VALUES ('Oziel', 'Landeros'); #tambien se pueden agregar valores solo en columnas especificas

INSERT INTO reservaciones2023 (nombre, apellido, cantidadmesa)
VALUES ('Juan', 'Hernandez', 5),('Pablo', 'Roma', 2),('Iris', 'Morales', 4); #se pueden agregar multiples


SELECT * FROM reservaciones2023;

UPDATE reservaciones2023 SET fecha = '2021-11-15' WHERE id = 3;

#es recomendable usar los updates, insert o delets con start transaction
START TRANSACTION; 
UPDATE reservaciones2023 SET fecha = '2021-11-15' WHERE id = 4;
ROLLBACK; #si el cambio no es correcto se usa rollback
COMMIT; #si el cambio es correcto se usa commit

#se pueden actualizar multiples columnas
UPDATE reservaciones2023 SET nombre = 'Jaziel Roberto', fecha = '2021-08-28' WHERE id = 2;
SELECT * FROM reservaciones2023;

DELETE FROM reservaciones2023 WHERE id = 7; #borramos a pablo


#CHANGE para renombrar columnas
ALTER TABLE reservaciones2023 ADD detalle varchar(60); 
ALTER TABLE reservaciones2023 CHANGE detalle detalles varchar(60);

#RENAME TABLE para cambiar el nombre de la tabla
RENAME TABLE reservaciones2023 TO nuevasreservaciones;
SELECT * FROM nuevasreservaciones;
RENAME TABLE nuevasreservaciones TO reservaciones2023;
SELECT * FROM reservaciones2023;


#===Views===
#A VIEW is a  virtual table that is based on the result-set of an SQL statement
#Contains rows and columns
#Permite estructurar datos para que los usuarios lo encuentres mas natural o inuitivo
#Restringe el acceso a los datos en los que un usuario puede modificar solo lo necesario y no mas
#Resume los daos de varias tablas
SELECT * FROM categoria;

#El view es un select, el cual puede ser tan complejo como se quiera y puede ser llamado despues
CREATE VIEW comidas AS
SELECT platillos.id, platillos.nombre AS 'Nombre Comida', platillos.precio, platillos.categoriaId
FROM platillos JOIN categoria
ON platillos.categoriaId = categoria.id
WHERE platillos.categoriaId = 2
ORDER BY platillos.id;

#aqui llamamos el view creado
SELECT * FROM comidas;

#Se puede actualizar el view con create or replace view
CREATE OR REPLACE VIEW comidas AS
SELECT platillos.id, platillos.nombre AS 'Nombre Comida', platillos.precio
FROM platillos JOIN categoria
ON platillos.categoriaId = categoria.id
WHERE platillos.categoriaId = 2
ORDER BY platillos.id;

SELECT * FROM comidas;
#
CREATE OR REPLACE VIEW bebidas AS
SELECT platillos.id, platillos.nombre AS 'Nombre bebidas', platillos.precio, categoria.nombre
FROM platillos JOIN categoria
ON platillos.categoriaId = categoria.id
WHERE (platillos.categoriaId = 3 OR platillos.categoriaId = 4)
ORDER BY platillos.id;

SELECT * FROM categoria;
SELECT * FROM bebidas;

#=========
#se puede usar where para buscar 'jose', pero si queires que tenga jose y algo mas, usar like
SELECT * FROM reservaciones
WHERE nombre LIKE '%Jose%' OR nombre LIKE 'Raul'; 

SELECT * FROM restaurant.reservaciones;