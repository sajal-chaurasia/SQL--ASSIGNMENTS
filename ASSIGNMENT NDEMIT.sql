select 'hello sql' as message;
    ------Assignments FOR UNIVERSITY DATABASE-------

CREATE TABLE STUDENTS(
STUDENTID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Email VARCHAR(100),
BirthDate DATE,
EnrollmentDate DATE);
SELECT * FROM STUDENTS;

INSERT INTO Students
(Studentid , FirstName, LastName, Email, BirthDate, EnrollmentDate)
values 
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-01-08'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01');
select * from students; 

(2)----DEPARTMENTS TABLE------

CREATE TABLE DEPARTMENTS(
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(100));
SELECT * FROM DEPARTMENTS;

INSERT INTO Departments
(DepartmentID, DepartmentName)
VALUES
(1, 'Computer Science'),
(2, 'Mathematics');
select * from departments;

(3)----COURSES TABLE----

CREATE TABLE COURSES(
CourseID INT PRIMARY KEY,
CourseName VARCHAR(100),
DepartmentID INT REFERENCES
Departments(DepartmentID),
Credits INT);
SELECT * FROM COURSES;


INSERT INTO COURSES
(CourseID, CourseName, DepartmentID, Credits)
VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4);
select * from students;

(4)----INSTRUCTORS TABLES----

CREATE TABLE INSTRUCTORS(
InstructorID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Email VARCHAR(100),
DepartmentID INT REFERENCES
Departments(DepartmentID));
SELECT * FROM Instructors;

INSERT INTO INSTRUCTORS
(InstructorID, FirstName, LastName, Email, DepartmentID)
VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2);
SELECT * FROM INSTRUCTORS;

(5)-----ENROLLMENTS TABLES-----

CREATE TABLE ENROLLMENTS(
EnrollmentID INT PRIMARY KEY,
StudentID INT REFERENCES
Students(StudentID),
CoursesID INT REFERENCES
Courses(CourseID),
EnrollmentDate DATE);
ALTER TABLE Enrollments
RENAME COLUMN CoursesID TO CourseID;
SELECT * FROM ENROLLMENTS;

INSERT INTO ENROLLMENTS
(EnrollmentID, StudentID, CourseID, EnrollmentDate)
VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01');
SELECT * FROM ENROLLMENTS;

----------ASSIGNMENTS QUESTIONS SOLVE IT-----------

QUESTION ---Perform CRUD Operations on all tables. 

INSERT INTO STUDENTS
VALUES
(3, 'Amit', 'Sharma', 'amitsharma@email.com', '2001-05-10', '2023-08-01');
select * from students;

update Students
set FirstName = 'Rahul'
where Studentid =3;
select * from students;

delete from students
where studentid = 3;
select * from students;

Question---Retrieve students who enrolled after 2022.

select * from students
where enrollmentdate >= '2023-01-01';

Question---Retrieve courses offered by the Mathematics department with a limit of 5 courses. 

select C.*
from Courses C
join Departments D
on C.Departmentid = D.departmentid
where D.DepartmentName = 'Mathematics' 
limit 5;

Question----Get the number of students enrolled in each course, filtering for courses with more than 5 students. 

select CourseID, COUNT(StudentID)
AS TotalStudents
from Enrollments
GROUP BY CourseID
HAVING COUNT(StudentID)>5;

Question----Find students who are enrolled in both Introduction to SQL and Data Structures. 

SELECT S.StudentID, S.FirstName, S.LastName
FROM Students S
JOIN Enrollments E
ON S.StudentID = E.StudentID
JOIN Courses C
ON E.CourseID = C.CourseID
WHERE C.CourseName IN ('Introduction to SQL','Data Structures')
GROUP BY  S.StudentID, S.FirstName, S.LastName
HAVING COUNT (DISTINCT C.CourseName) = 2;

Question----Find students who are either enrolled in Introduction to SQL or Data Structures.

SELECT S.StudentID, S.FirstName, S.LastName
FROM Students S
JOIN Enrollments E
ON S.StudentID = E.StudentID
JOIN Courses C
ON E.CourseID = C.CourseID
WHERE C.CourseName IN ('Introduction to SQL','Data Structures');

Question----Calculate the average number of credits for all courses. 

SELECT AVG(Credits) AS AverageCredits
FROM Courses;

Question----Find the maximum salary of instructors in the Computer Science department. 

SELECT MAX (I.Salary) AS MaximumSalary
FROM Instructors I
JOIN Departments D
on I.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Computer Science';

Question----Count the number of students enrolled in each department. 

SELECT D.DepartmentName, 
COUNT(DISTINCT E.StudentID) AS TotalStudents
FROM Departments D
JOIN Courses C
ON D.DepartmentID = C.DepartmentID
JOIN Enrollments E
ON C.CourseID = E.CourseID
GROUP BY D.DepartmentID, D.DepartmentName;

Question-----INNER JOIN: Retrieve students and their corresponding courses. 

SELECT S.FirstName, S.LastName, C.CourseName
FROM Students S
INNER JOIN Enrollments E
ON S.StudentID = E.StudentID
INNER JOIN Courses C
on E.CourseID = C.CourseID;

Question----LEFT JOIN: Retrieve all students and their corresponding courses, if any. 

SELECT S.FirstName, S.LastName, C.CourseName
FROM Students S
LEFT JOIN Enrollments E
ON S.StudentID = E.StudentID
LEFT JOIN Courses C
on E.CourseID = C.CourseID;

Question----- Subquery: Find students enrolled in courses that have more than 10 students. 

SELECT DISTINCT S.StudentID, S.FirstName, S.LastName
FROM Students S
JOIN Enrollments E
ON S.StudentID = E.StudentID
WHERE E.CourseID IN(
SELECT CourseID
FROM Enrollments
GROUP BY CourseID
HAVING COUNT(StudentID)>10);

Question----Extract the year from the EnrollmentDate of students.

SELECT StudentID,
YEAR(EnrollmentDate) AS EnrollmentYear
FROM Students;

Question-----Concatenate the instructor's first and last name. 

SELECT CONCAT(FirstName,'',LastName) AS InstructorName
FROM Instructors;

Question---- Calculate the running total of students enrolled in courses. 

SELECT EnrollmentID, StudentID, CourseID,
COUNT(*) OVER (ORDER BY EnrollmentDate, EnrollmentID
ROWS BETWEEN
)
)
