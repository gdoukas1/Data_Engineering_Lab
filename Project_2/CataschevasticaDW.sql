CREATE DATABASE CataschevasticaDW
GO

USE CataschevasticaDW
GO

--1. Create Customer Dimension Table

CREATE TABLE DimCustomer(
	CustomerKey INT IDENTITY(1,1) NOT NULL,
	CustomerID INT NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	CompanyName NVARCHAR(50) NOT NULL,
	[Address] NVARCHAR(60) NOT NULL,
	City NVARCHAR(20) NOT NULL,
	Region NVARCHAR(20) NOT NULL,
	PostalCode INT NOT NULL,
	Country NVARCHAR(24) NOT NULL,
	RowIsCurrent INT DEFAULT 1 NOT NULL,
    RowStartDate DATE DEFAULT '1899-12-31' NOT NULL,
    RowEndDate DATE DEFAULT '9999-12-31' NOT NULL,
    RowChangeReason VARCHAR(200) NULL
	PRIMARY KEY(CustomerKey)
);

--2. Create Employee Dimension Table

CREATE TABLE DimEmployee(
	EmployeeKey INT IDENTITY(1,1) NOT NULL,
	EmployeeID INT NOT NULL,
	FirstName NVARCHAR(50) NOT NULL, 
	LastName NVARCHAR(50) NOT NULL, 
	DepartmentName VARCHAR(50) NOT NULL,
	RowIsCurrent INT DEFAULT 1 NOT NULL,
    RowStartDate DATE DEFAULT '1899-12-31' NOT NULL,
    RowEndDate DATE DEFAULT '9999-12-31' NOT NULL,
    RowChangeReason VARCHAR(200) NULL
	PRIMARY KEY(EmployeeKey)
);

--3. Create Product Dimension Product:

CREATE TABLE DimProduct(
    ProductKey INT IDENTITY(1,1) NOT NULL,
    SKU VARCHAR(50) NOT NULL,
    ProductName NVARCHAR(50) NOT NULL,
    ProductStatus VARCHAR(20) NOT NULL,
	CostOfProduct DECIMAL(10,2) NOT NULL,
	EstimatedTime INT NOT NULL,
    RowIsCurrent INT DEFAULT 1 NOT NULL,
    RowStartDate DATE DEFAULT '1899-12-31' NOT NULL,
    RowEndDate DATE DEFAULT '9999-12-31' NOT NULL,
    RowChangeReason VARCHAR(200) NULL
	PRIMARY KEY(ProductKey)
);


--4. Create Sales Fact Table

CREATE TABLE FactSales(
    ProductKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    EmployeeKey INT NOT NULL,
    OrderDateKey INT NOT NULL,
    ShippedDateKey INT,
	RecievedDateKey INT,
	CancellationDateKey INT,
    OrderID INT NOT NULL,
    Quantity INT NOT NULL,
    ExtendedPriceAmount FLOAT NOT NULL,
);


--Create relationships between Dimension Tables and Fact Table

ALTER TABLE FactSales
ADD CONSTRAINT FK_employee FOREIGN KEY(EmployeeKey) REFERENCES DimEmployee(EmployeeKey)

ALTER TABLE FactSales
ADD CONSTRAINT FK_customer FOREIGN KEY(CustomerKey) REFERENCES DimCustomer(CustomerKey)

ALTER TABLE FactSales
ADD CONSTRAINT FK_product FOREIGN KEY(ProductKey) REFERENCES DimProduct(ProductKey)


--These ones require the creation of the DimDate table before being executed

ALTER TABLE FactSales
ADD CONSTRAINT FK_orderDate FOREIGN KEY(OrderDateKey) REFERENCES DimDate(OrderDateKey)

ALTER TABLE FactSales
ADD CONSTRAINT FK_shippedDate FOREIGN KEY(ShippedDateKey) REFERENCES DimDate(ShippedDateKey)

ALTER TABLE FactSales
ADD CONSTRAINT FK_recievedDate FOREIGN KEY(RecievedDateKey) REFERENCES DimDate(RecievedDateKey)

ALTER TABLE FactSales
ADD CONSTRAINT FK_cancellationDate FOREIGN KEY(CancellationDateKey) REFERENCES DimDate(CancellationDateKey)

