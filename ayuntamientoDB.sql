CREATE DATABASE IF NOT EXISTS ayuntamiento_db;
USE ayuntamiento_db;

DROP TABLE IF EXISTS gastos;
DROP TABLE IF EXISTS instalaciones;
DROP TABLE IF EXISTS personal;
DROP TABLE IF EXISTS concejalias;
DROP TABLE IF EXISTS ayuntamientos;

CREATE TABLE ayuntamientos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    telefono VARCHAR(20)
);

CREATE TABLE concejalias (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ayuntamiento_id BIGINT,
    presupuesto DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_concejalias_ayuntamiento
        FOREIGN KEY (ayuntamiento_id) REFERENCES ayuntamientos(id)
);

CREATE TABLE personal (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    puesto VARCHAR(100) NOT NULL,
    concejalia_id BIGINT,
    es_responsable BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_personal_concejalia
        FOREIGN KEY (concejalia_id) REFERENCES concejalias(id)
);

CREATE TABLE instalaciones (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    concejalia_id BIGINT,
    responsable_id BIGINT,
    CONSTRAINT fk_instalaciones_concejalia
        FOREIGN KEY (concejalia_id) REFERENCES concejalias(id),
    CONSTRAINT fk_instalaciones_responsable
        FOREIGN KEY (responsable_id) REFERENCES personal(id)
);

CREATE TABLE gastos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(150) NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    concejalia_id BIGINT,
    fecha DATE NOT NULL,
    CONSTRAINT fk_gastos_concejalia
        FOREIGN KEY (concejalia_id) REFERENCES concejalias(id)
);

INSERT INTO ayuntamientos (id, nombre, direccion, telefono) VALUES
(1, 'Ayuntamiento de Lorca', 'Plaza de España, 1, 30800 Lorca, Murcia', '968466000'),
(2, 'Ayuntamiento de Puerto Lumbreras', 'Plaza de la Constitución, 1, 30890 Puerto Lumbreras, Murcia', '968402500'),
(3, 'Ayuntamiento de Águilas', 'Plaza de España, 14, 30880 Águilas, Murcia', '968418800'),
(4, 'Ayuntamiento de Totana', 'Plaza de la Constitución, 1, 30850 Totana, Murcia', '968418151');

INSERT INTO concejalias (id, nombre, ayuntamiento_id, presupuesto) VALUES
-- Ayuntamiento de Lorca (id = 1)
(1, 'Alcaldía', 1, 350000.00),
(2, 'Urbanismo', 1, 1250000.00),
(3, 'Servicios Sociales', 1, 980000.00),
(4, 'Deportes', 1, 640000.00),
(5, 'Educación', 1, 720000.00),
(6, 'Cultura', 1, 510000.00),
(7, 'Juventud', 1, 275000.00),
(8, 'Festejos', 1, 430000.00),
(9, 'Medio Ambiente', 1, 560000.00),
(10, 'Obras y Servicios', 1, 890000.00),
(11, 'Turismo', 1, 390000.00),
(12, 'Seguridad Ciudadana', 1, 610000.00),

-- Ayuntamiento de Puerto Lumbreras (id = 2)
(13, 'Alcaldía', 2, 180000.00),
(14, 'Urbanismo', 2, 540000.00),
(15, 'Cultura', 2, 310000.00),
(16, 'Obras y Servicios', 2, 455000.00),
(17, 'Servicios Sociales', 2, 420000.00),
(18, 'Deportes', 2, 295000.00),
(19, 'Educación', 2, 260000.00),
(20, 'Juventud', 2, 140000.00),
(21, 'Festejos', 2, 225000.00),
(22, 'Medio Ambiente', 2, 205000.00),
(23, 'Turismo', 2, 175000.00),
(24, 'Seguridad Ciudadana', 2, 330000.00),

-- Ayuntamiento de Águilas (id = 3)
(25, 'Alcaldía', 3, 220000.00),
(26, 'Turismo', 3, 720000.00),
(27, 'Medio Ambiente', 3, 510000.00),
(28, 'Deportes', 3, 430000.00),
(29, 'Urbanismo', 3, 670000.00),
(30, 'Servicios Sociales', 3, 590000.00),
(31, 'Cultura', 3, 360000.00),
(32, 'Educación', 3, 340000.00),
(33, 'Juventud', 3, 160000.00),
(34, 'Festejos', 3, 310000.00),
(35, 'Obras y Servicios', 3, 605000.00),
(36, 'Playas y Limpieza', 3, 480000.00),

-- Ayuntamiento de Totana (id = 4)
(37, 'Alcaldía', 4, 210000.00),
(38, 'Educación', 4, 390000.00),
(39, 'Festejos', 4, 275000.00),
(40, 'Juventud', 4, 210000.00),
(41, 'Urbanismo', 4, 520000.00),
(42, 'Servicios Sociales', 4, 470000.00),
(43, 'Deportes', 4, 330000.00),
(44, 'Cultura', 4, 285000.00),
(45, 'Medio Ambiente', 4, 240000.00),
(46, 'Obras y Servicios', 4, 495000.00),
(47, 'Turismo', 4, 185000.00),
(48, 'Seguridad Ciudadana', 4, 350000.00);

