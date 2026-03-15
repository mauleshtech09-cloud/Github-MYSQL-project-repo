USE Online_course_platform;

/* -----------------------------------------------------
   1. Show student name and instructor name for each course enrollment
----------------------------------------------------- */

SELECT s.Name AS student_name,
       i.instructor_name AS instructor_name
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id
INNER JOIN instructors i ON c.instructor_id = i.instructor_id;


/* -----------------------------------------------------
   2. Show student name and the course they are enrolled in
----------------------------------------------------- */

SELECT s.Name AS student_name,
       c.course_name AS course_taken
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;


/* -----------------------------------------------------
   3. Show instructor name and total number of students taught
----------------------------------------------------- */

SELECT i.instructor_name,
       COUNT(s.student_id) AS total_students
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id
INNER JOIN instructors i ON c.instructor_id = i.instructor_id
GROUP BY i.instructor_name;


/* -----------------------------------------------------
   4. Show students who have not enrolled in any course
----------------------------------------------------- */

SELECT s.Name AS student_without_course
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id
WHERE c.course_id IS NULL;


/* -----------------------------------------------------
   5. Show all course names
----------------------------------------------------- */

SELECT c.course_name
FROM courses c;


/* -----------------------------------------------------
   6. Show course name, instructor name and total students enrolled
----------------------------------------------------- */

SELECT c.course_name,
       i.instructor_name,
       COUNT(student_id) AS total_students_enrolled
FROM courses c
INNER JOIN enrollments e ON c.course_id = e.course_id
INNER JOIN instructors i ON c.instructor_id = i.instructor_id
GROUP BY c.course_name;


/* -----------------------------------------------------
   7. Show instructors and number of courses they teach
----------------------------------------------------- */

SELECT i.instructor_name,
       COUNT(c.course_name) AS courses_teach
FROM instructors i
LEFT JOIN courses c ON i.instructor_id = c.instructor_id
GROUP BY i.instructor_id, i.instructor_name;


/* -----------------------------------------------------
   8. Show students and number of courses they enrolled in
----------------------------------------------------- */

SELECT s.Name AS student_name,
       COUNT(e.course_id) AS courses_enrolled
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.Name;


/* -----------------------------------------------------
   9. Show course name and student name for each enrollment
----------------------------------------------------- */

SELECT c.course_name,
       s.Name AS student_name
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;


/* -----------------------------------------------------
   10. Find the most expensive course
----------------------------------------------------- */

SELECT course_name
FROM courses
WHERE price = (SELECT MAX(price) FROM courses);


/* -----------------------------------------------------
   11. Show students enrolled in more than one course
----------------------------------------------------- */

SELECT Name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    GROUP BY student_id
    HAVING COUNT(student_id) > 1
);


/* -----------------------------------------------------
   12. Show courses with price higher than the average price
----------------------------------------------------- */

SELECT course_name
FROM courses
WHERE price > (SELECT AVG(price) FROM courses);


/* -----------------------------------------------------
   13. Show student who enrolled in the maximum number of courses
----------------------------------------------------- */

SELECT s.name,
       SUM(c.price) AS total_spent
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
GROUP BY s.student_id, s.name
HAVING SUM(c.price) = (
    SELECT MAX(total_spent)
    FROM (
        SELECT SUM(price) AS total_spent
        FROM enrollments e
        JOIN courses c ON e.course_id = c.course_id
        GROUP BY student_id
    ) AS temp
);


/* -----------------------------------------------------
   14. Show courses with enrollment greater than average enrollment
----------------------------------------------------- */

SELECT c.course_name,
       COUNT(e.student_id) AS total_students
FROM courses c
INNER JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.student_id) >
(
    SELECT AVG(total_count)
    FROM (
        SELECT COUNT(e.student_id) AS total_count
        FROM enrollments e
        GROUP BY course_id
    ) AS temp
);


/* -----------------------------------------------------
   15. Show instructor with the highest number of students enrolled
----------------------------------------------------- */

SELECT i.instructor_name,
       COUNT(*) AS total_enrolled
FROM instructors i
INNER JOIN courses c ON i.instructor_id = c.instructor_id
INNER JOIN enrollments e ON c.course_id = e.course_id
GROUP BY i.instructor_id, i.instructor_name
HAVING COUNT(*) = (
    SELECT MAX(total_student_enrolled)
    FROM (
        SELECT COUNT(*) AS total_student_enrolled
        FROM enrollments e
        INNER JOIN courses c ON e.course_id = c.course_id
        GROUP BY c.instructor_id
    ) AS temp
);


/* -----------------------------------------------------
   16. Show students who enrolled in more courses than the average student
----------------------------------------------------- */

SELECT s.Name AS student_name,
       COUNT(e.course_id) AS total_enrollment
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.Name
HAVING COUNT(e.course_id) >
(
    SELECT AVG(total_student_enrolled)
    FROM (
        SELECT COUNT(course_id) AS total_student_enrolled
        FROM enrollments
        GROUP BY student_id
    ) AS temp
);


/* -----------------------------------------------------
   17. Show course generating highest revenue
----------------------------------------------------- */

SELECT c.course_name,
       SUM(c.price) AS total_revenue
FROM courses c
INNER JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING SUM(c.price) = (
    SELECT MAX(total_revenue_generated)
    FROM (
        SELECT SUM(c.price) AS total_revenue_generated
        FROM courses c
        INNER JOIN enrollments e ON c.course_id = e.course_id
        GROUP BY e.course_id
    ) AS temp
);


/* -----------------------------------------------------
   18. Show instructor whose courses have highest average price
----------------------------------------------------- */

SELECT i.instructor_name,
       AVG(c.price) AS avg_price
FROM instructors i
INNER JOIN courses c ON i.instructor_id = c.instructor_id
GROUP BY i.instructor_id, i.instructor_name
HAVING AVG(c.price) = (
    SELECT MAX(total_course_price)
    FROM (
        SELECT AVG(price) AS total_course_price
        FROM courses
        GROUP BY instructor_id
    ) AS temp
);