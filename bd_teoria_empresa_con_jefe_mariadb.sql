DROP DATABASE IF EXISTS bd_teoria_empresa_con_jefe;
CREATE DATABASE bd_teoria_empresa_con_jefe;

USE bd_teoria_empresa_con_jefe ;

CREATE TABLE departamento(
    id int PRIMARY KEY,
    nombre varchar(50),
    presupuesto decimal(16,2)
);

CREATE TABLE empleado (
    codigo int PRIMARY KEY,
    nombre varchar(50),
    id_departamento int,
    codigo_jefe int,
    CONSTRAINT fk_empleado_dpto FOREIGN KEY (id_departamento) REFERENCES departamento(id),
    CONSTRAINT fk_empleado_jefe FOREIGN KEY (codigo_jefe) REFERENCES empleado(codigo)
);

INSERT INTO departamento(id,nombre,presupuesto)
    VALUES(1,'Desarrollo',120000);
INSERT INTO departamento(id,nombre,presupuesto)
    VALUES(2,'Sistemas',150000);
INSERT INTO departamento(id,nombre,presupuesto)
    VALUES(3,'Recursos Humanos',280000);


INSERT INTO empleado(codigo,nombre,id_departamento, codigo_jefe)  VALUES
    (1,'Pepe', 1, 1), 
    (2,'Maria', 2, 2), 
    (3,'Juan', 3, 3),
    (4, 'Juanjo', 2, 2),
    (5, 'Pedro', 3, 3),
    (6, 'Ainhoa', 1, 1),
    (7, 'Gemma', 2, 2);

