INSERT INTO clinics VALUES
('c1','City Clinic','Vizag','AP','India'),
('c2','Health Plus','Hyderabad','Telangana','India'),
('c3','Care Clinic','Chennai','TN','India');

INSERT INTO customers VALUES
('u1','Ravi','9000000001'),
('u2','Sita','9000000002'),
('u3','Arjun','9000000003');

INSERT INTO clinic_sales VALUES
('o1','u1','c1',5000,'2021-10-10 10:00:00','online'),
('o2','u2','c1',7000,'2021-10-15 11:00:00','offline'),
('o3','u1','c2',8000,'2021-11-05 09:00:00','online'),
('o4','u3','c2',6000,'2021-11-10 14:00:00','offline'),
('o5','u2','c3',9000,'2021-11-20 16:00:00','online');

INSERT INTO expenses VALUES
('e1','c1','maintenance',2000,'2021-10-12'),
('e2','c2','salary',3000,'2021-11-08'),
('e3','c3','equipment',4000,'2021-11-22');

