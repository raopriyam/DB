/* Drop the Database if it already exists */
DROP DATABASE IF EXISTS Supermarket
CREATE DATABASE Supermarket

GO
USE Supermarket
GO

/* Creating Customers Table */
CREATE TABLE [dbo].[Customers](
	[customerID] [nvarchar](5) NOT NULL PRIMARY KEY,
	[customerName] [nvarchar](30) NOT NULL,
	[customerPhone] [nvarchar](24) NOT NULL,
	[customerEmail] [nvarchar](30) NOT NULL,
	[dateBecomeCustomer] [date] NULL
)

/* Creating Addresses Table */
CREATE TABLE [dbo].[Addresses](
	[addressID] [nvarchar](5) NOT NULL PRIMARY KEY,
	[street] [nvarchar](60) NOT NULL,
	[city] [nvarchar](30) NOT NULL,
	[zipcode] [nvarchar](15) NOT NULL,
	[stateProvince] [nvarchar](30) NULL,
	[country] [nvarchar](15) NULL
)

/* Creating Suppliers Table */
CREATE TABLE [dbo].[Suppliers](
	[supplierID] [nvarchar] (5) NOT NULL PRIMARY KEY,
	[addressID] [nvarchar](5) NOT NULL,
	[supplierName] [nvarchar](40) NOT NULL,
	[contactName] [nvarchar](30) NOT NULL,
	[supplierPhone] [nvarchar](24) NOT NULL,
	[supplierEmail] [nvarchar](30) NOT NULL,
	FOREIGN KEY(addressID) REFERENCES Addresses(addressID)
)

/* Creating Employees Table */
CREATE TABLE [dbo].[Employees](
	[employeeID] [nvarchar] (5) NOT NULL PRIMARY KEY,
	[addressID] [nvarchar](5) NOT NULL,
	[employeeName] [nvarchar](30) NOT NULL,
	[employeePhone] [nvarchar](24) NOT NULL,
	[employeeEmail] [nvarchar](30) NOT NULL,
	FOREIGN KEY(addressID) REFERENCES Addresses(addressID)
)

/* Creating Products Table */
CREATE TABLE [dbo].[Products](
	[productID] [nvarchar] (5) NOT NULL PRIMARY KEY,
	[supplierID] [nvarchar] (5) NOT NULL,
	[productName] [nvarchar](70) NOT NULL,
	[productType] [nvarchar] (30) NOT NULL,
	[productPrice] [money] NOT NULL,
	[productQuantity] [int] NOT NULL,
	[productDescription] [nvarchar](70) NULL,
	FOREIGN KEY(supplierID) REFERENCES Suppliers(supplierID)
)

/* Creating Orders Table */
CREATE TABLE [dbo].[Orders](
	[orderID] [nvarchar] (5) NOT NULL PRIMARY KEY,
	[customerID] [nvarchar](5) NOT NULL,
	[orderStatusCode] [nvarchar] (20) NOT NULL CHECK(orderStatusCode = 'Ordered' OR orderStatusCode = 'Delivered' OR orderStatusCode = 'Collected' OR orderStatusCode = 'Pending'),
	[orderDate] [date] NULL,
	[paidStatus] [nvarchar] (20) NULL CHECK (paidStatus = 'Yes' OR paidStatus = 'No'),
	[orderDetails] [nvarchar] (30) NULL CHECK (orderDetails = 'Delivery' OR orderDetails = 'Pick-up'),
	FOREIGN KEY(customerID) REFERENCES Customers(customerID),
)

/* Creating OrderItems Table */
CREATE TABLE [dbo].[OrderItems](
	[orderID] [nvarchar] (5) NOT NULL,
	[productID] [nvarchar] (5) NOT NULL,
	[quantity] [int] NOT NULL,
	FOREIGN KEY(orderID) REFERENCES Orders(orderID),
	FOREIGN KEY(productID) REFERENCES Products(productID)
)

/* Creating Deliveries Table */
CREATE TABLE [dbo].[Deliveries](
	[deliveryID] [nvarchar] (5) NOT NULL PRIMARY KEY,
	[employeeID] [nvarchar] (5) NOT NULL,
	[orderID] [nvarchar] (5) NOT NULL,
	[deliveryStatusCode] [nvarchar] (20) NOT NULL CHECK (deliveryStatusCode = 'Yes' OR deliveryStatusCode = 'No'),
	[deliveryDate] [date] NOT NULL,
	FOREIGN KEY(employeeID) REFERENCES Employees(employeeID),
	FOREIGN KEY(orderID) REFERENCES Orders(orderID)
)

