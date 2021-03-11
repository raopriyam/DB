USE Supermarket
GO

WITH productAvailability_CTE AS	-- CTE to find available quantity
(
	SELECT o.productID, p.productName, (AVG(p.productQuantity) - SUM(o.quantity)) AS remainingQuantity
	FROM OrderItems AS o 
	INNER JOIN Products AS p ON o.productID = p.productID					
	GROUP BY o.productID, p.productName
)
-- Execution of the CTE to check the product availability
SELECT * FROM productAvailability_CTE;