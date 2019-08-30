/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.7.22 : Database - seata
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`seata` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `seata`;

/*Table structure for table `account_tbl` */

DROP TABLE IF EXISTS `account_tbl`;

CREATE TABLE `account_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) DEFAULT NULL,
  `money` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `account_tbl` */

insert  into `account_tbl`(`id`,`user_id`,`money`) values (2,'U100000',1000);

/*Table structure for table `branch_table` */

DROP TABLE IF EXISTS `branch_table`;

CREATE TABLE `branch_table` (
  `branch_id` bigint(20) NOT NULL,
  `xid` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `transaction_id` bigint(20) DEFAULT NULL,
  `resource_group_id` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `resource_id` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lock_key` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `branch_type` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `client_id` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `application_data` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`branch_id`),
  KEY `idx_xid` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `branch_table` */

/*Table structure for table `global_table` */

DROP TABLE IF EXISTS `global_table`;

CREATE TABLE `global_table` (
  `xid` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `transaction_id` bigint(20) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `application_id` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_service_group` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timeout` int(11) DEFAULT NULL,
  `begin_time` bigint(20) DEFAULT NULL,
  `application_data` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`xid`),
  KEY `idx_gmt_modified_status` (`gmt_modified`,`status`),
  KEY `idx_transaction_id` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `global_table` */

/*Table structure for table `lock_table` */

DROP TABLE IF EXISTS `lock_table`;

CREATE TABLE `lock_table` (
  `row_key` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `xid` varchar(96) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_id` mediumtext COLLATE utf8_unicode_ci,
  `branch_id` mediumtext COLLATE utf8_unicode_ci,
  `resource_id` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `table_name` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pk` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`row_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `lock_table` */

/*Table structure for table `order_tbl` */

DROP TABLE IF EXISTS `order_tbl`;

CREATE TABLE `order_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) DEFAULT NULL,
  `commodity_code` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT '0',
  `money` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `order_tbl` */

insert  into `order_tbl`(`id`,`user_id`,`commodity_code`,`count`,`money`) values (1,'U100000','C100000',30,3000),(3,'U100000','C100000',30,3000),(4,'U100000','C100000',30,3000);

/*Table structure for table `storage_tbl` */

DROP TABLE IF EXISTS `storage_tbl`;

CREATE TABLE `storage_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commodity_code` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commodity_code` (`commodity_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `storage_tbl` */

insert  into `storage_tbl`(`id`,`commodity_code`,`count`) values (2,'C100000',110);

/*Table structure for table `undo_log` */

DROP TABLE IF EXISTS `undo_log`;

CREATE TABLE `undo_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `xid` varchar(100) NOT NULL,
  `context` varchar(128) NOT NULL,
  `rollback_info` longblob NOT NULL,
  `log_status` int(11) NOT NULL,
  `log_created` datetime NOT NULL,
  `log_modified` datetime NOT NULL,
  `ext` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `undo_log` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
