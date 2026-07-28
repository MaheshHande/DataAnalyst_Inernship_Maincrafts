CREATE TABLE Courses (
    CourseID INT auto_increment PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL
);

CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT,
    Grade CHAR(2),

    PRIMARY KEY (StudentID, CourseID),

    FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID),

    FOREIGN KEY (CourseID)
        REFERENCES Courses(CourseID)
);

INSERT INTO Courses (CourseName)
VALUES
('Database Management'),
('Data Structures'),
('Computer Networks'),
('Operating Systems'),
('Python Programming');

INSERT INTO Enrollments (StudentID, CourseID, Grade)
VALUES
(1,1,'A'),
(1,2,'A'),

(2,1,'B'),
(2,3,'B'),

(3,2,'A'),
(3,4,'A'),

(4,1,'A'),
(4,5,'B'),

(5,3,'C'),
(5,4,'C'),

(6,2,'B'),
(6,5,'A'),

(7,1,'A'),
(7,3,'A'),

(8,2,'B'),
(8,4,'B'),

(9,5,'C'),
(10,1,'A');


select * from Courses
select * from Enrollments
select * from Students

-- List all students enrolled in each course. 

SELECT
    C.CourseName,
    COUNT(E.StudentID) AS TotalStudents
FROM Courses C
LEFT JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.CourseName;
    
     -- Find average grade per course
     
SELECT
    C.CourseName,
    COUNT(*) AS Enrollments
FROM Courses C
JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.CourseName;

--  Find top 3 students overall. 

SELECT
    StudentID,
    Name,
    MathScore,
    ScienceScore,
    EnglishScore,
    (MathScore + ScienceScore + EnglishScore) AS TotalMarks
FROM Students
ORDER BY TotalMarks DESC
LIMIT 3;

-- Count students who failed (grade < 40).
SELECT COUNT(*) AS FailedStudents
FROM Students
WHERE (MathScore + ScienceScore + EnglishScore) / 3.0 < 40;



