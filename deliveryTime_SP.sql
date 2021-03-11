USE Supermarket;
GO

DROP PROC IF EXISTS dbo.deliveryTime_sp; -- Drop procedure if exists
GO

CREATE PROC deliveryTime_sp -- creating stored procedure deliveryTime_sp
AS
	SELECT o.orderID, o.customerID, orderStatusCode , 
		DATEDIFF(day,o.orderDate,d.deliveryDate) AS deliverytime
	FROM Orders AS o 
	INNER JOIN Deliveries as d ON o.orderID = d.orderID
	WHERE orderStatusCode = 'Delivered';

-- Executing the Stored Procedure to check the customer experience based on delivery time
GO
EXEC deliveryTime_sp; 