/* Creating CustomerAddresses Table */
CREATE TABLE [dbo].[CustomerAddresses](
	[customerAddressID] [nvarchar] (10) NOT NULL PRIMARY KEY,
	[customerID] [nvarchar](5) NOT NULL,
	[addressID] [nvarchar](5) NOT NULL,
	[dateFrom] [date] NULL,
	[dateTo] [date] NULL,
	FOREIGN KEY(customerID) REFERENCES Customers(customerID),
	FOREIGN KEY(addressID) REFERENCES Addresses(addressID)
)

/* Inserting Data in Customers Table */
INSERT dbo.Customers (customerID, customerName, customerPhone, customerEmail, dateBecomeCustomer) 
VALUES ('C1', 'John Nash', '480-224-223', 'jnash@gmail.com', '2019-05-24'),
('C2', 'Kevin Barton', '480-453-243', 'kbarton@gmail.com', '2019-07-04'),
('C3', 'Stuart Broad', '480-334-113', 'sbroad@gmail.com', '2019-12-15'),
('C4', 'William Smith', '480-543-621', 'wsmith@gmail.com', '2019-09-10'),
('C5', 'Josh Barton', '480-278-123', 'jbarton@gmail.com', '2019-11-22'),
('C6', 'Scarlett Johnson', '480-324-163', 'sjohnson@sgmail.com', '2019-04-09'),
('C7', 'James Bond', '480-363-556', 'jbond@gmail.com', '2019-11-25'),
('C8', 'Tom Cruise', '480-779-055', 'tcruise@gmail.com', '2019-06-19'),
('C9', 'Brad Pitt', '480-584-096', 'bpitt@gmail.com', '2019-10-11'),
('C10', 'Steve Smith', '480-390-843', 'ssmith@gmail.com', '2019-07-20'),
('C11', 'Jennifer Lawrence', '480-374-183', 'jlawrence@gmail.com', '2019-10-06'),
('C12', 'Mathew Perry', '480-885-543', 'mperry@gmail.com', '2019-08-29'),
('C13', 'Chris Evans', '480-975-108', 'cevans@gmail.com', '2019-05-23'),
('C14', 'Tony Stark', '480-783-113', 'tstark@gmail.com', '2019-08-01'),
('C15', 'James Kirk', '480-347-982', 'jkirk@gmail.com', '2019-09-19')

