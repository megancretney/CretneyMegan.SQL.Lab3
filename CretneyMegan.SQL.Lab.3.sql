###################### Lab 3 ##########################
DROP database `northwind_dw`;
CREATE DATABASE `northwind_dw` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE northwind_dw;

#DROP TABLE `dim_customers`;
CREATE TABLE `dim_customers` (
  `customer_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

# DROP TABLE `dim_employees`;
CREATE TABLE `dim_employees` (
  `employee_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `home_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  `web_page` longtext,
  PRIMARY KEY (`employee_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

# DROP TABLE `dim_products`;
CREATE TABLE `dim_products` (
  `product_key` int NOT NULL AUTO_INCREMENT,
  `product_code` varchar(25) DEFAULT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `standard_cost` decimal(19,4) DEFAULT '0.0000',
  `list_price` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `reorder_level` int DEFAULT NULL,
  `target_level` int DEFAULT NULL,
  `quantity_per_unit` varchar(50) DEFAULT NULL,
  `discontinued` tinyint(1) NOT NULL DEFAULT '0',
  `minimum_reorder_quantity` int DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_key`),
  KEY `product_code` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

# DROP TABLE `dim_shippers`;
CREATE TABLE `dim_shippers` (
  `shipper_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shipper_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

### Exercise 1.2 – Creating the Fact Table
# DROP TABLE `fact_orders`;
CREATE TABLE `fact_orders` (
	`order_id` int,
    `employee_id` int,
    `customer_id` int,
    `product_id` int,
    `shipper_id` int,
    `ship_name` varchar(50) DEFAULT NULL,
    `ship_address` varchar(50) DEFAULT NULL,
    `ship_city` varchar(50) DEFAULT NULL,
    `ship_state_province` varchar(50) DEFAULT NULL,
    `ship_zip_postal_code` varchar(50) DEFAULT NULL,
    `ship_country_region` varchar(50) DEFAULT NULL,
    `quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
    `order_date` datetime DEFAULT NULL,
    `shipped_date` datetime DEFAULT NULL,
    `unit_price` decimal(19,4) DEFAULT '0.0000',
    `discount` double NOT NULL DEFAULT '0',
    `shipping_fee` decimal(19,4) DEFAULT '0.0000',
    `taxes` decimal(19,4) DEFAULT '0.0000',
    `payment_type` varchar(50) DEFAULT NULL,
    `paid_date` datetime DEFAULT NULL,
    `tax_rate` double DEFAULT '0',
    `order_status` varchar(50) DEFAULT NULL,
    `order_details_status` varchar(50) DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

##################### Insert Statements ################################


# Exercise 2.0 – Populating the Newly-Created Dimensional Schema
INSERT INTO `northwind_dw`.`dim_customers`
(`customer_key`,
`company`,
`last_name`,
`first_name`,
`job_title`,
`business_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `customers`.`id`,
    `customers`.`company`,
    `customers`.`last_name`,
    `customers`.`first_name`,
    `customers`.`job_title`,
    `customers`.`business_phone`,
    `customers`.`fax_number`,
    `customers`.`address`,
    `customers`.`city`,
    `customers`.`state_province`,
    `customers`.`zip_postal_code`,
    `customers`.`country_region`
FROM `northwind`.`customers`;


SELECT * FROM northwind_dw.dim_customers;

INSERT INTO `northwind_dw`.`dim_employees`
(`employee_key`,
`company`,
`last_name`,
`first_name`,
`email_address`,
`job_title`,
`business_phone`,
`home_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`,
`web_page`)
SELECT `employees`.`id`,
    `employees`.`company`,
    `employees`.`last_name`,
    `employees`.`first_name`,
    `employees`.`email_address`,
    `employees`.`job_title`,
    `employees`.`business_phone`,
    `employees`.`home_phone`,
    `employees`.`fax_number`,
    `employees`.`address`,
    `employees`.`city`,
    `employees`.`state_province`,
    `employees`.`zip_postal_code`,
    `employees`.`country_region`,
    `employees`.`web_page`
FROM `northwind`.`employees`;

SELECT * FROM northwind_dw.dim_employees;

INSERT INTO `northwind_dw`.`dim_products`
(`product_key`,
`product_code`,
`product_name`,
`standard_cost`,
`list_price`,
`reorder_level`,
`target_level`,
`quantity_per_unit`,
`discontinued`,
`minimum_reorder_quantity`,
`category`)
SELECT 
    `products`.`id`,
    `products`.`product_code`,
    `products`.`product_name`,
    `products`.`standard_cost`,
    `products`.`list_price`,
    `products`.`reorder_level`,
    `products`.`target_level`,
    `products`.`quantity_per_unit`,
    `products`.`discontinued`,
    `products`.`minimum_reorder_quantity`,
    `products`.`category`
FROM `northwind`.`products`;

SELECT * FROM northwind_dw.dim_products;

INSERT INTO `northwind_dw`.`dim_shippers`
(`shipper_key`,
`company`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `shippers`.`id`,
    `shippers`.`company`,
    `shippers`.`address`,
    `shippers`.`city`,
    `shippers`.`state_province`,
    `shippers`.`zip_postal_code`,
    `shippers`.`country_region`
FROM `northwind`.`shippers`;

SELECT * FROM northwind_dw.dim_shippers;

# Exercise 2.2 – Loading the Orders Fact Table
INSERT INTO `northwind_dw`.`fact_orders`
(`order_id`,
`employee_id`,
`customer_id`,
`product_id`,
`shipper_id`,
`ship_name`,
`ship_address`,
`ship_city`,
`ship_state_province`,
`ship_zip_postal_code`,
`ship_country_region`,
`quantity`,
`order_date`,
`shipped_date`,
`unit_price`,
`discount`,
`shipping_fee`,
`taxes`,
`payment_type`,
`paid_date`,
`tax_rate`,
`order_status`,
`order_details_status`)
SELECT `order_details`.`order_id`,
	`orders`.`employee_id`,
	`orders`.`customer_id`,
    `order_details`.`product_id`,
    `orders`.`shipper_id`,
    `orders`.`ship_name`,
    `orders`.`ship_address`,
    `orders`.`ship_city`,
    `orders`.`ship_state_province`,
    `orders`.`ship_zip_postal_code`,
    `orders`.`ship_country_region`,
    `order_details`.`quantity`,
    `orders`.`order_date`,
     `orders`.`shipped_date`,
     `order_details`.`unit_price`,
    `order_details`.`discount`,
    `orders`.`shipping_fee`,
    `orders`.`taxes`,
    `orders`.`payment_type`,
    `orders`.`paid_date`,
    `orders`.`tax_rate`,
    `orders_status`.`status_name` AS `order_status`,
    `order_details_status`.`status_name` AS `order_details_status`
FROM `northwind`.`orders` INNER JOIN `northwind`.`orders_status` ON
`northwind`.`orders`.`status_id` = `northwind`.`orders_status`.`id` RIGHT OUTER JOIN `northwind`.`order_details`
ON `northwind`.`orders`.`id` = `northwind`.`order_details`.`id`
INNER JOIN `northwind`.`order_details_status` ON `northwind`.`order_details`.`status_id` = `northwind`.`order_details_status`.`id`; 

SELECT * FROM northwind_dw.fact_orders;

## •	Each Customer’s Last Name
# •	The total amount of the order quantity associated with each customer
# •	The total amount of the order unit price associated with each customer

SELECT northwind_dw.dim_customers.last_name, SUM(northwind_dw.fact_orders.quantity) AS total_quantity,
 SUM(northwind_dw.fact_orders.unit_price) AS total_unit_price FROM northwind_dw.dim_customers 
JOIN northwind_dw.fact_orders ON northwind_dw.dim_customers.customer_key = northwind_dw.fact_orders.customer_id
GROUP BY northwind_dw.dim_customers.last_name;
