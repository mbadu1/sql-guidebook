
-- basic student information
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    graduation_year INTEGER NOT NULL,
    gpa REAL CHECK(gpa >= 0.0 AND gpa <= 4.0),
    enrollment_date DATE NOT NULL,
    major_id INTEGER,
    FOREIGN KEY (major_id) REFERENCES majors(major_id)
);


--  academic majors and their departments
CREATE TABLE majors (
    major_id INTEGER PRIMARY KEY,
    major_name TEXT NOT NULL UNIQUE,
    department TEXT NOT NULL,
    required_credits INTEGER NOT NULL
);


-- Stores course information
CREATE TABLE courses (
    course_id TEXT PRIMARY KEY,
    course_name TEXT NOT NULL,
    department TEXT NOT NULL,
    credits INTEGER NOT NULL,
    professor TEXT NOT NULL,
    semester TEXT NOT NULL
);


-- Links students to courses
CREATE TABLE enrollments (
    enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    course_id TEXT NOT NULL,
    semester TEXT NOT NULL,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);


-- Stores grades for student enrollments
CREATE TABLE grades (
    grade_id INTEGER PRIMARY KEY AUTOINCREMENT,
    enrollment_id INTEGER NOT NULL,
    grade TEXT CHECK(grade IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'F')),
    grade_points REAL,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);


-- Stores student organization information
CREATE TABLE clubs (
    club_id INTEGER PRIMARY KEY,
    club_name TEXT NOT NULL UNIQUE,
    category TEXT NOT NULL,
    founded_year INTEGER,
    budget REAL
);



-- Links students to clubs
CREATE TABLE club_memberships (
    membership_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    club_id INTEGER NOT NULL,
    position TEXT DEFAULT 'Member',
    join_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (club_id) REFERENCES clubs(club_id)
);