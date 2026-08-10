SQL DATA ANALYSIS INTERNSHIP – TASK 3
Complete SQL Script

Task Requirements
1. Top student per course
2. Pass rate per course (grade >= 40)
3. Overall topper across all courses
4. Students enrolled in multiple courses
5. Use JOIN + GROUP BY + HAVING

Assumed database tables from Task 2:
students(id, name)
courses(id, name)
enrollments(student_id, course_id, grade)

============================================================
1. TOP STUDENT PER COURSE
============================================================

SELECT
    c.name AS course,
    s.name AS student,
    e.grade AS top_grade
FROM enrollments e
JOIN students s
    ON e.student_id = s.id
JOIN courses c
    ON e.course_id = c.id
WHERE e.grade = (
    SELECT MAX(e2.grade)
    FROM enrollments e2
    WHERE e2.course_id = e.course_id
)
ORDER BY c.name;


============================================================
2. PASS RATE PER COURSE
============================================================
-- Passing grade is 40 or above.

SELECT
    c.name AS course,
    COUNT(*) AS total_students,
    SUM(
        CASE
            WHEN e.grade >= 40 THEN 1
            ELSE 0
        END
    ) AS passed_students,
    ROUND(
        SUM(
            CASE
                WHEN e.grade >= 40 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS pass_rate
FROM enrollments e
JOIN courses c
    ON e.course_id = c.id
GROUP BY c.id, c.name
ORDER BY pass_rate DESC;


============================================================
3. OVERALL TOPPER ACROSS ALL COURSES
============================================================
-- Returns the student(s) with the highest individual grade.

SELECT
    s.id,
    s.name AS student,
    e.grade AS highest_grade,
    c.name AS course
FROM enrollments e
JOIN students s
    ON e.student_id = s.id
JOIN courses c
    ON e.course_id = c.id
WHERE e.grade = (
    SELECT MAX(grade)
    FROM enrollments
);


============================================================
4. STUDENTS ENROLLED IN MULTIPLE COURSES
============================================================

SELECT
    s.id,
    s.name AS student,
    COUNT(e.course_id) AS total_courses
FROM students s
JOIN enrollments e
    ON s.id = e.student_id
GROUP BY s.id, s.name
HAVING COUNT(e.course_id) > 1
ORDER BY total_courses DESC;


============================================================
5. JOIN + GROUP BY + HAVING
============================================================
-- Courses having at least 2 enrolled students.

SELECT
    c.name AS course,
    COUNT(e.student_id) AS total_students,
    ROUND(AVG(e.grade), 2) AS average_grade
FROM courses c
JOIN enrollments e
    ON c.id = e.course_id
GROUP BY c.id, c.name
HAVING COUNT(e.student_id) >= 2
ORDER BY average_grade DESC;


============================================================
OPTIONAL: OVERALL TOPPER BY AVERAGE GRADE
============================================================
-- Use this version if "overall topper" means the student
-- with the highest average grade across all enrolled courses.

SELECT
    s.id,
    s.name AS student,
    ROUND(AVG(e.grade), 2) AS average_grade
FROM students s
JOIN enrollments e
    ON s.id = e.student_id
GROUP BY s.id, s.name
HAVING AVG(e.grade) = (
    SELECT MAX(avg_grade)
    FROM (
        SELECT AVG(grade) AS avg_grade
        FROM enrollments
        GROUP BY student_id
    ) AS student_averages
);


============================================================
SUBMISSION NOTE
============================================================

The Task 3 PDF asks for:
- SQL script with queries
- Screenshots of outputs

The queries above cover all four required analyses and explicitly
use JOIN, GROUP BY, HAVING, and subqueries.

IMPORTANT:
Use the same students, courses, and enrollments data from Task 2
when running these queries so that the output matches your database.
