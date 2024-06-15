USE CataschevasticaDW
GO


-- Incremental Load of FactSales Table

INSERT INTO CataschevasticaDW.dbo.FactSales(OrderStatus, OrderID, ProductKey, CustomerKey, EmployeeKey, DeliveryPartnerID,
	OrderDateKey, ShippedDateKey, RecievedDateKey, CancellationDateKey,
	Quantity, Price, ExtendedPriceAmount)
SELECT stagingSales.OrderStatus, stagingSales.OrderID, DimProduct.ProductKey, DimCustomer.CustomerKey, DimEmployee.EmployeeKey, stagingSales.DeliveryPartnerID,
    CAST(FORMAT(SubmissionDate,'yyyyMMdd') AS INT),
    CAST(FORMAT(ShipmentDate,'yyyyMMdd') AS INT),
	CAST(FORMAT(RecievedDate,'yyyyMMdd') AS INT),
	CAST(FORMAT(CancellationDate,'yyyyMMdd') AS INT),
    UnitsofProduct, [stagingSales].[Price], [stagingSales].[Price]*[UnitsofProduct]
    FROM CataschevasticaStaging.dbo.Sales stagingSales
	LEFT JOIN CataschevasticaDW.dbo.FactSalesView factSalesView
		ON stagingSales.OrderID = factSalesView.OrderID
    INNER JOIN CataschevasticaDW.dbo.DimCustomer
		ON CataschevasticaDW.dbo.DimCustomer.CustomerID = stagingSales.CustomerId
	INNER JOIN CataschevasticaDW.dbo.DimEmployee
		ON CataschevasticaDW.dbo.DimEmployee.EmployeeID = stagingSales.EmployeeId
	INNER JOIN CataschevasticaDW.dbo.DimProduct
		ON CataschevasticaDW.dbo.DimProduct.SKU = stagingSales.SKU  
WHERE (stagingSales.OrderID > (SELECT MAX(OrderID) FROM factSalesView))
	OR (stagingSales.OrderID = factSalesView.OrderID AND stagingSales.OrderStatus <> factSalesView.OrderStatus AND stagingSales.SKU = factSalesView.ProductID);

DELETE FROM TempFactSales

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




INSERT INTO CataschevasticaStaging.dbo.Sales(OrderID, OrderStatus, CustomerID, EmployeeID, DeliveryPartnerID, SubmissionDate, ShipmentDate, RecievedDate, CancellationDate, SKU, ProductName, UnitsofProduct, Price)
VALUES (69,	'in delivery', 9, 7, 10, '2024-06-09 15:45:16.2900000',	'2024-06-11 15:45:16.2900000',	NULL,	NULL,	'SKU013',	'Aluminum Sheet',	170, 10.00)


UPDATE CataschevasticaStaging.dbo.Sales 
SET OrderStatus = 'completed', RecievedDate = SYSDATETIME()
WHERE OrderID = 64



SELECT * FROM CataschevasticaStaging.dbo.Sales
WHERE OrderID = 64

SELECT * FROM CataschevasticaStaging.dbo.Sales;
SELECT * FROM CataschevasticaDW.dbo.FactSales;
SELECT * FROM TempFactSales
*/

--------------------------------------------------------------------------------------------

-- SCD TYPE 2

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
WHERE SKU='SKU003'


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
