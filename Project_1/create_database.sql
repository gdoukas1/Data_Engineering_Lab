CREATE TABLE Product
(
  Name INT NOT NULL,
  SKU INT NOT NULL,
  Length INT NOT NULL,
  Width INT NOT NULL,
  Thickness INT NOT NULL,
  Weight INT NOT NULL,
  Colour INT NOT NULL,
  ComplianceID INT NOT NULL,
  Cost INT NOT NULL,
  Quantity INT NOT NULL,
  EstimatedTime INT NOT NULL,
  ProductStatus INT NOT NULL,
  PRIMARY KEY (SKU)
);

CREATE TABLE Supplier
(
  SupplierID INT NOT NULL,
  PRIMARY KEY (SupplierID)
);

CREATE TABLE ProductionMember
(
  MemberID INT NOT NULL,
  PRIMARY KEY (MemberID)
);

CREATE TABLE Customer
(
  FirstName INT NOT NULL,
  LastName INT NOT NULL,
  CustomerID INT NOT NULL,
  Email INT NOT NULL,
  Telephone INT NOT NULL,
  PRIMARY KEY (CustomerID)
);

CREATE TABLE LogisticPartner
(
  PartnerID INT NOT NULL,
  PRIMARY KEY (PartnerID)
);

CREATE TABLE RawMaterial
(
  Name INT NOT NULL,
  MaterialID INT NOT NULL,
  SupplierID INT NOT NULL,
  PRIMARY KEY (MaterialID),
  FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE Order
(
  OrderID INT NOT NULL,
  CompletedDatetime INT NOT NULL,
  CustomerID INT NOT NULL,
  MemberID INT NOT NULL,
  PartnerID INT NOT NULL,
  CancelsCustomerID INT NOT NULL,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (MemberID) REFERENCES ProductionMember(MemberID),
  FOREIGN KEY (PartnerID) REFERENCES LogisticPartner(PartnerID),
  FOREIGN KEY (CancelsCustomerID) REFERENCES Customer(CustomerID)
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

CREATE TABLE Order_OrderStatus
(
  OrderStatus INT NOT NULL,
  OrderID INT NOT NULL,
  PRIMARY KEY (OrderStatus, OrderID),
  FOREIGN KEY (OrderID) REFERENCES Order(OrderID)
);