USE CataschevasticaDW

-- Only for the first load
DELETE FROM FactSales;
DELETE FROM DimProduct;
DELETE FROM DimCustomer;
DELETE FROM DimEmployee;


-- 1
INSERT INTO DimEmployee (EmployeeID, EmployeeName, DepartmentName)
  SELECT EmployeeID, CONCAT(FirstName, ' ', LastName), [Department Name]  
  FROM CataschevasticaStaging.dbo.ProductionEmployee

  SELECT * FROM CataschevasticaDW.dbo.DimEmployee

--2
INSERT INTO DimCustomer(CustomerID, CompanyName, ContactName, ContactTitle,
CustomerCountry, CustomerRegion, CustomerCity, CustomerPostalCode)
    SELECT CustomerID, CompanyName, ContactName, ContactTitle,
    Country, ISNULL(Region,'N/A'), City, ISNULL(PostalCode,'')
        FROM SouthwindStaging.dbo.Customers

--3
INSERT INTO DimProduct(ProductID, ProductName, Discontinued,
    SupplierName, CategoryName )
SELECT ProductID, ProductName, Discontinued, [CompanyName], CategoryName
        FROM SouthwindStaging.dbo.Products

--4
INSERT INTO FactSales(
    ProductKey, CustomerKey, EmployeeKey, OrderDateKey, ShippedDateKey,
    OrderID, Quantity, ExtendedPriceAmount, DiscountAmount, SoldAmount)
SELECT ProductKey, CustomerKey, EmployeeKey,
    CAST(FORMAT(OrderDate,'yyyyMMdd') AS INT),
    CAST(FORMAT(ShippedDate,'yyyyMMdd') AS INT),
    OrderID, Quantity, [UnitPrice]*[Quantity], ([UnitPrice]*[Discount])*[Quantity],
	([UnitPrice]*(1-[Discount]))*[Quantity]
        FROM SouthwindStaging.dbo.Sales
INNER JOIN SouthwindDW.dbo.DimCustomer
    ON SouthwindDW.dbo.DimCustomer.CustomerID=SouthwindStaging.dbo.Sales.CustomerId
INNER JOIN SouthwindDW.dbo.DimEmployee
    ON SouthwindDW.dbo.DimEmployee.EmployeeID=SouthwindStaging.dbo.Sales.EmployeeId
INNER JOIN SouthwindDW.dbo.DimProduct
    ON SouthwindDW.dbo.DimProduct.ProductID=SouthwindStaging.dbo.Sales.ProductID

SELECT * FROM FactSales


