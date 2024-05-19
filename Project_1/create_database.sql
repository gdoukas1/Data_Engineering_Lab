CREATE TABLE Supplier
(
  SupplierID INT NOT NULL,
  Name VARCHAR(50) NOT NULL,
  Telephone VARCHAR(15) NOT NULL,
  PRIMARY KEY (SupplierID)
);

CREATE TABLE ProductionMember
(
  MemberID INT NOT NULL,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  PRIMARY KEY (MemberID)
);

CREATE TABLE Customer
(
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  CustomerID INT NOT NULL,
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
  PartnerID INT NOT NULL,
  Name VARCHAR(50) NOT NULL,
  Telephone VARCHAR(15) NOT NULL,
  PRIMARY KEY (PartnerID)
);

CREATE TABLE Product
(
  Name VARCHAR(50) NOT NULL,
  SKU INT NOT NULL,
  Length NUMERIC(12 4) NOT NULL,
  Width NUMERIC(12 4) NOT NULL,
  Thickness NUMERIC(12 4) ) NOT NULL,
  Weight NUMERIC(12 4) NOT NULL,
  Colour VARCHAR(20) NOT NULL,
  ComplianceID VARCHAR(100) NOT NULL,
  Cost NUMERIC(10 2) NOT NULL,
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
  MaterialID INT NOT NULL,
  SupplierID INT NOT NULL,
  PRIMARY KEY (MaterialID),
  FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE Order
(
  OrderID INT NOT NULL,
  OrderStatus VARCHAR(16) NOT NULL,
  CompletedDatetime DATE NOT NULL,
  SubmittedDatetime DATE NOT NULL,
  AssignedDatetime DATE NOT NULL,
  DeliveryDatetime DATE NOT NULL,
  CancelledDatetime DATE NOT NULL,
  CustomerID INT NOT NULL,
  MemberID INT NOT NULL,
  PartnerID INT NOT NULL,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (MemberID) REFERENCES ProductionMember(MemberID),
  FOREIGN KEY (PartnerID) REFERENCES LogisticPartner(PartnerID)
);

CREATE TABLE Uses
(
  SKU INT NOT NULL,
  MaterialID INT NOT NULL,
  PRIMARY KEY (SKU, MaterialID),
  FOREIGN KEY (SKU) REFERENCES Product(SKU),
  FOREIGN KEY (MaterialID) REFERENCES RawMaterial(MaterialID)
);

CREATE TABLE Includes
(
  UnitsofProduct INT NOT NULL,
  OrderID INT NOT NULL,
  SKU INT NOT NULL,
  PRIMARY KEY (OrderID, SKU),
  FOREIGN KEY (OrderID) REFERENCES Order(OrderID),
  FOREIGN KEY (SKU) REFERENCES Product(SKU)
);