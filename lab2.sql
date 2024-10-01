CREATE DATABASE lab2;

DROP TABLE countries;

CREATE TABLE IF NOT EXISTS countries(
    country_id SERIAL PRIMARY KEY,
    country_name TEXT ,
    region_id INTEGER,
    population INTEGER
);

INSERT INTO countries(country_name, region_id, population)
VALUES ('Kazakhstan', 1 , 20600000);

INSERT INTO countries (country_id, country_name)
VALUES (2, 'Russia');

INSERT INTO countries(country_name,region_id, population)
VALUES ('USA', NULL,345900000);

INSERT INTO countries (country_name, region_id, population)
VALUES
('China', 3, 1420000000),
('South Korea', 4, 52000000),
('Japan', 5, 123000000);

ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

INSERT INTO countries (region_id, population)
VALUES (1, 20000000);

INSERT INTO countries DEFAULT VALUES;

CREATE TABLE countries_new LIKE countries WITH NO DATA;

INSERT INTO countries_new SELECT * FROM countries;

UPDATE countries_new
SET region_id = 1
WHERE region_id IS NULL;

SELECT country_name,
       population * 1.10 AS "New Population"
FROM countries;

DELETE FROM countries
WHERE population < 100000;

DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries)
RETURNING *;

WITH deleted AS (
    DELETE FROM countries
    RETURNING *
)
SELECT * FROM deleted;