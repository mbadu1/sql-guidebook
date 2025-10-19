-- Query 1
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    s.email,
    s.gpa,
    s.graduation_year,
    m.major_name
FROM students s
INNER JOIN majors m ON s.major_id = m.major_id
WHERE m.major_name = 'Computer Science'
ORDER BY s.gpa DESC;


-- Query 2

SELECT 
    m.department,
    COUNT(s.student_id) as student_count,
    ROUND(AVG(s.gpa), 2) as avg_gpa,
    MIN(s.gpa) as min_gpa,
    MAX(s.gpa) as max_gpa
FROM students s
INNER JOIN majors m ON s.major_id = m.major_id
GROUP BY m.department
HAVING COUNT(s.student_id) > 2
ORDER BY avg_gpa DESC;

-- Query 3
SELECT 
    s.first_name || ' ' || s.last_name as student_name,
    s.graduation_year,
    c.course_id,
    c.course_name,
    e.semester,
    g.grade,
    g.grade_points
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id
LEFT JOIN grades g ON e.enrollment_id = g.enrollment_id
ORDER BY s.last_name, c.course_id;

-- Query 4
SELECT 
    CASE 
        WHEN s.gpa >= 3.8 THEN 'Excellent'
        WHEN s.gpa >= 3.5 THEN 'Good'
        WHEN s.gpa >= 3.0 THEN 'Satisfactory'
        ELSE 'Needs Improvement'
    END as performance_level,
    COUNT(*) as student_count,
    ROUND(AVG(s.gpa), 2) as avg_gpa,
    GROUP_CONCAT(s.first_name || ' ' || s.last_name, ', ') as students
FROM students s
GROUP BY performance_level
ORDER BY avg_gpa DESC;


-- Query 5
SELECT 
    s.graduation_year,
    s.first_name || ' ' || s.last_name as student_name,
    m.major_name,
    s.gpa,
    RANK() OVER (PARTITION BY s.graduation_year ORDER BY s.gpa DESC) as gpa_rank,
    ROW_NUMBER() OVER (PARTITION BY s.graduation_year ORDER BY s.gpa DESC) as row_num,
    DENSE_RANK() OVER (PARTITION BY s.graduation_year ORDER BY s.gpa DESC) as dense_rank
FROM students s
INNER JOIN majors m ON s.major_id = m.major_id
ORDER BY s.graduation_year, gpa_rank;