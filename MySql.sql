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

--BASIC select queries

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


