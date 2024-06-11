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
WHERE (stagingSales.OrderID > (SELECT MAX(OrderID) FROM factSales))--MAX(factSales.OrderID)) 
	OR (stagingSales.OrderID = factSales.OrderID AND stagingSales.OrderStatus <> factSales.OrderStatus);


--SELECT * FROM CataschevasticaDW.dbo.FactSales;

-- SCD TYPE 2 DimEmployee

INSERT INTO CataschevasticaStaging.dbo.ProductionEmployee VALUES (14, 'Jim',	'White',	'Production')

UPDATE CataschevasticaStaging.dbo.ProductionEmployee
SET FirstName = 'Markos'
WHERE EmployeeID = 13;

ALTER TABLE FactSales
NOCHECK CONSTRAINT FK_employee
GO

INSERT INTO DimEmployee (EmployeeID, EmployeeName, DepartmentName, RowIsCurrent, RowStartDate, RowEndDate)
SELECT EmployeeID, EmployeeName, DepartmentName, 1, SYSDATETIME(), '9999-12-31'
FROM(
    MERGE DimEmployee AS [Target]
    USING CataschevasticaStaging.dbo.ProductionEmployee AS [Source]
    ON Target.EmployeeID = Source.EmployeeID 
        WHEN MATCHED AND RowIsCurrent = 1 AND (CONCAT(Source.FirstName, ' ', Source.LastName) <> Target.EmployeeName OR Source.[Department Name] <> Target.DepartmentName)
            THEN UPDATE SET target.RowIsCurrent = 0, Target.RowEndDate = SYSDATETIME()
        WHEN NOT MATCHED BY TARGET 
            THEN INSERT (EmployeeID, EmployeeName, DepartmentName, RowStartDate, RowEndDate)
                VALUES (source.EmployeeID, CONCAT(Source.FirstName, ' ', Source.LastName), Source.[Department Name], SYSDATETIME(), '9999-12-31')
        WHEN NOT MATCHED BY Source 
            THEN UPDATE SET target.RowEndDate = SYSDATETIME(), TARGET.RowIsDeleted = 1
    OUTPUT Source.EmployeeID, CONCAT(Source.FirstName, ' ', Source.LastName) AS EmployeeName, Source.[Department Name] AS DepartmentName, $Action AS ActionName
) AS [Merge]
WHERE ActionName = 'UPDATE'
AND EmployeeID IS NOT NULL;


ALTER TABLE FactSales
CHECK CONSTRAINT FK_employee
GO


DELETE FROM CataschevasticaDW.dbo.DimEmployee
WHERE EmployeeKey =14

UPDATE CataschevasticaDW.dbo.DimEmployee
SET RowIsCurrent = 1
WHERE EmployeeKey =13

SELECT * FROM CataschevasticaStaging.dbo.ProductionEmployee
SELECT * FROM CataschevasticaDW.dbo.DimEmployee



-- SCD TYPE 2 DimCustomer


/* One insert and  one update to check that everything works

INSERT INTO CataschevasticaStaging.dbo.Customer (FirstName, LastName, CompanyName, City, Region, PostalCode, Country) VALUES 
('Alice', 'Lee', 'Alice Enterprises', 'Metropolis', 'Region1', 12345, 'France')

UPDATE CataschevasticaStaging.dbo.Customer
SET Country = 'France'
WHERE CustomerID=12
*/ 


ALTER TABLE FactSales
NOCHECK CONSTRAINT FK_customer
GO

INSERT INTO DimCustomer (CustomerID, CustomerName, CompanyName, CustomerCountry, CustomerRegion, CustomerCity, CustomerPostalCode,
							RowIsCurrent, RowStartDate, RowEndDate)
SELECT CustomerID, CustomerName, CompanyName, Country, Region, City, PostalCode, 1, SYSDATETIME(), '9999-12-31'
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
        WHEN NOT MATCHED BY TARGET 
            THEN INSERT (CustomerID, CustomerName, CompanyName, CustomerCountry, CustomerRegion, CustomerCity, CustomerPostalCode, 
							RowStartDate, RowEndDate)
                VALUES (source.CustomerID, CONCAT(Source.FirstName, ' ', Source.LastName), Source.CompanyName, Source.Country, Source.Region, Source.City, Source.PostalCode,
							SYSDATETIME(), '9999-12-31')
        WHEN NOT MATCHED BY Source 
            THEN UPDATE SET target.RowEndDate = SYSDATETIME(), TARGET.RowIsDeleted = 1
    OUTPUT Source.CustomerID, CONCAT(Source.FirstName, ' ', Source.LastName) AS CustomerName, Source.CompanyName, Source.Country, Source.Region, Source.City, Source.PostalCode, $Action AS ActionName
) AS [Merge]
WHERE ActionName = 'UPDATE'
AND CustomerID IS NOT NULL;


ALTER TABLE FactSales
CHECK CONSTRAINT FK_customer
GO


/*Check that both insertion of new records and update works 
SELECT * FROM CataschevasticaStaging.dbo.Customer
SELECT * FORM DimCustomer
*/
