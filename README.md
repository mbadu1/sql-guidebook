# sql-guidebook


**Author:** Michael Kofi Badu
**Database:** SQLite  
**Purpose:** Personal SQL reference guide demonstrating advanced query techniques

---

## Table of Contents
1. [Database Schema](#database-schema)
2. [Setup](#setup)
3. [SQL Queries](#sql-queries)
4. [Key Learnings](#key-learnings)

---

## Database Schema

### Entity Relationship Overview
This database models a university system with students, courses, enrollments, grades, majors, clubs, and memberships.

**Tables:**
- `students` - Student demographic and academic information
- `majors` - Academic major programs
- `courses` - Course catalog
- `enrollments` - Student course registrations
- `grades` - Course grades
- `clubs` - Student organizations
- `club_memberships` - Student club participation

Results samples:

![alt text](<Tables image.png>)

![alt text](<Table image2.png>)

## Setup
**SQLite3** - Database engine
(verify with `sqlite3 --version`)
**SQLite Extension for VSCode** 
  - Extension ID: `alexcvzz.vscode-sqlite`

1. Clone or download this repository to your local machine:
2. Ensure you have the following files in your project directory
3. Create the Database
4. Verify Installation
5. Configure VSCode
6. Run Queries



### SQL Queries
#### Query 1: Basic SELECT with Filtering and Sorting

#### Question 1: Who are all the Computer Science majors, ordered by GPA?

SQL Concepts: SELECT, FROM, WHERE, INNER JOIN, ORDER BY

Query:

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

Results:
![alt text](<query1 image.png>)

Explanation: Find all computer science students sorted by gpa. 
This query joins the students table with the majors table to filter only Computer Science students. 
The INNER JOIN ensures we only get students with a valid major. Results are sorted by GPA in descending order to show top performers first.



#### Query 2: Aggregation with GROUP BY and HAVING

#### Question 2 : Which departments have more than 2 students and what's their average GPA?

SQL Concepts: GROUP BY, HAVING, COUNT, AVG, MIN, MAX, ROUND

Query:

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

Results:

![alt text](<query2 image.png>)


Explanation: This query demonstrates aggregation functions. GROUP BY organizes students by department, while HAVING filters to show only departments with more than 2 students. The aggregate functions (COUNT, AVG, MIN, MAX) provide statistical summaries.


#### Query 3: Multiple JOINS (INNER, LEFT JOIN)

#### Question 3: Show all students with their enrolled courses and grades, including students who haven't received grades yet.

SQL Concepts: INNER JOIN, LEFT JOIN, multiple table joins

Query:

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


Results:
![alt text](<query3 image.png>)
Explanation: 
Complete student academic record with course enrollments and grades. 
This query demonstrates the power of joining multiple tables to create a comprehensive view. We use INNER JOINs for students, enrollments, and courses because we only want records where these relationships exist. However, we use a LEFT JOIN for grades because some enrollments might not have grades yet, and we still want to see those enrollments. The || operator concatenates first and last names into a single field. This query pattern is extremely common in academic systems for generating transcript-like reports. The ORDER BY clause sorts first by last name, then by course ID for organized output.



#### QUERY 4: CASE WHEN for Data Transformation

#### Question 4: Classify students by GPA performance level and count each category.

SQL Concepts: CASE WHEN, GROUP BY, COUNT

Query:

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

Results:

![alt text](<query4 image.png>)

Explanation: Categorize students by academic performance. The CASE WHEN statement is SQL's version of if-else logic, allowing us to transform data dynamically. Here, we categorize students into performance tiers based on their GPA ranges. The CASE expression is evaluated for each row, and the appropriate label is assigned. GROUP BY then groups students by their assigned performance level. GROUP_CONCAT is a powerful aggregation function that combines multiple text values into a single comma-separated string, making it easy to see which students fall into each category. This type of query is valuable for creating summary reports, dashboards, and identifying students who may need academic support or recognition.


#### Query 5: Window Functions - RANK and ROW_NUMBER

#### Question: Rank students within each graduating class by GPA.

SQL Concept: Concepts: OVER, PARTITION BY, RANK, ROW_NUMBER, DENSE_RANK

Query:

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

Results:

![alt text](<query5 image.png>)

Explanation: Rank students within their graduation year.Window functions are powerful analytical tools that perform calculations across a set of rows related to the current row. Unlike GROUP BY which collapses rows, window functions preserve individual rows while adding calculated values. PARTITION BY divides the data into windows (here, by graduation year), and calculations are performed within each partition. RANK() assigns ranks but leaves gaps when there are ties (e.g., 1, 2, 2, 4). ROW_NUMBER() assigns unique sequential numbers regardless of ties. DENSE_RANK() assigns ranks without gaps even with ties (e.g., 1, 2, 2, 3).


#### Query 6: Common Table Expressions (WITH)

#### Question 6: Find students who are taking more courses than the average and show their course load.

SQL Concept: WITH (CTE), subqueries, aggregation

Query:

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

Results

![alt text](<query6 image.png>)

Explanation: Identify students with above-average course loads. Common Table Expressions (CTEs) make complex queries more readable and maintainable by breaking them into logical, named steps. Think of CTEs as temporary result sets that exist only for the duration of the query. In this query, we first create the CourseLoads CTE which calculates each student's course count and total credits. Then we create Average Course Load CTE which calculates the average across all students. Finally, we join these CTEs together using CROSS JOIN (which creates a cartesian product, but since AverageCourseLoad has only one row, each student row gets paired with the average). This structure makes the query much easier to understand, test, and modify than nested subqueries. CTEs are particularly valuable for complex analytical queries and are widely used in data analysis and reporting.


#### QUERY 7: UPDATE with Calculated Values

#### Question 7: Update GPA for students based on their latest grades.

SQL Concept: Concepts: UPDATE, subquery, aggregation

Query:

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

Results:

![alt text](<query7 image.png>)

Explanation: Recalculate and update student GPAs based on grades
The UPDATE statement modifies existing data in the database. This query demonstrates a correlated subquery, where the subquery references the outer query's table (students.student_id). For each student, the subquery calculates their actual GPA by averaging their grade points from all completed courses. The WHERE clause in the UPDATE ensures we only update students who have grades (avoiding NULL values).


#### QUERY 8: String Manipulation Functions

#### Question 8: Format student emails and extract domain, create display names.

SQL Concept: Concepts: UPPER, LOWER, SUBSTR, INSTR, LENGTH, REPLACE, TRIM

Query:

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
LIMIT 5

Results
![alt text](<query8 image.png>)

Explanation: Demonstrate string functions for data cleaning and formatting. String manipulation functions are essential for data cleaning, formatting, and transformation. SUBSTR extracts portions of text (parameters: string, start position, optional length). INSTR finds the position of a substring within a string. LENGTH returns character count. UPPER and LOWER change case. 


#### QUERY 9: UNION for Combining Result Sets

#### Question 9: Create a unified list of all participants students and professors with their roles.

SQL Concept: UNION, UNION ALL, set operations

Query:

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

Results:

![alt text](<query9 image.png>)

Explanation: Combine different entity types into a unified view. UNION combines the results of two or more SELECT statements into a single result set. The key requirement is that all SELECT statements must have the same number of columns with compatible data types. UNION automatically removes duplicate rows (use UNION ALL to keep duplicates). In this query, we combine student and professor data into a unified directory. 



#### QUERY 10: NULL Handling with COALESCE

#### Question 10: Display all club memberships with default values for missing data\

SQL Concepts: Concepts: COALESCE, IFNULL, NULL handling, LEFT JOIN

Query:
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

Results:

![alt text](<query10 image.png>)


Explanation: COALESCE is an essential function for handling NULL values in SQL, which occur when data is missing or relationships don't exist. COALESCE takes multiple arguments and returns the first non-NULL value. In this query, we use LEFT JOINs which can produce NULL values when a student isn't in any club. Instead of displaying NULL (which is confusing to end users), we provide meaningful default values: "No Club Membership" for students without clubs, "N/A" for missing positions, and 0 for missing budgets. 



#### Key Learnings


##### JOIN Operations

INNER JOIN for matching records
LEFT JOIN for including non-matches
Multiple table joins in single query


##### Window Functions

RANK() for competitive rankings
ROW_NUMBER() for sequential numbering
PARTITION BY for group-wise operations
LEAD/LAG for temporal analysis


##### Common Table Expressions (CTEs)

WITH clause for query organization
Multiple CTEs in single query
Improved readability and maintenance


##### String Functions

SUBSTR for extracting substrings
INSTR for finding positions
UPPER/LOWER for case conversion
Concatenation with ||


##### Date Functions

DATE for date manipulation


###### Set Operations

UNION for combining results
INTERSECT for common elements


##### NULL Handling

COALESCE for default values
IS NULL checks
LEFT JOIN for optional data


 **Limit Results:** Use LIMIT for large datasets during testing









---

## References

- SQLite Documentation: https://www.sqlite.org/docs.html
- SQL Window Functions: https://www.sqlitetutorial.net/sqlite-window-functions/


---

## Guidebook Checklist

 **Database Files:**
- [ ] `duke_university.db` (your SQLite database)
- [ ] `setup.sql` (table creation script)
- [ ] `insert_data.sql` (data population script)
- [ ] `queries.sql` (all 10 queries)
- [ ] `images ` (all screenshots of outputs during exercise)



**Required SQL Features (check each):**
- [ ] CREATE TABLE, INSERT, UPDATE
- [ ] SELECT, FROM, WHERE, ORDER BY, GROUP BY, LIMIT, HAVING
- [ ] Aggregate functions (COUNT, AVG, MAX, MIN)
- [ ] JOIN (INNER, LEFT)
- [ ] CASE WHEN
- [ ] Window functions (OVER, PARTITION BY, RANK, ROW_NUMBER)
- [ ] Common Table Expressions (WITH)
- [ ] At least 2 self-explored features:
  - [ ] String functions (SUBSTR, INSTR, UPPER, LOWER)
  - [ ] Date functions (JULIANDAY, STRFTIME, DATE)
  - [ ] LEAD/LAG window functions
  - [ ] UNION, EXCEPT, INTERSECT
  - [ ] COALESCE
  - [ ] Subqueries (EXISTS, IN, correlated)

---

---

*This guidebook was created by Michael Kofi Badu part of Week 7 Major Assignment for SQL course at Duke University.*
```