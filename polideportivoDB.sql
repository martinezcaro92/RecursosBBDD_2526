DROP DATABASE IF EXISTS polideportivoDB;
CREATE DATABASE IF NOT EXISTS polideportivoDB CHARACTER SET utf8mb4;
USE polideportivoDB;

-- ─────────────────────────────────────────────
--  TABLAS
-- ─────────────────────────────────────────────

CREATE TABLE instalaciones (
  id          BIGINT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(255),
  tipo        VARCHAR(50),
  aforo_max   INT,
  precio_hora DECIMAL(10, 2),
  CONSTRAINT chk_tipo CHECK (tipo IN ('piscina', 'pista', 'sala'))
);

CREATE TABLE socios (
  id             BIGINT AUTO_INCREMENT PRIMARY KEY,
  dni            VARCHAR(20) UNIQUE,
  nombre         VARCHAR(100),
  apellido1      VARCHAR(100),
  apellido2      VARCHAR(100),
  fecha_alta     DATE,
  cuota_mensual  DECIMAL(10, 2),
  saldo          DECIMAL(10, 2),
  activo         BOOLEAN
);

CREATE TABLE monitores (
  id           BIGINT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(100),
  apellido1    VARCHAR(100),
  especialidad VARCHAR(100),
  salario      DECIMAL(10, 2)
);

CREATE TABLE actividades (
  id            BIGINT AUTO_INCREMENT PRIMARY KEY,
  nombre        VARCHAR(255),
  id_monitor    BIGINT,
  id_instalacion BIGINT,
  dia_semana    VARCHAR(20),
  hora_inicio   TIME,
  plazas_max    INT,
  precio        DECIMAL(10, 2),
  FOREIGN KEY (id_monitor)    REFERENCES monitores    (id),
  FOREIGN KEY (id_instalacion) REFERENCES instalaciones (id)
);

CREATE TABLE inscripciones (
  id               BIGINT AUTO_INCREMENT PRIMARY KEY,
  id_socio         BIGINT,
  id_actividad     BIGINT,
  fecha_inscripcion DATE,
  FOREIGN KEY (id_socio)     REFERENCES socios     (id),
  FOREIGN KEY (id_actividad) REFERENCES actividades (id)
);

CREATE TABLE reservas (
  id             BIGINT AUTO_INCREMENT PRIMARY KEY,
  id_socio       BIGINT,
  id_instalacion BIGINT,
  fecha          DATE,
  hora_inicio    TIME,
  hora_fin       TIME,
  importe        DECIMAL(10, 2),
  FOREIGN KEY (id_socio)       REFERENCES socios       (id),
  FOREIGN KEY (id_instalacion) REFERENCES instalaciones (id)
);

-- ─────────────────────────────────────────────
--  DATOS DE EJEMPLO
-- ─────────────────────────────────────────────

-- instalaciones (11 filas)
-- Tipos válidos: 'piscina', 'pista', 'sala'
INSERT INTO instalaciones (nombre, tipo, aforo_max, precio_hora) VALUES
  ('Piscina Olímpica',     'piscina', 150,  80.00),   -- id = 1
  ('Piscina Infantil',     'piscina',  50,  40.00),   -- id = 2
  ('Pista de Tenis 1',     'pista',     4,  15.00),   -- id = 3
  ('Pista de Tenis 2',     'pista',     4,  15.00),   -- id = 4
  ('Pista de Pádel 1',     'pista',     4,  12.00),   -- id = 5
  ('Pista de Pádel 2',     'pista',     4,  12.00),   -- id = 6
  ('Sala Fitness',         'sala',     30,  25.00),   -- id = 7
  ('Sala Yoga',            'sala',     20,  20.00),   -- id = 8
  ('Sala Spinning',        'sala',     25,  22.00),   -- id = 9
  ('Pista Polideportiva',  'pista',    20,  30.00),   -- id = 10
  ('Piscina Exterior',     'piscina', 100,  60.00);   -- id = 11