/* Inserting Data in Addresses Table */
INSERT dbo.Addresses (addressID, street, city, zipcode, stateProvince, country) 
VALUES ('A1', '236 Cinema Drive, Suite #456', 'Tempe', '05242', 'Arizona', 'USA'),
('A2', '782 Rural Road, Apt. #642', 'Tempe', '13472', 'Arizona', 'USA'),
('A3', '488 Mountain Park, Suite #433', 'Tempe', '78931', 'Arizona', 'USA'),
('A4', '811 University Drive, Apt. #732', 'Tempe', '46751', 'Arizona', 'USA'),
('A5', '435 Rural Road, Suite #402', 'Tempe', '13472', 'Arizona', 'USA'),
('A6', '446 Mill Ave Loop, Suite #672', 'Tempe', '05242', 'Arizona', 'USA'),
('A7', '463 Rural Drive, Suite #157', 'Tempe', '46751', 'Arizona', 'USA'),
('A8', '136 Mill Ave Loop, Suite #562', 'Tempe', '78931', 'Arizona', 'USA'),
('A9', '346 University Drive, Apt. #156', 'Tempe', '46751', 'Arizona', 'USA'),
('A10', '771 Mountain Park, Apt. #721', 'Tempe', '13472', 'Arizona', 'USA'),
('A11', '123 Rural Road, Apt. #762', 'Tempe', '46751', 'Arizona', 'USA'),
('A12', '734 Mill Ave Loop, Suite #163', 'Tempe', '05242', 'Arizona', 'USA'),
('A13', '125 Rural Drive, Suite #733', 'Tempe', '78931', 'Arizona', 'USA'),
('A14', '155 Mountain Park, Apt. #167', 'Tempe', '13472', 'Arizona', 'USA'),
('A15', '622 University Drive, Suite #234', 'Tempe', '05242', 'Arizona', 'USA'),
('A16', '562 Rural Road, Apt. #515', 'Tempe', '05242', 'Arizona', 'USA'),
('A17', '672 Damstel Drive, Apt. #832', 'Mesa', '65512', 'Arizona', 'USA'),
('A18', '367 Space Park, Suite #236', 'Tucson', '05782', 'Arizona', 'USA'),
('A19', '467 Mill Ave, Apt. #722', 'Tucson', '67512', 'Arizona', 'USA'),
('A20', '167 Rural Drive, Suite #267', 'Tempe', '13472', 'Arizona', 'USA'),
('A21', '256 Mountain Park, Suite #113', 'Tempe', '78931', 'Arizona', 'USA'),
('A22', '733 Maiden House, Suite #721', 'Scottsdale', '64215', 'Arizona', 'USA'),
('A23', '623 Vista-del East, Apt. #523', 'Mesa', '86524', 'Arizona', 'USA'),
('A24', '635 University Drive, Suite #611', 'Tempe', '46751', 'Arizona', 'USA'),
('A25', '621 University Loop, Apt. #743', 'Phoenix', '73258', 'Arizona', 'USA'),
('A26', '832 Western Loop, Apt. #136', 'Tucson', '63312', 'Arizona', 'USA'),
('A27', '838 Apex Road, Apt. #721', 'Sedona', '26772', 'Arizona', 'USA'),
('A28', '254 University Park, Apt. #987', 'Flagstaff', '27821', 'Arizona', 'USA'),
('A29', '682 Drive-in Road, Suite #118', 'Scottsdale', '67237', 'Arizona', 'USA'),
('A30', '782 Vista-del Serro, Suite #132', 'Phoenix', '57232', 'Arizona', 'USA'),
('A31', '471 Serangoon Loop, Suite #402', 'Mesa', '05512', 'Arizona', 'USA'),
('A32', 'Lyngbysild Fiskebakken 10', 'Lyngby', '2800', 'Copenhagen', 'Denmark'),
('A33', 'Verkoop Rijnweg 22', 'Zaandam', '9999 ZZ', 'North Holland', 'Netherlands'),
('A34', 'Valtakatu 12', 'Lappeenranta', '53120', 'South Karelia', 'Finland'),
('A35', '170 Prince Edward Parade Hunter''s Hill', 'Sydney', '2048', 'New South Wales', 'Australia'),
('A36', '2960 Rue St. Laurent', 'Montréal', 'H1J 1C3', 'Québec', 'Canada'),
('A37', 'Via dei Gelsomini, 153', 'Salerno', '84100', 'Campania', 'Italy'),
('A38', '22, rue H. Voiron', 'Montceau', '71300', ' Bourgogne-Franche-Comté', 'France'),
('A39', '148 rue Chasseur', 'Ste-Hyacinthe', 'J2S 7S8', 'Québec', 'Canada'),
('A40', 'Order Processing Dept. 2100 Paul Revere Blvd.', 'Boston', '02134', 'Massachusetts', 'USA')

/* Inserting Data in Suppliers Table */
INSERT dbo.Suppliers (supplierID, addressID, supplierName, contactName, supplierPhone, supplierEmail) 
VALUES('S1', 'A31', 'Leka Trading', 'Chandra Leka', '480-321-009', 'cleka@lekatrading.com'),
('S2', 'A32', 'Lyngbysild', 'Niels Petersen', '43-844-108', 'npeterson@lyngbysild.com'),
('S3', 'A33', 'Zaanse Snoepfabriek', 'Dirk Luchte', '12345-1212', 'dlauchte@zaanse'),
('S4', 'A34', 'Karkki Oy', 'Anne Heikkonen', '953-10956', 'aheikkonnen@karkki.com'),
('S5', 'A35', 'G''day, Mate', 'Wendy Mackenzie', '02-555-5914', 'wmackenzie@mate.com'),
('S6', 'A36', 'Ma Maison', 'Jean-Guy Lauzon', '514-555-9022', 'jlauzon@maison.com'),
('S7', 'A37', 'Pasta Buttini s.r.l.', 'Giovanni Giudici', '089-6547665', 'ggiuddci@srl.com'),
('S8', 'A38', 'Escargots Nouveaux', 'Marie Delamare', '85-57-00-07', 'mdelamare@nouveaux.com'),
('S9', 'A39', 'Forêts d''érables', 'Chantal Goulet','514-555-2955', 'cgoulet@forets.com'),
('S10', 'A40', 'New England Seafood Cannery', 'Robb Merchant', '617-555-3267', 'rmerchant@cannery.com')