INSERT INTO personal (id, nombre, puesto, concejalia_id, es_responsable) VALUES
(1, 'José Antonio Martínez', 'Alcalde', 1, TRUE),
(2, 'María Dolores García', 'Concejala de Urbanismo', 2, TRUE),
(3, 'Antonio Navarro López', 'Concejal de Servicios Sociales', 3, TRUE),
(4, 'Francisco Pérez Gil', 'Concejal de Deportes', 4, TRUE),
(5, 'Lucía Fernández Ruiz', 'Concejala de Educación', 5, TRUE),
(6, 'Pedro Sánchez Navarro', 'Concejal de Cultura', 6, TRUE),
(7, 'Carmen Morales López', 'Concejala de Juventud', 7, TRUE),
(8, 'Javier Martínez Pérez', 'Concejal de Festejos', 8, TRUE),
(9, 'Ana Belén Gómez Ruiz', 'Concejala de Medio Ambiente', 9, TRUE),
(10, 'Miguel Ángel López García', 'Concejal de Obras y Servicios', 10, TRUE),
(11, 'Isabel Navarro Pérez', 'Concejala de Turismo', 11, TRUE),
(12, 'Francisco Hernández Sánchez', 'Concejal de Seguridad Ciudadana', 12, TRUE),

(13, 'Juan Antonio Díaz', 'Arquitecto Municipal', 2, FALSE),
(14, 'Rocío Martínez', 'Ingeniera Técnica de Urbanismo', 2, FALSE),
(15, 'Luis Alberto García', 'Técnico de Planeamiento', 2, FALSE),

(16, 'Sonia Pérez López', 'Trabajadora Social', 3, FALSE),
(17, 'Carlos Navarro Ruiz', 'Educador Social', 3, FALSE),
(18, 'Marta Gómez Sánchez', 'Coordinadora de Servicios Sociales', 3, FALSE),

(19, 'Antonio López Martínez', 'Coordinador de Instalaciones Deportivas', 4, FALSE),
(20, 'Raúl Sánchez Fernández', 'Monitor Deportivo', 4, FALSE),
(21, 'Sergio Martínez Pérez', 'Preparador Físico Municipal', 4, FALSE),

(22, 'Beatriz García Navarro', 'Técnica de Educación', 5, FALSE),
(23, 'Laura Sánchez Pérez', 'Gestora de Programas Educativos', 5, FALSE),
(24, 'Pedro Martínez López', 'Administrador Educativo', 5, FALSE),

(25, 'Ana María Pérez Ruiz', 'Gestora Cultural', 6, FALSE),
(26, 'Daniel Navarro López', 'Coordinador de Eventos Culturales', 6, FALSE),
(27, 'Cristina Martínez García', 'Técnica Cultural', 6, FALSE),

(28, 'Sergio López Ruiz', 'Informador Juvenil', 7, FALSE),
(29, 'Paula Navarro Pérez', 'Coordinadora de Juventud', 7, FALSE),
(30, 'Mario Sánchez Martínez', 'Dinamizador Juvenil', 7, FALSE),

(31, 'José Luis García Pérez', 'Coordinador de Festejos', 8, FALSE),
(32, 'Lucía Navarro Martínez', 'Gestora de Eventos', 8, FALSE),
(33, 'Raquel Sánchez López', 'Técnica de Producción de Eventos', 8, FALSE),

(34, 'Carlos Martínez Navarro', 'Técnico Ambiental', 9, FALSE),
(35, 'Laura López García', 'Educadora Ambiental', 9, FALSE),
(36, 'Francisco Sánchez Ruiz', 'Inspector Medioambiental', 9, FALSE),

(37, 'Juan Pedro Navarro', 'Encargado de Obras', 10, FALSE),
(38, 'Pedro García Martínez', 'Operario de Mantenimiento', 10, FALSE),
(39, 'Antonio Ruiz Sánchez', 'Conductor de Servicios Municipales', 10, FALSE),
(40, 'José Manuel López Pérez', 'Operario de Infraestructuras', 10, FALSE),

(41, 'Isabel Martínez Navarro', 'Técnica de Turismo', 11, FALSE),
(42, 'Carmen García Ruiz', 'Guía Turística Municipal', 11, FALSE),
(43, 'Luis Sánchez Pérez', 'Gestor de Promoción Turística', 11, FALSE),

(44, 'Antonio Martínez Ruiz', 'Inspector de Policía Local', 12, FALSE),
(45, 'Pedro Navarro García', 'Oficial de Policía Local', 12, FALSE),
(46, 'Sergio López Martínez', 'Agente de Policía Local', 12, FALSE),

(47, 'María Sánchez Navarro', 'Administrativa Municipal', 1, FALSE),
(48, 'Elena García Pérez', 'Secretaria de Alcaldía', 1, FALSE),
(49, 'José Antonio López Ruiz', 'Técnico de Administración General', 1, FALSE),
(50, 'Carmen Navarro Martínez', 'Gestora Administrativa', 1, FALSE),
(51, 'Miguel Sánchez García', 'Auxiliar Administrativo', 1, FALSE);

