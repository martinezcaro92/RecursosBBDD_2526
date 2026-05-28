-- ═══════════════════════════════════════════════════════════════════
--  POLIDEPORTIVO — EJERCICIOS DE MANIPULACIÓN DE DATOS (DML)
--  Base de datos: polideportivoDB
--  Requiere ejecutar primero: polideportivoDB.sql
-- ═══════════════════════════════════════════════════════════════════
USE polideportivoDB;

-- ───────────────────────────────────────────────────────────────────
--  EJERCICIO 1 — INSERT parcial
-- ───────────────────────────────────────────────────────────────────
--   Inserta un nuevo socio con todos sus campos usando los datos siguientes:
--     DNI: '98765432Z'  |  nombre: 'Marta'  |  apellido1: 'Delgado'
--     apellido2: 'Prieto'  |  fecha_alta: '2025-05-01'
--     cuota_mensual: 38.50  |  saldo: 100.00
-- ───────────────────────────────────────────────────────────────────
-- ── SOLUCIÓN ──────────────────────────────────────────────────────

INSERT INTO socios (dni, nombre, apellido1, apellido2, fecha_alta, cuota_mensual, saldo)
VALUES ('98765432Z', 'Marta', 'Delgado', 'Prieto', '2025-05-01', 38.50, 100.00);


-- Justificación: la columna precio_hora está definida como DECIMAL(10,2) sin la
-- restricción NOT NULL ni un DEFAULT. Al no existir ninguna obligación de valor,
-- MySQL acepta la fila y almacena NULL en precio_hora.
-- Si el campo tuviese NOT NULL sin DEFAULT, la sentencia fallaría con error 1364.

SELECT * FROM socios       WHERE dni = '98765432Z';

-- ───────────────────────────────────────────────────────────────────
--  EJERCICIO 2 — INSERT parcial
-- ───────────────────────────────────────────────────────────────────
--   Inserta una nueva instalación omitiendo ÚNICAMENTE el campo precio_hora,
--   con los valores: nombre = 'Pabellón Municipal', tipo = 'sala', aforo_max = 500.
--
--   Antes de ejecutar la sentencia, analiza la definición de la tabla instalaciones
--   y responde:
--     ¿Permite la estructura de la tabla insertar una fila sin precio_hora?
--     Justifica tu respuesta indicando qué restricción (o la ausencia de ella)
--     lo determina y qué valor quedará almacenado en ese campo.
-- ───────────────────────────────────────────────────────────────────
-- ── SOLUCIÓN ──────────────────────────────────────────────────────


INSERT INTO instalaciones (nombre, tipo, aforo_max)
VALUES ('Pabellón Municipal', 'sala', 500);

-- Justificación: la columna precio_hora está definida como DECIMAL(10,2) sin la
-- restricción NOT NULL ni un DEFAULT. Al no existir ninguna obligación de valor,
-- MySQL acepta la fila y almacena NULL en precio_hora.
-- Si el campo tuviese NOT NULL sin DEFAULT, la sentencia fallaría con error 1364.

SELECT * FROM instalaciones WHERE nombre = 'Pabellón Municipal';

-- ───────────────────────────────────────────────────────────────────
--  EJERCICIO 3 — INSERT múltiple
-- ───────────────────────────────────────────────────────────────────
-- Inserta las tres actividades siguientes en UNA ÚNICA sentencia INSERT:
--
--   1. Nombre: 'Musculación Avanzada'
--      Monitor: 9 (David Ruiz)   |  Instalación: 7 (Sala Fitness)
--      Día: 'lunes'              |  Hora inicio: '19:00:00'
--      Plazas máx.: 15           |  Precio: 14.00
--
--   2. Nombre: 'Pilates Avanzado'
--      Monitor: 6 (Ana Torres)   |  Instalación: 8 (Sala Yoga)
--      Día: 'miércoles'          |  Hora inicio: '19:30:00'
--      Plazas máx.: 10           |  Precio: 13.00
--
--   3. Nombre: 'Pádel Iniciación'
--      Monitor: 7 (Luis Ramírez) |  Instalación: 6 (Pista de Pádel 2)
--      Día: 'sábado'             |  Hora inicio: '10:00:00'
--      Plazas máx.: 4            |  Precio: 16.00
--
-- Comprueba el resultado con un SELECT sobre la tabla actividades.
-- ───────────────────────────────────────────────────────────────────
-- ── SOLUCIÓN ──────────────────────────────────────────────────────

