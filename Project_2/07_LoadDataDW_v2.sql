USE CataschevasticaDW
GO

-- ONLY FOR THE FIRST LOAD! RUN ONLY ONCE

DELETE FROM FactSales;
DELETE FROM FactProduction;
DELETE FROM DimProduct;
DELETE FROM DimCustomer;
DELETE FROM DimEmployee;
DELETE FROM DimMaterial;


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
	Thickness, Weight, Colour, Quantity, ComplianceStandards)
SELECT SKU, Name, Price, EstimatedTime, Length, Width, 
	Thickness, Weight, Colour, Quantity, ComplianceStandards
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
	WHERE OrderStatus <> 'in process'



INSERT INTO TempFactSales(OrderStatus, OrderID, ProductKey, CustomerKey, EmployeeKey, DeliveryPartnerID,
	OrderDateKey, Quantity, Price, ExtendedPriceAmount)
SELECT OrderStatus, OrderID, ProductKey, CustomerKey, EmployeeKey, DeliveryPartnerID,
    CAST(FORMAT(SubmissionDate,'yyyyMMdd') AS INT),
    UnitsofProduct AS Quantity, 
	stagingSales.Price,
	stagingSales.Price*UnitsofProduct
    FROM CataschevasticaStaging.dbo.Sales stagingSales
	INNER JOIN CataschevasticaDW.dbo.DimCustomer
		ON CataschevasticaDW.dbo.DimCustomer.CustomerID = stagingSales.CustomerId
	INNER JOIN CataschevasticaDW.dbo.DimEmployee
		ON CataschevasticaDW.dbo.DimEmployee.EmployeeID = stagingSales.EmployeeId
	INNER JOIN CataschevasticaDW.dbo.DimProduct
		ON CataschevasticaDW.dbo.DimProduct.SKU = stagingSales.SKU
	WHERE OrderStatus = 'in process'


/*
SELECT * FROM CataschevasticaDW.dbo.FactSales
SELECT * FROM CataschevasticaDW.dbo.TempFactSales
SELECT * FROM CataschevasticaDW.dbo.FactProduction
*/

INSERT INTO FactProduction(OrderID, ProductKey, EmployeeKey, MaterialKey, ProductionStatus, 
ProductionStartDateKey, ProductionEndDateKey, CostOfMaterial, AmountOfMaterialUsed, UnitsOfProduct, ExtendedCost)
SELECT Production.OrderID, ProductKey, EmployeeKey, MaterialKey, ProductionStatus, 
	CAST(FORMAT(ProductionStartDate,'yyyyMMdd') AS INT),
	CAST(FORMAT(ProductionEndDate,'yyyyMMdd') AS INT),
	Production.CostOfMaterial,
	RequiredUnitsOfRawMaterial,
	UnitsofProduct,
	Production.CostOfMaterial *  RequiredUnitsOfRawMaterial * UnitsofProduct
FROM CataschevasticaStaging.dbo.Production
INNER JOIN CataschevasticaDW.dbo.DimProduct
	ON Production.SKU = DimProduct.SKU
INNER JOIN CataschevasticaDW.dbo.DimEmployee
	ON Production.EmployeeID = DimEmployee.EmployeeID
INNER JOIN CataschevasticaDW.dbo.DimMaterial
	ON Production.MaterialID = DimMaterial.MaterialID


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


GO

SELECT * FROM CataschevasticaDW.dbo.FactSalesView

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