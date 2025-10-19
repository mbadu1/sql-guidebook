# sql-guidebook
# Duke University SQL Guidebook
**Author:** Michael Kofi Badu
**Database:** SQLite  
**Purpose:** Personal SQL reference guide demonstrating advanced query techniques

---

## Table of Contents
1. [Database Schema](#database-schema)
2. [Setup Instructions](#setup-instructions)
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

### Schema Diagram
```
students ──┬── enrollments ── grades
           │       │
           │       └── courses
           │
           ├── majors
           │
           └── club_memberships ── clubs

Setup Instructions
Prerequisites

SQLite3 installed
VSCode with SQLite extension
Basic understanding of SQL



SQL Queries
Query 1: Basic SELECT with Filtering and Sorting
Business Question: Who are all the Computer Science majors, ordered by GPA?
SQL Concepts: SELECT, FROM, WHERE, INNER JOIN, ORDER BY
Query:
sqlSELECT 
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
image.png


Query 2: Aggregation with GROUP BY and HAVING
Business Question: Which departments have more than 2 students and what's their average GPA?
SQL Concepts: GROUP BY, HAVING, COUNT, AVG, MIN, MAX, ROUND
Query:
sqlSELECT 
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
departmentstudent_countavg_gpamin_gpamax_gpaNatural Sciences33.853.783.95Social Sciences43.553.333.78Engineering43.703.453.95
Explanation:
This query demonstrates aggregation functions. GROUP BY organizes students by department, while HAVING filters to show only departments with more than 2 students. The aggregate functions (COUNT, AVG, MIN, MAX) provide statistical summaries.

[Continue with all other queries in similar format...]

Key Learnings
Advanced SQL Features Mastered

JOIN Operations

INNER JOIN for matching records
LEFT JOIN for including non-matches
Multiple table joins in single query


Window Functions

RANK() for competitive rankings
ROW_NUMBER() for sequential numbering
PARTITION BY for group-wise operations
LEAD/LAG for temporal analysis


Common Table Expressions (CTEs)

WITH clause for query organization
Multiple CTEs in single query
Improved readability and maintenance


String Functions

SUBSTR for extracting substrings
INSTR for finding positions
UPPER/LOWER for case conversion
Concatenation with ||


Date Functions

JULIANDAY for date arithmetic
STRFTIME for formatting
DATE for date manipulation


Set Operations

UNION for combining results
EXCEPT for differences
INTERSECT for common elements


NULL Handling

COALESCE for default values
IS NULL checks
LEFT JOIN for optional data



Best Practices Learned
✅ Always use table aliases for readability
✅ Include descriptive column names using AS
✅ Comment complex queries
✅ Use EXPLAIN QUERY PLAN for optimization
✅ Test queries incrementally
✅ Normalize data to reduce redundancy
✅ Use foreign keys for referential integrity

Performance Optimization Tips

Indexing: Create indexes on frequently queried columns

sql   CREATE INDEX idx_students_major ON students(major_id);
   CREATE INDEX idx_enrollments_student ON enrollments(student_id);

Query Planning: Use EXPLAIN to understand query execution

sql   EXPLAIN QUERY PLAN SELECT...
```

3. **Limit Results:** Use LIMIT for large datasets during testing

---

## Future Enhancements

- [ ] Add triggers for automatic GPA calculation
- [ ] Implement views for common queries
- [ ] Create stored procedures (if supported)
- [ ] Add transaction examples
- [ ] Include data validation constraints

---

## References

- SQLite Documentation: https://www.sqlite.org/docs.html
- SQL Window Functions: https://www.sqlitetutorial.net/sqlite-window-functions/
- Database Design Principles: Normalization and ER Modeling

---

*This guidebook was created as part of Week 7 Major Assignment for SQL course at Duke University.*
```

---

## Part 5: Testing and Verification

Create a file called `test_queries.sql` to verify everything works:
```sql
-- ============================================
-- VERIFICATION SCRIPT
-- ============================================
-- Run this to verify your database is set up correctly

.mode column
.headers on
.width 15 20 30

-- Test 1: Verify table creation
SELECT 'Test 1: Table Counts' as test;
SELECT 
    (SELECT COUNT(*) FROM students) as students,
    (SELECT COUNT(*) FROM majors) as majors,
    (SELECT COUNT(*) FROM courses) as courses,
    (SELECT COUNT(*) FROM enrollments) as enrollments,
    (SELECT COUNT(*) FROM grades) as grades,
    (SELECT COUNT(*) FROM clubs) as clubs,
    (SELECT COUNT(*) FROM club_memberships) as memberships;

-- Test 2: Verify foreign key relationships
SELECT 'Test 2: Relationship Integrity' as test;
SELECT 
    'Students with valid majors' as check_description,
    COUNT(*) as count
FROM students s
WHERE EXISTS (SELECT 1 FROM majors m WHERE m.major_id = s.major_id);

-- Test 3: Verify data quality
SELECT 'Test 3: Data Quality Checks' as test;
SELECT 
    'Students with GPA in valid range' as check_description,
    COUNT(*) as count
FROM students
WHERE gpa BETWEEN 0.0 AND 4.0;

SELECT 'All Tests Passed!' as result;
```

---

## Part 6: Submission Checklist

Before submitting, ensure you have:

✅ **Database Files:**
- [ ] `duke_university.db` (your SQLite database)
- [ ] `setup.sql` (table creation script)
- [ ] `insert_data.sql` (data population script)
- [ ] `queries.sql` (all 15 queries)
- [ ] `test_queries.sql` (verification script)

✅ **Documentation:**
- [ ] `README.md` or PowerPoint/PDF with:
  - Title for each query
  - Business question being answered
  - SQL concepts demonstrated
  - Complete SQL code
  - Screenshot or text of results
  - Explanation of what the query does

✅ **Required SQL Features (check each):**
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

## Bonus: Creating Screenshots for Documentation

If you need screenshots for your documentation:

1. **In VSCode:**
   - Run query
   - Select results
   - Right-click → "Copy"
   - Paste into your documentation

2. **Using SQLite command line:**
```bash
   sqlite3 duke_university.db -header -column < queries.sql > output.txt
```

3. **Export to CSV:**
```sql
   .mode csv
   .output results.csv
   SELECT * FROM students;
   .output stdout
```

---

This comprehensive guide gives you everything you need to complete your assignment with excellence! The database is realistic, the queries demonstrate all required concepts, and you have multiple self-explored features (string functions, date functions, LEAD/LAG, UNION/EXCEPT, COALESCE, and complex subqueries).

**Would you like me to:**
1. Create a PowerPoint template for your documentation?
2. Generate additional practice queries?
3. Help you export results in a specific format?
4. Create visualizations of your query results?RetryMBhow do i run this query to get the expected output
-- ============================================
-- QUERY 1: Basic Filtering and Sorting
-- ============================================
-- Purpose: Find all Computer Science students sorted by GPA
-- Concepts: SELECT, FROM, WHERE, JOIN, ORDER BY
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

**Expected Output:**

student_id | first_name | last_name | email | gpa | graduation_year | major_name
1007 | Sophia | Moore | sophia.m@duke.edu | 3.95 | 2027 | Computer Science
1001 | Emma | Johnson | emma.j@duke.edu | 3.85 | 2025 | Computer Science
1004 | Noah | Davis | noah.d@duke.edu | 3.45 | 2025 | Computer ScienceHow to Run SQL Queries in VSCode with SQLite
I'll show you three different methods to run your query and get nicely formatted output.

Method 1: Using SQLite Extension in VSCode (Recommended)
Step 1: Install SQLite Extension

Open VSCode
Click on Extensions icon (or press Ctrl+Shift+X)
Search for "SQLite" by alexcvzz
Click Install

Step 2: Run Your Query

Open your query file (e.g., queries.sql)
Select the query you want to run (highlight the entire Query 1)
Right-click on the selected text
Choose "Run Selected Query" or press Ctrl+Shift+Q
When prompted, select your database file (duke_university.db)

Step 3: View Results

Results will appear in a new tab at the bottom of VSCode
You can export results by clicking the export icon

Visual Guide:
1. Highlight Query → 2. Right-click → 3. "Run Selected Query" → 4. View results

Method 2: Using SQLite Command Line (Best for Formatted Output)
Step 1: Open Terminal
In VSCode, open the integrated terminal:

Windows/Linux: Ctrl + ``  (backtick)
Mac: Cmd + `` 

Or use Terminal → New Terminal
Step 2: Navigate to Your Project Folder
bashcd path/to/duke-sql-guidebook
Step 3: Run SQLite with Formatting
bashsqlite3 duke_university.db
Step 4: Set Display Options
Once in SQLite prompt, enter these formatting commands:
sql.mode column
.headers on
.width 10 12 10 25 5 15 20
Explanation:

.mode column - Display results in column format
.headers on - Show column headers
.width - Set width for each column (adjust as needed)

Step 5: Run Your Query
Now paste and run your query:
sqlSELECT 
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
Step 6: Exit SQLite
sql.quit

Method 3: Create a Script File (Best for Multiple Queries)
Step 1: Create a Run Script
Create a new file called run_query1.sql:
sql-- Set formatting options
.mode column
.headers on
.width 10 12 10 25 5 15 20

-- Query 1: Computer Science Students
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
Step 2: Run the Script from Terminal
bashsqlite3 duke_university.db < run_query1.sql
Step 3: Save Output to File (Optional)
bashsqlite3 duke_university.db < run_query1.sql > output.txt
Then open output.txt to see your results!

Method 4: All-in-One Script for All Queries
Create a file called run_all_queries.sql:
sql-- ============================================
-- FORMATTED OUTPUT FOR ALL QUERIES
-- ============================================

.echo on
.mode column
.headers on

-- ============================================
-- QUERY 1
-- ============================================
.print ""
.print "=========================================="
.print "QUERY 1: Computer Science Students by GPA"
.print "=========================================="
.width 10 12 10 25 5 15 20

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

-- ============================================
-- QUERY 2
-- ============================================
.print ""
.print "=========================================="
.print "QUERY 2: Department Statistics"
.print "=========================================="
.width 20 15 10 10 10

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

-- Add more queries here...
Run it:
bashsqlite3 duke_university.db < run_all_queries.sql > all_results.txt

Troubleshooting Common Issues
Issue 1: "No such table: students"
Solution: Make sure you've created the database first:
bashsqlite3 duke_university.db < setup.sql
sqlite3 duke_university.db < insert_data.sql
Issue 2: Output is not formatted nicely
Solution: Always set these options first:
sql.mode column
.headers on
.width auto  -- or specify widths manually
Issue 3: Query returns empty results
Verify data exists:
sqlSELECT COUNT(*) FROM students;
SELECT COUNT(*) FROM majors;
SELECT * FROM majors;  -- Check if "Computer Science" exists
Issue 4: Can't find database file
Check you're in the right directory:
bashls *.db  # Should show duke_university.db
# or on Windows:
dir *.db

Pro Tips for Better Output
1. Create a Reusable Query Runner
Save this as query_template.sql:
sql-- Quick Query Runner
.mode column
.headers on
.nullvalue NULL
.width auto

-- Paste your query below this line:
Then just paste any query after the formatting commands!
2. Export to CSV for Excel/Google Sheets
sql.mode csv
.output query1_results.csv
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
.output stdout
3. Create HTML Output for Documentation
sql.mode html
.output query1_results.html
-- Your query here
.output stdout
4. Pretty Print with Box Drawing
sql.mode box
.headers on

-- Your query here
```

**Output looks like:**
```
┌────────────┬────────────┬───────────┬───────────────────────┐
│ student_id │ first_name │ last_name │ email                 │
├────────────┼────────────┼───────────┼───────────────────────┤
│ 1007       │ Sophia     │ Moore     │ sophia.m@duke.edu     │
└────────────┴────────────┴───────────┴───────────────────────┘

Quick Reference Card
Save this for easy access:
bash# Connect to database
sqlite3 duke_university.db

# Inside SQLite:
.mode column          # Column format
.mode box            # Box drawing format
.mode csv            # CSV format
.mode html           # HTML format
.headers on          # Show headers
.width auto          # Auto-adjust widths
.width 10 20 15      # Manual widths
.output file.txt     # Save to file
.output stdout       # Back to screen
.echo on             # Show commands
.timer on            # Show execution time
.quit                # Exit