INSERT INTO actividades (nombre, id_monitor, id_instalacion, dia_semana, hora_inicio, plazas_max, precio)
VALUES
  ('Musculación Avanzada', 9, 7, 'lunes',     '19:00:00', 15, 14.00),
  ('Pilates Avanzado',     6, 8, 'miércoles', '19:30:00', 10, 13.00),
  ('Pádel Iniciación',     7, 6, 'sábado',    '10:00:00',  4, 16.00);

SELECT * FROM actividades ORDER BY id;


-- ───────────────────────────────────────────────────────────────────
--  EJERCICIO 4 — INSERT con SELECT
-- ───────────────────────────────────────────────────────────────────
-- Se considera que un socio tiene una "inscripción activa" si tiene al menos
-- una fila en la tabla inscripciones con fecha_inscripcion en el año 2025.
--
-- Realiza los siguientes pasos:
--
--   1. Crea una tabla llamada socios_activos con exactamente la misma estructura
--      que socios (columnas, tipos y restricciones)
--
--   2. Inserta en socios_activos, con una única sentencia INSERT ... SELECT,
--      todos los socios que cumplan la condición de inscripción activa definida
--      arriba. No inserts manuales: la sentencia SELECT debe filtrar los socios
--      directamente.
--
--   3. Comprueba el resultado: ¿cuántos socios contiene socios_activos?
--      ¿Qué socios son? Verifica que sus ids coinciden con los esperados.
--
-- Nota: la tabla socios_activos hereda las restricciones de socios (UNIQUE en dni,
-- AUTO_INCREMENT en id). Si repitieses la operación sin DROP previo obtendríás
-- error de clave duplicada, ya que los ids ya existirían.
-- ───────────────────────────────────────────────────────────────────

-- ── SOLUCIÓN ──────────────────────────────────────────────────────

-- 1. Crear tabla con la misma estructura
CREATE TABLE socios_activos (
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

-- 2. Insertar socios con al menos una inscripción en 2025
INSERT INTO socios_activos
SELECT id, dni, nombre, apellido1, apellido2, fecha_alta, cuota_mensual, saldo
FROM   socios 
WHERE  activo = True;
-- WHERE activo = 1;

-- 3. Verificar (resultado esperado: 6 socios, ids 1, 3, 5, 10, 11, 12)
SELECT * FROM socios_activos ORDER BY id;


-- ───────────────────────────────────────────────────────────────────
--  EJERCICIO 5 — UPDATE con condición
-- ───────────────────────────────────────────────────────────────────
-- La dirección del polideportivo decide aplicar un incremento del 5 %
-- en la cuota_mensual de los socios más antiguos: aquellos cuya fecha_alta
-- sea estrictamente anterior al 1 de enero de 2020.
--
-- Realiza los siguientes pasos:
--   1. Antes del UPDATE, muestra los socios que se van a ver afectados
--      indicando su id, nombre, apellido1, fecha_alta y cuota_mensual actual.
--   2. Ejecuta el UPDATE correspondiente.
--   3. Vuelve a consultar esos mismos socios y verifica que la cuota ha
--      aumentado correctamente.
--
-- Preguntas:
--   a) ¿Cuántos socios quedan afectados?
--   b) ¿Cuál es la nueva cuota de cada uno? Calcula el resultado esperado
--      antes de ejecutar el SELECT de verificación.
-- ───────────────────────────────────────────────────────────────────

