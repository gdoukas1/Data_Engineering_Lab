

INSERT INTO Orders (OrderStatus, SubmittedAt, DeliveryAt, CompletedAt, CancelledAt, CustomerID, EmployeeID, DeliveryPartnerID) VALUES 
('in process', '2024-05-27 10:00:00', NULL, NULL, NULL, 3, 7, 11),
('in delivery', '2024-05-29 12:00:00', '2024-05-29 14:00:00', NULL, NULL, 10, 6, 5),
('in process', '2024-05-30 11:00:00', NULL, NULL, NULL, 6, 6, 6),
('completed', '2024-05-31 14:00:00', '2024-06-03 15:00:00', '2024-06-07 10:00:00', NULL, 3, 3, 3),
('completed', '2024-06-02 09:30:00', '2024-05-02 11:30:00', '2024-06-06 17:00:00', NULL, 5, 4, 12),
('in delivery', '2024-06-03 17:30:00', '2024-06-04 13:00:00', NULL, NULL, 12, 4, 5),
('in process', '2024-06-04 11:00:00', NULL, NULL, NULL, 1, 5, 9),
('in delivery', '2024-06-05 08:00:00', '2024-06-05 11:30:00', NULL, NULL, 2, 8, 3),