INSERT INTO personal (id, nombre, puesto, concejalia_id, es_responsable) VALUES
(52, 'Pedro Antonio Sánchez', 'Alcalde', 13, TRUE),
(53, 'María Carmen López', 'Concejala de Urbanismo', 14, TRUE),
(54, 'Antonio Ruiz Navarro', 'Concejal de Cultura', 15, TRUE),
(55, 'Francisco José Martínez', 'Concejal de Obras y Servicios', 16, TRUE),
(56, 'Ana Belén García', 'Concejala de Servicios Sociales', 17, TRUE),
(57, 'José Manuel Navarro', 'Concejal de Deportes', 18, TRUE),
(58, 'Lucía Fernández Sánchez', 'Concejala de Educación', 19, TRUE),
(59, 'Raúl Pérez García', 'Concejal de Juventud', 20, TRUE),
(60, 'Carmen Martínez López', 'Concejala de Festejos', 21, TRUE),
(61, 'Miguel Ángel Ruiz', 'Concejal de Medio Ambiente', 22, TRUE),
(62, 'Elena Sánchez Pérez', 'Concejala de Turismo', 23, TRUE),
(63, 'Sergio Navarro López', 'Concejal de Seguridad Ciudadana', 24, TRUE),

(64, 'Juan Antonio García', 'Arquitecto Técnico Municipal', 14, FALSE),
(65, 'Laura Martínez Navarro', 'Técnica de Urbanismo', 14, FALSE),

(66, 'Ana María Sánchez', 'Gestora Cultural', 15, FALSE),
(67, 'Pedro López Ruiz', 'Coordinador de Actividades Culturales', 15, FALSE),

(68, 'Antonio Navarro Pérez', 'Encargado de Obras Municipales', 16, FALSE),
(69, 'José Sánchez Martínez', 'Operario de Mantenimiento', 16, FALSE),

(70, 'Rocío Martínez García', 'Trabajadora Social', 17, FALSE),
(71, 'Carlos Pérez Navarro', 'Educador Social', 17, FALSE),

(72, 'Sergio López García', 'Monitor Deportivo', 18, FALSE),
(73, 'Raquel Sánchez Navarro', 'Coordinadora de Deportes', 18, FALSE),

(74, 'Isabel Navarro Martínez', 'Administrativa de Educación', 19, FALSE),
(75, 'Mario Sánchez López', 'Informador Juvenil', 20, FALSE),
(76, 'Beatriz García Pérez', 'Auxiliar Administrativa', 13, FALSE);

INSERT INTO personal (id, nombre, puesto, concejalia_id, es_responsable) VALUES
(77, 'María del Carmen Moreno', 'Alcaldesa', 25, TRUE),
(78, 'Pedro Sánchez López', 'Concejal de Turismo', 26, TRUE),
(79, 'Antonio García Navarro', 'Concejal de Medio Ambiente', 27, TRUE),
(80, 'Francisco López Ruiz', 'Concejal de Deportes', 28, TRUE),
(81, 'Ana María Sánchez Pérez', 'Concejala de Urbanismo', 29, TRUE),
(82, 'José Antonio Martínez', 'Concejal de Servicios Sociales', 30, TRUE),
(83, 'Lucía Navarro Ruiz', 'Concejala de Cultura', 31, TRUE),
(84, 'Raúl García Martínez', 'Concejal de Educación', 32, TRUE),
(85, 'Elena Sánchez López', 'Concejala de Juventud', 33, TRUE),
(86, 'Miguel Ángel Navarro', 'Concejal de Festejos', 34, TRUE),
(87, 'Pedro José Martínez', 'Concejal de Obras y Servicios', 35, TRUE),
(88, 'Carmen López García', 'Concejala de Playas y Limpieza', 36, TRUE),

(89, 'Juan Antonio Pérez', 'Técnico de Turismo', 26, FALSE),
(90, 'Laura Sánchez Martínez', 'Gestora de Promoción Turística', 26, FALSE),

(91, 'Carlos Navarro Ruiz', 'Técnico Ambiental', 27, FALSE),
(92, 'Sonia García Pérez', 'Educadora Ambiental', 27, FALSE),

(93, 'Raúl Martínez López', 'Coordinador de Instalaciones Deportivas', 28, FALSE),
(94, 'Sergio Sánchez Navarro', 'Monitor Deportivo', 28, FALSE),

(95, 'Antonio López García', 'Arquitecto Municipal', 29, FALSE),
(96, 'Cristina Martínez Ruiz', 'Ingeniera Técnica de Urbanismo', 29, FALSE),

(97, 'Marta Navarro Pérez', 'Trabajadora Social', 30, FALSE),
(98, 'José Manuel García Ruiz', 'Educador Social', 30, FALSE),

(99, 'Beatriz Sánchez López', 'Gestora Cultural', 31, FALSE),
(100, 'Pedro Navarro Martínez', 'Coordinador de Eventos Culturales', 31, FALSE),

(101, 'Antonio Sánchez García', 'Encargado de Limpieza de Playas', 36, FALSE);

