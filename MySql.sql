-- DATABASE creation queries

CREATE DATABASE IF NOT EXISTS sql_learning;
USE sql_learning;

-- TABLE creation queries

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SHOW COLUMNS FROM students;

--DROP TABLE queries
DROP TABLE IF EXISTS students;

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    fee DECIMAL(8,2)
);

SHOW COLUMNS FROM courses;

CREATE TABLE enrollments (
    enroll_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enroll_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

SHOW COLUMNS FROM enrollments;

SHOW TABLES;

SHOW DATABASES;

-- INSERTING DATA queries

INSERT INTO students (name, age, email, city)
VALUES
('Maaz', 22, 'maaz@gmail.com', 'Hyderabad'),
('Irfan', 23, 'irfan@gmail.com', 'Delhi'),
('Rizwan', 21, 'rizwan@gmail.com', 'Mumbai');

SELECT * FROM students;

INSERT INTO courses (course_name, fee)
VALUES
('Python', 5000),
('Data Science', 12000),
('Web Development', 8000);

SELECT * FROM courses;

INSERT INTO enrollments (student_id, course_id, enroll_date)
VALUES
(1, 1, '2024-01-10'),
(1, 2, '2024-02-15'),
(2, 1, '2024-01-20');

SELECT * FROM enrollments

-- SELECT queries

SELECT * FROM students;
SELECT name, city FROM students;
SELECT DISTINCT city FROM students;

-- WHERE clause queries(conditions

SELECT * 
FROM students
WHERE city = 'Hyderabad'
  AND age >= 22;

SELECT *
FROM students
WHERE city = 'Hyderabad'
   OR age >= 22;

SELECT *
FROM students
WHERE city NOT IN ('Delhi', 'Mumbai');

SELECT *
FROM students
WHERE age > 21
  AND city IN ('Delhi', 'Mumbai');

SELECT *
FROM students
WHERE age > 21
   OR city IN ('Delhi', 'Mumbai');

SELECT *
FROM students
WHERE age > 21
  AND city NOT IN ('Delhi', 'Mumbai');

SELECT *
FROM students
WHERE age < 18
   OR city NOT IN ('Delhi', 'Mumbai');

--LIMIT and ORDER BY clause queries

SELECT * FROM students LIMIT 2;
SELECT * FROM students ORDER BY age DESC;
SELECT * FROM students ORDER BY age ASC;

--AGGREGATE functions queries

SELECT COUNT(*) FROM students;
SELECT AVG(age) FROM students;
SELECT MAX(fee) FROM courses;
SELECT SUM(fee) FROM courses;

--GROUP BY and HAVING clause queries(we genereally use group by with aggregate functions and having can be used only with group by)

SELECT city, COUNT(*) AS total_students
FROM students
GROUP BY city;

SELECT city, COUNT(*)
FROM students
GROUP BY city
HAVING COUNT(*) > 1;


-- UPDATE queries(use - SET SQL_SAFE_UPDATES = 0; to allow updates)
UPDATE students
SET city = 'Bangalore',
WHERE id = 1;

UPDATE students
SET age = 23,
    city = 'Hyderabad'
WHERE name = 'Maaz';

-- DELETE queries
DELETE FROM students
WHERE id = 5;

DELETE FROM students
WHERE age < 18;

DELETE FROM students;  --(Deletes all records)


-- ALTER TABLE queries
ALTER TABLE students
ADD phone VARCHAR(15);

ALTER TABLE students
CHANGE name full_name VARCHAR(150); --(for change we need to specify the datatype and constraints again)

ALTER TABLE students
MODIFY phone VARCHAR(20);

ALTER TABLE students
RENAME COLUMN phone TO mobile;

ALTER TABLE students
DROP COLUMN mobile;

-- TRUNCATE TABLE queries(removes all data but keeps the table structure)
TRUNCATE TABLE students;


--TRANSACTIONS queries(advanced topic).

SELECT @@autocommit; --(to check the current auto commit status)

SET autocommit = 0; --(to disable auto commit)

CREATE DATABASE IF NOT EXISTS bank;
USE bank;

SHOW DATABASES;
--(auto increment creates unique value for each new record)
CREATE TABLE accounts (
    id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(50),
    balance DECIMAL(10, 2)
);
ALTER TABLE accounts
ADD branch VARCHAR(50);

UPDATE accounts
SET branch = 'BLR'
WHERE name = "Syed";

UPDATE accounts
SET branch = 'BOM'
WHERE name = 'Maaz';

UPDATE accounts 
SET branch = 'DEL'
WHERE name = 'Khan';

INSERT INTO accounts (name, balance) 
VALUES
('Syed', 500.00),
('Maaz', 300.00),
('Khan', 1000.00)

SELECT * FROM accounts;

--(commit)
START TRANSACTION;
UPDATE accounts SET balance = balance - 50 WHERE id = 1;
UPDATE accounts SET balance = balance - 50 WHERE id = 2;
COMMIT;

--(rollback)
START TRANSACTION;
UPDATE accounts SET balance = balance - 50 WHERE id = 1;
COMMIT;
UPDATE accounts SET balance = balance - 50 WHERE id = 2;
ROLLBACK;

--(savepoint)
START TRANSACTION;
UPDATE accounts SET balance = balance + 1000 WHERE id = 1;
SAVEPOINT after_wallet_topup;
UPDATE accounts SET balance = balance + 10 WHERE id = 1;
ROLLBACK TO after_wallet_topup;
COMMIT;

--JOIN queries(advanced topic)

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Syed', 'Mumbai'),
(2, 'Maaz', 'Delhi'),
(3, 'Khan', 'Bangalore'),
(4, 'Pathan', 'Mumbai');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount INT
);

INSERT INTO orders VALUES
(101, 1, 500),
(102, 1, 300),
(103, 2, 200),
(104, 5, 700);

SELECT * FROM customers
SELECT * FROM orders

--INNER JOIN(ignores non matching records meaning if we have any NAN values it will not be shown in the result)

SELECT *
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

--LEFT JOIN

SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id;

--RIGHT JOIN

SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.customer_id = o.customer_id;

--OUTER JOIN(In mysql we can perform outer join by using union of left and right join)

SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
UNION
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.customer_id = o.customer_id;

--CROSS JOIN(means cartesian product, it will combine each row of first table with all rows of second table)

SELECT *
FROM customers
CROSS JOIN orders;


--SELF JOIN(means joining the table with itself)

SELECT *
FROM customers AS o
JOIN customers AS c
ON c.customer_id = o.customer_id;

--LEFT EXCLUSIVE JOINS(Here we want to print the null values of right table)

SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

--RIGHT EXCLUSIVE JOIN(Here we want to print the null values of left table)

SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

--Nested Queries

SELECT *
FROM orders
WHERE amount > (
    SELECT AVG(amount)
    FROM orders
);

-- VIEWS(here we create a virtual table with only required columns we need)

CREATE VIEW view1 AS
SELECT customer_id, name FROM customers;

SELECT * FROM view1;

--INDEXES(Indexes are used to speed up the retrieval of data from a table)

SELECT * FROM accounts;
--(Here we have make index on single col)
CREATE INDEX idx1 ON accounts(branch);
SHOW INDEX FROM accounts;


--(Here we have made index on multile col)
CREATE INDEX idx2 ON accounts(branch, balance);
SHOW INDEX FROM accounts;

DROP INDEX idx2 ON accounts:
