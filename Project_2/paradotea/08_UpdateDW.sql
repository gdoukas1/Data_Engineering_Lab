USE CataschevasticaDW
GO


-- Incremental Load of FactSales Table

-- Find New Rows

SELECT stagingSales.OrderID, stagingSales.SKU, stagingSales.OrderStatus, 
    DimProduct.ProductKey, DimCustomer.CustomerKey, DimEmployee.EmployeeKey, stagingSales.DeliveryPartnerID,
    CAST(FORMAT(SubmissionDate,'yyyyMMdd') AS INT) AS OrderDateKey,
    CAST(FORMAT(ShipmentDate,'yyyyMMdd') AS INT) AS ShippedDateKey,
	CAST(FORMAT(RecievedDate,'yyyyMMdd') AS INT) AS RecievedDateKey,
	CAST(FORMAT(CancellationDate,'yyyyMMdd') AS INT) AS CancellationDateKey,
    UnitsofProduct, stagingSales.Price, 
    stagingSales.Price*UnitsofProduct AS ExtendedPriceAmount
    INTO DeltaLoad_Staging_New
    FROM CataschevasticaStaging.dbo.Sales stagingSales
	LEFT JOIN CataschevasticaDW.dbo.FactSales factSales
		ON stagingSales.OrderID = factSales.OrderID AND stagingSales.SKU = factSales.ProductID
    INNER JOIN CataschevasticaDW.dbo.DimCustomer
		ON CataschevasticaDW.dbo.DimCustomer.CustomerID = stagingSales.CustomerId
	INNER JOIN CataschevasticaDW.dbo.DimEmployee
		ON CataschevasticaDW.dbo.DimEmployee.EmployeeID = stagingSales.EmployeeId
	INNER JOIN CataschevasticaDW.dbo.DimProduct
		ON CataschevasticaDW.dbo.DimProduct.SKU = stagingSales.SKU  
    WHERE (stagingSales.OrderID > (SELECT MAX(OrderID) FROM factSales) AND stagingSales.OrderStatus <> 'in process')
        OR (factSales.OrderID IS NULL AND stagingSales.OrderStatus <> 'in process');


-- Find Updated Orders (by status)

SELECT stagingSales.OrderID, stagingSales.SKU, stagingSales.OrderStatus, 
    factSales.ProductKey, factSales.CustomerKey, factSales.EmployeeKey, stagingSales.DeliveryPartnerID,
    CAST(FORMAT(SubmissionDate,'yyyyMMdd') AS INT) AS OrderDateKey,
    CAST(FORMAT(ShipmentDate,'yyyyMMdd') AS INT) AS ShippedDateKey,
	CAST(FORMAT(RecievedDate,'yyyyMMdd') AS INT) AS RecievedDateKey,
	CAST(FORMAT(CancellationDate,'yyyyMMdd') AS INT) AS CancellationDateKey,
    UnitsofProduct, stagingSales.Price, 
    stagingSales.Price*UnitsofProduct AS ExtendedPriceAmount
    INTO DeltaLoad_Staging_Updated
    FROM CataschevasticaStaging.dbo.Sales stagingSales
	LEFT JOIN CataschevasticaDW.dbo.FactSales factSales
		ON stagingSales.OrderID = factSales.OrderID AND stagingSales.SKU = factSales.ProductID
    INNER JOIN CataschevasticaDW.dbo.DimCustomer
		ON CataschevasticaDW.dbo.DimCustomer.CustomerID = stagingSales.CustomerId
	INNER JOIN CataschevasticaDW.dbo.DimEmployee
		ON CataschevasticaDW.dbo.DimEmployee.EmployeeID = stagingSales.EmployeeId
	INNER JOIN CataschevasticaDW.dbo.DimProduct
		ON CataschevasticaDW.dbo.DimProduct.SKU = stagingSales.SKU  
    WHERE stagingSales.OrderStatus <> factSales.OrderStatus AND factSales.RowIsCurrent = 1;


SELECT * FROM DeltaLoad_Staging_New
SELECT * FROM DeltaLoad_Staging_Updated


-- Update to mark historic rows

