-- 01_create_database.sql
-- Tạo database cho hệ thống QC demo

IF DB_ID(N'QC_Testing_DB') IS NULL
BEGIN
    CREATE DATABASE QC_Testing_DB;
END;
GO
