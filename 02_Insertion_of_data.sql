USE Online_course_platform;

INSERT INTO students VALUES
(1,'Aarav Sharma','aarav@gmail.com','Delhi','2024-01-10'),
(2,'Sneha Patel','sneha@gmail.com','Mumbai','2024-01-12'),
(3,'Raj Mehta','raj@gmail.com','Pune','2024-01-18'),
(4,'Fatima Khan','fatima@gmail.com','Kolkata','2024-02-01'),
(5,'Vikram Singh','vikram@gmail.com','Delhi','2024-02-05'),
(6,'Priya Nair','priya@gmail.com','Bangalore','2024-02-12'),
(7,'Aman Verma','aman@gmail.com','Jaipur','2024-02-20');

INSERT INTO instructors VALUES
(1,'Rahul Verma','Python'),
(2,'Neha Kapoor','Cybersecurity'),
(3,'Amit Shah','Web Development'),
(4,'Kiran Patel','Data Science');

INSERT INTO courses VALUES
(1,'Python Basics','Programming',3000,1),
(2,'Ethical Hacking','Cybersecurity',5000,2),
(3,'Web Development Bootcamp','Programming',4000,3),
(4,'Data Analysis','Data Science',4500,4),
(5,'Advanced Python','Programming',3500,1);

INSERT INTO enrollments VALUES
(1,1,1,'2024-03-01'),
(2,2,2,'2024-03-02'),
(3,3,3,'2024-03-05'),
(4,1,5,'2024-03-10'),
(5,4,4,'2024-03-12'),
(6,5,1,'2024-03-15'),
(7,6,4,'2024-03-18'),
(8,7,3,'2024-03-20');


SELECT * FROM students;
SELECT * FROM instructors;
SELECT * FROM courses;
SELECT * FROM enrollments;


