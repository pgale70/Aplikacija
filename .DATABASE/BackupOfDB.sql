/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `aplikacija`;
CREATE DATABASE IF NOT EXISTS `aplikacija` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `aplikacija`;

DROP TABLE IF EXISTS `administrator`;
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL DEFAULT '0',
  `password_hash` varchar(128) NOT NULL DEFAULT '0',
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `uq_administrator_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `administrator`;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(1, 'neko1', '0EEE5A71EA54421C52851153E86F726BD4821199AC46BCC832827E6C6D777DD32A81D7ED64AB8E2A2F62CC33A1A9C9A95B0604E51EE57397785F8F5B276666BE'),
	(2, 'neko2', '65A6D3DA2F512FAF83E196F3EE61C425F6DD51096F95FBC9998FE19F56A959DE0E2A39831EF8C9514932E2E503793D3D770D4FD0170BB0EB65BEDFE1DBF0DC84'),
	(3, 'neko3', 'D90FBB011D1AD49AFFB02E49880A042C0F62E4BC149B0CAFC95F97CB0727EA1F041D529380AA6DD7D02E522A020FEAC01C7654643C410FA4DEA0C8D855591E4F'),
	(4, 'neko4', 'BB753F34161A58B8A89ED84A66C9954A4679D1CF0E1354913B114946843C08A32E782781B021EDC7B4DCF65B01382128AE7E4DE29A254D13EC6E3E9A3CE5529B'),
	(5, 'neko5', 'A479B404FBEA5257F4BFBFBBA05238CA3819387964C273572CFC34A91EE222C8413E74C24FDC0DC36240E437799AAE530F1C576198784795311F6EC234FDB84F'),
	(6, 'pedja', 'F2C8AD06FB46DDAF5310230D7481B954E8219661DC6ED51D179DA14B57EDE2F324CF9D95C6DBB5E651FBD541F2E97F44CCC5D295D61FFBAA8C2C017667DA0FE2'),
	(9, 'bojan', 'F2C8AD06FB46DDAF5310230D7481B954E8219661DC6ED51D179DA14B57EDE2F324CF9D95C6DBB5E651FBD541F2E97F44CCC5D295D61FFBAA8C2C017667DA0FE2'),
	(11, 'jovana', '1EC3CC11B7526207A0BD1A049DA5B46ECFA2A7702FC8A3254B3B4B61484BD5F63B9387BC58047006F5A16A6D134EC0A4546FC62620297B6812B52C53B6715122'),
	(13, 'mirko', '1EC3CC11B7526207A0BD1A049DA5B46ECFA2A7702FC8A3254B3B4B61484BD5F63B9387BC58047006F5A16A6D134EC0A4546FC62620297B6812B52C53B6715122'),
	(16, 'admin', 'C7AD44CBAD762A5DA0A452F9E854FDC1E0E7A52A38015F23F3EAB1D80B931DD472634DFAC71CD34EBC35D16AB7FB8A90C81F975113D6C7538DC69DD8DE9077EC'),
	(17, 'admin1', '58B5444CF1B6253A4317FE12DAFF411A78BDA0A95279B1D5768EBF5CA60829E78DA944E8A9160A0B6D428CB213E813525A72650DAC67B88879394FF624DA482F'),
	(18, 'admin2', '661BB43140229AD4DC3E762E7BDD68CC14BB9093C158C386BD989FEA807ACD9BD7F805CA4736B870B6571594D0D8FCFC57B98431143DFB770E083FA9BE89BC72'),
	(19, 'admin4', '1BEE03396CC6C1C645B61C6AC87A941E7ABF5E42CE5B6CA5927B2013362756FFB4934326EBA570CA34CD4521E5AC02A31DD9FCD1BD11268A7345DED443DA1DD6');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  `excerpt` varchar(255) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `status` enum('available','visible','hidden') NOT NULL DEFAULT 'available',
  `is_promoted` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_id`),
  KEY `fk_article_category_id` (`category_id`),
  CONSTRAINT `fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `article`;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` (`article_id`, `name`, `category_id`, `excerpt`, `description`, `status`, `is_promoted`, `created_at`) VALUES
	(1, 'IBM HDD', 5, 'Kratak opis ...', 'Duži opis ....', 'available', 0, '2022-01-21 20:08:00'),
	(2, 'Lenovo HDD 1TB', 5, 'Neki kratak tekst...', 'Neki malo duži tekst...', 'available', 0, '2022-01-21 22:56:39'),
	(3, 'IBM HDD 1TB', 5, 'Neki kratak tekst...', 'Neki malo duži tekst...', 'available', 0, '2022-01-21 23:03:13'),
	(4, 'IBM HDD 1TB', 5, 'Neki kratak tekst...', 'Neki malo duži tekst...', 'available', 0, '2022-01-21 23:07:27'),
	(5, 'Novi naziv1', 5, 'Neki novi kratak tekst.....', 'Neki novi opis .....', 'visible', 1, '2022-01-21 23:19:18'),
	(9, 'Stick21', 5, 'Neki kratak tekst.sssss..', 'Neki malo duži tekst..sssssss.', 'available', 0, '2022-01-26 06:56:53'),
	(10, 'RAM taj i taj', 5, 'Neki kratak tekst.sssss..', 'Neki malo duži tekst..sssssss.', 'available', 0, '2022-01-26 06:57:12'),
	(11, 'RAM taj i taj', 5, 'Neki kratak tekst.sssss..', 'Neki malo duži tekst..sssssss.', 'available', 0, '2022-01-26 10:40:14');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;

