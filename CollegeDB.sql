-- 1. View sample rows

SELECT * FROM students LIMIT 20;
SELECT * FROM courses LIMIT 20;
SELECT * FROM enrollments LIMIT 20;

-- 2. Count totals in each table

SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(*) AS total_courses FROM courses;
SELECT COUNT(*) AS total_enrollments FROM enrollments;

-- 3. List all students majoring in Computer Science

SELECT student_id, first_name, last_name, major
FROM students
WHERE major = 'Computer Science'
LIMIT 50;

-- 4. Find students with GPA above 3.5

SELECT student_id, first_name, last_name, gpa
FROM students
WHERE gpa > 3.5
ORDER BY gpa DESC;

-- 5. Full student → enrollment → course join

SELECT s.first_name, s.last_name,
       c.course_name, c.department,
       e.semester, e.year, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY s.last_name
LIMIT 50;

-- 6. Count how many courses each student is enrolled in

SELECT s.student_id, s.first_name, s.last_name,
       COUNT(e.course_id) AS num_courses
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
ORDER BY num_courses DESC
LIMIT 20;

-- 7. Most popular courses by number of enrollments

SELECT c.course_name, COUNT(e.student_id) AS enrollment_count
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id
ORDER BY enrollment_count DESC
LIMIT 20;

-- 8. Window Function: Rank students by GPA

SELECT 
    student_id,
    first_name,
    last_name,
    gpa,
    RANK() OVER (ORDER BY gpa DESC) AS gpa_rank
FROM students
LIMIT 20;

-- 9. Most difficult course (lowest average grade)

SELECT 
    c.course_name,
    AVG(
        CASE grade
            WHEN 'A' THEN 4
            WHEN 'B' THEN 3
            WHEN 'C' THEN 2
            WHEN 'D' THEN 1
            WHEN 'F' THEN 0
            ELSE NULL
        END
    ) AS avg_grade
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id
ORDER BY avg_grade ASC
LIMIT 10;

