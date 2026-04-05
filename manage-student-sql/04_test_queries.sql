USE manage_student;
GO

-- 1. Kiểm tra có bao nhiêu sinh viên
SELECT COUNT(*) AS total_students 
FROM students;
GO

-- 2. Kiểm tra join dữ liệu
SELECT s.name, s.age, c.class_name
FROM students s
JOIN classes c ON s.class_id = c.id;
GO

-- 3. Test insert
INSERT INTO students (name, age, class_id)
VALUES (N'TestUser', 20, 1);
GO

-- 4. Verify insert
SELECT * 
FROM students 
WHERE name = N'TestUser';
GO

-- 5. Test update
UPDATE students
SET age = 25
WHERE name = N'TestUser';
GO

-- 6. Verify update
SELECT * 
FROM students 
WHERE name = N'TestUser';
GO

-- 7. Test delete
DELETE FROM students
WHERE name = N'TestUser';
GO

-- 8. Verify delete
SELECT * 
FROM students 
WHERE name = N'TestUser';
GO