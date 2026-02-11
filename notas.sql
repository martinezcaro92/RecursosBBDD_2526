/* Crea una base de datos llamada padronDB si no existe*/
CREATE DATABASE IF NOT EXISTS padronDB;

/* Muestra las bases de datos existentes*/
SHOW DATABASES;

/*A partir de las bbdd existentes, selecciona padronDB*/
USE padronDB;

/*Crear una tabla llamada "ciudadanos" con 5 campos y restricciones a los campos/atributos/columnas 
    De esta forma falla al introducirlo en el SGBD MySQL*/
CREATE TABLE IF NOT EXISTS ciudadanos (
    DNI_ciudadano VARCHAR(9) PRIMARY KEY,
    nombre_ciudadano VARCHAR(100) NOT NULL,
    apellidos_ciudadano VARCHAR(150) NOT NULL,
    telefono_ciudadano INTEGER CHECK (telefono_ciudadano LIKE '9________' OR telefono_ciudadano LIKE '6________' OR telefono_ciudadano LIKE '7________'),
    id_municipio INTEGER FOREIGN KEY REFERENCES municipios(id_municipio)
);

/* Modificación del FK en las tablas anteriores */
CREATE TABLE IF NOT EXISTS ciudadanos (
    DNI_ciudadano VARCHAR(9) PRIMARY KEY,
    nombre_ciudadano VARCHAR(100) NOT NULL,
    apellidos_ciudadano VARCHAR(150) NOT NULL,
    telefono_ciudadano INTEGER CHECK (telefono_ciudadano LIKE '9________' OR telefono_ciudadano LIKE '6________' OR telefono_ciudadano LIKE '7________'),
    id_municipio INTEGER NOT NULL,

    FOREIGN KEY (id_municipio) REFERENCES municipios(id_municipio)
);

/* Al introducir los comandos anteriores (CREATE TABLE para ciudadanos), nos da error porque utilizamos una 
    FK de una tabla que no existe previamente. Por lo tanto, tenemos que comenzar creando las tablas que menos
    dependencias tienen. */

/* Crear tabla llamada "comarcas" con 3 campos y restricciones a los campos/atributos/columnas */
CREATE TABLE IF NOT EXISTS comarcas (
    id_comarca INTEGER PRIMARY KEY,
    nombre_comarca VARCHAR(100) NOT NULL,
    extension_comarca DECIMAL(10,2) NOT NULL
);

/* Crear tabla llamada "municipios" con 3 campos y restricciones a los campos/atributos/columnas 
    De esta forma falla al introducirlo en el SGBD MySQL*/
CREATE TABLE IF NOT EXISTS municipios (
    id_municipio INTEGER PRIMARY KEY,
    nombre_municipio VARCHAR(100) NOT NULL,
    habitantes_municipio INTEGER NOT NULL,
    id_comarca INTEGER FOREIGN KEY REFERENCES comarcas(id_comarca)
);

/* Modificación del FK en las tablas anteriores */
CREATE TABLE IF NOT EXISTS municipios (
    id_municipio INTEGER PRIMARY KEY,
    nombre_municipio VARCHAR(100) NOT NULL,
    habitantes_municipio INTEGER NOT NULL,
    id_comarca INTEGER NOT NULL,

    /*De este modo ponemos la restricción a la tabla, no a dato/columna/atributo*/
    FOREIGN KEY (id_comarca) REFERENCES comarcas(id_comarca)
);

/* Mostrar las tablas creadas en padronDB */
SHOW TABLES;

/* Mostrar la estructura de la tabla ciudadanos */
DESCRIBE ciudadanos;

/* Modificar la tabla ciudadano para que nombre_ciudadano tenga un tamaño máximo de 100 caracteres */ 
ALTER TABLE ciudadanos
MODIFY nombre_ciudadano VARCHAR(150) NOT NULL;

INSERT INTO Persons (ID, LastName, FirstName, Age)  
    VALUES (1, 'Re', 'Miguel', 17);


/* Se incluyen los INSERT INTO para los datos de padronDB*/

/* Se empieza insertando los datos de la tabla comarcas*/
INSERT INTO comarcas (id_comarca, nombre_comarca, extension_comarca) 
    VALUES (1, 'Valle del Guadalentín', 10000),
           (2, 'Huerta de Murcia', 25000),
           (3, 'Campo de Cartagena', 20000),
           (4, 'Altiplano', 5000);

