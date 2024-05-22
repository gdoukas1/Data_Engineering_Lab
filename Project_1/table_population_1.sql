INSERT INTO Supplier (Name, Phone) VALUES 
('ABC Materials', '123-456-7890'),
('XYZ Supplies', '234-567-8901'),
('Top Steel', '345-678-9012'),
('Concrete Masters', '456-789-0123'),
('BrickWorks', '567-890-1234'),
('Insulation Experts', '678-901-2345'),
('Roofing World', '789-012-3456'),
('Metal Pros', '890-123-4567'),
('Cement Central', '901-234-5678'),
('Construction Essentials', '012-345-6789'),
('Steel Giants', '123-456-7890'),
('Urban Materials', '234-567-8901'),
('Prime Raw', '345-678-9012'),
('Building Blocks Co.', '456-789-0123'),
('Quality Materials', '567-890-1234');

INSERT INTO Department (Name) VALUES 
('Production'),
('Sales'),
('Logistics'),
('Accounting'),
('Research & Development'),
('IT'),
('Quality Control'),
('Marketing'),
('Security'),
('Legal');

INSERT INTO Employee (FirstName, LastName, DepartmentID) VALUES 
('John', 'Doe', 1),
('Jane', 'Smith', 1),
('James', 'Johnson', 1),
('Emily', 'Brown', 1),
('Michael', 'Davis', 1),
('Sarah', 'Miller', 1),
('David', 'Wilson', 1),
('Laura', 'Moore', 1),
('Daniel', 'Taylor', 1),
('Lisa', 'Anderson', 1),
('Paul', 'McArthur', 1),
('Anna', 'Jackson', 1),
('Mark', 'White', 1);

INSERT INTO Customer (FirstName, LastName, Email, Phone, Address, City, Region, PostalCode, Country, CompanyName) VALUES 
('Alice', 'Wright', 'alice.wright@example.com', '111-222-3333', '123 Elm St', 'Metropolis', 'Region1', 12345, 'CountryA', 'Alice Enterprises'),
('Bob', 'Green', 'bob.green@example.com', '222-333-4444', '456 Oak St', 'Gotham', 'Region2', 23456, 'CountryB', 'Green Solutions'),
('Charlie', 'Black', 'charlie.black@example.com', '333-444-5555', '789 Pine St', 'Star City', 'Region3', 34567, 'CountryC', 'Black Industries'),
('Diana', 'Brown', 'diana.brown@example.com', '444-555-6666', '321 Maple St', 'Central City', 'Region4', 45678, 'CountryD', 'Brown Corp'),
('Eve', 'White', 'eve.white@example.com', '555-666-7777', '654 Cedar St', 'Smallville', 'Region5', 56789, 'CountryE', 'White Enterprises'),
('Frank', 'Gray', 'frank.gray@example.com', '666-777-8888', '987 Birch St', 'Hill Valley', 'Region6', 67890, 'CountryF', 'Gray Industries'),
('Grace', 'Blue', 'grace.blue@example.com', '777-888-9999', '123 Spruce St', 'Sunnydale', 'Region7', 78901, 'CountryG', 'Blue Corp'),
('Henry', 'Red', 'henry.red@example.com', '888-999-0000', '456 Redwood St', 'Raccoon City', 'Region8', 89012, 'CountryH', 'Red Enterprises'),
('Ivy', 'Yellow', 'ivy.yellow@example.com', '999-000-1111', '789 Aspen St', 'Mystic Falls', 'Region9', 90123, 'CountryI', 'Yellow Solutions'),
('Jack', 'Purple', 'jack.purple@example.com', '000-111-2222', '321 Fir St', 'Hogsmeade', 'Region10', 10112, 'CountryJ', 'Purple Corp'),
('Kara', 'Pink', 'kara.pink@example.com', '111-222-3333', '654 Palm St', 'Springfield', 'Region11', 11223, 'CountryK', 'Pink Solutions'),
('Liam', 'Orange', 'liam.orange@example.com', '222-333-4444', '987 Beech St', 'Shelbyville', 'Region12', 12334, 'CountryL', 'Orange Corp'),
('Mia', 'Silver', 'mia.silver@example.com', '333-444-5555', '123 Cypress St', 'Atlantis', 'Region13', 13445, 'CountryM', 'Silver Enterprises'),
('Noah', 'Gold', 'noah.gold@example.com', '444-555-6666', '456 Dogwood St', 'Emerald City', 'Region14', 14556, 'CountryN', 'Gold Solutions'),
('Olivia', 'Platinum', 'olivia.platinum@example.com', '555-666-7777', '789 Alder St', 'Metropolis', 'Region1', 15667, 'CountryO', 'Platinum Corp');

