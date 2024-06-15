USE CataschevasticaV2
GO

INSERT INTO Supplier (Name, Phone) VALUES 
('ABC Materials', '123-456-7890'),
('XYZ Supplies', '234-567-8901'),
('Top Steel', '344-678-9012'),
('Concrete Masters', '456-789-1123'),
('BrickWorks', '567-890-1254'),
('Insulation Experts', '679-901-2345'),
('Roofing World', '789-012-3457'),
('Metal Pros', '890-123-4568'),
('Cement Central', '901-234-5678'),
('Construction Essentials', '012-345-6789'),
('Steel Giants', '123-456-7891'),
('Urban Materials', '234-568-8901'),
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

INSERT INTO ProductionEmployee (FirstName, LastName, DepartmentID) VALUES 
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
('Bastien', 'Sturm', 'bastien.sturm@example.com', '111-223-3333', '123 Elm St', 'Grenoble', 'Rhone-Alpes', 12345, 'France', 'Alice Enterprises'),
('Leonor', 'Mendez', 'leonoer.mendez@example.com', '222-333-4464', '456 Oak St', 'Lisbon', 'Sintra', 23456, 'Portugal', 'Green Solutions'),
('Gabriele', 'Fasani', 'gabriele.fasani@example.com', '337-444-5555', '789 Pine St', 'Travestere', 'Rome', 34567, 'Italy', 'Black Industries'),
('Sonke', 'Sturm', 'sonke.storm@example.com', '444-559-6666', '321 Maple St', 'Hamburg', 'Rostock', 45678, 'Germany', 'Brown Corp'),
('Diogo', 'Paco', 'diogo.paco@example.com', '555-666-7778', '654 Cedar St', 'Faro', 'Lagos', 56789, 'Portugal', 'White Enterprises'),
('Joana', 'Clot', 'joana.clot@example.com', '666-777-8288', '987 Birch St', 'Costa Brava', 'Catalonia', 67890, 'Spain', 'Gray Industries'),
('Christos', 'Antonopoulos', 'cris.antono@example.com', '777-888-9099', '123 Makrigianni', 'Athens', 'Chaidari', 78901, 'Greece', 'Blue Corp'),
('Giannis', 'Kourouniotis', 'john.kourou@example.com', '888-999-0010', '63 Polykarpou', 'Athens', 'Peristeri', 89012, 'Greece', 'Red Enterprises'),
('Ioanna', 'Tzani', 'ioanna.tzani@example.com', '994-000-1111', '7 Troon', 'Athens', 'Ano Petralona', 90123, 'Greece', 'Yellow Solutions'),
('Milinkovic', 'Savic', 'milinkovic.savic@example.com', '005-111-2222', '321 Fir St', 'Belgrade', 'Novsad', 10112, 'Serbia', 'Purple Corp'),
('Edi', 'Seifo', 'edi.seifo@example.com', '111-222-3335', '654 Palm St', 'Tirana', 'Durcin', 11223, 'Albania', 'Pink Solutions'),
('John', 'Terry', 'John.terry@example.com', '221-333-4444', '987 Beech St', 'London', 'Shoreditch', 12334, 'United Kingdom', 'Orange Corp'),
('Claire', 'Delly', 'claire.delly@example.com', '333-443-5555', '123 Cypress St', 'Dublin', 'Cole', 13445, 'Ireland', 'Silver Enterprises'),
('Kostas', 'Varas', 'kostas.varas@example.com', '444-555-6667', '46 Ilission', 'Athens', 'Ampelokipoi', 14556, 'Greece', 'Gold Solutions'),
('Panos', 'Vasilopoulos', 'pan.vas@example.com', '552-666-7777', '78 Kiriadon', 'Athens', 'Koukaki', 15667, 'Greece', 'Platinum Corp');

INSERT INTO LogisticsPartner (Name, Phone) VALUES 
('Speedy Delivery', '111-262-3333'),
('FastTrack Logistics', '272-333-4444'),
('QuickShip', '333-444-5575'),
('Express Movers', '444-555-6266'),
('Rapid Transit', '555-666-7767'),
('NextDay Delivery', '666-777-8988'),
('Overnight Express', '777-888-9099'),
('FastLane Couriers', '888-999-0100'),
('SwiftShippers', '999-000-1110'),
('Prime Logistics', '000-111-2212'),
('EcoFreight', '111-222-3323'),
('SecureShip', '222-333-4774'),
('ProMovers', '333-444-5995'),
('Elite Transport', '444-555-6556'),
('DirectDelivery', '555-666-7667');

