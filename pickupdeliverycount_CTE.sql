USE Supermarket
GO

--CTE for pickupcount and deliverycount

WITH pickup_count_CTE AS
(
	SELECT COUNT(orderStatusCode) AS Pickup_count 
	FROM Orders
	WHERE orderStatusCode = 'collected'
),
delivery_count_CTE AS
(
	SELECT COUNT(orderStatusCode) AS Delivered_count 
	FROM Orders
	WHERE orderStatusCode = 'Delivered'
)

SELECT * FROM pickup_count_CTE, delivery_count_CTE;


