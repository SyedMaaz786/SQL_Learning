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


-- UPDATE queries
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

DELETE FROM students;


-- ALTER TABLE queries
ALTER TABLE students
ADD phone VARCHAR(15);

ALTER TABLE students
MODIFY phone VARCHAR(20);

ALTER TABLE students
RENAME COLUMN phone TO mobile;

ALTER TABLE students
DROP COLUMN mobile;

-- TRUNCATE TABLE queries(removes all data but keeps the table structure)
TRUNCATE TABLE students;
