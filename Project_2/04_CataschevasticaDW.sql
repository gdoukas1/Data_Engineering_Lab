CREATE DATABASE CataschevasticaDW
GO

USE CataschevasticaDW
GO


--1. Create Customer Dimension Table

CREATE TABLE DimCustomer(
	CustomerKey INT IDENTITY(1,1) NOT NULL,
	CustomerID INT NOT NULL,
	CustomerName NVARCHAR(100) NOT NULL,
	CompanyName NVARCHAR(50) NOT NULL,
	CustomerCountry NVARCHAR(24) NOT NULL,
	CustomerRegion NVARCHAR(20) NOT NULL,
	CustomerCity NVARCHAR(20) NOT NULL,
	CustomerPostalCode INT NOT NULL,
	RowIsCurrent INT DEFAULT 1 NOT NULL,
    RowStartDate DATE DEFAULT '1899-12-31' NOT NULL,
    RowEndDate DATE DEFAULT '9999-12-31' NOT NULL,
    RowChangeReason VARCHAR(200) NULL,
	RowIsDeleted BIT DEFAULT 0,
	PRIMARY KEY(CustomerKey)
);


--2. Create Employee Dimension Table

CREATE TABLE DimEmployee(
	EmployeeKey INT IDENTITY(1,1) NOT NULL,
	EmployeeID INT NOT NULL,
	EmployeeName NVARCHAR(100) NOT NULL, 
	DepartmentName VARCHAR(50) NOT NULL,
	RowIsCurrent INT DEFAULT 1 NOT NULL,
    RowStartDate DATE DEFAULT '1899-12-31' NOT NULL,
    RowEndDate DATE DEFAULT '9999-12-31' NOT NULL,
    RowChangeReason VARCHAR(200) NULL,
	RowIsDeleted BIT DEFAULT 0,
	PRIMARY KEY(EmployeeKey)
);


--3. Create Product Dimension Product:

CREATE TABLE DimProduct(
    ProductKey INT IDENTITY(1,1) NOT NULL,
    SKU VARCHAR(50) NOT NULL,
    ProductName NVARCHAR(50) NOT NULL,
    ProductStatus VARCHAR(20) NOT NULL,
	Price DECIMAL(10,2) NOT NULL,
	EstimatedTime INT NOT NULL,
	Length DECIMAL(12, 4) NOT NULL,
	Width DECIMAL(12, 4) NOT NULL,
	Thickness DECIMAL(12, 4) NOT NULL,
	Weight DECIMAL(12, 4) NOT NULL,
	Colour VARCHAR(20) NOT NULL,
	Quantity INT NOT NULL,
	ComplianceStandards VARCHAR(255) NOT NULL,
	MaterialName NVARCHAR(50) NOT NULL,
	SupplierOfMaterial NVARCHAR(50) NOT NULL,
    RowIsCurrent INT DEFAULT 1 NOT NULL,
    RowStartDate DATE DEFAULT '1899-12-31' NOT NULL,
    RowEndDate DATE DEFAULT '9999-12-31' NOT NULL,
    RowChangeReason VARCHAR(200) NULL,
	RowIsDeleted BIT DEFAULT 0,
	PRIMARY KEY(ProductKey)
);


--4. Create Sales Fact Table

CREATE TABLE FactSales(
	SalesID INT IDENTITY NOT NULL,
	OrderStatus VARCHAR(20) NOT NULL,
	OrderID INT NOT NULL,
    ProductKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    EmployeeKey INT NOT NULL,
	DeliveryPartnerID INT NOT NULL,
	OrderDateKey INT NOT NULL,
    ShippedDateKey INT,
	RecievedDateKey INT,
	CancellationDateKey INT,
    Quantity INT NOT NULL,
	Price DECIMAL(10, 2) NOT NULL,
    ExtendedPriceAmount FLOAT NOT NULL,
);
