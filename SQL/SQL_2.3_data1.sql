-- ================================================================
-- 1. TẠO 10 USER & STUDENT (ID từ 1001 -> 1010)
-- ================================================================
INSERT INTO Users (ID, Username, User_Password, Email, Sex, Create_Dated, First_Name, Last_Name) VALUES 
(1001, 'user_pro', 'pass', 'pro@test.com', 'Male', NOW(), 'Kevin', 'De Bruyne'),      -- Xuất sắc
(1002, 'user_grind', 'pass', 'grind@test.com', 'Female', NOW(), 'Bruno', 'Fernandes'),-- Cày cuốc (Làm nhiều lần)
(1003, 'user_avg', 'pass', 'avg@test.com', 'Male', NOW(), 'Harry', 'Maguire'),        -- Trung bình
(1004, 'user_lazy', 'pass', 'lazy@test.com', 'Female', NOW(), 'Luke', 'Shaw'),        -- Lười (Làm thiếu bài)
(1005, 'user_fail', 'pass', 'fail@test.com', 'Male', NOW(), 'Antony', 'Santos'),      -- Điểm thấp
(1006, 'user_fast', 'pass', 'fast@test.com', 'Female', NOW(), 'Marcus', 'Rashford'),  -- Làm siêu nhanh
(1007, 'user_slow', 'pass', 'slow@test.com', 'Male', NOW(), 'Casemiro', 'Carlos'),    -- Làm siêu chậm
(1008, 'user_new', 'pass', 'new@test.com', 'Female', NOW(), 'Kobbie', 'Mainoo'),      -- Mới làm 1 bài
(1009, 'user_retry', 'pass', 'retry@test.com', 'Male', NOW(), 'Rasmus', 'Hojlund'),   -- Thử lại nhiều lần vẫn thấp
(1010, 'user_ghost', 'pass', 'ghost@test.com', 'Female', NOW(), 'Mason', 'Mount');    -- Không làm gì cả

-- Insert vào bảng Student
INSERT INTO Student (ID, Date_of_birth) VALUES 
(1001, '1995-01-01'), (1002, '1996-02-02'), (1003, '1993-03-03'), (1004, '1995-04-04'), (1005, '2000-05-05'),
(1006, '1997-06-06'), (1007, '1992-07-07'), (1008, '2005-08-08'), (1009, '2003-09-09'), (1010, '1999-10-10');

-- ================================================================
-- 2. GHI DANH VÀO KHÓA DATABASE (ID 700000)
-- Enroll_ID từ 5001 -> 5010
-- ================================================================
INSERT INTO Enrollment (Enroll_ID, Enroll_date, Student_ID, Course_ID) VALUES
(5001, DATE_SUB(NOW(), INTERVAL 10 DAY), 1001, 700000),
(5002, DATE_SUB(NOW(), INTERVAL 9 DAY), 1002, 700000),
(5003, DATE_SUB(NOW(), INTERVAL 8 DAY), 1003, 700000),
(5004, DATE_SUB(NOW(), INTERVAL 7 DAY), 1004, 700000),
(5005, DATE_SUB(NOW(), INTERVAL 6 DAY), 1005, 700000),
(5006, DATE_SUB(NOW(), INTERVAL 5 DAY), 1006, 700000),
(5007, DATE_SUB(NOW(), INTERVAL 4 DAY), 1007, 700000),
(5008, DATE_SUB(NOW(), INTERVAL 3 DAY), 1008, 700000),
(5009, DATE_SUB(NOW(), INTERVAL 2 DAY), 1009, 700000),
(5010, DATE_SUB(NOW(), INTERVAL 1 DAY), 1010, 700000);

-- ================================================================
-- 3. GIẢ LẬP QUÁ TRÌNH HỌC (Make_Progress)
-- ================================================================

INSERT INTO Make_Progress (Enroll_ID, Learning_Item_ID, Learning_Item_Module_Title, Learning_Item_Course_ID, Score, Completion_Time) VALUES 
(5001, 70003, 'Core Concepts & ER Diagrams', 700000, 10.0, '00:10:00'),
(5001, 70007, 'Basic SQL Queries', 700000, 10.0, '00:15:00');
INSERT INTO Make_Progress (Enroll_ID, Learning_Item_ID, Learning_Item_Module_Title, Learning_Item_Course_ID, Score, Completion_Time) VALUES 
(5001, 70008, 'Basic SQL Queries', 700000, 10.0, '00:15:00'),
(5001, 70009, 'Basic SQL Queries', 700000, 9.5, '00:20:00'),
(5001, 70010, 'Basic SQL Queries', 700000, 10.0, '00:45:00');

