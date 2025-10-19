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

-- Query 6
WITH CourseLoads AS (
    SELECT 
        s.student_id,
        s.first_name || ' ' || s.last_name as student_name,
        COUNT(e.enrollment_id) as course_count,
        SUM(c.credits) as total_credits
    FROM students s
    INNER JOIN enrollments e ON s.student_id = e.student_id
    INNER JOIN courses c ON e.course_id = c.course_id
    GROUP BY s.student_id, student_name
),
AverageCourseLoad AS (
    SELECT AVG(course_count) as avg_courses
    FROM CourseLoads
)
SELECT 
    cl.student_name,
    cl.course_count,
    cl.total_credits,
    ROUND(acl.avg_courses, 2) as avg_course_load,
    cl.course_count - acl.avg_courses as difference
FROM CourseLoads cl
CROSS JOIN AverageCourseLoad acl
WHERE cl.course_count > acl.avg_courses
ORDER BY cl.course_count DESC;

--Query 7
SELECT student_id, first_name, last_name, gpa as old_gpa
FROM students
WHERE student_id IN (1001, 1002, 1003);

UPDATE students
SET gpa = (
    SELECT ROUND(AVG(g.grade_points), 2)
    FROM enrollments e
    INNER JOIN grades g ON e.enrollment_id = g.enrollment_id
    WHERE e.student_id = students.student_id
)
WHERE student_id IN (
    SELECT DISTINCT e.student_id
    FROM enrollments e
    INNER JOIN grades g ON e.enrollment_id = g.enrollment_id
);

SELECT student_id, first_name, last_name, gpa as new_gpa
FROM students
WHERE student_id IN (1001, 1002, 1003);

-- Query 8
SELECT 
    s.student_id,
    s.first_name || ' ' || s.last_name as full_name,
    
    UPPER(s.last_name) || ', ' || s.first_name as display_name,
    
    s.email as original_email,
    SUBSTR(s.email, 1, INSTR(s.email, '@') - 1) as username,
    SUBSTR(s.email, INSTR(s.email, '@') + 1) as domain,
    
    LENGTH(s.email) as email_length,
    
    LOWER(s.first_name) || '.' || LOWER(s.last_name) || '@students.duke.edu' as alt_email,
    
    SUBSTR(s.first_name, 1, 1) || SUBSTR(s.last_name, 1, 1) as initials
    
FROM students s
ORDER BY s.last_name
LIMIT 5;

-- Query 9

SELECT 
    'Student' as role,
    student_id as id,
    first_name,
    last_name,
    email,
    'Class of ' || graduation_year as additional_info
FROM students
WHERE graduation_year = 2025

UNION

SELECT 
    'Professor' as role,
    ROW_NUMBER() OVER (ORDER BY professor) as id,
    SUBSTR(professor, INSTR(professor, ' ') + 1) as first_name,
    SUBSTR(professor, 1, INSTR(professor, ' ') - 1) as last_name,
    LOWER(REPLACE(professor, ' ', '.')) || '@duke.edu' as email,
    'Dept: ' || department as additional_info
FROM courses
GROUP BY professor, department

ORDER BY role, last_name;

-- Query 10
SELECT 
    s.student_id,
    s.first_name || ' ' || s.last_name as student_name,
    COALESCE(c.club_name, 'No Club Membership') as club_name,
    COALESCE(cm.position, 'N/A') as position,
    COALESCE(c.category, 'N/A') as club_category,
    COALESCE(c.budget, 0) as club_budget,
    COALESCE(DATE(cm.join_date), 'Never Joined') as join_date,
    CASE 
        WHEN cm.membership_id IS NULL THEN 'Not Active'
        WHEN DATE(cm.join_date) >= DATE('2024-01-01') THEN 'New Member'
        ELSE 'Established Member'
    END as membership_status
FROM students s
LEFT JOIN club_memberships cm ON s.student_id = cm.student_id
LEFT JOIN clubs c ON cm.club_id = c.club_id
ORDER BY s.student_id, club_name;