INSERT INTO Product (SKU, Name, Length, Width, Thickness, Weight, Colour, ComplianceStandards, Price, Quantity, EstimatedTime) VALUES 
('SKU001', 'Concrete Block', 39.0, 19.0, 19.0, 14.0, 'Gray', 'ISO 9001', 1.50, 1000, 2),
('SKU002', 'Steel Beam', 600.0, 20.0, 10.0, 50.0, 'Silver', 'ASTM A36', 45.00, 500, 2),
('SKU003', 'Roofing Tile', 30.0, 20.0, 1.0, 2.0, 'Red', 'EN 1304', 3.00, 2000, 2),
('SKU004', 'Insulation Roll', 1000.0, 50.0, 10.0, 10.0, 'White', 'ISO 14001', 25.00, 150, 2),
('SKU005', 'Cement Bag', 0.5, 0.5, 0.5, 25.0, 'Gray', 'EN 197-1', 5.00, 1000, 1),
('SKU006', 'Rebar', 600.0, 2.0, 2.0, 10.0, 'Silver', 'ASTM A615', 7.50, 300, 1),
('SKU007', 'Brick', 20.0, 10.0, 5.0, 3.0, 'Red', 'EN 771-1', 0.75, 5000, 1),
('SKU008', 'Plywood', 244.0, 122.0, 2.0, 20.0, 'Brown', 'BS 5268', 15.00, 400, 2),
('SKU009', 'Gravel', 0.0, 0.0, 0.0, 50.0, 'Gray', 'EN 12620', 2.00, 1000, 1),
('SKU010', 'Sand', 0.0, 0.0, 0.0, 50.0, 'Yellow', 'EN 13139', 1.50, 1000, 1),
('SKU011', 'Ceramic Tile', 30.0, 30.0, 0.5, 1.5, 'White', 'EN 14411', 2.50, 1500, 3),
('SKU012', 'Fiber Cement Board', 300.0, 150.0, 1.5, 10.0, 'Gray', 'ISO 8336', 18.00, 600, 2),
('SKU013', 'Aluminum Sheet', 240.0, 120.0, 0.3, 5.0, 'Silver', 'ASTM B209', 10.00, 700, 1),
('SKU014', 'Glass Pane', 200.0, 100.0, 0.5, 15.0, 'Clear', 'EN 572-1', 50.00, 200, 2),
('SKU015', 'Copper Wire', 500.0, 0.5, 0.5, 8.0, 'Copper', 'ASTM B3', 12.00, 800, 1);

INSERT INTO RawMaterial (Name, SupplierID, CostOfMaterial) VALUES 
('Cement', 1, 0.15),
('Steel', 2, 0.13),
('Clay', 3, 0.1),
('Insulation', 4, 0.1),
('Paint', 5, 0.45),
('Sand', 6, 0.08),
('Gravel', 7, 0.18),
('Lumber', 8, 0.2),
('Glass', 9, 0.21),
('Aluminum', 10, 0.4),
('Copper', 11, 0.5),
('PVC', 12, 0.8),
('Fiberglass', 13, 0.9),
('Asphalt', 14, 0.6),
('Ceramic', 15, 0.3);

