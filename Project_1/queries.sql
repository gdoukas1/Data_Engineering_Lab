-- QUERIES
------------------------------------------------------------------------------------------------

-- a) List of all products ordered yesterday (so that production can start)

/*
-- just for testing
SELECT o.OrderID, SKU, UnitsofProduct, OrderStatus, SubmittedAt, DeliveryAt, CompletedAt, CancelledAt
FROM Orders o
INNER JOIN OrderDetails od 
ON o.OrderID = od.OrderID 
WHERE CAST(SubmittedAt AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)
ORDER BY SubmittedAt DESC
*/

SELECT Name, P.SKU, SUM(UnitsofProduct) AS TotalUnitsOrdered 
FROM Orders O
INNER JOIN OrderDetails OD 
ON O.OrderID = OD.OrderID 
INNER JOIN Product P ON P.SKU = OD.SKU
WHERE CAST(O.SubmittedAt AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)
AND O.OrderStatus <> 'cancelled'
GROUP BY P.SKU, NAME;


/*
-- list of of products of a specific day
SELECT Name, P.SKU, SUM(UnitsofProduct) AS TotalUnitsOrdered 
FROM Orders O
INNER JOIN OrderDetails OD 
ON O.OrderID = OD.OrderID 
INNER JOIN Product P ON P.SKU = OD.SKU
WHERE  (DATEPART(YEAR, SubmittedAt) =2024 AND DATEPART(MONTH, SubmittedAt) = 05 AND DATEPART(DAY, SubmittedAt) = 1)
--WHERE CAST(O.SubmittedAt AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)
AND O.OrderStatus <> 'cancelled'
GROUP BY P.SKU, NAME;
*/

------------------------------------------------------------------------------------------------

--b) List of all finished orders ready to deliver
/*
-- testing
SELECT O.OrderID, OrderStatus, SubmittedAt, DeliveryAt, CustomerID, EmployeeID ,UnitsofProduct, SKU
FROM Orders O
INNER JOIN OrderDetails OD ON O.OrderID = OD.OrderID
WHERE OrderStatus = 'in delivery'
*/

SELECT OrderID, OrderStatus, SubmittedAt, DeliveryAt, CustomerID
FROM Orders
WHERE OrderStatus = 'in delivery'
GROUP BY OrderID, OrderStatus, SubmittedAt, DeliveryAt, CustomerID

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

/*
-- List of all orders per customer, but also showing the products included in the order
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
*/
------------------------------------------------------------------------------------------------

--d) List of all products with quantities, ordered and delivered, ordered and pending,cancelled

/*
-- Check
SELECT *
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
*/

SELECT Name, OD.SKU, SUM(UnitsofProduct) AS TotalUnitsOrdered, OrderStatus
FROM Orders O
INNER JOIN OrderDetails OD ON O.OrderID = OD.OrderID
INNER JOIN Product P ON P.SKU = OD.SKU
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

SELECT CAST(GETDATE() AS DATE) AS OrderDate,
       COUNT(o.OrderID) AS TotalOrders,
       SUM(CASE WHEN o.OrderStatus = 'completed' THEN 1 ELSE 0 END) AS CompletedOrders,
       SUM(CASE WHEN o.OrderStatus = 'in process' OR o.OrderStatus = 'in delivery' THEN 1 ELSE 0 END) AS PendingOrders,
       SUM(CASE WHEN o.OrderStatus = 'cancelled' THEN 1 ELSE 0 END) AS CancelledOrders
FROM Orders o
WHERE CAST(o.SubmittedAt AS DATE) = CAST(GETDATE() AS DATE) 
	  OR CAST(o.CompletedAt AS DATE) = CAST(GETDATE() AS DATE)
	  OR CAST(o.DeliveryAt AS DATE) = CAST(GETDATE() AS DATE) 
	  OR CAST(o.CancelledAt AS DATE) = CAST(GETDATE() AS DATE);

