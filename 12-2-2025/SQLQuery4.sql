
--Attributes: ID, Name, Description.
create table Categories (
ID int primary key identity,
Name varchar(50) not null,
Description varchar(100)
)

--Attributes: ID, Title, Author, Genre, Publication Year, and Availability Status
create table Books (
ID int primary key identity,
Title varchar(100) not null,
Genre varchar(50),
Publication_Year int,
Availability_Status bit,
--- one to many relationship between Books and catigories
Category_id int,
FOREIGN KEY (Category_id) REFERENCES Categories(ID)
)


--Attributes: ID, Name, Contact Information, Membership Type (Student, Teacher, Visitor), Registration Date.
create table Members (
ID int primary key identity,
Name varchar(50) not null,
Contact_Information varchar(100),
Membership_Type varchar(50),
Registration_Date date
)

-- Junction Table:Members and Books (many to many relationship)
--Attributes: ID, Member ID (FK), Book ID (FK), Borrowing date, due date, return date. 
CREATE TABLE Borrowing (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Member_ID INT NOT NULL,
    Book_ID INT NOT NULL,
    Borrowing_Date DATE NOT NULL,
    Due_Date DATE NOT NULL,
    Return_Date DATE NULL, -- Allows NULL for books not yet returned
    FOREIGN KEY (Member_ID) REFERENCES Members(ID) ON DELETE CASCADE,
    FOREIGN KEY (Book_ID) REFERENCES Books(ID) ON DELETE CASCADE
);


-- Junction Table:Members and Books (many to many relationship)
--Attributes: ID, Member ID (FK), Book ID (FK), Reservation Date, Status (Pending, Cancelled, Completed).
CREATE TABLE Reservation (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Member_ID INT NOT NULL,
    Book_ID INT NOT NULL,
    Reservation_Date DATE NOT NULL,
    Status VARCHAR(10) CHECK (Status IN ('Pending', 'Cancelled', 'Completed')) NOT NULL,
    FOREIGN KEY (Member_ID) REFERENCES Members(ID) ON DELETE CASCADE,
    FOREIGN KEY (Book_ID) REFERENCES Books(ID) ON DELETE CASCADE
);


--Attributes: ID, Name, Contact Info, Assigned Section, Employment Date.
CREATE TABLE Staff (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    Contact_Information VARCHAR(100),
    Assigned_Section VARCHAR(50),
    Employment_Date DATE NOT NULL
);



--Financial fines :Attributes: ID, Amount, Payment Status (Paid, Unpaid).
CREATE TABLE Financial_fines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Amount DECIMAL(10,2) NOT NULL,
    Payment_Status VARCHAR(50) NOT NULL CHECK (Payment_Status IN ('Paid', 'Unpaid')),
    Borrowing_ID INT UNIQUE NOT NULL,
    FOREIGN KEY (Borrowing_ID) REFERENCES Borrowing(ID) ON DELETE CASCADE
);




insert into Categories ( Name , Description)
values 
('Fiction', 'Books that contain fictional stories'),
('Non-Fiction', 'Books based on real facts and events'),
('Science', 'Books related to scientific topics'),
('History', 'Books about historical events and figures'),
('Technology', 'Books covering technology and computing');


-- Inserting 5 rows into Books
INSERT INTO Books (Title, Genre, Publication_Year, Availability_Status, Category_ID) 
VALUES 
('The Great Gatsby', 'Fiction', 1925, 1, 1),
('A Brief History of Time', 'Science', 1988, 1, 3),
('Sapiens: A Brief History of Humankind', 'History', 2011, 1, 4),
('Clean Code', 'Technology', 2008, 1, 5),
('Educated: A Memoir', 'Non-Fiction', 2018, 0, 2);

-- Inserting 5 rows into Members
INSERT INTO Members (Name, Contact_Information, Membership_Type, Registration_Date) 
VALUES 
('Alice Johnson', 'alice@example.com', 'Student', '2023-06-15'),
('John Smith', 'john.smith@example.com', 'Teacher', '2022-08-21'),
('Sarah Miller', 'sarah.miller@example.com', 'Visitor', '2024-01-10'),
('David Brown', 'david.brown@example.com', 'Student', '2023-09-05'),
('Emma Wilson', 'emma.wilson@example.com', 'Teacher', '2021-12-30');

INSERT INTO Borrowing (Member_ID, Book_ID, Borrowing_Date, Due_Date, Return_Date) 
VALUES 
(1, 3, '2024-02-01', '2024-02-15', NULL), -- Not returned yet
(2, 1, '2024-01-10', '2024-01-25', '2024-01-20'), -- Returned early
(3, 2, '2024-01-05', '2024-01-20', NULL), -- Still borrowed
(4, 4, '2024-02-05', '2024-02-19', '2024-02-18'), -- Returned on time
(5, 5, '2024-01-25', '2024-02-10', NULL); -- Overdue (not returned yet)


