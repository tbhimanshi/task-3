-- SQL Data Analysis Internship – Task 3
-- Student Management Database
-- Name - Himanshi Mahavar
-- batch - 24th May 2026
-- mail - mahavarhimanshi@gmail.com
-- Date   : 15-06-2026

--TASK 3 :

USE StudentManagement;

-- Query 1: Top Student Per Course
SELECT
    c.CourseName,
    s.StudentID,
    s.Name,
    e.Grade
FROM Enrollments e
JOIN Students s
ON e.StudentID = s.StudentID
JOIN Courses c
ON e.CourseID = c.CourseID
WHERE e.Grade = (
    SELECT MAX(e2.Grade)
    FROM Enrollments e2
    WHERE e2.CourseID = e.CourseID
);

-- Query 2: Pass Rate Per Course
SELECT
    c.CourseName,
    ROUND(
        SUM(CASE WHEN e.Grade >= 40 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS PassRate
FROM Courses c
JOIN Enrollments e
ON c.CourseID = e.CourseID
GROUP BY c.CourseName;

-- Query 3: Overall Topper Across All Courses
SELECT
    s.StudentID,
    s.Name,
    ROUND(
        AVG(e.Grade),
        2
    ) AS AverageScore
FROM Students s
JOIN Enrollments e
ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.Name
ORDER BY AverageScore DESC
LIMIT 1;

-- Query 4: Students Enrolled In Multiple Courses
SELECT
    s.StudentID,
    s.Name,
    COUNT(e.CourseID) AS TotalCourses
FROM Students s
JOIN Enrollments e
ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.Name
HAVING COUNT(e.CourseID) > 1;