UPDATE CataschevasticaDW.dbo.FactSales
SET RowIsCurrent = 0
FROM CataschevasticaDW.dbo.FactSales 
INNER JOIN 
DeltaLoad_Staging_Updated source
ON FactSales.OrderID = source.OrderID AND FactSales.ProductID = source.SKU


-- Insert new rows in data warehouse

INSERT INTO CataschevasticaDW.dbo.FactSales(OrderID, ProductID, OrderStatus, 
    ProductKey, CustomerKey, EmployeeKey, DeliveryPartnerID,
	OrderDateKey, ShippedDateKey, RecievedDateKey, CancellationDateKey,
	Quantity, Price, ExtendedPriceAmount)
SELECT *
FROM DeltaLoad_Staging_New
UNION
SELECT *
FROM DeltaLoad_Staging_Updated


-- Run each time: Drop staging tables
DROP TABLE IF EXISTS DeltaLoad_Staging_New;
DROP TABLE IF EXISTS DeltaLoad_Staging_Updated;

-- RUN EACH TIME Before the load
DELETE FROM TempFactSales


-- RUN EACH TIME

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
	WHERE OrderStatus = 'in process'


/*

INSERT INTO CataschevasticaStaging.dbo.Sales(OrderID, OrderStatus, CustomerID, EmployeeID, DeliveryPartnerID, SubmissionDate, ShipmentDate, RecievedDate, CancellationDate, SKU, ProductName, UnitsofProduct, Price)
VALUES (136, 'in process', 9, 7, 10, SYSDATETIME(),	NULL,	NULL,	NULL,	'SKU013',	'Aluminum Sheet',	170, 10.00)


UPDATE CataschevasticaStaging.dbo.Sales 
SET OrderStatus = 'in delivery', ShipmentDate = SYSDATETIME()
WHERE OrderID = 127

UPDATE CataschevasticaStaging.dbo.Sales 
SET OrderStatus = 'completed', RecievedDate = SYSDATETIME()
WHERE OrderID = 128

SELECT * FROM CataschevasticaStaging.dbo.Sales
WHERE OrderID = 128

UPDATE CataschevasticaStaging.dbo.Sales 
SET OrderStatus = 'completed', RecievedDate = SYSDATETIME()
WHERE OrderID = 131

SELECT * FROM CataschevasticaStaging.dbo.Sales
WHERE OrderID = 131

SELECT * FROM CataschevasticaStaging.dbo.Sales;
SELECT * FROM CataschevasticaDW.dbo.FactSales;
SELECT * FROM TempFactSales;
SELECT * FROM SalesMart

*/

---------------------------------------------------------------------------------------

-- Incremental Load of FactProduction Table

----------------------------------------------------------------------------------------

SELECT stagingProd.OrderID, stagingProd.SKU, stagingProd.MaterialID, stagingProd.ProductionStatus,
    DimProduct.ProductKey, DimMaterial.MaterialKey, DimEmployee.EmployeeKey,
    CAST(FORMAT(ProductionStartDate,'yyyyMMdd') AS INT) AS ProductionStartDateKey,
    CAST(FORMAT(ProductionEndDate,'yyyyMMdd') AS INT) AS ProductionEndDateKey,
    stagingProd.CostOfMaterial,
    stagingProd.RequiredUnitsOfRawMaterial AS AmountOfMaterialUsed,
    stagingProd.UnitsOfProduct,
    stagingProd.CostOfMaterial * RequiredUnitsOfRawMaterial * stagingProd.UnitsofProduct AS ExtendedCost
INTO DeltaLoad_StagingProd_New
FROM CataschevasticaStaging.dbo.Production stagingProd
LEFT JOIN CataschevasticaDW.dbo.FactProduction factProduction
    ON (stagingProd.OrderID = factProduction.OrderID 
        AND stagingProd.SKU = factProduction.ProductID 
        AND stagingProd.MaterialID = factProduction.MaterialID)
INNER JOIN CataschevasticaDW.dbo.DimProduct
    ON CataschevasticaDW.dbo.DimProduct.SKU = stagingProd.SKU
