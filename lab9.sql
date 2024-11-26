CREATE OR REPLACE FUNCTION increase_value(input_value INTEGER)
RETURNS INTEGER AS $$
BEGIN
    RETURN input_value + 10;
END;
$$ LANGUAGE plpgsql;

SELECT increase_value(5);

CREATE OR REPLACE FUNCTION compare_numbers(a INTEGER, b INTEGER)
RETURNS TEXT AS $$
BEGIN
    IF a > b THEN
        RETURN 'Greater';
    ELSIF a = b THEN
        RETURN 'Equal';
    ELSE
        RETURN 'Lesser';
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT compare_numbers(10, 20);

CREATE OR REPLACE FUNCTION number_series(n INTEGER)
RETURNS TABLE(series INTEGER) AS $$
BEGIN
    RETURN QUERY 
    SELECT generate_series(1, n);
END;
$$ LANGUAGE plpgsql;

SELECT * FROM number_series(5);

CREATE OR REPLACE FUNCTION find_employee(emp_name TEXT)
RETURNS TABLE(emp_id INTEGER, emp_name TEXT, emp_salary NUMERIC) AS $$
BEGIN
    RETURN QUERY 
    SELECT id, name, salary 
    FROM employees 
    WHERE name = emp_name;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM find_employee('John Doe');

CREATE OR REPLACE FUNCTION list_products(category_name TEXT)
RETURNS TABLE(product_id INTEGER, product_name TEXT, category TEXT) AS $$
BEGIN
    RETURN QUERY 
    SELECT id, name, category 
    FROM products 
    WHERE category = category_name;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM list_products('Electronics');

CREATE OR REPLACE FUNCTION calculate_bonus(emp_id INTEGER)
RETURNS NUMERIC AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    SELECT salary * 0.1 INTO bonus 
    FROM employees 
    WHERE id = emp_id;
    RETURN bonus;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_salary(emp_id INTEGER)
RETURNS VOID AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    bonus := calculate_bonus(emp_id);
    UPDATE employees 
    SET salary = salary + bonus 
    WHERE id = emp_id;
END;
$$ LANGUAGE plpgsql;

SELECT calculate_bonus(1);
CALL update_salary(1);
SELECT * FROM employees WHERE id = 1;

CREATE OR REPLACE FUNCTION complex_calculation(num INTEGER, text_value VARCHAR)
RETURNS TEXT AS $$
DECLARE
    num_result INTEGER;
    text_result VARCHAR;
BEGIN
    DECLARE
        doubled_num INTEGER;
    BEGIN
        doubled_num := num * 2;
        num_result := doubled_num + 10;
    END;

    DECLARE
        reversed_text VARCHAR;
    BEGIN
        reversed_text := reverse(text_value);
        text_result := 'Reversed: ' || reversed_text;
    END;

    RETURN 'Number Result: ' || num_result || ', ' || text_result;
END;
$$ LANGUAGE plpgsql;

SELECT complex_calculation(5, 'Hello World');