-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-06-2025 a las 04:59:59
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
-- Base de datos: `planilla`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencias`
--

CREATE TABLE `asistencias` (
  `asi_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_entrada` time DEFAULT NULL,
  `hora_salida` time DEFAULT NULL,
  `estado_entrada` enum('PUNTUAL','TARDANZA','FALTA') NOT NULL,
  `estado_salida` enum('NORMAL','ANTICIPADA','NO_MARCÓ') DEFAULT 'NO_MARCÓ',
  `min_tardanza` int(11) DEFAULT 0,
  `min_anticipacion` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asistencias`
--

INSERT INTO `asistencias` (`asi_id`, `emp_id`, `fecha`, `hora_entrada`, `hora_salida`, `estado_entrada`, `estado_salida`, `min_tardanza`, `min_anticipacion`) VALUES
(637, 1, '2025-06-02', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(638, 1, '2025-06-03', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(639, 1, '2025-06-04', '07:57:00', '15:47:00', 'PUNTUAL', 'ANTICIPADA', 0, 13),
(640, 1, '2025-06-05', '07:59:00', '15:45:00', 'PUNTUAL', 'ANTICIPADA', 0, 15),
(641, 1, '2025-06-06', '08:09:00', '16:00:00', 'TARDANZA', 'NORMAL', 9, 0),
(642, 1, '2025-06-09', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(643, 1, '2025-06-10', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(644, 1, '2025-06-11', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(645, 1, '2025-06-12', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(646, 1, '2025-06-13', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(647, 3, '2025-06-02', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(648, 3, '2025-06-03', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(649, 3, '2025-06-04', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(650, 3, '2025-06-05', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(651, 3, '2025-06-06', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(652, 3, '2025-06-09', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(653, 3, '2025-06-10', '07:58:00', '15:55:00', 'PUNTUAL', 'ANTICIPADA', 0, 5),
(654, 3, '2025-06-11', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(655, 3, '2025-06-12', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(656, 3, '2025-06-13', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(657, 4, '2025-06-02', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(658, 4, '2025-06-03', '07:57:00', '15:46:00', 'PUNTUAL', 'ANTICIPADA', 0, 14),
(659, 4, '2025-06-04', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(660, 4, '2025-06-05', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(661, 4, '2025-06-06', '07:59:00', '15:48:00', 'PUNTUAL', 'ANTICIPADA', 0, 12),
(662, 4, '2025-06-09', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(663, 4, '2025-06-10', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(664, 4, '2025-06-11', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(665, 4, '2025-06-12', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(666, 4, '2025-06-13', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(667, 5, '2025-06-02', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(668, 5, '2025-06-03', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(669, 5, '2025-06-04', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(670, 5, '2025-06-05', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(671, 5, '2025-06-06', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(672, 5, '2025-06-09', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(673, 5, '2025-06-10', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(674, 5, '2025-06-11', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(675, 5, '2025-06-12', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(676, 5, '2025-06-13', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(677, 6, '2025-06-02', '08:13:00', '15:49:00', 'TARDANZA', 'ANTICIPADA', 13, 11),
(678, 6, '2025-06-03', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(679, 6, '2025-06-04', '08:10:00', '16:00:00', 'TARDANZA', 'NORMAL', 10, 0),
(680, 6, '2025-06-05', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(681, 6, '2025-06-06', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(682, 6, '2025-06-09', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(683, 6, '2025-06-10', '08:15:00', '16:00:00', 'TARDANZA', 'NORMAL', 15, 0),
(684, 6, '2025-06-11', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(685, 6, '2025-06-12', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(686, 6, '2025-06-13', '08:20:00', '16:00:00', 'TARDANZA', 'NORMAL', 20, 0),
(687, 7, '2025-06-02', '08:11:00', '16:00:00', 'TARDANZA', 'NORMAL', 11, 0),
(688, 7, '2025-06-03', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(689, 7, '2025-06-04', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(690, 7, '2025-06-05', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(691, 7, '2025-06-06', '07:56:00', '15:54:00', 'PUNTUAL', 'ANTICIPADA', 0, 6),
(692, 7, '2025-06-09', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(693, 7, '2025-06-10', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(694, 7, '2025-06-11', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(695, 7, '2025-06-12', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(696, 7, '2025-06-13', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(697, 8, '2025-06-02', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(698, 8, '2025-06-03', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(699, 8, '2025-06-04', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(700, 8, '2025-06-05', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(701, 8, '2025-06-06', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(702, 8, '2025-06-09', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(703, 8, '2025-06-10', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(704, 8, '2025-06-11', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(705, 8, '2025-06-12', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(706, 8, '2025-06-13', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(707, 9, '2025-06-02', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(708, 9, '2025-06-03', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(709, 9, '2025-06-04', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(710, 9, '2025-06-05', '08:13:00', '16:00:00', 'TARDANZA', 'NORMAL', 13, 0),
(711, 9, '2025-06-06', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(712, 9, '2025-06-09', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(713, 9, '2025-06-10', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(714, 9, '2025-06-11', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(715, 9, '2025-06-12', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(716, 9, '2025-06-13', '07:57:00', '15:55:00', 'PUNTUAL', 'ANTICIPADA', 0, 5),
(717, 10, '2025-06-02', '08:17:00', '16:00:00', 'TARDANZA', 'NORMAL', 17, 0),
(718, 10, '2025-06-03', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(719, 10, '2025-06-04', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(720, 10, '2025-06-05', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(721, 10, '2025-06-06', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(722, 10, '2025-06-09', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(723, 10, '2025-06-10', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(724, 10, '2025-06-11', '07:59:00', '15:50:00', 'PUNTUAL', 'ANTICIPADA', 0, 10),
(725, 10, '2025-06-12', '07:59:00', '15:50:00', 'PUNTUAL', 'ANTICIPADA', 0, 10),
(726, 10, '2025-06-13', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(727, 11, '2025-06-02', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(728, 11, '2025-06-03', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(729, 11, '2025-06-04', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(730, 11, '2025-06-05', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(731, 11, '2025-06-06', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(732, 11, '2025-06-09', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(733, 11, '2025-06-10', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(734, 11, '2025-06-11', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(735, 11, '2025-06-12', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(736, 11, '2025-06-13', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(737, 12, '2025-06-02', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(738, 12, '2025-06-03', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(739, 12, '2025-06-04', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(740, 12, '2025-06-05', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(741, 12, '2025-06-06', '07:57:00', '15:52:00', 'PUNTUAL', 'ANTICIPADA', 0, 8),
(742, 12, '2025-06-09', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(743, 12, '2025-06-10', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(744, 12, '2025-06-11', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(745, 12, '2025-06-12', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(746, 12, '2025-06-13', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(747, 13, '2025-06-02', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(748, 13, '2025-06-03', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(749, 13, '2025-06-04', '07:59:00', '15:45:00', 'PUNTUAL', 'ANTICIPADA', 0, 15),
(750, 13, '2025-06-05', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(751, 13, '2025-06-06', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(752, 13, '2025-06-09', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(753, 13, '2025-06-10', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(754, 13, '2025-06-11', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(755, 13, '2025-06-12', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(756, 13, '2025-06-13', '07:59:00', '15:53:00', 'PUNTUAL', 'ANTICIPADA', 0, 7),
(757, 14, '2025-06-02', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(758, 14, '2025-06-03', '07:56:00', '15:51:00', 'PUNTUAL', 'ANTICIPADA', 0, 9),
(759, 14, '2025-06-04', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(760, 14, '2025-06-05', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(761, 14, '2025-06-06', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(762, 14, '2025-06-09', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(763, 14, '2025-06-10', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(764, 14, '2025-06-11', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(765, 14, '2025-06-12', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(766, 14, '2025-06-13', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(767, 15, '2025-06-02', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(768, 15, '2025-06-03', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(769, 15, '2025-06-04', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(770, 15, '2025-06-05', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(771, 15, '2025-06-06', '07:57:00', '15:52:00', 'PUNTUAL', 'ANTICIPADA', 0, 8),
(772, 15, '2025-06-09', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(773, 15, '2025-06-10', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(774, 15, '2025-06-11', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(775, 15, '2025-06-12', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(776, 15, '2025-06-13', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(777, 16, '2025-06-02', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(778, 16, '2025-06-03', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(779, 16, '2025-06-04', '07:57:00', '15:46:00', 'PUNTUAL', 'ANTICIPADA', 0, 14),
(780, 16, '2025-06-05', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(781, 16, '2025-06-06', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(782, 16, '2025-06-09', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(783, 16, '2025-06-10', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(784, 16, '2025-06-11', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(785, 16, '2025-06-12', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(786, 16, '2025-06-13', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(787, 17, '2025-06-02', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(788, 17, '2025-06-03', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(789, 17, '2025-06-04', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(790, 17, '2025-06-05', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(791, 17, '2025-06-06', '07:56:00', '15:50:00', 'PUNTUAL', 'ANTICIPADA', 0, 10),
(792, 17, '2025-06-09', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(793, 17, '2025-06-10', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(794, 17, '2025-06-11', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(795, 17, '2025-06-12', '07:58:00', '15:45:00', 'PUNTUAL', 'ANTICIPADA', 0, 15),
(796, 17, '2025-06-13', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(797, 18, '2025-06-02', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(798, 18, '2025-06-03', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(799, 18, '2025-06-04', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(800, 18, '2025-06-05', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(801, 18, '2025-06-06', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(802, 18, '2025-06-09', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(803, 18, '2025-06-10', '08:00:00', '15:52:00', 'PUNTUAL', 'ANTICIPADA', 0, 8),
(804, 18, '2025-06-11', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(805, 18, '2025-06-12', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(806, 18, '2025-06-13', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(807, 19, '2025-06-02', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(808, 19, '2025-06-03', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(809, 19, '2025-06-04', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(810, 19, '2025-06-05', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(811, 19, '2025-06-06', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(812, 19, '2025-06-09', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(813, 19, '2025-06-10', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(814, 19, '2025-06-11', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(815, 19, '2025-06-12', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(816, 19, '2025-06-13', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(817, 20, '2025-06-02', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(818, 20, '2025-06-03', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(819, 20, '2025-06-04', '07:59:00', '15:45:00', 'PUNTUAL', 'ANTICIPADA', 0, 15),
(820, 20, '2025-06-05', '08:00:00', '15:47:00', 'PUNTUAL', 'ANTICIPADA', 0, 13),
(821, 20, '2025-06-06', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(822, 20, '2025-06-09', '07:57:00', '15:53:00', 'PUNTUAL', 'ANTICIPADA', 0, 7),
(823, 20, '2025-06-10', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(824, 20, '2025-06-11', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(825, 20, '2025-06-12', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(826, 20, '2025-06-13', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(827, 21, '2025-06-02', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(828, 21, '2025-06-03', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(829, 21, '2025-06-04', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(830, 21, '2025-06-05', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(831, 21, '2025-06-06', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(832, 21, '2025-06-09', '08:00:00', '15:48:00', 'PUNTUAL', 'ANTICIPADA', 0, 12),
(833, 21, '2025-06-10', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(834, 21, '2025-06-11', '07:57:00', '15:51:00', 'PUNTUAL', 'ANTICIPADA', 0, 9),
(835, 21, '2025-06-12', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(836, 21, '2025-06-13', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(837, 22, '2025-06-02', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(838, 22, '2025-06-03', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(839, 22, '2025-06-04', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(840, 22, '2025-06-05', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(841, 22, '2025-06-06', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(842, 22, '2025-06-09', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(843, 22, '2025-06-10', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(844, 22, '2025-06-11', '07:58:00', '15:52:00', 'PUNTUAL', 'ANTICIPADA', 0, 8),
(845, 22, '2025-06-12', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(846, 22, '2025-06-13', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(847, 23, '2025-06-02', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(848, 23, '2025-06-03', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(849, 23, '2025-06-04', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(850, 23, '2025-06-05', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(851, 23, '2025-06-06', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(852, 23, '2025-06-09', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(853, 23, '2025-06-10', '07:59:00', '15:50:00', 'PUNTUAL', 'ANTICIPADA', 0, 10),
(854, 23, '2025-06-11', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(855, 23, '2025-06-12', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(856, 23, '2025-06-13', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(857, 24, '2025-06-02', '08:00:00', '15:53:00', 'PUNTUAL', 'ANTICIPADA', 0, 7),
(858, 24, '2025-06-03', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(859, 24, '2025-06-04', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(860, 24, '2025-06-05', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(861, 24, '2025-06-06', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(862, 24, '2025-06-09', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(863, 24, '2025-06-10', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(864, 24, '2025-06-11', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(865, 24, '2025-06-12', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(866, 24, '2025-06-13', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(867, 25, '2025-06-02', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(868, 25, '2025-06-03', '07:57:00', '15:54:00', 'PUNTUAL', 'ANTICIPADA', 0, 6),
(869, 25, '2025-06-04', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(870, 25, '2025-06-05', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(871, 25, '2025-06-06', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(872, 25, '2025-06-09', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(873, 25, '2025-06-10', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(874, 25, '2025-06-11', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(875, 25, '2025-06-12', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(876, 25, '2025-06-13', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(877, 26, '2025-06-02', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(878, 26, '2025-06-03', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(879, 26, '2025-06-04', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(880, 26, '2025-06-05', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(881, 26, '2025-06-06', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(882, 26, '2025-06-09', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(883, 26, '2025-06-10', '07:56:00', '15:45:00', 'PUNTUAL', 'ANTICIPADA', 0, 15),
(884, 26, '2025-06-11', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(885, 26, '2025-06-12', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(886, 26, '2025-06-13', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(887, 27, '2025-06-02', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(888, 27, '2025-06-03', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(889, 27, '2025-06-04', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(890, 27, '2025-06-05', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(891, 27, '2025-06-06', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(892, 27, '2025-06-09', '07:59:00', '15:45:00', 'PUNTUAL', 'ANTICIPADA', 0, 15),
(893, 27, '2025-06-10', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(894, 27, '2025-06-11', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(895, 27, '2025-06-12', '07:56:00', '15:53:00', 'PUNTUAL', 'ANTICIPADA', 0, 7),
(896, 27, '2025-06-13', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(897, 28, '2025-06-02', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(898, 28, '2025-06-03', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(899, 28, '2025-06-04', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(900, 28, '2025-06-05', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(901, 28, '2025-06-06', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(902, 28, '2025-06-09', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(903, 28, '2025-06-10', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(904, 28, '2025-06-11', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(905, 28, '2025-06-12', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(906, 28, '2025-06-13', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(907, 29, '2025-06-02', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(908, 29, '2025-06-03', '07:56:00', '15:54:00', 'PUNTUAL', 'ANTICIPADA', 0, 6),
(909, 29, '2025-06-04', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(910, 29, '2025-06-05', '07:57:00', '15:55:00', 'PUNTUAL', 'ANTICIPADA', 0, 5),
(911, 29, '2025-06-06', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(912, 29, '2025-06-09', '07:58:00', '15:55:00', 'PUNTUAL', 'ANTICIPADA', 0, 5),
(913, 29, '2025-06-10', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(914, 29, '2025-06-11', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(915, 29, '2025-06-12', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(916, 29, '2025-06-13', '07:59:00', '15:47:00', 'PUNTUAL', 'ANTICIPADA', 0, 13),
(917, 30, '2025-06-02', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(918, 30, '2025-06-03', '07:58:00', '15:47:00', 'PUNTUAL', 'ANTICIPADA', 0, 13),
(919, 30, '2025-06-04', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(920, 30, '2025-06-05', '07:58:00', '15:45:00', 'PUNTUAL', 'ANTICIPADA', 0, 15),
(921, 30, '2025-06-06', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(922, 30, '2025-06-09', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(923, 30, '2025-06-10', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(924, 30, '2025-06-11', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(925, 30, '2025-06-12', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(926, 30, '2025-06-13', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(927, 31, '2025-06-02', '07:59:00', '15:52:00', 'PUNTUAL', 'ANTICIPADA', 0, 8),
(928, 31, '2025-06-03', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(929, 31, '2025-06-04', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(930, 31, '2025-06-05', '07:59:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(931, 31, '2025-06-06', '07:58:00', '15:52:00', 'PUNTUAL', 'ANTICIPADA', 0, 8),
(932, 31, '2025-06-09', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(933, 31, '2025-06-10', '07:58:00', '15:49:00', 'PUNTUAL', 'ANTICIPADA', 0, 11),
(934, 31, '2025-06-11', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(935, 31, '2025-06-12', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(936, 31, '2025-06-13', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(937, 32, '2025-06-02', '07:59:00', '15:45:00', 'PUNTUAL', 'ANTICIPADA', 0, 15),
(938, 32, '2025-06-03', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(939, 32, '2025-06-04', '07:56:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(940, 32, '2025-06-05', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(941, 32, '2025-06-06', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(942, 32, '2025-06-09', '07:57:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(943, 32, '2025-06-10', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(944, 32, '2025-06-11', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(945, 32, '2025-06-12', '07:58:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(946, 32, '2025-06-13', '07:59:00', '15:51:00', 'PUNTUAL', 'ANTICIPADA', 0, 9),
(947, 2, '2025-06-02', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(948, 2, '2025-06-03', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(949, 2, '2025-06-04', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(950, 2, '2025-06-05', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(951, 2, '2025-06-06', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(952, 2, '2025-06-09', '08:00:00', '16:00:00', 'PUNTUAL', 'NORMAL', 0, 0),
(953, 2, '2025-06-10', '08:13:00', '16:10:00', 'TARDANZA', 'NORMAL', 13, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `emp_id` int(11) NOT NULL,
  `emp_nombre` varchar(100) NOT NULL,
  `emp_apellido` varchar(100) NOT NULL,
  `emp_dni` varchar(20) NOT NULL,
  `esp_id` int(11) NOT NULL,
  `hor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`emp_id`, `emp_nombre`, `emp_apellido`, `emp_dni`, `esp_id`, `hor_id`) VALUES
(1, 'Axel', 'Santander', '73681635', 1, 1),
(2, 'Lucas', 'Cocha', '87654321', 1, 1),
(3, 'Andres', 'Quispe', '44556677', 1, 1),
(4, 'Maria', 'Valdez', '77889900', 1, 1),
(5, 'Jose', 'Ramos', '11223344', 1, 1),
(6, 'Luisa', 'Salazar', '33445566', 1, 1),
(7, 'Carlos', 'Lopez', '55667788', 1, 1),
(8, 'Julia', 'Fernandez', '66778899', 1, 1),
(9, 'Raul', 'Gutierrez', '99887766', 2, 1),
(10, 'Veronica', 'Torres', '88990011', 2, 1),
(11, 'Pedro', 'Mendoza', '77665544', 2, 1),
(12, 'Natalia', 'Chavez', '22334455', 2, 1),
(13, 'Luis', 'Vega', '33446677', 2, 1),
(14, 'Diana', 'Silva', '44557788', 2, 1),
(15, 'Jorge', 'Herrera', '55668899', 3, 1),
(16, 'Rosa', 'Aguilar', '66779900', 3, 1),
(17, 'Marco', 'Campos', '77880011', 3, 1),
(18, 'Isabel', 'Reyes', '88991122', 3, 1),
(19, 'Miguel', 'Castro', '99002233', 3, 1),
(20, 'Camila', 'Ortega', '10111213', 3, 1),
(21, 'Hugo', 'Peña', '12131415', 4, 1),
(22, 'Patricia', 'Ruiz', '13141516', 4, 1),
(23, 'Renato', 'Nunez', '14151617', 4, 1),
(24, 'Daniela', 'Morales', '15161718', 4, 1),
(25, 'Esteban', 'Cortez', '16171819', 4, 1),
(26, 'Ana', 'Bravo', '17181920', 4, 1),
(27, 'Sergio', 'Fuentes', '18192021', 5, 1),
(28, 'Paola', 'Santos', '19202122', 5, 1),
(29, 'Ricardo', 'Ibarra', '20212223', 5, 1),
(30, 'Lorena', 'Paredes', '21222324', 5, 1),
(31, 'Fernando', 'Vargas', '22232425', 5, 1),
(32, 'Sandra', 'Navarro', '23242526', 5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidades`
--

CREATE TABLE `especialidades` (
  `esp_id` int(11) NOT NULL,
  `esp_nombre` varchar(100) NOT NULL,
  `tarifa_hora` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especialidades`
--

INSERT INTO `especialidades` (`esp_id`, `esp_nombre`, `tarifa_hora`) VALUES
(1, 'Ortodoncia', 80.00),
(2, 'Endodoncia', 70.00),
(3, 'Cirugía Oral', 90.00),
(4, 'Periodoncia', 75.00),
(5, 'Implantología', 100.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `hor_id` int(11) NOT NULL,
  `hora_entrada` time NOT NULL,
  `hora_salida` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`hor_id`, `hora_entrada`, `hora_salida`) VALUES
(1, '08:00:00', '16:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `justificativos`
--

CREATE TABLE `justificativos` (
  `jus_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `desde` date NOT NULL,
  `hasta` date NOT NULL,
  `archivo_url` varchar(255) DEFAULT NULL,
  `motivo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `justificativos`
--

INSERT INTO `justificativos` (`jus_id`, `emp_id`, `desde`, `hasta`, `archivo_url`, `motivo`) VALUES
(3, 1, '2025-06-14', '2025-06-18', '2', 'prueba'),
(4, 2, '2025-06-14', '2025-06-16', NULL, 'prueba'),
(5, 6, '2025-06-02', '2025-06-02', NULL, 'fiebre'),
(6, 10, '2025-06-11', '2025-06-12', NULL, 'fiesta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rol_id` int(11) NOT NULL,
  `rol_nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rol_id`, `rol_nombre`) VALUES
(1, 'ADMIN'),
(2, 'ODONTOLOGO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `usr_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `usr_usuario` varchar(50) NOT NULL,
  `usr_clave` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usr_id`, `emp_id`, `rol_id`, `usr_usuario`, `usr_clave`) VALUES
(1, 1, 1, 'A73681635', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(2, 2, 2, 'O12345678', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(3, 3, 2, 'O44556677', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(4, 4, 2, 'O77889900', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(5, 5, 2, 'O11223344', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(6, 6, 2, 'O33445566', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(7, 7, 2, 'O55667788', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(8, 8, 2, 'O66778899', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(9, 9, 2, 'O99887766', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(10, 10, 2, 'O88990011', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(11, 11, 2, 'O77665544', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(12, 12, 2, 'O22334455', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(13, 13, 2, 'O33446677', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(14, 14, 2, 'O44557788', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(15, 15, 2, 'O55668899', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(16, 16, 2, 'O66779900', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(17, 17, 2, 'O77880011', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(18, 18, 2, 'O88991122', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(19, 19, 2, 'O99002233', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(20, 20, 2, 'O10111213', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(21, 21, 2, 'O12131415', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(22, 22, 2, 'O13141516', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(23, 23, 2, 'O14151617', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(24, 24, 2, 'O15161718', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(25, 25, 2, 'O16171819', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(26, 26, 2, 'O17181920', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(27, 27, 2, 'O18192021', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(28, 28, 2, 'O19202122', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(29, 29, 2, 'O20212223', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(30, 30, 2, 'O21222324', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(31, 31, 2, 'O22232425', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG'),
(32, 32, 2, 'O23242526', '$2a$12$UUb/iCASVDAl8e.SRUirHeBrjalXVGL8G9.Z9Rq.oM14eVYBejaYG');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asistencias`
--
ALTER TABLE `asistencias`
  ADD PRIMARY KEY (`asi_id`),
  ADD KEY `emp_id` (`emp_id`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`emp_id`),
  ADD UNIQUE KEY `emp_dni` (`emp_dni`),
  ADD KEY `esp_id` (`esp_id`),
  ADD KEY `hor_id` (`hor_id`);

--
-- Indices de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`esp_id`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`hor_id`);

--
-- Indices de la tabla `justificativos`
--
ALTER TABLE `justificativos`
  ADD PRIMARY KEY (`jus_id`),
  ADD KEY `emp_id` (`emp_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rol_id`),
  ADD UNIQUE KEY `rol_nombre` (`rol_nombre`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usr_id`),
  ADD UNIQUE KEY `usr_usuario` (`usr_usuario`),
  ADD KEY `emp_id` (`emp_id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asistencias`
--
ALTER TABLE `asistencias`
  MODIFY `asi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=954;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `emp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  MODIFY `esp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `hor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `justificativos`
--
ALTER TABLE `justificativos`
  MODIFY `jus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `rol_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asistencias`
--
ALTER TABLE `asistencias`
  ADD CONSTRAINT `asistencias_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `empleados` (`emp_id`);

--
-- Filtros para la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`esp_id`) REFERENCES `especialidades` (`esp_id`),
  ADD CONSTRAINT `empleados_ibfk_2` FOREIGN KEY (`hor_id`) REFERENCES `horarios` (`hor_id`);

--
-- Filtros para la tabla `justificativos`
--
ALTER TABLE `justificativos`
  ADD CONSTRAINT `justificativos_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `empleados` (`emp_id`);

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
