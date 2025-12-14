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




SHOW TABLES;


SHOW DATABASES;