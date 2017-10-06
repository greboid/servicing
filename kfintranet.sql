DROP TABLE IF EXISTS `contractors`;
CREATE TABLE `contractors` (
  `contractor_id` int(11) NOT NULL AUTO_INCREMENT,
  `contractor_name` varchar(100) DEFAULT NULL,
  `contractor_phone` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`contractor_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `contracts`;
CREATE TABLE `contracts` (
  `contract_id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_contractor` int(11) NOT NULL,
  `contract_start` date NOT NULL,
  `contract_end` date NOT NULL,
  `contract_notes` text,
  PRIMARY KEY (`contract_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `intervals`;
CREATE TABLE `intervals` (
  `intervals_id` int(11) NOT NULL AUTO_INCREMENT,
  `intervals_name` varchar(255) NOT NULL,
  `intervals_months` int(11) NOT NULL,
  PRIMARY KEY (`intervals_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
LOCK TABLES `intervals` WRITE;
insert  into `intervals`(`intervals_id`,`intervals_name`,`intervals_months`) values (6,'Weekly',0),(7,'Monthly',1),(8,'Quarterly',4),(9,'Biannually',6),(10,'Annually',12),(11,'Biennially',24),(12,'Triennially',36),(13,'Quadrennially',48),(14,'Pentennially',60),(15,'Sexennial',72),(16,'Septennial',84),(17,'Octennial',96),(18,'Novennial',108),(19,'Decennial',120),(20,'Sesquiannual',18);
UNLOCK TABLES;

DROP TABLE IF EXISTS `item_types`;
CREATE TABLE `item_types` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_type` int(11) NOT NULL,
  `item_location` int(11) NOT NULL,
  `item_site` int(11) NOT NULL,
  `item_contract` int(11) DEFAULT NULL,
  `item_interval` int(11) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `item_notes` text,
  PRIMARY KEY (`item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `locations`;
CREATE TABLE `locations` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_site` int(11) NOT NULL,
  `location_name` varchar(255) NOT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `services`;
CREATE TABLE `services` (
  `service_id` int(11) NOT NULL AUTO_INCREMENT,
  `service_item` int(11) NOT NULL,
  `service_date` date NOT NULL,
  `service_notes` text NOT NULL,
  PRIMARY KEY (`service_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `servicing`;
CREATE TABLE `servicing` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Location` int(11) NOT NULL,
  `Item` varchar(30) DEFAULT NULL,
  `Type` int(11) NOT NULL,
  `Contractor` int(11) NOT NULL,
  `Interval` varchar(20) DEFAULT NULL,
  `Last Serviced` date DEFAULT NULL,
  `Next Due` date DEFAULT NULL,
  `SiteID` int(11) NOT NULL,
  KEY `ID` (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `sites`;
CREATE TABLE `sites` (
  `site_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_name` varchar(255) NOT NULL,
  PRIMARY KEY (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
