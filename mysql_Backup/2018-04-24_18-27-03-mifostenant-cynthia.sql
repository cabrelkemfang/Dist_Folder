-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: mifostenant-cynthia
-- ------------------------------------------------------
-- Server version	5.6.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `mifostenant-cynthia`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mifostenant-cynthia` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `mifostenant-cynthia`;

--
-- Table structure for table `Charges`
--

DROP TABLE IF EXISTS `Charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Charges` (
  `loan_id` bigint(20) NOT NULL,
  `Charges` text,
  PRIMARY KEY (`loan_id`),
  CONSTRAINT `fk_charges_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Charges`
--

LOCK TABLES `Charges` WRITE;
/*!40000 ALTER TABLE `Charges` DISABLE KEYS */;
/*!40000 ALTER TABLE `Charges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Marital Status`
--

DROP TABLE IF EXISTS `Marital Status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Marital Status` (
  `client_id` bigint(20) NOT NULL,
  `Marital Status` text,
  PRIMARY KEY (`client_id`),
  CONSTRAINT `fk_marital_status_client_id` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Marital Status`
--

LOCK TABLES `Marital Status` WRITE;
/*!40000 ALTER TABLE `Marital Status` DISABLE KEYS */;
/*!40000 ALTER TABLE `Marital Status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Member ID`
--

DROP TABLE IF EXISTS `Member ID`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Member ID` (
  `client_id` bigint(20) NOT NULL,
  `Member ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  CONSTRAINT `fk_member_id_client_id` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Member ID`
--

LOCK TABLES `Member ID` WRITE;
/*!40000 ALTER TABLE `Member ID` DISABLE KEYS */;
/*!40000 ALTER TABLE `Member ID` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_accounting_rule`
--

DROP TABLE IF EXISTS `acc_accounting_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_accounting_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `office_id` bigint(20) DEFAULT NULL,
  `debit_account_id` bigint(20) DEFAULT NULL,
  `allow_multiple_debits` tinyint(1) NOT NULL DEFAULT '0',
  `credit_account_id` bigint(20) DEFAULT NULL,
  `allow_multiple_credits` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(500) DEFAULT NULL,
  `system_defined` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounting_rule_name_unique` (`name`),
  KEY `FK_acc_accounting_rule_acc_gl_account_debit` (`debit_account_id`),
  KEY `FK_acc_accounting_rule_acc_gl_account_credit` (`credit_account_id`),
  KEY `FK_acc_accounting_rule_m_office` (`office_id`),
  CONSTRAINT `FK_acc_accounting_rule_acc_gl_account_credit` FOREIGN KEY (`credit_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_acc_accounting_rule_acc_gl_account_debit` FOREIGN KEY (`debit_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_acc_accounting_rule_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_accounting_rule`
--

LOCK TABLES `acc_accounting_rule` WRITE;
/*!40000 ALTER TABLE `acc_accounting_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_accounting_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_gl_account`
--

DROP TABLE IF EXISTS `acc_gl_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_gl_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `hierarchy` varchar(50) DEFAULT NULL,
  `gl_code` varchar(45) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `manual_journal_entries_allowed` tinyint(1) NOT NULL DEFAULT '1',
  `account_usage` tinyint(1) NOT NULL DEFAULT '2',
  `classification_enum` smallint(5) NOT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acc_gl_code` (`gl_code`),
  KEY `FK_ACC_0000000001` (`parent_id`),
  KEY `FKGLACC000000002` (`tag_id`),
  CONSTRAINT `FKGLACC000000002` FOREIGN KEY (`tag_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_ACC_0000000001` FOREIGN KEY (`parent_id`) REFERENCES `acc_gl_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_gl_account`
--

LOCK TABLES `acc_gl_account` WRITE;
/*!40000 ALTER TABLE `acc_gl_account` DISABLE KEYS */;
INSERT INTO `acc_gl_account` VALUES (1,'Cash at Hand',NULL,'.','507',0,1,1,1,NULL,'Cash at Hand'),(2,'Bank',NULL,'.','502',0,1,1,1,NULL,'Bank'),(3,'Cash',NULL,'.','500',0,1,2,1,NULL,'All Cash Accounts'),(4,'Account Payable',NULL,'.','400',0,1,2,2,NULL,'Account Payables'),(5,'Cheques Payable',4,'.5.','401',0,1,1,2,NULL,'Cheques Payables'),(6,'Funding Account',NULL,'.','100',0,1,2,3,NULL,'Main Funding Account'),(7,'Loan Funding',6,'.7.','101',0,1,1,3,NULL,'Loan Funding Account'),(8,'Operating Income',NULL,'.','700',0,1,2,4,NULL,'Operating Income'),(9,'Income from loans',8,'.9.','701',0,1,1,4,NULL,'Income from loans'),(10,'Investment Income',8,'.10.','702',0,1,1,4,NULL,'Investment Income'),(11,'Fees and Charges',8,'.11.','703',0,1,1,4,NULL,'Fees and Charges'),(12,'Operating Expenses',NULL,'.','600',0,1,2,5,NULL,'Operating Expenses'),(13,'Stationary expenses',12,'.13.','601',0,1,1,5,NULL,'Stationary Expenses'),(14,'Depreciation expense',12,'.14.','602',0,1,1,5,NULL,'Depreciation expenses'),(15,'Other expenses',12,'.15.','603',0,1,1,5,NULL,'Other Expenses'),(16,'Other Income',8,'.16.','704',0,1,1,4,NULL,'Other Income'),(17,'Teller',3,'.17.','503',0,1,1,1,NULL,'Teller transactions'),(18,'Vault',3,'.18.','505',0,1,1,1,NULL,'Vault transaction'),(19,'Fixed Asset',NULL,'.','510',0,1,2,1,NULL,'Fixed Assets'),(20,'Office Equipment',19,'.20.','511',0,1,1,1,NULL,'Office Equipment'),(21,'Fixtures and Fittings',19,'.21.','512',0,1,1,1,NULL,'Fixtures and Fittings'),(22,'Receivables',NULL,'.','520',0,1,2,1,NULL,'Account Receivables'),(23,'Account Receivables',22,'.23.','521',0,1,1,1,NULL,'Account  Receivables'),(24,'Cheques Receivables',22,'.24.','522',0,1,1,1,NULL,'Cheques Receivables'),(25,'Member Loans',NULL,'.','530',0,1,2,1,NULL,'Member Loans'),(26,'Consumer Loans',25,'.26.','531',0,1,1,1,NULL,'Consumer Loans'),(27,'Business Loans',25,'.27.','532',0,1,1,1,NULL,'Business Loans');
/*!40000 ALTER TABLE `acc_gl_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_gl_closure`
--

DROP TABLE IF EXISTS `acc_gl_closure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_gl_closure` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `office_id` bigint(20) NOT NULL,
  `closing_date` date NOT NULL,
  `is_deleted` int(20) NOT NULL DEFAULT '0',
  `createdby_id` bigint(20) DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `comments` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `office_id_closing_date` (`office_id`,`closing_date`),
  KEY `FK_acc_gl_closure_m_office` (`office_id`),
  KEY `FK_acc_gl_closure_m_appuser` (`createdby_id`),
  KEY `FK_acc_gl_closure_m_appuser_2` (`lastmodifiedby_id`),
  CONSTRAINT `FK_acc_gl_closure_m_appuser` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_closure_m_appuser_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_closure_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_gl_closure`
--

LOCK TABLES `acc_gl_closure` WRITE;
/*!40000 ALTER TABLE `acc_gl_closure` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_gl_closure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_gl_financial_activity_account`
--

DROP TABLE IF EXISTS `acc_gl_financial_activity_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_gl_financial_activity_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gl_account_id` bigint(20) NOT NULL DEFAULT '0',
  `financial_activity_type` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `financial_activity_type` (`financial_activity_type`),
  KEY `FK_office_mapping_acc_gl_account` (`gl_account_id`),
  CONSTRAINT `FK_office_mapping_acc_gl_account` FOREIGN KEY (`gl_account_id`) REFERENCES `acc_gl_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_gl_financial_activity_account`
--

LOCK TABLES `acc_gl_financial_activity_account` WRITE;
/*!40000 ALTER TABLE `acc_gl_financial_activity_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_gl_financial_activity_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_gl_journal_entry`
--

DROP TABLE IF EXISTS `acc_gl_journal_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_gl_journal_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `reversal_id` bigint(20) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `transaction_id` varchar(50) NOT NULL,
  `loan_transaction_id` bigint(20) DEFAULT NULL,
  `savings_transaction_id` bigint(20) DEFAULT NULL,
  `client_transaction_id` bigint(20) DEFAULT NULL,
  `reversed` tinyint(1) NOT NULL DEFAULT '0',
  `ref_num` varchar(100) DEFAULT NULL,
  `manual_entry` tinyint(1) NOT NULL DEFAULT '0',
  `entry_date` date NOT NULL,
  `type_enum` smallint(5) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `entity_type_enum` smallint(5) DEFAULT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  `is_running_balance_calculated` tinyint(4) NOT NULL DEFAULT '0',
  `office_running_balance` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `organization_running_balance` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `payment_details_id` bigint(20) DEFAULT NULL,
  `share_transaction_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_acc_gl_journal_entry_m_office` (`office_id`),
  KEY `FK_acc_gl_journal_entry_m_appuser` (`createdby_id`),
  KEY `FK_acc_gl_journal_entry_m_appuser_2` (`lastmodifiedby_id`),
  KEY `FK_acc_gl_journal_entry_acc_gl_journal_entry` (`reversal_id`),
  KEY `FK_acc_gl_journal_entry_acc_gl_account` (`account_id`),
  KEY `FK_acc_gl_journal_entry_m_loan_transaction` (`loan_transaction_id`),
  KEY `FK_acc_gl_journal_entry_m_savings_account_transaction` (`savings_transaction_id`),
  KEY `FK_acc_gl_journal_entry_m_payment_detail` (`payment_details_id`),
  KEY `FK_acc_gl_journal_entry_m_client_transaction` (`client_transaction_id`),
  KEY `FK_acc_gl_journal_entry_m_share_account_transaction` (`share_transaction_id`),
  CONSTRAINT `FK_acc_gl_journal_entry_acc_gl_account` FOREIGN KEY (`account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_acc_gl_journal_entry` FOREIGN KEY (`reversal_id`) REFERENCES `acc_gl_journal_entry` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_appuser` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_appuser_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_client_transaction` FOREIGN KEY (`client_transaction_id`) REFERENCES `m_client_transaction` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_loan_transaction` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_payment_detail` FOREIGN KEY (`payment_details_id`) REFERENCES `m_payment_detail` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_savings_account_transaction` FOREIGN KEY (`savings_transaction_id`) REFERENCES `m_savings_account_transaction` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_share_account_transaction` FOREIGN KEY (`share_transaction_id`) REFERENCES `m_share_account_transactions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_gl_journal_entry`
--

LOCK TABLES `acc_gl_journal_entry` WRITE;
/*!40000 ALTER TABLE `acc_gl_journal_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_gl_journal_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_product_mapping`
--

DROP TABLE IF EXISTS `acc_product_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_product_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gl_account_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `product_type` smallint(5) DEFAULT NULL,
  `payment_type` int(11) DEFAULT NULL,
  `charge_id` bigint(20) DEFAULT NULL,
  `financial_account_type` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_acc_product_mapping_m_charge` (`charge_id`),
  KEY `FK_acc_product_mapping_m_payment_type` (`payment_type`),
  CONSTRAINT `FK_acc_product_mapping_m_charge` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `FK_acc_product_mapping_m_payment_type` FOREIGN KEY (`payment_type`) REFERENCES `m_payment_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_product_mapping`
--

LOCK TABLES `acc_product_mapping` WRITE;
/*!40000 ALTER TABLE `acc_product_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_product_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_rule_tags`
--

DROP TABLE IF EXISTS `acc_rule_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_rule_tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `acc_rule_id` bigint(20) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `acc_type_enum` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE_ACCOUNT_RULE_TAGS` (`acc_rule_id`,`tag_id`,`acc_type_enum`),
  KEY `FK_acc_accounting_rule_id` (`acc_rule_id`),
  KEY `FK_m_code_value_id` (`tag_id`),
  CONSTRAINT `FK_acc_accounting_rule_id` FOREIGN KEY (`acc_rule_id`) REFERENCES `acc_accounting_rule` (`id`),
  CONSTRAINT `FK_m_code_value_id` FOREIGN KEY (`tag_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_rule_tags`
--

LOCK TABLES `acc_rule_tags` WRITE;
/*!40000 ALTER TABLE `acc_rule_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_rule_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_account_number_format`
--

DROP TABLE IF EXISTS `c_account_number_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_account_number_format` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_type_enum` smallint(1) NOT NULL,
  `prefix_type_enum` smallint(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_type_enum` (`account_type_enum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_account_number_format`
--

LOCK TABLES `c_account_number_format` WRITE;
/*!40000 ALTER TABLE `c_account_number_format` DISABLE KEYS */;
/*!40000 ALTER TABLE `c_account_number_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_cache`
--

DROP TABLE IF EXISTS `c_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_cache` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cache_type_enum` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_cache`
--

LOCK TABLES `c_cache` WRITE;
/*!40000 ALTER TABLE `c_cache` DISABLE KEYS */;
INSERT INTO `c_cache` VALUES (1,1);
/*!40000 ALTER TABLE `c_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_configuration`
--

DROP TABLE IF EXISTS `c_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `date_value` date DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_trap_door` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_configuration`
--

LOCK TABLES `c_configuration` WRITE;
/*!40000 ALTER TABLE `c_configuration` DISABLE KEYS */;
INSERT INTO `c_configuration` VALUES (1,'maker-checker',NULL,NULL,0,0,NULL),(4,'amazon-S3',NULL,NULL,0,0,NULL),(5,'reschedule-future-repayments',NULL,NULL,1,0,NULL),(6,'reschedule-repayments-on-holidays',NULL,NULL,0,0,NULL),(7,'allow-transactions-on-holiday',NULL,NULL,0,0,NULL),(8,'allow-transactions-on-non_workingday',NULL,NULL,0,0,NULL),(9,'constraint_approach_for_datatables',NULL,NULL,0,0,NULL),(10,'penalty-wait-period',2,NULL,1,0,NULL),(11,'force-password-reset-days',0,NULL,0,0,NULL),(12,'grace-on-penalty-posting',0,NULL,1,0,NULL),(15,'savings-interest-posting-current-period-end',NULL,NULL,0,0,'Recommended to be changed only once during start of production. When set as false(default), interest will be posted on the first date of next period. If set as true, interest will be posted on last date of current period. There is no difference in the interest amount posted.'),(16,'financial-year-beginning-month',1,NULL,1,0,'Recommended to be changed only once during start of production. Allowed values 1 - 12 (January - December). Interest posting periods are evaluated based on this configuration.'),(17,'min-clients-in-group',5,NULL,0,0,'Minimum number of Clients that a Group should have'),(18,'max-clients-in-group',5,NULL,0,0,'Maximum number of Clients that a Group can have'),(19,'meetings-mandatory-for-jlg-loans',NULL,NULL,0,0,'Enforces all JLG loans to follow a meeting schedule belonging to parent group or Center'),(20,'office-specific-products-enabled',0,NULL,0,0,'Whether products and fees should be office specific or not? This property should NOT be changed once Mifos is Live.'),(21,'restrict-products-to-user-office',0,NULL,0,0,'This should be enabled only if, products & fees are office specific (i.e. office-specific-products-enabled is enabled). This property specifies if the products should be auto-restricted to office of the user who created the proudct? Note: This property should NOT be changed once Mifos is Live.'),(22,'office-opening-balances-contra-account',0,NULL,1,0,NULL),(23,'rounding-mode',6,NULL,1,1,'0 - UP, 1 - DOWN, 2- CEILING, 3- FLOOR, 4- HALF_UP, 5- HALF_DOWN, 6 - HALF_EVEN'),(24,'backdate-penalties-enabled',0,NULL,1,0,'If this parameter is disabled penalties will only be added to instalments due moving forward, any old overdue instalments will not be affected.'),(25,'organisation-start-date',0,NULL,0,0,NULL),(26,'paymenttype-applicable-for-disbursement-charges',NULL,NULL,0,0,'Is the Disbursement Entry need to be considering the fund source of the paymnet type'),(27,'interest-charged-from-date-same-as-disbursal-date',0,NULL,0,0,NULL),(28,'skip-repayment-on-first-day-of-month',14,NULL,0,0,'skipping repayment on first day of month'),(29,'change-emi-if-repaymentdate-same-as-disbursementdate',0,NULL,1,0,'In tranche loans, if repayment date is same as tranche disbursement date then allow to change the emi amount'),(30,'daily-tpt-limit',0,NULL,0,0,'Daily limit for third party transfers'),(31,'Enable-Address',NULL,NULL,0,0,NULL);
/*!40000 ALTER TABLE `c_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_external_service`
--

DROP TABLE IF EXISTS `c_external_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_external_service` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_external_service`
--

LOCK TABLES `c_external_service` WRITE;
/*!40000 ALTER TABLE `c_external_service` DISABLE KEYS */;
INSERT INTO `c_external_service` VALUES (3,'MESSAGE_GATEWAY'),(4,'NOTIFICATION'),(1,'S3'),(2,'SMTP_Email_Account');
/*!40000 ALTER TABLE `c_external_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_external_service_properties`
--

DROP TABLE IF EXISTS `c_external_service_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_external_service_properties` (
  `name` varchar(150) NOT NULL,
  `value` varchar(250) DEFAULT NULL,
  `external_service_id` bigint(20) NOT NULL,
  KEY `FK_c_external_service_properties_c_external_service` (`external_service_id`),
  CONSTRAINT `FK_c_external_service_properties_c_external_service` FOREIGN KEY (`external_service_id`) REFERENCES `c_external_service` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_external_service_properties`
--

LOCK TABLES `c_external_service_properties` WRITE;
/*!40000 ALTER TABLE `c_external_service_properties` DISABLE KEYS */;
INSERT INTO `c_external_service_properties` VALUES ('s3_access_key',NULL,1),('s3_bucket_name',NULL,1),('s3_secret_key',NULL,1),('username','support@cloudmicrofinance.com',2),('password','support81',2),('host','smtp.gmail.com',2),('port','25',2),('useTLS','true',2),('host_name','localhost',3),('port_number','9191',3),('end_point','/',3),('tenant_app_key',NULL,3),('server_key','AAAAToBmqQQ:APA91bEodkE12CwFl8VHqanUbeJYg1E05TiheVz59CZZYrBnCq3uM40UYhHfdP-JfeTQ0L0zoLqS8orjvW_ze0_VF8DSuyyqkrDibflhtUainsI0lwgVz5u1YP3q3c3erqjlySEuRShS',4),('gcm_end_point','https://gcm-http.googleapis.com/gcm/send',4),('fcm_end_point','https://fcm.googleapis.com/fcm/send',4);
/*!40000 ALTER TABLE `c_external_service_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_device_registration`
--

DROP TABLE IF EXISTS `client_device_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_device_registration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `updatedon_date` datetime NOT NULL,
  `registration_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `registration_key_client_device_registration` (`registration_id`),
  UNIQUE KEY `client_key_client_device_registration` (`client_id`),
  KEY `FK1_client_device_registration_m_client` (`client_id`),
  CONSTRAINT `FK1_client_device_registration_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_device_registration`
--

LOCK TABLES `client_device_registration` WRITE;
/*!40000 ALTER TABLE `client_device_registration` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_device_registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fgfg`
--

DROP TABLE IF EXISTS `fgfg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fgfg` (
  `client_id` bigint(20) NOT NULL,
  `fgfg` varchar(525) DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  CONSTRAINT `fk_fgfg_client_id` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fgfg`
--

LOCK TABLES `fgfg` WRITE;
/*!40000 ALTER TABLE `fgfg` DISABLE KEYS */;
/*!40000 ALTER TABLE `fgfg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `cron_expression` varchar(20) CHARACTER SET latin1 NOT NULL,
  `create_time` datetime NOT NULL,
  `task_priority` smallint(6) NOT NULL DEFAULT '5',
  `group_name` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `previous_run_start_time` datetime DEFAULT NULL,
  `next_run_time` datetime DEFAULT NULL,
  `job_key` varchar(500) DEFAULT NULL,
  `initializing_errorlog` text,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `currently_running` tinyint(1) NOT NULL DEFAULT '0',
  `updates_allowed` tinyint(1) NOT NULL DEFAULT '1',
  `scheduler_group` smallint(2) NOT NULL DEFAULT '0',
  `is_misfired` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES (1,'Update loan Summary','Update loan Summary','0 0 22 1/1 * ? *','2018-04-16 11:50:31',5,NULL,'2018-04-23 21:00:00','2018-04-24 21:00:00','Update loan SummaryJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(2,'Update Loan Arrears Ageing','Update Loan Arrears Ageing','0 1 0 1/1 * ? *','2018-04-16 11:50:31',5,NULL,'2018-04-23 23:01:00','2018-04-24 23:01:00','Update Loan Arrears AgeingJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(3,'Update Loan Paid In Advance','Update Loan Paid In Advance','0 5 0 1/1 * ? *','2018-04-16 11:50:31',5,NULL,'2018-04-23 23:05:00','2018-04-24 23:05:00','Update Loan Paid In AdvanceJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(4,'Apply Annual Fee For Savings','Apply Annual Fee For Savings','0 20 22 1/1 * ? *','2018-04-16 11:50:31',5,NULL,'2018-04-23 21:20:00','2018-04-24 21:20:00','Apply Annual Fee For SavingsJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(5,'Apply Holidays To Loans','Apply Holidays To Loans','0 0 12 * * ?','2018-04-16 11:50:31',5,NULL,'2018-04-24 11:00:00','2018-04-25 11:00:00','Apply Holidays To LoansJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(6,'Post Interest For Savings','Post Interest For Savings','0 0 0 1/1 * ? *','2018-04-16 11:50:34',5,NULL,'2018-04-23 23:00:00','2018-04-24 23:00:00','Post Interest For SavingsJobDetail3 _ DEFAULT',NULL,1,0,1,1,0),(7,'Transfer Fee For Loans From Savings','Transfer Fee For Loans From Savings','0 1 0 1/1 * ? *','2018-04-16 11:50:39',5,NULL,'2018-04-23 23:01:00','2018-04-24 23:01:00','Transfer Fee For Loans From SavingsJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(8,'Pay Due Savings Charges','Pay Due Savings Charges','0 0 12 * * ?','2013-09-23 00:00:00',5,NULL,'2018-04-24 11:00:00','2018-04-25 11:00:00','Pay Due Savings ChargesJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(9,'Update Accounting Running Balances','Update Accounting Running Balances','0 1 0 1/1 * ? *','2018-04-16 11:50:41',5,NULL,'2018-04-23 23:01:00','2018-04-24 23:01:00','Update Accounting Running BalancesJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(10,'Execute Standing Instruction','Execute Standing Instruction','0 0 0 1/1 * ? *','2018-04-16 11:50:48',5,NULL,'2018-04-23 23:00:00','2018-04-24 23:00:00','Execute Standing InstructionJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(11,'Add Accrual Transactions','Add Accrual Transactions','0 1 0 1/1 * ? *','2018-04-16 11:50:49',3,NULL,'2018-04-23 23:01:00','2018-04-24 23:01:00','Add Accrual TransactionsJobDetail3 _ DEFAULT',NULL,1,0,1,3,0),(12,'Apply penalty to overdue loans','Apply penalty to overdue loans','0 0 0 1/1 * ? *','2018-04-16 11:50:49',5,NULL,'2018-04-23 23:00:00','2018-04-24 23:00:00','Apply penalty to overdue loansJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(13,'Update Non Performing Assets','Update Non Performing Assets','0 0 0 1/1 * ? *','2018-04-16 11:50:49',6,NULL,'2018-04-23 23:00:00','2018-04-24 23:00:00','Update Non Performing AssetsJobDetail3 _ DEFAULT',NULL,1,0,1,3,0),(14,'Transfer Interest To Savings','Transfer Interest To Savings','0 2 0 1/1 * ? *','2018-04-16 11:50:50',4,NULL,'2018-04-23 23:02:00','2018-04-24 23:02:00','Transfer Interest To SavingsJobDetail3 _ DEFAULT',NULL,1,0,1,1,0),(15,'Update Deposit Accounts Maturity details','Update Deposit Accounts Maturity details','0 0 0 1/1 * ? *','2018-04-16 11:50:50',5,NULL,'2018-04-23 23:00:00','2018-04-24 23:00:00','Update Deposit Accounts Maturity detailsJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(16,'Add Periodic Accrual Transactions','Add Periodic Accrual Transactions','0 2 0 1/1 * ? *','2018-04-16 11:50:53',2,NULL,'2018-04-23 23:02:00','2018-04-24 23:02:00','Add Periodic Accrual TransactionsJobDetail3 _ DEFAULT',NULL,1,0,1,3,0),(17,'Recalculate Interest For Loans','Recalculate Interest For Loans','0 1 0 1/1 * ? *','2018-04-16 11:50:54',4,NULL,'2018-04-23 23:01:00','2018-04-24 23:01:00','Recalculate Interest For LoansJobDetail3 _ DEFAULT',NULL,1,0,1,3,0),(18,'Generate Mandatory Savings Schedule','Generate Mandatory Savings Schedule','0 5 0 1/1 * ? *','2018-04-16 11:51:07',5,NULL,'2018-04-23 23:05:00','2018-04-24 23:05:00','Generate Mandatory Savings ScheduleJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(19,'Generate Loan Loss Provisioning','Generate Loan Loss Provisioning','0 0 0 1/1 * ? *','2018-04-16 11:51:23',5,NULL,'2018-04-23 23:00:00','2018-04-24 23:00:00','Generate Loan Loss ProvisioningJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(20,'Post Dividends For Shares','Post Dividends For Shares','0 0 0 1/1 * ? *','2018-04-16 11:51:27',5,NULL,'2018-04-23 23:00:00','2018-04-24 23:00:00','Post Dividends For SharesJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(21,'Update Savings Dormant Accounts','Update Savings Dormant Accounts','0 0 0 1/1 * ? *','2018-04-16 11:51:27',3,NULL,'2018-04-23 23:00:00','2018-04-24 23:00:00','Update Savings Dormant AccountsJobDetail3 _ DEFAULT',NULL,1,0,1,1,0),(22,'Add Accrual Transactions For Loans With Income Posted As Transactions','Add Accrual Transactions For Loans With Income Posted As Transactions','0 1 0 1/1 * ? *','2018-04-16 11:51:28',5,NULL,'2018-04-23 23:01:00','2018-04-24 23:01:00','Add Accrual Transactions For Loans With Income Posted As TransactionsJobDetail3 _ DEFAULT',NULL,1,0,1,3,0),(23,'Execute Report Mailing Jobs','Execute Report Mailing Jobs','0 0/15 * * * ?','2018-04-16 11:51:30',5,NULL,'2018-04-24 18:15:00','2018-04-24 18:30:00','Execute Report Mailing JobsJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(24,'Update SMS Outbound with Campaign Message','Update SMS Outbound with Campaign Message','0 0 5 1/1 * ? *','2018-04-16 11:51:31',3,NULL,'2018-04-24 04:00:00','2018-04-25 04:00:00','Update SMS Outbound with Campaign MessageJobDetail3 _ DEFAULT',NULL,1,0,1,4,0),(25,'Send Messages to SMS Gateway','Send Messages to SMS Gateway','0 0 5 1/1 * ? *','2018-04-16 11:51:31',2,NULL,'2018-04-24 04:00:00','2018-04-25 04:00:00','Send Messages to SMS GatewayJobDetail3 _ DEFAULT',NULL,1,0,1,4,0),(26,'Get Delivery Reports from SMS Gateway','Get Delivery Reports from SMS Gateway','0 0 5 1/1 * ? *','2018-04-16 11:51:31',1,NULL,'2018-04-24 04:00:00','2018-04-25 04:00:00','Get Delivery Reports from SMS GatewayJobDetail3 _ DEFAULT',NULL,1,0,1,4,0),(27,'Execute Email','Execute Email','0 0/10 * * * ?','2018-04-16 11:51:31',5,NULL,'2018-04-24 18:20:00','2018-04-24 18:30:00','Execute EmailJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(28,'Update Email Outbound with campaign message','Update Email Outbound with campaign message','0 0/15 * * * ?','2018-04-16 11:51:31',5,NULL,'2018-04-24 18:15:00','2018-04-24 18:30:00','Update Email Outbound with campaign messageJobDetail3 _ DEFAULT',NULL,1,0,1,0,0),(29,'Generate AdhocClient Schedule','Generate AdhocClient Schedule','0 0 12 1/1 * ? *','2018-04-16 11:51:35',5,NULL,'2018-04-24 11:00:00','2018-04-25 11:00:00','Generate AdhocClient ScheduleJobDetail3 _ DEFAULT',NULL,1,0,1,0,0);
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_run_history`
--

DROP TABLE IF EXISTS `job_run_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_run_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_id` bigint(20) NOT NULL,
  `version` bigint(20) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `status` varchar(10) CHARACTER SET latin1 NOT NULL,
  `error_message` text,
  `trigger_type` varchar(25) NOT NULL,
  `error_log` text,
  PRIMARY KEY (`id`),
  KEY `scheduledjobsFK` (`job_id`),
  CONSTRAINT `scheduledjobsFK` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2085 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_run_history`
--

LOCK TABLES `job_run_history` WRITE;
/*!40000 ALTER TABLE `job_run_history` DISABLE KEYS */;
INSERT INTO `job_run_history` VALUES (1,28,1,'2018-04-16 12:00:00','2018-04-16 12:00:00','success',NULL,'cron',NULL),(2,27,1,'2018-04-16 12:00:00','2018-04-16 12:00:00','success',NULL,'cron',NULL),(3,23,1,'2018-04-16 12:00:00','2018-04-16 12:00:00','success',NULL,'cron',NULL),(4,27,2,'2018-04-16 12:10:00','2018-04-16 12:10:00','success',NULL,'cron',NULL),(5,23,2,'2018-04-16 12:15:00','2018-04-16 12:15:00','success',NULL,'cron',NULL),(6,28,2,'2018-04-16 12:15:00','2018-04-16 12:15:00','success',NULL,'cron',NULL),(7,27,3,'2018-04-16 12:20:00','2018-04-16 12:20:00','success',NULL,'cron',NULL),(8,28,3,'2018-04-16 12:30:00','2018-04-16 12:30:00','success',NULL,'cron',NULL),(9,27,4,'2018-04-16 12:30:00','2018-04-16 12:30:00','success',NULL,'cron',NULL),(10,23,3,'2018-04-16 12:30:00','2018-04-16 12:30:00','success',NULL,'cron',NULL),(11,27,5,'2018-04-16 12:40:00','2018-04-16 12:40:00','success',NULL,'cron',NULL),(12,23,4,'2018-04-16 12:45:00','2018-04-16 12:45:00','success',NULL,'cron',NULL),(13,28,4,'2018-04-16 12:45:00','2018-04-16 12:45:00','success',NULL,'cron',NULL),(14,27,6,'2018-04-16 12:50:00','2018-04-16 12:50:00','success',NULL,'cron',NULL),(15,27,7,'2018-04-16 13:00:00','2018-04-16 13:00:00','success',NULL,'cron',NULL),(16,28,5,'2018-04-16 13:00:00','2018-04-16 13:00:00','success',NULL,'cron',NULL),(17,23,5,'2018-04-16 13:00:00','2018-04-16 13:00:00','success',NULL,'cron',NULL),(18,27,8,'2018-04-16 13:10:00','2018-04-16 13:10:00','success',NULL,'cron',NULL),(19,28,6,'2018-04-16 13:15:00','2018-04-16 13:15:00','success',NULL,'cron',NULL),(20,23,6,'2018-04-16 13:15:00','2018-04-16 13:15:00','success',NULL,'cron',NULL),(21,28,7,'2018-04-16 15:00:00','2018-04-16 15:00:00','success',NULL,'cron',NULL),(22,27,9,'2018-04-16 15:00:00','2018-04-16 15:00:00','success',NULL,'cron',NULL),(23,23,7,'2018-04-16 15:00:00','2018-04-16 15:00:00','success',NULL,'cron',NULL),(24,27,10,'2018-04-16 15:10:00','2018-04-16 15:10:00','success',NULL,'cron',NULL),(25,23,8,'2018-04-16 15:15:00','2018-04-16 15:15:00','success',NULL,'cron',NULL),(26,28,8,'2018-04-16 15:15:00','2018-04-16 15:15:00','success',NULL,'cron',NULL),(27,27,11,'2018-04-16 15:20:00','2018-04-16 15:20:00','success',NULL,'cron',NULL),(28,23,9,'2018-04-16 15:30:00','2018-04-16 15:30:00','success',NULL,'cron',NULL),(29,28,9,'2018-04-16 15:30:00','2018-04-16 15:30:00','success',NULL,'cron',NULL),(30,27,12,'2018-04-16 15:30:00','2018-04-16 15:30:00','success',NULL,'cron',NULL),(31,27,13,'2018-04-16 15:40:00','2018-04-16 15:40:00','success',NULL,'cron',NULL),(32,28,10,'2018-04-16 15:45:00','2018-04-16 15:45:00','success',NULL,'cron',NULL),(33,23,10,'2018-04-16 15:45:00','2018-04-16 15:45:00','success',NULL,'cron',NULL),(34,23,11,'2018-04-16 16:30:00','2018-04-16 16:30:00','success',NULL,'cron',NULL),(35,27,14,'2018-04-16 16:30:00','2018-04-16 16:30:00','success',NULL,'cron',NULL),(36,28,11,'2018-04-16 16:30:00','2018-04-16 16:30:00','success',NULL,'cron',NULL),(37,27,15,'2018-04-17 08:10:00','2018-04-17 08:10:00','success',NULL,'cron',NULL),(38,28,12,'2018-04-17 08:15:00','2018-04-17 08:15:00','success',NULL,'cron',NULL),(39,23,12,'2018-04-17 08:15:00','2018-04-17 08:15:00','success',NULL,'cron',NULL),(40,27,16,'2018-04-17 08:20:00','2018-04-17 08:20:00','success',NULL,'cron',NULL),(41,23,13,'2018-04-17 08:30:00','2018-04-17 08:30:00','success',NULL,'cron',NULL),(42,28,13,'2018-04-17 08:30:00','2018-04-17 08:30:00','success',NULL,'cron',NULL),(43,27,17,'2018-04-17 08:30:00','2018-04-17 08:30:00','success',NULL,'cron',NULL),(44,27,18,'2018-04-17 08:40:00','2018-04-17 08:40:02','success',NULL,'cron',NULL),(45,28,14,'2018-04-17 08:45:00','2018-04-17 08:45:00','success',NULL,'cron',NULL),(46,23,14,'2018-04-17 08:45:00','2018-04-17 08:45:00','success',NULL,'cron',NULL),(47,27,19,'2018-04-17 08:50:00','2018-04-17 08:50:00','success',NULL,'cron',NULL),(48,27,20,'2018-04-17 09:00:00','2018-04-17 09:00:00','success',NULL,'cron',NULL),(49,28,15,'2018-04-17 09:00:00','2018-04-17 09:00:00','success',NULL,'cron',NULL),(50,23,15,'2018-04-17 09:00:00','2018-04-17 09:00:00','success',NULL,'cron',NULL),(51,27,21,'2018-04-17 09:10:00','2018-04-17 09:10:00','success',NULL,'cron',NULL),(52,23,16,'2018-04-17 09:15:00','2018-04-17 09:15:00','success',NULL,'cron',NULL),(53,28,16,'2018-04-17 09:15:00','2018-04-17 09:15:00','success',NULL,'cron',NULL),(54,27,22,'2018-04-17 09:20:00','2018-04-17 09:20:00','success',NULL,'cron',NULL),(55,27,23,'2018-04-17 09:30:00','2018-04-17 09:30:00','success',NULL,'cron',NULL),(56,23,17,'2018-04-17 09:30:00','2018-04-17 09:30:00','success',NULL,'cron',NULL),(57,28,17,'2018-04-17 09:30:00','2018-04-17 09:30:00','success',NULL,'cron',NULL),(58,27,24,'2018-04-17 10:10:00','2018-04-17 10:10:02','success',NULL,'cron',NULL),(59,28,18,'2018-04-17 10:15:00','2018-04-17 10:15:03','success',NULL,'cron',NULL),(60,23,18,'2018-04-17 10:15:00','2018-04-17 10:15:03','success',NULL,'cron',NULL),(61,27,25,'2018-04-17 10:20:00','2018-04-17 10:20:00','success',NULL,'cron',NULL),(62,27,26,'2018-04-17 10:30:00','2018-04-17 10:30:00','success',NULL,'cron',NULL),(63,28,19,'2018-04-17 10:30:00','2018-04-17 10:30:00','success',NULL,'cron',NULL),(64,23,19,'2018-04-17 10:30:00','2018-04-17 10:30:00','success',NULL,'cron',NULL),(65,23,20,'2018-04-18 08:30:00','2018-04-18 08:30:00','success',NULL,'cron',NULL),(66,27,27,'2018-04-18 08:30:00','2018-04-18 08:30:00','success',NULL,'cron',NULL),(67,28,20,'2018-04-18 08:30:00','2018-04-18 08:30:00','success',NULL,'cron',NULL),(68,27,28,'2018-04-18 08:40:00','2018-04-18 08:40:00','success',NULL,'cron',NULL),(69,27,29,'2018-04-18 10:10:00','2018-04-18 10:10:00','success',NULL,'cron',NULL),(70,23,21,'2018-04-18 10:15:00','2018-04-18 10:15:00','success',NULL,'cron',NULL),(71,28,21,'2018-04-18 10:15:00','2018-04-18 10:15:00','success',NULL,'cron',NULL),(72,27,30,'2018-04-18 10:20:00','2018-04-18 10:20:00','success',NULL,'cron',NULL),(73,27,31,'2018-04-18 10:30:00','2018-04-18 10:30:00','success',NULL,'cron',NULL),(74,28,22,'2018-04-18 10:30:00','2018-04-18 10:30:00','success',NULL,'cron',NULL),(75,23,22,'2018-04-18 10:30:00','2018-04-18 10:30:00','success',NULL,'cron',NULL),(76,27,32,'2018-04-18 10:40:00','2018-04-18 10:40:00','success',NULL,'cron',NULL),(77,28,23,'2018-04-18 10:45:00','2018-04-18 10:45:00','success',NULL,'cron',NULL),(78,23,23,'2018-04-18 10:45:00','2018-04-18 10:45:00','success',NULL,'cron',NULL),(79,27,33,'2018-04-18 10:50:00','2018-04-18 10:50:00','success',NULL,'cron',NULL),(80,28,24,'2018-04-18 11:30:00','2018-04-18 11:30:00','success',NULL,'cron',NULL),(81,23,24,'2018-04-18 11:30:00','2018-04-18 11:30:00','success',NULL,'cron',NULL),(82,27,34,'2018-04-18 11:30:00','2018-04-18 11:30:00','success',NULL,'cron',NULL),(83,27,35,'2018-04-18 11:40:02','2018-04-18 11:40:08','success',NULL,'cron',NULL),(84,23,25,'2018-04-18 11:45:00','2018-04-18 11:45:00','success',NULL,'cron',NULL),(85,28,25,'2018-04-18 11:45:00','2018-04-18 11:45:00','success',NULL,'cron',NULL),(86,27,36,'2018-04-18 13:00:00','2018-04-18 13:00:00','success',NULL,'cron',NULL),(87,28,26,'2018-04-18 13:00:00','2018-04-18 13:00:00','success',NULL,'cron',NULL),(88,23,26,'2018-04-18 13:00:00','2018-04-18 13:00:00','success',NULL,'cron',NULL),(89,27,37,'2018-04-18 13:10:00','2018-04-18 13:10:00','success',NULL,'cron',NULL),(90,23,27,'2018-04-18 13:15:00','2018-04-18 13:15:00','success',NULL,'cron',NULL),(91,28,27,'2018-04-18 13:15:00','2018-04-18 13:15:00','success',NULL,'cron',NULL),(92,27,38,'2018-04-18 13:20:00','2018-04-18 13:20:00','success',NULL,'cron',NULL),(93,28,28,'2018-04-18 13:45:00','2018-04-18 13:45:00','success',NULL,'cron',NULL),(94,23,28,'2018-04-18 13:45:00','2018-04-18 13:45:00','success',NULL,'cron',NULL),(95,27,39,'2018-04-18 13:50:00','2018-04-18 13:50:00','success',NULL,'cron',NULL),(96,27,40,'2018-04-18 14:00:00','2018-04-18 14:00:00','success',NULL,'cron',NULL),(97,28,29,'2018-04-18 14:00:00','2018-04-18 14:00:00','success',NULL,'cron',NULL),(98,23,29,'2018-04-18 14:00:00','2018-04-18 14:00:00','success',NULL,'cron',NULL),(99,27,41,'2018-04-18 14:10:00','2018-04-18 14:10:00','success',NULL,'cron',NULL),(100,28,30,'2018-04-18 14:15:00','2018-04-18 14:15:01','success',NULL,'cron',NULL),(101,23,30,'2018-04-18 14:15:00','2018-04-18 14:15:01','success',NULL,'cron',NULL),(102,27,42,'2018-04-18 14:20:00','2018-04-18 14:20:05','success',NULL,'cron',NULL),(103,27,43,'2018-04-18 14:30:00','2018-04-18 14:30:00','success',NULL,'cron',NULL),(104,28,31,'2018-04-18 14:30:00','2018-04-18 14:30:00','success',NULL,'cron',NULL),(105,23,31,'2018-04-18 14:30:00','2018-04-18 14:30:00','success',NULL,'cron',NULL),(106,27,44,'2018-04-18 14:50:00','2018-04-18 14:50:00','success',NULL,'cron',NULL),(107,23,32,'2018-04-18 15:00:00','2018-04-18 15:00:00','success',NULL,'cron',NULL),(108,27,45,'2018-04-18 15:00:00','2018-04-18 15:00:00','success',NULL,'cron',NULL),(109,28,32,'2018-04-18 15:00:00','2018-04-18 15:00:00','success',NULL,'cron',NULL),(110,27,46,'2018-04-18 15:40:00','2018-04-18 15:40:00','success',NULL,'cron',NULL),(111,28,33,'2018-04-18 15:45:00','2018-04-18 15:45:00','success',NULL,'cron',NULL),(112,23,33,'2018-04-18 15:45:00','2018-04-18 15:45:00','success',NULL,'cron',NULL),(113,27,47,'2018-04-18 19:10:00','2018-04-18 19:10:00','success',NULL,'cron',NULL),(114,28,34,'2018-04-18 19:15:00','2018-04-18 19:15:00','success',NULL,'cron',NULL),(115,23,34,'2018-04-18 19:15:00','2018-04-18 19:15:00','success',NULL,'cron',NULL),(116,27,48,'2018-04-18 19:20:00','2018-04-18 19:20:00','success',NULL,'cron',NULL),(117,27,49,'2018-04-18 19:30:00','2018-04-18 19:30:00','success',NULL,'cron',NULL),(118,28,35,'2018-04-18 19:30:00','2018-04-18 19:30:00','success',NULL,'cron',NULL),(119,23,35,'2018-04-18 19:30:00','2018-04-18 19:30:00','success',NULL,'cron',NULL),(120,27,50,'2018-04-18 19:40:00','2018-04-18 19:40:00','success',NULL,'cron',NULL),(121,28,36,'2018-04-18 19:45:00','2018-04-18 19:45:00','success',NULL,'cron',NULL),(122,23,36,'2018-04-18 19:45:00','2018-04-18 19:45:00','success',NULL,'cron',NULL),(123,27,51,'2018-04-18 19:50:00','2018-04-18 19:50:00','success',NULL,'cron',NULL),(124,27,52,'2018-04-18 20:00:00','2018-04-18 20:00:00','success',NULL,'cron',NULL),(125,28,37,'2018-04-18 20:00:00','2018-04-18 20:00:00','success',NULL,'cron',NULL),(126,23,37,'2018-04-18 20:00:00','2018-04-18 20:00:00','success',NULL,'cron',NULL),(127,27,53,'2018-04-18 20:10:00','2018-04-18 20:10:00','success',NULL,'cron',NULL),(128,28,38,'2018-04-18 20:15:00','2018-04-18 20:15:00','success',NULL,'cron',NULL),(129,23,38,'2018-04-18 20:15:00','2018-04-18 20:15:00','success',NULL,'cron',NULL),(130,27,54,'2018-04-18 20:20:00','2018-04-18 20:20:00','success',NULL,'cron',NULL),(131,23,39,'2018-04-18 20:30:00','2018-04-18 20:30:00','success',NULL,'cron',NULL),(132,27,55,'2018-04-18 20:30:00','2018-04-18 20:30:00','success',NULL,'cron',NULL),(133,28,39,'2018-04-18 20:30:00','2018-04-18 20:30:00','success',NULL,'cron',NULL),(134,27,56,'2018-04-18 20:40:00','2018-04-18 20:40:00','success',NULL,'cron',NULL),(135,28,40,'2018-04-18 20:45:00','2018-04-18 20:45:00','success',NULL,'cron',NULL),(136,23,40,'2018-04-18 20:45:00','2018-04-18 20:45:00','success',NULL,'cron',NULL),(137,27,57,'2018-04-18 20:50:00','2018-04-18 20:50:00','success',NULL,'cron',NULL),(138,27,58,'2018-04-18 21:00:00','2018-04-18 21:00:00','success',NULL,'cron',NULL),(139,28,41,'2018-04-18 21:00:00','2018-04-18 21:00:00','success',NULL,'cron',NULL),(140,1,1,'2018-04-18 21:00:00','2018-04-18 21:00:00','success',NULL,'cron',NULL),(141,23,41,'2018-04-18 21:00:00','2018-04-18 21:00:00','success',NULL,'cron',NULL),(142,27,59,'2018-04-18 21:10:00','2018-04-18 21:10:00','success',NULL,'cron',NULL),(143,28,42,'2018-04-18 21:15:00','2018-04-18 21:15:00','success',NULL,'cron',NULL),(144,23,42,'2018-04-18 21:15:00','2018-04-18 21:15:00','success',NULL,'cron',NULL),(145,4,1,'2018-04-18 21:20:00','2018-04-18 21:20:02','success',NULL,'cron',NULL),(146,27,60,'2018-04-18 21:20:00','2018-04-18 21:20:02','success',NULL,'cron',NULL),(147,27,61,'2018-04-18 21:30:00','2018-04-18 21:30:00','success',NULL,'cron',NULL),(148,23,43,'2018-04-18 21:30:00','2018-04-18 21:30:00','success',NULL,'cron',NULL),(149,28,43,'2018-04-18 21:30:00','2018-04-18 21:30:00','success',NULL,'cron',NULL),(150,27,62,'2018-04-18 21:40:00','2018-04-18 21:40:00','success',NULL,'cron',NULL),(151,23,44,'2018-04-18 21:45:00','2018-04-18 21:45:00','success',NULL,'cron',NULL),(152,28,44,'2018-04-18 21:45:00','2018-04-18 21:45:00','success',NULL,'cron',NULL),(153,27,63,'2018-04-18 21:50:00','2018-04-18 21:50:00','success',NULL,'cron',NULL),(154,27,64,'2018-04-18 22:00:00','2018-04-18 22:00:00','success',NULL,'cron',NULL),(155,28,45,'2018-04-18 22:00:00','2018-04-18 22:00:00','success',NULL,'cron',NULL),(156,23,45,'2018-04-18 22:00:00','2018-04-18 22:00:00','success',NULL,'cron',NULL),(157,27,65,'2018-04-18 22:10:00','2018-04-18 22:10:00','success',NULL,'cron',NULL),(158,28,46,'2018-04-18 22:15:00','2018-04-18 22:15:00','success',NULL,'cron',NULL),(159,23,46,'2018-04-18 22:15:00','2018-04-18 22:15:00','success',NULL,'cron',NULL),(160,27,66,'2018-04-18 22:20:00','2018-04-18 22:20:00','success',NULL,'cron',NULL),(161,23,47,'2018-04-18 22:30:00','2018-04-18 22:30:01','success',NULL,'cron',NULL),(162,27,67,'2018-04-18 22:30:00','2018-04-18 22:30:01','success',NULL,'cron',NULL),(163,28,47,'2018-04-18 22:30:00','2018-04-18 22:30:01','success',NULL,'cron',NULL),(164,27,68,'2018-04-18 22:40:00','2018-04-18 22:40:00','success',NULL,'cron',NULL),(165,28,48,'2018-04-18 22:45:00','2018-04-18 22:45:00','success',NULL,'cron',NULL),(166,23,48,'2018-04-18 22:45:00','2018-04-18 22:45:00','success',NULL,'cron',NULL),(167,27,69,'2018-04-18 22:50:00','2018-04-18 22:50:00','success',NULL,'cron',NULL),(168,23,49,'2018-04-18 23:00:00','2018-04-18 23:00:00','success',NULL,'cron',NULL),(169,12,1,'2018-04-18 23:00:00','2018-04-18 23:00:01','success',NULL,'cron',NULL),(170,20,1,'2018-04-18 23:00:00','2018-04-18 23:00:01','success',NULL,'cron',NULL),(171,13,1,'2018-04-18 23:00:00','2018-04-18 23:00:01','success',NULL,'cron',NULL),(172,27,70,'2018-04-18 23:00:00','2018-04-18 23:00:01','success',NULL,'cron',NULL),(173,10,1,'2018-04-18 23:00:00','2018-04-18 23:00:01','success',NULL,'cron',NULL),(174,19,1,'2018-04-18 23:00:00','2018-04-18 23:00:01','success',NULL,'cron',NULL),(175,28,49,'2018-04-18 23:00:00','2018-04-18 23:00:01','success',NULL,'cron',NULL),(176,15,1,'2018-04-18 23:00:00','2018-04-18 23:00:01','success',NULL,'cron',NULL),(177,6,1,'2018-04-18 23:00:00','2018-04-18 23:00:01','success',NULL,'cron',NULL),(178,21,1,'2018-04-18 23:00:01','2018-04-18 23:00:01','success',NULL,'cron',NULL),(179,7,1,'2018-04-18 23:01:00','2018-04-18 23:01:00','success',NULL,'cron',NULL),(180,22,1,'2018-04-18 23:01:00','2018-04-18 23:01:00','success',NULL,'cron',NULL),(181,2,1,'2018-04-18 23:01:00','2018-04-18 23:01:00','success',NULL,'cron',NULL),(182,9,1,'2018-04-18 23:01:00','2018-04-18 23:01:00','success',NULL,'cron',NULL),(183,17,1,'2018-04-18 23:01:00','2018-04-18 23:01:00','success',NULL,'cron',NULL),(184,11,1,'2018-04-18 23:01:00','2018-04-18 23:01:00','success',NULL,'cron',NULL),(185,16,1,'2018-04-18 23:02:00','2018-04-18 23:02:00','success',NULL,'cron',NULL),(186,14,1,'2018-04-18 23:02:00','2018-04-18 23:02:00','success',NULL,'cron',NULL),(187,3,1,'2018-04-18 23:05:00','2018-04-18 23:05:00','success',NULL,'cron',NULL),(188,18,1,'2018-04-18 23:05:00','2018-04-18 23:05:00','success',NULL,'cron',NULL),(189,27,71,'2018-04-18 23:10:00','2018-04-18 23:10:00','success',NULL,'cron',NULL),(190,28,50,'2018-04-18 23:15:00','2018-04-18 23:15:00','success',NULL,'cron',NULL),(191,23,50,'2018-04-18 23:15:00','2018-04-18 23:15:00','success',NULL,'cron',NULL),(192,27,72,'2018-04-18 23:20:00','2018-04-18 23:20:00','success',NULL,'cron',NULL),(193,27,73,'2018-04-18 23:30:00','2018-04-18 23:30:00','success',NULL,'cron',NULL),(194,28,51,'2018-04-18 23:30:00','2018-04-18 23:30:00','success',NULL,'cron',NULL),(195,23,51,'2018-04-18 23:30:00','2018-04-18 23:30:00','success',NULL,'cron',NULL),(196,27,74,'2018-04-18 23:40:00','2018-04-18 23:40:00','success',NULL,'cron',NULL),(197,28,52,'2018-04-18 23:45:00','2018-04-18 23:45:00','success',NULL,'cron',NULL),(198,23,52,'2018-04-18 23:45:00','2018-04-18 23:45:00','success',NULL,'cron',NULL),(199,27,75,'2018-04-18 23:50:00','2018-04-18 23:50:01','success',NULL,'cron',NULL),(200,23,53,'2018-04-19 00:00:00','2018-04-19 00:00:00','success',NULL,'cron',NULL),(201,27,76,'2018-04-19 00:00:00','2018-04-19 00:00:00','success',NULL,'cron',NULL),(202,28,53,'2018-04-19 00:00:00','2018-04-19 00:00:00','success',NULL,'cron',NULL),(203,27,77,'2018-04-19 00:10:00','2018-04-19 00:10:00','success',NULL,'cron',NULL),(204,28,54,'2018-04-19 00:15:00','2018-04-19 00:15:00','success',NULL,'cron',NULL),(205,23,54,'2018-04-19 00:15:00','2018-04-19 00:15:00','success',NULL,'cron',NULL),(206,27,78,'2018-04-19 00:20:00','2018-04-19 00:20:00','success',NULL,'cron',NULL),(207,27,79,'2018-04-19 00:30:00','2018-04-19 00:30:00','success',NULL,'cron',NULL),(208,28,55,'2018-04-19 00:30:00','2018-04-19 00:30:00','success',NULL,'cron',NULL),(209,23,55,'2018-04-19 00:30:00','2018-04-19 00:30:00','success',NULL,'cron',NULL),(210,27,80,'2018-04-19 00:40:00','2018-04-19 00:40:00','success',NULL,'cron',NULL),(211,28,56,'2018-04-19 00:45:00','2018-04-19 00:45:00','success',NULL,'cron',NULL),(212,23,56,'2018-04-19 00:45:00','2018-04-19 00:45:00','success',NULL,'cron',NULL),(213,27,81,'2018-04-19 00:50:00','2018-04-19 00:50:00','success',NULL,'cron',NULL),(214,28,57,'2018-04-19 01:00:00','2018-04-19 01:00:00','success',NULL,'cron',NULL),(215,27,82,'2018-04-19 01:00:00','2018-04-19 01:00:00','success',NULL,'cron',NULL),(216,23,57,'2018-04-19 01:00:00','2018-04-19 01:00:00','success',NULL,'cron',NULL),(217,27,83,'2018-04-19 01:10:00','2018-04-19 01:10:00','success',NULL,'cron',NULL),(218,23,58,'2018-04-19 01:15:00','2018-04-19 01:15:00','success',NULL,'cron',NULL),(219,28,58,'2018-04-19 01:15:00','2018-04-19 01:15:00','success',NULL,'cron',NULL),(220,27,84,'2018-04-19 01:20:00','2018-04-19 01:20:00','success',NULL,'cron',NULL),(221,27,85,'2018-04-19 01:30:00','2018-04-19 01:30:00','success',NULL,'cron',NULL),(222,28,59,'2018-04-19 01:30:00','2018-04-19 01:30:00','success',NULL,'cron',NULL),(223,23,59,'2018-04-19 01:30:00','2018-04-19 01:30:00','success',NULL,'cron',NULL),(224,27,86,'2018-04-19 01:40:00','2018-04-19 01:40:00','success',NULL,'cron',NULL),(225,23,60,'2018-04-19 01:45:00','2018-04-19 01:45:00','success',NULL,'cron',NULL),(226,28,60,'2018-04-19 01:45:00','2018-04-19 01:45:00','success',NULL,'cron',NULL),(227,27,87,'2018-04-19 01:50:00','2018-04-19 01:50:00','success',NULL,'cron',NULL),(228,28,61,'2018-04-19 02:00:00','2018-04-19 02:00:00','success',NULL,'cron',NULL),(229,27,88,'2018-04-19 02:00:00','2018-04-19 02:00:00','success',NULL,'cron',NULL),(230,23,61,'2018-04-19 02:00:00','2018-04-19 02:00:00','success',NULL,'cron',NULL),(231,27,89,'2018-04-19 02:10:00','2018-04-19 02:10:00','success',NULL,'cron',NULL),(232,23,62,'2018-04-19 02:15:00','2018-04-19 02:15:00','success',NULL,'cron',NULL),(233,28,62,'2018-04-19 02:15:00','2018-04-19 02:15:00','success',NULL,'cron',NULL),(234,27,90,'2018-04-19 02:20:00','2018-04-19 02:20:00','success',NULL,'cron',NULL),(235,23,63,'2018-04-19 02:30:00','2018-04-19 02:30:00','success',NULL,'cron',NULL),(236,28,63,'2018-04-19 02:30:00','2018-04-19 02:30:00','success',NULL,'cron',NULL),(237,27,91,'2018-04-19 02:30:00','2018-04-19 02:30:00','success',NULL,'cron',NULL),(238,27,92,'2018-04-19 02:40:00','2018-04-19 02:40:00','success',NULL,'cron',NULL),(239,23,64,'2018-04-19 02:45:00','2018-04-19 02:45:02','success',NULL,'cron',NULL),(240,28,64,'2018-04-19 02:45:00','2018-04-19 02:45:07','success',NULL,'cron',NULL),(241,27,93,'2018-04-19 02:50:00','2018-04-19 02:50:00','success',NULL,'cron',NULL),(242,27,94,'2018-04-19 03:00:00','2018-04-19 03:00:00','success',NULL,'cron',NULL),(243,28,65,'2018-04-19 03:00:00','2018-04-19 03:00:00','success',NULL,'cron',NULL),(244,23,65,'2018-04-19 03:00:00','2018-04-19 03:00:00','success',NULL,'cron',NULL),(245,27,95,'2018-04-19 03:10:00','2018-04-19 03:10:00','success',NULL,'cron',NULL),(246,28,66,'2018-04-19 03:15:00','2018-04-19 03:15:00','success',NULL,'cron',NULL),(247,23,66,'2018-04-19 03:15:00','2018-04-19 03:15:00','success',NULL,'cron',NULL),(248,27,96,'2018-04-19 03:20:00','2018-04-19 03:20:00','success',NULL,'cron',NULL),(249,23,67,'2018-04-19 03:30:00','2018-04-19 03:30:00','success',NULL,'cron',NULL),(250,27,97,'2018-04-19 03:30:00','2018-04-19 03:30:00','success',NULL,'cron',NULL),(251,28,67,'2018-04-19 03:30:00','2018-04-19 03:30:00','success',NULL,'cron',NULL),(252,27,98,'2018-04-19 03:40:00','2018-04-19 03:40:00','success',NULL,'cron',NULL),(253,23,68,'2018-04-19 03:45:00','2018-04-19 03:45:00','success',NULL,'cron',NULL),(254,28,68,'2018-04-19 03:45:00','2018-04-19 03:45:00','success',NULL,'cron',NULL),(255,27,99,'2018-04-19 03:50:00','2018-04-19 03:50:00','success',NULL,'cron',NULL),(256,27,100,'2018-04-19 04:00:00','2018-04-19 04:00:00','success',NULL,'cron',NULL),(257,23,69,'2018-04-19 04:00:00','2018-04-19 04:00:00','success',NULL,'cron',NULL),(258,24,1,'2018-04-19 04:00:00','2018-04-19 04:00:00','success',NULL,'cron',NULL),(259,28,69,'2018-04-19 04:00:00','2018-04-19 04:00:00','success',NULL,'cron',NULL),(260,25,1,'2018-04-19 04:00:00','2018-04-19 04:00:00','success',NULL,'cron',NULL),(261,26,1,'2018-04-19 04:00:00','2018-04-19 04:00:00','success',NULL,'cron',NULL),(262,27,101,'2018-04-19 04:10:00','2018-04-19 04:10:00','success',NULL,'cron',NULL),(263,23,70,'2018-04-19 04:15:00','2018-04-19 04:15:00','success',NULL,'cron',NULL),(264,28,70,'2018-04-19 04:15:00','2018-04-19 04:15:00','success',NULL,'cron',NULL),(265,27,102,'2018-04-19 04:20:00','2018-04-19 04:20:00','success',NULL,'cron',NULL),(266,28,71,'2018-04-19 04:30:00','2018-04-19 04:30:00','success',NULL,'cron',NULL),(267,27,103,'2018-04-19 04:30:00','2018-04-19 04:30:00','success',NULL,'cron',NULL),(268,23,71,'2018-04-19 04:30:00','2018-04-19 04:30:00','success',NULL,'cron',NULL),(269,27,104,'2018-04-19 04:40:00','2018-04-19 04:40:00','success',NULL,'cron',NULL),(270,28,72,'2018-04-19 04:45:00','2018-04-19 04:45:00','success',NULL,'cron',NULL),(271,23,72,'2018-04-19 04:45:00','2018-04-19 04:45:00','success',NULL,'cron',NULL),(272,27,105,'2018-04-19 04:50:00','2018-04-19 04:50:00','success',NULL,'cron',NULL),(273,27,106,'2018-04-19 05:00:00','2018-04-19 05:00:00','success',NULL,'cron',NULL),(274,28,73,'2018-04-19 05:00:00','2018-04-19 05:00:00','success',NULL,'cron',NULL),(275,23,73,'2018-04-19 05:00:00','2018-04-19 05:00:00','success',NULL,'cron',NULL),(276,27,107,'2018-04-19 05:10:00','2018-04-19 05:10:00','success',NULL,'cron',NULL),(277,28,74,'2018-04-19 05:15:00','2018-04-19 05:15:00','success',NULL,'cron',NULL),(278,23,74,'2018-04-19 05:15:00','2018-04-19 05:15:00','success',NULL,'cron',NULL),(279,27,108,'2018-04-19 05:20:00','2018-04-19 05:20:00','success',NULL,'cron',NULL),(280,23,75,'2018-04-19 05:30:00','2018-04-19 05:30:02','success',NULL,'cron',NULL),(281,27,109,'2018-04-19 05:30:00','2018-04-19 05:30:03','success',NULL,'cron',NULL),(282,28,75,'2018-04-19 05:30:00','2018-04-19 05:30:03','success',NULL,'cron',NULL),(283,27,110,'2018-04-19 05:40:00','2018-04-19 05:40:00','success',NULL,'cron',NULL),(284,23,76,'2018-04-19 05:45:00','2018-04-19 05:45:00','success',NULL,'cron',NULL),(285,28,76,'2018-04-19 05:45:00','2018-04-19 05:45:00','success',NULL,'cron',NULL),(286,27,111,'2018-04-19 05:50:00','2018-04-19 05:50:00','success',NULL,'cron',NULL),(287,27,112,'2018-04-19 06:00:00','2018-04-19 06:00:00','success',NULL,'cron',NULL),(288,23,77,'2018-04-19 06:00:00','2018-04-19 06:00:00','success',NULL,'cron',NULL),(289,28,77,'2018-04-19 06:00:00','2018-04-19 06:00:00','success',NULL,'cron',NULL),(290,27,113,'2018-04-19 06:10:00','2018-04-19 06:10:00','success',NULL,'cron',NULL),(291,28,78,'2018-04-19 06:15:00','2018-04-19 06:15:00','success',NULL,'cron',NULL),(292,23,78,'2018-04-19 06:15:00','2018-04-19 06:15:00','success',NULL,'cron',NULL),(293,27,114,'2018-04-19 06:20:00','2018-04-19 06:20:02','success',NULL,'cron',NULL),(294,27,115,'2018-04-19 06:30:00','2018-04-19 06:30:00','success',NULL,'cron',NULL),(295,28,79,'2018-04-19 06:30:00','2018-04-19 06:30:00','success',NULL,'cron',NULL),(296,23,79,'2018-04-19 06:30:00','2018-04-19 06:30:00','success',NULL,'cron',NULL),(297,27,116,'2018-04-19 06:40:00','2018-04-19 06:40:00','success',NULL,'cron',NULL),(298,28,80,'2018-04-19 06:45:00','2018-04-19 06:45:00','success',NULL,'cron',NULL),(299,23,80,'2018-04-19 06:45:00','2018-04-19 06:45:00','success',NULL,'cron',NULL),(300,27,117,'2018-04-19 06:50:00','2018-04-19 06:50:00','success',NULL,'cron',NULL),(301,27,118,'2018-04-19 07:00:00','2018-04-19 07:00:00','success',NULL,'cron',NULL),(302,28,81,'2018-04-19 07:00:00','2018-04-19 07:00:00','success',NULL,'cron',NULL),(303,23,81,'2018-04-19 07:00:00','2018-04-19 07:00:00','success',NULL,'cron',NULL),(304,27,119,'2018-04-19 07:10:00','2018-04-19 07:10:00','success',NULL,'cron',NULL),(305,23,82,'2018-04-19 07:15:00','2018-04-19 07:15:00','success',NULL,'cron',NULL),(306,28,82,'2018-04-19 07:15:00','2018-04-19 07:15:00','success',NULL,'cron',NULL),(307,27,120,'2018-04-19 07:20:00','2018-04-19 07:20:00','success',NULL,'cron',NULL),(308,28,83,'2018-04-19 07:30:00','2018-04-19 07:30:00','success',NULL,'cron',NULL),(309,23,83,'2018-04-19 07:30:00','2018-04-19 07:30:00','success',NULL,'cron',NULL),(310,27,121,'2018-04-19 07:30:00','2018-04-19 07:30:00','success',NULL,'cron',NULL),(311,27,122,'2018-04-19 07:40:00','2018-04-19 07:40:00','success',NULL,'cron',NULL),(312,28,84,'2018-04-19 07:45:00','2018-04-19 07:45:02','success',NULL,'cron',NULL),(313,23,84,'2018-04-19 07:45:00','2018-04-19 07:45:02','success',NULL,'cron',NULL),(314,27,123,'2018-04-19 07:50:00','2018-04-19 07:50:00','success',NULL,'cron',NULL),(315,28,85,'2018-04-19 08:00:00','2018-04-19 08:00:00','success',NULL,'cron',NULL),(316,27,124,'2018-04-19 08:00:00','2018-04-19 08:00:00','success',NULL,'cron',NULL),(317,23,85,'2018-04-19 08:00:00','2018-04-19 08:00:00','success',NULL,'cron',NULL),(318,27,125,'2018-04-19 08:10:00','2018-04-19 08:10:00','success',NULL,'cron',NULL),(319,27,126,'2018-04-19 08:20:00','2018-04-19 08:20:00','success',NULL,'cron',NULL),(320,28,86,'2018-04-19 08:30:00','2018-04-19 08:30:00','success',NULL,'cron',NULL),(321,27,127,'2018-04-19 08:30:00','2018-04-19 08:30:00','success',NULL,'cron',NULL),(322,23,86,'2018-04-19 08:30:00','2018-04-19 08:30:00','success',NULL,'cron',NULL),(323,27,128,'2018-04-19 08:40:00','2018-04-19 08:40:00','success',NULL,'cron',NULL),(324,23,87,'2018-04-19 08:45:00','2018-04-19 08:45:00','success',NULL,'cron',NULL),(325,28,87,'2018-04-19 08:45:00','2018-04-19 08:45:00','success',NULL,'cron',NULL),(326,27,129,'2018-04-19 08:50:00','2018-04-19 08:50:00','success',NULL,'cron',NULL),(327,23,88,'2018-04-19 09:00:00','2018-04-19 09:00:00','success',NULL,'cron',NULL),(328,27,130,'2018-04-19 09:00:00','2018-04-19 09:00:00','success',NULL,'cron',NULL),(329,28,88,'2018-04-19 09:00:00','2018-04-19 09:00:00','success',NULL,'cron',NULL),(330,27,131,'2018-04-19 09:10:00','2018-04-19 09:10:00','success',NULL,'cron',NULL),(331,23,89,'2018-04-19 09:15:00','2018-04-19 09:15:00','success',NULL,'cron',NULL),(332,28,89,'2018-04-19 09:15:00','2018-04-19 09:15:00','success',NULL,'cron',NULL),(333,27,132,'2018-04-19 09:20:00','2018-04-19 09:20:00','success',NULL,'cron',NULL),(334,27,133,'2018-04-19 09:30:00','2018-04-19 09:30:00','success',NULL,'cron',NULL),(335,28,90,'2018-04-19 09:30:00','2018-04-19 09:30:00','success',NULL,'cron',NULL),(336,23,90,'2018-04-19 09:30:00','2018-04-19 09:30:00','success',NULL,'cron',NULL),(337,27,134,'2018-04-19 09:40:00','2018-04-19 09:40:00','success',NULL,'cron',NULL),(338,28,91,'2018-04-19 09:45:00','2018-04-19 09:45:00','success',NULL,'cron',NULL),(339,23,91,'2018-04-19 09:45:00','2018-04-19 09:45:00','success',NULL,'cron',NULL),(340,27,135,'2018-04-19 09:50:00','2018-04-19 09:50:00','success',NULL,'cron',NULL),(341,27,136,'2018-04-19 10:00:00','2018-04-19 10:00:00','success',NULL,'cron',NULL),(342,28,92,'2018-04-19 10:00:00','2018-04-19 10:00:00','success',NULL,'cron',NULL),(343,23,92,'2018-04-19 10:00:00','2018-04-19 10:00:00','success',NULL,'cron',NULL),(344,27,137,'2018-04-19 10:10:00','2018-04-19 10:10:00','success',NULL,'cron',NULL),(345,28,93,'2018-04-19 10:15:00','2018-04-19 10:15:00','success',NULL,'cron',NULL),(346,23,93,'2018-04-19 10:15:00','2018-04-19 10:15:00','success',NULL,'cron',NULL),(347,27,138,'2018-04-19 10:20:00','2018-04-19 10:20:00','success',NULL,'cron',NULL),(348,27,139,'2018-04-19 10:30:00','2018-04-19 10:30:00','success',NULL,'cron',NULL),(349,28,94,'2018-04-19 10:30:00','2018-04-19 10:30:00','success',NULL,'cron',NULL),(350,23,94,'2018-04-19 10:30:00','2018-04-19 10:30:00','success',NULL,'cron',NULL),(351,27,140,'2018-04-19 10:40:00','2018-04-19 10:40:00','success',NULL,'cron',NULL),(352,28,95,'2018-04-19 10:45:00','2018-04-19 10:45:00','success',NULL,'cron',NULL),(353,23,95,'2018-04-19 10:45:00','2018-04-19 10:45:00','success',NULL,'cron',NULL),(354,27,141,'2018-04-19 10:50:00','2018-04-19 10:50:00','success',NULL,'cron',NULL),(355,27,142,'2018-04-19 11:00:00','2018-04-19 11:00:00','success',NULL,'cron',NULL),(356,29,1,'2018-04-19 11:00:00','2018-04-19 11:00:00','success',NULL,'cron',NULL),(357,28,96,'2018-04-19 11:00:00','2018-04-19 11:00:00','success',NULL,'cron',NULL),(358,8,1,'2018-04-19 11:00:00','2018-04-19 11:00:00','success',NULL,'cron',NULL),(359,5,1,'2018-04-19 11:00:00','2018-04-19 11:00:00','success',NULL,'cron',NULL),(360,23,96,'2018-04-19 11:00:00','2018-04-19 11:00:00','success',NULL,'cron',NULL),(361,27,143,'2018-04-19 11:10:00','2018-04-19 11:10:00','success',NULL,'cron',NULL),(362,28,97,'2018-04-19 11:15:00','2018-04-19 11:15:00','success',NULL,'cron',NULL),(363,23,97,'2018-04-19 11:15:00','2018-04-19 11:15:00','success',NULL,'cron',NULL),(364,27,144,'2018-04-19 11:20:00','2018-04-19 11:20:00','success',NULL,'cron',NULL),(365,27,145,'2018-04-19 11:30:00','2018-04-19 11:30:00','success',NULL,'cron',NULL),(366,28,98,'2018-04-19 11:30:00','2018-04-19 11:30:00','success',NULL,'cron',NULL),(367,23,98,'2018-04-19 11:30:00','2018-04-19 11:30:00','success',NULL,'cron',NULL),(368,27,146,'2018-04-19 11:40:00','2018-04-19 11:40:00','success',NULL,'cron',NULL),(369,28,99,'2018-04-19 11:45:00','2018-04-19 11:45:00','success',NULL,'cron',NULL),(370,23,99,'2018-04-19 11:45:00','2018-04-19 11:45:00','success',NULL,'cron',NULL),(371,27,147,'2018-04-19 11:50:00','2018-04-19 11:50:00','success',NULL,'cron',NULL),(372,28,100,'2018-04-19 12:00:00','2018-04-19 12:00:00','success',NULL,'cron',NULL),(373,27,148,'2018-04-19 12:00:00','2018-04-19 12:00:00','success',NULL,'cron',NULL),(374,23,100,'2018-04-19 12:00:00','2018-04-19 12:00:00','success',NULL,'cron',NULL),(375,27,149,'2018-04-19 14:00:00','2018-04-19 14:00:00','success',NULL,'cron',NULL),(376,28,101,'2018-04-19 14:00:00','2018-04-19 14:00:00','success',NULL,'cron',NULL),(377,23,101,'2018-04-19 14:00:00','2018-04-19 14:00:00','success',NULL,'cron',NULL),(378,27,150,'2018-04-19 14:10:00','2018-04-19 14:10:00','success',NULL,'cron',NULL),(379,23,102,'2018-04-19 14:15:00','2018-04-19 14:15:00','success',NULL,'cron',NULL),(380,28,102,'2018-04-19 14:15:00','2018-04-19 14:15:00','success',NULL,'cron',NULL),(381,27,151,'2018-04-19 14:20:00','2018-04-19 14:20:00','success',NULL,'cron',NULL),(382,23,103,'2018-04-19 14:30:00','2018-04-19 14:30:00','success',NULL,'cron',NULL),(383,28,103,'2018-04-19 14:30:00','2018-04-19 14:30:00','success',NULL,'cron',NULL),(384,27,152,'2018-04-19 14:30:00','2018-04-19 14:30:00','success',NULL,'cron',NULL),(385,27,153,'2018-04-19 14:40:00','2018-04-19 14:40:00','success',NULL,'cron',NULL),(386,28,104,'2018-04-19 14:45:00','2018-04-19 14:45:00','success',NULL,'cron',NULL),(387,23,104,'2018-04-19 14:45:00','2018-04-19 14:45:00','success',NULL,'cron',NULL),(388,27,154,'2018-04-19 14:50:00','2018-04-19 14:50:00','success',NULL,'cron',NULL),(389,27,155,'2018-04-19 15:00:00','2018-04-19 15:00:00','success',NULL,'cron',NULL),(390,28,105,'2018-04-19 15:00:00','2018-04-19 15:00:00','success',NULL,'cron',NULL),(391,23,105,'2018-04-19 15:00:00','2018-04-19 15:00:00','success',NULL,'cron',NULL),(392,27,156,'2018-04-19 16:00:00','2018-04-19 16:00:00','success',NULL,'cron',NULL),(393,28,106,'2018-04-19 16:00:00','2018-04-19 16:00:00','success',NULL,'cron',NULL),(394,23,106,'2018-04-19 16:00:00','2018-04-19 16:00:00','success',NULL,'cron',NULL),(395,27,157,'2018-04-19 16:10:00','2018-04-19 16:10:00','success',NULL,'cron',NULL),(396,28,107,'2018-04-19 16:15:00','2018-04-19 16:15:00','success',NULL,'cron',NULL),(397,23,107,'2018-04-19 16:15:00','2018-04-19 16:15:00','success',NULL,'cron',NULL),(398,27,158,'2018-04-19 16:20:00','2018-04-19 16:20:00','success',NULL,'cron',NULL),(399,28,108,'2018-04-19 16:30:00','2018-04-19 16:30:00','success',NULL,'cron',NULL),(400,23,108,'2018-04-19 16:30:00','2018-04-19 16:30:00','success',NULL,'cron',NULL),(401,27,159,'2018-04-19 16:30:00','2018-04-19 16:30:00','success',NULL,'cron',NULL),(402,27,160,'2018-04-19 18:40:00','2018-04-19 18:40:00','success',NULL,'cron',NULL),(403,23,109,'2018-04-19 18:45:00','2018-04-19 18:45:00','success',NULL,'cron',NULL),(404,28,109,'2018-04-19 18:45:00','2018-04-19 18:45:00','success',NULL,'cron',NULL),(405,27,161,'2018-04-19 18:50:00','2018-04-19 18:50:00','success',NULL,'cron',NULL),(406,28,110,'2018-04-19 20:15:00','2018-04-19 20:15:00','success',NULL,'cron',NULL),(407,23,110,'2018-04-19 20:15:00','2018-04-19 20:15:00','success',NULL,'cron',NULL),(408,27,162,'2018-04-19 20:20:00','2018-04-19 20:20:00','success',NULL,'cron',NULL),(409,28,111,'2018-04-19 20:30:00','2018-04-19 20:30:00','success',NULL,'cron',NULL),(410,27,163,'2018-04-19 20:30:00','2018-04-19 20:30:00','success',NULL,'cron',NULL),(411,23,111,'2018-04-19 20:30:00','2018-04-19 20:30:00','success',NULL,'cron',NULL),(412,27,164,'2018-04-19 20:40:00','2018-04-19 20:40:00','success',NULL,'cron',NULL),(413,28,112,'2018-04-19 20:45:00','2018-04-19 20:45:00','success',NULL,'cron',NULL),(414,23,112,'2018-04-19 20:45:00','2018-04-19 20:45:00','success',NULL,'cron',NULL),(415,27,165,'2018-04-19 20:50:00','2018-04-19 20:50:00','success',NULL,'cron',NULL),(416,28,113,'2018-04-19 21:00:00','2018-04-19 21:00:00','success',NULL,'cron',NULL),(417,23,113,'2018-04-19 21:00:00','2018-04-19 21:00:00','success',NULL,'cron',NULL),(418,27,166,'2018-04-19 21:00:00','2018-04-19 21:00:00','success',NULL,'cron',NULL),(419,1,2,'2018-04-19 21:00:00','2018-04-19 21:00:00','success',NULL,'cron',NULL),(420,27,167,'2018-04-19 21:10:00','2018-04-19 21:10:00','success',NULL,'cron',NULL),(421,28,114,'2018-04-19 21:15:00','2018-04-19 21:15:00','success',NULL,'cron',NULL),(422,23,114,'2018-04-19 21:15:00','2018-04-19 21:15:00','success',NULL,'cron',NULL),(423,4,2,'2018-04-19 21:20:00','2018-04-19 21:20:00','success',NULL,'cron',NULL),(424,27,168,'2018-04-19 21:20:00','2018-04-19 21:20:00','success',NULL,'cron',NULL),(425,28,115,'2018-04-19 21:30:00','2018-04-19 21:30:00','success',NULL,'cron',NULL),(426,27,169,'2018-04-19 21:30:00','2018-04-19 21:30:00','success',NULL,'cron',NULL),(427,23,115,'2018-04-19 21:30:00','2018-04-19 21:30:00','success',NULL,'cron',NULL),(428,27,170,'2018-04-19 21:40:00','2018-04-19 21:40:00','success',NULL,'cron',NULL),(429,28,116,'2018-04-19 21:45:00','2018-04-19 21:45:00','success',NULL,'cron',NULL),(430,23,116,'2018-04-19 21:45:00','2018-04-19 21:45:00','success',NULL,'cron',NULL),(431,27,171,'2018-04-19 21:50:00','2018-04-19 21:50:00','success',NULL,'cron',NULL),(432,28,117,'2018-04-19 22:00:00','2018-04-19 22:00:00','success',NULL,'cron',NULL),(433,23,117,'2018-04-19 22:00:00','2018-04-19 22:00:00','success',NULL,'cron',NULL),(434,27,172,'2018-04-19 22:00:00','2018-04-19 22:00:00','success',NULL,'cron',NULL),(435,27,173,'2018-04-19 22:10:00','2018-04-19 22:10:00','success',NULL,'cron',NULL),(436,28,118,'2018-04-19 22:15:00','2018-04-19 22:15:00','success',NULL,'cron',NULL),(437,23,118,'2018-04-19 22:15:00','2018-04-19 22:15:00','success',NULL,'cron',NULL),(438,27,174,'2018-04-19 22:20:00','2018-04-19 22:20:00','success',NULL,'cron',NULL),(439,23,119,'2018-04-19 22:30:00','2018-04-19 22:30:00','success',NULL,'cron',NULL),(440,28,119,'2018-04-19 22:30:00','2018-04-19 22:30:00','success',NULL,'cron',NULL),(441,27,175,'2018-04-19 22:30:00','2018-04-19 22:30:00','success',NULL,'cron',NULL),(442,27,176,'2018-04-19 22:40:00','2018-04-19 22:40:00','success',NULL,'cron',NULL),(443,28,120,'2018-04-19 22:45:00','2018-04-19 22:45:00','success',NULL,'cron',NULL),(444,23,120,'2018-04-19 22:45:00','2018-04-19 22:45:00','success',NULL,'cron',NULL),(445,27,177,'2018-04-19 22:50:00','2018-04-19 22:50:00','success',NULL,'cron',NULL),(446,23,121,'2018-04-19 23:00:00','2018-04-19 23:00:00','success',NULL,'cron',NULL),(447,27,178,'2018-04-19 23:00:00','2018-04-19 23:00:00','success',NULL,'cron',NULL),(448,10,2,'2018-04-19 23:00:00','2018-04-19 23:00:00','success',NULL,'cron',NULL),(449,13,2,'2018-04-19 23:00:00','2018-04-19 23:00:00','success',NULL,'cron',NULL),(450,20,2,'2018-04-19 23:00:00','2018-04-19 23:00:00','success',NULL,'cron',NULL),(451,12,2,'2018-04-19 23:00:00','2018-04-19 23:00:00','success',NULL,'cron',NULL),(452,28,121,'2018-04-19 23:00:00','2018-04-19 23:00:00','success',NULL,'cron',NULL),(453,15,2,'2018-04-19 23:00:00','2018-04-19 23:00:00','success',NULL,'cron',NULL),(454,19,2,'2018-04-19 23:00:00','2018-04-19 23:00:00','success',NULL,'cron',NULL),(455,6,2,'2018-04-19 23:00:00','2018-04-19 23:00:01','success',NULL,'cron',NULL),(456,21,2,'2018-04-19 23:00:01','2018-04-19 23:00:01','success',NULL,'cron',NULL),(457,22,2,'2018-04-19 23:01:00','2018-04-19 23:01:00','success',NULL,'cron',NULL),(458,7,2,'2018-04-19 23:01:00','2018-04-19 23:01:00','success',NULL,'cron',NULL),(459,2,2,'2018-04-19 23:01:00','2018-04-19 23:01:00','success',NULL,'cron',NULL),(460,9,2,'2018-04-19 23:01:00','2018-04-19 23:01:00','success',NULL,'cron',NULL),(461,17,2,'2018-04-19 23:01:00','2018-04-19 23:01:00','success',NULL,'cron',NULL),(462,11,2,'2018-04-19 23:01:00','2018-04-19 23:01:00','success',NULL,'cron',NULL),(463,14,2,'2018-04-19 23:02:00','2018-04-19 23:02:00','success',NULL,'cron',NULL),(464,16,2,'2018-04-19 23:02:00','2018-04-19 23:02:00','success',NULL,'cron',NULL),(465,18,2,'2018-04-19 23:05:00','2018-04-19 23:05:00','success',NULL,'cron',NULL),(466,3,2,'2018-04-19 23:05:00','2018-04-19 23:05:00','success',NULL,'cron',NULL),(467,27,179,'2018-04-19 23:10:00','2018-04-19 23:10:00','success',NULL,'cron',NULL),(468,23,122,'2018-04-19 23:15:00','2018-04-19 23:15:00','success',NULL,'cron',NULL),(469,28,122,'2018-04-19 23:15:00','2018-04-19 23:15:00','success',NULL,'cron',NULL),(470,27,180,'2018-04-19 23:20:00','2018-04-19 23:20:00','success',NULL,'cron',NULL),(471,27,181,'2018-04-20 02:40:00','2018-04-20 02:40:00','success',NULL,'cron',NULL),(472,23,123,'2018-04-20 02:45:00','2018-04-20 02:45:00','success',NULL,'cron',NULL),(473,28,123,'2018-04-20 02:45:00','2018-04-20 02:45:00','success',NULL,'cron',NULL),(474,27,182,'2018-04-20 02:50:00','2018-04-20 02:50:00','success',NULL,'cron',NULL),(475,27,183,'2018-04-20 03:00:00','2018-04-20 03:00:00','success',NULL,'cron',NULL),(476,23,124,'2018-04-20 03:00:00','2018-04-20 03:00:00','success',NULL,'cron',NULL),(477,28,124,'2018-04-20 03:00:00','2018-04-20 03:00:00','success',NULL,'cron',NULL),(478,27,184,'2018-04-20 03:10:00','2018-04-20 03:10:00','success',NULL,'cron',NULL),(479,23,125,'2018-04-20 03:15:00','2018-04-20 03:15:00','success',NULL,'cron',NULL),(480,28,125,'2018-04-20 03:15:00','2018-04-20 03:15:00','success',NULL,'cron',NULL),(481,27,185,'2018-04-20 03:20:00','2018-04-20 03:20:00','success',NULL,'cron',NULL),(482,23,126,'2018-04-20 06:30:00','2018-04-20 06:30:00','success',NULL,'cron',NULL),(483,27,186,'2018-04-20 06:30:00','2018-04-20 06:30:00','success',NULL,'cron',NULL),(484,28,126,'2018-04-20 06:30:00','2018-04-20 06:30:00','success',NULL,'cron',NULL),(485,27,187,'2018-04-20 06:40:00','2018-04-20 06:40:00','success',NULL,'cron',NULL),(486,23,127,'2018-04-20 06:45:00','2018-04-20 06:45:00','success',NULL,'cron',NULL),(487,28,127,'2018-04-20 06:45:00','2018-04-20 06:45:00','success',NULL,'cron',NULL),(488,27,188,'2018-04-20 06:50:00','2018-04-20 06:50:00','success',NULL,'cron',NULL),(489,23,128,'2018-04-20 07:30:00','2018-04-20 07:30:00','success',NULL,'cron',NULL),(490,28,128,'2018-04-20 07:30:00','2018-04-20 07:30:00','success',NULL,'cron',NULL),(491,27,189,'2018-04-20 07:30:00','2018-04-20 07:30:00','success',NULL,'cron',NULL),(492,27,190,'2018-04-20 07:40:00','2018-04-20 07:40:00','success',NULL,'cron',NULL),(493,27,191,'2018-04-20 08:20:00','2018-04-20 08:20:00','success',NULL,'cron',NULL),(494,27,192,'2018-04-20 08:30:00','2018-04-20 08:30:01','success',NULL,'cron',NULL),(495,28,129,'2018-04-20 08:30:00','2018-04-20 08:30:01','success',NULL,'cron',NULL),(496,23,129,'2018-04-20 08:30:00','2018-04-20 08:30:01','success',NULL,'cron',NULL),(497,27,193,'2018-04-20 08:40:00','2018-04-20 08:40:00','success',NULL,'cron',NULL),(498,28,130,'2018-04-20 08:45:00','2018-04-20 08:45:00','success',NULL,'cron',NULL),(499,23,130,'2018-04-20 08:45:00','2018-04-20 08:45:00','success',NULL,'cron',NULL),(500,27,194,'2018-04-20 08:50:00','2018-04-20 08:50:00','success',NULL,'cron',NULL),(501,27,195,'2018-04-20 09:00:00','2018-04-20 09:00:00','success',NULL,'cron',NULL),(502,23,131,'2018-04-20 09:00:00','2018-04-20 09:00:00','success',NULL,'cron',NULL),(503,28,131,'2018-04-20 09:00:00','2018-04-20 09:00:00','success',NULL,'cron',NULL),(504,27,196,'2018-04-20 09:10:00','2018-04-20 09:10:00','success',NULL,'cron',NULL),(505,23,132,'2018-04-20 09:15:00','2018-04-20 09:15:00','success',NULL,'cron',NULL),(506,28,132,'2018-04-20 09:15:00','2018-04-20 09:15:00','success',NULL,'cron',NULL),(507,27,197,'2018-04-20 09:20:00','2018-04-20 09:20:00','success',NULL,'cron',NULL),(508,28,133,'2018-04-20 09:30:00','2018-04-20 09:30:00','success',NULL,'cron',NULL),(509,27,198,'2018-04-20 09:30:00','2018-04-20 09:30:00','success',NULL,'cron',NULL),(510,23,133,'2018-04-20 09:30:00','2018-04-20 09:30:00','success',NULL,'cron',NULL),(511,27,199,'2018-04-20 09:40:00','2018-04-20 09:40:00','success',NULL,'cron',NULL),(512,28,134,'2018-04-20 09:45:00','2018-04-20 09:45:00','success',NULL,'cron',NULL),(513,23,134,'2018-04-20 09:45:00','2018-04-20 09:45:00','success',NULL,'cron',NULL),(514,27,200,'2018-04-20 09:50:00','2018-04-20 09:50:00','success',NULL,'cron',NULL),(515,27,201,'2018-04-20 10:00:00','2018-04-20 10:00:00','success',NULL,'cron',NULL),(516,28,135,'2018-04-20 10:00:00','2018-04-20 10:00:00','success',NULL,'cron',NULL),(517,23,135,'2018-04-20 10:00:00','2018-04-20 10:00:00','success',NULL,'cron',NULL),(518,27,202,'2018-04-20 10:10:00','2018-04-20 10:10:00','success',NULL,'cron',NULL),(519,28,136,'2018-04-20 10:15:00','2018-04-20 10:15:00','success',NULL,'cron',NULL),(520,23,136,'2018-04-20 10:15:00','2018-04-20 10:15:00','success',NULL,'cron',NULL),(521,27,203,'2018-04-20 10:20:00','2018-04-20 10:20:00','success',NULL,'cron',NULL),(522,27,204,'2018-04-20 10:30:00','2018-04-20 10:30:00','success',NULL,'cron',NULL),(523,28,137,'2018-04-20 10:30:00','2018-04-20 10:30:00','success',NULL,'cron',NULL),(524,23,137,'2018-04-20 10:30:00','2018-04-20 10:30:00','success',NULL,'cron',NULL),(525,27,205,'2018-04-20 10:40:00','2018-04-20 10:40:00','success',NULL,'cron',NULL),(526,23,138,'2018-04-20 10:45:00','2018-04-20 10:45:00','success',NULL,'cron',NULL),(527,28,138,'2018-04-20 10:45:00','2018-04-20 10:45:00','success',NULL,'cron',NULL),(528,27,206,'2018-04-20 10:50:00','2018-04-20 10:50:00','success',NULL,'cron',NULL),(529,27,207,'2018-04-20 11:00:00','2018-04-20 11:00:00','success',NULL,'cron',NULL),(530,8,2,'2018-04-20 11:00:00','2018-04-20 11:00:00','success',NULL,'cron',NULL),(531,5,2,'2018-04-20 11:00:00','2018-04-20 11:00:00','success',NULL,'cron',NULL),(532,23,139,'2018-04-20 11:00:00','2018-04-20 11:00:00','success',NULL,'cron',NULL),(533,28,139,'2018-04-20 11:00:00','2018-04-20 11:00:00','success',NULL,'cron',NULL),(534,29,2,'2018-04-20 11:00:00','2018-04-20 11:00:00','success',NULL,'cron',NULL),(535,27,208,'2018-04-20 11:10:00','2018-04-20 11:10:00','success',NULL,'cron',NULL),(536,28,140,'2018-04-20 11:15:00','2018-04-20 11:15:00','success',NULL,'cron',NULL),(537,23,140,'2018-04-20 11:15:00','2018-04-20 11:15:00','success',NULL,'cron',NULL),(538,27,209,'2018-04-20 11:20:00','2018-04-20 11:20:00','success',NULL,'cron',NULL),(539,27,210,'2018-04-20 11:30:00','2018-04-20 11:30:00','success',NULL,'cron',NULL),(540,28,141,'2018-04-20 11:30:00','2018-04-20 11:30:00','success',NULL,'cron',NULL),(541,23,141,'2018-04-20 11:30:00','2018-04-20 11:30:00','success',NULL,'cron',NULL),(542,27,211,'2018-04-20 11:40:00','2018-04-20 11:40:00','success',NULL,'cron',NULL),(543,28,142,'2018-04-20 11:45:00','2018-04-20 11:45:00','success',NULL,'cron',NULL),(544,23,142,'2018-04-20 11:45:00','2018-04-20 11:45:00','success',NULL,'cron',NULL),(545,27,212,'2018-04-20 11:50:00','2018-04-20 11:50:00','success',NULL,'cron',NULL),(546,27,213,'2018-04-20 12:00:00','2018-04-20 12:00:00','success',NULL,'cron',NULL),(547,28,143,'2018-04-20 12:00:00','2018-04-20 12:00:00','success',NULL,'cron',NULL),(548,23,143,'2018-04-20 12:00:00','2018-04-20 12:00:00','success',NULL,'cron',NULL),(549,27,214,'2018-04-20 12:10:00','2018-04-20 12:10:00','success',NULL,'cron',NULL),(550,28,144,'2018-04-20 12:15:00','2018-04-20 12:15:00','success',NULL,'cron',NULL),(551,23,144,'2018-04-20 12:15:00','2018-04-20 12:15:00','success',NULL,'cron',NULL),(552,27,215,'2018-04-20 12:20:00','2018-04-20 12:20:00','success',NULL,'cron',NULL),(553,27,216,'2018-04-20 12:30:00','2018-04-20 12:30:00','success',NULL,'cron',NULL),(554,23,145,'2018-04-20 12:30:00','2018-04-20 12:30:00','success',NULL,'cron',NULL),(555,28,145,'2018-04-20 12:30:00','2018-04-20 12:30:00','success',NULL,'cron',NULL),(556,27,217,'2018-04-20 12:40:00','2018-04-20 12:40:00','success',NULL,'cron',NULL),(557,23,146,'2018-04-20 12:45:00','2018-04-20 12:45:00','success',NULL,'cron',NULL),(558,28,146,'2018-04-20 12:45:00','2018-04-20 12:45:00','success',NULL,'cron',NULL),(559,27,218,'2018-04-20 12:50:00','2018-04-20 12:50:00','success',NULL,'cron',NULL),(560,28,147,'2018-04-20 13:00:00','2018-04-20 13:00:00','success',NULL,'cron',NULL),(561,27,219,'2018-04-20 13:00:00','2018-04-20 13:00:00','success',NULL,'cron',NULL),(562,23,147,'2018-04-20 13:00:00','2018-04-20 13:00:00','success',NULL,'cron',NULL),(563,27,220,'2018-04-20 13:10:00','2018-04-20 13:10:00','success',NULL,'cron',NULL),(564,28,148,'2018-04-20 13:15:00','2018-04-20 13:15:00','success',NULL,'cron',NULL),(565,23,148,'2018-04-20 13:15:00','2018-04-20 13:15:00','success',NULL,'cron',NULL),(566,27,221,'2018-04-20 13:20:00','2018-04-20 13:20:00','success',NULL,'cron',NULL),(567,28,149,'2018-04-20 13:30:00','2018-04-20 13:30:00','success',NULL,'cron',NULL),(568,27,222,'2018-04-20 13:30:00','2018-04-20 13:30:00','success',NULL,'cron',NULL),(569,23,149,'2018-04-20 13:30:00','2018-04-20 13:30:00','success',NULL,'cron',NULL),(570,27,223,'2018-04-20 13:40:00','2018-04-20 13:40:00','success',NULL,'cron',NULL),(571,23,150,'2018-04-20 13:45:00','2018-04-20 13:45:00','success',NULL,'cron',NULL),(572,28,150,'2018-04-20 13:45:00','2018-04-20 13:45:00','success',NULL,'cron',NULL),(573,27,224,'2018-04-20 13:50:00','2018-04-20 13:50:00','success',NULL,'cron',NULL),(574,27,225,'2018-04-20 14:00:00','2018-04-20 14:00:00','success',NULL,'cron',NULL),(575,28,151,'2018-04-20 14:00:00','2018-04-20 14:00:00','success',NULL,'cron',NULL),(576,23,151,'2018-04-20 14:00:00','2018-04-20 14:00:00','success',NULL,'cron',NULL),(577,27,226,'2018-04-20 14:10:00','2018-04-20 14:10:00','success',NULL,'cron',NULL),(578,23,152,'2018-04-20 14:15:00','2018-04-20 14:15:00','success',NULL,'cron',NULL),(579,28,152,'2018-04-20 14:15:00','2018-04-20 14:15:00','success',NULL,'cron',NULL),(580,27,227,'2018-04-20 14:20:00','2018-04-20 14:20:00','success',NULL,'cron',NULL),(581,28,153,'2018-04-20 14:30:00','2018-04-20 14:30:00','success',NULL,'cron',NULL),(582,27,228,'2018-04-20 14:30:00','2018-04-20 14:30:00','success',NULL,'cron',NULL),(583,23,153,'2018-04-20 14:30:00','2018-04-20 14:30:00','success',NULL,'cron',NULL),(584,27,229,'2018-04-20 14:40:00','2018-04-20 14:40:00','success',NULL,'cron',NULL),(585,28,154,'2018-04-20 14:45:00','2018-04-20 14:45:00','success',NULL,'cron',NULL),(586,23,154,'2018-04-20 14:45:00','2018-04-20 14:45:00','success',NULL,'cron',NULL),(587,27,230,'2018-04-20 14:50:00','2018-04-20 14:50:00','success',NULL,'cron',NULL),(588,28,155,'2018-04-20 15:00:00','2018-04-20 15:00:00','success',NULL,'cron',NULL),(589,27,231,'2018-04-20 15:00:00','2018-04-20 15:00:00','success',NULL,'cron',NULL),(590,23,155,'2018-04-20 15:00:00','2018-04-20 15:00:00','success',NULL,'cron',NULL),(591,27,232,'2018-04-20 15:10:00','2018-04-20 15:10:00','success',NULL,'cron',NULL),(592,28,156,'2018-04-20 15:15:00','2018-04-20 15:15:00','success',NULL,'cron',NULL),(593,23,156,'2018-04-20 15:15:00','2018-04-20 15:15:00','success',NULL,'cron',NULL),(594,27,233,'2018-04-20 15:20:00','2018-04-20 15:20:00','success',NULL,'cron',NULL),(595,28,157,'2018-04-20 15:30:00','2018-04-20 15:30:00','success',NULL,'cron',NULL),(596,27,234,'2018-04-20 15:30:00','2018-04-20 15:30:00','success',NULL,'cron',NULL),(597,23,157,'2018-04-20 15:30:00','2018-04-20 15:30:00','success',NULL,'cron',NULL),(598,27,235,'2018-04-20 15:40:00','2018-04-20 15:40:00','success',NULL,'cron',NULL),(599,23,158,'2018-04-20 15:45:00','2018-04-20 15:45:00','success',NULL,'cron',NULL),(600,28,158,'2018-04-20 15:45:00','2018-04-20 15:45:00','success',NULL,'cron',NULL),(601,27,236,'2018-04-20 15:50:00','2018-04-20 15:50:00','success',NULL,'cron',NULL),(602,27,237,'2018-04-20 16:00:00','2018-04-20 16:00:00','success',NULL,'cron',NULL),(603,23,159,'2018-04-20 16:00:00','2018-04-20 16:00:00','success',NULL,'cron',NULL),(604,28,159,'2018-04-20 16:00:00','2018-04-20 16:00:00','success',NULL,'cron',NULL),(605,27,238,'2018-04-20 16:10:00','2018-04-20 16:10:00','success',NULL,'cron',NULL),(606,23,160,'2018-04-20 16:15:00','2018-04-20 16:15:00','success',NULL,'cron',NULL),(607,28,160,'2018-04-20 16:15:00','2018-04-20 16:15:00','success',NULL,'cron',NULL),(608,27,239,'2018-04-20 16:20:00','2018-04-20 16:20:00','success',NULL,'cron',NULL),(609,27,240,'2018-04-20 16:30:00','2018-04-20 16:30:00','success',NULL,'cron',NULL),(610,28,161,'2018-04-20 16:30:00','2018-04-20 16:30:00','success',NULL,'cron',NULL),(611,23,161,'2018-04-20 16:30:00','2018-04-20 16:30:00','success',NULL,'cron',NULL),(612,27,241,'2018-04-20 16:40:00','2018-04-20 16:40:00','success',NULL,'cron',NULL),(613,23,162,'2018-04-20 16:45:00','2018-04-20 16:45:00','success',NULL,'cron',NULL),(614,28,162,'2018-04-20 16:45:00','2018-04-20 16:45:00','success',NULL,'cron',NULL),(615,27,242,'2018-04-20 16:50:00','2018-04-20 16:50:00','success',NULL,'cron',NULL),(616,27,243,'2018-04-20 17:00:00','2018-04-20 17:00:00','success',NULL,'cron',NULL),(617,28,163,'2018-04-20 17:00:00','2018-04-20 17:00:00','success',NULL,'cron',NULL),(618,23,163,'2018-04-20 17:00:00','2018-04-20 17:00:00','success',NULL,'cron',NULL),(619,27,244,'2018-04-20 17:10:00','2018-04-20 17:10:00','success',NULL,'cron',NULL),(620,23,164,'2018-04-20 17:15:00','2018-04-20 17:15:00','success',NULL,'cron',NULL),(621,28,164,'2018-04-20 17:15:00','2018-04-20 17:15:00','success',NULL,'cron',NULL),(622,27,245,'2018-04-20 17:20:00','2018-04-20 17:20:00','success',NULL,'cron',NULL),(623,27,246,'2018-04-20 17:30:00','2018-04-20 17:30:00','success',NULL,'cron',NULL),(624,23,165,'2018-04-20 17:30:00','2018-04-20 17:30:00','success',NULL,'cron',NULL),(625,28,165,'2018-04-20 17:30:00','2018-04-20 17:30:00','success',NULL,'cron',NULL),(626,27,247,'2018-04-20 17:40:00','2018-04-20 17:40:00','success',NULL,'cron',NULL),(627,23,166,'2018-04-20 17:45:00','2018-04-20 17:45:00','success',NULL,'cron',NULL),(628,28,166,'2018-04-20 17:45:00','2018-04-20 17:45:00','success',NULL,'cron',NULL),(629,27,248,'2018-04-20 17:50:00','2018-04-20 17:50:00','success',NULL,'cron',NULL),(630,27,249,'2018-04-20 18:00:00','2018-04-20 18:00:00','success',NULL,'cron',NULL),(631,23,167,'2018-04-20 18:00:00','2018-04-20 18:00:00','success',NULL,'cron',NULL),(632,28,167,'2018-04-20 18:00:00','2018-04-20 18:00:00','success',NULL,'cron',NULL),(633,27,250,'2018-04-20 18:10:00','2018-04-20 18:10:00','success',NULL,'cron',NULL),(634,28,168,'2018-04-20 18:15:00','2018-04-20 18:15:00','success',NULL,'cron',NULL),(635,23,168,'2018-04-20 18:15:00','2018-04-20 18:15:00','success',NULL,'cron',NULL),(636,27,251,'2018-04-20 18:20:00','2018-04-20 18:20:00','success',NULL,'cron',NULL),(637,27,252,'2018-04-20 18:30:00','2018-04-20 18:30:00','success',NULL,'cron',NULL),(638,28,169,'2018-04-20 18:30:00','2018-04-20 18:30:00','success',NULL,'cron',NULL),(639,23,169,'2018-04-20 18:30:00','2018-04-20 18:30:00','success',NULL,'cron',NULL),(640,27,253,'2018-04-20 18:40:00','2018-04-20 18:40:00','success',NULL,'cron',NULL),(641,23,170,'2018-04-20 18:45:00','2018-04-20 18:45:00','success',NULL,'cron',NULL),(642,28,170,'2018-04-20 18:45:00','2018-04-20 18:45:00','success',NULL,'cron',NULL),(643,27,254,'2018-04-20 18:50:00','2018-04-20 18:50:00','success',NULL,'cron',NULL),(644,27,255,'2018-04-20 19:00:00','2018-04-20 19:00:00','success',NULL,'cron',NULL),(645,28,171,'2018-04-20 19:00:00','2018-04-20 19:00:00','success',NULL,'cron',NULL),(646,23,171,'2018-04-20 19:00:00','2018-04-20 19:00:00','success',NULL,'cron',NULL),(647,27,256,'2018-04-20 19:10:00','2018-04-20 19:10:00','success',NULL,'cron',NULL),(648,28,172,'2018-04-20 19:15:00','2018-04-20 19:15:00','success',NULL,'cron',NULL),(649,23,172,'2018-04-20 19:15:00','2018-04-20 19:15:00','success',NULL,'cron',NULL),(650,27,257,'2018-04-20 19:20:00','2018-04-20 19:20:00','success',NULL,'cron',NULL),(651,27,258,'2018-04-20 19:30:00','2018-04-20 19:30:00','success',NULL,'cron',NULL),(652,28,173,'2018-04-20 19:30:00','2018-04-20 19:30:00','success',NULL,'cron',NULL),(653,23,173,'2018-04-20 19:30:00','2018-04-20 19:30:00','success',NULL,'cron',NULL),(654,27,259,'2018-04-20 19:40:00','2018-04-20 19:40:00','success',NULL,'cron',NULL),(655,23,174,'2018-04-20 19:45:00','2018-04-20 19:45:00','success',NULL,'cron',NULL),(656,28,174,'2018-04-20 19:45:00','2018-04-20 19:45:00','success',NULL,'cron',NULL),(657,27,260,'2018-04-20 19:50:00','2018-04-20 19:50:00','success',NULL,'cron',NULL),(658,27,261,'2018-04-20 20:00:00','2018-04-20 20:00:00','success',NULL,'cron',NULL),(659,23,175,'2018-04-20 20:00:00','2018-04-20 20:00:00','success',NULL,'cron',NULL),(660,28,175,'2018-04-20 20:00:00','2018-04-20 20:00:00','success',NULL,'cron',NULL),(661,27,262,'2018-04-20 20:10:00','2018-04-20 20:10:00','success',NULL,'cron',NULL),(662,28,176,'2018-04-20 20:15:00','2018-04-20 20:15:00','success',NULL,'cron',NULL),(663,23,176,'2018-04-20 20:15:00','2018-04-20 20:15:00','success',NULL,'cron',NULL),(664,27,263,'2018-04-20 20:20:00','2018-04-20 20:20:00','success',NULL,'cron',NULL),(665,28,177,'2018-04-20 20:30:00','2018-04-20 20:30:00','success',NULL,'cron',NULL),(666,27,264,'2018-04-20 20:30:00','2018-04-20 20:30:00','success',NULL,'cron',NULL),(667,23,177,'2018-04-20 20:30:00','2018-04-20 20:30:00','success',NULL,'cron',NULL),(668,27,265,'2018-04-20 20:40:00','2018-04-20 20:40:00','success',NULL,'cron',NULL),(669,28,178,'2018-04-20 20:45:00','2018-04-20 20:45:00','success',NULL,'cron',NULL),(670,23,178,'2018-04-20 20:45:00','2018-04-20 20:45:00','success',NULL,'cron',NULL),(671,27,266,'2018-04-20 20:50:00','2018-04-20 20:50:00','success',NULL,'cron',NULL),(672,28,179,'2018-04-20 21:00:00','2018-04-20 21:00:00','success',NULL,'cron',NULL),(673,27,267,'2018-04-20 21:00:00','2018-04-20 21:00:00','success',NULL,'cron',NULL),(674,23,179,'2018-04-20 21:00:00','2018-04-20 21:00:00','success',NULL,'cron',NULL),(675,1,3,'2018-04-20 21:00:00','2018-04-20 21:00:00','success',NULL,'cron',NULL),(676,27,268,'2018-04-20 21:10:00','2018-04-20 21:10:00','success',NULL,'cron',NULL),(677,23,180,'2018-04-20 21:15:00','2018-04-20 21:15:00','success',NULL,'cron',NULL),(678,28,180,'2018-04-20 21:15:00','2018-04-20 21:15:00','success',NULL,'cron',NULL),(679,27,269,'2018-04-20 21:20:00','2018-04-20 21:20:00','success',NULL,'cron',NULL),(680,4,3,'2018-04-20 21:20:00','2018-04-20 21:20:00','success',NULL,'cron',NULL),(681,27,270,'2018-04-20 21:30:00','2018-04-20 21:30:00','success',NULL,'cron',NULL),(682,28,181,'2018-04-20 21:30:00','2018-04-20 21:30:00','success',NULL,'cron',NULL),(683,23,181,'2018-04-20 21:30:00','2018-04-20 21:30:00','success',NULL,'cron',NULL),(684,27,271,'2018-04-20 21:40:00','2018-04-20 21:40:00','success',NULL,'cron',NULL),(685,28,182,'2018-04-20 21:45:00','2018-04-20 21:45:00','success',NULL,'cron',NULL),(686,23,182,'2018-04-20 21:45:00','2018-04-20 21:45:00','success',NULL,'cron',NULL),(687,27,272,'2018-04-20 21:50:00','2018-04-20 21:50:00','success',NULL,'cron',NULL),(688,27,273,'2018-04-20 22:00:00','2018-04-20 22:00:00','success',NULL,'cron',NULL),(689,28,183,'2018-04-20 22:00:00','2018-04-20 22:00:00','success',NULL,'cron',NULL),(690,23,183,'2018-04-20 22:00:00','2018-04-20 22:00:00','success',NULL,'cron',NULL),(691,27,274,'2018-04-20 22:10:00','2018-04-20 22:10:00','success',NULL,'cron',NULL),(692,23,184,'2018-04-20 22:15:00','2018-04-20 22:15:00','success',NULL,'cron',NULL),(693,28,184,'2018-04-20 22:15:00','2018-04-20 22:15:00','success',NULL,'cron',NULL),(694,27,275,'2018-04-20 22:20:00','2018-04-20 22:20:00','success',NULL,'cron',NULL),(695,27,276,'2018-04-20 22:30:00','2018-04-20 22:30:00','success',NULL,'cron',NULL),(696,23,185,'2018-04-20 22:30:00','2018-04-20 22:30:00','success',NULL,'cron',NULL),(697,28,185,'2018-04-20 22:30:00','2018-04-20 22:30:00','success',NULL,'cron',NULL),(698,27,277,'2018-04-20 22:40:00','2018-04-20 22:40:00','success',NULL,'cron',NULL),(699,23,186,'2018-04-20 22:45:00','2018-04-20 22:45:00','success',NULL,'cron',NULL),(700,28,186,'2018-04-20 22:45:00','2018-04-20 22:45:00','success',NULL,'cron',NULL),(701,27,278,'2018-04-20 22:50:00','2018-04-20 22:50:00','success',NULL,'cron',NULL),(702,27,279,'2018-04-20 23:00:00','2018-04-20 23:00:00','success',NULL,'cron',NULL),(703,12,3,'2018-04-20 23:00:00','2018-04-20 23:00:00','success',NULL,'cron',NULL),(704,15,3,'2018-04-20 23:00:00','2018-04-20 23:00:00','success',NULL,'cron',NULL),(705,10,3,'2018-04-20 23:00:00','2018-04-20 23:00:00','success',NULL,'cron',NULL),(706,23,187,'2018-04-20 23:00:00','2018-04-20 23:00:00','success',NULL,'cron',NULL),(707,20,3,'2018-04-20 23:00:00','2018-04-20 23:00:00','success',NULL,'cron',NULL),(708,19,3,'2018-04-20 23:00:00','2018-04-20 23:00:00','success',NULL,'cron',NULL),(709,13,3,'2018-04-20 23:00:00','2018-04-20 23:00:00','success',NULL,'cron',NULL),(710,6,3,'2018-04-20 23:00:00','2018-04-20 23:00:00','success',NULL,'cron',NULL),(711,21,3,'2018-04-20 23:00:00','2018-04-20 23:00:00','success',NULL,'cron',NULL),(712,28,187,'2018-04-20 23:00:00','2018-04-20 23:00:01','success',NULL,'cron',NULL),(713,9,3,'2018-04-20 23:01:00','2018-04-20 23:01:00','success',NULL,'cron',NULL),(714,7,3,'2018-04-20 23:01:00','2018-04-20 23:01:00','success',NULL,'cron',NULL),(715,22,3,'2018-04-20 23:01:00','2018-04-20 23:01:00','success',NULL,'cron',NULL),(716,2,3,'2018-04-20 23:01:00','2018-04-20 23:01:00','success',NULL,'cron',NULL),(717,17,3,'2018-04-20 23:01:00','2018-04-20 23:01:00','success',NULL,'cron',NULL),(718,11,3,'2018-04-20 23:01:00','2018-04-20 23:01:00','success',NULL,'cron',NULL),(719,16,3,'2018-04-20 23:02:00','2018-04-20 23:02:00','success',NULL,'cron',NULL),(720,14,3,'2018-04-20 23:02:00','2018-04-20 23:02:00','success',NULL,'cron',NULL),(721,18,3,'2018-04-20 23:05:00','2018-04-20 23:05:00','success',NULL,'cron',NULL),(722,3,3,'2018-04-20 23:05:00','2018-04-20 23:05:00','success',NULL,'cron',NULL),(723,27,280,'2018-04-20 23:10:00','2018-04-20 23:10:00','success',NULL,'cron',NULL),(724,23,188,'2018-04-20 23:15:00','2018-04-20 23:15:00','success',NULL,'cron',NULL),(725,28,188,'2018-04-20 23:15:00','2018-04-20 23:15:00','success',NULL,'cron',NULL),(726,27,281,'2018-04-20 23:20:00','2018-04-20 23:20:00','success',NULL,'cron',NULL),(727,28,189,'2018-04-20 23:30:00','2018-04-20 23:30:00','success',NULL,'cron',NULL),(728,27,282,'2018-04-20 23:30:00','2018-04-20 23:30:00','success',NULL,'cron',NULL),(729,23,189,'2018-04-20 23:30:00','2018-04-20 23:30:00','success',NULL,'cron',NULL),(730,27,283,'2018-04-20 23:40:00','2018-04-20 23:40:00','success',NULL,'cron',NULL),(731,28,190,'2018-04-20 23:45:00','2018-04-20 23:45:00','success',NULL,'cron',NULL),(732,23,190,'2018-04-20 23:45:00','2018-04-20 23:45:00','success',NULL,'cron',NULL),(733,27,284,'2018-04-20 23:50:00','2018-04-20 23:50:00','success',NULL,'cron',NULL),(734,27,285,'2018-04-21 00:00:00','2018-04-21 00:00:00','success',NULL,'cron',NULL),(735,23,191,'2018-04-21 00:00:00','2018-04-21 00:00:00','success',NULL,'cron',NULL),(736,28,191,'2018-04-21 00:00:00','2018-04-21 00:00:00','success',NULL,'cron',NULL),(737,27,286,'2018-04-21 00:10:00','2018-04-21 00:10:00','success',NULL,'cron',NULL),(738,23,192,'2018-04-21 00:15:00','2018-04-21 00:15:00','success',NULL,'cron',NULL),(739,28,192,'2018-04-21 00:15:00','2018-04-21 00:15:00','success',NULL,'cron',NULL),(740,27,287,'2018-04-21 00:20:00','2018-04-21 00:20:00','success',NULL,'cron',NULL),(741,27,288,'2018-04-21 00:30:00','2018-04-21 00:30:00','success',NULL,'cron',NULL),(742,23,193,'2018-04-21 00:30:00','2018-04-21 00:30:00','success',NULL,'cron',NULL),(743,28,193,'2018-04-21 00:30:00','2018-04-21 00:30:00','success',NULL,'cron',NULL),(744,27,289,'2018-04-21 00:40:00','2018-04-21 00:40:00','success',NULL,'cron',NULL),(745,23,194,'2018-04-21 00:45:00','2018-04-21 00:45:00','success',NULL,'cron',NULL),(746,28,194,'2018-04-21 00:45:00','2018-04-21 00:45:00','success',NULL,'cron',NULL),(747,27,290,'2018-04-21 00:50:00','2018-04-21 00:50:00','success',NULL,'cron',NULL),(748,27,291,'2018-04-21 01:00:00','2018-04-21 01:00:00','success',NULL,'cron',NULL),(749,28,195,'2018-04-21 01:00:00','2018-04-21 01:00:00','success',NULL,'cron',NULL),(750,23,195,'2018-04-21 01:00:00','2018-04-21 01:00:00','success',NULL,'cron',NULL),(751,27,292,'2018-04-21 01:10:00','2018-04-21 01:10:00','success',NULL,'cron',NULL),(752,28,196,'2018-04-21 01:15:00','2018-04-21 01:15:00','success',NULL,'cron',NULL),(753,23,196,'2018-04-21 01:15:00','2018-04-21 01:15:00','success',NULL,'cron',NULL),(754,27,293,'2018-04-21 01:20:00','2018-04-21 01:20:00','success',NULL,'cron',NULL),(755,27,294,'2018-04-21 01:30:00','2018-04-21 01:30:00','success',NULL,'cron',NULL),(756,28,197,'2018-04-21 01:30:00','2018-04-21 01:30:00','success',NULL,'cron',NULL),(757,23,197,'2018-04-21 01:30:00','2018-04-21 01:30:00','success',NULL,'cron',NULL),(758,27,295,'2018-04-21 01:40:00','2018-04-21 01:40:00','success',NULL,'cron',NULL),(759,28,198,'2018-04-21 01:45:00','2018-04-21 01:45:00','success',NULL,'cron',NULL),(760,23,198,'2018-04-21 01:45:00','2018-04-21 01:45:00','success',NULL,'cron',NULL),(761,27,296,'2018-04-21 01:50:00','2018-04-21 01:50:00','success',NULL,'cron',NULL),(762,27,297,'2018-04-21 02:00:00','2018-04-21 02:00:00','success',NULL,'cron',NULL),(763,28,199,'2018-04-21 02:00:00','2018-04-21 02:00:00','success',NULL,'cron',NULL),(764,23,199,'2018-04-21 02:00:00','2018-04-21 02:00:00','success',NULL,'cron',NULL),(765,27,298,'2018-04-21 02:10:00','2018-04-21 02:10:00','success',NULL,'cron',NULL),(766,28,200,'2018-04-21 02:15:00','2018-04-21 02:15:00','success',NULL,'cron',NULL),(767,23,200,'2018-04-21 02:15:00','2018-04-21 02:15:00','success',NULL,'cron',NULL),(768,27,299,'2018-04-21 02:20:00','2018-04-21 02:20:00','success',NULL,'cron',NULL),(769,27,300,'2018-04-21 02:30:00','2018-04-21 02:30:00','success',NULL,'cron',NULL),(770,28,201,'2018-04-21 02:30:00','2018-04-21 02:30:00','success',NULL,'cron',NULL),(771,23,201,'2018-04-21 02:30:00','2018-04-21 02:30:00','success',NULL,'cron',NULL),(772,27,301,'2018-04-21 02:40:00','2018-04-21 02:40:00','success',NULL,'cron',NULL),(773,23,202,'2018-04-21 02:45:00','2018-04-21 02:45:00','success',NULL,'cron',NULL),(774,28,202,'2018-04-21 02:45:00','2018-04-21 02:45:00','success',NULL,'cron',NULL),(775,27,302,'2018-04-21 02:50:00','2018-04-21 02:50:00','success',NULL,'cron',NULL),(776,28,203,'2018-04-21 03:00:00','2018-04-21 03:00:00','success',NULL,'cron',NULL),(777,27,303,'2018-04-21 03:00:00','2018-04-21 03:00:00','success',NULL,'cron',NULL),(778,23,203,'2018-04-21 03:00:00','2018-04-21 03:00:00','success',NULL,'cron',NULL),(779,27,304,'2018-04-21 03:10:00','2018-04-21 03:10:00','success',NULL,'cron',NULL),(780,28,204,'2018-04-21 03:15:00','2018-04-21 03:15:00','success',NULL,'cron',NULL),(781,23,204,'2018-04-21 03:15:00','2018-04-21 03:15:00','success',NULL,'cron',NULL),(782,27,305,'2018-04-21 03:20:00','2018-04-21 03:20:00','success',NULL,'cron',NULL),(783,28,205,'2018-04-21 03:30:00','2018-04-21 03:30:00','success',NULL,'cron',NULL),(784,23,205,'2018-04-21 03:30:00','2018-04-21 03:30:00','success',NULL,'cron',NULL),(785,27,306,'2018-04-21 03:30:00','2018-04-21 03:30:00','success',NULL,'cron',NULL),(786,27,307,'2018-04-21 03:40:00','2018-04-21 03:40:00','success',NULL,'cron',NULL),(787,28,206,'2018-04-21 03:45:00','2018-04-21 03:45:00','success',NULL,'cron',NULL),(788,23,206,'2018-04-21 03:45:00','2018-04-21 03:45:00','success',NULL,'cron',NULL),(789,27,308,'2018-04-21 03:50:00','2018-04-21 03:50:00','success',NULL,'cron',NULL),(790,28,207,'2018-04-21 04:00:00','2018-04-21 04:00:00','success',NULL,'cron',NULL),(791,27,309,'2018-04-21 04:00:00','2018-04-21 04:00:00','success',NULL,'cron',NULL),(792,23,207,'2018-04-21 04:00:00','2018-04-21 04:00:00','success',NULL,'cron',NULL),(793,24,2,'2018-04-21 04:00:00','2018-04-21 04:00:00','success',NULL,'cron',NULL),(794,25,2,'2018-04-21 04:00:00','2018-04-21 04:00:00','success',NULL,'cron',NULL),(795,26,2,'2018-04-21 04:00:00','2018-04-21 04:00:00','success',NULL,'cron',NULL),(796,27,310,'2018-04-21 04:10:00','2018-04-21 04:10:00','success',NULL,'cron',NULL),(797,28,208,'2018-04-21 04:15:00','2018-04-21 04:15:00','success',NULL,'cron',NULL),(798,23,208,'2018-04-21 04:15:00','2018-04-21 04:15:00','success',NULL,'cron',NULL),(799,27,311,'2018-04-21 04:20:00','2018-04-21 04:20:00','success',NULL,'cron',NULL),(800,27,312,'2018-04-21 04:30:00','2018-04-21 04:30:00','success',NULL,'cron',NULL),(801,28,209,'2018-04-21 04:30:00','2018-04-21 04:30:00','success',NULL,'cron',NULL),(802,23,209,'2018-04-21 04:30:00','2018-04-21 04:30:00','success',NULL,'cron',NULL),(803,27,313,'2018-04-21 04:40:00','2018-04-21 04:40:00','success',NULL,'cron',NULL),(804,28,210,'2018-04-21 04:45:00','2018-04-21 04:45:00','success',NULL,'cron',NULL),(805,23,210,'2018-04-21 04:45:00','2018-04-21 04:45:00','success',NULL,'cron',NULL),(806,27,314,'2018-04-21 04:50:00','2018-04-21 04:50:00','success',NULL,'cron',NULL),(807,27,315,'2018-04-21 05:00:00','2018-04-21 05:00:00','success',NULL,'cron',NULL),(808,28,211,'2018-04-21 05:00:00','2018-04-21 05:00:00','success',NULL,'cron',NULL),(809,23,211,'2018-04-21 05:00:00','2018-04-21 05:00:00','success',NULL,'cron',NULL),(810,27,316,'2018-04-21 05:10:00','2018-04-21 05:10:00','success',NULL,'cron',NULL),(811,28,212,'2018-04-21 05:15:00','2018-04-21 05:15:00','success',NULL,'cron',NULL),(812,23,212,'2018-04-21 05:15:00','2018-04-21 05:15:00','success',NULL,'cron',NULL),(813,27,317,'2018-04-21 05:20:00','2018-04-21 05:20:00','success',NULL,'cron',NULL),(814,23,213,'2018-04-21 05:30:00','2018-04-21 05:30:00','success',NULL,'cron',NULL),(815,28,213,'2018-04-21 05:30:00','2018-04-21 05:30:00','success',NULL,'cron',NULL),(816,27,318,'2018-04-21 05:30:00','2018-04-21 05:30:00','success',NULL,'cron',NULL),(817,27,319,'2018-04-21 05:40:00','2018-04-21 05:40:00','success',NULL,'cron',NULL),(818,28,214,'2018-04-21 05:45:00','2018-04-21 05:45:00','success',NULL,'cron',NULL),(819,23,214,'2018-04-21 05:45:00','2018-04-21 05:45:00','success',NULL,'cron',NULL),(820,27,320,'2018-04-21 05:50:00','2018-04-21 05:50:00','success',NULL,'cron',NULL),(821,23,215,'2018-04-21 06:00:00','2018-04-21 06:00:00','success',NULL,'cron',NULL),(822,27,321,'2018-04-21 06:00:00','2018-04-21 06:00:00','success',NULL,'cron',NULL),(823,28,215,'2018-04-21 06:00:00','2018-04-21 06:00:00','success',NULL,'cron',NULL),(824,27,322,'2018-04-21 06:10:00','2018-04-21 06:10:00','success',NULL,'cron',NULL),(825,28,216,'2018-04-21 06:15:00','2018-04-21 06:15:00','success',NULL,'cron',NULL),(826,23,216,'2018-04-21 06:15:00','2018-04-21 06:15:00','success',NULL,'cron',NULL),(827,27,323,'2018-04-21 06:20:00','2018-04-21 06:20:00','success',NULL,'cron',NULL),(828,27,324,'2018-04-21 06:30:00','2018-04-21 06:30:00','success',NULL,'cron',NULL),(829,28,217,'2018-04-21 06:30:00','2018-04-21 06:30:00','success',NULL,'cron',NULL),(830,23,217,'2018-04-21 06:30:00','2018-04-21 06:30:00','success',NULL,'cron',NULL),(831,27,325,'2018-04-21 06:40:00','2018-04-21 06:40:00','success',NULL,'cron',NULL),(832,23,218,'2018-04-21 06:45:00','2018-04-21 06:45:00','success',NULL,'cron',NULL),(833,28,218,'2018-04-21 06:45:00','2018-04-21 06:45:00','success',NULL,'cron',NULL),(834,27,326,'2018-04-21 06:50:00','2018-04-21 06:50:00','success',NULL,'cron',NULL),(835,27,327,'2018-04-21 07:00:00','2018-04-21 07:00:00','success',NULL,'cron',NULL),(836,28,219,'2018-04-21 07:00:00','2018-04-21 07:00:00','success',NULL,'cron',NULL),(837,23,219,'2018-04-21 07:00:00','2018-04-21 07:00:00','success',NULL,'cron',NULL),(838,27,328,'2018-04-21 07:10:00','2018-04-21 07:10:00','success',NULL,'cron',NULL),(839,23,220,'2018-04-21 07:15:00','2018-04-21 07:15:00','success',NULL,'cron',NULL),(840,28,220,'2018-04-21 07:15:00','2018-04-21 07:15:00','success',NULL,'cron',NULL),(841,27,329,'2018-04-21 07:20:00','2018-04-21 07:20:00','success',NULL,'cron',NULL),(842,27,330,'2018-04-21 07:30:00','2018-04-21 07:30:00','success',NULL,'cron',NULL),(843,28,221,'2018-04-21 07:30:00','2018-04-21 07:30:00','success',NULL,'cron',NULL),(844,23,221,'2018-04-21 07:30:00','2018-04-21 07:30:00','success',NULL,'cron',NULL),(845,27,331,'2018-04-21 07:40:00','2018-04-21 07:40:00','success',NULL,'cron',NULL),(846,28,222,'2018-04-21 07:45:00','2018-04-21 07:45:00','success',NULL,'cron',NULL),(847,23,222,'2018-04-21 07:45:00','2018-04-21 07:45:00','success',NULL,'cron',NULL),(848,27,332,'2018-04-21 07:50:00','2018-04-21 07:50:00','success',NULL,'cron',NULL),(849,28,223,'2018-04-21 08:00:00','2018-04-21 08:00:00','success',NULL,'cron',NULL),(850,27,333,'2018-04-21 08:00:00','2018-04-21 08:00:00','success',NULL,'cron',NULL),(851,23,223,'2018-04-21 08:00:00','2018-04-21 08:00:00','success',NULL,'cron',NULL),(852,27,334,'2018-04-21 08:10:00','2018-04-21 08:10:00','success',NULL,'cron',NULL),(853,23,224,'2018-04-21 08:15:00','2018-04-21 08:15:00','success',NULL,'cron',NULL),(854,28,224,'2018-04-21 08:15:00','2018-04-21 08:15:00','success',NULL,'cron',NULL),(855,27,335,'2018-04-21 08:20:00','2018-04-21 08:20:00','success',NULL,'cron',NULL),(856,27,336,'2018-04-21 08:30:00','2018-04-21 08:30:00','success',NULL,'cron',NULL),(857,23,225,'2018-04-21 08:30:00','2018-04-21 08:30:00','success',NULL,'cron',NULL),(858,28,225,'2018-04-21 08:30:00','2018-04-21 08:30:00','success',NULL,'cron',NULL),(859,27,337,'2018-04-21 08:40:00','2018-04-21 08:40:00','success',NULL,'cron',NULL),(860,23,226,'2018-04-21 08:45:00','2018-04-21 08:45:00','success',NULL,'cron',NULL),(861,28,226,'2018-04-21 08:45:00','2018-04-21 08:45:00','success',NULL,'cron',NULL),(862,27,338,'2018-04-21 08:50:00','2018-04-21 08:50:00','success',NULL,'cron',NULL),(863,23,227,'2018-04-21 09:00:00','2018-04-21 09:00:00','success',NULL,'cron',NULL),(864,27,339,'2018-04-21 09:00:00','2018-04-21 09:00:00','success',NULL,'cron',NULL),(865,28,227,'2018-04-21 09:00:00','2018-04-21 09:00:00','success',NULL,'cron',NULL),(866,27,340,'2018-04-21 09:10:00','2018-04-21 09:10:00','success',NULL,'cron',NULL),(867,23,228,'2018-04-21 09:15:00','2018-04-21 09:15:00','success',NULL,'cron',NULL),(868,28,228,'2018-04-21 09:15:00','2018-04-21 09:15:00','success',NULL,'cron',NULL),(869,27,341,'2018-04-21 09:20:00','2018-04-21 09:20:00','success',NULL,'cron',NULL),(870,27,342,'2018-04-21 09:30:00','2018-04-21 09:30:00','success',NULL,'cron',NULL),(871,28,229,'2018-04-21 09:30:00','2018-04-21 09:30:00','success',NULL,'cron',NULL),(872,23,229,'2018-04-21 09:30:00','2018-04-21 09:30:00','success',NULL,'cron',NULL),(873,27,343,'2018-04-21 09:40:00','2018-04-21 09:40:00','success',NULL,'cron',NULL),(874,28,230,'2018-04-21 09:45:00','2018-04-21 09:45:00','success',NULL,'cron',NULL),(875,23,230,'2018-04-21 09:45:00','2018-04-21 09:45:00','success',NULL,'cron',NULL),(876,27,344,'2018-04-21 09:50:00','2018-04-21 09:50:00','success',NULL,'cron',NULL),(877,23,231,'2018-04-21 10:00:00','2018-04-21 10:00:00','success',NULL,'cron',NULL),(878,27,345,'2018-04-21 10:00:00','2018-04-21 10:00:00','success',NULL,'cron',NULL),(879,28,231,'2018-04-21 10:00:00','2018-04-21 10:00:00','success',NULL,'cron',NULL),(880,27,346,'2018-04-21 10:10:00','2018-04-21 10:10:00','success',NULL,'cron',NULL),(881,28,232,'2018-04-21 10:15:00','2018-04-21 10:15:00','success',NULL,'cron',NULL),(882,23,232,'2018-04-21 10:15:00','2018-04-21 10:15:00','success',NULL,'cron',NULL),(883,27,347,'2018-04-21 10:20:00','2018-04-21 10:20:00','success',NULL,'cron',NULL),(884,27,348,'2018-04-21 10:30:00','2018-04-21 10:30:00','success',NULL,'cron',NULL),(885,23,233,'2018-04-21 10:30:00','2018-04-21 10:30:00','success',NULL,'cron',NULL),(886,28,233,'2018-04-21 10:30:00','2018-04-21 10:30:00','success',NULL,'cron',NULL),(887,27,349,'2018-04-21 10:40:00','2018-04-21 10:40:00','success',NULL,'cron',NULL),(888,23,234,'2018-04-21 10:45:00','2018-04-21 10:45:00','success',NULL,'cron',NULL),(889,28,234,'2018-04-21 10:45:00','2018-04-21 10:45:00','success',NULL,'cron',NULL),(890,27,350,'2018-04-21 10:50:00','2018-04-21 10:50:00','success',NULL,'cron',NULL),(891,5,3,'2018-04-21 11:00:00','2018-04-21 11:00:00','success',NULL,'cron',NULL),(892,28,235,'2018-04-21 11:00:00','2018-04-21 11:00:00','success',NULL,'cron',NULL),(893,27,351,'2018-04-21 11:00:00','2018-04-21 11:00:00','success',NULL,'cron',NULL),(894,8,3,'2018-04-21 11:00:00','2018-04-21 11:00:00','success',NULL,'cron',NULL),(895,23,235,'2018-04-21 11:00:00','2018-04-21 11:00:00','success',NULL,'cron',NULL),(896,29,3,'2018-04-21 11:00:00','2018-04-21 11:00:00','success',NULL,'cron',NULL),(897,27,352,'2018-04-21 11:10:00','2018-04-21 11:10:00','success',NULL,'cron',NULL),(898,28,236,'2018-04-21 11:15:00','2018-04-21 11:15:00','success',NULL,'cron',NULL),(899,23,236,'2018-04-21 11:15:00','2018-04-21 11:15:00','success',NULL,'cron',NULL),(900,27,353,'2018-04-21 11:20:00','2018-04-21 11:20:00','success',NULL,'cron',NULL),(901,28,237,'2018-04-21 11:30:00','2018-04-21 11:30:00','success',NULL,'cron',NULL),(902,27,354,'2018-04-21 11:30:00','2018-04-21 11:30:00','success',NULL,'cron',NULL),(903,23,237,'2018-04-21 11:30:00','2018-04-21 11:30:00','success',NULL,'cron',NULL),(904,27,355,'2018-04-21 11:40:00','2018-04-21 11:40:00','success',NULL,'cron',NULL),(905,23,238,'2018-04-21 11:45:00','2018-04-21 11:45:00','success',NULL,'cron',NULL),(906,28,238,'2018-04-21 11:45:00','2018-04-21 11:45:00','success',NULL,'cron',NULL),(907,27,356,'2018-04-21 11:50:00','2018-04-21 11:50:00','success',NULL,'cron',NULL),(908,27,357,'2018-04-21 12:00:00','2018-04-21 12:00:00','success',NULL,'cron',NULL),(909,23,239,'2018-04-21 12:00:00','2018-04-21 12:00:00','success',NULL,'cron',NULL),(910,28,239,'2018-04-21 12:00:00','2018-04-21 12:00:00','success',NULL,'cron',NULL),(911,27,358,'2018-04-21 12:10:00','2018-04-21 12:10:00','success',NULL,'cron',NULL),(912,23,240,'2018-04-21 12:15:00','2018-04-21 12:15:00','success',NULL,'cron',NULL),(913,28,240,'2018-04-21 12:15:00','2018-04-21 12:15:00','success',NULL,'cron',NULL),(914,27,359,'2018-04-21 12:20:00','2018-04-21 12:20:00','success',NULL,'cron',NULL),(915,27,360,'2018-04-21 12:30:00','2018-04-21 12:30:00','success',NULL,'cron',NULL),(916,23,241,'2018-04-21 12:30:00','2018-04-21 12:30:00','success',NULL,'cron',NULL),(917,28,241,'2018-04-21 12:30:00','2018-04-21 12:30:00','success',NULL,'cron',NULL),(918,27,361,'2018-04-21 12:40:00','2018-04-21 12:40:00','success',NULL,'cron',NULL),(919,23,242,'2018-04-21 12:45:00','2018-04-21 12:45:00','success',NULL,'cron',NULL),(920,28,242,'2018-04-21 12:45:00','2018-04-21 12:45:00','success',NULL,'cron',NULL),(921,27,362,'2018-04-21 12:50:00','2018-04-21 12:50:00','success',NULL,'cron',NULL),(922,27,363,'2018-04-21 13:00:00','2018-04-21 13:00:00','success',NULL,'cron',NULL),(923,28,243,'2018-04-21 13:00:00','2018-04-21 13:00:00','success',NULL,'cron',NULL),(924,23,243,'2018-04-21 13:00:00','2018-04-21 13:00:00','success',NULL,'cron',NULL),(925,27,364,'2018-04-21 13:10:00','2018-04-21 13:10:00','success',NULL,'cron',NULL),(926,28,244,'2018-04-21 13:15:00','2018-04-21 13:15:00','success',NULL,'cron',NULL),(927,23,244,'2018-04-21 13:15:00','2018-04-21 13:15:00','success',NULL,'cron',NULL),(928,27,365,'2018-04-21 13:20:00','2018-04-21 13:20:00','success',NULL,'cron',NULL),(929,28,245,'2018-04-21 13:30:00','2018-04-21 13:30:00','success',NULL,'cron',NULL),(930,23,245,'2018-04-21 13:30:00','2018-04-21 13:30:00','success',NULL,'cron',NULL),(931,27,366,'2018-04-21 13:30:00','2018-04-21 13:30:00','success',NULL,'cron',NULL),(932,27,367,'2018-04-21 13:40:00','2018-04-21 13:40:00','success',NULL,'cron',NULL),(933,23,246,'2018-04-21 13:45:00','2018-04-21 13:45:00','success',NULL,'cron',NULL),(934,28,246,'2018-04-21 13:45:00','2018-04-21 13:45:00','success',NULL,'cron',NULL),(935,27,368,'2018-04-21 13:50:00','2018-04-21 13:50:00','success',NULL,'cron',NULL),(936,27,369,'2018-04-21 14:00:00','2018-04-21 14:00:00','success',NULL,'cron',NULL),(937,28,247,'2018-04-21 14:00:00','2018-04-21 14:00:00','success',NULL,'cron',NULL),(938,23,247,'2018-04-21 14:00:00','2018-04-21 14:00:00','success',NULL,'cron',NULL),(939,27,370,'2018-04-21 14:10:00','2018-04-21 14:10:00','success',NULL,'cron',NULL),(940,28,248,'2018-04-21 14:15:00','2018-04-21 14:15:00','success',NULL,'cron',NULL),(941,23,248,'2018-04-21 14:15:00','2018-04-21 14:15:00','success',NULL,'cron',NULL),(942,27,371,'2018-04-21 14:20:00','2018-04-21 14:20:00','success',NULL,'cron',NULL),(943,27,372,'2018-04-21 14:30:00','2018-04-21 14:30:00','success',NULL,'cron',NULL),(944,23,249,'2018-04-21 14:30:00','2018-04-21 14:30:00','success',NULL,'cron',NULL),(945,28,249,'2018-04-21 14:30:00','2018-04-21 14:30:00','success',NULL,'cron',NULL),(946,27,373,'2018-04-21 14:40:00','2018-04-21 14:40:00','success',NULL,'cron',NULL),(947,23,250,'2018-04-21 14:45:00','2018-04-21 14:45:00','success',NULL,'cron',NULL),(948,28,250,'2018-04-21 14:45:00','2018-04-21 14:45:00','success',NULL,'cron',NULL),(949,27,374,'2018-04-21 14:50:00','2018-04-21 14:50:00','success',NULL,'cron',NULL),(950,23,251,'2018-04-21 15:00:00','2018-04-21 15:00:00','success',NULL,'cron',NULL),(951,27,375,'2018-04-21 15:00:00','2018-04-21 15:00:00','success',NULL,'cron',NULL),(952,28,251,'2018-04-21 15:00:00','2018-04-21 15:00:00','success',NULL,'cron',NULL),(953,27,376,'2018-04-21 15:10:00','2018-04-21 15:10:00','success',NULL,'cron',NULL),(954,23,252,'2018-04-21 15:15:00','2018-04-21 15:15:00','success',NULL,'cron',NULL),(955,28,252,'2018-04-21 15:15:00','2018-04-21 15:15:00','success',NULL,'cron',NULL),(956,27,377,'2018-04-21 15:20:00','2018-04-21 15:20:00','success',NULL,'cron',NULL),(957,28,253,'2018-04-21 15:30:00','2018-04-21 15:30:00','success',NULL,'cron',NULL),(958,23,253,'2018-04-21 15:30:00','2018-04-21 15:30:00','success',NULL,'cron',NULL),(959,27,378,'2018-04-21 15:30:00','2018-04-21 15:30:00','success',NULL,'cron',NULL),(960,27,379,'2018-04-21 15:40:00','2018-04-21 15:40:00','success',NULL,'cron',NULL),(961,28,254,'2018-04-21 15:45:00','2018-04-21 15:45:00','success',NULL,'cron',NULL),(962,23,254,'2018-04-21 15:45:00','2018-04-21 15:45:00','success',NULL,'cron',NULL),(963,27,380,'2018-04-21 15:50:00','2018-04-21 15:50:00','success',NULL,'cron',NULL),(964,28,255,'2018-04-21 16:00:00','2018-04-21 16:00:00','success',NULL,'cron',NULL),(965,23,255,'2018-04-21 16:00:00','2018-04-21 16:00:00','success',NULL,'cron',NULL),(966,27,381,'2018-04-21 16:00:00','2018-04-21 16:00:00','success',NULL,'cron',NULL),(967,27,382,'2018-04-21 16:10:00','2018-04-21 16:10:00','success',NULL,'cron',NULL),(968,23,256,'2018-04-21 16:15:00','2018-04-21 16:15:00','success',NULL,'cron',NULL),(969,28,256,'2018-04-21 16:15:00','2018-04-21 16:15:00','success',NULL,'cron',NULL),(970,27,383,'2018-04-21 16:20:00','2018-04-21 16:20:00','success',NULL,'cron',NULL),(971,27,384,'2018-04-21 16:30:00','2018-04-21 16:30:00','success',NULL,'cron',NULL),(972,28,257,'2018-04-21 16:30:00','2018-04-21 16:30:00','success',NULL,'cron',NULL),(973,23,257,'2018-04-21 16:30:00','2018-04-21 16:30:00','success',NULL,'cron',NULL),(974,27,385,'2018-04-21 16:40:00','2018-04-21 16:40:00','success',NULL,'cron',NULL),(975,28,258,'2018-04-21 16:45:00','2018-04-21 16:45:00','success',NULL,'cron',NULL),(976,23,258,'2018-04-21 16:45:00','2018-04-21 16:45:00','success',NULL,'cron',NULL),(977,27,386,'2018-04-21 16:50:00','2018-04-21 16:50:00','success',NULL,'cron',NULL),(978,23,259,'2018-04-21 17:00:00','2018-04-21 17:00:00','success',NULL,'cron',NULL),(979,27,387,'2018-04-21 17:00:00','2018-04-21 17:00:00','success',NULL,'cron',NULL),(980,28,259,'2018-04-21 17:00:00','2018-04-21 17:00:00','success',NULL,'cron',NULL),(981,27,388,'2018-04-21 17:10:00','2018-04-21 17:10:00','success',NULL,'cron',NULL),(982,28,260,'2018-04-21 17:15:00','2018-04-21 17:15:00','success',NULL,'cron',NULL),(983,23,260,'2018-04-21 17:15:00','2018-04-21 17:15:00','success',NULL,'cron',NULL),(984,27,389,'2018-04-21 17:20:00','2018-04-21 17:20:00','success',NULL,'cron',NULL),(985,27,390,'2018-04-21 17:30:00','2018-04-21 17:30:00','success',NULL,'cron',NULL),(986,23,261,'2018-04-21 17:30:00','2018-04-21 17:30:00','success',NULL,'cron',NULL),(987,28,261,'2018-04-21 17:30:00','2018-04-21 17:30:00','success',NULL,'cron',NULL),(988,27,391,'2018-04-21 17:40:00','2018-04-21 17:40:00','success',NULL,'cron',NULL),(989,23,262,'2018-04-21 17:45:00','2018-04-21 17:45:00','success',NULL,'cron',NULL),(990,28,262,'2018-04-21 17:45:00','2018-04-21 17:45:00','success',NULL,'cron',NULL),(991,27,392,'2018-04-21 17:50:00','2018-04-21 17:50:00','success',NULL,'cron',NULL),(992,23,263,'2018-04-21 18:00:00','2018-04-21 18:00:00','success',NULL,'cron',NULL),(993,27,393,'2018-04-21 18:00:00','2018-04-21 18:00:00','success',NULL,'cron',NULL),(994,28,263,'2018-04-21 18:00:00','2018-04-21 18:00:00','success',NULL,'cron',NULL),(995,27,394,'2018-04-21 18:10:00','2018-04-21 18:10:00','success',NULL,'cron',NULL),(996,23,264,'2018-04-21 18:15:00','2018-04-21 18:15:00','success',NULL,'cron',NULL),(997,28,264,'2018-04-21 18:15:00','2018-04-21 18:15:00','success',NULL,'cron',NULL),(998,27,395,'2018-04-21 18:20:00','2018-04-21 18:20:00','success',NULL,'cron',NULL),(999,28,265,'2018-04-21 18:30:00','2018-04-21 18:30:00','success',NULL,'cron',NULL),(1000,27,396,'2018-04-21 18:30:00','2018-04-21 18:30:00','success',NULL,'cron',NULL),(1001,23,265,'2018-04-21 18:30:00','2018-04-21 18:30:00','success',NULL,'cron',NULL),(1002,27,397,'2018-04-21 18:40:00','2018-04-21 18:40:00','success',NULL,'cron',NULL),(1003,23,266,'2018-04-21 18:45:00','2018-04-21 18:45:00','success',NULL,'cron',NULL),(1004,28,266,'2018-04-21 18:45:00','2018-04-21 18:45:00','success',NULL,'cron',NULL),(1005,27,398,'2018-04-21 18:50:00','2018-04-21 18:50:00','success',NULL,'cron',NULL),(1006,28,267,'2018-04-21 19:00:00','2018-04-21 19:00:00','success',NULL,'cron',NULL),(1007,27,399,'2018-04-21 19:00:00','2018-04-21 19:00:00','success',NULL,'cron',NULL),(1008,23,267,'2018-04-21 19:00:00','2018-04-21 19:00:00','success',NULL,'cron',NULL),(1009,27,400,'2018-04-21 19:10:00','2018-04-21 19:10:00','success',NULL,'cron',NULL),(1010,28,268,'2018-04-21 19:15:00','2018-04-21 19:15:00','success',NULL,'cron',NULL),(1011,23,268,'2018-04-21 19:15:00','2018-04-21 19:15:00','success',NULL,'cron',NULL),(1012,27,401,'2018-04-21 19:20:00','2018-04-21 19:20:00','success',NULL,'cron',NULL),(1013,27,402,'2018-04-21 19:30:00','2018-04-21 19:30:00','success',NULL,'cron',NULL),(1014,28,269,'2018-04-21 19:30:00','2018-04-21 19:30:00','success',NULL,'cron',NULL),(1015,23,269,'2018-04-21 19:30:00','2018-04-21 19:30:00','success',NULL,'cron',NULL),(1016,27,403,'2018-04-21 19:40:00','2018-04-21 19:40:00','success',NULL,'cron',NULL),(1017,28,270,'2018-04-21 19:45:00','2018-04-21 19:45:00','success',NULL,'cron',NULL),(1018,23,270,'2018-04-21 19:45:00','2018-04-21 19:45:00','success',NULL,'cron',NULL),(1019,27,404,'2018-04-21 19:50:00','2018-04-21 19:50:00','success',NULL,'cron',NULL),(1020,28,271,'2018-04-21 20:00:00','2018-04-21 20:00:00','success',NULL,'cron',NULL),(1021,23,271,'2018-04-21 20:00:00','2018-04-21 20:00:00','success',NULL,'cron',NULL),(1022,27,405,'2018-04-21 20:00:00','2018-04-21 20:00:00','success',NULL,'cron',NULL),(1023,27,406,'2018-04-21 20:10:00','2018-04-21 20:10:00','success',NULL,'cron',NULL),(1024,28,272,'2018-04-21 20:15:00','2018-04-21 20:15:00','success',NULL,'cron',NULL),(1025,23,272,'2018-04-21 20:15:00','2018-04-21 20:15:00','success',NULL,'cron',NULL),(1026,27,407,'2018-04-21 20:20:00','2018-04-21 20:20:00','success',NULL,'cron',NULL),(1027,27,408,'2018-04-21 20:30:00','2018-04-21 20:30:00','success',NULL,'cron',NULL),(1028,23,273,'2018-04-21 20:30:00','2018-04-21 20:30:00','success',NULL,'cron',NULL),(1029,28,273,'2018-04-21 20:30:00','2018-04-21 20:30:00','success',NULL,'cron',NULL),(1030,27,409,'2018-04-21 20:40:00','2018-04-21 20:40:00','success',NULL,'cron',NULL),(1031,23,274,'2018-04-21 20:45:00','2018-04-21 20:45:00','success',NULL,'cron',NULL),(1032,28,274,'2018-04-21 20:45:00','2018-04-21 20:45:00','success',NULL,'cron',NULL),(1033,27,410,'2018-04-21 20:50:00','2018-04-21 20:50:00','success',NULL,'cron',NULL),(1034,27,411,'2018-04-21 21:00:00','2018-04-21 21:00:00','success',NULL,'cron',NULL),(1035,1,4,'2018-04-21 21:00:00','2018-04-21 21:00:00','success',NULL,'cron',NULL),(1036,28,275,'2018-04-21 21:00:00','2018-04-21 21:00:00','success',NULL,'cron',NULL),(1037,23,275,'2018-04-21 21:00:00','2018-04-21 21:00:00','success',NULL,'cron',NULL),(1038,27,412,'2018-04-21 21:10:00','2018-04-21 21:10:00','success',NULL,'cron',NULL),(1039,28,276,'2018-04-21 21:15:00','2018-04-21 21:15:00','success',NULL,'cron',NULL),(1040,23,276,'2018-04-21 21:15:00','2018-04-21 21:15:00','success',NULL,'cron',NULL),(1041,4,4,'2018-04-21 21:20:00','2018-04-21 21:20:00','success',NULL,'cron',NULL),(1042,27,413,'2018-04-21 21:20:00','2018-04-21 21:20:00','success',NULL,'cron',NULL),(1043,27,414,'2018-04-21 21:30:00','2018-04-21 21:30:00','success',NULL,'cron',NULL),(1044,28,277,'2018-04-21 21:30:00','2018-04-21 21:30:00','success',NULL,'cron',NULL),(1045,23,277,'2018-04-21 21:30:00','2018-04-21 21:30:00','success',NULL,'cron',NULL),(1046,27,415,'2018-04-21 21:40:00','2018-04-21 21:40:00','success',NULL,'cron',NULL),(1047,28,278,'2018-04-21 21:45:00','2018-04-21 21:45:00','success',NULL,'cron',NULL),(1048,23,278,'2018-04-21 21:45:00','2018-04-21 21:45:00','success',NULL,'cron',NULL),(1049,27,416,'2018-04-21 21:50:00','2018-04-21 21:50:00','success',NULL,'cron',NULL),(1050,23,279,'2018-04-21 22:00:00','2018-04-21 22:00:00','success',NULL,'cron',NULL),(1051,28,279,'2018-04-21 22:00:00','2018-04-21 22:00:00','success',NULL,'cron',NULL),(1052,27,417,'2018-04-21 22:00:00','2018-04-21 22:00:00','success',NULL,'cron',NULL),(1053,27,418,'2018-04-21 22:10:00','2018-04-21 22:10:00','success',NULL,'cron',NULL),(1054,28,280,'2018-04-21 22:15:00','2018-04-21 22:15:00','success',NULL,'cron',NULL),(1055,23,280,'2018-04-21 22:15:00','2018-04-21 22:15:00','success',NULL,'cron',NULL),(1056,27,419,'2018-04-21 22:20:00','2018-04-21 22:20:00','success',NULL,'cron',NULL),(1057,27,420,'2018-04-21 22:30:00','2018-04-21 22:30:00','success',NULL,'cron',NULL),(1058,23,281,'2018-04-21 22:30:00','2018-04-21 22:30:00','success',NULL,'cron',NULL),(1059,28,281,'2018-04-21 22:30:00','2018-04-21 22:30:00','success',NULL,'cron',NULL),(1060,27,421,'2018-04-21 22:40:00','2018-04-21 22:40:00','success',NULL,'cron',NULL),(1061,28,282,'2018-04-21 22:45:00','2018-04-21 22:45:00','success',NULL,'cron',NULL),(1062,23,282,'2018-04-21 22:45:00','2018-04-21 22:45:00','success',NULL,'cron',NULL),(1063,27,422,'2018-04-21 22:50:00','2018-04-21 22:50:00','success',NULL,'cron',NULL),(1064,19,4,'2018-04-21 23:00:00','2018-04-21 23:00:00','success',NULL,'cron',NULL),(1065,23,283,'2018-04-21 23:00:00','2018-04-21 23:00:00','success',NULL,'cron',NULL),(1066,13,4,'2018-04-21 23:00:00','2018-04-21 23:00:00','success',NULL,'cron',NULL),(1067,20,4,'2018-04-21 23:00:00','2018-04-21 23:00:00','success',NULL,'cron',NULL),(1068,15,4,'2018-04-21 23:00:00','2018-04-21 23:00:00','success',NULL,'cron',NULL),(1069,12,4,'2018-04-21 23:00:00','2018-04-21 23:00:00','success',NULL,'cron',NULL),(1070,27,423,'2018-04-21 23:00:00','2018-04-21 23:00:00','success',NULL,'cron',NULL),(1071,10,4,'2018-04-21 23:00:00','2018-04-21 23:00:00','success',NULL,'cron',NULL),(1072,28,283,'2018-04-21 23:00:00','2018-04-21 23:00:00','success',NULL,'cron',NULL),(1073,6,4,'2018-04-21 23:00:00','2018-04-21 23:00:00','success',NULL,'cron',NULL),(1074,21,4,'2018-04-21 23:00:00','2018-04-21 23:00:00','success',NULL,'cron',NULL),(1075,7,4,'2018-04-21 23:01:00','2018-04-21 23:01:00','success',NULL,'cron',NULL),(1076,22,4,'2018-04-21 23:01:00','2018-04-21 23:01:00','success',NULL,'cron',NULL),(1077,2,4,'2018-04-21 23:01:00','2018-04-21 23:01:00','success',NULL,'cron',NULL),(1078,9,4,'2018-04-21 23:01:00','2018-04-21 23:01:00','success',NULL,'cron',NULL),(1079,17,4,'2018-04-21 23:01:00','2018-04-21 23:01:00','success',NULL,'cron',NULL),(1080,11,4,'2018-04-21 23:01:00','2018-04-21 23:01:00','success',NULL,'cron',NULL),(1081,14,4,'2018-04-21 23:02:00','2018-04-21 23:02:00','success',NULL,'cron',NULL),(1082,16,4,'2018-04-21 23:02:00','2018-04-21 23:02:00','success',NULL,'cron',NULL),(1083,18,4,'2018-04-21 23:05:00','2018-04-21 23:05:00','success',NULL,'cron',NULL),(1084,3,4,'2018-04-21 23:05:00','2018-04-21 23:05:00','success',NULL,'cron',NULL),(1085,27,424,'2018-04-21 23:10:00','2018-04-21 23:10:00','success',NULL,'cron',NULL),(1086,28,284,'2018-04-21 23:15:00','2018-04-21 23:15:00','success',NULL,'cron',NULL),(1087,23,284,'2018-04-21 23:15:00','2018-04-21 23:15:00','success',NULL,'cron',NULL),(1088,27,425,'2018-04-21 23:20:00','2018-04-21 23:20:00','success',NULL,'cron',NULL),(1089,23,285,'2018-04-21 23:30:00','2018-04-21 23:30:00','success',NULL,'cron',NULL),(1090,27,426,'2018-04-21 23:30:00','2018-04-21 23:30:00','success',NULL,'cron',NULL),(1091,28,285,'2018-04-21 23:30:00','2018-04-21 23:30:00','success',NULL,'cron',NULL),(1092,27,427,'2018-04-21 23:40:00','2018-04-21 23:40:00','success',NULL,'cron',NULL),(1093,28,286,'2018-04-21 23:45:00','2018-04-21 23:45:00','success',NULL,'cron',NULL),(1094,23,286,'2018-04-21 23:45:00','2018-04-21 23:45:00','success',NULL,'cron',NULL),(1095,27,428,'2018-04-21 23:50:00','2018-04-21 23:50:00','success',NULL,'cron',NULL),(1096,27,429,'2018-04-22 00:00:00','2018-04-22 00:00:00','success',NULL,'cron',NULL),(1097,23,287,'2018-04-22 00:00:00','2018-04-22 00:00:00','success',NULL,'cron',NULL),(1098,28,287,'2018-04-22 00:00:00','2018-04-22 00:00:00','success',NULL,'cron',NULL),(1099,27,430,'2018-04-22 00:10:00','2018-04-22 00:10:00','success',NULL,'cron',NULL),(1100,23,288,'2018-04-22 00:15:00','2018-04-22 00:15:00','success',NULL,'cron',NULL),(1101,28,288,'2018-04-22 00:15:00','2018-04-22 00:15:00','success',NULL,'cron',NULL),(1102,27,431,'2018-04-22 00:20:00','2018-04-22 00:20:00','success',NULL,'cron',NULL),(1103,23,289,'2018-04-22 00:30:00','2018-04-22 00:30:00','success',NULL,'cron',NULL),(1104,28,289,'2018-04-22 00:30:00','2018-04-22 00:30:00','success',NULL,'cron',NULL),(1105,27,432,'2018-04-22 00:30:00','2018-04-22 00:30:00','success',NULL,'cron',NULL),(1106,27,433,'2018-04-22 00:40:00','2018-04-22 00:40:00','success',NULL,'cron',NULL),(1107,28,290,'2018-04-22 00:45:00','2018-04-22 00:45:00','success',NULL,'cron',NULL),(1108,23,290,'2018-04-22 00:45:00','2018-04-22 00:45:00','success',NULL,'cron',NULL),(1109,27,434,'2018-04-22 00:50:00','2018-04-22 00:50:00','success',NULL,'cron',NULL),(1110,27,435,'2018-04-22 01:00:00','2018-04-22 01:00:00','success',NULL,'cron',NULL),(1111,28,291,'2018-04-22 01:00:00','2018-04-22 01:00:00','success',NULL,'cron',NULL),(1112,23,291,'2018-04-22 01:00:00','2018-04-22 01:00:00','success',NULL,'cron',NULL),(1113,27,436,'2018-04-22 01:10:00','2018-04-22 01:10:00','success',NULL,'cron',NULL),(1114,28,292,'2018-04-22 01:15:00','2018-04-22 01:15:00','success',NULL,'cron',NULL),(1115,23,292,'2018-04-22 01:15:00','2018-04-22 01:15:00','success',NULL,'cron',NULL),(1116,27,437,'2018-04-22 01:20:00','2018-04-22 01:20:00','success',NULL,'cron',NULL),(1117,27,438,'2018-04-22 01:30:00','2018-04-22 01:30:00','success',NULL,'cron',NULL),(1118,28,293,'2018-04-22 01:30:00','2018-04-22 01:30:00','success',NULL,'cron',NULL),(1119,23,293,'2018-04-22 01:30:00','2018-04-22 01:30:00','success',NULL,'cron',NULL),(1120,27,439,'2018-04-22 01:40:00','2018-04-22 01:40:02','success',NULL,'cron',NULL),(1121,28,294,'2018-04-22 01:45:00','2018-04-22 01:45:00','success',NULL,'cron',NULL),(1122,23,294,'2018-04-22 01:45:00','2018-04-22 01:45:00','success',NULL,'cron',NULL),(1123,27,440,'2018-04-22 01:50:00','2018-04-22 01:50:00','success',NULL,'cron',NULL),(1124,27,441,'2018-04-22 02:00:00','2018-04-22 02:00:00','success',NULL,'cron',NULL),(1125,23,295,'2018-04-22 02:00:00','2018-04-22 02:00:00','success',NULL,'cron',NULL),(1126,28,295,'2018-04-22 02:00:00','2018-04-22 02:00:00','success',NULL,'cron',NULL),(1127,27,442,'2018-04-22 02:10:00','2018-04-22 02:10:00','success',NULL,'cron',NULL),(1128,23,296,'2018-04-22 02:15:00','2018-04-22 02:15:00','success',NULL,'cron',NULL),(1129,28,296,'2018-04-22 02:15:00','2018-04-22 02:15:00','success',NULL,'cron',NULL),(1130,27,443,'2018-04-22 02:20:00','2018-04-22 02:20:00','success',NULL,'cron',NULL),(1131,27,444,'2018-04-22 02:30:00','2018-04-22 02:30:00','success',NULL,'cron',NULL),(1132,28,297,'2018-04-22 02:30:00','2018-04-22 02:30:00','success',NULL,'cron',NULL),(1133,23,297,'2018-04-22 02:30:00','2018-04-22 02:30:00','success',NULL,'cron',NULL),(1134,27,445,'2018-04-22 02:40:00','2018-04-22 02:40:00','success',NULL,'cron',NULL),(1135,28,298,'2018-04-22 02:45:00','2018-04-22 02:45:00','success',NULL,'cron',NULL),(1136,23,298,'2018-04-22 02:45:00','2018-04-22 02:45:00','success',NULL,'cron',NULL),(1137,27,446,'2018-04-22 02:50:00','2018-04-22 02:50:00','success',NULL,'cron',NULL),(1138,27,447,'2018-04-22 03:00:00','2018-04-22 03:00:00','success',NULL,'cron',NULL),(1139,28,299,'2018-04-22 03:00:00','2018-04-22 03:00:00','success',NULL,'cron',NULL),(1140,23,299,'2018-04-22 03:00:00','2018-04-22 03:00:00','success',NULL,'cron',NULL),(1141,27,448,'2018-04-22 03:10:00','2018-04-22 03:10:00','success',NULL,'cron',NULL),(1142,28,300,'2018-04-22 03:15:00','2018-04-22 03:15:00','success',NULL,'cron',NULL),(1143,23,300,'2018-04-22 03:15:00','2018-04-22 03:15:00','success',NULL,'cron',NULL),(1144,27,449,'2018-04-22 03:20:00','2018-04-22 03:20:00','success',NULL,'cron',NULL),(1145,27,450,'2018-04-22 03:30:00','2018-04-22 03:30:00','success',NULL,'cron',NULL),(1146,23,301,'2018-04-22 03:30:00','2018-04-22 03:30:00','success',NULL,'cron',NULL),(1147,28,301,'2018-04-22 03:30:00','2018-04-22 03:30:00','success',NULL,'cron',NULL),(1148,27,451,'2018-04-22 03:40:00','2018-04-22 03:40:00','success',NULL,'cron',NULL),(1149,23,302,'2018-04-22 03:45:00','2018-04-22 03:45:00','success',NULL,'cron',NULL),(1150,28,302,'2018-04-22 03:45:00','2018-04-22 03:45:00','success',NULL,'cron',NULL),(1151,27,452,'2018-04-22 03:50:00','2018-04-22 03:50:00','success',NULL,'cron',NULL),(1152,27,453,'2018-04-22 04:00:00','2018-04-22 04:00:00','success',NULL,'cron',NULL),(1153,24,3,'2018-04-22 04:00:00','2018-04-22 04:00:00','success',NULL,'cron',NULL),(1154,28,303,'2018-04-22 04:00:00','2018-04-22 04:00:00','success',NULL,'cron',NULL),(1155,23,303,'2018-04-22 04:00:00','2018-04-22 04:00:00','success',NULL,'cron',NULL),(1156,25,3,'2018-04-22 04:00:00','2018-04-22 04:00:02','success',NULL,'cron',NULL),(1157,26,3,'2018-04-22 04:00:02','2018-04-22 04:00:02','success',NULL,'cron',NULL),(1158,27,454,'2018-04-22 04:10:00','2018-04-22 04:10:00','success',NULL,'cron',NULL),(1159,23,304,'2018-04-22 04:15:00','2018-04-22 04:15:00','success',NULL,'cron',NULL),(1160,28,304,'2018-04-22 04:15:00','2018-04-22 04:15:00','success',NULL,'cron',NULL),(1161,27,455,'2018-04-22 04:20:00','2018-04-22 04:20:00','success',NULL,'cron',NULL),(1162,27,456,'2018-04-22 04:30:00','2018-04-22 04:30:00','success',NULL,'cron',NULL),(1163,28,305,'2018-04-22 04:30:00','2018-04-22 04:30:00','success',NULL,'cron',NULL),(1164,23,305,'2018-04-22 04:30:00','2018-04-22 04:30:00','success',NULL,'cron',NULL),(1165,27,457,'2018-04-22 04:40:00','2018-04-22 04:40:00','success',NULL,'cron',NULL),(1166,23,306,'2018-04-22 04:45:00','2018-04-22 04:45:00','success',NULL,'cron',NULL),(1167,28,306,'2018-04-22 04:45:00','2018-04-22 04:45:00','success',NULL,'cron',NULL),(1168,27,458,'2018-04-22 04:50:00','2018-04-22 04:50:00','success',NULL,'cron',NULL),(1169,27,459,'2018-04-22 05:00:00','2018-04-22 05:00:00','success',NULL,'cron',NULL),(1170,28,307,'2018-04-22 05:00:00','2018-04-22 05:00:00','success',NULL,'cron',NULL),(1171,23,307,'2018-04-22 05:00:00','2018-04-22 05:00:00','success',NULL,'cron',NULL),(1172,27,460,'2018-04-22 05:10:00','2018-04-22 05:10:00','success',NULL,'cron',NULL),(1173,23,308,'2018-04-22 05:15:00','2018-04-22 05:15:00','success',NULL,'cron',NULL),(1174,28,308,'2018-04-22 05:15:00','2018-04-22 05:15:00','success',NULL,'cron',NULL),(1175,27,461,'2018-04-22 05:20:00','2018-04-22 05:20:00','success',NULL,'cron',NULL),(1176,27,462,'2018-04-22 05:30:00','2018-04-22 05:30:00','success',NULL,'cron',NULL),(1177,23,309,'2018-04-22 05:30:00','2018-04-22 05:30:00','success',NULL,'cron',NULL),(1178,28,309,'2018-04-22 05:30:00','2018-04-22 05:30:00','success',NULL,'cron',NULL),(1179,27,463,'2018-04-22 05:40:00','2018-04-22 05:40:00','success',NULL,'cron',NULL),(1180,23,310,'2018-04-22 05:45:00','2018-04-22 05:45:00','success',NULL,'cron',NULL),(1181,28,310,'2018-04-22 05:45:00','2018-04-22 05:45:00','success',NULL,'cron',NULL),(1182,27,464,'2018-04-22 05:50:00','2018-04-22 05:50:00','success',NULL,'cron',NULL),(1183,23,311,'2018-04-22 06:00:00','2018-04-22 06:00:00','success',NULL,'cron',NULL),(1184,27,465,'2018-04-22 06:00:00','2018-04-22 06:00:00','success',NULL,'cron',NULL),(1185,28,311,'2018-04-22 06:00:00','2018-04-22 06:00:00','success',NULL,'cron',NULL),(1186,27,466,'2018-04-22 06:10:00','2018-04-22 06:10:00','success',NULL,'cron',NULL),(1187,28,312,'2018-04-22 06:15:00','2018-04-22 06:15:00','success',NULL,'cron',NULL),(1188,23,312,'2018-04-22 06:15:00','2018-04-22 06:15:00','success',NULL,'cron',NULL),(1189,27,467,'2018-04-22 06:20:00','2018-04-22 06:20:00','success',NULL,'cron',NULL),(1190,28,313,'2018-04-22 06:30:00','2018-04-22 06:30:00','success',NULL,'cron',NULL),(1191,27,468,'2018-04-22 06:30:00','2018-04-22 06:30:00','success',NULL,'cron',NULL),(1192,23,313,'2018-04-22 06:30:00','2018-04-22 06:30:00','success',NULL,'cron',NULL),(1193,27,469,'2018-04-22 06:40:00','2018-04-22 06:40:00','success',NULL,'cron',NULL),(1194,28,314,'2018-04-22 06:45:00','2018-04-22 06:45:00','success',NULL,'cron',NULL),(1195,23,314,'2018-04-22 06:45:00','2018-04-22 06:45:00','success',NULL,'cron',NULL),(1196,27,470,'2018-04-22 06:50:00','2018-04-22 06:50:00','success',NULL,'cron',NULL),(1197,23,315,'2018-04-22 07:00:00','2018-04-22 07:00:00','success',NULL,'cron',NULL),(1198,27,471,'2018-04-22 07:00:00','2018-04-22 07:00:00','success',NULL,'cron',NULL),(1199,28,315,'2018-04-22 07:00:00','2018-04-22 07:00:00','success',NULL,'cron',NULL),(1200,27,472,'2018-04-22 07:10:00','2018-04-22 07:10:00','success',NULL,'cron',NULL),(1201,23,316,'2018-04-22 07:15:00','2018-04-22 07:15:00','success',NULL,'cron',NULL),(1202,28,316,'2018-04-22 07:15:00','2018-04-22 07:15:00','success',NULL,'cron',NULL),(1203,27,473,'2018-04-22 07:20:00','2018-04-22 07:20:00','success',NULL,'cron',NULL),(1204,27,474,'2018-04-22 07:30:00','2018-04-22 07:30:00','success',NULL,'cron',NULL),(1205,28,317,'2018-04-22 07:30:00','2018-04-22 07:30:00','success',NULL,'cron',NULL),(1206,23,317,'2018-04-22 07:30:00','2018-04-22 07:30:00','success',NULL,'cron',NULL),(1207,27,475,'2018-04-22 07:40:00','2018-04-22 07:40:00','success',NULL,'cron',NULL),(1208,28,318,'2018-04-22 07:45:00','2018-04-22 07:45:00','success',NULL,'cron',NULL),(1209,23,318,'2018-04-22 07:45:00','2018-04-22 07:45:00','success',NULL,'cron',NULL),(1210,27,476,'2018-04-22 07:50:00','2018-04-22 07:50:00','success',NULL,'cron',NULL),(1211,27,477,'2018-04-22 08:00:00','2018-04-22 08:00:00','success',NULL,'cron',NULL),(1212,23,319,'2018-04-22 08:00:00','2018-04-22 08:00:00','success',NULL,'cron',NULL),(1213,28,319,'2018-04-22 08:00:00','2018-04-22 08:00:00','success',NULL,'cron',NULL),(1214,27,478,'2018-04-22 08:10:00','2018-04-22 08:10:00','success',NULL,'cron',NULL),(1215,28,320,'2018-04-22 08:15:00','2018-04-22 08:15:00','success',NULL,'cron',NULL),(1216,23,320,'2018-04-22 08:15:00','2018-04-22 08:15:00','success',NULL,'cron',NULL),(1217,27,479,'2018-04-22 08:20:00','2018-04-22 08:20:00','success',NULL,'cron',NULL),(1218,28,321,'2018-04-22 08:30:00','2018-04-22 08:30:00','success',NULL,'cron',NULL),(1219,27,480,'2018-04-22 08:30:00','2018-04-22 08:30:00','success',NULL,'cron',NULL),(1220,23,321,'2018-04-22 08:30:00','2018-04-22 08:30:00','success',NULL,'cron',NULL),(1221,27,481,'2018-04-22 08:40:00','2018-04-22 08:40:00','success',NULL,'cron',NULL),(1222,28,322,'2018-04-22 08:45:00','2018-04-22 08:45:00','success',NULL,'cron',NULL),(1223,23,322,'2018-04-22 08:45:00','2018-04-22 08:45:00','success',NULL,'cron',NULL),(1224,27,482,'2018-04-22 08:50:00','2018-04-22 08:50:00','success',NULL,'cron',NULL),(1225,23,323,'2018-04-22 09:00:00','2018-04-22 09:00:00','success',NULL,'cron',NULL),(1226,27,483,'2018-04-22 09:00:00','2018-04-22 09:00:00','success',NULL,'cron',NULL),(1227,28,323,'2018-04-22 09:00:00','2018-04-22 09:00:00','success',NULL,'cron',NULL),(1228,27,484,'2018-04-22 09:10:00','2018-04-22 09:10:00','success',NULL,'cron',NULL),(1229,23,324,'2018-04-22 09:15:00','2018-04-22 09:15:00','success',NULL,'cron',NULL),(1230,28,324,'2018-04-22 09:15:00','2018-04-22 09:15:00','success',NULL,'cron',NULL),(1231,27,485,'2018-04-22 09:20:00','2018-04-22 09:20:00','success',NULL,'cron',NULL),(1232,23,325,'2018-04-22 09:30:00','2018-04-22 09:30:00','success',NULL,'cron',NULL),(1233,27,486,'2018-04-22 09:30:00','2018-04-22 09:30:00','success',NULL,'cron',NULL),(1234,28,325,'2018-04-22 09:30:00','2018-04-22 09:30:00','success',NULL,'cron',NULL),(1235,27,487,'2018-04-22 09:40:00','2018-04-22 09:40:00','success',NULL,'cron',NULL),(1236,28,326,'2018-04-22 09:45:00','2018-04-22 09:45:00','success',NULL,'cron',NULL),(1237,23,326,'2018-04-22 09:45:00','2018-04-22 09:45:00','success',NULL,'cron',NULL),(1238,27,488,'2018-04-22 09:50:00','2018-04-22 09:50:00','success',NULL,'cron',NULL),(1239,28,327,'2018-04-22 10:00:00','2018-04-22 10:00:00','success',NULL,'cron',NULL),(1240,27,489,'2018-04-22 10:00:00','2018-04-22 10:00:00','success',NULL,'cron',NULL),(1241,23,327,'2018-04-22 10:00:00','2018-04-22 10:00:00','success',NULL,'cron',NULL),(1242,27,490,'2018-04-22 10:10:00','2018-04-22 10:10:00','success',NULL,'cron',NULL),(1243,28,328,'2018-04-22 10:15:00','2018-04-22 10:15:00','success',NULL,'cron',NULL),(1244,23,328,'2018-04-22 10:15:00','2018-04-22 10:15:00','success',NULL,'cron',NULL),(1245,27,491,'2018-04-22 10:20:00','2018-04-22 10:20:00','success',NULL,'cron',NULL),(1246,27,492,'2018-04-22 10:30:00','2018-04-22 10:30:00','success',NULL,'cron',NULL),(1247,28,329,'2018-04-22 10:30:00','2018-04-22 10:30:00','success',NULL,'cron',NULL),(1248,23,329,'2018-04-22 10:30:00','2018-04-22 10:30:00','success',NULL,'cron',NULL),(1249,27,493,'2018-04-22 10:40:00','2018-04-22 10:40:00','success',NULL,'cron',NULL),(1250,28,330,'2018-04-22 10:45:00','2018-04-22 10:45:00','success',NULL,'cron',NULL),(1251,23,330,'2018-04-22 10:45:00','2018-04-22 10:45:00','success',NULL,'cron',NULL),(1252,27,494,'2018-04-22 10:50:00','2018-04-22 10:50:00','success',NULL,'cron',NULL),(1253,27,495,'2018-04-22 11:00:00','2018-04-22 11:00:00','success',NULL,'cron',NULL),(1254,29,4,'2018-04-22 11:00:00','2018-04-22 11:00:00','success',NULL,'cron',NULL),(1255,23,331,'2018-04-22 11:00:00','2018-04-22 11:00:00','success',NULL,'cron',NULL),(1256,8,4,'2018-04-22 11:00:00','2018-04-22 11:00:00','success',NULL,'cron',NULL),(1257,5,4,'2018-04-22 11:00:00','2018-04-22 11:00:00','success',NULL,'cron',NULL),(1258,28,331,'2018-04-22 11:00:00','2018-04-22 11:00:00','success',NULL,'cron',NULL),(1259,27,496,'2018-04-22 11:10:00','2018-04-22 11:10:00','success',NULL,'cron',NULL),(1260,28,332,'2018-04-22 11:15:00','2018-04-22 11:15:00','success',NULL,'cron',NULL),(1261,23,332,'2018-04-22 11:15:00','2018-04-22 11:15:00','success',NULL,'cron',NULL),(1262,27,497,'2018-04-22 11:20:00','2018-04-22 11:20:00','success',NULL,'cron',NULL),(1263,27,498,'2018-04-22 11:30:00','2018-04-22 11:30:00','success',NULL,'cron',NULL),(1264,28,333,'2018-04-22 11:30:00','2018-04-22 11:30:00','success',NULL,'cron',NULL),(1265,23,333,'2018-04-22 11:30:00','2018-04-22 11:30:00','success',NULL,'cron',NULL),(1266,27,499,'2018-04-22 11:40:00','2018-04-22 11:40:00','success',NULL,'cron',NULL),(1267,23,334,'2018-04-22 11:45:00','2018-04-22 11:45:00','success',NULL,'cron',NULL),(1268,28,334,'2018-04-22 11:45:00','2018-04-22 11:45:00','success',NULL,'cron',NULL),(1269,27,500,'2018-04-22 11:50:00','2018-04-22 11:50:00','success',NULL,'cron',NULL),(1270,23,335,'2018-04-22 12:00:00','2018-04-22 12:00:00','success',NULL,'cron',NULL),(1271,28,335,'2018-04-22 12:00:00','2018-04-22 12:00:00','success',NULL,'cron',NULL),(1272,27,501,'2018-04-22 12:00:00','2018-04-22 12:00:00','success',NULL,'cron',NULL),(1273,27,502,'2018-04-22 12:10:00','2018-04-22 12:10:00','success',NULL,'cron',NULL),(1274,28,336,'2018-04-22 12:15:00','2018-04-22 12:15:00','success',NULL,'cron',NULL),(1275,23,336,'2018-04-22 12:15:00','2018-04-22 12:15:00','success',NULL,'cron',NULL),(1276,27,503,'2018-04-22 12:20:00','2018-04-22 12:20:00','success',NULL,'cron',NULL),(1277,27,504,'2018-04-22 12:30:00','2018-04-22 12:30:00','success',NULL,'cron',NULL),(1278,28,337,'2018-04-22 12:30:00','2018-04-22 12:30:00','success',NULL,'cron',NULL),(1279,23,337,'2018-04-22 12:30:00','2018-04-22 12:30:00','success',NULL,'cron',NULL),(1280,27,505,'2018-04-22 12:40:00','2018-04-22 12:40:00','success',NULL,'cron',NULL),(1281,28,338,'2018-04-22 12:45:00','2018-04-22 12:45:00','success',NULL,'cron',NULL),(1282,23,338,'2018-04-22 12:45:00','2018-04-22 12:45:00','success',NULL,'cron',NULL),(1283,27,506,'2018-04-22 12:50:00','2018-04-22 12:50:00','success',NULL,'cron',NULL),(1284,27,507,'2018-04-22 13:00:00','2018-04-22 13:00:00','success',NULL,'cron',NULL),(1285,28,339,'2018-04-22 13:00:00','2018-04-22 13:00:00','success',NULL,'cron',NULL),(1286,23,339,'2018-04-22 13:00:00','2018-04-22 13:00:00','success',NULL,'cron',NULL),(1287,27,508,'2018-04-22 13:10:00','2018-04-22 13:10:00','success',NULL,'cron',NULL),(1288,28,340,'2018-04-22 13:15:00','2018-04-22 13:15:00','success',NULL,'cron',NULL),(1289,23,340,'2018-04-22 13:15:00','2018-04-22 13:15:00','success',NULL,'cron',NULL),(1290,27,509,'2018-04-22 13:20:00','2018-04-22 13:20:00','success',NULL,'cron',NULL),(1291,27,510,'2018-04-22 13:30:00','2018-04-22 13:30:00','success',NULL,'cron',NULL),(1292,28,341,'2018-04-22 13:30:00','2018-04-22 13:30:00','success',NULL,'cron',NULL),(1293,23,341,'2018-04-22 13:30:00','2018-04-22 13:30:00','success',NULL,'cron',NULL),(1294,27,511,'2018-04-22 13:40:00','2018-04-22 13:40:00','success',NULL,'cron',NULL),(1295,28,342,'2018-04-22 13:45:00','2018-04-22 13:45:00','success',NULL,'cron',NULL),(1296,23,342,'2018-04-22 13:45:00','2018-04-22 13:45:00','success',NULL,'cron',NULL),(1297,27,512,'2018-04-22 13:50:00','2018-04-22 13:50:00','success',NULL,'cron',NULL),(1298,27,513,'2018-04-22 14:00:00','2018-04-22 14:00:00','success',NULL,'cron',NULL),(1299,28,343,'2018-04-22 14:00:00','2018-04-22 14:00:00','success',NULL,'cron',NULL),(1300,23,343,'2018-04-22 14:00:00','2018-04-22 14:00:00','success',NULL,'cron',NULL),(1301,27,514,'2018-04-22 14:10:00','2018-04-22 14:10:00','success',NULL,'cron',NULL),(1302,23,344,'2018-04-22 14:15:00','2018-04-22 14:15:00','success',NULL,'cron',NULL),(1303,28,344,'2018-04-22 14:15:00','2018-04-22 14:15:00','success',NULL,'cron',NULL),(1304,27,515,'2018-04-22 14:20:00','2018-04-22 14:20:00','success',NULL,'cron',NULL),(1305,27,516,'2018-04-22 14:30:00','2018-04-22 14:30:00','success',NULL,'cron',NULL),(1306,28,345,'2018-04-22 14:30:00','2018-04-22 14:30:00','success',NULL,'cron',NULL),(1307,23,345,'2018-04-22 14:30:00','2018-04-22 14:30:00','success',NULL,'cron',NULL),(1308,27,517,'2018-04-22 14:40:00','2018-04-22 14:40:00','success',NULL,'cron',NULL),(1309,28,346,'2018-04-22 14:45:00','2018-04-22 14:45:00','success',NULL,'cron',NULL),(1310,23,346,'2018-04-22 14:45:00','2018-04-22 14:45:00','success',NULL,'cron',NULL),(1311,27,518,'2018-04-22 14:50:00','2018-04-22 14:50:00','success',NULL,'cron',NULL),(1312,23,347,'2018-04-22 15:00:00','2018-04-22 15:00:00','success',NULL,'cron',NULL),(1313,27,519,'2018-04-22 15:00:00','2018-04-22 15:00:00','success',NULL,'cron',NULL),(1314,28,347,'2018-04-22 15:00:00','2018-04-22 15:00:00','success',NULL,'cron',NULL),(1315,27,520,'2018-04-22 15:10:00','2018-04-22 15:10:00','success',NULL,'cron',NULL),(1316,23,348,'2018-04-22 15:15:00','2018-04-22 15:15:00','success',NULL,'cron',NULL),(1317,28,348,'2018-04-22 15:15:00','2018-04-22 15:15:00','success',NULL,'cron',NULL),(1318,27,521,'2018-04-22 15:20:00','2018-04-22 15:20:00','success',NULL,'cron',NULL),(1319,28,349,'2018-04-22 15:30:00','2018-04-22 15:30:00','success',NULL,'cron',NULL),(1320,27,522,'2018-04-22 15:30:00','2018-04-22 15:30:00','success',NULL,'cron',NULL),(1321,23,349,'2018-04-22 15:30:00','2018-04-22 15:30:00','success',NULL,'cron',NULL),(1322,27,523,'2018-04-22 15:40:00','2018-04-22 15:40:00','success',NULL,'cron',NULL),(1323,23,350,'2018-04-22 15:45:00','2018-04-22 15:45:00','success',NULL,'cron',NULL),(1324,28,350,'2018-04-22 15:45:00','2018-04-22 15:45:00','success',NULL,'cron',NULL),(1325,27,524,'2018-04-22 15:50:00','2018-04-22 15:50:00','success',NULL,'cron',NULL),(1326,28,351,'2018-04-22 16:00:00','2018-04-22 16:00:00','success',NULL,'cron',NULL),(1327,27,525,'2018-04-22 16:00:00','2018-04-22 16:00:00','success',NULL,'cron',NULL),(1328,23,351,'2018-04-22 16:00:00','2018-04-22 16:00:00','success',NULL,'cron',NULL),(1329,27,526,'2018-04-22 16:10:00','2018-04-22 16:10:00','success',NULL,'cron',NULL),(1330,28,352,'2018-04-22 16:15:00','2018-04-22 16:15:00','success',NULL,'cron',NULL),(1331,23,352,'2018-04-22 16:15:00','2018-04-22 16:15:00','success',NULL,'cron',NULL),(1332,27,527,'2018-04-22 16:20:00','2018-04-22 16:20:00','success',NULL,'cron',NULL),(1333,23,353,'2018-04-22 16:30:00','2018-04-22 16:30:00','success',NULL,'cron',NULL),(1334,27,528,'2018-04-22 16:30:00','2018-04-22 16:30:00','success',NULL,'cron',NULL),(1335,28,353,'2018-04-22 16:30:00','2018-04-22 16:30:00','success',NULL,'cron',NULL),(1336,27,529,'2018-04-22 16:40:00','2018-04-22 16:40:00','success',NULL,'cron',NULL),(1337,28,354,'2018-04-22 16:45:00','2018-04-22 16:45:00','success',NULL,'cron',NULL),(1338,23,354,'2018-04-22 16:45:00','2018-04-22 16:45:00','success',NULL,'cron',NULL),(1339,27,530,'2018-04-22 16:50:00','2018-04-22 16:50:00','success',NULL,'cron',NULL),(1340,23,355,'2018-04-22 17:00:00','2018-04-22 17:00:00','success',NULL,'cron',NULL),(1341,28,355,'2018-04-22 17:00:00','2018-04-22 17:00:00','success',NULL,'cron',NULL),(1342,27,531,'2018-04-22 17:00:00','2018-04-22 17:00:00','success',NULL,'cron',NULL),(1343,27,532,'2018-04-22 17:10:00','2018-04-22 17:10:00','success',NULL,'cron',NULL),(1344,28,356,'2018-04-22 17:15:00','2018-04-22 17:15:00','success',NULL,'cron',NULL),(1345,23,356,'2018-04-22 17:15:00','2018-04-22 17:15:00','success',NULL,'cron',NULL),(1346,27,533,'2018-04-22 17:20:00','2018-04-22 17:20:00','success',NULL,'cron',NULL),(1347,28,357,'2018-04-22 17:30:00','2018-04-22 17:30:00','success',NULL,'cron',NULL),(1348,27,534,'2018-04-22 17:30:00','2018-04-22 17:30:00','success',NULL,'cron',NULL),(1349,23,357,'2018-04-22 17:30:00','2018-04-22 17:30:00','success',NULL,'cron',NULL),(1350,27,535,'2018-04-22 17:40:00','2018-04-22 17:40:00','success',NULL,'cron',NULL),(1351,23,358,'2018-04-22 17:45:00','2018-04-22 17:45:00','success',NULL,'cron',NULL),(1352,28,358,'2018-04-22 17:45:00','2018-04-22 17:45:00','success',NULL,'cron',NULL),(1353,27,536,'2018-04-22 17:50:00','2018-04-22 17:50:00','success',NULL,'cron',NULL),(1354,27,537,'2018-04-22 18:00:00','2018-04-22 18:00:00','success',NULL,'cron',NULL),(1355,23,359,'2018-04-22 18:00:00','2018-04-22 18:00:00','success',NULL,'cron',NULL),(1356,28,359,'2018-04-22 18:00:00','2018-04-22 18:00:00','success',NULL,'cron',NULL),(1357,27,538,'2018-04-22 18:10:00','2018-04-22 18:10:00','success',NULL,'cron',NULL),(1358,28,360,'2018-04-22 18:15:00','2018-04-22 18:15:00','success',NULL,'cron',NULL),(1359,23,360,'2018-04-22 18:15:00','2018-04-22 18:15:00','success',NULL,'cron',NULL),(1360,27,539,'2018-04-22 18:20:00','2018-04-22 18:20:00','success',NULL,'cron',NULL),(1361,28,361,'2018-04-22 18:30:00','2018-04-22 18:30:00','success',NULL,'cron',NULL),(1362,23,361,'2018-04-22 18:30:00','2018-04-22 18:30:00','success',NULL,'cron',NULL),(1363,27,540,'2018-04-22 18:30:00','2018-04-22 18:30:00','success',NULL,'cron',NULL),(1364,27,541,'2018-04-22 18:40:00','2018-04-22 18:40:00','success',NULL,'cron',NULL),(1365,28,362,'2018-04-22 18:45:00','2018-04-22 18:45:00','success',NULL,'cron',NULL),(1366,23,362,'2018-04-22 18:45:00','2018-04-22 18:45:00','success',NULL,'cron',NULL),(1367,27,542,'2018-04-22 18:50:00','2018-04-22 18:50:00','success',NULL,'cron',NULL),(1368,28,363,'2018-04-22 19:00:00','2018-04-22 19:00:00','success',NULL,'cron',NULL),(1369,23,363,'2018-04-22 19:00:00','2018-04-22 19:00:00','success',NULL,'cron',NULL),(1370,27,543,'2018-04-22 19:00:00','2018-04-22 19:00:00','success',NULL,'cron',NULL),(1371,27,544,'2018-04-22 19:10:00','2018-04-22 19:10:00','success',NULL,'cron',NULL),(1372,28,364,'2018-04-22 19:15:00','2018-04-22 19:15:00','success',NULL,'cron',NULL),(1373,23,364,'2018-04-22 19:15:00','2018-04-22 19:15:00','success',NULL,'cron',NULL),(1374,27,545,'2018-04-22 19:20:00','2018-04-22 19:20:00','success',NULL,'cron',NULL),(1375,27,546,'2018-04-22 19:30:00','2018-04-22 19:30:00','success',NULL,'cron',NULL),(1376,23,365,'2018-04-22 19:30:00','2018-04-22 19:30:00','success',NULL,'cron',NULL),(1377,28,365,'2018-04-22 19:30:00','2018-04-22 19:30:00','success',NULL,'cron',NULL),(1378,27,547,'2018-04-22 19:40:00','2018-04-22 19:40:00','success',NULL,'cron',NULL),(1379,28,366,'2018-04-22 19:45:00','2018-04-22 19:45:00','success',NULL,'cron',NULL),(1380,23,366,'2018-04-22 19:45:00','2018-04-22 19:45:00','success',NULL,'cron',NULL),(1381,27,548,'2018-04-22 19:50:00','2018-04-22 19:50:00','success',NULL,'cron',NULL),(1382,27,549,'2018-04-22 20:00:00','2018-04-22 20:00:00','success',NULL,'cron',NULL),(1383,23,367,'2018-04-22 20:00:00','2018-04-22 20:00:00','success',NULL,'cron',NULL),(1384,28,367,'2018-04-22 20:00:00','2018-04-22 20:00:00','success',NULL,'cron',NULL),(1385,27,550,'2018-04-22 20:10:00','2018-04-22 20:10:00','success',NULL,'cron',NULL),(1386,23,368,'2018-04-22 20:15:00','2018-04-22 20:15:00','success',NULL,'cron',NULL),(1387,28,368,'2018-04-22 20:15:00','2018-04-22 20:15:00','success',NULL,'cron',NULL),(1388,27,551,'2018-04-22 20:20:00','2018-04-22 20:20:00','success',NULL,'cron',NULL),(1389,27,552,'2018-04-22 20:30:00','2018-04-22 20:30:00','success',NULL,'cron',NULL),(1390,23,369,'2018-04-22 20:30:00','2018-04-22 20:30:00','success',NULL,'cron',NULL),(1391,28,369,'2018-04-22 20:30:00','2018-04-22 20:30:00','success',NULL,'cron',NULL),(1392,27,553,'2018-04-22 20:40:00','2018-04-22 20:40:00','success',NULL,'cron',NULL),(1393,28,370,'2018-04-22 20:45:00','2018-04-22 20:45:00','success',NULL,'cron',NULL),(1394,23,370,'2018-04-22 20:45:00','2018-04-22 20:45:00','success',NULL,'cron',NULL),(1395,27,554,'2018-04-22 20:50:00','2018-04-22 20:50:00','success',NULL,'cron',NULL),(1396,23,371,'2018-04-22 21:00:00','2018-04-22 21:00:00','success',NULL,'cron',NULL),(1397,27,555,'2018-04-22 21:00:00','2018-04-22 21:00:00','success',NULL,'cron',NULL),(1398,28,371,'2018-04-22 21:00:00','2018-04-22 21:00:00','success',NULL,'cron',NULL),(1399,1,5,'2018-04-22 21:00:00','2018-04-22 21:00:00','success',NULL,'cron',NULL),(1400,27,556,'2018-04-22 21:10:00','2018-04-22 21:10:00','success',NULL,'cron',NULL),(1401,23,372,'2018-04-22 21:15:00','2018-04-22 21:15:00','success',NULL,'cron',NULL),(1402,28,372,'2018-04-22 21:15:00','2018-04-22 21:15:00','success',NULL,'cron',NULL),(1403,27,557,'2018-04-22 21:20:00','2018-04-22 21:20:00','success',NULL,'cron',NULL),(1404,4,5,'2018-04-22 21:20:00','2018-04-22 21:20:00','success',NULL,'cron',NULL),(1405,27,558,'2018-04-22 21:30:00','2018-04-22 21:30:00','success',NULL,'cron',NULL),(1406,23,373,'2018-04-22 21:30:00','2018-04-22 21:30:00','success',NULL,'cron',NULL),(1407,28,373,'2018-04-22 21:30:00','2018-04-22 21:30:00','success',NULL,'cron',NULL),(1408,27,559,'2018-04-22 21:40:00','2018-04-22 21:40:00','success',NULL,'cron',NULL),(1409,23,374,'2018-04-22 21:45:00','2018-04-22 21:45:00','success',NULL,'cron',NULL),(1410,28,374,'2018-04-22 21:45:00','2018-04-22 21:45:00','success',NULL,'cron',NULL),(1411,27,560,'2018-04-22 21:50:00','2018-04-22 21:50:00','success',NULL,'cron',NULL),(1412,28,375,'2018-04-22 22:00:00','2018-04-22 22:00:00','success',NULL,'cron',NULL),(1413,23,375,'2018-04-22 22:00:00','2018-04-22 22:00:00','success',NULL,'cron',NULL),(1414,27,561,'2018-04-22 22:00:00','2018-04-22 22:00:00','success',NULL,'cron',NULL),(1415,27,562,'2018-04-22 22:10:00','2018-04-22 22:10:00','success',NULL,'cron',NULL),(1416,23,376,'2018-04-22 22:15:00','2018-04-22 22:15:00','success',NULL,'cron',NULL),(1417,28,376,'2018-04-22 22:15:00','2018-04-22 22:15:00','success',NULL,'cron',NULL),(1418,27,563,'2018-04-22 22:20:00','2018-04-22 22:20:00','success',NULL,'cron',NULL),(1419,28,377,'2018-04-22 22:30:00','2018-04-22 22:30:00','success',NULL,'cron',NULL),(1420,23,377,'2018-04-22 22:30:00','2018-04-22 22:30:00','success',NULL,'cron',NULL),(1421,27,564,'2018-04-22 22:30:00','2018-04-22 22:30:00','success',NULL,'cron',NULL),(1422,27,565,'2018-04-22 22:40:00','2018-04-22 22:40:00','success',NULL,'cron',NULL),(1423,28,378,'2018-04-22 22:45:00','2018-04-22 22:45:00','success',NULL,'cron',NULL),(1424,23,378,'2018-04-22 22:45:00','2018-04-22 22:45:00','success',NULL,'cron',NULL),(1425,27,566,'2018-04-22 22:50:00','2018-04-22 22:50:00','success',NULL,'cron',NULL),(1426,19,5,'2018-04-22 23:00:00','2018-04-22 23:00:00','success',NULL,'cron',NULL),(1427,23,379,'2018-04-22 23:00:00','2018-04-22 23:00:00','success',NULL,'cron',NULL),(1428,27,567,'2018-04-22 23:00:00','2018-04-22 23:00:00','success',NULL,'cron',NULL),(1429,10,5,'2018-04-22 23:00:00','2018-04-22 23:00:00','success',NULL,'cron',NULL),(1430,12,5,'2018-04-22 23:00:00','2018-04-22 23:00:00','success',NULL,'cron',NULL),(1431,13,5,'2018-04-22 23:00:00','2018-04-22 23:00:00','success',NULL,'cron',NULL),(1432,20,5,'2018-04-22 23:00:00','2018-04-22 23:00:00','success',NULL,'cron',NULL),(1433,15,5,'2018-04-22 23:00:00','2018-04-22 23:00:00','success',NULL,'cron',NULL),(1434,28,379,'2018-04-22 23:00:00','2018-04-22 23:00:00','success',NULL,'cron',NULL),(1435,6,5,'2018-04-22 23:00:00','2018-04-22 23:00:00','success',NULL,'cron',NULL),(1436,21,5,'2018-04-22 23:00:00','2018-04-22 23:00:00','success',NULL,'cron',NULL),(1437,22,5,'2018-04-22 23:01:00','2018-04-22 23:01:00','success',NULL,'cron',NULL),(1438,7,5,'2018-04-22 23:01:00','2018-04-22 23:01:00','success',NULL,'cron',NULL),(1439,9,5,'2018-04-22 23:01:00','2018-04-22 23:01:00','success',NULL,'cron',NULL),(1440,2,5,'2018-04-22 23:01:00','2018-04-22 23:01:00','success',NULL,'cron',NULL),(1441,17,5,'2018-04-22 23:01:00','2018-04-22 23:01:00','success',NULL,'cron',NULL),(1442,11,5,'2018-04-22 23:01:00','2018-04-22 23:01:00','success',NULL,'cron',NULL),(1443,16,5,'2018-04-22 23:02:00','2018-04-22 23:02:00','success',NULL,'cron',NULL),(1444,14,5,'2018-04-22 23:02:00','2018-04-22 23:02:00','success',NULL,'cron',NULL),(1445,18,5,'2018-04-22 23:05:00','2018-04-22 23:05:00','success',NULL,'cron',NULL),(1446,3,5,'2018-04-22 23:05:00','2018-04-22 23:05:00','success',NULL,'cron',NULL),(1447,27,568,'2018-04-22 23:10:00','2018-04-22 23:10:00','success',NULL,'cron',NULL),(1448,28,380,'2018-04-22 23:15:00','2018-04-22 23:15:00','success',NULL,'cron',NULL),(1449,23,380,'2018-04-22 23:15:00','2018-04-22 23:15:00','success',NULL,'cron',NULL),(1450,27,569,'2018-04-22 23:20:00','2018-04-22 23:20:00','success',NULL,'cron',NULL),(1451,23,381,'2018-04-22 23:30:00','2018-04-22 23:30:00','success',NULL,'cron',NULL),(1452,27,570,'2018-04-22 23:30:00','2018-04-22 23:30:00','success',NULL,'cron',NULL),(1453,28,381,'2018-04-22 23:30:00','2018-04-22 23:30:00','success',NULL,'cron',NULL),(1454,27,571,'2018-04-22 23:40:00','2018-04-22 23:40:00','success',NULL,'cron',NULL),(1455,28,382,'2018-04-22 23:45:00','2018-04-22 23:45:00','success',NULL,'cron',NULL),(1456,23,382,'2018-04-22 23:45:00','2018-04-22 23:45:00','success',NULL,'cron',NULL),(1457,27,572,'2018-04-22 23:50:00','2018-04-22 23:50:00','success',NULL,'cron',NULL),(1458,28,383,'2018-04-23 00:00:00','2018-04-23 00:00:00','success',NULL,'cron',NULL),(1459,27,573,'2018-04-23 00:00:00','2018-04-23 00:00:00','success',NULL,'cron',NULL),(1460,23,383,'2018-04-23 00:00:00','2018-04-23 00:00:00','success',NULL,'cron',NULL),(1461,27,574,'2018-04-23 00:10:00','2018-04-23 00:10:00','success',NULL,'cron',NULL),(1462,28,384,'2018-04-23 00:15:00','2018-04-23 00:15:00','success',NULL,'cron',NULL),(1463,23,384,'2018-04-23 00:15:00','2018-04-23 00:15:00','success',NULL,'cron',NULL),(1464,27,575,'2018-04-23 00:20:00','2018-04-23 00:20:00','success',NULL,'cron',NULL),(1465,28,385,'2018-04-23 00:30:00','2018-04-23 00:30:00','success',NULL,'cron',NULL),(1466,27,576,'2018-04-23 00:30:00','2018-04-23 00:30:00','success',NULL,'cron',NULL),(1467,23,385,'2018-04-23 00:30:00','2018-04-23 00:30:00','success',NULL,'cron',NULL),(1468,27,577,'2018-04-23 00:40:00','2018-04-23 00:40:00','success',NULL,'cron',NULL),(1469,23,386,'2018-04-23 00:45:00','2018-04-23 00:45:00','success',NULL,'cron',NULL),(1470,28,386,'2018-04-23 00:45:00','2018-04-23 00:45:00','success',NULL,'cron',NULL),(1471,27,578,'2018-04-23 00:50:00','2018-04-23 00:50:00','success',NULL,'cron',NULL),(1472,28,387,'2018-04-23 01:00:00','2018-04-23 01:00:00','success',NULL,'cron',NULL),(1473,27,579,'2018-04-23 01:00:00','2018-04-23 01:00:00','success',NULL,'cron',NULL),(1474,23,387,'2018-04-23 01:00:00','2018-04-23 01:00:00','success',NULL,'cron',NULL),(1475,27,580,'2018-04-23 01:10:00','2018-04-23 01:10:00','success',NULL,'cron',NULL),(1476,23,388,'2018-04-23 01:15:00','2018-04-23 01:15:00','success',NULL,'cron',NULL),(1477,28,388,'2018-04-23 01:15:00','2018-04-23 01:15:00','success',NULL,'cron',NULL),(1478,27,581,'2018-04-23 01:20:00','2018-04-23 01:20:00','success',NULL,'cron',NULL),(1479,27,582,'2018-04-23 01:30:00','2018-04-23 01:30:00','success',NULL,'cron',NULL),(1480,28,389,'2018-04-23 01:30:00','2018-04-23 01:30:00','success',NULL,'cron',NULL),(1481,23,389,'2018-04-23 01:30:00','2018-04-23 01:30:00','success',NULL,'cron',NULL),(1482,27,583,'2018-04-23 01:40:00','2018-04-23 01:40:00','success',NULL,'cron',NULL),(1483,28,390,'2018-04-23 01:45:00','2018-04-23 01:45:00','success',NULL,'cron',NULL),(1484,23,390,'2018-04-23 01:45:00','2018-04-23 01:45:00','success',NULL,'cron',NULL),(1485,27,584,'2018-04-23 01:50:00','2018-04-23 01:50:00','success',NULL,'cron',NULL),(1486,27,585,'2018-04-23 02:00:00','2018-04-23 02:00:00','success',NULL,'cron',NULL),(1487,28,391,'2018-04-23 02:00:00','2018-04-23 02:00:00','success',NULL,'cron',NULL),(1488,23,391,'2018-04-23 02:00:00','2018-04-23 02:00:00','success',NULL,'cron',NULL),(1489,27,586,'2018-04-23 02:10:00','2018-04-23 02:10:00','success',NULL,'cron',NULL),(1490,28,392,'2018-04-23 02:15:00','2018-04-23 02:15:00','success',NULL,'cron',NULL),(1491,23,392,'2018-04-23 02:15:00','2018-04-23 02:15:00','success',NULL,'cron',NULL),(1492,27,587,'2018-04-23 02:20:00','2018-04-23 02:20:00','success',NULL,'cron',NULL),(1493,27,588,'2018-04-23 02:30:00','2018-04-23 02:30:00','success',NULL,'cron',NULL),(1494,23,393,'2018-04-23 02:30:00','2018-04-23 02:30:00','success',NULL,'cron',NULL),(1495,28,393,'2018-04-23 02:30:00','2018-04-23 02:30:00','success',NULL,'cron',NULL),(1496,27,589,'2018-04-23 02:40:00','2018-04-23 02:40:00','success',NULL,'cron',NULL),(1497,28,394,'2018-04-23 02:45:00','2018-04-23 02:45:00','success',NULL,'cron',NULL),(1498,23,394,'2018-04-23 02:45:00','2018-04-23 02:45:00','success',NULL,'cron',NULL),(1499,27,590,'2018-04-23 02:50:00','2018-04-23 02:50:00','success',NULL,'cron',NULL),(1500,27,591,'2018-04-23 03:00:00','2018-04-23 03:00:00','success',NULL,'cron',NULL),(1501,23,395,'2018-04-23 03:00:00','2018-04-23 03:00:00','success',NULL,'cron',NULL),(1502,28,395,'2018-04-23 03:00:00','2018-04-23 03:00:00','success',NULL,'cron',NULL),(1503,27,592,'2018-04-23 03:10:00','2018-04-23 03:10:00','success',NULL,'cron',NULL),(1504,28,396,'2018-04-23 03:15:00','2018-04-23 03:15:00','success',NULL,'cron',NULL),(1505,23,396,'2018-04-23 03:15:00','2018-04-23 03:15:00','success',NULL,'cron',NULL),(1506,27,593,'2018-04-23 03:20:00','2018-04-23 03:20:00','success',NULL,'cron',NULL),(1507,28,397,'2018-04-23 03:30:00','2018-04-23 03:30:00','success',NULL,'cron',NULL),(1508,27,594,'2018-04-23 03:30:00','2018-04-23 03:30:00','success',NULL,'cron',NULL),(1509,23,397,'2018-04-23 03:30:00','2018-04-23 03:30:00','success',NULL,'cron',NULL),(1510,27,595,'2018-04-23 03:40:00','2018-04-23 03:40:00','success',NULL,'cron',NULL),(1511,28,398,'2018-04-23 03:45:00','2018-04-23 03:45:00','success',NULL,'cron',NULL),(1512,23,398,'2018-04-23 03:45:00','2018-04-23 03:45:00','success',NULL,'cron',NULL),(1513,27,596,'2018-04-23 03:50:00','2018-04-23 03:50:00','success',NULL,'cron',NULL),(1514,24,4,'2018-04-23 04:00:00','2018-04-23 04:00:00','success',NULL,'cron',NULL),(1515,27,597,'2018-04-23 04:00:00','2018-04-23 04:00:00','success',NULL,'cron',NULL),(1516,28,399,'2018-04-23 04:00:00','2018-04-23 04:00:00','success',NULL,'cron',NULL),(1517,23,399,'2018-04-23 04:00:00','2018-04-23 04:00:00','success',NULL,'cron',NULL),(1518,25,4,'2018-04-23 04:00:00','2018-04-23 04:00:00','success',NULL,'cron',NULL),(1519,26,4,'2018-04-23 04:00:00','2018-04-23 04:00:00','success',NULL,'cron',NULL),(1520,27,598,'2018-04-23 04:10:00','2018-04-23 04:10:00','success',NULL,'cron',NULL),(1521,28,400,'2018-04-23 04:15:00','2018-04-23 04:15:00','success',NULL,'cron',NULL),(1522,23,400,'2018-04-23 04:15:00','2018-04-23 04:15:00','success',NULL,'cron',NULL),(1523,27,599,'2018-04-23 04:20:00','2018-04-23 04:20:00','success',NULL,'cron',NULL),(1524,28,401,'2018-04-23 04:30:00','2018-04-23 04:30:00','success',NULL,'cron',NULL),(1525,27,600,'2018-04-23 04:30:00','2018-04-23 04:30:00','success',NULL,'cron',NULL),(1526,23,401,'2018-04-23 04:30:00','2018-04-23 04:30:00','success',NULL,'cron',NULL),(1527,27,601,'2018-04-23 04:40:00','2018-04-23 04:40:00','success',NULL,'cron',NULL),(1528,23,402,'2018-04-23 04:45:00','2018-04-23 04:45:00','success',NULL,'cron',NULL),(1529,28,402,'2018-04-23 04:45:00','2018-04-23 04:45:00','success',NULL,'cron',NULL),(1530,27,602,'2018-04-23 04:50:00','2018-04-23 04:50:00','success',NULL,'cron',NULL),(1531,23,403,'2018-04-23 05:00:00','2018-04-23 05:00:00','success',NULL,'cron',NULL),(1532,28,403,'2018-04-23 05:00:00','2018-04-23 05:00:00','success',NULL,'cron',NULL),(1533,27,603,'2018-04-23 05:00:00','2018-04-23 05:00:00','success',NULL,'cron',NULL),(1534,27,604,'2018-04-23 05:10:00','2018-04-23 05:10:00','success',NULL,'cron',NULL),(1535,23,404,'2018-04-23 05:15:00','2018-04-23 05:15:00','success',NULL,'cron',NULL),(1536,28,404,'2018-04-23 05:15:00','2018-04-23 05:15:00','success',NULL,'cron',NULL),(1537,27,605,'2018-04-23 05:20:00','2018-04-23 05:20:00','success',NULL,'cron',NULL),(1538,23,405,'2018-04-23 05:30:00','2018-04-23 05:30:00','success',NULL,'cron',NULL),(1539,27,606,'2018-04-23 05:30:00','2018-04-23 05:30:00','success',NULL,'cron',NULL),(1540,28,405,'2018-04-23 05:30:00','2018-04-23 05:30:00','success',NULL,'cron',NULL),(1541,27,607,'2018-04-23 05:40:00','2018-04-23 05:40:00','success',NULL,'cron',NULL),(1542,28,406,'2018-04-23 05:45:00','2018-04-23 05:45:00','success',NULL,'cron',NULL),(1543,23,406,'2018-04-23 05:45:00','2018-04-23 05:45:00','success',NULL,'cron',NULL),(1544,27,608,'2018-04-23 05:50:00','2018-04-23 05:50:00','success',NULL,'cron',NULL),(1545,28,407,'2018-04-23 06:00:00','2018-04-23 06:00:00','success',NULL,'cron',NULL),(1546,23,407,'2018-04-23 06:00:00','2018-04-23 06:00:00','success',NULL,'cron',NULL),(1547,27,609,'2018-04-23 06:00:00','2018-04-23 06:00:00','success',NULL,'cron',NULL),(1548,27,610,'2018-04-23 06:10:00','2018-04-23 06:10:00','success',NULL,'cron',NULL),(1549,23,408,'2018-04-23 06:15:00','2018-04-23 06:15:00','success',NULL,'cron',NULL),(1550,28,408,'2018-04-23 06:15:00','2018-04-23 06:15:00','success',NULL,'cron',NULL),(1551,27,611,'2018-04-23 06:20:00','2018-04-23 06:20:00','success',NULL,'cron',NULL),(1552,28,409,'2018-04-23 06:30:00','2018-04-23 06:30:00','success',NULL,'cron',NULL),(1553,27,612,'2018-04-23 06:30:00','2018-04-23 06:30:00','success',NULL,'cron',NULL),(1554,23,409,'2018-04-23 06:30:00','2018-04-23 06:30:00','success',NULL,'cron',NULL),(1555,27,613,'2018-04-23 06:40:00','2018-04-23 06:40:00','success',NULL,'cron',NULL),(1556,28,410,'2018-04-23 06:45:00','2018-04-23 06:45:00','success',NULL,'cron',NULL),(1557,23,410,'2018-04-23 06:45:00','2018-04-23 06:45:00','success',NULL,'cron',NULL),(1558,27,614,'2018-04-23 06:50:00','2018-04-23 06:50:00','success',NULL,'cron',NULL),(1559,27,615,'2018-04-23 07:00:00','2018-04-23 07:00:00','success',NULL,'cron',NULL),(1560,28,411,'2018-04-23 07:00:00','2018-04-23 07:00:00','success',NULL,'cron',NULL),(1561,23,411,'2018-04-23 07:00:00','2018-04-23 07:00:00','success',NULL,'cron',NULL),(1562,27,616,'2018-04-23 07:10:00','2018-04-23 07:10:00','success',NULL,'cron',NULL),(1563,23,412,'2018-04-23 07:15:00','2018-04-23 07:15:00','success',NULL,'cron',NULL),(1564,28,412,'2018-04-23 07:15:00','2018-04-23 07:15:00','success',NULL,'cron',NULL),(1565,27,617,'2018-04-23 07:20:00','2018-04-23 07:20:00','success',NULL,'cron',NULL),(1566,27,618,'2018-04-23 07:30:00','2018-04-23 07:30:00','success',NULL,'cron',NULL),(1567,28,413,'2018-04-23 07:30:00','2018-04-23 07:30:00','success',NULL,'cron',NULL),(1568,23,413,'2018-04-23 07:30:00','2018-04-23 07:30:00','success',NULL,'cron',NULL),(1569,27,619,'2018-04-23 07:40:00','2018-04-23 07:40:00','success',NULL,'cron',NULL),(1570,23,414,'2018-04-23 07:45:00','2018-04-23 07:45:00','success',NULL,'cron',NULL),(1571,28,414,'2018-04-23 07:45:00','2018-04-23 07:45:00','success',NULL,'cron',NULL),(1572,27,620,'2018-04-23 07:50:00','2018-04-23 07:50:00','success',NULL,'cron',NULL),(1573,27,621,'2018-04-23 08:00:00','2018-04-23 08:00:00','success',NULL,'cron',NULL),(1574,23,415,'2018-04-23 08:00:00','2018-04-23 08:00:00','success',NULL,'cron',NULL),(1575,28,415,'2018-04-23 08:00:00','2018-04-23 08:00:00','success',NULL,'cron',NULL),(1576,27,622,'2018-04-23 08:10:00','2018-04-23 08:10:00','success',NULL,'cron',NULL),(1577,28,416,'2018-04-23 08:15:00','2018-04-23 08:15:00','success',NULL,'cron',NULL),(1578,23,416,'2018-04-23 08:15:00','2018-04-23 08:15:00','success',NULL,'cron',NULL),(1579,27,623,'2018-04-23 08:20:00','2018-04-23 08:20:00','success',NULL,'cron',NULL),(1580,27,624,'2018-04-23 08:30:00','2018-04-23 08:30:00','success',NULL,'cron',NULL),(1581,28,417,'2018-04-23 08:30:00','2018-04-23 08:30:00','success',NULL,'cron',NULL),(1582,23,417,'2018-04-23 08:30:00','2018-04-23 08:30:00','success',NULL,'cron',NULL),(1583,27,625,'2018-04-23 08:40:00','2018-04-23 08:40:00','success',NULL,'cron',NULL),(1584,23,418,'2018-04-23 08:45:00','2018-04-23 08:45:00','success',NULL,'cron',NULL),(1585,28,418,'2018-04-23 08:45:00','2018-04-23 08:45:00','success',NULL,'cron',NULL),(1586,27,626,'2018-04-23 08:50:00','2018-04-23 08:50:00','success',NULL,'cron',NULL),(1587,28,419,'2018-04-23 09:00:00','2018-04-23 09:00:00','success',NULL,'cron',NULL),(1588,23,419,'2018-04-23 09:00:00','2018-04-23 09:00:00','success',NULL,'cron',NULL),(1589,27,627,'2018-04-23 09:00:00','2018-04-23 09:00:00','success',NULL,'cron',NULL),(1590,27,628,'2018-04-23 09:10:00','2018-04-23 09:10:00','success',NULL,'cron',NULL),(1591,23,420,'2018-04-23 09:15:00','2018-04-23 09:15:00','success',NULL,'cron',NULL),(1592,28,420,'2018-04-23 09:15:00','2018-04-23 09:15:00','success',NULL,'cron',NULL),(1593,27,629,'2018-04-23 09:20:00','2018-04-23 09:20:00','success',NULL,'cron',NULL),(1594,27,630,'2018-04-23 09:30:00','2018-04-23 09:30:00','success',NULL,'cron',NULL),(1595,28,421,'2018-04-23 09:30:00','2018-04-23 09:30:00','success',NULL,'cron',NULL),(1596,23,421,'2018-04-23 09:30:00','2018-04-23 09:30:00','success',NULL,'cron',NULL),(1597,27,631,'2018-04-23 09:40:00','2018-04-23 09:40:00','success',NULL,'cron',NULL),(1598,28,422,'2018-04-23 09:45:00','2018-04-23 09:45:00','success',NULL,'cron',NULL),(1599,23,422,'2018-04-23 09:45:00','2018-04-23 09:45:00','success',NULL,'cron',NULL),(1600,27,632,'2018-04-23 09:50:00','2018-04-23 09:50:00','success',NULL,'cron',NULL),(1601,27,633,'2018-04-23 10:00:00','2018-04-23 10:00:00','success',NULL,'cron',NULL),(1602,23,423,'2018-04-23 10:00:00','2018-04-23 10:00:00','success',NULL,'cron',NULL),(1603,28,423,'2018-04-23 10:00:00','2018-04-23 10:00:00','success',NULL,'cron',NULL),(1604,27,634,'2018-04-23 10:10:00','2018-04-23 10:10:00','success',NULL,'cron',NULL),(1605,28,424,'2018-04-23 10:15:00','2018-04-23 10:15:00','success',NULL,'cron',NULL),(1606,23,424,'2018-04-23 10:15:00','2018-04-23 10:15:00','success',NULL,'cron',NULL),(1607,27,635,'2018-04-23 10:20:00','2018-04-23 10:20:00','success',NULL,'cron',NULL),(1608,27,636,'2018-04-23 10:30:00','2018-04-23 10:30:00','success',NULL,'cron',NULL),(1609,23,425,'2018-04-23 10:30:00','2018-04-23 10:30:00','success',NULL,'cron',NULL),(1610,28,425,'2018-04-23 10:30:00','2018-04-23 10:30:00','success',NULL,'cron',NULL),(1611,27,637,'2018-04-23 10:40:00','2018-04-23 10:40:00','success',NULL,'cron',NULL),(1612,28,426,'2018-04-23 10:45:00','2018-04-23 10:45:00','success',NULL,'cron',NULL),(1613,23,426,'2018-04-23 10:45:00','2018-04-23 10:45:00','success',NULL,'cron',NULL),(1614,27,638,'2018-04-23 10:50:00','2018-04-23 10:50:00','success',NULL,'cron',NULL),(1615,28,427,'2018-04-23 11:00:00','2018-04-23 11:00:00','success',NULL,'cron',NULL),(1616,5,5,'2018-04-23 11:00:00','2018-04-23 11:00:00','success',NULL,'cron',NULL),(1617,29,5,'2018-04-23 11:00:00','2018-04-23 11:00:00','success',NULL,'cron',NULL),(1618,23,427,'2018-04-23 11:00:00','2018-04-23 11:00:00','success',NULL,'cron',NULL),(1619,27,639,'2018-04-23 11:00:00','2018-04-23 11:00:00','success',NULL,'cron',NULL),(1620,8,5,'2018-04-23 11:00:00','2018-04-23 11:00:00','success',NULL,'cron',NULL),(1621,27,640,'2018-04-23 11:10:00','2018-04-23 11:10:00','success',NULL,'cron',NULL),(1622,28,428,'2018-04-23 11:15:00','2018-04-23 11:15:00','success',NULL,'cron',NULL),(1623,23,428,'2018-04-23 11:15:00','2018-04-23 11:15:00','success',NULL,'cron',NULL),(1624,27,641,'2018-04-23 11:20:00','2018-04-23 11:20:00','success',NULL,'cron',NULL),(1625,27,642,'2018-04-23 11:30:00','2018-04-23 11:30:00','success',NULL,'cron',NULL),(1626,23,429,'2018-04-23 11:30:00','2018-04-23 11:30:00','success',NULL,'cron',NULL),(1627,28,429,'2018-04-23 11:30:00','2018-04-23 11:30:00','success',NULL,'cron',NULL),(1628,27,643,'2018-04-23 11:40:00','2018-04-23 11:40:00','success',NULL,'cron',NULL),(1629,23,430,'2018-04-23 11:45:00','2018-04-23 11:45:00','success',NULL,'cron',NULL),(1630,28,430,'2018-04-23 11:45:00','2018-04-23 11:45:00','success',NULL,'cron',NULL),(1631,27,644,'2018-04-23 11:50:00','2018-04-23 11:50:00','success',NULL,'cron',NULL),(1632,27,645,'2018-04-23 12:00:00','2018-04-23 12:00:00','success',NULL,'cron',NULL),(1633,28,431,'2018-04-23 12:00:00','2018-04-23 12:00:00','success',NULL,'cron',NULL),(1634,23,431,'2018-04-23 12:00:00','2018-04-23 12:00:00','success',NULL,'cron',NULL),(1635,27,646,'2018-04-23 12:10:00','2018-04-23 12:10:00','success',NULL,'cron',NULL),(1636,23,432,'2018-04-23 12:15:00','2018-04-23 12:15:00','success',NULL,'cron',NULL),(1637,28,432,'2018-04-23 12:15:00','2018-04-23 12:15:00','success',NULL,'cron',NULL),(1638,27,647,'2018-04-23 12:20:00','2018-04-23 12:20:00','success',NULL,'cron',NULL),(1639,28,433,'2018-04-23 12:30:00','2018-04-23 12:30:00','success',NULL,'cron',NULL),(1640,23,433,'2018-04-23 12:30:00','2018-04-23 12:30:00','success',NULL,'cron',NULL),(1641,27,648,'2018-04-23 12:30:00','2018-04-23 12:30:00','success',NULL,'cron',NULL),(1642,27,649,'2018-04-23 12:40:00','2018-04-23 12:40:00','success',NULL,'cron',NULL),(1643,23,434,'2018-04-23 12:45:00','2018-04-23 12:45:00','success',NULL,'cron',NULL),(1644,28,434,'2018-04-23 12:45:00','2018-04-23 12:45:00','success',NULL,'cron',NULL),(1645,27,650,'2018-04-23 12:50:00','2018-04-23 12:50:00','success',NULL,'cron',NULL),(1646,23,435,'2018-04-23 13:00:00','2018-04-23 13:00:00','success',NULL,'cron',NULL),(1647,28,435,'2018-04-23 13:00:00','2018-04-23 13:00:00','success',NULL,'cron',NULL),(1648,27,651,'2018-04-23 13:00:00','2018-04-23 13:00:00','success',NULL,'cron',NULL),(1649,27,652,'2018-04-23 13:10:00','2018-04-23 13:10:00','success',NULL,'cron',NULL),(1650,28,436,'2018-04-23 13:15:00','2018-04-23 13:15:00','success',NULL,'cron',NULL),(1651,23,436,'2018-04-23 13:15:00','2018-04-23 13:15:00','success',NULL,'cron',NULL),(1652,27,653,'2018-04-23 13:20:00','2018-04-23 13:20:00','success',NULL,'cron',NULL),(1653,23,437,'2018-04-23 13:30:00','2018-04-23 13:30:00','success',NULL,'cron',NULL),(1654,28,437,'2018-04-23 13:30:00','2018-04-23 13:30:00','success',NULL,'cron',NULL),(1655,27,654,'2018-04-23 13:30:00','2018-04-23 13:30:00','success',NULL,'cron',NULL),(1656,27,655,'2018-04-23 13:40:00','2018-04-23 13:40:00','success',NULL,'cron',NULL),(1657,28,438,'2018-04-23 13:45:00','2018-04-23 13:45:00','success',NULL,'cron',NULL),(1658,23,438,'2018-04-23 13:45:00','2018-04-23 13:45:00','success',NULL,'cron',NULL),(1659,27,656,'2018-04-23 13:50:00','2018-04-23 13:50:00','success',NULL,'cron',NULL),(1660,28,439,'2018-04-23 14:00:00','2018-04-23 14:00:00','success',NULL,'cron',NULL),(1661,27,657,'2018-04-23 14:00:00','2018-04-23 14:00:00','success',NULL,'cron',NULL),(1662,23,439,'2018-04-23 14:00:00','2018-04-23 14:00:00','success',NULL,'cron',NULL),(1663,27,658,'2018-04-23 14:10:00','2018-04-23 14:10:00','success',NULL,'cron',NULL),(1664,28,440,'2018-04-23 14:15:00','2018-04-23 14:15:00','success',NULL,'cron',NULL),(1665,23,440,'2018-04-23 14:15:00','2018-04-23 14:15:00','success',NULL,'cron',NULL),(1666,27,659,'2018-04-23 14:20:00','2018-04-23 14:20:00','success',NULL,'cron',NULL),(1667,28,441,'2018-04-23 14:30:00','2018-04-23 14:30:00','success',NULL,'cron',NULL),(1668,23,441,'2018-04-23 14:30:00','2018-04-23 14:30:00','success',NULL,'cron',NULL),(1669,27,660,'2018-04-23 14:30:00','2018-04-23 14:30:00','success',NULL,'cron',NULL),(1670,27,661,'2018-04-23 14:40:00','2018-04-23 14:40:00','success',NULL,'cron',NULL),(1671,23,442,'2018-04-23 14:45:00','2018-04-23 14:45:00','success',NULL,'cron',NULL),(1672,28,442,'2018-04-23 14:45:00','2018-04-23 14:45:00','success',NULL,'cron',NULL),(1673,27,662,'2018-04-23 14:50:00','2018-04-23 14:50:00','success',NULL,'cron',NULL),(1674,27,663,'2018-04-23 15:00:00','2018-04-23 15:00:00','success',NULL,'cron',NULL),(1675,28,443,'2018-04-23 15:00:00','2018-04-23 15:00:00','success',NULL,'cron',NULL),(1676,23,443,'2018-04-23 15:00:00','2018-04-23 15:00:00','success',NULL,'cron',NULL),(1677,27,664,'2018-04-23 15:10:00','2018-04-23 15:10:00','success',NULL,'cron',NULL),(1678,28,444,'2018-04-23 15:15:00','2018-04-23 15:15:00','success',NULL,'cron',NULL),(1679,23,444,'2018-04-23 15:15:00','2018-04-23 15:15:00','success',NULL,'cron',NULL),(1680,27,665,'2018-04-23 15:20:00','2018-04-23 15:20:00','success',NULL,'cron',NULL),(1681,28,445,'2018-04-23 15:30:00','2018-04-23 15:30:00','success',NULL,'cron',NULL),(1682,23,445,'2018-04-23 15:30:00','2018-04-23 15:30:00','success',NULL,'cron',NULL),(1683,27,666,'2018-04-23 15:30:00','2018-04-23 15:30:00','success',NULL,'cron',NULL),(1684,27,667,'2018-04-23 15:40:00','2018-04-23 15:40:00','success',NULL,'cron',NULL),(1685,28,446,'2018-04-23 15:45:00','2018-04-23 15:45:00','success',NULL,'cron',NULL),(1686,23,446,'2018-04-23 15:45:00','2018-04-23 15:45:00','success',NULL,'cron',NULL),(1687,27,668,'2018-04-23 15:50:00','2018-04-23 15:50:00','success',NULL,'cron',NULL),(1688,28,447,'2018-04-23 16:00:00','2018-04-23 16:00:00','success',NULL,'cron',NULL),(1689,27,669,'2018-04-23 16:00:00','2018-04-23 16:00:00','success',NULL,'cron',NULL),(1690,23,447,'2018-04-23 16:00:00','2018-04-23 16:00:00','success',NULL,'cron',NULL),(1691,27,670,'2018-04-23 16:10:00','2018-04-23 16:10:00','success',NULL,'cron',NULL),(1692,28,448,'2018-04-23 16:15:00','2018-04-23 16:15:00','success',NULL,'cron',NULL),(1693,23,448,'2018-04-23 16:15:00','2018-04-23 16:15:00','success',NULL,'cron',NULL),(1694,27,671,'2018-04-23 16:20:00','2018-04-23 16:20:00','success',NULL,'cron',NULL),(1695,27,672,'2018-04-23 16:30:00','2018-04-23 16:30:00','success',NULL,'cron',NULL),(1696,23,449,'2018-04-23 16:30:00','2018-04-23 16:30:00','success',NULL,'cron',NULL),(1697,28,449,'2018-04-23 16:30:00','2018-04-23 16:30:00','success',NULL,'cron',NULL),(1698,27,673,'2018-04-23 16:40:00','2018-04-23 16:40:00','success',NULL,'cron',NULL),(1699,28,450,'2018-04-23 16:45:00','2018-04-23 16:45:00','success',NULL,'cron',NULL),(1700,23,450,'2018-04-23 16:45:00','2018-04-23 16:45:00','success',NULL,'cron',NULL),(1701,27,674,'2018-04-23 16:50:00','2018-04-23 16:50:00','success',NULL,'cron',NULL),(1702,23,451,'2018-04-23 17:00:00','2018-04-23 17:00:00','success',NULL,'cron',NULL),(1703,27,675,'2018-04-23 17:00:00','2018-04-23 17:00:00','success',NULL,'cron',NULL),(1704,28,451,'2018-04-23 17:00:00','2018-04-23 17:00:00','success',NULL,'cron',NULL),(1705,27,676,'2018-04-23 17:10:00','2018-04-23 17:10:00','success',NULL,'cron',NULL),(1706,28,452,'2018-04-23 17:15:00','2018-04-23 17:15:00','success',NULL,'cron',NULL),(1707,23,452,'2018-04-23 17:15:00','2018-04-23 17:15:00','success',NULL,'cron',NULL),(1708,27,677,'2018-04-23 17:20:00','2018-04-23 17:20:00','success',NULL,'cron',NULL),(1709,27,678,'2018-04-23 17:30:00','2018-04-23 17:30:00','success',NULL,'cron',NULL),(1710,23,453,'2018-04-23 17:30:00','2018-04-23 17:30:00','success',NULL,'cron',NULL),(1711,28,453,'2018-04-23 17:30:00','2018-04-23 17:30:00','success',NULL,'cron',NULL),(1712,27,679,'2018-04-23 17:40:00','2018-04-23 17:40:00','success',NULL,'cron',NULL),(1713,28,454,'2018-04-23 17:45:00','2018-04-23 17:45:00','success',NULL,'cron',NULL),(1714,23,454,'2018-04-23 17:45:00','2018-04-23 17:45:00','success',NULL,'cron',NULL),(1715,27,680,'2018-04-23 17:50:00','2018-04-23 17:50:00','success',NULL,'cron',NULL),(1716,28,455,'2018-04-23 18:00:00','2018-04-23 18:00:00','success',NULL,'cron',NULL),(1717,27,681,'2018-04-23 18:00:00','2018-04-23 18:00:00','success',NULL,'cron',NULL),(1718,23,455,'2018-04-23 18:00:00','2018-04-23 18:00:00','success',NULL,'cron',NULL),(1719,27,682,'2018-04-23 18:10:00','2018-04-23 18:10:00','success',NULL,'cron',NULL),(1720,28,456,'2018-04-23 18:15:00','2018-04-23 18:15:00','success',NULL,'cron',NULL),(1721,23,456,'2018-04-23 18:15:00','2018-04-23 18:15:00','success',NULL,'cron',NULL),(1722,27,683,'2018-04-23 18:20:00','2018-04-23 18:20:00','success',NULL,'cron',NULL),(1723,28,457,'2018-04-23 18:30:00','2018-04-23 18:30:00','success',NULL,'cron',NULL),(1724,27,684,'2018-04-23 18:30:00','2018-04-23 18:30:00','success',NULL,'cron',NULL),(1725,23,457,'2018-04-23 18:30:00','2018-04-23 18:30:00','success',NULL,'cron',NULL),(1726,27,685,'2018-04-23 18:40:00','2018-04-23 18:40:00','success',NULL,'cron',NULL),(1727,23,458,'2018-04-23 18:45:00','2018-04-23 18:45:00','success',NULL,'cron',NULL),(1728,28,458,'2018-04-23 18:45:00','2018-04-23 18:45:00','success',NULL,'cron',NULL),(1729,27,686,'2018-04-23 18:50:00','2018-04-23 18:50:00','success',NULL,'cron',NULL),(1730,28,459,'2018-04-23 19:00:00','2018-04-23 19:00:00','success',NULL,'cron',NULL),(1731,27,687,'2018-04-23 19:00:00','2018-04-23 19:00:00','success',NULL,'cron',NULL),(1732,23,459,'2018-04-23 19:00:00','2018-04-23 19:00:00','success',NULL,'cron',NULL),(1733,27,688,'2018-04-23 19:10:00','2018-04-23 19:10:00','success',NULL,'cron',NULL),(1734,28,460,'2018-04-23 19:15:00','2018-04-23 19:15:00','success',NULL,'cron',NULL),(1735,23,460,'2018-04-23 19:15:00','2018-04-23 19:15:00','success',NULL,'cron',NULL),(1736,27,689,'2018-04-23 19:20:00','2018-04-23 19:20:00','success',NULL,'cron',NULL),(1737,28,461,'2018-04-23 19:30:00','2018-04-23 19:30:00','success',NULL,'cron',NULL),(1738,23,461,'2018-04-23 19:30:00','2018-04-23 19:30:00','success',NULL,'cron',NULL),(1739,27,690,'2018-04-23 19:30:00','2018-04-23 19:30:00','success',NULL,'cron',NULL),(1740,27,691,'2018-04-23 19:40:00','2018-04-23 19:40:00','success',NULL,'cron',NULL),(1741,28,462,'2018-04-23 19:45:00','2018-04-23 19:45:00','success',NULL,'cron',NULL),(1742,23,462,'2018-04-23 19:45:00','2018-04-23 19:45:00','success',NULL,'cron',NULL),(1743,27,692,'2018-04-23 19:50:00','2018-04-23 19:50:00','success',NULL,'cron',NULL),(1744,28,463,'2018-04-23 20:00:00','2018-04-23 20:00:00','success',NULL,'cron',NULL),(1745,27,693,'2018-04-23 20:00:00','2018-04-23 20:00:00','success',NULL,'cron',NULL),(1746,23,463,'2018-04-23 20:00:00','2018-04-23 20:00:00','success',NULL,'cron',NULL),(1747,27,694,'2018-04-23 20:10:00','2018-04-23 20:10:00','success',NULL,'cron',NULL),(1748,28,464,'2018-04-23 20:15:00','2018-04-23 20:15:00','success',NULL,'cron',NULL),(1749,23,464,'2018-04-23 20:15:00','2018-04-23 20:15:00','success',NULL,'cron',NULL),(1750,27,695,'2018-04-23 20:20:00','2018-04-23 20:20:00','success',NULL,'cron',NULL),(1751,28,465,'2018-04-23 20:30:00','2018-04-23 20:30:00','success',NULL,'cron',NULL),(1752,23,465,'2018-04-23 20:30:00','2018-04-23 20:30:00','success',NULL,'cron',NULL),(1753,27,696,'2018-04-23 20:30:00','2018-04-23 20:30:00','success',NULL,'cron',NULL),(1754,27,697,'2018-04-23 20:40:00','2018-04-23 20:40:00','success',NULL,'cron',NULL),(1755,28,466,'2018-04-23 20:45:00','2018-04-23 20:45:00','success',NULL,'cron',NULL),(1756,23,466,'2018-04-23 20:45:00','2018-04-23 20:45:00','success',NULL,'cron',NULL),(1757,27,698,'2018-04-23 20:50:00','2018-04-23 20:50:00','success',NULL,'cron',NULL),(1758,28,467,'2018-04-23 21:00:00','2018-04-23 21:00:00','success',NULL,'cron',NULL),(1759,1,6,'2018-04-23 21:00:00','2018-04-23 21:00:00','success',NULL,'cron',NULL),(1760,27,699,'2018-04-23 21:00:00','2018-04-23 21:00:00','success',NULL,'cron',NULL),(1761,23,467,'2018-04-23 21:00:00','2018-04-23 21:00:00','success',NULL,'cron',NULL),(1762,27,700,'2018-04-23 21:10:00','2018-04-23 21:10:00','success',NULL,'cron',NULL),(1763,28,468,'2018-04-23 21:15:00','2018-04-23 21:15:00','success',NULL,'cron',NULL),(1764,23,468,'2018-04-23 21:15:00','2018-04-23 21:15:00','success',NULL,'cron',NULL),(1765,4,6,'2018-04-23 21:20:00','2018-04-23 21:20:00','success',NULL,'cron',NULL),(1766,27,701,'2018-04-23 21:20:00','2018-04-23 21:20:00','success',NULL,'cron',NULL),(1767,23,469,'2018-04-23 21:30:00','2018-04-23 21:30:00','success',NULL,'cron',NULL),(1768,27,702,'2018-04-23 21:30:00','2018-04-23 21:30:00','success',NULL,'cron',NULL),(1769,28,469,'2018-04-23 21:30:00','2018-04-23 21:30:00','success',NULL,'cron',NULL),(1770,27,703,'2018-04-23 21:40:00','2018-04-23 21:40:00','success',NULL,'cron',NULL),(1771,28,470,'2018-04-23 21:45:00','2018-04-23 21:45:00','success',NULL,'cron',NULL),(1772,23,470,'2018-04-23 21:45:00','2018-04-23 21:45:00','success',NULL,'cron',NULL),(1773,27,704,'2018-04-23 21:50:00','2018-04-23 21:50:00','success',NULL,'cron',NULL),(1774,27,705,'2018-04-23 22:00:00','2018-04-23 22:00:00','success',NULL,'cron',NULL),(1775,28,471,'2018-04-23 22:00:00','2018-04-23 22:00:00','success',NULL,'cron',NULL),(1776,23,471,'2018-04-23 22:00:00','2018-04-23 22:00:00','success',NULL,'cron',NULL),(1777,27,706,'2018-04-23 22:10:00','2018-04-23 22:10:00','success',NULL,'cron',NULL),(1778,28,472,'2018-04-23 22:15:00','2018-04-23 22:15:00','success',NULL,'cron',NULL),(1779,23,472,'2018-04-23 22:15:00','2018-04-23 22:15:00','success',NULL,'cron',NULL),(1780,27,707,'2018-04-23 22:20:00','2018-04-23 22:20:00','success',NULL,'cron',NULL),(1781,27,708,'2018-04-23 22:30:00','2018-04-23 22:30:00','success',NULL,'cron',NULL),(1782,23,473,'2018-04-23 22:30:00','2018-04-23 22:30:00','success',NULL,'cron',NULL),(1783,28,473,'2018-04-23 22:30:00','2018-04-23 22:30:00','success',NULL,'cron',NULL),(1784,27,709,'2018-04-23 22:40:00','2018-04-23 22:40:00','success',NULL,'cron',NULL),(1785,28,474,'2018-04-23 22:45:00','2018-04-23 22:45:00','success',NULL,'cron',NULL),(1786,23,474,'2018-04-23 22:45:00','2018-04-23 22:45:00','success',NULL,'cron',NULL),(1787,27,710,'2018-04-23 22:50:00','2018-04-23 22:50:00','success',NULL,'cron',NULL),(1788,27,711,'2018-04-23 23:00:00','2018-04-23 23:00:00','success',NULL,'cron',NULL),(1789,20,6,'2018-04-23 23:00:00','2018-04-23 23:00:00','success',NULL,'cron',NULL),(1790,12,6,'2018-04-23 23:00:00','2018-04-23 23:00:00','success',NULL,'cron',NULL),(1791,13,6,'2018-04-23 23:00:00','2018-04-23 23:00:00','success',NULL,'cron',NULL),(1792,19,6,'2018-04-23 23:00:00','2018-04-23 23:00:00','success',NULL,'cron',NULL),(1793,10,6,'2018-04-23 23:00:00','2018-04-23 23:00:00','success',NULL,'cron',NULL),(1794,15,6,'2018-04-23 23:00:00','2018-04-23 23:00:00','success',NULL,'cron',NULL),(1795,23,475,'2018-04-23 23:00:00','2018-04-23 23:00:00','success',NULL,'cron',NULL),(1796,28,475,'2018-04-23 23:00:00','2018-04-23 23:00:00','success',NULL,'cron',NULL),(1797,6,6,'2018-04-23 23:00:00','2018-04-23 23:00:00','success',NULL,'cron',NULL),(1798,21,6,'2018-04-23 23:00:00','2018-04-23 23:00:00','success',NULL,'cron',NULL),(1799,9,6,'2018-04-23 23:01:00','2018-04-23 23:01:00','success',NULL,'cron',NULL),(1800,22,6,'2018-04-23 23:01:00','2018-04-23 23:01:00','success',NULL,'cron',NULL),(1801,7,6,'2018-04-23 23:01:00','2018-04-23 23:01:00','success',NULL,'cron',NULL),(1802,2,6,'2018-04-23 23:01:00','2018-04-23 23:01:00','success',NULL,'cron',NULL),(1803,17,6,'2018-04-23 23:01:00','2018-04-23 23:01:00','success',NULL,'cron',NULL),(1804,11,6,'2018-04-23 23:01:00','2018-04-23 23:01:00','success',NULL,'cron',NULL),(1805,14,6,'2018-04-23 23:02:00','2018-04-23 23:02:00','success',NULL,'cron',NULL),(1806,16,6,'2018-04-23 23:02:00','2018-04-23 23:02:00','success',NULL,'cron',NULL),(1807,18,6,'2018-04-23 23:05:00','2018-04-23 23:05:00','success',NULL,'cron',NULL),(1808,3,6,'2018-04-23 23:05:00','2018-04-23 23:05:00','success',NULL,'cron',NULL),(1809,27,712,'2018-04-23 23:10:00','2018-04-23 23:10:00','success',NULL,'cron',NULL),(1810,28,476,'2018-04-23 23:15:00','2018-04-23 23:15:00','success',NULL,'cron',NULL),(1811,23,476,'2018-04-23 23:15:00','2018-04-23 23:15:00','success',NULL,'cron',NULL),(1812,27,713,'2018-04-23 23:20:00','2018-04-23 23:20:00','success',NULL,'cron',NULL),(1813,28,477,'2018-04-23 23:30:00','2018-04-23 23:30:00','success',NULL,'cron',NULL),(1814,23,477,'2018-04-23 23:30:00','2018-04-23 23:30:00','success',NULL,'cron',NULL),(1815,27,714,'2018-04-23 23:30:00','2018-04-23 23:30:00','success',NULL,'cron',NULL),(1816,27,715,'2018-04-23 23:40:00','2018-04-23 23:40:00','success',NULL,'cron',NULL),(1817,23,478,'2018-04-23 23:45:00','2018-04-23 23:45:00','success',NULL,'cron',NULL),(1818,28,478,'2018-04-23 23:45:00','2018-04-23 23:45:00','success',NULL,'cron',NULL),(1819,27,716,'2018-04-23 23:50:00','2018-04-23 23:50:00','success',NULL,'cron',NULL),(1820,27,717,'2018-04-24 00:00:00','2018-04-24 00:00:00','success',NULL,'cron',NULL),(1821,23,479,'2018-04-24 00:00:00','2018-04-24 00:00:00','success',NULL,'cron',NULL),(1822,28,479,'2018-04-24 00:00:00','2018-04-24 00:00:00','success',NULL,'cron',NULL),(1823,27,718,'2018-04-24 00:10:00','2018-04-24 00:10:00','success',NULL,'cron',NULL),(1824,28,480,'2018-04-24 00:15:00','2018-04-24 00:15:00','success',NULL,'cron',NULL),(1825,23,480,'2018-04-24 00:15:00','2018-04-24 00:15:00','success',NULL,'cron',NULL),(1826,27,719,'2018-04-24 00:20:00','2018-04-24 00:20:00','success',NULL,'cron',NULL),(1827,23,481,'2018-04-24 00:30:00','2018-04-24 00:30:00','success',NULL,'cron',NULL),(1828,27,720,'2018-04-24 00:30:00','2018-04-24 00:30:00','success',NULL,'cron',NULL),(1829,28,481,'2018-04-24 00:30:00','2018-04-24 00:30:00','success',NULL,'cron',NULL),(1830,27,721,'2018-04-24 00:40:00','2018-04-24 00:40:00','success',NULL,'cron',NULL),(1831,28,482,'2018-04-24 00:45:00','2018-04-24 00:45:00','success',NULL,'cron',NULL),(1832,23,482,'2018-04-24 00:45:00','2018-04-24 00:45:00','success',NULL,'cron',NULL),(1833,27,722,'2018-04-24 00:50:00','2018-04-24 00:50:00','success',NULL,'cron',NULL),(1834,28,483,'2018-04-24 01:00:00','2018-04-24 01:00:00','success',NULL,'cron',NULL),(1835,23,483,'2018-04-24 01:00:00','2018-04-24 01:00:00','success',NULL,'cron',NULL),(1836,27,723,'2018-04-24 01:00:00','2018-04-24 01:00:00','success',NULL,'cron',NULL),(1837,27,724,'2018-04-24 01:10:00','2018-04-24 01:10:00','success',NULL,'cron',NULL),(1838,23,484,'2018-04-24 01:15:00','2018-04-24 01:15:00','success',NULL,'cron',NULL),(1839,28,484,'2018-04-24 01:15:00','2018-04-24 01:15:00','success',NULL,'cron',NULL),(1840,27,725,'2018-04-24 01:20:00','2018-04-24 01:20:00','success',NULL,'cron',NULL),(1841,27,726,'2018-04-24 01:30:00','2018-04-24 01:30:00','success',NULL,'cron',NULL),(1842,28,485,'2018-04-24 01:30:00','2018-04-24 01:30:00','success',NULL,'cron',NULL),(1843,23,485,'2018-04-24 01:30:00','2018-04-24 01:30:00','success',NULL,'cron',NULL),(1844,27,727,'2018-04-24 01:40:00','2018-04-24 01:40:00','success',NULL,'cron',NULL),(1845,23,486,'2018-04-24 01:45:00','2018-04-24 01:45:00','success',NULL,'cron',NULL),(1846,28,486,'2018-04-24 01:45:00','2018-04-24 01:45:00','success',NULL,'cron',NULL),(1847,27,728,'2018-04-24 01:50:00','2018-04-24 01:50:00','success',NULL,'cron',NULL),(1848,23,487,'2018-04-24 02:00:00','2018-04-24 02:00:00','success',NULL,'cron',NULL),(1849,28,487,'2018-04-24 02:00:00','2018-04-24 02:00:00','success',NULL,'cron',NULL),(1850,27,729,'2018-04-24 02:00:00','2018-04-24 02:00:00','success',NULL,'cron',NULL),(1851,27,730,'2018-04-24 02:10:00','2018-04-24 02:10:00','success',NULL,'cron',NULL),(1852,28,488,'2018-04-24 02:15:00','2018-04-24 02:15:00','success',NULL,'cron',NULL),(1853,23,488,'2018-04-24 02:15:00','2018-04-24 02:15:00','success',NULL,'cron',NULL),(1854,27,731,'2018-04-24 02:20:00','2018-04-24 02:20:00','success',NULL,'cron',NULL),(1855,27,732,'2018-04-24 02:30:00','2018-04-24 02:30:00','success',NULL,'cron',NULL),(1856,23,489,'2018-04-24 02:30:00','2018-04-24 02:30:00','success',NULL,'cron',NULL),(1857,28,489,'2018-04-24 02:30:00','2018-04-24 02:30:00','success',NULL,'cron',NULL),(1858,27,733,'2018-04-24 02:40:00','2018-04-24 02:40:00','success',NULL,'cron',NULL),(1859,28,490,'2018-04-24 02:45:00','2018-04-24 02:45:00','success',NULL,'cron',NULL),(1860,23,490,'2018-04-24 02:45:00','2018-04-24 02:45:00','success',NULL,'cron',NULL),(1861,27,734,'2018-04-24 02:50:00','2018-04-24 02:50:00','success',NULL,'cron',NULL),(1862,27,735,'2018-04-24 03:00:00','2018-04-24 03:00:00','success',NULL,'cron',NULL),(1863,28,491,'2018-04-24 03:00:00','2018-04-24 03:00:00','success',NULL,'cron',NULL),(1864,23,491,'2018-04-24 03:00:00','2018-04-24 03:00:00','success',NULL,'cron',NULL),(1865,27,736,'2018-04-24 03:10:00','2018-04-24 03:10:00','success',NULL,'cron',NULL),(1866,28,492,'2018-04-24 03:15:00','2018-04-24 03:15:00','success',NULL,'cron',NULL),(1867,23,492,'2018-04-24 03:15:00','2018-04-24 03:15:00','success',NULL,'cron',NULL),(1868,27,737,'2018-04-24 03:20:00','2018-04-24 03:20:00','success',NULL,'cron',NULL),(1869,27,738,'2018-04-24 03:30:00','2018-04-24 03:30:00','success',NULL,'cron',NULL),(1870,28,493,'2018-04-24 03:30:00','2018-04-24 03:30:00','success',NULL,'cron',NULL),(1871,23,493,'2018-04-24 03:30:00','2018-04-24 03:30:00','success',NULL,'cron',NULL),(1872,27,739,'2018-04-24 03:40:00','2018-04-24 03:40:00','success',NULL,'cron',NULL),(1873,23,494,'2018-04-24 03:45:00','2018-04-24 03:45:00','success',NULL,'cron',NULL),(1874,28,494,'2018-04-24 03:45:00','2018-04-24 03:45:00','success',NULL,'cron',NULL),(1875,27,740,'2018-04-24 03:50:00','2018-04-24 03:50:00','success',NULL,'cron',NULL),(1876,27,741,'2018-04-24 04:00:00','2018-04-24 04:00:00','success',NULL,'cron',NULL),(1877,28,495,'2018-04-24 04:00:00','2018-04-24 04:00:00','success',NULL,'cron',NULL),(1878,23,495,'2018-04-24 04:00:00','2018-04-24 04:00:00','success',NULL,'cron',NULL),(1879,24,5,'2018-04-24 04:00:00','2018-04-24 04:00:00','success',NULL,'cron',NULL),(1880,25,5,'2018-04-24 04:00:00','2018-04-24 04:00:00','success',NULL,'cron',NULL),(1881,26,5,'2018-04-24 04:00:00','2018-04-24 04:00:00','success',NULL,'cron',NULL),(1882,27,742,'2018-04-24 04:10:00','2018-04-24 04:10:00','success',NULL,'cron',NULL),(1883,23,496,'2018-04-24 04:15:00','2018-04-24 04:15:00','success',NULL,'cron',NULL),(1884,28,496,'2018-04-24 04:15:00','2018-04-24 04:15:00','success',NULL,'cron',NULL),(1885,27,743,'2018-04-24 04:20:00','2018-04-24 04:20:00','success',NULL,'cron',NULL),(1886,27,744,'2018-04-24 04:30:00','2018-04-24 04:30:00','success',NULL,'cron',NULL),(1887,28,497,'2018-04-24 04:30:00','2018-04-24 04:30:00','success',NULL,'cron',NULL),(1888,23,497,'2018-04-24 04:30:00','2018-04-24 04:30:00','success',NULL,'cron',NULL),(1889,27,745,'2018-04-24 04:40:00','2018-04-24 04:40:00','success',NULL,'cron',NULL),(1890,28,498,'2018-04-24 04:45:00','2018-04-24 04:45:00','success',NULL,'cron',NULL),(1891,23,498,'2018-04-24 04:45:00','2018-04-24 04:45:00','success',NULL,'cron',NULL),(1892,27,746,'2018-04-24 04:50:00','2018-04-24 04:50:00','success',NULL,'cron',NULL),(1893,27,747,'2018-04-24 05:00:00','2018-04-24 05:00:00','success',NULL,'cron',NULL),(1894,23,499,'2018-04-24 05:00:00','2018-04-24 05:00:00','success',NULL,'cron',NULL),(1895,28,499,'2018-04-24 05:00:00','2018-04-24 05:00:00','success',NULL,'cron',NULL),(1896,27,748,'2018-04-24 05:10:00','2018-04-24 05:10:00','success',NULL,'cron',NULL),(1897,28,500,'2018-04-24 05:15:00','2018-04-24 05:15:00','success',NULL,'cron',NULL),(1898,23,500,'2018-04-24 05:15:00','2018-04-24 05:15:00','success',NULL,'cron',NULL),(1899,27,749,'2018-04-24 05:20:00','2018-04-24 05:20:00','success',NULL,'cron',NULL),(1900,27,750,'2018-04-24 05:30:00','2018-04-24 05:30:00','success',NULL,'cron',NULL),(1901,23,501,'2018-04-24 05:30:00','2018-04-24 05:30:00','success',NULL,'cron',NULL),(1902,28,501,'2018-04-24 05:30:00','2018-04-24 05:30:00','success',NULL,'cron',NULL),(1903,27,751,'2018-04-24 05:40:00','2018-04-24 05:40:00','success',NULL,'cron',NULL),(1904,28,502,'2018-04-24 05:45:00','2018-04-24 05:45:00','success',NULL,'cron',NULL),(1905,23,502,'2018-04-24 05:45:00','2018-04-24 05:45:00','success',NULL,'cron',NULL),(1906,27,752,'2018-04-24 05:50:00','2018-04-24 05:50:00','success',NULL,'cron',NULL),(1907,27,753,'2018-04-24 06:00:00','2018-04-24 06:00:00','success',NULL,'cron',NULL),(1908,28,503,'2018-04-24 06:00:00','2018-04-24 06:00:00','success',NULL,'cron',NULL),(1909,23,503,'2018-04-24 06:00:00','2018-04-24 06:00:00','success',NULL,'cron',NULL),(1910,27,754,'2018-04-24 06:10:00','2018-04-24 06:10:00','success',NULL,'cron',NULL),(1911,28,504,'2018-04-24 06:15:00','2018-04-24 06:15:00','success',NULL,'cron',NULL),(1912,23,504,'2018-04-24 06:15:00','2018-04-24 06:15:00','success',NULL,'cron',NULL),(1913,27,755,'2018-04-24 06:20:00','2018-04-24 06:20:00','success',NULL,'cron',NULL),(1914,23,505,'2018-04-24 06:30:00','2018-04-24 06:30:00','success',NULL,'cron',NULL),(1915,28,505,'2018-04-24 06:30:00','2018-04-24 06:30:00','success',NULL,'cron',NULL),(1916,27,756,'2018-04-24 06:30:00','2018-04-24 06:30:00','success',NULL,'cron',NULL),(1917,27,757,'2018-04-24 06:40:00','2018-04-24 06:40:00','success',NULL,'cron',NULL),(1918,23,506,'2018-04-24 06:45:00','2018-04-24 06:45:00','success',NULL,'cron',NULL),(1919,28,506,'2018-04-24 06:45:00','2018-04-24 06:45:00','success',NULL,'cron',NULL),(1920,27,758,'2018-04-24 06:50:00','2018-04-24 06:50:00','success',NULL,'cron',NULL),(1921,27,759,'2018-04-24 07:00:00','2018-04-24 07:00:00','success',NULL,'cron',NULL),(1922,28,507,'2018-04-24 07:00:00','2018-04-24 07:00:00','success',NULL,'cron',NULL),(1923,23,507,'2018-04-24 07:00:00','2018-04-24 07:00:00','success',NULL,'cron',NULL),(1924,27,760,'2018-04-24 07:10:00','2018-04-24 07:10:00','success',NULL,'cron',NULL),(1925,23,508,'2018-04-24 07:15:00','2018-04-24 07:15:00','success',NULL,'cron',NULL),(1926,28,508,'2018-04-24 07:15:00','2018-04-24 07:15:00','success',NULL,'cron',NULL),(1927,27,761,'2018-04-24 07:20:00','2018-04-24 07:20:00','success',NULL,'cron',NULL),(1928,28,509,'2018-04-24 07:30:00','2018-04-24 07:30:00','success',NULL,'cron',NULL),(1929,23,509,'2018-04-24 07:30:00','2018-04-24 07:30:00','success',NULL,'cron',NULL),(1930,27,762,'2018-04-24 07:30:00','2018-04-24 07:30:00','success',NULL,'cron',NULL),(1931,27,763,'2018-04-24 07:40:00','2018-04-24 07:40:00','success',NULL,'cron',NULL),(1932,28,510,'2018-04-24 07:45:00','2018-04-24 07:45:00','success',NULL,'cron',NULL),(1933,23,510,'2018-04-24 07:45:00','2018-04-24 07:45:00','success',NULL,'cron',NULL),(1934,27,764,'2018-04-24 07:50:00','2018-04-24 07:50:00','success',NULL,'cron',NULL),(1935,27,765,'2018-04-24 08:00:00','2018-04-24 08:00:00','success',NULL,'cron',NULL),(1936,28,511,'2018-04-24 08:00:00','2018-04-24 08:00:00','success',NULL,'cron',NULL),(1937,23,511,'2018-04-24 08:00:00','2018-04-24 08:00:00','success',NULL,'cron',NULL),(1938,27,766,'2018-04-24 08:10:00','2018-04-24 08:10:00','success',NULL,'cron',NULL),(1939,23,512,'2018-04-24 08:15:00','2018-04-24 08:15:00','success',NULL,'cron',NULL),(1940,28,512,'2018-04-24 08:15:00','2018-04-24 08:15:00','success',NULL,'cron',NULL),(1941,27,767,'2018-04-24 08:20:00','2018-04-24 08:20:00','success',NULL,'cron',NULL),(1942,23,513,'2018-04-24 08:30:00','2018-04-24 08:30:00','success',NULL,'cron',NULL),(1943,28,513,'2018-04-24 08:30:00','2018-04-24 08:30:00','success',NULL,'cron',NULL),(1944,27,768,'2018-04-24 08:30:00','2018-04-24 08:30:00','success',NULL,'cron',NULL),(1945,27,769,'2018-04-24 08:40:00','2018-04-24 08:40:00','success',NULL,'cron',NULL),(1946,28,514,'2018-04-24 08:45:00','2018-04-24 08:45:00','success',NULL,'cron',NULL),(1947,23,514,'2018-04-24 08:45:00','2018-04-24 08:45:00','success',NULL,'cron',NULL),(1948,27,770,'2018-04-24 08:50:00','2018-04-24 08:50:00','success',NULL,'cron',NULL),(1949,28,515,'2018-04-24 09:00:00','2018-04-24 09:00:00','success',NULL,'cron',NULL),(1950,27,771,'2018-04-24 09:00:00','2018-04-24 09:00:00','success',NULL,'cron',NULL),(1951,23,515,'2018-04-24 09:00:00','2018-04-24 09:00:00','success',NULL,'cron',NULL),(1952,27,772,'2018-04-24 09:10:00','2018-04-24 09:10:00','success',NULL,'cron',NULL),(1953,28,516,'2018-04-24 09:15:00','2018-04-24 09:15:00','success',NULL,'cron',NULL),(1954,23,516,'2018-04-24 09:15:00','2018-04-24 09:15:00','success',NULL,'cron',NULL),(1955,27,773,'2018-04-24 09:20:00','2018-04-24 09:20:00','success',NULL,'cron',NULL),(1956,27,774,'2018-04-24 09:30:00','2018-04-24 09:30:00','success',NULL,'cron',NULL),(1957,28,517,'2018-04-24 09:30:00','2018-04-24 09:30:00','success',NULL,'cron',NULL),(1958,23,517,'2018-04-24 09:30:00','2018-04-24 09:30:00','success',NULL,'cron',NULL),(1959,27,775,'2018-04-24 09:40:00','2018-04-24 09:40:00','success',NULL,'cron',NULL),(1960,23,518,'2018-04-24 09:45:00','2018-04-24 09:45:00','success',NULL,'cron',NULL),(1961,28,518,'2018-04-24 09:45:00','2018-04-24 09:45:00','success',NULL,'cron',NULL),(1962,27,776,'2018-04-24 09:50:00','2018-04-24 09:50:00','success',NULL,'cron',NULL),(1963,23,519,'2018-04-24 10:00:00','2018-04-24 10:00:00','success',NULL,'cron',NULL),(1964,27,777,'2018-04-24 10:00:00','2018-04-24 10:00:00','success',NULL,'cron',NULL),(1965,28,519,'2018-04-24 10:00:00','2018-04-24 10:00:00','success',NULL,'cron',NULL),(1966,27,778,'2018-04-24 10:10:00','2018-04-24 10:10:00','success',NULL,'cron',NULL),(1967,23,520,'2018-04-24 10:15:00','2018-04-24 10:15:00','success',NULL,'cron',NULL),(1968,28,520,'2018-04-24 10:15:00','2018-04-24 10:15:00','success',NULL,'cron',NULL),(1969,27,779,'2018-04-24 10:20:00','2018-04-24 10:20:00','success',NULL,'cron',NULL),(1970,27,780,'2018-04-24 10:30:00','2018-04-24 10:30:00','success',NULL,'cron',NULL),(1971,28,521,'2018-04-24 10:30:00','2018-04-24 10:30:00','success',NULL,'cron',NULL),(1972,23,521,'2018-04-24 10:30:00','2018-04-24 10:30:00','success',NULL,'cron',NULL),(1973,27,781,'2018-04-24 10:40:00','2018-04-24 10:40:00','success',NULL,'cron',NULL),(1974,28,522,'2018-04-24 10:45:00','2018-04-24 10:45:00','success',NULL,'cron',NULL),(1975,23,522,'2018-04-24 10:45:00','2018-04-24 10:45:00','success',NULL,'cron',NULL),(1976,27,782,'2018-04-24 10:50:00','2018-04-24 10:50:00','success',NULL,'cron',NULL),(1977,5,6,'2018-04-24 11:00:00','2018-04-24 11:00:00','success',NULL,'cron',NULL),(1978,8,6,'2018-04-24 11:00:00','2018-04-24 11:00:00','success',NULL,'cron',NULL),(1979,27,783,'2018-04-24 11:00:00','2018-04-24 11:00:00','success',NULL,'cron',NULL),(1980,29,6,'2018-04-24 11:00:00','2018-04-24 11:00:00','success',NULL,'cron',NULL),(1981,28,523,'2018-04-24 11:00:00','2018-04-24 11:00:00','success',NULL,'cron',NULL),(1982,23,523,'2018-04-24 11:00:00','2018-04-24 11:00:00','success',NULL,'cron',NULL),(1983,27,784,'2018-04-24 11:10:00','2018-04-24 11:10:00','success',NULL,'cron',NULL),(1984,28,524,'2018-04-24 11:15:00','2018-04-24 11:15:00','success',NULL,'cron',NULL),(1985,23,524,'2018-04-24 11:15:00','2018-04-24 11:15:00','success',NULL,'cron',NULL),(1986,27,785,'2018-04-24 11:20:00','2018-04-24 11:20:00','success',NULL,'cron',NULL),(1987,28,525,'2018-04-24 11:30:00','2018-04-24 11:30:00','success',NULL,'cron',NULL),(1988,23,525,'2018-04-24 11:30:00','2018-04-24 11:30:00','success',NULL,'cron',NULL),(1989,27,786,'2018-04-24 11:30:00','2018-04-24 11:30:00','success',NULL,'cron',NULL),(1990,27,787,'2018-04-24 11:40:00','2018-04-24 11:40:00','success',NULL,'cron',NULL),(1991,23,526,'2018-04-24 11:45:00','2018-04-24 11:45:00','success',NULL,'cron',NULL),(1992,28,526,'2018-04-24 11:45:00','2018-04-24 11:45:00','success',NULL,'cron',NULL),(1993,27,788,'2018-04-24 11:50:00','2018-04-24 11:50:00','success',NULL,'cron',NULL),(1994,23,527,'2018-04-24 12:00:00','2018-04-24 12:00:00','success',NULL,'cron',NULL),(1995,27,789,'2018-04-24 12:00:00','2018-04-24 12:00:00','success',NULL,'cron',NULL),(1996,28,527,'2018-04-24 12:00:00','2018-04-24 12:00:00','success',NULL,'cron',NULL),(1997,27,790,'2018-04-24 12:10:00','2018-04-24 12:10:00','success',NULL,'cron',NULL),(1998,28,528,'2018-04-24 12:15:00','2018-04-24 12:15:00','success',NULL,'cron',NULL),(1999,23,528,'2018-04-24 12:15:00','2018-04-24 12:15:00','success',NULL,'cron',NULL),(2000,27,791,'2018-04-24 12:20:00','2018-04-24 12:20:00','success',NULL,'cron',NULL),(2001,28,529,'2018-04-24 12:30:00','2018-04-24 12:30:00','success',NULL,'cron',NULL),(2002,27,792,'2018-04-24 12:30:00','2018-04-24 12:30:00','success',NULL,'cron',NULL),(2003,23,529,'2018-04-24 12:30:00','2018-04-24 12:30:00','success',NULL,'cron',NULL),(2004,27,793,'2018-04-24 12:40:00','2018-04-24 12:40:00','success',NULL,'cron',NULL),(2005,23,530,'2018-04-24 12:45:00','2018-04-24 12:45:00','success',NULL,'cron',NULL),(2006,28,530,'2018-04-24 12:45:00','2018-04-24 12:45:00','success',NULL,'cron',NULL),(2007,27,794,'2018-04-24 12:50:00','2018-04-24 12:50:00','success',NULL,'cron',NULL),(2008,28,531,'2018-04-24 13:00:00','2018-04-24 13:00:00','success',NULL,'cron',NULL),(2009,27,795,'2018-04-24 13:00:00','2018-04-24 13:00:00','success',NULL,'cron',NULL),(2010,23,531,'2018-04-24 13:00:00','2018-04-24 13:00:00','success',NULL,'cron',NULL),(2011,27,796,'2018-04-24 13:10:00','2018-04-24 13:10:00','success',NULL,'cron',NULL),(2012,28,532,'2018-04-24 13:15:00','2018-04-24 13:15:00','success',NULL,'cron',NULL),(2013,23,532,'2018-04-24 13:15:00','2018-04-24 13:15:00','success',NULL,'cron',NULL),(2014,27,797,'2018-04-24 13:20:00','2018-04-24 13:20:00','success',NULL,'cron',NULL),(2015,27,798,'2018-04-24 13:30:00','2018-04-24 13:30:00','success',NULL,'cron',NULL),(2016,28,533,'2018-04-24 13:30:00','2018-04-24 13:30:00','success',NULL,'cron',NULL),(2017,23,533,'2018-04-24 13:30:00','2018-04-24 13:30:00','success',NULL,'cron',NULL),(2018,27,799,'2018-04-24 13:40:00','2018-04-24 13:40:00','success',NULL,'cron',NULL),(2019,28,534,'2018-04-24 13:45:00','2018-04-24 13:45:00','success',NULL,'cron',NULL),(2020,23,534,'2018-04-24 13:45:00','2018-04-24 13:45:00','success',NULL,'cron',NULL),(2021,27,800,'2018-04-24 13:50:00','2018-04-24 13:50:00','success',NULL,'cron',NULL),(2022,23,535,'2018-04-24 14:00:00','2018-04-24 14:00:00','success',NULL,'cron',NULL),(2023,28,535,'2018-04-24 14:00:00','2018-04-24 14:00:00','success',NULL,'cron',NULL),(2024,27,801,'2018-04-24 14:00:00','2018-04-24 14:00:00','success',NULL,'cron',NULL),(2025,27,802,'2018-04-24 14:10:00','2018-04-24 14:10:00','success',NULL,'cron',NULL),(2026,28,536,'2018-04-24 14:15:00','2018-04-24 14:15:00','success',NULL,'cron',NULL),(2027,23,536,'2018-04-24 14:15:00','2018-04-24 14:15:00','success',NULL,'cron',NULL),(2028,27,803,'2018-04-24 14:20:00','2018-04-24 14:20:00','success',NULL,'cron',NULL),(2029,27,804,'2018-04-24 14:30:00','2018-04-24 14:30:00','success',NULL,'cron',NULL),(2030,28,537,'2018-04-24 14:30:00','2018-04-24 14:30:00','success',NULL,'cron',NULL),(2031,23,537,'2018-04-24 14:30:00','2018-04-24 14:30:00','success',NULL,'cron',NULL),(2032,27,805,'2018-04-24 14:40:00','2018-04-24 14:40:00','success',NULL,'cron',NULL),(2033,28,538,'2018-04-24 14:45:00','2018-04-24 14:45:00','success',NULL,'cron',NULL),(2034,23,538,'2018-04-24 14:45:00','2018-04-24 14:45:00','success',NULL,'cron',NULL),(2035,27,806,'2018-04-24 14:50:00','2018-04-24 14:50:00','success',NULL,'cron',NULL),(2036,28,539,'2018-04-24 15:00:00','2018-04-24 15:00:00','success',NULL,'cron',NULL),(2037,23,539,'2018-04-24 15:00:00','2018-04-24 15:00:00','success',NULL,'cron',NULL),(2038,27,807,'2018-04-24 15:00:00','2018-04-24 15:00:00','success',NULL,'cron',NULL),(2039,27,808,'2018-04-24 15:10:00','2018-04-24 15:10:00','success',NULL,'cron',NULL),(2040,28,540,'2018-04-24 15:15:00','2018-04-24 15:15:00','success',NULL,'cron',NULL),(2041,23,540,'2018-04-24 15:15:00','2018-04-24 15:15:00','success',NULL,'cron',NULL),(2042,27,809,'2018-04-24 15:20:00','2018-04-24 15:20:00','success',NULL,'cron',NULL),(2043,27,810,'2018-04-24 15:30:00','2018-04-24 15:30:00','success',NULL,'cron',NULL),(2044,28,541,'2018-04-24 15:30:00','2018-04-24 15:30:00','success',NULL,'cron',NULL),(2045,23,541,'2018-04-24 15:30:00','2018-04-24 15:30:00','success',NULL,'cron',NULL),(2046,27,811,'2018-04-24 15:40:00','2018-04-24 15:40:00','success',NULL,'cron',NULL),(2047,23,542,'2018-04-24 15:45:00','2018-04-24 15:45:00','success',NULL,'cron',NULL),(2048,28,542,'2018-04-24 15:45:00','2018-04-24 15:45:00','success',NULL,'cron',NULL),(2049,27,812,'2018-04-24 15:50:00','2018-04-24 15:50:00','success',NULL,'cron',NULL),(2050,27,813,'2018-04-24 16:00:00','2018-04-24 16:00:00','success',NULL,'cron',NULL),(2051,28,543,'2018-04-24 16:00:00','2018-04-24 16:00:00','success',NULL,'cron',NULL),(2052,23,543,'2018-04-24 16:00:00','2018-04-24 16:00:00','success',NULL,'cron',NULL),(2053,27,814,'2018-04-24 16:10:00','2018-04-24 16:10:00','success',NULL,'cron',NULL),(2054,28,544,'2018-04-24 16:15:00','2018-04-24 16:15:00','success',NULL,'cron',NULL),(2055,23,544,'2018-04-24 16:15:00','2018-04-24 16:15:00','success',NULL,'cron',NULL),(2056,27,815,'2018-04-24 16:20:00','2018-04-24 16:20:00','success',NULL,'cron',NULL),(2057,27,816,'2018-04-24 16:30:00','2018-04-24 16:30:00','success',NULL,'cron',NULL),(2058,23,545,'2018-04-24 16:30:00','2018-04-24 16:30:00','success',NULL,'cron',NULL),(2059,28,545,'2018-04-24 16:30:00','2018-04-24 16:30:00','success',NULL,'cron',NULL),(2060,27,817,'2018-04-24 16:40:00','2018-04-24 16:40:00','success',NULL,'cron',NULL),(2061,28,546,'2018-04-24 16:45:00','2018-04-24 16:45:00','success',NULL,'cron',NULL),(2062,23,546,'2018-04-24 16:45:00','2018-04-24 16:45:00','success',NULL,'cron',NULL),(2063,27,818,'2018-04-24 16:50:00','2018-04-24 16:50:00','success',NULL,'cron',NULL),(2064,28,547,'2018-04-24 17:00:00','2018-04-24 17:00:00','success',NULL,'cron',NULL),(2065,27,819,'2018-04-24 17:00:00','2018-04-24 17:00:00','success',NULL,'cron',NULL),(2066,23,547,'2018-04-24 17:00:00','2018-04-24 17:00:00','success',NULL,'cron',NULL),(2067,27,820,'2018-04-24 17:10:00','2018-04-24 17:10:00','success',NULL,'cron',NULL),(2068,28,548,'2018-04-24 17:15:00','2018-04-24 17:15:00','success',NULL,'cron',NULL),(2069,23,548,'2018-04-24 17:15:00','2018-04-24 17:15:00','success',NULL,'cron',NULL),(2070,27,821,'2018-04-24 17:20:00','2018-04-24 17:20:00','success',NULL,'cron',NULL),(2071,23,549,'2018-04-24 17:30:00','2018-04-24 17:30:00','success',NULL,'cron',NULL),(2072,27,822,'2018-04-24 17:30:00','2018-04-24 17:30:00','success',NULL,'cron',NULL),(2073,28,549,'2018-04-24 17:30:00','2018-04-24 17:30:00','success',NULL,'cron',NULL),(2074,27,823,'2018-04-24 17:40:00','2018-04-24 17:40:00','success',NULL,'cron',NULL),(2075,23,550,'2018-04-24 17:45:00','2018-04-24 17:45:00','success',NULL,'cron',NULL),(2076,28,550,'2018-04-24 17:45:00','2018-04-24 17:45:00','success',NULL,'cron',NULL),(2077,27,824,'2018-04-24 17:50:00','2018-04-24 17:50:00','success',NULL,'cron',NULL),(2078,27,825,'2018-04-24 18:00:00','2018-04-24 18:00:00','success',NULL,'cron',NULL),(2079,28,551,'2018-04-24 18:00:00','2018-04-24 18:00:00','success',NULL,'cron',NULL),(2080,23,551,'2018-04-24 18:00:00','2018-04-24 18:00:00','success',NULL,'cron',NULL),(2081,27,826,'2018-04-24 18:10:00','2018-04-24 18:10:00','success',NULL,'cron',NULL),(2082,28,552,'2018-04-24 18:15:00','2018-04-24 18:15:00','success',NULL,'cron',NULL),(2083,23,552,'2018-04-24 18:15:00','2018-04-24 18:15:00','success',NULL,'cron',NULL),(2084,27,827,'2018-04-24 18:20:00','2018-04-24 18:20:00','success',NULL,'cron',NULL);
/*!40000 ALTER TABLE `job_run_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_account_transfer_details`
--

DROP TABLE IF EXISTS `m_account_transfer_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_account_transfer_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_office_id` bigint(20) NOT NULL,
  `to_office_id` bigint(20) NOT NULL,
  `from_client_id` bigint(20) DEFAULT NULL,
  `to_client_id` bigint(20) DEFAULT NULL,
  `from_savings_account_id` bigint(20) DEFAULT NULL,
  `to_savings_account_id` bigint(20) DEFAULT NULL,
  `from_loan_account_id` bigint(20) DEFAULT NULL,
  `to_loan_account_id` bigint(20) DEFAULT NULL,
  `transfer_type` smallint(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_account_transfer_details_from_office` (`from_office_id`),
  KEY `FK_m_account_transfer_details_to_office` (`to_office_id`),
  KEY `FK_m_account_transfer_details_from_client` (`from_client_id`),
  KEY `FK_m_account_transfer_details_to_client` (`to_client_id`),
  KEY `FK_m_account_transfer_details_from_savings_account` (`from_savings_account_id`),
  KEY `FK_m_account_transfer_details_to_savings_account` (`to_savings_account_id`),
  KEY `FK_m_account_transfer_details_from_loan_account` (`from_loan_account_id`),
  KEY `FK_m_account_transfer_details_to_loan_account` (`to_loan_account_id`),
  CONSTRAINT `FK_m_account_transfer_details_from_client` FOREIGN KEY (`from_client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK_m_account_transfer_details_from_loan_account` FOREIGN KEY (`from_loan_account_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_m_account_transfer_details_from_office` FOREIGN KEY (`from_office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_m_account_transfer_details_from_savings_account` FOREIGN KEY (`from_savings_account_id`) REFERENCES `m_savings_account` (`id`),
  CONSTRAINT `FK_m_account_transfer_details_to_client` FOREIGN KEY (`to_client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK_m_account_transfer_details_to_loan_account` FOREIGN KEY (`to_loan_account_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_m_account_transfer_details_to_office` FOREIGN KEY (`to_office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_m_account_transfer_details_to_savings_account` FOREIGN KEY (`to_savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_account_transfer_details`
--

LOCK TABLES `m_account_transfer_details` WRITE;
/*!40000 ALTER TABLE `m_account_transfer_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_account_transfer_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_account_transfer_standing_instructions`
--

DROP TABLE IF EXISTS `m_account_transfer_standing_instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_account_transfer_standing_instructions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `account_transfer_details_id` bigint(20) NOT NULL,
  `priority` tinyint(2) NOT NULL,
  `status` tinyint(2) NOT NULL,
  `instruction_type` tinyint(2) NOT NULL,
  `amount` decimal(19,6) DEFAULT NULL,
  `valid_from` date NOT NULL,
  `valid_till` date DEFAULT NULL,
  `recurrence_type` tinyint(1) NOT NULL,
  `recurrence_frequency` smallint(5) DEFAULT NULL,
  `recurrence_interval` smallint(5) DEFAULT NULL,
  `recurrence_on_day` smallint(2) DEFAULT NULL,
  `recurrence_on_month` smallint(2) DEFAULT NULL,
  `last_run_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `FK_m_standing_instructions_account_transfer_details` (`account_transfer_details_id`),
  CONSTRAINT `FK_m_standing_instructions_account_transfer_details` FOREIGN KEY (`account_transfer_details_id`) REFERENCES `m_account_transfer_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_account_transfer_standing_instructions`
--

LOCK TABLES `m_account_transfer_standing_instructions` WRITE;
/*!40000 ALTER TABLE `m_account_transfer_standing_instructions` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_account_transfer_standing_instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_account_transfer_standing_instructions_history`
--

DROP TABLE IF EXISTS `m_account_transfer_standing_instructions_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_account_transfer_standing_instructions_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `standing_instruction_id` bigint(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `execution_time` datetime NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `error_log` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_account_transfer_standing_instructions_history` (`standing_instruction_id`),
  CONSTRAINT `FK_m_account_transfer_standing_instructions_m_history` FOREIGN KEY (`standing_instruction_id`) REFERENCES `m_account_transfer_standing_instructions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_account_transfer_standing_instructions_history`
--

LOCK TABLES `m_account_transfer_standing_instructions_history` WRITE;
/*!40000 ALTER TABLE `m_account_transfer_standing_instructions_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_account_transfer_standing_instructions_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_account_transfer_transaction`
--

DROP TABLE IF EXISTS `m_account_transfer_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_account_transfer_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_transfer_details_id` bigint(20) NOT NULL,
  `from_savings_transaction_id` bigint(20) DEFAULT NULL,
  `from_loan_transaction_id` bigint(20) DEFAULT NULL,
  `to_savings_transaction_id` bigint(20) DEFAULT NULL,
  `to_loan_transaction_id` bigint(20) DEFAULT NULL,
  `is_reversed` tinyint(1) NOT NULL,
  `transaction_date` date NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_account_transfer_transaction_from_m_savings_transaction` (`from_savings_transaction_id`),
  KEY `FK_m_account_transfer_transaction_to_m_savings_transaction` (`to_savings_transaction_id`),
  KEY `FK_m_account_transfer_transaction_to_m_loan_transaction` (`to_loan_transaction_id`),
  KEY `FK_m_account_transfer_transaction_from_m_loan_transaction` (`from_loan_transaction_id`),
  KEY `FK_m_account_transfer_transaction_account_detail` (`account_transfer_details_id`),
  CONSTRAINT `FK_m_account_transfer_transaction_account_detail` FOREIGN KEY (`account_transfer_details_id`) REFERENCES `m_account_transfer_details` (`id`),
  CONSTRAINT `FK_m_account_transfer_transaction_from_m_loan_transaction` FOREIGN KEY (`from_loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`),
  CONSTRAINT `FK_m_account_transfer_transaction_from_m_savings_transaction` FOREIGN KEY (`from_savings_transaction_id`) REFERENCES `m_savings_account_transaction` (`id`),
  CONSTRAINT `FK_m_account_transfer_transaction_to_m_loan_transaction` FOREIGN KEY (`to_loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`),
  CONSTRAINT `FK_m_account_transfer_transaction_to_m_savings_transaction` FOREIGN KEY (`to_savings_transaction_id`) REFERENCES `m_savings_account_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_account_transfer_transaction`
--

LOCK TABLES `m_account_transfer_transaction` WRITE;
/*!40000 ALTER TABLE `m_account_transfer_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_account_transfer_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_address`
--

DROP TABLE IF EXISTS `m_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `street` varchar(100) DEFAULT NULL,
  `address_line_1` varchar(100) DEFAULT NULL,
  `address_line_2` varchar(100) DEFAULT NULL,
  `address_line_3` varchar(100) DEFAULT NULL,
  `town_village` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `county_district` varchar(100) DEFAULT NULL,
  `state_province_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `latitude` decimal(10,8) unsigned DEFAULT '0.00000000',
  `longitude` decimal(10,8) unsigned DEFAULT '0.00000000',
  `created_by` varchar(100) DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_on` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `address_fields_codefk1` (`state_province_id`),
  KEY `address_fields_codefk2` (`country_id`),
  CONSTRAINT `address_fields_codefk1` FOREIGN KEY (`state_province_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `address_fields_codefk2` FOREIGN KEY (`country_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_address`
--

LOCK TABLES `m_address` WRITE;
/*!40000 ALTER TABLE `m_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_adhoc`
--

DROP TABLE IF EXISTS `m_adhoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_adhoc` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `query` varchar(2000) DEFAULT NULL,
  `table_name` varchar(100) DEFAULT NULL,
  `table_fields` varchar(1000) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT '0',
  `created_date` datetime DEFAULT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `report_run_frequency_code` int(11) DEFAULT NULL,
  `report_run_every` int(11) DEFAULT NULL,
  `last_run` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `createdby_id` (`createdby_id`),
  KEY `lastmodifiedby_id` (`lastmodifiedby_id`),
  CONSTRAINT `createdby_id` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `lastmodifiedby_id` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_adhoc`
--

LOCK TABLES `m_adhoc` WRITE;
/*!40000 ALTER TABLE `m_adhoc` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_adhoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_appuser`
--

DROP TABLE IF EXISTS `m_appuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_appuser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `office_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `firsttime_login_remaining` bit(1) NOT NULL,
  `nonexpired` bit(1) NOT NULL,
  `nonlocked` bit(1) NOT NULL,
  `nonexpired_credentials` bit(1) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `last_time_password_updated` date NOT NULL,
  `password_never_expires` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'define if the password, should be check for validity period or not',
  `is_self_service_user` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_org` (`username`),
  KEY `FKB3D587CE0DD567A` (`office_id`),
  KEY `fk_m_appuser_002x` (`staff_id`),
  KEY `last_time_password_updated` (`last_time_password_updated`),
  CONSTRAINT `FKB3D587CE0DD567A` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `fk_m_appuser_002` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_appuser`
--

LOCK TABLES `m_appuser` WRITE;
/*!40000 ALTER TABLE `m_appuser` DISABLE KEYS */;
INSERT INTO `m_appuser` VALUES (1,0,1,NULL,'mifos','App','Administrator','5787039480429368bf94732aacc771cd0a3ea02bcf504ffe1185ab94213bc63a','demomfi@mifos.org','\0','','','','','2018-04-16',0,'\0'),(2,0,1,NULL,'system','system','system','5787039480429368bf94732aacc771cd0a3ea02bcf504ffe1185ab94213bc63a','demomfi@mifos.org','\0','','','','','2014-03-07',0,'\0'),(3,0,1,NULL,'pembe','Pembe','Miriam','520c2357662f3672d46847d57aea4cc3fb0f960e12abe439a68cdb3e1bff0309','pembemiriam007@gmail.com','\0','','','','','2018-04-16',0,'\0'),(9,0,2,1,'Cynthia.Epolle','Cynthia','Epolle','017dd3a5573f2f966892606618fd51ffee9f8936af4584651f83f1cac43d98b0','Cynthia.Epolle@skylabase.com','\0','','','','','2018-04-17',0,'\0'),(10,0,2,NULL,'Ayuk.Etta','Ayuk','Etta','1bba1d3652850fe6bd9fe936289b981a8091fc16fb5e06b665b643c1496cadd2','Ayuk.Etta@skylabase.com','\0','','','','','2018-04-20',0,'\0');
/*!40000 ALTER TABLE `m_appuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_appuser_previous_password`
--

DROP TABLE IF EXISTS `m_appuser_previous_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_appuser_previous_password` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `removal_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `m_appuser_previous_password_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_appuser_previous_password`
--

LOCK TABLES `m_appuser_previous_password` WRITE;
/*!40000 ALTER TABLE `m_appuser_previous_password` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_appuser_previous_password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_appuser_role`
--

DROP TABLE IF EXISTS `m_appuser_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_appuser_role` (
  `appuser_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`appuser_id`,`role_id`),
  KEY `FK7662CE59B4100309` (`appuser_id`),
  KEY `FK7662CE5915CEC7AB` (`role_id`),
  CONSTRAINT `FK7662CE5915CEC7AB` FOREIGN KEY (`role_id`) REFERENCES `m_role` (`id`),
  CONSTRAINT `FK7662CE59B4100309` FOREIGN KEY (`appuser_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_appuser_role`
--

LOCK TABLES `m_appuser_role` WRITE;
/*!40000 ALTER TABLE `m_appuser_role` DISABLE KEYS */;
INSERT INTO `m_appuser_role` VALUES (1,1),(3,1),(9,1),(10,1);
/*!40000 ALTER TABLE `m_appuser_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_calendar`
--

DROP TABLE IF EXISTS `m_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_calendar` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(70) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `duration` smallint(6) DEFAULT NULL,
  `calendar_type_enum` smallint(5) NOT NULL,
  `repeating` tinyint(1) NOT NULL DEFAULT '0',
  `recurrence` varchar(100) DEFAULT NULL,
  `remind_by_enum` smallint(5) DEFAULT NULL,
  `first_reminder` smallint(11) DEFAULT NULL,
  `second_reminder` smallint(11) DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `meeting_time` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_calendar`
--

LOCK TABLES `m_calendar` WRITE;
/*!40000 ALTER TABLE `m_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_calendar_history`
--

DROP TABLE IF EXISTS `m_calendar_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_calendar_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `calendar_id` bigint(20) NOT NULL,
  `title` varchar(70) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `duration` smallint(6) DEFAULT NULL,
  `calendar_type_enum` smallint(5) NOT NULL,
  `repeating` tinyint(1) NOT NULL DEFAULT '0',
  `recurrence` varchar(100) DEFAULT NULL,
  `remind_by_enum` smallint(5) DEFAULT NULL,
  `first_reminder` smallint(11) DEFAULT NULL,
  `second_reminder` smallint(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_calendar_m_calendar_history` (`calendar_id`),
  CONSTRAINT `FK_m_calendar_m_calendar_history` FOREIGN KEY (`calendar_id`) REFERENCES `m_calendar` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_calendar_history`
--

LOCK TABLES `m_calendar_history` WRITE;
/*!40000 ALTER TABLE `m_calendar_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_calendar_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_calendar_instance`
--

DROP TABLE IF EXISTS `m_calendar_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_calendar_instance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `calendar_id` bigint(20) NOT NULL,
  `entity_id` bigint(20) NOT NULL,
  `entity_type_enum` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_calendar_m_calendar_instance` (`calendar_id`),
  CONSTRAINT `FK_m_calendar_m_calendar_instance` FOREIGN KEY (`calendar_id`) REFERENCES `m_calendar` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_calendar_instance`
--

LOCK TABLES `m_calendar_instance` WRITE;
/*!40000 ALTER TABLE `m_calendar_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_calendar_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_cashier_transactions`
--

DROP TABLE IF EXISTS `m_cashier_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_cashier_transactions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cashier_id` bigint(20) NOT NULL,
  `txn_type` smallint(5) NOT NULL,
  `txn_amount` decimal(19,6) NOT NULL,
  `txn_date` date NOT NULL,
  `created_date` datetime NOT NULL,
  `entity_type` varchar(50) DEFAULT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `txn_note` varchar(200) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IK_m_teller_transactions_m_cashier` (`cashier_id`),
  CONSTRAINT `FK_m_teller_transactions_m_cashiers` FOREIGN KEY (`cashier_id`) REFERENCES `m_cashiers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_cashier_transactions`
--

LOCK TABLES `m_cashier_transactions` WRITE;
/*!40000 ALTER TABLE `m_cashier_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_cashier_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_cashiers`
--

DROP TABLE IF EXISTS `m_cashiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_cashiers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `staff_id` bigint(20) DEFAULT NULL,
  `teller_id` bigint(20) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` varchar(10) DEFAULT NULL,
  `end_time` varchar(10) DEFAULT NULL,
  `full_day` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IK_m_cashiers_m_staff` (`staff_id`),
  KEY `IK_m_cashiers_m_teller` (`teller_id`),
  CONSTRAINT `FK_m_cashiers_m_staff` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`),
  CONSTRAINT `FK_m_cashiers_m_teller` FOREIGN KEY (`teller_id`) REFERENCES `m_tellers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_cashiers`
--

LOCK TABLES `m_cashiers` WRITE;
/*!40000 ALTER TABLE `m_cashiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_cashiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_charge`
--

DROP TABLE IF EXISTS `m_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `charge_applies_to_enum` smallint(5) NOT NULL,
  `charge_time_enum` smallint(5) NOT NULL,
  `charge_calculation_enum` smallint(5) NOT NULL,
  `charge_payment_mode_enum` smallint(5) DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `fee_on_day` smallint(5) DEFAULT NULL,
  `fee_interval` smallint(5) DEFAULT NULL,
  `fee_on_month` smallint(5) DEFAULT NULL,
  `is_penalty` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `min_cap` decimal(19,6) DEFAULT NULL,
  `max_cap` decimal(19,6) DEFAULT NULL,
  `fee_frequency` smallint(5) DEFAULT NULL,
  `income_or_liability_account_id` bigint(20) DEFAULT NULL,
  `tax_group_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `FK_m_charge_acc_gl_account` (`income_or_liability_account_id`),
  KEY `FK_m_charge_m_tax_group` (`tax_group_id`),
  CONSTRAINT `FK_m_charge_acc_gl_account` FOREIGN KEY (`income_or_liability_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_m_charge_m_tax_group` FOREIGN KEY (`tax_group_id`) REFERENCES `m_tax_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_charge`
--

LOCK TABLES `m_charge` WRITE;
/*!40000 ALTER TABLE `m_charge` DISABLE KEYS */;
INSERT INTO `m_charge` VALUES (1,'Membership fee','XAF',2,3,1,NULL,1000.000000,NULL,NULL,NULL,0,1,0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `m_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client`
--

DROP TABLE IF EXISTS `m_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_no` varchar(20) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `status_enum` int(5) NOT NULL DEFAULT '300',
  `sub_status` int(11) DEFAULT NULL,
  `activation_date` date DEFAULT NULL,
  `office_joining_date` date DEFAULT NULL,
  `office_id` bigint(20) NOT NULL,
  `transfer_to_office_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `middlename` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) NOT NULL,
  `mobile_no` varchar(50) DEFAULT NULL,
  `is_staff` tinyint(1) NOT NULL DEFAULT '0',
  `gender_cv_id` int(11) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `image_id` bigint(20) DEFAULT NULL,
  `closure_reason_cv_id` int(11) DEFAULT NULL,
  `closedon_date` date DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `updated_on` date DEFAULT NULL,
  `submittedon_date` date DEFAULT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `activatedon_userid` bigint(20) DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `default_savings_product` bigint(20) DEFAULT NULL,
  `default_savings_account` bigint(20) DEFAULT NULL,
  `client_type_cv_id` int(11) DEFAULT NULL,
  `client_classification_cv_id` int(11) DEFAULT NULL,
  `reject_reason_cv_id` int(11) DEFAULT NULL,
  `rejectedon_date` date DEFAULT NULL,
  `rejectedon_userid` bigint(20) DEFAULT NULL,
  `withdraw_reason_cv_id` int(11) DEFAULT NULL,
  `withdrawn_on_date` date DEFAULT NULL,
  `withdraw_on_userid` bigint(20) DEFAULT NULL,
  `reactivated_on_date` date DEFAULT NULL,
  `reactivated_on_userid` bigint(20) DEFAULT NULL,
  `legal_form_enum` int(5) DEFAULT NULL,
  `reopened_on_date` date DEFAULT NULL,
  `reopened_by_userid` bigint(20) DEFAULT NULL,
  `email_address` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_no_UNIQUE` (`account_no`),
  UNIQUE KEY `external_id` (`external_id`),
  UNIQUE KEY `mobile_no_UNIQUE` (`mobile_no`),
  KEY `FKCE00CAB3E0DD567A` (`office_id`),
  KEY `FK_m_client_m_image` (`image_id`),
  KEY `client_staff_id` (`staff_id`),
  KEY `FK_m_client_m_code` (`closure_reason_cv_id`),
  KEY `FK_m_client_m_office` (`transfer_to_office_id`),
  KEY `FK_m_client_m_savings_product` (`default_savings_product`),
  KEY `FK_m_client_m_savings_account` (`default_savings_account`),
  KEY `FK_m_client_type_m_code_value` (`client_type_cv_id`),
  KEY `FK_m_client_classification_m_code_value` (`client_classification_cv_id`),
  KEY `FK1_m_client_gender_m_code_value` (`gender_cv_id`),
  KEY `FK_m_client_substatus_m_code_value` (`sub_status`),
  KEY `FK_m_client_type_mcode_value_reject` (`reject_reason_cv_id`),
  KEY `FK_m_client_type_m_code_value_withdraw` (`withdraw_reason_cv_id`),
  CONSTRAINT `FK1_m_client_gender_m_code_value` FOREIGN KEY (`gender_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FKCE00CAB3E0DD567A` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_m_client_classification_m_code_value` FOREIGN KEY (`client_classification_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_client_m_code` FOREIGN KEY (`closure_reason_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_client_m_image` FOREIGN KEY (`image_id`) REFERENCES `m_image` (`id`),
  CONSTRAINT `FK_m_client_m_office` FOREIGN KEY (`transfer_to_office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_m_client_m_savings_account` FOREIGN KEY (`default_savings_account`) REFERENCES `m_savings_account` (`id`),
  CONSTRAINT `FK_m_client_m_savings_product` FOREIGN KEY (`default_savings_product`) REFERENCES `m_savings_product` (`id`),
  CONSTRAINT `FK_m_client_m_staff` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`),
  CONSTRAINT `FK_m_client_substatus_m_code_value` FOREIGN KEY (`sub_status`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_client_type_m_code_value` FOREIGN KEY (`client_type_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_client_type_m_code_value_withdraw` FOREIGN KEY (`withdraw_reason_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_client_type_mcode_value_reject` FOREIGN KEY (`reject_reason_cv_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client`
--

LOCK TABLES `m_client` WRITE;
/*!40000 ALTER TABLE `m_client` DISABLE KEYS */;
INSERT INTO `m_client` VALUES (1,'000000001','MS001',300,NULL,'2018-04-19','2018-04-19',2,NULL,NULL,'Ayuk','Etta','Akum',NULL,'Ayuk Etta Akum','676101785',0,20,'1991-03-13',NULL,NULL,NULL,NULL,NULL,'2018-04-19',9,9,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(2,'000000002','MS002',300,NULL,'2018-04-19','2018-04-19',2,NULL,NULL,'Ndam',NULL,'Arouna',NULL,'Ndam Arouna','677245373',0,21,'1996-02-04',NULL,NULL,NULL,NULL,NULL,'2018-04-19',9,9,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(3,'000000003','MS003',300,NULL,'2018-04-19','2018-04-19',2,NULL,1,'Cynthia',NULL,'Epolle',NULL,'Cynthia Epolle','670949951',0,20,'1993-01-17',NULL,NULL,NULL,NULL,NULL,'2018-04-19',9,9,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(4,'000000004','MS004',300,NULL,'2018-04-19','2018-04-19',2,NULL,NULL,'Issac','Kamga','Mkounga',NULL,'Issac Kamga Mkounga','674106297',0,21,'1987-05-27',NULL,NULL,NULL,NULL,NULL,'2018-04-19',9,9,NULL,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(5,'000000005','MS005',300,NULL,'2018-04-19','2018-04-19',2,NULL,NULL,'Awasum','Yannick','Noah',NULL,'Awasum Yannick Noah','676683945',0,21,'1991-03-19',NULL,NULL,NULL,NULL,NULL,'2018-04-19',9,9,NULL,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(6,'000000006','MS006',300,NULL,'2018-04-19','2018-04-19',2,NULL,NULL,'Akoko','Bill','Elton',NULL,'Akoko Bill Elton','678635286',0,21,'1993-02-05',NULL,NULL,NULL,NULL,NULL,'2018-04-19',9,9,NULL,NULL,6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(7,'000000007','MS007',300,NULL,'2018-04-19','2018-04-19',2,NULL,NULL,'Achia','Rolence','Aka',NULL,'Achia Rolence Aka','670030932',0,21,'2017-08-05',NULL,NULL,NULL,NULL,NULL,'2018-04-19',9,9,NULL,NULL,7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(8,'000000008','MS008',300,NULL,'2018-04-19','2018-04-19',2,NULL,NULL,'Effangwa','Martha','Itoh',NULL,'Effangwa Martha Itoh','674669380',0,20,'1992-04-08',NULL,NULL,NULL,NULL,NULL,'2018-04-19',9,9,NULL,NULL,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(9,'000000009','MS009',300,NULL,'2018-04-19','2018-04-19',2,NULL,NULL,'Pembe','Miriam','Motia',NULL,'Pembe Miriam Motia','671840646',0,20,'1996-11-06',NULL,NULL,NULL,NULL,NULL,'2018-04-19',9,9,NULL,NULL,9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(10,'000000010','MS010',300,NULL,'2018-04-19','2018-04-19',2,NULL,NULL,'Tcheukounang','Kengne','Grace',NULL,'Tcheukounang Kengne Grace','675734571',0,20,'1996-10-10',NULL,NULL,NULL,NULL,NULL,'2018-04-19',9,9,NULL,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(11,'000000011','MS011',300,NULL,'2018-04-19','2018-04-19',2,NULL,NULL,'Kelvin','Ikome','Ekonde',NULL,'Kelvin Ikome Ekonde','677666659',0,21,'1999-08-28',NULL,NULL,NULL,NULL,NULL,'2018-04-19',9,9,NULL,NULL,11,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(12,'000000012','MS012',300,NULL,'2018-04-19','2018-04-19',2,NULL,NULL,'Kemfang','Tcheutchie','Cabrel',NULL,'Kemfang Tcheutchie Cabrel','675463395',0,21,'1993-08-12',NULL,NULL,NULL,NULL,NULL,'2018-04-19',9,9,NULL,NULL,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(13,'000000013','MS013',300,NULL,'2018-04-19','2018-04-19',2,NULL,NULL,'Forntoh','Esoh','Berlinda',NULL,'Forntoh Esoh Berlinda','670256726',0,20,'1995-09-07',NULL,NULL,NULL,NULL,NULL,'2018-04-19',9,9,NULL,NULL,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(15,'000000015','MS014',300,NULL,'2018-04-19','2018-04-19',2,NULL,NULL,NULL,NULL,NULL,'Skylabase Inc','Skylabase Inc','243626689',0,NULL,'2017-04-19',NULL,NULL,NULL,NULL,NULL,'2018-04-19',9,9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL);
/*!40000 ALTER TABLE `m_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_address`
--

DROP TABLE IF EXISTS `m_client_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL DEFAULT '0',
  `address_id` bigint(20) NOT NULL DEFAULT '0',
  `address_type_id` int(11) NOT NULL DEFAULT '0',
  `is_active` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `addressIdFk` (`address_id`),
  KEY `address_codefk` (`address_type_id`),
  KEY `clientaddressfk` (`client_id`),
  CONSTRAINT `address_codefk` FOREIGN KEY (`address_type_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `clientaddressfk` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_address`
--

LOCK TABLES `m_client_address` WRITE;
/*!40000 ALTER TABLE `m_client_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_attendance`
--

DROP TABLE IF EXISTS `m_client_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_attendance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL DEFAULT '0',
  `meeting_id` bigint(20) NOT NULL,
  `attendance_type_enum` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_client_meeting_attendance` (`client_id`,`meeting_id`),
  KEY `FK_m_meeting_m_client_attendance` (`meeting_id`),
  CONSTRAINT `FK_m_client_m_client_attendance` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK_m_meeting_m_client_attendance` FOREIGN KEY (`meeting_id`) REFERENCES `m_meeting` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_attendance`
--

LOCK TABLES `m_client_attendance` WRITE;
/*!40000 ALTER TABLE `m_client_attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_charge`
--

DROP TABLE IF EXISTS `m_client_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  `is_penalty` tinyint(1) NOT NULL,
  `charge_time_enum` smallint(5) NOT NULL,
  `charge_due_date` date DEFAULT NULL,
  `charge_calculation_enum` smallint(5) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_paid_derived` decimal(19,6) DEFAULT NULL,
  `amount_waived_derived` decimal(19,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(19,6) NOT NULL,
  `is_paid_derived` tinyint(1) DEFAULT NULL,
  `waived` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `inactivated_on_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_client_charge_m_client` (`client_id`),
  KEY `FK_m_client_charge_m_charge` (`charge_id`),
  CONSTRAINT `FK_m_client_charge_m_charge` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `FK_m_client_charge_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_charge`
--

LOCK TABLES `m_client_charge` WRITE;
/*!40000 ALTER TABLE `m_client_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_charge_paid_by`
--

DROP TABLE IF EXISTS `m_client_charge_paid_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_charge_paid_by` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_transaction_id` bigint(20) NOT NULL,
  `client_charge_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_client_charge_paid_by_m_client_transaction` (`client_transaction_id`),
  KEY `FK_m_client_charge_paid_by_m_client_charge` (`client_charge_id`),
  CONSTRAINT `FK_m_client_charge_paid_by_m_client_charge` FOREIGN KEY (`client_charge_id`) REFERENCES `m_client_charge` (`id`),
  CONSTRAINT `FK_m_client_charge_paid_by_m_client_transaction` FOREIGN KEY (`client_transaction_id`) REFERENCES `m_client_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_charge_paid_by`
--

LOCK TABLES `m_client_charge_paid_by` WRITE;
/*!40000 ALTER TABLE `m_client_charge_paid_by` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_charge_paid_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_identifier`
--

DROP TABLE IF EXISTS `m_client_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_identifier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `document_type_id` int(11) NOT NULL,
  `document_key` varchar(50) NOT NULL,
  `status` int(5) NOT NULL DEFAULT '300',
  `active` int(5) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_identifier_key` (`document_type_id`,`document_key`),
  UNIQUE KEY `unique_active_client_identifier` (`client_id`,`document_type_id`,`active`),
  KEY `FK_m_client_document_m_client` (`client_id`),
  KEY `FK_m_client_document_m_code_value` (`document_type_id`),
  CONSTRAINT `FK_m_client_document_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK_m_client_document_m_code_value` FOREIGN KEY (`document_type_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_identifier`
--

LOCK TABLES `m_client_identifier` WRITE;
/*!40000 ALTER TABLE `m_client_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_identifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_non_person`
--

DROP TABLE IF EXISTS `m_client_non_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_non_person` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `constitution_cv_id` int(11) NOT NULL,
  `incorp_no` varchar(50) DEFAULT NULL,
  `incorp_validity_till` datetime DEFAULT NULL,
  `main_business_line_cv_id` int(11) DEFAULT NULL,
  `remarks` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `FK_client_id` (`client_id`),
  CONSTRAINT `FK_client_id` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_non_person`
--

LOCK TABLES `m_client_non_person` WRITE;
/*!40000 ALTER TABLE `m_client_non_person` DISABLE KEYS */;
INSERT INTO `m_client_non_person` VALUES (1,15,0,'M031712616989F','2019-04-19 00:00:00',NULL,NULL);
/*!40000 ALTER TABLE `m_client_non_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_transaction`
--

DROP TABLE IF EXISTS `m_client_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `payment_detail_id` bigint(20) DEFAULT NULL,
  `is_reversed` tinyint(1) NOT NULL,
  `external_id` varchar(50) DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `transaction_type_enum` smallint(5) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `created_date` datetime NOT NULL,
  `appuser_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_id` (`external_id`),
  KEY `FK_m_client_transaction_m_client` (`client_id`),
  KEY `FK_m_client_transaction_m_appuser` (`appuser_id`),
  CONSTRAINT `FK_m_client_transaction_m_appuser` FOREIGN KEY (`appuser_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_client_transaction_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_transaction`
--

LOCK TABLES `m_client_transaction` WRITE;
/*!40000 ALTER TABLE `m_client_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_code`
--

DROP TABLE IF EXISTS `m_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(100) DEFAULT NULL,
  `is_system_defined` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_name` (`code_name`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_code`
--

LOCK TABLES `m_code` WRITE;
/*!40000 ALTER TABLE `m_code` DISABLE KEYS */;
INSERT INTO `m_code` VALUES (1,'Customer Identifier',1),(2,'LoanCollateral',1),(3,'LoanPurpose',1),(4,'Gender',1),(5,'YesNo',1),(6,'GuarantorRelationship',1),(7,'AssetAccountTags',1),(8,'LiabilityAccountTags',1),(9,'EquityAccountTags',1),(10,'IncomeAccountTags',1),(11,'ExpenseAccountTags',1),(13,'GROUPROLE',1),(14,'ClientClosureReason',1),(15,'GroupClosureReason',1),(16,'ClientType',1),(17,'ClientClassification',1),(18,'ClientSubStatus',1),(19,'ClientRejectReason',1),(20,'ClientWithdrawReason',1),(21,'Entity to Entity Access Types',1),(22,'CenterClosureReason',1),(23,'LoanRescheduleReason',1),(24,'Constitution',1),(25,'Main Business Line',1),(26,'WriteOffReasons',1),(27,'STATE',1),(28,'COUNTRY',1),(29,'ADDRESS_TYPE',1),(30,'MARITAL STATUS',1),(31,'RELATIONSHIP',1),(32,'PROFESSION',1),(34,'Charges',0),(35,'Funding',0);
/*!40000 ALTER TABLE `m_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_code_value`
--

DROP TABLE IF EXISTS `m_code_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_code_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_id` int(11) NOT NULL,
  `code_value` varchar(100) DEFAULT NULL,
  `code_description` varchar(500) DEFAULT NULL,
  `order_position` int(11) NOT NULL DEFAULT '0',
  `code_score` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_mandatory` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_value` (`code_id`,`code_value`),
  KEY `FKCFCEA42640BE071Z` (`code_id`),
  CONSTRAINT `FKCFCEA42640BE071Z` FOREIGN KEY (`code_id`) REFERENCES `m_code` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_code_value`
--

LOCK TABLES `m_code_value` WRITE;
/*!40000 ALTER TABLE `m_code_value` DISABLE KEYS */;
INSERT INTO `m_code_value` VALUES (1,1,'Passport',NULL,1,NULL,1,0),(2,1,'Id',NULL,2,NULL,1,0),(3,1,'Drivers License',NULL,3,NULL,1,0),(4,1,'Any Other Id Type',NULL,4,NULL,1,0),(5,6,'Spouse',NULL,0,NULL,1,0),(6,6,'Parent',NULL,0,NULL,1,0),(7,6,'Sibling',NULL,0,NULL,1,0),(8,6,'Business Associate',NULL,0,NULL,1,0),(9,6,'Other',NULL,0,NULL,1,0),(10,21,'Office Access to Loan Products',NULL,0,NULL,1,0),(11,21,'Office Access to Savings Products',NULL,0,NULL,1,0),(12,21,'Office Access to Fees/Charges',NULL,0,NULL,1,0),(13,13,'Leader','Group Leader Role',1,NULL,1,0),(14,30,'Single','Single',1,NULL,1,0),(15,30,'Married','Married',2,NULL,1,0),(16,30,'Divorced','Divorced',3,NULL,1,0),(17,30,'Widowed','Widowed',4,NULL,1,0),(18,31,'Wife','Wife',1,NULL,1,0),(19,31,'Husband','Husband',2,NULL,1,0),(20,4,'Female','Female',1,NULL,1,0),(21,4,'Male','Male',2,NULL,1,0),(22,28,'Cameroon','Cameroon',1,NULL,1,0),(23,28,'United States','United States',2,NULL,1,0),(24,32,'Student','Student',1,NULL,1,0),(25,32,'Private Sector','Private Sector',2,NULL,1,0),(26,32,'Civil Servant','Civil Servant',3,NULL,1,0),(27,32,'Sole Proprietor','Sole Proprietor',4,NULL,1,0),(28,31,'Sister','Sister',3,NULL,1,0),(29,31,'Brother','Brother',4,NULL,1,0),(30,31,'Mother','Mother',5,NULL,1,0),(31,31,'Father','Father',6,NULL,1,0),(32,25,'IT Services','IT Services',1,NULL,1,0),(33,25,'Consultancy','Consultancy',2,NULL,1,0),(34,25,'Business','Business',3,NULL,1,0),(35,3,'Business','Business',1,NULL,1,0),(36,3,'School','School',2,NULL,1,0),(37,3,'Personal','Personal',3,NULL,1,0),(38,2,'Salary','Salary',1,NULL,1,0),(39,2,'Savings','Savings',2,NULL,1,0),(40,2,'Personal Belongings','Personal Belongings',3,NULL,1,0),(41,14,'Inactive','Inactive',1,NULL,1,0),(42,14,'Dormant','Dormant',2,NULL,1,0),(43,34,'Loan Processing','Loan Processing',1,NULL,1,0),(44,34,'Late Payment Fee','Late Payment Fee',2,NULL,1,0),(45,35,'Main Funding','Main Funding',1,NULL,1,0),(46,35,'Loan Funding','Loan Funding',2,NULL,1,0);
/*!40000 ALTER TABLE `m_code_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_creditbureau`
--

DROP TABLE IF EXISTS `m_creditbureau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_creditbureau` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `product` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `implementationKey` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique impl` (`name`,`product`,`country`,`implementationKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_creditbureau`
--

LOCK TABLES `m_creditbureau` WRITE;
/*!40000 ALTER TABLE `m_creditbureau` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_creditbureau` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_creditbureau_configuration`
--

DROP TABLE IF EXISTS `m_creditbureau_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_creditbureau_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `configkey` varchar(50) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `organisation_creditbureau_id` bigint(20) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mcbconfig` (`configkey`,`organisation_creditbureau_id`),
  KEY `cbConfigfk1` (`organisation_creditbureau_id`),
  CONSTRAINT `cbConfigfk1` FOREIGN KEY (`organisation_creditbureau_id`) REFERENCES `m_organisation_creditbureau` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_creditbureau_configuration`
--

LOCK TABLES `m_creditbureau_configuration` WRITE;
/*!40000 ALTER TABLE `m_creditbureau_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_creditbureau_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_creditbureau_loanproduct_mapping`
--

DROP TABLE IF EXISTS `m_creditbureau_loanproduct_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_creditbureau_loanproduct_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `organisation_creditbureau_id` bigint(20) NOT NULL,
  `loan_product_id` bigint(20) NOT NULL,
  `is_creditcheck_mandatory` tinyint(1) DEFAULT NULL,
  `skip_creditcheck_in_failure` tinyint(1) DEFAULT NULL,
  `stale_period` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cblpunique_key` (`organisation_creditbureau_id`,`loan_product_id`),
  KEY `fk_cb_lp2` (`loan_product_id`),
  CONSTRAINT `cblpfk2` FOREIGN KEY (`organisation_creditbureau_id`) REFERENCES `m_organisation_creditbureau` (`id`),
  CONSTRAINT `fk_cb_lp2` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_creditbureau_loanproduct_mapping`
--

LOCK TABLES `m_creditbureau_loanproduct_mapping` WRITE;
/*!40000 ALTER TABLE `m_creditbureau_loanproduct_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_creditbureau_loanproduct_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_currency`
--

DROP TABLE IF EXISTS `m_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_currency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) NOT NULL,
  `decimal_places` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `display_symbol` varchar(10) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `internationalized_name_code` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_currency`
--

LOCK TABLES `m_currency` WRITE;
/*!40000 ALTER TABLE `m_currency` DISABLE KEYS */;
INSERT INTO `m_currency` VALUES (1,'AED',2,NULL,NULL,'UAE Dirham','currency.AED'),(2,'AFN',2,NULL,NULL,'Afghanistan Afghani','currency.AFN'),(3,'ALL',2,NULL,NULL,'Albanian Lek','currency.ALL'),(4,'AMD',2,NULL,NULL,'Armenian Dram','currency.AMD'),(5,'ANG',2,NULL,NULL,'Netherlands Antillian Guilder','currency.ANG'),(6,'AOA',2,NULL,NULL,'Angolan Kwanza','currency.AOA'),(7,'ARS',2,NULL,'$','Argentine Peso','currency.ARS'),(8,'AUD',2,NULL,'A$','Australian Dollar','currency.AUD'),(9,'AWG',2,NULL,NULL,'Aruban Guilder','currency.AWG'),(10,'AZM',2,NULL,NULL,'Azerbaijanian Manat','currency.AZM'),(11,'BAM',2,NULL,NULL,'Bosnia and Herzegovina Convertible Marks','currency.BAM'),(12,'BBD',2,NULL,NULL,'Barbados Dollar','currency.BBD'),(13,'BDT',2,NULL,NULL,'Bangladesh Taka','currency.BDT'),(14,'BGN',2,NULL,NULL,'Bulgarian Lev','currency.BGN'),(15,'BHD',3,NULL,NULL,'Bahraini Dinar','currency.BHD'),(16,'BIF',0,NULL,NULL,'Burundi Franc','currency.BIF'),(17,'BMD',2,NULL,NULL,'Bermudian Dollar','currency.BMD'),(18,'BND',2,NULL,'B$','Brunei Dollar','currency.BND'),(19,'BOB',2,NULL,'Bs.','Bolivian Boliviano','currency.BOB'),(20,'BRL',2,NULL,'R$','Brazilian Real','currency.BRL'),(21,'BSD',2,NULL,NULL,'Bahamian Dollar','currency.BSD'),(22,'BTN',2,NULL,NULL,'Bhutan Ngultrum','currency.BTN'),(23,'BWP',2,NULL,NULL,'Botswana Pula','currency.BWP'),(24,'BYR',0,NULL,NULL,'Belarussian Ruble','currency.BYR'),(25,'BZD',2,NULL,'BZ$','Belize Dollar','currency.BZD'),(26,'CAD',2,NULL,NULL,'Canadian Dollar','currency.CAD'),(27,'CDF',2,NULL,NULL,'Franc Congolais','currency.CDF'),(28,'CHF',2,NULL,NULL,'Swiss Franc','currency.CHF'),(29,'CLP',0,NULL,'$','Chilean Peso','currency.CLP'),(30,'CNY',2,NULL,NULL,'Chinese Yuan Renminbi','currency.CNY'),(31,'COP',2,NULL,'$','Colombian Peso','currency.COP'),(32,'CRC',2,NULL,'₡','Costa Rican Colon','currency.CRC'),(33,'CSD',2,NULL,NULL,'Serbian Dinar','currency.CSD'),(34,'CUP',2,NULL,'$MN','Cuban Peso','currency.CUP'),(35,'CVE',2,NULL,NULL,'Cape Verde Escudo','currency.CVE'),(36,'CYP',2,NULL,NULL,'Cyprus Pound','currency.CYP'),(37,'CZK',2,NULL,NULL,'Czech Koruna','currency.CZK'),(38,'DJF',0,NULL,NULL,'Djibouti Franc','currency.DJF'),(39,'DKK',2,NULL,NULL,'Danish Krone','currency.DKK'),(40,'DOP',2,NULL,'RD$','Dominican Peso','currency.DOP'),(41,'DZD',2,NULL,NULL,'Algerian Dinar','currency.DZD'),(42,'EEK',2,NULL,NULL,'Estonian Kroon','currency.EEK'),(43,'EGP',2,NULL,NULL,'Egyptian Pound','currency.EGP'),(44,'ERN',2,NULL,NULL,'Eritrea Nafka','currency.ERN'),(45,'ETB',2,NULL,NULL,'Ethiopian Birr','currency.ETB'),(46,'EUR',2,NULL,'€','Euro','currency.EUR'),(47,'FJD',2,NULL,NULL,'Fiji Dollar','currency.FJD'),(48,'FKP',2,NULL,NULL,'Falkland Islands Pound','currency.FKP'),(49,'GBP',2,NULL,NULL,'Pound Sterling','currency.GBP'),(50,'GEL',2,NULL,NULL,'Georgian Lari','currency.GEL'),(51,'GHC',2,NULL,'GHc','Ghana Cedi','currency.GHC'),(52,'GIP',2,NULL,NULL,'Gibraltar Pound','currency.GIP'),(53,'GMD',2,NULL,NULL,'Gambian Dalasi','currency.GMD'),(54,'GNF',0,NULL,NULL,'Guinea Franc','currency.GNF'),(55,'GTQ',2,NULL,'Q','Guatemala Quetzal','currency.GTQ'),(56,'GYD',2,NULL,NULL,'Guyana Dollar','currency.GYD'),(57,'HKD',2,NULL,NULL,'Hong Kong Dollar','currency.HKD'),(58,'HNL',2,NULL,'L','Honduras Lempira','currency.HNL'),(59,'HRK',2,NULL,NULL,'Croatian Kuna','currency.HRK'),(60,'HTG',2,NULL,'G','Haiti Gourde','currency.HTG'),(61,'HUF',2,NULL,NULL,'Hungarian Forint','currency.HUF'),(62,'IDR',2,NULL,NULL,'Indonesian Rupiah','currency.IDR'),(63,'ILS',2,NULL,NULL,'New Israeli Shekel','currency.ILS'),(64,'INR',2,NULL,'₹','Indian Rupee','currency.INR'),(65,'IQD',3,NULL,NULL,'Iraqi Dinar','currency.IQD'),(66,'IRR',2,NULL,NULL,'Iranian Rial','currency.IRR'),(67,'ISK',0,NULL,NULL,'Iceland Krona','currency.ISK'),(68,'JMD',2,NULL,NULL,'Jamaican Dollar','currency.JMD'),(69,'JOD',3,NULL,NULL,'Jordanian Dinar','currency.JOD'),(70,'JPY',0,NULL,NULL,'Japanese Yen','currency.JPY'),(71,'KES',2,NULL,'KSh','Kenyan Shilling','currency.KES'),(72,'KGS',2,NULL,NULL,'Kyrgyzstan Som','currency.KGS'),(73,'KHR',2,NULL,NULL,'Cambodia Riel','currency.KHR'),(74,'KMF',0,NULL,NULL,'Comoro Franc','currency.KMF'),(75,'KPW',2,NULL,NULL,'North Korean Won','currency.KPW'),(76,'KRW',0,NULL,NULL,'Korean Won','currency.KRW'),(77,'KWD',3,NULL,NULL,'Kuwaiti Dinar','currency.KWD'),(78,'KYD',2,NULL,NULL,'Cayman Islands Dollar','currency.KYD'),(79,'KZT',2,NULL,NULL,'Kazakhstan Tenge','currency.KZT'),(80,'LAK',2,NULL,NULL,'Lao Kip','currency.LAK'),(81,'LBP',2,NULL,'L£','Lebanese Pound','currency.LBP'),(82,'LKR',2,NULL,NULL,'Sri Lanka Rupee','currency.LKR'),(83,'LRD',2,NULL,NULL,'Liberian Dollar','currency.LRD'),(84,'LSL',2,NULL,NULL,'Lesotho Loti','currency.LSL'),(85,'LTL',2,NULL,NULL,'Lithuanian Litas','currency.LTL'),(86,'LVL',2,NULL,NULL,'Latvian Lats','currency.LVL'),(87,'LYD',3,NULL,NULL,'Libyan Dinar','currency.LYD'),(88,'MAD',2,NULL,NULL,'Moroccan Dirham','currency.MAD'),(89,'MDL',2,NULL,NULL,'Moldovan Leu','currency.MDL'),(90,'MGA',2,NULL,NULL,'Malagasy Ariary','currency.MGA'),(91,'MKD',2,NULL,NULL,'Macedonian Denar','currency.MKD'),(92,'MMK',2,NULL,'K','Myanmar Kyat','currency.MMK'),(93,'MNT',2,NULL,NULL,'Mongolian Tugrik','currency.MNT'),(94,'MOP',2,NULL,NULL,'Macau Pataca','currency.MOP'),(95,'MRO',2,NULL,NULL,'Mauritania Ouguiya','currency.MRO'),(96,'MTL',2,NULL,NULL,'Maltese Lira','currency.MTL'),(97,'MUR',2,NULL,NULL,'Mauritius Rupee','currency.MUR'),(98,'MVR',2,NULL,NULL,'Maldives Rufiyaa','currency.MVR'),(99,'MWK',2,NULL,NULL,'Malawi Kwacha','currency.MWK'),(100,'MXN',2,NULL,'$','Mexican Peso','currency.MXN'),(101,'MYR',2,NULL,NULL,'Malaysian Ringgit','currency.MYR'),(102,'MZM',2,NULL,NULL,'Mozambique Metical','currency.MZM'),(103,'NAD',2,NULL,NULL,'Namibia Dollar','currency.NAD'),(104,'NGN',2,NULL,NULL,'Nigerian Naira','currency.NGN'),(105,'NIO',2,NULL,'C$','Nicaragua Cordoba Oro','currency.NIO'),(106,'NOK',2,NULL,NULL,'Norwegian Krone','currency.NOK'),(107,'NPR',2,NULL,NULL,'Nepalese Rupee','currency.NPR'),(108,'NZD',2,NULL,NULL,'New Zealand Dollar','currency.NZD'),(109,'OMR',3,NULL,NULL,'Rial Omani','currency.OMR'),(110,'PAB',2,NULL,'B/.','Panama Balboa','currency.PAB'),(111,'PEN',2,NULL,'S/.','Peruvian Nuevo Sol','currency.PEN'),(112,'PGK',2,NULL,NULL,'Papua New Guinea Kina','currency.PGK'),(113,'PHP',2,NULL,NULL,'Philippine Peso','currency.PHP'),(114,'PKR',2,NULL,NULL,'Pakistan Rupee','currency.PKR'),(115,'PLN',2,NULL,NULL,'Polish Zloty','currency.PLN'),(116,'PYG',0,NULL,'₲','Paraguayan Guarani','currency.PYG'),(117,'QAR',2,NULL,NULL,'Qatari Rial','currency.QAR'),(118,'RON',2,NULL,NULL,'Romanian Leu','currency.RON'),(119,'RUB',2,NULL,NULL,'Russian Ruble','currency.RUB'),(120,'RWF',0,NULL,NULL,'Rwanda Franc','currency.RWF'),(121,'SAR',2,NULL,NULL,'Saudi Riyal','currency.SAR'),(122,'SBD',2,NULL,NULL,'Solomon Islands Dollar','currency.SBD'),(123,'SCR',2,NULL,NULL,'Seychelles Rupee','currency.SCR'),(124,'SDD',2,NULL,NULL,'Sudanese Dinar','currency.SDD'),(125,'SEK',2,NULL,NULL,'Swedish Krona','currency.SEK'),(126,'SGD',2,NULL,NULL,'Singapore Dollar','currency.SGD'),(127,'SHP',2,NULL,NULL,'St Helena Pound','currency.SHP'),(128,'SIT',2,NULL,NULL,'Slovenian Tolar','currency.SIT'),(129,'SKK',2,NULL,NULL,'Slovak Koruna','currency.SKK'),(130,'SLL',2,NULL,NULL,'Sierra Leone Leone','currency.SLL'),(131,'SOS',2,NULL,NULL,'Somali Shilling','currency.SOS'),(132,'SRD',2,NULL,NULL,'Surinam Dollar','currency.SRD'),(133,'STD',2,NULL,NULL,'Sao Tome and Principe Dobra','currency.STD'),(134,'SVC',2,NULL,NULL,'El Salvador Colon','currency.SVC'),(135,'SYP',2,NULL,NULL,'Syrian Pound','currency.SYP'),(136,'SZL',2,NULL,NULL,'Swaziland Lilangeni','currency.SZL'),(137,'THB',2,NULL,NULL,'Thai Baht','currency.THB'),(138,'TJS',2,NULL,NULL,'Tajik Somoni','currency.TJS'),(139,'TMM',2,NULL,NULL,'Turkmenistan Manat','currency.TMM'),(140,'TND',3,NULL,'DT','Tunisian Dinar','currency.TND'),(141,'TOP',2,NULL,NULL,'Tonga Pa\'anga','currency.TOP'),(142,'TRY',2,NULL,NULL,'Turkish Lira','currency.TRY'),(143,'TTD',2,NULL,NULL,'Trinidad and Tobago Dollar','currency.TTD'),(144,'TWD',2,NULL,NULL,'New Taiwan Dollar','currency.TWD'),(145,'TZS',2,NULL,NULL,'Tanzanian Shilling','currency.TZS'),(146,'UAH',2,NULL,NULL,'Ukraine Hryvnia','currency.UAH'),(147,'UGX',2,NULL,'USh','Uganda Shilling','currency.UGX'),(148,'USD',2,NULL,'$','US Dollar','currency.USD'),(149,'UYU',2,NULL,'$U','Peso Uruguayo','currency.UYU'),(150,'UZS',2,NULL,NULL,'Uzbekistan Sum','currency.UZS'),(151,'VEB',2,NULL,'Bs.F.','Venezuelan Bolivar','currency.VEB'),(152,'VND',2,NULL,NULL,'Vietnamese Dong','currency.VND'),(153,'VUV',0,NULL,NULL,'Vanuatu Vatu','currency.VUV'),(154,'WST',2,NULL,NULL,'Samoa Tala','currency.WST'),(155,'XAF',0,NULL,NULL,'CFA Franc BEAC','currency.XAF'),(156,'XCD',2,NULL,NULL,'East Caribbean Dollar','currency.XCD'),(157,'XDR',5,NULL,NULL,'SDR (Special Drawing Rights)','currency.XDR'),(158,'XOF',0,NULL,'CFA','CFA Franc BCEAO','currency.XOF'),(159,'XPF',0,NULL,NULL,'CFP Franc','currency.XPF'),(160,'YER',2,NULL,NULL,'Yemeni Rial','currency.YER'),(161,'ZAR',2,NULL,'R','South African Rand','currency.ZAR'),(162,'ZMK',2,NULL,NULL,'Zambian Kwacha','currency.ZMK'),(163,'ZWD',2,NULL,NULL,'Zimbabwe Dollar','currency.ZWD');
/*!40000 ALTER TABLE `m_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_account_on_hold_transaction`
--

DROP TABLE IF EXISTS `m_deposit_account_on_hold_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_account_on_hold_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `transaction_type_enum` smallint(1) NOT NULL,
  `transaction_date` date NOT NULL,
  `is_reversed` tinyint(1) NOT NULL DEFAULT '0',
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_deposit_on_hold_transaction_m_savings_account` (`savings_account_id`),
  CONSTRAINT `FK_deposit_on_hold_transaction_m_savings_account` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_account_on_hold_transaction`
--

LOCK TABLES `m_deposit_account_on_hold_transaction` WRITE;
/*!40000 ALTER TABLE `m_deposit_account_on_hold_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_account_on_hold_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_account_recurring_detail`
--

DROP TABLE IF EXISTS `m_deposit_account_recurring_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_account_recurring_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL DEFAULT '0',
  `mandatory_recommended_deposit_amount` decimal(19,6) DEFAULT NULL,
  `is_mandatory` tinyint(4) NOT NULL DEFAULT '0',
  `allow_withdrawal` tinyint(4) NOT NULL DEFAULT '0',
  `adjust_advance_towards_future_payments` tinyint(4) NOT NULL DEFAULT '1',
  `is_calendar_inherited` tinyint(4) NOT NULL DEFAULT '0',
  `total_overdue_amount` decimal(19,6) DEFAULT NULL,
  `no_of_overdue_installments` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKDARD00000000000001` (`savings_account_id`),
  CONSTRAINT `FKDARD00000000000001` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_account_recurring_detail`
--

LOCK TABLES `m_deposit_account_recurring_detail` WRITE;
/*!40000 ALTER TABLE `m_deposit_account_recurring_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_account_recurring_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_account_term_and_preclosure`
--

DROP TABLE IF EXISTS `m_deposit_account_term_and_preclosure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_account_term_and_preclosure` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL DEFAULT '0',
  `min_deposit_term` int(11) DEFAULT NULL,
  `max_deposit_term` int(11) DEFAULT NULL,
  `min_deposit_term_type_enum` smallint(5) DEFAULT NULL,
  `max_deposit_term_type_enum` smallint(5) DEFAULT NULL,
  `in_multiples_of_deposit_term` int(11) DEFAULT NULL,
  `in_multiples_of_deposit_term_type_enum` smallint(5) DEFAULT NULL,
  `pre_closure_penal_applicable` smallint(5) DEFAULT NULL,
  `pre_closure_penal_interest` decimal(19,6) DEFAULT NULL,
  `pre_closure_penal_interest_on_enum` smallint(5) DEFAULT NULL,
  `deposit_period` int(11) DEFAULT NULL,
  `deposit_period_frequency_enum` smallint(5) DEFAULT NULL,
  `deposit_amount` decimal(19,6) DEFAULT NULL,
  `maturity_amount` decimal(19,6) DEFAULT NULL,
  `maturity_date` date DEFAULT NULL,
  `on_account_closure_enum` smallint(5) DEFAULT NULL,
  `expected_firstdepositon_date` date DEFAULT NULL,
  `transfer_interest_to_linked_account` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FKDATP00000000000001` (`savings_account_id`),
  CONSTRAINT `FKDATP00000000000001` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_account_term_and_preclosure`
--

LOCK TABLES `m_deposit_account_term_and_preclosure` WRITE;
/*!40000 ALTER TABLE `m_deposit_account_term_and_preclosure` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_account_term_and_preclosure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_product_interest_rate_chart`
--

DROP TABLE IF EXISTS `m_deposit_product_interest_rate_chart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_product_interest_rate_chart` (
  `deposit_product_id` bigint(20) NOT NULL,
  `interest_rate_chart_id` bigint(20) NOT NULL,
  UNIQUE KEY `deposit_product_id_interest_rate_chart_id` (`deposit_product_id`,`interest_rate_chart_id`),
  KEY `FKDPIRC00000000000002` (`interest_rate_chart_id`),
  CONSTRAINT `FKDPIRC00000000000001` FOREIGN KEY (`deposit_product_id`) REFERENCES `m_savings_product` (`id`),
  CONSTRAINT `FKDPIRC00000000000002` FOREIGN KEY (`interest_rate_chart_id`) REFERENCES `m_interest_rate_chart` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_product_interest_rate_chart`
--

LOCK TABLES `m_deposit_product_interest_rate_chart` WRITE;
/*!40000 ALTER TABLE `m_deposit_product_interest_rate_chart` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_product_interest_rate_chart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_product_recurring_detail`
--

DROP TABLE IF EXISTS `m_deposit_product_recurring_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_product_recurring_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_product_id` bigint(20) NOT NULL DEFAULT '0',
  `is_mandatory` tinyint(1) NOT NULL DEFAULT '1',
  `allow_withdrawal` tinyint(1) NOT NULL DEFAULT '0',
  `adjust_advance_towards_future_payments` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FKDPRD00000000000001` (`savings_product_id`),
  CONSTRAINT `FKDPRD00000000000001` FOREIGN KEY (`savings_product_id`) REFERENCES `m_savings_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_product_recurring_detail`
--

LOCK TABLES `m_deposit_product_recurring_detail` WRITE;
/*!40000 ALTER TABLE `m_deposit_product_recurring_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_product_recurring_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_product_term_and_preclosure`
--

DROP TABLE IF EXISTS `m_deposit_product_term_and_preclosure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_product_term_and_preclosure` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_product_id` bigint(20) NOT NULL DEFAULT '0',
  `min_deposit_term` int(11) DEFAULT NULL,
  `max_deposit_term` int(11) DEFAULT NULL,
  `min_deposit_term_type_enum` smallint(5) DEFAULT NULL,
  `max_deposit_term_type_enum` smallint(5) DEFAULT NULL,
  `in_multiples_of_deposit_term` int(11) DEFAULT NULL,
  `in_multiples_of_deposit_term_type_enum` smallint(5) DEFAULT NULL,
  `pre_closure_penal_applicable` smallint(5) DEFAULT NULL,
  `pre_closure_penal_interest` decimal(19,6) DEFAULT NULL,
  `pre_closure_penal_interest_on_enum` smallint(5) DEFAULT NULL,
  `min_deposit_amount` decimal(19,6) DEFAULT NULL,
  `max_deposit_amount` decimal(19,6) DEFAULT NULL,
  `deposit_amount` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKDPTP00000000000001` (`savings_product_id`),
  CONSTRAINT `FKDPTP00000000000001` FOREIGN KEY (`savings_product_id`) REFERENCES `m_savings_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_product_term_and_preclosure`
--

LOCK TABLES `m_deposit_product_term_and_preclosure` WRITE;
/*!40000 ALTER TABLE `m_deposit_product_term_and_preclosure` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_product_term_and_preclosure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_document`
--

DROP TABLE IF EXISTS `m_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_document` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `parent_entity_type` varchar(50) NOT NULL,
  `parent_entity_id` int(20) NOT NULL DEFAULT '0',
  `name` varchar(250) NOT NULL,
  `file_name` varchar(250) NOT NULL,
  `size` int(20) DEFAULT '0',
  `type` varchar(500) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `location` varchar(500) NOT NULL DEFAULT '0',
  `storage_type_enum` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_document`
--

LOCK TABLES `m_document` WRITE;
/*!40000 ALTER TABLE `m_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_entity_datatable_check`
--

DROP TABLE IF EXISTS `m_entity_datatable_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_entity_datatable_check` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_table_name` varchar(200) NOT NULL,
  `x_registered_table_name` varchar(50) NOT NULL,
  `status_enum` int(11) NOT NULL,
  `system_defined` tinyint(4) NOT NULL DEFAULT '0',
  `product_id` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_check` (`application_table_name`,`x_registered_table_name`,`status_enum`,`product_id`),
  KEY `x_registered_table_name` (`x_registered_table_name`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `m_entity_datatable_check_ibfk_1` FOREIGN KEY (`x_registered_table_name`) REFERENCES `x_registered_table` (`registered_table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_entity_datatable_check`
--

LOCK TABLES `m_entity_datatable_check` WRITE;
/*!40000 ALTER TABLE `m_entity_datatable_check` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_entity_datatable_check` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_entity_relation`
--

DROP TABLE IF EXISTS `m_entity_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_entity_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_entity_type` int(10) NOT NULL,
  `to_entity_type` int(10) NOT NULL,
  `code_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `from_entity_type_to_entity_type_code_name` (`from_entity_type`,`to_entity_type`,`code_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_entity_relation`
--

LOCK TABLES `m_entity_relation` WRITE;
/*!40000 ALTER TABLE `m_entity_relation` DISABLE KEYS */;
INSERT INTO `m_entity_relation` VALUES (1,1,2,'office_access_to_loan_products'),(2,1,3,'office_access_to_savings_products'),(3,1,4,'office_access_to_fees/charges'),(4,5,2,'role_access_to_loan_products'),(5,5,3,'role_access_to_savings_products');
/*!40000 ALTER TABLE `m_entity_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_entity_to_entity_access`
--

DROP TABLE IF EXISTS `m_entity_to_entity_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_entity_to_entity_access` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` bigint(20) NOT NULL,
  `access_type_code_value_id` int(11) NOT NULL,
  `second_entity_type` varchar(50) NOT NULL,
  `second_entity_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_uniq_m_entity_to_entity_access` (`entity_type`,`entity_id`,`access_type_code_value_id`,`second_entity_type`,`second_entity_id`),
  KEY `IDX_OFFICE` (`entity_type`,`entity_id`),
  KEY `FK_access_type_code_m_code_value` (`access_type_code_value_id`),
  CONSTRAINT `FK_access_type_code_m_code_value` FOREIGN KEY (`access_type_code_value_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_entity_to_entity_access`
--

LOCK TABLES `m_entity_to_entity_access` WRITE;
/*!40000 ALTER TABLE `m_entity_to_entity_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_entity_to_entity_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_entity_to_entity_mapping`
--

DROP TABLE IF EXISTS `m_entity_to_entity_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_entity_to_entity_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rel_id` bigint(20) NOT NULL DEFAULT '0',
  `from_id` bigint(20) NOT NULL DEFAULT '0',
  `to_id` bigint(20) unsigned NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rel_id_from_id_to_id` (`rel_id`,`from_id`,`to_id`),
  CONSTRAINT `FK__rel_id_m_entity_relation_id` FOREIGN KEY (`rel_id`) REFERENCES `m_entity_relation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_entity_to_entity_mapping`
--

LOCK TABLES `m_entity_to_entity_mapping` WRITE;
/*!40000 ALTER TABLE `m_entity_to_entity_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_entity_to_entity_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_family_members`
--

DROP TABLE IF EXISTS `m_family_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_family_members` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `middlename` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `qualification` varchar(50) DEFAULT NULL,
  `relationship_cv_id` int(11) NOT NULL,
  `marital_status_cv_id` int(11) DEFAULT NULL,
  `gender_cv_id` int(11) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `profession_cv_id` int(11) DEFAULT NULL,
  `mobile_number` varchar(50) DEFAULT NULL,
  `is_dependent` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_family_members_client_id_m_client` (`client_id`),
  KEY `FK_m_family_members_relationship_m_code_value` (`relationship_cv_id`),
  KEY `FK_m_family_members_marital_status_m_code_value` (`marital_status_cv_id`),
  KEY `FK_m_family_members_gender_m_code_value` (`gender_cv_id`),
  KEY `FK_m_family_members_profession_m_code_value` (`profession_cv_id`),
  CONSTRAINT `FK_m_family_members_client_id_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK_m_family_members_gender_m_code_value` FOREIGN KEY (`gender_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_family_members_marital_status_m_code_value` FOREIGN KEY (`marital_status_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_family_members_profession_m_code_value` FOREIGN KEY (`profession_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_family_members_relationship_m_code_value` FOREIGN KEY (`relationship_cv_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_family_members`
--

LOCK TABLES `m_family_members` WRITE;
/*!40000 ALTER TABLE `m_family_members` DISABLE KEYS */;
INSERT INTO `m_family_members` VALUES (1,1,'Ayuk','Larissa','Livella','',18,15,20,'1993-04-03',25,NULL,'675895562',0),(2,4,'Kamga','Amalia','Ngassa','',18,15,20,'1992-04-10',26,NULL,'675265551',0),(3,5,'Akoh','Raphael','','',29,15,21,'1988-04-02',30,25,'676524819',0),(4,3,'Epie','Coril','','',28,14,20,'1997-10-14',20,24,'677577349',0),(5,6,'Akoko','Mildred','','',30,15,20,'1978-04-02',40,27,'675951599',0),(6,7,'Nkem','Sixtus','','',29,14,21,'1988-02-22',30,27,'678249265',0),(7,8,'Owanji','Bau','Marie','',30,15,20,'1978-02-28',40,26,'677548923',0),(8,9,'Ebong','Paul','Junior','',29,14,21,'1990-04-17',27,25,'671135926',0),(9,10,'Massabe','Kengne','Lydiane','',28,14,20,'1993-04-03',25,24,'675875421',0),(10,11,'Isaac','','Kamga','',29,15,21,'1987-05-28',30,25,'674106958',0),(11,12,'Ngounou','Rachel','','',30,15,20,'1978-04-01',40,26,'675925637',0),(12,13,'Saliki','Justine','','',29,15,21,'1983-01-08',35,26,'678523694',0);
/*!40000 ALTER TABLE `m_family_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_field_configuration`
--

DROP TABLE IF EXISTS `m_field_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_field_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entity` varchar(100) NOT NULL,
  `subentity` varchar(100) NOT NULL,
  `field` varchar(100) NOT NULL,
  `is_enabled` tinyint(4) NOT NULL,
  `is_mandatory` tinyint(4) NOT NULL,
  `validation_regex` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_field_configuration`
--

LOCK TABLES `m_field_configuration` WRITE;
/*!40000 ALTER TABLE `m_field_configuration` DISABLE KEYS */;
INSERT INTO `m_field_configuration` VALUES (1,'ADDRESS','CLIENT','addressType',1,0,''),(2,'ADDRESS','CLIENT','street',1,1,''),(3,'ADDRESS','CLIENT','addressLine1',1,0,''),(4,'ADDRESS','CLIENT','addressLine2',1,0,''),(5,'ADDRESS','CLIENT','addressLine3',1,0,''),(6,'ADDRESS','CLIENT','townVillage',0,0,''),(7,'ADDRESS','CLIENT','city',1,0,''),(8,'ADDRESS','CLIENT','countyDistrict',0,0,''),(9,'ADDRESS','CLIENT','stateProvinceId',1,0,''),(10,'ADDRESS','CLIENT','countryId',1,0,''),(11,'ADDRESS','CLIENT','postalCode',1,0,''),(12,'ADDRESS','CLIENT','latitude',0,0,''),(13,'ADDRESS','CLIENT','longitude',0,0,''),(14,'ADDRESS','CLIENT','createdBy',1,0,''),(15,'ADDRESS','CLIENT','createdOn',1,0,''),(16,'ADDRESS','CLIENT','updatedBy',1,0,''),(17,'ADDRESS','CLIENT','updatedOn',1,0,''),(18,'ADDRESS','CLIENT','isActive',1,0,'');
/*!40000 ALTER TABLE `m_field_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_floating_rates`
--

DROP TABLE IF EXISTS `m_floating_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_floating_rates` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `is_base_lending_rate` bit(1) NOT NULL DEFAULT b'0',
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `createdby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_floating_rates`
--

LOCK TABLES `m_floating_rates` WRITE;
/*!40000 ALTER TABLE `m_floating_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_floating_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_floating_rates_periods`
--

DROP TABLE IF EXISTS `m_floating_rates_periods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_floating_rates_periods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `floating_rates_id` bigint(20) NOT NULL,
  `from_date` datetime NOT NULL,
  `interest_rate` decimal(19,6) NOT NULL,
  `is_differential_to_base_lending_rate` bit(1) NOT NULL DEFAULT b'0',
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `createdby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mappings_m_floating_rates` (`floating_rates_id`),
  CONSTRAINT `FK_mappings_m_floating_rates` FOREIGN KEY (`floating_rates_id`) REFERENCES `m_floating_rates` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_floating_rates_periods`
--

LOCK TABLES `m_floating_rates_periods` WRITE;
/*!40000 ALTER TABLE `m_floating_rates_periods` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_floating_rates_periods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_fund`
--

DROP TABLE IF EXISTS `m_fund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_fund` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fund_name_org` (`name`),
  UNIQUE KEY `fund_externalid_org` (`external_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_fund`
--

LOCK TABLES `m_fund` WRITE;
/*!40000 ALTER TABLE `m_fund` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_fund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_group`
--

DROP TABLE IF EXISTS `m_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `external_id` varchar(100) DEFAULT NULL,
  `status_enum` int(5) NOT NULL DEFAULT '300',
  `activation_date` date DEFAULT NULL,
  `office_id` bigint(20) NOT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `level_id` int(11) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `hierarchy` varchar(100) DEFAULT NULL,
  `closure_reason_cv_id` int(11) DEFAULT NULL,
  `closedon_date` date DEFAULT NULL,
  `activatedon_userid` bigint(20) DEFAULT NULL,
  `submittedon_date` date DEFAULT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `account_no` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`display_name`,`level_id`),
  UNIQUE KEY `external_id` (`external_id`,`level_id`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  KEY `office_id` (`office_id`),
  KEY `staff_id` (`staff_id`),
  KEY `Parent_Id_reference` (`parent_id`),
  KEY `FK_m_group_level` (`level_id`),
  KEY `FK_m_group_m_code` (`closure_reason_cv_id`),
  CONSTRAINT `FK_m_group_level` FOREIGN KEY (`level_id`) REFERENCES `m_group_level` (`id`),
  CONSTRAINT `FK_m_group_m_code` FOREIGN KEY (`closure_reason_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_group_m_staff` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`),
  CONSTRAINT `Parent_Id_reference` FOREIGN KEY (`parent_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `m_group_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_group`
--

LOCK TABLES `m_group` WRITE;
/*!40000 ALTER TABLE `m_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_group_client`
--

DROP TABLE IF EXISTS `m_group_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_group_client` (
  `group_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`group_id`,`client_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `m_group_client_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `m_group_client_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_group_client`
--

LOCK TABLES `m_group_client` WRITE;
/*!40000 ALTER TABLE `m_group_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_group_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_group_level`
--

DROP TABLE IF EXISTS `m_group_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_group_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `super_parent` tinyint(1) NOT NULL,
  `level_name` varchar(100) NOT NULL,
  `recursable` tinyint(1) NOT NULL,
  `can_have_clients` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Parent_levelId_reference` (`parent_id`),
  CONSTRAINT `Parent_levelId_reference` FOREIGN KEY (`parent_id`) REFERENCES `m_group_level` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_group_level`
--

LOCK TABLES `m_group_level` WRITE;
/*!40000 ALTER TABLE `m_group_level` DISABLE KEYS */;
INSERT INTO `m_group_level` VALUES (1,NULL,1,'Center',1,0),(2,1,0,'Group',0,1);
/*!40000 ALTER TABLE `m_group_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_group_roles`
--

DROP TABLE IF EXISTS `m_group_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_group_roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `role_cv_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE_GROUP_ROLES` (`client_id`,`group_id`,`role_cv_id`),
  KEY `FKGroupRoleClientId` (`client_id`),
  KEY `FKGroupRoleGroupId` (`group_id`),
  KEY `FK_grouprole_m_codevalue` (`role_cv_id`),
  CONSTRAINT `FKGroupRoleClientId` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FKGroupRoleGroupId` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FK_grouprole_m_codevalue` FOREIGN KEY (`role_cv_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_group_roles`
--

LOCK TABLES `m_group_roles` WRITE;
/*!40000 ALTER TABLE `m_group_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_group_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_guarantor`
--

DROP TABLE IF EXISTS `m_guarantor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_guarantor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `client_reln_cv_id` int(11) DEFAULT NULL,
  `type_enum` smallint(5) NOT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address_line_1` varchar(500) DEFAULT NULL,
  `address_line_2` varchar(500) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `house_phone_number` varchar(20) DEFAULT NULL,
  `mobile_number` varchar(20) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_m_guarantor_m_loan` (`loan_id`),
  KEY `FK_m_guarantor_m_code_value` (`client_reln_cv_id`),
  CONSTRAINT `FK_m_guarantor_m_code_value` FOREIGN KEY (`client_reln_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_guarantor_m_loan` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_guarantor`
--

LOCK TABLES `m_guarantor` WRITE;
/*!40000 ALTER TABLE `m_guarantor` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_guarantor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_guarantor_funding_details`
--

DROP TABLE IF EXISTS `m_guarantor_funding_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_guarantor_funding_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guarantor_id` bigint(20) NOT NULL,
  `account_associations_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_released_derived` decimal(19,6) DEFAULT NULL,
  `amount_remaining_derived` decimal(19,6) DEFAULT NULL,
  `amount_transfered_derived` decimal(19,6) DEFAULT NULL,
  `status_enum` smallint(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_guarantor_fund_details_m_guarantor` (`guarantor_id`),
  KEY `FK_m_guarantor_fund_details_account_associations_id` (`account_associations_id`),
  CONSTRAINT `FK_m_guarantor_fund_details_account_associations_id` FOREIGN KEY (`account_associations_id`) REFERENCES `m_portfolio_account_associations` (`id`),
  CONSTRAINT `FK_m_guarantor_fund_details_m_guarantor` FOREIGN KEY (`guarantor_id`) REFERENCES `m_guarantor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_guarantor_funding_details`
--

LOCK TABLES `m_guarantor_funding_details` WRITE;
/*!40000 ALTER TABLE `m_guarantor_funding_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_guarantor_funding_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_guarantor_transaction`
--

DROP TABLE IF EXISTS `m_guarantor_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_guarantor_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guarantor_fund_detail_id` bigint(20) NOT NULL,
  `loan_transaction_id` bigint(20) DEFAULT NULL,
  `deposit_on_hold_transaction_id` bigint(20) NOT NULL,
  `is_reversed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_guarantor_transaction_m_deposit_account_on_hold_transaction` (`deposit_on_hold_transaction_id`),
  KEY `FK_guarantor_transaction_guarantor_fund_detail` (`guarantor_fund_detail_id`),
  KEY `FK_guarantor_transaction_m_loan_transaction` (`loan_transaction_id`),
  CONSTRAINT `FK_guarantor_transaction_guarantor_fund_detail` FOREIGN KEY (`guarantor_fund_detail_id`) REFERENCES `m_guarantor_funding_details` (`id`),
  CONSTRAINT `FK_guarantor_transaction_m_deposit_account_on_hold_transaction` FOREIGN KEY (`deposit_on_hold_transaction_id`) REFERENCES `m_deposit_account_on_hold_transaction` (`id`),
  CONSTRAINT `FK_guarantor_transaction_m_loan_transaction` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_guarantor_transaction`
--

LOCK TABLES `m_guarantor_transaction` WRITE;
/*!40000 ALTER TABLE `m_guarantor_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_guarantor_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_holiday`
--

DROP TABLE IF EXISTS `m_holiday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_holiday` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `from_date` datetime NOT NULL,
  `to_date` datetime NOT NULL,
  `repayments_rescheduled_to` datetime DEFAULT NULL,
  `status_enum` int(5) NOT NULL DEFAULT '100',
  `processed` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(100) DEFAULT NULL,
  `rescheduling_type` int(5) NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`),
  UNIQUE KEY `holiday_name` (`name`,`from_date`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_holiday`
--

LOCK TABLES `m_holiday` WRITE;
/*!40000 ALTER TABLE `m_holiday` DISABLE KEYS */;
INSERT INTO `m_holiday` VALUES (1,'LABOR DAY','2018-04-30 00:00:00','2018-05-01 00:00:00',NULL,100,0,'Labor Day',1);
/*!40000 ALTER TABLE `m_holiday` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_holiday_office`
--

DROP TABLE IF EXISTS `m_holiday_office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_holiday_office` (
  `holiday_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  PRIMARY KEY (`holiday_id`,`office_id`),
  KEY `m_holiday_id_ibfk_1` (`holiday_id`),
  KEY `m_office_id_ibfk_2` (`office_id`),
  CONSTRAINT `m_holiday_id_ibfk_1` FOREIGN KEY (`holiday_id`) REFERENCES `m_holiday` (`id`),
  CONSTRAINT `m_office_id_ibfk_2` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_holiday_office`
--

LOCK TABLES `m_holiday_office` WRITE;
/*!40000 ALTER TABLE `m_holiday_office` DISABLE KEYS */;
INSERT INTO `m_holiday_office` VALUES (1,2);
/*!40000 ALTER TABLE `m_holiday_office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_hook`
--

DROP TABLE IF EXISTS `m_hook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_hook` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `template_id` smallint(6) NOT NULL,
  `is_active` smallint(3) NOT NULL DEFAULT '1',
  `name` varchar(45) NOT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `ugd_template_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_template_id_idx` (`template_id`),
  KEY `fk_ugd_template_id` (`ugd_template_id`),
  CONSTRAINT `fk_template_id` FOREIGN KEY (`template_id`) REFERENCES `m_hook_templates` (`id`),
  CONSTRAINT `fk_ugd_template_id` FOREIGN KEY (`ugd_template_id`) REFERENCES `m_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_hook`
--

LOCK TABLES `m_hook` WRITE;
/*!40000 ALTER TABLE `m_hook` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_hook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_hook_configuration`
--

DROP TABLE IF EXISTS `m_hook_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_hook_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hook_id` bigint(20) DEFAULT NULL,
  `field_type` varchar(45) NOT NULL,
  `field_name` varchar(100) NOT NULL,
  `field_value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_hook_id_idx` (`hook_id`),
  CONSTRAINT `fk_hook_id_cfg` FOREIGN KEY (`hook_id`) REFERENCES `m_hook` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_hook_configuration`
--

LOCK TABLES `m_hook_configuration` WRITE;
/*!40000 ALTER TABLE `m_hook_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_hook_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_hook_registered_events`
--

DROP TABLE IF EXISTS `m_hook_registered_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_hook_registered_events` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hook_id` bigint(20) NOT NULL,
  `entity_name` varchar(45) NOT NULL,
  `action_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_hook_id_idx` (`hook_id`),
  CONSTRAINT `fk_hook_idc` FOREIGN KEY (`hook_id`) REFERENCES `m_hook` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_hook_registered_events`
--

LOCK TABLES `m_hook_registered_events` WRITE;
/*!40000 ALTER TABLE `m_hook_registered_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_hook_registered_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_hook_schema`
--

DROP TABLE IF EXISTS `m_hook_schema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_hook_schema` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `hook_template_id` smallint(6) NOT NULL,
  `field_type` varchar(45) NOT NULL,
  `field_name` varchar(100) NOT NULL,
  `placeholder` varchar(100) DEFAULT NULL,
  `optional` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_hook_template_id_idx` (`hook_template_id`),
  CONSTRAINT `fk_hook_template_id` FOREIGN KEY (`hook_template_id`) REFERENCES `m_hook_templates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_hook_schema`
--

LOCK TABLES `m_hook_schema` WRITE;
/*!40000 ALTER TABLE `m_hook_schema` DISABLE KEYS */;
INSERT INTO `m_hook_schema` VALUES (1,1,'string','Payload URL',NULL,0),(2,1,'string','Content Type','json / form',0),(3,2,'string','Payload URL',NULL,0),(4,2,'string','SMS Provider',NULL,0),(5,2,'string','Phone Number',NULL,0),(6,2,'string','SMS Provider Token',NULL,0),(7,2,'string','SMS Provider Account Id',NULL,0);
/*!40000 ALTER TABLE `m_hook_schema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_hook_templates`
--

DROP TABLE IF EXISTS `m_hook_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_hook_templates` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_hook_templates`
--

LOCK TABLES `m_hook_templates` WRITE;
/*!40000 ALTER TABLE `m_hook_templates` DISABLE KEYS */;
INSERT INTO `m_hook_templates` VALUES (1,'Web'),(2,'SMS Bridge');
/*!40000 ALTER TABLE `m_hook_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_image`
--

DROP TABLE IF EXISTS `m_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_image` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `location` varchar(500) DEFAULT NULL,
  `storage_type_enum` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_image`
--

LOCK TABLES `m_image` WRITE;
/*!40000 ALTER TABLE `m_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_import_document`
--

DROP TABLE IF EXISTS `m_import_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_import_document` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `document_id` int(20) NOT NULL,
  `import_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `entity_type` tinyint(3) NOT NULL,
  `completed` tinyint(2) DEFAULT '0',
  `total_records` bigint(20) DEFAULT '0',
  `success_count` bigint(20) DEFAULT '0',
  `failure_count` bigint(20) DEFAULT '0',
  `createdby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `import_document_id` (`document_id`),
  KEY `FK_m_import_m_appuser` (`createdby_id`),
  CONSTRAINT `FK_m_import_m_appuser` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_import_m_document` FOREIGN KEY (`document_id`) REFERENCES `m_document` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_import_document`
--

LOCK TABLES `m_import_document` WRITE;
/*!40000 ALTER TABLE `m_import_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_import_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_interest_incentives`
--

DROP TABLE IF EXISTS `m_interest_incentives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_interest_incentives` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `interest_rate_slab_id` bigint(20) NOT NULL,
  `entiry_type` smallint(2) NOT NULL,
  `attribute_name` smallint(2) NOT NULL,
  `condition_type` smallint(2) NOT NULL,
  `attribute_value` varchar(50) NOT NULL,
  `incentive_type` smallint(2) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_interest_incentives_m_interest_rate_slab` (`interest_rate_slab_id`),
  CONSTRAINT `FK_m_interest_incentives_m_interest_rate_slab` FOREIGN KEY (`interest_rate_slab_id`) REFERENCES `m_interest_rate_slab` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_interest_incentives`
--

LOCK TABLES `m_interest_incentives` WRITE;
/*!40000 ALTER TABLE `m_interest_incentives` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_interest_incentives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_interest_rate_chart`
--

DROP TABLE IF EXISTS `m_interest_rate_chart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_interest_rate_chart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `from_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `is_primary_grouping_by_amount` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_interest_rate_chart`
--

LOCK TABLES `m_interest_rate_chart` WRITE;
/*!40000 ALTER TABLE `m_interest_rate_chart` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_interest_rate_chart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_interest_rate_slab`
--

DROP TABLE IF EXISTS `m_interest_rate_slab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_interest_rate_slab` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `interest_rate_chart_id` bigint(20) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `period_type_enum` smallint(5) DEFAULT NULL,
  `from_period` int(11) DEFAULT NULL,
  `to_period` int(11) DEFAULT NULL,
  `amount_range_from` decimal(19,6) DEFAULT NULL,
  `amount_range_to` decimal(19,6) DEFAULT NULL,
  `annual_interest_rate` decimal(19,6) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKIRS00000000000001` (`interest_rate_chart_id`),
  CONSTRAINT `FKIRS00000000000001` FOREIGN KEY (`interest_rate_chart_id`) REFERENCES `m_interest_rate_chart` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_interest_rate_slab`
--

LOCK TABLES `m_interest_rate_slab` WRITE;
/*!40000 ALTER TABLE `m_interest_rate_slab` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_interest_rate_slab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan`
--

DROP TABLE IF EXISTS `m_loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_no` varchar(20) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `fund_id` bigint(20) DEFAULT NULL,
  `loan_officer_id` bigint(20) DEFAULT NULL,
  `loanpurpose_cv_id` int(11) DEFAULT NULL,
  `loan_status_id` smallint(5) NOT NULL,
  `loan_type_enum` smallint(5) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `principal_amount_proposed` decimal(19,6) NOT NULL,
  `principal_amount` decimal(19,6) NOT NULL,
  `approved_principal` decimal(19,6) NOT NULL,
  `arrearstolerance_amount` decimal(19,6) DEFAULT NULL,
  `is_floating_interest_rate` bit(1) DEFAULT b'0',
  `interest_rate_differential` decimal(19,6) DEFAULT '0.000000',
  `nominal_interest_rate_per_period` decimal(19,6) DEFAULT NULL,
  `interest_period_frequency_enum` smallint(5) DEFAULT NULL,
  `annual_nominal_interest_rate` decimal(19,6) DEFAULT NULL,
  `interest_method_enum` smallint(5) NOT NULL,
  `interest_calculated_in_period_enum` smallint(5) NOT NULL DEFAULT '1',
  `allow_partial_period_interest_calcualtion` tinyint(1) NOT NULL DEFAULT '0',
  `term_frequency` smallint(5) NOT NULL DEFAULT '0',
  `term_period_frequency_enum` smallint(5) NOT NULL DEFAULT '2',
  `repay_every` smallint(5) NOT NULL,
  `repayment_period_frequency_enum` smallint(5) NOT NULL,
  `number_of_repayments` smallint(5) NOT NULL,
  `grace_on_principal_periods` smallint(5) DEFAULT NULL,
  `recurring_moratorium_principal_periods` smallint(5) DEFAULT NULL,
  `grace_on_interest_periods` smallint(5) DEFAULT NULL,
  `grace_interest_free_periods` smallint(5) DEFAULT NULL,
  `amortization_method_enum` smallint(5) NOT NULL,
  `submittedon_date` date DEFAULT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `approvedon_date` date DEFAULT NULL,
  `approvedon_userid` bigint(20) DEFAULT NULL,
  `expected_disbursedon_date` date DEFAULT NULL,
  `expected_firstrepaymenton_date` date DEFAULT NULL,
  `interest_calculated_from_date` date DEFAULT NULL,
  `disbursedon_date` date DEFAULT NULL,
  `disbursedon_userid` bigint(20) DEFAULT NULL,
  `expected_maturedon_date` date DEFAULT NULL,
  `maturedon_date` date DEFAULT NULL,
  `closedon_date` date DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `total_charges_due_at_disbursement_derived` decimal(19,6) DEFAULT NULL,
  `principal_disbursed_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `principal_repaid_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `principal_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `principal_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_charged_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_repaid_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_waived_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_charged_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_repaid_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_waived_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_charged_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_repaid_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_waived_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_expected_repayment_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_repayment_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_expected_costofloan_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_costofloan_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_waived_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_overpaid_derived` decimal(19,6) DEFAULT NULL,
  `rejectedon_date` date DEFAULT NULL,
  `rejectedon_userid` bigint(20) DEFAULT NULL,
  `rescheduledon_date` date DEFAULT NULL,
  `rescheduledon_userid` bigint(20) DEFAULT NULL,
  `withdrawnon_date` date DEFAULT NULL,
  `withdrawnon_userid` bigint(20) DEFAULT NULL,
  `writtenoffon_date` date DEFAULT NULL,
  `loan_transaction_strategy_id` bigint(20) DEFAULT NULL,
  `sync_disbursement_with_meeting` tinyint(1) DEFAULT NULL,
  `loan_counter` smallint(6) DEFAULT NULL,
  `loan_product_counter` smallint(6) DEFAULT NULL,
  `fixed_emi_amount` decimal(19,6) DEFAULT NULL,
  `max_outstanding_loan_balance` decimal(19,6) DEFAULT NULL,
  `grace_on_arrears_ageing` smallint(5) DEFAULT NULL,
  `is_npa` tinyint(1) NOT NULL DEFAULT '0',
  `total_recovered_derived` decimal(19,6) DEFAULT NULL,
  `accrued_till` date DEFAULT NULL,
  `interest_recalcualated_on` date DEFAULT NULL,
  `days_in_month_enum` smallint(5) NOT NULL DEFAULT '1',
  `days_in_year_enum` smallint(5) NOT NULL DEFAULT '1',
  `interest_recalculation_enabled` tinyint(4) NOT NULL DEFAULT '0',
  `guarantee_amount_derived` decimal(19,6) DEFAULT NULL,
  `create_standing_instruction_at_disbursement` tinyint(1) DEFAULT NULL,
  `version` int(15) NOT NULL DEFAULT '1',
  `writeoff_reason_cv_id` int(11) DEFAULT NULL,
  `loan_sub_status_id` smallint(5) DEFAULT NULL,
  `is_topup` tinyint(1) NOT NULL DEFAULT '0',
  `is_equal_amortization` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `loan_account_no_UNIQUE` (`account_no`),
  UNIQUE KEY `loan_externalid_UNIQUE` (`external_id`),
  KEY `FKB6F935D87179A0CB` (`client_id`),
  KEY `FKB6F935D8C8D4B434` (`product_id`),
  KEY `FK7C885877240145` (`fund_id`),
  KEY `FK_loan_ltp_strategy` (`loan_transaction_strategy_id`),
  KEY `FK_m_loan_m_staff` (`loan_officer_id`),
  KEY `group_id` (`group_id`),
  KEY `FK_m_loanpurpose_codevalue` (`loanpurpose_cv_id`),
  KEY `FK_submittedon_userid` (`submittedon_userid`),
  KEY `FK_approvedon_userid` (`approvedon_userid`),
  KEY `FK_rejectedon_userid` (`rejectedon_userid`),
  KEY `FK_withdrawnon_userid` (`withdrawnon_userid`),
  KEY `FK_disbursedon_userid` (`disbursedon_userid`),
  KEY `FK_closedon_userid` (`closedon_userid`),
  KEY `fk_m_group_client_001_idx` (`group_id`,`client_id`),
  KEY `FK_writeoffreason_m_loan_m_code_value` (`writeoff_reason_cv_id`),
  CONSTRAINT `FK7C885877240145` FOREIGN KEY (`fund_id`) REFERENCES `m_fund` (`id`),
  CONSTRAINT `FKB6F935D87179A0CB` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FKB6F935D8C8D4B434` FOREIGN KEY (`product_id`) REFERENCES `m_product_loan` (`id`),
  CONSTRAINT `FK_approvedon_userid` FOREIGN KEY (`approvedon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_closedon_userid` FOREIGN KEY (`closedon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_disbursedon_userid` FOREIGN KEY (`disbursedon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_loan_ltp_strategy` FOREIGN KEY (`loan_transaction_strategy_id`) REFERENCES `ref_loan_transaction_processing_strategy` (`id`),
  CONSTRAINT `FK_m_loan_m_staff` FOREIGN KEY (`loan_officer_id`) REFERENCES `m_staff` (`id`),
  CONSTRAINT `FK_m_loanpurpose_codevalue` FOREIGN KEY (`loanpurpose_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_rejectedon_userid` FOREIGN KEY (`rejectedon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_submittedon_userid` FOREIGN KEY (`submittedon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_withdrawnon_userid` FOREIGN KEY (`withdrawnon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_writeoffreason_m_loan_m_code_value` FOREIGN KEY (`writeoff_reason_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `m_loan_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan`
--

LOCK TABLES `m_loan` WRITE;
/*!40000 ALTER TABLE `m_loan` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_arrears_aging`
--

DROP TABLE IF EXISTS `m_loan_arrears_aging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_arrears_aging` (
  `loan_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `principal_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `overdue_since_date_derived` date DEFAULT NULL,
  PRIMARY KEY (`loan_id`),
  CONSTRAINT `m_loan_arrears_aging_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_arrears_aging`
--

LOCK TABLES `m_loan_arrears_aging` WRITE;
/*!40000 ALTER TABLE `m_loan_arrears_aging` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_arrears_aging` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_charge`
--

DROP TABLE IF EXISTS `m_loan_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  `is_penalty` tinyint(1) NOT NULL DEFAULT '0',
  `charge_time_enum` smallint(5) NOT NULL,
  `due_for_collection_as_of_date` date DEFAULT NULL,
  `charge_calculation_enum` smallint(5) NOT NULL,
  `charge_payment_mode_enum` smallint(5) NOT NULL DEFAULT '0',
  `calculation_percentage` decimal(19,6) DEFAULT NULL,
  `calculation_on_amount` decimal(19,6) DEFAULT NULL,
  `charge_amount_or_percentage` decimal(19,6) DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_paid_derived` decimal(19,6) DEFAULT NULL,
  `amount_waived_derived` decimal(19,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `is_paid_derived` tinyint(1) NOT NULL DEFAULT '0',
  `waived` tinyint(1) NOT NULL DEFAULT '0',
  `min_cap` decimal(19,6) DEFAULT NULL,
  `max_cap` decimal(19,6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `charge_id` (`charge_id`),
  KEY `m_loan_charge_ibfk_2` (`loan_id`),
  CONSTRAINT `m_loan_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_loan_charge_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_charge`
--

LOCK TABLES `m_loan_charge` WRITE;
/*!40000 ALTER TABLE `m_loan_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_charge_paid_by`
--

DROP TABLE IF EXISTS `m_loan_charge_paid_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_charge_paid_by` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_transaction_id` bigint(20) NOT NULL,
  `loan_charge_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `installment_number` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__m_loan_transaction` (`loan_transaction_id`),
  KEY `FK__m_loan_charge` (`loan_charge_id`),
  CONSTRAINT `FK__m_loan_charge` FOREIGN KEY (`loan_charge_id`) REFERENCES `m_loan_charge` (`id`),
  CONSTRAINT `FK__m_loan_transaction` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_charge_paid_by`
--

LOCK TABLES `m_loan_charge_paid_by` WRITE;
/*!40000 ALTER TABLE `m_loan_charge_paid_by` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_charge_paid_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_collateral`
--

DROP TABLE IF EXISTS `m_loan_collateral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_collateral` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `type_cv_id` int(11) NOT NULL,
  `value` decimal(19,6) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_collateral_m_loan` (`loan_id`),
  KEY `FK_collateral_code_value` (`type_cv_id`),
  CONSTRAINT `FK_collateral_code_value` FOREIGN KEY (`type_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_collateral_m_loan` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_collateral`
--

LOCK TABLES `m_loan_collateral` WRITE;
/*!40000 ALTER TABLE `m_loan_collateral` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_collateral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_disbursement_detail`
--

DROP TABLE IF EXISTS `m_loan_disbursement_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_disbursement_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `expected_disburse_date` datetime NOT NULL,
  `disbursedon_date` datetime DEFAULT NULL,
  `principal` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_loan_disbursement_detail_loan_id` (`loan_id`),
  CONSTRAINT `FK_loan_disbursement_detail_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_disbursement_detail`
--

LOCK TABLES `m_loan_disbursement_detail` WRITE;
/*!40000 ALTER TABLE `m_loan_disbursement_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_disbursement_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_installment_charge`
--

DROP TABLE IF EXISTS `m_loan_installment_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_installment_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_charge_id` bigint(20) NOT NULL,
  `loan_schedule_id` bigint(20) NOT NULL,
  `due_date` date DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_paid_derived` decimal(19,6) DEFAULT NULL,
  `amount_waived_derived` decimal(19,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `is_paid_derived` tinyint(1) NOT NULL DEFAULT '0',
  `waived` tinyint(1) NOT NULL DEFAULT '0',
  `amount_through_charge_payment` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_loan_charge_id_charge_schedule` (`loan_charge_id`),
  KEY `FK_loan_schedule_id_charge_schedule` (`loan_schedule_id`),
  CONSTRAINT `FK_loan_charge_id_charge_schedule` FOREIGN KEY (`loan_charge_id`) REFERENCES `m_loan_charge` (`id`),
  CONSTRAINT `FK_loan_schedule_id_charge_schedule` FOREIGN KEY (`loan_schedule_id`) REFERENCES `m_loan_repayment_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_installment_charge`
--

LOCK TABLES `m_loan_installment_charge` WRITE;
/*!40000 ALTER TABLE `m_loan_installment_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_installment_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_interest_recalculation_additional_details`
--

DROP TABLE IF EXISTS `m_loan_interest_recalculation_additional_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_interest_recalculation_additional_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_repayment_schedule_id` bigint(20) NOT NULL,
  `effective_date` date NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_additional_details_repayment_schedule_id` (`loan_repayment_schedule_id`),
  CONSTRAINT `FK_additional_details_repayment_schedule_id` FOREIGN KEY (`loan_repayment_schedule_id`) REFERENCES `m_loan_repayment_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_interest_recalculation_additional_details`
--

LOCK TABLES `m_loan_interest_recalculation_additional_details` WRITE;
/*!40000 ALTER TABLE `m_loan_interest_recalculation_additional_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_interest_recalculation_additional_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_officer_assignment_history`
--

DROP TABLE IF EXISTS `m_loan_officer_assignment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_officer_assignment_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `loan_officer_id` bigint(20) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_m_loan_officer_assignment_history_0001` (`loan_id`),
  KEY `fk_m_loan_officer_assignment_history_0002` (`loan_officer_id`),
  CONSTRAINT `fk_m_loan_officer_assignment_history_0001` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `fk_m_loan_officer_assignment_history_0002` FOREIGN KEY (`loan_officer_id`) REFERENCES `m_staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_officer_assignment_history`
--

LOCK TABLES `m_loan_officer_assignment_history` WRITE;
/*!40000 ALTER TABLE `m_loan_officer_assignment_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_officer_assignment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_overdue_installment_charge`
--

DROP TABLE IF EXISTS `m_loan_overdue_installment_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_overdue_installment_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_charge_id` bigint(20) NOT NULL,
  `loan_schedule_id` bigint(20) NOT NULL,
  `frequency_number` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_loan_overdue_installment_charge_m_loan_charge` (`loan_charge_id`),
  KEY `FK_m_loan_overdue_installment_charge_m_loan_repayment_schedule` (`loan_schedule_id`),
  CONSTRAINT `FK_m_loan_overdue_installment_charge_m_loan_charge` FOREIGN KEY (`loan_charge_id`) REFERENCES `m_loan_charge` (`id`),
  CONSTRAINT `FK_m_loan_overdue_installment_charge_m_loan_repayment_schedule` FOREIGN KEY (`loan_schedule_id`) REFERENCES `m_loan_repayment_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_overdue_installment_charge`
--

LOCK TABLES `m_loan_overdue_installment_charge` WRITE;
/*!40000 ALTER TABLE `m_loan_overdue_installment_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_overdue_installment_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_paid_in_advance`
--

DROP TABLE IF EXISTS `m_loan_paid_in_advance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_paid_in_advance` (
  `loan_id` bigint(20) NOT NULL,
  `principal_in_advance_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_in_advance_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_in_advance_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_in_advance_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_in_advance_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`loan_id`),
  CONSTRAINT `m_loan_paid_in_advance_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_paid_in_advance`
--

LOCK TABLES `m_loan_paid_in_advance` WRITE;
/*!40000 ALTER TABLE `m_loan_paid_in_advance` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_paid_in_advance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_recalculation_details`
--

DROP TABLE IF EXISTS `m_loan_recalculation_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_recalculation_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `compound_type_enum` smallint(5) NOT NULL,
  `reschedule_strategy_enum` smallint(5) NOT NULL,
  `rest_frequency_type_enum` smallint(1) NOT NULL,
  `rest_frequency_interval` smallint(3) NOT NULL DEFAULT '0',
  `compounding_frequency_type_enum` smallint(1) DEFAULT NULL,
  `compounding_frequency_interval` smallint(3) DEFAULT NULL,
  `rest_frequency_nth_day_enum` int(5) DEFAULT NULL,
  `rest_frequency_on_day` int(5) DEFAULT NULL,
  `rest_frequency_weekday_enum` int(5) DEFAULT NULL,
  `compounding_frequency_nth_day_enum` int(5) DEFAULT NULL,
  `compounding_frequency_on_day` int(5) DEFAULT NULL,
  `is_compounding_to_be_posted_as_transaction` tinyint(1) NOT NULL DEFAULT '0',
  `compounding_frequency_weekday_enum` int(5) DEFAULT NULL,
  `allow_compounding_on_eod` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_m_loan_m_loan_recalculation_details` (`loan_id`),
  CONSTRAINT `FK_m_loan_m_loan_recalculation_details` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_recalculation_details`
--

LOCK TABLES `m_loan_recalculation_details` WRITE;
/*!40000 ALTER TABLE `m_loan_recalculation_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_recalculation_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_repayment_schedule`
--

DROP TABLE IF EXISTS `m_loan_repayment_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_repayment_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `fromdate` date DEFAULT NULL,
  `duedate` date NOT NULL,
  `installment` smallint(5) NOT NULL,
  `principal_amount` decimal(19,6) DEFAULT NULL,
  `principal_completed_derived` decimal(19,6) DEFAULT NULL,
  `principal_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `interest_amount` decimal(19,6) DEFAULT NULL,
  `interest_completed_derived` decimal(19,6) DEFAULT NULL,
  `interest_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `interest_waived_derived` decimal(19,6) DEFAULT NULL,
  `accrual_interest_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_amount` decimal(19,6) DEFAULT NULL,
  `fee_charges_completed_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_waived_derived` decimal(19,6) DEFAULT NULL,
  `accrual_fee_charges_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_amount` decimal(19,6) DEFAULT NULL,
  `penalty_charges_completed_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_waived_derived` decimal(19,6) DEFAULT NULL,
  `accrual_penalty_charges_derived` decimal(19,6) DEFAULT NULL,
  `total_paid_in_advance_derived` decimal(19,6) DEFAULT NULL,
  `total_paid_late_derived` decimal(19,6) DEFAULT NULL,
  `completed_derived` bit(1) NOT NULL,
  `obligations_met_on_date` date DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `recalculated_interest_component` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK488B92AA40BE0710` (`loan_id`),
  CONSTRAINT `FK488B92AA40BE0710` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_repayment_schedule`
--

LOCK TABLES `m_loan_repayment_schedule` WRITE;
/*!40000 ALTER TABLE `m_loan_repayment_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_repayment_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_repayment_schedule_history`
--

DROP TABLE IF EXISTS `m_loan_repayment_schedule_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_repayment_schedule_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `loan_reschedule_request_id` bigint(20) DEFAULT NULL,
  `fromdate` date DEFAULT NULL,
  `duedate` date NOT NULL,
  `installment` smallint(5) NOT NULL,
  `principal_amount` decimal(19,6) DEFAULT NULL,
  `interest_amount` decimal(19,6) DEFAULT NULL,
  `fee_charges_amount` decimal(19,6) DEFAULT NULL,
  `penalty_charges_amount` decimal(19,6) DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `version` int(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_id` (`loan_id`),
  KEY `loan_reschedule_request_id` (`loan_reschedule_request_id`),
  CONSTRAINT `m_loan_repayment_schedule_history_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `m_loan_repayment_schedule_history_ibfk_2` FOREIGN KEY (`loan_reschedule_request_id`) REFERENCES `m_loan_reschedule_request` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_repayment_schedule_history`
--

LOCK TABLES `m_loan_repayment_schedule_history` WRITE;
/*!40000 ALTER TABLE `m_loan_repayment_schedule_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_repayment_schedule_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_reschedule_request`
--

DROP TABLE IF EXISTS `m_loan_reschedule_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_reschedule_request` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `status_enum` smallint(5) NOT NULL,
  `reschedule_from_installment` smallint(5) NOT NULL COMMENT 'Rescheduling will start from this installment',
  `reschedule_from_date` date NOT NULL COMMENT 'Rescheduling will start from the installment with due date similar to this date.',
  `recalculate_interest` tinyint(1) DEFAULT NULL COMMENT 'If set to 1, interest will be recalculated starting from the reschedule period.',
  `reschedule_reason_cv_id` int(11) DEFAULT NULL COMMENT 'ID of code value of reason for rescheduling',
  `reschedule_reason_comment` varchar(500) DEFAULT NULL COMMENT 'Text provided in addition to the reason code value',
  `submitted_on_date` date NOT NULL,
  `submitted_by_user_id` bigint(20) NOT NULL,
  `approved_on_date` date DEFAULT NULL,
  `approved_by_user_id` bigint(20) DEFAULT NULL,
  `rejected_on_date` date DEFAULT NULL,
  `rejected_by_user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_id` (`loan_id`),
  KEY `reschedule_reason_cv_id` (`reschedule_reason_cv_id`),
  KEY `submitted_by_user_id` (`submitted_by_user_id`),
  KEY `approved_by_user_id` (`approved_by_user_id`),
  KEY `rejected_by_user_id` (`rejected_by_user_id`),
  CONSTRAINT `m_loan_reschedule_request_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `m_loan_reschedule_request_ibfk_2` FOREIGN KEY (`reschedule_reason_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `m_loan_reschedule_request_ibfk_3` FOREIGN KEY (`submitted_by_user_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_loan_reschedule_request_ibfk_4` FOREIGN KEY (`approved_by_user_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_loan_reschedule_request_ibfk_5` FOREIGN KEY (`rejected_by_user_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_reschedule_request`
--

LOCK TABLES `m_loan_reschedule_request` WRITE;
/*!40000 ALTER TABLE `m_loan_reschedule_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_reschedule_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_reschedule_request_term_variations_mapping`
--

DROP TABLE IF EXISTS `m_loan_reschedule_request_term_variations_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_reschedule_request_term_variations_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_reschedule_request_id` bigint(20) NOT NULL,
  `loan_term_variations_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__m_loan_reschedule_request` (`loan_reschedule_request_id`),
  KEY `FK__m_loan_term_variations` (`loan_term_variations_id`),
  CONSTRAINT `FK__m_loan_reschedule_request` FOREIGN KEY (`loan_reschedule_request_id`) REFERENCES `m_loan_reschedule_request` (`id`),
  CONSTRAINT `FK__m_loan_term_variations` FOREIGN KEY (`loan_term_variations_id`) REFERENCES `m_loan_term_variations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_reschedule_request_term_variations_mapping`
--

LOCK TABLES `m_loan_reschedule_request_term_variations_mapping` WRITE;
/*!40000 ALTER TABLE `m_loan_reschedule_request_term_variations_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_reschedule_request_term_variations_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_term_variations`
--

DROP TABLE IF EXISTS `m_loan_term_variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_term_variations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `term_type` smallint(2) NOT NULL,
  `applicable_date` date NOT NULL,
  `decimal_value` decimal(19,6) DEFAULT NULL,
  `date_value` date DEFAULT NULL,
  `is_specific_to_installment` tinyint(4) NOT NULL DEFAULT '0',
  `applied_on_loan_status` smallint(5) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_loan_id_m_loan_id` (`loan_id`),
  CONSTRAINT `FK_loan_id_m_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_term_variations`
--

LOCK TABLES `m_loan_term_variations` WRITE;
/*!40000 ALTER TABLE `m_loan_term_variations` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_term_variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_topup`
--

DROP TABLE IF EXISTS `m_loan_topup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_topup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `closure_loan_id` bigint(20) NOT NULL,
  `account_transfer_details_id` bigint(20) DEFAULT NULL,
  `topup_amount` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `m_loan_topup_FK_loan_id` (`loan_id`),
  KEY `m_loan_topup_FK_closure_loan_id` (`closure_loan_id`),
  KEY `m_loan_topup_FK_account_transfer_details_id` (`account_transfer_details_id`),
  CONSTRAINT `m_loan_topup_FK_account_transfer_details_id` FOREIGN KEY (`account_transfer_details_id`) REFERENCES `m_account_transfer_details` (`id`),
  CONSTRAINT `m_loan_topup_FK_closure_loan_id` FOREIGN KEY (`closure_loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `m_loan_topup_FK_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_topup`
--

LOCK TABLES `m_loan_topup` WRITE;
/*!40000 ALTER TABLE `m_loan_topup` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_topup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_tranche_charges`
--

DROP TABLE IF EXISTS `m_loan_tranche_charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_tranche_charges` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_loan_tranche_charges_m_loan` (`loan_id`),
  KEY `FK_m_loan_tranche_charges_m_charge` (`charge_id`),
  CONSTRAINT `FK_m_loan_tranche_charges_m_charge` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `FK_m_loan_tranche_charges_m_loan` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_tranche_charges`
--

LOCK TABLES `m_loan_tranche_charges` WRITE;
/*!40000 ALTER TABLE `m_loan_tranche_charges` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_tranche_charges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_tranche_disbursement_charge`
--

DROP TABLE IF EXISTS `m_loan_tranche_disbursement_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_tranche_disbursement_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_charge_id` bigint(20) NOT NULL,
  `disbursement_detail_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_loan_tranche_disbursement_charge_m_loan_charge` (`loan_charge_id`),
  KEY `FK_m_loan_tranche_disbursement_charge_m_loan_disbursement_detail` (`disbursement_detail_id`),
  CONSTRAINT `FK_m_loan_tranche_disbursement_charge_m_loan_charge` FOREIGN KEY (`loan_charge_id`) REFERENCES `m_loan_charge` (`id`),
  CONSTRAINT `FK_m_loan_tranche_disbursement_charge_m_loan_disbursement_detail` FOREIGN KEY (`disbursement_detail_id`) REFERENCES `m_loan_disbursement_detail` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_tranche_disbursement_charge`
--

LOCK TABLES `m_loan_tranche_disbursement_charge` WRITE;
/*!40000 ALTER TABLE `m_loan_tranche_disbursement_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_tranche_disbursement_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_transaction`
--

DROP TABLE IF EXISTS `m_loan_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `payment_detail_id` bigint(20) DEFAULT NULL,
  `is_reversed` tinyint(1) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `transaction_type_enum` smallint(5) NOT NULL,
  `transaction_date` date NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `principal_portion_derived` decimal(19,6) DEFAULT NULL,
  `interest_portion_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_portion_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_portion_derived` decimal(19,6) DEFAULT NULL,
  `overpayment_portion_derived` decimal(19,6) DEFAULT NULL,
  `unrecognized_income_portion` decimal(19,6) DEFAULT NULL,
  `outstanding_loan_balance_derived` decimal(19,6) DEFAULT NULL,
  `submitted_on_date` date NOT NULL,
  `manually_adjusted_or_reversed` tinyint(1) DEFAULT '0',
  `created_date` datetime DEFAULT NULL,
  `appuser_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  KEY `FKCFCEA42640BE0710` (`loan_id`),
  KEY `FK_m_loan_transaction_m_payment_detail` (`payment_detail_id`),
  KEY `FK_m_loan_transaction_m_office` (`office_id`),
  CONSTRAINT `FKCFCEA42640BE0710` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_m_loan_transaction_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_m_loan_transaction_m_payment_detail` FOREIGN KEY (`payment_detail_id`) REFERENCES `m_payment_detail` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_transaction`
--

LOCK TABLES `m_loan_transaction` WRITE;
/*!40000 ALTER TABLE `m_loan_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_transaction_repayment_schedule_mapping`
--

DROP TABLE IF EXISTS `m_loan_transaction_repayment_schedule_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_transaction_repayment_schedule_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_transaction_id` bigint(20) NOT NULL,
  `loan_repayment_schedule_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `principal_portion_derived` decimal(19,6) DEFAULT NULL,
  `interest_portion_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_portion_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_portion_derived` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mappings_m_loan_transaction` (`loan_transaction_id`),
  KEY `FK_mappings_m_loan_repayment_schedule` (`loan_repayment_schedule_id`),
  CONSTRAINT `FK_mappings_m_loan_repayment_schedule` FOREIGN KEY (`loan_repayment_schedule_id`) REFERENCES `m_loan_repayment_schedule` (`id`),
  CONSTRAINT `FK_mappings_m_loan_transaction` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_transaction_repayment_schedule_mapping`
--

LOCK TABLES `m_loan_transaction_repayment_schedule_mapping` WRITE;
/*!40000 ALTER TABLE `m_loan_transaction_repayment_schedule_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_transaction_repayment_schedule_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loanproduct_provisioning_entry`
--

DROP TABLE IF EXISTS `m_loanproduct_provisioning_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loanproduct_provisioning_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `history_id` bigint(20) NOT NULL,
  `criteria_id` bigint(20) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `overdue_in_days` bigint(20) DEFAULT '0',
  `reseve_amount` decimal(20,6) DEFAULT '0.000000',
  `liability_account` bigint(20) DEFAULT NULL,
  `expense_account` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `history_id` (`history_id`),
  KEY `criteria_id` (`criteria_id`),
  KEY `office_id` (`office_id`),
  KEY `product_id` (`product_id`),
  KEY `category_id` (`category_id`),
  KEY `liability_account` (`liability_account`),
  KEY `expense_account` (`expense_account`),
  CONSTRAINT `m_loanproduct_provisioning_entry_ibfk_1` FOREIGN KEY (`history_id`) REFERENCES `m_provisioning_history` (`id`),
  CONSTRAINT `m_loanproduct_provisioning_entry_ibfk_2` FOREIGN KEY (`criteria_id`) REFERENCES `m_provisioning_criteria` (`id`),
  CONSTRAINT `m_loanproduct_provisioning_entry_ibfk_3` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `m_loanproduct_provisioning_entry_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `m_product_loan` (`id`),
  CONSTRAINT `m_loanproduct_provisioning_entry_ibfk_5` FOREIGN KEY (`category_id`) REFERENCES `m_provision_category` (`id`),
  CONSTRAINT `m_loanproduct_provisioning_entry_ibfk_6` FOREIGN KEY (`liability_account`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `m_loanproduct_provisioning_entry_ibfk_7` FOREIGN KEY (`expense_account`) REFERENCES `acc_gl_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loanproduct_provisioning_entry`
--

LOCK TABLES `m_loanproduct_provisioning_entry` WRITE;
/*!40000 ALTER TABLE `m_loanproduct_provisioning_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loanproduct_provisioning_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loanproduct_provisioning_mapping`
--

DROP TABLE IF EXISTS `m_loanproduct_provisioning_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loanproduct_provisioning_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `criteria_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`),
  KEY `criteria_id` (`criteria_id`),
  CONSTRAINT `m_loanproduct_provisioning_mapping_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `m_product_loan` (`id`),
  CONSTRAINT `m_loanproduct_provisioning_mapping_ibfk_2` FOREIGN KEY (`criteria_id`) REFERENCES `m_provisioning_criteria` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loanproduct_provisioning_mapping`
--

LOCK TABLES `m_loanproduct_provisioning_mapping` WRITE;
/*!40000 ALTER TABLE `m_loanproduct_provisioning_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loanproduct_provisioning_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_mandatory_savings_schedule`
--

DROP TABLE IF EXISTS `m_mandatory_savings_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_mandatory_savings_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL,
  `fromdate` date DEFAULT NULL,
  `duedate` date NOT NULL,
  `installment` smallint(5) NOT NULL,
  `deposit_amount` decimal(19,6) DEFAULT NULL,
  `deposit_amount_completed_derived` decimal(19,6) DEFAULT NULL,
  `total_paid_in_advance_derived` decimal(19,6) DEFAULT NULL,
  `total_paid_late_derived` decimal(19,6) DEFAULT NULL,
  `completed_derived` bit(1) NOT NULL,
  `obligations_met_on_date` date DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKMSS0000000001` (`savings_account_id`),
  CONSTRAINT `FKMSS0000000001` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_mandatory_savings_schedule`
--

LOCK TABLES `m_mandatory_savings_schedule` WRITE;
/*!40000 ALTER TABLE `m_mandatory_savings_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_mandatory_savings_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_meeting`
--

DROP TABLE IF EXISTS `m_meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_meeting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `calendar_instance_id` bigint(20) NOT NULL,
  `meeting_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_calendar_instance_id_meeting_date` (`calendar_instance_id`,`meeting_date`),
  CONSTRAINT `FK_m_calendar_instance_m_meeting` FOREIGN KEY (`calendar_instance_id`) REFERENCES `m_calendar_instance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_meeting`
--

LOCK TABLES `m_meeting` WRITE;
/*!40000 ALTER TABLE `m_meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_note`
--

DROP TABLE IF EXISTS `m_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_note` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `loan_id` bigint(20) DEFAULT NULL,
  `loan_transaction_id` bigint(20) DEFAULT NULL,
  `savings_account_id` bigint(20) DEFAULT NULL,
  `savings_account_transaction_id` bigint(20) DEFAULT NULL,
  `share_account_id` bigint(20) DEFAULT NULL,
  `note_type_enum` smallint(5) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7C9708924D26803` (`loan_transaction_id`),
  KEY `FK7C97089541F0A56` (`createdby_id`),
  KEY `FK7C970897179A0CB` (`client_id`),
  KEY `FK_m_note_m_group` (`group_id`),
  KEY `FK7C970898F889C3F` (`lastmodifiedby_id`),
  KEY `FK7C9708940BE0710` (`loan_id`),
  KEY `FK_savings_account_id` (`savings_account_id`),
  CONSTRAINT `FK7C9708924D26803` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`),
  CONSTRAINT `FK7C9708940BE0710` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK7C97089541F0A56` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK7C970897179A0CB` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK7C970898F889C3F` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_note_m_group` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FK_savings_account_id` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_note`
--

LOCK TABLES `m_note` WRITE;
/*!40000 ALTER TABLE `m_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_office`
--

DROP TABLE IF EXISTS `m_office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_office` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL,
  `hierarchy` varchar(100) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `opening_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_org` (`name`),
  UNIQUE KEY `externalid_org` (`external_id`),
  KEY `FK2291C477E2551DCC` (`parent_id`),
  CONSTRAINT `FK2291C477E2551DCC` FOREIGN KEY (`parent_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_office`
--

LOCK TABLES `m_office` WRITE;
/*!40000 ALTER TABLE `m_office` DISABLE KEYS */;
INSERT INTO `m_office` VALUES (1,NULL,'.','1','Head Office','2009-01-01'),(2,1,'.2.','MSCG','Mountain Savings & Credit Group','2018-04-17');
/*!40000 ALTER TABLE `m_office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_office_transaction`
--

DROP TABLE IF EXISTS `m_office_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_office_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_office_id` bigint(20) DEFAULT NULL,
  `to_office_id` bigint(20) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` int(11) NOT NULL,
  `transaction_amount` decimal(19,6) NOT NULL,
  `transaction_date` date NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1E37728B93C6C1B6` (`to_office_id`),
  KEY `FK1E37728B783C5C25` (`from_office_id`),
  CONSTRAINT `FK1E37728B783C5C25` FOREIGN KEY (`from_office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK1E37728B93C6C1B6` FOREIGN KEY (`to_office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_office_transaction`
--

LOCK TABLES `m_office_transaction` WRITE;
/*!40000 ALTER TABLE `m_office_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_office_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_organisation_creditbureau`
--

DROP TABLE IF EXISTS `m_organisation_creditbureau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_organisation_creditbureau` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `alias` varchar(50) NOT NULL,
  `creditbureau_id` bigint(20) NOT NULL,
  `is_active` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `morgcb` (`alias`,`creditbureau_id`),
  KEY `orgcb_cbfk` (`creditbureau_id`),
  CONSTRAINT `orgcb_cbfk` FOREIGN KEY (`creditbureau_id`) REFERENCES `m_creditbureau` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_organisation_creditbureau`
--

LOCK TABLES `m_organisation_creditbureau` WRITE;
/*!40000 ALTER TABLE `m_organisation_creditbureau` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_organisation_creditbureau` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_organisation_currency`
--

DROP TABLE IF EXISTS `m_organisation_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_organisation_currency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) NOT NULL,
  `decimal_places` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `display_symbol` varchar(10) DEFAULT NULL,
  `internationalized_name_code` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_organisation_currency`
--

LOCK TABLES `m_organisation_currency` WRITE;
/*!40000 ALTER TABLE `m_organisation_currency` DISABLE KEYS */;
INSERT INTO `m_organisation_currency` VALUES (22,'XAF',0,NULL,'CFA Franc BEAC',NULL,'currency.XAF');
/*!40000 ALTER TABLE `m_organisation_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_password_validation_policy`
--

DROP TABLE IF EXISTS `m_password_validation_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_password_validation_policy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `regex` text NOT NULL,
  `description` text NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `key` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_password_validation_policy`
--

LOCK TABLES `m_password_validation_policy` WRITE;
/*!40000 ALTER TABLE `m_password_validation_policy` DISABLE KEYS */;
INSERT INTO `m_password_validation_policy` VALUES (1,'^.{1,50}$','Password most be at least 1 character and not more that 50 characters long',1,'simple'),(2,'^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\\s).{6,50}$','Password must be at least 6 characters, no more than 50 characters long, must include at least one upper case letter, one lower case letter, one numeric digit and no space',0,'secure');
/*!40000 ALTER TABLE `m_password_validation_policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_payment_detail`
--

DROP TABLE IF EXISTS `m_payment_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_payment_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payment_type_id` int(11) DEFAULT NULL,
  `account_number` varchar(100) DEFAULT NULL,
  `check_number` varchar(100) DEFAULT NULL,
  `receipt_number` varchar(100) DEFAULT NULL,
  `bank_number` varchar(100) DEFAULT NULL,
  `routing_code` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_payment_detail_m_payment_type` (`payment_type_id`),
  CONSTRAINT `FK_m_payment_detail_m_payment_type` FOREIGN KEY (`payment_type_id`) REFERENCES `m_payment_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_payment_detail`
--

LOCK TABLES `m_payment_detail` WRITE;
/*!40000 ALTER TABLE `m_payment_detail` DISABLE KEYS */;
INSERT INTO `m_payment_detail` VALUES (1,1,'','','','','');
/*!40000 ALTER TABLE `m_payment_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_payment_type`
--

DROP TABLE IF EXISTS `m_payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_payment_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `is_cash_payment` tinyint(1) DEFAULT '0',
  `order_position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_payment_type`
--

LOCK TABLES `m_payment_type` WRITE;
/*!40000 ALTER TABLE `m_payment_type` DISABLE KEYS */;
INSERT INTO `m_payment_type` VALUES (1,'Cash','Cash',1,1),(2,'Cheque','Cheque',0,2);
/*!40000 ALTER TABLE `m_payment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_permission`
--

DROP TABLE IF EXISTS `m_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `grouping` varchar(45) DEFAULT NULL,
  `code` varchar(100) NOT NULL,
  `entity_name` varchar(100) DEFAULT NULL,
  `action_name` varchar(100) DEFAULT NULL,
  `can_maker_checker` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=879 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_permission`
--

LOCK TABLES `m_permission` WRITE;
/*!40000 ALTER TABLE `m_permission` DISABLE KEYS */;
INSERT INTO `m_permission` VALUES (1,'special','ALL_FUNCTIONS',NULL,NULL,0),(2,'special','ALL_FUNCTIONS_READ',NULL,NULL,0),(3,'special','CHECKER_SUPER_USER',NULL,NULL,0),(4,'special','REPORTING_SUPER_USER',NULL,NULL,0),(5,'authorisation','READ_PERMISSION','PERMISSION','READ',0),(6,'authorisation','PERMISSIONS_ROLE','ROLE','PERMISSIONS',0),(7,'authorisation','CREATE_ROLE','ROLE','CREATE',0),(8,'authorisation','CREATE_ROLE_CHECKER','ROLE','CREATE_CHECKER',0),(9,'authorisation','READ_ROLE','ROLE','READ',0),(10,'authorisation','UPDATE_ROLE','ROLE','UPDATE',0),(11,'authorisation','UPDATE_ROLE_CHECKER','ROLE','UPDATE_CHECKER',0),(12,'authorisation','DELETE_ROLE','ROLE','DELETE',0),(13,'authorisation','DELETE_ROLE_CHECKER','ROLE','DELETE_CHECKER',0),(14,'authorisation','CREATE_USER','USER','CREATE',0),(15,'authorisation','CREATE_USER_CHECKER','USER','CREATE_CHECKER',0),(16,'authorisation','READ_USER','USER','READ',0),(17,'authorisation','UPDATE_USER','USER','UPDATE',0),(18,'authorisation','UPDATE_USER_CHECKER','USER','UPDATE_CHECKER',0),(19,'authorisation','DELETE_USER','USER','DELETE',0),(20,'authorisation','DELETE_USER_CHECKER','USER','DELETE_CHECKER',0),(21,'configuration','READ_CONFIGURATION','CONFIGURATION','READ',0),(22,'configuration','UPDATE_CONFIGURATION','CONFIGURATION','UPDATE',0),(23,'configuration','UPDATE_CONFIGURATION_CHECKER','CONFIGURATION','UPDATE_CHECKER',0),(24,'configuration','READ_CODE','CODE','READ',0),(25,'configuration','CREATE_CODE','CODE','CREATE',0),(26,'configuration','CREATE_CODE_CHECKER','CODE','CREATE_CHECKER',0),(27,'configuration','UPDATE_CODE','CODE','UPDATE',0),(28,'configuration','UPDATE_CODE_CHECKER','CODE','UPDATE_CHECKER',0),(29,'configuration','DELETE_CODE','CODE','DELETE',0),(30,'configuration','DELETE_CODE_CHECKER','CODE','DELETE_CHECKER',0),(31,'configuration','READ_CODEVALUE','CODEVALUE','READ',0),(32,'configuration','CREATE_CODEVALUE','CODEVALUE','CREATE',0),(33,'configuration','CREATE_CODEVALUE_CHECKER','CODEVALUE','CREATE_CHECKER',0),(34,'configuration','UPDATE_CODEVALUE','CODEVALUE','UPDATE',0),(35,'configuration','UPDATE_CODEVALUE_CHECKER','CODEVALUE','UPDATE_CHECKER',0),(36,'configuration','DELETE_CODEVALUE','CODEVALUE','DELETE',0),(37,'configuration','DELETE_CODEVALUE_CHECKER','CODEVALUE','DELETE_CHECKER',0),(38,'configuration','READ_CURRENCY','CURRENCY','READ',0),(39,'configuration','UPDATE_CURRENCY','CURRENCY','UPDATE',0),(40,'configuration','UPDATE_CURRENCY_CHECKER','CURRENCY','UPDATE_CHECKER',0),(41,'configuration','UPDATE_PERMISSION','PERMISSION','UPDATE',0),(42,'configuration','UPDATE_PERMISSION_CHECKER','PERMISSION','UPDATE_CHECKER',0),(43,'configuration','READ_DATATABLE','DATATABLE','READ',0),(44,'configuration','REGISTER_DATATABLE','DATATABLE','REGISTER',0),(45,'configuration','REGISTER_DATATABLE_CHECKER','DATATABLE','REGISTER_CHECKER',0),(46,'configuration','DEREGISTER_DATATABLE','DATATABLE','DEREGISTER',0),(47,'configuration','DEREGISTER_DATATABLE_CHECKER','DATATABLE','DEREGISTER_CHECKER',0),(48,'configuration','READ_AUDIT','AUDIT','READ',0),(49,'configuration','CREATE_CALENDAR','CALENDAR','CREATE',0),(50,'configuration','READ_CALENDAR','CALENDAR','READ',0),(51,'configuration','UPDATE_CALENDAR','CALENDAR','UPDATE',0),(52,'configuration','DELETE_CALENDAR','CALENDAR','DELETE',0),(53,'configuration','CREATE_CALENDAR_CHECKER','CALENDAR','CREATE_CHECKER',0),(54,'configuration','UPDATE_CALENDAR_CHECKER','CALENDAR','UPDATE_CHECKER',0),(55,'configuration','DELETE_CALENDAR_CHECKER','CALENDAR','DELETE_CHECKER',0),(57,'organisation','READ_CHARGE','CHARGE','READ',0),(58,'organisation','CREATE_CHARGE','CHARGE','CREATE',0),(59,'organisation','CREATE_CHARGE_CHECKER','CHARGE','CREATE_CHECKER',0),(60,'organisation','UPDATE_CHARGE','CHARGE','UPDATE',0),(61,'organisation','UPDATE_CHARGE_CHECKER','CHARGE','UPDATE_CHECKER',0),(62,'organisation','DELETE_CHARGE','CHARGE','DELETE',0),(63,'organisation','DELETE_CHARGE_CHECKER','CHARGE','DELETE_CHECKER',0),(64,'organisation','READ_FUND','FUND','READ',0),(65,'organisation','CREATE_FUND','FUND','CREATE',0),(66,'organisation','CREATE_FUND_CHECKER','FUND','CREATE_CHECKER',0),(67,'organisation','UPDATE_FUND','FUND','UPDATE',0),(68,'organisation','UPDATE_FUND_CHECKER','FUND','UPDATE_CHECKER',0),(69,'organisation','DELETE_FUND','FUND','DELETE',0),(70,'organisation','DELETE_FUND_CHECKER','FUND','DELETE_CHECKER',0),(71,'organisation','READ_LOANPRODUCT','LOANPRODUCT','READ',0),(72,'organisation','CREATE_LOANPRODUCT','LOANPRODUCT','CREATE',0),(73,'organisation','CREATE_LOANPRODUCT_CHECKER','LOANPRODUCT','CREATE_CHECKER',0),(74,'organisation','UPDATE_LOANPRODUCT','LOANPRODUCT','UPDATE',0),(75,'organisation','UPDATE_LOANPRODUCT_CHECKER','LOANPRODUCT','UPDATE_CHECKER',0),(76,'organisation','DELETE_LOANPRODUCT','LOANPRODUCT','DELETE',0),(77,'organisation','DELETE_LOANPRODUCT_CHECKER','LOANPRODUCT','DELETE_CHECKER',0),(78,'organisation','READ_OFFICE','OFFICE','READ',0),(79,'organisation','CREATE_OFFICE','OFFICE','CREATE',0),(80,'organisation','CREATE_OFFICE_CHECKER','OFFICE','CREATE_CHECKER',0),(81,'organisation','UPDATE_OFFICE','OFFICE','UPDATE',0),(82,'organisation','UPDATE_OFFICE_CHECKER','OFFICE','UPDATE_CHECKER',0),(83,'organisation','READ_OFFICETRANSACTION','OFFICETRANSACTION','READ',0),(84,'organisation','DELETE_OFFICE_CHECKER','OFFICE','DELETE_CHECKER',0),(85,'organisation','CREATE_OFFICETRANSACTION','OFFICETRANSACTION','CREATE',0),(86,'organisation','CREATE_OFFICETRANSACTION_CHECKER','OFFICETRANSACTION','CREATE_CHECKER',0),(87,'organisation','DELETE_OFFICETRANSACTION','OFFICETRANSACTION','DELETE',0),(88,'organisation','DELETE_OFFICETRANSACTION_CHECKER','OFFICETRANSACTION','DELETE_CHECKER',0),(89,'organisation','READ_STAFF','STAFF','READ',0),(90,'organisation','CREATE_STAFF','STAFF','CREATE',0),(91,'organisation','CREATE_STAFF_CHECKER','STAFF','CREATE_CHECKER',0),(92,'organisation','UPDATE_STAFF','STAFF','UPDATE',0),(93,'organisation','UPDATE_STAFF_CHECKER','STAFF','UPDATE_CHECKER',0),(94,'organisation','DELETE_STAFF','STAFF','DELETE',0),(95,'organisation','DELETE_STAFF_CHECKER','STAFF','DELETE_CHECKER',0),(96,'organisation','READ_SAVINGSPRODUCT','SAVINGSPRODUCT','READ',0),(97,'organisation','CREATE_SAVINGSPRODUCT','SAVINGSPRODUCT','CREATE',0),(98,'organisation','CREATE_SAVINGSPRODUCT_CHECKER','SAVINGSPRODUCT','CREATE_CHECKER',0),(99,'organisation','UPDATE_SAVINGSPRODUCT','SAVINGSPRODUCT','UPDATE',0),(100,'organisation','UPDATE_SAVINGSPRODUCT_CHECKER','SAVINGSPRODUCT','UPDATE_CHECKER',0),(101,'organisation','DELETE_SAVINGSPRODUCT','SAVINGSPRODUCT','DELETE',0),(102,'organisation','DELETE_SAVINGSPRODUCT_CHECKER','SAVINGSPRODUCT','DELETE_CHECKER',0),(103,'portfolio','READ_LOAN','LOAN','READ',0),(104,'portfolio','CREATE_LOAN','LOAN','CREATE',0),(105,'portfolio','CREATE_LOAN_CHECKER','LOAN','CREATE_CHECKER',0),(106,'portfolio','UPDATE_LOAN','LOAN','UPDATE',0),(107,'portfolio','UPDATE_LOAN_CHECKER','LOAN','UPDATE_CHECKER',0),(108,'portfolio','DELETE_LOAN','LOAN','DELETE',0),(109,'portfolio','DELETE_LOAN_CHECKER','LOAN','DELETE_CHECKER',0),(110,'portfolio','READ_CLIENT','CLIENT','READ',0),(111,'portfolio','CREATE_CLIENT','CLIENT','CREATE',0),(112,'portfolio','CREATE_CLIENT_CHECKER','CLIENT','CREATE_CHECKER',0),(113,'portfolio','UPDATE_CLIENT','CLIENT','UPDATE',0),(114,'portfolio','UPDATE_CLIENT_CHECKER','CLIENT','UPDATE_CHECKER',0),(115,'portfolio','DELETE_CLIENT','CLIENT','DELETE',0),(116,'portfolio','DELETE_CLIENT_CHECKER','CLIENT','DELETE_CHECKER',0),(117,'portfolio','READ_CLIENTIMAGE','CLIENTIMAGE','READ',0),(118,'portfolio','CREATE_CLIENTIMAGE','CLIENTIMAGE','CREATE',0),(119,'portfolio','CREATE_CLIENTIMAGE_CHECKER','CLIENTIMAGE','CREATE_CHECKER',0),(120,'portfolio','DELETE_CLIENTIMAGE','CLIENTIMAGE','DELETE',0),(121,'portfolio','DELETE_CLIENTIMAGE_CHECKER','CLIENTIMAGE','DELETE_CHECKER',0),(122,'portfolio','READ_CLIENTNOTE','CLIENTNOTE','READ',0),(123,'portfolio','CREATE_CLIENTNOTE','CLIENTNOTE','CREATE',0),(124,'portfolio','CREATE_CLIENTNOTE_CHECKER','CLIENTNOTE','CREATE_CHECKER',0),(125,'portfolio','UPDATE_CLIENTNOTE','CLIENTNOTE','UPDATE',0),(126,'portfolio','UPDATE_CLIENTNOTE_CHECKER','CLIENTNOTE','UPDATE_CHECKER',0),(127,'portfolio','DELETE_CLIENTNOTE','CLIENTNOTE','DELETE',0),(128,'portfolio','DELETE_CLIENTNOTE_CHECKER','CLIENTNOTE','DELETE_CHECKER',0),(129,'portfolio_group','READ_GROUPNOTE','GROUPNOTE','READ',0),(130,'portfolio_group','CREATE_GROUPNOTE','GROUPNOTE','CREATE',0),(131,'portfolio_group','UPDATE_GROUPNOTE','GROUPNOTE','UPDATE',0),(132,'portfolio_group','DELETE_GROUPNOTE','GROUPNOTE','DELETE',0),(133,'portfolio_group','CREATE_GROUPNOTE_CHECKER','GROUPNOTE','CREATE_CHECKER',0),(134,'portfolio_group','UPDATE_GROUPNOTE_CHECKER','GROUPNOTE','UPDATE_CHECKER',0),(135,'portfolio_group','DELETE_GROUPNOTE_CHECKER','GROUPNOTE','DELETE_CHECKER',0),(136,'portfolio','READ_LOANNOTE','LOANNOTE','READ',0),(137,'portfolio','CREATE_LOANNOTE','LOANNOTE','CREATE',0),(138,'portfolio','UPDATE_LOANNOTE','LOANNOTE','UPDATE',0),(139,'portfolio','DELETE_LOANNOTE','LOANNOTE','DELETE',0),(140,'portfolio','CREATE_LOANNOTE_CHECKER','LOANNOTE','CREATE_CHECKER',0),(141,'portfolio','UPDATE_LOANNOTE_CHECKER','LOANNOTE','UPDATE_CHECKER',0),(142,'portfolio','DELETE_LOANNOTE_CHECKER','LOANNOTE','DELETE_CHECKER',0),(143,'portfolio','READ_LOANTRANSACTIONNOTE','LOANTRANSACTIONNOTE','READ',0),(144,'portfolio','CREATE_LOANTRANSACTIONNOTE','LOANTRANSACTIONNOTE','CREATE',0),(145,'portfolio','UPDATE_LOANTRANSACTIONNOTE','LOANTRANSACTIONNOTE','UPDATE',0),(146,'portfolio','DELETE_LOANTRANSACTIONNOTE','LOANTRANSACTIONNOTE','DELETE',0),(147,'portfolio','CREATE_LOANTRANSACTIONNOTE_CHECKER','LOANTRANSACTIONNOTE','CREATE_CHECKER',0),(148,'portfolio','UPDATE_LOANTRANSACTIONNOTE_CHECKER','LOANTRANSACTIONNOTE','UPDATE_CHECKER',0),(149,'portfolio','DELETE_LOANTRANSACTIONNOTE_CHECKER','LOANTRANSACTIONNOTE','DELETE_CHECKER',0),(150,'portfolio','READ_SAVINGNOTE','SAVINGNOTE','READ',0),(151,'portfolio','CREATE_SAVINGNOTE','SAVINGNOTE','CREATE',0),(152,'portfolio','UPDATE_SAVINGNOTE','SAVINGNOTE','UPDATE',0),(153,'portfolio','DELETE_SAVINGNOTE','SAVINGNOTE','DELETE',0),(154,'portfolio','CREATE_SAVINGNOTE_CHECKER','SAVINGNOTE','CREATE_CHECKER',0),(155,'portfolio','UPDATE_SAVINGNOTE_CHECKER','SAVINGNOTE','UPDATE_CHECKER',0),(156,'portfolio','DELETE_SAVINGNOTE_CHECKER','SAVINGNOTE','DELETE_CHECKER',0),(157,'portfolio','READ_CLIENTIDENTIFIER','CLIENTIDENTIFIER','READ',0),(158,'portfolio','CREATE_CLIENTIDENTIFIER','CLIENTIDENTIFIER','CREATE',0),(159,'portfolio','CREATE_CLIENTIDENTIFIER_CHECKER','CLIENTIDENTIFIER','CREATE_CHECKER',0),(160,'portfolio','UPDATE_CLIENTIDENTIFIER','CLIENTIDENTIFIER','UPDATE',0),(161,'portfolio','UPDATE_CLIENTIDENTIFIER_CHECKER','CLIENTIDENTIFIER','UPDATE_CHECKER',0),(162,'portfolio','DELETE_CLIENTIDENTIFIER','CLIENTIDENTIFIER','DELETE',0),(163,'portfolio','DELETE_CLIENTIDENTIFIER_CHECKER','CLIENTIDENTIFIER','DELETE_CHECKER',0),(164,'portfolio','READ_DOCUMENT','DOCUMENT','READ',0),(165,'portfolio','CREATE_DOCUMENT','DOCUMENT','CREATE',0),(166,'portfolio','CREATE_DOCUMENT_CHECKER','DOCUMENT','CREATE_CHECKER',0),(167,'portfolio','UPDATE_DOCUMENT','DOCUMENT','UPDATE',0),(168,'portfolio','UPDATE_DOCUMENT_CHECKER','DOCUMENT','UPDATE_CHECKER',0),(169,'portfolio','DELETE_DOCUMENT','DOCUMENT','DELETE',0),(170,'portfolio','DELETE_DOCUMENT_CHECKER','DOCUMENT','DELETE_CHECKER',0),(171,'portfolio_group','READ_GROUP','GROUP','READ',0),(172,'portfolio_group','CREATE_GROUP','GROUP','CREATE',0),(173,'portfolio_group','CREATE_GROUP_CHECKER','GROUP','CREATE_CHECKER',0),(174,'portfolio_group','UPDATE_GROUP','GROUP','UPDATE',0),(175,'portfolio_group','UPDATE_GROUP_CHECKER','GROUP','UPDATE_CHECKER',0),(176,'portfolio_group','DELETE_GROUP','GROUP','DELETE',0),(177,'portfolio_group','DELETE_GROUP_CHECKER','GROUP','DELETE_CHECKER',0),(178,'portfolio_group','UNASSIGNSTAFF_GROUP','GROUP','UNASSIGNSTAFF',0),(179,'portfolio_group','UNASSIGNSTAFF_GROUP_CHECKER','GROUP','UNASSIGNSTAFF_CHECKER',0),(180,'portfolio','CREATE_LOANCHARGE','LOANCHARGE','CREATE',0),(181,'portfolio','CREATE_LOANCHARGE_CHECKER','LOANCHARGE','CREATE_CHECKER',0),(182,'portfolio','UPDATE_LOANCHARGE','LOANCHARGE','UPDATE',0),(183,'portfolio','UPDATE_LOANCHARGE_CHECKER','LOANCHARGE','UPDATE_CHECKER',0),(184,'portfolio','DELETE_LOANCHARGE','LOANCHARGE','DELETE',0),(185,'portfolio','DELETE_LOANCHARGE_CHECKER','LOANCHARGE','DELETE_CHECKER',0),(186,'portfolio','WAIVE_LOANCHARGE','LOANCHARGE','WAIVE',0),(187,'portfolio','WAIVE_LOANCHARGE_CHECKER','LOANCHARGE','WAIVE_CHECKER',0),(188,'portfolio','READ_SAVINGSACCOUNT','SAVINGSACCOUNT','READ',0),(189,'portfolio','CREATE_SAVINGSACCOUNT','SAVINGSACCOUNT','CREATE',0),(190,'portfolio','CREATE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','CREATE_CHECKER',0),(191,'portfolio','UPDATE_SAVINGSACCOUNT','SAVINGSACCOUNT','UPDATE',0),(192,'portfolio','UPDATE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','UPDATE_CHECKER',0),(193,'portfolio','DELETE_SAVINGSACCOUNT','SAVINGSACCOUNT','DELETE',0),(194,'portfolio','DELETE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','DELETE_CHECKER',0),(195,'portfolio','READ_GUARANTOR','GUARANTOR','READ',0),(196,'portfolio','CREATE_GUARANTOR','GUARANTOR','CREATE',0),(197,'portfolio','CREATE_GUARANTOR_CHECKER','GUARANTOR','CREATE_CHECKER',0),(198,'portfolio','UPDATE_GUARANTOR','GUARANTOR','UPDATE',0),(199,'portfolio','UPDATE_GUARANTOR_CHECKER','GUARANTOR','UPDATE_CHECKER',0),(200,'portfolio','DELETE_GUARANTOR','GUARANTOR','DELETE',0),(201,'portfolio','DELETE_GUARANTOR_CHECKER','GUARANTOR','DELETE_CHECKER',0),(202,'portfolio','READ_COLLATERAL','COLLATERAL','READ',0),(203,'portfolio','CREATE_COLLATERAL','COLLATERAL','CREATE',0),(204,'portfolio','UPDATE_COLLATERAL','COLLATERAL','UPDATE',0),(205,'portfolio','DELETE_COLLATERAL','COLLATERAL','DELETE',0),(206,'portfolio','CREATE_COLLATERAL_CHECKER','COLLATERAL','CREATE_CHECKER',0),(207,'portfolio','UPDATE_COLLATERAL_CHECKER','COLLATERAL','UPDATE_CHECKER',0),(208,'portfolio','DELETE_COLLATERAL_CHECKER','COLLATERAL','DELETE_CHECKER',0),(209,'transaction_loan','APPROVE_LOAN','LOAN','APPROVE',0),(211,'transaction_loan','REJECT_LOAN','LOAN','REJECT',0),(213,'transaction_loan','WITHDRAW_LOAN','LOAN','WITHDRAW',0),(215,'transaction_loan','APPROVALUNDO_LOAN','LOAN','APPROVALUNDO',0),(216,'transaction_loan','DISBURSE_LOAN','LOAN','DISBURSE',0),(218,'transaction_loan','DISBURSALUNDO_LOAN','LOAN','DISBURSALUNDO',0),(219,'transaction_loan','REPAYMENT_LOAN','LOAN','REPAYMENT',0),(221,'transaction_loan','ADJUST_LOAN','LOAN','ADJUST',0),(222,'transaction_loan','WAIVEINTERESTPORTION_LOAN','LOAN','WAIVEINTERESTPORTION',0),(223,'transaction_loan','WRITEOFF_LOAN','LOAN','WRITEOFF',0),(224,'transaction_loan','CLOSE_LOAN','LOAN','CLOSE',0),(225,'transaction_loan','CLOSEASRESCHEDULED_LOAN','LOAN','CLOSEASRESCHEDULED',0),(226,'transaction_loan','UPDATELOANOFFICER_LOAN','LOAN','UPDATELOANOFFICER',0),(227,'transaction_loan','UPDATELOANOFFICER_LOAN_CHECKER','LOAN','UPDATELOANOFFICER_CHECKER',0),(228,'transaction_loan','REMOVELOANOFFICER_LOAN','LOAN','REMOVELOANOFFICER',0),(229,'transaction_loan','REMOVELOANOFFICER_LOAN_CHECKER','LOAN','REMOVELOANOFFICER_CHECKER',0),(230,'transaction_loan','BULKREASSIGN_LOAN','LOAN','BULKREASSIGN',0),(231,'transaction_loan','BULKREASSIGN_LOAN_CHECKER','LOAN','BULKREASSIGN_CHECKER',0),(232,'transaction_loan','APPROVE_LOAN_CHECKER','LOAN','APPROVE_CHECKER',0),(234,'transaction_loan','REJECT_LOAN_CHECKER','LOAN','REJECT_CHECKER',0),(236,'transaction_loan','WITHDRAW_LOAN_CHECKER','LOAN','WITHDRAW_CHECKER',0),(238,'transaction_loan','APPROVALUNDO_LOAN_CHECKER','LOAN','APPROVALUNDO_CHECKER',0),(239,'transaction_loan','DISBURSE_LOAN_CHECKER','LOAN','DISBURSE_CHECKER',0),(241,'transaction_loan','DISBURSALUNDO_LOAN_CHECKER','LOAN','DISBURSALUNDO_CHECKER',0),(242,'transaction_loan','REPAYMENT_LOAN_CHECKER','LOAN','REPAYMENT_CHECKER',0),(244,'transaction_loan','ADJUST_LOAN_CHECKER','LOAN','ADJUST_CHECKER',0),(245,'transaction_loan','WAIVEINTERESTPORTION_LOAN_CHECKER','LOAN','WAIVEINTERESTPORTION_CHECKER',0),(246,'transaction_loan','WRITEOFF_LOAN_CHECKER','LOAN','WRITEOFF_CHECKER',0),(247,'transaction_loan','CLOSE_LOAN_CHECKER','LOAN','CLOSE_CHECKER',0),(248,'transaction_loan','CLOSEASRESCHEDULED_LOAN_CHECKER','LOAN','CLOSEASRESCHEDULED_CHECKER',0),(249,'transaction_savings','DEPOSIT_SAVINGSACCOUNT','SAVINGSACCOUNT','DEPOSIT',0),(250,'transaction_savings','DEPOSIT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','DEPOSIT_CHECKER',0),(251,'transaction_savings','WITHDRAWAL_SAVINGSACCOUNT','SAVINGSACCOUNT','WITHDRAWAL',0),(252,'transaction_savings','WITHDRAWAL_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','WITHDRAWAL_CHECKER',0),(253,'transaction_savings','ACTIVATE_SAVINGSACCOUNT','SAVINGSACCOUNT','ACTIVATE',0),(254,'transaction_savings','ACTIVATE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','ACTIVATE_CHECKER',0),(255,'transaction_savings','CALCULATEINTEREST_SAVINGSACCOUNT','SAVINGSACCOUNT','CALCULATEINTEREST',0),(256,'transaction_savings','CALCULATEINTEREST_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','CALCULATEINTEREST_CHECKER',0),(257,'accounting','CREATE_GLACCOUNT','GLACCOUNT','CREATE',0),(258,'accounting','UPDATE_GLACCOUNT','GLACCOUNT','UPDATE',0),(259,'accounting','DELETE_GLACCOUNT','GLACCOUNT','DELETE',0),(260,'accounting','CREATE_GLCLOSURE','GLCLOSURE','CREATE',0),(261,'accounting','UPDATE_GLCLOSURE','GLCLOSURE','UPDATE',0),(262,'accounting','DELETE_GLCLOSURE','GLCLOSURE','DELETE',0),(263,'accounting','CREATE_JOURNALENTRY','JOURNALENTRY','CREATE',0),(264,'accounting','REVERSE_JOURNALENTRY','JOURNALENTRY','REVERSE',0),(265,'report','READ_Active Loans - Details','Active Loans - Details','READ',0),(266,'report','READ_Active Loans - Summary','Active Loans - Summary','READ',0),(267,'report','READ_Active Loans by Disbursal Period','Active Loans by Disbursal Period','READ',0),(268,'report','READ_Active Loans in last installment','Active Loans in last installment','READ',0),(269,'report','READ_Active Loans in last installment Summary','Active Loans in last installment Summary','READ',0),(270,'report','READ_Active Loans Passed Final Maturity','Active Loans Passed Final Maturity','READ',0),(271,'report','READ_Active Loans Passed Final Maturity Summary','Active Loans Passed Final Maturity Summary','READ',0),(272,'report','READ_Aging Detail','Aging Detail','READ',0),(273,'report','READ_Aging Summary (Arrears in Months)','Aging Summary (Arrears in Months)','READ',0),(274,'report','READ_Aging Summary (Arrears in Weeks)','Aging Summary (Arrears in Weeks)','READ',0),(275,'report','READ_Balance Sheet','Balance Sheet','READ',0),(276,'report','READ_Branch Expected Cash Flow','Branch Expected Cash Flow','READ',0),(277,'report','READ_Client Listing','Client Listing','READ',0),(278,'report','READ_Client Loans Listing','Client Loans Listing','READ',0),(279,'report','READ_Expected Payments By Date - Basic','Expected Payments By Date - Basic','READ',0),(280,'report','READ_Expected Payments By Date - Formatted','Expected Payments By Date - Formatted','READ',0),(281,'report','READ_Funds Disbursed Between Dates Summary','Funds Disbursed Between Dates Summary','READ',0),(282,'report','READ_Funds Disbursed Between Dates Summary by Office','Funds Disbursed Between Dates Summary by Office','READ',0),(283,'report','READ_Income Statement','Income Statement','READ',0),(284,'report','READ_Loan Account Schedule','Loan Account Schedule','READ',0),(285,'report','READ_Loans Awaiting Disbursal','Loans Awaiting Disbursal','READ',0),(286,'report','READ_Loans Awaiting Disbursal Summary','Loans Awaiting Disbursal Summary','READ',0),(287,'report','READ_Loans Awaiting Disbursal Summary by Month','Loans Awaiting Disbursal Summary by Month','READ',0),(288,'report','READ_Loans Pending Approval','Loans Pending Approval','READ',0),(289,'report','READ_Obligation Met Loans Details','Obligation Met Loans Details','READ',0),(290,'report','READ_Obligation Met Loans Summary','Obligation Met Loans Summary','READ',0),(291,'report','READ_Portfolio at Risk','Portfolio at Risk','READ',0),(292,'report','READ_Portfolio at Risk by Branch','Portfolio at Risk by Branch','READ',0),(293,'report','READ_Rescheduled Loans','Rescheduled Loans','READ',0),(294,'report','READ_Trial Balance','Trial Balance','READ',0),(295,'report','READ_Written-Off Loans','Written-Off Loans','READ',0),(296,'transaction_savings','POSTINTEREST_SAVINGSACCOUNT','SAVINGSACCOUNT','POSTINTEREST',1),(297,'transaction_savings','POSTINTEREST_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','POSTINTEREST_CHECKER',0),(298,'portfolio_center','READ_CENTER','CENTER','READ',0),(299,'portfolio_center','CREATE_CENTER','CENTER','CREATE',0),(300,'portfolio_center','CREATE_CENTER_CHECKER','CENTER','CREATE_CHECKER',0),(301,'portfolio_center','UPDATE_CENTER','CENTER','UPDATE',0),(302,'portfolio_center','UPDATE_CENTER_CHECKER','CENTER','UPDATE_CHECKER',0),(303,'portfolio_center','DELETE_CENTER','CENTER','DELETE',0),(304,'portfolio_center','DELETE_CENTER_CHECKER','CENTER','DELETE_CHECKER',0),(305,'configuration','READ_REPORT','REPORT','READ',0),(306,'configuration','CREATE_REPORT','REPORT','CREATE',0),(307,'configuration','CREATE_REPORT_CHECKER','REPORT','CREATE_CHECKER',0),(308,'configuration','UPDATE_REPORT','REPORT','UPDATE',0),(309,'configuration','UPDATE_REPORT_CHECKER','REPORT','UPDATE_CHECKER',0),(310,'configuration','DELETE_REPORT','REPORT','DELETE',0),(311,'configuration','DELETE_REPORT_CHECKER','REPORT','DELETE_CHECKER',0),(312,'portfolio','ACTIVATE_CLIENT','CLIENT','ACTIVATE',1),(313,'portfolio','ACTIVATE_CLIENT_CHECKER','CLIENT','ACTIVATE_CHECKER',0),(314,'portfolio_center','ACTIVATE_CENTER','CENTER','ACTIVATE',1),(315,'portfolio_center','ACTIVATE_CENTER_CHECKER','CENTER','ACTIVATE_CHECKER',0),(316,'portfolio_group','ACTIVATE_GROUP','GROUP','ACTIVATE',1),(317,'portfolio_group','ACTIVATE_GROUP_CHECKER','GROUP','ACTIVATE_CHECKER',0),(318,'portfolio_group','ASSOCIATECLIENTS_GROUP','GROUP','ASSOCIATECLIENTS',0),(319,'portfolio_group','DISASSOCIATECLIENTS_GROUP','GROUP','DISASSOCIATECLIENTS',0),(320,'portfolio_group','SAVECOLLECTIONSHEET_GROUP','GROUP','SAVECOLLECTIONSHEET',0),(321,'portfolio_center','SAVECOLLECTIONSHEET_CENTER','CENTER','SAVECOLLECTIONSHEET',0),(323,'accounting','DELETE_ACCOUNTINGRULE','ACCOUNTINGRULE','DELETE',0),(324,'accounting','CREATE_ACCOUNTINGRULE','ACCOUNTINGRULE','CREATE',0),(325,'accounting','UPDATE_ACCOUNTINGRULE','ACCOUNTINGRULE','UPDATE',0),(326,'report','READ_GroupSummaryCounts','GroupSummaryCounts','READ',0),(327,'report','READ_GroupSummaryAmounts','GroupSummaryAmounts','READ',0),(328,'configuration','CREATE_DATATABLE','DATATABLE','CREATE',0),(329,'configuration','CREATE_DATATABLE_CHECKER','DATATABLE','CREATE_CHECKER',0),(330,'configuration','UPDATE_DATATABLE','DATATABLE','UPDATE',0),(331,'configuration','UPDATE_DATATABLE_CHECKER','DATATABLE','UPDATE_CHECKER',0),(332,'configuration','DELETE_DATATABLE','DATATABLE','DELETE',0),(333,'configuration','DELETE_DATATABLE_CHECKER','DATATABLE','DELETE_CHECKER',0),(334,'organisation','CREATE_HOLIDAY','HOLIDAY','CREATE',0),(335,'portfolio_group','ASSIGNROLE_GROUP','GROUP','ASSIGNROLE',0),(336,'portfolio_group','UNASSIGNROLE_GROUP','GROUP','UNASSIGNROLE',0),(337,'portfolio_group','UPDATEROLE_GROUP','GROUP','UPDATEROLE',0),(346,'report','READ_TxnRunningBalances','TxnRunningBalances','READ',0),(347,'portfolio','UNASSIGNSTAFF_CLIENT','CLIENT','UNASSIGNSTAFF',0),(348,'portfolio','ASSIGNSTAFF_CLIENT','CLIENT','ASSIGNSTAFF',0),(349,'portfolio','CLOSE_CLIENT','CLIENT','CLOSE',1),(350,'report','READ_FieldAgentStats','FieldAgentStats','READ',0),(351,'report','READ_FieldAgentPrograms','FieldAgentPrograms','READ',0),(352,'report','READ_ProgramDetails','ProgramDetails','READ',0),(353,'report','READ_ChildrenStaffList','ChildrenStaffList','READ',0),(354,'report','READ_CoordinatorStats','CoordinatorStats','READ',0),(355,'report','READ_BranchManagerStats','BranchManagerStats','READ',0),(356,'report','READ_ProgramDirectorStats','ProgramDirectorStats','READ',0),(357,'report','READ_ProgramStats','ProgramStats','READ',0),(358,'transaction_savings','APPROVE_SAVINGSACCOUNT','SAVINGSACCOUNT','APPROVE',1),(359,'transaction_savings','REJECT_SAVINGSACCOUNT','SAVINGSACCOUNT','REJECT',1),(360,'transaction_savings','WITHDRAW_SAVINGSACCOUNT','SAVINGSACCOUNT','WITHDRAW',1),(361,'transaction_savings','APPROVALUNDO_SAVINGSACCOUNT','SAVINGSACCOUNT','APPROVALUNDO',1),(362,'transaction_savings','CLOSE_SAVINGSACCOUNT','SAVINGSACCOUNT','CLOSE',1),(363,'transaction_savings','APPROVE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','APPROVE_CHECKER',0),(364,'transaction_savings','REJECT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','REJECT_CHECKER',0),(365,'transaction_savings','WITHDRAW_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','WITHDRAW_CHECKER',0),(366,'transaction_savings','APPROVALUNDO_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','APPROVALUNDO_CHECKER',0),(367,'transaction_savings','CLOSE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','CLOSE_CHECKER',0),(368,'transaction_savings','UNDOTRANSACTION_SAVINGSACCOUNT','SAVINGSACCOUNT','UNDOTRANSACTION',1),(369,'transaction_savings','UNDOTRANSACTION_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','UNDOTRANSACTION_CHECKER',0),(370,'portfolio','CREATE_PRODUCTMIX','PRODUCTMIX','CREATE',0),(371,'portfolio','UPDATE_PRODUCTMIX','PRODUCTMIX','UPDATE',0),(372,'portfolio','DELETE_PRODUCTMIX','PRODUCTMIX','DELETE',0),(373,'jobs','UPDATE_SCHEDULER','SCHEDULER','UPDATE',0),(374,'transaction_savings','APPLYANNUALFEE_SAVINGSACCOUNT','SAVINGSACCOUNT','APPLYANNUALFEE',1),(375,'transaction_savings','APPLYANNUALFEE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','APPLYANNUALFEE_CHECKER',0),(376,'portfolio_group','ASSIGNSTAFF_GROUP','GROUP','ASSIGNSTAFF',0),(377,'transaction_savings','READ_ACCOUNTTRANSFER','ACCOUNTTRANSFER','READ',0),(378,'transaction_savings','CREATE_ACCOUNTTRANSFER','ACCOUNTTRANSFER','CREATE',1),(379,'transaction_savings','CREATE_ACCOUNTTRANSFER_CHECKER','ACCOUNTTRANSFER','CREATE_CHECKER',0),(380,'transaction_savings','ADJUSTTRANSACTION_SAVINGSACCOUNT','SAVINGSACCOUNT','ADJUSTTRANSACTION',0),(381,'portfolio','CREATE_MEETING','MEETING','CREATE',0),(382,'portfolio','UPDATE_MEETING','MEETING','UPDATE',0),(383,'portfolio','DELETE_MEETING','MEETING','DELETE',0),(384,'portfolio','SAVEORUPDATEATTENDANCE_MEETING','MEETING','SAVEORUPDATEATTENDANCE',0),(385,'portfolio_group','TRANSFERCLIENTS_GROUP','GROUP','TRANSFERCLIENTS',0),(386,'portfolio_group','TRANSFERCLIENTS_GROUP_CHECKER','GROUP','TRANSFERCLIENTS_CHECKER',0),(389,'portfolio','PROPOSETRANSFER_CLIENT','CLIENT','PROPOSETRANSFER',0),(390,'portfolio','PROPOSETRANSFER_CLIENT_CHECKER','CLIENT','PROPOSETRANSFER_CHECKER',0),(391,'portfolio','ACCEPTTRANSFER_CLIENT','CLIENT','ACCEPTTRANSFER',0),(392,'portfolio','ACCEPTTRANSFER_CLIENT_CHECKER','CLIENT','ACCEPTTRANSFER_CHECKER',0),(393,'portfolio','REJECTTRANSFER_CLIENT','CLIENT','REJECTTRANSFER',0),(394,'portfolio','REJECTTRANSFER_CLIENT_CHECKER','CLIENT','REJECTTRANSFER_CHECKER',0),(395,'portfolio','WITHDRAWTRANSFER_CLIENT','CLIENT','WITHDRAWTRANSFER',0),(396,'portfolio','WITHDRAWTRANSFER_CLIENT_CHECKER','CLIENT','WITHDRAWTRANSFER_CHECKER',0),(397,'portfolio','CLOSE_GROUP','GROUP','CLOSE',1),(398,'portfolio','CLOSE_CENTER','CENTER','CLOSE',1),(399,'xbrlmapping','UPDATE_XBRLMAPPING','XBRLMAPPING','UPDATE',0),(400,'configuration','READ_CACHE','CACHE','READ',0),(401,'configuration','UPDATE_CACHE','CACHE','UPDATE',0),(402,'transaction_loan','PAY_LOANCHARGE','LOANCHARGE','PAY',0),(403,'portfolio','CREATE_SAVINGSACCOUNTCHARGE','SAVINGSACCOUNTCHARGE','CREATE',0),(404,'portfolio','CREATE_SAVINGSACCOUNTCHARGE_CHECKER','SAVINGSACCOUNTCHARGE','CREATE_CHECKER',0),(405,'portfolio','UPDATE_SAVINGSACCOUNTCHARGE','SAVINGSACCOUNTCHARGE','UPDATE',0),(406,'portfolio','UPDATE_SAVINGSACCOUNTCHARGE_CHECKER','SAVINGSACCOUNTCHARGE','UPDATE_CHECKER',0),(407,'portfolio','DELETE_SAVINGSACCOUNTCHARGE','SAVINGSACCOUNTCHARGE','DELETE',0),(408,'portfolio','DELETE_SAVINGSACCOUNTCHARGE_CHECKER','SAVINGSACCOUNTCHARGE','DELETE_CHECKER',0),(409,'portfolio','WAIVE_SAVINGSACCOUNTCHARGE','SAVINGSACCOUNTCHARGE','WAIVE',0),(410,'portfolio','WAIVE_SAVINGSACCOUNTCHARGE_CHECKER','SAVINGSACCOUNTCHARGE','WAIVE_CHECKER',0),(411,'portfolio','PAY_SAVINGSACCOUNTCHARGE','SAVINGSACCOUNTCHARGE','PAY',0),(412,'portfolio','PAY_SAVINGSACCOUNTCHARGE_CHECKER','SAVINGSACCOUNTCHARGE','PAY_CHECKER',0),(413,'portfolio','PROPOSEANDACCEPTTRANSFER_CLIENT','CLIENT','PROPOSEANDACCEPTTRANSFER',0),(414,'portfolio','PROPOSEANDACCEPTTRANSFER_CLIENT_CHECKER','CLIENT','PROPOSEANDACCEPTTRANSFER_CHECKER',0),(415,'organisation','DELETE_TEMPLATE','TEMPLATE','DELETE',0),(416,'organisation','CREATE_TEMPLATE','TEMPLATE','CREATE',0),(417,'organisation','UPDATE_TEMPLATE','TEMPLATE','UPDATE',0),(418,'organisation','READ_TEMPLATE','TEMPLATE','READ',0),(419,'accounting','UPDATERUNNINGBALANCE_JOURNALENTRY','JOURNALENTRY','UPDATERUNNINGBALANCE',0),(420,'organisation','READ_SMS','SMS','READ',0),(421,'organisation','CREATE_SMS','SMS','CREATE',0),(422,'organisation','CREATE_SMS_CHECKER','SMS','CREATE_CHECKER',0),(423,'organisation','UPDATE_SMS','SMS','UPDATE',0),(424,'organisation','UPDATE_SMS_CHECKER','SMS','UPDATE_CHECKER',0),(425,'organisation','DELETE_SMS','SMS','DELETE',0),(426,'organisation','DELETE_SMS_CHECKER','SMS','DELETE_CHECKER',0),(427,'organisation','CREATE_HOLIDAY_CHECKER','HOLIDAY','CREATE_CHECKER',0),(428,'organisation','ACTIVATE_HOLIDAY','HOLIDAY','ACTIVATE',0),(429,'organisation','ACTIVATE_HOLIDAY_CHECKER','HOLIDAY','ACTIVATE_CHECKER',0),(430,'organisation','UPDATE_HOLIDAY','HOLIDAY','UPDATE',0),(431,'organisation','UPDATE_HOLIDAY_CHECKER','HOLIDAY','UPDATE_CHECKER',0),(432,'organisation','DELETE_HOLIDAY','HOLIDAY','DELETE',0),(433,'organisation','DELETE_HOLIDAY_CHECKER','HOLIDAY','DELETE_CHECKER',0),(434,'transaction_loan','UNDOWRITEOFF_LOAN','LOAN','UNDOWRITEOFF',0),(435,'portfolio','READ_SAVINGSACCOUNTCHARGE','SAVINGSACCOUNTCHARGE','READ',0),(436,'accounting','CREATE_JOURNALENTRY_CHECKER','JOURNALENTRY','CREATE_CHECKER',0),(437,'portfolio','UPDATE_DISBURSEMENTDETAIL','DISBURSEMENTDETAIL','UPDATE',0),(438,'portfolio','UPDATESAVINGSACCOUNT_CLIENT','CLIENT','UPDATESAVINGSACCOUNT',0),(439,'accounting','READ_ACCOUNTINGRULE','ACCOUNTINGRULE','READ',0),(440,'accounting','READ_JOURNALENTRY','JOURNALENTRY','READ',0),(441,'accounting','READ_GLACCOUNT','GLACCOUNT','READ',0),(442,'accounting','READ_GLCLOSURE','GLCLOSURE','READ',0),(443,'organisation','READ_HOLIDAY','HOLIDAY','READ',0),(444,'jobs','READ_SCHEDULER','SCHEDULER','READ',0),(445,'portfolio','READ_PRODUCTMIX','PRODUCTMIX','READ',0),(446,'portfolio','READ_MEETING','MEETING','READ',0),(447,'jobs','EXECUTEJOB_SCHEDULER','SCHEDULER','EXECUTEJOB',0),(448,'account_transfer','READ_STANDINGINSTRUCTION ','STANDINGINSTRUCTION ','READ',0),(449,'account_transfer','CREATE_STANDINGINSTRUCTION ','STANDINGINSTRUCTION ','CREATE',0),(450,'account_transfer','UPDATE_STANDINGINSTRUCTION ','STANDINGINSTRUCTION ','UPDATE',0),(451,'account_transfer','DELETE_STANDINGINSTRUCTION ','STANDINGINSTRUCTION ','DELETE',0),(452,'portfolio','CREATE_INTERESTRATECHART','INTERESTRATECHART','CREATE',0),(453,'portfolio','CREATE_INTERESTRATECHART_CHECKER','INTERESTRATECHART','CREATE_CHECKER',0),(454,'portfolio','UPDATE_INTERESTRATECHART','INTERESTRATECHART','UPDATE',0),(455,'portfolio','DELETE_INTERESTRATECHART','INTERESTRATECHART','DELETE',0),(456,'portfolio','UPDATE_INTERESTRATECHART_CHECKER','INTERESTRATECHART','UPDATE_CHECKER',0),(457,'portfolio','DELETE_INTERESTRATECHART_CHECKER','INTERESTRATECHART','DELETE_CHECKER',0),(458,'portfolio','CREATE_CHARTSLAB','CHARTSLAB','CREATE',0),(459,'portfolio','CREATE_CHARTSLAB_CHECKER','CHARTSLAB','CREATE_CHECKER',0),(460,'portfolio','UPDATE_CHARTSLAB','CHARTSLAB','UPDATE',0),(461,'portfolio','DELETE_CHARTSLAB','CHARTSLAB','DELETE',0),(462,'portfolio','UPDATE_CHARTSLAB_CHECKER','CHARTSLAB','UPDATE_CHECKER',0),(463,'portfolio','DELETE_CHARTSLAB_CHECKER','CHARTSLAB','DELETE_CHECKER',0),(464,'portfolio','CREATE_FIXEDDEPOSITPRODUCT','FIXEDDEPOSITPRODUCT','CREATE',0),(465,'portfolio','CREATE_FIXEDDEPOSITPRODUCT_CHECKER','FIXEDDEPOSITPRODUCT','CREATE_CHECKER',0),(466,'portfolio','UPDATE_FIXEDDEPOSITPRODUCT','FIXEDDEPOSITPRODUCT','UPDATE',0),(467,'portfolio','DELETE_FIXEDDEPOSITPRODUCT','FIXEDDEPOSITPRODUCT','DELETE',0),(468,'portfolio','UPDATE_FIXEDDEPOSITPRODUCT_CHECKER','FIXEDDEPOSITPRODUCT','UPDATE_CHECKER',0),(469,'portfolio','DELETE_FIXEDDEPOSITPRODUCT_CHECKER','FIXEDDEPOSITPRODUCT','DELETE_CHECKER',0),(470,'portfolio','CREATE_RECURRINGDEPOSITPRODUCT','RECURRINGDEPOSITPRODUCT','CREATE',0),(471,'portfolio','CREATE_RECURRINGDEPOSITPRODUCT_CHECKER','RECURRINGDEPOSITPRODUCT','CREATE_CHECKER',0),(472,'portfolio','UPDATE_RECURRINGDEPOSITPRODUCT','RECURRINGDEPOSITPRODUCT','UPDATE',0),(473,'portfolio','DELETE_RECURRINGDEPOSITPRODUCT','RECURRINGDEPOSITPRODUCT','DELETE',0),(474,'portfolio','UPDATE_RECURRINGDEPOSITPRODUCT_CHECKER','RECURRINGDEPOSITPRODUCT','UPDATE_CHECKER',0),(475,'portfolio','DELETE_RECURRINGDEPOSITPRODUCT_CHECKER','RECURRINGDEPOSITPRODUCT','DELETE_CHECKER',0),(476,'portfolio','READ_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','READ',0),(477,'portfolio','CREATE_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','CREATE',0),(478,'portfolio','CREATE_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','CREATE_CHECKER',0),(479,'portfolio','UPDATE_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','UPDATE',0),(480,'portfolio','UPDATE_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','UPDATE_CHECKER',0),(481,'portfolio','DELETE_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','DELETE',0),(482,'portfolio','DELETE_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','DELETE_CHECKER',0),(483,'transaction_savings','DEPOSIT_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','DEPOSIT',0),(484,'transaction_savings','DEPOSIT_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','DEPOSIT_CHECKER',0),(485,'transaction_savings','WITHDRAWAL_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','WITHDRAWAL',0),(486,'transaction_savings','WITHDRAWAL_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','WITHDRAWAL_CHECKER',0),(487,'transaction_savings','ACTIVATE_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','ACTIVATE',0),(488,'transaction_savings','ACTIVATE_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','ACTIVATE_CHECKER',0),(489,'transaction_savings','CALCULATEINTEREST_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','CALCULATEINTEREST',0),(490,'transaction_savings','CALCULATEINTEREST_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','CALCULATEINTEREST_CHECKER',0),(491,'transaction_savings','POSTINTEREST_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','POSTINTEREST',1),(492,'transaction_savings','POSTINTEREST_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','POSTINTEREST_CHECKER',0),(493,'transaction_savings','APPROVE_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','APPROVE',1),(494,'transaction_savings','REJECT_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','REJECT',1),(495,'transaction_savings','WITHDRAW_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','WITHDRAW',1),(496,'transaction_savings','APPROVALUNDO_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','APPROVALUNDO',1),(497,'transaction_savings','CLOSE_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','CLOSE',1),(498,'transaction_savings','APPROVE_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','APPROVE_CHECKER',0),(499,'transaction_savings','REJECT_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','REJECT_CHECKER',0),(500,'transaction_savings','WITHDRAW_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','WITHDRAW_CHECKER',0),(501,'transaction_savings','APPROVALUNDO_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','APPROVALUNDO_CHECKER',0),(502,'transaction_savings','CLOSE_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','CLOSE_CHECKER',0),(503,'transaction_savings','UNDOTRANSACTION_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','UNDOTRANSACTION',1),(504,'transaction_savings','UNDOTRANSACTION_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','UNDOTRANSACTION_CHECKER',0),(505,'transaction_savings','ADJUSTTRANSACTION_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','ADJUSTTRANSACTION',0),(506,'portfolio','READ_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','READ',0),(507,'portfolio','CREATE_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','CREATE',0),(508,'portfolio','CREATE_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','CREATE_CHECKER',0),(509,'portfolio','UPDATE_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','UPDATE',0),(510,'portfolio','UPDATE_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','UPDATE_CHECKER',0),(511,'portfolio','DELETE_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','DELETE',0),(512,'portfolio','DELETE_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','DELETE_CHECKER',0),(513,'transaction_savings','DEPOSIT_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','DEPOSIT',0),(514,'transaction_savings','DEPOSIT_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','DEPOSIT_CHECKER',0),(515,'transaction_savings','WITHDRAWAL_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','WITHDRAWAL',0),(516,'transaction_savings','WITHDRAWAL_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','WITHDRAWAL_CHECKER',0),(517,'transaction_savings','ACTIVATE_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','ACTIVATE',0),(518,'transaction_savings','ACTIVATE_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','ACTIVATE_CHECKER',0),(519,'transaction_savings','CALCULATEINTEREST_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','CALCULATEINTEREST',0),(520,'transaction_savings','CALCULATEINTEREST_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','CALCULATEINTEREST_CHECKER',0),(521,'transaction_savings','POSTINTEREST_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','POSTINTEREST',1),(522,'transaction_savings','POSTINTEREST_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','POSTINTEREST_CHECKER',0),(523,'transaction_savings','APPROVE_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','APPROVE',1),(524,'transaction_savings','REJECT_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','REJECT',1),(525,'transaction_savings','WITHDRAW_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','WITHDRAW',1),(526,'transaction_savings','APPROVALUNDO_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','APPROVALUNDO',1),(527,'transaction_savings','CLOSE_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','CLOSE',1),(528,'transaction_savings','APPROVE_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','APPROVE_CHECKER',0),(529,'transaction_savings','REJECT_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','REJECT_CHECKER',0),(530,'transaction_savings','WITHDRAW_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','WITHDRAW_CHECKER',0),(531,'transaction_savings','APPROVALUNDO_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','APPROVALUNDO_CHECKER',0),(532,'transaction_savings','CLOSE_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','CLOSE_CHECKER',0),(533,'transaction_savings','UNDOTRANSACTION_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','UNDOTRANSACTION',1),(534,'transaction_savings','UNDOTRANSACTION_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','UNDOTRANSACTION_CHECKER',0),(535,'transaction_savings','ADJUSTTRANSACTION_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','ADJUSTTRANSACTION',0),(536,'transaction_savings','PREMATURECLOSE_FIXEDDEPOSITACCOUNT_CHECKER','FIXEDDEPOSITACCOUNT','PREMATURECLOSE_CHECKER',0),(537,'transaction_savings','PREMATURECLOSE_FIXEDDEPOSITACCOUNT','FIXEDDEPOSITACCOUNT','PREMATURECLOSE',1),(538,'transaction_savings','PREMATURECLOSE_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','PREMATURECLOSE_CHECKER',0),(539,'transaction_savings','PREMATURECLOSE_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','PREMATURECLOSE',1),(540,'transaction_loan','DISBURSETOSAVINGS_LOAN','LOAN','DISBURSETOSAVINGS',0),(541,'transaction_loan','RECOVERYPAYMENT_LOAN','LOAN','RECOVERYPAYMENT',0),(542,'organisation','READ_RECURRINGDEPOSITPRODUCT','RECURRINGDEPOSITPRODUCT','READ',0),(543,'organisation','READ_FIXEDDEPOSITPRODUCT','FIXEDDEPOSITPRODUCT','READ',0),(544,'accounting','READ_FINANCIALACTIVITYACCOUNT','FINANCIALACTIVITYACCOUNT','READ',0),(545,'accounting','CREATE_FINANCIALACTIVITYACCOUNT','FINANCIALACTIVITYACCOUNT','CREATE',0),(546,'accounting','DELETE_FINANCIALACTIVITYACCOUNT','FINANCIALACTIVITYACCOUNT','DELETE',0),(547,'accounting','UPDATE_FINANCIALACTIVITYACCOUNT','FINANCIALACTIVITYACCOUNT','UPDATE',0),(548,'datatable','UPDATE_LIKELIHOOD','likelihood','UPDATE',0),(549,'survey','REGISTER_SURVEY','survey','CREATE',0),(550,'accounting','EXECUTE_PERIODICACCRUALACCOUNTING','PERIODICACCRUALACCOUNTING','EXECUTE',0),(551,'portfolio','INACTIVATE_SAVINGSACCOUNTCHARGE','SAVINGSACCOUNTCHARGE','INACTIVATE',0),(552,'portfolio','INACTIVATE_SAVINGSACCOUNTCHARGE_CHECKER','SAVINGSACCOUNTCHARGE','INACTIVATE_CHECKER',0),(553,'portfolio_center','DISASSOCIATEGROUPS_CENTER','CENTER','DISASSOCIATEGROUPS',0),(554,'portfolio_center','ASSOCIATEGROUPS_CENTER','CENTER','ASSOCIATEGROUPS',0),(555,'portfolio_center','DISASSOCIATEGROUPS_CENTER_CHECKER','CENTER','DISASSOCIATEGROUPS_CHECKER',0),(556,'portfolio_center','ASSOCIATEGROUPS_CENTER_CHECKER','CENTER','ASSOCIATEGROUPS_CHECKER',0),(557,'loan_reschedule','READ_RESCHEDULELOAN','RESCHEDULELOAN','READ',0),(558,'loan_reschedule','CREATE_RESCHEDULELOAN','RESCHEDULELOAN','CREATE',0),(559,'loan_reschedule','REJECT_RESCHEDULELOAN','RESCHEDULELOAN','REJECT',0),(560,'loan_reschedule','APPROVE_RESCHEDULELOAN','RESCHEDULELOAN','APPROVE',0),(561,'configuration','CREATE_HOOK','HOOK','CREATE',0),(562,'configuration','READ_HOOK','HOOK','READ',0),(563,'configuration','UPDATE_HOOK','HOOK','UPDATE',0),(564,'configuration','DELETE_HOOK','HOOK','DELETE',0),(565,'portfolio','REMOVESAVINGSOFFICER_SAVINGSACCOUNT','SAVINGSACCOUNT','REMOVESAVINGSOFFICER',1),(566,'portfolio','UPDATESAVINGSOFFICER_SAVINGSACCOUNT','SAVINGSACCOUNT','UPDATESAVINGSOFFICER',1),(567,'report','READ_Active Loans - Summary(Pentaho)','Active Loans - Summary(Pentaho)','READ',0),(568,'report','READ_Active Loans by Disbursal Period(Pentaho)','Active Loans by Disbursal Period(Pentaho)','READ',0),(569,'report','READ_Active Loans in last installment Summary(Pentaho)','Active Loans in last installment Summary(Pentaho)','READ',0),(570,'report','READ_Active Loans in last installment(Pentaho)','Active Loans in last installment(Pentaho)','READ',0),(571,'report','READ_Active Loans Passed Final Maturity Summary(Pentaho)','Active Loans Passed Final Maturity Summary(Pentaho)','READ',0),(572,'report','READ_Active Loans Passed Final Maturity(Pentaho)','Active Loans Passed Final Maturity(Pentaho)','READ',0),(573,'report','READ_Aging Detail(Pentaho)','Aging Detail(Pentaho)','READ',0),(574,'report','READ_Aging Summary (Arrears in Months)(Pentaho)','Aging Summary (Arrears in Months)(Pentaho)','READ',0),(575,'report','READ_Aging Summary (Arrears in Weeks)(Pentaho)','Aging Summary (Arrears in Weeks)(Pentaho)','READ',0),(576,'report','READ_Client Listing(Pentaho)','Client Listing(Pentaho)','READ',0),(577,'report','READ_Client Loan Account Schedule','Client Loan Account Schedule','READ',0),(578,'report','READ_Client Loans Listing(Pentaho)','Client Loans Listing(Pentaho)','READ',0),(579,'report','READ_Client Saving Transactions','Client Saving Transactions','READ',0),(580,'report','READ_Client Savings Summary','Client Savings Summary','READ',0),(581,'report','READ_ClientSummary ','ClientSummary ','READ',0),(582,'report','READ_ClientTrendsByDay','ClientTrendsByDay','READ',0),(583,'report','READ_ClientTrendsByMonth','ClientTrendsByMonth','READ',0),(584,'report','READ_ClientTrendsByWeek','ClientTrendsByWeek','READ',0),(585,'report','READ_Demand_Vs_Collection','Demand_Vs_Collection','READ',0),(586,'report','READ_Disbursal_Vs_Awaitingdisbursal','Disbursal_Vs_Awaitingdisbursal','READ',0),(587,'report','READ_Expected Payments By Date - Basic(Pentaho)','Expected Payments By Date - Basic(Pentaho)','READ',0),(588,'report','READ_Funds Disbursed Between Dates Summary by Office(Pentaho)','Funds Disbursed Between Dates Summary by Office(Pentaho)','READ',0),(589,'report','READ_Funds Disbursed Between Dates Summary(Pentaho)','Funds Disbursed Between Dates Summary(Pentaho)','READ',0),(590,'report','READ_GroupNamesByStaff','GroupNamesByStaff','READ',0),(591,'report','READ_GroupSavingSummary','GroupSavingSummary','READ',0),(592,'report','READ_LoanCyclePerProduct','LoanCyclePerProduct','READ',0),(593,'report','READ_Loans Awaiting Disbursal Summary by Month(Pentaho)','Loans Awaiting Disbursal Summary by Month(Pentaho)','READ',0),(594,'report','READ_Loans Awaiting Disbursal Summary(Pentaho)','Loans Awaiting Disbursal Summary(Pentaho)','READ',0),(595,'report','READ_Loans Awaiting Disbursal(Pentaho)','Loans Awaiting Disbursal(Pentaho)','READ',0),(596,'report','READ_Loans Pending Approval(Pentaho)','Loans Pending Approval(Pentaho)','READ',0),(597,'report','READ_LoanTrendsByDay','LoanTrendsByDay','READ',0),(598,'report','READ_LoanTrendsByMonth','LoanTrendsByMonth','READ',0),(599,'report','READ_LoanTrendsByWeek','LoanTrendsByWeek','READ',0),(600,'report','READ_Obligation Met Loans Details(Pentaho)','Obligation Met Loans Details(Pentaho)','READ',0),(601,'report','READ_Obligation Met Loans Summary(Pentaho)','Obligation Met Loans Summary(Pentaho)','READ',0),(602,'report','READ_Portfolio at Risk by Branch(Pentaho)','Portfolio at Risk by Branch(Pentaho)','READ',0),(603,'report','READ_Portfolio at Risk(Pentaho)','Portfolio at Risk(Pentaho)','READ',0),(604,'report','READ_Rescheduled Loans(Pentaho)','Rescheduled Loans(Pentaho)','READ',0),(605,'report','READ_Savings Transactions','Savings Transactions','READ',0),(606,'report','READ_TxnRunningBalances(Pentaho)','TxnRunningBalances(Pentaho)','READ',0),(607,'report','READ_Written-Off Loans(Pentaho)','Written-Off Loans(Pentaho)','READ',0),(608,'configuration','CREATE_ACCOUNTNUMBERFORMAT','ACCOUNTNUMBERFORMAT','CREATE',0),(609,'configuration','READ_ACCOUNTNUMBERFORMAT','ACCOUNTNUMBERFORMAT','READ',0),(610,'configuration','UPDATE_ACCOUNTNUMBERFORMAT','ACCOUNTNUMBERFORMAT','UPDATE',0),(611,'configuration','DELETE_ACCOUNTNUMBERFORMAT','HOOK','DELETE',0),(612,'portfolio','RECOVERGUARANTEES_LOAN','LOAN','RECOVERGUARANTEES',0),(613,'portfolio','RECOVERGUARANTEES_LOAN_CHECKER','LOAN','RECOVERGUARANTEES_CHECKER',0),(614,'portfolio','REJECT_CLIENT','CLIENT','REJECT',1),(615,'portfolio','REJECT_CLIENT_CHECKER','CLIENT','REJECT_CHECKER',0),(616,'portfolio','WITHDRAW_CLIENT','CLIENT','WITHDRAW',1),(617,'portfolio','WITHDRAW_CLIENT_CHECKER','CLIENT','WITHDRAW_CHECKER',0),(618,'portfolio','REACTIVATE_CLIENT','CLIENT','REACTIVATE',1),(619,'portfolio','REACTIVATE_CLIENT_CHECKER','CLIENT','REACTIVATE_CHECKER',0),(620,'transaction_savings','UPDATEDEPOSITAMOUNT_RECURRINGDEPOSITACCOUNT','RECURRINGDEPOSITACCOUNT','UPDATEDEPOSITAMOUNT',1),(621,'transaction_savings','UPDATEDEPOSITAMOUNT_RECURRINGDEPOSITACCOUNT_CHECKER','RECURRINGDEPOSITACCOUNT','UPDATEDEPOSITAMOUNT',1),(622,'transaction_savings','REFUNDBYTRANSFER_ACCOUNTTRANSFER_CHECKER','ACCOUNTTRANSFER','REFUNDBYTRANSFER',0),(623,'transaction_savings','REFUNDBYTRANSFER_ACCOUNTTRANSFER','ACCOUNTTRANSFER','REFUNDBYTRANSFER',1),(624,'transaction_loan','REFUNDBYCASH_LOAN','LOAN','REFUNDBYCASH',1),(625,'transaction_loan','REFUNDBYCASH_LOAN_CHECKER','LOAN','REFUNDBYCASH',0),(626,'cash_mgmt','CREATE_TELLER','TELLER','CREATE',1),(627,'cash_mgmt','UPDATE_TELLER','TELLER','UPDATE',1),(628,'cash_mgmt','ALLOCATECASHIER_TELLER','TELLER','ALLOCATE',1),(629,'cash_mgmt','UPDATECASHIERALLOCATION_TELLER','TELLER','UPDATECASHIERALLOCATION',1),(630,'cash_mgmt','DELETECASHIERALLOCATION_TELLER','TELLER','DELETECASHIERALLOCATION',1),(631,'cash_mgmt','ALLOCATECASHTOCASHIER_TELLER','TELLER','ALLOCATECASHTOCASHIER',1),(632,'cash_mgmt','SETTLECASHFROMCASHIER_TELLER','TELLER','SETTLECASHFROMCASHIER',1),(633,'authorisation','DISABLE_ROLE','ROLE','DISABLE',0),(634,'authorisation','DISABLE_ROLE_CHECKER','ROLE','DISABLE_CHECKER',0),(635,'authorisation','ENABLE_ROLE','ROLE','ENABLE',0),(636,'authorisation','ENABLE_ROLE_CHECKER','ROLE','ENABLE_CHECKER',0),(637,'accounting','DEFINEOPENINGBALANCE_JOURNALENTRY','JOURNALENTRY','DEFINEOPENINGBALANCE',1),(638,'collection_sheet','READ_COLLECTIONSHEET','COLLECTIONSHEET','READ',0),(639,'collection_sheet','SAVE_COLLECTIONSHEET','COLLECTIONSHEET','SAVE',0),(640,'infrastructure','CREATE_ENTITYMAPPING','ENTITYMAPPING','CREATE',0),(641,'infrastructure','UPDATE_ENTITYMAPPING','ENTITYMAPPING','UPDATE',0),(642,'infrastructure','DELETE_ENTITYMAPPING','ENTITYMAPPING','DELETE',0),(643,'organisation','READ_WORKINGDAYS','WORKINGDAYS','READ',0),(644,'organisation','UPDATE_WORKINGDAYS','WORKINGDAYS','UPDATE',0),(645,'organisation','UPDATE_WORKINGDAYS_CHECKER','WORKINGDAYS','UPDATE_CHECKER',0),(646,'authorisation','READ_PASSWORD_PREFERENCES','PASSWORD_PREFERENCES','READ',0),(647,'authorisation','UPDATE_PASSWORD_PREFERENCES','PASSWORD_PREFERENCES','UPDATE',0),(648,'authorisation','UPDATE_PASSWORD_PREFERENCES_CHECKER','PASSWORD_PREFERENCES','UPDATE_CHECKER',0),(649,'portfolio','CREATE_PAYMENTTYPE','PAYMENTTYPE','CREATE',0),(650,'portfolio','UPDATE_PAYMENTTYPE','PAYMENTTYPE','UPDATE',0),(651,'portfolio','DELETE_PAYMENTTYPE','PAYMENTTYPE','DELETE',0),(652,'cash_mgmt','DELETE_TELLER','TELLER','DELETE',1),(653,'report','READ_General Ledger Report','General Ledger Report','READ',0),(654,'portfolio','READ_STAFFIMAGE','STAFFIMAGE','READ',0),(655,'portfolio','CREATE_STAFFIMAGE','STAFFIMAGE','CREATE',1),(656,'portfolio','CREATE_STAFFIMAGE_CHECKER','STAFFIMAGE','CREATE',0),(657,'portfolio','DELETE_STAFFIMAGE','STAFFIMAGE','DELETE',1),(658,'portfolio','DELETE_STAFFIMAGE_CHECKER','STAFFIMAGE','DELETE',0),(659,'report','READ_Active Loan Summary per Branch','Active Loan Summary per Branch','READ',0),(660,'report','READ_Disbursal Report','Disbursal Report','READ',0),(661,'report','READ_Balance Outstanding','Balance Outstanding','READ',0),(662,'report','READ_Collection Report','Collection Report','READ',0),(663,'portfolio','READ_PAYMENTTYPE','PAYMENTTYPE','READ',0),(664,'report','READ_Staff Assignment History','Staff Assignment History(Pentaho)','READ',0),(665,'externalservices','UPDATE_EXTERNALSERVICES','EXTERNALSERVICES','UPDATE',0),(666,'portfolio','READ_CLIENTCHARGE','CLIENTCHARGE','READ',0),(667,'portfolio','CREATE_CLIENTCHARGE','CLIENTCHARGE','CREATE',0),(668,'portfolio','DELETE_CLIENTCHARGE','CLIENTCHARGE','DELETE',0),(669,'portfolio','WAIVE_CLIENTCHARGE','CLIENTCHARGE','WAIVE',0),(670,'portfolio','PAY_CLIENTCHARGE','CLIENTCHARGE','PAY',0),(671,'portfolio','INACTIVATE_CLIENTCHARGE','CLIENTCHARGE','INACTIVATE',0),(672,'portfolio','UPDATE_CLIENTCHARGE','CLIENTCHARGE','UPDATE',0),(673,'portfolio','CREATE_CLIENTCHARGE_CHECKER','CLIENTCHARGE','CREATE_CHECKER',0),(674,'portfolio','DELETE_CLIENTCHARGE_CHECKER','CLIENTCHARGE','DELETE_CHECKER',0),(675,'portfolio','WAIVE_CLIENTCHARGE_CHECKER','CLIENTCHARGE','WAIVE_CHECKER',0),(676,'portfolio','PAY_CLIENTCHARGE_CHECKER','CLIENTCHARGE','PAY_CHECKER',0),(677,'portfolio','INACTIVATE_CLIENTCHARGE_CHECKER','CLIENTCHARGE','INACTIVATE_CHECKER',0),(678,'portfolio','UPDATE_CLIENTCHARGE_CHECKER','CLIENTCHARGE','UPDATE_CHECKER',0),(679,'transaction_client','READTRANSACTION_CLIENT','CLIENT','READTRANSACTION',0),(680,'transaction_client','UNDOTRANSACTION_CLIENT','CLIENT','UNDOTRANSACTION',0),(681,'transaction_client','UNDOTRANSACTION_CLIENT_CHECKER','CLIENT','UNDOTRANSACTION_CHECKER',0),(682,'LOAN_PROVISIONING','CREATE_PROVISIONCATEGORY','PROVISIONCATEGORY','CREATE',0),(683,'LOAN_PROVISIONING','DELETE_PROVISIONCATEGORY','PROVISIONCATEGORY','DELETE',0),(684,'LOAN_PROVISIONING','CREATE_PROVISIONCRITERIA','PROVISIONINGCRITERIA','CREATE',0),(685,'LOAN_PROVISIONING','UPDATE_PROVISIONCRITERIA','PROVISIONINGCRITERIA','UPDATE',0),(686,'LOAN_PROVISIONING','DELETE_PROVISIONCRITERIA','PROVISIONINGCRITERIA','DELETE',0),(687,'LOAN_PROVISIONING','CREATE_PROVISIONENTRIES','PROVISIONINGENTRIES','CREATE',0),(688,'LOAN_PROVISIONING','CREATE_PROVISIONJOURNALENTRIES','PROVISIONINGENTRIES','CREATE',0),(689,'LOAN_PROVISIONING','RECREATE_PROVISIONENTRIES','PROVISIONINGENTRIES','RECREATE',0),(690,'portfolio','READ_FLOATINGRATE','FLOATINGRATE','READ',0),(691,'portfolio','CREATE_FLOATINGRATE','FLOATINGRATE','CREATE',1),(692,'portfolio','CREATE_FLOATINGRATE_CHECKER','FLOATINGRATE','CREATE_CHECKER',0),(693,'portfolio','UPDATE_FLOATINGRATE','FLOATINGRATE','UPDATE',1),(694,'portfolio','UPDATE_FLOATINGRATE_CHECKER','FLOATINGRATE','UPDATE_CHECKER',0),(695,'portfolio','CREATESCHEDULEEXCEPTIONS_LOAN','LOAN','CREATESCHEDULEEXCEPTIONS',0),(696,'portfolio','CREATESCHEDULEEXCEPTIONS_LOAN_CHECKER','LOAN','CREATESCHEDULEEXCEPTIONS_CHECKER',0),(697,'portfolio','DELETESCHEDULEEXCEPTIONS_LOAN','LOAN','DELETESCHEDULEEXCEPTIONS',0),(698,'portfolio','DELETESCHEDULEEXCEPTIONS_LOAN_CHECKER','LOAN','DELETESCHEDULEEXCEPTIONS_CHECKER',0),(699,'transaction_loan','DISBURSALLASTUNDO_LOAN','LOAN','DISBURSALLASTUNDO',0),(700,'transaction_loan','DISBURSALLASTUNDO_LOAN_CHECKER','LOAN','DISBURSALLASTUNDO_CHECKER',0),(701,'SHAREPRODUCT','CREATE_SHAREPRODUCT','SHAREPRODUCT','CREATE',0),(702,'SHAREPRODUCT','UPDATE_SHAREPRODUCT','SHAREPRODUCT','CREATE',0),(703,'SHAREACCOUNT','CREATE_SHAREACCOUNT','SHAREACCOUNT','CREATE',0),(704,'SHAREACCOUNT','UPDATE_SHAREACCOUNT','SHAREACCOUNT','CREATE',0),(705,'organisation','READ_TAXCOMPONENT','TAXCOMPONENT','READ',0),(706,'organisation','CREATE_TAXCOMPONENT','TAXCOMPONENT','CREATE',0),(707,'organisation','CREATE_TAXCOMPONENT_CHECKER','TAXCOMPONENT','CREATE_CHECKER',0),(708,'organisation','UPDATE_TAXCOMPONENT','TAXCOMPONENT','UPDATE',0),(709,'organisation','UPDATE_TAXCOMPONENT_CHECKER','TAXCOMPONENT','UPDATE_CHECKER',0),(710,'organisation','READ_TAXGROUP','TAXGROUP','READ',0),(711,'organisation','CREATE_TAXGROUP','TAXGROUP','CREATE',0),(712,'organisation','CREATE_TAXGROUP_CHECKER','TAXGROUP','CREATE_CHECKER',0),(713,'organisation','UPDATE_TAXGROUP','TAXGROUP','UPDATE',0),(714,'organisation','UPDATE_TAXGROUP_CHECKER','TAXGROUP','UPDATE_CHECKER',0),(715,'portfolio','UPDATEWITHHOLDTAX_SAVINGSACCOUNT','SAVINGSACCOUNT','UPDATEWITHHOLDTAX',0),(716,'portfolio','UPDATEWITHHOLDTAX_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','UPDATEWITHHOLDTAX_CHECKER',0),(717,'SHAREPRODUCT','CREATE_DIVIDEND_SHAREPRODUCT','SHAREPRODUCT','CREATE_DIVIDEND',0),(718,'SHAREPRODUCT','CREATE_DIVIDEND_SHAREPRODUCT_CHECKER','SHAREPRODUCT','CREATE_DIVIDEND_CHECKER',0),(719,'SHAREPRODUCT','APPROVE_DIVIDEND_SHAREPRODUCT','SHAREPRODUCT','APPROVE_DIVIDEND',0),(720,'SHAREPRODUCT','APPROVE_DIVIDEND_SHAREPRODUCT_CHECKER','SHAREPRODUCT','APPROVE_DIVIDEND_CHECKER',0),(721,'SHAREPRODUCT','DELETE_DIVIDEND_SHAREPRODUCT','SHAREPRODUCT','DELETE_DIVIDEND',0),(722,'SHAREPRODUCT','DELETE_DIVIDEND_SHAREPRODUCT_CHECKER','SHAREPRODUCT','DELETE_DIVIDEND_CHECKER',0),(723,'SHAREPRODUCT','READ_DIVIDEND_SHAREPRODUCT','SHAREPRODUCT','READ_DIVIDEND',0),(724,'SHAREACCOUNT','APPROVE_SHAREACCOUNT','SHAREACCOUNT','APPROVE',0),(725,'SHAREACCOUNT','ACTIVATE_SHAREACCOUNT','SHAREACCOUNT','ACTIVATE',0),(726,'SHAREACCOUNT','UNDOAPPROVAL_SHAREACCOUNT','SHAREACCOUNT','UNDOAPPROVAL',0),(727,'SHAREACCOUNT','REJECT_SHAREACCOUNT','SHAREACCOUNT','REJECT',0),(728,'SHAREACCOUNT','APPLYADDITIONALSHARES_SHAREACCOUNT','SHAREACCOUNT','APPLYADDITIONALSHARES',0),(729,'SHAREACCOUNT','APPROVEADDITIONALSHARES_SHAREACCOUNT','SHAREACCOUNT','APPROVEADDITIONALSHARES',0),(730,'SHAREACCOUNT','REJECTADDITIONALSHARES_SHAREACCOUNT','SHAREACCOUNT','REJECTADDITIONALSHARES',0),(731,'SHAREACCOUNT','REDEEMSHARES_SHAREACCOUNT','SHAREACCOUNT','REDEEMSHARES',0),(732,'SHAREACCOUNT','CLOSE_SHAREACCOUNT','SHAREACCOUNT','CLOSE',0),(733,'SSBENEFICIARYTPT','READ_SSBENEFICIARYTPT','SSBENEFICIARYTPT','READ',0),(734,'SSBENEFICIARYTPT','CREATE_SSBENEFICIARYTPT','SSBENEFICIARYTPT','CREATE',0),(735,'SSBENEFICIARYTPT','UPDATE_SSBENEFICIARYTPT','SSBENEFICIARYTPT','UPDATE',0),(736,'SSBENEFICIARYTPT','DELETE_SSBENEFICIARYTPT','SSBENEFICIARYTPT','DELETE',0),(737,'portfolio','FORECLOSURE_LOAN','LOAN','FORECLOSURE',0),(738,'portfolio','FORECLOSURE_LOAN_CHECKER','LOAN','FORECLOSURE_CHECKER',0),(739,'portfolio','CREATE_ADDRESS','ADDRESS','CREATE',0),(740,'portfolio','CREATE_ADDRESS_CHECKER','ADDRESS','CREATE_CHECKER',1),(741,'portfolio','UPDATE_ADDRESS','ADDRESS','UPDATE',0),(742,'portfolio','UPDATE_ADDRESS_CHECKER','ADDRESS','UPDATE_CHECKER',1),(743,'portfolio','READ_ADDRESS','ADDRESS','READ',0),(744,'portfolio','DELETE_ADDRESS','ADDRESS','DELETE',0),(745,'portfolio','DELETE_ADDRESS_CHECKER','ADDRESS','DELETE_CHECKER',1),(746,'jobs','CREATE_REPORTMAILINGJOB','REPORTMAILINGJOB','CREATE',0),(747,'jobs','UPDATE_REPORTMAILINGJOB','REPORTMAILINGJOB','UPDATE',0),(748,'jobs','DELETE_REPORTMAILINGJOB','REPORTMAILINGJOB','DELETE',0),(749,'jobs','READ_REPORTMAILINGJOB','REPORTMAILINGJOB','READ',0),(750,'portfolio','UNDOREJECT_CLIENT','CLIENT','UNDOREJECT',1),(751,'portfolio','UNDOREJECT_CLIENT_CHECKER','CLIENT','UNDOREJECT_CHECKER',1),(752,'portfolio','UNDOWITHDRAWAL_CLIENT','CLIENT','UNDOWITHDRAWAL',1),(753,'portfolio','UNDOWITHDRAWAL_CLIENT_CHECKER','CLIENT','UNDOWITHDRAWAL_CHECKER',1),(754,'organisation','READ_SMSCAMPAIGN','SMSCAMPAIGN','READ',0),(755,'organisation','CREATE_SMSCAMPAIGN','SMSCAMPAIGN','CREATE',0),(756,'organisation','CREATE_SMSCAMPAIGN_CHECKER','SMSCAMPAIGN','CREATE',0),(757,'organisation','UPDATE_SMSCAMPAIGN','SMSCAMPAIGN','UPDATE',0),(758,'organisation','UPDATE_SMSCAMPAIGN_CHECKER','SMSCAMPAIGN','UPDATE',0),(759,'organisation','DELETE_SMSCAMPAIGN','SMSCAMPAIGN','DELETE',0),(760,'organisation','DELETE_SMSCAMPAIGN_CHECKER','SMSCAMPAIGN','DELETE',0),(761,'organisation','ACTIVATE_SMSCAMPAIGN','SMSCAMPAIGN','ACTIVATE',0),(762,'organisation','CLOSE_SMSCAMPAIGN','SMSCAMPAIGN','CLOSE',0),(763,'organisation','REACTIVATE_SMSCAMPAIGN','SMSCAMPAIGN','REACTIVATE',0),(764,'organisation','READ_EMAIL','EMAIL','READ',0),(765,'organisation','CREATE_EMAIL','EMAIL','CREATE',0),(766,'organisation','CREATE_EMAIL_CHECKER','EMAIL','CREATE_CHECKER',0),(767,'organisation','UPDATE_EMAIL','EMAIL','UPDATE',0),(768,'organisation','UPDATE_EMAIL_CHECKER','EMAIL','UPDATE_CHECKER',0),(769,'organisation','DELETE_EMAIL','EMAIL','DELETE',0),(770,'organisation','DELETE_EMAIL_CHECKER','EMAIL','DELETE_CHECKER',0),(771,'organisation','READ_EMAIL_CAMPAIGN','EMAIL_CAMPAIGN','READ',0),(772,'organisation','CREATE_EMAIL_CAMPAIGN','EMAIL_CAMPAIGN','CREATE',0),(773,'organisation','CREATE_EMAIL_CAMPAIGN_CHECKER','EMAIL_CAMPAIGN','CREATE_CHECKER',0),(774,'organisation','UPDATE_EMAIL_CAMPAIGN','EMAIL_CAMPAIGN','UPDATE',0),(775,'organisation','UPDATE_EMAIL_CAMPAIGN_CHECKER','EMAIL_CAMPAIGN','UPDATE_CHECKER',0),(776,'organisation','DELETE_EMAIL_CAMPAIGN','EMAIL_CAMPAIGN','DELETE',0),(777,'organisation','DELETE_EMAIL_CAMPAIGN_CHECKER','EMAIL_CAMPAIGN','DELETE_CHECKER',0),(778,'organisation','CLOSE_EMAIL_CAMPAIGN','EMAIL_CAMPAIGN','CLOSE',0),(779,'organisation','ACTIVATE_EMAIL_CAMPAIGN','EMAIL_CAMPAIGN','ACTIVATE',0),(780,'organisation','REACTIVATE_EMAIL_CAMPAIGN','EMAIL_CAMPAIGN','REACTIVATE',0),(781,'organisation','READ_EMAIL_CONFIGURATION','EMAIL_CONFIGURATION','READ',0),(782,'organisation','UPDATE_EMAIL_CONFIGURATION','EMAIL_CONFIGURATION','UPDATE',0),(783,'report','READ_Active Clients - Email','Active Clients - Email','READ',0),(784,'report','READ_Prospective Clients - Email','Prospective Clients - Email','READ',0),(785,'report','READ_Active Loan Clients - Email','Active Loan Clients - Email','READ',0),(786,'report','READ_Loans in arrears - Email','Loans in arrears - Email','READ',0),(787,'report','READ_Loans disbursed to clients - Email','Loans disbursed to clients - Email','READ',0),(788,'report','READ_Loan payments due - Email','Loan payments due - Email','READ',0),(789,'report','READ_Dormant Prospects - Email','Dormant Prospects - Email','READ',0),(790,'report','READ_Active Group Leaders - Email','Active Group Leaders - Email','READ',0),(791,'report','READ_Loan Payments Due (Overdue Loans) - Email','Loan Payments Due (Overdue Loans) - Email','READ',0),(792,'report','READ_Loan Payments Received (Active Loans) - Email','Loan Payments Received (Active Loans) - Email','READ',0),(793,'report','READ_Loan Payments Received (Overdue Loans) - Email','Loan Payments Received (Overdue Loans)  - Email','READ',0),(794,'report','READ_Loan Fully Repaid - Email','Loan Fully Repaid - Email','READ',0),(795,'report','READ_Loans Outstanding after final instalment date - Email','Loans Outstanding after final instalment date - Email','READ',0),(796,'report','READ_Happy Birthday - Email','Happy Birthday - Email','READ',0),(797,'report','READ_Loan Rejected - Email','Loan Rejected - Email','READ',0),(798,'report','READ_Loan Approved - Email','Loan Approved - Email','READ',0),(799,'report','READ_Loan Repayment - Email','Loan Repayment - Email','READ',0),(800,'datatable','READ_ENTITY_DATATABLE_CHECK','ENTITY_DATATABLE_CHECK','READ',0),(801,'datatable','CREATE_ENTITY_DATATABLE_CHECK','ENTITY_DATATABLE_CHECK','CREATE',0),(802,'datatable','DELETE_ENTITY_DATATABLE_CHECK','ENTITY_DATATABLE_CHECK','DELETE',0),(803,'configuration','CREATE_CREDITBUREAU_LOANPRODUCT_MAPPING','CREDITBUREAU_LOANPRODUCT_MAPPING','CREATE',0),(804,'configuration','CREATE_ORGANISATIONCREDITBUREAU','ORGANISATIONCREDITBUREAU','CREATE',0),(805,'configuration','UPDATE_ORGANISATIONCREDITBUREAU','ORGANISATIONCREDITBUREAU','UPDATE',0),(806,'configuration','UPDATE_CREDITBUREAU_LOANPRODUCT_MAPPING','CREDITBUREAU_LOANPRODUCT_MAPPING','UPDATE',0),(807,'portfolio','CREATE_FAMILYMEMBERS','FAMILYMEMBERS','CREATE',0),(808,'portfolio','UPDATE_FAMILYMEMBERS','FAMILYMEMBERS','UPDATE',0),(809,'portfolio','DELETE_FAMILYMEMBERS','FAMILYMEMBERS','DELETE',0),(810,'transaction_savings','HOLDAMOUNT_SAVINGSACCOUNT','SAVINGSACCOUNT','HOLDAMOUNT',0),(811,'transaction_savings','HOLDAMOUNT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','HOLDAMOUNT_CHECKER',0),(812,'transaction_savings','BLOCKDEBIT_SAVINGSACCOUNT','SAVINGSACCOUNT','BLOCKDEBIT',0),(813,'transaction_savings','BLOCKDEBIT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','BLOCKDEBIT_CHECKER',0),(814,'transaction_savings','UNBLOCKDEBIT_SAVINGSACCOUNT','SAVINGSACCOUNT','UNBLOCKDEBIT',0),(815,'transaction_savings','UNBLOCKDEBIT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','UNBLOCKDEBIT_CHECKER',0),(816,'transaction_savings','BLOCKCREDIT_SAVINGSACCOUNT','SAVINGSACCOUNT','BLOCKCREDIT',0),(817,'transaction_savings','BLOCKCREDIT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','BLOCKCREDIT_CHECKER',0),(818,'transaction_savings','UNBLOCKCREDIT_SAVINGSACCOUNT','SAVINGSACCOUNT','UNBLOCKCREDIT',0),(819,'transaction_savings','UNBLOCKCREDIT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','UNBLOCKCREDIT_CHECKER',0),(820,'transaction_savings','BLOCK_SAVINGSACCOUNT','SAVINGSACCOUNT','BLOCK',0),(821,'transaction_savings','BLOCK_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','BLOCK_CHECKER',0),(822,'transaction_savings','UNBLOCK_SAVINGSACCOUNT','SAVINGSACCOUNT','UNBLOCK',0),(823,'transaction_savings','UNBLOCK_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','UNBLOCK_CHECKER',0),(824,'transaction_savings','RELEASEAMOUNT_SAVINGSACCOUNT','SAVINGSACCOUNT','RELEASEAMOUNT',0),(825,'transaction_savings','RELEASEAMOUNT_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','RELEASEAMOUNT_CHECKER',0),(826,'authorisation','UPDATE_ADHOC','ADHOC','UPDATE',1),(827,'authorisation','UPDATE_ADHOC_CHECKER','ADHOC','UPDATE',0),(828,'authorisation','DELETE_ADHOC','ADHOC','DELETE',1),(829,'authorisation','DELETE_ADHOC_CHECKER','ADHOC','DELETE',0),(830,'authorisation','CREATE_ADHOC','ADHOC','CREATE',1),(831,'authorisation','CREATE_ADHOC_CHECKER','ADHOC','CREATE',0),(832,'authorisation','INVALIDATE_TWOFACTOR_ACCESSTOKEN','TWOFACTOR_ACCESSTOKEN','INVALIDATE',0),(833,'configuration','READ_TWOFACTOR_CONFIGURATION','TWOFACTOR_CONFIGURATION','READ',0),(834,'configuration','UPDATE_TWOFACTOR_CONFIGURATION','TWOFACTOR_CONFIGURATION','UPDATE',0),(835,'special','BYPASS_TWOFACTOR',NULL,NULL,0),(836,'infrastructure','READ_IMPORT','IMPORT','READ',0),(844,'datatable','CREATE_Member ID','Member ID','CREATE',1),(845,'datatable','CREATE_Member ID_CHECKER','Member ID','CREATE',0),(846,'datatable','READ_Member ID','Member ID','READ',0),(847,'datatable','UPDATE_Member ID','Member ID','UPDATE',1),(848,'datatable','UPDATE_Member ID_CHECKER','Member ID','UPDATE',0),(849,'datatable','DELETE_Member ID','Member ID','DELETE',1),(850,'datatable','DELETE_Member ID_CHECKER','Member ID','DELETE',0),(851,'datatable','CREATE_tr','tr','CREATE',1),(852,'datatable','CREATE_tr_CHECKER','tr','CREATE',0),(853,'datatable','READ_tr','tr','READ',0),(854,'datatable','UPDATE_tr','tr','UPDATE',1),(855,'datatable','UPDATE_tr_CHECKER','tr','UPDATE',0),(856,'datatable','DELETE_tr','tr','DELETE',1),(857,'datatable','DELETE_tr_CHECKER','tr','DELETE',0),(858,'datatable','CREATE_fgfg','fgfg','CREATE',1),(859,'datatable','CREATE_fgfg_CHECKER','fgfg','CREATE',0),(860,'datatable','READ_fgfg','fgfg','READ',0),(861,'datatable','UPDATE_fgfg','fgfg','UPDATE',1),(862,'datatable','UPDATE_fgfg_CHECKER','fgfg','UPDATE',0),(863,'datatable','DELETE_fgfg','fgfg','DELETE',1),(864,'datatable','DELETE_fgfg_CHECKER','fgfg','DELETE',0),(865,'datatable','CREATE_Marital Status','Marital Status','CREATE',1),(866,'datatable','CREATE_Marital Status_CHECKER','Marital Status','CREATE',0),(867,'datatable','READ_Marital Status','Marital Status','READ',0),(868,'datatable','UPDATE_Marital Status','Marital Status','UPDATE',1),(869,'datatable','UPDATE_Marital Status_CHECKER','Marital Status','UPDATE',0),(870,'datatable','DELETE_Marital Status','Marital Status','DELETE',1),(871,'datatable','DELETE_Marital Status_CHECKER','Marital Status','DELETE',0),(872,'datatable','CREATE_Charges','Charges','CREATE',1),(873,'datatable','CREATE_Charges_CHECKER','Charges','CREATE',0),(874,'datatable','READ_Charges','Charges','READ',0),(875,'datatable','UPDATE_Charges','Charges','UPDATE',1),(876,'datatable','UPDATE_Charges_CHECKER','Charges','UPDATE',0),(877,'datatable','DELETE_Charges','Charges','DELETE',1),(878,'datatable','DELETE_Charges_CHECKER','Charges','DELETE',0);
/*!40000 ALTER TABLE `m_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_portfolio_account_associations`
--

DROP TABLE IF EXISTS `m_portfolio_account_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_portfolio_account_associations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_account_id` bigint(20) DEFAULT NULL,
  `savings_account_id` bigint(20) DEFAULT NULL,
  `linked_loan_account_id` bigint(20) DEFAULT NULL,
  `linked_savings_account_id` bigint(20) DEFAULT NULL,
  `association_type_enum` smallint(1) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `account_association_loan_fk` (`loan_account_id`),
  KEY `account_association_savings_fk` (`savings_account_id`),
  KEY `linked_loan_fk` (`linked_loan_account_id`),
  KEY `linked_savings_fk` (`linked_savings_account_id`),
  CONSTRAINT `account_association_loan_fk` FOREIGN KEY (`loan_account_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `account_association_savings_fk` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`),
  CONSTRAINT `linked_loan_fk` FOREIGN KEY (`linked_loan_account_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `linked_savings_fk` FOREIGN KEY (`linked_savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_portfolio_account_associations`
--

LOCK TABLES `m_portfolio_account_associations` WRITE;
/*!40000 ALTER TABLE `m_portfolio_account_associations` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_portfolio_account_associations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_portfolio_command_source`
--

DROP TABLE IF EXISTS `m_portfolio_command_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_portfolio_command_source` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action_name` varchar(50) NOT NULL,
  `entity_name` varchar(50) NOT NULL,
  `office_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `loan_id` bigint(20) DEFAULT NULL,
  `savings_account_id` bigint(20) DEFAULT NULL,
  `api_get_url` varchar(100) NOT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `subresource_id` bigint(20) DEFAULT NULL,
  `command_as_json` text NOT NULL,
  `maker_id` bigint(20) NOT NULL,
  `made_on_date` datetime NOT NULL,
  `checker_id` bigint(20) DEFAULT NULL,
  `checked_on_date` datetime DEFAULT NULL,
  `processing_result_enum` smallint(5) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `creditbureau_id` bigint(20) DEFAULT NULL,
  `organisation_creditbureau_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_maker_m_appuser` (`maker_id`),
  KEY `FK_m_checker_m_appuser` (`checker_id`),
  KEY `action_name` (`action_name`),
  KEY `entity_name` (`entity_name`,`resource_id`),
  KEY `made_on_date` (`made_on_date`),
  KEY `checked_on_date` (`checked_on_date`),
  KEY `processing_result_enum` (`processing_result_enum`),
  KEY `office_id` (`office_id`),
  KEY `group_id` (`office_id`),
  KEY `client_id` (`office_id`),
  KEY `loan_id` (`office_id`),
  CONSTRAINT `FK_m_checker_m_appuser` FOREIGN KEY (`checker_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_maker_m_appuser` FOREIGN KEY (`maker_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_portfolio_command_source`
--

LOCK TABLES `m_portfolio_command_source` WRITE;
/*!40000 ALTER TABLE `m_portfolio_command_source` DISABLE KEYS */;
INSERT INTO `m_portfolio_command_source` VALUES (1,'CREATE','USER',1,NULL,NULL,NULL,NULL,'/users/template',3,NULL,'{\"sendPasswordToEmail\":false,\"roles\":[\"1\"],\"username\":\"pembe\",\"firstname\":\"Pembe\",\"lastname\":\"Miriam\",\"email\":\"pembemiriam007@gmail.com\",\"password\":\"love8love8\",\"repeatPassword\":\"love8love8\",\"officeId\":1}',1,'2018-04-16 12:54:26',NULL,NULL,1,NULL,NULL,NULL,NULL),(2,'CREATE','OFFICE',2,NULL,NULL,NULL,NULL,'/offices/template',2,NULL,'{\"parentId\":1,\"name\":\"Mountain Savings & Credit Group\",\"externalId\":\"MSCG\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"openingDate\":\"17 April 2018\"}',1,'2018-04-17 08:35:02',NULL,NULL,1,NULL,NULL,NULL,NULL),(3,'UPDATE','CURRENCY',NULL,NULL,NULL,NULL,NULL,'/currencies',NULL,NULL,'{\"currencies\":[\"XAF\"]}',1,'2018-04-17 08:36:13',NULL,NULL,1,NULL,NULL,NULL,NULL),(4,'CREATE','HOLIDAY',NULL,NULL,NULL,NULL,NULL,'/holidays/template',1,NULL,'{\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"name\":\"LABOR DAY\",\"fromDate\":\"30 April 2018\",\"toDate\":\"01 May 2018\",\"reschedulingType\":1,\"description\":\"Labor Day\",\"offices\":[{\"officeId\":2}]}',1,'2018-04-17 08:39:39',NULL,NULL,1,NULL,NULL,NULL,NULL),(5,'CREATE','STAFF',2,NULL,NULL,NULL,NULL,'/staff/template',1,NULL,'{\"isLoanOfficer\":false,\"officeId\":2,\"firstname\":\"Cynthia\",\"lastname\":\"Epolle\",\"mobileNo\":\"670949951\",\"joiningDate\":\"17 April 2018\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2018-04-17 08:41:46',NULL,NULL,1,NULL,NULL,NULL,NULL),(6,'CREATE','STAFF',2,NULL,NULL,NULL,NULL,'/staff/template',2,NULL,'{\"isLoanOfficer\":true,\"officeId\":2,\"firstname\":\"Ndam\",\"lastname\":\"Arouna\",\"mobileNo\":\"677245373\",\"joiningDate\":\"17 April 2018\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2018-04-17 08:43:01',NULL,NULL,1,NULL,NULL,NULL,NULL),(7,'CREATE','STAFF',2,NULL,NULL,NULL,NULL,'/staff/template',3,NULL,'{\"isLoanOfficer\":false,\"officeId\":2,\"firstname\":\"Esoh\",\"lastname\":\"Berlinda\",\"mobileNo\":\"670256726\",\"joiningDate\":\"17 April 2018\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2018-04-17 08:44:53',NULL,NULL,1,NULL,NULL,NULL,NULL),(8,'CREATE','STAFF',2,NULL,NULL,NULL,NULL,'/staff/template',4,NULL,'{\"isLoanOfficer\":false,\"officeId\":2,\"firstname\":\"Ayuk\",\"lastname\":\"Etta\",\"mobileNo\":\"676101785\",\"joiningDate\":\"17 April 2018\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2018-04-17 08:46:30',NULL,NULL,1,NULL,NULL,NULL,NULL),(9,'UPDATE','WORKINGDAYS',NULL,NULL,NULL,NULL,NULL,'/workingdays/',1,NULL,'{\"recurrence\":\"FREQ\\u003dWEEKLY;INTERVAL\\u003d1;BYDAY\\u003dMO,TU,WE,TH,FR,SA\"}',1,'2018-04-17 08:47:34',NULL,NULL,1,NULL,NULL,NULL,NULL),(10,'CREATE','USER',2,NULL,NULL,NULL,NULL,'/users/template',9,NULL,'{\"sendPasswordToEmail\":false,\"roles\":[\"1\"],\"username\":\"Cynthia.Epolle\",\"firstname\":\"Cynthia\",\"lastname\":\"Epolle\",\"email\":\"Cynthia.Epolle@skylabase.com\",\"password\":\"admin123\",\"repeatPassword\":\"admin123\",\"officeId\":2,\"staffId\":1}',1,'2018-04-17 08:49:48',NULL,NULL,1,NULL,NULL,NULL,NULL),(11,'CREATE','DATATABLE',NULL,NULL,NULL,NULL,NULL,'/datatables/',NULL,NULL,'{\"datatableName\":\"Marital status\",\"apptableName\":\"m_client\",\"multiRow\":false,\"columns\":[{\"name\":\"Marital status\",\"type\":\"String\",\"mandatory\":false,\"length\":\"20\"}]}',9,'2018-04-17 09:06:13',NULL,NULL,1,NULL,NULL,NULL,NULL),(12,'CREATE','DATATABLE',NULL,NULL,NULL,NULL,NULL,'/datatables/',NULL,NULL,'{\"datatableName\":\"Member ID\",\"apptableName\":\"m_client\",\"multiRow\":false,\"columns\":[{\"name\":\"Member ID\",\"type\":\"Number\",\"mandatory\":false}]}',9,'2018-04-17 09:08:57',NULL,NULL,1,NULL,NULL,NULL,NULL),(13,'UPDATE','DATATABLE',NULL,NULL,NULL,NULL,NULL,'/datatables/Member ID',NULL,NULL,'{\"apptableName\":\"m_client\",\"changeColumns\":[{\"name\":\"Member ID\",\"mandatory\":false,\"newName\":\"Member ID\"}]}',9,'2018-04-17 09:09:58',NULL,NULL,1,NULL,NULL,NULL,NULL),(14,'CREATE','LOANPRODUCT',NULL,NULL,NULL,NULL,NULL,'/loanproducts/template',1,NULL,'{\"currencyCode\":\"XAF\",\"includeInBorrowerCycle\":true,\"useBorrowerCycle\":false,\"digitsAfterDecimal\":\"1\",\"inMultiplesOf\":\"100\",\"repaymentFrequencyType\":1,\"interestRateFrequencyType\":2,\"amortizationType\":1,\"interestType\":1,\"interestCalculationPeriodType\":1,\"transactionProcessingStrategyId\":5,\"principalVariationsForBorrowerCycle\":[],\"interestRateVariationsForBorrowerCycle\":[],\"numberOfRepaymentVariationsForBorrowerCycle\":[],\"multiDisburseLoan\":false,\"accountingRule\":\"1\",\"daysInYearType\":1,\"daysInMonthType\":1,\"isInterestRecalculationEnabled\":false,\"preClosureInterestCalculationStrategy\":1,\"isLinkedToFloatingInterestRates\":false,\"allowVariableInstallments\":false,\"name\":\"Personal Loan\",\"description\":\"Personal Loan\",\"shortName\":\"PLN\",\"installmentAmountInMultiplesOf\":\"100\",\"minPrincipal\":\"5000\",\"principal\":\"10000\",\"maxPrincipal\":\"25000\",\"minNumberOfRepayments\":\"1\",\"numberOfRepayments\":\"3\",\"maxNumberOfRepayments\":\"5\",\"interestRatePerPeriod\":\"5\",\"maxInterestRatePerPeriod\":\"5\",\"repaymentEvery\":\"2\",\"minimumDaysBetweenDisbursalAndFirstRepayment\":\"14\",\"accountMovesOutOfNPAOnlyOnArrearsCompletion\":true,\"paymentChannelToFundSourceMappings\":[],\"feeToIncomeAccountMappings\":[],\"penaltyToIncomeAccountMappings\":[],\"charges\":[],\"allowAttributeOverrides\":{\"amortizationType\":true,\"interestType\":true,\"transactionProcessingStrategyId\":true,\"interestCalculationPeriodType\":true,\"inArrearsTolerance\":true,\"repaymentEvery\":true,\"graceOnPrincipalAndInterestPayment\":true,\"graceOnArrearsAgeing\":true},\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"startDate\":\"17 April 2018\"}',9,'2018-04-17 10:08:02',NULL,NULL,1,NULL,NULL,NULL,NULL),(15,'CREATE','LOANPRODUCT',NULL,NULL,NULL,NULL,NULL,'/loanproducts/template',2,NULL,'{\"currencyCode\":\"XAF\",\"includeInBorrowerCycle\":true,\"useBorrowerCycle\":false,\"digitsAfterDecimal\":\"1\",\"inMultiplesOf\":\"100\",\"repaymentFrequencyType\":2,\"interestRateFrequencyType\":2,\"amortizationType\":1,\"interestType\":1,\"interestCalculationPeriodType\":1,\"transactionProcessingStrategyId\":1,\"principalVariationsForBorrowerCycle\":[],\"interestRateVariationsForBorrowerCycle\":[],\"numberOfRepaymentVariationsForBorrowerCycle\":[],\"multiDisburseLoan\":false,\"accountingRule\":\"1\",\"daysInYearType\":1,\"daysInMonthType\":1,\"isInterestRecalculationEnabled\":false,\"preClosureInterestCalculationStrategy\":1,\"isLinkedToFloatingInterestRates\":false,\"allowVariableInstallments\":false,\"name\":\"Business Loan\",\"description\":\"Business Loan\",\"shortName\":\"BLN\",\"installmentAmountInMultiplesOf\":\"100\",\"principal\":\"25000\",\"maxPrincipal\":\"100000\",\"numberOfRepayments\":\"3\",\"maxNumberOfRepayments\":\"5\",\"interestRatePerPeriod\":\"5\",\"maxInterestRatePerPeriod\":\"5\",\"repaymentEvery\":\"1\",\"minimumDaysBetweenDisbursalAndFirstRepayment\":\"28\",\"accountMovesOutOfNPAOnlyOnArrearsCompletion\":true,\"paymentChannelToFundSourceMappings\":[],\"feeToIncomeAccountMappings\":[],\"penaltyToIncomeAccountMappings\":[],\"charges\":[],\"allowAttributeOverrides\":{\"amortizationType\":true,\"interestType\":true,\"transactionProcessingStrategyId\":true,\"interestCalculationPeriodType\":true,\"inArrearsTolerance\":true,\"repaymentEvery\":true,\"graceOnPrincipalAndInterestPayment\":true,\"graceOnArrearsAgeing\":true},\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"startDate\":\"17 April 2018\"}',9,'2018-04-17 10:19:57',NULL,NULL,1,NULL,NULL,NULL,NULL),(16,'CREATE','SAVINGSPRODUCT',NULL,NULL,NULL,NULL,NULL,'/savingsproducts/template',1,NULL,'{\"currencyCode\":\"XAF\",\"digitsAfterDecimal\":\"1\",\"interestCompoundingPeriodType\":5,\"interestPostingPeriodType\":5,\"interestCalculationType\":1,\"interestCalculationDaysInYearType\":365,\"accountingRule\":\"1\",\"name\":\"Regular Savings\",\"shortName\":\"RSV\",\"description\":\"Regular Savings\",\"inMultiplesOf\":\"100\",\"nominalAnnualInterestRate\":\"0\",\"minRequiredOpeningBalance\":\"500\",\"enforceMinRequiredBalance\":true,\"minRequiredBalance\":\"500\",\"paymentChannelToFundSourceMappings\":[],\"feeToIncomeAccountMappings\":[],\"penaltyToIncomeAccountMappings\":[],\"charges\":[],\"locale\":\"en\"}',9,'2018-04-17 10:26:40',NULL,NULL,1,NULL,NULL,NULL,NULL),(17,'CREATE','CHARGE',NULL,NULL,NULL,NULL,NULL,'/charges/template',1,NULL,'{\"chargeAppliesTo\":2,\"name\":\"Membership fee\",\"currencyCode\":\"XAF\",\"chargeTimeType\":3,\"chargeCalculationType\":1,\"amount\":\"1000\",\"active\":true,\"locale\":\"en\",\"monthDayFormat\":\"dd MMM\"}',9,'2018-04-17 10:33:40',NULL,NULL,1,NULL,NULL,NULL,NULL),(18,'CREATE','DATATABLE',NULL,NULL,NULL,NULL,NULL,'/datatables/',NULL,NULL,'{\"datatableName\":\"tr\",\"apptableName\":\"m_client\",\"multiRow\":false,\"columns\":[{\"name\":\"fgf\",\"type\":\"String\",\"mandatory\":false,\"length\":\"52\"}]}',1,'2018-04-19 05:24:19',NULL,NULL,1,NULL,NULL,NULL,NULL),(19,'CREATE','DATATABLE',NULL,NULL,NULL,NULL,NULL,'/datatables/',NULL,NULL,'{\"datatableName\":\"fgfg\",\"apptableName\":\"m_client\",\"multiRow\":false,\"columns\":[{\"name\":\"fgfg\",\"type\":\"String\",\"mandatory\":false,\"length\":\"525\"}]}',1,'2018-04-19 05:26:41',NULL,NULL,1,NULL,NULL,NULL,NULL),(20,'CREATE','DATATABLE',NULL,NULL,NULL,NULL,NULL,'/datatables/',NULL,NULL,'{\"datatableName\":\"Marital Status\",\"apptableName\":\"m_client\",\"multiRow\":false,\"columns\":[{\"name\":\"Marital Status\",\"type\":\"Text\",\"mandatory\":false}]}',9,'2018-04-19 08:42:13',NULL,NULL,1,NULL,NULL,NULL,NULL),(21,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/30/codevalues/template',30,NULL,'{\"isActive\":true,\"name\":\"Single\",\"description\":\"Single\",\"position\":\"\"}',9,'2018-04-19 09:01:18',NULL,NULL,1,NULL,NULL,NULL,NULL),(22,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/30/codevalues/template',30,NULL,'{\"isActive\":true,\"name\":\"Married\",\"description\":\"Married\"}',9,'2018-04-19 09:01:46',NULL,NULL,1,NULL,NULL,NULL,NULL),(23,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/30/codevalues/template',30,NULL,'{\"isActive\":true,\"name\":\"Divorced\",\"description\":\"Divorced\"}',9,'2018-04-19 09:02:15',NULL,NULL,1,NULL,NULL,NULL,NULL),(24,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/30/codevalues/template',30,NULL,'{\"isActive\":true,\"name\":\"Widowed\",\"description\":\"Widowed\"}',9,'2018-04-19 09:03:54',NULL,NULL,1,NULL,NULL,NULL,NULL),(25,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/31/codevalues/template',31,NULL,'{\"isActive\":true,\"name\":\"Wife\",\"description\":\"Wife\"}',9,'2018-04-19 09:04:36',NULL,NULL,1,NULL,NULL,NULL,NULL),(26,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/31/codevalues/template',31,NULL,'{\"isActive\":true,\"name\":\"Husband\",\"description\":\"Husband\"}',9,'2018-04-19 09:04:55',NULL,NULL,1,NULL,NULL,NULL,NULL),(27,'UPDATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/31/codevalues/18',18,18,'{\"position\":1}',9,'2018-04-19 09:05:21',NULL,NULL,1,NULL,NULL,NULL,NULL),(28,'UPDATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/31/codevalues/19',19,19,'{\"position\":2}',9,'2018-04-19 09:05:31',NULL,NULL,1,NULL,NULL,NULL,NULL),(29,'UPDATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/30/codevalues/14',14,14,'{\"position\":1}',9,'2018-04-19 09:05:53',NULL,NULL,1,NULL,NULL,NULL,NULL),(30,'UPDATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/30/codevalues/15',15,15,'{\"position\":2}',9,'2018-04-19 09:06:18',NULL,NULL,1,NULL,NULL,NULL,NULL),(31,'UPDATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/30/codevalues/16',16,16,'{\"position\":3}',9,'2018-04-19 09:06:36',NULL,NULL,1,NULL,NULL,NULL,NULL),(32,'UPDATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/30/codevalues/17',17,17,'{\"position\":4}',9,'2018-04-19 09:06:46',NULL,NULL,1,NULL,NULL,NULL,NULL),(33,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/4/codevalues/template',4,NULL,'{\"isActive\":true,\"name\":\"Female\",\"description\":\"Female\",\"position\":\"1\"}',9,'2018-04-19 09:07:29',NULL,NULL,1,NULL,NULL,NULL,NULL),(34,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/4/codevalues/template',4,NULL,'{\"isActive\":true,\"name\":\"Male\",\"description\":\"Male\",\"position\":\"2\"}',9,'2018-04-19 09:08:07',NULL,NULL,1,NULL,NULL,NULL,NULL),(35,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/28/codevalues/template',28,NULL,'{\"isActive\":true,\"name\":\"Cameroon\",\"description\":\"Cameroon\",\"position\":\"1\"}',9,'2018-04-19 09:08:59',NULL,NULL,1,NULL,NULL,NULL,NULL),(36,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/28/codevalues/template',28,NULL,'{\"isActive\":true,\"name\":\"United States\",\"description\":\"United States\",\"position\":\"2\"}',9,'2018-04-19 09:09:31',NULL,NULL,1,NULL,NULL,NULL,NULL),(37,'CREATE','CLIENT',2,NULL,1,NULL,1,'/clients/template',1,NULL,'{\"address\":[],\"familyMembers\":[{\"relationshipId\":18,\"firstName\":\"Ayuk\",\"middleName\":\"Larissa\",\"lastName\":\"Livella\",\"mobileNumber\":\"675895562\",\"age\":\"25\",\"genderId\":20,\"maritalStatusId\":15,\"dateOfBirth\":\"03 April 1993\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}],\"officeId\":2,\"legalFormId\":1,\"firstname\":\"Ayuk\",\"middlename\":\"Etta\",\"lastname\":\"Akum\",\"mobileNo\":\"676101785\",\"externalId\":\"MS001\",\"active\":true,\"savingsProductId\":1,\"genderId\":20,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"19 April 2018\",\"submittedOnDate\":\"19 April 2018\",\"dateOfBirth\":\"13 March 1991\"}',9,'2018-04-19 09:14:09',NULL,NULL,1,NULL,NULL,NULL,NULL),(38,'CREATE','CLIENT',2,NULL,2,NULL,2,'/clients/template',2,NULL,'{\"address\":[],\"familyMembers\":[],\"officeId\":2,\"legalFormId\":1,\"firstname\":\"Ndam\",\"lastname\":\"Arouna\",\"mobileNo\":\"677245373\",\"externalId\":\"MS002\",\"genderId\":21,\"active\":true,\"savingsProductId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"19 April 2018\",\"submittedOnDate\":\"19 April 2018\",\"dateOfBirth\":\"04 February 1996\"}',9,'2018-04-19 09:17:46',NULL,NULL,1,NULL,NULL,NULL,NULL),(39,'CREATE','CLIENT',2,NULL,3,NULL,3,'/clients/template',3,NULL,'{\"address\":[],\"familyMembers\":[],\"officeId\":2,\"legalFormId\":1,\"firstname\":\"Cynthia\",\"lastname\":\"Epolle\",\"mobileNo\":\"670949951\",\"externalId\":\"MS003\",\"active\":true,\"genderId\":20,\"savingsProductId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"19 April 2018\",\"submittedOnDate\":\"19 April 2018\",\"dateOfBirth\":\"17 January 1993\"}',9,'2018-04-19 09:19:54',NULL,NULL,1,NULL,NULL,NULL,NULL),(40,'CREATE','CLIENT',2,NULL,4,NULL,4,'/clients/template',4,NULL,'{\"address\":[],\"familyMembers\":[{\"relationshipId\":18,\"firstName\":\"Kamga\",\"middleName\":\"Amalia\",\"lastName\":\"Ngassa\",\"mobileNumber\":\"675265551\",\"age\":\"26\",\"genderId\":20,\"maritalStatusId\":15,\"dateOfBirth\":\"10 April 1992\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}],\"officeId\":2,\"legalFormId\":1,\"firstname\":\"Issac\",\"middlename\":\"Kamga\",\"lastname\":\"Mkounga\",\"mobileNo\":\"674106297\",\"externalId\":\"MS004\",\"active\":true,\"genderId\":21,\"savingsProductId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"19 April 2018\",\"submittedOnDate\":\"19 April 2018\",\"dateOfBirth\":\"27 May 1987\"}',9,'2018-04-19 09:27:27',NULL,NULL,1,NULL,NULL,NULL,NULL),(41,'CREATE','CLIENT',2,NULL,5,NULL,5,'/clients/template',5,NULL,'{\"address\":[],\"familyMembers\":[],\"officeId\":2,\"legalFormId\":1,\"firstname\":\"Awasum\",\"middlename\":\"Yannick\",\"lastname\":\"Noah\",\"mobileNo\":\"676683945\",\"externalId\":\"MS005\",\"active\":true,\"genderId\":21,\"savingsProductId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"19 April 2018\",\"submittedOnDate\":\"19 April 2018\",\"dateOfBirth\":\"19 March 1991\"}',9,'2018-04-19 09:29:52',NULL,NULL,1,NULL,NULL,NULL,NULL),(42,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/32/codevalues/template',32,NULL,'{\"isActive\":true,\"name\":\"Student\",\"description\":\"Student\",\"position\":\"1\"}',9,'2018-04-19 09:30:51',NULL,NULL,1,NULL,NULL,NULL,NULL),(43,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/32/codevalues/template',32,NULL,'{\"isActive\":true,\"name\":\"Private Sector\",\"description\":\"Private Sector\",\"position\":\"2\"}',9,'2018-04-19 09:32:04',NULL,NULL,1,NULL,NULL,NULL,NULL),(44,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/32/codevalues/template',32,NULL,'{\"isActive\":true,\"name\":\"Civil Servant\",\"description\":\"Civil Servant\",\"position\":\"3\"}',9,'2018-04-19 09:32:29',NULL,NULL,1,NULL,NULL,NULL,NULL),(45,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/32/codevalues/template',32,NULL,'{\"isActive\":true,\"name\":\"Sole Proprietor\",\"description\":\"Sole Proprietor\",\"position\":\"4\"}',9,'2018-04-19 09:33:07',NULL,NULL,1,NULL,NULL,NULL,NULL),(46,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/31/codevalues/template',31,NULL,'{\"isActive\":true,\"name\":\"Sister\",\"description\":\"Sister\",\"position\":\"3\"}',9,'2018-04-19 09:33:46',NULL,NULL,1,NULL,NULL,NULL,NULL),(47,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/31/codevalues/template',31,NULL,'{\"isActive\":true,\"name\":\"Brother\",\"description\":\"Brother\",\"position\":\"4\"}',9,'2018-04-19 09:34:19',NULL,NULL,1,NULL,NULL,NULL,NULL),(48,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/31/codevalues/template',31,NULL,'{\"isActive\":true,\"name\":\"Mother\",\"description\":\"Mother\",\"position\":\"5\"}',9,'2018-04-19 09:34:37',NULL,NULL,1,NULL,NULL,NULL,NULL),(49,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/31/codevalues/template',31,NULL,'{\"isActive\":true,\"name\":\"Father\",\"description\":\"Father\",\"position\":\"6\"}',9,'2018-04-19 09:34:58',NULL,NULL,1,NULL,NULL,NULL,NULL),(50,'CREATE','FAMILYMEMBERS',NULL,NULL,NULL,NULL,NULL,'/clients/5/familymembers',3,NULL,'{\"firstName\":\"Akoh\",\"middleName\":\"Raphael\",\"mobileNumber\":\"676524819\",\"age\":\"30\",\"relationshipId\":29,\"genderId\":21,\"professionId\":25,\"maritalStatusId\":15,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"dateOfBirth\":\"02 April 1988\"}',9,'2018-04-19 09:37:20',NULL,NULL,1,NULL,NULL,NULL,NULL),(51,'CREATE','FAMILYMEMBERS',NULL,NULL,NULL,NULL,NULL,'/clients/3/familymembers',4,NULL,'{\"firstName\":\"Epie\",\"middleName\":\"Coril\",\"mobileNumber\":\"677577349\",\"age\":\"20\",\"relationshipId\":28,\"genderId\":20,\"professionId\":24,\"maritalStatusId\":14,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"dateOfBirth\":\"14 October 1997\"}',9,'2018-04-19 09:39:48',NULL,NULL,1,NULL,NULL,NULL,NULL),(52,'CREATE','CLIENT',2,NULL,6,NULL,6,'/clients/template',6,NULL,'{\"address\":[],\"familyMembers\":[{\"relationshipId\":30,\"firstName\":\"Akoko\",\"middleName\":\"Mildred\",\"mobileNumber\":\"675951599\",\"age\":\"40\",\"genderId\":20,\"professionId\":27,\"maritalStatusId\":15,\"dateOfBirth\":\"02 April 1978\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}],\"officeId\":2,\"legalFormId\":1,\"firstname\":\"Akoko\",\"middlename\":\"Bill\",\"lastname\":\"Elton\",\"mobileNo\":\"678635286\",\"genderId\":21,\"externalId\":\"MS006\",\"active\":true,\"savingsProductId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"19 April 2018\",\"submittedOnDate\":\"19 April 2018\",\"dateOfBirth\":\"05 February 1993\"}',9,'2018-04-19 09:47:09',NULL,NULL,1,NULL,NULL,NULL,NULL),(53,'CREATE','CLIENT',2,NULL,7,NULL,7,'/clients/template',7,NULL,'{\"address\":[],\"familyMembers\":[{\"relationshipId\":29,\"firstName\":\"Nkem\",\"middleName\":\"Sixtus\",\"mobileNumber\":\"678249265\",\"age\":\"30\",\"genderId\":21,\"professionId\":27,\"maritalStatusId\":14,\"dateOfBirth\":\"22 February 1988\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}],\"officeId\":2,\"legalFormId\":1,\"firstname\":\"Achia\",\"middlename\":\"Rolence\",\"lastname\":\"Aka\",\"mobileNo\":\"670030932\",\"externalId\":\"MS007\",\"genderId\":21,\"active\":true,\"savingsProductId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"19 April 2018\",\"submittedOnDate\":\"19 April 2018\",\"dateOfBirth\":\"05 August 2017\"}',9,'2018-04-19 09:56:18',NULL,NULL,1,NULL,NULL,NULL,NULL),(54,'CREATE','CLIENT',2,NULL,8,NULL,8,'/clients/template',8,NULL,'{\"address\":[],\"familyMembers\":[{\"relationshipId\":30,\"firstName\":\"Owanji\",\"middleName\":\"Bau\",\"lastName\":\"Marie\",\"mobileNumber\":\"677548923\",\"age\":\"40\",\"genderId\":20,\"professionId\":26,\"maritalStatusId\":15,\"dateOfBirth\":\"28 February 1978\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}],\"officeId\":2,\"legalFormId\":1,\"firstname\":\"Effangwa\",\"middlename\":\"Martha\",\"lastname\":\"Itoh\",\"mobileNo\":\"674669380\",\"genderId\":20,\"externalId\":\"MS008\",\"active\":true,\"savingsProductId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"19 April 2018\",\"submittedOnDate\":\"19 April 2018\",\"dateOfBirth\":\"08 April 1992\"}',9,'2018-04-19 10:44:46',NULL,NULL,1,NULL,NULL,NULL,NULL),(55,'CREATE','CLIENT',2,NULL,9,NULL,9,'/clients/template',9,NULL,'{\"address\":[],\"familyMembers\":[{\"relationshipId\":29,\"firstName\":\"Ebong\",\"middleName\":\"Paul\",\"lastName\":\"Junior\",\"mobileNumber\":\"671135926\",\"age\":\"27\",\"genderId\":21,\"professionId\":25,\"maritalStatusId\":14,\"dateOfBirth\":\"17 April 1990\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}],\"officeId\":2,\"legalFormId\":1,\"firstname\":\"Pembe\",\"middlename\":\"Miriam\",\"lastname\":\"Motia\",\"mobileNo\":\"671840646\",\"genderId\":20,\"externalId\":\"MS009\",\"active\":true,\"savingsProductId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"19 April 2018\",\"submittedOnDate\":\"19 April 2018\",\"dateOfBirth\":\"06 November 1996\"}',9,'2018-04-19 10:54:13',NULL,NULL,1,NULL,NULL,NULL,NULL),(56,'CREATE','CLIENT',2,NULL,10,NULL,10,'/clients/template',10,NULL,'{\"address\":[],\"familyMembers\":[{\"relationshipId\":28,\"firstName\":\"Massabe\",\"middleName\":\"Kengne\",\"lastName\":\"Lydiane\",\"mobileNumber\":\"675875421\",\"age\":\"25\",\"genderId\":20,\"professionId\":24,\"maritalStatusId\":14,\"dateOfBirth\":\"03 April 1993\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}],\"officeId\":2,\"legalFormId\":1,\"firstname\":\"Tcheukounang\",\"middlename\":\"Kengne\",\"lastname\":\"Grace\",\"mobileNo\":\"675734571\",\"genderId\":20,\"externalId\":\"MS010\",\"active\":true,\"savingsProductId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"19 April 2018\",\"submittedOnDate\":\"19 April 2018\",\"dateOfBirth\":\"10 October 1996\"}',9,'2018-04-19 10:59:42',NULL,NULL,1,NULL,NULL,NULL,NULL),(57,'CREATE','CLIENT',2,NULL,11,NULL,11,'/clients/template',11,NULL,'{\"address\":[],\"familyMembers\":[{\"relationshipId\":29,\"firstName\":\"Isaac\",\"lastName\":\"Kamga\",\"mobileNumber\":\"674106958\",\"age\":\"30\",\"genderId\":21,\"professionId\":25,\"maritalStatusId\":15,\"dateOfBirth\":\"28 May 1987\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}],\"officeId\":2,\"legalFormId\":1,\"firstname\":\"Kelvin\",\"middlename\":\"Ikome\",\"lastname\":\"Ekonde\",\"mobileNo\":\"677666659\",\"externalId\":\"MS011\",\"active\":true,\"genderId\":21,\"savingsProductId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"19 April 2018\",\"submittedOnDate\":\"19 April 2018\",\"dateOfBirth\":\"28 August 1999\"}',9,'2018-04-19 11:04:20',NULL,NULL,1,NULL,NULL,NULL,NULL),(58,'CREATE','CLIENT',2,NULL,12,NULL,12,'/clients/template',12,NULL,'{\"address\":[],\"familyMembers\":[{\"relationshipId\":30,\"firstName\":\"Ngounou\",\"middleName\":\"Rachel\",\"mobileNumber\":\"675925637\",\"age\":\"40\",\"genderId\":20,\"professionId\":26,\"maritalStatusId\":15,\"dateOfBirth\":\"01 April 1978\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}],\"officeId\":2,\"legalFormId\":1,\"firstname\":\"Kemfang\",\"middlename\":\"Tcheutchie\",\"lastname\":\"Cabrel\",\"mobileNo\":\"675463395\",\"genderId\":21,\"active\":true,\"savingsProductId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"19 April 2018\",\"submittedOnDate\":\"19 April 2018\",\"dateOfBirth\":\"12 August 1993\"}',9,'2018-04-19 11:10:17',NULL,NULL,1,NULL,NULL,NULL,NULL),(59,'CREATE','CLIENT',2,NULL,13,NULL,13,'/clients/template',13,NULL,'{\"address\":[],\"familyMembers\":[{\"relationshipId\":29,\"firstName\":\"Saliki\",\"middleName\":\"Justine\",\"mobileNumber\":\"678523694\",\"age\":\"35\",\"genderId\":21,\"professionId\":26,\"maritalStatusId\":15,\"dateOfBirth\":\"08 January 1983\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}],\"officeId\":2,\"legalFormId\":1,\"firstname\":\"Forntoh\",\"middlename\":\"Esoh\",\"lastname\":\"Berlinda\",\"mobileNo\":\"670256726\",\"genderId\":20,\"externalId\":\"MS013\",\"active\":true,\"savingsProductId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"19 April 2018\",\"submittedOnDate\":\"19 April 2018\",\"dateOfBirth\":\"07 September 1995\"}',9,'2018-04-19 11:15:06',NULL,NULL,1,NULL,NULL,NULL,NULL),(60,'UPDATE','CLIENT',2,NULL,12,NULL,NULL,'/clients/12',12,NULL,'{\"externalId\":\"MS012\"}',9,'2018-04-19 11:16:38',NULL,NULL,1,NULL,NULL,NULL,NULL),(61,'CREATE','CLIENT',2,NULL,15,NULL,NULL,'/clients/template',15,NULL,'{\"address\":[],\"familyMembers\":[],\"officeId\":2,\"legalFormId\":2,\"fullname\":\"Skylabase Inc\",\"mobileNo\":\"243626689\",\"clientNonPersonDetails\":{\"incorpNumber\":\"M031712616989F\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"incorpValidityTillDate\":\"19 April 2019\"},\"externalId\":\"MS014\",\"active\":true,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"activationDate\":\"19 April 2018\",\"submittedOnDate\":\"19 April 2018\",\"dateOfBirth\":\"19 April 2017\",\"savingsProductId\":null}',9,'2018-04-19 11:20:58',NULL,NULL,1,NULL,NULL,NULL,NULL),(62,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/25/codevalues/template',25,NULL,'{\"isActive\":true,\"name\":\"IT Services\",\"description\":\"IT Services\",\"position\":\"1\"}',9,'2018-04-19 11:22:52',NULL,NULL,1,NULL,NULL,NULL,NULL),(63,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/25/codevalues/template',25,NULL,'{\"isActive\":true,\"name\":\"Consultancy\",\"description\":\"Consultancy\",\"position\":\"2\"}',9,'2018-04-19 11:23:17',NULL,NULL,1,NULL,NULL,NULL,NULL),(64,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/25/codevalues/template',25,NULL,'{\"isActive\":true,\"name\":\"Business\",\"description\":\"Business\",\"position\":\"3\"}',9,'2018-04-19 11:23:55',NULL,NULL,1,NULL,NULL,NULL,NULL),(65,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',1,NULL,'{\"manualEntriesAllowed\":true,\"type\":1,\"usage\":\"1\",\"glCode\":\"57\",\"name\":\"Cash at Hand\",\"description\":\"Cash at Hand\"}',9,'2018-04-19 11:40:11',NULL,NULL,1,NULL,NULL,NULL,NULL),(66,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',2,NULL,'{\"manualEntriesAllowed\":true,\"type\":1,\"usage\":\"1\",\"glCode\":\"502\",\"name\":\"Bank\",\"description\":\"Bank\"}',9,'2018-04-19 11:42:23',NULL,NULL,1,NULL,NULL,NULL,NULL),(67,'UPDATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/1',1,NULL,'{\"glCode\":\"507\"}',9,'2018-04-19 11:42:55',NULL,NULL,1,NULL,NULL,NULL,NULL),(68,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',3,NULL,'{\"manualEntriesAllowed\":true,\"type\":1,\"usage\":\"2\",\"glCode\":\"500\",\"name\":\"Liquid Asset\",\"description\":\"All Liquid Assets\"}',9,'2018-04-19 11:43:55',NULL,NULL,1,NULL,NULL,NULL,NULL),(69,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',4,NULL,'{\"manualEntriesAllowed\":true,\"type\":2,\"usage\":\"2\",\"glCode\":\"400\",\"name\":\"Account Payable\",\"description\":\"Account Payables\"}',9,'2018-04-19 11:48:07',NULL,NULL,1,NULL,NULL,NULL,NULL),(70,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',5,NULL,'{\"manualEntriesAllowed\":true,\"type\":2,\"usage\":\"1\",\"parentId\":4,\"glCode\":\"401\",\"name\":\"Cheques Payable\",\"description\":\"Cheques Payables\"}',9,'2018-04-19 11:49:19',NULL,NULL,1,NULL,NULL,NULL,NULL),(71,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',6,NULL,'{\"manualEntriesAllowed\":true,\"type\":3,\"usage\":\"2\",\"glCode\":\"100\",\"name\":\"Funding Account\",\"description\":\"Main Funding Account\"}',9,'2018-04-20 10:34:30',NULL,NULL,1,NULL,NULL,NULL,NULL),(72,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',7,NULL,'{\"manualEntriesAllowed\":true,\"type\":3,\"usage\":\"1\",\"parentId\":6,\"glCode\":\"101\",\"name\":\"Loan Funding\",\"description\":\"Loan Funding Account\"}',9,'2018-04-20 10:35:08',NULL,NULL,1,NULL,NULL,NULL,NULL),(73,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',8,NULL,'{\"manualEntriesAllowed\":true,\"type\":4,\"usage\":\"2\",\"glCode\":\"700\",\"name\":\"Operating Income\",\"description\":\"Operating Income\"}',9,'2018-04-20 10:47:17',NULL,NULL,1,NULL,NULL,NULL,NULL),(74,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',9,NULL,'{\"manualEntriesAllowed\":true,\"type\":4,\"usage\":\"1\",\"parentId\":8,\"glCode\":\"701\",\"name\":\"Income from loans\",\"description\":\"Income from loans\"}',9,'2018-04-20 10:48:43',NULL,NULL,1,NULL,NULL,NULL,NULL),(75,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',10,NULL,'{\"manualEntriesAllowed\":true,\"type\":4,\"usage\":\"1\",\"parentId\":8,\"glCode\":\"702\",\"name\":\"Investment Income\",\"description\":\"Investment Income\"}',9,'2018-04-20 10:51:37',NULL,NULL,1,NULL,NULL,NULL,NULL),(76,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',11,NULL,'{\"manualEntriesAllowed\":true,\"type\":4,\"usage\":\"1\",\"parentId\":8,\"glCode\":\"703\",\"name\":\"Fees and Charges\",\"description\":\"Fees and Charges\"}',9,'2018-04-20 10:52:40',NULL,NULL,1,NULL,NULL,NULL,NULL),(77,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',12,NULL,'{\"manualEntriesAllowed\":true,\"type\":5,\"usage\":\"2\",\"glCode\":\"600\",\"name\":\"Operating Expenses\",\"description\":\"Operating Expenses\"}',9,'2018-04-20 10:54:40',NULL,NULL,1,NULL,NULL,NULL,NULL),(78,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',13,NULL,'{\"manualEntriesAllowed\":true,\"type\":5,\"usage\":\"1\",\"parentId\":12,\"glCode\":\"601\",\"name\":\"Stationary expenses\",\"description\":\"Stationary Expenses\"}',9,'2018-04-20 10:55:33',NULL,NULL,1,NULL,NULL,NULL,NULL),(79,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',14,NULL,'{\"manualEntriesAllowed\":true,\"type\":5,\"usage\":\"1\",\"parentId\":12,\"glCode\":\"602\",\"name\":\"Depreciation expense\",\"description\":\"Depreciation expenses\"}',9,'2018-04-20 10:58:15',NULL,NULL,1,NULL,NULL,NULL,NULL),(80,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',15,NULL,'{\"manualEntriesAllowed\":true,\"type\":5,\"usage\":\"1\",\"parentId\":12,\"glCode\":\"603\",\"name\":\"Other expenses\",\"description\":\"Other Expenses\"}',9,'2018-04-20 10:59:21',NULL,NULL,1,NULL,NULL,NULL,NULL),(81,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',16,NULL,'{\"manualEntriesAllowed\":true,\"type\":4,\"usage\":\"1\",\"parentId\":8,\"glCode\":\"704\",\"name\":\"Other Income\",\"description\":\"Other Income\"}',9,'2018-04-20 11:00:40',NULL,NULL,1,NULL,NULL,NULL,NULL),(82,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/3/codevalues/template',3,NULL,'{\"isActive\":true,\"name\":\"Business\",\"description\":\"Business\",\"position\":\"1\"}',9,'2018-04-20 11:11:02',NULL,NULL,1,NULL,NULL,NULL,NULL),(83,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/3/codevalues/template',3,NULL,'{\"isActive\":true,\"name\":\"School\",\"description\":\"School\",\"position\":\"2\"}',9,'2018-04-20 11:11:48',NULL,NULL,1,NULL,NULL,NULL,NULL),(84,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/3/codevalues/template',3,NULL,'{\"isActive\":true,\"name\":\"Personal\",\"description\":\"Personal\",\"position\":\"3\"}',9,'2018-04-20 11:12:35',NULL,NULL,1,NULL,NULL,NULL,NULL),(85,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/2/codevalues/template',2,NULL,'{\"isActive\":true,\"name\":\"Salary\",\"description\":\"Salary\",\"position\":\"1\"}',9,'2018-04-20 11:13:24',NULL,NULL,1,NULL,NULL,NULL,NULL),(86,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/2/codevalues/template',2,NULL,'{\"isActive\":true,\"name\":\"Savings\",\"description\":\"Savings\",\"position\":\"2\"}',9,'2018-04-20 11:13:59',NULL,NULL,1,NULL,NULL,NULL,NULL),(87,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/2/codevalues/template',2,NULL,'{\"isActive\":true,\"name\":\"Personal Belongings\",\"description\":\"Personal Belongings\",\"position\":\"3\"}',9,'2018-04-20 11:14:56',NULL,NULL,1,NULL,NULL,NULL,NULL),(88,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/14/codevalues/template',14,NULL,'{\"isActive\":true,\"name\":\"Inactive\",\"description\":\"Inactive\",\"position\":\"1\"}',9,'2018-04-20 11:20:20',NULL,NULL,1,NULL,NULL,NULL,NULL),(89,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/14/codevalues/template',14,NULL,'{\"isActive\":true,\"name\":\"Dormant\",\"description\":\"Dormant\",\"position\":\"2\"}',9,'2018-04-20 11:27:32',NULL,NULL,1,NULL,NULL,NULL,NULL),(90,'CREATE','DATATABLE',NULL,NULL,NULL,NULL,NULL,'/datatables/',NULL,NULL,'{\"datatableName\":\"Charges\",\"apptableName\":\"m_loan\",\"multiRow\":false,\"columns\":[{\"name\":\"Charges\",\"type\":\"Text\",\"mandatory\":false}]}',9,'2018-04-20 11:43:54',NULL,NULL,1,NULL,NULL,NULL,NULL),(91,'CREATE','CODE',NULL,NULL,NULL,NULL,NULL,'/codes/template',34,NULL,'{\"name\":\"Charges\"}',9,'2018-04-20 11:45:20',NULL,NULL,1,NULL,NULL,NULL,NULL),(92,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/34/codevalues/template',34,NULL,'{\"isActive\":true,\"name\":\"Loan Processing\",\"description\":\"Loan Processing\",\"position\":\"1\"}',9,'2018-04-20 11:46:05',NULL,NULL,1,NULL,NULL,NULL,NULL),(93,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/34/codevalues/template',34,NULL,'{\"isActive\":true,\"name\":\"Late Payment Fee\",\"description\":\"Late Payment Fee\",\"position\":\"2\"}',9,'2018-04-20 11:47:34',NULL,NULL,1,NULL,NULL,NULL,NULL),(94,'CREATE','CODE',NULL,NULL,NULL,NULL,NULL,'/codes/template',35,NULL,'{\"name\":\"Funding\"}',9,'2018-04-20 11:49:26',NULL,NULL,1,NULL,NULL,NULL,NULL),(95,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/35/codevalues/template',35,NULL,'{\"isActive\":true,\"name\":\"Main Funding\",\"description\":\"Main Funding\",\"position\":\"1\"}',9,'2018-04-20 11:50:11',NULL,NULL,1,NULL,NULL,NULL,NULL),(96,'CREATE','CODEVALUE',NULL,NULL,NULL,NULL,NULL,'/codes/35/codevalues/template',35,NULL,'{\"isActive\":true,\"name\":\"Loan Funding\",\"description\":\"Loan Funding\",\"position\":\"2\"}',9,'2018-04-20 11:50:52',NULL,NULL,1,NULL,NULL,NULL,NULL),(97,'UPDATESAVINGSACCOUNT','CLIENT',2,NULL,5,NULL,NULL,'/clients/5?command=updateSavingsAccount',5,NULL,'{\"savingsAccountId\":5}',9,'2018-04-20 12:24:09',NULL,NULL,1,NULL,NULL,NULL,NULL),(98,'CREATE','PAYMENTTYPE',NULL,NULL,NULL,NULL,NULL,'/paymenttype',1,NULL,'{\"name\":\"Cash\",\"description\":\"Cash\",\"isCashPayment\":true,\"position\":\"1\"}',9,'2018-04-20 12:32:55',NULL,NULL,1,NULL,NULL,NULL,NULL),(99,'CREATE','PAYMENTTYPE',NULL,NULL,NULL,NULL,NULL,'/paymenttype',2,NULL,'{\"name\":\"Cheque\",\"description\":\"Cheque\",\"position\":\"2\",\"isCashPayment\":false}',9,'2018-04-20 12:33:17',NULL,NULL,1,NULL,NULL,NULL,NULL),(100,'UPDATE','CLIENT',2,NULL,3,NULL,NULL,'/clients/3',3,NULL,'{\"staffId\":1}',9,'2018-04-20 12:34:39',NULL,NULL,1,NULL,NULL,NULL,NULL),(101,'DEPOSIT','SAVINGSACCOUNT',2,NULL,5,NULL,5,'/savingsaccounts/5/transactions',14,NULL,'{\"transactionDate\":\"20 April 2018\",\"transactionAmount\":\"30000\",\"paymentTypeId\":1,\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',9,'2018-04-20 12:41:27',NULL,NULL,1,NULL,NULL,NULL,NULL),(102,'CREATE','USER',2,NULL,NULL,NULL,NULL,'/users/template',10,NULL,'{\"sendPasswordToEmail\":false,\"roles\":[\"1\"],\"username\":\"Ayuk.Etta\",\"firstname\":\"Ayuk\",\"lastname\":\"Etta\",\"email\":\"Ayuk.Etta@skylabase.com\",\"password\":\"Admin123\",\"repeatPassword\":\"Admin123\",\"officeId\":2}',9,'2018-04-20 12:55:40',NULL,NULL,1,NULL,NULL,NULL,NULL),(103,'UPDATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/3',3,NULL,'{\"description\":\"All Cash Accounts\",\"name\":\"Cash\"}',9,'2018-04-24 09:44:10',NULL,NULL,1,NULL,NULL,NULL,NULL),(104,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',17,NULL,'{\"manualEntriesAllowed\":true,\"type\":1,\"usage\":1,\"parentId\":3,\"glCode\":\"503\",\"name\":\"Teller\",\"description\":\"Teller transactions\"}',9,'2018-04-24 09:45:26',NULL,NULL,1,NULL,NULL,NULL,NULL),(105,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',18,NULL,'{\"manualEntriesAllowed\":true,\"type\":1,\"usage\":\"1\",\"parentId\":3,\"glCode\":\"505\",\"name\":\"Vault\",\"description\":\"Vault transaction\"}',9,'2018-04-24 09:46:28',NULL,NULL,1,NULL,NULL,NULL,NULL),(106,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',19,NULL,'{\"manualEntriesAllowed\":true,\"type\":1,\"usage\":\"2\",\"glCode\":\"510\",\"name\":\"Fixed Asset\",\"description\":\"Fixed Assets\"}',9,'2018-04-24 09:49:05',NULL,NULL,1,NULL,NULL,NULL,NULL),(107,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',20,NULL,'{\"manualEntriesAllowed\":true,\"type\":1,\"usage\":\"1\",\"parentId\":19,\"glCode\":\"511\",\"name\":\"Office Equipment\",\"description\":\"Office Equipment\"}',9,'2018-04-24 09:50:43',NULL,NULL,1,NULL,NULL,NULL,NULL),(108,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',21,NULL,'{\"manualEntriesAllowed\":true,\"type\":1,\"usage\":\"1\",\"parentId\":19,\"glCode\":\"512\",\"name\":\"Fixtures and Fittings\",\"description\":\"Fixtures and Fittings\"}',9,'2018-04-24 09:52:23',NULL,NULL,1,NULL,NULL,NULL,NULL),(109,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',22,NULL,'{\"manualEntriesAllowed\":true,\"type\":1,\"usage\":\"2\",\"glCode\":\"520\",\"name\":\"Receivables\",\"description\":\"Account Receivables\"}',9,'2018-04-24 09:53:49',NULL,NULL,1,NULL,NULL,NULL,NULL),(110,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',23,NULL,'{\"manualEntriesAllowed\":true,\"type\":1,\"usage\":\"1\",\"parentId\":22,\"glCode\":\"521\",\"name\":\"Account Receivables\",\"description\":\"Account  Receivables\"}',9,'2018-04-24 10:51:19',NULL,NULL,1,NULL,NULL,NULL,NULL),(111,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',24,NULL,'{\"manualEntriesAllowed\":true,\"type\":1,\"usage\":\"1\",\"parentId\":22,\"glCode\":\"522\",\"name\":\"Cheques Receivables\",\"description\":\"Cheques Receivables\"}',9,'2018-04-24 11:36:34',NULL,NULL,1,NULL,NULL,NULL,NULL),(112,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',25,NULL,'{\"manualEntriesAllowed\":true,\"type\":1,\"usage\":\"2\",\"glCode\":\"530\",\"name\":\"Member Loans\",\"description\":\"Member Loans\"}',9,'2018-04-24 11:41:00',NULL,NULL,1,NULL,NULL,NULL,NULL),(113,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',26,NULL,'{\"manualEntriesAllowed\":true,\"type\":1,\"usage\":\"1\",\"parentId\":25,\"glCode\":\"531\",\"name\":\"Consumer Loans\",\"description\":\"Consumer Loans\"}',9,'2018-04-24 11:42:10',NULL,NULL,1,NULL,NULL,NULL,NULL),(114,'CREATE','GLACCOUNT',NULL,NULL,NULL,NULL,NULL,'/glaccounts/template',27,NULL,'{\"manualEntriesAllowed\":true,\"type\":1,\"usage\":\"1\",\"parentId\":25,\"glCode\":\"532\",\"name\":\"Business Loans\",\"description\":\"Business Loans\"}',9,'2018-04-24 11:45:02',NULL,NULL,1,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `m_portfolio_command_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan`
--

DROP TABLE IF EXISTS `m_product_loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `short_name` varchar(4) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `principal_amount` decimal(19,6) DEFAULT NULL,
  `min_principal_amount` decimal(19,6) DEFAULT NULL,
  `max_principal_amount` decimal(19,6) DEFAULT NULL,
  `arrearstolerance_amount` decimal(19,6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `fund_id` bigint(20) DEFAULT NULL,
  `is_linked_to_floating_interest_rates` bit(1) NOT NULL DEFAULT b'0',
  `allow_variabe_installments` bit(1) NOT NULL DEFAULT b'0',
  `nominal_interest_rate_per_period` decimal(19,6) DEFAULT NULL,
  `min_nominal_interest_rate_per_period` decimal(19,6) DEFAULT NULL,
  `max_nominal_interest_rate_per_period` decimal(19,6) DEFAULT NULL,
  `interest_period_frequency_enum` smallint(5) DEFAULT NULL,
  `annual_nominal_interest_rate` decimal(19,6) DEFAULT NULL,
  `interest_method_enum` smallint(5) NOT NULL,
  `interest_calculated_in_period_enum` smallint(5) NOT NULL DEFAULT '1',
  `allow_partial_period_interest_calcualtion` tinyint(1) NOT NULL DEFAULT '0',
  `repay_every` smallint(5) NOT NULL,
  `repayment_period_frequency_enum` smallint(5) NOT NULL,
  `number_of_repayments` smallint(5) NOT NULL,
  `min_number_of_repayments` smallint(5) DEFAULT NULL,
  `max_number_of_repayments` smallint(5) DEFAULT NULL,
  `grace_on_principal_periods` smallint(5) DEFAULT NULL,
  `recurring_moratorium_principal_periods` smallint(5) DEFAULT NULL,
  `grace_on_interest_periods` smallint(5) DEFAULT NULL,
  `grace_interest_free_periods` smallint(5) DEFAULT NULL,
  `amortization_method_enum` smallint(5) NOT NULL,
  `accounting_type` smallint(5) NOT NULL,
  `loan_transaction_strategy_id` bigint(20) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `include_in_borrower_cycle` tinyint(1) NOT NULL DEFAULT '0',
  `use_borrower_cycle` tinyint(1) NOT NULL DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `close_date` date DEFAULT NULL,
  `allow_multiple_disbursals` tinyint(1) NOT NULL DEFAULT '0',
  `max_disbursals` int(2) DEFAULT NULL,
  `max_outstanding_loan_balance` decimal(19,6) DEFAULT NULL,
  `grace_on_arrears_ageing` smallint(5) DEFAULT NULL,
  `overdue_days_for_npa` smallint(5) DEFAULT NULL,
  `days_in_month_enum` smallint(5) NOT NULL DEFAULT '1',
  `days_in_year_enum` smallint(5) NOT NULL DEFAULT '1',
  `interest_recalculation_enabled` tinyint(4) NOT NULL DEFAULT '0',
  `min_days_between_disbursal_and_first_repayment` int(3) DEFAULT NULL,
  `hold_guarantee_funds` tinyint(1) NOT NULL DEFAULT '0',
  `principal_threshold_for_last_installment` decimal(5,2) NOT NULL DEFAULT '50.00',
  `account_moves_out_of_npa_only_on_arrears_completion` tinyint(1) NOT NULL DEFAULT '0',
  `can_define_fixed_emi_amount` tinyint(1) NOT NULL DEFAULT '0',
  `instalment_amount_in_multiples_of` decimal(19,6) DEFAULT NULL,
  `can_use_for_topup` tinyint(1) NOT NULL DEFAULT '0',
  `sync_expected_with_disbursement_date` tinyint(4) DEFAULT '0',
  `is_equal_amortization` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`),
  UNIQUE KEY `unq_short_name` (`short_name`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  KEY `FKA6A8A7D77240145` (`fund_id`),
  KEY `FK_ltp_strategy` (`loan_transaction_strategy_id`),
  CONSTRAINT `FKA6A8A7D77240145` FOREIGN KEY (`fund_id`) REFERENCES `m_fund` (`id`),
  CONSTRAINT `FK_ltp_strategy` FOREIGN KEY (`loan_transaction_strategy_id`) REFERENCES `ref_loan_transaction_processing_strategy` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan`
--

LOCK TABLES `m_product_loan` WRITE;
/*!40000 ALTER TABLE `m_product_loan` DISABLE KEYS */;
INSERT INTO `m_product_loan` VALUES (1,'PLN','XAF',1,100,10000.000000,5000.000000,25000.000000,NULL,'Personal Loan','Personal Loan',NULL,'\0','\0',5.000000,NULL,5.000000,2,60.000000,1,1,0,2,1,3,1,5,NULL,NULL,NULL,NULL,1,1,5,NULL,1,0,'2018-04-17',NULL,0,NULL,NULL,NULL,NULL,1,1,0,14,0,0.00,1,0,100.000000,0,0,0),(2,'BLN','XAF',1,100,25000.000000,NULL,100000.000000,NULL,'Business Loan','Business Loan',NULL,'\0','\0',5.000000,NULL,5.000000,2,60.000000,1,1,0,1,2,3,NULL,5,NULL,NULL,NULL,NULL,1,1,1,NULL,1,0,'2018-04-17',NULL,0,NULL,NULL,NULL,NULL,1,1,0,28,0,0.00,1,0,100.000000,0,0,0);
/*!40000 ALTER TABLE `m_product_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_charge`
--

DROP TABLE IF EXISTS `m_product_loan_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_charge` (
  `product_loan_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  PRIMARY KEY (`product_loan_id`,`charge_id`),
  KEY `charge_id` (`charge_id`),
  CONSTRAINT `m_product_loan_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_product_loan_charge_ibfk_2` FOREIGN KEY (`product_loan_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_charge`
--

LOCK TABLES `m_product_loan_charge` WRITE;
/*!40000 ALTER TABLE `m_product_loan_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_configurable_attributes`
--

DROP TABLE IF EXISTS `m_product_loan_configurable_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_configurable_attributes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL,
  `amortization_method_enum` tinyint(4) NOT NULL DEFAULT '1',
  `interest_method_enum` tinyint(4) NOT NULL DEFAULT '1',
  `loan_transaction_strategy_id` tinyint(4) NOT NULL DEFAULT '1',
  `interest_calculated_in_period_enum` tinyint(4) NOT NULL DEFAULT '1',
  `arrearstolerance_amount` tinyint(4) NOT NULL DEFAULT '1',
  `repay_every` tinyint(4) NOT NULL DEFAULT '1',
  `moratorium` tinyint(4) NOT NULL DEFAULT '1',
  `grace_on_arrears_ageing` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_m_product_loan_configurable_attributes_0001` (`loan_product_id`),
  CONSTRAINT `fk_m_product_loan_configurable_attributes_0001` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_configurable_attributes`
--

LOCK TABLES `m_product_loan_configurable_attributes` WRITE;
/*!40000 ALTER TABLE `m_product_loan_configurable_attributes` DISABLE KEYS */;
INSERT INTO `m_product_loan_configurable_attributes` VALUES (1,1,1,1,1,1,1,1,1,1),(2,2,1,1,1,1,1,1,1,1);
/*!40000 ALTER TABLE `m_product_loan_configurable_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_floating_rates`
--

DROP TABLE IF EXISTS `m_product_loan_floating_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_floating_rates` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL,
  `floating_rates_id` bigint(20) NOT NULL,
  `interest_rate_differential` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `min_differential_lending_rate` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `default_differential_lending_rate` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `max_differential_lending_rate` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `is_floating_interest_rate_calculation_allowed` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `FK_mappings_m_product_loan_id` (`loan_product_id`),
  KEY `FK_mappings_m_floating_rates_id` (`floating_rates_id`),
  CONSTRAINT `FK_mappings_m_floating_rates_id` FOREIGN KEY (`floating_rates_id`) REFERENCES `m_floating_rates` (`id`),
  CONSTRAINT `FK_mappings_m_product_loan_id` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_floating_rates`
--

LOCK TABLES `m_product_loan_floating_rates` WRITE;
/*!40000 ALTER TABLE `m_product_loan_floating_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan_floating_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_guarantee_details`
--

DROP TABLE IF EXISTS `m_product_loan_guarantee_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_guarantee_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL,
  `mandatory_guarantee` decimal(19,5) NOT NULL,
  `minimum_guarantee_from_own_funds` decimal(19,5) DEFAULT NULL,
  `minimum_guarantee_from_guarantor_funds` decimal(19,5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_guarantee_details_loan_product` (`loan_product_id`),
  CONSTRAINT `FK_guarantee_details_loan_product` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_guarantee_details`
--

LOCK TABLES `m_product_loan_guarantee_details` WRITE;
/*!40000 ALTER TABLE `m_product_loan_guarantee_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan_guarantee_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_recalculation_details`
--

DROP TABLE IF EXISTS `m_product_loan_recalculation_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_recalculation_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `compound_type_enum` smallint(5) NOT NULL,
  `reschedule_strategy_enum` smallint(5) NOT NULL,
  `rest_frequency_type_enum` smallint(1) NOT NULL,
  `rest_frequency_interval` smallint(3) NOT NULL DEFAULT '0',
  `arrears_based_on_original_schedule` tinyint(1) NOT NULL DEFAULT '0',
  `pre_close_interest_calculation_strategy` smallint(3) NOT NULL DEFAULT '1',
  `compounding_frequency_type_enum` smallint(1) DEFAULT NULL,
  `compounding_frequency_interval` smallint(3) DEFAULT NULL,
  `rest_frequency_nth_day_enum` int(5) DEFAULT NULL,
  `rest_frequency_on_day` int(5) DEFAULT NULL,
  `rest_frequency_weekday_enum` int(5) DEFAULT NULL,
  `compounding_frequency_nth_day_enum` int(5) DEFAULT NULL,
  `compounding_frequency_on_day` int(5) DEFAULT NULL,
  `compounding_frequency_weekday_enum` int(5) DEFAULT NULL,
  `is_compounding_to_be_posted_as_transaction` tinyint(1) NOT NULL DEFAULT '0',
  `allow_compounding_on_eod` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_m_product_loan_m_product_loan_recalculation_details` (`product_id`),
  CONSTRAINT `FK_m_product_loan_m_product_loan_recalculation_details` FOREIGN KEY (`product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_recalculation_details`
--

LOCK TABLES `m_product_loan_recalculation_details` WRITE;
/*!40000 ALTER TABLE `m_product_loan_recalculation_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan_recalculation_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_variable_installment_config`
--

DROP TABLE IF EXISTS `m_product_loan_variable_installment_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_variable_installment_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL,
  `minimum_gap` int(4) NOT NULL,
  `maximum_gap` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mappings_m_variable_product_loan_id` (`loan_product_id`),
  CONSTRAINT `FK_mappings_m_variable_product_loan_id` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_variable_installment_config`
--

LOCK TABLES `m_product_loan_variable_installment_config` WRITE;
/*!40000 ALTER TABLE `m_product_loan_variable_installment_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan_variable_installment_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_variations_borrower_cycle`
--

DROP TABLE IF EXISTS `m_product_loan_variations_borrower_cycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_variations_borrower_cycle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL DEFAULT '0',
  `borrower_cycle_number` int(3) NOT NULL DEFAULT '0',
  `value_condition` int(1) NOT NULL DEFAULT '0',
  `param_type` int(1) NOT NULL DEFAULT '0',
  `default_value` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `max_value` decimal(19,6) DEFAULT NULL,
  `min_value` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `borrower_cycle_loan_product_FK` (`loan_product_id`),
  CONSTRAINT `borrower_cycle_loan_product_FK` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_variations_borrower_cycle`
--

LOCK TABLES `m_product_loan_variations_borrower_cycle` WRITE;
/*!40000 ALTER TABLE `m_product_loan_variations_borrower_cycle` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan_variations_borrower_cycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_mix`
--

DROP TABLE IF EXISTS `m_product_mix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_mix` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `restricted_product_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_product_mix_product_id_to_m_product_loan` (`product_id`),
  KEY `FK_m_product_mix_restricted_product_id_to_m_product_loan` (`restricted_product_id`),
  CONSTRAINT `FK_m_product_mix_product_id_to_m_product_loan` FOREIGN KEY (`product_id`) REFERENCES `m_product_loan` (`id`),
  CONSTRAINT `FK_m_product_mix_restricted_product_id_to_m_product_loan` FOREIGN KEY (`restricted_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_mix`
--

LOCK TABLES `m_product_mix` WRITE;
/*!40000 ALTER TABLE `m_product_mix` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_mix` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_provision_category`
--

DROP TABLE IF EXISTS `m_provision_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_provision_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_provision_category`
--

LOCK TABLES `m_provision_category` WRITE;
/*!40000 ALTER TABLE `m_provision_category` DISABLE KEYS */;
INSERT INTO `m_provision_category` VALUES (1,'STANDARD','Punctual Payment without any dues'),(2,'SUB-STANDARD','Principal and/or Interest overdue by x days'),(3,'DOUBTFUL','Principal and/or Interest overdue by x days and less than y'),(4,'LOSS','Principal and/or Interest overdue by y days');
/*!40000 ALTER TABLE `m_provision_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_provisioning_criteria`
--

DROP TABLE IF EXISTS `m_provisioning_criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_provisioning_criteria` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `criteria_name` varchar(200) NOT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `criteria_name` (`criteria_name`),
  KEY `createdby_id` (`createdby_id`),
  KEY `lastmodifiedby_id` (`lastmodifiedby_id`),
  CONSTRAINT `m_provisioning_criteria_ibfk_1` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_provisioning_criteria_ibfk_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_provisioning_criteria`
--

LOCK TABLES `m_provisioning_criteria` WRITE;
/*!40000 ALTER TABLE `m_provisioning_criteria` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_provisioning_criteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_provisioning_criteria_definition`
--

DROP TABLE IF EXISTS `m_provisioning_criteria_definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_provisioning_criteria_definition` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `criteria_id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `min_age` bigint(20) NOT NULL,
  `max_age` bigint(20) NOT NULL,
  `provision_percentage` decimal(5,2) NOT NULL,
  `liability_account` bigint(20) DEFAULT NULL,
  `expense_account` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `criteria_id` (`criteria_id`),
  KEY `category_id` (`category_id`),
  KEY `liability_account` (`liability_account`),
  KEY `expense_account` (`expense_account`),
  CONSTRAINT `m_provisioning_criteria_definition_ibfk_1` FOREIGN KEY (`criteria_id`) REFERENCES `m_provisioning_criteria` (`id`),
  CONSTRAINT `m_provisioning_criteria_definition_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `m_provision_category` (`id`),
  CONSTRAINT `m_provisioning_criteria_definition_ibfk_3` FOREIGN KEY (`liability_account`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `m_provisioning_criteria_definition_ibfk_4` FOREIGN KEY (`expense_account`) REFERENCES `acc_gl_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_provisioning_criteria_definition`
--

LOCK TABLES `m_provisioning_criteria_definition` WRITE;
/*!40000 ALTER TABLE `m_provisioning_criteria_definition` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_provisioning_criteria_definition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_provisioning_history`
--

DROP TABLE IF EXISTS `m_provisioning_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_provisioning_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `journal_entry_created` bit(1) DEFAULT b'0',
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `createdby_id` (`createdby_id`),
  KEY `lastmodifiedby_id` (`lastmodifiedby_id`),
  CONSTRAINT `m_provisioning_history_ibfk_1` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_provisioning_history_ibfk_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_provisioning_history`
--

LOCK TABLES `m_provisioning_history` WRITE;
/*!40000 ALTER TABLE `m_provisioning_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_provisioning_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_report_mailing_job`
--

DROP TABLE IF EXISTS `m_report_mailing_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_report_mailing_job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `start_datetime` datetime NOT NULL,
  `recurrence` varchar(100) DEFAULT NULL,
  `created_date` date NOT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `lastmodified_date` date DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `email_recipients` text NOT NULL,
  `email_subject` varchar(100) NOT NULL,
  `email_message` text NOT NULL,
  `email_attachment_file_format` varchar(10) NOT NULL,
  `stretchy_report_id` int(11) NOT NULL,
  `stretchy_report_param_map` text,
  `previous_run_datetime` datetime DEFAULT NULL,
  `next_run_datetime` datetime DEFAULT NULL,
  `previous_run_status` varchar(10) DEFAULT NULL,
  `previous_run_error_log` text,
  `previous_run_error_message` text,
  `number_of_runs` int(11) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `run_as_userid` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`),
  KEY `createdby_id` (`createdby_id`),
  KEY `lastmodifiedby_id` (`lastmodifiedby_id`),
  KEY `stretchy_report_id` (`stretchy_report_id`),
  KEY `run_as_userid` (`run_as_userid`),
  CONSTRAINT `m_report_mailing_job_ibfk_1` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_report_mailing_job_ibfk_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_report_mailing_job_ibfk_3` FOREIGN KEY (`stretchy_report_id`) REFERENCES `stretchy_report` (`id`),
  CONSTRAINT `m_report_mailing_job_ibfk_4` FOREIGN KEY (`run_as_userid`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_report_mailing_job`
--

LOCK TABLES `m_report_mailing_job` WRITE;
/*!40000 ALTER TABLE `m_report_mailing_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_report_mailing_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_report_mailing_job_configuration`
--

DROP TABLE IF EXISTS `m_report_mailing_job_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_report_mailing_job_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `value` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_report_mailing_job_configuration`
--

LOCK TABLES `m_report_mailing_job_configuration` WRITE;
/*!40000 ALTER TABLE `m_report_mailing_job_configuration` DISABLE KEYS */;
INSERT INTO `m_report_mailing_job_configuration` VALUES (1,'GMAIL_SMTP_SERVER','smtp.gmail.com'),(2,'GMAIL_SMTP_PORT','587'),(3,'GMAIL_SMTP_USERNAME',''),(4,'GMAIL_SMTP_PASSWORD','');
/*!40000 ALTER TABLE `m_report_mailing_job_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_report_mailing_job_run_history`
--

DROP TABLE IF EXISTS `m_report_mailing_job_run_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_report_mailing_job_run_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_id` bigint(20) NOT NULL,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime NOT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` text,
  `error_log` text,
  PRIMARY KEY (`id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `m_report_mailing_job_run_history_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `m_report_mailing_job` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_report_mailing_job_run_history`
--

LOCK TABLES `m_report_mailing_job_run_history` WRITE;
/*!40000 ALTER TABLE `m_report_mailing_job_run_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_report_mailing_job_run_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_role`
--

DROP TABLE IF EXISTS `m_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_role`
--

LOCK TABLES `m_role` WRITE;
/*!40000 ALTER TABLE `m_role` DISABLE KEYS */;
INSERT INTO `m_role` VALUES (1,'Super user','This role provides all application permissions.',0),(2,'Self Service User','self service user role',1);
/*!40000 ALTER TABLE `m_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_role_permission`
--

DROP TABLE IF EXISTS `m_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_role_permission` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `FK8DEDB04815CEC7AB` (`role_id`),
  KEY `FK8DEDB048103B544B` (`permission_id`),
  CONSTRAINT `FK8DEDB048103B544B` FOREIGN KEY (`permission_id`) REFERENCES `m_permission` (`id`),
  CONSTRAINT `FK8DEDB04815CEC7AB` FOREIGN KEY (`role_id`) REFERENCES `m_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_role_permission`
--

LOCK TABLES `m_role_permission` WRITE;
/*!40000 ALTER TABLE `m_role_permission` DISABLE KEYS */;
INSERT INTO `m_role_permission` VALUES (1,1);
/*!40000 ALTER TABLE `m_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_account`
--

DROP TABLE IF EXISTS `m_savings_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_no` varchar(20) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `field_officer_id` bigint(20) DEFAULT NULL,
  `status_enum` smallint(5) NOT NULL DEFAULT '300',
  `sub_status_enum` smallint(5) NOT NULL DEFAULT '0',
  `account_type_enum` smallint(5) NOT NULL DEFAULT '1',
  `deposit_type_enum` smallint(5) NOT NULL DEFAULT '100',
  `submittedon_date` date NOT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `approvedon_date` date DEFAULT NULL,
  `approvedon_userid` bigint(20) DEFAULT NULL,
  `rejectedon_date` date DEFAULT NULL,
  `rejectedon_userid` bigint(20) DEFAULT NULL,
  `withdrawnon_date` date DEFAULT NULL,
  `withdrawnon_userid` bigint(20) DEFAULT NULL,
  `activatedon_date` date DEFAULT NULL,
  `activatedon_userid` bigint(20) DEFAULT NULL,
  `closedon_date` date DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `nominal_annual_interest_rate` decimal(19,6) NOT NULL,
  `interest_compounding_period_enum` smallint(5) NOT NULL,
  `interest_posting_period_enum` smallint(5) NOT NULL DEFAULT '4',
  `interest_calculation_type_enum` smallint(5) NOT NULL,
  `interest_calculation_days_in_year_type_enum` smallint(5) NOT NULL,
  `min_required_opening_balance` decimal(19,6) DEFAULT NULL,
  `lockin_period_frequency` decimal(19,6) DEFAULT NULL,
  `lockin_period_frequency_enum` smallint(5) DEFAULT NULL,
  `withdrawal_fee_for_transfer` tinyint(4) DEFAULT '1',
  `allow_overdraft` tinyint(1) NOT NULL DEFAULT '0',
  `overdraft_limit` decimal(19,6) DEFAULT NULL,
  `nominal_annual_interest_rate_overdraft` decimal(19,6) DEFAULT '0.000000',
  `min_overdraft_for_interest_calculation` decimal(19,6) DEFAULT '0.000000',
  `lockedin_until_date_derived` date DEFAULT NULL,
  `total_deposits_derived` decimal(19,6) DEFAULT NULL,
  `total_withdrawals_derived` decimal(19,6) DEFAULT NULL,
  `total_withdrawal_fees_derived` decimal(19,6) DEFAULT NULL,
  `total_fees_charge_derived` decimal(19,6) DEFAULT NULL,
  `total_penalty_charge_derived` decimal(19,6) DEFAULT NULL,
  `total_annual_fees_derived` decimal(19,6) DEFAULT NULL,
  `total_interest_earned_derived` decimal(19,6) DEFAULT NULL,
  `total_interest_posted_derived` decimal(19,6) DEFAULT NULL,
  `total_overdraft_interest_derived` decimal(19,6) DEFAULT '0.000000',
  `total_withhold_tax_derived` decimal(19,6) DEFAULT NULL,
  `account_balance_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `min_required_balance` decimal(19,6) DEFAULT NULL,
  `enforce_min_required_balance` tinyint(1) NOT NULL DEFAULT '0',
  `min_balance_for_interest_calculation` decimal(19,6) DEFAULT NULL,
  `start_interest_calculation_date` date DEFAULT NULL,
  `on_hold_funds_derived` decimal(19,6) DEFAULT NULL,
  `version` int(15) NOT NULL DEFAULT '1',
  `withhold_tax` tinyint(4) NOT NULL DEFAULT '0',
  `tax_group_id` bigint(20) DEFAULT NULL,
  `last_interest_calculation_date` date DEFAULT NULL,
  `total_savings_amount_on_hold` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sa_account_no_UNIQUE` (`account_no`),
  UNIQUE KEY `sa_externalid_UNIQUE` (`external_id`),
  KEY `FKSA00000000000001` (`client_id`),
  KEY `FKSA00000000000002` (`group_id`),
  KEY `FKSA00000000000003` (`product_id`),
  KEY `FK_savings_account_tax_group` (`tax_group_id`),
  CONSTRAINT `FKSA00000000000001` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FKSA00000000000002` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FKSA00000000000003` FOREIGN KEY (`product_id`) REFERENCES `m_savings_product` (`id`),
  CONSTRAINT `FK_savings_account_tax_group` FOREIGN KEY (`tax_group_id`) REFERENCES `m_tax_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_account`
--

LOCK TABLES `m_savings_account` WRITE;
/*!40000 ALTER TABLE `m_savings_account` DISABLE KEYS */;
INSERT INTO `m_savings_account` VALUES (1,'000000001',NULL,1,NULL,1,NULL,300,0,1,100,'2018-04-19',9,'2018-04-19',9,NULL,NULL,NULL,NULL,'2018-04-19',9,NULL,NULL,'XAF',1,100,0.000000,5,5,1,365,500.000000,NULL,NULL,0,0,0.000000,0.000000,0.000000,NULL,500.000000,NULL,NULL,NULL,NULL,NULL,0.000000,NULL,NULL,NULL,500.000000,500.000000,1,NULL,NULL,NULL,3,0,NULL,'2018-04-19',NULL),(2,'000000002',NULL,2,NULL,1,NULL,300,0,1,100,'2018-04-19',9,'2018-04-19',9,NULL,NULL,NULL,NULL,'2018-04-19',9,NULL,NULL,'XAF',1,100,0.000000,5,5,1,365,500.000000,NULL,NULL,0,0,0.000000,0.000000,0.000000,NULL,500.000000,NULL,NULL,NULL,NULL,NULL,0.000000,NULL,NULL,NULL,500.000000,500.000000,1,NULL,NULL,NULL,3,0,NULL,'2018-04-19',NULL),(3,'000000003',NULL,3,NULL,1,NULL,300,0,1,100,'2018-04-19',9,'2018-04-19',9,NULL,NULL,NULL,NULL,'2018-04-19',9,NULL,NULL,'XAF',1,100,0.000000,5,5,1,365,500.000000,NULL,NULL,0,0,0.000000,0.000000,0.000000,NULL,500.000000,NULL,NULL,NULL,NULL,NULL,0.000000,NULL,NULL,NULL,500.000000,500.000000,1,NULL,NULL,NULL,3,0,NULL,'2018-04-19',NULL),(4,'000000004',NULL,4,NULL,1,NULL,300,0,1,100,'2018-04-19',9,'2018-04-19',9,NULL,NULL,NULL,NULL,'2018-04-19',9,NULL,NULL,'XAF',1,100,0.000000,5,5,1,365,500.000000,NULL,NULL,0,0,0.000000,0.000000,0.000000,NULL,500.000000,NULL,NULL,NULL,NULL,NULL,0.000000,NULL,NULL,NULL,500.000000,500.000000,1,NULL,NULL,NULL,3,0,NULL,'2018-04-19',NULL),(5,'000000005',NULL,5,NULL,1,NULL,300,0,1,100,'2018-04-19',9,'2018-04-19',9,NULL,NULL,NULL,NULL,'2018-04-19',9,NULL,NULL,'XAF',1,100,0.000000,5,5,1,365,500.000000,NULL,NULL,0,0,0.000000,0.000000,0.000000,NULL,30500.000000,NULL,NULL,NULL,NULL,NULL,0.000000,NULL,NULL,NULL,30500.000000,500.000000,1,NULL,NULL,NULL,4,0,NULL,'2018-04-20',NULL),(6,'000000006',NULL,6,NULL,1,NULL,300,0,1,100,'2018-04-19',9,'2018-04-19',9,NULL,NULL,NULL,NULL,'2018-04-19',9,NULL,NULL,'XAF',1,100,0.000000,5,5,1,365,500.000000,NULL,NULL,0,0,0.000000,0.000000,0.000000,NULL,500.000000,NULL,NULL,NULL,NULL,NULL,0.000000,NULL,NULL,NULL,500.000000,500.000000,1,NULL,NULL,NULL,3,0,NULL,'2018-04-19',NULL),(7,'000000007',NULL,7,NULL,1,NULL,300,0,1,100,'2018-04-19',9,'2018-04-19',9,NULL,NULL,NULL,NULL,'2018-04-19',9,NULL,NULL,'XAF',1,100,0.000000,5,5,1,365,500.000000,NULL,NULL,0,0,0.000000,0.000000,0.000000,NULL,500.000000,NULL,NULL,NULL,NULL,NULL,0.000000,NULL,NULL,NULL,500.000000,500.000000,1,NULL,NULL,NULL,3,0,NULL,'2018-04-19',NULL),(8,'000000008',NULL,8,NULL,1,NULL,300,0,1,100,'2018-04-19',9,'2018-04-19',9,NULL,NULL,NULL,NULL,'2018-04-19',9,NULL,NULL,'XAF',1,100,0.000000,5,5,1,365,500.000000,NULL,NULL,0,0,0.000000,0.000000,0.000000,NULL,500.000000,NULL,NULL,NULL,NULL,NULL,0.000000,NULL,NULL,NULL,500.000000,500.000000,1,NULL,NULL,NULL,3,0,NULL,'2018-04-19',NULL),(9,'000000009',NULL,9,NULL,1,NULL,300,0,1,100,'2018-04-19',9,'2018-04-19',9,NULL,NULL,NULL,NULL,'2018-04-19',9,NULL,NULL,'XAF',1,100,0.000000,5,5,1,365,500.000000,NULL,NULL,0,0,0.000000,0.000000,0.000000,NULL,500.000000,NULL,NULL,NULL,NULL,NULL,0.000000,NULL,NULL,NULL,500.000000,500.000000,1,NULL,NULL,NULL,3,0,NULL,'2018-04-19',NULL),(10,'000000010',NULL,10,NULL,1,NULL,300,0,1,100,'2018-04-19',9,'2018-04-19',9,NULL,NULL,NULL,NULL,'2018-04-19',9,NULL,NULL,'XAF',1,100,0.000000,5,5,1,365,500.000000,NULL,NULL,0,0,0.000000,0.000000,0.000000,NULL,500.000000,NULL,NULL,NULL,NULL,NULL,0.000000,NULL,NULL,NULL,500.000000,500.000000,1,NULL,NULL,NULL,3,0,NULL,'2018-04-19',NULL),(11,'000000011',NULL,11,NULL,1,NULL,300,0,1,100,'2018-04-19',9,'2018-04-19',9,NULL,NULL,NULL,NULL,'2018-04-19',9,NULL,NULL,'XAF',1,100,0.000000,5,5,1,365,500.000000,NULL,NULL,0,0,0.000000,0.000000,0.000000,NULL,500.000000,NULL,NULL,NULL,NULL,NULL,0.000000,NULL,NULL,NULL,500.000000,500.000000,1,NULL,NULL,NULL,3,0,NULL,'2018-04-19',NULL),(12,'000000012',NULL,12,NULL,1,NULL,300,0,1,100,'2018-04-19',9,'2018-04-19',9,NULL,NULL,NULL,NULL,'2018-04-19',9,NULL,NULL,'XAF',1,100,0.000000,5,5,1,365,500.000000,NULL,NULL,0,0,0.000000,0.000000,0.000000,NULL,500.000000,NULL,NULL,NULL,NULL,NULL,0.000000,NULL,NULL,NULL,500.000000,500.000000,1,NULL,NULL,NULL,3,0,NULL,'2018-04-19',NULL),(13,'000000013',NULL,13,NULL,1,NULL,300,0,1,100,'2018-04-19',9,'2018-04-19',9,NULL,NULL,NULL,NULL,'2018-04-19',9,NULL,NULL,'XAF',1,100,0.000000,5,5,1,365,500.000000,NULL,NULL,0,0,0.000000,0.000000,0.000000,NULL,500.000000,NULL,NULL,NULL,NULL,NULL,0.000000,NULL,NULL,NULL,500.000000,500.000000,1,NULL,NULL,NULL,3,0,NULL,'2018-04-19',NULL);
/*!40000 ALTER TABLE `m_savings_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_account_charge`
--

DROP TABLE IF EXISTS `m_savings_account_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_account_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  `is_penalty` tinyint(1) NOT NULL DEFAULT '0',
  `charge_time_enum` smallint(5) NOT NULL,
  `charge_due_date` date DEFAULT NULL,
  `fee_on_month` smallint(5) DEFAULT NULL,
  `fee_on_day` smallint(5) DEFAULT NULL,
  `fee_interval` smallint(5) DEFAULT NULL,
  `charge_calculation_enum` smallint(5) NOT NULL,
  `calculation_percentage` decimal(19,6) DEFAULT NULL,
  `calculation_on_amount` decimal(19,6) DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_paid_derived` decimal(19,6) DEFAULT NULL,
  `amount_waived_derived` decimal(19,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `is_paid_derived` tinyint(1) NOT NULL DEFAULT '0',
  `waived` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `inactivated_on_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `charge_id` (`charge_id`),
  KEY `m_savings_account_charge_ibfk_2` (`savings_account_id`),
  CONSTRAINT `m_savings_account_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_savings_account_charge_ibfk_2` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_account_charge`
--

LOCK TABLES `m_savings_account_charge` WRITE;
/*!40000 ALTER TABLE `m_savings_account_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_account_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_account_charge_paid_by`
--

DROP TABLE IF EXISTS `m_savings_account_charge_paid_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_account_charge_paid_by` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_transaction_id` bigint(20) NOT NULL,
  `savings_account_charge_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__m_savings_account_transaction` (`savings_account_transaction_id`),
  KEY `FK__m_savings_account_charge` (`savings_account_charge_id`),
  CONSTRAINT `FK__m_savings_account_charge` FOREIGN KEY (`savings_account_charge_id`) REFERENCES `m_savings_account_charge` (`id`),
  CONSTRAINT `FK__m_savings_account_transaction` FOREIGN KEY (`savings_account_transaction_id`) REFERENCES `m_savings_account_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_account_charge_paid_by`
--

LOCK TABLES `m_savings_account_charge_paid_by` WRITE;
/*!40000 ALTER TABLE `m_savings_account_charge_paid_by` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_account_charge_paid_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_account_interest_rate_chart`
--

DROP TABLE IF EXISTS `m_savings_account_interest_rate_chart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_account_interest_rate_chart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `from_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `is_primary_grouping_by_amount` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FKSAIRC00000000000001` (`savings_account_id`),
  CONSTRAINT `FKSAIRC00000000000001` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_account_interest_rate_chart`
--

LOCK TABLES `m_savings_account_interest_rate_chart` WRITE;
/*!40000 ALTER TABLE `m_savings_account_interest_rate_chart` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_account_interest_rate_chart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_account_interest_rate_slab`
--

DROP TABLE IF EXISTS `m_savings_account_interest_rate_slab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_account_interest_rate_slab` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_interest_rate_chart_id` bigint(20) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `period_type_enum` smallint(5) DEFAULT NULL,
  `from_period` int(11) DEFAULT NULL,
  `to_period` int(11) DEFAULT NULL,
  `amount_range_from` decimal(19,6) DEFAULT NULL,
  `amount_range_to` decimal(19,6) DEFAULT NULL,
  `annual_interest_rate` decimal(19,6) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKSAIRS00000000000001` (`savings_account_interest_rate_chart_id`),
  CONSTRAINT `FKSAIRS00000000000001` FOREIGN KEY (`savings_account_interest_rate_chart_id`) REFERENCES `m_savings_account_interest_rate_chart` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_account_interest_rate_slab`
--

LOCK TABLES `m_savings_account_interest_rate_slab` WRITE;
/*!40000 ALTER TABLE `m_savings_account_interest_rate_slab` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_account_interest_rate_slab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_account_transaction`
--

DROP TABLE IF EXISTS `m_savings_account_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_account_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `payment_detail_id` bigint(20) DEFAULT NULL,
  `transaction_type_enum` smallint(5) NOT NULL,
  `is_reversed` tinyint(1) NOT NULL,
  `transaction_date` date NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `overdraft_amount_derived` decimal(19,6) DEFAULT NULL,
  `balance_end_date_derived` date DEFAULT NULL,
  `balance_number_of_days_derived` int(11) DEFAULT NULL,
  `running_balance_derived` decimal(19,6) DEFAULT NULL,
  `cumulative_balance_derived` decimal(19,6) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `appuser_id` bigint(20) DEFAULT NULL,
  `is_manual` tinyint(1) DEFAULT '0',
  `release_id_of_hold_amount` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKSAT0000000001` (`savings_account_id`),
  KEY `FK_m_savings_account_transaction_m_payment_detail` (`payment_detail_id`),
  KEY `FK_m_savings_account_transaction_m_office` (`office_id`),
  CONSTRAINT `FKSAT0000000001` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`),
  CONSTRAINT `FK_m_savings_account_transaction_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK_m_savings_account_transaction_m_payment_detail` FOREIGN KEY (`payment_detail_id`) REFERENCES `m_payment_detail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_account_transaction`
--

LOCK TABLES `m_savings_account_transaction` WRITE;
/*!40000 ALTER TABLE `m_savings_account_transaction` DISABLE KEYS */;
INSERT INTO `m_savings_account_transaction` VALUES (1,1,2,NULL,1,0,'2018-04-19',500.000000,NULL,'2018-04-19',1,500.000000,500.000000,'2018-04-19 09:14:09',9,0,NULL),(2,2,2,NULL,1,0,'2018-04-19',500.000000,NULL,'2018-04-19',1,500.000000,500.000000,'2018-04-19 09:17:45',9,0,NULL),(3,3,2,NULL,1,0,'2018-04-19',500.000000,NULL,'2018-04-19',1,500.000000,500.000000,'2018-04-19 09:19:54',9,0,NULL),(4,4,2,NULL,1,0,'2018-04-19',500.000000,NULL,'2018-04-19',1,500.000000,500.000000,'2018-04-19 09:27:27',9,0,NULL),(5,5,2,NULL,1,0,'2018-04-19',500.000000,NULL,'2018-04-19',1,500.000000,500.000000,'2018-04-19 09:29:52',9,0,NULL),(6,6,2,NULL,1,0,'2018-04-19',500.000000,NULL,'2018-04-19',1,500.000000,500.000000,'2018-04-19 09:47:09',9,0,NULL),(7,7,2,NULL,1,0,'2018-04-19',500.000000,NULL,'2018-04-19',1,500.000000,500.000000,'2018-04-19 09:56:18',9,0,NULL),(8,8,2,NULL,1,0,'2018-04-19',500.000000,NULL,'2018-04-19',1,500.000000,500.000000,'2018-04-19 10:44:46',9,0,NULL),(9,9,2,NULL,1,0,'2018-04-19',500.000000,NULL,'2018-04-19',1,500.000000,500.000000,'2018-04-19 10:54:13',9,0,NULL),(10,10,2,NULL,1,0,'2018-04-19',500.000000,NULL,'2018-04-19',1,500.000000,500.000000,'2018-04-19 10:59:42',9,0,NULL),(11,11,2,NULL,1,0,'2018-04-19',500.000000,NULL,'2018-04-19',1,500.000000,500.000000,'2018-04-19 11:04:20',9,0,NULL),(12,12,2,NULL,1,0,'2018-04-19',500.000000,NULL,'2018-04-19',1,500.000000,500.000000,'2018-04-19 11:10:17',9,0,NULL),(13,13,2,NULL,1,0,'2018-04-19',500.000000,NULL,'2018-04-19',1,500.000000,500.000000,'2018-04-19 11:15:06',9,0,NULL),(14,5,2,1,1,0,'2018-04-20',30000.000000,NULL,'2018-04-20',1,30500.000000,30500.000000,'2018-04-20 12:41:27',9,0,NULL);
/*!40000 ALTER TABLE `m_savings_account_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_account_transaction_tax_details`
--

DROP TABLE IF EXISTS `m_savings_account_transaction_tax_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_account_transaction_tax_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_transaction_id` bigint(20) NOT NULL,
  `tax_component_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_savings_account_transaction_tax_details_savings_transaction` (`savings_transaction_id`),
  KEY `FK_savings_account_transaction_tax_details_tax_component` (`tax_component_id`),
  CONSTRAINT `FK_savings_account_transaction_tax_details_savings_transaction` FOREIGN KEY (`savings_transaction_id`) REFERENCES `m_savings_account_transaction` (`id`),
  CONSTRAINT `FK_savings_account_transaction_tax_details_tax_component` FOREIGN KEY (`tax_component_id`) REFERENCES `m_tax_component` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_account_transaction_tax_details`
--

LOCK TABLES `m_savings_account_transaction_tax_details` WRITE;
/*!40000 ALTER TABLE `m_savings_account_transaction_tax_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_account_transaction_tax_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_interest_incentives`
--

DROP TABLE IF EXISTS `m_savings_interest_incentives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_interest_incentives` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deposit_account_interest_rate_slab_id` bigint(20) NOT NULL,
  `entiry_type` smallint(2) NOT NULL,
  `attribute_name` smallint(2) NOT NULL,
  `condition_type` smallint(2) NOT NULL,
  `attribute_value` varchar(50) NOT NULL,
  `incentive_type` smallint(2) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_savings_interest_incentives_m_savings_interest_rate_slab` (`deposit_account_interest_rate_slab_id`),
  CONSTRAINT `FK_m_savings_interest_incentives_m_savings_interest_rate_slab` FOREIGN KEY (`deposit_account_interest_rate_slab_id`) REFERENCES `m_savings_account_interest_rate_slab` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_interest_incentives`
--

LOCK TABLES `m_savings_interest_incentives` WRITE;
/*!40000 ALTER TABLE `m_savings_interest_incentives` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_interest_incentives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_officer_assignment_history`
--

DROP TABLE IF EXISTS `m_savings_officer_assignment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_officer_assignment_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `savings_officer_id` bigint(20) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_m_savings_officer_assignment_history_0001` (`account_id`),
  KEY `fk_m_savings_officer_assignment_history_0002` (`savings_officer_id`),
  CONSTRAINT `fk_m_savings_officer_assignment_history_0001` FOREIGN KEY (`account_id`) REFERENCES `m_savings_account` (`id`),
  CONSTRAINT `fk_m_savings_officer_assignment_history_0002` FOREIGN KEY (`savings_officer_id`) REFERENCES `m_staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_officer_assignment_history`
--

LOCK TABLES `m_savings_officer_assignment_history` WRITE;
/*!40000 ALTER TABLE `m_savings_officer_assignment_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_officer_assignment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_product`
--

DROP TABLE IF EXISTS `m_savings_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `short_name` varchar(4) NOT NULL,
  `description` varchar(500) NOT NULL,
  `deposit_type_enum` smallint(5) NOT NULL DEFAULT '100',
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `nominal_annual_interest_rate` decimal(19,6) NOT NULL,
  `interest_compounding_period_enum` smallint(5) NOT NULL,
  `interest_posting_period_enum` smallint(5) NOT NULL DEFAULT '4',
  `interest_calculation_type_enum` smallint(5) NOT NULL,
  `interest_calculation_days_in_year_type_enum` smallint(5) NOT NULL,
  `min_required_opening_balance` decimal(19,6) DEFAULT NULL,
  `lockin_period_frequency` decimal(19,6) DEFAULT NULL,
  `lockin_period_frequency_enum` smallint(5) DEFAULT NULL,
  `accounting_type` smallint(5) NOT NULL,
  `withdrawal_fee_amount` decimal(19,6) DEFAULT NULL,
  `withdrawal_fee_type_enum` smallint(5) DEFAULT NULL,
  `withdrawal_fee_for_transfer` tinyint(4) DEFAULT '1',
  `allow_overdraft` tinyint(1) NOT NULL DEFAULT '0',
  `overdraft_limit` decimal(19,6) DEFAULT NULL,
  `nominal_annual_interest_rate_overdraft` decimal(19,6) DEFAULT '0.000000',
  `min_overdraft_for_interest_calculation` decimal(19,6) DEFAULT '0.000000',
  `min_required_balance` decimal(19,6) DEFAULT NULL,
  `enforce_min_required_balance` tinyint(1) NOT NULL DEFAULT '0',
  `min_balance_for_interest_calculation` decimal(19,6) DEFAULT NULL,
  `withhold_tax` tinyint(4) NOT NULL DEFAULT '0',
  `tax_group_id` bigint(20) DEFAULT NULL,
  `is_dormancy_tracking_active` smallint(1) DEFAULT NULL,
  `days_to_inactive` int(11) DEFAULT NULL,
  `days_to_dormancy` int(11) DEFAULT NULL,
  `days_to_escheat` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sp_unq_name` (`name`),
  UNIQUE KEY `sp_unq_short_name` (`short_name`),
  KEY `FK_savings_product_tax_group` (`tax_group_id`),
  CONSTRAINT `FK_savings_product_tax_group` FOREIGN KEY (`tax_group_id`) REFERENCES `m_tax_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_product`
--

LOCK TABLES `m_savings_product` WRITE;
/*!40000 ALTER TABLE `m_savings_product` DISABLE KEYS */;
INSERT INTO `m_savings_product` VALUES (1,'Regular Savings','RSV','Regular Savings',100,'XAF',1,100,0.000000,5,5,1,365,500.000000,NULL,NULL,1,NULL,NULL,0,0,0.000000,0.000000,0.000000,500.000000,1,NULL,0,NULL,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `m_savings_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_savings_product_charge`
--

DROP TABLE IF EXISTS `m_savings_product_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_savings_product_charge` (
  `savings_product_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  PRIMARY KEY (`savings_product_id`,`charge_id`),
  KEY `charge_id` (`charge_id`),
  CONSTRAINT `m_savings_product_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_savings_product_charge_ibfk_2` FOREIGN KEY (`savings_product_id`) REFERENCES `m_savings_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_savings_product_charge`
--

LOCK TABLES `m_savings_product_charge` WRITE;
/*!40000 ALTER TABLE `m_savings_product_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_savings_product_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_selfservice_beneficiaries_tpt`
--

DROP TABLE IF EXISTS `m_selfservice_beneficiaries_tpt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_selfservice_beneficiaries_tpt` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_user_id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `account_type` smallint(4) NOT NULL,
  `transfer_limit` bigint(20) DEFAULT '0',
  `is_active` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`app_user_id`,`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_selfservice_beneficiaries_tpt`
--

LOCK TABLES `m_selfservice_beneficiaries_tpt` WRITE;
/*!40000 ALTER TABLE `m_selfservice_beneficiaries_tpt` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_selfservice_beneficiaries_tpt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_selfservice_user_client_mapping`
--

DROP TABLE IF EXISTS `m_selfservice_user_client_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_selfservice_user_client_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appuser_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `appuser_id_client_id` (`appuser_id`,`client_id`),
  KEY `m_selfservice_client_id` (`client_id`),
  CONSTRAINT `m_selfservice_appuser_id` FOREIGN KEY (`appuser_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_selfservice_client_id` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_selfservice_user_client_mapping`
--

LOCK TABLES `m_selfservice_user_client_mapping` WRITE;
/*!40000 ALTER TABLE `m_selfservice_user_client_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_selfservice_user_client_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_account`
--

DROP TABLE IF EXISTS `m_share_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_no` varchar(50) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `status_enum` smallint(5) NOT NULL DEFAULT '300',
  `total_approved_shares` bigint(20) DEFAULT NULL,
  `total_pending_shares` bigint(20) DEFAULT NULL,
  `submitted_date` date NOT NULL,
  `submitted_userid` bigint(20) DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `approved_userid` bigint(20) DEFAULT NULL,
  `rejected_date` date DEFAULT NULL,
  `rejected_userid` bigint(20) DEFAULT NULL,
  `activated_date` date DEFAULT NULL,
  `activated_userid` bigint(20) DEFAULT NULL,
  `closed_date` date DEFAULT NULL,
  `closed_userid` bigint(20) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `savings_account_id` bigint(20) NOT NULL,
  `minimum_active_period_frequency` decimal(19,6) DEFAULT NULL,
  `minimum_active_period_frequency_enum` smallint(5) DEFAULT NULL,
  `lockin_period_frequency` decimal(19,6) DEFAULT NULL,
  `lockin_period_frequency_enum` smallint(5) DEFAULT NULL,
  `allow_dividends_inactive_clients` smallint(1) DEFAULT '0',
  `created_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `m_share_account_ibfk_1` (`product_id`),
  KEY `m_share_account_ibfk_2` (`savings_account_id`),
  KEY `m_share_account_ibfk_3` (`submitted_userid`),
  KEY `m_share_account_ibfk_4` (`approved_userid`),
  KEY `m_share_account_ibfk_5` (`rejected_userid`),
  KEY `m_share_account_ibfk_6` (`activated_userid`),
  KEY `m_share_account_ibfk_7` (`closed_userid`),
  KEY `m_share_account_ibfk_8` (`lastmodifiedby_id`),
  KEY `m_share_account_ibfk_9` (`client_id`),
  CONSTRAINT `m_share_account_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `m_share_product` (`id`),
  CONSTRAINT `m_share_account_ibfk_2` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`),
  CONSTRAINT `m_share_account_ibfk_3` FOREIGN KEY (`submitted_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_share_account_ibfk_4` FOREIGN KEY (`approved_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_share_account_ibfk_5` FOREIGN KEY (`rejected_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_share_account_ibfk_6` FOREIGN KEY (`activated_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_share_account_ibfk_7` FOREIGN KEY (`closed_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_share_account_ibfk_8` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_share_account_ibfk_9` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_account`
--

LOCK TABLES `m_share_account` WRITE;
/*!40000 ALTER TABLE `m_share_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_account_charge`
--

DROP TABLE IF EXISTS `m_share_account_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_account_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  `charge_time_enum` smallint(5) NOT NULL,
  `charge_calculation_enum` smallint(5) NOT NULL,
  `charge_payment_mode_enum` smallint(5) NOT NULL DEFAULT '0',
  `calculation_percentage` decimal(19,6) DEFAULT NULL,
  `calculation_on_amount` decimal(19,6) DEFAULT NULL,
  `charge_amount_or_percentage` decimal(19,6) DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_paid_derived` decimal(19,6) DEFAULT NULL,
  `amount_waived_derived` decimal(19,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `is_paid_derived` tinyint(1) NOT NULL DEFAULT '0',
  `waived` tinyint(1) NOT NULL DEFAULT '0',
  `min_cap` decimal(19,6) DEFAULT NULL,
  `max_cap` decimal(19,6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `charge_id` (`charge_id`),
  KEY `m_share_account_charge_ibfk_2` (`account_id`),
  CONSTRAINT `m_share_account_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_share_account_charge_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `m_share_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_account_charge`
--

LOCK TABLES `m_share_account_charge` WRITE;
/*!40000 ALTER TABLE `m_share_account_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_account_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_account_charge_paid_by`
--

DROP TABLE IF EXISTS `m_share_account_charge_paid_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_account_charge_paid_by` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `share_transaction_id` bigint(20) DEFAULT NULL,
  `charge_transaction_id` bigint(20) DEFAULT NULL,
  `amount` decimal(20,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `m_share_account_transactions_charge_mapping_ibfk1` (`share_transaction_id`),
  KEY `m_share_account_transactions_charge_mapping_ibfk2` (`charge_transaction_id`),
  CONSTRAINT `m_share_account_transactions_charge_mapping_ibfk1` FOREIGN KEY (`share_transaction_id`) REFERENCES `m_share_account_transactions` (`id`),
  CONSTRAINT `m_share_account_transactions_charge_mapping_ibfk2` FOREIGN KEY (`charge_transaction_id`) REFERENCES `m_share_account_charge` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_account_charge_paid_by`
--

LOCK TABLES `m_share_account_charge_paid_by` WRITE;
/*!40000 ALTER TABLE `m_share_account_charge_paid_by` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_account_charge_paid_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_account_dividend_details`
--

DROP TABLE IF EXISTS `m_share_account_dividend_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_account_dividend_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dividend_pay_out_id` bigint(20) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `status` smallint(3) NOT NULL,
  `savings_transaction_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_share_account_dividend_details_dividend_pay_out_id` (`dividend_pay_out_id`),
  KEY `FK_m_share_account_dividend_details_account_id` (`account_id`),
  CONSTRAINT `FK_m_share_account_dividend_details_account_id` FOREIGN KEY (`account_id`) REFERENCES `m_share_account` (`id`),
  CONSTRAINT `FK_m_share_account_dividend_details_dividend_pay_out_id` FOREIGN KEY (`dividend_pay_out_id`) REFERENCES `m_share_product_dividend_pay_out` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_account_dividend_details`
--

LOCK TABLES `m_share_account_dividend_details` WRITE;
/*!40000 ALTER TABLE `m_share_account_dividend_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_account_dividend_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_account_transactions`
--

DROP TABLE IF EXISTS `m_share_account_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_account_transactions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `transaction_date` date DEFAULT NULL,
  `total_shares` bigint(20) DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `amount` decimal(20,2) DEFAULT NULL,
  `charge_amount` decimal(20,2) DEFAULT NULL,
  `amount_paid` decimal(20,2) DEFAULT NULL,
  `status_enum` smallint(5) NOT NULL DEFAULT '300',
  `type_enum` smallint(5) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `m_share_account_purchased_shares_ibfk_1` (`account_id`),
  CONSTRAINT `m_share_account_purchased_shares_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `m_share_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_account_transactions`
--

LOCK TABLES `m_share_account_transactions` WRITE;
/*!40000 ALTER TABLE `m_share_account_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_account_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_product`
--

DROP TABLE IF EXISTS `m_share_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `short_name` varchar(4) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `description` varchar(500) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `currency_multiplesof` smallint(5) DEFAULT NULL,
  `total_shares` bigint(20) NOT NULL,
  `issued_shares` bigint(20) DEFAULT NULL,
  `totalsubscribed_shares` bigint(20) DEFAULT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `capital_amount` decimal(20,2) NOT NULL,
  `minimum_client_shares` bigint(20) DEFAULT NULL,
  `nominal_client_shares` bigint(20) NOT NULL,
  `maximum_client_shares` bigint(20) DEFAULT NULL,
  `minimum_active_period_frequency` decimal(19,6) DEFAULT NULL,
  `minimum_active_period_frequency_enum` smallint(5) DEFAULT NULL,
  `lockin_period_frequency` decimal(19,6) DEFAULT NULL,
  `lockin_period_frequency_enum` smallint(5) DEFAULT NULL,
  `allow_dividends_inactive_clients` smallint(1) DEFAULT '0',
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `accounting_type` smallint(2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `m_share_product_ibfk_1` (`createdby_id`),
  KEY `m_share_product_ibfk_2` (`lastmodifiedby_id`),
  CONSTRAINT `m_share_product_ibfk_1` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_share_product_ibfk_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_product`
--

LOCK TABLES `m_share_product` WRITE;
/*!40000 ALTER TABLE `m_share_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_product_charge`
--

DROP TABLE IF EXISTS `m_share_product_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_product_charge` (
  `product_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  PRIMARY KEY (`product_id`,`charge_id`),
  KEY `m_share_product_charge_ibfk_1` (`charge_id`),
  CONSTRAINT `m_share_product_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_share_product_charge_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `m_share_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_product_charge`
--

LOCK TABLES `m_share_product_charge` WRITE;
/*!40000 ALTER TABLE `m_share_product_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_product_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_product_dividend_pay_out`
--

DROP TABLE IF EXISTS `m_share_product_dividend_pay_out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_product_dividend_pay_out` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `dividend_period_start_date` date NOT NULL,
  `dividend_period_end_date` date NOT NULL,
  `status` smallint(3) NOT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_share_product_dividend_pay_out_product_id` (`product_id`),
  KEY `FK_m_share_product_dividend_pay_out_createdby_id` (`createdby_id`),
  KEY `FK_m_share_product_dividend_pay_out_lastmodifiedby_id` (`lastmodifiedby_id`),
  CONSTRAINT `FK_m_share_product_dividend_pay_out_createdby_id` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_share_product_dividend_pay_out_lastmodifiedby_id` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_share_product_dividend_pay_out_product_id` FOREIGN KEY (`product_id`) REFERENCES `m_share_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_product_dividend_pay_out`
--

LOCK TABLES `m_share_product_dividend_pay_out` WRITE;
/*!40000 ALTER TABLE `m_share_product_dividend_pay_out` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_product_dividend_pay_out` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_share_product_market_price`
--

DROP TABLE IF EXISTS `m_share_product_market_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_share_product_market_price` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `from_date` date DEFAULT NULL,
  `share_value` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `m_share_product_market_price_ibfk_1` (`product_id`),
  CONSTRAINT `m_share_product_market_price_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `m_share_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_share_product_market_price`
--

LOCK TABLES `m_share_product_market_price` WRITE;
/*!40000 ALTER TABLE `m_share_product_market_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_share_product_market_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_staff`
--

DROP TABLE IF EXISTS `m_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_staff` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_loan_officer` tinyint(1) NOT NULL DEFAULT '0',
  `office_id` bigint(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `display_name` varchar(102) NOT NULL,
  `mobile_no` varchar(50) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `organisational_role_enum` smallint(6) DEFAULT NULL,
  `organisational_role_parent_staff_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `joining_date` date DEFAULT NULL,
  `image_id` bigint(20) DEFAULT NULL,
  `email_address` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_name` (`display_name`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  UNIQUE KEY `mobile_no_UNIQUE` (`mobile_no`),
  KEY `FK_m_staff_m_office` (`office_id`),
  KEY `FK_m_staff_m_image` (`image_id`),
  CONSTRAINT `FK_m_staff_m_image` FOREIGN KEY (`image_id`) REFERENCES `m_image` (`id`),
  CONSTRAINT `FK_m_staff_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_staff`
--

LOCK TABLES `m_staff` WRITE;
/*!40000 ALTER TABLE `m_staff` DISABLE KEYS */;
INSERT INTO `m_staff` VALUES (1,0,2,'Cynthia','Epolle','Epolle, Cynthia','670949951',NULL,NULL,NULL,1,'2018-04-17',NULL,NULL),(2,1,2,'Ndam','Arouna','Arouna, Ndam','677245373',NULL,NULL,NULL,1,'2018-04-17',NULL,NULL),(3,0,2,'Esoh','Berlinda','Berlinda, Esoh','670256726',NULL,NULL,NULL,1,'2018-04-17',NULL,NULL),(4,0,2,'Ayuk','Etta','Etta, Ayuk','676101785',NULL,NULL,NULL,1,'2018-04-17',NULL,NULL);
/*!40000 ALTER TABLE `m_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_staff_assignment_history`
--

DROP TABLE IF EXISTS `m_staff_assignment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_staff_assignment_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `centre_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_staff_assignment_history_centre_id_m_group` (`centre_id`),
  KEY `FK_m_staff_assignment_history_m_staff` (`staff_id`),
  CONSTRAINT `FK_m_staff_assignment_history_centre_id_m_group` FOREIGN KEY (`centre_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FK_m_staff_assignment_history_m_staff` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_staff_assignment_history`
--

LOCK TABLES `m_staff_assignment_history` WRITE;
/*!40000 ALTER TABLE `m_staff_assignment_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_staff_assignment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_survey_components`
--

DROP TABLE IF EXISTS `m_survey_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_survey_components` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `survey_id` bigint(20) NOT NULL,
  `a_key` varchar(32) NOT NULL,
  `a_text` varchar(255) NOT NULL,
  `description` varchar(4000) DEFAULT NULL,
  `sequence_no` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `survey_id` (`survey_id`),
  CONSTRAINT `m_survey_components_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `m_surveys` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_survey_components`
--

LOCK TABLES `m_survey_components` WRITE;
/*!40000 ALTER TABLE `m_survey_components` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_survey_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_survey_lookup_tables`
--

DROP TABLE IF EXISTS `m_survey_lookup_tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_survey_lookup_tables` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `survey_id` bigint(20) NOT NULL,
  `a_key` varchar(255) NOT NULL,
  `description` int(4) DEFAULT NULL,
  `value_from` int(4) NOT NULL,
  `value_to` int(4) NOT NULL,
  `score` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `survey_id` (`survey_id`),
  CONSTRAINT `m_survey_lookup_tables_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `m_surveys` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_survey_lookup_tables`
--

LOCK TABLES `m_survey_lookup_tables` WRITE;
/*!40000 ALTER TABLE `m_survey_lookup_tables` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_survey_lookup_tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_survey_questions`
--

DROP TABLE IF EXISTS `m_survey_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_survey_questions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `survey_id` bigint(20) NOT NULL,
  `component_key` varchar(32) DEFAULT NULL,
  `a_key` varchar(32) NOT NULL,
  `a_text` varchar(255) NOT NULL,
  `description` varchar(4000) DEFAULT NULL,
  `sequence_no` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `survey_id` (`survey_id`),
  CONSTRAINT `m_survey_questions_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `m_surveys` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_survey_questions`
--

LOCK TABLES `m_survey_questions` WRITE;
/*!40000 ALTER TABLE `m_survey_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_survey_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_survey_responses`
--

DROP TABLE IF EXISTS `m_survey_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_survey_responses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) NOT NULL,
  `a_text` varchar(255) NOT NULL,
  `a_value` int(4) NOT NULL,
  `sequence_no` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `m_survey_responses_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `m_survey_questions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_survey_responses`
--

LOCK TABLES `m_survey_responses` WRITE;
/*!40000 ALTER TABLE `m_survey_responses` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_survey_responses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_survey_scorecards`
--

DROP TABLE IF EXISTS `m_survey_scorecards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_survey_scorecards` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `survey_id` bigint(20) NOT NULL,
  `question_id` bigint(20) NOT NULL,
  `response_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  `created_on` datetime DEFAULT NULL,
  `a_value` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `survey_id` (`survey_id`),
  KEY `question_id` (`question_id`),
  KEY `response_id` (`response_id`),
  KEY `user_id` (`user_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `m_survey_scorecards_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `m_surveys` (`id`),
  CONSTRAINT `m_survey_scorecards_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `m_survey_questions` (`id`),
  CONSTRAINT `m_survey_scorecards_ibfk_3` FOREIGN KEY (`response_id`) REFERENCES `m_survey_responses` (`id`),
  CONSTRAINT `m_survey_scorecards_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `m_survey_scorecards_ibfk_5` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_survey_scorecards`
--

LOCK TABLES `m_survey_scorecards` WRITE;
/*!40000 ALTER TABLE `m_survey_scorecards` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_survey_scorecards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_surveys`
--

DROP TABLE IF EXISTS `m_surveys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_surveys` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `a_key` varchar(32) NOT NULL,
  `a_name` varchar(255) NOT NULL,
  `description` varchar(4000) DEFAULT NULL,
  `country_code` varchar(2) NOT NULL,
  `valid_from` datetime DEFAULT NULL,
  `valid_to` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_surveys`
--

LOCK TABLES `m_surveys` WRITE;
/*!40000 ALTER TABLE `m_surveys` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_surveys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_tax_component`
--

DROP TABLE IF EXISTS `m_tax_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_tax_component` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `percentage` decimal(19,6) NOT NULL,
  `debit_account_type_enum` smallint(2) DEFAULT NULL,
  `debit_account_id` bigint(20) DEFAULT NULL,
  `credit_account_type_enum` smallint(2) DEFAULT NULL,
  `credit_account_id` bigint(20) DEFAULT NULL,
  `start_date` date NOT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tax_component_debit_gl_account` (`debit_account_id`),
  KEY `FK_tax_component_credit_gl_account` (`credit_account_id`),
  KEY `FK_tax_component_createdby` (`createdby_id`),
  KEY `FK_tax_component_lastmodifiedby` (`lastmodifiedby_id`),
  CONSTRAINT `FK_tax_component_createdby` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_tax_component_credit_gl_account` FOREIGN KEY (`credit_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_tax_component_debit_gl_account` FOREIGN KEY (`debit_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_tax_component_lastmodifiedby` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_tax_component`
--

LOCK TABLES `m_tax_component` WRITE;
/*!40000 ALTER TABLE `m_tax_component` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_tax_component` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_tax_component_history`
--

DROP TABLE IF EXISTS `m_tax_component_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_tax_component_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tax_component_id` bigint(20) NOT NULL,
  `percentage` decimal(19,6) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tax_component_history_tax_component_id` (`tax_component_id`),
  KEY `FK_tax_component_history_createdby` (`createdby_id`),
  KEY `FK_tax_component_history_lastmodifiedby` (`lastmodifiedby_id`),
  CONSTRAINT `FK_tax_component_history_createdby` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_tax_component_history_lastmodifiedby` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_tax_component_history_tax_component_id` FOREIGN KEY (`tax_component_id`) REFERENCES `m_tax_component` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_tax_component_history`
--

LOCK TABLES `m_tax_component_history` WRITE;
/*!40000 ALTER TABLE `m_tax_component_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_tax_component_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_tax_group`
--

DROP TABLE IF EXISTS `m_tax_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_tax_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tax_group_createdby` (`createdby_id`),
  KEY `FK_tax_group_lastmodifiedby` (`lastmodifiedby_id`),
  CONSTRAINT `FK_tax_group_createdby` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_tax_group_lastmodifiedby` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_tax_group`
--

LOCK TABLES `m_tax_group` WRITE;
/*!40000 ALTER TABLE `m_tax_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_tax_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_tax_group_mappings`
--

DROP TABLE IF EXISTS `m_tax_group_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_tax_group_mappings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tax_group_id` bigint(20) NOT NULL,
  `tax_component_id` bigint(20) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tax_group_mappings_tax_group` (`tax_group_id`),
  KEY `FK_tax_group_mappings_tax_component` (`tax_component_id`),
  KEY `FK_tax_group_mappings_createdby` (`createdby_id`),
  KEY `FK_tax_group_mappings_lastmodifiedby` (`lastmodifiedby_id`),
  CONSTRAINT `FK_tax_group_mappings_createdby` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_tax_group_mappings_lastmodifiedby` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_tax_group_mappings_tax_component` FOREIGN KEY (`tax_component_id`) REFERENCES `m_tax_component` (`id`),
  CONSTRAINT `FK_tax_group_mappings_tax_group` FOREIGN KEY (`tax_group_id`) REFERENCES `m_tax_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_tax_group_mappings`
--

LOCK TABLES `m_tax_group_mappings` WRITE;
/*!40000 ALTER TABLE `m_tax_group_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_tax_group_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_tellers`
--

DROP TABLE IF EXISTS `m_tellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_tellers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `office_id` bigint(20) NOT NULL,
  `debit_account_id` bigint(20) DEFAULT NULL,
  `credit_account_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_to` date DEFAULT NULL,
  `state` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `m_tellers_name_unq` (`name`),
  KEY `IK_m_tellers_m_office` (`office_id`),
  KEY `FK_m_tellers_gl_account_debit_account_id` (`debit_account_id`),
  KEY `FK_m_tellers_gl_account_credit_account_id` (`credit_account_id`),
  CONSTRAINT `FK_m_tellers_gl_account_credit_account_id` FOREIGN KEY (`credit_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_m_tellers_gl_account_debit_account_id` FOREIGN KEY (`debit_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_m_tellers_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_tellers`
--

LOCK TABLES `m_tellers` WRITE;
/*!40000 ALTER TABLE `m_tellers` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_tellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_template`
--

DROP TABLE IF EXISTS `m_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `text` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `entity` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_template`
--

LOCK TABLES `m_template` WRITE;
/*!40000 ALTER TABLE `m_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_template_m_templatemappers`
--

DROP TABLE IF EXISTS `m_template_m_templatemappers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_template_m_templatemappers` (
  `m_template_id` bigint(20) NOT NULL,
  `mappers_id` bigint(20) NOT NULL,
  UNIQUE KEY `mappers_id` (`mappers_id`),
  KEY `mappers_id_2` (`mappers_id`),
  KEY `m_template_id` (`m_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_template_m_templatemappers`
--

LOCK TABLES `m_template_m_templatemappers` WRITE;
/*!40000 ALTER TABLE `m_template_m_templatemappers` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_template_m_templatemappers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_templatemappers`
--

DROP TABLE IF EXISTS `m_templatemappers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_templatemappers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mapperkey` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `mapperorder` int(11) DEFAULT NULL,
  `mappervalue` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_templatemappers`
--

LOCK TABLES `m_templatemappers` WRITE;
/*!40000 ALTER TABLE `m_templatemappers` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_templatemappers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_working_days`
--

DROP TABLE IF EXISTS `m_working_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_working_days` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `recurrence` varchar(100) DEFAULT NULL,
  `repayment_rescheduling_enum` smallint(5) DEFAULT NULL,
  `extend_term_daily_repayments` tinyint(1) DEFAULT '0',
  `extend_term_holiday_repayment` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_working_days`
--

LOCK TABLES `m_working_days` WRITE;
/*!40000 ALTER TABLE `m_working_days` DISABLE KEYS */;
INSERT INTO `m_working_days` VALUES (1,'FREQ=WEEKLY;INTERVAL=1;BYDAY=MO,TU,WE,TH,FR,SA',2,0,0);
/*!40000 ALTER TABLE `m_working_days` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mix_taxonomy`
--

DROP TABLE IF EXISTS `mix_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mix_taxonomy` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `namespace_id` int(11) DEFAULT NULL,
  `dimension` varchar(100) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `need_mapping` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mix_taxonomy`
--

LOCK TABLES `mix_taxonomy` WRITE;
/*!40000 ALTER TABLE `mix_taxonomy` DISABLE KEYS */;
INSERT INTO `mix_taxonomy` VALUES (1,'AdministrativeExpense',1,NULL,3,NULL,1),(2,'Assets',3,NULL,1,'All outstanding principals due for all outstanding client loans. This includes current, delinquent, and renegotiated loans, but not loans that have been written off. It does not include interest receivable.',1),(3,'Assets',3,'MaturityDimension:LessThanOneYearMember',1,'Segmentation based on the life of an asset or liability.',1),(4,'Assets',3,'MaturityDimension:MoreThanOneYearMember',1,'Segmentation based on the life of an asset or liability.',1),(5,'CashAndCashEquivalents',1,NULL,1,NULL,1),(6,'Deposits',3,NULL,1,'The total value of funds placed in an account with an MFI that are payable to a depositor. This item includes any current, checking, or savings accounts that are payable on demand. It also includes time deposits which have a fixed maturity date and compulsory deposits.',1),(7,'Deposits',3,'DepositProductsDimension:CompulsoryMember',1,'The value of deposits that an MFI\'s clients are required to  maintain as a condition of an existing or future loan.',NULL),(8,'Deposits',3,'DepositProductsDimension:VoluntaryMember',1,'The value of deposits that an MFI\'s clients are not required to  maintain as a condition of an existing or future loan.',NULL),(9,'Deposits',3,'LocationDimension:RuralMember',1,'Located in rural areas. Segmentation based on location.',NULL),(10,'Deposits',3,'LocationDimension:UrbanMember',1,'Located in urban areas. Segmentation based on location.',NULL),(11,'Deposits',3,'MaturityDimension:LessThanOneYearMember',1,'Segmentation based on the life of an asset or liability.',NULL),(12,'Deposits',3,'MaturityDimension:MoreThanOneYearMember',1,'Segmentation based on the life of an asset or liability.',NULL),(13,'EmployeeBenefitsExpense',1,NULL,3,NULL,NULL),(14,'Equity',1,NULL,1,NULL,NULL),(15,'Expense',1,NULL,3,NULL,NULL),(16,'FinancialExpense',3,NULL,3,'All costs All costs incurred in raising funds from third parties, fee expenses from non-financial services, net gains (losses) due to changes in fair value of financial liabilities, impairment losses net of reversals of financial assets other than loan portfolio and net gains (losses) from restatement of financial statements in terms of the measuring unit current at the end of the reporting period.',NULL),(17,'FinancialRevenueOnLoans',3,NULL,2,'Interest and non-interest income generated by the provision of credit services to the clients. Fees and commissions for late payment are also included.',NULL),(18,'ImpairmentLossAllowanceGrossLoanPortfolio',3,NULL,2,'An allowance for the risk of losses in the gross loan portfolio due to default .',NULL),(19,'Liabilities',1,NULL,1,NULL,NULL),(20,'Liabilities',3,'MaturityDimension:LessThanOneYearMember',1,'Segmentation based on the life of an asset or liability.',NULL),(21,'Liabilities',3,'MaturityDimension:MoreThanOneYearMember',1,'Segmentation based on the life of an asset or liability.',NULL),(22,'LoanPortfolioGross',3,NULL,2,'All outstanding principals due for all outstanding client loans. This includes current, delinquent, and renegotiated loans, but not loans that have been written off. It does not include interest receivable.',NULL),(23,'LoanPortfolioGross',3,'CreditProductsDimension:MicroenterpriseMember',2,'Loans that finance the production or trade of goods and  services for an individual\'s microenterprise, whether or not the microenterprise is legally registered. Segmentation based on loan product.',NULL),(24,'LoanPortfolioGross',3,'DelinquencyDimension:OneMonthOrMoreMember',2,'Segmentation based on the principal balance of all loans outstanding that have one or more installments of principal  past due or renegotiated. Segmentation based on the  principal balance of all loans outstanding that have one or  more installments of principal past due or renegotiated.',NULL),(25,'LoanPortfolioGross',3,'DelinquencyDimension:ThreeMonthsOrMoreMember',2,'Segmentation based on the principal balance of all loans outstanding that have one or more installments of principal  past due or renegotiated.? Segmentation based on the  principal balance of all loans outstanding that have one or  more installments of principal past due or renegotiated.',NULL),(26,'LoanPortfolioGross',3,'LocationDimension:RuralMember',2,'Located in rural areas. Segmentation based on geographic location.',NULL),(27,'LoanPortfolioGross',3,'LocationDimension:UrbanMember',2,'Located in urbal areas. Segmentation based on geographic location.',NULL),(28,'LoanPortfolioGross',3,'MaturityDimension:LessThanOneYearMember',2,'Segmentation based on the life of an asset or liability.',NULL),(29,'LoanPortfolioGross',3,'MaturityDimension:MoreThanOneYearMember',2,'Segmentation based on the life of an asset or liability.',NULL),(30,'NetLoanLoss',3,'',3,'Referred to the value of delinquency loans written off net of any principal recovery.',NULL),(31,'NetLoanLossProvisionExpense',3,NULL,3,'Represent the net value of loan portfolio impairment loss considering any reversal on impairment loss and any recovery on loans written off recognized as a income during the accounting period.',NULL),(32,'NetOperatingIncome',3,NULL,2,'Total operating revenue less all expenses related to the MFI\'s core financial service operation including total financial expense, impairment loss and operating expense. Donations are excluded.',NULL),(33,'NetOperatingIncomeNetOfTaxExpense',3,NULL,3,'Net operating income reported incorporating the effect of taxes. Taxes include all domestic and foreign taxes which are based on taxable profits, other taxes related to personnel, financial transactions or value-added taxes are not considered in calculation of this value.',NULL),(34,'NumberOfActiveBorrowers',3,NULL,0,'The number of individuals who currently have an outstanding loan balance with the MFI or are primarily responsible for repaying any portion of the gross loan portfolio. Individuals who have multiple loans with an MFI should be counted as a single borrower.',NULL),(35,'NumberOfActiveBorrowers',3,'GenderDimension:FemaleMember',0,'The number of individuals who currently have an outstanding loan balance with the MFI or are primarily responsible for repaying any portion of the gross loan portfolio. Individuals who have multiple loans with an MFI should be counted as a single borrower.',NULL),(36,'NumberOfBoardMembers',3,'GenderDimension:FemaleMember',0,'The number of members that comprise the board of directors at the end of the reporting period who are female.',NULL),(37,'NumberOfDepositAccounts',3,NULL,0,'The number of individuals who currently have funds on deposit with the MFI on a voluntary basis; i.e., they are not required to maintain the deposit account to access a loan. This number applies only to deposits held by an MFI, not to those deposits held in other institutions by the MFI\'s clients. The number should be based on the number of individuals rather than the number of groups. A single deposit account may represent multiple depositors.',NULL),(38,'NumberOfDepositors',3,'',0,'The number of deposit accounts, both voluntary and compulsory, opened at the MFI whose balances the institution is liable to repay. The number should be based on the number of individual accounts rather than on the number of groups.',NULL),(39,'NumberOfEmployees',3,NULL,0,'The number of individuals who are actively employed by an entity. This number includes contract employees or advisors who dedicate a substantial portion of their time to the entity, even if they are not on the entity\'s employees roster.',NULL),(40,'NumberOfEmployees',3,'GenderDimension:FemaleMember',0,'The number of individuals who are actively employed by an entity. This number includes contract employees or advisors who dedicate a substantial portion of their time to the entity, even if they are not on the entity\'s employees roster.',NULL),(41,'NumberOfLoanOfficers',3,NULL,0,'The number of employees whose main activity is to manage a portion of the gross loan portfolio. A loan officer is a staff member of record who is directly responsible for arranging and monitoring client loans.',NULL),(42,'NumberOfLoanOfficers',3,'GenderDimension:FemaleMember',0,'The number of employees whose main activity is to manage a portion of the gross loan portfolio. A loan officer is a staff member of record who is directly responsible for arranging and monitoring client loans.',NULL),(43,'NumberOfManagers',3,'GenderDimension:FemaleMember',0,'The number of members that comprise the management of the institution who are female.',NULL),(44,'NumberOfOffices',3,NULL,0,'The number of staffed points of service and administrative sites used to deliver or support the delivery of financial services to microfinance clients.',NULL),(45,'NumberOfOutstandingLoans',3,NULL,0,'The number of loans in the gross loan portfolio. For MFIs using a group lending methodology, the number of loans should refer to the number of individuals receiving loans as part of a group or as part of a group loan.',NULL),(46,'OperatingExpense',3,NULL,3,'Includes expenses not related to financial and credit loss impairment, such as personnel expenses, depreciation, amortization and administrative expenses.',NULL),(47,'OperatingIncome',3,NULL,2,'Includes all financial income and other operating revenue which is generated from non-financial services. Operating income also includes net gains (losses) from holding financial assets (changes on their values during the period and foreign exchange differences). Donations or any revenue not related with an MFI\'s core business of making loans and providing financial services are not considered under this category.',NULL),(48,'WriteOffsOnGrossLoanPortfolio',3,NULL,2,'The value of loans that have been recognized as uncollectible for accounting purposes. A write-off is an accounting procedure that removes the outstanding balance of the loan from the gross loan portfolio and impairment loss allowance. Thus, the write-off does not affect the net loan portfolio, total assets, or any equity account. If the impairment loss allowance is insufficient to cover the amount written off, the excess amount will result in an additional impairment loss on loans recognised in profit or loss of the period.',NULL);
/*!40000 ALTER TABLE `mix_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mix_taxonomy_mapping`
--

DROP TABLE IF EXISTS `mix_taxonomy_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mix_taxonomy_mapping` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `config` varchar(200) DEFAULT NULL,
  `last_update_date` datetime DEFAULT NULL,
  `currency` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mix_taxonomy_mapping`
--

LOCK TABLES `mix_taxonomy_mapping` WRITE;
/*!40000 ALTER TABLE `mix_taxonomy_mapping` DISABLE KEYS */;
INSERT INTO `mix_taxonomy_mapping` VALUES (1,'default',NULL,NULL,'');
/*!40000 ALTER TABLE `mix_taxonomy_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mix_xbrl_namespace`
--

DROP TABLE IF EXISTS `mix_xbrl_namespace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mix_xbrl_namespace` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `prefix` varchar(20) NOT NULL DEFAULT '',
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQUE` (`prefix`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mix_xbrl_namespace`
--

LOCK TABLES `mix_xbrl_namespace` WRITE;
/*!40000 ALTER TABLE `mix_xbrl_namespace` DISABLE KEYS */;
INSERT INTO `mix_xbrl_namespace` VALUES (1,'ifrs','http://xbrl.iasb.org/taxonomy/2009-04-01/ifrs'),(2,'iso4217','http://www.xbrl.org/2003/iso4217'),(3,'mix','http://www.themix.org/int/fr/ifrs/basi/YYYY-MM-DD/mx-cor'),(4,'xbrldi','http://xbrl.org/2006/xbrldi'),(5,'xbrli','http://www.xbrl.org/2003/instance'),(6,'link','http://www.xbrl.org/2003/linkbase'),(7,'dc-all','http://www.themix.org/int/fr/ifrs/basi/2010-08-31/dc-all');
/*!40000 ALTER TABLE `mix_xbrl_namespace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_generator`
--

DROP TABLE IF EXISTS `notification_generator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_generator` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_type` text,
  `object_identifier` bigint(20) DEFAULT NULL,
  `action` text,
  `actor` bigint(20) DEFAULT NULL,
  `is_system_generated` tinyint(1) DEFAULT '0',
  `notification_content` text,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_generator`
--

LOCK TABLES `notification_generator` WRITE;
/*!40000 ALTER TABLE `notification_generator` DISABLE KEYS */;
INSERT INTO `notification_generator` VALUES (1,'loanProduct',1,'created',9,0,'New loan product created','2018-04-17 10:08:02'),(2,'loanProduct',1,'created',9,0,'New loan product created','2018-04-17 10:08:02'),(3,'loanProduct',2,'created',9,0,'New loan product created','2018-04-17 10:19:57'),(4,'loanProduct',2,'created',9,0,'New loan product created','2018-04-17 10:19:57'),(5,'savingsAccount',1,'depositMade',9,0,'Deposit made','2018-04-19 09:14:09'),(6,'client',1,'created',9,0,'New client created','2018-04-19 09:14:09'),(7,'savingsAccount',2,'depositMade',9,0,'Deposit made','2018-04-19 09:17:46'),(8,'client',2,'created',9,0,'New client created','2018-04-19 09:17:46'),(9,'savingsAccount',3,'depositMade',9,0,'Deposit made','2018-04-19 09:19:54'),(10,'client',3,'created',9,0,'New client created','2018-04-19 09:19:54'),(11,'savingsAccount',4,'depositMade',9,0,'Deposit made','2018-04-19 09:27:27'),(12,'client',4,'created',9,0,'New client created','2018-04-19 09:27:27'),(13,'client',5,'created',9,0,'New client created','2018-04-19 09:29:52'),(14,'savingsAccount',5,'depositMade',9,0,'Deposit made','2018-04-19 09:29:52'),(15,'savingsAccount',6,'depositMade',9,0,'Deposit made','2018-04-19 09:47:09'),(16,'client',6,'created',9,0,'New client created','2018-04-19 09:47:09'),(17,'savingsAccount',7,'depositMade',9,0,'Deposit made','2018-04-19 09:56:18'),(18,'client',7,'created',9,0,'New client created','2018-04-19 09:56:18'),(19,'savingsAccount',8,'depositMade',9,0,'Deposit made','2018-04-19 10:44:46'),(20,'client',8,'created',9,0,'New client created','2018-04-19 10:44:46'),(21,'savingsAccount',9,'depositMade',9,0,'Deposit made','2018-04-19 10:54:13'),(22,'client',9,'created',9,0,'New client created','2018-04-19 10:54:13'),(23,'savingsAccount',10,'depositMade',9,0,'Deposit made','2018-04-19 10:59:42'),(24,'client',10,'created',9,0,'New client created','2018-04-19 10:59:42'),(25,'savingsAccount',11,'depositMade',9,0,'Deposit made','2018-04-19 11:04:20'),(26,'client',11,'created',9,0,'New client created','2018-04-19 11:04:20'),(27,'savingsAccount',12,'depositMade',9,0,'Deposit made','2018-04-19 11:10:17'),(28,'client',12,'created',9,0,'New client created','2018-04-19 11:10:17'),(29,'savingsAccount',13,'depositMade',9,0,'Deposit made','2018-04-19 11:15:06'),(30,'client',13,'created',9,0,'New client created','2018-04-19 11:15:06'),(31,'client',15,'created',9,0,'New client created','2018-04-19 11:20:58'),(32,'savingsAccount',5,'depositMade',9,0,'Deposit made','2018-04-20 12:41:27');
/*!40000 ALTER TABLE `notification_generator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_mapper`
--

DROP TABLE IF EXISTS `notification_mapper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_mapper` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `notification_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_mapper` (`user_id`),
  KEY `notification_id` (`notification_id`),
  CONSTRAINT `notification_mapper_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `notification_mapper_ibfk_3` FOREIGN KEY (`notification_id`) REFERENCES `notification_generator` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_mapper`
--

LOCK TABLES `notification_mapper` WRITE;
/*!40000 ALTER TABLE `notification_mapper` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_mapper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_token`
--

DROP TABLE IF EXISTS `oauth_access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_token` (
  `token_id` varchar(256) DEFAULT NULL,
  `token` blob,
  `authentication_id` varchar(256) DEFAULT NULL,
  `user_name` varchar(256) DEFAULT NULL,
  `client_id` varchar(256) DEFAULT NULL,
  `authentication` blob,
  `refresh_token` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_token`
--

LOCK TABLES `oauth_access_token` WRITE;
/*!40000 ALTER TABLE `oauth_access_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_access_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_client_details`
--

DROP TABLE IF EXISTS `oauth_client_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_client_details` (
  `client_id` varchar(128) NOT NULL,
  `resource_ids` varchar(256) DEFAULT NULL,
  `client_secret` varchar(256) DEFAULT NULL,
  `scope` varchar(256) DEFAULT NULL,
  `authorized_grant_types` varchar(256) DEFAULT NULL,
  `web_server_redirect_uri` varchar(256) DEFAULT NULL,
  `authorities` varchar(256) DEFAULT NULL,
  `access_token_validity` int(11) DEFAULT NULL,
  `refresh_token_validity` int(11) DEFAULT NULL,
  `additional_information` varchar(4096) DEFAULT NULL,
  `autoapprove` bit(1) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_client_details`
--

LOCK TABLES `oauth_client_details` WRITE;
/*!40000 ALTER TABLE `oauth_client_details` DISABLE KEYS */;
INSERT INTO `oauth_client_details` VALUES ('community-app',NULL,'123','all','password,refresh_token',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `oauth_client_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_token`
--

DROP TABLE IF EXISTS `oauth_refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_refresh_token` (
  `token_id` varchar(256) DEFAULT NULL,
  `token` blob,
  `authentication` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_token`
--

LOCK TABLES `oauth_refresh_token` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ppi_likelihoods`
--

DROP TABLE IF EXISTS `ppi_likelihoods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppi_likelihoods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ppi_likelihoods`
--

LOCK TABLES `ppi_likelihoods` WRITE;
/*!40000 ALTER TABLE `ppi_likelihoods` DISABLE KEYS */;
/*!40000 ALTER TABLE `ppi_likelihoods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ppi_likelihoods_ppi`
--

DROP TABLE IF EXISTS `ppi_likelihoods_ppi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppi_likelihoods_ppi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `likelihood_id` bigint(20) NOT NULL,
  `ppi_name` varchar(250) NOT NULL,
  `enabled` int(11) NOT NULL DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ppi_likelihoods_ppi`
--

LOCK TABLES `ppi_likelihoods_ppi` WRITE;
/*!40000 ALTER TABLE `ppi_likelihoods_ppi` DISABLE KEYS */;
/*!40000 ALTER TABLE `ppi_likelihoods_ppi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ppi_scores`
--

DROP TABLE IF EXISTS `ppi_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppi_scores` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `score_from` int(11) NOT NULL,
  `score_to` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ppi_scores`
--

LOCK TABLES `ppi_scores` WRITE;
/*!40000 ALTER TABLE `ppi_scores` DISABLE KEYS */;
INSERT INTO `ppi_scores` VALUES (1,0,4),(2,5,9),(3,10,14),(4,15,19),(5,20,24),(6,25,29),(7,30,34),(8,35,39),(9,40,44),(10,45,49),(11,50,54),(12,55,59),(13,60,64),(14,65,69),(15,70,74),(16,75,79),(17,80,84),(18,85,89),(19,90,94),(20,95,100);
/*!40000 ALTER TABLE `ppi_scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `r_enum_value`
--

DROP TABLE IF EXISTS `r_enum_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `r_enum_value` (
  `enum_name` varchar(100) NOT NULL,
  `enum_id` int(11) NOT NULL,
  `enum_message_property` varchar(100) NOT NULL,
  `enum_value` varchar(100) NOT NULL,
  `enum_type` tinyint(1) NOT NULL,
  PRIMARY KEY (`enum_name`,`enum_id`),
  UNIQUE KEY `enum_message_property` (`enum_name`,`enum_message_property`),
  UNIQUE KEY `enum_value` (`enum_name`,`enum_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `r_enum_value`
--

LOCK TABLES `r_enum_value` WRITE;
/*!40000 ALTER TABLE `r_enum_value` DISABLE KEYS */;
INSERT INTO `r_enum_value` VALUES ('account_type_type_enum',0,'INVALID','INVALID',0),('account_type_type_enum',1,'INDIVIDUAL','INDIVIDUAL',0),('account_type_type_enum',2,'GROUP','GROUP',0),('account_type_type_enum',3,'JLG','JLG',0),('accrual_accounts_for_loan_type_enum',1,'FUND_SOURCE','FUND_SOURCE',0),('accrual_accounts_for_loan_type_enum',2,'LOAN_PORTFOLIO','LOAN_PORTFOLIO',0),('accrual_accounts_for_loan_type_enum',3,'INTEREST_ON_LOANS','INTEREST_ON_LOANS',0),('accrual_accounts_for_loan_type_enum',4,'INCOME_FROM_FEES','INCOME_FROM_FEES',0),('accrual_accounts_for_loan_type_enum',5,'INCOME_FROM_PENALTIES','INCOME_FROM_PENALTIES',0),('accrual_accounts_for_loan_type_enum',6,'LOSSES_WRITTEN_OFF','LOSSES_WRITTEN_OFF',0),('accrual_accounts_for_loan_type_enum',7,'INTEREST_RECEIVABLE','INTEREST_RECEIVABLE',0),('accrual_accounts_for_loan_type_enum',8,'FEES_RECEIVABLE','FEES_RECEIVABLE',0),('accrual_accounts_for_loan_type_enum',9,'PENALTIES_RECEIVABLE','PENALTIES_RECEIVABLE',0),('accrual_accounts_for_loan_type_enum',10,'TRANSFERS_SUSPENSE','TRANSFERS_SUSPENSE',0),('accrual_accounts_for_loan_type_enum',11,'OVERPAYMENT','OVERPAYMENT',0),('accrual_accounts_for_loan_type_enum',12,'INCOME_FROM_RECOVERY','INCOME_FROM_RECOVERY',0),('amortization_method_enum',0,'Equal principle payments','Equal principle payments',0),('amortization_method_enum',1,'Equal installments','Equal installments',0),('calendar_type_enum',0,'INVALID','INVALID',0),('calendar_type_enum',1,'CLIENTS','CLIENTS',0),('calendar_type_enum',2,'GROUPS','GROUPS',0),('calendar_type_enum',3,'LOANS','LOANS',0),('calendar_type_enum',4,'CENTERS','CENTERS',0),('calendar_type_enum',5,'SAVINGS','SAVINGS',0),('calendar_type_enum',6,'LOAN_RECALCULATION_REST_DETAIL','LOAN_RECALCULATION_REST_DETAIL',0),('calendar_type_enum',7,'LOAN_RECALCULATION_COMPOUNDING_DETAIL','LOAN_RECALCULATION_COMPOUNDING_DETAIL',0),('cash_accounts_for_loan_type_enum',1,'FUND_SOURCE','FUND_SOURCE',0),('cash_accounts_for_loan_type_enum',2,'LOAN_PORTFOLIO','LOAN_PORTFOLIO',0),('cash_accounts_for_loan_type_enum',3,'INTEREST_ON_LOANS','INTEREST_ON_LOANS',0),('cash_accounts_for_loan_type_enum',4,'INCOME_FROM_FEES','INCOME_FROM_FEES',0),('cash_accounts_for_loan_type_enum',5,'INCOME_FROM_PENALTIES','INCOME_FROM_PENALTIES',0),('cash_accounts_for_loan_type_enum',6,'LOSSES_WRITTEN_OFF','LOSSES_WRITTEN_OFF',0),('cash_accounts_for_loan_type_enum',10,'TRANSFERS_SUSPENSE','TRANSFERS_SUSPENSE',0),('cash_accounts_for_loan_type_enum',11,'OVERPAYMENT','OVERPAYMENT',0),('cash_accounts_for_loan_type_enum',12,'INCOME_FROM_RECOVERY','INCOME_FROM_RECOVERY',0),('cash_accounts_for_savings_type_enum',1,'SAVINGS_REFERENCE','SAVINGS_REFERENCE',0),('cash_accounts_for_savings_type_enum',2,'SAVINGS_CONTROL','SAVINGS_CONTROL',0),('cash_accounts_for_savings_type_enum',3,'INTEREST_ON_SAVINGS','INTEREST_ON_SAVINGS',0),('cash_accounts_for_savings_type_enum',4,'INCOME_FROM_FEES','INCOME_FROM_FEES',0),('cash_accounts_for_savings_type_enum',5,'INCOME_FROM_PENALTIES','INCOME_FROM_PENALTIES',0),('cash_accounts_for_savings_type_enum',10,'TRANSFERS_SUSPENSE','TRANSFERS_SUSPENSE',0),('cash_accounts_for_savings_type_enum',11,'OVERDRAFT_PORTFOLIO_CONTROL','OVERDRAFT_PORTFOLIO_CONTROL',0),('cash_accounts_for_savings_type_enum',12,'INCOME_FROM_INTEREST','INCOME_FROM_INTEREST',0),('cash_account_for_shares_type_enum',1,'SHARES_REFERENCE','SHARES_REFERENCE',0),('cash_account_for_shares_type_enum',2,'SHARES_SUSPENSE','SHARES_SUSPENSE',0),('cash_account_for_shares_type_enum',3,'INCOME_FROM_FEES','INCOME_FROM_FEES',0),('cash_account_for_shares_type_enum',4,'SHARES_EQUITY','SHARES_EQUITY',0),('client_transaction_type_enum',1,'PAY_CHARGE','PAY_CHARGE',0),('client_transaction_type_enum',2,'WAIVE_CHARGE','WAIVE_CHARGE',0),('entity_account_type_enum',1,'CLIENT','CLIENT',0),('entity_account_type_enum',2,'LOAN','LOAN',0),('entity_account_type_enum',3,'SAVINGS','SAVINGS',0),('entity_account_type_enum',4,'CENTER','CENTER',0),('entity_account_type_enum',5,'GROUP','GROUP',0),('entity_account_type_enum',6,'SHARES','SHARES',0),('financial_activity_type_enum',100,'ASSET_TRANSFER','ASSET_TRANSFER',0),('financial_activity_type_enum',101,'CASH_AT_MAINVAULT','CASH_AT_MAINVAULT',0),('financial_activity_type_enum',102,'CASH_AT_TELLER','CASH_AT_TELLER',0),('financial_activity_type_enum',103,'ASSET_FUND_SOURCE','ASSET_FUND_SOURCE',0),('financial_activity_type_enum',200,'LIABILITY_TRANSFER','LIABILITY_TRANSFER',0),('financial_activity_type_enum',201,'PAYABLE_DIVIDENDS','PAYABLE_DIVIDENDS',0),('financial_activity_type_enum',300,'OPENING_BALANCES_TRANSFER_CONTRA','OPENING_BALANCES_TRANSFER_CONTRA',0),('glaccount_type_enum',1,'ASSET','ASSET',0),('glaccount_type_enum',2,'LIABILITY','LIABILITY',0),('glaccount_type_enum',3,'EQUITY','EQUITY',0),('glaccount_type_enum',4,'INCOME','INCOME',0),('glaccount_type_enum',5,'EXPENSE','EXPENSE',0),('interest_calculated_in_period_enum',0,'Daily','Daily',0),('interest_calculated_in_period_enum',1,'Same as repayment period','Same as repayment period',0),('interest_method_enum',0,'Declining Balance','Declining Balance',0),('interest_method_enum',1,'Flat','Flat',0),('interest_period_frequency_enum',2,'Per month','Per month',0),('interest_period_frequency_enum',3,'Per year','Per year',0),('journal_entry_type_type_enum',1,'CREDIT','CREDIT',0),('journal_entry_type_type_enum',2,'DEBIT','DEBIT',0),('loan_status_id',0,'Invalid','Invalid',0),('loan_status_id',100,'Submitted and awaiting approval','Submitted and awaiting approval',0),('loan_status_id',200,'Approved','Approved',0),('loan_status_id',300,'Active','Active',0),('loan_status_id',400,'Withdrawn by client','Withdrawn by client',0),('loan_status_id',500,'Rejected','Rejected',0),('loan_status_id',600,'Closed','Closed',0),('loan_status_id',601,'Written-Off','Written-Off',0),('loan_status_id',602,'Rescheduled','Rescheduled',0),('loan_status_id',700,'Overpaid','Overpaid',0),('loan_transaction_strategy_id',1,'mifos-standard-strategy','Mifos style',0),('loan_transaction_strategy_id',2,'heavensfamily-strategy','Heavensfamily',0),('loan_transaction_strategy_id',3,'creocore-strategy','Creocore',0),('loan_transaction_strategy_id',4,'rbi-india-strategy','RBI (India)',0),('loan_transaction_type_enum',0,'INVALID','INVALID',0),('loan_transaction_type_enum',1,'DISBURSEMENT','DISBURSEMENT',0),('loan_transaction_type_enum',2,'REPAYMENT','REPAYMENT',0),('loan_transaction_type_enum',3,'CONTRA','CONTRA',0),('loan_transaction_type_enum',4,'WAIVE_INTEREST','WAIVE_INTEREST',0),('loan_transaction_type_enum',5,'REPAYMENT_AT_DISBURSEMENT','REPAYMENT_AT_DISBURSEMENT',0),('loan_transaction_type_enum',6,'WRITEOFF','WRITEOFF',0),('loan_transaction_type_enum',7,'MARKED_FOR_RESCHEDULING','MARKED_FOR_RESCHEDULING',0),('loan_transaction_type_enum',8,'RECOVERY_REPAYMENT','RECOVERY_REPAYMENT',0),('loan_transaction_type_enum',9,'WAIVE_CHARGES','WAIVE_CHARGES',0),('loan_transaction_type_enum',10,'ACCRUAL','ACCRUAL',0),('loan_transaction_type_enum',12,'INITIATE_TRANSFER','INITIATE_TRANSFER',0),('loan_transaction_type_enum',13,'APPROVE_TRANSFER','APPROVE_TRANSFER',0),('loan_transaction_type_enum',14,'WITHDRAW_TRANSFER','WITHDRAW_TRANSFER',0),('loan_transaction_type_enum',15,'REJECT_TRANSFER','REJECT_TRANSFER',0),('loan_transaction_type_enum',16,'REFUND','REFUND',0),('loan_transaction_type_enum',17,'CHARGE_PAYMENT','CHARGE_PAYMENT',0),('loan_transaction_type_enum',18,'REFUND_FOR_ACTIVE_LOAN','REFUND_FOR_ACTIVE_LOAN',0),('loan_transaction_type_enum',19,'INCOME_POSTING','INCOME_POSTING',0),('loan_type_enum',1,'Individual Loan','Individual Loan',0),('loan_type_enum',2,'Group Loan','Group Loan',0),('portfolio_account_type_enum',1,'LOAN','LOAN',0),('portfolio_account_type_enum',2,'SAVING','EXPENSE',0),('portfolio_account_type_enum',3,'PROVISIONING','PROVISIONING',0),('portfolio_account_type_enum',4,'SHARES','SHARES',0),('processing_result_enum',0,'invalid','Invalid',0),('processing_result_enum',1,'processed','Processed',0),('processing_result_enum',2,'awaiting.approval','Awaiting Approval',0),('processing_result_enum',3,'rejected','Rejected',0),('repayment_period_frequency_enum',0,'Days','Days',0),('repayment_period_frequency_enum',1,'Weeks','Weeks',0),('repayment_period_frequency_enum',2,'Months','Months',0),('savings_transaction_type_enum',0,'INVALID','INVALID',0),('savings_transaction_type_enum',1,'deposit','deposit',0),('savings_transaction_type_enum',2,'withdrawal','withdrawal',1),('savings_transaction_type_enum',3,'Interest Posting','Interest Posting',0),('savings_transaction_type_enum',4,'Withdrawal Fee','Withdrawal Fee',1),('savings_transaction_type_enum',5,'Annual Fee','Annual Fee',1),('savings_transaction_type_enum',6,'Waive Charge','Waive Charge',0),('savings_transaction_type_enum',7,'Pay Charge','Pay Charge',1),('savings_transaction_type_enum',8,'DIVIDEND_PAYOUT','DIVIDEND_PAYOUT',0),('savings_transaction_type_enum',12,'Initiate Transfer','Initiate Transfer',0),('savings_transaction_type_enum',13,'Approve Transfer','Approve Transfer',0),('savings_transaction_type_enum',14,'Withdraw Transfer','Withdraw Transfer',0),('savings_transaction_type_enum',15,'Reject Transfer','Reject Transfer',0),('savings_transaction_type_enum',16,'Written-Off','Written-Off',0),('savings_transaction_type_enum',17,'Overdraft Interest','Overdraft Interest',0),('savings_transaction_type_enum',19,'WITHHOLD_TAX','WITHHOLD_TAX',0),('status_enum',0,'Invalid','Invalid',0),('status_enum',100,'Pending','Pending',0),('status_enum',300,'Active','Active',0),('status_enum',600,'Closed','Closed',0),('teller_status',300,'Active','Active',0),('teller_status',400,'Inactive','Inactive',0),('teller_status',600,'Closed','Closed',0),('term_period_frequency_enum',0,'Days','Days',0),('term_period_frequency_enum',1,'Weeks','Weeks',0),('term_period_frequency_enum',2,'Months','Months',0),('term_period_frequency_enum',3,'Years','Years',0),('transaction_type_enum',1,'Disbursement','Disbursement',0),('transaction_type_enum',2,'Repayment','Repayment',0),('transaction_type_enum',3,'Contra','Contra',0),('transaction_type_enum',4,'Waive Interest','Waive Interest',0),('transaction_type_enum',5,'Repayment At Disbursement','Repayment At Disbursement',0),('transaction_type_enum',6,'Write-Off','Write-Off',0),('transaction_type_enum',7,'Marked for Rescheduling','Marked for Rescheduling',0),('transaction_type_enum',8,'Recovery Repayment','Recovery Repayment',0),('transaction_type_enum',9,'Waive Charges','Waive Charges',0),('transaction_type_enum',10,'Apply Charges','Apply Charges',0),('transaction_type_enum',11,'Apply Interest','Apply Interest',0);
/*!40000 ALTER TABLE `r_enum_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_loan_transaction_processing_strategy`
--

DROP TABLE IF EXISTS `ref_loan_transaction_processing_strategy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ref_loan_transaction_processing_strategy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sort_order` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ltp_strategy_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_loan_transaction_processing_strategy`
--

LOCK TABLES `ref_loan_transaction_processing_strategy` WRITE;
/*!40000 ALTER TABLE `ref_loan_transaction_processing_strategy` DISABLE KEYS */;
INSERT INTO `ref_loan_transaction_processing_strategy` VALUES (1,'mifos-standard-strategy','Penalties, Fees, Interest, Principal order',1),(2,'heavensfamily-strategy','HeavensFamily Unique',6),(3,'creocore-strategy','Creocore Unique',7),(4,'rbi-india-strategy','Overdue/Due Fee/Int,Principal',2),(5,'principal-interest-penalties-fees-order-strategy','Principal, Interest, Penalties, Fees Order',3),(6,'interest-principal-penalties-fees-order-strategy','Interest, Principal, Penalties, Fees Order',4),(7,'early-repayment-strategy','Early Repayment Strategy',5);
/*!40000 ALTER TABLE `ref_loan_transaction_processing_strategy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request_audit_table`
--

DROP TABLE IF EXISTS `request_audit_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request_audit_table` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lastname` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `mobile_number` varchar(50) DEFAULT NULL,
  `firstname` varchar(100) NOT NULL,
  `authentication_token` varchar(100) DEFAULT NULL,
  `password` varchar(250) NOT NULL,
  `email` varchar(100) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  `created_date` date NOT NULL,
  `account_number` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1_request_audit_table_m_client` (`client_id`),
  CONSTRAINT `FK1_request_audit_table_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request_audit_table`
--

LOCK TABLES `request_audit_table` WRITE;
/*!40000 ALTER TABLE `request_audit_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `request_audit_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rpt_sequence`
--

DROP TABLE IF EXISTS `rpt_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rpt_sequence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rpt_sequence`
--

LOCK TABLES `rpt_sequence` WRITE;
/*!40000 ALTER TABLE `rpt_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `rpt_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_email_campaign`
--

DROP TABLE IF EXISTS `scheduled_email_campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduled_email_campaign` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `campaign_name` varchar(100) NOT NULL,
  `campaign_type` int(11) NOT NULL,
  `businessRule_id` int(11) NOT NULL,
  `param_value` text,
  `status_enum` int(11) NOT NULL,
  `email_subject` varchar(100) NOT NULL,
  `email_message` text NOT NULL,
  `email_attachment_file_format` varchar(10) NOT NULL,
  `stretchy_report_id` int(11) NOT NULL,
  `stretchy_report_param_map` text,
  `closedon_date` date DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `submittedon_date` date DEFAULT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `approvedon_date` date DEFAULT NULL,
  `approvedon_userid` bigint(20) DEFAULT NULL,
  `recurrence` varchar(100) DEFAULT NULL,
  `next_trigger_date` datetime DEFAULT NULL,
  `last_trigger_date` datetime DEFAULT NULL,
  `recurrence_start_date` datetime DEFAULT NULL,
  `is_visible` tinyint(1) DEFAULT '1',
  `previous_run_error_log` text,
  `previous_run_error_message` text,
  PRIMARY KEY (`id`),
  KEY `scheduled_email_campaign_ibfk_1` (`stretchy_report_id`),
  CONSTRAINT `scheduled_email_campaign_ibfk_1` FOREIGN KEY (`stretchy_report_id`) REFERENCES `stretchy_report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_email_campaign`
--

LOCK TABLES `scheduled_email_campaign` WRITE;
/*!40000 ALTER TABLE `scheduled_email_campaign` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduled_email_campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_email_configuration`
--

DROP TABLE IF EXISTS `scheduled_email_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduled_email_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_email_configuration`
--

LOCK TABLES `scheduled_email_configuration` WRITE;
/*!40000 ALTER TABLE `scheduled_email_configuration` DISABLE KEYS */;
INSERT INTO `scheduled_email_configuration` VALUES (1,'SMTP_SERVER',NULL),(2,'SMTP_PORT',NULL),(3,'SMTP_USERNAME',NULL),(4,'SMTP_PASSWORD',NULL);
/*!40000 ALTER TABLE `scheduled_email_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_email_messages_outbound`
--

DROP TABLE IF EXISTS `scheduled_email_messages_outbound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduled_email_messages_outbound` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `email_campaign_id` bigint(20) DEFAULT NULL,
  `status_enum` int(5) NOT NULL DEFAULT '100',
  `email_address` varchar(50) NOT NULL,
  `email_subject` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `campaign_name` varchar(200) DEFAULT NULL,
  `submittedon_date` date DEFAULT NULL,
  `error_message` text,
  PRIMARY KEY (`id`),
  KEY `SEFKGROUP000000001` (`group_id`),
  KEY `SEFKCLIENT00000001` (`client_id`),
  KEY `SEFKSTAFF000000001` (`staff_id`),
  KEY `fk_schedule_email_campign1` (`email_campaign_id`),
  CONSTRAINT `SEFKCLIENT00000001` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `SEFKGROUP000000001` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `SEFKSTAFF000000001` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`),
  CONSTRAINT `fk_schedule_email_campign1` FOREIGN KEY (`email_campaign_id`) REFERENCES `scheduled_email_campaign` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_email_messages_outbound`
--

LOCK TABLES `scheduled_email_messages_outbound` WRITE;
/*!40000 ALTER TABLE `scheduled_email_messages_outbound` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduled_email_messages_outbound` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_detail`
--

DROP TABLE IF EXISTS `scheduler_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_detail` (
  `id` smallint(2) NOT NULL AUTO_INCREMENT,
  `is_suspended` tinyint(1) NOT NULL DEFAULT '0',
  `execute_misfired_jobs` tinyint(1) NOT NULL DEFAULT '1',
  `reset_scheduler_on_bootup` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_detail`
--

LOCK TABLES `scheduler_detail` WRITE;
/*!40000 ALTER TABLE `scheduler_detail` DISABLE KEYS */;
INSERT INTO `scheduler_detail` VALUES (1,0,1,1);
/*!40000 ALTER TABLE `scheduler_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_version`
--

DROP TABLE IF EXISTS `schema_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_version` (
  `version_rank` int(11) NOT NULL,
  `installed_rank` int(11) NOT NULL,
  `version` varchar(50) NOT NULL,
  `description` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `script` varchar(1000) NOT NULL,
  `checksum` int(11) DEFAULT NULL,
  `installed_by` varchar(100) NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`version`),
  KEY `schema_version_vr_idx` (`version_rank`),
  KEY `schema_version_ir_idx` (`installed_rank`),
  KEY `schema_version_s_idx` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_version`
--

LOCK TABLES `schema_version` WRITE;
/*!40000 ALTER TABLE `schema_version` DISABLE KEYS */;
INSERT INTO `schema_version` VALUES (1,1,'1','mifosplatform-core-ddl-latest','SQL','V1__mifosplatform-core-ddl-latest.sql',-1243364190,'root','2018-04-16 11:50:20',1177,1),(10,10,'10','interest-posting-fields-for-savings','SQL','V10__interest-posting-fields-for-savings.sql',79717272,'root','2018-04-16 11:50:21',66,1),(100,100,'100','Group saving summary report','SQL','V100__Group_saving_summary_report.sql',-754402574,'root','2018-04-16 11:50:35',5,1),(101,101,'101','add mulitplesof to account transfers table','SQL','V101__add_mulitplesof_to_account_transfers_table.sql',-1862733976,'root','2018-04-16 11:50:35',51,1),(102,102,'102','client attendance tables','SQL','V102__client_attendance_tables.sql',-1564312651,'root','2018-04-16 11:50:35',39,1),(103,103,'103','cluster support for batch jobs','SQL','V103__cluster_support_for_batch_jobs.sql',1111178393,'root','2018-04-16 11:50:35',85,1),(104,104,'104','permissions for transfers','SQL','V104__permissions_for_transfers.sql',-347262213,'root','2018-04-16 11:50:35',6,1),(105,105,'105','track loan transaction against office','SQL','V105__track_loan_transaction_against_office.sql',-2084319791,'root','2018-04-16 11:50:36',583,1),(106,106,'106','more permissions for transfers','SQL','V106__more_permissions_for_transfers.sql',-136119894,'root','2018-04-16 11:50:36',9,1),(107,107,'107','datatable code mappings','SQL','V107__datatable_code_mappings.sql',907861419,'root','2018-04-16 11:50:36',17,1),(108,108,'108','client has transfer office','SQL','V108__client_has_transfer_office.sql',-1299345701,'root','2018-04-16 11:50:36',52,1),(109,109,'109','account transfer withdrawal fee configuration','SQL','V109__account_transfer_withdrawal_fee_configuration.sql',1026122328,'root','2018-04-16 11:50:37',175,1),(11,11,'11','add-payment-details','SQL','V11__add-payment-details.sql',-1900991138,'root','2018-04-16 11:50:22',50,1),(110,110,'110','group center close','SQL','V110__group_center_close.sql',-731961406,'root','2018-04-16 11:50:37',56,1),(111,111,'111','disable constraint approach for datatables by default','SQL','V111__disable_constraint_approach_for_datatables_by_default.sql',570971038,'root','2018-04-16 11:50:37',4,1),(112,112,'111.1','set default transfers in suspense account for existing loan products','SQL','V111_1__set default_transfers_in_suspense_account_for_existing_loan_products.sql',-368844854,'root','2018-04-16 11:50:37',2,1),(113,113,'112','mixreport sql support','SQL','V112__mixreport_sql_support.sql',1955735805,'root','2018-04-16 11:50:37',110,1),(114,114,'113','track savings transaction against office','SQL','V113__track_savings_transaction_against_office.sql',1117484424,'root','2018-04-16 11:50:37',95,1),(115,115,'114','set default transfers in suspense account for existing savings products - Copy','SQL','V114__set_default_transfers_in_suspense_account_for_existing_savings_products - Copy.sql',-1053914103,'root','2018-04-16 11:50:37',2,1),(116,116,'115','permissions for cache api','SQL','V115__permissions_for_cache_api.sql',1454363094,'root','2018-04-16 11:50:38',923,1),(117,117,'116','track currency for journal entries','SQL','V116__track_currency_for_journal_entries.sql',-1392964791,'root','2018-04-16 11:50:39',81,1),(118,118,'117','loan charge from savings','SQL','V117__loan_charge_from_savings.sql',-1454721638,'root','2018-04-16 11:50:39',236,1),(119,119,'118','savings charge','SQL','V118__savings_charge.sql',-2007870881,'root','2018-04-16 11:50:39',236,1),(120,120,'118.1','savings charge patch update','SQL','V118_1__savings_charge_patch_update.sql',813878610,'root','2018-04-16 11:50:40',274,1),(121,121,'118.2','product mapping delete duplicate fund source to account mappings','SQL','V118_2__product_mapping_delete_duplicate_fund_source_to_account_mappings.sql',-1682827795,'root','2018-04-16 11:50:40',2,1),(122,122,'118.3','permissions form propose and accept client transfers','SQL','V118_3__permissions_form_propose_and_accept_client_transfers.sql',-984451311,'root','2018-04-16 11:50:40',44,1),(123,123,'118.4','reset default transfers in suspense account for existing savings products','SQL','V118_4__reset_default_transfers_in_suspense_account_for_existing_savings_products.sql',1253777410,'root','2018-04-16 11:50:40',2,1),(124,124,'118.5','batch job entry for pay savings charge','SQL','V118_5__batch_job_entry_for_pay_savings_charge.sql',1853280559,'root','2018-04-16 11:50:40',5,1),(125,125,'118.6','defaults for income from penalties for savings product','SQL','V118_6__defaults_for_income_from_penalties_for savings_product.sql',-1890547137,'root','2018-04-16 11:50:40',2,1),(126,126,'118.7','move withdrawal annual fee to charges','SQL','V118_7__move_withdrawal_annual_fee_to_charges.sql',1368796487,'root','2018-04-16 11:50:40',101,1),(127,127,'118.8','track overpayments seperately in loan transactions','SQL','V118_8__track_overpayments_seperately_in_loan_transactions.sql',103894334,'root','2018-04-16 11:50:41',31,1),(128,128,'119','add template table','SQL','V119__add_template_table.sql',-432032770,'root','2018-04-16 11:50:41',108,1),(12,12,'12','add external id to couple of tables','SQL','V12__add_external_id_to_couple_of_tables.sql',2145623175,'root','2018-04-16 11:50:22',141,1),(129,129,'120','accounting running balance','SQL','V120__accounting_running_balance.sql',561327556,'root','2018-04-16 11:50:41',279,1),(130,130,'121','accounting running balance for organization','SQL','V121__accounting_running_balance_for_organization.sql',-576778038,'root','2018-04-16 11:50:41',30,1),(131,131,'122','recurring fee support for savings','SQL','V122__recurring_fee_support_for_savings.sql',1042442680,'root','2018-04-16 11:50:41',91,1),(132,132,'123','remove payment mode for savings','SQL','V123__remove_payment_mode_for_savings.sql',469806906,'root','2018-04-16 11:50:41',22,1),(133,133,'124','added min max cap for charges','SQL','V124__added_min_max_cap_for_charges.sql',1878563905,'root','2018-04-16 11:50:42',45,1),(134,134,'125','added column for actual fee amount or percentage','SQL','V125__added_column_for_actual_fee_amount_or_percentage.sql',1201765940,'root','2018-04-16 11:50:42',28,1),(135,135,'126','initial database structure for sms outbound','SQL','V126__initial_database_structure_for_sms_outbound.sql',1161953791,'root','2018-04-16 11:50:42',428,1),(136,136,'127','mobile no fields','SQL','V127__mobile_no_fields.sql',1026994283,'root','2018-04-16 11:50:42',70,1),(137,137,'128','added loan installment charge','SQL','V128__added_loan_installment_charge.sql',1780045777,'root','2018-04-16 11:50:42',17,1),(138,138,'129','client and group timeline','SQL','V129__client_and_group_timeline.sql',1766656680,'root','2018-04-16 11:50:43',91,1),(13,13,'13','add group and client pending configuration','SQL','V13__add_group_and_client_pending_configuration.sql',-192455526,'root','2018-04-16 11:50:22',127,1),(139,139,'130','calendar-history-table','SQL','V130__calendar-history-table.sql',-2132039976,'root','2018-04-16 11:50:43',15,1),(140,140,'131','holiday-status-column-and-permissions','SQL','V131__holiday-status-column-and-permissions.sql',-72373073,'root','2018-04-16 11:50:43',471,1),(141,141,'132','borrower cycle changes','SQL','V132__borrower_cycle_changes.sql',-974707474,'root','2018-04-16 11:50:43',38,1),(142,142,'133','adding payment detail with journal entry','SQL','V133__adding_payment_detail_with_journal_entry.sql',-55582257,'root','2018-04-16 11:50:44',47,1),(143,143,'134','added column value on c configuration','SQL','V134__added_column_value_on_c_configuration.sql',293040383,'root','2018-04-16 11:50:44',69,1),(144,144,'134.1','submitted date updation for clients','SQL','V134_1__submitted_date_updation_for_clients.sql',1748790046,'root','2018-04-16 11:50:44',3,1),(145,145,'134.2','permissions spelling correction','SQL','V134_2__permissions_spelling_correction.sql',-1713075394,'root','2018-04-16 11:50:44',38,1),(146,146,'135','added permission for undo written off','SQL','V135__added_permission_for_undo_written_off.sql',-761587924,'root','2018-04-16 11:50:44',4,1),(147,147,'136.1','update script strechy parameter','SQL','V136_1__update_script_strechy_parameter.sql',-484185,'root','2018-04-16 11:50:44',4,1),(148,148,'137','added is active column in m staff','SQL','V137__added_is_active_column_in_m_staff.sql',1494120188,'root','2018-04-16 11:50:44',30,1),(149,149,'138','add short name for m product loan and m savings product','SQL','V138__add_short_name_for_m_product_loan_and_m_savings_product.sql',1419334573,'root','2018-04-16 11:50:44',129,1),(150,150,'139','default value for is active updated to true in m staff','SQL','V139__default_value_for_is_active_updated_to_true_in_m_staff.sql',1480735386,'root','2018-04-16 11:50:45',38,1),(14,14,'14','rename status id to enum','SQL','V14__rename_status_id_to_enum.sql',-1081945577,'root','2018-04-16 11:50:22',17,1),(151,151,'140','added loan charge status','SQL','V140__added_loan_charge_status.sql',1121535657,'root','2018-04-16 11:50:45',30,1),(152,152,'140.1','added payment detail id in ac gl journal entry','SQL','V140_1__added_payment_detail_id_in_ac_gl_journal_entry.sql',1235438247,'root','2018-04-16 11:50:45',56,1),(153,153,'141','add early repayment strategy','SQL','V141__add_early_repayment_strategy.sql',-227396086,'root','2018-04-16 11:50:45',4,1),(154,154,'142','read savingsaccount charge permission','SQL','V142__read_savingsaccount_charge_permission.sql',299242827,'root','2018-04-16 11:50:45',52,1),(155,155,'143','create journalentry checker permission','SQL','V143__create_journalentry_checker_permission.sql',2044638229,'root','2018-04-16 11:50:45',4,1),(156,156,'144','spelling mistake corrections','SQL','V144__spelling_mistake_corrections.sql',-1509260601,'root','2018-04-16 11:50:45',14,1),(157,157,'145','add force password reset in c configuration','SQL','V145__add_force_password_reset_in_c_configuration.sql',1521898847,'root','2018-04-16 11:50:46',178,1),(158,158,'146','tranche loans','SQL','V146__tranche_loans.sql',1632857244,'root','2018-04-16 11:50:46',124,1),(159,159,'147','tranche loans column name changes','SQL','V147__tranche_loans_column_name_changes.sql',1323481977,'root','2018-04-16 11:50:46',8,1),(160,160,'148','overdraft changes','SQL','V148__overdraft_changes.sql',1203044488,'root','2018-04-16 11:50:46',166,1),(161,161,'149','add created date savings transaction','SQL','V149__add_created_date_savings_transaction.sql',-1126372170,'root','2018-04-16 11:50:46',32,1),(15,15,'15','center permissions','SQL','V15__center_permissions.sql',-397540463,'root','2018-04-16 11:50:22',6,1),(162,162,'150','basic savings report','SQL','V150__basic_savings_report.sql',-1036803254,'root','2018-04-16 11:50:47',101,1),(163,163,'151','add default savings account to client','SQL','V151__add_default_savings_account_to_client.sql',798635423,'root','2018-04-16 11:50:47',51,1),(164,164,'152','added grace for over due','SQL','V152__added_grace_for_over_due.sql',-1916581696,'root','2018-04-16 11:50:47',92,1),(165,165,'153','Insert missed permissions','SQL','V153__Insert_missed_permissions.sql',1408459847,'root','2018-04-16 11:50:47',7,1),(166,166,'154','aging details','SQL','V154__aging_details.sql',-1125432672,'root','2018-04-16 11:50:48',442,1),(167,167,'155','stretchy into pentaho','SQL','V155__stretchy_into_pentaho.sql',-1288576894,'root','2018-04-16 11:50:48',120,1),(168,168,'156','added loan saving txns pentaho','SQL','V156__added_loan_saving_txns_pentaho.sql',1916408309,'root','2018-04-16 11:50:48',11,1),(169,169,'157','overdue charge improvements','SQL','V157__overdue_charge_improvements.sql',1926239015,'root','2018-04-16 11:50:48',44,1),(170,170,'158','dashboard and navigation queries','SQL','V158__dashboard_and_navigation_queries.sql',-1003182169,'root','2018-04-16 11:50:48',16,1),(171,171,'159','add transaction id column m portfolio command source','SQL','V159__add_transaction_id_column_m_portfolio_command_source.sql',1856672381,'root','2018-04-16 11:50:48',51,1),(16,16,'16','drop min max column on loan table','SQL','V16__drop_min_max_column_on_loan_table.sql',1414842463,'root','2018-04-16 11:50:22',62,1),(172,172,'160','standing instruction changes','SQL','V160__standing_instruction_changes.sql',-951720020,'root','2018-04-16 11:50:48',125,1),(173,173,'160.2','Allow nullValue For principal on lonProduct','SQL','V160_2__Allow_nullValue_For_principal_on_lonProduct.sql',1498909616,'root','2018-04-16 11:50:49',40,1),(174,174,'161','added accrual batch job','SQL','V161__added_accrual_batch_job.sql',1530884559,'root','2018-04-16 11:50:49',24,1),(175,175,'162','overdue charge batch job','SQL','V162__overdue_charge_batch_job.sql',-601622307,'root','2018-04-16 11:50:49',4,1),(176,176,'163','added npa for loans','SQL','V163__added_npa_for_loans.sql',4757824,'root','2018-04-16 11:50:49',172,1),(177,177,'164','fd and rd deposit tables','SQL','V164__fd_and_rd_deposit_tables.sql',-2117275016,'root','2018-04-16 11:50:49',287,1),(178,178,'165','added permission for disburse to saving account','SQL','V165__added_permission_for_disburse_to_saving_account.sql',-1245643496,'root','2018-04-16 11:50:50',4,1),(179,179,'166','added deposit amount to product term and preclosure','SQL','V166__added_deposit_amount_to_product_term_and_preclosure.sql',-2019432635,'root','2018-04-16 11:50:50',55,1),(180,180,'167','added columns for writtenOff loans recovered','SQL','V167__added_columns_for_writtenOff_loans_recovered.sql',887814697,'root','2018-04-16 11:50:50',73,1),(181,181,'168','added transfer fixed deposit interest to linked account','SQL','V168__added_transfer_fixed_deposit_interest_to_linked_account.sql',2021698129,'root','2018-04-16 11:50:50',57,1),(182,182,'169','update dashboard reports to core reports use report to false','SQL','V169__update_dashboard_reports_to_core_reports_use_report_to_false.sql',-1082743067,'root','2018-04-16 11:50:50',41,1),(17,17,'17','update stretchy reporting ddl','SQL','V17__update_stretchy_reporting_ddl.sql',436966109,'root','2018-04-16 11:50:23',688,1),(183,183,'170','update deposit accounts maturity details job','SQL','V170__update_deposit_accounts_maturity_details_job.sql',30397538,'root','2018-04-16 11:50:50',3,1),(184,184,'171','added mandatory savings and rd changes','SQL','V171__added_mandatory_savings_and_rd_changes.sql',-218191905,'root','2018-04-16 11:50:51',155,1),(185,185,'172','accounting changes for transfers','SQL','V172__accounting_changes_for_transfers.sql',-1246214897,'root','2018-04-16 11:50:51',21,1),(186,186,'173','ppi','SQL','V173__ppi.sql',1465403384,'root','2018-04-16 11:50:51',136,1),(187,187,'174','remove interest accrual','SQL','V174__remove_interest_accrual.sql',-1593433770,'root','2018-04-16 11:50:51',2,1),(188,188,'175','added incentive interest rates','SQL','V175__added_incentive_interest_rates.sql',-17965975,'root','2018-04-16 11:50:52',320,1),(189,189,'176','updates to financial activity accounts','SQL','V176__updates_to_financial_activity_accounts.sql',103591100,'root','2018-04-16 11:50:52',55,1),(190,190,'177','cleanup for client incentives','SQL','V177__cleanup_for_client_incentives.sql',1070538805,'root','2018-04-16 11:50:52',4,1),(191,191,'178','updates to financial activity accounts pt2','SQL','V178__updates_to_financial_activity_accounts_pt2.sql',1430879501,'root','2018-04-16 11:50:52',9,1),(192,192,'179','updates to action names for maker checker permissions','SQL','V179__updates_to_action_names_for_maker_checker_permissions.sql',871278301,'root','2018-04-16 11:50:52',12,1),(18,18,'18','update stretchy reporting reportSql','SQL','V18__update_stretchy_reporting_reportSql.sql',-520607907,'root','2018-04-16 11:50:23',7,1),(193,193,'180','update report schemas for disbursed vs awaitingdisbursal and groupnamesbystaff','SQL','V180__update_report_schemas_for_disbursed_vs_awaitingdisbursal_and_groupnamesbystaff.sql',-1697108470,'root','2018-04-16 11:50:52',36,1),(194,194,'181','standing instruction logging','SQL','V181__standing_instruction_logging.sql',1151150413,'root','2018-04-16 11:50:52',134,1),(195,195,'182','added min required balance to savings product','SQL','V182__added_min_required_balance_to_savings_product.sql',89955786,'root','2018-04-16 11:50:53',55,1),(196,196,'183','added min balance for interest calculation','SQL','V183__added_min_balance_for_interest_calculation.sql',479667978,'root','2018-04-16 11:50:53',61,1),(197,197,'184','update min required balance for savings product','SQL','V184__update_min_required_balance_for_savings_product.sql',1380290285,'root','2018-04-16 11:50:53',11,1),(198,198,'185','add accrual till date for periodic accrual','SQL','V185__add_accrual_till_date_for_periodic_accrual.sql',2132938814,'root','2018-04-16 11:50:53',57,1),(199,199,'186','added periodic accrual job','SQL','V186__added_periodic_accrual_job.sql',717708357,'root','2018-04-16 11:50:53',4,1),(200,200,'187','added permission to periodic accrual','SQL','V187__added_permission_to_periodic_accrual.sql',-1350750892,'root','2018-04-16 11:50:53',41,1),(201,201,'188','add savingscharge inactivate permissions','SQL','V188__add_savingscharge_inactivate_permissions.sql',-543121447,'root','2018-04-16 11:50:53',62,1),(202,202,'189','m loan interest recalculation tables','SQL','V189__m_loan_interest_recalculation_tables.sql',-1849437648,'root','2018-04-16 11:50:54',113,1),(19,19,'19','report maintenance permissions','SQL','V19__report_maintenance_permissions.sql',-139431294,'root','2018-04-16 11:50:23',11,1),(203,203,'190','add associategroup disassociategroup permissions','SQL','V190__add_associategroup_disassociategroup_permissions.sql',-738284830,'root','2018-04-16 11:50:54',4,1),(204,204,'191','update gl account increase size of name col','SQL','V191__update_gl_account_increase_size_of_name_col.sql',99612865,'root','2018-04-16 11:50:54',29,1),(205,205,'192','interest recalculate job','SQL','V192__interest_recalculate_job.sql',1431072766,'root','2018-04-16 11:50:54',4,1),(206,206,'193','added column joiningDate for staff','SQL','V193__added_column_joiningDate_for_staff.sql',1584808613,'root','2018-04-16 11:50:54',25,1),(207,207,'194','added recalculatedInterestComponent for interest recalculation','SQL','V194__added_recalculatedInterestComponent_for_interest_recalculation.sql',-425206815,'root','2018-04-16 11:50:54',22,1),(208,208,'195','moved rest frequency to product level','SQL','V195__moved_rest_frequency_to_product_level.sql',-250893403,'root','2018-04-16 11:50:54',255,1),(209,209,'196','added loan running balance to transactions','SQL','V196__added_loan_running_balance_to_transactions.sql',-1872675055,'root','2018-04-16 11:50:55',30,1),(210,210,'197','updated loan running balance of transactions','SQL','V197__updated_loan_running_balance_of_transactions.sql',-364666887,'root','2018-04-16 11:50:55',21,1),(211,211,'198','loan rescheduling tables and permissions','SQL','V198__loan_rescheduling_tables_and_permissions.sql',1610194559,'root','2018-04-16 11:50:55',104,1),(212,212,'199','removed extra columns from schedule history','SQL','V199__removed_extra_columns_from_schedule_history.sql',352416187,'root','2018-04-16 11:50:55',25,1),(2,2,'2','mifosx-base-reference-data-utf8','SQL','V2__mifosx-base-reference-data-utf8.sql',802596776,'root','2018-04-16 11:50:20',51,1),(20,20,'20','report maint perms really configuration','SQL','V20__report_maint_perms_really_configuration.sql',-1671252627,'root','2018-04-16 11:50:23',4,1),(213,213,'200','alter savings account for start interest calculation date','SQL','V200__alter_savings_account_for_start_interest_calculation_date.sql',-1953903651,'root','2018-04-16 11:50:55',227,1),(214,214,'201','webhooks','SQL','V201__webhooks.sql',-1336007721,'root','2018-04-16 11:50:56',154,1),(215,215,'202','savings officer history table','SQL','V202__savings_officer_history_table.sql',-1190601063,'root','2018-04-16 11:50:56',18,1),(216,216,'203','added subbmittedDate loantransaction','SQL','V203__added_subbmittedDate_loantransaction.sql',-1720588441,'root','2018-04-16 11:50:56',29,1),(217,217,'204','insert script for charges paid by for accruals','SQL','V204__insert_script_for_charges_paid_by_for_accruals.sql',921311711,'root','2018-04-16 11:50:56',4,1),(218,218,'205','fix for charge and interest waiver with accruals','SQL','V205__fix_for_charge_and_interest_waiver_with_accruals.sql',2064156368,'root','2018-04-16 11:50:56',50,1),(219,219,'206','interest posting configuration','SQL','V206__interest_posting_configuration.sql',1969946491,'root','2018-04-16 11:50:57',388,1),(220,220,'207','min max clients per group','SQL','V207__min_max_clients_per_group.sql',-941684012,'root','2018-04-16 11:50:57',69,1),(221,221,'208','min max clients in group redux','SQL','V208__min_max_clients_in_group_redux.sql',1555975738,'root','2018-04-16 11:50:57',64,1),(222,222,'209','add all report names in m permission table','SQL','V209__add_all_report_names_in_m_permission_table.sql',79899864,'root','2018-04-16 11:50:57',20,1),(21,21,'21','activation-permissions-for-clients','SQL','V21__activation-permissions-for-clients.sql',-1201397355,'root','2018-04-16 11:50:23',40,1),(223,223,'210','track manually adjusted transactions','SQL','V210__track_manually_adjusted_transactions.sql',-314992180,'root','2018-04-16 11:50:57',27,1),(224,224,'211','minimum days between disbursal and first repayment','SQL','V211__minimum_days_between_disbursal_and_first_repayment.sql',-896943661,'root','2018-04-16 11:50:57',29,1),(225,225,'212','add NthDay and DayOfWeek columns loan','SQL','V212__add_NthDay_and_DayOfWeek_columns_loan.sql',-1408877083,'root','2018-04-16 11:50:57',53,1),(226,226,'213','NthDay and DayOfWeek columns should be nullable','SQL','V213__NthDay_and_DayOfWeek_columns_should_be_nullable.sql',-571189232,'root','2018-04-16 11:51:02',4176,1),(227,227,'214','alter table add create SI at disbursement','SQL','V214__alter_table_add_create_SI_at_disbursement.sql',785371501,'root','2018-04-16 11:51:02',66,1),(228,228,'215','guarantee on hold fund changes','SQL','V215__guarantee_on_hold_fund_changes.sql',-491155023,'root','2018-04-16 11:51:02',108,1),(229,229,'216','adding loan proposed amount to loan','SQL','V216__adding_loan_proposed_amount_to_loan.sql',1664104750,'root','2018-04-16 11:51:02',63,1),(230,230,'217','client substatus and codevalue description','SQL','V217__client_substatus_and_codevalue_description.sql',1701078555,'root','2018-04-16 11:51:03',187,1),(231,231,'218','add user and datetime for loan savings transactions','SQL','V218__add_user_and_datetime_for_loan_savings_transactions.sql',811251105,'root','2018-04-16 11:51:03',124,1),(232,232,'219','guarantor on hold fund changes for account','SQL','V219__guarantor_on_hold_fund_changes_for_account.sql',-636439330,'root','2018-04-16 11:51:03',179,1),(22,22,'22','alter-group-for-consistency-add-permissions','SQL','V22__alter-group-for-consistency-add-permissions.sql',1501525144,'root','2018-04-16 11:50:24',96,1),(233,233,'220','account number preferences','SQL','V220__account_number_preferences.sql',498517685,'root','2018-04-16 11:51:03',22,1),(234,234,'221','add version for m savings account','SQL','V221__add_version_for_m_savings_account.sql',-1315329107,'root','2018-04-16 11:51:03',33,1),(235,235,'222','guarantor on hold fund changes for transactions','SQL','V222__guarantor_on_hold_fund_changes_for_transactions.sql',1448959843,'root','2018-04-16 11:51:03',117,1),(236,236,'223','add version for m loan account','SQL','V223__add_version_for_m_loan_account.sql',1110042443,'root','2018-04-16 11:51:04',140,1),(237,237,'224','client lifecycle adding statuses','SQL','V224__client_lifecycle_adding_statuses.sql',-1260726557,'root','2018-04-16 11:51:04',158,1),(238,238,'225','permissions for updating recurring deposit amount','SQL','V225__permissions_for_updating_recurring_deposit_amount.sql',17824143,'root','2018-04-16 11:51:04',3,1),(239,239,'226','configuration for enforcing calendars for jlg loans','SQL','V226__configuration_for_enforcing_calendars_for_jlg_loans.sql',530541054,'root','2018-04-16 11:51:04',4,1),(240,240,'227','loan-refund-permissions','SQL','V227__loan-refund-permissions.sql',-199541245,'root','2018-04-16 11:51:04',5,1),(241,241,'228','entity to entity access','SQL','V228__entity_to_entity_access.sql',-886972575,'root','2018-04-16 11:51:04',30,1),(242,242,'229','teller cash management','SQL','V229__teller_cash_management.sql',1797536464,'root','2018-04-16 11:51:05',68,1),(23,23,'23','remove-enable-disable-configuration-for-client-group-status','SQL','V23__remove-enable-disable-configuration-for-client-group-status.sql',43458638,'root','2018-04-16 11:50:24',30,1),(243,243,'230','role status and correspoding permissions','SQL','V230__role_status_and_correspoding_permissions.sql',-718483838,'root','2018-04-16 11:51:05',112,1),(244,244,'231','m cashier transaction added currency code','SQL','V231__m_cashier_transaction_added_currency_code.sql',-1646679447,'root','2018-04-16 11:51:05',23,1),(245,245,'232','insert center closure reason','SQL','V232__insert_center_closure_reason.sql',976483171,'root','2018-04-16 11:51:05',3,1),(246,246,'233','Savings Transaction Receipt','SQL','V233__Savings_Transaction_Receipt.sql',904771282,'root','2018-04-16 11:51:05',8,1),(247,247,'234','opening balaces setup','SQL','V234__opening_balaces_setup.sql',640123929,'root','2018-04-16 11:51:05',53,1),(248,248,'235','add ugd template id m hook','SQL','V235__add_ugd_template_id_m_hook.sql',-1268706826,'root','2018-04-16 11:51:05',52,1),(249,249,'236','individual collection sheet permissions','SQL','V236__individual_collection_sheet_permissions.sql',-569636466,'root','2018-04-16 11:51:05',5,1),(250,250,'237','add threshold config for last instalment','SQL','V237__add_threshold_config_for_last_instalment.sql',255818398,'root','2018-04-16 11:51:06',33,1),(251,251,'238','update staff display name length','SQL','V238__update_staff_display_name_length.sql',1942648833,'root','2018-04-16 11:51:06',39,1),(252,252,'239','Loan Transaction Receipt','SQL','V239__Loan_Transaction_Receipt.sql',1892953443,'root','2018-04-16 11:51:06',5,1),(24,24,'24','add-group-client-foreign-key-constraint-in-loan-table','SQL','V24__add-group-client-foreign-key-constraint-in-loan-table.sql',585910999,'root','2018-04-16 11:50:24',77,1),(253,253,'240','arrears aging config for interest recalculation','SQL','V240__arrears_aging_config_for_interest_recalculation.sql',1657223198,'root','2018-04-16 11:51:06',555,1),(254,254,'241','fixed emi changes','SQL','V241__fixed_emi_changes.sql',571693336,'root','2018-04-16 11:51:07',313,1),(255,255,'242','entitytoentitymappingrelation','SQL','V242__entitytoentitymappingrelation.sql',1876771949,'root','2018-04-16 11:51:07',38,1),(256,256,'243','alter loan disbursement details','SQL','V243__alter_loan_disbursement_details.sql',2125791789,'root','2018-04-16 11:51:07',23,1),(257,257,'244','staff assignment history table','SQL','V244__staff_assignment_history_table.sql',285562400,'root','2018-04-16 11:51:07',25,1),(258,258,'245','open rd changes','SQL','V245__open_rd_changes.sql',88342375,'root','2018-04-16 11:51:07',4,1),(259,259,'246','drop group client foreign key from m loan','SQL','V246__drop_group_client_foreign_key_from_m_loan.sql',2066150361,'root','2018-04-16 11:51:08',9,1),(260,260,'247','consistency wrt spelling principalThresholdForLastInstalment','SQL','V247__consistency_wrt_spelling_principalThresholdForLastInstalment.sql',1868904766,'root','2018-04-16 11:51:10',2418,1),(261,261,'248','added password never expired to User','SQL','V248__added_password_never_expired_to_User.sql',-207588405,'root','2018-04-16 11:51:10',89,1),(262,262,'249','workingdays permissions','SQL','V249__workingdays_permissions.sql',845502408,'root','2018-04-16 11:51:10',4,1),(25,25,'25','update client reports for status and activation change','SQL','V25__update_client_reports_for_status_and_activation_change.sql',1872185975,'root','2018-04-16 11:50:24',44,1),(263,263,'250','password validation policy','SQL','V250__password_validation_policy.sql',1858897569,'root','2018-04-16 11:51:10',18,1),(264,264,'251','paymentType table','SQL','V251__paymentType_table.sql',-350734561,'root','2018-04-16 11:51:11',82,1),(265,265,'252','bug fix teller cash management','SQL','V252__bug_fix_teller_cash_management.sql',1224535024,'root','2018-04-16 11:51:11',37,1),(266,266,'253','product loan configurable attributes','SQL','V253__product_loan_configurable_attributes.sql',-1912798616,'root','2018-04-16 11:51:11',21,1),(267,267,'254','General Ledger Report','SQL','V254__General_Ledger_Report.sql',2037924653,'root','2018-04-16 11:51:11',45,1),(268,268,'255','pre close interest period config','SQL','V255__pre_close_interest_period_config.sql',1717451256,'root','2018-04-16 11:51:11',27,1),(269,269,'256','Update script for General Ledger report','SQL','V256__Update script for General_Ledger_report.sql',-1400786952,'root','2018-04-16 11:51:11',7,1),(270,270,'257','staff image association','SQL','V257__staff_image_association.sql',-1702585950,'root','2018-04-16 11:51:12',444,1),(271,271,'258','interest compounding changes','SQL','V258__interest_compounding_changes.sql',-930986140,'root','2018-04-16 11:51:12',43,1),(272,272,'259','alter working days','SQL','V259__alter_working_days.sql',-1436809036,'root','2018-04-16 11:51:12',63,1),(26,26,'26','add-support-for-withdrawal-fees-on-savings','SQL','V26__add-support-for-withdrawal-fees-on-savings.sql',2118474011,'root','2018-04-16 11:50:24',86,1),(273,273,'260','alter password validation policy','SQL','V260__alter_password_validation_policy.sql',-720915497,'root','2018-04-16 11:51:12',75,1),(274,274,'261','Update script for Client Loan Account Schedule Report','SQL','V261__Update script for Client_Loan_Account_Schedule_Report.sql',-1203826809,'root','2018-04-16 11:51:12',4,1),(275,275,'262','accountNumber for groups','SQL','V262__accountNumber_for_groups.sql',-1618907984,'root','2018-04-16 11:51:15',2575,1),(276,276,'263','mifos reports','SQL','V263__mifos_reports.sql',5463425,'root','2018-04-16 11:51:15',16,1),(277,277,'264','insert paymenttype and report read permission','SQL','V264__insert_paymenttype_and_report_read_permission.sql',-878457774,'root','2018-04-16 11:51:15',4,1),(278,278,'265','modify external service schema','SQL','V265__modify_external_service_schema.sql',-2093326987,'root','2018-04-16 11:51:16',507,1),(279,279,'266','client fees','SQL','V266__client_fees.sql',1985527595,'root','2018-04-16 11:51:16',100,1),(280,280,'267','client transaction permissions','SQL','V267__client_transaction_permissions.sql',2102532971,'root','2018-04-16 11:51:16',3,1),(281,281,'268','update gmail password','SQL','V268__update_gmail_password.sql',-1488155404,'root','2018-04-16 11:51:16',4,1),(282,282,'269','increased calendar title length ','SQL','V269__increased_calendar_title_length .sql',2009701575,'root','2018-04-16 11:51:16',46,1),(27,27,'27','add-loan-type-column-to-loan-table','SQL','V27__add-loan-type-column-to-loan-table.sql',687699677,'root','2018-04-16 11:50:24',61,1),(283,283,'270','add rounding mode configuration','SQL','V270__add_rounding_mode_configuration.sql',-1749059384,'root','2018-04-16 11:51:17',83,1),(284,284,'271','accounting for client charges','SQL','V271__accounting_for_client_charges.sql',-504614323,'root','2018-04-16 11:51:20',3417,1),(285,285,'272','loan tranche disbursement charge','SQL','V272__loan_tranche_disbursement_charge.sql',-285159057,'root','2018-04-16 11:51:21',1080,1),(286,286,'273','oauth changes','SQL','V273__oauth_changes.sql',-344895003,'root','2018-04-16 11:51:22',36,1),(287,287,'274','Loan Reschedule Code Value','SQL','V274__Loan_Reschedule_Code_Value.sql',217374783,'root','2018-04-16 11:51:22',3,1),(288,288,'275','loan transaction to repayment schedule mapping','SQL','V275__loan_transaction_to_repayment_schedule_mapping.sql',103630394,'root','2018-04-16 11:51:22',18,1),(289,289,'276','loan recalulated till date','SQL','V276__loan_recalulated_till_date.sql',368993412,'root','2018-04-16 11:51:22',56,1),(290,290,'277','Loan Product Provisioning','SQL','V277__Loan_Product_Provisioning.sql',706445180,'root','2018-04-16 11:51:23',559,1),(291,291,'278','LoanTransactionProcessingStrategy','SQL','V278__LoanTransactionProcessingStrategy.sql',-1455572446,'root','2018-04-16 11:51:23',80,1),(292,292,'279','floating rates','SQL','V279__floating_rates.sql',656913236,'root','2018-04-16 11:51:23',138,1),(28,28,'28','accounting-abstractions-and-autoposting','SQL','V28__accounting-abstractions-and-autoposting.sql',1795480561,'root','2018-04-16 11:50:24',50,1),(293,293,'280','spm framework initial tables','SQL','V280__spm_framework_initial_tables.sql',-2084662630,'root','2018-04-16 11:51:23',96,1),(294,294,'281','add configuration param backdate-penalties','SQL','V281__add_configuration_param_backdate-penalties.sql',-396872379,'root','2018-04-16 11:51:23',3,1),(295,295,'282','CustomerSelfService','SQL','V282__CustomerSelfService.sql',-2032395686,'root','2018-04-16 11:51:24',261,1),(296,296,'283','Variable Installments','SQL','V283__Variable_Installments.sql',886050646,'root','2018-04-16 11:51:24',122,1),(297,297,'284','update codevalue','SQL','V284__update_codevalue.sql',-675349506,'root','2018-04-16 11:51:24',75,1),(298,298,'285','undo last tranche script','SQL','V285__undo_last_tranche_script.sql',-891471969,'root','2018-04-16 11:51:24',4,1),(299,299,'286','partial period interest calcualtion','SQL','V286__partial_period_interest_calcualtion.sql',1621312358,'root','2018-04-16 11:51:24',96,1),(300,300,'287','alter spm scorecard','SQL','V287__alter_spm_scorecard.sql',-729460302,'root','2018-04-16 11:51:24',35,1),(301,301,'288','overdraft interest','SQL','V288__overdraft_interest.sql',1983820448,'root','2018-04-16 11:51:25',59,1),(302,302,'289','client non person','SQL','V289__client_non_person.sql',-2000808984,'root','2018-04-16 11:51:25',79,1),(29,29,'29','add-support-for-annual-fees-on-savings','SQL','V29__add-support-for-annual-fees-on-savings.sql',-2091285116,'root','2018-04-16 11:50:25',94,1),(303,303,'290','shares dividends permissions script','SQL','V290__shares_dividends_permissions_script.sql',1794609838,'root','2018-04-16 11:51:25',4,1),(304,304,'291','organisation start date config','SQL','V291__organisation_start_date_config.sql',163957436,'root','2018-04-16 11:51:25',69,1),(305,305,'292','update organisation start date','SQL','V292__update_organisation_start_date.sql',1186979674,'root','2018-04-16 11:51:25',6,1),(306,306,'293','interest rate chart support for amounts','SQL','V293__interest_rate_chart_support_for_amounts.sql',1403529502,'root','2018-04-16 11:51:25',82,1),(307,307,'294','configuration for paymnettype application forDisbursement charge','SQL','V294__configuration_for_paymnettype_application_forDisbursement_charge.sql',-499755507,'root','2018-04-16 11:51:25',4,1),(308,308,'295','configuration for interest charged date same as disbursal date','SQL','V295__configuration_for_interest_charged_date_same_as_disbursal_date.sql',-1036462051,'root','2018-04-16 11:51:26',9,1),(309,309,'296','skip repayment on first-day of month','SQL','V296__skip_repayment_on first-day_of_month.sql',-831182585,'root','2018-04-16 11:51:26',4,1),(310,310,'297','Adding Meeting Time column','SQL','V297__Adding_Meeting_Time_column.sql',2130113830,'root','2018-04-16 11:51:26',19,1),(311,311,'298','savings interest tax','SQL','V298__savings_interest_tax.sql',1521315509,'root','2018-04-16 11:51:26',280,1),(312,312,'299','share products','SQL','V299__share_products.sql',1965974581,'root','2018-04-16 11:51:27',240,1),(3,3,'3','mifosx-permissions-and-authorisation-utf8','SQL','V3__mifosx-permissions-and-authorisation-utf8.sql',-2068712444,'root','2018-04-16 11:50:20',33,1),(30,30,'30','add-referenceNumber-to-acc gl journal entry','SQL','V30__add-referenceNumber-to-acc_gl_journal_entry.sql',1755375098,'root','2018-04-16 11:50:25',32,1),(313,313,'300','configuration for allow changing of emi amount','SQL','V300__configuration_for_allow_changing_of_emi_amount.sql',-77580122,'root','2018-04-16 11:51:27',36,1),(314,314,'301','recurring moratorium principal periods','SQL','V301__recurring_moratorium_principal_periods.sql',-1417393406,'root','2018-04-16 11:51:27',94,1),(315,315,'302','add status to client identifier','SQL','V302__add_status_to_client_identifier.sql',293526785,'root','2018-04-16 11:51:27',34,1),(316,316,'303','Savings Account Dormancy','SQL','V303__Savings_Account_Dormancy.sql',722055066,'root','2018-04-16 11:51:27',93,1),(317,317,'304','customer self service third party transfers','SQL','V304__customer_self_service_third_party_transfers.sql',-884817516,'root','2018-04-16 11:51:27',23,1),(318,318,'305','compounding and rest frequency nth day freq and insertion script for accrual job','SQL','V305__compounding_and_rest_frequency_nth_day_freq_and_insertion_script_for_accrual_job.sql',77106775,'root','2018-04-16 11:51:28',278,1),(319,319,'306','add domancy tracking job to savings group','SQL','V306__add_domancy_tracking_job_to_savings_group.sql',-1684964164,'root','2018-04-16 11:51:28',7,1),(320,320,'307','add share notes','SQL','V307__add_share_notes.sql',-264448271,'root','2018-04-16 11:51:28',41,1),(321,321,'308','add interest recalculation in savings account','SQL','V308__add_interest_recalculation_in_savings_account.sql',-337873986,'root','2018-04-16 11:51:28',113,1),(322,322,'309','add loan write off reason code','SQL','V309__add_loan_write_off_reason_code.sql',2026829662,'root','2018-04-16 11:51:28',168,1),(31,31,'31','drop-autopostings','SQL','V31__drop-autopostings.sql',499669958,'root','2018-04-16 11:50:25',8,1),(323,323,'310','copy data from entitytoentityaccess to entitytoentitymapping','SQL','V310__copy_data_from_entitytoentityaccess_to_entitytoentitymapping.sql',-1649070300,'root','2018-04-16 11:51:29',4,1),(324,324,'311','foreclosure details','SQL','V311__foreclosure_details.sql',-1065709257,'root','2018-04-16 11:51:29',69,1),(325,325,'312','add is mandatory to code value','SQL','V312__add_is_mandatory_to_code_value.sql',-126173291,'root','2018-04-16 11:51:29',119,1),(326,326,'313','multi rescheduling script','SQL','V313__multi_rescheduling_script.sql',-1366579431,'root','2018-04-16 11:51:29',295,1),(327,327,'314','updating r enum table','SQL','V314__updating_r_enum_table.sql',1732507970,'root','2018-04-16 11:51:30',43,1),(328,328,'315','add sync expected with disbursement date in m product loan','SQL','V315__add_sync_expected_with_disbursement_date_in_m_product_loan.sql',-843455125,'root','2018-04-16 11:51:30',35,1),(329,329,'316','address module tables metadat','SQL','V316__address_module_tables_metadat.sql',-802461604,'root','2018-04-16 11:51:30',66,1),(330,330,'317','report mailing job module','SQL','V317__report_mailing_job_module.sql',-839807922,'root','2018-04-16 11:51:30',61,1),(331,331,'318','topuploan','SQL','V318__topuploan.sql',-2043298172,'root','2018-04-16 11:51:30',240,1),(332,332,'319','client undoreject','SQL','V319__client_undoreject.sql',-2115496427,'root','2018-04-16 11:51:31',66,1),(32,32,'32','associate-disassociate-clients-from-group-permissions','SQL','V32__associate-disassociate-clients-from-group-permissions.sql',-1523966200,'root','2018-04-16 11:50:25',3,1),(333,333,'320','add holiday payment reschedule','SQL','V320__add_holiday_payment_reschedule.sql',2014943609,'root','2018-04-16 11:51:31',66,1),(334,334,'321','boolean field As Interest PostedOn','SQL','V321__boolean_field_As_Interest_PostedOn.sql',-1865452289,'root','2018-04-16 11:51:31',28,1),(335,335,'322','sms campaign','SQL','V322__sms_campaign.sql',325413061,'root','2018-04-16 11:51:31',132,1),(336,336,'322.1','scheduled email campaign','SQL','V322_1__scheduled_email_campaign.sql',2005034399,'root','2018-04-16 11:51:31',321,1),(337,337,'322.2','email business rules','SQL','V322_2__email_business_rules.sql',-1042026609,'root','2018-04-16 11:51:32',6,1),(338,338,'323','spm replace dead fk with exisiting one','SQL','V323__spm_replace_dead_fk_with_exisiting_one.sql',588066913,'root','2018-04-16 11:51:32',33,1),(339,339,'324','datatable checks','SQL','V324__datatable_checks.sql',-1938197720,'root','2018-04-16 11:51:32',24,1),(340,340,'325','add is staff client data','SQL','V325__add_is_staff_client_data.sql',-1873777737,'root','2018-04-16 11:51:32',62,1),(341,341,'326','data migration for client tr gl entries','SQL','V326__data_migration_for_client_tr_gl_entries.sql',955740895,'root','2018-04-16 11:51:32',3,1),(342,342,'327','creditbureau configuration','SQL','V327__creditbureau_configuration.sql',1668840284,'root','2018-04-16 11:51:34',1408,1),(343,343,'328','family members sql support','SQL','V328__family_members_sql_support.sql',-573306316,'root','2018-04-16 11:51:34',31,1),(344,344,'329','sms messages without campaign','SQL','V329__sms_messages_without_campaign.sql',-1105953017,'root','2018-04-16 11:51:34',37,1),(33,33,'33','drop unique check on stretchy report parameter','SQL','V33__drop_unique_check_on_stretchy_report_parameter.sql',-1703958717,'root','2018-04-16 11:50:25',9,1),(345,345,'330','savings account transaction releaseId','SQL','V330__savings_account_transaction_releaseId.sql',955636224,'root','2018-04-16 11:51:34',109,1),(346,346,'331','holiday schema changes','SQL','V331__holiday_schema_changes.sql',115844504,'root','2018-04-16 11:51:34',24,1),(347,347,'332','self service registration schema','SQL','V332__self_service_registration_schema.sql',633744390,'root','2018-04-16 11:51:34',19,1),(348,348,'333','adhocquery','SQL','V333__adhocquery.sql',-1793709676,'root','2018-04-16 11:51:35',29,1),(349,349,'334','notification module tables','SQL','V334__notification_module_tables.sql',2078988506,'root','2018-04-16 11:51:35',64,1),(350,350,'335','self service user role','SQL','V335__self_service_user_role.sql',-1007891545,'root','2018-04-16 11:51:35',7,1),(351,351,'336','sms campaign notification','SQL','V336__sms_campaign_notification.sql',-1618899110,'root','2018-04-16 11:51:35',77,1),(352,352,'337','equal amortization','SQL','V337__equal_amortization.sql',376914729,'root','2018-04-16 11:51:35',107,1),(353,353,'338','two factor authentication','SQL','V338__two_factor_authentication.sql',313249194,'root','2018-04-16 11:51:35',41,1),(354,354,'339','report-run-frequency','SQL','V339__report-run-frequency.sql',711922458,'root','2018-04-16 11:51:36',70,1),(34,34,'34','add unique check on stretchy report parameter','SQL','V34__add_unique_check_on_stretchy_report_parameter.sql',771466793,'root','2018-04-16 11:50:25',161,1),(355,355,'340','nullable-adhoc-email','SQL','V340__nullable-adhoc-email.sql',1937711890,'root','2018-04-16 11:51:36',28,1),(356,356,'341','m import document','SQL','V341__m_import_document.sql',-1267409700,'root','2018-04-16 11:51:36',19,1),(357,357,'342','topic module table','SQL','V342__topic_module_table.sql',-984858634,'root','2018-04-16 11:51:36',42,1),(35,35,'35','add hierarchy column for acc gl account','SQL','V35__add_hierarchy_column_for_acc_gl_account.sql',-507655908,'root','2018-04-16 11:50:25',24,1),(36,36,'36','add tag id column for acc gl account','SQL','V36__add_tag_id_column_for_acc_gl_account.sql',1202085498,'root','2018-04-16 11:50:25',32,1),(37,37,'37','add-center-group-collection-sheet-permissions','SQL','V37__add-center-group-collection-sheet-permissions.sql',1955324939,'root','2018-04-16 11:50:25',5,1),(38,38,'38','add-group-summary-details-report','SQL','V38__add-group-summary-details-report.sql',-1699228726,'root','2018-04-16 11:50:26',6,1),(39,39,'39','payment-channels-updates','SQL','V39__payment-channels-updates.sql',-561424848,'root','2018-04-16 11:50:26',84,1),(4,4,'4','mifosx-core-reports-utf8','SQL','V4__mifosx-core-reports-utf8.sql',-1262708825,'root','2018-04-16 11:50:21',203,1),(40,40,'40','add permissions for accounting rule','SQL','V40__add_permissions_for_accounting_rule.sql',-1703106875,'root','2018-04-16 11:50:26',5,1),(41,41,'41','group-summary-reports','SQL','V41__group-summary-reports.sql',1384609136,'root','2018-04-16 11:50:26',9,1),(42,42,'42','Add default value for id for acc accounting rule','SQL','V42__Add_default_value_for_id_for_acc_accounting_rule.sql',298600221,'root','2018-04-16 11:50:26',36,1),(43,43,'43','accounting-for-savings','SQL','V43__accounting-for-savings.sql',1994927835,'root','2018-04-16 11:50:26',172,1),(44,44,'44','document-increase-size-of-column-type','SQL','V44__document-increase-size-of-column-type.sql',1988036274,'root','2018-04-16 11:50:26',23,1),(45,45,'45','create acc rule tags table','SQL','V45__create_acc_rule_tags_table.sql',-76884353,'root','2018-04-16 11:50:26',21,1),(46,46,'46','extend datatables api','SQL','V46__extend_datatables_api.sql',-1371499241,'root','2018-04-16 11:50:27',4,1),(47,47,'47','staff-hierarchy-link-to-users','SQL','V47__staff-hierarchy-link-to-users.sql',-1745268815,'root','2018-04-16 11:50:27',136,1),(48,48,'48','adding-S3-Support','SQL','V48__adding-S3-Support.sql',-1069415834,'root','2018-04-16 11:50:27',125,1),(49,49,'49','track-loan-charge-payment-transactions','SQL','V49__track-loan-charge-payment-transactions.sql',1658312740,'root','2018-04-16 11:50:27',19,1),(5,5,'5','update-savings-product-and-account-tables','SQL','V5__update-savings-product-and-account-tables.sql',378848888,'root','2018-04-16 11:50:21',56,1),(50,50,'50','add-grace-settings-to-loan-product','SQL','V50__add-grace-settings-to-loan-product.sql',1919481959,'root','2018-04-16 11:50:27',275,1),(51,51,'51','track-additional-details-related-to-installment-performance','SQL','V51__track-additional-details-related-to-installment-performance.sql',508807417,'root','2018-04-16 11:50:28',206,1),(52,52,'52','add boolean support cols to acc accounting rule','SQL','V52__add_boolean_support_cols_to_acc_accounting_rule.sql',-1786009479,'root','2018-04-16 11:50:28',50,1),(53,53,'53','track-advance-and-late-payments-on-installment','SQL','V53__track-advance-and-late-payments-on-installment.sql',156397562,'root','2018-04-16 11:50:28',27,1),(54,54,'54','charge-to-income-account-mappings','SQL','V54__charge-to-income-account-mappings.sql',1497405377,'root','2018-04-16 11:50:28',66,1),(55,55,'55','add-additional-transaction-processing-strategies','SQL','V55__add-additional-transaction-processing-strategies.sql',-460619563,'root','2018-04-16 11:50:28',269,1),(56,56,'56','track-overpaid-amount-on-loans','SQL','V56__track-overpaid-amount-on-loans.sql',382763118,'root','2018-04-16 11:50:29',66,1),(57,57,'57','add default values to debit and credit accounts acc accounting rule','SQL','V57__add_default_values_to_debit_and_credit_accounts_acc_accounting_rule.sql',-1568824194,'root','2018-04-16 11:50:29',34,1),(58,58,'58','create-holiday-tables changed','SQL','V58__create-holiday-tables_changed.sql',-962646632,'root','2018-04-16 11:50:29',35,1),(59,59,'59','add group roles schema and permissions','SQL','V59__add_group_roles_schema_and_permissions.sql',368364301,'root','2018-04-16 11:50:29',28,1),(6,6,'6','add min max principal column to loan','SQL','V6__add_min_max_principal_column_to_loan.sql',70722042,'root','2018-04-16 11:50:21',84,1),(60,60,'60','quipo dashboard reports','SQL','V60__quipo_dashboard_reports.sql',2046253614,'root','2018-04-16 11:50:29',30,1),(61,61,'61','txn running balance example','SQL','V61__txn_running_balance_example.sql',-450363348,'root','2018-04-16 11:50:29',11,1),(62,62,'62','add staff id to m client changed','SQL','V62__add_staff_id_to_m_client_changed.sql',1164419989,'root','2018-04-16 11:50:29',43,1),(63,63,'63','add sync disbursement with meeting column to loan','SQL','V63__add_sync_disbursement_with_meeting_column_to_loan.sql',-947659725,'root','2018-04-16 11:50:29',183,1),(64,64,'64','add permission for assign staff','SQL','V64__add_permission_for_assign_staff.sql',-1794585739,'root','2018-04-16 11:50:30',4,1),(65,65,'65','fix rupee symbol issues','SQL','V65__fix_rupee_symbol_issues.sql',-1194352396,'root','2018-04-16 11:50:30',4,1),(66,66,'66','client close functionality','SQL','V66__client_close_functionality.sql',1532902384,'root','2018-04-16 11:50:30',44,1),(67,67,'67','loans in advance table','SQL','V67__loans_in_advance_table.sql',300209608,'root','2018-04-16 11:50:30',14,1),(68,68,'68','quipo dashboard reports updated','SQL','V68__quipo_dashboard_reports_updated.sql',-1147318254,'root','2018-04-16 11:50:30',38,1),(69,69,'69','loans in advance initialise','SQL','V69__loans_in_advance_initialise.sql',-2069978996,'root','2018-04-16 11:50:30',16,1),(7,7,'7','remove read makerchecker permission','SQL','V7__remove_read_makerchecker_permission.sql',-326347048,'root','2018-04-16 11:50:21',41,1),(70,70,'70','quipo program detail query fix','SQL','V70__quipo_program_detail_query_fix.sql',-1017138863,'root','2018-04-16 11:50:30',41,1),(71,71,'71','insert reschedule repayment to configuration','SQL','V71__insert_reschedule_repayment_to_configuration.sql',-11153805,'root','2018-04-16 11:50:30',4,1),(72,72,'72','add m loan counter changes','SQL','V72__add_m_loan_counter_changes.sql',204127945,'root','2018-04-16 11:50:30',148,1),(73,73,'73','add repayments rescheduled to and processed column to holiday','SQL','V73__add_repayments_rescheduled_to_and_processed_column_to_holiday.sql',1638728810,'root','2018-04-16 11:50:31',57,1),(74,74,'74','alter m loan counter table add group','SQL','V74__alter_m_loan_counter_table_add_group.sql',-1938854244,'root','2018-04-16 11:50:31',71,1),(75,75,'75','add reschedule-repayments-on-holidays to configuration','SQL','V75__add_reschedule-repayments-on-holidays_to_configuration.sql',-2118763844,'root','2018-04-16 11:50:31',4,1),(76,76,'76','rename permission grouping','SQL','V76__rename_permission_grouping.sql',-53740793,'root','2018-04-16 11:50:31',10,1),(77,77,'77','alter m product loan changes','SQL','V77__alter_m_product_loan_changes.sql',-1791822757,'root','2018-04-16 11:50:31',35,1),(78,78,'78','breakdown portfolio grouping','SQL','V78__breakdown_portfolio_grouping.sql',-1667180527,'root','2018-04-16 11:50:31',6,1),(79,79,'79','schedule jobs tables','SQL','V79__schedule_jobs_tables.sql',-803375537,'root','2018-04-16 11:50:31',37,1),(8,8,'8','deposit-transaction-permissions-if-they-exist','SQL','V8__deposit-transaction-permissions-if-they-exist.sql',1336264325,'root','2018-04-16 11:50:21',2,1),(80,80,'80','schedule jobs tables updates','SQL','V80__schedule_jobs_tables_updates.sql',743488132,'root','2018-04-16 11:50:32',173,1),(81,81,'81','savings related changes','SQL','V81__savings_related_changes.sql',570043414,'root','2018-04-16 11:50:32',186,1),(82,82,'82','schedule jobs tables updates for running status','SQL','V82__schedule_jobs_tables_updates_for_running_status.sql',333776790,'root','2018-04-16 11:50:32',92,1),(83,83,'83','non-working-days-table','SQL','V83__non-working-days-table.sql',1562001980,'root','2018-04-16 11:50:32',16,1),(84,84,'84','undo savings transaction permission','SQL','V84__undo_savings_transaction_permission.sql',-1532397221,'root','2018-04-16 11:50:32',4,1),(85,85,'85','product mix related changes','SQL','V85__product_mix_related_changes.sql',650997088,'root','2018-04-16 11:50:32',68,1),(86,86,'86','update-working-days','SQL','V86__update-working-days.sql',1454599851,'root','2018-04-16 11:50:33',161,1),(87,87,'87','add permission for scheduler','SQL','V87__add_permission_for_scheduler.sql',-143804840,'root','2018-04-16 11:50:33',39,1),(88,88,'88','added update constrain for scheduler jobs','SQL','V88__added_update_constrain_for_scheduler_jobs.sql',-1721849104,'root','2018-04-16 11:50:33',65,1),(89,89,'89','added scheduler group','SQL','V89__added_scheduler_group.sql',870811111,'root','2018-04-16 11:50:33',59,1),(9,9,'9','add min max constraint column to loan loanproduct','SQL','V9__add_min_max_constraint_column_to_loan_loanproduct.sql',1914461568,'root','2018-04-16 11:50:21',218,1),(90,90,'90','client performance history reports','SQL','V90__client_performance_history_reports.sql',1930320723,'root','2018-04-16 11:50:33',5,1),(91,91,'91','apply annual fees permission','SQL','V91__apply_annual_fees_permission.sql',1903694379,'root','2018-04-16 11:50:33',4,1),(92,92,'91.1','configuration settings for holiday and non workingday','SQL','V91_1__configuration_settings_for_holiday_and_non_workingday.sql',550696268,'root','2018-04-16 11:50:33',5,1),(93,93,'92','group center assign staff permission','SQL','V92__group_center_assign_staff_permission.sql',-1720945560,'root','2018-04-16 11:50:33',4,1),(94,94,'93','loan transaction external id','SQL','V93__loan_transaction_external_id.sql',1883193852,'root','2018-04-16 11:50:34',220,1),(95,95,'94','added savings accont type','SQL','V94__added_savings_accont type.sql',900679016,'root','2018-04-16 11:50:34',30,1),(96,96,'95','batch job postInterest','SQL','V95__batch_job_postInterest.sql',1639975057,'root','2018-04-16 11:50:34',4,1),(97,97,'96','savings accounts transfers table','SQL','V96__savings_accounts_transfers_table.sql',670361759,'root','2018-04-16 11:50:34',45,1),(98,98,'97','add permission for adjust savings transaction','SQL','V97__add_permission_for_adjust_savings_transaction.sql',-1776198278,'root','2018-04-16 11:50:34',3,1),(99,99,'98','added currency roundof for multipleof','SQL','V98__added_currency_roundof_for_multipleof.sql',-1419021504,'root','2018-04-16 11:50:35',731,1);
/*!40000 ALTER TABLE `schema_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_campaign`
--

DROP TABLE IF EXISTS `sms_campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_campaign` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `campaign_name` varchar(100) NOT NULL,
  `campaign_type` int(11) NOT NULL,
  `campaign_trigger_type` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `provider_id` bigint(20) DEFAULT NULL,
  `param_value` text,
  `status_enum` int(11) NOT NULL,
  `message` text NOT NULL,
  `submittedon_date` date DEFAULT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `approvedon_date` date DEFAULT NULL,
  `approvedon_userid` bigint(20) DEFAULT NULL,
  `closedon_date` date DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `recurrence` varchar(100) DEFAULT NULL,
  `next_trigger_date` datetime DEFAULT NULL,
  `last_trigger_date` datetime DEFAULT NULL,
  `recurrence_start_date` datetime DEFAULT NULL,
  `is_visible` tinyint(1) DEFAULT '1',
  `is_notification` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`),
  CONSTRAINT `sms_campaign_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `stretchy_report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_campaign`
--

LOCK TABLES `sms_campaign` WRITE;
/*!40000 ALTER TABLE `sms_campaign` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_messages_outbound`
--

DROP TABLE IF EXISTS `sms_messages_outbound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_messages_outbound` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `status_enum` int(5) NOT NULL DEFAULT '100',
  `mobile_no` varchar(50) DEFAULT NULL,
  `message` varchar(1000) NOT NULL,
  `campaign_id` bigint(20) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `submittedon_date` date DEFAULT NULL,
  `delivered_on_date` datetime DEFAULT NULL,
  `is_notification` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FKGROUP000000001` (`group_id`),
  KEY `FKCLIENT00000001` (`client_id`),
  KEY `FKSTAFF000000001` (`staff_id`),
  KEY `FKCAMPAIGN00000001` (`campaign_id`),
  CONSTRAINT `FKCAMPAIGN00000001` FOREIGN KEY (`campaign_id`) REFERENCES `sms_campaign` (`id`),
  CONSTRAINT `FKCLIENT00000001` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FKGROUP000000001` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FKSTAFF000000001` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_messages_outbound`
--

LOCK TABLES `sms_messages_outbound` WRITE;
/*!40000 ALTER TABLE `sms_messages_outbound` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_messages_outbound` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stretchy_parameter`
--

DROP TABLE IF EXISTS `stretchy_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stretchy_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parameter_name` varchar(45) NOT NULL,
  `parameter_variable` varchar(45) DEFAULT NULL,
  `parameter_label` varchar(45) NOT NULL,
  `parameter_displayType` varchar(45) NOT NULL,
  `parameter_FormatType` varchar(10) NOT NULL,
  `parameter_default` varchar(45) NOT NULL,
  `special` varchar(1) DEFAULT NULL,
  `selectOne` varchar(1) DEFAULT NULL,
  `selectAll` varchar(1) DEFAULT NULL,
  `parameter_sql` text,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`parameter_name`),
  KEY `fk_stretchy_parameter_001_idx` (`parent_id`),
  CONSTRAINT `fk_stretchy_parameter_001` FOREIGN KEY (`parent_id`) REFERENCES `stretchy_parameter` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1023 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stretchy_parameter`
--

LOCK TABLES `stretchy_parameter` WRITE;
/*!40000 ALTER TABLE `stretchy_parameter` DISABLE KEYS */;
INSERT INTO `stretchy_parameter` VALUES (1,'startDateSelect','startDate','startDate','date','date','today',NULL,NULL,NULL,NULL,NULL),(2,'endDateSelect','endDate','endDate','date','date','today',NULL,NULL,NULL,NULL,NULL),(3,'obligDateTypeSelect','obligDateType','obligDateType','select','number','0',NULL,NULL,NULL,'select * from\r\n(select 1 as id, \"Closed\" as `name` union all\r\nselect 2, \"Disbursal\" ) x\r\norder by x.`id`',NULL),(5,'OfficeIdSelectOne','officeId','Office','select','number','0',NULL,'Y',NULL,'select id, \r\nconcat(substring(\"........................................\", 1, \r\n   \n\n((LENGTH(`hierarchy`) - LENGTH(REPLACE(`hierarchy`, \'.\', \'\')) - 1) * 4)), \r\n   `name`) as tc\r\nfrom m_office\r\nwhere hierarchy like concat\n\n(\'${currentUserHierarchy}\', \'%\')\r\norder by hierarchy',NULL),(6,'loanOfficerIdSelectAll','loanOfficerId','Loan Officer','select','number','0',NULL,NULL,'Y','(select lo.id, lo.display_name as `Name` \r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\njoin m_staff lo on lo.office_id = ounder.id\r\nwhere lo.is_loan_officer = true\r\nand o.id = ${officeId})\r\nunion all\r\n(select -10, \'-\')\r\norder by 2',5),(10,'currencyIdSelectAll','currencyId','Currency','select','number','0',NULL,NULL,'Y','select `code`, `name`\r\nfrom m_organisation_currency\r\norder by `code`',NULL),(20,'fundIdSelectAll','fundId','Fund','select','number','0',NULL,NULL,'Y','(select id, `name`\r\nfrom m_fund)\r\nunion all\r\n(select -10, \'-\')\r\norder by 2',NULL),(25,'loanProductIdSelectAll','loanProductId','Product','select','number','0',NULL,NULL,'Y','select p.id, p.`name`\r\nfrom m_product_loan p\r\nwhere (p.currency_code = \'${currencyId}\' or \'-1\'= \'${currencyId}\')\r\norder by 2',10),(26,'loanPurposeIdSelectAll','loanPurposeId','Loan Purpose','select','number','0',NULL,NULL,'Y','select -10 as id, \'-\' as code_value\r\nunion all\r\nselect * from (select v.id, v.code_value\r\nfrom m_code c\r\njoin m_code_value v on v.code_id = c.id\r\nwhere c.code_name = \"loanPurpose\"\r\norder by v.order_position)  x',NULL),(100,'parTypeSelect','parType','parType','select','number','0',NULL,NULL,NULL,'select * from\r\n(select 1 as id, \"Principal Only\" as `name` union all\r\nselect 2, \"Principal + Interest\" union all\r\nselect 3, \"Principal + Interest + Fees\" union all\r\nselect 4, \"Principal + Interest + Fees + Penalties\") x\r\norder by x.`id`',NULL),(1001,'FullReportList',NULL,'n/a','n/a','n/a','n/a','Y',NULL,NULL,'select  r.id as report_id, r.report_name, r.report_type, r.report_subtype, r.report_category,\nrp.id as parameter_id, rp.report_parameter_name, p.parameter_name\n  from stretchy_report r\n  left join stretchy_report_parameter rp on rp.report_id = r.id \n  left join stretchy_parameter p on p.id = rp.parameter_id\n  where r.use_report is true\n  and exists\n  ( select \'f\'\n  from m_appuser_role ur \n  join m_role r on r.id = ur.role_id\n  join m_role_permission rp on rp.role_id = r.id\n  join m_permission p on p.id = rp.permission_id\n  where ur.appuser_id = ${currentUserId}\n  and (p.code in (\'ALL_FUNCTIONS_READ\', \'ALL_FUNCTIONS\') or p.code = concat(\"READ_\", r.report_name)) )\n  order by r.report_category, r.report_name, rp.id',NULL),(1002,'FullParameterList',NULL,'n/a','n/a','n/a','n/a','Y',NULL,NULL,'select sp.parameter_name, sp.parameter_variable, sp.parameter_label, sp.parameter_displayType, \r sp.parameter_FormatType, sp.parameter_default, sp.selectOne,  sp.selectAll, spp.parameter_name as parentParameterName\r from stretchy_parameter sp\r left join stretchy_parameter spp on spp.id = sp.parent_id\r where sp.special is null\r and exists \r 	(select \'f\' \r 	from stretchy_report sr\r 	join stretchy_report_parameter srp on srp.report_id = sr.id\r 	where sr.report_name in(${reportListing})\r 	and srp.parameter_id = sp.id\r 	)\r order by sp.id',NULL),(1003,'reportCategoryList',NULL,'n/a','n/a','n/a','n/a','Y',NULL,NULL,'select  r.id as report_id, r.report_name, r.report_type, r.report_subtype, r.report_category,\n  rp.id as parameter_id, rp.report_parameter_name, p.parameter_name\n  from stretchy_report r\n  left join stretchy_report_parameter rp on rp.report_id = r.id\n  left join stretchy_parameter p on p.id = rp.parameter_id\n  where r.report_category = \'${reportCategory}\'\n  and r.use_report is true\n  and exists\n  (select \'f\'\n  from m_appuser_role ur \n  join m_role r on r.id = ur.role_id\n  join m_role_permission rp on rp.role_id = r.id\n  join m_permission p on p.id = rp.permission_id\n  where ur.appuser_id = ${currentUserId}\n  and (p.code in (\'ALL_FUNCTIONS_READ\', \'ALL_FUNCTIONS\') or p.code = concat(\"READ_\", r.report_name)) )\n  order by r.report_category, r.report_name, rp.id',NULL),(1004,'selectAccount','accountNo','Enter Account No','text','string','n/a',NULL,NULL,NULL,NULL,NULL),(1005,'savingsProductIdSelectAll','savingsProductId','Product','select','number','0',NULL,NULL,'Y','select p.id, p.`name`\r\nfrom m_savings_product p\r\norder by 2',NULL),(1006,'transactionId','transactionId','transactionId','text','string','n/a',NULL,NULL,NULL,NULL,NULL),(1007,'selectCenterId','centerId','Enter Center Id','text','string','n/a',NULL,NULL,NULL,NULL,NULL),(1008,'SelectGLAccountNO','GLAccountNO','GLAccountNO','select','number','0',NULL,NULL,NULL,'select id aid,name aname\r\nfrom acc_gl_account',NULL),(1009,'asOnDate','asOn','As On','date','date','today',NULL,NULL,NULL,NULL,NULL),(1010,'SavingsAccountSubStatus','subStatus','SavingsAccountDormancyStatus','select','number','100',NULL,NULL,NULL,'select * from\r\n(select 100 as id, \"Inactive\" as name  union all\r\nselect 200 as id, \"Dormant\" as  name union all \r\nselect 300 as id, \"Escheat\" as name) x\r\norder by x.`id`',NULL),(1011,'cycleXSelect','cycleX','Cycle X Number','text','number','n/a',NULL,NULL,NULL,NULL,NULL),(1012,'cycleYSelect','cycleY','Cycle Y Number','text','number','n/a',NULL,NULL,NULL,NULL,NULL),(1013,'fromXSelect','fromX','From X Number','text','number','n/a',NULL,NULL,NULL,NULL,NULL),(1014,'toYSelect','toY','To Y Number','text','number','n/a',NULL,NULL,NULL,NULL,NULL),(1015,'overdueXSelect','overdueX','Overdue X Number','text','number','n/a',NULL,NULL,NULL,NULL,NULL),(1016,'overdueYSelect','overdueY','Overdue Y Number','text','number','n/a',NULL,NULL,NULL,NULL,NULL),(1017,'DefaultLoan','loanId','Loan','none','number','-1',NULL,NULL,'Y','select ml.id \nfrom m_loan ml \nleft join m_client mc on mc.id = ml.client_id \nleft join m_office mo on mo.id = mc.office_id \nwhere mo.id = ${officeId} or ${officeId} = -1',5),(1018,'DefaultClient','clientId','Client','none','number','-1',NULL,NULL,'Y','select mc.id \nfrom m_client mc\n left join m_office on mc.office_id = mo.id\n where mo.id = ${officeId} or ${officeId} = -1',5),(1019,'DefaultGroup','groupId','Group','none','number','-1',NULL,NULL,'Y','select mg.id \nfrom m_group mg\nleft join m_office mo on mg.office_id = mo.id\nwhere mo.id = ${officeId} or ${officeId} = -1',5),(1020,'SelectLoanType','loanType','Loan Type','select','number','-1',NULL,NULL,'Y','select\nenum_id as id,\nenum_value as value\nfrom r_enum_value\nwhere enum_name = \'loan_type_enum\'',NULL),(1021,'DefaultSavings','savingsId','Savings','none','number','-1',NULL,NULL,'Y',NULL,5),(1022,'DefaultSavingsTransactionId','savingsTransactionId','Savings Transaction','none','number','-1',NULL,NULL,'Y',NULL,5);
/*!40000 ALTER TABLE `stretchy_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stretchy_report`
--

DROP TABLE IF EXISTS `stretchy_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stretchy_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_name` varchar(100) NOT NULL,
  `report_type` varchar(20) NOT NULL,
  `report_subtype` varchar(20) DEFAULT NULL,
  `report_category` varchar(45) DEFAULT NULL,
  `report_sql` text,
  `description` text,
  `core_report` tinyint(1) DEFAULT '0',
  `use_report` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `report_name_UNIQUE` (`report_name`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stretchy_report`
--

LOCK TABLES `stretchy_report` WRITE;
/*!40000 ALTER TABLE `stretchy_report` DISABLE KEYS */;
INSERT INTO `stretchy_report` VALUES (1,'Client Listing','Table',NULL,'Client','select\nconcat(repeat(\"..\",\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\n c.account_no as \"Client Account No.\",\nc.display_name as \"Name\",\nr.enum_message_property as \"Status\",\nc.activation_date as \"Activation\", c.external_id as \"External Id\"\nfrom m_office o\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_client c on c.office_id = ounder.id\nleft join r_enum_value r on r.enum_name = \'status_enum\' and r.enum_id = c.status_enum\nwhere o.id = ${officeId}\norder by ounder.hierarchy, c.account_no','Individual Client Report\r\n\r\nLists the small number of defined fields on the client table.  Would expect to copy this \n\nreport and add any \'one to one\' additional data for specific tenant needs.\r\n\r\nCan be run for any size MFI but you\'d expect it only to be run within a branch for \n\nlarger ones.  Depending on how many columns are displayed, there is probably is a limit of about 20/50k clients returned for html display (export to excel doesn\'t \n\nhave that client browser/memory impact).',1,1),(2,'Client Loans Listing','Table',NULL,'Client','select\nconcat(repeat(\"..\",\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\", c.account_no as \"Client Account No.\",\nc.display_name as \"Name\",\nr.enum_message_property as \"Client Status\",\nlo.display_name as \"Loan Officer\", l.account_no as \"Loan Account No.\", l.external_id as \"External Id\", p.name as Loan, st.enum_message_property as \"Status\",\nf.`name` as Fund, purp.code_value as \"Loan Purpose\",\nifnull(cur.display_symbol, l.currency_code) as Currency,\nl.principal_amount, l.arrearstolerance_amount as \"Arrears Tolerance Amount\",\nl.number_of_repayments as \"Expected No. Repayments\",\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\",\nl.nominal_interest_rate_per_period as \"Nominal Interest Rate Per Period\",\nipf.enum_message_property as \"Interest Rate Frequency\",\nim.enum_message_property as \"Interest Method\",\nicp.enum_message_property as \"Interest Calculated in Period\",\nl.term_frequency as \"Term Frequency\",\ntf.enum_message_property as \"Term Frequency Period\",\nl.repay_every as \"Repayment Frequency\",\nrf.enum_message_property as \"Repayment Frequency Period\",\nam.enum_message_property as \"Amortization\",\nl.total_charges_due_at_disbursement_derived as \"Total Charges Due At Disbursement\",\ndate(l.submittedon_date) as Submitted, date(l.approvedon_date) Approved, l.expected_disbursedon_date As \"Expected Disbursal\",\ndate(l.expected_firstrepaymenton_date) as \"Expected First Repayment\",\ndate(l.interest_calculated_from_date) as \"Interest Calculated From\" ,\ndate(l.disbursedon_date) as Disbursed,\ndate(l.expected_maturedon_date) \"Expected Maturity\",\ndate(l.maturedon_date) as \"Matured On\", date(l.closedon_date) as Closed,\ndate(l.rejectedon_date) as Rejected, date(l.rescheduledon_date) as Rescheduled,\ndate(l.withdrawnon_date) as Withdrawn, date(l.writtenoffon_date) \"Written Off\"\nfrom m_office o\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_client c on c.office_id = ounder.id\nleft join r_enum_value r on r.enum_name = \'status_enum\'\n and r.enum_id = c.status_enum\nleft join m_loan l on l.client_id = c.id\nleft join m_staff lo on lo.id = l.loan_officer_id\nleft join m_product_loan p on p.id = l.product_id\nleft join m_fund f on f.id = l.fund_id\nleft join r_enum_value st on st.enum_name = \"loan_status_id\" and st.enum_id = l.loan_status_id\nleft join r_enum_value ipf on ipf.enum_name = \"interest_period_frequency_enum\"\n and ipf.enum_id = l.interest_period_frequency_enum\nleft join r_enum_value im on im.enum_name = \"interest_method_enum\"\n and im.enum_id = l.interest_method_enum\nleft join r_enum_value tf on tf.enum_name = \"term_period_frequency_enum\"\n and tf.enum_id = l.term_period_frequency_enum\nleft join r_enum_value icp on icp.enum_name = \"interest_calculated_in_period_enum\"\n and icp.enum_id = l.interest_calculated_in_period_enum\nleft join r_enum_value rf on rf.enum_name = \"repayment_period_frequency_enum\"\n and rf.enum_id = l.repayment_period_frequency_enum\nleft join r_enum_value am on am.enum_name = \"amortization_method_enum\"\n and am.enum_id = l.amortization_method_enum\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\nleft join m_currency cur on cur.code = l.currency_code\nwhere o.id = ${officeId}\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\norder by ounder.hierarchy, 2 , l.id','Individual Client Report\r\n\r\nPretty \n\nwide report that lists the basic details of client loans.  \r\n\r\nCan be run for any size MFI but you\'d expect it only to be run within a branch for larger ones.  \n\nThere is probably is a limit of about 20/50k clients returned for html display (export to excel doesn\'t have that client browser/memory impact).',1,1),(5,'Loans Awaiting Disbursal','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nc.account_no as \"Client Account No\", c.display_name as \"Name\", l.account_no as \"Loan Account No.\", pl.`name` as \"Product\", \r\nf.`name` as Fund, ifnull(cur.display_symbol, l.currency_code) as Currency,  \r\nl.principal_amount as Principal,  \r\nl.term_frequency as \"Term Frequency\",\n\n\r\ntf.enum_message_property as \"Term Frequency Period\",\r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\",\r\ndate(l.approvedon_date) \"Approved\",\r\ndatediff(l.expected_disbursedon_date, curdate()) as \"Days to Disbursal\",\r\ndate(l.expected_disbursedon_date) \"Expected Disbursal\",\r\npurp.code_value as \"Loan Purpose\",\r\n lo.display_name as \"Loan Officer\"\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nleft join r_enum_value tf on tf.enum_name = \"term_period_frequency_enum\" and tf.enum_id = l.term_period_frequency_enum\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 200\r\norder by ounder.hierarchy, datediff(l.expected_disbursedon_date, curdate()),  c.account_no','Individual Client Report',1,1),(6,'Loans Awaiting Disbursal Summary','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\npl.`name` as \"Product\", \r\nifnull(cur.display_symbol, l.currency_code) as Currency,  f.`name` as Fund,\r\nsum(l.principal_amount) as Principal\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 200\r\ngroup by ounder.hierarchy, pl.`name`, l.currency_code,  f.`name`\r\norder by ounder.hierarchy, pl.`name`, l.currency_code,  f.`name`','Individual Client Report',1,1),(7,'Loans Awaiting Disbursal Summary by Month','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\npl.`name` as \"Product\", \r\nifnull(cur.display_symbol, l.currency_code) as Currency,  \r\nyear(l.expected_disbursedon_date) as \"Year\", \r\nmonthname(l.expected_disbursedon_date) as \"Month\",\r\nsum(l.principal_amount) as Principal\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 200\r\ngroup by ounder.hierarchy, pl.`name`, l.currency_code, year(l.expected_disbursedon_date), month(l.expected_disbursedon_date)\r\norder by ounder.hierarchy, pl.`name`, l.currency_code, year(l.expected_disbursedon_date), month(l.expected_disbursedon_date)','Individual Client Report',1,1),(8,'Loans Pending Approval','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nc.account_no as \"Client Account No.\", c.display_name as \"Client Name\", \r\nifnull(cur.display_symbol, l.currency_code) as Currency,  pl.`name` as \"Product\", \r\nl.account_no as \"Loan Account No.\", \r\nl.principal_amount as \"Loan Amount\", \r\nl.term_frequency as \"Term Frequency\",\n\n\r\ntf.enum_message_property as \"Term Frequency Period\",\r\nl.annual_nominal_interest_rate as \" Annual \n\nNominal Interest Rate\", \r\ndatediff(curdate(), l.submittedon_date) \"Days Pending Approval\", \r\npurp.code_value as \"Loan Purpose\",\r\nlo.display_name as \"Loan Officer\"\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nleft join r_enum_value tf on tf.enum_name = \"term_period_frequency_enum\" and tf.enum_id = l.term_period_frequency_enum\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 100 /*Submitted and awaiting approval */\r\norder by ounder.hierarchy, l.submittedon_date,  l.account_no','Individual Client Report',1,1),(11,'Active Loans - Summary','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(mo.`hierarchy`) - LENGTH(REPLACE(mo.`hierarchy`, \'.\', \'\')) - 1))), mo.`name`) as \"Office/Branch\", x.currency as Currency,\r\n x.client_count as \"No. of Clients\", x.active_loan_count as \"No. Active Loans\", x. loans_in_arrears_count as \"No. of Loans in Arrears\",\r\nx.principal as \"Total Loans Disbursed\", x.principal_repaid as \"Principal Repaid\", x.principal_outstanding as \"Principal Outstanding\", x.principal_overdue as \"Principal Overdue\",\r\nx.interest as \"Total Interest\", x.interest_repaid as \"Interest Repaid\", x.interest_outstanding as \"Interest Outstanding\", x.interest_overdue as \"Interest Overdue\",\r\nx.fees as \"Total Fees\", x.fees_repaid as \"Fees Repaid\", x.fees_outstanding as \"Fees Outstanding\", x.fees_overdue as \"Fees Overdue\",\r\nx.penalties as \"Total Penalties\", x.penalties_repaid as \"Penalties Repaid\", x.penalties_outstanding as \"Penalties Outstanding\", x.penalties_overdue as \"Penalties Overdue\",\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.principal_overdue * 100) / x.principal_outstanding, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue + x.penalties_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding + x.penalties_overdue), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from m_office mo\r\njoin \r\n(select ounder.id as branch,\r\nifnull(cur.display_symbol, l.currency_code) as currency,\r\ncount(distinct(c.id)) as client_count, \r\ncount(distinct(l.id)) as  active_loan_count,\r\ncount(distinct(if(laa.loan_id is not null,  l.id, null)  )) as loans_in_arrears_count,\r\n\r\nsum(l.principal_disbursed_derived) as principal,\r\nsum(l.principal_repaid_derived) as principal_repaid,\r\nsum(l.principal_outstanding_derived) as principal_outstanding,\r\nsum(laa.principal_overdue_derived) as principal_overdue,\r\n\r\nsum(l.interest_charged_derived) as interest,\r\nsum(l.interest_repaid_derived) as interest_repaid,\r\nsum(l.interest_outstanding_derived) as interest_outstanding,\r\nsum(laa.interest_overdue_derived) as interest_overdue,\r\n\r\nsum(l.fee_charges_charged_derived) as fees,\r\nsum(l.fee_charges_repaid_derived) as fees_repaid,\r\nsum(l.fee_charges_outstanding_derived)  as fees_outstanding,\r\nsum(laa.fee_charges_overdue_derived) as fees_overdue,\r\n\r\nsum(l.penalty_charges_charged_derived) as penalties,\r\nsum(l.penalty_charges_repaid_derived) as penalties_repaid,\r\nsum(l.penalty_charges_outstanding_derived) as penalties_outstanding,\r\nsum(laa.penalty_charges_overdue_derived) as penalties_overdue\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\nleft join m_currency cur on cur.code = l.currency_code\r\n\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\ngroup by ounder.id, l.currency_code) x on x.branch = mo.id\r\norder by mo.hierarchy, x.Currency',NULL,1,1),(12,'Active Loans - Details','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nlo.display_name as \"Loan Officer\", \r\nc.display_name as \"Client\", l.account_no as \"Loan Account No.\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  \r\nl.principal_amount as \"Loan Amount\", \r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed Date\", \r\ndate(l.expected_maturedon_date) as \"Expected Matured On\",\r\n\r\nl.principal_repaid_derived as \"Principal Repaid\",\r\nl.principal_outstanding_derived as \"Principal Outstanding\",\r\nlaa.principal_overdue_derived as \"Principal Overdue\",\r\n\r\nl.interest_repaid_derived as \"Interest Repaid\",\r\nl.interest_outstanding_derived as \"Interest Outstanding\",\r\nlaa.interest_overdue_derived as \"Interest Overdue\",\r\n\r\nl.fee_charges_repaid_derived as \"Fees Repaid\",\r\nl.fee_charges_outstanding_derived  as \"Fees Outstanding\",\r\nlaa.fee_charges_overdue_derived as \"Fees Overdue\",\r\n\r\nl.penalty_charges_repaid_derived as \"Penalties Repaid\",\r\nl.penalty_charges_outstanding_derived as \"Penalties Outstanding\",\r\npenalty_charges_overdue_derived as \"Penalties Overdue\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\ngroup by l.id\r\norder by ounder.hierarchy, l.currency_code, c.account_no, l.account_no','Individual Client \n\nReport',1,1),(13,'Obligation Met Loans Details','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nc.account_no as \"Client Account No.\", c.display_name as \"Client\",\r\nl.account_no as \"Loan Account No.\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  \r\nl.principal_amount as \"Loan Amount\", \r\nl.total_repayment_derived  as \"Total Repaid\", \r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed\", \r\ndate(l.closedon_date) as \"Closed\",\r\n\r\nl.principal_repaid_derived as \"Principal Repaid\",\r\nl.interest_repaid_derived as \"Interest Repaid\",\r\nl.fee_charges_repaid_derived as \"Fees Repaid\",\r\nl.penalty_charges_repaid_derived as \"Penalties Repaid\",\r\nlo.display_name as \"Loan Officer\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand (case\r\n	when ${obligDateType} = 1 then\r\n    l.closedon_date between \'${startDate}\' and \'${endDate}\'\r\n	when ${obligDateType} = 2 then\r\n    l.disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\n	else 1 = 1\r\n	end)\r\nand l.loan_status_id = 600\r\ngroup by l.id\r\norder by ounder.hierarchy, l.currency_code, c.account_no, l.account_no','Individual Client \n\nReport',1,1),(14,'Obligation Met Loans Summary','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\ncount(distinct(c.id)) as \"No. of Clients\",\r\ncount(distinct(l.id)) as \"No. of Loans\",\r\nsum(l.principal_amount) as \"Total Loan Amount\", \r\nsum(l.principal_repaid_derived) as \"Total Principal Repaid\",\r\nsum(l.interest_repaid_derived) as \"Total Interest Repaid\",\r\nsum(l.fee_charges_repaid_derived) as \"Total Fees Repaid\",\r\nsum(l.penalty_charges_repaid_derived) as \"Total Penalties Repaid\",\r\nsum(l.interest_waived_derived) as \"Total Interest Waived\",\r\nsum(l.fee_charges_waived_derived) as \"Total Fees Waived\",\r\nsum(l.penalty_charges_waived_derived) as \"Total Penalties Waived\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand (case\r\n	when ${obligDateType} = 1 then\r\n    l.closedon_date between \'${startDate}\' and \'${endDate}\'\r\n	when ${obligDateType} = 2 then\r\n    l.disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\n	else 1 = 1\r\n	end)\r\nand l.loan_status_id = 600\r\ngroup by ounder.hierarchy, l.currency_code\r\norder by ounder.hierarchy, l.currency_code','Individual Client \n\nReport',1,1),(15,'Portfolio at Risk','Table',NULL,'Loan','select x.Currency, x.`Principal Outstanding`, x.`Principal Overdue`, x.`Interest Outstanding`, x.`Interest Overdue`, \r\nx.`Fees Outstanding`, x.`Fees Overdue`, x.`Penalties Outstanding`, x.`Penalties Overdue`,\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.`Principal Overdue` * 100) / x.`Principal Outstanding`, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding`), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue` + x.`Fees Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding` + x.`Fees Outstanding`), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue` + x.`Fees Overdue` + x.`Penalties Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding` + x.`Fees Outstanding` + x.`Penalties Overdue`), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from \r\n(select  ifnull(cur.display_symbol, l.currency_code) as Currency,  \r\nsum(l.principal_outstanding_derived) as \"Principal Outstanding\",\r\nsum(laa.principal_overdue_derived) as \"Principal Overdue\",\r\n\r\nsum(l.interest_outstanding_derived) as \"Interest Outstanding\",\r\nsum(laa.interest_overdue_derived) as \"Interest Overdue\",\r\n\r\nsum(l.fee_charges_outstanding_derived)  as \"Fees Outstanding\",\r\nsum(laa.fee_charges_overdue_derived) as \"Fees Overdue\",\r\n\r\nsum(penalty_charges_outstanding_derived) as \"Penalties Outstanding\",\r\nsum(laa.penalty_charges_overdue_derived) as \"Penalties Overdue\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin  m_loan l on l.client_id = c.id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nleft join m_product_loan p on p.id = l.product_id\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\ngroup by l.currency_code\r\norder by l.currency_code) x','Covers all loans.\r\n\r\nFor larger MFIs … we should add some derived fields on loan (or a 1:1 loan related table like mifos 2.x does)\r\nPrinciple, Interest, Fees, Penalties Outstanding and Overdue (possibly waived and written off too)',1,1),(16,'Portfolio at Risk by Branch','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(mo.`hierarchy`) - LENGTH(REPLACE(mo.`hierarchy`, \'.\', \'\')) - 1))), mo.`name`) as \"Office/Branch\",\r\nx.Currency, x.`Principal Outstanding`, x.`Principal Overdue`, x.`Interest Outstanding`, x.`Interest Overdue`, \r\nx.`Fees Outstanding`, x.`Fees Overdue`, x.`Penalties Outstanding`, x.`Penalties Overdue`,\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.`Principal Overdue` * 100) / x.`Principal Outstanding`, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding`), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue` + x.`Fees Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding` + x.`Fees Outstanding`), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue` + x.`Fees Overdue` + x.`Penalties Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding` + x.`Fees Outstanding` + x.`Penalties Overdue`), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from m_office mo\r\njoin \r\n(select  ounder.id as \"branch\", ifnull(cur.display_symbol, l.currency_code) as Currency,  \r\n\r\nsum(l.principal_outstanding_derived) as \"Principal Outstanding\",\r\nsum(laa.principal_overdue_derived) as \"Principal Overdue\",\r\n\r\nsum(l.interest_outstanding_derived) as \"Interest Outstanding\",\r\nsum(laa.interest_overdue_derived) as \"Interest Overdue\",\r\n\r\nsum(l.fee_charges_outstanding_derived)  as \"Fees Outstanding\",\r\nsum(laa.fee_charges_overdue_derived) as \"Fees Overdue\",\r\n\r\nsum(penalty_charges_outstanding_derived) as \"Penalties Outstanding\",\r\nsum(laa.penalty_charges_overdue_derived) as \"Penalties Overdue\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin  m_loan l on l.client_id = c.id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nleft join m_product_loan p on p.id = l.product_id\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\ngroup by ounder.id, l.currency_code) x on x.branch = mo.id\r\norder by mo.hierarchy, x.Currency','Covers all loans.\r\n\r\nFor larger MFIs … we should add some derived fields on loan (or a 1:1 loan related table like mifos 2.x does)\r\nPrinciple, Interest, Fees, Penalties Outstanding and Overdue (possibly waived and written off too)',1,1),(20,'Funds Disbursed Between Dates Summary','Table',NULL,'Fund','select ifnull(f.`name`, \'-\') as Fund,  ifnull(cur.display_symbol, l.currency_code) as Currency, \r\nround(sum(l.principal_amount), 4) as disbursed_amount\r\nfrom m_office ounder \r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_currency cur on cur.`code` = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nwhere disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (l.currency_code = \'${currencyId}\' or \'-1\' = \'${currencyId}\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\ngroup by ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, l.currency_code)\r\norder by ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, l.currency_code)',NULL,1,1),(21,'Funds Disbursed Between Dates Summary by Office','Table',NULL,'Fund','select \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\n \n\nifnull(f.`name`, \'-\') as Fund,  ifnull(cur.display_symbol, l.currency_code) as Currency, round(sum(l.principal_amount), 4) as disbursed_amount\r\nfrom m_office o\r\n\n\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c \n\non c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_currency cur on cur.`code` = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\n\n\nwhere disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\nand o.id = ${officeId}\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand \n\n(l.currency_code = \'${currencyId}\' or \'-1\' = \'${currencyId}\')\r\ngroup by ounder.`name`,  ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, \n\nl.currency_code)\r\norder by ounder.`name`,  ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, l.currency_code)',NULL,1,1),(48,'Balance Sheet','Pentaho',NULL,'Accounting',NULL,'Balance Sheet',1,1),(49,'Income Statement','Pentaho',NULL,'Accounting',NULL,'Profit and Loss Statement',1,1),(50,'Trial Balance','Pentaho',NULL,'Accounting',NULL,'Trial Balance Report',1,1),(51,'Written-Off Loans','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, ml.currency_code) as Currency,  \r\nc.account_no as \"Client Account No.\",\r\nc.display_name AS \'Client Name\',\r\nml.account_no AS \'Loan Account No.\',\r\nmpl.name AS \'Product Name\',\r\nml.disbursedon_date AS \'Disbursed Date\',\r\nlt.transaction_date AS \'Written Off date\',\r\nml.principal_amount as \"Loan Amount\",\r\nifnull(lt.principal_portion_derived, 0) AS \'Written-Off Principal\',\r\nifnull(lt.interest_portion_derived, 0) AS \'Written-Off Interest\',\r\nifnull(lt.fee_charges_portion_derived,0) AS \'Written-Off Fees\',\r\nifnull(lt.penalty_charges_portion_derived,0) AS \'Written-Off Penalties\',\r\nn.note AS \'Reason For Write-Off\',\r\nIFNULL(ms.display_name,\'-\') AS \'Loan Officer Name\'\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nAND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_loan ml ON ml.client_id = c.id\r\nJOIN m_product_loan mpl ON mpl.id=ml.product_id\r\nLEFT JOIN m_staff ms ON ms.id=ml.loan_officer_id\r\nJOIN m_loan_transaction lt ON lt.loan_id = ml.id\r\nLEFT JOIN m_note n ON n.loan_transaction_id = lt.id\r\nLEFT JOIN m_currency cur on cur.code = ml.currency_code\r\nWHERE lt.transaction_type_enum = 6 /*write-off */\r\nAND lt.is_reversed is false \r\nAND ml.loan_status_id=601\r\nAND o.id=${officeId}\r\nAND (mpl.id=${loanProductId} OR ${loanProductId}=-1)\r\nAND lt.transaction_date BETWEEN \'${startDate}\' AND \'${endDate}\'\r\nAND (ml.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\") \r\nORDER BY ounder.hierarchy, ifnull(cur.display_symbol, ml.currency_code), ml.account_no','Individual Lending Report. Written Off Loans',1,1),(52,'Aging Detail','Table',NULL,'Loan','\r\nSELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, ml.currency_code) as Currency,  \r\nmc.account_no as \"Client Account No.\",\r\n 	mc.display_name AS \"Client Name\",\r\n 	ml.account_no AS \"Account Number\",\r\n 	ml.principal_amount AS \"Loan Amount\",\r\n ml.principal_disbursed_derived AS \"Original Principal\",\r\n ml.interest_charged_derived AS \"Original Interest\",\r\n ml.principal_repaid_derived AS \"Principal Paid\",\r\n ml.interest_repaid_derived AS \"Interest Paid\",\r\n laa.principal_overdue_derived AS \"Principal Overdue\",\r\n laa.interest_overdue_derived AS \"Interest Overdue\",\r\nDATEDIFF(CURDATE(), laa.overdue_since_date_derived) as \"Days in Arrears\",\r\n\r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<7, \'<1\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<8, \' 1\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<15,  \'2\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<22, \' 3\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<29, \' 4\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<36, \' 5\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<43, \' 6\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<50, \' 7\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<57, \' 8\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<64, \' 9\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<71, \'10\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<78, \'11\', \r\n 	IF(DATEDIFF(CURDATE(), laa.overdue_since_date_derived)<85, \'12\', \'12+\')))))))))))) )AS \"Weeks In Arrears Band\",\r\n\r\n		IF(DATEDIFF(CURDATE(),  laa.overdue_since_date_derived)<31, \'0 - 30\', \r\n		IF(DATEDIFF(CURDATE(),  laa.overdue_since_date_derived)<61, \'30 - 60\', \r\n		IF(DATEDIFF(CURDATE(),  laa.overdue_since_date_derived)<91, \'60 - 90\', \r\n		IF(DATEDIFF(CURDATE(),  laa.overdue_since_date_derived)<181, \'90 - 180\', \r\n		IF(DATEDIFF(CURDATE(),  laa.overdue_since_date_derived)<361, \'180 - 360\', \r\n				 \'> 360\'))))) AS \"Days in Arrears Band\"\r\n\r\n	FROM m_office mo \r\n    JOIN m_office ounder ON ounder.hierarchy like concat(mo.hierarchy, \'%\')\r\n	        AND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n    INNER JOIN m_client mc ON mc.office_id=ounder.id\r\n	    INNER JOIN m_loan ml ON ml.client_id = mc.id\r\n	    INNER JOIN r_enum_value rev ON rev.enum_id=ml.loan_status_id AND rev.enum_name = \'loan_status_id\'\r\n    INNER JOIN m_loan_arrears_aging laa ON laa.loan_id=ml.id\r\n    left join m_currency cur on cur.code = ml.currency_code\r\n	WHERE ml.loan_status_id=300\r\n    AND mo.id=${officeId}\r\nORDER BY ounder.hierarchy, ifnull(cur.display_symbol, ml.currency_code), ml.account_no\r\n','Loan arrears aging (Weeks)',1,1),(53,'Aging Summary (Arrears in Weeks)','Table',NULL,'Loan','SELECT \r\n  IFNULL(periods.currencyName, periods.currency) as currency, \r\n  periods.period_no \'Weeks In Arrears (Up To)\', \r\n  IFNULL(ars.loanId, 0) \'No Of Loans\', \r\n  IFNULL(ars.principal,0.0) \'Original Principal\', \r\n  IFNULL(ars.interest,0.0) \'Original Interest\', \r\n  IFNULL(ars.prinPaid,0.0) \'Principal Paid\', \r\n  IFNULL(ars.intPaid,0.0) \'Interest Paid\', \r\n  IFNULL(ars.prinOverdue,0.0) \'Principal Overdue\', \r\n  IFNULL(ars.intOverdue,0.0)\'Interest Overdue\'\r\nFROM \r\n	/* full table of aging periods/currencies used combo to ensure each line represented */\r\n  (SELECT curs.code as currency, curs.name as currencyName, pers.* from\r\n	(SELECT \'On Schedule\' period_no,1 pid UNION\r\n		SELECT \'1\',2 UNION\r\n		SELECT \'2\',3 UNION\r\n		SELECT \'3\',4 UNION\r\n		SELECT \'4\',5 UNION\r\n		SELECT \'5\',6 UNION\r\n		SELECT \'6\',7 UNION\r\n		SELECT \'7\',8 UNION\r\n		SELECT \'8\',9 UNION\r\n		SELECT \'9\',10 UNION\r\n		SELECT \'10\',11 UNION\r\n		SELECT \'11\',12 UNION\r\n		SELECT \'12\',13 UNION\r\n		SELECT \'12+\',14) pers,\r\n	(SELECT distinctrow moc.code, moc.name\r\n  	FROM m_office mo2\r\n   	INNER JOIN m_office ounder2 ON ounder2.hierarchy \r\n				LIKE CONCAT(mo2.hierarchy, \'%\')\r\nAND ounder2.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n   	INNER JOIN m_client mc2 ON mc2.office_id=ounder2.id\r\n   	INNER JOIN m_loan ml2 ON ml2.client_id = mc2.id\r\n	INNER JOIN m_organisation_currency moc ON moc.code = ml2.currency_code\r\n	WHERE ml2.loan_status_id=300 /* active */\r\n	AND mo2.id=${officeId}\r\nAND (ml2.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")) curs) periods\r\n\r\n\r\nLEFT JOIN /* table of aging periods per currency with gaps if no applicable loans */\r\n(SELECT \r\n  	z.currency, z.arrPeriod, \r\n	COUNT(z.loanId) as loanId, SUM(z.principal) as principal, SUM(z.interest) as interest, \r\n	SUM(z.prinPaid) as prinPaid, SUM(z.intPaid) as intPaid, \r\n	SUM(z.prinOverdue) as prinOverdue, SUM(z.intOverdue) as intOverdue\r\nFROM\r\n	/*derived table just used to get arrPeriod value (was much slower to\r\n	duplicate calc of minOverdueDate in inner query)\r\nmight not be now with derived fields but didn’t check */\r\n	(SELECT x.loanId, x.currency, x.principal, x.interest, x.prinPaid, x.intPaid, x.prinOverdue, x.intOverdue,\r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<1, \'On Schedule\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<8, \'1\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<15, \'2\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<22, \'3\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<29, \'4\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<36, \'5\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<43, \'6\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<50, \'7\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<57, \'8\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<64, \'9\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<71, \'10\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<78, \'11\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<85, \'12\',\r\n				 \'12+\'))))))))))))) AS arrPeriod\r\n\r\n	FROM /* get the individual loan details */\r\n		(SELECT ml.id AS loanId, ml.currency_code as currency,\r\n   			ml.principal_disbursed_derived as principal, \r\n			   ml.interest_charged_derived as interest, \r\n   			ml.principal_repaid_derived as prinPaid, \r\n			   ml.interest_repaid_derived intPaid,\r\n\r\n			   laa.principal_overdue_derived as prinOverdue,\r\n			   laa.interest_overdue_derived as intOverdue,\r\n\r\n			   IFNULL(laa.overdue_since_date_derived, curdate()) as minOverdueDate\r\n			  \r\n  		FROM m_office mo\r\n   		INNER JOIN m_office ounder ON ounder.hierarchy \r\n				LIKE CONCAT(mo.hierarchy, \'%\')\r\nAND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n   		INNER JOIN m_client mc ON mc.office_id=ounder.id\r\n   		INNER JOIN m_loan ml ON ml.client_id = mc.id\r\n		   LEFT JOIN m_loan_arrears_aging laa on laa.loan_id = ml.id\r\n		WHERE ml.loan_status_id=300 /* active */\r\n     		AND mo.id=${officeId}\r\n     AND (ml.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\n  		GROUP BY ml.id) x\r\n	) z \r\nGROUP BY z.currency, z.arrPeriod ) ars ON ars.arrPeriod=periods.period_no and ars.currency = periods.currency\r\nORDER BY periods.currency, periods.pid','Loan amount in arrears by branch',1,1),(54,'Rescheduled Loans','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, ml.currency_code) as Currency,  \r\nc.account_no as \"Client Account No.\",\r\nc.display_name AS \'Client Name\',\r\nml.account_no AS \'Loan Account No.\',\r\nmpl.name AS \'Product Name\',\r\nml.disbursedon_date AS \'Disbursed Date\',\r\nlt.transaction_date AS \'Written Off date\',\r\nml.principal_amount as \"Loan Amount\",\r\nifnull(lt.principal_portion_derived, 0) AS \'Rescheduled Principal\',\r\nifnull(lt.interest_portion_derived, 0) AS \'Rescheduled Interest\',\r\nifnull(lt.fee_charges_portion_derived,0) AS \'Rescheduled Fees\',\r\nifnull(lt.penalty_charges_portion_derived,0) AS \'Rescheduled Penalties\',\r\nn.note AS \'Reason For Rescheduling\',\r\nIFNULL(ms.display_name,\'-\') AS \'Loan Officer Name\'\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nAND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_loan ml ON ml.client_id = c.id\r\nJOIN m_product_loan mpl ON mpl.id=ml.product_id\r\nLEFT JOIN m_staff ms ON ms.id=ml.loan_officer_id\r\nJOIN m_loan_transaction lt ON lt.loan_id = ml.id\r\nLEFT JOIN m_note n ON n.loan_transaction_id = lt.id\r\nLEFT JOIN m_currency cur on cur.code = ml.currency_code\r\nWHERE lt.transaction_type_enum = 7 /*marked for rescheduling */\r\nAND lt.is_reversed is false \r\nAND ml.loan_status_id=602\r\nAND o.id=${officeId}\r\nAND (mpl.id=${loanProductId} OR ${loanProductId}=-1)\r\nAND lt.transaction_date BETWEEN \'${startDate}\' AND \'${endDate}\'\r\nAND (ml.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nORDER BY ounder.hierarchy, ifnull(cur.display_symbol, ml.currency_code), ml.account_no','Individual Lending Report. Rescheduled Loans.  The ability to reschedule (or mark that you have rescheduled the loan elsewhere) is a legacy of the older Mifos product.  Needed for migration.',1,1),(55,'Active Loans Passed Final Maturity','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nlo.display_name as \"Loan Officer\", \r\nc.display_name as \"Client\", l.account_no as \"Loan Account No.\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  \r\nl.principal_amount as \"Loan Amount\", \r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed Date\", \r\ndate(l.expected_maturedon_date) as \"Expected Matured On\",\r\n\r\nl.principal_repaid_derived as \"Principal Repaid\",\r\nl.principal_outstanding_derived as \"Principal Outstanding\",\r\nlaa.principal_overdue_derived as \"Principal Overdue\",\r\n\r\nl.interest_repaid_derived as \"Interest Repaid\",\r\nl.interest_outstanding_derived as \"Interest Outstanding\",\r\nlaa.interest_overdue_derived as \"Interest Overdue\",\r\n\r\nl.fee_charges_repaid_derived as \"Fees Repaid\",\r\nl.fee_charges_outstanding_derived  as \"Fees Outstanding\",\r\nlaa.fee_charges_overdue_derived as \"Fees Overdue\",\r\n\r\nl.penalty_charges_repaid_derived as \"Penalties Repaid\",\r\nl.penalty_charges_outstanding_derived as \"Penalties Outstanding\",\r\nlaa.penalty_charges_overdue_derived as \"Penalties Overdue\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\nand l.expected_maturedon_date < curdate()\r\ngroup by l.id\r\norder by ounder.hierarchy, l.currency_code, c.account_no, l.account_no','Individual Client \n\nReport',1,1),(56,'Active Loans Passed Final Maturity Summary','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(mo.`hierarchy`) - LENGTH(REPLACE(mo.`hierarchy`, \'.\', \'\')) - 1))), mo.`name`) as \"Office/Branch\", x.currency as Currency,\r\n x.client_count as \"No. of Clients\", x.active_loan_count as \"No. Active Loans\", x. arrears_loan_count as \"No. of Loans in Arrears\",\r\nx.principal as \"Total Loans Disbursed\", x.principal_repaid as \"Principal Repaid\", x.principal_outstanding as \"Principal Outstanding\", x.principal_overdue as \"Principal Overdue\",\r\nx.interest as \"Total Interest\", x.interest_repaid as \"Interest Repaid\", x.interest_outstanding as \"Interest Outstanding\", x.interest_overdue as \"Interest Overdue\",\r\nx.fees as \"Total Fees\", x.fees_repaid as \"Fees Repaid\", x.fees_outstanding as \"Fees Outstanding\", x.fees_overdue as \"Fees Overdue\",\r\nx.penalties as \"Total Penalties\", x.penalties_repaid as \"Penalties Repaid\", x.penalties_outstanding as \"Penalties Outstanding\", x.penalties_overdue as \"Penalties Overdue\",\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.principal_overdue * 100) / x.principal_outstanding, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue + x.penalties_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding + x.penalties_overdue), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from m_office mo\r\njoin \r\n(select ounder.id as branch,\r\nifnull(cur.display_symbol, l.currency_code) as currency,\r\ncount(distinct(c.id)) as client_count, \r\ncount(distinct(l.id)) as  active_loan_count,\r\ncount(distinct(laa.loan_id)  ) as arrears_loan_count,\r\n\r\nsum(l.principal_disbursed_derived) as principal,\r\nsum(l.principal_repaid_derived) as principal_repaid,\r\nsum(l.principal_outstanding_derived) as principal_outstanding,\r\nsum(ifnull(laa.principal_overdue_derived,0)) as principal_overdue,\r\n\r\nsum(l.interest_charged_derived) as interest,\r\nsum(l.interest_repaid_derived) as interest_repaid,\r\nsum(l.interest_outstanding_derived) as interest_outstanding,\r\nsum(ifnull(laa.interest_overdue_derived,0)) as interest_overdue,\r\n\r\nsum(l.fee_charges_charged_derived) as fees,\r\nsum(l.fee_charges_repaid_derived) as fees_repaid,\r\nsum(l.fee_charges_outstanding_derived)  as fees_outstanding,\r\nsum(ifnull(laa.fee_charges_overdue_derived,0)) as fees_overdue,\r\n\r\nsum(l.penalty_charges_charged_derived) as penalties,\r\nsum(l.penalty_charges_repaid_derived) as penalties_repaid,\r\nsum(l.penalty_charges_outstanding_derived) as penalties_outstanding,\r\nsum(ifnull(laa.penalty_charges_overdue_derived,0)) as penalties_overdue\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\n\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\nand l.expected_maturedon_date < curdate()\r\ngroup by ounder.id, l.currency_code) x on x.branch = mo.id\r\norder by mo.hierarchy, x.Currency',NULL,1,1),(57,'Active Loans in last installment','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(lastInstallment.`hierarchy`) - LENGTH(REPLACE(lastInstallment.`hierarchy`, \'.\', \'\')) - 1))), lastInstallment.branch) as \"Office/Branch\",\r\nlastInstallment.Currency,\r\nlastInstallment.`Loan Officer`, \r\nlastInstallment.`Client Account No`, lastInstallment.`Client`, \r\nlastInstallment.`Loan Account No`, lastInstallment.`Product`, \r\nlastInstallment.`Fund`,  lastInstallment.`Loan Amount`, \r\nlastInstallment.`Annual Nominal Interest Rate`, \r\nlastInstallment.`Disbursed`, lastInstallment.`Expected Matured On` ,\r\n\r\nl.principal_repaid_derived as \"Principal Repaid\",\r\nl.principal_outstanding_derived as \"Principal Outstanding\",\r\nlaa.principal_overdue_derived as \"Principal Overdue\",\r\n\r\nl.interest_repaid_derived as \"Interest Repaid\",\r\nl.interest_outstanding_derived as \"Interest Outstanding\",\r\nlaa.interest_overdue_derived as \"Interest Overdue\",\r\n\r\nl.fee_charges_repaid_derived as \"Fees Repaid\",\r\nl.fee_charges_outstanding_derived  as \"Fees Outstanding\",\r\nlaa.fee_charges_overdue_derived as \"Fees Overdue\",\r\n\r\nl.penalty_charges_repaid_derived as \"Penalties Repaid\",\r\nl.penalty_charges_outstanding_derived as \"Penalties Outstanding\",\r\nlaa.penalty_charges_overdue_derived as \"Penalties Overdue\"\r\n\r\nfrom \r\n(select l.id as loanId, l.number_of_repayments, min(r.installment), \r\nounder.id, ounder.hierarchy, ounder.`name` as branch, \r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nlo.display_name as \"Loan Officer\", c.account_no as \"Client Account No\",\r\nc.display_name as \"Client\", l.account_no as \"Loan Account No\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  l.principal_amount as \"Loan Amount\", \r\nl.annual_nominal_interest_rate as \"Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed\", date(l.expected_maturedon_date) as \"Expected Matured On\"\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\nand r.completed_derived is false\r\nand r.duedate >= curdate()\r\ngroup by l.id\r\nhaving l.number_of_repayments = min(r.installment)) lastInstallment\r\njoin m_loan l on l.id = lastInstallment.loanId\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\norder by lastInstallment.hierarchy, lastInstallment.Currency, lastInstallment.`Client Account No`, lastInstallment.`Loan Account No`','Individual Client \n\nReport',1,1),(58,'Active Loans in last installment Summary','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(mo.`hierarchy`) - LENGTH(REPLACE(mo.`hierarchy`, \'.\', \'\')) - 1))), mo.`name`) as \"Office/Branch\", x.currency as Currency,\r\n x.client_count as \"No. of Clients\", x.active_loan_count as \"No. Active Loans\", x. arrears_loan_count as \"No. of Loans in Arrears\",\r\nx.principal as \"Total Loans Disbursed\", x.principal_repaid as \"Principal Repaid\", x.principal_outstanding as \"Principal Outstanding\", x.principal_overdue as \"Principal Overdue\",\r\nx.interest as \"Total Interest\", x.interest_repaid as \"Interest Repaid\", x.interest_outstanding as \"Interest Outstanding\", x.interest_overdue as \"Interest Overdue\",\r\nx.fees as \"Total Fees\", x.fees_repaid as \"Fees Repaid\", x.fees_outstanding as \"Fees Outstanding\", x.fees_overdue as \"Fees Overdue\",\r\nx.penalties as \"Total Penalties\", x.penalties_repaid as \"Penalties Repaid\", x.penalties_outstanding as \"Penalties Outstanding\", x.penalties_overdue as \"Penalties Overdue\",\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.principal_overdue * 100) / x.principal_outstanding, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue + x.penalties_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding + x.penalties_overdue), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from m_office mo\r\njoin \r\n(select lastInstallment.branchId as branchId,\r\nlastInstallment.Currency,\r\ncount(distinct(lastInstallment.clientId)) as client_count, \r\ncount(distinct(lastInstallment.loanId)) as  active_loan_count,\r\ncount(distinct(laa.loan_id)  ) as arrears_loan_count,\r\n\r\nsum(l.principal_disbursed_derived) as principal,\r\nsum(l.principal_repaid_derived) as principal_repaid,\r\nsum(l.principal_outstanding_derived) as principal_outstanding,\r\nsum(ifnull(laa.principal_overdue_derived,0)) as principal_overdue,\r\n\r\nsum(l.interest_charged_derived) as interest,\r\nsum(l.interest_repaid_derived) as interest_repaid,\r\nsum(l.interest_outstanding_derived) as interest_outstanding,\r\nsum(ifnull(laa.interest_overdue_derived,0)) as interest_overdue,\r\n\r\nsum(l.fee_charges_charged_derived) as fees,\r\nsum(l.fee_charges_repaid_derived) as fees_repaid,\r\nsum(l.fee_charges_outstanding_derived)  as fees_outstanding,\r\nsum(ifnull(laa.fee_charges_overdue_derived,0)) as fees_overdue,\r\n\r\nsum(l.penalty_charges_charged_derived) as penalties,\r\nsum(l.penalty_charges_repaid_derived) as penalties_repaid,\r\nsum(l.penalty_charges_outstanding_derived) as penalties_outstanding,\r\nsum(ifnull(laa.penalty_charges_overdue_derived,0)) as penalties_overdue\r\n\r\nfrom \r\n(select l.id as loanId, l.number_of_repayments, min(r.installment), \r\nounder.id as branchId, ounder.hierarchy, ounder.`name` as branch, \r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nlo.display_name as \"Loan Officer\", c.id as clientId, c.account_no as \"Client Account No\",\r\nc.display_name as \"Client\", l.account_no as \"Loan Account No\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  l.principal_amount as \"Loan Amount\", \r\nl.annual_nominal_interest_rate as \"Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed\", date(l.expected_maturedon_date) as \"Expected Matured On\"\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\nand r.completed_derived is false\r\nand r.duedate >= curdate()\r\ngroup by l.id\r\nhaving l.number_of_repayments = min(r.installment)) lastInstallment\r\njoin m_loan l on l.id = lastInstallment.loanId\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\ngroup by lastInstallment.branchId) x on x.branchId = mo.id\r\norder by mo.hierarchy, x.Currency','Individual Client \n\nReport',1,1),(59,'Active Loans by Disbursal Period','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nc.account_no as \"Client Account No\", c.display_name as \"Client\", l.account_no as \"Loan Account No\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  \r\nl.principal_amount as \"Loan Principal Amount\", \r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed Date\", \r\n\r\nl.total_expected_repayment_derived as \"Total Loan (P+I+F+Pen)\",\r\nl.total_repayment_derived as \"Total Repaid (P+I+F+Pen)\",\r\nlo.display_name as \"Loan Officer\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\nand l.loan_status_id = 300\r\ngroup by l.id\r\norder by ounder.hierarchy, l.currency_code, c.account_no, l.account_no','Individual Client \n\nReport',1,1),(61,'Aging Summary (Arrears in Months)','Table',NULL,'Loan','SELECT \r\n  IFNULL(periods.currencyName, periods.currency) as currency, \r\n  periods.period_no \'Days In Arrears\', \r\n  IFNULL(ars.loanId, 0) \'No Of Loans\', \r\n  IFNULL(ars.principal,0.0) \'Original Principal\', \r\n  IFNULL(ars.interest,0.0) \'Original Interest\', \r\n  IFNULL(ars.prinPaid,0.0) \'Principal Paid\', \r\n  IFNULL(ars.intPaid,0.0) \'Interest Paid\', \r\n  IFNULL(ars.prinOverdue,0.0) \'Principal Overdue\', \r\n  IFNULL(ars.intOverdue,0.0)\'Interest Overdue\'\r\nFROM \r\n	/* full table of aging periods/currencies used combo to ensure each line represented */\r\n  (SELECT curs.code as currency, curs.name as currencyName, pers.* from\r\n	(SELECT \'On Schedule\' period_no,1 pid UNION\r\n		SELECT \'0 - 30\',2 UNION\r\n		SELECT \'30 - 60\',3 UNION\r\n		SELECT \'60 - 90\',4 UNION\r\n		SELECT \'90 - 180\',5 UNION\r\n		SELECT \'180 - 360\',6 UNION\r\n		SELECT \'> 360\',7 ) pers,\r\n	(SELECT distinctrow moc.code, moc.name\r\n  	FROM m_office mo2\r\n   	INNER JOIN m_office ounder2 ON ounder2.hierarchy \r\n				LIKE CONCAT(mo2.hierarchy, \'%\')\r\nAND ounder2.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n   	INNER JOIN m_client mc2 ON mc2.office_id=ounder2.id\r\n   	INNER JOIN m_loan ml2 ON ml2.client_id = mc2.id\r\n	INNER JOIN m_organisation_currency moc ON moc.code = ml2.currency_code\r\n	WHERE ml2.loan_status_id=300 /* active */\r\n	AND mo2.id=${officeId}\r\nAND (ml2.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")) curs) periods\r\n\r\n\r\nLEFT JOIN /* table of aging periods per currency with gaps if no applicable loans */\r\n(SELECT \r\n  	z.currency, z.arrPeriod, \r\n	COUNT(z.loanId) as loanId, SUM(z.principal) as principal, SUM(z.interest) as interest, \r\n	SUM(z.prinPaid) as prinPaid, SUM(z.intPaid) as intPaid, \r\n	SUM(z.prinOverdue) as prinOverdue, SUM(z.intOverdue) as intOverdue\r\nFROM\r\n	/*derived table just used to get arrPeriod value (was much slower to\r\n	duplicate calc of minOverdueDate in inner query)\r\nmight not be now with derived fields but didn’t check */\r\n	(SELECT x.loanId, x.currency, x.principal, x.interest, x.prinPaid, x.intPaid, x.prinOverdue, x.intOverdue,\r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<1, \'On Schedule\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<31, \'0 - 30\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<61, \'30 - 60\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<91, \'60 - 90\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<181, \'90 - 180\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<361, \'180 - 360\', \r\n				 \'> 360\')))))) AS arrPeriod\r\n\r\n	FROM /* get the individual loan details */\r\n		(SELECT ml.id AS loanId, ml.currency_code as currency,\r\n   			ml.principal_disbursed_derived as principal, \r\n			   ml.interest_charged_derived as interest, \r\n   			ml.principal_repaid_derived as prinPaid, \r\n			   ml.interest_repaid_derived intPaid,\r\n\r\n			   laa.principal_overdue_derived as prinOverdue,\r\n			   laa.interest_overdue_derived as intOverdue,\r\n\r\n			   IFNULL(laa.overdue_since_date_derived, curdate()) as minOverdueDate\r\n			  \r\n  		FROM m_office mo\r\n   		INNER JOIN m_office ounder ON ounder.hierarchy \r\n				LIKE CONCAT(mo.hierarchy, \'%\')\r\nAND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n   		INNER JOIN m_client mc ON mc.office_id=ounder.id\r\n   		INNER JOIN m_loan ml ON ml.client_id = mc.id\r\n		   LEFT JOIN m_loan_arrears_aging laa on laa.loan_id = ml.id\r\n		WHERE ml.loan_status_id=300 /* active */\r\n     		AND mo.id=${officeId}\r\n     AND (ml.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\n  		GROUP BY ml.id) x\r\n	) z \r\nGROUP BY z.currency, z.arrPeriod ) ars ON ars.arrPeriod=periods.period_no and ars.currency = periods.currency\r\nORDER BY periods.currency, periods.pid','Loan amount in arrears by branch',1,1),(91,'Loan Account Schedule','Pentaho',NULL,'Loan',NULL,NULL,1,0),(92,'Branch Expected Cash Flow','Pentaho',NULL,'Loan',NULL,NULL,1,1),(93,'Expected Payments By Date - Basic','Table',NULL,'Loan','SELECT \r\n      ounder.name \'Office\', \r\n      IFNULL(ms.display_name,\'-\') \'Loan Officer\',\r\n	  mc.account_no \'Client Account Number\',\r\n	  mc.display_name \'Name\',\r\n	  mp.name \'Product\',\r\n	  ml.account_no \'Loan Account Number\',\r\n	  mr.duedate \'Due Date\',\r\n	  mr.installment \'Installment\',\r\n	  cu.display_symbol \'Currency\',\r\n	  mr.principal_amount- IFNULL(mr.principal_completed_derived,0) \'Principal Due\',\r\n	  mr.interest_amount- IFNULL(IFNULL(mr.interest_completed_derived,mr.interest_waived_derived),0) \'Interest Due\', \r\n	  IFNULL(mr.fee_charges_amount,0)- IFNULL(IFNULL(mr.fee_charges_completed_derived,mr.fee_charges_waived_derived),0) \'Fees Due\', \r\n	  IFNULL(mr.penalty_charges_amount,0)- IFNULL(IFNULL(mr.penalty_charges_completed_derived,mr.penalty_charges_waived_derived),0) \'Penalty Due\',\r\n      (mr.principal_amount- IFNULL(mr.principal_completed_derived,0)) +\r\n       (mr.interest_amount- IFNULL(IFNULL(mr.interest_completed_derived,mr.interest_waived_derived),0)) + \r\n       (IFNULL(mr.fee_charges_amount,0)- IFNULL(IFNULL(mr.fee_charges_completed_derived,mr.fee_charges_waived_derived),0)) + \r\n       (IFNULL(mr.penalty_charges_amount,0)- IFNULL(IFNULL(mr.penalty_charges_completed_derived,mr.penalty_charges_waived_derived),0)) \'Total Due\', \r\n     mlaa.total_overdue_derived \'Total Overdue\'\r\n										 \r\n FROM m_office mo\r\n  JOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\')\r\n  \r\n  AND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n	\r\n  LEFT JOIN m_client mc ON mc.office_id=ounder.id\r\n  LEFT JOIN m_loan ml ON ml.client_id=mc.id AND ml.loan_status_id=300\r\n  LEFT JOIN m_loan_arrears_aging mlaa ON mlaa.loan_id=ml.id\r\n  LEFT JOIN m_loan_repayment_schedule mr ON mr.loan_id=ml.id AND mr.completed_derived=0\r\n  LEFT JOIN m_product_loan mp ON mp.id=ml.product_id\r\n  LEFT JOIN m_staff ms ON ms.id=ml.loan_officer_id\r\n  LEFT JOIN m_currency cu ON cu.code=ml.currency_code\r\n WHERE mo.id=${officeId}\r\n AND (IFNULL(ml.loan_officer_id, -10) = \"${loanOfficerId}\" OR \"-1\" = \"${loanOfficerId}\")\r\n AND mr.duedate BETWEEN \'${startDate}\' AND \'${endDate}\'\r\n ORDER BY ounder.id,mr.duedate,ml.account_no','Test',1,1),(94,'Expected Payments By Date - Formatted','Pentaho',NULL,'Loan',NULL,NULL,1,1),(96,'GroupSummaryCounts','Table',NULL,NULL,'\n/*\nActive Client is a client linked to the \'group\' via m_group_client\nand with an active \'status_enum\'.)\nActive Borrowers - Borrower may be a client or a \'group\'\n*/\nselect x.*\nfrom m_office o,\nm_group g,\n\n(select a.activeClients,\n(b.activeClientLoans + c.activeGroupLoans) as activeLoans,\nb.activeClientLoans, c.activeGroupLoans,\n(b.activeClientBorrowers + c.activeGroupBorrowers) as activeBorrowers,\nb.activeClientBorrowers, c.activeGroupBorrowers,\n(b.overdueClientLoans +  c.overdueGroupLoans) as overdueLoans,\nb.overdueClientLoans, c.overdueGroupLoans\nfrom\n(select count(*) as activeClients\nfrom m_group topgroup\njoin m_group g on g.hierarchy like concat(topgroup.hierarchy, \'%\')\njoin m_group_client gc on gc.group_id = g.id\njoin m_client c on c.id = gc.client_id\nwhere topgroup.id = ${groupId}\nand c.status_enum = 300) a,\n\n(select count(*) as activeClientLoans,\ncount(distinct(l.client_id)) as activeClientBorrowers,\nifnull(sum(if(laa.loan_id is not null, 1, 0)), 0) as overdueClientLoans\nfrom m_group topgroup\njoin m_group g on g.hierarchy like concat(topgroup.hierarchy, \'%\')\njoin m_loan l on l.group_id = g.id and l.client_id is not null\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nwhere topgroup.id = ${groupId}\nand l.loan_status_id = 300) b,\n\n(select count(*) as activeGroupLoans,\ncount(distinct(l.group_id)) as activeGroupBorrowers,\nifnull(sum(if(laa.loan_id is not null, 1, 0)), 0) as overdueGroupLoans\nfrom m_group topgroup\njoin m_group g on g.hierarchy like concat(topgroup.hierarchy, \'%\')\njoin m_loan l on l.group_id = g.id and l.client_id is null\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nwhere topgroup.id = ${groupId}\nand l.loan_status_id = 300) c\n) x\n\nwhere g.id = ${groupId}\nand o.id = g.office_id\nand o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\n','Utility query for getting group summary count details for a group_id',1,0),(97,'GroupSummaryAmounts','Table',NULL,NULL,'\nselect ifnull(cur.display_symbol, l.currency_code) as currency,\nifnull(sum(l.principal_disbursed_derived),0) as totalDisbursedAmount,\nifnull(sum(l.principal_outstanding_derived),0) as totalLoanOutstandingAmount,\ncount(laa.loan_id) as overdueLoans, ifnull(sum(laa.total_overdue_derived), 0) as totalLoanOverdueAmount\nfrom m_group topgroup\njoin m_office o on o.id = topgroup.office_id and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_group g on g.hierarchy like concat(topgroup.hierarchy, \'%\')\njoin m_loan l on l.group_id = g.id\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nleft join m_currency cur on cur.code = l.currency_code\nwhere topgroup.id = ${groupId}\nand l.disbursedon_date is not null\ngroup by l.currency_code\n','Utility query for getting group summary currency amount details for a group_id',1,0),(106,'TxnRunningBalances','Table',NULL,'Transaction','\nselect date(\'${startDate}\') as \'Transaction Date\', \'Opening Balance\' as `Transaction Type`, null as Office,\n	null as \'Loan Officer\', null as `Loan Account No`, null as `Loan Product`, null as `Currency`,\n	null as `Client Account No`, null as Client,\n	null as Amount, null as Principal, null as Interest,\n@totalOutstandingPrincipal :=\nifnull(round(sum(\n	if (txn.transaction_type_enum = 1 /* disbursement */,\n		ifnull(txn.amount,0.00),\n		ifnull(txn.principal_portion_derived,0.00) * -1))\n			,2),0.00)  as \'Outstanding Principal\',\n\n@totalInterestIncome :=\nifnull(round(sum(\n	if (txn.transaction_type_enum in (2,5,8) /* repayment, repayment at disbursal, recovery repayment */,\n		ifnull(txn.interest_portion_derived,0.00),\n		0))\n			,2),0.00) as \'Interest Income\',\n\n@totalWriteOff :=\nifnull(round(sum(\n	if (txn.transaction_type_enum = 6 /* write-off */,\n		ifnull(txn.principal_portion_derived,0.00),\n		0))\n			,2),0.00) as \'Principal Write Off\'\nfrom m_office o\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\n                          and ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_client c on c.office_id = ounder.id\njoin m_loan l on l.client_id = c.id\njoin m_product_loan lp on lp.id = l.product_id\njoin m_loan_transaction txn on txn.loan_id = l.id\nleft join m_currency cur on cur.code = l.currency_code\nwhere txn.is_reversed = false\nand txn.transaction_type_enum not in (10,11)\nand o.id = ${officeId}\nand txn.transaction_date < date(\'${startDate}\')\n\nunion all\n\nselect x.`Transaction Date`, x.`Transaction Type`, x.Office, x.`Loan Officer`, x.`Loan Account No`, x.`Loan Product`, x.`Currency`,\n	x.`Client Account No`, x.Client, x.Amount, x.Principal, x.Interest,\ncast(round(\n	if (x.transaction_type_enum = 1 /* disbursement */,\n		@totalOutstandingPrincipal := @totalOutstandingPrincipal + x.`Amount`,\n		@totalOutstandingPrincipal := @totalOutstandingPrincipal - x.`Principal`)\n			,2) as decimal(19,2)) as \'Outstanding Principal\',\ncast(round(\n	if (x.transaction_type_enum in (2,5,8) /* repayment, repayment at disbursal, recovery repayment */,\n		@totalInterestIncome := @totalInterestIncome + x.`Interest`,\n		@totalInterestIncome)\n			,2) as decimal(19,2)) as \'Interest Income\',\ncast(round(\n	if (x.transaction_type_enum = 6 /* write-off */,\n		@totalWriteOff := @totalWriteOff + x.`Principal`,\n		@totalWriteOff)\n			,2) as decimal(19,2)) as \'Principal Write Off\'\nfrom\n(select txn.transaction_type_enum, txn.id as txn_id, txn.transaction_date as \'Transaction Date\',\ncast(\n	ifnull(re.enum_message_property, concat(\'Unknown Transaction Type Value: \' , txn.transaction_type_enum))\n	as char) as \'Transaction Type\',\nounder.`name` as Office, lo.display_name as \'Loan Officer\',\nl.account_no  as \'Loan Account No\', lp.`name` as \'Loan Product\',\nifnull(cur.display_symbol, l.currency_code) as Currency,\nc.account_no as \'Client Account No\', c.display_name as \'Client\',\nifnull(txn.amount,0.00) as Amount,\nifnull(txn.principal_portion_derived,0.00) as Principal,\nifnull(txn.interest_portion_derived,0.00) as Interest\nfrom m_office o\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\n                          and ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_client c on c.office_id = ounder.id\njoin m_loan l on l.client_id = c.id\nleft join m_staff lo on lo.id = l.loan_officer_id\njoin m_product_loan lp on lp.id = l.product_id\njoin m_loan_transaction txn on txn.loan_id = l.id\nleft join m_currency cur on cur.code = l.currency_code\nleft join r_enum_value re on re.enum_name = \'transaction_type_enum\'\n						and re.enum_id = txn.transaction_type_enum\nwhere txn.is_reversed = false\nand txn.transaction_type_enum not in (10,11)\nand (ifnull(l.loan_officer_id, -10) = \'${loanOfficerId}\' or \'-1\' = \'${loanOfficerId}\')\nand o.id = ${officeId}\nand txn.transaction_date >= date(\'${startDate}\')\nand txn.transaction_date <= date(\'${endDate}\')\norder by txn.transaction_date, txn.id) x\n','Running Balance Txn report for Individual Lending.\nSuitable for small MFI\'s.  Larger could use it using the branch or other parameters.\nBasically, suck it and see if its quick enough for you out-of-te box or whether it needs performance work in your situation.\n',0,0),(107,'FieldAgentStats','Table',NULL,'Quipo','\nselect ifnull(cur.display_symbol, l.currency_code) as Currency,\n/*This query will return more than one entry if more than one currency is used */\ncount(distinct(c.id)) as activeClients, count(*) as activeLoans,\nsum(l.principal_disbursed_derived) as disbursedAmount,\nsum(l.principal_outstanding_derived) as loanOutstandingAmount,\nround((sum(l.principal_outstanding_derived) * 100) /  sum(l.principal_disbursed_derived),2) as loanOutstandingPC,\nsum(ifnull(lpa.principal_in_advance_derived,0.0)) as LoanPaidInAdvance,\nsum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) as portfolioAtRisk,\n\nround((sum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) * 100) / sum(l.principal_outstanding_derived), 2) as portfolioAtRiskPC,\n\ncount(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) as clientsInDefault,\nround((count(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) * 100) / count(distinct(c.id)),2) as clientsInDefaultPC,\n(sum(l.principal_disbursed_derived) / count(*))  as averageLoanAmount\nfrom m_staff fa\njoin m_office o on o.id = fa.office_id\n			and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_group pgm on pgm.staff_id = fa.id\njoin m_loan l on l.group_id = pgm.id and l.client_id is not null\nleft join m_currency cur on cur.code = l.currency_code\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nleft join m_loan_paid_in_advance lpa on lpa.loan_id = l.id\njoin m_client c on c.id = l.client_id\nwhere fa.id = ${staffId}\nand l.loan_status_id = 300\ngroup  by l.currency_code\n','Field Agent Statistics',0,0),(108,'FieldAgentPrograms','Table',NULL,'Quipo','\nselect pgm.id, pgm.display_name as `name`, sts.enum_message_property as status\n from m_group pgm\n join m_office o on o.id = pgm.office_id\n			and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\n left join r_enum_value sts on sts.enum_name = \'status_enum\' and sts.enum_id = pgm.status_enum\n where pgm.staff_id = ${staffId}\n','List of Field Agent Programs',0,0),(109,'ProgramDetails','Table',NULL,'Quipo','\n select l.id as loanId, l.account_no as loanAccountNo, c.id as clientId, c.account_no as clientAccountNo,\n pgm.display_name as programName,\n\n(select count(*)\nfrom m_loan cy\nwhere cy.group_id = pgm.id and cy.client_id =c.id\nand cy.disbursedon_date <= l.disbursedon_date) as loanCycleNo,\n\nc.display_name as clientDisplayName,\n ifnull(cur.display_symbol, l.currency_code) as Currency,\nifnull(l.principal_repaid_derived,0.0) as loanRepaidAmount,\nifnull(l.principal_outstanding_derived, 0.0) as loanOutstandingAmount,\nifnull(lpa.principal_in_advance_derived,0.0) as LoanPaidInAdvance,\n\nifnull(laa.principal_overdue_derived, 0.0) as loanInArrearsAmount,\nif(ifnull(laa.principal_overdue_derived, 0.00) > 0, \'Yes\', \'No\') as inDefault,\n\nif(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)  as portfolioAtRisk\n\n from m_group pgm\n join m_office o on o.id = pgm.office_id\n			and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\n join m_loan l on l.group_id = pgm.id and l.client_id is not null\n left join m_currency cur on cur.code = l.currency_code\n join m_client c on c.id = l.client_id\n left join m_loan_arrears_aging laa on laa.loan_id = l.id\n left join m_loan_paid_in_advance lpa on lpa.loan_id = l.id\n where pgm.id = ${programId}\n and l.loan_status_id = 300\norder by c.display_name, l.account_no\n\n','List of Loans in a Program',0,0),(110,'ChildrenStaffList','Table',NULL,'Quipo','\n select s.id, s.display_name,\ns.firstname, s.lastname, s.organisational_role_enum,\ns.organisational_role_parent_staff_id,\nsp.display_name as `organisational_role_parent_staff_display_name`\nfrom m_staff s\njoin m_staff sp on s.organisational_role_parent_staff_id = sp.id\nwhere s.organisational_role_parent_staff_id = ${staffId}\n','Get Next Level Down Staff',0,0),(111,'CoordinatorStats','Table',NULL,'Quipo','\nselect ifnull(cur.display_symbol, l.currency_code) as Currency,\n/*This query will return more than one entry if more than one currency is used */\ncount(distinct(c.id)) as activeClients, count(*) as activeLoans,\nsum(l.principal_disbursed_derived) as disbursedAmount,\nsum(l.principal_outstanding_derived) as loanOutstandingAmount,\nround((sum(l.principal_outstanding_derived) * 100) /  sum(l.principal_disbursed_derived),2) as loanOutstandingPC,\nsum(ifnull(lpa.principal_in_advance_derived,0.0)) as LoanPaidInAdvance,\nsum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) as portfolioAtRisk,\n\nround((sum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) * 100) / sum(l.principal_outstanding_derived), 2) as portfolioAtRiskPC,\n\ncount(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) as clientsInDefault,\nround((count(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) * 100) / count(distinct(c.id)),2) as clientsInDefaultPC,\n(sum(l.principal_disbursed_derived) / count(*))  as averageLoanAmount\nfrom m_staff coord\njoin m_staff fa on fa.organisational_role_parent_staff_id = coord.id\njoin m_office o on o.id = fa.office_id\n			and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_group pgm on pgm.staff_id = fa.id\njoin m_loan l on l.group_id = pgm.id and l.client_id is not null\nleft join m_currency cur on cur.code = l.currency_code\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nleft join m_loan_paid_in_advance lpa on lpa.loan_id = l.id\njoin m_client c on c.id = l.client_id\nwhere coord.id = ${staffId}\nand l.loan_status_id = 300\ngroup  by l.currency_code\n','Coordinator Statistics',0,0),(112,'BranchManagerStats','Table',NULL,'Quipo','\nselect ifnull(cur.display_symbol, l.currency_code) as Currency,\n/*This query will return more than one entry if more than one currency is used */\ncount(distinct(c.id)) as activeClients, count(*) as activeLoans,\nsum(l.principal_disbursed_derived) as disbursedAmount,\nsum(l.principal_outstanding_derived) as loanOutstandingAmount,\nround((sum(l.principal_outstanding_derived) * 100) /  sum(l.principal_disbursed_derived),2) as loanOutstandingPC,\nsum(ifnull(lpa.principal_in_advance_derived,0.0)) as LoanPaidInAdvance,\nsum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) as portfolioAtRisk,\n\nround((sum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) * 100) / sum(l.principal_outstanding_derived), 2) as portfolioAtRiskPC,\n\ncount(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) as clientsInDefault,\nround((count(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) * 100) / count(distinct(c.id)),2) as clientsInDefaultPC,\n(sum(l.principal_disbursed_derived) / count(*))  as averageLoanAmount\nfrom m_staff bm\njoin m_staff coord on coord.organisational_role_parent_staff_id = bm.id\njoin m_staff fa on fa.organisational_role_parent_staff_id = coord.id\njoin m_office o on o.id = fa.office_id\n			and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_group pgm on pgm.staff_id = fa.id\njoin m_loan l on l.group_id = pgm.id and l.client_id is not null\nleft join m_currency cur on cur.code = l.currency_code\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nleft join m_loan_paid_in_advance lpa on lpa.loan_id = l.id\njoin m_client c on c.id = l.client_id\nwhere bm.id = ${staffId}\nand l.loan_status_id = 300\ngroup  by l.currency_code\n','Branch Manager Statistics',0,0),(113,'ProgramDirectorStats','Table',NULL,'Quipo','\nselect ifnull(cur.display_symbol, l.currency_code) as Currency,\n/*This query will return more than one entry if more than one currency is used */\ncount(distinct(c.id)) as activeClients, count(*) as activeLoans,\nsum(l.principal_disbursed_derived) as disbursedAmount,\nsum(l.principal_outstanding_derived) as loanOutstandingAmount,\nround((sum(l.principal_outstanding_derived) * 100) /  sum(l.principal_disbursed_derived),2) as loanOutstandingPC,\nsum(ifnull(lpa.principal_in_advance_derived,0.0)) as LoanPaidInAdvance,\nsum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) as portfolioAtRisk,\n\nround((sum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) * 100) / sum(l.principal_outstanding_derived), 2) as portfolioAtRiskPC,\n\ncount(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) as clientsInDefault,\nround((count(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) * 100) / count(distinct(c.id)),2) as clientsInDefaultPC,\n(sum(l.principal_disbursed_derived) / count(*))  as averageLoanAmount\nfrom m_staff pd\njoin m_staff bm on bm.organisational_role_parent_staff_id = pd.id\njoin m_staff coord on coord.organisational_role_parent_staff_id = bm.id\njoin m_staff fa on fa.organisational_role_parent_staff_id = coord.id\njoin m_office o on o.id = fa.office_id\n			and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_group pgm on pgm.staff_id = fa.id\njoin m_loan l on l.group_id = pgm.id and l.client_id is not null\nleft join m_currency cur on cur.code = l.currency_code\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nleft join m_loan_paid_in_advance lpa on lpa.loan_id = l.id\njoin m_client c on c.id = l.client_id\nwhere pd.id = ${staffId}\nand l.loan_status_id = 300\ngroup  by l.currency_code\n','Program DirectorStatistics',0,0),(114,'ProgramStats','Table',NULL,'Quipo','\nselect ifnull(cur.display_symbol, l.currency_code) as Currency,\n/*This query will return more than one entry if more than one currency is used */\ncount(distinct(c.id)) as activeClients, count(*) as activeLoans,\nsum(l.principal_disbursed_derived) as disbursedAmount,\nsum(l.principal_outstanding_derived) as loanOutstandingAmount,\nround((sum(l.principal_outstanding_derived) * 100) /  sum(l.principal_disbursed_derived),2) as loanOutstandingPC,\nsum(ifnull(lpa.principal_in_advance_derived,0.0)) as LoanPaidInAdvance,\nsum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) as portfolioAtRisk,\n\nround((sum(\n	if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n		l.principal_outstanding_derived,0)) * 100) / sum(l.principal_outstanding_derived), 2) as portfolioAtRiskPC,\n\ncount(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) as clientsInDefault,\nround((count(distinct(\n		if(date_sub(curdate(), interval 28 day) > ifnull(laa.overdue_since_date_derived, curdate()),\n			c.id,null))) * 100) / count(distinct(c.id)),2) as clientsInDefaultPC,\n(sum(l.principal_disbursed_derived) / count(*))  as averageLoanAmount\nfrom m_group pgm\njoin m_office o on o.id = pgm.office_id\n			and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_loan l on l.group_id = pgm.id and l.client_id is not null\nleft join m_currency cur on cur.code = l.currency_code\nleft join m_loan_arrears_aging laa on laa.loan_id = l.id\nleft join m_loan_paid_in_advance lpa on lpa.loan_id = l.id\njoin m_client c on c.id = l.client_id\nwhere pgm.id = ${programId}\nand l.loan_status_id = 300\ngroup  by l.currency_code\n','Program Statistics',0,0),(115,'ClientSummary ','Table',NULL,NULL,'SELECT x.* FROM m_client c, m_office o, \n(\n       SELECT a.loanCycle, a.activeLoans, b.lastLoanAmount, d.activeSavings, d.totalSavings FROM \n	(SELECT IFNULL(MAX(l.loan_counter),0) AS loanCycle, COUNT(l.id) AS activeLoans FROM m_loan l WHERE l.loan_status_id=300 AND l.client_id=${clientId}) a, \n	(SELECT count(l.id), IFNULL(l.principal_amount,0) AS \'lastLoanAmount\' FROM m_loan l WHERE l.client_id=${clientId} AND l.disbursedon_date = (SELECT IFNULL(MAX(disbursedon_date),NOW()) FROM m_loan where client_id=${clientId} and loan_status_id=300)) b, \n	(SELECT COUNT(s.id) AS \'activeSavings\', IFNULL(SUM(s.account_balance_derived),0) AS \'totalSavings\' FROM m_savings_account s WHERE s.status_enum=300 AND s.client_id=${clientId}) d\n) x\nWHERE c.id=${clientId} AND o.id = c.office_id AND o.hierarchy LIKE CONCAT(\'${currentUserHierarchy}\', \'%\')','Utility query for getting the client summary details',1,0),(116,'LoanCyclePerProduct','Table',NULL,NULL,'SELECT lp.name AS \'productName\', MAX(l.loan_product_counter) AS \'loanProductCycle\' FROM m_loan l JOIN m_product_loan lp ON l.product_id=lp.id WHERE lp.include_in_borrower_cycle=1 AND l.loan_product_counter IS NOT NULL AND l.client_id=${clientId} GROUP BY l.product_id','Utility query for getting the client loan cycle details',1,0),(117,'GroupSavingSummary','Table',NULL,NULL,'select ifnull(cur.display_symbol, sa.currency_code) as currency,\ncount(sa.id) as totalSavingAccounts, ifnull(sum(sa.account_balance_derived),0) as totalSavings\nfrom m_group topgroup\njoin m_office o on o.id = topgroup.office_id and o.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\njoin m_group g on g.hierarchy like concat(topgroup.hierarchy, \'%\')\njoin m_savings_account sa on sa.group_id = g.id\nleft join m_currency cur on cur.code = sa.currency_code\nwhere topgroup.id = ${groupId}\nand sa.activatedon_date is not null\ngroup by sa.currency_code','Utility query for getting group or center saving summary details for a group_id',1,0),(118,'Savings Transactions','Pentaho',NULL,'Savings',NULL,NULL,0,1),(119,'Client Savings Summary','Pentaho',NULL,'Savings',NULL,NULL,0,1),(120,'Active Loans - Details(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(121,'Active Loans - Summary(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(122,'Active Loans by Disbursal Period(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(123,'Active Loans in last installment Summary(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(124,'Active Loans in last installment(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(125,'Active Loans Passed Final Maturity Summary(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(126,'Active Loans Passed Final Maturity(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(127,'Aging Detail(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(128,'Aging Summary (Arrears in Months)(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(129,'Aging Summary (Arrears in Weeks)(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(130,'Client Listing(Pentaho)','Pentaho',NULL,'Client','(NULL)','(NULL)',1,1),(131,'Client Loans Listing(Pentaho)','Pentaho',NULL,'Client','(NULL)','(NULL)',1,1),(132,'Expected Payments By Date - Basic(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(133,'Funds Disbursed Between Dates Summary by Office(Pentaho)','Pentaho',NULL,'Fund','(NULL)','(NULL)',1,1),(134,'Funds Disbursed Between Dates Summary(Pentaho)','Pentaho',NULL,'Fund','(NULL)','(NULL)',1,1),(135,'Loans Awaiting Disbursal Summary by Month(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(136,'Loans Awaiting Disbursal Summary(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(137,'Loans Awaiting Disbursal(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(138,'Loans Pending Approval(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(139,'Obligation Met Loans Details(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(140,'Obligation Met Loans Summary(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(141,'Portfolio at Risk by Branch(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(142,'Portfolio at Risk(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(143,'Rescheduled Loans(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(144,'TxnRunningBalances(Pentaho)','Pentaho',NULL,'Transaction','(NULL)','(NULL)',1,1),(145,'Written-Off Loans(Pentaho)','Pentaho',NULL,'Loan','(NULL)','(NULL)',1,1),(146,'Client Saving Transactions','Pentaho',NULL,'Savings',NULL,NULL,0,0),(147,'Client Loan Account Schedule','Pentaho',NULL,'Loans',NULL,NULL,0,0),(148,'GroupNamesByStaff','Table','','','Select gr.id as id, gr.display_name as name from m_group gr where gr.level_id=1 and gr.staff_id = ${staffId}','',1,0),(149,'ClientTrendsByDay','Table','','Client','SELECT 	COUNT(cl.id) AS count, \n		cl.activation_date AS days\nFROM m_office of \n	LEFT JOIN m_client cl on of.id = cl.office_id\nWHERE of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" ) \n	AND (cl.activation_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 DAY) AND DATE(NOW()- INTERVAL 1 DAY))\nGROUP BY days','Retrieves the number of clients joined in last 12 days',1,0),(150,'ClientTrendsByWeek','Table','','Client','SELECT 	COUNT(cl.id) AS count, \n		WEEK(cl.activation_date) AS Weeks\nFROM m_office of \n	LEFT JOIN m_client cl on of.id = cl.office_id\nWHERE of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" ) \n	AND (cl.activation_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 WEEK) AND DATE(NOW()))\nGROUP BY Weeks','',1,0),(151,'ClientTrendsByMonth','Table','','Client','SELECT 	COUNT(cl.id) AS count, \n		MONTHNAME(cl.activation_date) AS Months\nFROM m_office of \n	LEFT JOIN m_client cl on of.id = cl.office_id\nWHERE of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" ) \n	AND (cl.activation_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 MONTH) AND DATE(NOW()))\nGROUP BY Months','',1,0),(152,'LoanTrendsByDay','Table','','Loan','SELECT 	COUNT(ln.id) AS lcount, \n		ln.disbursedon_date AS days\nFROM m_office of \n	LEFT JOIN m_client cl on of.id = cl.office_id\n	LEFT JOIN m_loan ln on cl.id = ln.client_id\nWHERE of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" ) \n	AND (ln.disbursedon_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 DAY) AND DATE(NOW()- INTERVAL 1 DAY))\nGROUP BY days','Retrieves Number of loans disbursed for last 12 days',1,0),(153,'LoanTrendsByWeek','Table','','Loan','SELECT 	COUNT(ln.id) AS lcount, \n		WEEK(ln.disbursedon_date) AS Weeks\nFROM m_office of \n	LEFT JOIN m_client cl on of.id = cl.office_id\n	LEFT JOIN m_loan ln on cl.id = ln.client_id\nWHERE of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" ) \n	AND (ln.disbursedon_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 WEEK) AND DATE(NOW()))\nGROUP BY Weeks','',1,0),(154,'LoanTrendsByMonth','Table','','Loan','SELECT 	COUNT(ln.id) AS lcount, \n		MONTHNAME(ln.disbursedon_date) AS Months\nFROM m_office of \n	LEFT JOIN m_client cl on of.id = cl.office_id\n	LEFT JOIN m_loan ln on cl.id = ln.client_id\nWHERE of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" ) \n	AND (ln.disbursedon_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 MONTH) AND DATE(NOW()))\nGROUP BY Months','',1,0),(155,'Demand_Vs_Collection','Table','','Loan','select amount.AmountDue-amount.AmountPaid as AmountDue, amount.AmountPaid as AmountPaid from\n(SELECT \n(IFNULL(SUM(ls.principal_amount),0) - IFNULL(SUM(ls.principal_writtenoff_derived),0)\n + IFNULL(SUM(ls.interest_amount),0) - IFNULL(SUM(ls.interest_writtenoff_derived),0) \n - IFNULL(SUM(ls.interest_waived_derived),0)\n + IFNULL(SUM(ls.fee_charges_amount),0) - IFNULL(SUM(ls.fee_charges_writtenoff_derived),0) \n - IFNULL(SUM(ls.fee_charges_waived_derived),0)\n + IFNULL(SUM(ls.penalty_charges_amount),0) - IFNULL(SUM(ls.penalty_charges_writtenoff_derived),0) \n - IFNULL(SUM(ls.penalty_charges_waived_derived),0)\n) AS AmountDue, \n\n(IFNULL(SUM(ls.principal_completed_derived),0) - IFNULL(SUM(ls.principal_writtenoff_derived),0) + IFNULL(SUM(ls.interest_completed_derived),0) - IFNULL(SUM(ls.interest_writtenoff_derived),0) \n - IFNULL(SUM(ls.interest_waived_derived),0)\n + IFNULL(SUM(ls.fee_charges_completed_derived),0) - IFNULL(SUM(ls.fee_charges_writtenoff_derived),0) \n - IFNULL(SUM(ls.fee_charges_waived_derived),0)\n + IFNULL(SUM(ls.penalty_charges_completed_derived),0) - IFNULL(SUM(ls.penalty_charges_writtenoff_derived),0) \n - IFNULL(SUM(ls.penalty_charges_waived_derived),0)\n) AS AmountPaid\nFROM m_office of\nLEFT JOIN m_client cl ON of.id = cl.office_id\nLEFT JOIN m_loan ln ON cl.id = ln.client_id\nLEFT JOIN m_loan_repayment_schedule ls ON ln.id = ls.loan_id\nWHERE ls.duedate = DATE(NOW()) AND \n (of.hierarchy LIKE CONCAT((\nSELECT ino.hierarchy\nFROM m_office ino\nWHERE ino.id = ${officeId}),\"%\"))) as amount','Demand Vs Collection',1,0),(156,'Disbursal_Vs_Awaitingdisbursal','Table','','Loan','select awaitinddisbursal.amount-disbursedAmount.amount as amountToBeDisburse, disbursedAmount.amount as disbursedAmount from \n(\nSELECT 	COUNT(ln.id) AS noOfLoans, \n			IFNULL(SUM(ln.principal_amount),0) AS amount\nFROM \nm_office of\nLEFT JOIN m_client cl ON cl.office_id = of.id\nLEFT JOIN m_loan ln ON cl.id = ln.client_id\nWHERE \nln.expected_disbursedon_date = DATE(NOW()) AND \n(ln.loan_status_id=200 OR ln.loan_status_id=300) AND\n of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" )\n) awaitinddisbursal,\n(\nSELECT 	COUNT(ltrxn.id) as count, \n			IFNULL(SUM(ltrxn.amount),0) as amount \nFROM \nm_office of\nLEFT JOIN m_client cl ON cl.office_id = of.id\nLEFT JOIN m_loan ln ON cl.id = ln.client_id\nLEFT JOIN m_loan_transaction ltrxn ON ln.id = ltrxn.loan_id\nWHERE \nltrxn.transaction_date = DATE(NOW()) AND \nltrxn.is_reversed = 0 AND\nltrxn.transaction_type_enum=1 AND\n of.hierarchy like concat((select ino.hierarchy from m_office ino where ino.id = ${officeId}),\"%\" ) \n) disbursedAmount','Disbursal_Vs_Awaitingdisbursal',1,0),(157,'Savings Transaction Receipt','Pentaho',NULL,NULL,NULL,NULL,0,1),(158,'Loan Transaction Receipt','Pentaho',NULL,NULL,NULL,NULL,0,1),(159,'Staff Assignment History','Pentaho',NULL,NULL,NULL,NULL,0,1),(160,'GeneralLedgerReport','Pentaho',NULL,'Accounting',NULL,NULL,0,1),(161,'Active Loan Summary per Branch','Pentaho',NULL,'Loans',NULL,NULL,0,1),(162,'Balance Outstanding','Pentaho',NULL,'Loans',NULL,NULL,0,1),(163,'Collection Report','Pentaho',NULL,'Loans',NULL,NULL,0,1),(164,'Disbursal Report','Pentaho',NULL,'Loans',NULL,NULL,0,1),(165,'Savings Accounts Dormancy Report','Table',NULL,'Savings','select cl.display_name as \'Client Display Name\',\r\nsa.account_no as \'Account Number\',\r\ncl.mobile_no as \'Mobile Number\',\r\n@lastdate:=(select IFNULL(max(sat.transaction_date),sa.activatedon_date) \r\n            from m_savings_account_transaction as sat \r\n            where sat.is_reversed = 0 \r\n            and sat.transaction_type_enum in (1,2) \r\n            and sat.savings_account_id = sa.id) as \'Date of Last Activity\',\r\nDATEDIFF(now(), @lastdate) as \'Days Since Last Activity\'\r\nfrom m_savings_account as sa \r\ninner join m_savings_product as sp on (sa.product_id = sp.id and sp.is_dormancy_tracking_active = 1) \r\nleft join m_client as cl on sa.client_id = cl.id \r\nwhere sa.sub_status_enum = ${subStatus}\r\nand cl.office_id = ${officeId}',NULL,1,1),(166,'Active Clients','SMS','NonTriggered','Clients','SELECT c.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\r\nREPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \r\no.id AS \"officeNumber\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nLEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\r\nWHERE o.id = ${officeId} AND c.status_enum = 300 AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId})\r\nGROUP BY c.id\r\nORDER BY ounder.hierarchy, c.account_no','All clients with the status ‘Active’',0,1),(167,'Prospective Clients','SMS','NonTriggered','Clients','SELECT c.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\r\nREPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \r\no.id AS \"officeNumber\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nLEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\r\nLEFT JOIN m_loan l ON l.client_id = c.id\r\nWHERE o.id = ${officeId} AND c.status_enum = 300 AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND l.client_id IS NULL\r\nGROUP BY c.id\r\nORDER BY ounder.hierarchy, c.account_no','All clients with the status ‘Active’ who have never had a loan before',0,1),(168,'Active Loan Clients','SMS','NonTriggered','Clients','SELECT \r\nc.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", \r\nl.principal_amount AS \"loanAmount\", \r\n(IFNULL(l.principal_outstanding_derived, 0) + IFNULL(l.interest_outstanding_derived, 0) + IFNULL(l.fee_charges_outstanding_derived, 0) + IFNULL(l.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nl.principal_disbursed_derived AS \"loanDisbursed\",\r\nounder.id AS \"officeNumber\", \r\nl.account_no AS \"loanAccountId\", \r\ngua.lastname AS \"guarantorLastName\", COUNT(gua.id) AS \"numberOfGuarantors\",\r\ng.display_name AS \"groupName\"\r\n\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_loan l ON l.client_id = c.id\r\nJOIN m_product_loan pl ON pl.id = l.product_id\r\nLEFT JOIN m_group_client gc ON gc.client_id = c.id\r\nLEFT JOIN m_group g ON g.id = gc.group_id\r\nLEFT JOIN m_staff lo ON lo.id = l.loan_officer_id\r\nLEFT JOIN m_currency cur ON cur.code = l.currency_code\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = l.id\r\nWHERE o.id = ${officeId} AND (IFNULL(l.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND l.loan_status_id = 300 AND (DATEDIFF(CURDATE(), l.disbursedon_date) BETWEEN ${cycleX} AND ${cycleY})\r\nGROUP BY l.id\r\nORDER BY ounder.hierarchy, l.currency_code, c.account_no, l.account_no','All clients with an outstanding loan between cycleX and cycleY days',0,1),(169,'Loan in arrears','SMS','NonTriggered','Loan','SELECT \r\nmc.id AS \"id\", \r\nmc.firstname AS \"firstName\",\r\nmc.middlename AS \"middleName\",\r\nmc.lastname AS \"lastName\",\r\nmc.display_name AS \"fullName\",\r\nmc.mobile_no AS \"mobileNo\", \r\nml.principal_amount AS \"loanAmount\", \r\n(IFNULL(ml.principal_outstanding_derived, 0) + IFNULL(ml.interest_outstanding_derived, 0) + IFNULL(ml.fee_charges_outstanding_derived, 0) + IFNULL(ml.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nml.principal_disbursed_derived AS \"loanDisbursed\",\r\nlaa.overdue_since_date_derived AS \"paymentDueDate\",\r\nIFNULL(laa.total_overdue_derived, 0) AS \"totalDue\",\r\nounder.id AS \"officeNumber\", \r\nml.account_no AS \"loanAccountId\", \r\ngua.lastname AS \"guarantorLastName\", \r\nCOUNT(gua.id) AS \"numberOfGuarantors\",\r\ng.display_name AS \"groupName\"\r\n\r\nFROM m_office mo\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\')\r\nINNER JOIN m_client mc ON mc.office_id=ounder.id\r\nINNER JOIN m_loan ml ON ml.client_id = mc.id\r\nINNER JOIN r_enum_value rev ON rev.enum_id=ml.loan_status_id AND rev.enum_name = \'loan_status_id\'\r\nINNER JOIN m_loan_arrears_aging laa ON laa.loan_id=ml.id\r\nLEFT JOIN m_currency cur ON cur.code = ml.currency_code\r\nLEFT JOIN m_group_client gc ON gc.client_id = mc.id\r\nLEFT JOIN m_group g ON g.id = gc.group_id\r\nLEFT JOIN m_staff lo ON lo.id = ml.loan_officer_id\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = ml.id\r\nWHERE ml.loan_status_id=300 AND mo.id=${officeId} AND (IFNULL(ml.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND (DATEDIFF(CURDATE(), laa.overdue_since_date_derived) BETWEEN ${fromX} AND ${toY})\r\nGROUP BY ml.id\r\nORDER BY ounder.hierarchy, ml.currency_code, mc.account_no, ml.account_no','All clients with an outstanding loan in arrears between fromX and toY days',0,1),(170,'Loan payments due','SMS','NonTriggered','Loan','SELECT \r\ncl.id AS \"id\", \r\ncl.firstname AS \"firstName\",\r\ncl.middlename AS \"middleName\",\r\ncl.lastname AS \"lastName\",\r\ncl.display_name AS \"fullName\",\r\ncl.mobile_no AS \"mobileNo\", \r\nl.principal_amount AS \"loanAmount\",\r\nof.id AS \"officeNumber\",\r\n(IFNULL(l.principal_outstanding_derived, 0) + IFNULL(l.interest_outstanding_derived, 0) + IFNULL(l.fee_charges_outstanding_derived, 0) + IFNULL(l.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nl.principal_disbursed_derived AS \"loanDisbursed\",\r\nls.duedate AS \"paymentDueDate\",\r\n(IFNULL(SUM(ls.principal_amount),0) - IFNULL(SUM(ls.principal_writtenoff_derived),0)\r\n + IFNULL(SUM(ls.interest_amount),0) - IFNULL(SUM(ls.interest_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.interest_waived_derived),0)\r\n + IFNULL(SUM(ls.fee_charges_amount),0) - IFNULL(SUM(ls.fee_charges_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.fee_charges_waived_derived),0)\r\n + IFNULL(SUM(ls.penalty_charges_amount),0) - IFNULL(SUM(ls.penalty_charges_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.penalty_charges_waived_derived),0)\r\n) AS \"totalDue\",\r\nlaa.total_overdue_derived AS \"totalOverdue\",\r\nl.account_no AS \"loanAccountId\",\r\ngua.lastname AS \"guarantorLastName\",\r\nCOUNT(gua.id) AS \"numberOfGuarantors\",\r\ngp.display_name AS \"groupName\"\r\n\r\nFROM m_office of\r\nLEFT JOIN m_client cl ON of.id = cl.office_id\r\nLEFT JOIN m_loan l ON cl.id = l.client_id\r\nLEFT JOIN m_group_client gc ON gc.client_id = cl.id\r\nLEFT JOIN m_group gp ON gp.id = l.group_id\r\nLEFT JOIN m_loan_repayment_schedule ls ON l.id = ls.loan_id\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = l.id\r\nINNER JOIN m_loan_arrears_aging laa ON laa.loan_id=l.id\r\nWHERE of.id = ${officeId} AND (IFNULL(l.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND (DATEDIFF(CURDATE(), ls.duedate) BETWEEN ${fromX} AND ${toY}) \r\nAND (of.hierarchy LIKE CONCAT((\r\nSELECT ino.hierarchy\r\nFROM m_office ino\r\nWHERE ino.id = ${officeId}),\"%\"))\r\nGROUP BY l.id\r\nORDER BY of.hierarchy, l.currency_code, cl.account_no, l.account_no','All clients with an unpaid installment due on their loan between fromX and toY days',0,1),(171,'Dormant Prospects','SMS','NonTriggered','Clients','SELECT c.id AS \"id\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\r\nREPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\",  \r\no.id AS \"officeNumber\", \r\nTIMESTAMPDIFF(MONTH, c.activation_date, CURDATE()) AS \"dormant\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nLEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\r\nLEFT JOIN m_loan l ON l.client_id = c.id\r\nWHERE o.id = ${officeId} AND c.status_enum = 300 AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND l.client_id IS NULL AND (TIMESTAMPDIFF(MONTH, c.activation_date, CURDATE()) > 3)\r\nGROUP BY c.id\r\nORDER BY ounder.hierarchy, c.account_no','All individuals who have not yet received a loan but were also entered into the system more than 3 months',0,1),(172,'Active group leaders','SMS','NonTriggered','Clients','SELECT c.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\r\nREPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \r\no.id AS \"officeNumber\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_group g ON g.office_id = ounder.id\r\nJOIN m_client c ON c.office_id = ounder.id\r\nLEFT JOIN m_group_client gc ON gc.group_id = g.id AND gc.client_id = c.id\r\nLEFT JOIN m_group_roles gr ON gr.group_id = g.id AND gr.client_id = c.id\r\nLEFT JOIN m_staff ms ON ms.id = c.staff_id\r\nLEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\r\nLEFT JOIN m_code_value cv ON cv.id = gr.role_cv_id\r\nLEFT JOIN m_code code ON code.id = cv.code_id\r\nWHERE o.id = ${officeId} AND g.status_enum = 300 AND c.status_enum = 300  AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND code.code_name = \'GROUPROLE\' AND cv.code_value = \'Leader\'\r\nGROUP BY c.id\r\nORDER BY ounder.hierarchy, c.account_no','All active group chairmen',0,1),(173,'Loan payments due (Overdue Loans)','SMS','NonTriggered','Loan','SELECT \r\nmc.id AS \"id\", \r\nmc.firstname AS \"firstName\",\r\nmc.middlename AS \"middleName\",\r\nmc.lastname AS \"lastName\",\r\nmc.display_name AS \"fullName\",\r\nmc.mobile_no AS \"mobileNo\", \r\nml.principal_amount AS \"loanAmount\", \r\n(IFNULL(ml.principal_outstanding_derived, 0) + IFNULL(ml.interest_outstanding_derived, 0) + IFNULL(ml.fee_charges_outstanding_derived, 0) + IFNULL(ml.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nml.principal_disbursed_derived AS \"loanDisbursed\",\r\nlaa.overdue_since_date_derived AS \"paymentDueDate\",\r\n(IFNULL(SUM(ls.principal_amount),0) - IFNULL(SUM(ls.principal_writtenoff_derived),0)\r\n + IFNULL(SUM(ls.interest_amount),0) - IFNULL(SUM(ls.interest_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.interest_waived_derived),0)\r\n + IFNULL(SUM(ls.fee_charges_amount),0) - IFNULL(SUM(ls.fee_charges_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.fee_charges_waived_derived),0)\r\n + IFNULL(SUM(ls.penalty_charges_amount),0) - IFNULL(SUM(ls.penalty_charges_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.penalty_charges_waived_derived),0)\r\n) AS \"totalDue\",\r\nlaa.total_overdue_derived AS \"totalOverdue\",\r\nounder.id AS \"officeNumber\", \r\nml.account_no AS \"loanAccountId\", \r\ngua.lastname AS \"guarantorLastName\", \r\nCOUNT(gua.id) AS \"numberOfGuarantors\",\r\ng.display_name AS \"groupName\"\r\n\r\nFROM m_office mo\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\')\r\nINNER JOIN m_client mc ON mc.office_id=ounder.id\r\nINNER JOIN m_loan ml ON ml.client_id = mc.id\r\nINNER JOIN r_enum_value rev ON rev.enum_id=ml.loan_status_id AND rev.enum_name = \'loan_status_id\'\r\nINNER JOIN m_loan_arrears_aging laa ON laa.loan_id=ml.id\r\nLEFT JOIN m_loan_repayment_schedule ls ON ls.loan_id = ml.id\r\nLEFT JOIN m_currency cur ON cur.code = ml.currency_code\r\nLEFT JOIN m_group_client gc ON gc.client_id = mc.id\r\nLEFT JOIN m_group g ON g.id = gc.group_id\r\nLEFT JOIN m_staff lo ON lo.id = ml.loan_officer_id\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = ml.id\r\nWHERE ml.loan_status_id=300 AND mo.id=${officeId} AND (IFNULL(ml.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) \r\nAND (DATEDIFF(CURDATE(), ls.duedate) BETWEEN ${fromX} AND ${toY})\r\nAND (DATEDIFF(CURDATE(), laa.overdue_since_date_derived) BETWEEN ${overdueX} AND ${overdueY})\r\nGROUP BY ml.id\r\nORDER BY ounder.hierarchy, ml.currency_code, mc.account_no, ml.account_no','Loan Payments Due between fromX to toY days for clients in arrears between overdueX and overdueY days',0,1),(174,'Loan payments received (Active Loans)','SMS','NonTriggered','Loan','SELECT \r\nmc.id AS \"id\", \r\nmc.firstname AS \"firstName\",\r\nmc.middlename AS \"middleName\",\r\nmc.lastname AS \"lastName\",\r\nmc.display_name AS \"fullName\",\r\nmc.mobile_no AS \"mobileNo\", \r\nml.principal_amount AS \"loanAmount\", \r\n(IFNULL(ml.principal_outstanding_derived, 0) + IFNULL(ml.interest_outstanding_derived, 0) + IFNULL(ml.fee_charges_outstanding_derived, 0) + IFNULL(ml.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nounder.id AS \"officeNumber\", \r\nml.account_no AS \"loanAccountNumber\",\r\nSUM(lt.amount) AS \"repaymentAmount\"\r\nFROM m_office mo\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\')\r\nINNER JOIN m_client mc ON mc.office_id=ounder.id\r\nINNER JOIN m_loan ml ON ml.client_id = mc.id\r\nINNER JOIN r_enum_value rev ON rev.enum_id=ml.loan_status_id AND rev.enum_name = \'loan_status_id\'\r\nINNER JOIN m_loan_transaction lt ON lt.loan_id = ml.id\r\nINNER JOIN m_appuser au ON au.id = lt.appuser_id\r\nLEFT JOIN m_loan_arrears_aging laa ON laa.loan_id=ml.id\r\nLEFT JOIN m_payment_detail mpd ON mpd.id=lt.payment_detail_id\r\nLEFT JOIN m_currency cur ON cur.code = ml.currency_code\r\nLEFT JOIN m_group_client gc ON gc.client_id = mc.id\r\nLEFT JOIN m_group g ON g.id = gc.group_id\r\nLEFT JOIN m_staff lo ON lo.id = ml.loan_officer_id\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = ml.id\r\nWHERE ml.loan_status_id=300 AND mo.id=${officeId} AND (IFNULL(ml.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND (DATEDIFF(CURDATE(), lt.transaction_date) BETWEEN ${fromX} AND ${toY}) AND lt.is_reversed=0 AND lt.transaction_type_enum=2 AND laa.loan_id IS NULL\r\nGROUP BY ml.id\r\nORDER BY ounder.hierarchy, ml.currency_code, mc.account_no, ml.account_no','Payments received in the last fromX to toY days for any loan with the status Active (on-time)',0,1),(175,'Loan payments received (Overdue Loans)','SMS','NonTriggered','Loan','SELECT \r\nml.id AS \"loanId\", \r\nmc.id AS \"id\", \r\nmc.firstname AS \"firstName\",\r\nmc.middlename AS \"middleName\",\r\nmc.lastname AS \"lastName\",\r\nmc.display_name AS \"fullName\",\r\nmc.mobile_no AS \"mobileNo\", \r\nml.principal_amount AS \"loanAmount\", \r\n(IFNULL(ml.principal_outstanding_derived, 0) + IFNULL(ml.interest_outstanding_derived, 0) + IFNULL(ml.fee_charges_outstanding_derived, 0) + IFNULL(ml.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nounder.id AS \"officeNumber\", \r\nml.account_no AS \"loanAccountNumber\",\r\nSUM(lt.amount) AS \"repaymentAmount\"\r\nFROM m_office mo\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\')\r\nINNER JOIN m_client mc ON mc.office_id=ounder.id\r\nINNER JOIN m_loan ml ON ml.client_id = mc.id\r\nINNER JOIN r_enum_value rev ON rev.enum_id=ml.loan_status_id AND rev.enum_name = \'loan_status_id\'\r\nINNER JOIN m_loan_arrears_aging laa ON laa.loan_id=ml.id\r\nINNER JOIN m_loan_transaction lt ON lt.loan_id = ml.id\r\nINNER JOIN m_appuser au ON au.id = lt.appuser_id\r\nLEFT JOIN m_payment_detail mpd ON mpd.id=lt.payment_detail_id\r\nLEFT JOIN m_currency cur ON cur.code = ml.currency_code\r\nLEFT JOIN m_group_client gc ON gc.client_id = mc.id\r\nLEFT JOIN m_group g ON g.id = gc.group_id\r\nLEFT JOIN m_staff lo ON lo.id = ml.loan_officer_id\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = ml.id\r\nWHERE ml.loan_status_id=300 AND mo.id=${officeId} AND (IFNULL(ml.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND (DATEDIFF(CURDATE(), lt.transaction_date) BETWEEN ${fromX} AND ${toY}) AND (DATEDIFF(CURDATE(), laa.overdue_since_date_derived) BETWEEN ${overdueX} AND ${overdueY}) AND lt.is_reversed=0 AND lt.transaction_type_enum=2\r\nGROUP BY ml.id\r\nORDER BY ounder.hierarchy, ml.currency_code, mc.account_no, ml.account_no','Payments received in the last fromX to toY days for any loan with the status Overdue (arrears) between overdueX and overdueY days',0,1),(176,'Happy Birthday','SMS','NonTriggered','Clients','SELECT \r\nc.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\r\nREPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \r\no.id AS \"officeNumber\", \r\nc.date_of_birth AS \"dateOfBirth\",\r\nIF(c.date_of_birth IS NULL, 0, CEIL(DATEDIFF (NOW(), c.date_of_birth)/365)) AS \"age\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nLEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\r\nLEFT JOIN m_staff ms ON ms.id = c.staff_id\r\nWHERE o.id = ${officeId} AND c.status_enum = 300 AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND c.date_of_birth IS NOT NULL AND (DAY(c.date_of_birth)=DAY(NOW())) AND (MONTH(c.date_of_birth)=MONTH(NOW()))\r\nORDER BY ounder.hierarchy, c.account_no','This sends a message to all clients with the status Active on their Birthday',0,1),(177,'Loan fully repaid','SMS','NonTriggered','Loan','SELECT \r\nc.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", \r\nl.principal_amount AS \"loanAmount\",\r\n(IFNULL(l.principal_outstanding_derived, 0) + IFNULL(l.interest_outstanding_derived, 0) + IFNULL(l.fee_charges_outstanding_derived, 0) + IFNULL(l.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nl.principal_disbursed_derived AS \"loanDisbursed\",\r\no.id AS \"officeNumber\",\r\nl.account_no AS \"loanAccountId\",\r\ngua.lastname AS \"guarantorLastName\", COUNT(gua.id) AS \"numberOfGuarantors\",\r\nls.duedate AS \"dueDate\",\r\nlaa.total_overdue_derived AS \"totalDue\",\r\ngp.display_name AS \"groupName\",\r\nl.total_repayment_derived AS \"totalFullyPaid\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_loan l ON l.client_id = c.id\r\nLEFT JOIN m_staff lo ON lo.id = l.loan_officer_id\r\nLEFT JOIN m_currency cur ON cur.code = l.currency_code\r\nLEFT JOIN m_group_client gc ON gc.client_id = c.id\r\nLEFT JOIN m_group gp ON gp.id = l.group_id\r\nLEFT JOIN m_loan_repayment_schedule ls ON l.id = ls.loan_id\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = l.id\r\nLEFT JOIN m_loan_arrears_aging laa ON laa.loan_id=l.id\r\nWHERE o.id = ${officeId} AND (IFNULL(l.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND \r\n(DATEDIFF(CURDATE(), l.closedon_date) BETWEEN ${fromX} AND ${toY})\r\n AND (l.loan_status_id IN (600, 700))\r\nGROUP BY l.id\r\nORDER BY ounder.hierarchy, l.currency_code, c.account_no, l.account_no','All loans that have been fully repaid (Closed or Overpaid) in the last fromX to toY days',0,1),(178,'Loan outstanding after final instalment date','SMS','NonTriggered','Loan','SELECT \r\nc.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", \r\nl.principal_amount AS \"loanAmount\",\r\no.id AS \"officeNumber\",\r\n(IFNULL(l.principal_outstanding_derived, 0) + IFNULL(l.interest_outstanding_derived, 0) + IFNULL(l.fee_charges_outstanding_derived, 0) + IFNULL(l.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\r\nl.principal_disbursed_derived AS \"loanDisbursed\",\r\nls.duedate AS \"paymentDueDate\",\r\n(IFNULL(SUM(ls.principal_amount),0) - IFNULL(SUM(ls.principal_writtenoff_derived),0)\r\n + IFNULL(SUM(ls.interest_amount),0) - IFNULL(SUM(ls.interest_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.interest_waived_derived),0)\r\n + IFNULL(SUM(ls.fee_charges_amount),0) - IFNULL(SUM(ls.fee_charges_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.fee_charges_waived_derived),0)\r\n + IFNULL(SUM(ls.penalty_charges_amount),0) - IFNULL(SUM(ls.penalty_charges_writtenoff_derived),0) \r\n - IFNULL(SUM(ls.penalty_charges_waived_derived),0)\r\n) AS \"totalDue\",\r\nlaa.total_overdue_derived AS \"totalOverdue\",\r\nl.account_no AS \"loanAccountId\",\r\ngua.lastname AS \"guarantorLastName\",\r\nCOUNT(gua.id) AS \"numberOfGuarantors\",\r\ngp.display_name AS \"groupName\"\r\n\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_loan l ON l.client_id = c.id\r\nLEFT JOIN m_staff lo ON lo.id = l.loan_officer_id\r\nLEFT JOIN m_currency cur ON cur.code = l.currency_code\r\nLEFT JOIN m_loan_arrears_aging laa ON laa.loan_id = l.id\r\nLEFT JOIN m_group_client gc ON gc.client_id = c.id\r\nLEFT JOIN m_group gp ON gp.id = l.group_id\r\nLEFT JOIN m_loan_repayment_schedule ls ON l.id = ls.loan_id\r\nLEFT JOIN m_guarantor gua ON gua.loan_id = l.id\r\nWHERE o.id = ${officeId} AND (IFNULL(l.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND l.loan_status_id = 300 AND l.expected_maturedon_date < CURDATE() \r\nAND (DATEDIFF(CURDATE(), l.expected_maturedon_date) BETWEEN ${fromX} AND ${toY})\r\nGROUP BY l.id\r\nORDER BY ounder.hierarchy, l.currency_code, c.account_no, l.account_no','All active loans (with an outstanding balance) between fromX to toY days after the final instalment date on their loan schedule',0,1),(179,'Loan Repayment','SMS','Triggered',NULL,'select ml.id as loanId,mc.id, mc.firstname, ifnull(mc.middlename,\'\') as middlename, mc.lastname, mc.display_name as FullName, mobile_no as mobileNo, mc.group_name as GroupName, round(ml.principal_amount, ml.currency_digits) as LoanAmount, round(ml.`total_outstanding_derived`, ml.currency_digits) as LoanOutstanding,\nml.`account_no` as LoanAccountId, round(mlt.amountPaid, ml.currency_digits) as repaymentAmount\nFROM m_office mo\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\')\nAND ounder.hierarchy like CONCAT(\'.\', \'%\')\nLEFT JOIN (\n select \n ml.id as loanId, \n ifnull(mc.id,mc2.id) as id, \n ifnull(mc.firstname,mc2.firstname) as firstname, \n ifnull(mc.middlename,ifnull(mc2.middlename,(\'\'))) as middlename, \n ifnull(mc.lastname,mc2.lastname) as lastname, \n ifnull(mc.display_name,mc2.display_name) as display_name, \n ifnull(mc.status_enum,mc2.status_enum) as status_enum,\n ifnull(mc.mobile_no,mc2.mobile_no) as mobile_no,\n ifnull(mg.office_id,mc2.office_id) as office_id,\n ifnull(mg.staff_id,mc2.staff_id) as staff_id,\n mg.id as group_id, \nmg.display_name as group_name\n from\n m_loan ml\n left join m_group mg on mg.id = ml.group_id\n left join m_group_client mgc on mgc.group_id = mg.id\n left join m_client mc on mc.id = mgc.client_id\n left join m_client mc2 on mc2.id = ml.client_id\n order by loanId\n ) mc on mc.office_id = ounder.id\nright join m_loan as ml on mc.loanId = ml.id\nright join(\nselect mlt.amount as amountPaid,mlt.id,mlt.loan_id\nfrom m_loan_transaction mlt\nwhere mlt.is_reversed = 0 \ngroup by mlt.loan_id\n) as mlt on mlt.loan_id = ml.id\nright join m_loan_repayment_schedule as mls1 on ml.id = mls1.loan_id and mls1.`completed_derived` = 0\nand mls1.installment = (SELECT MIN(installment) from m_loan_repayment_schedule where loan_id = ml.id and duedate <= CURDATE() and completed_derived=0)\nwhere mc.status_enum = 300 and mobile_no is not null and ml.`loan_status_id` = 300\nand (mo.id = ${officeId} or ${officeId} = -1)\nand (mc.staff_id = ${loanOfficerId} or ${loanOfficerId} = -1)\nand (ml.loan_type_enum = ${loanType} or ${loanType} = -1)\nand ml.id in (select mla.loan_id from m_loan_arrears_aging mla)\ngroup by ml.id','Loan Repayment',0,0),(180,'Loan Approved','SMS','Triggered',NULL,'SELECT mc.id, mc.firstname, mc.middlename as middlename, mc.lastname, mc.display_name as FullName, mc.mobile_no as mobileNo, mc.group_name as GroupName, mo.name as officename, ml.id as loanId, ml.account_no as accountnumber, ml.principal_amount_proposed as loanamount, ml.annual_nominal_interest_rate as annualinterestrate FROM m_office mo JOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\') AND ounder.hierarchy like CONCAT(\'.\', \'%\') LEFT JOIN ( select  ml.id as loanId,  ifnull(mc.id,mc2.id) as id,  ifnull(mc.firstname,mc2.firstname) as firstname,  ifnull(mc.middlename,ifnull(mc2.middlename,(\'\'))) as middlename,  ifnull(mc.lastname,mc2.lastname) as lastname,  ifnull(mc.display_name,mc2.display_name) as display_name,  ifnull(mc.status_enum,mc2.status_enum) as status_enum, ifnull(mc.mobile_no,mc2.mobile_no) as mobile_no, ifnull(mg.office_id,mc2.office_id) as office_id, ifnull(mg.staff_id,mc2.staff_id) as staff_id, mg.id as group_id, mg.display_name as group_name from m_loan ml left join m_group mg on mg.id = ml.group_id left join m_group_client mgc on mgc.group_id = mg.id left join m_client mc on mc.id = mgc.client_id left join m_client mc2 on mc2.id = ml.client_id order by loanId ) mc on mc.office_id = ounder.id  left join m_loan ml on ml.id = mc.loanId WHERE mc.status_enum = 300 and mc.mobile_no is not null and (mo.id = ${officeId} or ${officeId} = -1) and (mc.staff_id = ${loanOfficerId} or ${loanOfficerId} = -1)and (ml.id = ${loanId} or ${loanId} = -1)and (mc.id = ${clientId} or ${clientId} = -1)and (mc.group_id = ${groupId} or ${groupId} = -1)and (ml.loan_type_enum = ${loanType} or ${loanType} = -1)','Loan and client data of approved loan',0,0),(181,'Loan Rejected','SMS','Triggered',NULL,'SELECT mc.id, mc.firstname, mc.middlename as middlename, mc.lastname, mc.display_name as FullName, mc.mobile_no as mobileNo, mc.group_name as GroupName,  mo.name as officename, ml.id as loanId, ml.account_no as accountnumber, ml.principal_amount_proposed as loanamount, ml.annual_nominal_interest_rate as annualinterestrate  FROM  m_office mo  JOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\')  AND ounder.hierarchy like CONCAT(\'.\', \'%\')  LEFT JOIN (  select   ml.id as loanId,   ifnull(mc.id,mc2.id) as id,   ifnull(mc.firstname,mc2.firstname) as firstname,   ifnull(mc.middlename,ifnull(mc2.middlename,(\'\'))) as middlename,   ifnull(mc.lastname,mc2.lastname) as lastname,   ifnull(mc.display_name,mc2.display_name) as display_name,   ifnull(mc.status_enum,mc2.status_enum) as status_enum,  ifnull(mc.mobile_no,mc2.mobile_no) as mobile_no,  ifnull(mg.office_id,mc2.office_id) as office_id,  ifnull(mg.staff_id,mc2.staff_id) as staff_id,  mg.id as group_id,  mg.display_name as group_name  from  m_loan ml  left join m_group mg on mg.id = ml.group_id  left join m_group_client mgc on mgc.group_id = mg.id  left join m_client mc on mc.id = mgc.client_id  left join m_client mc2 on mc2.id = ml.client_id  order by loanId  ) mc on mc.office_id = ounder.id  left join m_loan ml on ml.id = mc.loanId  WHERE mc.status_enum = 300 and mc.mobile_no is not null  and (mo.id = ${officeId} or ${officeId} = -1)  and (mc.staff_id = ${loanOfficerId} or ${loanOfficerId} = -1) and (ml.id = ${loanId} or ${loanId} = -1) and (mc.id = ${clientId} or ${clientId} = -1) and (mc.group_id = ${groupId} or ${groupId} = -1)  and (ml.loan_type_enum = ${loanType} or ${loanType} = -1)','Loan and client data of rejected loan',0,0),(182,'Client Rejected','SMS','Triggered','Clients','SELECT c.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\r\nREPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \r\no.id AS \"officeNumber\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nLEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\r\nWHERE o.id = ${officeId} AND c.id = ${clientId} AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId})','Client Rejection',0,1),(183,'Client Activated','SMS','Triggered','Clients','SELECT c.id AS \"id\", \r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\r\nREPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \r\no.id AS \"officeNumber\"\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nLEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\r\nWHERE o.id = ${officeId} AND c.id = ${clientId} AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId})','Client Activation',0,1),(184,'Savings Rejected','SMS','Triggered','Savings','SELECT \r\nc.id AS \"id\",\r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\",\r\ns.account_no AS \"savingsAccountNo\",\r\nounder.id AS \"officeNumber\",\r\nounder.name AS \"officeName\"\r\n\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_savings_account s ON s.client_id = c.id\r\nJOIN m_savings_product sp ON sp.id = s.product_id\r\nLEFT JOIN m_staff st ON st.id = s.field_officer_id\r\nLEFT JOIN m_currency cur ON cur.code = s.currency_code\r\nWHERE o.id = ${officeId} AND (IFNULL(s.field_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND s.id = ${savingsId}','Savings Rejected',0,1),(185,'Savings Activated','SMS','Triggered','Savings','SELECT \r\nc.id AS \"id\",\r\nc.firstname AS \"firstName\",\r\nc.middlename AS \"middleName\",\r\nc.lastname AS \"lastName\",\r\nc.display_name AS \"fullName\",\r\nc.mobile_no AS \"mobileNo\",\r\ns.account_no AS \"savingsAccountNo\",\r\nounder.id AS \"officeNumber\",\r\nounder.name AS \"officeName\"\r\n\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_savings_account s ON s.client_id = c.id\r\nJOIN m_savings_product sp ON sp.id = s.product_id\r\nLEFT JOIN m_staff st ON st.id = s.field_officer_id\r\nLEFT JOIN m_currency cur ON cur.code = s.currency_code\r\nWHERE o.id = ${officeId} AND (IFNULL(s.field_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND s.id = ${savingsId}','Savings Activation',0,1),(186,'Savings Deposit','SMS','Triggered',NULL,'SELECT sc.savingsId AS savingsId, sc.id AS clientId, sc.firstname, IFNULL(sc.middlename,\'\') AS middlename, sc.lastname, sc.display_name AS FullName, sc.mobile_no AS mobileNo,\r\nms.`account_no` AS savingsAccountNo, ROUND(mst.amountPaid, ms.currency_digits) AS depositAmount, ms.account_balance_derived AS balance, \r\nmst.transactionDate AS transactionDate\r\nFROM m_office mo\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\') AND ounder.hierarchy LIKE CONCAT(\'.\', \'%\')\r\nLEFT JOIN (\r\nSELECT \r\n sa.id AS savingsId, mc.id AS id, mc.firstname AS firstname, mc.middlename AS middlename, mc.lastname AS lastname, \r\n mc.display_name AS display_name, mc.status_enum AS status_enum, \r\n mc.mobile_no AS mobile_no, mc.office_id AS office_id, \r\n mc.staff_id AS staff_id\r\nFROM\r\nm_savings_account sa\r\nLEFT JOIN m_client mc ON mc.id = sa.client_id\r\nORDER BY savingsId) sc ON sc.office_id = ounder.id\r\nRIGHT JOIN m_savings_account AS ms ON sc.savingsId = ms.id\r\nRIGHT JOIN(\r\nSELECT st.amount AS amountPaid, st.id, st.savings_account_id, st.id AS savingsTransactionId, st.transaction_date AS transactionDate\r\nFROM m_savings_account_transaction st\r\nWHERE st.is_reversed = 0\r\nGROUP BY st.savings_account_id\r\n) AS mst ON mst.savings_account_id = ms.id\r\nWHERE sc.mobile_no IS NOT NULL AND (mo.id = ${officeId} OR ${officeId} = -1) AND (sc.staff_id = ${loanOfficerId} OR ${loanOfficerId} = -1) AND mst.savingsTransactionId = ${savingsTransactionId}','Savings Deposit',0,1),(187,'Savings Withdrawal','SMS','Triggered',NULL,'SELECT sc.savingsId AS savingsId, sc.id AS clientId, sc.firstname, IFNULL(sc.middlename,\'\') AS middlename, sc.lastname, sc.display_name AS FullName, sc.mobile_no AS mobileNo,\r\nms.`account_no` AS savingsAccountNo, ROUND(mst.amountPaid, ms.currency_digits) AS withdrawAmount, ms.account_balance_derived AS balance, \r\nmst.transactionDate AS transactionDate\r\nFROM m_office mo\r\nJOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(mo.hierarchy, \'%\') AND ounder.hierarchy LIKE CONCAT(\'.\', \'%\')\r\nLEFT JOIN (\r\nSELECT \r\n sa.id AS savingsId, mc.id AS id, mc.firstname AS firstname, mc.middlename AS middlename, mc.lastname AS lastname, \r\n mc.display_name AS display_name, mc.status_enum AS status_enum, \r\n mc.mobile_no AS mobile_no, mc.office_id AS office_id, \r\n mc.staff_id AS staff_id\r\nFROM\r\nm_savings_account sa\r\nLEFT JOIN m_client mc ON mc.id = sa.client_id\r\nORDER BY savingsId) sc ON sc.office_id = ounder.id\r\nRIGHT JOIN m_savings_account AS ms ON sc.savingsId = ms.id\r\nRIGHT JOIN(\r\nSELECT st.amount AS amountPaid, st.id, st.savings_account_id, st.id AS savingsTransactionId, st.transaction_date AS transactionDate\r\nFROM m_savings_account_transaction st\r\nWHERE st.is_reversed = 0\r\nGROUP BY st.savings_account_id\r\n) AS mst ON mst.savings_account_id = ms.id\r\nWHERE sc.mobile_no IS NOT NULL AND (mo.id = ${officeId} OR ${officeId} = -1) AND (sc.staff_id = ${loanOfficerId} OR ${loanOfficerId} = -1) AND mst.savingsTransactionId = ${savingsTransactionId}','Savings Withdrawal',0,1);
/*!40000 ALTER TABLE `stretchy_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stretchy_report_parameter`
--

DROP TABLE IF EXISTS `stretchy_report_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stretchy_report_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `report_parameter_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `report_parameter_unique` (`report_id`,`parameter_id`),
  KEY `fk_report_parameter_001_idx` (`report_id`),
  KEY `fk_report_parameter_002_idx` (`parameter_id`),
  CONSTRAINT `fk_report_parameter_001` FOREIGN KEY (`report_id`) REFERENCES `stretchy_report` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_parameter_002` FOREIGN KEY (`parameter_id`) REFERENCES `stretchy_parameter` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=522 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stretchy_report_parameter`
--

LOCK TABLES `stretchy_report_parameter` WRITE;
/*!40000 ALTER TABLE `stretchy_report_parameter` DISABLE KEYS */;
INSERT INTO `stretchy_report_parameter` VALUES (1,1,5,NULL),(2,2,5,NULL),(3,2,6,NULL),(4,2,10,NULL),(5,2,20,NULL),(6,2,25,NULL),(7,2,26,NULL),(8,5,5,NULL),(9,5,6,NULL),(10,5,10,NULL),(11,5,20,NULL),(12,5,25,NULL),(13,5,26,NULL),(14,6,5,NULL),(15,6,6,NULL),(16,6,10,NULL),(17,6,20,NULL),(18,6,25,NULL),(19,6,26,NULL),(20,7,5,NULL),(21,7,6,NULL),(22,7,10,NULL),(23,7,20,NULL),(24,7,25,NULL),(25,7,26,NULL),(26,8,5,NULL),(27,8,6,NULL),(28,8,10,NULL),(29,8,25,NULL),(30,8,26,NULL),(31,11,5,NULL),(32,11,6,NULL),(33,11,10,NULL),(34,11,20,NULL),(35,11,25,NULL),(36,11,26,NULL),(37,11,100,NULL),(38,12,5,NULL),(39,12,6,NULL),(40,12,10,NULL),(41,12,20,NULL),(42,12,25,NULL),(43,12,26,NULL),(44,13,1,NULL),(45,13,2,NULL),(46,13,3,NULL),(47,13,5,NULL),(48,13,6,NULL),(49,13,10,NULL),(50,13,20,NULL),(51,13,25,NULL),(52,13,26,NULL),(53,14,1,NULL),(54,14,2,NULL),(55,14,3,NULL),(56,14,5,NULL),(57,14,6,NULL),(58,14,10,NULL),(59,14,20,NULL),(60,14,25,NULL),(61,14,26,NULL),(62,15,5,NULL),(63,15,6,NULL),(64,15,10,NULL),(65,15,20,NULL),(66,15,25,NULL),(67,15,26,NULL),(68,15,100,NULL),(69,16,5,NULL),(70,16,6,NULL),(71,16,10,NULL),(72,16,20,NULL),(73,16,25,NULL),(74,16,26,NULL),(75,16,100,NULL),(76,20,1,NULL),(77,20,2,NULL),(78,20,10,NULL),(79,20,20,NULL),(80,21,1,NULL),(81,21,2,NULL),(82,21,5,NULL),(83,21,10,NULL),(84,21,20,NULL),(85,48,5,'branch'),(86,48,2,'date'),(87,49,5,'branch'),(88,49,1,'fromDate'),(89,49,2,'toDate'),(90,50,5,'branch'),(91,50,1,'fromDate'),(92,50,2,'toDate'),(93,51,1,NULL),(94,51,2,NULL),(95,51,5,NULL),(96,51,10,NULL),(97,51,25,NULL),(98,52,5,NULL),(99,53,5,NULL),(100,53,10,NULL),(101,54,1,NULL),(102,54,2,NULL),(103,54,5,NULL),(104,54,10,NULL),(105,54,25,NULL),(106,55,5,NULL),(107,55,6,NULL),(108,55,10,NULL),(109,55,20,NULL),(110,55,25,NULL),(111,55,26,NULL),(112,56,5,NULL),(113,56,6,NULL),(114,56,10,NULL),(115,56,20,NULL),(116,56,25,NULL),(117,56,26,NULL),(118,56,100,NULL),(119,57,5,NULL),(120,57,6,NULL),(121,57,10,NULL),(122,57,20,NULL),(123,57,25,NULL),(124,57,26,NULL),(125,58,5,NULL),(126,58,6,NULL),(127,58,10,NULL),(128,58,20,NULL),(129,58,25,NULL),(130,58,26,NULL),(131,58,100,NULL),(132,59,1,NULL),(133,59,2,NULL),(134,59,5,NULL),(135,59,6,NULL),(136,59,10,NULL),(137,59,20,NULL),(138,59,25,NULL),(139,59,26,NULL),(140,61,5,NULL),(141,61,10,NULL),(142,92,1,'fromDate'),(143,92,5,'selectOffice'),(144,92,2,'toDate'),(145,93,1,NULL),(146,93,2,NULL),(147,93,5,NULL),(148,93,6,NULL),(149,94,2,'endDate'),(150,94,6,'loanOfficerId'),(151,94,5,'officeId'),(152,94,1,'startDate'),(256,106,2,NULL),(257,106,6,NULL),(258,106,5,NULL),(259,106,1,NULL),(263,118,1,'fromDate'),(264,118,2,'toDate'),(265,118,1004,'accountNo'),(266,119,1,'fromDate'),(267,119,2,'toDate'),(268,119,5,'selectOffice'),(269,119,1005,'selectProduct'),(270,120,5,'branch'),(271,120,6,'loanOfficer'),(272,120,10,'currencyId'),(273,120,20,'fundId'),(274,120,25,'loanProductId'),(275,120,26,'loanPurposeId'),(276,121,5,'Branch'),(277,121,6,'loanOfficer'),(278,121,10,'CurrencyId'),(279,121,20,'fundId'),(280,121,25,'loanProductId'),(281,121,26,'loanPurposeId'),(282,121,100,'parType'),(283,122,5,'Branch'),(284,122,6,'loanOfficer'),(285,122,10,'CurrencyId'),(286,122,20,'fundId'),(287,122,25,'loanProductId'),(288,122,26,'loanPurposeId'),(289,122,1,'startDate'),(290,122,2,'endDate'),(291,123,5,'Branch'),(292,123,6,'Loan Officer'),(293,123,10,'CurrencyId'),(294,123,20,'fundId'),(295,123,25,'loanProductId'),(296,123,26,'loanPurposeId'),(297,123,100,'parType'),(298,124,5,'Branch'),(299,124,6,'Loan Officer'),(300,124,10,'CurrencyId'),(301,124,20,'fundId'),(302,124,25,'loanProductId'),(303,124,26,'loanPurposeId'),(304,125,5,'Branch'),(305,125,6,'Loan Officer'),(306,125,10,'CurrencyId'),(307,125,20,'fundId'),(308,125,25,'loanProductId'),(309,125,26,'loanPurposeId'),(310,125,100,'parType'),(311,126,5,'Branch'),(312,126,6,'Loan Officer'),(313,126,10,'CurrencyId'),(314,126,20,'fundId'),(315,126,25,'loanProductId'),(316,126,26,'loanPurposeId'),(317,127,5,'Branch'),(318,128,5,'Branch'),(319,128,10,'CurrencyId'),(320,129,5,'Branch'),(321,129,10,'CurrencyId'),(322,130,5,'selectOffice'),(323,131,5,'Branch'),(324,131,6,'Loan Officer'),(325,131,10,'CurrencyId'),(326,131,20,'fundId'),(327,131,25,'loanProductId'),(328,131,26,'loanPurposeId'),(329,132,5,'Branch'),(330,132,6,'Loan Officer'),(331,132,1,'startDate'),(332,132,2,'endDate'),(333,133,5,'Branch'),(334,133,10,'CurrencyId'),(335,133,20,'fundId'),(336,133,1,'startDate'),(337,133,2,'endDate'),(338,134,10,'CurrencyId'),(339,134,20,'fundId'),(340,134,1,'startDate'),(341,134,2,'endDate'),(342,135,5,'Branch'),(343,135,6,'Loan Officer'),(344,135,10,'CurrencyId'),(345,135,20,'fundId'),(346,135,25,'loanProductId'),(347,135,26,'loanPurposeId'),(348,136,5,'Branch'),(349,136,6,'Loan Officer'),(350,136,10,'CurrencyId'),(351,136,20,'fundId'),(352,136,25,'loanProductId'),(353,136,26,'loanPurposeId'),(354,137,5,'Branch'),(355,137,6,'Loan Officer'),(356,137,10,'CurrencyId'),(357,137,20,'fundId'),(358,137,25,'loanProductId'),(359,137,26,'loanPurposeId'),(360,138,5,'Branch'),(361,138,6,'Loan Officer'),(362,138,10,'CurrencyId'),(363,138,20,'fundId'),(364,138,25,'loanProductId'),(365,138,26,'loanPurposeId'),(366,139,5,'Branch'),(367,139,6,'Loan Officer'),(368,139,10,'CurrencyId'),(369,139,20,'fundId'),(370,139,25,'loanProductId'),(371,139,26,'loanPurposeId'),(372,139,1,'startDate'),(373,139,2,'endDate'),(374,139,3,'obligDateType'),(375,140,5,'Branch'),(376,140,6,'Loan Officer'),(377,140,10,'CurrencyId'),(378,140,20,'fundId'),(379,140,25,'loanProductId'),(380,140,26,'loanPurposeId'),(381,140,1,'Startdate'),(382,140,2,'Enddate'),(383,140,3,'obligDateType'),(384,141,5,'Branch'),(385,141,6,'Loan Officer'),(386,141,10,'CurrencyId'),(387,141,20,'fundId'),(388,141,25,'loanProductId'),(389,141,26,'loanPurposeId'),(390,141,100,'parType'),(391,142,5,'Branch'),(392,142,6,'loanOfficer'),(393,142,10,'CurrencyId'),(394,142,20,'fundId'),(395,142,25,'loanProductId'),(396,142,26,'loanPurposeId'),(397,142,100,'parType'),(398,143,5,'Branch'),(399,143,10,'CurrencyId'),(400,143,25,'loanProductId'),(401,143,1,'startDate'),(402,143,2,'endDate'),(403,144,5,'Branch'),(404,144,6,'Loan Officer'),(405,144,1,'startDate'),(406,144,2,'endDate'),(407,145,5,'Branch'),(408,145,10,'CurrencyId'),(409,145,25,'loanProductId'),(410,145,1,'startDate'),(411,145,2,'endDate'),(412,146,1,'startDate'),(413,146,2,'endDate'),(414,146,1004,'accountNo'),(415,147,1,'startDate'),(416,147,2,'endDate'),(417,147,1004,'selectLoan'),(418,149,5,''),(419,150,5,''),(420,151,5,''),(421,152,5,''),(422,153,5,''),(423,154,5,''),(424,155,5,''),(425,156,5,''),(426,157,1006,'transactionId'),(427,158,1006,'transactionId'),(428,159,1007,'centerId'),(429,160,1008,'account'),(430,160,1,'fromDate'),(431,160,2,'toDate'),(432,160,5,'branch'),(433,162,5,'branch'),(434,162,1009,'ondate'),(435,163,5,'branch'),(436,163,1,'fromDate'),(437,163,2,'toDate'),(438,164,5,'branch'),(439,164,1,'fromDate'),(440,164,2,'toDate'),(441,165,1010,NULL),(442,165,5,NULL),(443,166,5,'officeId'),(444,166,6,'loanOfficerId'),(445,167,5,'officeId'),(446,167,6,'loanOfficerId'),(447,168,5,'officeId'),(448,168,6,'loanOfficerId'),(449,168,1011,'cycleX'),(450,168,1012,'cycleY'),(451,169,5,'officeId'),(452,169,6,'loanOfficerId'),(453,169,1013,'fromX'),(454,169,1014,'toY'),(455,170,5,'officeId'),(456,170,6,'loanOfficerId'),(457,170,1013,'fromX'),(458,170,1014,'toY'),(459,171,5,'officeId'),(460,171,6,'loanOfficerId'),(461,172,5,'officeId'),(462,172,6,'loanOfficerId'),(463,173,5,'officeId'),(464,173,6,'loanOfficerId'),(465,173,1013,'fromX'),(466,173,1014,'toY'),(467,173,1015,'overdueX'),(468,173,1016,'overdueY'),(469,174,5,'officeId'),(470,174,6,'loanOfficerId'),(471,174,1013,'fromX'),(472,174,1014,'toY'),(473,175,5,'officeId'),(474,175,6,'loanOfficerId'),(475,175,1013,'fromX'),(476,175,1014,'toY'),(477,175,1015,'overdueX'),(478,175,1016,'overdueY'),(479,176,5,'officeId'),(480,176,6,'loanOfficerId'),(481,177,5,'officeId'),(482,177,6,'loanOfficerId'),(483,177,1013,'fromX'),(484,177,1014,'toY'),(485,178,5,'officeId'),(486,178,6,'loanOfficerId'),(487,178,1013,'fromX'),(488,178,1014,'toY'),(489,181,5,'officeId'),(490,180,5,'officeId'),(491,179,5,'officeId'),(492,181,6,'loanOfficerId'),(493,180,6,'loanOfficerId'),(494,179,6,'loanOfficerId'),(495,181,1017,'loanId'),(496,180,1017,'loanId'),(497,181,1018,'clientId'),(498,180,1018,'clientId'),(499,181,1019,'groupId'),(500,180,1019,'groupId'),(501,181,1020,'loanType'),(502,180,1020,'loanType'),(503,179,1020,'loanType'),(504,182,5,'officeId'),(505,183,5,'officeId'),(506,182,6,'loanOfficerId'),(507,183,6,'loanOfficerId'),(508,182,1018,'clientId'),(509,183,1018,'clientId'),(510,184,5,'officeId'),(511,184,6,'loanOfficerId'),(512,184,1021,'savingsId'),(513,185,5,'officeId'),(514,185,6,'loanOfficerId'),(515,185,1021,'savingsId'),(516,186,5,'officeId'),(517,186,6,'loanOfficerId'),(518,186,1022,'savingsTransactionId'),(519,187,5,'officeId'),(520,187,6,'loanOfficerId'),(521,187,1022,'savingsTransactionId');
/*!40000 ALTER TABLE `stretchy_report_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `entity_id` bigint(20) NOT NULL,
  `entity_type` text NOT NULL,
  `member_type` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title_UNIQUE` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
INSERT INTO `topic` VALUES (1,'Self Service User of Head Office',1,1,'OFFICE','SELF SERVICE USER'),(2,'Super user of Head Office',1,1,'OFFICE','SUPER USER'),(4,'Super user of Mountain Savings & Credit Group',1,2,'BRANCH','SUPER USER'),(5,'Self Service User of Mountain Savings & Credit Group',1,2,'BRANCH','SELF SERVICE USER');
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic_subscriber`
--

DROP TABLE IF EXISTS `topic_subscriber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_subscriber` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `topic_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `subscription_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_topic_has_m_appuser_topic` (`topic_id`),
  KEY `fk_topic_has_m_appuser_m_appuser1` (`user_id`),
  CONSTRAINT `fk_topic_has_m_appuser_m_appuser1` FOREIGN KEY (`user_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `fk_topic_has_m_appuser_topic` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic_subscriber`
--

LOCK TABLES `topic_subscriber` WRITE;
/*!40000 ALTER TABLE `topic_subscriber` DISABLE KEYS */;
INSERT INTO `topic_subscriber` VALUES (1,2,1,'2018-04-16'),(2,2,3,'2018-04-16'),(3,4,9,'2018-04-17'),(4,4,10,'2018-04-20');
/*!40000 ALTER TABLE `topic_subscriber` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tr`
--

DROP TABLE IF EXISTS `tr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tr` (
  `client_id` bigint(20) NOT NULL,
  `fgf` varchar(52) DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  CONSTRAINT `fk_tr_client_id` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tr`
--

LOCK TABLES `tr` WRITE;
/*!40000 ALTER TABLE `tr` DISABLE KEYS */;
/*!40000 ALTER TABLE `tr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `twofactor_access_token`
--

DROP TABLE IF EXISTS `twofactor_access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twofactor_access_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` varchar(32) NOT NULL,
  `appuser_id` bigint(20) NOT NULL,
  `valid_from` datetime NOT NULL,
  `valid_to` datetime NOT NULL,
  `enabled` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_appuser_UNIQUE` (`token`,`appuser_id`),
  KEY `user` (`appuser_id`),
  KEY `token` (`token`),
  CONSTRAINT `fk_2fa_access_token_user_id` FOREIGN KEY (`appuser_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `twofactor_access_token`
--

LOCK TABLES `twofactor_access_token` WRITE;
/*!40000 ALTER TABLE `twofactor_access_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `twofactor_access_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `twofactor_configuration`
--

DROP TABLE IF EXISTS `twofactor_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twofactor_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `value` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `twofactor_configuration`
--

LOCK TABLES `twofactor_configuration` WRITE;
/*!40000 ALTER TABLE `twofactor_configuration` DISABLE KEYS */;
INSERT INTO `twofactor_configuration` VALUES (1,'otp-delivery-email-enable','true'),(2,'otp-delivery-email-subject','Fineract Two-Factor Authentication Token'),(3,'otp-delivery-email-body','Hello {{username}}.\nYour OTP login token is {{token}}.'),(4,'otp-delivery-sms-enable','false'),(5,'otp-delivery-sms-provider','1'),(6,'otp-delivery-sms-text','Your authentication token for Fineract is {{token}}.'),(7,'otp-token-live-time','300'),(8,'otp-token-length','5'),(9,'access-token-live-time','86400'),(10,'access-token-live-time-extended','604800');
/*!40000 ALTER TABLE `twofactor_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_registered_table`
--

DROP TABLE IF EXISTS `x_registered_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_registered_table` (
  `registered_table_name` varchar(50) NOT NULL,
  `application_table_name` varchar(50) NOT NULL,
  `category` int(11) NOT NULL DEFAULT '100',
  PRIMARY KEY (`registered_table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_registered_table`
--

LOCK TABLES `x_registered_table` WRITE;
/*!40000 ALTER TABLE `x_registered_table` DISABLE KEYS */;
INSERT INTO `x_registered_table` VALUES ('Charges','m_loan',100),('fgfg','m_client',100),('Marital Status','m_client',100),('Member ID','m_client',100),('tr','m_client',100);
/*!40000 ALTER TABLE `x_registered_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_table_column_code_mappings`
--

DROP TABLE IF EXISTS `x_table_column_code_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_table_column_code_mappings` (
  `column_alias_name` varchar(50) NOT NULL,
  `code_id` int(10) NOT NULL,
  PRIMARY KEY (`column_alias_name`),
  KEY `FK_x_code_id` (`code_id`),
  CONSTRAINT `FK_x_code_id` FOREIGN KEY (`code_id`) REFERENCES `m_code` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_table_column_code_mappings`
--

LOCK TABLES `x_table_column_code_mappings` WRITE;
/*!40000 ALTER TABLE `x_table_column_code_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `x_table_column_code_mappings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-24 18:27:06