-- monitores (10 filas)
INSERT INTO monitores (nombre, apellido1, especialidad, salario) VALUES
  ('Carlos',  'García',   'Natación',     1800.00),   -- id = 1  → imparte 3 actividades
  ('Laura',   'Martínez', 'Yoga',         1600.00),   -- id = 2  → imparte 2 actividades
  ('Javier',  'López',    'Spinning',     1700.00),   -- id = 3  → imparte 2 actividades
  ('María',   'Sánchez',  'Fitness',      1750.00),   -- id = 4
  ('Pedro',   'Fernández','Tenis',        1650.00),   -- id = 5
  ('Ana',     'Torres',   'Pilates',      1600.00),   -- id = 6
  ('Luis',    'Ramírez',  'Pádel',        1680.00),   -- id = 7
  ('Elena',   'Moreno',   'Aquafit',      1720.00),   -- id = 8
  ('David',   'Ruiz',     'Musculación',  1780.00),   -- id = 9
  ('Sofía',   'Navarro',  'Zumba',        1620.00);   -- id = 10

-- socios (12 filas)
-- Socios con fecha_alta < 2020-01-01: ids 1, 2, 3, 7, 9, 12  (afectados por Ejercicio 4)
INSERT INTO socios (dni, nombre, apellido1, apellido2, fecha_alta, cuota_mensual, saldo, activo) VALUES
  ('12345678A', 'Manuel',   'Rodríguez', 'García',   '2018-03-15', 35.00, 200.00, True),  -- id = 1
  ('23456789B', 'Isabel',   'Gómez',     'López',    '2019-07-20', 35.00, 150.00, False),  -- id = 2
  ('34567890C', 'Fernando', 'Díaz',      'Martínez', '2017-11-08', 30.00, 300.00, True),  -- id = 3
  ('45678901D', 'Lucía',    'Pérez',     'Sánchez',  '2021-02-14', 40.00, 100.00, True),  -- id = 4
  ('56789012E', 'Raúl',     'Jiménez',   'Torres',   '2020-09-01', 38.00, 250.00, True),  -- id = 5
  ('67890123F', 'Carmen',   'Morales',   'Ruiz',     '2022-05-23', 42.00, 180.00, False),  -- id = 6
  ('78901234G', 'Tomás',    'Herrera',   'Navarro',  '2019-12-31', 35.00, 120.00, True),  -- id = 7
  ('89012345H', 'Patricia', 'Vega',      'López',    '2023-01-10', 45.00, 400.00, False),  -- id = 8
  ('90123456I', 'Alberto',  'Cano',      'García',   '2018-08-05', 33.00,  80.00, True),  -- id = 9
  ('01234567J', 'Nuria',    'Iglesias',  'Martínez', '2024-03-20', 47.00, 350.00, True),  -- id = 10
  ('11223344K', 'Rodrigo',  'Fuentes',   'Díaz',     '2021-07-15', 40.00, 220.00, True),  -- id = 11
  ('22334455L', 'Amelia',   'Castro',    'Pérez',    '2016-04-02', 30.00,  90.00, True);  -- id = 12

-- actividades (13 filas)
-- Monitor 1 imparte las actividades 1, 2 y 13  → cumple la condición del Ejercicio 5 (>2)
-- Monitor 3 imparte las actividades 6 y 7       → usado en Ejercicio 9
INSERT INTO actividades (nombre, id_monitor, id_instalacion, dia_semana, hora_inicio, plazas_max, precio) VALUES
  ('Natación Adultos',    1, 1,  'lunes',     '09:00:00', 20, 15.00),  -- id = 1
  ('Natación Infantil',   1, 2,  'martes',    '10:00:00', 15, 12.00),  -- id = 2
  ('Aquafit',             8, 1,  'miércoles', '11:00:00', 20, 14.00),  -- id = 3
  ('Yoga Mañana',         2, 8,  'lunes',     '09:30:00', 15, 10.00),  -- id = 4
  ('Yoga Tarde',          2, 8,  'jueves',    '18:00:00', 15, 10.00),  -- id = 5
  ('Spinning',            3, 9,  'martes',    '07:00:00', 20,  8.00),  -- id = 6
  ('Spinning Intenso',    3, 9,  'jueves',    '07:00:00', 20,  9.00),  -- id = 7
  ('Fitness Funcional',   4, 7,  'miércoles', '10:00:00', 25, 12.00),  -- id = 8
  ('Pilates',             6, 8,  'viernes',   '10:00:00', 12, 11.00),  -- id = 9
  ('Zumba',              10, 7,  'sábado',    '11:00:00', 25,  9.00),  -- id = 10
  ('Tenis Iniciación',    5, 3,  'martes',    '16:00:00',  4, 20.00),  -- id = 11
  ('Pádel Avanzado',      7, 5,  'jueves',    '19:00:00',  4, 18.00),  -- id = 12
  ('Natación Velocidad',  1, 11, 'viernes',   '08:00:00', 10, 16.00);  -- id = 13