DROP TABLE IF EXISTS `article_feature`;
CREATE TABLE IF NOT EXISTS `article_feature` (
  `article_feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `feature_id` int unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`article_feature_id`),
  UNIQUE KEY `uq_article_feature_article_id_feature_id` (`article_id`,`feature_id`),
  KEY `fk_article_feature_feature_id` (`feature_id`),
  CONSTRAINT `fk_article_feature_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_article_feature_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `article_feature`;
/*!40000 ALTER TABLE `article_feature` DISABLE KEYS */;
INSERT INTO `article_feature` (`article_feature_id`, `article_id`, `feature_id`, `value`) VALUES
	(1, 1, 1, '512'),
	(2, 1, 2, 'ATA'),
	(3, 1, 3, 'SSD'),
	(4, 2, 1, '1TB'),
	(5, 2, 3, 'SSD'),
	(6, 3, 3, 'SSD'),
	(7, 3, 1, '1TB'),
	(8, 4, 3, 'SSD'),
	(9, 4, 1, '1TB'),
	(12, 5, 1, 'Nova vrijednost'),
	(13, 5, 2, 'Novija vrijednost'),
	(20, 9, 1, '1TB'),
	(21, 9, 3, 'SSD'),
	(22, 10, 1, '1TB'),
	(23, 10, 3, 'SSD'),
	(24, 11, 1, '1TB'),
	(25, 11, 3, 'SSD');
/*!40000 ALTER TABLE `article_feature` ENABLE KEYS */;

DROP TABLE IF EXISTS `article_price`;
CREATE TABLE IF NOT EXISTS `article_price` (
  `article_price_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_price_id`),
  KEY `fk_article_price_article_id` (`article_id`),
  CONSTRAINT `fk_article_price_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `article_price`;
/*!40000 ALTER TABLE `article_price` DISABLE KEYS */;
INSERT INTO `article_price` (`article_price_id`, `article_id`, `price`, `created_at`) VALUES
	(1, 1, 45.00, '2022-01-21 20:56:53'),
	(2, 1, 47.00, '2022-01-21 20:57:06'),
	(3, 2, 56.87, '2022-01-21 22:56:39'),
	(4, 3, 56.87, '2022-01-21 23:03:13'),
	(5, 4, 56.00, '2022-01-21 23:07:27'),
	(6, 5, 56.00, '2022-01-21 23:19:18'),
	(7, 5, 25.50, '2022-01-23 20:45:09'),
	(8, 9, 56.87, '2022-01-26 06:56:53'),
	(9, 10, 56.87, '2022-01-26 06:57:12'),
	(10, 11, 56.87, '2022-01-26 10:40:14');
/*!40000 ALTER TABLE `article_price` ENABLE KEYS */;

DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `cart_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  KEY `fk_cart_user_id` (`user_id`),
  CONSTRAINT `fk_cart_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `cart`;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

DROP TABLE IF EXISTS `cart_article`;
CREATE TABLE IF NOT EXISTS `cart_article` (
  `cart_article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` int unsigned NOT NULL DEFAULT '0',
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `quantity` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`cart_article_id`),
  UNIQUE KEY `uq_cart_article_cart_id_article_id` (`cart_id`,`article_id`),
  KEY `fk_cart_article_article_id` (`article_id`),
  CONSTRAINT `fk_cart_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_article_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `cart_article`;
/*!40000 ALTER TABLE `cart_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_article` ENABLE KEYS */;

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '0',
  `image_path` varchar(128) NOT NULL DEFAULT '0',
  `parent__category_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_category_name` (`name`),
  UNIQUE KEY `uq_category_image_path` (`image_path`),
  KEY `fk_category_parent__category_id` (`parent__category_id`),
  CONSTRAINT `fk_category_parent__category_id` FOREIGN KEY (`parent__category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent__category_id`) VALUES
	(1, 'Rač. komponente', 'assets/pc.jpg', NULL),
	(2, 'Kućna elektronika', 'assts/home.jpg', NULL),
	(3, 'Laptop računari', 'assets/pc/laptop.jpg', 1),
	(4, 'Memorijski mediji', 'assets/pc/memory.jpg', 1),
	(5, 'Hard diskovi', 'assets/pc/memory/hdd.jpg', 4),
	(6, 'Hrana za mačke', './assets/images', NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

DROP TABLE IF EXISTS `feature`;
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `uq_feature_name_category_id` (`name`,`category_id`),
  KEY `fk_feature_category_id` (`category_id`),
  CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `feature`;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` (`feature_id`, `name`, `category_id`) VALUES
	(1, 'Kapacitet', 5),
	(4, 'Napon', 2),
	(10, 'Nešto peto', 2),
	(9, 'Nešto peto', 5),
	(7, 'Proizvodjac', 2),
	(6, 'Snaga', 2),
	(3, 'Tehnologija', 5),
	(2, 'Vrsta', 5),
	(8, 'Vrsta utičnice', 2);
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cart_id` int unsigned NOT NULL DEFAULT '0',
  `status` enum('rejected','accepted','shipped','pending') NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uq_order_cart_id` (`cart_id`),
  CONSTRAINT `fk_order_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `order`;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;

DROP TABLE IF EXISTS `photo`;
CREATE TABLE IF NOT EXISTS `photo` (
  `photo_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `image_path` varchar(128) NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `uq_photo_image_path` (`image_path`),
  KEY `fk_photo_article_id` (`article_id`),
  CONSTRAINT `fk_photo_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `photo`;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` (`photo_id`, `article_id`, `image_path`) VALUES
	(1, 1, 'images/1/front.jpg'),
	(2, 1, 'images/1/label.jpg'),
	(4, 2, '2022122-0976356064-mojaslika.jpg'),
	(7, 2, '2022123-9563931517-mojaslika.jpg');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '0',
  `password_hash` varchar(128) NOT NULL DEFAULT '0',
  `forename` varchar(64) NOT NULL DEFAULT '0',
  `surname` varchar(64) NOT NULL DEFAULT '0',
  `phone_number` varchar(24) NOT NULL DEFAULT '0',
  `postal_address` text NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_user_email` (`email`),
  UNIQUE KEY `uq_user_phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `email`, `password_hash`, `forename`, `surname`, `phone_number`, `postal_address`) VALUES
	(1, 'test@test.rs', 'B991F855E3AD0E00E7EA43F87A179209B5E31A2903F8F82A0B7B9B61E03115E723BBF1B8F6A4E7F0775209039810B0249717B70D85578496DA072AC8FC18D9F1', 'Pera', 'Peric', '+387658888', 'Gojsina bb'),
	(3, 'test1t@test.rs', '60E59F5B74E21E18E6FCF55D610A8FB88BC5A7E231B6975199A193F72C74297EB36C1248B4EDC0248011039C5B31B45DA7DC65A32EFA23F06CE0D952833A10B0', 'Mika', 'Mikic', '+387657788', 'Gomiljani bb'),
	(4, 'test2@test.rs', 'DDAF35A193617ABACC417349AE20413112E6FA4E89A97EA20A9EEEE64B55D39A2192992A274FC1A836BA3C23A3FEEBBD454D4423643CE80E2A9AC94FA54CA49F', 'Mika', 'Mikic', '+387666788', 'Gomiljani bb'),
	(5, 'pgale@teol.net', '1664B958A4812A1E15D051171785ED3291E27F51C66EA2E36962D15AAB6EABA0E2325B31FFC3823BFB87774255885AC4F71346D50582B1A4B40AAA427F7A1579', 'Pedja', 'Galic', '+38765903192', 'Gomiljani bb');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