INSERT INTO personal (id, nombre, puesto, concejalia_id, es_responsable) VALUES
(102, 'Juan José Cánovas Martínez', 'Alcalde', 37, TRUE),
(103, 'María Isabel López García', 'Concejala de Educación', 38, TRUE),
(104, 'Antonio Sánchez Navarro', 'Concejal de Festejos', 39, TRUE),
(105, 'Lucía Martínez Pérez', 'Concejala de Juventud', 40, TRUE),
(106, 'Pedro José García Ruiz', 'Concejal de Urbanismo', 41, TRUE),
(107, 'Ana Belén Navarro López', 'Concejala de Servicios Sociales', 42, TRUE),
(108, 'Miguel Ángel Martínez Sánchez', 'Concejal de Deportes', 43, TRUE),
(109, 'Carmen Pérez García', 'Concejala de Cultura', 44, TRUE),
(110, 'Francisco López Martínez', 'Concejal de Medio Ambiente', 45, TRUE),
(111, 'Raúl Sánchez Pérez', 'Concejal de Obras y Servicios', 46, TRUE),
(112, 'Elena García Navarro', 'Concejala de Turismo', 47, TRUE),
(113, 'José Antonio Martínez López', 'Concejal de Seguridad Ciudadana', 48, TRUE),

(114, 'Beatriz Sánchez Ruiz', 'Técnica de Educación', 38, FALSE),
(115, 'Salvador Navarro Pérez', 'Administrativo de Educación', 38, FALSE),

(116, 'Rocío Martínez García', 'Coordinadora de Festejos', 39, FALSE),
(117, 'David López Sánchez', 'Técnico de Producción de Eventos', 39, FALSE),
(118, 'Paula Navarro Ruiz', 'Gestora de Eventos Municipales', 39, FALSE),

(119, 'Sergio García Pérez', 'Informador Juvenil', 40, FALSE),
(120, 'Nuria López Martínez', 'Coordinadora de Juventud', 40, FALSE),
(121, 'Mario Sánchez García', 'Dinamizador Juvenil', 40, FALSE),

(122, 'Antonio Pérez López', 'Arquitecto Técnico Municipal', 41, FALSE),
(123, 'Cristina Navarro Sánchez', 'Ingeniera Técnica de Urbanismo', 41, FALSE),

(124, 'Marta García Ruiz', 'Trabajadora Social', 42, FALSE),
(125, 'Carlos Martínez Navarro', 'Educador Social', 42, FALSE),
(126, 'Laura Sánchez López', 'Coordinadora de Servicios Sociales', 42, FALSE),

(127, 'Adrián López García', 'Monitor Deportivo', 43, FALSE),
(128, 'José Manuel Navarro Ruiz', 'Coordinador de Instalaciones Deportivas', 43, FALSE),

(129, 'Isabel Pérez Martínez', 'Gestora Cultural', 44, FALSE),

(130, 'Francisco Navarro García', 'Técnico Ambiental', 45, FALSE),

(131, 'Pedro Sánchez Martínez', 'Encargado de Obras Municipales', 46, FALSE);

INSERT INTO instalaciones (id, nombre, direccion, concejalia_id, responsable_id) VALUES
(1,'Casa Consistorial de Lorca','Plaza de España 1, Lorca',1,1),
(2,'Oficina Técnica de Urbanismo','Calle Corredera 25, Lorca',2,2),
(3,'Centro de Servicios Sociales Norte','Calle Nogalte 8, Lorca',3,16),
(4,'Centro de Servicios Sociales Sur','Alameda Cervantes 52, Lorca',3,17),
(5,'Complejo Deportivo Felipe VI','Calle Juan Antonio Dimas s/n, Lorca',4,19),
(6,'Polideportivo San José','Calle Pérez Casas s/n, Lorca',4,20),
(7,'Piscina Municipal Cubierta','Avenida Santa Clara s/n, Lorca',4,21),
(8,'Centro Educativo Municipal','Calle Lope Gisbert 12, Lorca',5,22),
(9,'Biblioteca Municipal Pilar Barnés','Plaza Real 3, Lorca',6,26),
(10,'Teatro Guerra','Plaza Calderón s/n, Lorca',6,27),
(11,'Centro Cultural Espín','Calle Corredera 6, Lorca',6,25),
(12,'Casa de la Juventud','Calle Alporchones 14, Lorca',7,29),
(13,'Espacio Joven La Hoya','Calle Mayor 18, La Hoya',7,30),
(14,'Recinto Ferial Huerto de la Rueda','Avenida Europa s/n, Lorca',8,31),
(15,'Auditorio Margarita Lozano','Avenida Juan Carlos I s/n, Lorca',8,32),
(16,'Centro de Educación Ambiental','Calle Sierra Espuña s/n, Lorca',9,34),
(17,'Parque Municipal de Jardinería','Camino Marín s/n, Lorca',9,35),
(18,'Taller Municipal de Obras','Polígono Saprelorca nave 15',10,37),
(19,'Almacén de Servicios Municipales','Polígono Saprelorca nave 16',10,38),
(20,'Garaje de Vehículos Municipales','Polígono Saprelorca nave 18',10,39),
(21,'Oficina de Turismo de Lorca','Plaza de España 7, Lorca',11,41),
(22,'Centro de Visitantes Castillo de Lorca','Castillo de Lorca',11,42),
(23,'Jefatura Policía Local','Calle Juan Antonio Dimas 5, Lorca',12,44),
(24,'Parque Infantil San Diego','Barrio San Diego, Lorca',8,31),
(25,'Centro Cívico La Viña','Barrio La Viña, Lorca',3,18),
(26,'Centro Deportivo La Hoya','Diputación La Hoya, Lorca',4,20),
(27,'Vivero Municipal','Camino del Saladar s/n, Lorca',9,34),
(28,'Centro Cultural San Cristóbal','Barrio San Cristóbal, Lorca',6,25),
(29,'Oficina Municipal de Atención Ciudadana','Plaza de España 2, Lorca',1,48),
(30,'Archivo Municipal','Calle Selgas 3, Lorca',1,50);

