

CREATE DATABASE university;

DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Instructors;

CREATE TABLE Instructors (
    InstructorID SERIAL PRIMARY KEY,    -- SERIAL: PostgreSQL's way to auto-increment integers for unique IDs. PRIMARY KEY ensures unique, non-null identification for each instructor.
    FirstName VARCHAR(100) NOT NULL,    -- VARCHAR(100): Stores variable-length strings up to 100 characters. NOT NULL means this field cannot be empty.
    LastName VARCHAR(100) NOT NULL,     -- Last name of the instructor.
    Department VARCHAR(100) NOT NULL,   -- Department the instructor belongs to.
    Email VARCHAR(255) UNIQUE           -- UNIQUE: Ensures every email address is distinct across all instructors.
);

CREATE TABLE Instructors (
    InstructorID SERIAL PRIMARY KEY,    -- SERIAL: PostgreSQL's way to auto-increment integers for unique IDs. PRIMARY KEY ensures unique, non-null identification for each instructor.
    FirstName VARCHAR(100) NOT NULL,    -- VARCHAR(100): Stores variable-length strings up to 100 characters. NOT NULL means this field cannot be empty.
    LastName VARCHAR(100) NOT NULL,     -- Last name of the instructor.
    Department VARCHAR(100) NOT NULL,   -- Department the instructor belongs to.
    Email VARCHAR(255) UNIQUE           -- UNIQUE: Ensures every email address is distinct across all instructors.
);

CREATE TABLE Students (
    StudentID SERIAL PRIMARY KEY,       -- Unique student identifier.
    FirstName VARCHAR(100) NOT NULL,    -- Student's first name.
    LastName VARCHAR(100) NOT NULL,     -- Student's last name.
    DateOfBirth DATE,                   -- DATE: Stores dates (YYYY-MM-DD). Useful for age calculations or demographic analysis.
    Email VARCHAR(255) UNIQUE           -- Unique email address for each student.
);

CREATE TABLE Courses (
    CourseID VARCHAR(20) PRIMARY KEY,   -- Unique identifier for each course (e.g., 'CS101', 'PHY201').
    CourseName VARCHAR(255) NOT NULL,   -- Full name of the course.
    Credits INT NOT NULL,               -- Number of academic credits for the course.
    Department VARCHAR(100) NOT NULL,   -- Department offering the course.
    InstructorID INT,                   -- This is the FOREIGN KEY. It refers to InstructorID in the Instructors table.
    CONSTRAINT fk_instructor            -- Naming the foreign key constraint.
        FOREIGN KEY (InstructorID)      -- Specifies which column in THIS table is the foreign key.
        REFERENCES Instructors(InstructorID) -- Specifies which table and column it refers to.
        ON DELETE SET NULL              -- Action when a referenced instructor is deleted: set this Course's InstructorID to NULL.
);


CREATE TABLE Enrollments (
    EnrollmentID SERIAL PRIMARY KEY,    -- Unique ID for each enrollment record.
    StudentID INT NOT NULL,             -- FOREIGN KEY referencing StudentID in the Students table.
    CourseID VARCHAR(20) NOT NULL,      -- FOREIGN KEY referencing CourseID in the Courses table.
    Grade VARCHAR(5),                   -- Grade received (e.g., 'A', 'B+', 'C-'). Can be NULL if the course is ongoing.
    Semester VARCHAR(50) NOT NULL,      -- Semester of enrollment (e.g., 'Fall 2024', 'Spring 2025').
    EnrollmentDate DATE DEFAULT CURRENT_DATE, -- DATE DEFAULT CURRENT_DATE: Automatically sets the enrollment date to today's date if not specified.
    CONSTRAINT fk_student               -- Naming the foreign key constraint for students.
        FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID)
        ON DELETE CASCADE,              -- ON DELETE CASCADE: If a student record is deleted, all their associated enrollments are also deleted.
    CONSTRAINT fk_course                -- Naming the foreign key constraint for courses.
        FOREIGN KEY (CourseID)
        REFERENCES Courses(CourseID)
        ON DELETE CASCADE               -- ON DELETE CASCADE: If a course record is deleted, all its associated enrollments are also deleted.
);

- =============================================================================
-- SECTION 2: DATA INSERTION (DML - Data Manipulation Language)
-- =============================================================================

-- DML statements are used to add, modify, or delete data within the tables.

-- Question: How do we put data into our newly created tables?
-- Answer: We use the INSERT INTO statement.

-- Inserting sample data into the 'Instructors' table
-- Using Indian-sounding names for better relatability.
INSERT INTO Instructors (InstructorID, FirstName, LastName, Department, Email) VALUES
(1, 'Dr. Anand', 'Rao', 'Computer Science', 'anand.r@university.edu'),
(2, 'Prof. Neha', 'Gupta', 'Physics', 'neha.g@university.edu'),
(3, 'Dr. Vivek', 'Singh', 'Mathematics', 'vivek.s@university.edu'),
(4, 'Dr. Priya', 'Sharma', 'Computer Science', 'priya.s@university.edu'),
(5, 'Prof. Rohan', 'Joshi', 'Chemistry', 'rohan.j@university.edu'),
(6, 'Dr. Sneha', 'Reddy', 'Biology', 'sneha.r@university.edu'),
(7, 'Prof. Arjun', 'Kumar', 'Mathematics', 'arjun.k@university.edu'),
(8, 'Dr. Aditi', 'Verma', 'History', 'aditi.v@university.edu'); -- Added an extra instructor for more diversity