INSERT INTO Reservation (Member_ID, Book_ID, Reservation_Date, Status) 
VALUES 
(1, 2, '2024-02-10', 'Pending'),
(3, 4, '2024-01-20', 'Completed'),
(5, 1, '2024-02-05', 'Cancelled'),
(2, 3, '2024-01-25', 'Pending'),
(4, 5, '2024-02-15', 'Completed');


INSERT INTO Staff (Name, Contact_Information, Assigned_Section, Employment_Date) 
VALUES 
('James Walker', 'james.walker@example.com', 'HR', '2021-05-15'),
('Sophia Green', 'sophia.green@example.com', 'IT', '2022-09-10'),
('Michael Davis', 'michael.davis@example.com', 'Finance', '2023-01-18'),
('Olivia Taylor', 'olivia.taylor@example.com', 'Admin', '2020-03-22'),
('Ethan Harris', 'ethan.harris@example.com', 'IT', '2022-11-01');

INSERT INTO Financial_fines (Amount, Payment_Status, Borrowing_ID)
VALUES 
(15.50, 'Unpaid', 1),
(5.00, 'Paid', 2),
(20.00, 'Unpaid', 3),
(10.75, 'Paid', 4),
(7.50, 'Unpaid', 5);

-- Select all rows from the Categories table
SELECT * FROM Categories;

-- Select all rows from the Books table
SELECT * FROM Books;

-- Select all rows from the Members table
SELECT * FROM Members;

-- Select all rows from the Borrowing table
SELECT * FROM Borrowing;

-- Select all rows from the Reservation table
SELECT * FROM Reservation;

-- Select all rows from the Staff table
SELECT * FROM Staff;

-- Select all rows from the Financial_fines table
SELECT * FROM Financial_fines;


--Write an SQL query to find all members who registered on 2021-12-30.
select * 
from Members 
where Members.Registration_Date = '2021-12-30'

--Write an SQL query to retrieve all details of a book titled "Database Fundamentals".
select * 
from Books 
where Books.Title = 'The Great Gatsby'

--The Members table is missing an Phone_number column. Write an SQL query to add an Phone_number column with a data type suitable for Phone_number
alter table Members 
add Phone_number varchar(10)

SELECT * FROM Members;

--Write an SQL query to insert a new member with the following details:
INSERT INTO Members (Name, Contact_Information, Membership_Type, Registration_Date ,Phone_number) 
VALUES 
('Omar', 'Omar@gmail.com', 'Student', '2024-06-05', '0781509970');

SELECT * FROM Members;

--5. Select members who have reservations in the system
--Write an SQL query to find all members who have made a book reservation.

SELECT * FROM Reservation;
SELECT * FROM Members;

select * 
from Members
inner join Reservation on Members.ID= Reservation.Member_ID
inner join Books on Reservation.Book_ID = Books.ID

--6. Select members who have borrowed a specific book
--Write an SQL query to find members who have borrowed the book titled "SQL for Beginners".

SELECT * FROM Borrowing;
SELECT * FROM Members;
SELECT * FROM Books;

select * 
from Members
inner join Borrowing on Members.ID= Borrowing.Member_ID
inner join Books on Borrowing.Book_ID = Books.ID
where Books.Title='Clean Code'


--. Select members who have borrowed and returned a specific book
--Write an SQL query to find all members who have borrowed and returned the book titled 'Clean Code'
select * 
from Members
inner join Borrowing on Members.ID= Borrowing.Member_ID
inner join Books on Borrowing.Book_ID = Books.ID
where Books.Title='Clean Code' and Borrowing.Return_Date is not null 


--Write an SQL query to find members who have returned books after the due date.

INSERT INTO Borrowing (Member_ID, Book_ID, Borrowing_Date, Due_Date, Return_Date) 
VALUES 
(1, 3, '2024-02-01', '2024-02-15', '2024-02-16') 
select * from Borrowing


select * 
from Members
inner join Borrowing on Members.ID= Borrowing.Member_ID
inner join Books on Borrowing.Book_ID = Books.ID
where Borrowing.Due_Date < Borrowing.Return_Date

--. Select books borrowed more than 1 times
--Write an SQL query to find books that have been borrowed more than 3 times.
SELECT book_id, COUNT(*) AS borrow_count
FROM Borrowing
GROUP BY book_id
HAVING COUNT(*) > 1;



--Find members who have borrowed books between two dates
--Write an SQL query to find members who have borrowed a book between 10-2 and 15-2
select * from Borrowing

select * 
from Members
inner join Borrowing on Members.ID= Borrowing.Member_ID
inner join Books on Borrowing.Book_ID = Books.ID
where Borrowing.Borrowing_Date >= '2024-01-10' and Borrowing.Borrowing_Date <= '2024-02-05' ;

--11. Count the total number of books in the library
--Write an SQL query to count the total number of books available in the library.
select COUNT(*) as Total_Books from Books
