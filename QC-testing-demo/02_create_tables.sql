-- 02_create_tables.sql
-- Tạo các table và ràng buộc theo cú pháp SQL Server

USE QC_Testing_DB;
GO

-- Xóa bảng theo thứ tự phụ thuộc nếu cần chạy lại script
IF OBJECT_ID(N'dbo.payments', N'U') IS NOT NULL DROP TABLE dbo.payments;
IF OBJECT_ID(N'dbo.order_items', N'U') IS NOT NULL DROP TABLE dbo.order_items;
IF OBJECT_ID(N'dbo.orders', N'U') IS NOT NULL DROP TABLE dbo.orders;
IF OBJECT_ID(N'dbo.login_history', N'U') IS NOT NULL DROP TABLE dbo.login_history;
IF OBJECT_ID(N'dbo.users', N'U') IS NOT NULL DROP TABLE dbo.users;
GO

CREATE TABLE dbo.users (
    id INT IDENTITY(1,1) NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    [password] NVARCHAR(255) NOT NULL,
    [status] VARCHAR(20) NOT NULL,
    created_at DATETIME2(0) NOT NULL CONSTRAINT DF_users_created_at DEFAULT SYSDATETIME(),
    CONSTRAINT PK_users PRIMARY KEY (id),
    CONSTRAINT UQ_users_email UNIQUE (email),
    CONSTRAINT CK_users_status CHECK ([status] IN ('active', 'inactive', 'blocked'))
);
GO

CREATE TABLE dbo.login_history (
    id INT IDENTITY(1,1) NOT NULL,
    user_id INT NOT NULL,
    login_time DATETIME2(0) NOT NULL CONSTRAINT DF_login_history_login_time DEFAULT SYSDATETIME(),
    ip_address VARCHAR(45) NOT NULL,
    result VARCHAR(20) NOT NULL,
    CONSTRAINT PK_login_history PRIMARY KEY (id),
    CONSTRAINT FK_login_history_users FOREIGN KEY (user_id)
        REFERENCES dbo.users(id),
    CONSTRAINT CK_login_history_result CHECK (result IN ('success', 'failed'))
);
GO

CREATE TABLE dbo.orders (
    id INT IDENTITY(1,1) NOT NULL,
    order_code VARCHAR(50) NOT NULL,
    user_id INT NOT NULL,
    [status] VARCHAR(20) NOT NULL,
    total_amount DECIMAL(18,2) NOT NULL,
    created_at DATETIME2(0) NOT NULL CONSTRAINT DF_orders_created_at DEFAULT SYSDATETIME(),
    CONSTRAINT PK_orders PRIMARY KEY (id),
    CONSTRAINT UQ_orders_order_code UNIQUE (order_code),
    CONSTRAINT FK_orders_users FOREIGN KEY (user_id)
        REFERENCES dbo.users(id),
    CONSTRAINT CK_orders_status CHECK ([status] IN ('pending', 'paid', 'canceled', 'shipped'))
);
GO

CREATE TABLE dbo.order_items (
    id INT IDENTITY(1,1) NOT NULL,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(18,2) NOT NULL,
    CONSTRAINT PK_order_items PRIMARY KEY (id),
    CONSTRAINT FK_order_items_orders FOREIGN KEY (order_id)
        REFERENCES dbo.orders(id),
    CONSTRAINT CK_order_items_quantity CHECK (quantity > 0),
    CONSTRAINT CK_order_items_price CHECK (price >= 0)
);
GO

CREATE TABLE dbo.payments (
    id INT IDENTITY(1,1) NOT NULL,
    order_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    paid_amount DECIMAL(18,2) NOT NULL,
    paid_at DATETIME2(0) NULL,
    CONSTRAINT PK_payments PRIMARY KEY (id),
    CONSTRAINT FK_payments_orders FOREIGN KEY (order_id)
        REFERENCES dbo.orders(id),
    CONSTRAINT UQ_payments_order_id UNIQUE (order_id),
    CONSTRAINT CK_payments_method CHECK (payment_method IN ('cod', 'bank_transfer', 'credit_card', 'e_wallet')),
    CONSTRAINT CK_payments_status CHECK (payment_status IN ('pending', 'paid', 'failed', 'refunded')),
    CONSTRAINT CK_payments_amount CHECK (paid_amount >= 0)
);
GO