/* Inserting Data in Employees Table */
INSERT dbo.Employees (employeeID, addressID, employeeName, employeePhone, employeeEmail) 
VALUES ('E1', 'A16', 'Roger Sanders', '480-954-912', 'rsanders@supermarket.com'),
('E2', 'A17', 'Jamie Lannister', '480-562-182', 'rsanders@supermarket.com'),
('E3', 'A18', 'White Walker', '480-346-621', 'rsanders@supermarket.com'),
('E4', 'A19', 'John Snow', '480-935-146', 'rsanders@supermarket.com'),
('E5', 'A20', 'Arya Stark', '480-256-915', 'rsanders@supermarket.com'),
('E6', 'A21', 'Lionel Shrike', '480-564-432', 'rsanders@supermarket.com'),
('E7', 'A22', 'keenu Reeves', '480-874-624', 'rsanders@supermarket.com'),
('E8', 'A23', 'Catherine Teran', '480-638-714', 'rsanders@supermarket.com'),
('E9', 'A24', 'Myra Mints', '480-146-671', 'rsanders@supermarket.com'),
('E10', 'A25', 'George Clooney', '480-182-721', 'rsanders@supermarket.com'),
('E11', 'A26', 'Samuel Jackson', '480-788-236', 'rsanders@supermarket.com'),
('E12', 'A27', 'Roberto Mancini', '480-721-267', 'rsanders@supermarket.com'),
('E13', 'A28', 'Carlos Corey', '480-546-745', 'rsanders@supermarket.com'),
('E14', 'A29', 'Roy Hudson', '480-771-734', 'rsanders@supermarket.com'),
('E15', 'A30', 'James Milner', '480-672-666', 'rsanders@supermarket.com')

/* Inserting Data in Products Table */
INSERT dbo.Products (productID, supplierID, productName, productType, productPrice, productQuantity, productDescription) 
VALUES ('P1', 'S1', 'Chai', 'Beverages', 18.0000, 50, 'Tea boxes'),
('P2', 'S1', 'Smarthem', 'Beverages', 19.0000, 50, 'Water Bottles'),
('P3', 'S2', 'Black Beans', 'Canned Goods', 10.0000, 50, 'Preserved beans'),
('P4', 'S3', 'Chef Anton''s Cajun Seasoning', 'Condiments', 22.0000, 50, 'Cajun Jars'),
('P5', 'S3', 'Strawberry Squeezer', 'Beverages', 21.3500, 50, 'Strawberry Juice'),
('P6', 'S4', 'Signature Peanut Butter Spread', 'Snacks', 25.0000, 50, 'Peanut Butter Spread'),
('P7', 'S5', 'Cheese Pizza', 'Frozen Food', 30.0000, 50, 'Frozen Cheese Pizza'),
('P8', 'S4', 'Signature Chocolate', 'Icecream', 40.0000, 50, 'Chocolate Icecream'),
('P9', 'S5', 'Ruffles Chips', 'Snacks', 7.0000, 50, 'Chips Snacks'),
('P10', 'S6', 'Milk', 'Dairy', 5.0000, 50, 'Dairy Signature Milk'),
('P11', 'S7', 'Tomatoes', 'Vegetables', 21.0000, 50, 'Raw Vegetables'),
('P12', 'S7', 'Onions', 'Vegetables', 38.0000, 50, 'Raw Vegetables'),
('P13', 'S7', 'Potatoes', 'Vegetables', 6.0000, 50, 'Raw Vegetables'),
('P14', 'S8', 'Paper Towels', 'Paper Products', 23.2500, 50, 'Paper product'),
('P15', 'S9', 'Green Peas', 'Canned Goods', 15.5000, 50, 'Preserved Cans'),
('P16', 'S9', 'Tide Clothes Cleaner', 'Cleaning Supplies', 17.4500, 50, 'Clothes Cleaner Boxes'),
('P17', 'S10', 'Alice Mutton', 'Meat & Seafood', 39.0000, 50, 'Mutton Packets'),
('P18', 'S10', 'Fish Fingers', 'Meat & Seafood', 32.5000, 50, 'Fish Packets'),
('P19', 'S8', 'Teatime Chocolate Biscuits', 'Snacks', 9.2000, 50, 'Biscuits Packets'),
('P20', 'S8', 'Salsa Chutney', 'Condiments', 8.0000, 50, 'Salsa dip')