-- ── SOLUCIÓN ──────────────────────────────────────────────────────

-- 1. Socios afectados (ids 1, 2, 3, 7, 9, 12 → 6 socios)
SELECT id, nombre, apellido1, fecha_alta, cuota_mensual AS cuota_antes
FROM   socios
WHERE  fecha_alta < '2020-01-01'
ORDER  BY fecha_alta;

-- 2. UPDATE
UPDATE socios
SET    cuota_mensual = cuota_mensual * 1.05
WHERE  fecha_alta < '2020-01-01';

-- 3. Verificación
-- Nuevas cuotas esperadas:
--   id=3  (Fernando, 30.00) → 31.50
--   id=12 (Amelia,   30.00) → 31.50
--   id=9  (Alberto,  33.00) → 34.65
--   id=1  (Manuel,   35.00) → 36.75
--   id=2  (Isabel,   35.00) → 36.75
--   id=7  (Tomás,    35.00) → 36.75
SELECT id, nombre, apellido1, fecha_alta, cuota_mensual AS cuota_despues
FROM   socios
WHERE  fecha_alta < '2020-01-01'
ORDER  BY fecha_alta;


-- ───────────────────────────────────────────────────────────────────
--  EJERCICIO 6 — UPDATE multitabla
-- ───────────────────────────────────────────────────────────────────
-- Por el inicio de la temporada de verano, se aplica un incremento del 10 %
-- al importe de todas las reservas de instalaciones de tipo 'piscina'.
--
-- Realiza los siguientes pasos:
--   1. Muestra las reservas que se van a modificar indicando el id de reserva,
--      el nombre de la instalación, el tipo y el importe actual.
--   2. Ejecuta el UPDATE usando la sintaxis multitabla de MySQL
--      (UPDATE … JOIN … SET …), que combina reservas e instalaciones.
--   3. Vuelve a consultar las mismas reservas y comprueba los nuevos importes.
--
-- Preguntas:
--   a) ¿Cuántas reservas se ven afectadas?
--   b) ¿Cuáles son los nuevos importes para cada tipo de piscina?
-- ───────────────────────────────────────────────────────────────────

-- ── SOLUCIÓN ──────────────────────────────────────────────────────

-- 1. Reservas de piscina antes del UPDATE (7 reservas)
SELECT r.id, i.nombre, i.tipo, r.importe AS importe_antes
FROM   reservas      r
JOIN   instalaciones i ON r.id_instalacion = i.id
WHERE  i.tipo = 'piscina'
ORDER  BY r.id;

-- 2. UPDATE multitabla
UPDATE reservas      r
  JOIN instalaciones i ON r.id_instalacion = i.id
SET    r.importe = r.importe * 1.10
WHERE  i.tipo = 'piscina';

-- 3. Verificación
-- Nuevos importes esperados:
--   Piscina Olímpica  (precio_hora 80.00): reservas ids 1, 2, 7, 12 → 88.00
--   Piscina Infantil  (precio_hora 40.00): reservas ids 5, 14        → 44.00
--   Piscina Exterior  (precio_hora 60.00): reserva  id  10           → 66.00
SELECT r.id, i.nombre, i.tipo, r.importe AS importe_despues
FROM   reservas      r
JOIN   instalaciones i ON r.id_instalacion = i.id
WHERE  i.tipo = 'piscina'
ORDER  BY r.id;


-- ───────────────────────────────────────────────────────────────────
--  EJERCICIO 7 — DELETE con integridad referencial
-- ───────────────────────────────────────────────────────────────────
-- El monitor con id = 1 (Carlos García) causa baja en el polideportivo.
--
--   Intenta ejecutar: DELETE FROM monitores WHERE id = 1;
--   ¿Qué error obtienes? ¿Qué tabla y qué clave foránea lo impiden?
--   Consulta las actividades de Carlos García para entender el motivo.
--
-- ───────────────────────────────────────────────────────────────────
-- ── SOLUCIÓN ──────────────────────────────────────────────────────