SELECT o.OrderID, SKU, UnitsofProduct, OrderStatus, CAST(SubmittedAt AS DATE) AS SubmittedAt, 
CAST(DeliveryAt AS DATE) AS DeliveryAt, CAST(CompletedAt AS DATE) AS CompletedAt, CAST(CancelledAt AS DATE) AS CancelledAt
FROM Orders o
INNER JOIN OrderDetails od 
ON o.OrderID = od.OrderID 
WHERE CAST(o.SubmittedAt AS DATE) = CAST(GETDATE() AS DATE) 
	  OR CAST(o.CompletedAt AS DATE) = CAST(GETDATE() AS DATE)
	  OR CAST(o.DeliveryAt AS DATE) = CAST(GETDATE() AS DATE) 
	  OR CAST(o.CancelledAt AS DATE) = CAST(GETDATE() AS DATE)
ORDER BY OrderID;

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

/*
--or as two different queries
--1. orders per week
SELECT 
	DATEPART(week, Orders.CompletedAt) AS Week, 
	Orders.OrderID, 
	Orders.CompletedAt
FROM Orders
WHERE Orders.OrderStatus = 'completed'
ORDER BY DATEPART(week, Orders.CompletedAt), Orders.CompletedAt

--2. orders per month
SELECT 
	DATEPART(month, Orders.CompletedAt) AS Month, 
	Orders.OrderID, 
	Orders.CompletedAt
FROM Orders
WHERE Orders.OrderStatus = 'completed'
ORDER BY DATEPART(month, Orders.CompletedAt), Orders.CompletedAt
*/


------------------------------------------------------------------------------------------------

-- 5.a) Create an Order

--Step 1
-- Enter Details of Order
DECLARE @CustomerID INT = 5;			-- Replace with actual CustomerID
DECLARE @EmployeeID INT = 7;			-- Replace with actual EmployeeID (must belong to the production department)
DECLARE @DeliveryPartnerID INT = 4;		-- Replace with actual DeliveryPartnerID
DECLARE @OrderID INT; 

-- Calculate how many orders exist and increase by 1
SET @OrderID = (SELECT COUNT(*) FROM Orders) + 1;

-- Create a new order with the current_timestamp 
INSERT INTO Orders (OrderStatus, SubmittedAt, DeliveryAt, CompletedAt, CancelledAt, CustomerID, EmployeeID, DeliveryPartnerID) VALUES 
('in process', GETDATE(), NULL, NULL, NULL, @CustomerID, @EmployeeID, @DeliveryPartnerID);

-- Step 2
-- Insert Products into Order
DECLARE @SKU VARCHAR(50) = 'SKU007';		-- Replace with actual product's SKU
DECLARE @UnitsofProduct INT = 20;			-- Replace with actual product's ordered amount
DECLARE @OrderDetailID INT; 

-- Calculate how many orders exist and increase by 1
SET @OrderDetailID = (SELECT COUNT(*) FROM Orders)
INSERT INTO OrderDetails (OrderID, SKU, UnitsofProduct) VALUES 
(@OrderDetailID, @SKU, @UnitsofProduct);

------------------------------------------------------------------------------------------------

--5.b) Finalise production

DECLARE @SKUproduction VARCHAR(50) = 'SKU001';  -- Replace with actual product's SKU

UPDATE Product
SET ProductStatus = 'available'
WHERE SKU = @SKUproduction;

------------------------------------------------------------------------------------------------

--5.c) Finalise an order and delivery

DECLARE @Order_id INT = 1;			 -- Replace with actual OrderID
DECLARE @DeliveryPartner INT = 4;	 -- Replace with actual DeliveryPartnerID if selection is manually

-- Finalise an order from production, set the DeliveryAt timestamp
UPDATE Orders
SET OrderStatus = 'in delivery', DeliveryAt = GETDATE(), DeliveryPartnerID = @DeliveryPartner 
WHERE OrderID = @Order_id;

-- Finalise an order after it delivered successfully 
-- Update the order status to 'completed' and set the CompletedAt timestamp
UPDATE Orders
SET OrderStatus = 'completed', CompletedAt = GETDATE()
WHERE OrderID = @Order_id;

-- Finalise order if cancelled
UPDATE Orders
SET OrderStatus = 'cancelled', CancelledAt = GETDATE()
WHERE OrderID = @Order_id;