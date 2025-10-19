-- ============================================
-- INSERT DATA: MAJORS
-- ============================================
INSERT INTO majors (major_id, major_name, department, required_credits) VALUES
(1, 'Computer Science', 'Engineering', 120),
(2, 'Economics', 'Social Sciences', 115),
(3, 'Biology', 'Natural Sciences', 120),
(4, 'Psychology', 'Social Sciences', 115),
(5, 'Mathematics', 'Natural Sciences', 120),
(6, 'Public Policy', 'Social Sciences', 115),
(7, 'Mechanical Engineering', 'Engineering', 128),
(8, 'English', 'Humanities', 110);

-- ============================================
-- INSERT DATA: STUDENTS
-- ============================================
INSERT INTO students (student_id, first_name, last_name, email, graduation_year, gpa, enrollment_date, major_id) VALUES
(1001, 'Emma', 'Johnson', 'emma.j@duke.edu', 2025, 3.85, '2021-08-25', 1),
(1002, 'Liam', 'Williams', 'liam.w@duke.edu', 2025, 3.62, '2021-08-25', 2),
(1003, 'Olivia', 'Brown', 'olivia.b@duke.edu', 2026, 3.91, '2022-08-24', 3),
(1004, 'Noah', 'Davis', 'noah.d@duke.edu', 2025, 3.45, '2021-08-25', 1),
(1005, 'Ava', 'Miller', 'ava.m@duke.edu', 2026, 3.78, '2022-08-24', 4),
(1006, 'Ethan', 'Wilson', 'ethan.w@duke.edu', 2025, 3.55, '2021-08-25', 5),
(1007, 'Sophia', 'Moore', 'sophia.m@duke.edu', 2027, 3.95, '2023-08-23', 1),
(1008, 'Mason', 'Taylor', 'mason.t@duke.edu', 2026, 3.33, '2022-08-24', 6),
(1009, 'Isabella', 'Anderson', 'isabella.a@duke.edu', 2025, 3.72, '2021-08-25', 7),
(1010, 'James', 'Thomas', 'james.t@duke.edu', 2027, 3.88, '2023-08-23', 3),
(1011, 'Mia', 'Jackson', 'mia.j@duke.edu', 2026, 3.41, '2022-08-24', 8),
(1012, 'Lucas', 'White', 'lucas.w@duke.edu', 2025, 3.67, '2021-08-25', 2);

-- ============================================
-- INSERT DATA: COURSES
-- ============================================
INSERT INTO courses (course_id, course_name, department, credits, professor, semester) VALUES
('CS101', 'Introduction to Programming', 'Computer Science', 4, 'Dr. Sarah Chen', 'Fall 2024'),
('CS201', 'Data Structures', 'Computer Science', 4, 'Dr. Michael Park', 'Spring 2024'),
('CS301', 'Algorithms', 'Computer Science', 4, 'Dr. Sarah Chen', 'Fall 2024'),
('ECON101', 'Principles of Microeconomics', 'Economics', 3, 'Dr. Robert Smith', 'Fall 2024'),
('ECON201', 'Intermediate Microeconomics', 'Economics', 4, 'Dr. Jennifer Lee', 'Spring 2024'),
('BIO101', 'General Biology', 'Biology', 4, 'Dr. Amanda Green', 'Fall 2024'),
('BIO205', 'Genetics', 'Biology', 4, 'Dr. David Martinez', 'Spring 2024'),
('PSY101', 'Introduction to Psychology', 'Psychology', 3, 'Dr. Lisa Anderson', 'Fall 2024'),
('MATH216', 'Linear Algebra', 'Mathematics', 4, 'Dr. John Wilson', 'Fall 2024'),
('PUBPOL201', 'Policy Analysis', 'Public Policy', 3, 'Dr. Maria Garcia', 'Spring 2024'),
('ME101', 'Engineering Mechanics', 'Mechanical Engineering', 4, 'Dr. Thomas Brown', 'Fall 2024'),
('ENG150', 'Academic Writing', 'English', 3, 'Dr. Emily Taylor', 'Fall 2024');