INSERT INTO LogisticsPartner (Name, Phone) VALUES 
('Speedy Delivery', '111-222-3333'),
('FastTrack Logistics', '222-333-4444'),
('QuickShip', '333-444-5555'),
('Express Movers', '444-555-6666'),
('Rapid Transit', '555-666-7777'),
('NextDay Delivery', '666-777-8888'),
('Overnight Express', '777-888-9999'),
('FastLane Couriers', '888-999-0000'),
('SwiftShippers', '999-000-1111'),
('Prime Logistics', '000-111-2222'),
('EcoFreight', '111-222-3333'),
('SecureShip', '222-333-4444'),
('ProMovers', '333-444-5555'),
('Elite Transport', '444-555-6666'),
('DirectDelivery', '555-666-7777');

INSERT INTO Product (SKU, Name, Length, Width, Thickness, Weight, Colour, ComplianceStandards, CostPerUnit, Quantity, EstimatedTime, ProductStatus, ProductionMemberID) VALUES 
('SKU001', 'Concrete Block', 39.0, 19.0, 19.0, 14.0, 'Gray', 'ISO 9001', 1.50, 1000, 3, 'in production', 1),
('SKU002', 'Steel Beam', 600.0, 20.0, 10.0, 50.0, 'Silver', 'ASTM A36', 45.00, 500, 7, 'ready', 2),
('SKU003', 'Roofing Tile', 30.0, 20.0, 1.0, 2.0, 'Red', 'EN 1304', 3.00, 2000, 5, 'available', 3),
('SKU004', 'Insulation Roll', 1000.0, 50.0, 10.0, 10.0, 'White', 'ISO 14001', 25.00, 150, 4, 'in production', 4),
('SKU005', 'Cement Bag', 0.5, 0.5, 0.5, 25.0, 'Gray', 'EN 197-1', 5.00, 1000, 2, 'available', 1),
('SKU006', 'Rebar', 600.0, 2.0, 2.0, 10.0, 'Silver', 'ASTM A615', 7.50, 300, 5, 'in production', 2),
('SKU007', 'Brick', 20.0, 10.0, 5.0, 3.0, 'Red', 'EN 771-1', 0.75, 5000, 2, 'ready', 3),
('SKU008', 'Plywood', 244.0, 122.0, 2.0, 20.0, 'Brown', 'BS 5268', 15.00, 400, 3, 'available', 4),
('SKU009', 'Gravel', 0.0, 0.0, 0.0, 50.0, 'Gray', 'EN 12620', 2.00, 1000, 1, 'in production', 1),
('SKU010', 'Sand', 0.0, 0.0, 0.0, 50.0, 'Yellow', 'EN 13139', 1.50, 1000, 1, 'in production', 2),
('SKU011', 'Ceramic Tile', 30.0, 30.0, 0.5, 1.5, 'White', 'EN 14411', 2.50, 1500, 3, 'ready', 3),
('SKU012', 'Fiber Cement Board', 300.0, 150.0, 1.5, 10.0, 'Gray', 'ISO 8336', 18.00, 600, 6, 'available', 4),
('SKU013', 'Aluminum Sheet', 240.0, 120.0, 0.3, 5.0, 'Silver', 'ASTM B209', 10.00, 700, 4, 'in production', 1),
('SKU014', 'Glass Pane', 200.0, 100.0, 0.5, 15.0, 'Clear', 'EN 572-1', 50.00, 200, 10, 'ready', 2),
('SKU015', 'Copper Wire', 500.0, 0.5, 0.5, 8.0, 'Copper', 'ASTM B3', 12.00, 800, 3, 'available', 3);

INSERT INTO RawMaterial (Name, SupplierID) VALUES 
('Cement', 1),
('Steel', 2),
('Clay', 3),
('Insulation', 4),
('Paint', 5),
('Sand', 6),
('Gravel', 7),
('Lumber', 8),
('Glass', 9),
('Aluminum', 10),
('Copper', 11),
('PVC', 12),
('Fiberglass', 13),
('Asphalt', 14),
('Ceramic', 15);

