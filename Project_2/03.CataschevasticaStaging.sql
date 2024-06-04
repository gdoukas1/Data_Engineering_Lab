CREATE DATABASE CataschevasticaStaging
GO

USE CataschevasticaStaging
GO

--1. Get Data From Customer Table

SELECT 
	CustomerID,
	FirstName, 
	LastName, 
	CompanyName, 
	Address, 
	City, 
	Region, 
	PostalCode, 
	Country
INTO CataschevasticaStaging.dbo.Customer
FROM Cataschevastica.dbo.Customer

SELECT * FROM Cataschevastica.dbo.Customer
SELECT * FROM CataschevasticaStaging.dbo.Customer

--2. Get Data From ProductionEmployee Table

SELECT 
	EmployeeID, 
	FirstName, 
	LastName, 
	[Name] AS 'Department Name'
INTO CataschevasticaStaging.dbo.ProductionEmployee
FROM Cataschevastica.dbo.ProductionEmployee
INNER JOIN Cataschevastica.dbo.Department 
ON Cataschevastica.dbo.ProductionEmployee.DepartmentID = Cataschevastica.dbo.Department.DepartmentID

SELECT * FROM CataschevasticaStaging.dbo.ProductionEmployee


--3. Get Data From Product Table

SELECT Product.SKU, 
	Product.Name, 
	Price, 
	Quantity, 
	ProductStatus, 
	RawMaterial.Name AS MaterialName,
	Supplier.Name AS SupplierOfMaterial
INTO CataschevasticaStaging.dbo.Product
FROM Cataschevastica.dbo.Product
INNER JOIN Cataschevastica.dbo.ProductMaterials 
	ON Cataschevastica.dbo.Product.SKU = Cataschevastica.dbo.ProductMaterials.SKU
INNER JOIN Cataschevastica.dbo.RawMaterial 
	ON Cataschevastica.dbo.ProductMaterials.MaterialID = Cataschevastica.dbo.RawMaterial.MaterialID
INNER JOIN Cataschevastica.dbo.Supplier
	ON Cataschevastica.dbo.RawMaterial.SupplierID = Cataschevastica.dbo.Supplier.SupplierID


-- SELECT * FROM CataschevasticaStaging.dbo.Product

-- 4. Get Data From Orders Table
SELECT  
	Cataschevastica.dbo.Orders.OrderId,
	OrderStatus, 
	Cataschevastica.dbo.Product.SKU,
	EmployeeId, 
	CustomerId, 
	SubmittedAt AS 'SubmissionDate',
	DeliveryAt AS 'ShipmentDate',
	CompletedAt AS 'RecievedDate',
	CancelledAt AS 'CancellationDate',
	UnitsofProduct,
	Price
INTO CataschevasticaStaging.dbo.Sales
FROM Cataschevastica.dbo.Orders
INNER JOIN Cataschevastica.dbo.OrderDetails
    ON Cataschevastica.dbo.Orders.OrderID = Cataschevastica.dbo.OrderDetails.OrderID
INNER JOIN Cataschevastica.dbo.Product
	ON Cataschevastica.dbo.OrderDetails.SKU = Cataschevastica.dbo.Product.SKU

SELECT * FROM CataschevasticaStaging.dbo.Sales