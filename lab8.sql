CREATE TABLE salesman(
salesman_id INT PRIMARY KEY,
name VARCHAR(50),
city VARCHAR(20),
commision DECIMAL(5,2)
);

CREATE TABLE customers(
customer_id INT PRIMARY KEY,
cust_name VARCHAR(50),
city VARCHAR(20),
grade INT,
salesman_id INT REFERENCES salesman(salesman_id)
);

CREATE TABLE orders(
ord_no INT PRIMARY KEY,
purch_amt DECIMAL(10,2),
ord_date DATE,
customer_id INT REFERENCES customers(customer_id),
salesman_id INT REFERENCES salesman(salesman_id)
);

INSERT INTO salesman VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', NULL, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO customers VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', NULL, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001);

CREATE ROLE junior_dev WITH LOGIN;

CREATE VIEW salesman_NY AS 
SELECT * FROM salesman WHERE city = 'New York';

CREATE VIEW orders_view AS
SELECT o.ord_no, s.name AS salesman_name, c.cust_name AS customer_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN salesman s ON o.salesman_id = s.salesman_id;

GRANT ALL PRIVILEGES ON orders_view TO junior_dev;

CREATE VIEW highest_grade_customer AS
SELECT cust_name FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

CREATE VIEW city_salesman AS
SELECT city, COUNT(salesman_id) AS salesman_counted
FROM salesman
GROUP BY city;

CREATE VIEW top_salesman AS
SELECT s.name AS salesman_name, COUNT(c.customer_id) AS customers_counted
FROM salesman s
JOIN customers c ON c.salesman_id = s.salesman_id
GROUP BY s.name
HAVING COUNT(customer_id) > 1;

CREATE ROLE intern;
GRANT junior_dev TO intern;