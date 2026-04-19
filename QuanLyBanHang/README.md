# 📘 TEAM 1 SQL Practice - QuanLyBanHang

---
## 📂 Database

```sql
USE QuanLyBanHang;
```

---

# 🔍 I. Truy vấn dữ liệu (SELECT)

## 1. Tìm tất cả khách hàng ở đường Lê Lợi

```sql
SELECT HoTen as 'Họ và tên', DiaChi as 'Địa chỉ'
FROM KhachHang
WHERE DiaChi LIKE N'%Lê Lợi';
```

---

## 2. Tìm tất cả khách hàng tên "Anh"

```sql
SELECT HoTen as 'Họ và tên', DiaChi as 'Địa chỉ'
FROM KhachHang
WHERE RTRIM(HoTen) LIKE N'% Anh';
```

---

## 3. Tìm tất cả khách hàng họ "Vũ"

```sql
SELECT HoTen as 'Họ và tên', DiaChi as 'Địa chỉ'
FROM KhachHang
WHERE LTRIM(HoTen) LIKE N'Vũ %'
```

---

## 4. Tìm khách hàng tên "Anh" ở Đức

```sql
SELECT HoTen as 'Họ và tên', QuocGia as 'Quốc gia'
FROM KhachHang
WHERE QuocGia = N'Đức' and RTRIM(HoTen) LIKE N'% Anh';
```

---

## 5. Liệt kê nhà cung cấp ở Hà Nội

```sql
SELECT TenDayDu as 'Nhà cung cấp', ThanhPho as 'Thành phố'
FROM NhaCungCap
WHERE ThanhPho LIKE N'%Hà Nội%';
```

---

## 6. Tìm sản phẩm có giá > 50.000

```sql
SELECT *
FROM SanPham
WHERE Gia >  50000;
```

---

## 7. Tìm sản phẩm "Sữa" và "Bánh" ở cửa hàng

```sql
SELECT *
FROM SanPham
WHERE TenSanPham LIKE N'%sữa%'
   OR TenSanPham LIKE N'%bánh%';
```

---

## 8. Nhân viên sinh năm 1995

```sql
SELECT Ho + ' ' + Ten AS [Họ và tên], NgaySinh as 'Ngày sinh'
FROM NhanVien
WHERE YEAR(NgaySinh) = 1995;
```

---

## 9. Có bao nhiêu khách hàng tên "Bình"

```sql
SELECT COUNT(*) as 'Số lượng khách hàng có tên là Bình'
FROM KhachHang
WHERE RTRIM(HoTen) LIKE N'% Bình';
```

---

## 10. Nhân viên trẻ nhất / lớn tuổi nhất

### a. Trẻ nhất

```sql
SELECT  CONCAT(Ho, Ten) AS [Họ và tên], NgaySinh as 'Ngày Sinh'
FROM NhanVien
WHERE YEAR(NgaySinh) = ( 
    SELECT MAX(YEAR(NgaySinh)) FROM NhanVien
)
```

### b. Lớn tuổi nhất

```sql
SELECT  CONCAT(Ho, Ten) AS [Họ và tên], NgaySinh as 'Ngày Sinh'
FROM NhanVien
WHERE YEAR(NgaySinh) = ( 
    SELECT MIN(YEAR(NgaySinh)) FROM NhanVien
)
```

---

## 11. Đếm sản phẩm giá > 300.000

```sql
SELECT COUNT(*) as 'Số sản phẩm có giá hơn 300.000'
FROM SanPham
WHERE Gia >  300000;
```

---

## 12. Khách hàng Việt Nam ở đường Lê Lợi

```sql
SELECT HoTen as 'Họ và tên', DiaChi as 'Địa chỉ', QuocGia as 'Quốc gia'
FROM KhachHang
WHERE QuocGia = N'Việt Nam'
      and DiaChi LIKE N'%Lê Lợi';
```

---

## 13. Đếm khách hàng có mã bưu điện = 101

```sql
SELECT COUNT(*) as 'Số lượng mã bưu điện 101'
FROM KhachHang
WHERE MaBuuDien = '101'
```

---

## 14. Tìm Top 5 sp rẻ nhất ở cửa hàng và cho biết giá tương ứng của mỗi sản phẩm

```sql
SELECT TOP 5 TenSanPham as 'Tên sản phẩm', Gia as 'Giá'
FROM SanPham
ORDER BY Gia;
```

---

## 15. Khách hàng đến từ những quốc gia khác nhau nào?

```sql
SELECT DISTINCT QuocGia as 'Quốc gia'
FROM KhachHang;
```

---

## 16. Sản phẩm giá từ 15k - 50k

```sql
SELECT * 
FROM SanPham
WHERE Gia BETWEEN 15000 AND 50000;
```

---

## 17. Đếm KH ở Cà Mau hoặc Đồng Tháp, quốc gia Đức

```sql
SELECT COUNT(*) as 'Số lượng khách hàng'
FROM KhachHang
WHERE (ThanhPho = N'Cà Mau' or ThanhPho = N'Đồng Tháp') 
    and QuocGia = N'Đức'
```

---

## 18. Tìm khách hàng tên "Anh", họ "Trần" và đang ở Kiên Giang
### Không có ai họ Trần tên Anh nên đổi họ Hoàng để test

```sql
SELECT HoTen as 'Họ và tên', DiaChi as 'Địa chỉ', ThanhPho as 'Thành phố'
FROM KhachHang
WHERE ThanhPho = 'Kiên Giang'
and RTRIM(HoTen) LIKE N'% Anh'
and LTRIM(HoTen) LIKE N'Hoàng %';
```

---

# ✏️ II. Cập nhật dữ liệu (UPDATE)

## 19. Update Mã Bưu Điện 100 thành 101

```sql
UPDATE KhachHang
SET MaBuuDien = '101'
WHERE MaBuuDien = '100'
```

---

## 20. Update giá của sản phẩm "Sữa Vinamilk Growplus" thành 350000

```sql
UPDATE SanPham
SET  Gia = 350000
WHERE TenSanPham = N'Sữa Vinamilk Growplus'
```

---

# 🔗 III. JOIN

## 21. Sản phẩm được nhập từ những thành phố nào?

```sql
SELECT
    sp.TenSanPham as 'Tên sản phẩm',
    ncc.TenDayDu as 'Tên nhà cung cấp',
    ncc.ThanhPho as 'Thành phố'
FROM SanPham sp
INNER JOIN NhaCungCap ncc
    ON sp.NhaCungCapID = ncc.NhaCungCapID
ORDER BY ncc.ThanhPho;
```

---

# 🧠 Ghi chú

* Luôn dùng `N'...'` cho tiếng Việt
* Dùng `RTRIM / LTRIM` để tránh lỗi khoảng trắng
* `DISTINCT` để loại trùng
* `ORDER BY` để sắp xếp
* `JOIN` để lấy dữ liệu từ nhiều bảng

---