-- DELETE FROM monitores WHERE id = 1;
-- ERROR 1451 (23000): Cannot delete or update a parent row:
--   a foreign key constraint fails (`polideportivodb`.`actividades`,
--   CONSTRAINT `actividades_ibfk_1` FOREIGN KEY (`id_monitor`)
--   REFERENCES `monitores` (`id`))
-- Causa: los ids 1, 2 y 13 de actividades referencian al monitor 1.

-- ───────────────────────────────────────────────────────────────────
--  EJERCICIO 8 — DELETE con integridad referencial
-- ───────────────────────────────────────────────────────────────────
-- Parte B — Solucionar el problema:
--   Se decide que al dar de baja a un monitor, las actividades que impartía
--   deben conservarse en la base de datos pero quedar sin monitor asignado
--   (campo id_monitor = NULL).
--   Para conseguirlo:
--     1. Obtén el nombre exacto de la clave foránea actual ejecutando:
--           SHOW CREATE TABLE actividades;
--        Localiza la línea que empieza por CONSTRAINT … FOREIGN KEY (id_monitor)
--        y anota el nombre del constraint (suele ser actividades_ibfk_1).
--     2. Elimina esa clave foránea.
--     3. Añade una nueva clave foránea sobre id_monitor que aplique ON DELETE SET NULL.
--     4. Elimina el monitor con id = 2.
--     5. Verifica que las actividades 4 y 5 siguen existiendo con id_monitor = NULL.
-- ───────────────────────────────────────────────────────────────────

-- ── SOLUCIÓN ──────────────────────────────────────────────────────

-- Parte A: intento fallido
-- DELETE FROM monitores WHERE id = 1;
-- ERROR 1451 (23000): Cannot delete or update a parent row:
--   a foreign key constraint fails (`polideportivodb`.`actividades`,
--   CONSTRAINT `actividades_ibfk_1` FOREIGN KEY (`id_monitor`)
--   REFERENCES `monitores` (`id`))
-- Causa: los ids 1, 2 y 13 de actividades referencian al monitor 1.

-- Parte B: solución

-- B.1 Consultar el nombre de la FK
SHOW CREATE TABLE actividades;

-- B.2 Eliminar la FK (sustituye el nombre [actividades_ibfk_1] si difiere en tu instalación)
ALTER TABLE actividades DROP FOREIGN KEY actividades_ibfk_1;

-- B.3 Nueva FK con ON DELETE SET NULL
ALTER TABLE actividades
  ADD CONSTRAINT fk_actividades_monitor
  FOREIGN KEY (id_monitor) REFERENCES monitores(id)
  ON DELETE SET NULL;

-- B.4 Eliminar el monitor
DELETE FROM monitores WHERE id = 2;

-- B.5 Verificación: las actividades 4 y 5 persisten con id_monitor = NULL
SELECT id, nombre, id_monitor
FROM   actividades
WHERE  id IN (4, 5);