INSERT INTO instalaciones (id, nombre, direccion, concejalia_id, responsable_id) VALUES
(31,'Casa Consistorial de Puerto Lumbreras','Plaza Constitución 1',13,52),
(32,'Oficina Técnica de Urbanismo','Avenida Región Murciana 20',14,64),
(33,'Centro Cultural Casa de los Duendes','Calle Doctor Fleming 3',15,66),
(34,'Parque de Servicios Municipales','Polígono Industrial El Descanso',16,68),
(35,'Centro de Servicios Sociales','Calle Mayor 12',17,70),
(36,'Polideportivo Municipal','Avenida Juan Carlos I s/n',18,72),
(37,'Centro de Educación Infantil Municipal','Calle Lorca 6',19,74),
(38,'Espacio Joven Municipal','Calle Murcia 14',20,75),
(39,'Recinto Ferial','Avenida Almería s/n',21,60),
(40,'Oficina de Turismo','Plaza Constitución 3',23,62);

INSERT INTO instalaciones (id, nombre, direccion, concejalia_id, responsable_id) VALUES
(41,'Casa Consistorial de Águilas','Plaza de España 14',25,77),
(42,'Oficina de Turismo de Águilas','Plaza de España 1',26,89),
(43,'Centro de Educación Ambiental','Calle Aire 8',27,91),
(44,'Polideportivo Municipal','Avenida del Deporte s/n',28,93),
(45,'Estadio El Rubial','Avenida del Deporte 2',28,94),
(46,'Oficina Técnica de Urbanismo','Calle Conde de Aranda 10',29,95),
(47,'Centro de Servicios Sociales','Calle Rey Carlos III 15',30,97),
(48,'Auditorio y Palacio de Congresos','Avenida de las Acacias s/n',31,99),
(49,'Biblioteca Municipal','Calle Castelar 2',31,100),
(50,'Centro de Educación Municipal','Calle Iberia 4',32,84),
(51,'Espacio Joven Águilas','Calle Murcia 9',33,85),
(52,'Recinto de Carnaval','Explanada del Auditorio',34,86),
(53,'Parque de Servicios Municipales','Polígono Industrial Águilas',35,87),
(54,'Centro de Interpretación del Mar','Puerto Deportivo',26,90),
(55,'Centro de Limpieza de Playas','Avenida de la Bahía s/n',36,101);

INSERT INTO instalaciones (id, nombre, direccion, concejalia_id, responsable_id) VALUES
(56,'Casa Consistorial de Totana','Plaza Constitución 1',37,102),
(57,'Centro Educativo Municipal','Calle General Aznar 5',38,114),
(58,'Biblioteca Municipal Mateo García','Calle Santomera 10',38,115),
(59,'Recinto Ferial de Totana','Avenida Rambla de la Santa',39,116),
(60,'Auditorio Marcos Ortiz','Parque Municipal',39,117),
(61,'Espacio Joven Totana','Calle Menorca 12',40,119),
(62,'Centro Juvenil El Candil','Calle del Pilar 8',40,121),
(63,'Oficina Técnica de Urbanismo','Plaza Constitución 3',41,122),
(64,'Centro de Servicios Sociales','Calle Sol 18',42,124),
(65,'Centro de Atención Familiar','Calle Rambla 20',42,125),
(66,'Polideportivo Municipal 6 de Diciembre','Avenida Santa Eulalia',43,127),
(67,'Piscina Municipal Totana','Avenida Santa Eulalia',43,128),
(68,'Centro Sociocultural La Cárcel','Calle Santa Eulalia 8',44,129),
(69,'Casa de la Cultura','Calle Padre Melchor 14',44,129),
(70,'Vivero Municipal','Camino de Lébor s/n',45,130),
(71,'Parque Municipal de Jardinería','Avenida Lorca',45,130),
(72,'Taller Municipal de Obras','Polígono Industrial El Saladar',46,131),
(73,'Almacén de Servicios Municipales','Polígono Industrial El Saladar',46,131),
(74,'Oficina de Turismo Totana','Plaza Constitución 4',47,112),
(75,'Jefatura Policía Local','Calle Rambla de la Santa 15',48,113);

INSERT INTO gastos (id, descripcion, monto, concejalia_id, fecha) VALUES
-- =========================
-- LORCA (25 gastos)
-- =========================
(1, 'Redacción de proyecto de ampliación urbana en pedanías', 420000.00, 2, '2026-01-15'),
(2, 'Reparación de acerado y firme en barrio de San Cristóbal', 315000.00, 2, '2026-02-03'),
(3, 'Adecuación de solares municipales para uso público', 290000.00, 2, '2026-02-18'),
(4, 'Asistencia técnica para revisión del plan urbanístico', 265000.00, 2, '2026-03-02'),

