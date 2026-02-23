DROP DATABASE IF EXISTS bd_teoria_empresa;
CREATE DATABASE bd_teoria_empresa;

USE bd_teoria_empresa ;

CREATE TABLE departamento(
    id int PRIMARY KEY,
    nombre varchar(50),
    presupuesto decimal(16,2)
);

CREATE TABLE empleado (
    codigo int PRIMARY KEY,
    nombre varchar(50),
    id_departamento int,
    CONSTRAINT fk_empleado_dpto FOREIGN KEY (id_departamento) REFERENCES departamento(id) 
);

INSERT INTO departamento(id,nombre,presupuesto)
    VALUES(1,'Desarrollo',120000);
INSERT INTO departamento(id,nombre,presupuesto)
    VALUES(2,'Sistemas',150000);
INSERT INTO departamento(id,nombre,presupuesto)
    VALUES(3,'Recursos Humanos',280000);


INSERT INTO empleado(codigo,nombre,id_departamento)
    VALUES(1,'Pepe', 1);
INSERT INTO empleado(codigo,nombre,id_departamento)
    VALUES(2,'Maria', 2);
INSERT INTO empleado(codigo,nombre,id_departamento)
    VALUES(3,'Juan', null);