-- Inserting sample data into the 'Students' table
-- Using Indian-sounding names.
INSERT INTO Students (StudentID, FirstName, LastName, DateOfBirth, Email) VALUES
(101, 'Aakash', 'Sharma', '2003-05-15', 'aakash.s@example.com'),
(102, 'Priya', 'Singh', '2002-11-20', 'priya.s@example.com'),
(103, 'Rohan', 'Mehta', '2004-01-10', 'rohan.m@example.com'),
(104, 'Sneha', 'Reddy', '2003-08-25', 'sneha.r@example.com'),
(105, 'Arjun', 'Kumar', '2002-03-30', 'arjun.k@example.com'),
(106, 'Disha', 'Gupta', '2003-07-12', 'disha.g@example.com'),
(107, 'Vikram', 'Patel', '2004-09-01', 'vikram.p@example.com'),
(108, 'Pooja', 'Sharma', '2003-02-18', 'pooja.s@example.com'),
(109, 'Kabir', 'Khan', '2002-07-05', 'kabir.k@example.com'),
(110, 'Tanya', 'Das', '2004-04-22', 'tanya.d@example.com'),
(111, 'Ishaan', 'Malhotra', '2003-10-08', 'ishaan.m@example.com'),
(112, 'Zoya', 'Ali', '2002-01-14', 'zoya.a@example.com'),
(113, 'Rohan', 'Verma', '2004-06-28', 'rohan.v@example.com'),
(114, 'Nisha', 'Yadav', '2003-12-03', 'nisha.y@example.com'),
(115, 'Aryan', 'Singh', '2002-09-19', 'aryan.s@example.com'),
(116, 'Khushi', 'Agarwal', '2004-02-11', 'khushi.a@example.com'),
(117, 'Rahul', 'Dubey', '2003-04-07', 'rahul.d@example.com'),
(118, 'Simran', 'Kaur', '2002-08-02', 'simran.k@example.com'),
(119, 'Siddharth', 'Mehra', '2004-03-17', 'siddharth.m@example.com'),
(120, 'Divya', 'Rao', '2003-06-29', 'divya.r@example.com'),
(121, 'Harsh', 'Gupta', '2002-05-01', 'harsh.g@example.com'),
(122, 'Meena', 'Devi', '2003-09-10', 'meena.d@example.com'),
(123, 'Gaurav', 'Kumar', '2004-11-05', 'gaurav.k@example.com');

-- Inserting sample data into the 'Courses' table
INSERT INTO Courses (CourseID, CourseName, Credits, Department, InstructorID) VALUES
('CS101', 'Introduction to Programming', 3, 'Computer Science', 1),
('PH201', 'Classical Mechanics', 4, 'Physics', 2),
('MA301', 'Linear Algebra', 3, 'Mathematics', 3),
('CS202', 'Data Structures & Algorithms', 3, 'Computer Science', 1),
('PH301', 'Quantum Physics', 4, 'Physics', 2),
('CH101', 'General Chemistry I', 3, 'Chemistry', 5),
('BI101', 'General Biology I', 3, 'Biology', 6),
('MA401', 'Differential Equations', 4, 'Mathematics', 7),
('CS303', 'Database Systems', 3, 'Computer Science', 4),
('PH202', 'Electromagnetism', 4, 'Physics', 2),
('CH201', 'Organic Chemistry I', 4, 'Chemistry', 5),
('BI201', 'Cell Biology', 3, 'Biology', 6),
('MA302', 'Discrete Mathematics', 3, 'Mathematics', 3),
('CS404', 'Advanced Algorithms', 4, 'Computer Science', 1),
('PH401', 'Thermodynamics', 3, 'Physics', 2),
('HI101', 'Ancient Indian History', 3, 'History', 8),
('HI201', 'Modern Indian History', 3, 'History', 8); -- Added History courses and instructor

