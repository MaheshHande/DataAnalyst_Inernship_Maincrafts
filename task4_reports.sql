-- ============================================
-- SQL Data Analysis Internship - Task 4
-- File: task4_reports.sql
-- Database: Student Management System
-- ============================================

USE student_db;

-- =====================================================
-- 1. Average Grade by Gender
-- Compare male vs female average grades
-- =====================================================
SELECT
    s.gender,
    ROUND(AVG(e.grade), 2) AS average_grade
FROM students s
JOIN enrollments e
    ON s.id = e.student_id
GROUP BY s.gender;

-- =====================================================
-- 2. Pass Rate Per Course
-- Passing grade = 40
-- =====================================================
SELECT
    c.id,
    c.name AS course_name,
    COUNT(*) AS total_students,
    SUM(CASE WHEN e.grade >= 40 THEN 1 ELSE 0 END) AS passed_students,
    ROUND(
        SUM(CASE WHEN e.grade >= 40 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS pass_rate_percentage
FROM courses c
JOIN enrollments e
    ON c.id = e.course_id
GROUP BY c.id, c.name
ORDER BY pass_rate_percentage DESC;

-- =====================================================
-- 3. Top 3 Students Overall
-- Based on average grade
-- =====================================================
SELECT
    s.id,
    s.name,
    ROUND(AVG(e.grade), 2) AS average_grade
FROM students s
JOIN enrollments e
    ON s.id = e.student_id
GROUP BY s.id, s.name
ORDER BY average_grade DESC
LIMIT 3;

-- =====================================================
-- 4. Students Enrolled in More Than 2 Courses
-- =====================================================
SELECT
    s.id,
    s.name,
    COUNT(e.course_id) AS courses_enrolled
FROM students s
JOIN enrollments e
    ON s.id = e.student_id
GROUP BY s.id, s.name
HAVING COUNT(e.course_id) > 2
ORDER BY courses_enrolled DESC, s.name;

-- =====================================================
-- 5. Improvement Report (Optional)
-- Works only if 'semester' column exists
-- =====================================================
/*
SELECT
    s.id,
    s.name,
    e1.grade AS semester1_grade,
    e2.grade AS semester2_grade,
    (e2.grade - e1.grade) AS improvement
FROM enrollments e1
JOIN enrollments e2
    ON e1.student_id = e2.student_id
JOIN students s
    ON s.id = e1.student_id
WHERE e1.semester = 'Semester 1'
  AND e2.semester = 'Semester 2'
  AND e1.course_id = e2.course_id
  AND e2.grade > e1.grade
ORDER BY improvement DESC;
*/

-- ============================================
-- End of Task 4
-- ============================================