/*
INSERT INTO Orders (OrderStatus, SubmittedAt, DeliveryAt, CompletedAt, CancelledAt, CustomerID, EmployeeID, DeliveryPartnerID) VALUES 
('completed', '2024-02-10 10:00:00', '2024-02-12 11:00:00', '2024-02-13 13:00:00', NULL, 15, 7, 15),
('in process', '2024-02-22 17:00:00', NULL, NULL, NULL, 3, 9, 10),
('in process', '2024-03-01 14:00:00', NULL, NULL, NULL, 3, 13, 9),
('in process', '2024-03-02 09:00:00', NULL, NULL, NULL, 6, 6, 6),
('cancelled', '2024-03-05 14:00:00', NULL, NULL, '2024-03-06 09:00:00', 4, 12, 8),
('completed', '2024-03-21 10:00:00', '2024-03-24 11:00:00', '2024-03-26 13:00:00', NULL, 15, 7, 12),
('in delivery', '2024-04-01 13:00:00', '2024-04-03 11:00:00', NULL, NULL, 7, 8, 1),
('in process', '2024-04-10 10:00:00', NULL, NULL, NULL, 9, 2, 9),
('completed', '2024-04-12 09:00:00', '2024-04-16 09:00:00', '2024-04-16 18:00:00', NULL, 12, 2, 6),
('in delivery', '2024-04-25 09:00:00', '2024-05-01 09:00:00', NULL, NULL, 2, 4, 6),
('cancelled', '2024-04-27 08:00:00', NULL, NULL, '2024-04-27 16:00:00', 8, 7, 6),
('completed', '2024-04-30 15:00:00', '2024-05-02 10:00:00', '2024-05-04 12:00:00', NULL, 5, 5, 5),
('in process', '2024-05-01 10:00:00', NULL, NULL, NULL, 1, 5, 7),
('in delivery', '2024-05-01 11:00:00', '2024-05-03 10:00:00', NULL, NULL, 3, 3, 3),
('cancelled', '2024-05-08 12:00:00', NULL, NULL, '2024-05-9 10:00:00', 10, 1, 5),
('in delivery', '2024-05-15 11:00:00', '2024-05-18 13:00:00', NULL, NULL, 11, 11, 11),
('in delivery', '2024-05-20 15:00:00', '2024-05-22 09:00:00', NULL, NULL, 14, 4, 14),
('in process', '2024-05-22 09:30:00', NULL, NULL, NULL, 4, 5, 2),
('in delivery', '2024-05-22 09:30:00', '2024-05-23 12:30:00', NULL, NULL, 3, 7, 11),
('completed', '2034-08-15 15:00:00', '2023-08-20 10:00:00', '2023-08-27 12:00:00', NULL, 6, 3, 4),
('completed', '2023-10-28 12:00:00', '2023-10-31 11:00:00', '2023-11-04 10:30:00', NULL, 11, 10, 5),
('completed', '2023-12-25 10:00:00', '2023-12-27 14:30:00', '2023-12-31 16:00:00', NULL, 9, 1, 7);

--to produce results for the daily report query
INSERT INTO Orders (OrderStatus, SubmittedAt, DeliveryAt, CompletedAt, CancelledAt, CustomerID, EmployeeID, DeliveryPartnerID) VALUES 
('completed', DATEADD(day, -4, GETDATE()), DATEADD(day, -1, GETDATE()), GETDATE(), NULL, 11, 2, 6),
('completed', DATEADD(day, -3, GETDATE()), DATEADD(day, -2, GETDATE()), GETDATE(), NULL, 15, 7, 15),
('in delivery', DATEADD(day, -2, GETDATE()), GETDATE(), NULL, NULL, 12, 9, 11),
('in delivery', DATEADD(day, -1, GETDATE()), GETDATE(), NULL, NULL, 10, 3, 8),
('cancelled', DATEADD(day, -1, GETDATE()), NULL ,NULL , GETDATE(), 1, 8, 12),
('in process', GETDATE(), NULL, NULL, NULL, 8, 7, 15);
*/