-- ───────────────────────────────────────────────────────────────────
--  EJERCICIO 9 — Transacción básica con procedimiento almacenado
-- ───────────────────────────────────────────────────────────────────
-- Crea un procedimiento almacenado llamado registrar_inscripcion que gestione
-- la inscripción de un socio en una actividad de forma transaccional.
--
-- Parámetros de entrada: p_id_socio BIGINT, p_id_actividad BIGINT.
--
-- El procedimiento debe:
--   1. Obtener plazas_max y precio de la actividad indicada.
--   2. Contar las inscripciones existentes para esa actividad.
--   3. Obtener el saldo actual del socio.
--   4. Si el número de inscritos >= plazas_max:
--        → ROLLBACK  y devolver el mensaje 'ERROR: No quedan plazas disponibles'
--   5. Si el saldo del socio < precio de la actividad:
--        → ROLLBACK  y devolver el mensaje 'ERROR: Saldo insuficiente'
--   6. Si ninguna condición de error se cumple:
--        → INSERT en inscripciones con la fecha actual (CURDATE())
--        → UPDATE socios: restar el precio al saldo
--        → COMMIT  y devolver 'OK: Inscripción registrada correctamente'
--
-- Una vez creado el procedimiento, pruébalo con los dos casos siguientes:
--
--   Caso A — inscripción correcta:
--     CALL registrar_inscripcion(8, 6);
--     (Patricia Vega, saldo = 400.00 € — Spinning, precio = 8.00 €, 2/20 plazas)
--     Resultado esperado: COMMIT. Nuevo saldo de Patricia = 392.00 €.
--
--   Caso B — saldo insuficiente:
--     Primero reduce el saldo del socio 9 (Alberto Cano) a 5.00 €:
--       UPDATE socios SET saldo = 5.00 WHERE id = 9;
--     Luego: CALL registrar_inscripcion(9, 13);
--     (Alberto Cano, saldo = 5.00 € — Natación Velocidad, precio = 16.00 €)
--     Resultado esperado: ROLLBACK. El saldo y las inscripciones no cambian.
--
-- Verifica ambos casos consultando la tabla socios y la tabla inscripciones.
-- ───────────────────────────────────────────────────────────────────
-- ── SOLUCIÓN ──────────────────────────────────────────────────────

DELIMITER //
CREATE PROCEDURE registrar_inscripcion(
    IN p_id_socio     BIGINT,
    IN p_id_actividad BIGINT
)
BEGIN
    DECLARE v_plazas_max INT;
    DECLARE v_precio     DECIMAL(10, 2);
    DECLARE v_inscritos  INT;
    DECLARE v_saldo      DECIMAL(10, 2);

    START TRANSACTION;

    SELECT plazas_max, precio
    INTO   v_plazas_max, v_precio
    FROM   actividades
    WHERE  id = p_id_actividad;

    SELECT COUNT(*) INTO v_inscritos
    FROM   inscripciones
    WHERE  id_actividad = p_id_actividad;

    SELECT saldo INTO v_saldo
    FROM   socios
    WHERE  id = p_id_socio;

    IF v_inscritos >= v_plazas_max THEN
        ROLLBACK;
        SELECT 'ERROR: No quedan plazas disponibles' AS resultado;
    ELSEIF v_saldo < v_precio THEN
        ROLLBACK;
        SELECT 'ERROR: Saldo insuficiente' AS resultado;
    ELSE
        INSERT INTO inscripciones (id_socio, id_actividad, fecha_inscripcion)
        VALUES (p_id_socio, p_id_actividad, CURDATE());

        UPDATE socios
        SET    saldo = saldo - v_precio
        WHERE  id = p_id_socio;

        COMMIT;
        SELECT 'OK: Inscripción registrada correctamente' AS resultado;
    END IF;
END //
DELIMITER ;

-- ───────────────────────────────────────────────────────────────────
--  EJERCICIO 10 — Transacción básica con procedimiento almacenado
-- ───────────────────────────────────────────────────────────────────
--
-- Una vez creado el procedimiento, pruébalo con los dos casos siguientes:
--
--     Verificar el saldo del socio antes de registrara la inscripción (esperado: 400.00 €).
--     CALL registrar_inscripcion(8, 6);
--     (Patricia Vega, saldo = 400.00 € — Spinning, precio = 8.00 €, 2/20 plazas)
--     Resultado esperado: COMMIT. Nuevo saldo de Patricia = 392.00 €.
--
-- Verifica ambos casos consultando la tabla socios y la tabla inscripciones.
-- ───────────────────────────────────────────────────────────────────
-- ── SOLUCIÓN ──────────────────────────────────────────────────────

