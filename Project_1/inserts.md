Sure! Here's a set of 12 INSERT statements for each table in your database schema. These statements will add sample data to each table.

### 1. Inserting into the `Supplier` table
```sql
INSERT INTO Supplier (Name, Telephone) VALUES 
('Supplier A', '123-456-7890'),
('Supplier B', '234-567-8901'),
('Supplier C', '345-678-9012'),
('Supplier D', '456-789-0123'),
('Supplier E', '567-890-1234'),
('Supplier F', '678-901-2345'),
('Supplier G', '789-012-3456'),
('Supplier H', '890-123-4567'),
('Supplier I', '901-234-5678'),
('Supplier J', '012-345-6789'),
('Supplier K', '123-456-7800'),
('Supplier L', '234-567-8900');
```

### 2. Inserting into the `ProductionMember` table
```sql
INSERT INTO ProductionMember (FirstName, LastName) VALUES 
('John', 'Doe'),
('Jane', 'Smith'),
('Robert', 'Johnson'),
('Michael', 'Williams'),
('David', 'Brown'),
('Mary', 'Jones'),
('James', 'Garcia'),
('Patricia', 'Miller'),
('Linda', 'Davis'),
('Barbara', 'Rodriguez'),
('Elizabeth', 'Martinez'),
('Jennifer', 'Hernandez');
```

### 3. Inserting into the `Customer` table
```sql
INSERT INTO Customer (FirstName, LastName, Email, Telephone, City, PostalCode, Street, CompanyName) VALUES 
('Alice', 'Johnson', 'alice.j@example.com', '111-222-3333', 'New York', 10001, '123 Main St', 'Company A'),
('Bob', 'Smith', 'bob.s@example.com', '222-333-4444', 'Los Angeles', 90001, '456 Elm St', 'Company B'),
('Charlie', 'Brown', 'charlie.b@example.com', '333-444-5555', 'Chicago', 60001, '789 Pine St', 'Company C'),
('David', 'Williams', 'david.w@example.com', '444-555-6666', 'Houston', 77001, '101 Maple St', 'Company D'),
('Eve', 'Jones', 'eve.j@example.com', '555-666-7777', 'Phoenix', 85001, '202 Oak St', 'Company E'),
('Frank', 'Miller', 'frank.m@example.com', '666-777-8888', 'Philadelphia', 19019, '303 Cedar St', 'Company F'),
('Grace', 'Davis', 'grace.d@example.com', '777-888-9999', 'San Antonio', 78201, '404 Birch St', 'Company G'),
('Hank', 'Garcia', 'hank.g@example.com', '888-999-0000', 'San Diego', 92101, '505 Spruce St', 'Company H'),
('Ivy', 'Martinez', 'ivy.m@example.com', '999-000-1111', 'Dallas', 75201, '606 Cherry St', 'Company I'),
('Jack', 'Rodriguez', 'jack.r@example.com', '000-111-2222', 'San Jose', 95101, '707 Walnut St', 'Company J'),
('Kim', 'Martinez', 'kim.m@example.com', '111-222-1234', 'Austin', 73301, '808 Palm St', 'Company K'),
('Luke', 'Hernandez', 'luke.h@example.com', '222-333-2345', 'Jacksonville', 32099, '909 Cypress St', 'Company L');
```

### 4. Inserting into the `LogisticPartner` table
```sql
INSERT INTO LogisticPartner (Name, Telephone) VALUES 
('Logistic Partner A', '321-654-0987'),
('Logistic Partner B', '432-765-1098'),
('Logistic Partner C', '543-876-2109'),
('Logistic Partner D', '654-987-3210'),
('Logistic Partner E', '765-098-4321'),
('Logistic Partner F', '876-109-5432'),
('Logistic Partner G', '987-210-6543'),
('Logistic Partner H', '098-321-7654'),
('Logistic Partner I', '109-432-8765'),
('Logistic Partner J', '210-543-9876'),
('Logistic Partner K', '321-654-0980'),
('Logistic Partner L', '432-765-1090');
```

