CREATE DATABASE bd_teoria_productos ;
USE bd_teoria_productos ; 

CREATE TABLE fabricante (
    código int AUTO_INCREMENT PRIMARY KEY,
    nombre varchar(100)
);

INSERT INTO fabricante values(1, 'El hijo de Ep');
INSERT INTO fabricante values(2, 'Tecnología Lógica');
INSERT INTO fabricante values(3, 'Pecado Capital');
INSERT INTO fabricante values(4, 'Rey Casi Piedra');
INSERT INTO fabricante values(5, 'Puerta Al Mar');


CREATE TABLE producto (
    id int AUTO_INCREMENT PRIMARY KEY,
    nombre varchar(50),
    tipo varchar(25),
    precio decimal(16,2),
    código_fabricante int, 
    FOREIGN KEY (código_fabricante) REFERENCES fabricante(código)
);

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB','almacenamiento',86 , 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB','almacenamiento',120, 4);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB'      ,'almacenamiento',150, 5);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti'  ,'gráficos'      ,185, 3);
INSERT INTO producto VALUES(5, 'Ati 7000Ti'  ,'gráficos'              ,170, 5);
INSERT INTO producto VALUES(6, 'Guantes Covid-19'  ,'higiene'              ,1 , null);

SELECT * FROM fabricante;
SELECT * FROM producto;