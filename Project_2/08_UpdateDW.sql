USE CataschevasticaDW
GO

/*
SELECT * FROM CataschevasticaStaging.dbo.Sales;

INSERT INTO CataschevasticaStaging.dbo.Sales(OrderID, OrderStatus, CustomerID, EmployeeID, DeliveryPartnerID, SubmissionDate, ShipmentDate, RecievedDate, CancellationDate, SKU, ProductName, UnitsofProduct, Price)
VALUES (26,	'in process', 9, 7, 10, '2024-06-09 15:45:16.2900000',	NULL,	NULL,	NULL,	'SKU013',	'Aluminum Sheet',	170, 10.00)

SELECT * FROM CataschevasticaDW.dbo.FactSales;

UPDATE CataschevasticaStaging.dbo.Sales 
SET OrderStatus = 'in delivery', ShipmentDate = SYSDATETIME()
WHERE OrderID = 26
*/

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
	INNER JOIN CataschevasticaDW.dbo.DimCustomer
		ON CataschevasticaDW.dbo.DimCustomer.CustomerID = stagingSales.CustomerId
	INNER JOIN CataschevasticaDW.dbo.DimEmployee
		ON CataschevasticaDW.dbo.DimEmployee.EmployeeID = stagingSales.EmployeeId
	INNER JOIN CataschevasticaDW.dbo.DimProduct
		ON CataschevasticaDW.dbo.DimProduct.SKU = stagingSales.SKU
	LEFT JOIN CataschevasticaDW.dbo.FactSales factSales
		ON stagingSales.OrderID = factSales.OrderID
WHERE (stagingSales.OrderID > (SELECT MAX(OrderID) FROM factSales))
	OR (stagingSales.OrderID = factSales.OrderID AND stagingSales.OrderStatus <> factSales.OrderStatus);

/*
SELECT * FROM CataschevasticaDW.dbo.FactSales;
*/

--------------------------------------------------------------------------------------------

-- SCD TYPE 2

DELETE
FROM CataschevasticaStaging.dbo.ProductionEmployee
WHERE EmployeeID = 14

ALTER TABLE FactSales
NOCHECK CONSTRAINT FK_employee
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

/*
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

/* One insert and one update to check that everything works

INSERT INTO CataschevasticaStaging.dbo.Customer (FirstName, LastName, CompanyName, City, Region, PostalCode, Country) VALUES 
('Alice', 'Lee', 'Alice Enterprises', 'Metropolis', 'Region1', 12345, 'France')

UPDATE CataschevasticaStaging.dbo.Customer
SET Country = 'France'
WHERE CustomerID = 12
*/ 


ALTER TABLE FactSales
NOCHECK CONSTRAINT FK_customer
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

INSERT INTO DimProduct (SKU, ProductName, ProductStatus, Price, EstimatedTime, Length, Width, Thickness, Weight, Colour, Quantity, ComplianceStandards, MaterialName, SupplierOfMaterial, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
SELECT SKU, Name, ProductStatus, Price, EstimatedTime, Length, Width, Thickness, Weight, Colour, Quantity, ComplianceStandards, MaterialName, SupplierOfMaterial, 1, SYSDATETIME(), '9999-12-31', ActionName
FROM(
    MERGE DimProduct AS [Target]
    USING CataschevasticaStaging.dbo.Product AS [Source]
    ON Target.SKU = Source.SKU 
        WHEN MATCHED AND RowIsCurrent = 1 AND 
        (Source.Name <> Target.ProductName 
        OR Source.ProductStatus <> Target.ProductStatus 
        OR Source.Price <> Target.Price 
		OR Source.EstimatedTime <> Target.EstimatedTime 
        OR Source.Length <> Target.Length 
        OR Source.Width <> Target.Width 
        OR Source.Thickness <> Target.Thickness 
		OR Source.Weight <> Target.Weight 
        OR Source.Colour <> Target.Colour 
        OR Source.Quantity <> Target.Quantity 
        OR Source.ComplianceStandards <> Target.ComplianceStandards 
		OR Source.MaterialName <> Target.MaterialName 
        OR Source.SupplierOfMaterial <> Target.SupplierOfMaterial)
            THEN UPDATE SET target.RowIsCurrent = 0, Target.RowEndDate = SYSDATETIME()
        WHEN NOT MATCHED BY TARGET 
            THEN INSERT (SKU, ProductName, ProductStatus, Price, EstimatedTime, Length, Width, Thickness, Weight, Colour, Quantity, ComplianceStandards, MaterialName, SupplierOfMaterial, RowStartDate, RowEndDate)
                VALUES (Source.SKU, Source.Name, Source.ProductStatus, Source.Price, Source.EstimatedTime, Source.Length, Source.Width, Source.Thickness, Source.Weight, Source.Colour, Source.Quantity, Source.ComplianceStandards, Source.MaterialName, Source.SupplierOfMaterial, SYSDATETIME(), '9999-12-31')
        WHEN NOT MATCHED BY Source 
            THEN UPDATE SET target.RowEndDate = SYSDATETIME(), Target.RowIsCurrent = 0, Target.RowIsDeleted = 1, Target.RowChangeReason = 'DELETE'
    OUTPUT Source.SKU, Source.Name, Source.ProductStatus, Source.Price, Source.EstimatedTime, Source.Length, Source.Width, Source.Thickness, Source.Weight, Source.Colour, Source.Quantity, Source.ComplianceStandards, Source.MaterialName, Source.SupplierOfMaterial, $Action AS ActionName
) AS [Merge]
WHERE ActionName = 'UPDATE'
AND SKU IS NOT NULL;

ALTER TABLE FactSales
CHECK CONSTRAINT FK_product
GO

/*
INSERT INTO CataschevasticaStaging.dbo.Product (SKU, Name, ProductStatus, Price, EstimatedTime, Length, Width, Thickness, Weight, Colour, Quantity, ComplianceStandards, MaterialName, SupplierOfMaterial)
VALUES ()

UPDATE CataschevasticaStaging.dbo.Product
SET EstimatedTime = 999
WHERE SKU = 'SKU015'

-- Check that both insertion of new records and update works 

SELECT * FROM CataschevasticaStaging.dbo.Product
SELECT * FROM DimProduct

*/

