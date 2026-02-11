DROP DATABASE IF EXISTS clientesDB;
CREATE DATABASE clientesDB CHARACTER SET utf8mb4;
USE clientesDB;

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `Customers`;
CREATE TABLE `Customers` (
  `CustomerID` int NOT NULL,
  `CustomerName` varchar(100) DEFAULT NULL,
  `ContactName` varchar(100) DEFAULT NULL,
  `Address` varchar(150) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `PostalCode` varchar(20) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Customers` (`CustomerID`, `CustomerName`, `ContactName`, `Address`, `City`, `PostalCode`, `Country`) VALUES
(1,	'Alfreds Futterkiste',	'Maria Anders',	'Obere Str. 57',	'Berlin',	'12209',	'Germany'),
(2,	'Ana Trujillo Emparedados y helados',	'Ana Trujillo',	'Avda. de la Constitucin 2222',	'Mxico D.F.',	'05021',	'Mexico'),
(3,	'Antonio Moreno Taquera',	'Antonio Moreno',	'Mataderos 2312',	'Mxico D.F.',	'05023',	'Mexico'),
(4,	'Around the Horn',	'Thomas Hardy',	'120 Hanover Sq.',	'London',	'WA1 1DP',	'UK'),
(5,	'Berglunds snabbkp',	'Christina Berglund',	'Berguvsvgen 8',	'Lule',	'S-958 22',	'Sweden'),
(6,	'Blauer See Delikatessen',	'Hanna Moos',	'Forsterstr. 57',	'Mannheim',	'68306',	'Germany'),
(7,	'Blondel pre et fils',	'Frdrique Citeaux',	'24, place Klber',	'Strasbourg',	'67000',	'France'),
(8,	'Blido Comidas preparadas',	'Martn Sommer',	'C/ Araquil, 67',	'Madrid',	'28023',	'Spain'),
(9,	'Bon app',	'Laurence Lebihans',	'12, rue des Bouchers',	'Marseille',	'13008',	'France'),
(10,	'Bottom-Dollar Marketse',	'Elizabeth Lincoln',	'23 Tsawassen Blvd.',	'Tsawassen',	'T2F 8M4',	'Canada'),
(11,	'Bs Beverages',	'Victoria Ashworth',	'Fauntleroy Circus',	'London',	'EC2 5NT',	'UK'),
(12,	'Cactus Comidas para llevar',	'Patricio Simpson',	'Cerrito 333',	'Buenos Aires',	'1010',	'Argentina'),
(13,	'Centro comercial Moctezuma',	'Francisco Chang',	'Sierras de Granada 9993',	'Mxico D.F.',	'05022',	'Mexico'),
(14,	'Chop-suey Chinese',	'Yang Wang',	'Hauptstr. 29',	'Bern',	'3012',	'Switzerland'),
(15,	'Comrcio Mineiro',	'Pedro Afonso',	'Av. dos Lusadas, 23',	'So Paulo',	'05432-043',	'Brazil'),
(16,	'Consolidated Holdings',	'Elizabeth Brown',	'Berkeley Gardens 12 Brewery',	'London',	'WX1 6LT',	'UK'),
(17,	'Drachenblut Delikatessend',	'Sven Ottlieb',	'Walserweg 21',	'Aachen',	'52066',	'Germany'),
(18,	'Du monde entier',	'Janine Labrune',	'67, rue des Cinquante Otages',	'Nantes',	'44000',	'France'),
(19,	'Eastern Connection',	'Ann Devon',	'35 King George',	'London',	'WX3 6FW',	'UK'),
(20,	'Ernst Handel',	'Roland Mendel',	'Kirchgasse 6',	'Graz',	'8010',	'Austria');

DROP TABLE IF EXISTS `CustomersDaw`;
CREATE TABLE `CustomersDaw` (
  `CustomerID` int NOT NULL,
  `CustomerName` varchar(100) DEFAULT NULL,
  `ContactName` varchar(100) DEFAULT NULL,
  `Address` varchar(150) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `PostalCode` varchar(20) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `CustomersDaw` (`CustomerID`, `CustomerName`, `ContactName`, `Address`, `City`, `PostalCode`, `Country`) VALUES
(1,	'Alfreds Futterkiste',	'Maria Anders',	'Obere Str. 57',	'Berlin',	'12209',	'Germany'),
(2,	'Ana Trujillo Emparedados y helados',	'Ana Trujillo',	'Avda. de la Constitucin 2222',	'Mxico D.F.',	'05021',	'Mexico'),
(3,	'Antonio Moreno Taquera',	'Antonio Moreno',	'Mataderos 2312',	'Mxico D.F.',	'05023',	'Mexico'),
(4,	'Around the Horn',	'Thomas Hardy',	'120 Hanover Sq.',	'London',	'WA1 1DP',	'UK'),
(5,	'Berglunds snabbkp',	'Christina Berglund',	'Berguvsvgen 8',	'Lule',	'S-958 22',	'Sweden');

