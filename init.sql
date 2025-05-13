CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- Set the character set and collation for Vietnamese support
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
SET character_set_connection=utf8mb4;
SET collation_connection=utf8mb4_unicode_ci;

-- Set default collation for the database
ALTER DATABASE ecommerce_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Drop existing tables if they exist (in correct order due to dependencies)
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS brand;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS login;
DROP TABLE IF EXISTS usermaster;

-- Create tables with proper constraints and Vietnamese support
CREATE TABLE brand (
    bid INT PRIMARY KEY AUTO_INCREMENT,
    bname VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_brand_name (bname)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE category (
    cid INT PRIMARY KEY AUTO_INCREMENT,
    cname VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_category_name (cname)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE product (
    pid INT PRIMARY KEY AUTO_INCREMENT,
    pname VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    pprice DECIMAL(10,2) NOT NULL,
    pquantity INT NOT NULL DEFAULT 0,
    pimage VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    bid INT,
    cid INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (bid) REFERENCES brand(bid) ON DELETE SET NULL,
    FOREIGN KEY (cid) REFERENCES category(cid) ON DELETE SET NULL,
    INDEX idx_product_name (pname),
    INDEX idx_product_price (pprice)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email_Id VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    Contact_No VARCHAR(15) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_customer_email (Email_Id),
    INDEX idx_customer_name (Name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE orders (
    Order_Id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    Customer_City VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Total_Price DECIMAL(10,2) NOT NULL,
    Status VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_orders_date (Date),
    INDEX idx_orders_status (Status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE order_details (
    detail_id INT PRIMARY KEY AUTO_INCREMENT,
    Order_Id INT NOT NULL,
    Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    bname VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    cname VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    pname VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    pprice DECIMAL(10,2) NOT NULL,
    pquantity INT NOT NULL,
    pimage VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    FOREIGN KEY (Order_Id) REFERENCES orders(Order_Id) ON DELETE CASCADE,
    INDEX idx_order_details_order (Order_Id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    bname VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    cname VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    pname VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    pprice DECIMAL(10,2) NOT NULL,
    pquantity INT NOT NULL DEFAULT 1,
    pimage VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_cart_name (Name),
    INDEX idx_cart_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE login (
    username VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    INDEX idx_login_last_login (last_login)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE usermaster (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    Password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    UNIQUE KEY uk_usermaster_name (Name),
    INDEX idx_usermaster_last_login (last_login)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert existing data
INSERT INTO brand (bid, bname) VALUES 
(1,'samsung'),(2,'sony'),(3,'lenovo'),(4,'acer'),(5,'onida');

INSERT INTO category (cid, cname) VALUES 
(1,'laptop'),(2,'tv'),(3,'mobile'),(4,'watch');

INSERT INTO product (pid, pname, pprice, pquantity, pimage, bid, cid) VALUES 
(5,'Sony Smart Watch',50000,100,'sonywatch.webp',2,4),
(6,'Samsung Galaxy Book',45000,100,'samsunglaptop.jpg',1,1),
(7,'Onida Smart TV',28000,100,'onidatv.jpg',5,2),
(8,'Lenovo Smartphone',15000,100,'lenovomobile.webp',3,3),
(9,'Acer Aspire Laptop',52000,100,'acerlaptop.jpg',4,1),
(10,'Sony Bravia TV',52000,100,'sonytv.jpg',2,2),
(11,'Samsung Galaxy Watch',22000,100,'galaxywatch.webp',1,4),
(14,'Sony KDL TV',45000,100,'sony kdl.jpg',2,2),
(15,'Acer Series A7 TV',21000,100,'acer series a7.jpg',4,2),
(17,'Onida Leo TV',31000,100,'onida leo.jpg',5,2),
(18,'Samsung Crystal TV',42000,100,'samsung crystal.webp',1,2),
(19,'Acer Aspire 7 Laptop',55000,100,'acer aspire7.jpg',4,1),
(20,'Lenovo IdeaPad Laptop',37000,100,'lenovo ideapad.jpg',3,1),
(21,'Lenovo Legion Laptop',51000,100,'lenovo legion.jpg',3,1),
(22,'Samsung Galaxy Z Fold3',66000,100,'Galaxy z fold3.jpg',1,3),
(23,'Samsung Galaxy S22',55000,100,'Samsung galaxy s22.webp',1,3),
(24,'Sony Xperia 1V',56000,100,'sony xperia 1v.jpg',2,3),
(26,'Lenovo A850',14500,100,'lenovo a850.jpg',3,3),
(27,'Samsung Galaxy Watch',8000,100,'galaxy watch.jpg',1,4),
(28,'Samsung Galaxy Watch 4',95000,100,'galaxy watch4.jpg',1,4),
(29,'Lenovo Smart Fit Watch',11000,100,'smart fit.jpg',3,4),
(30,'Sony Smart Watch 2',12000,100,'sony smart2.webp',2,4),
(31,'Acer Predator Gaming Laptop',120000,100,'Acer Predator.jpg',4,1),
(32,'Acer Liquid Smartphone',16000,100,'Acer liquid.jpg',4,3),
(33,'Samsung Neo QLED TV',46000,100,'Samsung neo Qled.webp',1,2),
(34,'Sony VAIO Laptop',53000,100,'Sony Vaio.jpg',2,1),
(35,'Sony Xperia Z',32000,100,'sonyxperiaz.png',2,3);

INSERT INTO login (username, password) VALUES ('admin','admin');
INSERT INTO usermaster (Name, Password) VALUES ('admin','admin');

-- Create views with proper indexing
CREATE OR REPLACE VIEW viewlist AS 
SELECT brand.bname, category.cname, product.pname, product.pprice, 
       product.pquantity, product.pimage 
FROM brand 
JOIN product ON brand.bid = product.bid 
JOIN category ON product.cid = category.cid;

CREATE OR REPLACE VIEW mobile AS 
SELECT brand.bname, category.cname, product.pname, product.pprice, 
       product.pquantity, product.pimage 
FROM brand 
JOIN product ON brand.bid = product.bid 
JOIN category ON product.cid = category.cid 
WHERE category.cid = 3;

CREATE OR REPLACE VIEW laptop AS 
SELECT brand.bname, category.cname, product.pname, product.pprice, 
       product.pquantity, product.pimage 
FROM brand 
JOIN product ON brand.bid = product.bid 
JOIN category ON product.cid = category.cid 
WHERE category.cid = 1;

CREATE OR REPLACE VIEW tv AS 
SELECT brand.bname, category.cname, product.pname, product.pprice, 
       product.pquantity, product.pimage 
FROM brand 
JOIN product ON brand.bid = product.bid 
JOIN category ON product.cid = category.cid 
WHERE category.cid = 2;

CREATE OR REPLACE VIEW watch AS 
SELECT brand.bname, category.cname, product.pname, product.pprice, 
       product.pquantity, product.pimage 
FROM brand 
JOIN product ON brand.bid = product.bid 
JOIN category ON product.cid = category.cid 
WHERE category.cid = 4;

-- Add additional indexes for Azure MySQL optimization
CREATE INDEX idx_product_brand ON product(bid);
CREATE INDEX idx_product_category ON product(cid);
CREATE INDEX idx_orders_customer ON orders(Customer_Name);
CREATE INDEX idx_cart_updated ON cart(updated_at);

-- Add performance improvements for better query optimization
CREATE INDEX idx_cart_product ON cart(pname, bname, cname);
CREATE INDEX idx_orders_customer_name ON orders(Customer_Name);
CREATE INDEX idx_order_details_name ON order_details(Name);
CREATE INDEX idx_product_brand_category ON product(bid, cid);
CREATE INDEX idx_customer_contact ON customer(Contact_No);
CREATE INDEX idx_cart_updated_name ON cart(updated_at, Name);

-- Set up event scheduler for maintenance (Azure MySQL compatible)
SET GLOBAL event_scheduler = ON;

DELIMITER //

CREATE EVENT IF NOT EXISTS cleanup_old_carts
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    DELETE FROM cart WHERE updated_at < DATE_SUB(NOW(), INTERVAL 30 DAY);
END //

DELIMITER ;