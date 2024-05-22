-- SELECT QUERIES

------------------------------------------------------------------------------------------------
-- a) List of all products ordered yesterday (so that production can start)

SELECT * FROM Orders
WHERE  DATEPART(YEAR, SubmittedAt) =2024 AND DATEPART(MONTH, SubmittedAt) = 05 AND DATEPART(DAY, SubmittedAt) = 1
ORDER BY SubmittedAt DESC;

SELECT * FROM OrderDetails;
/*
select * 
from Orders O
JOIN OrderDetails OD 
ON O.OrderID = OD.OrderID 
JOIN Product P ON P.SKU = OD.SKU
WHERE  (DATEPART(YEAR, SubmittedAt) =2024 AND DATEPART(MONTH, SubmittedAt) = 05 AND DATEPART(DAY, SubmittedAt) = 1)
*/

select Name, P.SKU, SUM(UnitsofProduct) AS TotalUnitsOrdered 
from Orders O
JOIN OrderDetails OD 
ON O.OrderID = OD.OrderID 
JOIN Product P ON P.SKU = OD.SKU
--WHERE  (DATEPART(YEAR, SubmittedAt) =2024 AND DATEPART(MONTH, SubmittedAt) = 05 AND DATEPART(DAY, SubmittedAt) = 1)
WHERE CAST(O.SubmittedAt AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)
AND O.OrderStatus <> 'cancelled'
GROUP BY P.SKU, NAME;


------------------------------------------------------------------------------------------------

--b) List of all finished orders ready to deliver
SELECT * FROM Orders;

select O.OrderID, OrderStatus, SubmittedAt, CustomerID, EmployeeID ,UnitsofProduct, SKU
from Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
WHERE OrderStatus = 'in delivery'

------------------------------------------------------------------------------------------------
--c. List of all orders per customer, completed, pending, cancelled
SELECT 
	Orders.CustomerID, 
	Customer.FirstName, 
	Customer.LastName,  
	Customer.Email,
	Orders.SubmittedAt AS 'Time Of Submission',
	Orders.OrderStatus,
	Orders.OrderID
FROM Orders
INNER JOIN Customer ON Orders.CustomerID = Customer.CustomerID
ORDER BY CustomerID, OrderStatus

-- List of all orders per customer, but also showing the porducts included in the order
SELECT 
	Orders.CustomerID, 
	Customer.FirstName, 
	Customer.LastName, 
	Customer.Email,
	Orders.SubmittedAt AS 'Time Of Submission',
	Orders.OrderStatus, 
	Orders.OrderID, 
	OrderDetails.SKU,
	Product.Name AS 'Product Name',
	OrderDetails.UnitsofProduct
FROM Orders
INNER JOIN Customer ON Orders.CustomerID = Customer.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Product ON OrderDetails.SKU = Product.SKU
ORDER BY CustomerID, OrderStatus

--List of all orders of a specific customer, completed, pending, cancelled
SELECT 
	Orders.CustomerID, 
	Customer.FirstName, 
	Customer.LastName, 
	Customer.Email,
	Orders.SubmittedAt AS 'Time Of Submission',
	Orders.OrderStatus, 
	Orders.OrderID, 
	OrderDetails.SKU,
	Product.Name AS 'Product Name',
	OrderDetails.UnitsofProduct
FROM Orders
INNER JOIN Customer ON Orders.CustomerID = Customer.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Product ON OrderDetails.SKU = Product.SKU
WHERE Orders.CustomerID = 1
ORDER BY OrderStatus

------------------------------------------------------------------------------------------------
--d) List of all products with quantities, ordered and delivered, ordered and pending,cancelled

select Name, OD.SKU, SUM(UnitsofProduct) AS TotalUnitsOrdered, OrderStatus
from Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Product P ON P.SKU = OD.SKU
GROUP BY  OD.SKU, Name, OrderStatus
ORDER BY Name

------------------------------------------------------------------------------------------------

-- e) List of orders per production team employee, completed, pending, cancelled

SELECT e.EmployeeID, e.FirstName, e.LastName, o.OrderID, o.OrderStatus, 
	o.SubmittedAt, o.DeliveryAt, o.CompletedAt, o.CancelledAt 
FROM ProductionEmployee e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
ORDER BY e.EmployeeID, o.OrderStatus, o.SubmittedAt;

------------------------------------------------------------------------------------------------

-- f) Daily order and production report
SELECT * FROM Orders
ORDER BY SubmittedAt;

SELECT CAST(o.SubmittedAt AS DATE) AS OrderDate,
       COUNT(o.OrderID) AS TotalOrders,
       SUM(CASE WHEN o.OrderStatus = 'completed' THEN 1 ELSE 0 END) AS CompletedOrders,
       SUM(CASE WHEN o.OrderStatus = 'in process' OR o.OrderStatus = 'in delivery' THEN 1 ELSE 0 END) AS PendingOrders
       SUM(CASE WHEN o.OrderStatus = 'cancelled' THEN 1 ELSE 0 END) AS CancelledOrders
FROM Orders o
GROUP BY CAST(o.SubmittedAt AS DATE)
ORDER BY OrderDate DESC;

------------------------------------------------------------------------------------------------

-- g) List of new orders per week and month

SELECT DATEPART(YEAR, SubmittedAt) AS OrderYear, 
	   DATEPART(MONTH, SubmittedAt) AS OrderMonth,
	   DATEPART(WEEK, SubmittedAt) AS OrderWeek, OrderID, SubmittedAt
FROM Orders
WHERE Orders.OrderStatus = 'in process'
ORDER BY DATEPART(YEAR, SubmittedAt),  DATEPART(MONTH, SubmittedAt), DATEPART(WEEK, SubmittedAt)

------------------------------------------------------------------------------------------------

--h) List of completed orders per week and month 

SELECT 
	DATEPART(year, Orders.CompletedAt) AS Year,
	DATEPART(month, CompletedAt) AS Month, 
	DATEPART(week, Orders.CompletedAt) AS Week, 
	Orders.OrderID, 
	Orders.CompletedAt
FROM Orders
WHERE Orders.OrderStatus = 'completed'
ORDER BY DATEPART(year, Orders.CompletedAt), DATEPART(week, Orders.CompletedAt), DATEPART(month, CompletedAt), Orders.CompletedAt

--or as two different queries
--1. orders per week
SELECT 
	DATEPART(week, Orders.CompletedAt) AS Week, 
	Orders.OrderID, 
	Orders.CompletedAt
FROM Orders
WHERE Orders.OrderStatus = 'completed'
ORDER BY DATEPART(week, Orders.CompletedAt), Orders.CompletedAt

--2.orders per month
SELECT 
	DATEPART(month, Orders.CompletedAt) AS Month, 
	Orders.OrderID, 
	Orders.CompletedAt
FROM Orders
WHERE Orders.OrderStatus = 'completed'
ORDER BY DATEPART(month, Orders.CompletedAt), Orders.CompletedAt