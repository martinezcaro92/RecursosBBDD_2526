-- CREACIÓN DE LA BASE DE DATOS
-- =========================

DROP DATABASE IF EXISTS hospitalDB;
CREATE DATABASE hospitalDB CHARACTER SET utf8mb4;
USE hospitalDB;

-- TABLA PACIENTES
CREATE TABLE pacientes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero VARCHAR(20) NOT NULL,
    direccion VARCHAR(255)
) ENGINE=InnoDB;

-- TABLA MEDICOS
CREATE TABLE medicos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    telefono VARCHAR(20)
) ENGINE=InnoDB;

-- TABLA CITAS
CREATE TABLE citas (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    paciente_id BIGINT NOT NULL,
    medico_id BIGINT NOT NULL,
    fecha TIMESTAMP NOT NULL,
    motivo VARCHAR(255),
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    FOREIGN KEY (medico_id) REFERENCES medicos(id)
) ENGINE=InnoDB;

-- TABLA MEDICAMENTOS
CREATE TABLE medicamentos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2)
) ENGINE=InnoDB;

-- TABLA HISTORIAL MEDICO
CREATE TABLE historial_medico (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    paciente_id BIGINT NOT NULL,
    descripcion TEXT NOT NULL,
    fecha TIMESTAMP NOT NULL,
    medicamento_id BIGINT,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    FOREIGN KEY (medicamento_id) REFERENCES medicamentos(id)
) ENGINE=InnoDB;

INSERT INTO pacientes (id, nombre, fecha_nacimiento, genero, direccion) VALUES
(1, 'Juan Pérez', '1980-05-15', 'Masculino', 'Calle Falsa 12'),
(2, 'María Gómez', '1990-08-22', 'Femenino', 'Avenida Siempre Viva 4'),
(3, 'Carlos Sánchez', '1975-12-30', 'Masculino', 'Calle Luna 7'),
(4, 'Ana Martínez', '1985-03-10', 'Femenino', 'Avenida Sol 9'),
(5, 'Luis Rodríguez', '1992-11-05', 'Masculino', 'Calle Estrella 3'),
(6, 'Sofía Fernández', '1988-07-19', 'Femenino', 'Avenida Nube 6'),
(7, 'Miguel Torres', '1970-01-25', 'Masculino', 'Calle Río 8'),
(8, 'Laura Ramírez', '1995-04-12', 'Femenino', 'Avenida Montaña 2'),
(9, 'Diego López', '1982-09-30', 'Masculino', 'Calle Mar 5'),
(10, 'Elena García', '1993-02-18', 'Femenino', 'Avenida Bosque 1'),
(11, 'Pedro Fernández', '1987-06-14', 'Masculino', 'Calle Sol 4'),
(12, 'Lucía Martínez', '1991-10-20', 'Femenino', 'Avenida Río 7'),
(13, 'Jorge Sánchez', '1978-04-05', 'Masculino', 'Calle Estrella 9'),
(14, 'Marta Gómez', '1983-11-28', 'Femenino', 'Avenida Luna 3'),
(15, 'Andrés Rodríguez', '1994-01-17', 'Masculino', 'Calle Nube 6'),
(16, 'Sofía Torres', '1986-09-12', 'Femenino', 'Avenida Mar 8'),
(17, 'Ricardo Ramírez', '1972-02-22', 'Masculino', 'Calle Bosque 2'),
(18, 'Isabel López', '1990-05-30', 'Femenino', 'Avenida Sol 5'),
(19, 'Fernando García', '1984-08-18', 'Masculino', 'Calle Río 4'),
(20, 'Carla Martínez', '1993-12-10', 'Femenino', 'Avenida Estrella 1'),
(21, 'Santiago Fernández', '1981-03-25', 'Masculino', 'Calle Luna 6'),
(22, 'Valentina Gómez', '1989-07-14', 'Femenino', 'Avenida Nube 3'),
(23, 'Diego Rodríguez', '1976-11-08', 'Masculino', 'Calle Mar 2'),
(24, 'Camila Sánchez', '1992-04-18', 'Femenino', 'Avenida Bosque 4'),
(25, 'Javier Torres', '1983-09-05', 'Masculino', 'Calle Sol 7'),
(26, 'Lucía Ramírez', '1990-12-22', 'Femenino', 'Avenida Río 9'),
(27, 'Andrés Martínez', '1979-01-30', 'Masculino', 'Calle Estrella 5'),
(28, 'Sofía Fernández', '1987-06-17', 'Femenino', 'Avenida Luna 8'),
(29, 'Ricardo Sánchez', '1982-10-10', 'Masculino', 'Calle Nube 4'),
(30, 'Isabel Rodríguez', '1991-03-15', 'Femenino', 'Avenida Mar 6');

