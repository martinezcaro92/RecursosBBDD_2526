DROP DATABASE IF EXISTS `empleadosDB`;
CREATE DATABASE `empleadosDB` CHARACTER SET utf8mb4;
USE `empleadosDB`;

DROP TABLE IF EXISTS `departamento`;
CREATE TABLE `departamento` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `presupuesto` double unsigned NOT NULL,
  `gastos` double unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `departamento` (`id`, `nombre`, `presupuesto`, `gastos`) VALUES
(1,	'Desarrollo',	120000,	6000),
(2,	'Sistemas',	150000,	21000),
(3,	'Recursos Humanos',	280000,	25000),
(4,	'Contabilidad',	110000,	3000),
(5,	'I+D',	375000,	380000),
(6,	'Proyectos',	0,	0),
(7,	'Publicidad',	0,	1000);

DROP TABLE IF EXISTS `empleado`;
CREATE TABLE `empleado` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nif` varchar(9) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido1` varchar(100) NOT NULL,
  `apellido2` varchar(100) DEFAULT NULL,
  `id_departamento` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nif` (`nif`),
  KEY `id_departamento` (`id_departamento`),
  CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `empleado` (`id`, `nif`, `nombre`, `apellido1`, `apellido2`, `id_departamento`) VALUES
(1,	'32481596F',	'Aarón',	'Rivero',	'Gómez',	1),
(2,	'Y5575632D',	'Adela',	'Salas',	'Díaz',	2),
(3,	'R6970642B',	'Adolfo',	'Rubio',	'Flores',	3),
(4,	'77705545E',	'Adrián',	'Suárez',	NULL,	4),
(5,	'17087203C',	'Marcos',	'Loyola',	'Méndez',	5),
(6,	'38382980M',	'María',	'Santana',	'Moreno',	1),
(7,	'80576669X',	'Pilar',	'Ruiz',	NULL,	2),
(8,	'71651431Z',	'Pepe',	'Ruiz',	'Santana',	3),
(9,	'56399183D',	'Juan',	'Gómez',	'López',	2),
(10,	'46384486H',	'Diego',	'Flores',	'Salas',	5),
(11,	'67389283A',	'Marta',	'Herrera',	'Gil',	1),
(12,	'41234836R',	'Irene',	'Salas',	'Flores',	NULL),
(13,	'82635162B',	'Juan Antonio',	'Sáez',	'Guerrero',	NULL);
