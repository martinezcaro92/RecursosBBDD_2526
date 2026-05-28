-- Adminer 5.4.1 MySQL 8.0.44 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP DATABASE IF EXISTS `bd_teoria_productos`;
CREATE DATABASE `bd_teoria_productos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bd_teoria_productos`;

DELIMITER ;;

CREATE PROCEDURE `fabricante_add` (`pnombre` varchar(100), OUT `pcodigo` int)
COMMENT 'Inserta un nuevo fabricante en la tabla fabricante'
BEGIN
    DECLARE vcodigo_nuevo int;

    INSERT INTO fabricante(nombre)
        VALUES (pnombre);

    -- averiguamos el nuevo id que se le ha asignado
    SELECT LAST_INSERT_ID()
        INTO pcodigo; -- actualizamos el parametro de salida
/*
-- PRUEBAS
DELIMITER ;
START TRANSACTION;
call fabricante_add('Dodot', @codigo_dodot);
select @codigo_dodot;
select * from fabricante;
ROLLBACK;
*/
END;;

CREATE PROCEDURE `fabricante_cuenta` ()
COMMENT 'Obtiene el número de productos sin fabricante asociado'
BEGIN
-- CONSULTA
   SELECT COUNT(*)
      FROM producto
      WHERE código_fabricante IS NULL;
END;;

CREATE PROCEDURE `fabricante_listado` ()
COMMENT 'Obtiene un listado de todos los fabricantes'
BEGIN
    SELECT código,nombre
    FROM fabricante;
END;;

CREATE PROCEDURE `proc_fabricante_getNombre` (`pcodigo` int, OUT `pnombre` varchar(100))
COMMENT 'Obtiene el nombre del fabricante o la cadena vacia en caso de no existir'
BEGIN
    DECLARE vnombre VARCHAR(100) DEFAULT '';

    SELECT nombre
        INTO vnombre
        FROM fabricante
        WHERE código = pcodigo;

    SET pnombre = vnombre;
/*
DELIMITER ;
-- PRUEBAS
call proc_fabricante_getNombre(2, @nombre_fabricante_2);
call proc_fabricante_getNombre(99, @nombre_fabricante_99);
select @nombre_fabricante_2, @nombre_fabricante_99;
*/
END;;

CREATE PROCEDURE `producto_cuenta` ()
COMMENT 'Devuelve los productos del Hijo de Ep'
BEGIN
  SELECT COUNT(*)
    FROM producto
    WHERE código_fabricante IN (SELECT código FROM fabricante WHERE nombre = 'El hijo de Ep');
END;;

CREATE PROCEDURE `producto_getCodigo` (IN `nombre_producto` varchar(100), OUT `codigo_producto` integer)
BEGIN
  
  SELECT id
    INTO codigo_producto
    FROM producto
    WHERE nombre LIKE CONCAT('%', nombre_producto, '%')
    ORDER BY nombre ASC
    LIMIT 1;

END;;

CREATE PROCEDURE `producto_getMaxPrecio` ()
COMMENT 'Devuelve el producto con mayor precio con un formato dado'
BEGIN
  DECLARE vid INT;
  DECLARE vnombre VARCHAR(100);
  DECLARE vprecio DECIMAL(10,2);

  SELECT id, nombre, precio
    INTO vid, vnombre, vprecio
    FROM producto
    ORDER BY precio DESC
    LIMIT 1;

  SELECT CONCAT('(', vid,') ', vnombre, ' : ', vprecio) AS datos_producto;

END;;

CREATE PROCEDURE `producto_getMaxPrecioFabricante` (IN `pfabricante` integer)
BEGIN

  DECLARE nombre_producto VARCHAR(250);
  DECLARE v_codigo_fabricante INT;
  DECLARE v_precio DECIMAL(5,2);

  SELECT código_fabricante, nombre, precio
    INTO v_codigo_fabricante, nombre_producto, v_precio
    FROM producto
    WHERE código_fabricante=pfabricante
    ORDER BY precio DESC
    LIMIT 1;

  IF v_codigo_fabricante IS NOT NULL THEN
     SELECT CONCAT('(', v_codigo_fabricante, ') ', nombre_producto, ' : ', v_precio) AS 'datos_producto';
  ELSE
     SELECT 'no existe' AS 'datos_producto';
  END IF;

END;;

CREATE PROCEDURE `producto_getUltimo` ()
BEGIN
  DECLARE ultimo_producto VARCHAR(255);

  SELECT CONCAT_WS('-',id, nombre, tipo, precio, código_fabricante)
     INTO ultimo_producto
     FROM producto
     ORDER BY nombre DESC
     LIMIT 1;

  SELECT ultimo_producto AS 'datos_producto';