SELECT id, nombre, saldo FROM socios WHERE id = 8;
-- Llamada a procedimiento almacenado
CALL registrar_inscripcion(8, 6);
-- Verificar saldo actualizado (esperado: 392.00)
SELECT id, nombre, saldo FROM socios WHERE id = 8;
-- Verificar inscripción creada
SELECT * FROM inscripciones WHERE id_socio = 8 AND id_actividad = 6;

-- ───────────────────────────────────────────────────────────────────
--  EJERCICIO 11 — Transacción básica con procedimiento almacenado
-- ───────────────────────────────────────────────────────────────────
--
-- Una vez creado el procedimiento, pruébalo con los dos casos siguientes:
--
--     Primero reduce el saldo del socio 9 (Alberto Cano) a 5.00 €:
--       UPDATE socios SET saldo = 5.00 WHERE id = 9;
--     Luego: CALL registrar_inscripcion(9, 13);
--     (Alberto Cano, saldo = 5.00 € — Natación Velocidad, precio = 16.00 €)
--     Resultado esperado: ROLLBACK. El saldo y las inscripciones no cambian.
--
-- Verifica ambos casos consultando la tabla socios y la tabla inscripciones.
-- ───────────────────────────────────────────────────────────────────
-- ── SOLUCIÓN ──────────────────────────────────────────────────────

UPDATE socios SET saldo = 5.00 WHERE id = 9;
SELECT id, nombre, saldo FROM socios WHERE id = 9;
CALL registrar_inscripcion(9, 13);
-- Verificar que el saldo no ha cambiado (esperado: 5.00)
SELECT id, nombre, saldo FROM socios WHERE id = 9;
-- Verificar que no se ha creado la inscripción (resultado vacío)
SELECT * FROM inscripciones WHERE id_socio = 9 AND id_actividad = 13;


-- ───────────────────────────────────────────────────────────────────
--  EJERCICIO 12 — Procedimiento almacenado con parámetros INOUT
-- ───────────────────────────────────────────────────────────────────
-- Crea un procedimiento llamado monitor_ajustarSalario que reciba como parámetro de entrada el id del monitor (pIdMonitor INT), como parámetro de entrada una cantidad (pCantidad DECIMAL(8,2)), y como parámetro de entrada/salida (pEspecialidad VARCHAR(50)) que inicialmente contiene la especialidad que se desea verificar antes de modificar el salario.
-- El procedimiento debe comportarse así:
--   - Si el monitor no existe debe mostrar dos columnas y salir de la ejecución con un ROLLBACK:
--       * code: -1
--       * msg: 'Monitor no encontrado'
--   - Si la especialidad recibida en pEspecialidad no coincide con la especialidad del monitor encontrado debe mostrar dos columnas y salir de la ejecución con un ROLLBACK:
--       * code: -2
--       * msg: 'La especialidad indicada no coincide con la del monitor'
--   - Si la especialidad coincide debe aplicar la cantidad sobre el salario del monitor. Si pCantidad es positiva se suma al salario. Si pCantidad es negativa se resta, pero si el resultado (nuevo salario) fuera inferior a 900 debe mostrar dos columnas y salir de la ejecución con un ROLLBACK:
--       * code: -3
--       * msg: 'El salario no puede ser inferior al mínimo (900)'
--   - Si todo es correcto debe actualizar el salario y devolver en pEspecialidad el nuevo salario del monitor expresado como cadena de texto con el formato 'Nuevo salario: <Valor>'. Finalizará la ejecución del procedimiento realizando un COMMIT.

-- 
-- ───────────────────────────────────────────────────────────────────
-- ── SOLUCIÓN ──────────────────────────────────────────────────────

DELIMITER $$