-- Insert completed or canceled orders
INSERT INTO Orders (OrderStatus, SubmittedAt, DeliveryAt, CompletedAt, CancelledAt, CustomerID, EmployeeID, DeliveryPartnerID) VALUES 
('completed', '2023-01-15 08:00:00', '2023-01-20 10:00:00', '2023-01-25 12:00:00', NULL, 1, 7, 11),
('completed', '2023-03-10 09:00:00', '2023-03-15 11:00:00', '2023-03-20 14:00:00', NULL, 12, 2, 9),
('cancelled', '2023-04-05 10:00:00', NULL, NULL, '2023-04-07 08:00:00', 8, 5, 3),
('completed', '2023-06-18 11:00:00', '2023-06-20 12:00:00', '2023-06-25 15:00:00', NULL, 4, 3, 7),
('completed', '2023-08-20 12:00:00', '2023-08-25 13:00:00', '2023-08-30 16:00:00', NULL, 5, 5, 6),
('cancelled', '2023-10-15 13:00:00', NULL, NULL, '2023-10-18 10:00:00', 15, 6, 1),
('completed', '2023-12-12 14:00:00', '2023-12-17 14:00:00', '2023-12-22 18:00:00', NULL, 2, 7, 8),
('cancelled', '2024-02-14 15:00:00', NULL, NULL, '2024-02-17 12:00:00', 9, 3, 14),
('completed', '2024-04-25 16:00:00', '2024-04-30 15:00:00', '2024-05-05 20:00:00', NULL, 5, 13, 9),
('completed', '2024-06-01 08:00:00', '2024-06-05 09:00:00', '2024-06-10 11:00:00', NULL, 4, 10, 15),
('completed', '2023-01-12 11:00:00', '2023-01-17 12:00:00', '2023-01-22 13:00:00', NULL, 11, 7, 9),
('cancelled', '2023-01-20 14:00:00', NULL, NULL, '2023-01-25 15:00:00', 2, 10, 5),
('completed', '2023-02-01 08:00:00', '2023-02-06 09:00:00', '2023-02-11 10:00:00', NULL, 12, 13, 3),
('completed', '2023-02-18 10:00:00', '2023-02-23 11:00:00', '2023-02-28 12:00:00', NULL, 4, 4, 8),
('cancelled', '2023-03-01 09:00:00', NULL, NULL, '2023-03-06 10:00:00', 15, 7, 14),
('completed', '2023-03-05 14:00:00', '2023-03-10 15:00:00', '2023-03-15 16:00:00', NULL, 6, 9, 11),
('completed', '2023-03-17 13:00:00', '2023-03-22 14:00:00', '2023-03-27 15:00:00', NULL, 3, 7, 8),
('cancelled', '2023-04-10 12:00:00', NULL, NULL, '2023-04-15 13:00:00', 2, 5, 10),
('completed', '2023-04-22 16:00:00', '2023-04-27 17:00:00', '2023-05-02 18:00:00', NULL, 9, 11, 8),
('cancelled', '2023-05-15 15:00:00', NULL, NULL, '2023-05-20 16:00:00', 10, 1, 4),
('completed', '2023-05-25 17:00:00', '2023-05-30 18:00:00', '2023-06-04 19:00:00', NULL, 11, 6, 5),
('completed', '2023-06-03 18:00:00', '2023-06-08 19:00:00', '2023-06-13 20:00:00', NULL, 6, 12, 11),
('cancelled', '2023-06-20 19:00:00', NULL, NULL, '2023-06-25 20:00:00', 9, 13, 15),
('completed', '2023-07-10 20:00:00', '2023-07-15 21:00:00', '2023-07-20 22:00:00', NULL, 4, 2, 7),
('cancelled', '2023-07-25 21:00:00', NULL, NULL, '2023-07-30 22:00:00', 2, 5, 11),
('completed', '2023-08-01 22:00:00', '2023-08-06 23:00:00', '2023-08-11 00:00:00', NULL, 6, 8, 1),
('completed', '2023-08-12 23:00:00', '2023-08-17 00:00:00', '2023-08-22 01:00:00', NULL, 15, 7, 2),
('cancelled', '2023-08-20 00:00:00', NULL, NULL, '2023-08-25 01:00:00', 8, 3, 4),
('completed', '2023-09-01 01:00:00', '2023-09-06 02:00:00', '2023-09-11 03:00:00', NULL, 9, 12, 6),
('cancelled', '2023-09-15 02:00:00', NULL, NULL, '2023-09-20 03:00:00', 3, 1, 4),
('completed', '2023-09-25 03:00:00', '2023-09-30 04:00:00', '2023-10-05 05:00:00', NULL, 11, 5, 10),
('completed', '2023-10-05 04:00:00', '2023-10-10 05:00:00', '2023-10-15 06:00:00', NULL, 15, 6, 12),
('cancelled', '2023-10-20 05:00:00', NULL, NULL, '2023-10-25 06:00:00', 3, 4, 13),
('completed', '2023-10-30 06:00:00', '2023-11-04 07:00:00', '2023-11-09 08:00:00', NULL, 4, 4, 1),
('completed', '2023-11-05 07:00:00', '2023-11-10 08:00:00', '2023-11-15 09:00:00', NULL, 2, 3, 5),
('cancelled', '2023-11-20 08:00:00', NULL, NULL, '2023-11-25 09:00:00', 6, 8, 12),
('completed', '2023-12-01 09:00:00', '2023-12-06 10:00:00', '2023-12-11 11:00:00', NULL, 7, 3, 10),
('cancelled', '2023-12-10 10:00:00', NULL, NULL, '2023-12-15 11:00:00', 3, 8, 11),
('completed', '2023-12-20 11:00:00', '2023-12-25 12:00:00', '2023-12-30 13:00:00', NULL, 15, 4, 14),
('completed', '2023-11-22 12:00:00', '2023-11-27 13:00:00', '2023-12-02 14:00:00', NULL, 14, 4, 5),
('cancelled', '2023-09-15 13:00:00', NULL, NULL, '2023-09-20 14:00:00', 4, 1, 5),
('completed', '2023-08-12 14:00:00', '2023-08-17 15:00:00', '2023-08-22 16:00:00', NULL, 14, 11, 2),
('completed', '2023-03-18 15:00:00', '2023-03-23 16:00:00', '2023-03-28 17:00:00', NULL, 4, 3, 13),
('cancelled', '2023-05-21 16:00:00', NULL, NULL, '2023-05-26 17:00:00', 14, 6, 11),
('completed', '2023-04-30 17:00:00', '2023-05-05 18:00:00', '2023-05-10 19:00:00', NULL, 5, 13, 3),
('completed', '2023-06-15 18:00:00', '2023-06-20 19:00:00', '2023-06-25 20:00:00', NULL, 6, 7, 9),
('cancelled', '2023-07-15 19:00:00', NULL, NULL, '2023-07-20 20:00:00', 7, 8, 14),
('completed', '2023-08-22 20:00:00', '2023-08-27 21:00:00', '2023-09-01 22:00:00', NULL, 2, 5, 14),
('completed', '2023-10-11 21:00:00', '2023-10-16 22:00:00', '2023-10-21 23:00:00', NULL, 14, 3, 15),
('cancelled', '2023-11-11 22:00:00', NULL, NULL, '2023-11-16 23:00:00', 8, 12, 10),
('completed', '2023-09-22 23:00:00', '2023-09-27 00:00:00', '2023-10-02 01:00:00', NULL, 11, 6, 13),
('completed', '2023-07-22 00:00:00', '2023-07-27 01:00:00', '2023-08-01 02:00:00', NULL, 2, 12, 3),
('cancelled', '2023-08-11 01:00:00', NULL, NULL, '2023-08-16 02:00:00', 15, 10, 4),
('completed', '2023-05-12 02:00:00', '2023-05-17 03:00:00', '2023-05-22 04:00:00', NULL, 5, 4, 9),
('completed', '2023-04-13 03:00:00', '2023-04-18 04:00:00', '2023-04-23 05:00:00', NULL, 3, 1, 12),
('cancelled', '2023-03-14 04:00:00', NULL, NULL, '2023-03-19 05:00:00', 15, 6, 1),
('completed', '2023-02-15 05:00:00', '2023-02-20 06:00:00', '2023-02-25 07:00:00', NULL, 2, 7, 11),
('completed', '2023-01-16 06:00:00', '2023-01-21 07:00:00', '2023-01-26 08:00:00', NULL, 11, 5, 8),
('cancelled', '2023-02-17 07:00:00', NULL, NULL, '2023-02-22 08:00:00', 9, 7, 9),
('completed', '2023-03-18 08:00:00', '2023-03-23 09:00:00', '2023-03-28 10:00:00', NULL, 6, 10, 7),
('in process', '2024-06-16 08:00:00', NULL, NULL, NULL, 5, 11, 4),
('in delivery', '2024-06-17 09:00:00', '2024-06-20 10:00:00', NULL, NULL, 12, 2, 14),
('in process', '2024-06-18 10:00:00', NULL, NULL, NULL, 1, 3, 13),
('in delivery', '2024-06-19 11:00:00', '2024-06-22 12:00:00', NULL, NULL, 14, 5, 6),
('in process', '2024-06-20 12:00:00', NULL, NULL, NULL, 4, 1, 15),
('in delivery', '2024-06-21 13:00:00', '2024-06-24 14:00:00', NULL, NULL, 7, 3, 6),
('in process', '2024-06-22 14:00:00', NULL, NULL, NULL, 2, 7, 8),
('in delivery', '2024-06-23 15:00:00', '2024-06-26 16:00:00', NULL, NULL, 15, 13, 14);



