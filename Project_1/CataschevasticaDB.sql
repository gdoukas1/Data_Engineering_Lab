CREATE TABLE Supplier
(
  SupplierID INT IDENTITY,
  Name VARCHAR(50) NOT NULL,
  Telephone VARCHAR(15) NOT NULL,
  PRIMARY KEY (SupplierID)
);

CREATE TABLE ProductionMember
(
  MemberID INT IDENTITY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  PRIMARY KEY (MemberID)
);

CREATE TABLE Customer
(
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  CustomerID INT IDENTITY,
  Email VARCHAR(30) NOT NULL,
  Telephone VARCHAR(15) NOT NULL,
  City VARCHAR(20) NOT NULL,
  PostalCode INT NOT NULL,
  Street VARCHAR(50) NOT NULL,
  CompanyName VARCHAR(50) NOT NULL,
  PRIMARY KEY (CustomerID)
);

CREATE TABLE LogisticPartner
(
  PartnerID INT IDENTITY,
  Name VARCHAR(50) NOT NULL,
  Telephone VARCHAR(15) NOT NULL,
  PRIMARY KEY (PartnerID)
);

CREATE TABLE Product
(
  Name VARCHAR(50) NOT NULL,
  SKU INT IDENTITY(10000, 1),
  Length NUMERIC(12, 4) NOT NULL,
  Width NUMERIC(12, 4) NOT NULL,
  Thickness NUMERIC(12, 4) NOT NULL,
  Weight NUMERIC(12, 4) NOT NULL,
  Colour VARCHAR(20) NOT NULL,
  ComplianceID VARCHAR(100) NOT NULL,
  Cost NUMERIC(10, 2) NOT NULL,
  Quantity INT NOT NULL,
  EstimatedTime INT NOT NULL,
  ProductStatus VARCHAR(20) NOT NULL,
  MemberID INT NOT NULL,
  PRIMARY KEY (SKU),
  FOREIGN KEY (MemberID) REFERENCES ProductionMember(MemberID)
);

CREATE TABLE RawMaterial
(
  Name VARCHAR(50) NOT NULL,
  MaterialID INT IDENTITY,
  SupplierID INT NOT NULL,
  PRIMARY KEY (MaterialID),
  FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE Orders
(
  OrderID INT IDENTITY,
  OrderStatus VARCHAR(16) NOT NULL,
  CompletedAt DATETIME NOT NULL,
  SubmittedAt DATETIME NOT NULL,
  AssignedAt DATETIME NOT NULL,
  DeliveryAt DATETIME NOT NULL,
  CancelledAt DATETIME NOT NULL,
  CustomerID INT NOT NULL,
  MemberID INT NOT NULL,
  PartnerID INT NOT NULL,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (MemberID) REFERENCES ProductionMember(MemberID),
  FOREIGN KEY (PartnerID) REFERENCES LogisticPartner(PartnerID)
);

CREATE TABLE ProductMaterials
(
  SKU INT NOT NULL,
  MaterialID INT NOT NULL,
  PRIMARY KEY (SKU, MaterialID),
  FOREIGN KEY (SKU) REFERENCES Product(SKU),
  FOREIGN KEY (MaterialID) REFERENCES RawMaterial(MaterialID)
);

CREATE TABLE OrderDetails
(
  UnitsofProduct INT NOT NULL,
  OrderID INT NOT NULL,
  SKU INT NOT NULL,
  PRIMARY KEY (OrderID, SKU),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (SKU) REFERENCES Product(SKU)
);
