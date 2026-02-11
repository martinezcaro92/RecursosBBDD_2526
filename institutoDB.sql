DROP DATABASE IF EXISTS `institutoDB`;
CREATE DATABASE `institutoDB` CHARACTER SET utf8mb4;
USE `institutoDB`;

DROP TABLE IF EXISTS `alumno`;
CREATE TABLE `alumno` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido1` varchar(100) NOT NULL,
  `apellido2` varchar(100) DEFAULT NULL,
  `fecha_nacimiento` date NOT NULL,
  `es_repetidor` enum('sí','no') NOT NULL,
  `teléfono` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `alumno` (`id`, `nombre`, `apellido1`, `apellido2`, `fecha_nacimiento`, `es_repetidor`, `teléfono`) VALUES
(1,	'María',	'Sánchez',	'Pérez',	'1990-12-01',	'no',	NULL),
(2,	'Juan',	'Sáez',	'Vega',	'1998-04-02',	'no',	'618253876'),
(3,	'Pepe',	'Ramírez',	'Gea',	'1988-01-03',	'no',	NULL),
(4,	'Lucía',	'Sánchez',	'Ortega',	'1993-06-13',	'sí',	'678516294'),
(5,	'Paco',	'Martínez',	'López',	'1995-11-24',	'no',	'692735409'),
(6,	'Irene',	'Gutiérrez',	'Sánchez',	'1991-03-28',	'sí',	NULL),
(7,	'Cristina',	'Fernández',	'Ramírez',	'1996-09-17',	'no',	'628349590'),
(8,	'Antonio',	'Carretero',	'Ortega',	'1994-05-20',	'sí',	'612345633'),
(9,	'Manuel',	'Domínguez',	'Hernández',	'1999-07-08',	'no',	NULL),
(10,	'Daniel',	'Moreno',	'Ruiz',	'1998-02-03',	'no',	NULL);

DROP TABLE IF EXISTS `ventas`;
CREATE TABLE `ventas` (
  `id` int unsigned NOT NULL,
  `cantidad_comprada` int unsigned NOT NULL,
  `precio_unitario` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `ventas` (`id`, `cantidad_comprada`, `precio_unitario`) VALUES
(1,	2,	1.50),
(2,	5,	1.75),
(3,	7,	2.00);