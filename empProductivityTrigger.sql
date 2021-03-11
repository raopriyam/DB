			/*Employee Productivity Trigger*/
USE Supermarket
GO

DROP TRIGGER IF EXISTS employeeProductivityTrigger;
GO

CREATE TRIGGER employeeProductivityTrigger ON Deliveries 
	AFTER INSERT, UPDATE
AS
	BEGIN
		IF OBJECT_ID('tempdb..#productivityDemo') IS NOT NULL
			DROP TABLE #productivityDemo
		-- Get the total number of deliveries
		SELECT e.employeeID, e.employeeName, COUNT(*) AS totalDeliveries INTO #productivityDemo 
			FROM Deliveries AS d 
			INNER JOIN Employees AS e ON e.employeeID=d.employeeID
			GROUP BY e.employeeID, e.employeeName;

		IF OBJECT_ID('tempdb..#productivityDemo1') IS NOT NULL
			DROP TABLE #productivityDemo1
		-- Get the total delivered by each employee
		SELECT e.employeeID, e.employeeName, COUNT(*) AS totalDelivered INTO #productivityDemo1 
		FROM Deliveries AS d 
		INNER JOIN Employees AS e ON e.employeeID=d.employeeID 
		WHERE d.deliveryStatusCode='yes' 
		GROUP BY e.employeeID, e.employeeName;

		SELECT a.employeeID, a.employeeName, (b.totalDelivered*100)/a.totalDeliveries AS Productivity 
		FROM #productivityDemo AS a 
		INNER JOIN #productivityDemo1 AS b ON a.employeeID=b.employeeID;
		
		DECLARE @Order_ID NVARCHAR(5)
		SELECT @Order_ID = cast(SESSION_CONTEXT(N'Order_ID') as NVARCHAR(5))

		DECLARE @Delivery_Code NVARCHAR(5)
		SELECT @Delivery_Code = cast(SESSION_CONTEXT(N'Delivery_Code') as NVARCHAR(5))

		IF @Delivery_Code = (SELECT deliveryStatusCode FROM Deliveries WHERE orderID=@Order_ID)
			UPDATE Orders SET orderStatusCode='Delivered' WHERE orderID=@Order_ID
		ELSE
			UPDATE Orders SET orderStatusCode='Ordered' WHERE orderID=@Order_ID
END

-- Data to check the trigger
GO
EXEC sp_set_session_context @key = N'Order_ID', @value = O13
EXEC sp_set_session_context @key = N'Delivery_Code', @value = Yes

UPDATE Deliveries SET deliveryStatusCode='Yes' WHERE orderID=cast(SESSION_CONTEXT(N'Order_ID') as NVARCHAR(5))

SELECT * FROM Orders WHERE orderID=cast(SESSION_CONTEXT(N'Order_ID') as NVARCHAR(5))

--Data to Revert the results
GO
EXEC sp_set_session_context @key = N'Order_ID', @value = O13
EXEC sp_set_session_context @key = N'Delivery_Code', @value = Yes

UPDATE Deliveries SET deliveryStatusCode='No' WHERE orderID=cast(SESSION_CONTEXT(N'Order_ID') as NVARCHAR(5))

SELECT * FROM Orders WHERE orderID=cast(SESSION_CONTEXT(N'Order_ID') as NVARCHAR(5))