/* Se muestran los datos de la tabla comarcas*/
SELECT * FROM comarcas;

/* Se incluyen los INSERT INTO para los datos de municipios*/
INSERT INTO municipios (id_municipio, nombre_municipio, habitantes_municipio, id_comarca) 
    VALUES  (1, "Lorca", 100000, 1),
            (2, "Murcia", 400000, 2),
            (3, "Cartagena", 250000, 3),
            (4, "Totana", 30000, 1),
            (5, "Yecla", 35000, 4),
            (6, "San Javier", 25000, 3),
            (7, "Molina de Segura", 45000, 2);

/* Se muestran los datos de la tabla municipios*/
SELECT * FROM municipios;

/* Se incluyen los INSERT INTO para los datos de ciudadanos*/
INSERT INTO ciudadanos (DNI_ciudadano, nombre_ciudadano, apellidos_ciudadano, telefono_ciudadano, id_municipio) 
    VALUES  ('11111111A', 'Adolfo', 'Martín', 666666666, 1),
            ('22222222B', 'Miguelito', 'Re', 677777777, 2),
            ('33333333C', 'Nerea', 'Sánchez', 688888888, 3),
            ('44444444D', 'Josué', 'Mollo', 699999999, 4),
            ('55555555E', 'Álvaro', 'Sánchez', 600000000, 5),
            ('66666666F', 'Francisco', 'Guerrero', 611111111, 6),
            ('77777777G', 'José', 'Peñarrieta', 622222222, 1);

/* Se muestran los datos de la tabla ciudadanos*/
SELECT * FROM ciudadanos;

/*Mostrar las columnas DNI_ciudadano, nombre_ciudadano y telefono_ciudadano*/
SELECT DNI_ciudadano, nombre_ciudadano, telefono_ciudadano FROM ciudadanos;

SELECT  DNI_ciudadano AS 'DNI', 
        nombre_ciudadano AS 'nombre', 
        telefono_ciudadano AS 'telefono'
FROM ciudadanos;


/*AHORA VAMOS A PROCEDER CON LA BD clientesDB*/
/* Crea una base de datos llamada clientesDB si no existe*/
CREATE DATABASE IF NOT EXISTS clientesDB;

/* Muestra las bases de datos existentes*/
SHOW DATABASES;

/*A partir de las bbdd existentes, selecciona clientesDB*/
USE clientesDB;

/* Crear las tablas existentes en esta base de datos */
CREATE TABLE CustomersDaw (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Address VARCHAR(150),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    Country VARCHAR(50)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Address VARCHAR(150),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    Country VARCHAR(50)
);

