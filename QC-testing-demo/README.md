# SQL Guideline for QC

## 1. Purpose
This document is a practical SQL guideline for QC/Tester roles. It focuses on the SQL knowledge needed in daily testing work, especially for verifying data related to register, login, order, and payment features.

The goal is not to become a database developer, but to be able to:
- verify data after testing UI or API
- compare UI, API, and database results
- detect data-related bugs
- prepare test data when needed
- understand how system data is stored

---

## 2. Why QC Should Learn SQL
A QC should learn SQL because many bugs cannot be confirmed only from the UI.

Examples:
- The UI shows **Register successful**, but the user record is not saved in the database.
- The order is created on the screen, but `order_items` are missing.
- Payment is marked as successful on the UI, but no payment record exists in DB.
- The system allows duplicate email although the requirement says email must be unique.

SQL helps QC confirm the actual result in the database.

---

## 3. Basic Database Concepts

### 3.1 Table
A table stores data.

Example: `users`, `orders`, `payments`

### 3.2 Row
A row is one record in a table.

### 3.3 Column
A column is one field in a table.

### 3.4 Primary Key
A primary key uniquely identifies each row.

Example: `id`

### 3.5 Foreign Key
A foreign key links one table to another.

Example:
- `orders.user_id` links to `users.id`

### 3.6 Relationship
Common relationships:
- one user has many orders
- one order has many order items
- one order may have one payment record

---

## 4. Common Tables in Testing Projects
Depending on the system, QC often works with tables like:

- `users`
- `login_history`
- `orders`
- `order_items`
- `products`
- `payments`
- `roles`
- `user_addresses`

QC should understand:
- which table stores which data
- which columns are important
- how tables are linked together

---

## 5. SQL Skills QC Must Know

### 5.1 SELECT
Used to retrieve data.

```sql
SELECT * FROM users;
```

Use when:
- checking whether data exists
- viewing saved records
- verifying test results in DB

### 5.2 WHERE
Used to filter data.

```sql
SELECT *
FROM users
WHERE email = 'tester01@gmail.com';
```

Use when:
- finding a specific user, order, or payment
- checking a record created during testing

### 5.3 ORDER BY
Used to sort data.

```sql
SELECT *
FROM orders
ORDER BY created_at DESC;
```

Use when:
- viewing the latest data first
- checking the newest records after testing

### 5.4 LIMIT / TOP
Used to limit the number of rows.

MySQL / PostgreSQL:

```sql
SELECT *
FROM orders
ORDER BY created_at DESC
LIMIT 5;
```

SQL Server:

```sql
SELECT TOP 5 *
FROM orders
ORDER BY created_at DESC;
```

### 5.5 DISTINCT
Used to get non-duplicate values.

```sql
SELECT DISTINCT status
FROM orders;
```

Use when:
- checking which status values exist in the system

### 5.6 COUNT
Used to count records.

```sql
SELECT COUNT(*)
FROM users;
```

Use when:
- checking how many records exist
- verifying whether the number of records increases after an action

### 5.7 GROUP BY
Used to group data.

```sql
SELECT status, COUNT(*)
FROM orders
GROUP BY status;
```

Use when:
- counting data by status
- checking report or summary logic

### 5.8 HAVING
Used to filter grouped data.

```sql
SELECT email, COUNT(*)
FROM users
GROUP BY email
HAVING COUNT(*) > 1;
```

Use when:
- checking duplicate data

### 5.9 INNER JOIN
Used to combine matching records from related tables.

```sql
SELECT o.order_code, u.full_name, u.email
FROM orders o
INNER JOIN users u ON o.user_id = u.id;
```

Use when:
- verifying which user created an order
- checking relationships between tables

### 5.10 LEFT JOIN
Used to get all records from the left table, including unmatched ones.

```sql
SELECT u.id, u.email, l.id AS login_id
FROM users u
LEFT JOIN login_history l ON u.id = l.user_id;
```

Use when:
- finding users with no login history
- finding orders without payment

---

## 6. Useful Conditions for QC

### AND
```sql
SELECT *
FROM users
WHERE status = 'active' AND role = 'member';
```

### OR
```sql
SELECT *
FROM users
WHERE status = 'inactive' OR status = 'blocked';
```

### IN
```sql
SELECT *
FROM orders
WHERE status IN ('pending', 'paid', 'canceled');
```

### BETWEEN
```sql
SELECT *
FROM products
WHERE price BETWEEN 100000 AND 300000;
```

### LIKE
```sql
SELECT *
FROM users
WHERE full_name LIKE '%An%';
```

### IS NULL
```sql
SELECT *
FROM users
WHERE phone IS NULL;
```

---

## 7. Basic Data Types QC Should Understand
QC does not need deep database knowledge, but should understand common data types.

- `INT` : integer
- `VARCHAR` : text
- `DATE` : date only
- `DATETIME` : date and time
- `BOOLEAN` : true/false
- `DECIMAL` : decimal number

This helps QC verify:
- correct data format
- valid data values
- whether required fields are missing

---

