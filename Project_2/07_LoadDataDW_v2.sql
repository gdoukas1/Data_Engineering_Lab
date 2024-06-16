USE CataschevasticaDW
GO

-- ONLY FOR THE FIRST LOAD! RUN ONLY ONCE

DELETE FROM FactSales;
DELETE FROM TempFactSales;
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

INSERT INTO FactSales(OrderID, ProductID, OrderStatus, ProductKey, CustomerKey, EmployeeKey, DeliveryPartnerID,
	OrderDateKey, ShippedDateKey, RecievedDateKey, CancellationDateKey,
	Quantity, Price, ExtendedPriceAmount)
SELECT OrderID, stagingSales.SKU, OrderStatus, ProductKey, CustomerKey, EmployeeKey, DeliveryPartnerID,
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
	WHERE OrderStatus <> 'in process' AND DimCustomer.RowIsCurrent = 1 AND DimEmployee.RowIsCurrent = 1 AND DimProduct.RowIsCurrent = 1



INSERT INTO TempFactSales(OrderID, ProductID, OrderStatus, ProductKey, CustomerKey, EmployeeKey, DeliveryPartnerID,
	OrderDateKey, Quantity, Price, ExtendedPriceAmount)
SELECT OrderID, stagingSales.SKU, OrderStatus, ProductKey, CustomerKey, EmployeeKey, DeliveryPartnerID,
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
	WHERE OrderStatus = 'in process' AND DimCustomer.RowIsCurrent = 1 AND DimEmployee.RowIsCurrent = 1 AND DimProduct.RowIsCurrent = 1


-- 6

INSERT INTO FactProduction(OrderID, ProductID, MaterialID, ProductionStatus, ProductKey, MaterialKey, EmployeeKey,
ProductionStartDateKey, ProductionEndDateKey, CostOfMaterial, AmountOfMaterialUsed, UnitsOfProduct, ExtendedCost)
SELECT Production.OrderID, Production.SKU, Production.MaterialID, ProductionStatus, ProductKey, MaterialKey, EmployeeKey,
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
WHERE DimMaterial.RowIsCurrent = 1 AND DimEmployee.RowIsCurrent = 1 AND DimProduct.RowIsCurrent = 1



/*
SELECT * FROM CataschevasticaDW.dbo.FactSales
SELECT * FROM CataschevasticaDW.dbo.TempFactSales
SELECT * FROM CataschevasticaDW.dbo.FactProduction
*/

GO

CREATE VIEW SalesMart AS 
	SELECT OrderID, ProductID, OrderStatus, ProductKey, CustomerKey, EmployeeKey, DeliveryPartnerID,
	OrderDateKey, ShippedDateKey, RecievedDateKey, CancellationDateKey, Quantity, Price, ExtendedPriceAmount
	FROM CataschevasticaDW.dbo.FactSales factSales
	WHERE FactSales.RowIsCurrent = 1
	UNION
	(SELECT OrderID, ProductID, OrderStatus, ProductKey, CustomerKey, EmployeeKey, DeliveryPartnerID,
	OrderDateKey, NULL, NULL, NULL, Quantity, Price, ExtendedPriceAmount
	FROM CataschevasticaDW.dbo.TempFactSales)

GO

CREATE VIEW ProductionMart AS 
	SELECT OrderID, ProductID, MaterialID, ProductionStatus, ProductKey, MaterialKey, EmployeeKey, 
	ProductionStartDateKey, ProductionEndDateKey, CostOfMaterial, AmountOfMaterialUsed, UnitsOfProduct, ExtendedCost
	FROM CataschevasticaDW.dbo.FactProduction
	WHERE FactProduction.RowIsCurrent = 1 AND ProductionStatus <> 'cancelled'

GO

/*
SELECT * FROM SalesMart
SELECT * FROM ProductionMart
*/


