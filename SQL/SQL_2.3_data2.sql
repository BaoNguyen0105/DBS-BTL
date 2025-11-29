-- ====================================================
-- 1. TẠO GIÁO VIÊN (Dr. Alice Codd ) 
-- ====================================================
INSERT INTO Users (ID, Username, User_Password, Email, Sex, Create_Dated, First_Name, Last_Name) 
VALUES (880, 'alice_sql', 'pass123', 'alice@university.edu', 'Female', NOW(), 'Alice', 'Codd');

INSERT INTO Teacher (ID, Title) VALUES (880, 'Senior Database Architect');

-- ====================================================
-- 2. TẠO KHÓA HỌC (Nhập môn CSDL)
-- ====================================================
INSERT INTO Course (ID, Specialization,  Title, Course_Language, Price, Course_Level, Duration, Teacher_ID, Course_Status) 
VALUES (700000, 'Computer Science' , 'Relational Database Design & SQL Fundamentals', 'English', 'Free', 'Beginner', '4 Weeks', 880, 'Available');

-- ====================================================
-- 3. TẠO MODULES 
-- ====================================================
INSERT INTO Module (Title, Course_ID, Duration) VALUES 
('Core Concepts & ER Diagrams', 700000, '1 Week'),
('Normalization & Integrity', 700000, '1 Week'),
('Basic SQL Queries', 700000, '2 Weeks');

-- ====================================================
-- 4. TẠO LEARNING ITEMS 
-- ====================================================

-- >> Module 1: Core Concepts
INSERT INTO Learning_Item (ID, Module_Title, Course_ID, Item_Order, Content_Type, Title) VALUES 
(70001, 'Core Concepts & ER Diagrams', 700000, 1, 'Video', 'SQL vs NoSQL: What is the difference?'),
(70002, 'Core Concepts & ER Diagrams', 700000, 2, 'Reading', 'Understanding Primary & Foreign Keys'),
(70003, 'Core Concepts & ER Diagrams', 700000, 3, 'Quiz', 'Database Architecture Quiz');

-- >> Module 2: Normalization
INSERT INTO Learning_Item (ID, Module_Title, Course_ID, Item_Order, Content_Type, Title) VALUES 
(70004, 'Normalization & Integrity', 700000, 1, 'Video', 'Database Normalization - 1NF, 2NF, 3NF'),
(70005, 'Normalization & Integrity', 700000, 2, 'Reading', 'The Anomalies: Update, Delete, and Insertion');

-- >> Module 3: Basic SQL
INSERT INTO Learning_Item (ID, Module_Title, Course_ID, Item_Order, Content_Type, Title) VALUES 
(70006, 'Basic SQL Queries', 700000, 1, 'Video', 'SQL Tutorial for Beginners (Full Course)'),
(70007, 'Basic SQL Queries', 700000, 2, 'Quiz', 'SQL Syntax Challenge'), 
(70008, 'Basic SQL Queries', 700000, 3, 'Quiz', 'Advanced Joins & Unions'),
(70009, 'Basic SQL Queries', 700000, 4, 'Quiz', 'Subqueries & CTEs'),
(70010, 'Basic SQL Queries', 700000, 5, 'Quiz', 'Final Exam (Comprehensive)');



-- ====================================================
-- 5. Tạo chi tiết Nội Dung
-- ====================================================

-- 5.1 VIDEO
INSERT INTO Video (ID, Module_Title, Course_ID, URL, Duration) VALUES 
(70001, 'Core Concepts & ER Diagrams', 700000, 'https://www.youtube.com/watch?v=wR0jg0eQsZA', '00:06:45'),
(70004, 'Normalization & Integrity', 700000, 'https://www.youtube.com/watch?v=UrYXuJ5trNA', '00:15:30'),
(70006, 'Basic SQL Queries', 700000, 'https://www.youtube.com/watch?v=7S_tz1z_5bA', '01:00:00');

