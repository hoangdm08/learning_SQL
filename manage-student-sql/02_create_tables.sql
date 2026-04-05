USE manage_student;
GO

-- Bảng lớp
CREATE TABLE classes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    class_name NVARCHAR(100)
);
GO

-- Bảng sinh viên
CREATE TABLE students (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100),
    age INT,
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES classes(id)
);
GO