CREATE DATABASE CataschevasticaStaging
GO

USE CataschevasticaStaging
GO

DROP TABLE IF EXISTS CataschevasticaStaging.dbo.[ProductionEmployee];
DROP TABLE IF EXISTS CataschevasticaStaging.dbo.[Customer];
DROP TABLE IF EXISTS CataschevasticaStaging.dbo.[Product];
DROP TABLE IF EXISTS CataschevasticaStaging.dbo.[Sales];


--1. Get Data From Customer Table

SELECT 
	CustomerID,
	FirstName, 
	LastName, 
	CompanyName,
	City, 
	Region, 
	PostalCode, 
	Country
INTO CataschevasticaStaging.dbo.Customer
FROM Cataschevastica.dbo.Customer

/*
SELECT * FROM CataschevasticaStaging.dbo.Customer
SELECT * FROM Cataschevastica.dbo.Customer
*/


--2. Get Data From ProductionEmployee Table

SELECT 
	EmployeeID, 
	FirstName, 
	LastName, 
	[Name] AS 'Department Name'
INTO CataschevasticaStaging.dbo.ProductionEmployee
FROM Cataschevastica.dbo.ProductionEmployee e
INNER JOIN Cataschevastica.dbo.Department d
ON e.DepartmentID = d.DepartmentID

/*
SELECT * FROM CataschevasticaStaging.dbo.ProductionEmployee;

SELECT * FROM Cataschevastica.dbo.ProductionEmployee e
INNER JOIN Cataschevastica.dbo.Department d
ON e.DepartmentID = d.DepartmentID;
*/

--3. Get Data From Product Table

SELECT p.SKU, 
	p.Name, 
	p.Length,
	p.Width,
	p.Thickness,
	p.Weight,
	p.Colour,
	p.ComplianceStandards,
	Price, 
	Quantity,
	EstimatedTime,
	ProductStatus, 
	m.Name AS MaterialName,
	s.Name AS SupplierOfMaterial
INTO CataschevasticaStaging.dbo.Product
FROM Cataschevastica.dbo.Product p
INNER JOIN Cataschevastica.dbo.ProductMaterials pmaterials
	ON p.SKU = pmaterials.SKU
INNER JOIN Cataschevastica.dbo.RawMaterial m
	ON pmaterials.MaterialID = m.MaterialID
INNER JOIN Cataschevastica.dbo.Supplier s
	ON m.SupplierID = s.SupplierID

/*
SELECT * FROM CataschevasticaStaging.dbo.Product;

SELECT * FROM Cataschevastica.dbo.Product p
INNER JOIN Cataschevastica.dbo.ProductMaterials pmaterials
	ON p.SKU = pmaterials.SKU
INNER JOIN Cataschevastica.dbo.RawMaterial m
	ON pmaterials.MaterialID = m.MaterialID
INNER JOIN Cataschevastica.dbo.Supplier s
	ON m.SupplierID = s.SupplierID;
*/


-- 4. Get Data From Orders Table
SELECT  
	o.OrderID,
	OrderStatus, 
	CustomerID,
	EmployeeID,
	DeliveryPartnerID,
	SubmittedAt AS 'SubmissionDate',
	DeliveryAt AS 'ShipmentDate',
	CompletedAt AS 'RecievedDate',
	CancelledAt AS 'CancellationDate',
	p.SKU,
	p.Name AS ProductName,
	UnitsofProduct,
	Price
INTO CataschevasticaStaging.dbo.Sales
FROM Cataschevastica.dbo.Orders o
INNER JOIN Cataschevastica.dbo.OrderDetails odetails
    ON o.OrderID = odetails.OrderID
INNER JOIN Cataschevastica.dbo.Product p
	ON odetails.SKU = p.SKU


/*
SELECT * FROM CataschevasticaStaging.dbo.Sales;

SELECT * FROM Cataschevastica.dbo.Orders o
INNER JOIN Cataschevastica.dbo.OrderDetails odetails
    ON o.OrderID = odetails.OrderID
INNER JOIN Cataschevastica.dbo.Product p
	ON odetails.SKU = p.SKU;
*/