INSERT INTO Make_Progress (Enroll_ID, Learning_Item_ID, Learning_Item_Module_Title, Learning_Item_Course_ID, Score, Completion_Time) VALUES 
(5002, 70003, 'Core Concepts & ER Diagrams', 700000, 5.0, '00:12:00'), -- Lần 1 thấp
(5002, 70003, 'Core Concepts & ER Diagrams', 700000, 9.0, '00:09:00'), -- Lần 2 cao (Hệ thống phải lấy số này)
(5002, 70007, 'Basic SQL Queries', 700000, 8.0, '00:20:00');
INSERT INTO Make_Progress (Enroll_ID, Learning_Item_ID, Learning_Item_Module_Title, Learning_Item_Course_ID, Score, Completion_Time) VALUES 
(5002, 70008, 'Basic SQL Queries', 700000, 8.0, '00:18:00'),
(5002, 70009, 'Basic SQL Queries', 700000, 8.5, '00:22:00'),
(5002, 70010, 'Basic SQL Queries', 700000, 7.5, '00:55:00');

INSERT INTO Make_Progress (Enroll_ID, Learning_Item_ID, Learning_Item_Module_Title, Learning_Item_Course_ID, Score, Completion_Time) VALUES 
(5003, 70003, 'Core Concepts & ER Diagrams', 700000, 7.0, '00:18:00'),
(5003, 70007, 'Basic SQL Queries', 700000, 7.0, '00:25:00');
INSERT INTO Make_Progress (Enroll_ID, Learning_Item_ID, Learning_Item_Module_Title, Learning_Item_Course_ID, Score, Completion_Time) VALUES 
(5003, 70008, 'Basic SQL Queries', 700000, 6.5, '00:20:00');

INSERT INTO Make_Progress (Enroll_ID, Learning_Item_ID, Learning_Item_Module_Title, Learning_Item_Course_ID, Score, Completion_Time) VALUES 
(5004, 70003, 'Core Concepts & ER Diagrams', 700000, 8.0, '00:14:00');

INSERT INTO Make_Progress (Enroll_ID, Learning_Item_ID, Learning_Item_Module_Title, Learning_Item_Course_ID, Score, Completion_Time) VALUES 
(5005, 70003, 'Core Concepts & ER Diagrams', 700000, 4.0, '00:15:00'),
(5005, 70007, 'Basic SQL Queries', 700000, 5.0, '00:15:00');

INSERT INTO Make_Progress (Enroll_ID, Learning_Item_ID, Learning_Item_Module_Title, Learning_Item_Course_ID, Score, Completion_Time) VALUES 
(5006, 70003, 'Core Concepts & ER Diagrams', 700000, 8.5, '00:05:00'),
(5006, 70007, 'Basic SQL Queries', 700000, 8.0, '00:08:00');
INSERT INTO Make_Progress (Enroll_ID, Learning_Item_ID, Learning_Item_Module_Title, Learning_Item_Course_ID, Score, Completion_Time) VALUES 
(5006, 70008, 'Basic SQL Queries', 700000, 8.0, '00:08:00'),
(5006, 70009, 'Basic SQL Queries', 700000, 8.0, '00:10:00'),
(5006, 70010, 'Basic SQL Queries', 700000, 9.0, '00:30:00');

INSERT INTO Make_Progress (Enroll_ID, Learning_Item_ID, Learning_Item_Module_Title, Learning_Item_Course_ID, Score, Completion_Time) VALUES 
(5007, 70003, 'Core Concepts & ER Diagrams', 700000, 8.0, '00:45:00'),
(5007, 70007, 'Basic SQL Queries', 700000, 8.5, '01:00:00');

INSERT INTO Make_Progress (Enroll_ID, Learning_Item_ID, Learning_Item_Module_Title, Learning_Item_Course_ID, Score, Completion_Time) VALUES 
(5008, 70003, 'Core Concepts & ER Diagrams', 700000, 6.0, '00:20:00');

INSERT INTO Make_Progress (Enroll_ID, Learning_Item_ID, Learning_Item_Module_Title, Learning_Item_Course_ID, Score, Completion_Time) VALUES 
(5009, 70003, 'Core Concepts & ER Diagrams', 700000, 2.0, '00:10:00'),
(5009, 70003, 'Core Concepts & ER Diagrams', 700000, 3.0, '00:12:00'),
(5009, 70003, 'Core Concepts & ER Diagrams', 700000, 4.0, '00:15:00');

-- 10. Mason (Ghost): Enroll_ID 5010 -> Không có dữ liệu trong Make_Progress 