-- ============================================
-- INSERT DATA: ENROLLMENTS
-- ============================================
INSERT INTO enrollments (student_id, course_id, semester, enrollment_date) VALUES
-- Student 1001 (Emma)
(1001, 'CS301', 'Fall 2024', '2024-08-15'),
(1001, 'MATH216', 'Fall 2024', '2024-08-15'),
(1001, 'ENG150', 'Fall 2024', '2024-08-15'),
-- Student 1002 (Liam)
(1002, 'ECON201', 'Spring 2024', '2024-01-10'),
(1002, 'PSY101', 'Fall 2024', '2024-08-15'),
(1002, 'MATH216', 'Fall 2024', '2024-08-15'),
-- Student 1003 (Olivia)
(1003, 'BIO205', 'Spring 2024', '2024-01-10'),
(1003, 'BIO101', 'Fall 2024', '2024-08-15'),
(1003, 'CS101', 'Fall 2024', '2024-08-15'),
-- Student 1004 (Noah)
(1004, 'CS301', 'Fall 2024', '2024-08-15'),
(1004, 'CS201', 'Spring 2024', '2024-01-10'),
-- Student 1005 (Ava)
(1005, 'PSY101', 'Fall 2024', '2024-08-15'),
(1005, 'BIO101', 'Fall 2024', '2024-08-15'),
-- Student 1006 (Ethan)
(1006, 'MATH216', 'Fall 2024', '2024-08-15'),
(1006, 'CS201', 'Spring 2024', '2024-01-10'),
-- Student 1007 (Sophia)
(1007, 'CS101', 'Fall 2024', '2024-08-15'),
(1007, 'MATH216', 'Fall 2024', '2024-08-15'),
-- Student 1008 (Mason)
(1008, 'PUBPOL201', 'Spring 2024', '2024-01-10'),
(1008, 'ECON101', 'Fall 2024', '2024-08-15'),
-- Student 1009 (Isabella)
(1009, 'ME101', 'Fall 2024', '2024-08-15'),
(1009, 'MATH216', 'Fall 2024', '2024-08-15'),
-- Student 1010 (James)
(1010, 'BIO101', 'Fall 2024', '2024-08-15'),
(1010, 'CS101', 'Fall 2024', '2024-08-15'),
-- Student 1011 (Mia)
(1011, 'ENG150', 'Fall 2024', '2024-08-15'),
(1011, 'PSY101', 'Fall 2024', '2024-08-15'),
-- Student 1012 (Lucas)
(1012, 'ECON201', 'Spring 2024', '2024-01-10'),
(1012, 'ECON101', 'Fall 2024', '2024-08-15');

-- ============================================
-- INSERT DATA: GRADES
-- ============================================
INSERT INTO grades (enrollment_id, grade, grade_points) VALUES
(1, 'A', 4.0),
(2, 'A-', 3.7),
(3, 'B+', 3.3),
(4, 'A-', 3.7),
(5, 'B', 3.0),
(6, 'B+', 3.3),
(7, 'A', 4.0),
(8, 'A+', 4.0),
(9, 'A', 4.0),
(10, 'A-', 3.7),
(11, 'B+', 3.3),
(12, 'B', 3.0),
(13, 'A-', 3.7),
(14, 'B+', 3.3),
(15, 'A', 4.0),
(16, 'B-', 2.7),
(17, 'A', 4.0),
(18, 'A+', 4.0),
(19, 'B+', 3.3),
(20, 'B', 3.0),
(21, 'A-', 3.7),
(22, 'A', 4.0),
(23, 'B', 3.0),
(24, 'B+', 3.3),
(25, 'A-', 3.7),
(26, 'B+', 3.3);

-- ============================================
-- INSERT DATA: CLUBS
-- ============================================
INSERT INTO clubs (club_id, club_name, category, founded_year, budget) VALUES
(1, 'Duke Computer Science Club', 'Academic', 1995, 5000.00),
(2, 'Duke Economics Society', 'Academic', 2000, 3500.00),
(3, 'Duke Hiking Club', 'Recreation', 1998, 2000.00),
(4, 'Duke Debate Team', 'Competition', 1985, 8000.00),
(5, 'Duke Volunteer Corps', 'Service', 1992, 4500.00),
(6, 'Duke Engineering Society', 'Academic', 1988, 6000.00),
(7, 'Duke Photography Club', 'Arts', 2005, 1500.00);

-- ============================================
-- INSERT DATA: CLUB_MEMBERSHIPS
-- ============================================
INSERT INTO club_memberships (student_id, club_id, position, join_date) VALUES
(1001, 1, 'President', '2023-09-01'),
(1001, 4, 'Member', '2022-09-01'),
(1002, 2, 'Vice President', '2022-09-01'),
(1002, 3, 'Member', '2023-09-01'),
(1003, 5, 'Member', '2022-09-01'),
(1004, 1, 'Member', '2021-09-01'),
(1005, 5, 'Treasurer', '2023-09-01'),
(1006, 1, 'Member', '2022-09-01'),
(1007, 1, 'Member', '2023-09-01'),
(1007, 6, 'Member', '2024-01-15'),
(1008, 2, 'Member', '2023-09-01'),
(1009, 6, 'President', '2023-01-15'),
(1010, 5, 'Member', '2023-09-01'),
(1010, 7, 'Secretary', '2024-01-15'),
(1011, 7, 'President', '2024-01-15'),
(1012, 2, 'Member', '2022-09-01');