-- Teachers Table
CREATE TABLE Teachers (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    email VARCHAR(50) UNIQUE
);

-- TeacherDetails Table (One-to-One Relationship)
CREATE TABLE TeacherDetails (
    id INT PRIMARY KEY,
    teacher_id INT UNIQUE,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(id),
    fname VARCHAR(50),
    lname VARCHAR(50),
    birthDay DATE
);

-- Courses Table (One-to-Many Relationship)
CREATE TABLE Courses (
    id INT PRIMARY KEY,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(id),
    Title VARCHAR(50),
    price INT,
    expectedDuration_months INT
);

-- Students Table
CREATE TABLE Students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

-- students_courses Table (Many-to-Many Relationship)
CREATE TABLE students_courses (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(id),
    FOREIGN KEY (course_id) REFERENCES Courses(id)
);

-- Inserting Data into Teachers Table
INSERT INTO Teachers (id, name, salary, email) VALUES 
(1, 'ayman', 550, 'ayman@gmail.com'),
(2, 'hala', 600, 'hala@gmail.com'),
(3, 'enas', 800, 'enas@gmail.com');

-- Inserting Data into TeacherDetails Table
INSERT INTO TeacherDetails (id, teacher_id, fname, lname, birthDay) VALUES 
(1, 1, 'ayman', 'jaradat', '1999-01-01'),
(2, 2, 'hala', 'bani hamad', '2001-01-01'),
(3, 3, 'enas', 'bani salameh', '2001-01-01');

-- Inserting Data into Courses Table
INSERT INTO Courses (id, teacher_id, Title, price, expectedDuration_months) VALUES 
(1, 1, 'c sharp', 200, 3),
(2, 2, 'c++', 250, 2),
(3, 3, 'java script', 300, 5);

-- Inserting Data into Students Table
INSERT INTO Students (id, name, age) VALUES 
(1, 'sure', 24),
(2, 'sara', 22),
(3, 'sajeda', 26);