/* Inserting Data in Orders Table */
INSERT dbo.Orders (orderID, customerID, orderStatusCode, orderDate, paidStatus, orderDetails) 
VALUES ('O1', 'C1', 'Ordered', '2019-11-21', 'No', 'Delivery'),
('O2', 'C2', 'Ordered', '2019-12-01', 'No', 'Delivery'),
('O3', 'C3', 'Ordered', '2019-12-19', 'No', 'Delivery'),
('O4', 'C4', 'Ordered', '2019-12-29', 'No', 'Delivery'),
('O5', 'C5', 'Ordered', '2019-12-21', 'No', 'Pick-up'),
('O6', 'C6', 'Ordered', '2019-12-26', 'No', 'Delivery'),
('O7', 'C7', 'Ordered', '2019-12-12', 'No', 'Delivery'),
('O8', 'C8', 'Collected', '2019-10-05', 'Yes', 'Pick-up'),
('O9', 'C9', 'Ordered', '2019-12-11', 'No', 'Delivery'),
('O10', 'C10', 'Ordered', '2019-11-01', 'No', 'Delivery'),
('O11', 'C11', 'Ordered', '2019-10-29', 'No', 'Delivery'),
('O12', 'C12', 'Ordered', '2019-11-24', 'No', 'Pick-up'),
('O13', 'C13', 'Ordered', '2019-12-09', 'No', 'Delivery'),
('O14', 'C14', 'Ordered', '2019-12-08', 'No', 'Pick-up'),
('O15', 'C15', 'Ordered', '2019-11-15', 'No', 'Delivery'),
('O16', 'C15', 'Delivered', '2019-05-02', 'Yes', 'Delivery'),
('O17', 'C14', 'Delivered', '2019-08-27', 'Yes', 'Delivery'),
('O18', 'C13', 'Delivered', '2019-06-11', 'Yes', 'Delivery'),
('O19', 'C12', 'Delivered', '2019-07-16', 'Yes', 'Delivery'),
('O20', 'C11', 'Collected', '2019-08-21', 'Yes', 'Pick-up'),
('O21', 'C10', 'Delivered', '2019-09-17', 'Yes', 'Delivery'),
('O22', 'C9', 'Delivered', '2019-09-19', 'Yes', 'Delivery'),
('O23', 'C8', 'Delivered', '2019-11-29', 'Yes', 'Delivery'),
('O24', 'C7', 'Collected', '2019-11-09', 'Yes', 'Pick-up'),
('O25', 'C6', 'Delivered', '2019-11-05', 'Yes', 'Delivery'),
('O26', 'C5', 'Delivered', '2019-11-04', 'Yes', 'Delivery'),
('O27', 'C4', 'Collected', '2019-12-08', 'Yes', 'Pick-up'),
('O28', 'C3', 'Collected', '2019-06-21', 'Yes', 'Pick-up'),
('O29', 'C2', 'Delivered', '2019-11-23', 'Yes', 'Delivery'),
('O30', 'C1', 'Collected', '2019-11-10', 'Yes', 'Pick-up'),
('O31', 'C15', 'Pending', '2019-12-25', 'NO', 'Delivery'),
('O32', 'C10', 'Pending', '2019-12-21', 'NO', 'Delivery'),
('O33', 'C5', 'Pending', '2019-12-15', 'NO', 'Delivery'),
('O34', 'C2', 'Pending', '2019-12-20', 'NO', 'Delivery'),
('O35', 'C1', 'Pending', '2019-12-11', 'NO', 'Delivery')