END;;

CREATE PROCEDURE `producto_posicion` (IN `posicion` integer)
BEGIN

  DECLARE id_producto INTEGER; -- DEFAULT 0;
  DECLARE nombre_producto VARCHAR(250);
  DECLARE v_codigo_fabricante INT;
  DECLARE v_precio DECIMAL(5,2);
  DECLARE v_tipo VARCHAR(50);

  SELECT id, nombre, tipo, precio, código_fabricante
    INTO id_producto, nombre_producto, v_tipo, v_precio, v_codigo_fabricante
    FROM producto
    WHERE id=posicion
    ORDER BY nombre ASC
    LIMIT 1;

  IF id_producto IS NOT NULL THEN
     SELECT CONCAT_WS('-', id_producto, nombre_producto, v_codigo_fabricante, v_precio, v_tipo) AS 'datos_producto';
  ELSE
     SELECT 'no existe' AS 'datos_producto';
  END IF;

END;;

CREATE PROCEDURE `produto_add` (`pnombre` varchar(50), `ptipo` varchar(25), `pprecio` decimal(16,2), `pcodigo_fabricante` int)
COMMENT 'Inserta un nuevo producto en la tabla producto'
BEGIN
    DECLARE vtipo_nuevo varchar(25);
    DECLARE vid_nuevo int;

    IF ifnull(ptipo, '')='' THEN
        -- buscamos el tipo del último producto insertado del mismo fabricante
        SELECT tipo
            INTO vtipo_nuevo
            FROM producto
            WHERE código_fabricante = pcodigo_fabricante
            ORDER BY id DESC
            LIMIT 1;
        IF vtipo_nuevo is null THEN
            -- no hay ningun producto anterior insertado
            SET vtipo_nuevo = 'desconocido';
        END IF;
    ELSE
        SET vtipo_nuevo = ptipo; 
    END IF;

    INSERT INTO producto(nombre, tipo, precio, código_fabricante)
        VALUES (pnombre, vtipo_nuevo, pprecio, pcodigo_fabricante);

    -- averiguamos el nuevo id que se le ha asignado
    SELECT LAST_INSERT_ID()
        INTO vid_nuevo;

    SELECT concat_ws('-', vid_nuevo, pnombre, vtipo_nuevo, pprecio, pcódigo_fabricante) as 'datos_producto';

END;;

CREATE PROCEDURE `produto_getMaxPrecioFabricante` (`pfabricante` int)
COMMENT 'Devuelve el producto de mayor precio del codigo de fabricante pfabricante con el formato (id) nombre : precio'
BEGIN
    DECLARE vid int;
    DECLARE vnombre varchar(50);
    DECLARE vprecio decimal(16,2);

    SELECT id, nombre, precio 
      INTO vid, vnombre, vprecio
        FROM producto
        WHERE código_fabricante = pfabricante
        ORDER BY precio DESC
        LIMIT 1;
    SELECT concat_ws('', '(', vid, ') ', vnombre, ' : ', vprecio) as 'datos_producto';
/*
-- PRUEBAS
DELIMITER ;
call produto_getMaxPrecioFabricante(5);
*/
END;;

DELIMITER ;

DROP TABLE IF EXISTS `fabricante`;
CREATE TABLE `fabricante` (
  `código` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`código`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `fabricante` (`código`, `nombre`) VALUES
(1,	'El hijo de Ep'),
(2,	'Tecnología Lógica'),
(3,	'Pecado Capital'),
(4,	'Rey Casi Piedra'),
(5,	'Puerta Al Mar'),
(99,	'Fabricante de prueba');

DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `tipo` varchar(25) DEFAULT NULL,
  `precio` decimal(16,2) DEFAULT NULL,
  `código_fabricante` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `código_fabricante` (`código_fabricante`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`código_fabricante`) REFERENCES `fabricante` (`código`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `producto` (`id`, `nombre`, `tipo`, `precio`, `código_fabricante`) VALUES
(1,	'Disco duro SATA3 1TB',	'almacenamiento',	86.00,	5),
(2,	'Memoria RAM DDR4 8GB',	'almacenamiento',	120.00,	4),
(3,	'Disco SSD 1 TB',	'almacenamiento',	150.00,	5),
(4,	'GeForce GTX 1050Ti',	'gráficos',	185.00,	3),
(5,	'Ati 7000Ti',	'gráficos',	170.00,	5),
(6,	'Guantes Covid-19',	'higiene',	1.00,	NULL);

-- 2026-05-13 08:08:26 UTC