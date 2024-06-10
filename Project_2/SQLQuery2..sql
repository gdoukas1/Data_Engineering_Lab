

INSERT INTO Orders (OrderStatus, SubmittedAt, DeliveryAt, CompletedAt, CancelledAt, CustomerID, EmployeeID, DeliveryPartnerID) VALUES 
('in process', '2024-05-27 10:00:00', NULL, NULL, NULL, 3, 7, 11),
('in delivery', '2024-05-29 12:00:00', '2024-05-29 14:00:00', NULL, NULL, 10, 6, 5),
('in process', '2024-05-30 11:00:00', NULL, NULL, NULL, 6, 6, 6),
('completed', '2024-05-31 14:00:00', '2024-06-03 15:00:00', '2024-06-07 10:00:00', NULL, 3, 3, 3),
('completed', '2024-06-02 09:30:00', '2024-05-02 11:30:00', '2024-06-06 17:00:00', NULL, 5, 4, 12),
('in delivery', '2024-06-03 17:30:00', '2024-06-04 13:00:00', NULL, NULL, 12, 4, 5),
('in process', '2024-06-04 11:00:00', NULL, NULL, NULL, 1, 5, 9),
('in delivery', '2024-06-05 08:00:00', '2024-06-05 11:30:00', NULL, NULL, 2, 8, 3),
('cancelled', '2024-06-14 08:00:00', NULL, NULL, '2024-06-17 13:00:00', 8, 10, 11),
('completed', '2024-06-28 09:00:00', '2024-07-01 12:30:00', '2024-07-03 14:00:00', NULL, 1, 9, 9),
('in process', '2024-07-01 12:00:00', NULL, NULL, NULL, 3, 4, 11),
('in delivery', '2024-07-10 09:30:00', '2024-07-14 17:00:00', NULL, NULL, 11, 11, 10),
('completed', '2024-07-14 10:30:00', '2024-07-16 11:30:00', '2024-07-25 13:30:00', NULL, 12, 2, 5),
('in delivery', '2024-07-23 15:30:00', '2024-07-26 14:00:00', NULL, NULL, 1, 4, 11),
('completed', '2024-07-26 10:30:00', '2024-07-29 11:00:00', '2024-08-01 13:30:00', NULL, 2, 2, 3),
('in delivery', '2024-08-09 12:30:00', '2024-08-13 14:30:00', NULL, NULL, 5, 7, 8),
('in process', '2024-08-20 13:00:00', NULL, NULL, NULL, 9, 9, 9),
('cancelled', '2024-08-27 09:00:00', NULL, NULL, '2024-08-30 15:30:00', 12, 1, 11),
('in process', '2024-08-30 11:30:00', NULL, NULL, NULL, 3, 4, 6),
('completed', '2024-09-17 09:30:00', '2024-09-20 12:00:00', '2024-09-25 16:30:00', NULL, 7, 7, 7),
('in delivery', '2024-09-23 13:30:00', '2024-09-27 10:30:00', NULL, NULL, 10, 4, 8),
('completed', '2024-09-27 10:30:00', '2024-09-30 11:00:00', '2024-10-03 15:30:00', NULL, 12, 9, 1),
('cancelled', '2024-09-30 15:30:00', NULL, NULL, '2024-10-02 10:00:00', 1, 1, 3),
('in process', '2024-10-07 09:30:00', NULL, NULL, NULL, 5, 10, 8),
('in delivery', '2024-10-11 11:30:00', '2024-10-16 16:00:00', NULL, NULL, 2, 9, 6),
('in delivery', '2024-10-25 13:00:00', '2024-10-29 14:30:00', NULL, NULL, 4, 11, 7),
('completed', '2024-11-28 15:30:00', '2024-12-02 10:00:00', '2024-12-06 13:30:00', NULL, 7, 3, 12),
('cancelled', '2024-12-06 11:30:00', NULL, NULL, '2024-12-11 14:30:00', 4, 5, 8),
('in process', '2024-12-12 13:30:00', NULL, NULL, NULL, 2, 4, 11),
('cancelled', '2024-12-19 11:00:00', NULL, NULL, '2024-12-23 10:30:00', 10, 9, 3),