CREATE PROCEDURE monitor_ajustarSalario(
    IN    pIdMonitor   INT,
    IN    pCantidad    DECIMAL(8,2),
    INOUT pEspecialidad VARCHAR(50)
)
BEGIN
    -- Variables locales
    DECLARE vEspecialidadReal VARCHAR(50);
    DECLARE vSalarioActual    DECIMAL(8,2);
    DECLARE vSalarioNuevo     DECIMAL(8,2);


    -- ── Validación 1: el monitor debe existir ─────────────────────────────
    SELECT especialidad,
           salario
    INTO   vEspecialidadReal,
           vSalarioActual
    FROM   monitores
    WHERE  id = pIdMonitor
    LIMIT  1;

    IF vEspecialidadReal IS NULL THEN
        SELECT -1 AS code,
               'Monitor no encontrado' AS msg;
        ROLLBACK;
    END IF;

    -- ── Validación 2: la especialidad debe coincidir ───────────────────────
    IF pEspecialidad <> vEspecialidadReal THEN
        SELECT -2 AS code,
               'La especialidad indicada no coincide con la del monitor' AS msg;
        ROLLBACK;
    END IF;

    -- ── Lógica de ajuste de salario ───────────────────────────────────────
    SET vSalarioNuevo = vSalarioActual + pCantidad;

    IF vSalarioNuevo > 900 THEN
        UPDATE monitores
        SET    salario = vSalarioNuevo
        WHERE  id = pIdMonitor;
    ELSE
        -- Cantidad cero: no se modifica nada, se devuelve el salario actual
        SET vSalarioNuevo = vSalarioActual;
        ROLLBACK;
    END IF;

    -- ── Devolver resultado en el parámetro INOUT ──────────────────────────
    SET pEspecialidad = CONCAT('Nuevo salario: ', vSalarioNuevo);

    COMMIT;

END$$

DELIMITER ;

-- ───────────────────────────────────────────────────────────────────
--  EJERCICIO 13 — Test de Procedimiento almacenado con parámetros INOUT
-- ───────────────────────────────────────────────────────────────────
-- Una vez creado el procedimiento monitor_ajustarSalario, pruébalo con el siguiente caso de inscripción correcta:
-- Localiza el salario actual del monitor con id = 3 antes de realizar ninguna llamada al procedimiento, para tener constancia del valor de partida.
-- Llamar al procedimiento para un monitor con id=3 y pEspecialidad Musculación, la variable pCantidad -200€.
-- Llamar al procedimiento para un monitor con id=9 y pEspecialidad Muscualción, la variable pCantidad 350€
-- Muestra el contenido de la variable @especialidad tras la llamada y verifica el nuevo salario percibido.
-- Localiza el salario actual del monitor con id = 3 antes de realizar ninguna llamada al procedimiento, para tener constancia del valor de partida. Verifica que el salario se ha aumentado al llamar al procedimiento
-- 
-- ───────────────────────────────────────────────────────────────────
-- ── SOLUCIÓN ──────────────────────────────────────────────────────

-- ── 1. Salario previo a la llamada ───────────────────────────────────────────
SELECT id,
       nombre,
       apellido1,
       especialidad,
       salario AS salario_antes
FROM   monitores
WHERE  id = 3;

-- ── 2. Llamada al procedimiento ──────────────────────────────────────────────
SET @especialidad = 'Musculación';

CALL monitor_ajustarSalario(3, -250.00, @especialidad);
CALL monitor_ajustarSalario(3, 350.00, @especialidad);

-- ── 3. Verificar el valor devuelto en el parámetro INOUT ─────────────────────
SELECT @especialidad AS resultado_inout;
-- Valor esperado: 'Nuevo salario: XXXXX.XX'

-- ── 4. Verificar que el salario se ha actualizado en la tabla ─────────────────
SELECT id,
       nombre,
       apellido1,
       especialidad,
       salario AS salario_despues
FROM   monitores
WHERE  id = 3;
-- Valor esperado en salario_despues: 1600.00