-- 5.2 READING
INSERT INTO Reading (ID, Module_Title, Course_ID, URL, Content) VALUES 
(70002, 'Core Concepts & ER Diagrams', 700000, 'https://www.geeksforgeeks.org/difference-between-primary-key-and-foreign-key/', 
'A Primary Key is a column or a set of columns that uniquely identifies each row in a table. It cannot accept NULL values. A Foreign Key is a field (or collection of fields) in one table that refers to the Primary Key in another table.'),

(70005, 'Normalization & Integrity', 700000, 'https://www.javatpoint.com/dbms-anomalies', 
'Anomalies are problems that can occur in poorly planned, un-normalized databases where all the data is stored in one table (a flat-file database). There are three types of anomalies: Insertion, Update, and Deletion.');

-- 5.3 QUIZ
INSERT INTO Quiz (ID, Module_Title, Course_ID, Passing_Score, Time_Limit, Max_Attempt) VALUES 
(70003, 'Core Concepts & ER Diagrams', 700000, 7, '00:20:00', 3),
(70007, 'Basic SQL Queries', 700000, 8, '00:30:00', 3),
(70008, 'Basic SQL Queries', 700000, 7, '00:20:00', 3),
(70009, 'Basic SQL Queries', 700000, 7, '00:25:00', 3),
(70010, 'Basic SQL Queries', 700000, 9, '01:00:00', 1); -- Final Exam

-- ====================================================
-- 6. CÂU HỎI (Questions)
-- ====================================================

INSERT INTO Question (Quiz_ID, Q_Module_Title, Q_Course_ID, Question_ID, Question_Text, Question_Point, Q_Answer) VALUES 
-- Quiz 1: Architecture (3 câu)
(70003, 'Core Concepts & ER Diagrams', 700000, 95001, 'Which of the following best describes a Relational Database?', 3.0,  'B'),
(70003, 'Core Concepts & ER Diagrams', 700000, 95002, 'What constraint ensures that a column cannot have NULL values and must be unique?', 3.0,  'A'),
(70003, 'Core Concepts & ER Diagrams', 700000, 95003, 'In an ER Diagram, what does a Diamond shape typically represent?', 4.0, 'C'),

-- Quiz 2: SQL Syntax (2 câu)
(70007, 'Basic SQL Queries', 700000, 95004, 'Which SQL keyword is used to retrieve data from a database?', 5.0,  'A'),
(70007, 'Basic SQL Queries', 700000, 95005, 'What is the correct order of operations in a SQL query?', 5.0,  'D');
INSERT INTO Question (Quiz_ID, Q_Module_Title, Q_Course_ID, Question_ID, Question_Text, Question_Point, Q_Answer) VALUES
(70008, 'Basic SQL Queries', 700000, 96001, 'Question about Inner Join', 10,  'A'),
(70009, 'Basic SQL Queries', 700000, 96002, 'Question about Correlated Subquery', 10,  'B'),
(70010, 'Basic SQL Queries', 700000, 96003, 'Final Exam Question 1', 10,'C');
-- ====================================================
-- 7. ĐÁP ÁN (Question_Option)
-- ====================================================

-- Q1: Relational DB Definition
INSERT INTO Question_Option (Quiz_ID, Q_Module_Title, Q_Course_ID, Question_ID, Option_Label, Option_Text) VALUES 
(70003, 'Core Concepts & ER Diagrams', 700000, 95001, 'A', 'A database that stores data in JSON documents.'),
(70003, 'Core Concepts & ER Diagrams', 700000, 95001, 'B', 'A database that organizes data into tables with rows and columns.'), -- Đúng
(70003, 'Core Concepts & ER Diagrams', 700000, 95001, 'C', 'A database that uses graph structures for nodes and edges.'),
(70003, 'Core Concepts & ER Diagrams', 700000, 95001, 'D', 'A key-value store optimized for caching.');

-- Q2: Constraints
INSERT INTO Question_Option (Quiz_ID, Q_Module_Title, Q_Course_ID, Question_ID, Option_Label, Option_Text) VALUES 
(70003, 'Core Concepts & ER Diagrams', 700000, 95002, 'A', 'PRIMARY KEY'), -- Đúng
(70003, 'Core Concepts & ER Diagrams', 700000, 95002, 'B', 'FOREIGN KEY'),
(70003, 'Core Concepts & ER Diagrams', 700000, 95002, 'C', 'UNIQUE'),
(70003, 'Core Concepts & ER Diagrams', 700000, 95002, 'D', 'CHECK');

