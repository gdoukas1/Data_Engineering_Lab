USE CataschevasticaDW
GO

-- ONLY FOR THE FIRST LOAD! RUN ONLY ONCE

DELETE FROM FactSales;
DELETE FROM DimProduct;
DELETE FROM DimCustomer;
DELETE FROM DimEmployee;


-- 1

INSERT INTO DimEmployee (EmployeeID, EmployeeName, DepartmentName)
	SELECT EmployeeID, CONCAT(FirstName, ' ', LastName), [Department Name]  
	FROM CataschevasticaStaging.dbo.ProductionEmployee


--2

INSERT INTO DimCustomer(CustomerID, CustomerName, CompanyName, CustomerCountry, CustomerRegion,
	CustomerCity, CustomerPostalCode)
SELECT CustomerID, CONCAT(FirstName, ' ', LastName), CompanyName, 
	Country, Region, City, PostalCode
	FROM CataschevasticaStaging.dbo.Customer


--3

INSERT INTO DimProduct(SKU, ProductName, Price, EstimatedTime, Length, Width, 
	Thickness, Weight, Colour, Quantity, ComplianceStandards, MaterialName, SupplierOfMaterial)
SELECT SKU, Name, Price, EstimatedTime, Length, Width, 
	Thickness, Weight, Colour, Quantity, ComplianceStandards, MaterialName, SupplierOfMaterial
	FROM CataschevasticaStaging.dbo.Product


-- 4
INSERT INTO DimMaterial(MaterialID, MaterialName, CostOfMaterial, SupplierID, SupplierName)
SELECT MaterialID, MaterialName, CostOfMaterial, SupplierID, SupplierOfMaterial
FROM CataschevasticaStaging.dbo.Material
--5

INSERT INTO FactSales(OrderStatus, OrderID, ProductKey, CustomerKey, EmployeeKey, DeliveryPartnerID,
	OrderDateKey, ShippedDateKey, RecievedDateKey, CancellationDateKey,
	Quantity, Price, ExtendedPriceAmount)
SELECT OrderStatus, OrderID, ProductKey, CustomerKey, EmployeeKey, DeliveryPartnerID,
    CAST(FORMAT(SubmissionDate,'yyyyMMdd') AS INT),
    CAST(FORMAT(ShipmentDate,'yyyyMMdd') AS INT),
	CAST(FORMAT(RecievedDate,'yyyyMMdd') AS INT),
	CAST(FORMAT(CancellationDate,'yyyyMMdd') AS INT),
    UnitsofProduct, [stagingSales].[Price], [stagingSales].[Price]*[UnitsofProduct]
    FROM CataschevasticaStaging.dbo.Sales stagingSales
	INNER JOIN CataschevasticaDW.dbo.DimCustomer
		ON CataschevasticaDW.dbo.DimCustomer.CustomerID = stagingSales.CustomerId
	INNER JOIN CataschevasticaDW.dbo.DimEmployee
		ON CataschevasticaDW.dbo.DimEmployee.EmployeeID = stagingSales.EmployeeId
	INNER JOIN CataschevasticaDW.dbo.DimProduct
		ON CataschevasticaDW.dbo.DimProduct.SKU = stagingSales.SKU

-- SELECT * FROM CataschevasticaDW.dbo.FactSales

USE CataschevasticaStaging
GO

CREATE VIEW FactSalesView AS 
SELECT factSales.OrderID,
	factSales.OrderStatus, 
	DimProduct.SKU AS ProductID,
	DimProduct.ProductKey, 
	factSales.CustomerKey, 
	factSales.EmployeeKey, 
	factSales.DeliveryPartnerID,
    OrderDateKey,
    ShippedDateKey,
	RecievedDateKey,
	CancellationDateKey,
    factSales.Quantity,
	factSales.Price, 
	ExtendedPriceAmount
    FROM CataschevasticaDW.dbo.FactSales factSales
	INNER JOIN CataschevasticaDW.dbo.DimProduct
		ON CataschevasticaDW.dbo.DimProduct.ProductKey = FactSales.ProductKey
	WHERE FactSales.RowIsCurrent = 1;

SELECT * FROM CataschevasticaStaging.dbo.FactSalesView

/*
USE CataschevasticaStaging
GO

CREATE VIEW SalesView AS 
SELECT Sales.OrderID,
	Sales.OrderStatus, 
	Sales.SKU,
	DimProduct.ProductKey, 
	DimCustomer.CustomerKey, 
	DimEmployee.EmployeeKey, 
	Sales.DeliveryPartnerID,
    CAST(FORMAT(SubmissionDate,'yyyyMMdd') AS INT) AS OrderDateKey,
    CAST(FORMAT(ShipmentDate,'yyyyMMdd') AS INT) AS ShippedDateKey,
	CAST(FORMAT(RecievedDate,'yyyyMMdd') AS INT) AS RecievedDateKey,
	CAST(FORMAT(CancellationDate,'yyyyMMdd') AS INT) AS CancellationDateKey,
    UnitsofProduct AS Quantity,
	[Sales].[Price], 
	[Sales].[Price]*[UnitsofProduct] AS ExtendedPriceAmount 
    FROM CataschevasticaStaging.dbo.Sales
	INNER JOIN CataschevasticaDW.dbo.DimCustomer
		ON CataschevasticaDW.dbo.DimCustomer.CustomerID = Sales.CustomerId
	INNER JOIN CataschevasticaDW.dbo.DimEmployee
		ON CataschevasticaDW.dbo.DimEmployee.EmployeeID = Sales.EmployeeId
	INNER JOIN CataschevasticaDW.dbo.DimProduct
		ON CataschevasticaDW.dbo.DimProduct.SKU = Sales.SKU
GO


SELECT * FROM CataschevasticaStaging.dbo.SalesView
WHERE OrderID = 2

SELECT * FROM CataschevasticaDW.dbo.FactSales
SELECT * FROM CataschevasticaStaging.dbo.Sales
*/