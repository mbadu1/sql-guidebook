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
