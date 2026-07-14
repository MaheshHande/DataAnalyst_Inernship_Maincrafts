
Create Database StudentManagement;

Create Table Student(
StudentID int IDENTITY(1,1) PRIMARY KEY ,
Name Varchar(10),
Gender CHAR(1) ,
Age int,
Grade CHAR(2), 
MathScore int,
ScienceScore int,
EnglishScore int
);  

INSERT INTO Student
(Name, Gender, Age, Grade, MathScore, ScienceScore, EnglishScore)
VALUES
('Aarav', 'M', 18, 'A', 92, 88, 90),
('Anaya', 'F', 17, 'B', 78, 82, 80),
('Rohan', 'M', 19, 'A', 95, 91, 89),
('Sneha', 'F', 18, 'A', 88, 90, 93),
('Vivaan', 'M', 17, 'C', 65, 70, 68),
('Diya', 'F', 18, 'B', 81, 79, 84),
('Arjun', 'M', 19, 'B', 74, 76, 72),
('Kiara', 'F', 17, 'A', 96, 94, 98),
('Ishaan', 'M', 18, 'C', 60, 66, 63),
('Meera', 'F', 19, 'A', 89, 87, 91);


--Querie 1 Show All Student data
select * from Student;

--Querie 2 Show Avgerage Score in each subject

select AVG(MathScore)as AvgMath,AVG(ScienceScore) as AvgScence,AVG(EnglishScore) as avgEnglish from Student;

--Querie 3 Top Performer (Highest Total Score )

SELECT TOP 1
    StudentID,
    Name,
    Grade,
    MathScore,
    ScienceScore,
    EnglishScore,
    (MathScore + ScienceScore + EnglishScore) AS TotalScore
FROM Student
ORDER BY TotalScore DESC;

--Querie 4 Count Student per Grade

select Grade, Count(Grade) As CountGrade from Student
group by Grade

--Querie 5 Avg Score by Gender 

select gender, AVG(MathScore) as AVGMath, Avg(ScienceScore)as AVGScience,Avg(EnglishScore)as AVGEnglish from Student
group by gender

--Querie 6  Students With Math>80

select Name , MathScore from student 
where MathScore>80;

--Querie 7 Update a Studnet Grade

Update Student
set Grade = 'B'
where Name = 'Rohan';


