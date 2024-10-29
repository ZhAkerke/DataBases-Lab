DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;

CREATE TABLE locations (
location_id SERIAL PRIMARY KEY,
street_address VARCHAR(25),
postal_code VARCHAR(12),
city VARCHAR(30),
state_province VARCHAR(12)
)

CREATE TABLE departments (
department_id SERIAL PRIMARY KEY,
department_name VARCHAR(50) UNIQUE,
budget INTEGER,
location_id INTEGER REFERENCES locations
)

CREATE TABLE employees (
employee_id SERIAL PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(50),
phone_number VARCHAR(20),
salary INTEGER,
department_id INTEGER REFERENCES departments
)

INSERT INTO locations (street_address, postal_code, city, state_province) VALUES
('221B Baker St', 'NW1 6XE', 'London', 'ENG'),             -- Sherlock Holmes
('742 Evergreen Terrace', '97475', 'Springfield', 'IL'),    -- The Simpsons
('618 Gopher Rd', '28675', 'Gravity Falls', 'OR'),          -- Dipper & Mabel Pines
('124 Conch St', '33139', 'Bikini Bottom', 'OC'),           -- SpongeBob SquarePants
('1007 Mountain Dr', '90210', 'Gotham City', 'NY'),         -- Batman
('1938 Sullivan Lane', '99921', 'Metropolis', 'NY'),        -- Superman
('31 Spooner St', '78130', 'Quahog', 'RI'),                 -- Family Guy
('4 Privet Drive', 'UB7 0ED', 'Little Whinging', 'ENG');    -- Harry Potter

INSERT INTO departments (department_name, budget, location_id) VALUES
('Detective Agency', 100000, 1),       -- Sherlock Holmes
('Nuclear Safety', 70000, 2),         -- Homer Simpson
('Mystery Shack', 600, 3),          -- Dipper & Mabel Pines
('Krusty Krab', 5000, 4),            -- SpongeBob
('Wayne Enterprises', 1500000, 5),     -- Batman
('Daily Planet', 80000, 6),           -- Superman
('Pawtucket Brewery', 45000, 7),      -- Family Guy
('Hogwarts', 100000, 8);     -- Harry Potter

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
('Sherlock', 'Holmes', 'sherlock.holmes@detective.com', '123-456-7890', 95000, 1),
('Homer', 'Simpson', 'homer.simpson@springfield.com', '234-567-8901', 52000, 2),
('Dipper', 'Pines', 'dipper.pines@mysteryshack.com', '345-678-9012', 45000, 3),
('Mabel', 'Pines', 'mabel.pines@mysteryshack.com', '456-789-0123', 45000, 3),
('SpongeBob', 'SquarePants', 'spongebob@krustykrab.com', '567-890-1234', 30000, 4),
('Bruce', 'Wayne', 'bruce.wayne@wayneenterprises.com', '678-901-2345', 200000, 5),
('Clark', 'Kent', 'clark.kent@dailyplanet.com', '789-012-3456', 85000, 6),
('Peter', 'Griffin', 'peter.griffin@pawtucketbrewery.com', '890-123-4567', 40000, 7),
('Harry', 'Potter', 'harry.potter@hogwarts.com', '901-234-5678', 95000, 8); 

SELECT * FROM locations;

SELECT * FROM departments;

SELECT * FROM employees;

SELECT first_name, last_name, employees.department_id, departments.department_name
FROM employees
JOIN departments ON employees.department_id = departments.department_id;

SELECT first_name, last_name, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id IN (8, 4);

SELECT first_name, last_name, d.department_name, l.city, l.state_province
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;

UPDATE employees SET department_id = NULL WHERE first_name = 'Harry';

SELECT d.department_name, e.first_name, e.last_name 
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id;

SELECT first_name, last_name, e.department_id, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;