(5, 'Programa de ayuda de emergencia social', 185000.00, 3, '2026-01-20'),
(6, 'Suministro de productos de primera necesidad', 96000.00, 3, '2026-02-08'),
(7, 'Servicio de atención domiciliaria extraordinaria', 142000.00, 3, '2026-03-11'),

(8, 'Mantenimiento integral de instalaciones deportivas', 138000.00, 4, '2026-01-25'),
(9, 'Renovación de equipamiento de gimnasio municipal', 89000.00, 4, '2026-02-21'),

(10, 'Adquisición de material didáctico para actividades municipales', 74000.00, 5, '2026-01-18'),
(11, 'Programa de apoyo escolar en barrios', 52000.00, 5, '2026-03-05'),

(12, 'Organización del festival de teatro local', 118000.00, 6, '2026-02-10'),
(13, 'Digitalización del archivo cultural', 46000.00, 6, '2026-03-14'),

(14, 'Campaña de actividades juveniles de invierno', 38000.00, 7, '2026-01-27'),
(15, 'Talleres de orientación y empleo joven', 28500.00, 7, '2026-03-08'),

(16, 'Montaje de infraestructuras para feria y fiestas patronales', 210000.00, 8, '2026-01-30'),
(17, 'Contratación de espectáculos y sonido', 165000.00, 8, '2026-02-12'),
(18, 'Decoración festiva y alumbrado extraordinario', 124000.00, 8, '2026-03-01'),

(19, 'Reposición de arbolado urbano', 97000.00, 9, '2026-02-06'),
(20, 'Campaña de control de vertidos y limpieza ambiental', 61000.00, 9, '2026-03-09'),

(21, 'Compra de maquinaria para brigada municipal', 240000.00, 10, '2026-01-22'),
(22, 'Reparación de vías públicas y caminos', 355000.00, 10, '2026-02-26'),

(23, 'Promoción turística de Semana Santa y patrimonio', 84000.00, 11, '2026-02-04'),
(24, 'Señalización turística inteligente', 57000.00, 11, '2026-03-12'),

(25, 'Renovación de vestuario y material operativo policial', 93000.00, 12, '2026-02-17'),

-- =========================
-- PUERTO LUMBRERAS (15 gastos)
-- =========================
(26, 'Redacción de estudio de detalle urbano', 118000.00, 14, '2026-01-19'),
(27, 'Adecuación de accesos a zona residencial', 156000.00, 14, '2026-03-03'),

(28, 'Programación cultural trimestral', 69000.00, 15, '2026-02-05'),
(29, 'Exposición y actividades de patrimonio local', 42000.00, 15, '2026-03-16'),

(30, 'Compra de contenedores y herramientas de servicio', 138000.00, 16, '2026-01-28'),
(31, 'Reparación urgente de alumbrado y mobiliario urbano', 174000.00, 16, '2026-02-20'),
(32, 'Pavimentación de calles y mantenimiento extraordinario', 201000.00, 16, '2026-03-10'),

(33, 'Ayudas de emergencia para familias vulnerables', 87000.00, 17, '2026-01-24'),
(34, 'Programa de intervención social comunitaria', 54000.00, 17, '2026-03-04'),

(35, 'Renovación de porterías y equipamiento deportivo', 48000.00, 18, '2026-02-14'),

(36, 'Material educativo para aula de apoyo municipal', 26000.00, 19, '2026-01-31'),

(37, 'Festival juvenil y actividades de ocio alternativo', 33000.00, 20, '2026-02-27'),

(38, 'Instalación de escenarios y carpas para fiestas', 91000.00, 21, '2026-02-11'),

(39, 'Plan de mejora y limpieza de zonas verdes', 73000.00, 22, '2026-03-06'),

(40, 'Campaña de promoción de rutas locales', 22000.00, 23, '2026-03-13'),

-- =========================
-- ÁGUILAS (20 gastos)
-- =========================
(41, 'Campaña nacional de promoción turística de verano', 285000.00, 26, '2026-01-17'),
(42, 'Instalación de puntos de información turística digital', 176000.00, 26, '2026-02-09'),
(43, 'Acciones de marketing para carnaval y eventos', 312000.00, 26, '2026-03-07'),

(44, 'Reposición de contenedores de reciclaje', 98000.00, 27, '2026-01-26'),
(45, 'Programa de vigilancia y educación ambiental', 83000.00, 27, '2026-02-22'),

(46, 'Mantenimiento de césped y pistas deportivas', 124000.00, 28, '2026-01-29'),
(47, 'Adquisición de material para escuelas deportivas', 71000.00, 28, '2026-03-05'),

(48, 'Proyecto de mejora del frente urbano litoral', 215000.00, 29, '2026-02-03'),
(49, 'Asistencia técnica para licencias y planeamiento', 164000.00, 29, '2026-03-11'),

(50, 'Programa de apoyo a mayores y dependencia', 139000.00, 30, '2026-01-21'),
(51, 'Refuerzo de atención social comunitaria', 92000.00, 30, '2026-02-25'),

(52, 'Festival de música y artes escénicas', 112000.00, 31, '2026-02-08'),
(53, 'Mejora de equipamiento escénico del auditorio', 86000.00, 31, '2026-03-15'),

