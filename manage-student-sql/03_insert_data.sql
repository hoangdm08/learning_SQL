USE manage_student;

GO
-- Insert classes
INSERT INTO
  classes (class_name)
VALUES
  (N'CNTT 1'),
  (N'CNTT 2');

GO
-- Insert students
INSERT INTO
  students (name, age, class_id)
VALUES
  (N'Hoang', 22, 1),
  (N'An', 21, 1),
  (N'Binh', 23, 2);

GO