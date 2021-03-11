USE Supermarket
GO

DROP TABLE IF EXISTS #pickupcount_UT; -- Drop table if it exists

CREATE TABLE #pickupcount_UT(pickup_count INT) -- Temporary table for pickup count

INSERT INTO #pickupcount_UT
	SELECT COUNT(orderStatusCode) AS Pickup_count
	FROM Orders
	WHERE orderStatusCode = 'collected'

DROP TABLE IF EXISTS #deliverycount_UT; -- Drop table if it exits

CREATE TABLE #deliverycount_UT(delivery_count INT)	-- Temporary table for delivery count

INSERT INTO #deliverycount_UT
	SELECT COUNT(orderStatusCode) AS Delivered_count 
	FROM Orders
	WHERE orderStatusCode = 'Delivered'

-- Executing the below queries to check the output of the USER TABLE
SELECT * FROM #pickupcount_UT;
SELECT * FROM #deliverycount_UT;