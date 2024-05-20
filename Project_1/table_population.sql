INSERT INTO Supplier (Name, Telephone) VALUES
('Brick Masters', '555-1010'),
('Concrete Solutions', '555-2020'),
('Steel Suppliers Co.', '555-3030'),
('Roofing Pros', '555-4040'),
('Insulation Inc.', '555-5050'),
('Cement Creators', '555-6060'),
('Block Builders', '555-7070'),
('Metal Materials', '555-8080'),
('Construction Supplies', '555-9090'),
('Infrastructure Experts', '555-1001'),
('Advanced Materials', '555-2002'),
('Premium Products', '555-3003');

INSERT INTO ProductionMember (FirstName, LastName) VALUES
('John', 'Doe'),
('Jane', 'Smith'),
('Emily', 'Davis'),
('Michael', 'Brown'),
('Sarah', 'Johnson'),
('David', 'Wilson'),
('Laura', 'Moore'),
('Daniel', 'Taylor'),
('Jessica', 'Anderson'),
('James', 'Thomas'),
('Sophia', 'Jackson'),
('Oliver', 'White');

INSERT INTO Customer (FirstName, LastName, Email, Telephone, City, PostalCode, Street, CompanyName) VALUES
('Alice', 'Green', 'alice.green@buildco.com', '555-1111', 'New York', 10001, '123 Main St', 'BuildCo'),
('Bob', 'Blue', 'bob.blue@constructit.com', '555-2222', 'Los Angeles', 90001, '456 Elm St', 'ConstructIt'),
('Charlie', 'Red', 'charlie.red@developcorp.com', '555-3333', 'Chicago', 60601, '789 Oak St', 'DevelopCorp'),
('Diana', 'Yellow', 'diana.yellow@infraworks.com', '555-4444', 'Houston', 77001, '101 Pine St', 'InfraWorks'),
('Ethan', 'Purple', 'ethan.purple@buildwise.com', '555-5555', 'Phoenix', 85001, '202 Maple St', 'BuildWise'),
('Fiona', 'Orange', 'fiona.orange@probuilders.com', '555-6666', 'Philadelphia', 19101, '303 Cedar St', 'ProBuilders'),
('George', 'Gray', 'george.gray@constructpros.com', '555-7777', 'San Antonio', 78201, '404 Birch St', 'ConstructPros'),
('Hannah', 'Brown', 'hannah.brown@structura.com', '555-8888', 'San Diego', 92101, '505 Spruce St', 'Structura'),
('Ian', 'Black', 'ian.black@megaorders.com', '555-9999', 'Dallas', 75201, '606 Willow St', 'MegaOrders'),
('Jenna', 'White', 'jenna.white@constructit.com', '555-0000', 'San Jose', 95101, '707 Fir St', 'ConstructIt'),
('Kevin', 'Pink', 'kevin.pink@infraworks.com', '555-1234', 'Austin', 73301, '808 Chestnut St', 'InfraWorks'),
('Lily', 'Gold', 'lily.gold@buildwise.com', '555-2345', 'Jacksonville', 32201, '909 Ash St', 'BuildWise');


INSERT INTO LogisticPartner (Name, Telephone) VALUES
('Logistic Movers', '555-0101'),
('Rapid Delivery', '555-0202'),
('Express Logistics', '555-0303'),
('Quick Transport', '555-0404'),
('Reliable Shippers', '555-0505'),
('Speedy Freight', '555-0606'),
('Efficient Movers', '555-0707'),
('Dependable Carriers', '555-0808'),
('Secure Transport', '555-0909'),
('On-Time Delivery', '555-1010'),
('Global Logistics', '555-2020'),
('National Transport', '555-3030');