/* Inserting Data in OrderItems Table */
INSERT dbo.OrderItems (orderID, productID, quantity) 
VALUES ('O1', 'P1', 2),
('O1', 'P2', 3),
('O2', 'P3', 4),
('O2', 'P4', 5),
('O3', 'P5', 2),
('O3', 'P6', 3),
('O4', 'P7', 3),
('O4', 'P8', 1),
('O5', 'P9', 5),
('O5', 'P10', 2),
('O6', 'P11', 5),
('O6', 'P12', 1),
('O7', 'P13', 2),
('O7', 'P14', 7),
('O8', 'P15', 3),
('O8', 'P16', 5),
('O9', 'P17', 6),
('O9', 'P18', 4),
('O10', 'P19', 1),
('O10', 'P20', 3),
('O11', 'P2', 6),
('O11', 'P4', 7),
('O12', 'P6', 8),
('O12', 'P8', 4),
('O13', 'P10', 5),
('O13', 'P12', 3),
('O14', 'P14', 5),
('O14', 'P16', 3),
('O15', 'P18', 5),
('O15', 'P20', 2),
('O16', 'P1', 4),
('O16', 'P3', 5),
('O17', 'P5', 3),
('O17', 'P7', 4),
('O18', 'P9', 3),
('O18', 'P11', 4),
('O19', 'P13', 2),
('O20', 'P15', 2),
('O20', 'P17', 4),
('O21', 'P19', 3),
('O21', 'P1', 2),
('O22', 'P2', 3),
('O22', 'P3', 2),
('O23', 'P4', 3),
('O23', 'P5', 5),
('O24', 'P6', 1),
('O24', 'P7', 1),
('O25', 'P8', 1),
('O25', 'P9', 2),
('O26', 'P10', 3),
('O26', 'P11', 5),
('O27', 'P12', 3),
('O27', 'P13', 4),
('O28', 'P14', 2),
('O28', 'P15', 1),
('O29', 'P16', 1),
('O29', 'P1', 4),
('O30', 'P7', 1),
('O30', 'P8', 3),
('O31', 'P2', 5),
('O32', 'P6', 1),
('O33', 'P4', 1),
('O34', 'P6', 4),
('O35', 'P5', 2),
('O1', 'P15', 2),
('O2', 'P16', 2),
('O3', 'P17', 3),
('O4', 'P18', 7),
('O5', 'P19', 2),
('O6', 'P20', 1)

/*
	Inserting Data in Deliveries Table
	Orders in Pending and Pick-up State won't be present under deliveries table.
*/
INSERT dbo.Deliveries (deliveryID, employeeID, orderID, deliveryStatusCode, deliveryDate) 
VALUES ('D1', 'E12', 'O1', 'No', '2019-11-28'),
('D2', 'E13', 'O2', 'No', '2019-12-08'),
('D3', 'E14', 'O3', 'No', '2019-12-27'),
('D4', 'E15', 'O4', 'No', '2020-01-07'),
('D5', 'E12', 'O6', 'No', '2020-01-02'),
('D6', 'E13', 'O7', 'No', '2019-12-19'),
('D7', 'E14', 'O9', 'No', '2019-12-18'),
('D8', 'E15', 'O10', 'No', '2019-11-08'),
('D9', 'E15', 'O11', 'No', '2019-11-07'),
('D10', 'E14', 'O13', 'No', '2019-12-16'),
('D11', 'E13', 'O15', 'No', '2019-11-23'),
('D12', 'E12', 'O16', 'Yes', '2019-05-09'),
('D13', 'E13', 'O17', 'Yes', '2019-09-04'),
('D14', 'E14', 'O18', 'Yes', '2019-06-18'),
('D15', 'E12', 'O19', 'Yes', '2019-07-22'),
('D16', 'E15', 'O21', 'Yes', '2019-09-24'),
('D17', 'E12', 'O22', 'Yes', '2019-09-26'),
('D18', 'E15', 'O23', 'Yes', '2019-12-07'),
('D19', 'E14', 'O25', 'Yes', '2019-11-12'),
('D20', 'E12', 'O26', 'Yes', '2019-11-11'),
('D21', 'E13', 'O29', 'Yes', '2019-11-30')

/*
	Inserting Data in CustomerAddresses Table
	CustomerAddresses Table should be updated automatically and dateBecomeCustomer data should be used in dateFrom
*/
INSERT dbo.CustomerAddresses (customerAddressID, customerID, addressID, dateFrom) 
VALUES ('CA1', 'C1', 'A1', '2019-05-24'),
('CA2', 'C2', 'A2', '2019-07-04'),
('CA3', 'C3', 'A3', '2019-12-15'),
('CA4', 'C4', 'A4', '2019-09-10'),
('CA5', 'C5', 'A5', '2019-11-22'),
('CA6', 'C6', 'A6', '2019-04-09'),
('CA7', 'C7', 'A7', '2019-11-25'),
('CA8', 'C8', 'A8', '2019-06-19'),
('CA9', 'C9', 'A9', '2019-10-11'),
('CA10', 'C10', 'A10', '2019-07-20'),
('CA11', 'C11', 'A11', '2019-10-06'),
('CA12', 'C12', 'A12', '2019-08-29'),
('CA13', 'C13', 'A13', '2019-05-23'),
('CA14', 'C14', 'A14', '2019-08-01'),
('CA15', 'C15', 'A15', '2019-09-19')