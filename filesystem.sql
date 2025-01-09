-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-01-2025 a las 05:17:45
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `filesystem`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizarUsuario` (IN `idP` INT, IN `nombreP` VARCHAR(100), IN `usuarioP` VARCHAR(100), IN `contraseniaP` VARCHAR(100), IN `tipoP` INT)   BEGIN
		update users set name=nombreP,
						 username=usuarioP,
                         password=contraseniaP,
						type=tipoP
                        where id=idP;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminarUsuario` (IN `idP` INT)   BEGIN
	delete from users where id = idP;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarUsuario` (IN `nombreP` VARCHAR(100), IN `usuarioP` VARCHAR(100), IN `contraseniaP` VARCHAR(100), IN `tipoP` INT)   BEGIN
	insert into users (name,username, password, type) values(nombreP,usuarioP,contraseniaP,tipoP);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrarUsuarios` ()   BEGIN
    SELECT id,name,username
		FROM users
		ORDER BY name ASC;
        
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `files`
--

CREATE TABLE `files` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `user_id` int(30) NOT NULL,
  `folder_id` int(30) NOT NULL,
  `file_type` varchar(50) NOT NULL,
  `file_path` text NOT NULL,
  `is_public` tinyint(1) DEFAULT 0,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `receptor_id` int(11) DEFAULT NULL,
  `op_descargar` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `files`
--

INSERT INTO `files` (`id`, `name`, `description`, `user_id`, `folder_id`, `file_type`, `file_path`, `is_public`, `date_updated`, `receptor_id`, `op_descargar`) VALUES
(8, 'verbs', 'Esta es mi archivo', 1, 7, 'jpg', '1736395500_verbs.jpg', 0, '2025-01-08 23:05:13', NULL, 0);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `files_view`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `files_view` (
`id` int(11)
,`name` varchar(200)
,`description` text
,`user_id` int(30)
,`folder_id` int(30)
,`file_type` varchar(50)
,`file_path` text
,`is_public` tinyint(1)
,`date_updated` datetime
,`receptor_id` int(11)
,`op_descargar` int(11)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `folders`
--

CREATE TABLE `folders` (
  `id` int(30) NOT NULL,
  `user_id` int(30) NOT NULL,
  `name` varchar(200) NOT NULL,
  `parent_id` int(30) NOT NULL DEFAULT 0,
  `is_public` tinyint(1) DEFAULT NULL,
  `receptor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `folders`
--

INSERT INTO `folders` (`id`, `user_id`, `name`, `parent_id`, `is_public`, `receptor_id`) VALUES
(7, 1, 'IA', 0, NULL, 10);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `folders_view`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `folders_view` (
`id` int(30)
,`user_id` int(30)
,`name` varchar(200)
,`parent_id` int(30)
,`is_public` tinyint(1)
,`receptor_id` int(11)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(30) NOT NULL,
  `name` varchar(200) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(200) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 2 COMMENT '1+admin , 2 = users'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `type`) VALUES
(1, 'TAREA ', 'admin', 'YCzyOHfqf0OG4kOp5t/VLUEvQUdjZTdkS2RrZkhFQXl1ZldLL0E9PQ==', 1),
(2, 'joel', 'joel', 'joel', 2),
(9, 'Fernando Guevara', 'fernando', 'gF0HBfCTjOUe/U8QygQ7iS9PT0ZOR1hiRXlFaW1oaHFyZEtzZmc9PQ==', 1),
(10, 'juan', 'juan', 'fkStH1ZYH2yn1YuHzMpDiGxZbGExMkdHdUJIVUpxbDIyMG00K1E9PQ==', 2);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `users_view`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `users_view` (
`id` int(30)
,`name` varchar(200)
,`username` varchar(100)
,`password` varchar(200)
,`type` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `files_view`
--
DROP TABLE IF EXISTS `files_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `files_view`  AS SELECT `files`.`id` AS `id`, `files`.`name` AS `name`, `files`.`description` AS `description`, `files`.`user_id` AS `user_id`, `files`.`folder_id` AS `folder_id`, `files`.`file_type` AS `file_type`, `files`.`file_path` AS `file_path`, `files`.`is_public` AS `is_public`, `files`.`date_updated` AS `date_updated`, `files`.`receptor_id` AS `receptor_id`, `files`.`op_descargar` AS `op_descargar` FROM `files` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `folders_view`
--
DROP TABLE IF EXISTS `folders_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `folders_view`  AS SELECT `folders`.`id` AS `id`, `folders`.`user_id` AS `user_id`, `folders`.`name` AS `name`, `folders`.`parent_id` AS `parent_id`, `folders`.`is_public` AS `is_public`, `folders`.`receptor_id` AS `receptor_id` FROM `folders` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `users_view`
--
DROP TABLE IF EXISTS `users_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `users_view`  AS SELECT `users`.`id` AS `id`, `users`.`name` AS `name`, `users`.`username` AS `username`, `users`.`password` AS `password`, `users`.`type` AS `type` FROM `users` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `receptor_id` (`receptor_id`);

--
-- Indices de la tabla `folders`
--
ALTER TABLE `folders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `receptor_id` (`receptor_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `files`
--
ALTER TABLE `files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `folders`
--
ALTER TABLE `folders`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_ibfk_1` FOREIGN KEY (`receptor_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `folders`
--
ALTER TABLE `folders`
  ADD CONSTRAINT `folders_ibfk_1` FOREIGN KEY (`receptor_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