INSERT INTO ProductMaterials (SKU, MaterialID, RequiredUnitsOfRawMaterial) VALUES 
('SKU001', 1, 2),
('SKU002', 2, 3),
('SKU003', 3, 2),
('SKU004', 4, 5),
('SKU005', 1, 3),
('SKU006', 2, 5),
('SKU007', 3, 4),
('SKU008', 8, 5),
('SKU009', 7, 6),
('SKU010', 6, 5),
('SKU011', 15, 4),
('SKU012', 1, 2),
('SKU013', 10, 5),
('SKU014', 9, 3),
('SKU015', 11, 1);



-- Insert order details for the above orders
INSERT INTO OrderDetails (OrderID, SKU, UnitsofProduct, ProductionStartDate, ProductionEndDate, ProductionStatus) VALUES 
(1, 'SKU001', 150, '2023-01-16 08:00:00', '2023-01-18 10:00:00', 'completed'),
(1, 'SKU002', 100, '2023-01-16 08:00:00', '2023-01-18 10:00:00', 'completed'),
(2, 'SKU003', 200, '2023-03-11 09:00:00', '2023-03-13 11:00:00', 'completed'),
(2, 'SKU004', 75, '2023-03-11 09:00:00', '2023-03-13 11:00:00', 'completed'),
(3, 'SKU005', 150, '2023-04-06 10:00:00', '2023-04-06 12:00:00', 'completed'),
(4, 'SKU006', 250, '2023-06-19 11:00:00', '2023-06-21 12:00:00', 'completed'),
(4, 'SKU007', 120, '2023-06-19 11:00:00', '2023-06-21 12:00:00', 'completed'),
(5, 'SKU008', 300, '2023-08-21 12:00:00', '2023-08-23 13:00:00', 'completed'),
(5, 'SKU009', 200, '2023-08-21 12:00:00', '2023-08-23 13:00:00', 'completed'),
(6, 'SKU010', 150, '2023-10-16 13:00:00', '2023-10-18 12:00:00', 'completed'),
(7, 'SKU011', 450, '2023-12-13 14:00:00', '2023-12-15 14:00:00', 'completed'),
(7, 'SKU012', 200, '2023-12-13 14:00:00', '2023-12-15 14:00:00', 'completed'),
(8, 'SKU013', 100, '2024-02-15 15:00:00', '2024-02-16 17:30:00', 'completed'),
(9, 'SKU014', 300, '2024-04-26 16:00:00', '2024-04-28 15:00:00', 'completed'),
(9, 'SKU015', 150, '2024-04-26 16:00:00', '2024-04-28 15:00:00', 'completed'),
(10, 'SKU001', 200, '2024-06-02 08:00:00', '2024-06-04 09:00:00', 'completed'),
(10, 'SKU002', 100, '2024-06-02 08:00:00', '2024-06-04 09:00:00', 'completed'),
(11, 'SKU011', 110, '2023-01-13 11:00:00', '2023-01-15 11:00:00', 'completed'),
(12, 'SKU012', 120, '2023-01-21 14:00:00', '2023-01-23 11:00:00', 'completed'),
(13, 'SKU013', 130, '2023-02-02 08:00:00', '2023-02-04 08:00:00', 'completed'),
(14, 'SKU014', 140, '2023-02-19 10:00:00', '2023-02-21 10:00:00', 'completed'),
(15, 'SKU015', 150, '2023-03-02 09:00:00', '2023-03-04 12:00:00', 'completed'),
(16, 'SKU006', 160, '2023-03-06 14:00:00', '2023-03-08 14:00:00', 'completed'),
(17, 'SKU007', 170, '2023-03-18 13:00:00', '2023-03-20 13:00:00', 'completed'),
(18, 'SKU008', 180, '2023-04-11 12:00:00', '2023-04-13 14:00:00', 'completed'),
(19, 'SKU009', 190, '2023-04-23 16:00:00', '2023-04-25 16:00:00', 'completed'),
(20, 'SKU010', 200, '2023-05-16 15:00:00', '2023-05-18 16:00:00', 'completed'),
(21, 'SKU011', 210, '2023-05-26 17:00:00', '2023-05-28 17:00:00', 'completed'),
(22, 'SKU012', 220, '2023-06-04 14:00:00', '2023-06-06 18:00:00', 'completed'),
(23, 'SKU013', 230, '2023-06-21 13:00:00', '2023-06-23 13:00:00', 'completed'),
(24, 'SKU014', 240, '2023-07-11 12:00:00', '2023-07-13 10:00:00', 'completed'),
(25, 'SKU015', 250, '2023-07-26 11:00:00', '2023-07-28 11:00:00', 'completed'),
(26, 'SKU006', 260, '2023-08-02 12:00:00', '2023-08-04 11:00:00', 'completed'),
(27, 'SKU007', 270, '2023-08-13 13:00:00', '2023-08-15 12:00:00', 'completed'),
(28, 'SKU008', 280, '2023-08-21 10:00:00', '2023-08-23 11:00:00', 'completed'),
(29, 'SKU011', 290, '2023-09-02 11:00:00', '2023-09-04 11:00:00', 'completed'),
(30, 'SKU010', 300, '2023-09-16 09:00:00', '2023-09-18 10:00:00', 'completed'),
(31, 'SKU011', 310, '2023-09-26 08:00:00', '2023-09-28 08:00:00', 'completed'),
(32, 'SKU012', 320, '2023-10-06 08:00:00', '2023-10-08 09:00:00', 'completed'),
(33, 'SKU013', 330, '2023-10-21 09:00:00', '2023-10-23 09:00:00', 'completed'),
(34, 'SKU014', 340, '2023-10-31 10:00:00', '2023-11-02 13:00:00', 'completed'),
(35, 'SKU015', 350, '2023-11-06 11:00:00', '2023-11-08 08:00:00', 'completed'),
(36, 'SKU008', 360, '2023-11-21 08:00:00', '2023-11-23 12:00:00', 'completed'),
(37, 'SKU007', 370, '2023-12-02 09:00:00', '2023-12-04 09:00:00', 'completed'),
(38, 'SKU008', 380, '2023-12-11 13:00:00', '2023-12-13 15:00:00', 'completed'),
(39, 'SKU009', 390, '2023-12-21 12:00:00', '2023-12-23 11:00:00', 'completed'),
(40, 'SKU001', 400, '2023-11-23 12:00:00', '2023-11-25 12:00:00', 'completed'),
(41, 'SKU011', 410, '2023-09-16 13:00:00', '2023-09-18 10:00:00', 'completed'),
(42, 'SKU012', 420, '2023-08-13 14:00:00', '2023-08-15 14:00:00', 'completed'),
(43, 'SKU013', 430, '2023-03-19 15:00:00', '2023-03-21 15:00:00', 'completed'),
(44, 'SKU004', 440, '2023-05-22 10:00:00', '2023-05-24 12:00:00', 'completed'),
(45, 'SKU005', 450, '2023-05-01 17:00:00', '2023-05-03 17:00:00', 'completed'),
(46, 'SKU006', 460, '2023-06-16 18:00:00', '2023-06-18 18:00:00', 'completed'),
(61, 'SKU003', 150, '2024-06-17 16:00:00', NULL, 'in production'),
(61, 'SKU004', 100, '2024-06-17 08:00:00', NULL, 'in production'),
(62, 'SKU005', 250, '2024-06-18 09:00:00', '2024-06-19 11:00:00', 'completed'),
(62, 'SKU006', 200, '2024-06-18 09:00:00', '2024-06-19 13:00:00', 'completed'),
(63, 'SKU007', 100, '2024-06-19 10:00:00', NULL, 'in production'),
(63, 'SKU008', 300, '2024-06-19 10:00:00', NULL, 'in production'),
(64, 'SKU009', 200, '2024-06-20 13:00:00', '2024-06-21 18:00:00', 'completed'),
(64, 'SKU010', 150, '2024-06-20 11:00:00', '2024-06-22 09:00:00', 'completed'),
(65, 'SKU011', 450, '2024-06-21 12:00:00', NULL, 'in production'),
(65, 'SKU012', 200, '2024-06-21 14:00:00', NULL, 'in production'),
(66, 'SKU013', 300, '2024-06-22 13:00:00', '2024-06-24 12:00:00', 'completed'),
(66, 'SKU014', 150, '2024-06-22 13:00:00', '2024-06-24 10:00:00', 'completed'),
(67, 'SKU015', 200, '2024-06-23 11:00:00', NULL, 'in production'),
(67, 'SKU001', 100, '2024-06-23 14:00:00', NULL, 'in production'),
(68, 'SKU002', 300, '2024-06-24 10:00:00', '2024-06-26 13:00:00', 'completed'),
(68, 'SKU003', 200, '2024-06-24 15:00:00', '2024-06-26 15:00:00', 'completed');


SELECT * FROM OrderDetails
DELETE FROM OrderDetails
