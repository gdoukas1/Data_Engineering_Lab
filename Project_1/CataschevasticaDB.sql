-- Create the database
CREATE DATABASE Cataschevastica;
GO

-- Switch to the new database
USE Cataschevastica;
GO

-- Table Creation
CREATE TABLE Supplier
(
  SupplierID INT IDENTITY,
  Name NVARCHAR(50) NOT NULL,
  Phone  VARCHAR(20) UNIQUE NOT NULL,
  PRIMARY KEY (SupplierID)
);

CREATE TABLE Department
(
  DepartmentID INT IDENTITY NOT NULL,
  Name  VARCHAR(50) UNIQUE NOT NULL,
  PRIMARY KEY (DepartmentID)
);

CREATE TABLE ProductionEmployee
(
  EmployeeID INT IDENTITY,
  FirstName NVARCHAR(50) NOT NULL,
  LastName NVARCHAR(50) NOT NULL,
  DepartmentID INT NOT NULL,
  PRIMARY KEY (EmployeeID),
  FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
  CONSTRAINT CHK_ProductionMember CHECK (DepartmentID = 1)
);

CREATE TABLE Customer
(
  CustomerID INT IDENTITY,
  FirstName NVARCHAR(50) NOT NULL,
  LastName NVARCHAR(50) NOT NULL,
  Email VARCHAR(30) UNIQUE NOT NULL,
  Phone VARCHAR(20) UNIQUE NOT NULL,
  Address NVARCHAR(60) NOT NULL,
  City NVARCHAR(20) NOT NULL,
  Region NVARCHAR(20) NOT NULL,
  PostalCode INT NOT NULL,
  Country NVARCHAR(24) NOT NULL,
  CompanyName VARCHAR(50) NULL,
  PRIMARY KEY (CustomerID)
);

CREATE TABLE LogisticsPartner
(
  PartnerID INT IDENTITY,
  Name NVARCHAR(50) NOT NULL,
  Phone VARCHAR(20) UNIQUE NOT NULL,
  PRIMARY KEY (PartnerID)
);

CREATE TABLE Product
(
  SKU VARCHAR(50) NOT NULL,
  Name NVARCHAR(50) NOT NULL,
  Length DECIMAL(12, 4) NOT NULL,
  Width DECIMAL(12, 4) NOT NULL,
  Thickness DECIMAL(12, 4) NOT NULL,
  Weight DECIMAL(12, 4) NOT NULL,
  Colour VARCHAR(20) NOT NULL,
  ComplianceStandards VARCHAR(255) NOT NULL,
  CostofProduct DECIMAL(10, 2) NOT NULL,
  Quantity INT NOT NULL DEFAULT 1,
  EstimatedTime INT NOT NULL,
  ProductStatus VARCHAR(20) NOT NULL,
  PRIMARY KEY (SKU),
  CONSTRAINT CHK_ProductStatus CHECK (ProductStatus IN ('in production', 'available', 'not available'))
);

CREATE TABLE RawMaterial
(
  MaterialID INT IDENTITY,
  Name NVARCHAR(50) NOT NULL,
  SupplierID INT NOT NULL,
  PRIMARY KEY (MaterialID),
  FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE Orders
(
  OrderID INT IDENTITY,
  OrderStatus VARCHAR(20) NOT NULL,
  SubmittedAt DATETIME2 NOT NULL,
  DeliveryAt DATETIME2 NULL,
  CompletedAt DATETIME2 NULL,
  CancelledAt DATETIME2 NULL,
  CustomerID INT NOT NULL,
  EmployeeID INT NOT NULL,
  DeliveryPartnerID INT NOT NULL,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (EmployeeID) REFERENCES ProductionEmployee(EmployeeID),
  FOREIGN KEY (DeliveryPartnerID) REFERENCES LogisticsPartner(PartnerID),
  CONSTRAINT CHK_OrderStatus CHECK (OrderStatus IN ('in process', 'in delivery', 'completed', 'cancelled'))
);

CREATE TABLE ProductMaterials
(
  SKU VARCHAR(50) NOT NULL,
  MaterialID INT NOT NULL,
  PRIMARY KEY (SKU, MaterialID),
  FOREIGN KEY (SKU) REFERENCES Product(SKU),
  FOREIGN KEY (MaterialID) REFERENCES RawMaterial(MaterialID)
);

CREATE TABLE OrderDetails
(
  OrderID INT NOT NULL,
  SKU VARCHAR(50) NOT NULL,
  UnitsofProduct INT NOT NULL,
  PRIMARY KEY (OrderID, SKU),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (SKU) REFERENCES Product(SKU)
);