INNER JOIN CataschevasticaDW.dbo.DimMaterial
    ON CataschevasticaDW.dbo.DimMaterial.MaterialID = stagingProd.MaterialID
INNER JOIN CataschevasticaDW.dbo.DimEmployee
    ON CataschevasticaDW.dbo.DimEmployee.EmployeeID = stagingProd.EmployeeId
WHERE factProduction.OrderID IS NULL 



SELECT stagingProd.OrderID, stagingProd.SKU, stagingProd.MaterialID, stagingProd.ProductionStatus,
    factProduction.ProductKey, factProduction.MaterialKey, factProduction.EmployeeKey,
    CAST(FORMAT(ProductionStartDate,'yyyyMMdd') AS INT) AS ProductionStartDateKey,
    CAST(FORMAT(ProductionEndDate,'yyyyMMdd') AS INT) AS ProductionEndDateKey,
    factProduction.CostOfMaterial,
    factProduction.AmountOfMaterialUsed,
    factProduction.UnitsOfProduct,
    factProduction.ExtendedCost
INTO DeltaLoad_StagingProd_Updated
FROM CataschevasticaStaging.dbo.Production stagingProd
INNER JOIN CataschevasticaDW.dbo.FactProduction factProduction
    ON (stagingProd.OrderID = factProduction.OrderID 
        AND stagingProd.SKU = factProduction.ProductID 
        AND stagingProd.MaterialID = factProduction.MaterialID)
INNER JOIN CataschevasticaDW.dbo.DimProduct
    ON CataschevasticaDW.dbo.DimProduct.SKU = stagingProd.SKU
INNER JOIN CataschevasticaDW.dbo.DimMaterial
    ON CataschevasticaDW.dbo.DimMaterial.MaterialID = stagingProd.MaterialID
INNER JOIN CataschevasticaDW.dbo.DimEmployee
    ON CataschevasticaDW.dbo.DimEmployee.EmployeeID = stagingProd.EmployeeId
WHERE stagingProd.ProductionStatus <> factProduction.ProductionStatus AND factProduction.RowIsCurrent = 1;

/*
SELECT * FROM DeltaLoad_StagingProd_New
SELECT * FROM DeltaLoad_StagingProd_Updated
*/

-- Update to mark historic rows

UPDATE CataschevasticaDW.dbo.FactProduction
SET RowIsCurrent = 0
FROM CataschevasticaDW.dbo.FactProduction 
INNER JOIN 
DeltaLoad_StagingProd_Updated source
ON (source.OrderID = FactProduction.OrderID 
        AND source.SKU = FactProduction.ProductID 
        AND source.MaterialID = FactProduction.MaterialID)


-- Insert new rows in data warehouse

INSERT INTO CataschevasticaDW.dbo.FactProduction(OrderID, ProductID, MaterialID, ProductionStatus, 
    ProductKey, MaterialKey, EmployeeKey, ProductionStartDateKey, ProductionEndDateKey,
	CostOfMaterial, AmountOfMaterialUsed, UnitsOfProduct, ExtendedCost)
SELECT *
FROM DeltaLoad_StagingProd_New
UNION
SELECT *
FROM DeltaLoad_StagingProd_Updated


-- Run each time: Drop staging tables
DROP TABLE IF EXISTS DeltaLoad_StagingProd_New;
DROP TABLE IF EXISTS DeltaLoad_StagingProd_Updated;


/*
INSERT INTO CataschevasticaStaging.dbo.Production VALUES (70, 'SKU013',	1,	1,	'not started', NULL, NULL,	0.15,	2.00,	200)

UPDATE CataschevasticaStaging.dbo.Production
SET ProductionStatus = 'cancelled'
WHERE OrderID = 70 AND SKU = 'SKU013'

UPDATE CataschevasticaStaging.dbo.Production
SET ProductionStatus = 'completed', ProductionEndDate = SYSDATETIME()
WHERE OrderID = 67 AND SKU = 'SKU015'

SELECT * FROM CataschevasticaStaging.dbo.Production;
SELECT * FROM CataschevasticaDW.dbo.FactProduction;
*/


SELECT * FROM SalesMart;
SELECT * FROM ProductionMart;