INSERT INTO medicos (id, nombre, especialidad, telefono) VALUES
(1, 'Dr. Juan Pérez', 'Cardiología', '+34 666789987'),
(2, 'Dra. María Gómez', 'Pediatría', '+34 666789988'),
(3, 'Dr. Carlos Sánchez', 'Dermatología', '+34 666789989'),
(4, 'Dra. Ana Martínez', 'Ginecología', '+34 666789990'),
(5, 'Dr. Luis Rodríguez', 'Neurología', '+34 666789991'),
(6, 'Dra. Sofía Fernández', 'Oftalmología', '+34 666789992'),
(7, 'Dr. Miguel Torres', 'Ortopedia', '+34 666789993'),
(8, 'Dra. Laura Ramírez', 'Psiquiatría', '+34 666789994'),
(9, 'Dr. Diego López', 'Radiología', '+34 666789995'),
(10, 'Dra. Elena García', 'Oncología', '+34 666789996'),
(11, 'Dr. Pedro Fernández', 'Gastroenterología', '+34 666789997'),
(12, 'Dra. Lucía Martínez', 'Endocrinología', '+34 666789998'),
(13, 'Dr. Jorge Sánchez', 'Reumatología', '+34 666789999'),
(14, 'Dra. Marta Gómez', 'Hematología', '+34 666789000'),
(15, 'Dr. Andrés Rodríguez', 'Nefrología', '+34 666789001'),
(16, 'Dra. Sofía Torres', 'Traumatología', '+34 666789002'),
(17, 'Dr. Ricardo Ramírez', 'Urología', '+34 666789003'),
(18, 'Dra. Isabel López', 'Neumología', '+34 666789004'),
(19, 'Dr. Fernando García', 'Cirugía General', '+34 666789005'),
(20, 'Dra. Carla Martínez', 'Geriatría', '+34 666789006'),
(21, 'Dr. Santiago Fernández', 'Endocrinología', '+34 666789007'),
(22, 'Dra. Valentina Gómez', 'Pediatría', '+34 666789008'),
(23, 'Dr. Diego Rodríguez', 'Cardiología', '+34 666789009'),
(24, 'Dra. Camila Sánchez', 'Dermatología', '+34 666789010'),
(25, 'Dr. Javier Torres', 'Neurología', '+34 666789011'),
(26, 'Dra. Lucía Ramírez', 'Oftalmología', '+34 666789012'),
(27, 'Dr. Andrés Martínez', 'Ortopedia', '+34 666789013'),
(28, 'Dra. Sofía Fernández', 'Psiquiatría', '+34 666789014'),
(29, 'Dr. Ricardo Sánchez', 'Radiología', '+34 666789015'),
(30, 'Dra. Isabel Rodríguez', 'Oncología', '+34 666789016');

INSERT INTO citas (id, paciente_id, medico_id, fecha, motivo) VALUES
(1, 7, 1, '2024-07-01 10:00:00', 'Chequeo general'),
(2, 9, 2, '2024-07-02 11:30:00', 'Consulta pediátrica'),
(3, 12, 3, '2024-07-03 14:00:00', 'Revisión de piel'),
(4, 11, 4, '2024-07-04 09:00:00', 'Control ginecológico'),
(5, 26, 5, '2024-07-05 15:30:00', 'Dolor de cabeza'),
(6, 17, 6, '2024-07-06 13:00:00', 'Problemas de visión'),
(7, 21, 7, '2024-07-07 16:00:00', 'Dolor de espalda'),
(8, 22, 8, '2024-07-08 10:30:00', 'Consulta psiquiátrica'),
(9, 29, 9, '2024-07-09 12:00:00', 'Revisión radiológica'),
(10, 4, 10, '2024-07-10 14:30:00', 'Control oncológico'),
(11, 7, 11, '2024-07-11 09:30:00', 'Consulta gastroenterológica'),
(12, 23, 12, '2024-07-12 11:00:00', 'Revisión endocrinológica'),
(13, 18, 13, '2024-07-13 15:00:00', 'Consulta reumatológica'),
(14, 5, 14, '2024-07-14 10:00:00', 'Control hematológico'),
(15, 19, 15, '2024-07-15 13:30:00', 'Consulta nefrológica'),
(16, 20, 16, '2024-07-16 14:00:00', 'Revisión traumatológica'),
(17, 25, 17, '2024-07-17 09:00:00', 'Consulta urológica'),
(18, 18, 18, '2024-07-18 11:30:00', 'Control neumológico'),
(19, 14, 19, '2024-07-19 16:00:00', 'Consulta de cirugía general'),
(20, 15, 20, '2024-07-20 10:30:00', 'Revisión geriátrica'),
(21, 9, 21, '2024-07-21 09:00:00', 'Consulta endocrinológica'),
(22, 25, 22, '2024-07-22 11:30:00', 'Consulta pediátrica'),
(23, 17, 23, '2024-07-23 14:00:00', 'Chequeo cardiológico'),
(24, 29, 24, '2024-07-24 09:00:00', 'Revisión dermatológica'),
(25, 3, 25, '2024-07-25 15:30:00', 'Consulta neurológica');

