USE CataschevasticaDW
GO

-- Only for the first load

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

INSERT INTO DimProduct(SKU, ProductName, ProductStatus, Price, EstimatedTime, Length, Width, 
	Thickness, Weight, Colour, Quantity, ComplianceStandards, MaterialName, SupplierOfMaterial)
SELECT SKU, Name, ProductStatus, Price, EstimatedTime, Length, Width, 
	Thickness, Weight, Colour, Quantity, ComplianceStandards, MaterialName, SupplierOfMaterial
	FROM CataschevasticaStaging.dbo.Product


--4

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

SELECT * FROM CataschevasticaDW.dbo.FactSales
