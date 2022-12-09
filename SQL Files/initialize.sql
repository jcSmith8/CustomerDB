DROP SEQUENCE customer_seq;
DROP SEQUENCE order_seq;
DROP SEQUENCE line_seq;
DROP SEQUENCE item_seq;

DROP TABLE OrderLineItem;
DROP TABLE CustOrder;
DROP TABLE StoreItem;
DROP TABLE Customer;

CREATE SEQUENCE customer_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE order_seq
START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE line_seq
START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE item_seq
START WITH 1 INCREMENT BY 1;


CREATE TABLE Customer(
	custId int PRIMARY KEY,
	custType varchar(10),
       	name varchar(30),
       	phoneNum number,
       	address varchar(50),
	dateJoined DATE DEFAULT NULL,	--dateJoined and coupon exclusive to custType=Gold
	coupon int DEFAULT NULL		--values will be NULL for custType=regular
);

CREATE TABLE CustOrder (
       	orderID int PRIMARY KEY,
	custID int,
       	orderDate varchar(30),
       	shippedDate varchar(30),
       	shippingFee number,
	quantity int,
	grandTotal number,
	CONSTRAINT fk_custOrd
		FOREIGN KEY (custID)
		REFERENCES Customer(custID)
);

CREATE TABLE StoreItem (
	itemID int PRIMARY KEY,
	itemType VARCHAR(15), --can be "comicBook", or "cartoonMovie"
	price number,
	numCopies int,
	title VARCHAR(64),
	publishDate VARCHAR(15) DEFAULT NULL, --only for itemType=comicBook
	studioName VARCHAR(64) DEFAULT NULL, --only for itemType=cartoonMovie
	description VARCHAR(256) DEFAULT NULL
);

CREATE TABLE OrderLineItem (
	lineID int UNIQUE,
	orderID int,
	itemID int,
       	quantity int,
	lineprice number,	
	CONSTRAINT primary_line
		PRIMARY KEY(lineID, orderID),
	CONSTRAINT fk_lineItem
		FOREIGN KEY (itemID)
		REFERENCES StoreItem(itemID),
	CONSTRAINT fk_lineOrder
		FOREIGN KEY (orderID)
		REFERENCES CustOrder(orderID)
);

-- 2a
-- Inserts Customers, Book storeitems, Movie storeitems

-- Customer inserts
insert into Customer(custID, custType, name, phoneNum, address) values (customer_seq.nextval, 'Gold', 'John Smith', '6501234567', '412 Ortega Way');
insert into Customer(custID, custType, name, phoneNum, address) values (customer_seq.nextval, 'Regular', 'John Boston', '4081312299', '999 Escro Lane');
insert into Customer(custID, custType, name, phoneNum, address) values (customer_seq.nextval, 'Gold', 'Sarah Johnson', '6504126661', '813 Terrance Road');
insert into Customer(custID, custType, name, phoneNum, address) values (customer_seq.nextval, 'Regular', 'Joe Bill', '6505555555', '913 Fort Road');
insert into Customer(custID, custType, name, phoneNum, address) values (customer_seq.nextval, 'Gold', 'Joy Sokich', '1234567891', '42 Oregon Trail');
insert into Customer(custID, custType, name, phoneNum, address) values (customer_seq.nextval, 'Regular', 'Bill Russell', '8881032222', '500 El Camino Real');
insert into Customer(custID, custType, name, phoneNum, address) values (customer_seq.nextval, 'Regular', 'Mary Nordmeyer', '6508881000', '969 Snail Way');
insert into Customer(custID, custType, name, phoneNum, address) values (customer_seq.nextval, 'Regular', 'Billiard Billingson', '6501235555', '444 Lowrider Lane');
insert into Customer(custID, custType, name, phoneNum, address) values (customer_seq.nextval, 'Gold', 'Josephine Richardson', '4087777408', '412 Ortega Way');


-- Book insert
INSERT INTO StoreItem(itemID, itemType, price, numCopies, title, publishDate) values (item_seq.nextval, 'Book', '25.25', 10, 'Harry Potter', '08-08-2009');
INSERT INTO StoreItem(itemID, itemType, price, numCopies, title, publishDate) values (item_seq.nextval, 'Book', '10.50', 20, 'Harry Potter 2', '09-08-2015');
INSERT INTO StoreItem(itemID, itemType, price, numCopies, title, publishDate) values (item_seq.nextval, 'Book', '30.00', 4, 'Harry Potter 3', '10-08-2008');
INSERT INTO StoreItem(itemID, itemType, price, numCopies, title, publishDate) values (item_seq.nextval, 'Book', '17.99', 102, 'Dr. Seuss', '01-23-2020');
INSERT INTO StoreItem(itemID, itemType, price, numCopies, title, publishDate) values (item_seq.nextval, 'Book', '14.59', 13232, 'Poetry', '06-15-2019');
INSERT INTO StoreItem(itemID, itemType, price, numCopies, title, publishDate) values (item_seq.nextval, 'Book', '99.99', 2, 'Stephen King', '08-31-2022');


-- Movie insert
INSERT INTO StoreItem(itemID, itemType, price, numCopies, title, studioName) values (item_seq.nextval, 'Movie', '20.00', 30, 'Avengers', 'Marvel Studio');
INSERT INTO StoreItem(itemID, itemType, price, numCopies, title, studioName) values (item_seq.nextval, 'Movie', '20.99', 30, 'Avengers 2', 'Marvel Studio');
INSERT INTO StoreItem(itemID, itemType, price, numCopies, title, studioName) values (item_seq.nextval, 'Movie', '30.50', 30, 'Avengers 3', 'Marvel Studio');
INSERT INTO StoreItem(itemID, itemType, price, numCopies, title, studioName) values (item_seq.nextval, 'Movie', '5.12', 30, 'Avengers 4', 'Marvel Studio');
INSERT INTO StoreItem(itemID, itemType, price, numCopies, title, studioName) values (item_seq.nextval, 'Movie', '1.99', 30, 'Avengers 5', 'Marvel Studio');
INSERT INTO StoreItem(itemID, itemType, price, numCopies, title, studioName) values (item_seq.nextval, 'Movie', '2.50', 30, 'Avengers 6', 'Marvel Studio');

-- CustOrder insert
INSERT INTO CustOrder(orderID, custID, orderDate, shippedDate, shippingFee, quantity, grandTotal) values (order_seq.nextval, 8, 0, 0, 0, 0, 0);

