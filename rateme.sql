SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `rateme`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(30) DEFAULT NULL,
  `category_item_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`, `category_item_count`) VALUES
(2, 'Mobile Phone', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--

CREATE TABLE IF NOT EXISTS `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `feature`
--

CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int(11) NOT NULL AUTO_INCREMENT,
  `feature_name` varchar(20) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`feature_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `logins`
--

CREATE TABLE IF NOT EXISTS `logins` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id for logins sessions',
  `session_id` varchar(25) DEFAULT NULL COMMENT 'to hold the session id of the login session',
  `uname` varchar(30) DEFAULT NULL COMMENT 'to hold the logedin user name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(11) NOT NULL,
  `last_updated` date NOT NULL,
  `created_date` date NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `last_updated`, `created_date`, `category_id`) VALUES
(1, 'iphone 6', '2024-12-16', '2024-12-16', 2),
(2, 'nexus 5', '2024-12-12', '2024-12-12', 2);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE IF NOT EXISTS `review` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL DEFAULT '0',
  `created_date` varchar(200) DEFAULT NULL,
  `text` varchar(500) NOT NULL,
  `api` varchar(30) NOT NULL,
  `geo_location` varchar(50) DEFAULT NULL,
  `likes` int(11) NOT NULL DEFAULT '0',
  `final_sentiment` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8360 ;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`review_id`, `product_id`, `created_date`, `text`, `api`, `geo_location`, `likes`, `final_sentiment`) VALUES
(1, 1, '2024-12-16', 'Iphone is a good phone to but and best phone available in the market', 'twitter', 'Delhi', 120, ''),
(2, 1, '2024-12-16', 'iphone is a very not that good as a android device. same features as last year.', 'twitter', 'Mumbia', 1, ''),
(3, 1, '2024-12-16', 'this is very bad', 'twitter', 'Kolkata', 2, ''),
(4, 2, '2024-12-30', 'Nice', 'Twitter', 'Hyderabaad', 0, 'NU'),
(5, 2, '2024-12-30', 'WOW', 'Tweeter', 'NULL', 0, 'NU'),


-- --------------------------------------------------------

--
-- Table structure for table `review_feature`
--

CREATE TABLE IF NOT EXISTS `review_feature` (
  `reviewfeature_id` int(11) NOT NULL AUTO_INCREMENT,
  `feature` varchar(20) NOT NULL,
  `value` varchar(30) NOT NULL,
  `score` int(11) NOT NULL,
  `review_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`reviewfeature_id`),
  KEY `product_id` (`product_id`),
  KEY `review_id` (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id of the user record',
  `first_name` varchar(30) NOT NULL COMMENT 'name of the user',
  `uname` varchar(30) NOT NULL,
  `pword` varchar(25) NOT NULL,
  `salt` int(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `country` varchar(20) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `about` varchar(250) NOT NULL,
  `alternative_email` varchar(100) NOT NULL,
  `mobile_num` varchar(20) NOT NULL,
  `age` int(3) NOT NULL DEFAULT '0' COMMENT 'age of the user',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `feature`
--
ALTER TABLE `feature`
  ADD CONSTRAINT `feature_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Constraints for table `review_feature`
--
ALTER TABLE `review_feature`
  ADD CONSTRAINT `review_feature_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `review_feature_ibfk_2` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
