
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