-- inscripciones (16 filas)
-- Inscripciones en 2025 (usadas en Ejercicio 3 como "activas"): ids 11–16
--   Socios con inscripciones en 2025: 1, 3, 5, 10, 11, 12
-- Actividad 6 tiene 2 inscritos (ids 4 y 9)   → usada en Ejercicio 8
-- Actividad 7 tiene 2 inscritos (ids 10 y 16) → usada en Ejercicio 9
INSERT INTO inscripciones (id_socio, id_actividad, fecha_inscripcion) VALUES
  ( 1,  1, '2024-09-01'),   -- id = 1
  ( 2,  1, '2024-09-02'),   -- id = 2
  ( 3,  4, '2024-09-01'),   -- id = 3
  ( 4,  6, '2024-09-05'),   -- id = 4  ← actividad Spinning
  ( 5,  2, '2024-09-10'),   -- id = 5
  ( 6,  8, '2024-10-01'),   -- id = 6
  ( 7,  1, '2024-09-15'),   -- id = 7
  ( 8,  4, '2024-10-10'),   -- id = 8
  ( 9,  6, '2024-09-20'),   -- id = 9  ← actividad Spinning
  ( 2,  7, '2024-10-05'),   -- id = 10 ← actividad Spinning Intenso
  (10, 10, '2025-01-15'),   -- id = 11 ← 2025
  (11,  3, '2025-02-01'),   -- id = 12 ← 2025
  (12,  8, '2025-03-10'),   -- id = 13 ← 2025
  ( 1, 13, '2025-01-20'),   -- id = 14 ← 2025
  ( 3,  5, '2025-02-15'),   -- id = 15 ← 2025
  ( 5,  7, '2025-03-01');   -- id = 16 ← 2025, actividad Spinning Intenso

-- reservas (14 filas)
-- Reservas de instalaciones piscina (ids 1, 2, 11): filas 1, 2, 5, 7, 10, 12, 14
INSERT INTO reservas (id_socio, id_instalacion, fecha, hora_inicio, hora_fin, importe) VALUES
  ( 1,  1, '2025-01-10', '10:00:00', '11:00:00', 80.00),  -- id = 1  piscina
  ( 2,  1, '2025-01-15', '11:00:00', '12:00:00', 80.00),  -- id = 2  piscina
  ( 3,  3, '2025-01-20', '16:00:00', '17:00:00', 15.00),  -- id = 3  pista
  ( 4,  7, '2025-02-01', '09:00:00', '10:00:00', 25.00),  -- id = 4  sala
  ( 5,  2, '2025-02-10', '10:00:00', '11:00:00', 40.00),  -- id = 5  piscina
  ( 6,  5, '2025-02-15', '18:00:00', '19:00:00', 12.00),  -- id = 6  pista
  ( 7,  1, '2025-03-01', '09:00:00', '10:00:00', 80.00),  -- id = 7  piscina
  ( 8,  8, '2025-03-05', '10:00:00', '11:00:00', 20.00),  -- id = 8  sala
  ( 9,  4, '2025-03-10', '17:00:00', '18:00:00', 15.00),  -- id = 9  pista
  (10, 11, '2025-03-15', '11:00:00', '12:00:00', 60.00),  -- id = 10 piscina
  (11,  9, '2025-04-01', '07:00:00', '08:00:00', 22.00),  -- id = 11 sala
  (12,  1, '2025-04-10', '10:00:00', '11:00:00', 80.00),  -- id = 12 piscina
  ( 1,  6, '2025-04-15', '19:00:00', '20:00:00', 12.00),  -- id = 13 pista
  ( 3,  2, '2025-04-20', '09:00:00', '10:00:00', 40.00);  -- id = 14 piscina