--------------------------------------------------------------------------------------------

-- SCD TYPE 2

--------------------------------------------------------------------------------------------

-- SCD TYPE 2 DimEmployee

ALTER TABLE FactSales
NOCHECK CONSTRAINT FK_employee
GO

ALTER TABLE TempFactSales
NOCHECK CONSTRAINT FK_employeeTemp
GO

ALTER TABLE FactProduction
NOCHECK CONSTRAINT FK_employeeProd
GO

INSERT INTO DimEmployee (EmployeeID, EmployeeName, DepartmentName, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
SELECT EmployeeID, EmployeeName, DepartmentName, 1, SYSDATETIME(), '9999-12-31', ActionName
FROM(
    MERGE DimEmployee AS [Target]
    USING CataschevasticaStaging.dbo.ProductionEmployee AS [Source]
    ON Target.EmployeeID = Source.EmployeeID 
        WHEN MATCHED AND RowIsCurrent = 1 AND (CONCAT(Source.FirstName, ' ', Source.LastName) <> Target.EmployeeName OR Source.[Department Name] <> Target.DepartmentName)
            THEN UPDATE SET target.RowIsCurrent = 0, Target.RowEndDate = SYSDATETIME()
        WHEN NOT MATCHED BY Target 
            THEN INSERT (EmployeeID, EmployeeName, DepartmentName, RowStartDate, RowEndDate)
                VALUES (source.EmployeeID, CONCAT(Source.FirstName, ' ', Source.LastName), Source.[Department Name], SYSDATETIME(), '9999-12-31')
        WHEN NOT MATCHED BY Source 
            THEN UPDATE SET Target.RowEndDate = SYSDATETIME(), Target.RowIsCurrent = 0, Target.RowIsDeleted = 1, Target.RowChangeReason = 'DELETE'
    OUTPUT Source.EmployeeID, CONCAT(Source.FirstName, ' ', Source.LastName) AS EmployeeName, Source.[Department Name] AS DepartmentName, $Action AS ActionName
) AS [Merge]
WHERE ActionName = 'UPDATE'
AND EmployeeID IS NOT NULL;


ALTER TABLE FactSales
CHECK CONSTRAINT FK_employee
GO

ALTER TABLE TempFactSales
CHECK CONSTRAINT FK_employeeTemp
GO

ALTER TABLE FactProduction
CHECK CONSTRAINT FK_employeeProd
GO

/*
DELETE
FROM CataschevasticaStaging.dbo.ProductionEmployee
WHERE EmployeeID = 12

INSERT INTO CataschevasticaStaging.dbo.ProductionEmployee VALUES (14, 'Jim', 'White', 'Production')

UPDATE CataschevasticaStaging.dbo.ProductionEmployee
SET FirstName = 'Markos'
WHERE EmployeeID = 13;

DELETE FROM CataschevasticaDW.dbo.DimEmployee
WHERE EmployeeKey =14

UPDATE CataschevasticaDW.dbo.DimEmployee
SET RowIsCurrent = 1
WHERE EmployeeKey =13

SELECT * FROM CataschevasticaStaging.dbo.ProductionEmployee
SELECT * FROM CataschevasticaDW.dbo.DimEmployee
*/

--------------------------------------------------------------------------------------------

-- SCD TYPE 2 DimCustomer

ALTER TABLE FactSales
NOCHECK CONSTRAINT FK_customer
GO

ALTER TABLE TempFactSales
NOCHECK CONSTRAINT FK_customerTemp
GO

INSERT INTO DimCustomer (CustomerID, CustomerName, CompanyName, CustomerCountry, CustomerRegion, CustomerCity, CustomerPostalCode,
							RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
SELECT CustomerID, CustomerName, CompanyName, Country, Region, City, PostalCode, 1, SYSDATETIME(), '9999-12-31', ActionName
FROM(
    MERGE DimCustomer AS [Target]
    USING CataschevasticaStaging.dbo.Customer AS [Source]
    ON Target.CustomerID = Source.CustomerID 
        WHEN MATCHED AND RowIsCurrent = 1 AND 
			(CONCAT(Source.FirstName, ' ', Source.LastName) <> Target.CustomerName 
			OR Source.CompanyName <> Target.CompanyName
			OR Source.Country <> Target.CustomerCountry
			OR Source.Region <> Target.CustomerRegion
			OR Source.City <> Target.CustomerCity
			OR Source.PostalCode <> Target.CustomerPostalCode)
            THEN UPDATE SET target.RowIsCurrent = 0, Target.RowEndDate = SYSDATETIME()
        WHEN NOT MATCHED BY Target
            THEN INSERT (CustomerID, CustomerName, CompanyName, CustomerCountry, CustomerRegion, CustomerCity, CustomerPostalCode, 
							RowStartDate, RowEndDate)
                VALUES (source.CustomerID, CONCAT(Source.FirstName, ' ', Source.LastName), Source.CompanyName, Source.Country, Source.Region, Source.City, Source.PostalCode,
							SYSDATETIME(), '9999-12-31')
        WHEN NOT MATCHED BY Source 
            THEN UPDATE SET Target.RowEndDate = SYSDATETIME(), Target.RowIsCurrent = 0, Target.RowIsDeleted = 1, Target.RowChangeReason = 'DELETE'
    OUTPUT Source.CustomerID, CONCAT(Source.FirstName, ' ', Source.LastName) AS CustomerName, Source.CompanyName, Source.Country, Source.Region, Source.City, Source.PostalCode, $Action AS ActionName
) AS [Merge]
WHERE ActionName = 'UPDATE'
AND CustomerID IS NOT NULL;


ALTER TABLE FactSales
CHECK CONSTRAINT FK_customer
GO

ALTER TABLE TempFactSales
CHECK CONSTRAINT FK_customerTemp
GO

/* 
-- One insert and one update to check that everything works
INSERT INTO CataschevasticaStaging.dbo.Customer (FirstName, LastName, CompanyName, City, Region, PostalCode, Country) VALUES 
('Alice', 'Lee', 'Alice Enterprises', 'Metropolis', 'Region1', 12345, 'France')

UPDATE CataschevasticaStaging.dbo.Customer
SET Country = 'France'
WHERE CustomerID = 12

-- Check that both insertion of new records and update works 

SELECT * FROM CataschevasticaStaging.dbo.Customer
SELECT * FROM DimCustomer

*/

--------------------------------------------------------------------------------------------

-- SCD TYPE2 DimProduct

ALTER TABLE FactSales
NOCHECK CONSTRAINT FK_product
GO

ALTER TABLE TempFactSales
NOCHECK CONSTRAINT FK_productTemp
GO

ALTER TABLE FactProduction
NOCHECK CONSTRAINT FK_productProd
GO

INSERT INTO DimProduct (SKU, ProductName, Price, EstimatedTime, Length, Width, Thickness, Weight, Colour, Quantity, ComplianceStandards, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
SELECT SKU, Name, Price, EstimatedTime, Length, Width, Thickness, Weight, Colour, Quantity, ComplianceStandards, 1, SYSDATETIME(), '9999-12-31', ActionName
FROM(
    MERGE DimProduct AS [Target]
    USING CataschevasticaStaging.dbo.Product AS [Source]
    ON Target.SKU = Source.SKU 
        WHEN MATCHED AND RowIsCurrent = 1 AND 
        (Source.Name <> Target.ProductName  
        OR Source.Price <> Target.Price 
		OR Source.EstimatedTime <> Target.EstimatedTime 
        OR Source.Length <> Target.Length 
        OR Source.Width <> Target.Width 
        OR Source.Thickness <> Target.Thickness 
		OR Source.Weight <> Target.Weight 
        OR Source.Colour <> Target.Colour 
        OR Source.Quantity <> Target.Quantity 
        OR Source.ComplianceStandards <> Target.ComplianceStandards )
            THEN UPDATE SET target.RowIsCurrent = 0, Target.RowEndDate = SYSDATETIME()
        WHEN NOT MATCHED BY TARGET 
            THEN INSERT (SKU, ProductName, Price, EstimatedTime, Length, Width, Thickness, Weight, Colour, Quantity, ComplianceStandards, RowStartDate, RowEndDate)
                VALUES (Source.SKU, Source.Name, Source.Price, Source.EstimatedTime, Source.Length, Source.Width, Source.Thickness, Source.Weight, 
                    Source.Colour, Source.Quantity, Source.ComplianceStandards, SYSDATETIME(), '9999-12-31')
        WHEN NOT MATCHED BY Source 
            THEN UPDATE SET target.RowEndDate = SYSDATETIME(), Target.RowIsCurrent = 0, Target.RowIsDeleted = 1, Target.RowChangeReason = 'DELETE'
    OUTPUT Source.SKU, Source.Name, Source.Price, Source.EstimatedTime, Source.Length, Source.Width, Source.Thickness, Source.Weight, Source.Colour, Source.Quantity, Source.ComplianceStandards, $Action AS ActionName
) AS [Merge]
WHERE ActionName = 'UPDATE'
AND SKU IS NOT NULL;

ALTER TABLE FactSales
CHECK CONSTRAINT FK_product
GO

ALTER TABLE TempFactSales
CHECK CONSTRAINT FK_productTemp
GO

ALTER TABLE FactProduction
CHECK CONSTRAINT FK_productProd
GO



/*

UPDATE CataschevasticaStaging.dbo.Product
SET Length = 8888.00
WHERE SKU='SKU005'


SELECT * FROM CataschevasticaStaging.dbo.Product
SELECT * FROM CataschevasticaDW.dbo.DimProduct
*/



------------------------------------------------------------------
-- SCD TYPE 2 DimMaterial


ALTER TABLE FactProduction
NOCHECK CONSTRAINT FK_materialProd
GO

INSERT INTO DimMaterial (MaterialID, MaterialName, CostOfMaterial, SupplierID, SupplierName,
							RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
SELECT MaterialID, MaterialName, CostOfMaterial, SupplierID, SupplierOfMaterial, 1, SYSDATETIME(), '9999-12-31', ActionName
FROM(
    MERGE DimMaterial AS [Target]
    USING CataschevasticaStaging.dbo.Material AS [Source]
    ON Target.MaterialID = Source.MaterialID 
        WHEN MATCHED AND RowIsCurrent = 1 AND 
			(Source.MaterialName <> Target.MaterialName
			OR Source.CostOfMaterial <> Target.CostOfMaterial
			OR Source.SupplierID <> Target.SupplierID
			OR Source.SupplierOfMaterial <> Target.SupplierName)
            THEN UPDATE SET target.RowIsCurrent = 0, Target.RowEndDate = SYSDATETIME()
        WHEN NOT MATCHED BY Target
            THEN INSERT (MaterialID, MaterialName, CostOfMaterial, SupplierID, SupplierName, RowStartDate, RowEndDate)
                VALUES (source.MaterialID, Source.MaterialName, Source.CostOfMaterial, Source.SupplierID, Source.SupplierOfMaterial,
							SYSDATETIME(), '9999-12-31')
        WHEN NOT MATCHED BY Source 
            THEN UPDATE SET Target.RowEndDate = SYSDATETIME(), Target.RowIsCurrent = 0, Target.RowIsDeleted = 1, Target.RowChangeReason = 'DELETE'
    OUTPUT Source.MaterialID, Source.MaterialName, Source.CostOfMaterial, Source.SupplierID, Source.SupplierOfMaterial, $Action AS ActionName
) AS [Merge]
WHERE ActionName = 'UPDATE'
AND MaterialID IS NOT NULL;


ALTER TABLE FactProduction
CHECK CONSTRAINT FK_materialProd
GO

/* One insert and one update to check that everything works

INSERT INTO CataschevasticaStaging.dbo.Material (MaterialID, MaterialName, CostOfMaterial, SupplierID, SupplierOfMaterial) VALUES 
(16, 'plaster', 0.8, 1, 'ABC Materials')

UPDATE CataschevasticaStaging.dbo.Material
SET CostOfMaterial = 0.2
WHERE MaterialID = 15

SELECT * FROM CataschevasticaStaging.dbo.Material
SELECT * FROM CataschevasticaDW.dbo.DimMaterial
*/ 
