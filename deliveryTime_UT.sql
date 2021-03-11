USE Supermarket
GO

DROP TABLE IF EXISTS #deliveryTime_UT; -- Dropping table if it exists

-- Creating temporary table to show the delivery time
CREATE TABLE #deliveryTime_UT(orderID NVARCHAR(5), customerID NVARCHAR(5), orderStatusCode NVARCHAR(30), deliveryTime INT)

-- Using DATEDIFF function to find the difference between deliverydate and orderdate
INSERT INTO #deliveryTime_UT
	SELECT o.orderID, o.customerID, orderStatusCode, DATEDIFF(day,o.orderDate,d.deliveryDate) AS deliverytime
	FROM Orders AS o 
	INNER JOIN Deliveries AS d ON o.orderID = d.orderID
	WHERE orderStatusCode = 'Delivered';

-- Execution of the created user table to check the data
SELECT * FROM #deliveryTime_UT;