(54, 'Plan municipal de actividades educativas', 67000.00, 32, '2026-01-30'),

(55, 'Programa de ocio joven y formación digital', 41000.00, 33, '2026-02-18'),

(56, 'Infraestructuras para fiestas y carnaval', 121000.00, 34, '2026-01-27'),
(57, 'Contratación de servicios técnicos para eventos', 97000.00, 34, '2026-02-13'),

(58, 'Mejora de firme y señalización en vías urbanas', 201000.00, 35, '2026-02-28'),

(59, 'Limpieza extraordinaria del litoral y playas', 258000.00, 36, '2026-01-23'),
(60, 'Maquinaria y cribado de arena en temporada alta', 249000.00, 36, '2026-03-09'),

-- =========================
-- TOTANA (15 gastos)
-- =========================
(61, 'Programa municipal de refuerzo educativo', 54000.00, 38, '2026-01-16'),
(62, 'Material y recursos para actividades formativas', 36000.00, 38, '2026-03-01'),

(63, 'Montaje de escenarios para fiestas patronales', 128000.00, 39, '2026-01-31'),
(64, 'Actuaciones musicales y eventos festivos', 97000.00, 39, '2026-02-15'),
(65, 'Iluminación extraordinaria y decoración festiva', 86000.00, 39, '2026-03-12'),

(66, 'Actividades juveniles y talleres de empleo', 29000.00, 40, '2026-02-04'),

(67, 'Redacción de proyecto de reordenación urbana', 142000.00, 41, '2026-01-22'),
(68, 'Adecuación de espacios públicos y accesibilidad', 118000.00, 41, '2026-03-06'),

(69, 'Ayudas de urgencia social', 76000.00, 42, '2026-02-10'),
(70, 'Programa de atención a familias', 58000.00, 42, '2026-03-14'),

(71, 'Reparación de pistas e instalaciones deportivas', 64000.00, 43, '2026-02-19'),

(72, 'Programación cultural de primavera', 47000.00, 44, '2026-03-08'),

(73, 'Campaña de mejora de zonas verdes', 39000.00, 45, '2026-01-29'),

(74, 'Compra de materiales para brigada municipal', 184000.00, 46, '2026-02-23'),

(75, 'Campaña de promoción turística local', 21000.00, 47, '2026-03-10');

INSERT INTO gastos (id, descripcion, monto, concejalia_id, fecha) VALUES
-- =========================
-- LORCA (25 gastos)
-- =========================
(76, 'Redacción de proyecto de ampliación urbana en pedanías', 420000.00, 2, '2026-01-15'),
(77, 'Reparación de acerado y firme en barrio de San Cristóbal', 315000.00, 2, '2026-02-03'),
(78, 'Adecuación de solares municipales para uso público', 290000.00, 2, '2026-02-18'),
(79, 'Asistencia técnica para revisión del plan urbanístico', 265000.00, 2, '2026-03-02'),

(80, 'Programa de ayuda de emergencia social', 185000.00, 3, '2026-01-20'),
(81, 'Suministro de productos de primera necesidad', 96000.00, 3, '2026-02-08'),
(82, 'Servicio de atención domiciliaria extraordinaria', 142000.00, 3, '2026-03-11'),

(83, 'Mantenimiento integral de instalaciones deportivas', 138000.00, 4, '2026-01-25'),
(84, 'Renovación de equipamiento de gimnasio municipal', 89000.00, 4, '2026-02-21'),

(85, 'Adquisición de material didáctico para actividades municipales', 74000.00, 5, '2026-01-18'),
(86, 'Programa de apoyo escolar en barrios', 52000.00, 5, '2026-03-05'),

(87, 'Organización del festival de teatro local', 118000.00, 6, '2026-02-10'),
(88, 'Digitalización del archivo cultural', 46000.00, 6, '2026-03-14'),

(89, 'Campaña de actividades juveniles de invierno', 38000.00, 7, '2026-01-27'),
(90, 'Talleres de orientación y empleo joven', 28500.00, 7, '2026-03-08'),

(91, 'Montaje de infraestructuras para feria y fiestas patronales', 210000.00, 8, '2026-01-30'),
(92, 'Contratación de espectáculos y sonido', 165000.00, 8, '2026-02-12'),
(93, 'Decoración festiva y alumbrado extraordinario', 124000.00, 8, '2026-03-01'),

(94, 'Reposición de arbolado urbano', 97000.00, 9, '2026-02-06'),
(95, 'Campaña de control de vertidos y limpieza ambiental', 61000.00, 9, '2026-03-09'),

(96, 'Compra de maquinaria para brigada municipal', 240000.00, 10, '2026-01-22'),
(97, 'Reparación de vías públicas y caminos', 355000.00, 10, '2026-02-26'),

(98, 'Promoción turística de Semana Santa y patrimonio', 84000.00, 11, '2026-02-04'),
(99, 'Señalización turística inteligente', 57000.00, 11, '2026-03-12'),

(100, 'Renovación de vestuario y material operativo policial', 93000.00, 12, '2026-02-17'),