-- Inserting extensive sample data into the 'Enrollments' table
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade, Semester, EnrollmentDate) VALUES
(1, 101, 'CS101', 'A', 'Fall 2024', '2024-09-01'),
(2, 102, 'PH201', 'B', 'Fall 2024', '2024-09-01'),
(3, 103, 'MA301', 'A-', 'Fall 2024', '2024-09-02'),
(4, 101, 'CS202', 'B+', 'Fall 2024', '2024-09-02'),
(5, 104, 'CS101', 'C', 'Fall 2024', '2024-09-03'),
(6, 105, 'PH201', 'A', 'Fall 2024', '2024-09-03'),
(7, 101, 'PH301', 'C+', 'Spring 2025', '2025-01-15'),
(8, 102, 'MA301', 'B-', 'Spring 2025', '2025-01-16'),
(9, 106, 'CS101', 'A', 'Spring 2025', '2025-01-17'),
(10, 106, 'CS202', 'B', 'Spring 2025', '2025-01-17'),
(11, 107, 'CH101', 'A', 'Fall 2024', '2024-09-04'),
(12, 108, 'BI101', 'B+', 'Fall 2024', '2024-09-04'),
(13, 109, 'CS101', 'A-', 'Fall 2024', '2024-09-05'),
(14, 110, 'MA301', 'B', 'Fall 2024', '2024-09-05'),
(15, 111, 'CS202', 'C+', 'Fall 2024', '2024-09-06'),
(16, 112, 'PH201', 'B', 'Fall 2024', '2024-09-06'),
(17, 113, 'CH101', 'A', 'Spring 2025', '2025-01-18'),
(18, 114, 'BI101', 'C', 'Spring 2025', '2025-01-18'),
(19, 115, 'MA401', 'B+', 'Spring 2025', '2025-01-19'),
(20, 116, 'CS303', 'A-', 'Spring 2025', '2025-01-19'),
(21, 117, 'PH202', 'B', 'Spring 2025', '2025-01-20'),
(22, 118, 'CH201', 'C+', 'Spring 2025', '2025-01-20'),
(23, 119, 'BI201', 'A', 'Spring 2025', '2025-01-21'),
(24, 120, 'MA302', 'B', 'Spring 2025', '2025-01-21'),
(25, 101, 'MA301', 'B', 'Fall 2024', '2024-09-07'),
(26, 102, 'CS101', 'C', 'Fall 2024', '2024-09-07'),
(27, 103, 'PH201', 'B+', 'Spring 2025', '2025-01-22'),
(28, 104, 'MA301', 'A', 'Spring 2025', '2025-01-22'),
(29, 105, 'CS202', 'B', 'Spring 2025', '2025-01-23'),
(30, 107, 'CS101', 'B', 'Spring 2025', '2025-01-23'),
(31, 108, 'PH201', 'A-', 'Spring 2025', '2025-01-24'),
(32, 109, 'MA301', 'C', 'Spring 2025', '2025-01-24'),
(33, 110, 'CS202', 'B+', 'Spring 2025', '2025-01-25'),
(34, 111, 'PH301', 'A', 'Spring 2025', '2025-01-25'),
(35, 112, 'CH101', 'B-', 'Spring 2025', '2025-01-26'),
(36, 113, 'BI101', 'C+', 'Fall 2024', '2024-09-08'),
(37, 114, 'CS101', 'B', 'Fall 2024', '2024-09-08'),
(38, 115, 'MA301', 'A-', 'Fall 2024', '2024-09-09'),
(39, 116, 'PH201', 'B+', 'Fall 2024', '2024-09-09'),
(40, 117, 'CS202', 'A', 'Fall 2024', '2024-09-10'),
(41, 118, 'MA401', 'B', 'Fall 2024', '2024-09-10'),
(42, 119, 'CS303', 'A', 'Fall 2024', '2024-09-11'),
(43, 120, 'PH202', 'C', 'Fall 2024', '2024-09-11'),
(44, 101, 'MA401', 'A', 'Fall 2024', '2024-09-12'),
(45, 102, 'CS202', 'B', 'Fall 2024', '2024-09-12'),
(46, 103, 'CH101', 'B', 'Fall 2024', '2024-09-13'),
(47, 104, 'BI101', 'A-', 'Fall 2024', '2024-09-13'),
(48, 105, 'MA301', 'C+', 'Spring 2025', '2025-01-27'),
(49, 106, 'PH301', 'B', 'Spring 2025', '2025-01-27'),
(50, 107, 'MA301', 'A', 'Spring 2025', '2025-01-28'),
(51, 110, 'HI101', 'B+', 'Fall 2024', '2024-09-14'), -- New history course enrollment
(52, 111, 'HI201', 'A-', 'Spring 2025', '2025-01-29'),
(53, 112, 'CS101', 'B', 'Spring 2025', '2025-01-30'),
(54, 101, 'CS303', 'A', 'Spring 2025', '2025-01-31'),
(55, 102, 'CS303', 'B+', 'Spring 2025', '2025-02-01'),
(56, 103, 'CS303', 'C', 'Spring 2025', '2025-02-02'),
(57, 104, 'CS202', 'B', 'Spring 2025', '2025-02-03'),
(58, 105, 'PH202', 'A-', 'Spring 2025', '2025-02-04'),
(59, 106, 'CH201', 'B+', 'Spring 2025', '2025-02-05'),
(60, 107, 'BI201', 'A', 'Spring 2025', '2025-02-06');

-- Optional: Resetting SERIAL sequences for tables after explicit inserts, so future SERIAL inserts work correctly.
-- This is crucial if you explicitly provided IDs during initial inserts and then later rely on auto-incrementing.
SELECT setval('instructors_instructorid_seq', (SELECT MAX(InstructorID) FROM Instructors));
SELECT setval('students_studentid_seq', (SELECT MAX(StudentID) FROM Students));
SELECT setval('enrollments_enrollmentid_seq', (SELECT MAX(EnrollmentID) FROM Enrollments));