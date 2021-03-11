	/* The following is a stored procedure which can be used to get the total income of store */
USE Supermarket
GO

IF OBJECT_ID('storeEarnings') IS NOT NULL
	DROP PROC storeEarnings
GO

CREATE PROCEDURE storeEarnings
AS
	BEGIN
		IF OBJECT_ID('tempdb..#tempTableForBill') IS NOT NULL
			DROP TABLE #tempTableForBill
		
		SELECT o.orderID, SUM(p.productPrice * p.productQuantity) AS totalPrice INTO #tempTableForBill 
		FROM Orders AS o					-- used concept of temporary table here
		INNER JOIN OrderItems AS oi ON o.orderID = oi.orderID 
		INNER JOIN Products AS p ON oi.productID = p.productID  
		GROUP by o.orderID;
					
		SELECT SUM(totalPrice) AS Total_Store_Earnings FROM #tempTableForBill;
	END

GO
EXEC storeEarnings