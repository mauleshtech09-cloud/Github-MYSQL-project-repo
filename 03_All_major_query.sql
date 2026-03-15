USE Online_course_platform;

								-- Basic query
                                
-- Query1
-- SELECT * FROM students;

-- Query2
-- SELECT * FROM students WHERE City='Delhi'; 

-- Query3
-- SELECT course_name,price FROM courses WHERE Price>3500;

-- Query4
-- SELECT course_name,price FROM courses ORDER BY Price DESC;

-- Query5
-- SELECT Name FROM students WHERE Name LIKE 'A%';


								-- Join query
                                
 -- Query6
--  SELECT s.Name AS 'Student_name',c.course_name AS 'course_name' FROM students s
--  INNER JOIN enrollments e ON e.student_id=s.student_id 
--  INNER JOIN courses c ON e.course_id=c.course_id; 

-- Query7
-- SELECT c.course_name AS 'course_name',i.instructor_name AS 'instructor_name' FROM courses c INNER JOIN instructors i ON c.instructor_id=i.instructor_id;

-- Query8
-- SELECT s.Name AS 'student_name',c.course_name AS 'course_name'FROM students s INNER JOIN enrollments e ON e.student_id=s.student_id
-- INNER JOIN courses c  ON e.course_id=c.course_id WHERE Course_name LIKE '%Python%';  
   

								-- Aggregation queries
                                
-- Query9
-- SELECT COUNT(*) AS 'Total_students' FROM students;  

-- Query10
-- SELECT AVG(Price) AS 'average_price' FROM courses;

-- Query11
-- SELECT course_name AS course ,Price AS Price FROM courses WHERE Price=(SELECT MAX(Price) FROM courses);

-- Query12
-- SELECT c.course_name AS course_name, COUNT(e.student_id) AS total_students_enrolled  FROM courses c LEFT JOIN enrollments e ON c.course_id=e.course_id GROUP BY c.course_name;

-- Query13
-- SELECT s.Name AS student_name FROM students s INNER JOIN enrollments e ON e.student_id=s.student_id
--  GROUP BY s.student_id, s.Name HAVING COUNT(course_id)>1;

-- Query14
-- SELECT c.course_name FROM courses c INNER JOIN enrollments e ON c.course_id = e.course_id GROUP BY c.course_name,c.Course_id ORDER BY COUNT(e.course_id) DESC LIMIT 1;

-- Query15
-- SELECT i.instructor_name AS instrcutor_name FROM instructors i 
-- INNER JOIN courses c ON i.instructor_id=c.instructor_id
-- GROUP BY i.instructor_id,i.instructor_name HAVING COUNT(c.course_id)>1;

-- Query16
-- SELECT SUM(c.Price) AS total_revenue
-- FROM courses c 
-- INNER JOIN enrollments e 
-- ON c.course_id=e.course_id;


-- Query17
-- CREATE VIEW expensive_courses AS 
--  SELECT course_name,Price FROM courses;


-- Query18
-- CREATE INDEX idxEmail ON students(Email);

-- Query19
-- DELIMITER $$
-- CREATE PROCEDURE Addstudent(
-- IN p_Name VARCHAR(30),
-- IN p_Email VARCHAR(30),
-- IN P_City VARCHAR(30),
-- IN p_Join_date DATE
-- )
-- BEGIN 
-- INSERT INTO students(Name,Email,City,join_date)VALUES
-- (p_Name,p_Email,p_City,p_Join_date);

-- SELECT * FROM students ; 
-- END$$

-- DELIMITER ;

-- CALL Addstudent('XYZ','XYZ@example.com','ABC','1909-08-12');

-- Query20

-- DELIMITER $$

-- CREATE TRIGGER after_course_price_updated
-- AFTER UPDATE ON courses
-- FOR EACH ROW
-- BEGIN
-- INSERT INTO course_price_log(course_id, old_price, new_price, change_time)
-- VALUES (OLD.course_id, OLD.price, NEW.price, NOW());
-- END$$


-- CREATE TRIGGER after_insertion_new_course
-- AFTER INSERT ON courses
-- FOR EACH ROW
-- BEGIN
-- INSERT INTO course_price_log(course_id, old_price, new_price, change_time)
-- VALUES (NEW.course_id, NULL, NEW.price, NOW());
-- END$$

-- DELIMITER ;