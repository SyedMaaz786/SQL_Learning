-- DATABASE & TABLES creation 

CREATE DATABASE IF NOT EXISTS sql_learning;
USE sql_learning;

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SHOW COLUMNS FROM students;

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