CREATE DATABASE IF NOT EXISTS academiaDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_spanish_ci;

USE academiaDB;

/* En primer lugar se genera la tabla profesor por que no tiene ninguna FK */
CREATE TABLE profesores (
    DNI_profesor        VARCHAR(9)  PRIMARY KEY,
    nombre_profesor     VARCHAR(50),
    apellido1_profesor  VARCHAR(50),
    apellido2_profesor  VARCHAR(50),
    direccion_profesor  VARCHAR(50),
    titulo              VARCHAR(50),
    gana                DECIMAL(6,2) NOT NULL,

    UNIQUE (nombre_profesor, apellido1_profesor, apellido2_profesor)
);

/*A continuación se procede con la tabla cursos porque coge la FK de profesores y dependerá alumnos de ella*/

CREATE TABLE cursos (
    cod_curso       INTEGER         PRIMARY KEY,
    nombre_curso    VARCHAR(50)     UNIQUE,
    maximo_alumnos  INTEGER,
    fecha_inicio    DATE,
    fecha_fin       DATE,
    num_horas       DECIMAL(4,1)    NOT NULL,
    DNI_profesor    VARCHAR(9),

    FOREIGN KEY (DNI_profesor) REFERENCES profesores (DNI_profesor),
    CHECK (fecha_inicio < fecha_fin)
);

CREATE TABLE alumnos (
    DNI_alumno          VARCHAR(9)      PRIMARY KEY,
    nombre_alumno       VARCHAR(50),
    apellido1_alumno    VARCHAR(50),
    apellido2_alumno    VARCHAR(50),
    direccion_alumno    VARCHAR(50),
    sexo_alumno         CHAR(1)         CHECK (sexo_alumno IN ('H','M')),
    fecha_nacimiento    DATE,
    cod_curso           INTEGER         NOT NULL,

    FOREIGN KEY (cod_curso) REFERENCES cursos (cod_curso)
);

INSERT INTO profesores 
    VALUES ('32432455', 'Juan', 'Arch', 'López', 'Puerta Negra, 4', 'Ing. Informática', 7500),
    ('43215643', 'María', 'Oliva', 'Rubio', 'Juan Alfonso, 32', 'Lda. Filología Inglesa', 5400);

INSERT INTO cursos 
    VALUES (1, 'Inglés Básico', 15, '2000-11-01', '2000-12-22', 120, '43215643'),
    (2, 'Administración Linux', NULL, '2000-09-01', NULL, 80, '32432455');

INSERT INTO alumnos 
    VALUES ('123523', 'Lucas', 'Manilva', 'López', 'Alhamar 3', 'H', '1979-11-01', 1),
    ('2567567', 'Antonia', 'López', 'Alcantara', 'Maniquí 21', 'M', NULL, 2),
    ('3123689', 'Manuel', 'Alcantara', 'Pedrós', 'Julian 2', NULL, NULL, 2),
    ('4896765', 'José', 'Pérez', 'Caballar', 'Jarcha 5', 'H', '1977-02-03', 1);

/* Consultas de prueba */
SELECT * FROM profesores;
SELECT * FROM cursos;
SELECT * FROM alumnos;

INSERT INTO alumnos (sexo_alumno, DNI_alumno, apellido2_alumno, apellido1_alumno, nombre_alumno) 
    VALUES ('P', '123523', 'Retal', 'Navas', 'Sergio');

/* Añadir campo edad_profesor a la tabla profesores */
ALTER TABLE profesores
    ADD COLUMN edad_profesor INTEGER;

/* Añadir restricción a edad_profesor para que sea mayor o igual de 18 y menor o igualque 65*/
ALTER TABLE profesores
    ADD CONSTRAINT chk_edad_profesor CHECK (edad_profesor >= 18 AND edad_profesor <= 65);

/* Añadir una restricción para que no se pueda añadir un curso si su número de alumnos máximo es menor que 10 */
ALTER TABLE cursos
    ADD CONSTRAINT chk_maximo_alumnos CHECK (maximo_alumnos >= 10),
    ADD CONSTRAINT chk_num_horas CHECK (num_horas > 100);

/*Para ver los constraint de una tabla se puede hacer con*/
SELECT *
FROM information_schema.table_constraints
WHERE table_name = 'cursos';

/*Eliminar la restricción para la columna sexo*/
ALTER TABLE alumnos
    DROP CONSTRAINT cursos_chk_1;