-- Q3: ER Diagram Shapes
INSERT INTO Question_Option (Quiz_ID, Q_Module_Title, Q_Course_ID, Question_ID, Option_Label, Option_Text) VALUES 
(70003, 'Core Concepts & ER Diagrams', 700000, 95003, 'A', 'Entity'),
(70003, 'Core Concepts & ER Diagrams', 700000, 95003, 'B', 'Attribute'),
(70003, 'Core Concepts & ER Diagrams', 700000, 95003, 'C', 'Relationship'), -- Đúng
(70003, 'Core Concepts & ER Diagrams', 700000, 95003, 'D', 'Weak Entity');

-- Q4: SQL Keyword
INSERT INTO Question_Option (Quiz_ID, Q_Module_Title, Q_Course_ID, Question_ID, Option_Label, Option_Text) VALUES 
(70007, 'Basic SQL Queries', 700000, 95004, 'A', 'SELECT'), -- Đúng
(70007, 'Basic SQL Queries', 700000, 95004, 'B', 'GET'),
(70007, 'Basic SQL Queries', 700000, 95004, 'C', 'FETCH'),
(70007, 'Basic SQL Queries', 700000, 95004, 'D', 'EXTRACT');

-- Q5: SQL Order
INSERT INTO Question_Option (Quiz_ID, Q_Module_Title, Q_Course_ID, Question_ID, Option_Label, Option_Text) VALUES 
(70007, 'Basic SQL Queries', 700000, 95005, 'A', 'SELECT, GROUP BY, WHERE, ORDER BY'),
(70007, 'Basic SQL Queries', 700000, 95005, 'B', 'SELECT, ORDER BY, WHERE, GROUP BY'),
(70007, 'Basic SQL Queries', 700000, 95005, 'C', 'WHERE, SELECT, GROUP BY, ORDER BY'),
(70007, 'Basic SQL Queries', 700000, 95005, 'D', 'SELECT, WHERE, GROUP BY, ORDER BY'); -- Đúng


INSERT INTO Question_Option (Quiz_ID, Q_Module_Title, Q_Course_ID, Question_ID, Option_Label, Option_Text) VALUES 
(70008, 'Basic SQL Queries', 700000, 96001, 'A', 'INNER JOIN'), -- Đúng
(70008, 'Basic SQL Queries', 700000, 96001, 'B', 'LEFT JOIN'),
(70008, 'Basic SQL Queries', 700000, 96001, 'C', 'RIGHT JOIN'),
(70008, 'Basic SQL Queries', 700000, 96001, 'D', 'FULL OUTER JOIN');

INSERT INTO Question_Option (Quiz_ID, Q_Module_Title, Q_Course_ID, Question_ID, Option_Label, Option_Text) VALUES 
(70009, 'Basic SQL Queries', 700000, 96002, 'A', 'It is executed only once for the entire outer query.'),
(70009, 'Basic SQL Queries', 700000, 96002, 'B', 'It depends on the outer query for its values and executes once for each row selected by the outer query.'), -- Đúng
(70009, 'Basic SQL Queries', 700000, 96002, 'C', 'It must return multiple rows.'),
(70009, 'Basic SQL Queries', 700000, 96002, 'D', 'It cannot contain a WHERE clause.');

INSERT INTO Question_Option (Quiz_ID, Q_Module_Title, Q_Course_ID, Question_ID, Option_Label, Option_Text) VALUES 
(70010, 'Basic SQL Queries', 700000, 96003, 'A', 'DELETE removes the table structure, TRUNCATE keeps it.'),
(70010, 'Basic SQL Queries', 700000, 96003, 'B', 'TRUNCATE can be rolled back easily, DELETE cannot.'),
(70010, 'Basic SQL Queries', 700000, 96003, 'C', 'TRUNCATE is a DDL operation (faster, resets identity), DELETE is DML (slower, logs each row).'), -- Đúng
(70010, 'Basic SQL Queries', 700000, 96003, 'D', 'There is no difference.');