INSERT INTO Orders (OrderStatus, SubmittedAt, DeliveryAt, CompletedAt, CancelledAt, CustomerID, EmployeeID, DeliveryPartnerID) VALUES 
('in process', '2024-05-01 10:00:00', NULL, NULL, NULL, 1, 5, 7),
('completed', '2024-04-25 09:00:00', '2024-05-01 09:00:00', '2024-05-02 10:00:00', NULL, 2, 4, 6),
('in delivery', '2024-05-01 11:00:00', '2024-05-03 10:00:00', NULL, NULL, 3, 3, 3),
('cancelled', '2024-05-02 14:00:00', NULL, NULL, '2024-05-03 09:00:00', 4, 12, 8),
('completed', '2024-04-30 15:00:00', '2024-05-05 10:00:00', '2024-05-06 12:00:00', NULL, 5, 5, 5),
('in process', '2024-05-02 09:00:00', NULL, NULL, NULL, 6, 6, 6),
('in delivery', '2024-05-01 13:00:00', '2024-05-04 11:00:00', NULL, NULL, 7, 8, 1),
('completed', '2024-04-27 08:00:00', '2024-05-02 10:00:00', '2024-05-03 14:00:00', NULL, 8, 7, 6),
('in process', '2024-05-03 10:00:00', NULL, NULL, NULL, 9, 2, 9),
('cancelled', '2024-05-01 12:00:00', NULL, NULL, '2024-05-02 09:00:00', 10, 1, 5),
('in delivery', '2024-05-02 11:00:00', '2024-05-05 13:00:00', NULL, NULL, 11, 11, 11),
('completed', '2024-04-29 09:00:00', '2024-05-03 10:00:00', '2024-05-04 11:00:00', NULL, 12, 2, 6),
('in process', '2024-05-01 14:00:00', NULL, NULL, NULL, 3, 13, 9),
('in delivery', '2024-05-02 15:00:00', '2024-05-06 09:00:00', NULL, NULL, 14, 4, 14),
('completed', '2024-04-30 10:00:00', '2024-05-04 11:00:00', '2024-05-05 13:00:00', NULL, 15, 7, 15);
INSERT INTO Orders (OrderStatus, SubmittedAt, DeliveryAt, CompletedAt, CancelledAt, CustomerID, EmployeeID, DeliveryPartnerID) VALUES ('completed', '2024-05-21 10:00:00', '2024-05-24 11:00:00', '2024-05-26 13:00:00', NULL, 15, 7, 15);
INSERT INTO Orders (OrderStatus, SubmittedAt, DeliveryAt, CompletedAt, CancelledAt, CustomerID, EmployeeID, DeliveryPartnerID) VALUES ('completed', '2024-05-22 17:00:00', '2024-05-24 11:00:00', '2024-05-26 13:00:00', NULL, 3, 9, 10);

INSERT INTO ProductMaterials (SKU, MaterialID) VALUES 
('SKU001', 1),
('SKU002', 2),
('SKU003', 3),
('SKU004', 4),
('SKU005', 1),
('SKU006', 2),
('SKU007', 3),
('SKU008', 8),
('SKU009', 7),
('SKU010', 6),
('SKU011', 15),
('SKU012', 1),
('SKU013', 10),
('SKU014', 9),
('SKU015', 11);

INSERT INTO OrderDetails (OrderID, SKU, UnitsofProduct) VALUES 
(1, 'SKU001', 100),
(1, 'SKU002', 50),
(2, 'SKU003', 200),
(2, 'SKU004', 75),
(3, 'SKU005', 150),
(3, 'SKU006', 100),
(4, 'SKU007', 250),
(4, 'SKU008', 120),
(5, 'SKU009', 300),
(5, 'SKU010', 200),
(6, 'SKU011', 400),
(6, 'SKU012', 150),
(7, 'SKU013', 50),
(7, 'SKU014', 100),
(8, 'SKU015', 70);
INSERT INTO OrderDetails (OrderID, SKU, UnitsofProduct) VALUES (13, 'SKU001', 50);
INSERT INTO OrderDetails (OrderID, SKU, UnitsofProduct) VALUES (16, 'SKU015', 50);
INSERT INTO OrderDetails (OrderID, SKU, UnitsofProduct) VALUES (17, 'SKU004', 40);
INSERT INTO OrderDetails (OrderID, SKU, UnitsofProduct) VALUES (10, 'SKU004', 40);