INSERT INTO medicamentos (id, nombre, descripcion, precio) VALUES
(1, 'Paracetamol', 'Analgésico y antipirético', 5.99),
(2, 'Ibuprofeno', 'Antiinflamatorio no esteroideo', 7.49),
(3, 'Amoxicilina', 'Antibiótico de amplio espectro', 12.99),
(4, 'Loratadina', 'Antihistamínico para alergias', 8.99),
(5, 'Omeprazol', 'Inhibidor de la bomba de protones para acidez estomacal', 9.99),
(6, 'Metformina', 'Medicamento para la diabetes tipo 2', 15.99),
(7, 'Simvastatina', 'Medicamento para reducir el colesterol', 11.49),
(8, 'Alprazolam', 'Ansiolítico para trastornos de ansiedad', 14.99),
(9, 'Salbutamol', 'Broncodilatador para el asma', 10.99),
(10, 'Aspirina', 'Analgésico y antiinflamatorio', 6.49),
(11, 'Ciprofloxacino', 'Antibiótico para infecciones bacterianas', 13.99),
(12, 'Dexametasona', 'Corticosteroide para inflamación', 9.49),
(13, 'Furosemida', 'Diurético para edema y hipertensión', 7.99),
(14, 'Clonazepam', 'Ansiolítico para trastornos de ansiedad y convulsiones', 16.99),
(15, 'Losartán', 'Medicamento para la hipertensión arterial', 12.49),
(16, 'Ranitidina', 'Medicamento para la acidez estomacal y úlceras gástricas', 8.49),
(17, 'Metoprolol', 'Betabloqueante para la hipertensión y enfermedades cardíacas', 10.99),
(18, 'Prednisona', 'Corticosteroide para inflamación y alergias', 11.99),
(19, 'Warfarina', 'Anticoagulante para prevenir coágulos sanguíneos', 14.49),
(20, 'Levotiroxina', 'Hormona tiroidea para el hipotiroidismo', 13.49),
(21, 'Clindamicina', 'Antibiótico para infecciones bacterianas', 12.99),
(22, 'Duloxetina', 'Antidepresivo para trastornos de ansiedad y depresión', 15.99),
(23, 'Amlodipino', 'Medicamento para la hipertensión arterial y angina de pecho', 9.99),
(24, 'Risperidona', 'Antipsicótico para trastornos mentales como esquizofrenia y trastorno bipolar', 14.49),
(25, 'Metronidazol', 'Antibiótico para infecciones bacterianas y parasitarias', 11.99);

INSERT INTO historial_medico (id, paciente_id, descripcion, fecha, medicamento_id) VALUES
(1, 7, 'Paciente con hipertensión arterial controlada', '2024-06-01 10:00:00', 1),
(2, 9, 'Niño con alergias estacionales', '2024-06-02 11:30:00', 4),
(3, 12, 'Paciente con dermatitis atópica', '2024-06-03 14:00:00', 3),
(4, 11, 'Mujer con antecedentes de miomas uterinos', '2024-06-04 09:00:00', 5),
(5, 26, 'Paciente con migrañas frecuentes', '2024-06-05 15:30:00', 2),
(6, 17, 'Hombre con miopía y astigmatismo', '2024-06-06 13:00:00', 1),
(7, 21, 'Paciente con hernia discal lumbar', '2024-06-07 16:00:00', 1),
(8, 22, 'Mujer con trastorno de ansiedad generalizada', '2024-06-08 10:30:00', 8),
(9, 29, 'Paciente con fractura de clavícula derecha', '2024-06-09 12:00:00', 1),
(10, 4, 'Mujer con antecedentes de cáncer de mama', '2024-06-10 14:30:00', 5),
(11, 7, 'Paciente con gastritis crónica', '2024-06-11 09:30:00', 5),
(12, 23, 'Hombre con diabetes tipo 2', '2024-06-12 11:00:00', 6),
(13, 18, 'Mujer con artritis reumatoide', '2024-06-13 15:00:00', 7),
(14, 5, 'Paciente con anemia ferropénica', '2024-06-14 10:00:00', 9),
(15, 19, 'Hombre con insuficiencia renal crónica', '2024-06-15 13:30:00', 13),
(16, 20, 'Mujer con fractura de cadera derecha', '2024-06-16 14:00:00', 1),
(17, 25, 'Paciente con hiperplasia prostática benigna', '2024-06-17 09:00:00', 15),
(18, 18, 'Mujer con asma bronquial persistente', '2024-06-18 11:30:00', 9),
(19, 14, 'Hombre con antecedentes de apendicitis aguda', '2024-06-19 16:00:00', 3),
(20, 15, 'Mujer con osteoporosis postmenopáusica', '2024-06-20 10:30:00', 20);