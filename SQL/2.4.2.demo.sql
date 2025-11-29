-- =========================
-- 1. TEACHER & COURSE
-- =========================

-- Teacher (user đóng vai trò giảng viên)
INSERT INTO Users 
VALUES (30001, 'teacher_rev', 'pw', 't_rev@test.com',
        '000', 'Teach', 'Rev', 'M', '2024-01-01');

INSERT INTO Teacher
VALUES (30001, 'Lecturer');

-- Course demo để test doanh thu
INSERT INTO Course
(ID, Title, Course_Language, Course_Description, Price, 
 Course_Level, Duration, Teacher_ID, Delete_Date, Delete_By, Course_Status)
VALUES
(40001, 'Revenue Demo', 'English', 'Course test doanh thu', '100 USD',
 'Beginner', '5 Weeks', 30001, NULL, NULL, 'Available');

-- =========================
-- 2. STUDENT + ENROLLMENT
-- =========================

-- Student 1: đã trả tiền 100.00 → tính vào doanh thu
INSERT INTO Users
VALUES (31001, 'st_rev1', 'pw', 'st1@test.com',
        '000', 'Stu', 'One', 'F', '2024-01-01');

INSERT INTO Student
VALUES (31001, '2000-01-01', 0, 0);

INSERT INTO Enrollment
VALUES (50001, '2024-01-10', 0, 31001, 40001);

-- Student 2: Payment Pending → KHÔNG tính doanh thu
INSERT INTO Users
VALUES (31002, 'st_rev2', 'pw', 'st2@test.com',
        '000', 'Stu', 'Two', 'F', '2024-01-02');

INSERT INTO Student
VALUES (31002, '2000-02-02', 0, 0);

INSERT INTO Enrollment
VALUES (50002, '2024-01-11', 0, 31002, 40001);

-- Student 3: Payment Paid nhưng Ammount = 'Free' → KHÔNG tính
INSERT INTO Users
VALUES (31003, 'st_rev3', 'pw', 'st3@test.com',
        '000', 'Stu', 'Three', 'M', '2024-01-03');

INSERT INTO Student
VALUES (31003, '2000-03-03', 0, 0);

INSERT INTO Enrollment
VALUES (50003, '2024-01-12', 0, 31003, 40001);

-- Student 4: Payment Paid 50.50 → tính vào doanh thu
INSERT INTO Users
VALUES (31004, 'st_rev4', 'pw', 'st4@test.com',
        '000', 'Stu', 'Four', 'M', '2024-01-04');

INSERT INTO Student
VALUES (31004, '2000-04-04', 0, 0);

INSERT INTO Enrollment
VALUES (50004, '2024-01-13', 0, 31004, 40001);

-- =========================
-- 3. PAYMENT CHO COURSE 40001
-- =========================

-- Enroll 50001: Paid 100.00 → cộng
INSERT INTO Payment
VALUES (90001, '2024-02-01', 'Card', 'Paid', '100.00', 50001);

-- Enroll 50002: Pending 100.00 → bỏ qua
INSERT INTO Payment
VALUES (90002, '2024-02-02', 'Card', 'Pending', '100.00', 50002);

-- Enroll 50003: Paid nhưng Free → bỏ qua
INSERT INTO Payment
VALUES (90003, '2024-02-03', 'Voucher', 'Paid', 'Free', 50003);

-- Enroll 50004: Paid 50.50 → cộng
INSERT INTO Payment
VALUES (90004, '2024-02-04', 'Card', 'Paid', '50.50', 50004);

SET @rev = 0;
CALL Calc_Course_Revenue(40001, @rev);
SELECT @rev AS total_revenue_course_40001;  -- mong đợi: 150.50