## 8. Common Testing Scenarios with SQL

### 8.1 Register
QC uses SQL to verify:
- user is created successfully
- email is unique
- default status is correct
- required fields are saved

Example:

```sql
SELECT *
FROM users
WHERE email = 'tester01@gmail.com';
```

### 8.2 Login
QC uses SQL to verify:
- login history is saved
- login time is correct
- login result is recorded correctly
- IP address or device info is stored if required

Example:

```sql
SELECT *
FROM login_history
WHERE user_id = 1
ORDER BY login_time DESC;
```

### 8.3 Order
QC uses SQL to verify:
- order is created
- order status is correct
- order belongs to the correct user
- order items exist
- total quantity or amount is correct

Example:

```sql
SELECT *
FROM orders
WHERE order_code = 'ORD1001';
```

### 8.4 Payment
QC uses SQL to verify:
- payment record is created
- payment status is correct
- paid amount matches order amount
- failed payment is logged correctly

Example:

```sql
SELECT p.*
FROM payments p
INNER JOIN orders o ON p.order_id = o.id
WHERE o.order_code = 'ORD1001';
```

---

## 9. Practical SQL Exercises for QC

### Exercise 1: Check whether a user is created after successful register

**Requirement**  
Verify that user `tester01@gmail.com` exists in DB.

```sql
SELECT *
FROM users
WHERE email = 'tester01@gmail.com';
```

**Expected check**
- 1 record exists
- user data is saved correctly

---

### Exercise 2: Check duplicate email

**Requirement**  
Email must be unique.

```sql
SELECT email, COUNT(*)
FROM users
GROUP BY email
HAVING COUNT(*) > 1;
```

**Expected check**
- no record should be returned

---

### Exercise 3: Check default status of a new user

**Requirement**  
New registered user should have `status = 'active'`.

```sql
SELECT email, status
FROM users
WHERE email = 'tester01@gmail.com';
```

**Expected check**
- status should be `active`

---

### Exercise 4: Check users with missing full name

**Requirement**  
`full_name` is required.

```sql
SELECT *
FROM users
WHERE full_name IS NULL;
```

**Expected check**
- no invalid record should exist

---

### Exercise 5: Check the latest created user

```sql
SELECT *
FROM users
ORDER BY created_at DESC
LIMIT 1;
```

**Expected check**
- the latest user should match the recent test action

---

### Exercise 6: Check whether successful login creates log history

```sql
SELECT *
FROM login_history
WHERE user_id = 1
ORDER BY login_time DESC;
```

**Expected check**
- a new login record exists

---

### Exercise 7: Check the latest login record

```sql
SELECT *
FROM login_history
WHERE user_id = 1
ORDER BY login_time DESC
LIMIT 1;
```

**Expected check**
- login time is correct
- login result matches test result

---

### Exercise 8: Count failed login attempts

```sql
SELECT COUNT(*)
FROM login_history
WHERE user_id = 1
  AND result = 'failed';
```

**Expected check**
- failed count matches actual test attempts

---

### Exercise 9: Check IP address of the latest login

```sql
SELECT ip_address, login_time
FROM login_history
WHERE user_id = 1
ORDER BY login_time DESC
LIMIT 1;
```

**Expected check**
- IP should be stored correctly if the system requires it

---

### Exercise 10: Find users who never logged in

```sql
SELECT u.id, u.email
FROM users u
LEFT JOIN login_history l ON u.id = l.user_id
WHERE l.id IS NULL;
```

**Expected check**
- users without login history are listed correctly

---

### Exercise 11: Check whether an order is created

```sql
SELECT *
FROM orders
WHERE order_code = 'ORD1001';
```

**Expected check**
- the order exists

---

### Exercise 12: Check order status

```sql
SELECT order_code, status
FROM orders
WHERE order_code = 'ORD1001';
```

**Expected check**
- status matches requirement, such as `pending`

---

### Exercise 13: Check which user owns the order

```sql
SELECT o.order_code, u.full_name, u.email
FROM orders o
INNER JOIN users u ON o.user_id = u.id
WHERE o.order_code = 'ORD1001';
```

**Expected check**
- the order belongs to the correct user

---

### Exercise 14: Get the 5 latest orders

```sql
SELECT *
FROM orders
ORDER BY created_at DESC
LIMIT 5;
```

**Expected check**
- recent orders are shown in correct order

---

### Exercise 15: Count orders by status

```sql
SELECT status, COUNT(*)
FROM orders
GROUP BY status;
```

**Expected check**
- counts by status are reasonable and correct

---

### Exercise 16: Check whether an order has order items

```sql
SELECT o.order_code, oi.product_id, oi.quantity, oi.price
FROM orders o
INNER JOIN order_items oi ON o.id = oi.order_id
WHERE o.order_code = 'ORD1001';
```

**Expected check**
- at least one order item should exist

---

### Exercise 17: Calculate total quantity in an order

```sql
SELECT o.order_code, SUM(oi.quantity) AS total_quantity
FROM orders o
INNER JOIN order_items oi ON o.id = oi.order_id
WHERE o.order_code = 'ORD1001'
GROUP BY o.order_code;
```

