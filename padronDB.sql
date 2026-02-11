DROP DATABASE IF EXISTS `padronDB`;
CREATE DATABASE `padronDB` CHARACTER SET utf8mb4;
USE `padronDB`;

DROP TABLE IF EXISTS `ciudadanos`;
CREATE TABLE `ciudadanos` (
  `DNI_ciudadano` varchar(9) NOT NULL,
  `nombre_ciudadano` varchar(150) NOT NULL,
  `apellidos_ciudadano` varchar(150) NOT NULL,
  `telefono_ciudadano` int DEFAULT NULL,
  `id_municipio` int NOT NULL,
  PRIMARY KEY (`DNI_ciudadano`),
  KEY `id_municipio` (`id_municipio`),
  CONSTRAINT `ciudadanos_ibfk_1` FOREIGN KEY (`id_municipio`) REFERENCES `municipios` (`id_municipio`),
  CONSTRAINT `ciudadanos_chk_1` CHECK (((`telefono_ciudadano` like _latin1'9________') or (`telefono_ciudadano` like _latin1'6________') or (`telefono_ciudadano` like _latin1'7________')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `ciudadanos` (`DNI_ciudadano`, `nombre_ciudadano`, `apellidos_ciudadano`, `telefono_ciudadano`, `id_municipio`) VALUES
('11111111A',	'Adolfo',	'Martn',	666666666,	1),
('22222222B',	'Miguelito',	'Re',	677777777,	2),
('33333333C',	'Nerea',	'Snchez',	688888888,	3),
('44444444D',	'Josu',	'Mollo',	699999999,	4),
('55555555E',	'lvaro',	'Snchez',	600000000,	5),
('66666666F',	'Francisco',	'Guerrero',	611111111,	6),
('77777777G',	'Jos',	'Pearrieta',	622222222,	1);

DROP TABLE IF EXISTS `comarcas`;
CREATE TABLE `comarcas` (
  `id_comarca` int NOT NULL,
  `nombre_comarca` varchar(100) NOT NULL,
  `extension_comarca` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_comarca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `comarcas` (`id_comarca`, `nombre_comarca`, `extension_comarca`) VALUES
(1,	'Valle del Guadalentn',	10000.00),
(2,	'Huerta de Murcia',	25000.00),
(3,	'Campo de Cartagena',	20000.00),
(4,	'Altiplano',	5000.00);

DROP TABLE IF EXISTS `municipios`;
CREATE TABLE `municipios` (
  `id_municipio` int NOT NULL,
  `nombre_municipio` varchar(100) NOT NULL,
  `habitantes_municipio` int NOT NULL,
  `id_comarca` int NOT NULL,
  PRIMARY KEY (`id_municipio`),
  KEY `id_comarca` (`id_comarca`),
  CONSTRAINT `municipios_ibfk_1` FOREIGN KEY (`id_comarca`) REFERENCES `comarcas` (`id_comarca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `municipios` (`id_municipio`, `nombre_municipio`, `habitantes_municipio`, `id_comarca`) VALUES
(1,	'Lorca',	100000,	1),
(2,	'Murcia',	400000,	2),
(3,	'Cartagena',	250000,	3),
(4,	'Totana',	30000,	1),
(5,	'Yecla',	35000,	4),
(6,	'San Javier',	25000,	3),
(7,	'Molina de Segura',	45000,	2);