-- =========================
-- PUERTO LUMBRERAS (15 gastos)
-- =========================
(101, 'Redacción de estudio de detalle urbano', 118000.00, 14, '2026-01-19'),
(102, 'Adecuación de accesos a zona residencial', 156000.00, 14, '2026-03-03'),

(103, 'Programación cultural trimestral', 69000.00, 15, '2026-02-05'),
(104, 'Exposición y actividades de patrimonio local', 42000.00, 15, '2026-03-16'),

(105, 'Compra de contenedores y herramientas de servicio', 138000.00, 16, '2026-01-28'),
(106, 'Reparación urgente de alumbrado y mobiliario urbano', 174000.00, 16, '2026-02-20'),
(107, 'Pavimentación de calles y mantenimiento extraordinario', 201000.00, 16, '2026-03-10'),

(108, 'Ayudas de emergencia para familias vulnerables', 87000.00, 17, '2026-01-24'),
(109, 'Programa de intervención social comunitaria', 54000.00, 17, '2026-03-04'),

(110, 'Renovación de porterías y equipamiento deportivo', 48000.00, 18, '2026-02-14'),

(111, 'Material educativo para aula de apoyo municipal', 26000.00, 19, '2026-01-31'),

(112, 'Festival juvenil y actividades de ocio alternativo', 33000.00, 20, '2026-02-27'),

(113, 'Instalación de escenarios y carpas para fiestas', 91000.00, 21, '2026-02-11'),

(114, 'Plan de mejora y limpieza de zonas verdes', 73000.00, 22, '2026-03-06'),

(115, 'Campaña de promoción de rutas locales', 22000.00, 23, '2026-03-13'),

-- =========================
-- ÁGUILAS (20 gastos)
-- =========================
(116, 'Campaña nacional de promoción turística de verano', 285000.00, 26, '2026-01-17'),
(117, 'Instalación de puntos de información turística digital', 176000.00, 26, '2026-02-09'),
(118, 'Acciones de marketing para carnaval y eventos', 312000.00, 26, '2026-03-07'),

(119, 'Reposición de contenedores de reciclaje', 98000.00, 27, '2026-01-26'),
(120, 'Programa de vigilancia y educación ambiental', 83000.00, 27, '2026-02-22'),

(121, 'Mantenimiento de césped y pistas deportivas', 124000.00, 28, '2026-01-29'),
(122, 'Adquisición de material para escuelas deportivas', 71000.00, 28, '2026-03-05'),

(123, 'Proyecto de mejora del frente urbano litoral', 215000.00, 29, '2026-02-03'),
(124, 'Asistencia técnica para licencias y planeamiento', 164000.00, 29, '2026-03-11'),

(125, 'Programa de apoyo a mayores y dependencia', 139000.00, 30, '2026-01-21'),
(126, 'Refuerzo de atención social comunitaria', 92000.00, 30, '2026-02-25'),

(127, 'Festival de música y artes escénicas', 112000.00, 31, '2026-02-08'),
(128, 'Mejora de equipamiento escénico del auditorio', 86000.00, 31, '2026-03-15'),

(129, 'Plan municipal de actividades educativas', 67000.00, 32, '2026-01-30'),

(130, 'Programa de ocio joven y formación digital', 41000.00, 33, '2026-02-18'),

(131, 'Infraestructuras para fiestas y carnaval', 121000.00, 34, '2026-01-27'),
(132, 'Contratación de servicios técnicos para eventos', 97000.00, 34, '2026-02-13'),

(133, 'Mejora de firme y señalización en vías urbanas', 201000.00, 35, '2026-02-28'),

(134, 'Limpieza extraordinaria del litoral y playas', 258000.00, 36, '2026-01-23'),
(135, 'Maquinaria y cribado de arena en temporada alta', 249000.00, 36, '2026-03-09'),

-- =========================
-- TOTANA (15 gastos)
-- =========================
(136, 'Programa municipal de refuerzo educativo', 54000.00, 38, '2026-01-16'),
(137, 'Material y recursos para actividades formativas', 36000.00, 38, '2026-03-01'),

(138, 'Montaje de escenarios para fiestas patronales', 128000.00, 39, '2026-01-31'),
(139, 'Actuaciones musicales y eventos festivos', 97000.00, 39, '2026-02-15'),
(140, 'Iluminación extraordinaria y decoración festiva', 86000.00, 39, '2026-03-12'),

(141, 'Actividades juveniles y talleres de empleo', 29000.00, 40, '2026-02-04'),

(142, 'Redacción de proyecto de reordenación urbana', 142000.00, 41, '2026-01-22'),
(143, 'Adecuación de espacios públicos y accesibilidad', 118000.00, 41, '2026-03-06'),

(144, 'Ayudas de urgencia social', 76000.00, 42, '2026-02-10'),
(145, 'Programa de atención a familias', 58000.00, 42, '2026-03-14'),

(146, 'Reparación de pistas e instalaciones deportivas', 64000.00, 43, '2026-02-19'),

(147, 'Programación cultural de primavera', 47000.00, 44, '2026-03-08'),

(148, 'Campaña de mejora de zonas verdes', 39000.00, 45, '2026-01-29'),

(149, 'Compra de materiales para brigada municipal', 184000.00, 46, '2026-02-23'),

(150, 'Campaña de promoción turística local', 21000.00, 47, '2026-03-10');