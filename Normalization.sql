
create database normal

use normal

CREATE TABLE StudentCourses(StudentID INT PRIMARY KEY, StudentName VARCHAR(50),Courses VARCHAR(100),Instructors VARCHAR(100));

INSERT INTO StudentCourses (StudentID, StudentName, Courses, Instructors) VALUES
(1, 'Jesu', 'Math,Science', 'Dr. Kamla,Dr. Arvi'),
(2, 'Aarav', 'Math,English', 'Dr. Kamla,Dr. Arvi');

select * from StudentCourses

---1NF

CREATE TABLE Courses (StudentID INT,CourseName VARCHAR(50),InstructorName VARCHAR(50),PRIMARY KEY (StudentID, CourseName));

select*from Courses

CREATE TABLE Students (StudentID INT PRIMARY KEY,StudentName VARCHAR(50));

INSERT INTO Students (StudentID, StudentName)SELECT DISTINCT StudentID, StudentName FROM StudentCourses;

select* from Students

WITH SplitCourses AS (
    SELECT 
        StudentID,
        TRIM(value) AS CourseName,
        ROW_NUMBER() OVER (PARTITION BY StudentID ORDER BY (SELECT 1)) AS CoursePosition
    FROM StudentCourses
    CROSS APPLY STRING_SPLIT(Courses, ',')
),
SplitInstructors AS (
    SELECT 
        StudentID,
        TRIM(value) AS InstructorName,
        ROW_NUMBER() OVER (PARTITION BY StudentID ORDER BY (SELECT 1)) AS InstructorPosition
    FROM StudentCourses
    CROSS APPLY STRING_SPLIT(Instructors, ',')
)
INSERT INTO Courses (StudentID, CourseName, InstructorName)
SELECT 
    c.StudentID,
    c.CourseName,
    i.InstructorName
FROM 
    SplitCourses c
JOIN 
    SplitInstructors i
ON 
    c.StudentID = i.StudentID
    AND c.CoursePosition = i.InstructorPosition;

---2NF
CREATE TABLE CourseDetails (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    CourseName VARCHAR(50)
);
select * from CourseDetails

drop table CourseDetails

CREATE TABLE StudentCourse (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES CourseDetails(CourseID)
);

select * from StudentCourse

drop table StudentCourse
INSERT INTO CourseDetails (CourseName)
SELECT DISTINCT CourseName 
FROM Courses;

INSERT INTO StudentCourse (StudentID, CourseID)
SELECT c.StudentID, cd.CourseID
FROM Courses c
JOIN CourseDetails cd ON c.CourseName = cd.CourseName;

--3NF

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50)
);

CREATE TABLE Instructors (
    InstructorID INT IDENTITY(1,1) PRIMARY KEY,
    InstructorName VARCHAR(50)
);

INSERT INTO Instructors (InstructorName)
SELECT DISTINCT InstructorName 
FROM Courses;

CREATE TABLE CourseInstructors (
    CourseID INT,
    InstructorID INT,
    PRIMARY KEY (CourseID, InstructorID),
    
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

INSERT INTO CourseInstructors (InstructorID)
SELECT 
    i.InstructorID
FROM 
    Courses c
JOIN 
    CourseDetails cd ON c.CourseName = cd.CourseName
JOIN 
    Instructors i ON c.InstructorName = i.InstructorName;