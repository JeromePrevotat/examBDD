-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour gastronomy
CREATE DATABASE IF NOT EXISTS `gastronomy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gastronomy`;

-- Listage de la structure de table gastronomy. chefs
CREATE TABLE IF NOT EXISTS `chefs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `restaurant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `chefs_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table gastronomy.chefs : ~6 rows (environ)
INSERT INTO `chefs` (`id`, `name`, `restaurant_id`) VALUES
	(1, 'Pierre Dubois', 1),
	(2, 'Giulia Romano', 2),
	(3, 'Haruto Tanaka', 3),
	(4, 'Carlos Rodriguez', 4),
	(5, 'Aisha Khan', 5),
	(6, 'John Smith', 6);

-- Listage de la structure de table gastronomy. dishes
CREATE TABLE IF NOT EXISTS `dishes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `chef_id` int DEFAULT NULL,
  `price` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chef_id` (`chef_id`),
  CONSTRAINT `dishes_ibfk_1` FOREIGN KEY (`chef_id`) REFERENCES `chefs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table gastronomy.dishes : ~11 rows (environ)
INSERT INTO `dishes` (`id`, `name`, `chef_id`, `price`) VALUES
	(1, 'Bœuf Bourguignon', 1, 25.00),
	(2, 'Risotto ai Funghi', 2, 18.50),
	(3, 'Sushi Moriawase', 3, 30.00),
	(4, 'Asado', 4, 35.00),
	(5, 'Chicken Tikka Masala', 5, 15.50),
	(6, 'Classic Cheeseburger', 6, 12.00),
	(7, 'Coq au Vin', 1, 27.00),
	(8, 'Pizza Margherita', 2, 16.00),
	(9, 'Tempura Udon', 3, 22.00),
	(10, 'Empanadas', 4, 10.00),
	(11, 'Palak Paneer', 5, 14.00);

-- Listage de la structure de table gastronomy. ingredients
CREATE TABLE IF NOT EXISTS `ingredients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dish_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dish_id` (`dish_id`),
  CONSTRAINT `ingredients_ibfk_1` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table gastronomy.ingredients : ~29 rows (environ)
INSERT INTO `ingredients` (`id`, `name`, `dish_id`) VALUES
	(1, 'Bœuf', 1),
	(2, 'Champignons', 2),
	(3, 'Riz à Sushi', 3),
	(4, 'Viande de bœuf', 4),
	(5, 'Poulet', 5),
	(6, 'Bœuf haché', 6),
	(7, 'Poulet', 7),
	(8, 'Tomates', 8),
	(9, 'Nouilles Udon', 9),
	(10, 'Viande hachée', 10),
	(11, 'Épinards', 11),
	(13, 'Vin rouge', 1),
	(14, 'Lardons', 1),
	(15, 'Carottes', 1),
	(16, 'Riz Arborio', 2),
	(17, 'Parmesan', 2),
	(18, 'Vin blanc', 2),
	(19, 'Poisson', 3),
	(20, 'Algues', 3),
	(21, 'Wasabi', 3),
	(22, 'Chimichurri', 4),
	(23, 'Sel', 4),
	(24, 'Poivre', 4),
	(25, 'Yaourt', 5),
	(26, 'Garam Masala', 5),
	(27, 'Tomates', 5),
	(28, 'Pain à burger', 6),
	(29, 'Fromage Cheddar', 6),
	(30, 'Salade', 6);

-- Listage de la structure de table gastronomy. restaurants
CREATE TABLE IF NOT EXISTS `restaurants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `cuisine_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table gastronomy.restaurants : ~6 rows (environ)
INSERT INTO `restaurants` (`id`, `name`, `location`, `cuisine_type`) VALUES
	(1, 'Le Gourmet Parisien', 'Paris, France', 'Française'),
	(2, 'Sapore Italiano', 'Rome, Italie', 'Italienne'),
	(3, 'Sushi Master', 'Tokyo, Japon', 'Japonaise'),
	(4, 'El Asador Patagonico', 'Buenos Aires, Argentine', 'Argentine'),
	(5, 'The Curry House', 'Londres, Royaume-Uni', 'Indienne'),
	(6, 'Burger Town', 'New York, États-Unis', 'Américaine');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
