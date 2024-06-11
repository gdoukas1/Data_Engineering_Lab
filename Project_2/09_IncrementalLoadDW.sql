USE CataschevasticaStaging
GO

-- Find New Rows

SELECT  source.*
	INTO DeltaLoad_Staging_New
    FROM CataschevasticaStaging.dbo.StagingSales source
	LEFT JOIN CataschevasticaDW.dbo.FactSales factSales
		ON source.OrderID = factSales.OrderID AND source.ProductKey = factSales.ProductKey
WHERE factSales.OrderID IS NULL;


-- Find Updated Orders while in process

SELECT  source.*
	INTO DeltaLoad_Staging_Updated
    FROM CataschevasticaStaging.dbo.StagingSales source
	INNER JOIN CataschevasticaDW.dbo.FactSales factSales
		ON source.OrderID = factSales.OrderID AND source.ProductKey = factSales.ProductKey
WHERE source.OrderStatus = 'in process' AND source.Quantity <> factSales.Quantity 


-- Find Deleted products while order status is in process

SELECT  factSales.*
INTO DeltaLoad_Staging_Deleted
FROM CataschevasticaStaging.dbo.StagingSales source
RIGHT JOIN CataschevasticaDW.dbo.FactSales factSales
	ON source.OrderID = factSales.OrderID AND source.ProductKey = factSales.ProductKey
WHERE source.OrderID IS NULL AND factSales.OrderStatus = 'in process' 


-- Update to mark historic rows

UPDATE CataschevasticaDW.dbo.FactSales
SET RowIsCurrent = 0
FROM CataschevasticaDW.dbo.FactSales 
INNER JOIN 
(SELECT * FROM DeltaLoad_Staging_Updated
UNION
SELECT * FROM DeltaLoad_Staging_Deleted) source
ON FactSales.OrderID = source.OrderID AND FactSales.ProductKey = source.ProductKey


-- Insert new rows in data warehouse

INSERT INTO CataschevasticaDW.dbo.FactSales 
SELECT OrderID, OrderStatus, ProductKey, CustomerKey, EmployeeKey, DeliveryPartnerID, 
	OrderDateKey, ShippedDateKey, RecievedDateKey, CancellationDateKey, 
	Quantity, Price, ExtendedPriceAmount, 1
FROM DeltaLoad_Staging_New
UNION
SELECT OrderID, OrderStatus, ProductKey, CustomerKey, EmployeeKey, DeliveryPartnerID, 
	OrderDateKey, ShippedDateKey, RecievedDateKey, CancellationDateKey, 
	Quantity, Price, ExtendedPriceAmount, 1
FROM DeltaLoad_Staging_Updated

-- Run each time: Drop staging tables
DROP TABLE IF EXISTS DeltaLoad_Staging_New;
DROP TABLE IF EXISTS DeltaLoad_Staging_Updated;
DROP TABLE IF EXISTS DeltaLoad_Staging_Deleted;



/*
SELECT * FROM CataschevasticaStaging.dbo.Product

SELECT * FROM CataschevasticaStaging.dbo.Sales

SELECT * FROM CataschevasticaDW.dbo.FactSales
WHERE OrderID = 26

SELECT * FROM CataschevasticaStaging.dbo.StagingSales
WHERE OrderID = 26

-- OrderID = 26 {SKU005, SKU014}  'in process'


INSERT INTO CataschevasticaStaging.dbo.Sales(OrderID, OrderStatus, CustomerId, EmployeeID, DeliveryPartnerID, SubmissionDate, ShipmentDate, RecievedDate, CancellationDate, SKU, ProductName, UnitsofProduct, Price)
VALUES (26, 'in process',3,	7,	11,	'2024-05-27 10:00:00.0000000',	NULL,	NULL,	NULL,	'SKU007', 'Brick', 100, 0.75)

INSERT INTO CataschevasticaStaging.dbo.Sales(OrderID, OrderStatus, CustomerId, EmployeeID, DeliveryPartnerID, SubmissionDate, ShipmentDate, RecievedDate, CancellationDate, SKU, ProductName, UnitsofProduct, Price)
VALUES (56, 'in process', 3, 8, 12,	'2024-05-28 10:00:00.0000000',	NULL,	NULL,	NULL,	'SKU007', 'Brick', 200, 0.75)

SELECT * FROM CataschevasticaStaging.dbo.Sales
SELECT * FROM DeltaLoad_Staging_New;



UPDATE CataschevasticaStaging.dbo.Sales
SET UnitsofProduct = 999
WHERE OrderID = 26 AND SKU = 'SKU005'

SELECT * FROM CataschevasticaStaging.dbo.DeltaLoad_Staging_Updated
SELECT * FROM CataschevasticaStaging.dbo.StagingSales
WHERE OrderID =26



SELECT * FROM CataschevasticaStaging.dbo.Sales

DELETE 
FROM CataschevasticaStaging.dbo.Sales
WHERE OrderID = 2 AND SKU = 'SKU003'

SELECT * FROM CataschevasticaStaging.dbo.StagingSales
WHERE OrderID = 2



SELECT * FROM CataschevasticaStaging.dbo.StagingSales
WHERE OrderID = 26

SELECT * FROM CataschevasticaDW.dbo.FactSales
WHERE OrderID = 26
*/

