USE CataschevasticaStaging
GO

-- NO LONGER USABLE (OLD VERSION)

-- Find New Rows

SELECT stagingSales.OrderID, stagingSales.OrderStatus, DimProduct.ProductKey, DimCustomer.CustomerKey, DimEmployee.EmployeeKey, stagingSales.DeliveryPartnerID,
    CAST(FORMAT(SubmissionDate,'yyyyMMdd') AS INT) AS OrderDateKey,
    CAST(FORMAT(ShipmentDate,'yyyyMMdd') AS INT) AS ShippedDateKey,
	CAST(FORMAT(RecievedDate,'yyyyMMdd') AS INT) AS RecievedDateKey,
	CAST(FORMAT(CancellationDate,'yyyyMMdd') AS INT) AS CancellationDateKey,
    UnitsofProduct AS Quantity, 
	stagingSales.Price, 
	stagingSales.Price * UnitsofProduct AS ExtendedPriceAmount
INTO DeltaLoad_Staging_New
FROM CataschevasticaStaging.dbo.Sales stagingSales
LEFT JOIN CataschevasticaStaging.dbo.FactSalesView factSalesView
	ON stagingSales.OrderID = factSalesView.OrderID AND stagingSales.SKU = factSalesView.ProductID
INNER JOIN CataschevasticaDW.dbo.DimCustomer
	ON CataschevasticaDW.dbo.DimCustomer.CustomerID = stagingSales.CustomerId
INNER JOIN CataschevasticaDW.dbo.DimEmployee
	ON CataschevasticaDW.dbo.DimEmployee.EmployeeID = stagingSales.EmployeeId
INNER JOIN CataschevasticaDW.dbo.DimProduct
	ON CataschevasticaDW.dbo.DimProduct.SKU = stagingSales.SKU
WHERE factSalesView.OrderID IS NULL AND DimProduct.RowIsCurrent = 1;

/*
SELECT * FROM CataschevasticaStaging.dbo.SalesView
SELECT * FROM CataschevasticaDW.dbo.FactSales
*/

-- Find Modified Orders while in process

SELECT factSalesView.OrderID, factSalesView.OrderStatus, factSalesView.ProductKey, factSalesView.CustomerKey, factSalesView.EmployeeKey, factSalesView.DeliveryPartnerID,
 	OrderDateKey, ShippedDateKey, RecievedDateKey, CancellationDateKey,
	stagingSales.UnitsofProduct AS Quantity,
	factSalesView.Price, 
	stagingSales.UnitsofProduct * factSalesView.Price AS ExtendedPriceAmount 
INTO DeltaLoad_Staging_Updated
FROM CataschevasticaStaging.dbo.Sales stagingSales
INNER JOIN CataschevasticaStaging.dbo.FactSalesView factSalesView
	ON (stagingSales.OrderID = factSalesView.OrderID AND stagingSales.SKU = factSalesView.ProductID)
WHERE stagingSales.UnitsofProduct <> factSalesView.Quantity AND stagingSales.OrderStatus = 'in process' 


-- Find Deleted products while order status is in process

SELECT  factSalesView.OrderID, factSalesView.OrderStatus, factSalesView.ProductKey, factSalesView.CustomerKey, factSalesView.EmployeeKey, factSalesView.DeliveryPartnerID, 
	factSalesView.OrderDateKey, factSalesView.ShippedDateKey, factSalesView.RecievedDateKey, factSalesView.CancellationDateKey, 
	factSalesView.Quantity, factSalesView.Price, factSalesView.ExtendedPriceAmount
INTO DeltaLoad_Staging_Deleted
FROM CataschevasticaStaging.dbo.Sales source
RIGHT JOIN CataschevasticaStaging.dbo.FactSalesView factSalesView
	ON source.OrderID = factSalesView.OrderID AND source.SKU = factSalesView.ProductID
WHERE source.OrderID IS NULL AND factSalesView.OrderStatus = 'in process' 


SELECT * FROM DeltaLoad_Staging_New
SELECT * FROM DeltaLoad_Staging_Updated
SELECT * FROM DeltaLoad_Staging_Deleted


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

--SELECT * FROM CataschevasticaStaging.dbo.Sales

SELECT * FROM CataschevasticaStaging.dbo.StagingSales
WHERE OrderID = 26

-- OrderID = 26 {SKU005, SKU014}  'in process'


INSERT INTO CataschevasticaStaging.dbo.Sales(OrderID, OrderStatus, CustomerId, EmployeeID, DeliveryPartnerID, SubmissionDate, ShipmentDate, RecievedDate, CancellationDate, SKU, ProductName, UnitsofProduct, Price)
VALUES (26, 'in process', 3, 7,	11,	'2024-05-27 10:00:00.0000000',	NULL,	NULL,	NULL,	'SKU007', 'Brick', 100, 0.75)

INSERT INTO CataschevasticaStaging.dbo.Sales(OrderID, OrderStatus, CustomerId, EmployeeID, DeliveryPartnerID, SubmissionDate, ShipmentDate, RecievedDate, CancellationDate, SKU, ProductName, UnitsofProduct, Price)
VALUES (56, 'in process', 3, 8, 12,	'2024-05-28 10:00:00.0000000',	NULL,	NULL,	NULL,	'SKU007', 'Brick', 200, 0.75)

SELECT * FROM CataschevasticaStaging.dbo.Sales
SELECT * FROM DeltaLoad_Staging_New;
SELECT * FROM CataschevasticaStaging.dbo.SalesView


UPDATE CataschevasticaStaging.dbo.Sales
SET UnitsofProduct = 999
WHERE OrderID = 26 AND SKU = 'SKU005'

SELECT * FROM CataschevasticaStaging.dbo.DeltaLoad_Staging_Updated
SELECT * FROM CataschevasticaStaging.dbo.Sales
WHERE OrderID =26



SELECT * FROM CataschevasticaStaging.dbo.Sales
WHERE OrderID =2

DELETE 
FROM CataschevasticaStaging.dbo.Sales
WHERE OrderID = 32 AND SKU = 'SKU004'

SELECT * FROM CataschevasticaStaging.dbo.Sales
WHERE OrderID = 2



SELECT * FROM CataschevasticaStaging.dbo.SalesView
WHERE OrderID = 2

SELECT * FROM CataschevasticaDW.dbo.FactSales
WHERE OrderID = 26

SELECT * FROM CataschevasticaStaging.dbo.Sales
WHERE OrderID = 2 AND SKU = 'SKU003'

UPDATE CataschevasticaStaging.dbo.Sales
SET UnitsofProduct = 9999
WHERE OrderID = 2 AND SKU = 'SKU003'


SELECT * FROM CataschevasticaDW.dbo.DimProduct

INSERT INTO CataschevasticaStaging.dbo.Sales(OrderID, OrderStatus, CustomerId, EmployeeID, DeliveryPartnerID, SubmissionDate, ShipmentDate, RecievedDate, CancellationDate, SKU, ProductName, UnitsofProduct, Price)
VALUES (56,	'in process',  3, 9,	10,	SYSDATETIME(),	NULL,	NULL,	NULL,	'SKU003',	'Roofing Tile',	1111,	3.00)

*/