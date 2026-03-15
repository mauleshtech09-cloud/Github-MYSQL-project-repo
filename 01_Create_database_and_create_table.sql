CREATE DATABASE Online_course_platform;

USE Online_course_platform;

CREATE TABLE students(
	student_id INT PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Email VARCHAR(50) NOT NULL UNIQUE,
    City VARCHAR(30),
    Join_date DATE
);

CREATE TABLE instructors
(
	instructor_id INT PRIMARY KEY,
    instructor_name VARCHAR(30) NOT NULL,
    Expertise VARCHAR(30) NOT NULL
);

CREATE TABLE courses
(
	Course_id INT PRIMARY KEY,
    Course_name VARCHAR(30) NOT NULL,
    Category VARCHAR(30) NOT NULL,
    Price INT NOT NULL,
    instructor_id INT,
    
    CONSTRAINT fk_instructid FOREIGN KEY(instructor_id)
    REFERENCES instructors(instructor_id)
);

CREATE TABLE enrollments
(
	enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    
    CONSTRAINT fk_studid FOREIGN KEY(student_id)REFERENCES students(student_id),
    CONSTRAINT fk_courseid FOREIGN KEY(course_id)REFERENCES courses(course_id)
);