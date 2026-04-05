-- 03_insert_data.sql
-- Insert dữ liệu mẫu, mỗi bảng 1 dòng

USE QC_Testing_DB;
GO

-- users
INSERT INTO dbo.users (full_name, email, [password], [status], created_at)
VALUES (N'Nguyen Van A', 'nguyenvana@example.com', N'123456', 'active', '2026-04-05 09:00:00');
GO

-- login_history
INSERT INTO dbo.login_history (user_id, login_time, ip_address, result)
VALUES (1, '2026-04-05 09:15:00', '192.168.1.10', 'success');
GO

-- orders
INSERT INTO dbo.orders (order_code, user_id, [status], total_amount, created_at)
VALUES ('ORD1001', 1, 'pending', 250000.00, '2026-04-05 09:30:00');
GO

-- order_items
INSERT INTO dbo.order_items (order_id, product_id, quantity, price)
VALUES (1, 101, 2, 125000.00);
GO

-- payments
INSERT INTO dbo.payments (order_id, payment_method, payment_status, paid_amount, paid_at)
VALUES (1, 'bank_transfer', 'pending', 250000.00, NULL);
GO