**Expected check**
- total quantity matches cart or expected result

---

### Exercise 18: Check whether payment is created

```sql
SELECT p.*
FROM payments p
INNER JOIN orders o ON p.order_id = o.id
WHERE o.order_code = 'ORD1001';
```

**Expected check**
- payment record exists after successful payment

---

### Exercise 19: Check payment status and paid amount

```sql
SELECT o.order_code, p.payment_status, p.paid_amount
FROM payments p
INNER JOIN orders o ON p.order_id = o.id
WHERE o.order_code = 'ORD1001';
```

**Expected check**
- payment status is correct
- paid amount matches expected amount

---

### Exercise 20: Find orders without payment

```sql
SELECT o.id, o.order_code, o.status
FROM orders o
LEFT JOIN payments p ON o.id = p.order_id
WHERE p.id IS NULL;
```

**Expected check**
- identify orders that have not been paid or are missing payment records

---

## 10. Bonus Queries for Real Testing Work

### 10.1 Compare order amount and payment amount

```sql
SELECT o.order_code, o.total_amount, p.paid_amount
FROM orders o
INNER JOIN payments p ON o.id = p.order_id
WHERE o.order_code = 'ORD1001';
```

Use to verify:
- payment amount equals order amount

### 10.2 Find orders without order items

```sql
SELECT o.id, o.order_code
FROM orders o
LEFT JOIN order_items oi ON o.id = oi.order_id
WHERE oi.id IS NULL;
```

Use to verify:
- no empty order should exist

### 10.3 Count how many orders a user has

```sql
SELECT u.email, COUNT(o.id) AS total_orders
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE u.email = 'tester01@gmail.com'
GROUP BY u.email;
```

### 10.4 Find failed payments

```sql
SELECT *
FROM payments
WHERE payment_status = 'failed';
```

### 10.5 Find canceled orders that still have paid status

```sql
SELECT o.order_code, o.status, p.payment_status
FROM orders o
INNER JOIN payments p ON o.id = p.order_id
WHERE o.status = 'canceled'
  AND p.payment_status = 'paid';
```

Use to detect:
- possible business logic or refund issue

---

## 11. INSERT, UPDATE, DELETE for QC
QC should mainly use `SELECT`, but should also understand:

### INSERT
Used to create test data.

```sql
INSERT INTO users (full_name, email, status)
VALUES ('Test User', 'test1@gmail.com', 'active');
```

### UPDATE
Used to modify test data.

```sql
UPDATE users
SET status = 'inactive'
WHERE email = 'test1@gmail.com';
```

### DELETE
Used to remove test data.

```sql
DELETE FROM users
WHERE email = 'test1@gmail.com';
```

**Important note:**  
Only use these commands in a test environment and with permission.

---

## 12. Common Mistakes Beginners Make

### 12.1 Forgetting WHERE in UPDATE or DELETE
Wrong:

```sql
UPDATE users
SET status = 'inactive';
```

This may update all rows.

### 12.2 Checking NULL incorrectly
Wrong:

```sql
WHERE phone = NULL
```

Correct:

```sql
WHERE phone IS NULL
```

### 12.3 Joining tables with wrong conditions
This may return duplicated or incorrect data.

### 12.4 Querying the wrong table
A correct SQL syntax does not mean the test conclusion is correct.

### 12.5 Checking only UI, not DB
Some important bugs can only be confirmed through DB verification.

---

## 13. Recommended SQL Learning Path for QC

### Level 1
Learn:
- table, row, column
- primary key, foreign key
- `SELECT`
- `WHERE`
- `ORDER BY`

### Level 2
Learn:
- `COUNT`
- `GROUP BY`
- `HAVING`
- `DISTINCT`
- `LIKE`
- `IN`
- `BETWEEN`

### Level 3
Learn:
- `INNER JOIN`
- `LEFT JOIN`

### Level 4
Apply in real cases:
- register
- login
- create order
- update profile
- cancel order
- payment

### Level 5
Learn more when needed:
- subquery
- `CASE WHEN`
- date functions
- basic data setup and cleanup

---

## 14. Daily Practice Tips for QC
- Always connect SQL with one feature or one test case.
- After testing a feature, ask:
  - which table stores this data?
  - which field should I verify?
  - what is the expected value in DB?
- Practice by changing email, order code, status, and user ID in sample queries.
- Focus on understanding the business meaning of the query, not only the syntax.

---

## 15. Summary
A QC should use SQL mainly for four purposes:

- read data
- verify data
- compare system result with database result
- prepare test data

The most important SQL skills for QC are:
- `SELECT`
- `WHERE`
- `ORDER BY`
- `COUNT`
- `GROUP BY`
- `HAVING`
- `INNER JOIN`
- `LEFT JOIN`
- checking null values
- checking duplicate data
- verifying status and data relationships

SQL is a practical skill for testers.  
The best way to learn is:

**test something -> run query -> verify result**

