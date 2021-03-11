/* Trending Product */
USE Supermarket
GO

SELECT p.productName, COUNT(*) AS totalOrders 
	FROM Products AS p
	LEFT JOIN OrderItems AS o ON p.productID=o.productID 
	GROUP BY p.productName
	ORDER BY totalOrders DESC;