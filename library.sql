CREATE DATABASE IF NOT EXISTS library;
USE library;

CREATE TABLE IF NOT EXISTS BRANCH (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(200),
    Contact_no VARCHAR(12)
);

CREATE TABLE IF NOT EXISTS Employee (
    Emp_id INT PRIMARY KEY,
    emp_name VARCHAR(250),
    Position VARCHAR(230),
    Salary INT,
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES BRANCH(Branch_no)
);

CREATE TABLE IF NOT EXISTS Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(250),
    Customer_address VARCHAR(200),
    Reg_date DATE
);

CREATE TABLE IF NOT EXISTS IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(250),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Isbn_book) REFERENCES BOOKS(ISBN),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id)
);

CREATE TABLE IF NOT EXISTS ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Isbn_book2) REFERENCES BOOKS(ISBN),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id)
);

CREATE TABLE IF NOT EXISTS BOOKS (
    ISBN INT PRIMARY KEY,
    Book_Title VARCHAR(250),
    Category VARCHAR(250),
    Rental_Price INT,
    Status ENUM('Yes', 'No'),
    Author VARCHAR(250),
    Publisher VARCHAR(250)
);

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) 
VALUES
(1, 101, '123 Main Street', '123-456-7890'),
(2, 102, '456 Elm Street', '987-654-3210'),
(3, 103, '789 Oak Street', '456-789-0123'),
(4, 104, '321 Pine Street', '789-012-3456'),
(5, 105, '654 Maple Street', '012-345-6789');
SELECT * FROM Branch;

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) 
VALUES
(201, 'Jack', 'Manager', 60000, 1),
(202, 'Smith', 'Assistant Manager', 50000, 1),
(203, 'Zain', 'Clerk', 42000, 2),
(204, 'Ann', 'Manager', 65000, 3),
(205, 'David', 'Peon', 32000, 4);
SELECT * FROM Employee;

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) 
VALUES
(301, 'Michael Brown', '123 Park Ave', '2021-06-15'),
(302, 'Jennifer Lee', '456 Lake St', '2021-07-20'),
(303, 'William Taylor', '789 Forest Rd', '2021-08-10'),
(304, 'Elizabeth Wilson', '321 Hillside Ave', '2021-09-05'),
(305, 'Christopher Martinez', '654 River Rd', '2021-10-15'),
(306, 'Amanda Davis', '987 Ocean Blvd', '2021-11-20'),
(307, 'Daniel Anderson', '159 Mountain View Dr', '2021-12-10'),
(308, 'Megan Thomas', '357 Sunset Blvd', '2022-01-05'),
(309, 'Matthew Rodriguez', '753 Sunrise Ave', '2022-02-20'),
(310, 'Samantha Garcia', '258 Beach Blvd', '2022-03-15');

INSERT INTO Books (ISBN, Book_Title, Category, Rental_Price, Status, Author, Publisher) 
VALUES
(101, 'Book1', 'Fiction', 10.00, 'Yes', 'John Author', 'Publisher1'),
(102, 'Book2', 'Non-fiction', 12.00, 'Yes', 'Jane Author', 'Publisher2'),
(103, 'Book3', 'History', 15.00, 'No', 'Alice Author', 'Publisher3'),
(104, 'Book4', 'Science', 18.00, 'Yes', 'Bob Author', 'Publisher4'),
(105, 'Book5', 'Fiction', 10.00, 'Yes', 'Charlie Author', 'Publisher5'),
(106, 'Book6', 'Non-fiction', 12.00, 'No', 'David Author', 'Publisher6'),
(107, 'Book7', 'History', 15.00, 'Yes', 'Emily Author', 'Publisher7'),
(108, 'Book8', 'Science', 18.00, 'No', 'Frank Author', 'Publisher8'),
(109, 'Book9', 'Fiction', 10.00, 'Yes', 'Grace Author', 'Publisher9'),
(110, 'Book10', 'Non-fiction', 12.00, 'No', 'Henry Author', 'Publisher10');

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) 
VALUES
(401, 301, 'Book1', '2023-01-10', 101),
(402, 302, 'Book2', '2023-02-15', 102),
(403, 304, 'Book4', '2023-04-25', 104),
(404, 305, 'Book5', '2023-05-30', 105),
(405, 306, 'Book6', '2023-06-05', 106),
(406, 307, 'Book7', '2023-07-10', 107),
(407, 308, 'Book8', '2023-08-15', 108),
(408, 309, 'Book9', '2023-09-20', 109),
(409, 310, 'Book10', '2023-10-25', 110);

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
(501, 301, 'Book1', '2023-01-20', 101),
(502, 302, 'Book2', '2023-02-25', 102),
(503, 303, 'Book3', '2023-03-30', 103),
(504, 304, 'Book4', '2023-04-05', 104),
(505, 305, 'Book5', '2023-05-10', 105),
(506, 306, 'Book6', '2023-06-15', 106),
(507, 307, 'Book7', '2023-07-20', 107),
(508, 308, 'Book8', '2023-08-25', 108),
(509, 309, 'Book9', '2023-09-30', 109),
(510, 310, 'Book10', '2023-10-05', 110);

SELECT Branch_no, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY Branch_no
HAVING EmployeeCount > 5;

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'Yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT b.Book_title, i.Issued_cust, c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

SELECT Category, COUNT(*) AS TotalBooks
FROM Books
GROUP BY Category;

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

SELECT c.Customer_name
FROM Customer c
LEFT JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE c.Reg_date < '2022-01-01' AND i.Issue_Id IS NULL;

SELECT Branch_no, COUNT(*) AS TotalEmployees
FROM Employee E
GROUP BY Branch_no;

SELECT DISTINCT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE YEAR(i.Issue_date) = 2023 AND MONTH(i.Issue_date) = 6;

SELECT Book_title
FROM Books
WHERE Category = 'History';

SELECT Branch_no, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY Branch_no
HAVING EmployeeCount > 5;