### 5. Inserting into the `Product` table
```sql
INSERT INTO Product (Name, Length, Width, Thickness, Weight, Colour, ComplianceID, Cost, Quantity, EstimatedTime, ProductStatus, MemberID) VALUES 
('Product A', 10.5, 5.2, 1.1, 2.5, 'Red', 'C1234', 15.50, 100, 3, 'Available', 1),
('Product B', 20.0, 10.0, 2.0, 5.0, 'Blue', 'C2345', 25.75, 200, 5, 'Available', 2),
('Product C', 30.5, 15.2, 3.1, 7.5, 'Green', 'C3456', 35.00, 300, 7, 'Available', 3),
('Product D', 40.0, 20.0, 4.0, 10.0, 'Yellow', 'C4567', 45.25, 400, 9, 'Available', 4),
('Product E', 50.5, 25.2, 5.1, 12.5, 'Purple', 'C5678', 55.50, 500, 11, 'Available', 5),
('Product F', 60.0, 30.0, 6.0, 15.0, 'Orange', 'C6789', 65.75, 600, 13, 'Available', 6),
('Product G', 70.5, 35.2, 7.1, 17.5, 'Black', 'C7890', 75.00, 700, 15, 'Available', 7),
('Product H', 80.0, 40.0, 8.0, 20.0, 'White', 'C8901', 85.25, 800, 17, 'Available', 8),
('Product I', 90.5, 45.2, 9.1, 22.5, 'Grey', 'C9012', 95.50, 900, 19, 'Available', 9),
('Product J', 100.0, 50.0, 10.0, 25.0, 'Pink', 'C0123', 105.75, 1000, 21, 'Available', 10),
('Product K', 110.5, 55.2, 11.1, 27.5, 'Brown', 'C1234', 115.00, 1100, 23, 'Available', 11),
('Product L', 120.0, 60.0, 12.0, 30.0, 'Cyan', 'C2345', 125.25, 1200, 25, 'Available', 12);
```

### 6. Inserting into the `RawMaterial` table
```sql
INSERT INTO RawMaterial (Name, SupplierID) VALUES 
('Material A', 1),
('Material B', 2),
('Material C', 3),
('Material D', 4),
('Material E', 5),
('Material F', 6),
('Material G', 7),
('Material H', 8),
('Material I', 9),
('Material J', 10),
('Material K', 11),
('Material L', 12);
```

### 7. Inserting into the `Orders` table
```sql
INSERT INTO Orders (OrderStatus, CompletedDatetime, SubmittedDatetime, AssignedDatetime, DeliveryDatetime, CancelledDatetime, CustomerID, MemberID, PartnerID) VALUES 
('Pending', '2023-01-10', '2023-01-01', '2023-01-05', '2023-01-15', '2023-01-20', 1, 1, 1),
('Completed', '2023-02-10', '2023-02-01', '2023-02-05', '2023-02-15', '2023-02-20', 2, 2, 2),
('Cancelled', '2023-03-10', '2023-03-01', '2023-03-05', '2023-03-15', '2023-03-20', 3, 3, 3),
('Pending', '2023-04-10', '2023-04-01', '2023-04-05', '2023-04-15', '2023-04-20', 4, 4, 4),
('Completed', '2023-05-10', '2023-05-

01', '2023-05-05', '2023-05-15', '2023-05-20', 5, 5, 5),
('Cancelled', '2023-06-10', '2023-06-01', '2023-06-05', '2023-06-15', '2023-06-20', 6, 6, 6),
('Pending', '2023-07-10', '2023-07-01', '2023-07-05', '2023-07-15', '2023-07-20', 7, 7, 7),
('Completed', '2023-08-10', '2023-08-01', '2023-08-05', '2023-08-15', '2023-08-20', 8, 8, 8),
('Cancelled', '2023-09-10', '2023-09-01', '2023-09-05', '2023-09-15', '2023-09-20', 9, 9, 9),
('Pending', '2023-10-10', '2023-10-01', '2023-10-05', '2023-10-15', '2023-10-20', 10, 10, 10),
('Completed', '2023-11-10', '2023-11-01', '2023-11-05', '2023-11-15', '2023-11-20', 11, 11, 11),
('Cancelled', '2023-12-10', '2023-12-01', '2023-12-05', '2023-12-15', '2023-12-20', 12, 12, 12);
```

### 8. Inserting into the `ProductMaterials` table
```sql
INSERT INTO ProductMaterials (SKU, MaterialID) VALUES 
(10000, 1),
(10001, 2),
(10002, 3),
(10003, 4),
(10004, 5),
(10005, 6),
(10006, 7),
(10007, 8),
(10008, 9),
(10009, 10),
(10010, 11),
(10011, 12);
```

### 9. Inserting into the `OrderDetails` table
```sql
INSERT INTO OrderDetails (UnitsofProduct, OrderID, SKU) VALUES 
(5, 1, 10000),
(10, 2, 10001),
(15, 3, 10002),
(20, 4, 10003),
(25, 5, 10004),
(30, 6, 10005),
(35, 7, 10006),
(40, 8, 10007),
(45, 9, 10008),
(50, 10, 10009),
(55, 11, 10010),
(60, 12, 10011);
```

This should populate your tables with some initial data to work with. Feel free to adjust any values as needed to better fit your specific requirements.