INSERT INTO Product (Name, Length, Width, Thickness, Weight, Colour, ComplianceID, Cost, Quantity, EstimatedTime, ProductStatus, MemberID) VALUES
('Red Brick', 8.0000, 4.0000, 2.5000, 3.5000, 'Red', 'COMPLY-001', 0.50, 1000, 5, 'In Production', 1),
('Concrete Block', 16.0000, 8.0000, 4.0000, 20.0000, 'Gray', 'COMPLY-002', 1.00, 500, 7, 'In Production', 2),
('Steel Beam', 240.0000, 8.0000, 8.0000, 150.0000, 'Silver', 'COMPLY-003', 150.00, 50, 10, 'In Production', 3),
('Roof Tile', 12.0000, 6.0000, 0.5000, 2.0000, 'Red', 'COMPLY-004', 2.00, 1000, 3, 'In Production', 4),
('Insulation Panel', 96.0000, 48.0000, 2.0000, 10.0000, 'White', 'COMPLY-005', 20.00, 200, 5, 'In Production', 5),
('Cement Bag', 18.0000, 12.0000, 4.0000, 50.0000, 'Gray', 'COMPLY-006', 10.00, 300, 2, 'In Production', 6),
('Gypsum Board', 96.0000, 48.0000, 0.5000, 40.0000, 'White', 'COMPLY-007', 15.00, 150, 6, 'In Production', 7),
('Rebar', 240.0000, 1.0000, 1.0000, 10.0000, 'Steel', 'COMPLY-008', 5.00, 200, 8, 'In Production', 8),
('Concrete Mix', 12.0000, 12.0000, 4.0000, 80.0000, 'Gray', 'COMPLY-009', 12.00, 500, 4, 'In Production', 9),
('Plywood Sheet', 96.0000, 48.0000, 0.7500, 60.0000, 'Brown', 'COMPLY-010', 25.00, 100, 5, 'In Production', 10),
('Granite Slab', 96.0000, 24.0000, 1.2500, 200.0000, 'Black', 'COMPLY-011', 300.00, 30, 15, 'In Production', 11),
('Aluminum Sheet', 96.0000, 48.0000, 0.1250, 20.0000, 'Silver', 'COMPLY-012', 50.00, 70, 5, 'In Production', 12);


INSERT INTO RawMaterial (Name, SupplierID) VALUES
('Clay', 1),
('Cement', 2),
('Steel', 3),
('Roofing Material', 4),
('Insulation', 5),
('Concrete', 6),
('Gypsum', 7),
('Iron', 8),
('Gravel', 9),
('Wood', 10),
('Stone', 11),
('Aluminum', 12);


INSERT INTO Orders (OrderStatus, CompletedAt, SubmittedAt, AssignedAt, DeliveryAt, CancelledAt, CustomerID, MemberID, PartnerID) VALUES
('Completed', '2024-01-10 12:00:00', '2024-01-01 09:00:00', '2024-01-02 10:00:00', '2024-01-09 11:00:00', '2024-01-10 08:00:00', 1, 1, 1),
('Pending', '2024-02-10 12:00:00', '2024-02-01 09:00:00', '2024-02-02 10:00:00', '2024-02-09 11:00:00', '2024-02-10 08:00:00', 2, 2, 2),
('Completed', '2024-03-10 12:00:00', '2024-03-01 09:00:00', '2024-03-02 10:00:00', '2024-03-09 11:00:00', '2024-03-10 08:00:00', 3, 3, 3),
('Pending', '2024-04-10 12:00:00', '2024-04-01 09:00:00', '2024-04-02 10:00:00', '2024-04-09 11:00:00', '2024-04-10 08:00:00', 4, 4, 4),
('Completed', '2024-05-10 12:00:00', '2024-05-01 09:00:00', '2024-05-02 10:00:00', '2024-05-09 11:00:00', '2024-05-10 08:00:00', 5, 5, 5),
('Pending', '2024-06-10 12:00:00', '2024-06-01 09:00:00', '2024-06-02 10:00:00', '2024-06-09 11:00:00', '2024-06-10 08:00:00', 6, 6, 6),
('Completed', '2024-07-10 12:00:00', '2024-07-01 09:00:00', '2024-07-02 10:00:00', '2024-07-09 11:00:00', '2024-07-10 08:00:00', 7, 7, 7),
('Pending', '2024-08-10 12:00:00', '2024-08-01 09:00:00', '2024-08-02 10:00:00', '2024-08-09 11:00:00', '2024-08-10 08:00:00', 8, 8, 8),
('Completed', '2024-09-10 12:00:00', '2024-09-01 09:00:00', '2024-09-02 10:00:00', '2024-09-09 11:00:00', '2024-09-10 08:00:00', 9, 9, 9),
('Pending', '2024-10-10 12:00:00', '2024-10-01 09:00:00', '2024-10-02 10:00:00', '2024-10-09 11:00:00', '2024-10-10 08:00:00', 10, 10, 10),
('Completed', '2024-11-10 12:00:00', '2024-11-01 09:00:00', '2024-11-02 10:00:00', '2024-11-09 11:00:00', '2024-11-10 08:00:00', 11, 11, 11),
('Pending', '2024-12-10 12:00:00', '2024-12-01 09:00:00', '2024-12-02 10:00:00', '2024-12-09 11:00:00', '2024-12-10 08:00:00', 12, 12, 12);


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


INSERT INTO OrderDetails (UnitsofProduct, OrderID, SKU) VALUES
(100, 1, 10000),
(200, 2, 10001),
(300, 3, 10002),
(400, 4, 10003),
(500, 5, 10004),
(600, 6, 10005),
(700, 7, 10006),
(800, 8, 10007),
(900, 9, 10008),
(1000, 10, 10009),
(1100, 11, 10010),
(1200, 12, 10011);

