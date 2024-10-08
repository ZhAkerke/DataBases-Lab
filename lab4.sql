DROP TABLE IF EXISTS warehouses;
DROP TABLE IF EXISTS boxes;

CREATE TABLE warehouses (
    code serial PRIMARY KEY,
	location VARCHAR(255),
	capacity INT
)

CREATE TABLE boxes (
    code CHAR(4),
	contents VARCHAR(255),
	value REAL,
	warehouse INT REFERENCES warehouses(code)
)

INSERT INTO warehouses (location, capacity) VALUES
('Chicago', 3),
('Chicago', 4),
('New York', 7),
('Los Angeles', 2),
('San Francisco', 8);

INSERT INTO boxes (code, contents, value, warehouse) VALUES
('0MN7', 'Rocks', 180, 3),
('4H8P', 'Rocks', 250, 1),
('4RT3', 'Scissors', 190, 4),
('7G3H', 'Rocks', 200, 1),
('8JN6', 'Papers', 75, 1),
('8Y6U', 'Papers', 50, 3),
('9J6F', 'Papers', 175, 2),
('LL08', 'Rocks', 140, 4),
('P0H6', 'Scissors', 125, 1),
('P2T6', 'Scissors', 150, 2),
('TU55', 'Papers', 90, 5);

SELECT * FROM warehouses;

SELECT * FROM boxes;

SELECT * FROM boxes WHERE value > 150;

SELECT DISTINCT contents FROM boxes;

SELECT warehouse, COUNT(*) AS box_num FROM boxes GROUP BY warehouse;

SELECT warehouse, 
COUNT(*) AS box_num 
FROM boxes 
GROUP BY warehouse
HAVING COUNT(*) > 2;

INSERT INTO warehouses (location, capacity) VALUES ('New York', 3);

INSERT INTO boxes (code, contents, value, warehouse) VALUES ('H5RT', 'Papers', 200, 2);

UPDATE boxes 
SET value = value * 0.85 
WHERE value = (SELECT value FROM boxes ORDER BY value DESC LIMIT 1 OFFSET 2);

DELETE FROM boxes WHERE value < 150;

DELETE FROM boxes WHERE warehouse IN (SELECT code FROM warehouses WHERE location = 'New York')
RETURNING *;