/* Insertar datos en la tabla CustomersDaw */
INSERT INTO CustomersDaw (CustomerID, CustomerName, ContactName, Address, City, PostalCode, Country)
VALUES
(1, 'Alfreds Futterkiste', 'Maria Anders', 'Obere Str. 57', 'Berlin', '12209', 'Germany'),
(2, 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Avda. de la Constitución 2222', 'México D.F.', '05021', 'Mexico'),
(3, 'Antonio Moreno Taquería', 'Antonio Moreno', 'Mataderos 2312', 'México D.F.', '05023', 'Mexico'),
(4, 'Around the Horn', 'Thomas Hardy', '120 Hanover Sq.', 'London', 'WA1 1DP', 'UK'),
(5, 'Berglunds snabbköp', 'Christina Berglund', 'Berguvsvägen 8', 'Luleå', 'S-958 22', 'Sweden');

/* El INSERT INTO anterior es equivalente al siguiente INSERT INTO*/ 

INSERT INTO CustomersDaw
VALUES
(1, 'Alfreds Futterkiste', 'Maria Anders', 'Obere Str. 57', 'Berlin', '12209', 'Germany'),
(2, 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Avda. de la Constitución 2222', 'México D.F.', '05021', 'Mexico'),
(3, 'Antonio Moreno Taquería', 'Antonio Moreno', 'Mataderos 2312', 'México D.F.', '05023', 'Mexico'),
(4, 'Around the Horn', 'Thomas Hardy', '120 Hanover Sq.', 'London', 'WA1 1DP', 'UK'),
(5, 'Berglunds snabbköp', 'Christina Berglund', 'Berguvsvägen 8', 'Luleå', 'S-958 22', 'Sweden');

/* Insertar datos en la tabla Customers */
INSERT INTO Customers (CustomerID, CustomerName, ContactName, Address, City, PostalCode, Country)
VALUES
(1, 'Alfreds Futterkiste', 'Maria Anders', 'Obere Str. 57', 'Berlin', '12209', 'Germany'),
(2, 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Avda. de la Constitución 2222', 'México D.F.', '05021', 'Mexico'),
(3, 'Antonio Moreno Taquería', 'Antonio Moreno', 'Mataderos 2312', 'México D.F.', '05023', 'Mexico'),
(4, 'Around the Horn', 'Thomas Hardy', '120 Hanover Sq.', 'London', 'WA1 1DP', 'UK'),
(5, 'Berglunds snabbköp', 'Christina Berglund', 'Berguvsvägen 8', 'Luleå', 'S-958 22', 'Sweden'),
(6, 'Blauer See Delikatessen', 'Hanna Moos', 'Forsterstr. 57', 'Mannheim', '68306', 'Germany'),
(7, 'Blondel père et fils', 'Frédérique Citeaux', '24, place Kléber', 'Strasbourg', '67000', 'France'),
(8, 'Bólido Comidas preparadas', 'Martín Sommer', 'C/ Araquil, 67', 'Madrid', '28023', 'Spain'),
(9, 'Bon app’', 'Laurence Lebihans', '12, rue des Bouchers', 'Marseille', '13008', 'France'),
(10, 'Bottom-Dollar Marketse', 'Elizabeth Lincoln', '23 Tsawassen Blvd.', 'Tsawassen', 'T2F 8M4', 'Canada'),
(11, 'B''s Beverages', 'Victoria Ashworth', 'Fauntleroy Circus', 'London', 'EC2 5NT', 'UK'),
(12, 'Cactus Comidas para llevar', 'Patricio Simpson', 'Cerrito 333', 'Buenos Aires', '1010', 'Argentina'),
(13, 'Centro comercial Moctezuma', 'Francisco Chang', 'Sierras de Granada 9993', 'México D.F.', '05022', 'Mexico'),
(14, 'Chop-suey Chinese', 'Yang Wang', 'Hauptstr. 29', 'Bern', '3012', 'Switzerland'),
(15, 'Comércio Mineiro', 'Pedro Afonso', 'Av. dos Lusíadas, 23', 'São Paulo', '05432-043', 'Brazil'),
(16, 'Consolidated Holdings', 'Elizabeth Brown', 'Berkeley Gardens 12 Brewery', 'London', 'WX1 6LT', 'UK'),
(17, 'Drachenblut Delikatessend', 'Sven Ottlieb', 'Walserweg 21', 'Aachen', '52066', 'Germany'),
(18, 'Du monde entier', 'Janine Labrune', '67, rue des Cinquante Otages', 'Nantes', '44000', 'France'),
(19, 'Eastern Connection', 'Ann Devon', '35 King George', 'London', 'WX3 6FW', 'UK'),
(20, 'Ernst Handel', 'Roland Mendel', 'Kirchgasse 6', 'Graz', '8010', 'Austria');


/*Mostrar los datos en la tabla CustomersDaw*/
SELECT * FROM CustomersDaw;

/*Mostrar los datos en la tabla Customers*/
SELECT * FROM Customers;

/*Devolver una tabla que solo devuelva el Nombre del cliente y la ciudad de la tabla CustomersDaw*/
SELECT CustomerName, City FROM CustomersDaw;

/*Mostrar las ciudades diferentes que hay en la tabla Customers*/
SELECT DISTINCT City FROM Customers;

/* Mostrar los países diferentes que hay en la tabla CustomersDaw */
SELECT DISTINCT Country FROM CustomersDaw;

/*Mostrar cuántas ciudades diferentes hay en la tabla Customers*/ 
SELECT COUNT(DISTINCT City) FROM Customers;

/* Mostrar cuántos países diferentes hay en la tabla CustomersDaw */
SELECT COUNT(DISTINCT Country) FROM CustomersDaw;

/*Mostrar todos los datos de los clientes que viven en la ciudad de Londres en la tabla Customers*/
SELECT * 
    FROM Customers
    WHERE City = 'London';

/*Mostrar todos los datos de los clientes que viven en Germany en la tabla CustomersDaw */
SELECT * 
    FROM CustomersDaw
    WHERE Country = 'Germany';

/* Mostrar los clientes cuyo código postal sea mayor que 05022 en la tabla Customers */
SELECT * 
    FROM Customers
    WHERE PostalCode > '05022';