-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-05-2025 a las 11:50:35
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_clinica`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencias`
--

CREATE TABLE `asistencias` (
  `asis_id` int(11) NOT NULL,
  `asis_fec` date NOT NULL,
  `hora_entrada` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bonos`
--

CREATE TABLE `bonos` (
  `bono_id` int(11) NOT NULL,
  `bono_nom` varchar(100) NOT NULL,
  `bono_can` decimal(10,2) NOT NULL,
  `bono_desc` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_asistencias`
--

CREATE TABLE `detalle_asistencias` (
  `detasis_id` int(11) NOT NULL,
  `asis_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `hora_llegada` time DEFAULT NULL,
  `tipo_asistencia` varchar(20) NOT NULL,
  `descuento` decimal(10,2) DEFAULT NULL,
  `justificacion` text DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pagos`
--

CREATE TABLE `detalle_pagos` (
  `detp_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `pag_id` int(11) NOT NULL,
  `per_id` int(11) NOT NULL,
  `bono_id` int(11) DEFAULT NULL,
  `detp_mon` decimal(10,2) NOT NULL,
  `descuento_total` decimal(10,2) NOT NULL,
  `sueldo_neto` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `emp_id` int(11) NOT NULL,
  `emp_dni` varchar(15) NOT NULL,
  `emp_nom` varchar(50) NOT NULL,
  `emp_ape` varchar(50) NOT NULL,
  `emp_email` varchar(100) NOT NULL,
  `emp_tel` varchar(15) DEFAULT NULL,
  `esp_id` int(11) DEFAULT NULL,
  `emp_fec` date NOT NULL,
  `emp_sal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`emp_id`, `emp_dni`, `emp_nom`, `emp_ape`, `emp_email`, `emp_tel`, `esp_id`, `emp_fec`, `emp_sal`) VALUES
(33, '76432189', 'Axel Jesús', 'Santander Alcarraz', 'axelsantander@gmail.com', '912345678', NULL, '2025-01-15', 5000.00),
(34, '75643829', 'Lucía Marisol', 'Cruz Villanueva', 'luciacruz@gmail.com', '913456789', NULL, '2025-01-22', 2800.00),
(35, '73214567', 'Carlos Javier', 'Quispe Salazar', 'carlosquispe@gmail.com', '914567890', 1, '2025-01-25', 3500.00),
(36, '74321890', 'Andrea Paola', 'Gómez Huamán', 'andreagomez@gmail.com', '915678901', 2, '2025-01-28', 3500.00),
(37, '75478901', 'Luis Enrique', 'Paredes Soto', 'luisparedes@gmail.com', '916789012', 3, '2025-02-01', 3500.00),
(38, '76589012', 'Sandra Milagros', 'Ramírez León', 'sandraramirez@gmail.com', '917890123', 4, '2025-02-05', 3500.00),
(39, '77690123', 'Jorge Alberto', 'Rojas Aguilar', 'jorgerojas@gmail.com', '918901234', 5, '2025-02-08', 3500.00),
(40, '78701234', 'Mónica Fiorella', 'Cáceres Meza', 'monicacaceres@gmail.com', '919012345', 6, '2025-02-11', 3500.00),
(41, '79812345', 'Ricardo Daniel', 'Salinas Ruiz', 'ricardosalinas@gmail.com', '920123456', 1, '2025-02-15', 3500.00),
(42, '70923456', 'Valeria Roxana', 'Espinoza Poma', 'valeriaespinoza@gmail.com', '921234567', 2, '2025-02-20', 3500.00),
(43, '71034567', 'Fernando Iván', 'Reyes Guevara', 'fernandoreyes@gmail.com', '922345678', 3, '2025-02-25', 3500.00),
(44, '72145678', 'Lucero Carolina', 'Lozano Córdova', 'lucerolozano@gmail.com', '923456789', 4, '2025-03-01', 3500.00),
(45, '73256789', 'Héctor Raúl', 'Mendoza Castillo', 'hectormendoza@gmail.com', '924567890', 5, '2025-03-05', 3500.00),
(46, '74367890', 'Gisela Pilar', 'Rivas Tello', 'giselarivas@gmail.com', '925678901', 6, '2025-03-10', 3500.00),
(47, '75478912', 'David Andrés', 'Zevallos Linares', 'davidzevallos@gmail.com', '926789012', 1, '2025-03-15', 3500.00),
(48, '76589023', 'Alejandra Ruth', 'Valdivia Quinteros', 'alejandravald@gmail.com', '927890123', 2, '2025-03-20', 3500.00),
(49, '77690134', 'Renato César', 'Morales Yupanqui', 'renatomorales@gmail.com', '928901234', 3, '2025-03-25', 3500.00),
(50, '78701245', 'Diana Fátima', 'Mamani Vargas', 'dianamam@gmail.com', '929012345', 4, '2025-03-30', 3500.00),
(51, '79812356', 'Edwin Joel', 'Ortega Zárate', 'edwinortega@gmail.com', '930123456', 5, '2025-04-01', 3500.00),
(52, '70923467', 'María Fernanda', 'Pino Galván', 'mariapino@gmail.com', '931234567', 6, '2025-04-05', 3500.00),
(53, '71034578', 'Óscar Leonel', 'Bravo Ticona', 'oscarbravo@gmail.com', '932345678', 1, '2025-04-10', 3500.00),
(54, '72145689', 'Anahí Julissa', 'Gonzales Llosa', 'anahigonzales@gmail.com', '933456789', 2, '2025-04-15', 3500.00),
(55, '73256790', 'Bryan Ariel', 'Zambrano Olivares', 'bryanzambrano@gmail.com', '934567890', 3, '2025-04-20', 3500.00),
(56, '74367801', 'Mariela Edith', 'Núñez Rengifo', 'marielanunez@gmail.com', '935678901', 4, '2025-04-25', 3500.00),
(57, '75478923', 'Franco Elías', 'Chávez Delgado', 'francochavez@gmail.com', '936789012', 5, '2025-04-28', 3500.00),
(58, '76589034', 'Zulema Estefany', 'Mejía Carbajal', 'zulemamejia@gmail.com', '937890123', 6, '2025-04-30', 3500.00),
(59, '77690145', 'Kevin Alexander', 'Torres Ayala', 'kevintorres@gmail.com', '938901234', 1, '2025-05-01', 3500.00),
(60, '78701256', 'Natalie Ivonne', 'Benavente Quiroz', 'nataliebenavente@gmail.com', '939012345', 2, '2025-05-05', 3500.00),
(61, '79812367', 'Samuel Esteban', 'Huerta Vigo', 'samuelhuerta@gmail.com', '940123456', 3, '2025-05-08', 3500.00),
(62, '70923478', 'Pamela Alejandra', 'Quintana Rosas', 'pamelaquintana@gmail.com', '941234567', 4, '2025-05-10', 3500.00),
(63, '71034589', 'Yair Rodrigo', 'Silva Castañeda', 'yairsilva@gmail.com', '942345678', 5, '2025-05-12', 3500.00),
(64, '72145690', 'Fiorella Celeste', 'Delgado Ñahui', 'fiorelladelgado@gmail.com', '943456789', 6, '2025-05-15', 3500.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidades`
--

CREATE TABLE `especialidades` (
  `esp_id` int(11) NOT NULL,
  `esp_nom` varchar(100) NOT NULL,
  `esp_desc` text DEFAULT NULL,
  `esp_ph` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especialidades`
--

INSERT INTO `especialidades` (`esp_id`, `esp_nom`, `esp_desc`, `esp_ph`) VALUES
(1, 'Odontología General', 'Tratamientos generales dentales', 50.00),
(2, 'Ortodoncia', 'Corrección de dientes mal alineados', 60.00),
(3, 'Endodoncia', 'Tratamiento de conductos', 70.00),
(4, 'Periodoncia', 'Tratamiento de encías', 55.00),
(5, 'Cirugía Oral', 'Extracciones y cirugías menores', 80.00),
(6, 'Implantología', 'Colocación de implantes dentales', 90.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `pag_id` int(11) NOT NULL,
  `pag_fec` date NOT NULL,
  `pag_tot` decimal(10,2) NOT NULL,
  `pag_det` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `periodos_pago`
--

CREATE TABLE `periodos_pago` (
  `per_id` int(11) NOT NULL,
  `per_ini` date NOT NULL,
  `per_fin` date NOT NULL,
  `per_desc` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rol_id` int(11) NOT NULL,
  `rol_nom` varchar(50) DEFAULT NULL,
  `rol_desc` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rol_id`, `rol_nom`, `rol_desc`) VALUES
(1, 'Admin', 'Gestión total del sistema de planillas'),
(2, 'Recepcionista', 'Registro de asistencias y apoyo en administración'),
(3, 'Odontólogo', 'Visualización de sus asistencias y pagos en la planilla');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `usr_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `usr_user` varchar(100) NOT NULL,
  `usr_pass` varchar(255) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `usr_act` tinyint(4) NOT NULL,
  `usr_fec` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usr_id`, `emp_id`, `usr_user`, `usr_pass`, `rol_id`, `usr_act`, `usr_fec`) VALUES
(1, 57, 'A12345678', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 1, 1, '2025-05-12 08:28:11'),
(2, 56, 'O87654321', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-05-12 08:49:43'),
(33, 33, 'asantander', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 1, 1, '2025-01-15 10:00:00'),
(34, 34, 'lcruz', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 2, 1, '2025-03-22 10:00:00'),
(35, 35, 'cquispe', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-01-20 10:00:00'),
(36, 36, 'agomez', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-01-28 10:00:00'),
(37, 37, 'lparedes', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-02-01 10:00:00'),
(38, 38, 'sramirez', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-02-05 10:00:00'),
(39, 39, 'jrojas', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-02-08 10:00:00'),
(40, 40, 'mcaceres', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-02-11 10:00:00'),
(41, 41, 'rsalinas', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-02-15 10:00:00'),
(42, 42, 'vespinoza', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-02-20 10:00:00'),
(43, 43, 'freyes', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-02-25 10:00:00'),
(44, 44, 'llozano', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-03-01 10:00:00'),
(45, 45, 'hmendoza', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-03-05 10:00:00'),
(46, 46, 'grivas', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-03-10 10:00:00'),
(47, 47, 'dzevallos', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-03-15 10:00:00'),
(48, 48, 'avaldivia', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-03-20 10:00:00'),
(49, 49, 'rmorales', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-03-25 10:00:00'),
(50, 50, 'dmamani', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-03-30 10:00:00'),
(51, 51, 'eortega', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-04-01 10:00:00'),
(52, 52, 'mpino', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-04-05 10:00:00'),
(53, 53, 'obravo', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-04-10 10:00:00'),
(54, 54, 'agonzales', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-04-15 10:00:00'),
(55, 55, 'bzambrano', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-04-20 10:00:00'),
(56, 56, 'mnunez', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-04-25 10:00:00'),
(57, 57, 'fchavez', '$2a$12$1zOGlvCC8eO8R7fOWT5wcOAvoeAX4b1bnffxJEUaW.72wLA6abjaS', 3, 1, '2025-04-28 10:00:00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asistencias`
--
ALTER TABLE `asistencias`
  ADD PRIMARY KEY (`asis_id`);

--
-- Indices de la tabla `bonos`
--
ALTER TABLE `bonos`
  ADD PRIMARY KEY (`bono_id`);

--
-- Indices de la tabla `detalle_asistencias`
--
ALTER TABLE `detalle_asistencias`
  ADD PRIMARY KEY (`detasis_id`),
  ADD KEY `asis_id` (`asis_id`),
  ADD KEY `emp_id` (`emp_id`);

--
-- Indices de la tabla `detalle_pagos`
--
ALTER TABLE `detalle_pagos`
  ADD PRIMARY KEY (`detp_id`),
  ADD KEY `emp_id` (`emp_id`),
  ADD KEY `pag_id` (`pag_id`),
  ADD KEY `per_id` (`per_id`),
  ADD KEY `bono_id` (`bono_id`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `esp_id` (`esp_id`);

--
-- Indices de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`esp_id`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`pag_id`);

--
-- Indices de la tabla `periodos_pago`
--
ALTER TABLE `periodos_pago`
  ADD PRIMARY KEY (`per_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usr_id`),
  ADD UNIQUE KEY `usr_user` (`usr_user`),
  ADD KEY `emp_id` (`emp_id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asistencias`
--
ALTER TABLE `asistencias`
  MODIFY `asis_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `bonos`
--
ALTER TABLE `bonos`
  MODIFY `bono_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_asistencias`
--
ALTER TABLE `detalle_asistencias`
  MODIFY `detasis_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_pagos`
--
ALTER TABLE `detalle_pagos`
  MODIFY `detp_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `emp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  MODIFY `esp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `pag_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `periodos_pago`
--
ALTER TABLE `periodos_pago`
  MODIFY `per_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `rol_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_asistencias`
--
ALTER TABLE `detalle_asistencias`
  ADD CONSTRAINT `detalle_asistencias_ibfk_1` FOREIGN KEY (`asis_id`) REFERENCES `asistencias` (`asis_id`),
  ADD CONSTRAINT `detalle_asistencias_ibfk_2` FOREIGN KEY (`emp_id`) REFERENCES `empleados` (`emp_id`);

--
-- Filtros para la tabla `detalle_pagos`
--
ALTER TABLE `detalle_pagos`
  ADD CONSTRAINT `detalle_pagos_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `empleados` (`emp_id`),
  ADD CONSTRAINT `detalle_pagos_ibfk_2` FOREIGN KEY (`pag_id`) REFERENCES `pagos` (`pag_id`),
  ADD CONSTRAINT `detalle_pagos_ibfk_3` FOREIGN KEY (`per_id`) REFERENCES `periodos_pago` (`per_id`),
  ADD CONSTRAINT `detalle_pagos_ibfk_4` FOREIGN KEY (`bono_id`) REFERENCES `bonos` (`bono_id`);

--
-- Filtros para la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`esp_id`) REFERENCES `especialidades` (`esp_id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `empleados` (`emp_id`),
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
