-- 02_create_tables.sql
-- Tạo các table và ràng buộc theo cú pháp SQL Server

USE QuanLyBanHang;

CREATE TABLE DanhMuc (
    DanhMucID   INT IDENTITY(1,1)   PRIMARY KEY,
    TenDanhMuc  NVARCHAR(100)       NOT NULL,
    MoTa        NVARCHAR(500)       
)

CREATE TABLE NhaCungCap (
    NhaCungCapID    NVARCHAR(10)    PRIMARY KEY,
    TenDayDu        NVARCHAR(200)   NOT NULL,
    TenLienHe       NVARCHAR(100),
    DiaChi          NVARCHAR(255),
    ThanhPho        NVARCHAR(100),
    MaBuuDien       VARCHAR(20),
    QuocGia         NVARCHAR(100),
    DienThoai       VARCHAR(20)
);

CREATE TABLE NhanVien (
    NhanVienID  NVARCHAR(10) PRIMARY KEY,
    Ten         NVARCHAR(50) NOT NULL,
    Ho          NVARCHAR(50) NOT NULL,
    NgaySinh    DATE,
    Ghichu      NVARCHAR(500)
);

CREATE TABLE KhachHang (
    KhachHangID NVARCHAR(10)    PRIMARY KEY,
    HoTen       NVARCHAR(150)   NOT NULL,
    DiaChi      NVARCHAR(255),
    ThanhPho    NVARCHAR(100),
    MaBuuDien   VARCHAR(20),
    QuocGia     NVARCHAR(100)
);

CREATE TABLE Shippers (
    ShipperID INT IDENTITY(1,1) PRIMARY KEY,
    ShiperName NVARCHAR(100) NOT NULL,
    Sodienthoai VARCHAR(20) NULL
);


CREATE TABLE SanPham (
    SanPhamID       NVARCHAR(10)    PRIMARY KEY,
    TenSanPham      NVARCHAR(200)   NOT NULL,  
    NhaCungCapID    NVARCHAR(10)    NOT NULL,
    DanhMucID       INT             NOT NULL,
    Donvi           NVARCHAR(50)    NOT NULL,
    Gia             DECIMAL(18,2)   NOT NULL CHECK (Gia >= 0),

    CONSTRAINT FK_SanPham_NhaCungCap
        FOREIGN KEY (NhaCungCapID) REFERENCES NhaCungCap(NhaCungCapID),

    CONSTRAINT FK_SanPham_DanhMuc
        FOREIGN KEY (DanhMucID) REFERENCES DanhMuc(DanhMucID)
);


CREATE TABLE DonHang (
    DonHangID   INT PRIMARY KEY,
    KhachHangID NVARCHAR(10)    NOT NULL,
    NhanVienID  NVARCHAR(10)    NOT NULL,    
    NgayDatHang DATETIME        NOT NULL,    
    ShipperID   INT             NULL,

    CONSTRAINT FK_DonHang_Khachhang
        FOREIGN KEY (KhachHangID) REFERENCES Khachhang(KhachHangID),

    CONSTRAINT FK_DonHang_Nhanvien
        FOREIGN KEY (NhanVienID) REFERENCES Nhanvien(NhanVienID),

    CONSTRAINT FK_DonHang_Shippers
        FOREIGN KEY (ShipperID) REFERENCES Shippers(ShipperID)
);


CREATE TABLE DonHangChiTiet (
    DonHangChiTietID    INT PRIMARY KEY,
    DonHangID           INT NOT NULL,    
    SanPhamID           NVARCHAR(10) NOT NULL,
    Soluong             INT NOT NULL CHECK (Soluong > 0),
    

    CONSTRAINT FK_DonHangChiTiet_DonHang
        FOREIGN KEY (DonHangID) REFERENCES Donhang(DonHangID),

    CONSTRAINT FK_DonHangChiTiet_SanPham
        FOREIGN KEY (SanPhamID) REFERENCES Sanpham(SanPhamID)
);