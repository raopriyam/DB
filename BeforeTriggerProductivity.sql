USE Supermarket
GO

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

GO
EXEC sp_set_session_context @key = N'Order_ID', @value = O13
SELECT * FROM Orders WHERE orderID=cast(SESSION_CONTEXT(N'Order_ID') as NVARCHAR(5))