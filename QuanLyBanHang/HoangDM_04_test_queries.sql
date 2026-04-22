USE QuanLyBanHang;


-- 1. Tìm tất cả khách hàng ở đường Lê Lợi
SELECT HoTen as 'Họ và tên', DiaChi as 'Địa chỉ'
FROM KhachHang
WHERE DiaChi LIKE N'%Lê Lợi';


-- 2. Tìm tất cả khách hàng tên "Anh"
SELECT HoTen as 'Họ và tên', DiaChi as 'Địa chỉ'
FROM KhachHang
WHERE RTRIM(HoTen) LIKE N'% Anh';


--3. Tìm tất cả khách hàng họ "Vũ"
SELECT HoTen as 'Họ và tên', DiaChi as 'Địa chỉ'
FROM KhachHang
WHERE LTRIM(HoTen) LIKE N'Vũ %'


--4. Tìm khách hàng tên "Anh" ở Đức
SELECT HoTen as 'Họ và tên', QuocGia as 'Quốc gia'
FROM KhachHang
WHERE QuocGia = N'Đức' and RTRIM(HoTen) LIKE N'% Anh';


--5. Liệt kê các nhà cung cấp ở Hà Nội
SELECT TenDayDu as 'Nhà cung cấp', ThanhPho as 'Thành phố'
FROM NhaCungCap
WHERE ThanhPho LIKE N'Hà Nội';

--6. Tìm các sản phẩm có giá lớn hơn 50.000
SELECT *
FROM SanPham
WHERE Gia >  50000;


--7. Tìm các sản phẩm sửa và bánh ở cửa hàng
SELECT *
FROM SanPham
WHERE TenSanPham LIKE N'%sữa%'
   OR TenSanPham LIKE N'%bánh%';

SELECT TenSanpham as SuavaBanh
From Sanpham
Where TenSanpham like N'Sữa %' OR TenSanPham like N'Bánh %';

-- 8. Liệt kê Họ và Tên của nhân viên sinh năm 1995
SELECT  Ho + ' ' + Ten AS [Họ và tên], NgaySinh as 'Ngày sinh'
FROM NhanVien
WHERE YEAR(NgaySinh) = 1995;


--9. Có bao nhiêu khách hàng tên "Bình"
SELECT COUNT(*) as 'Số lượng khách hàng có tên là Bình'
FROM KhachHang
WHERE RTRIM(HoTen) LIKE N'% Bình';


--10 a. Tìm nhân viên nhỏ tuổi nhất ở cửa hàng
SELECT  CONCAT(Ho, Ten) AS [Họ và tên], NgaySinh as 'Ngày Sinh'
FROM NhanVien
WHERE YEAR(NgaySinh) = ( 
    SELECT MAX(YEAR(NgaySinh)) FROM NhanVien
)


--10 b.Tìm nhân viên lớn tuổi nhất ở cửa hàng
SELECT  CONCAT(Ho, Ten) AS [Họ và tên], NgaySinh as 'Ngày Sinh'
FROM NhanVien
WHERE YEAR(NgaySinh) = ( 
    SELECT MIN(YEAR(NgaySinh)) FROM NhanVien
)


--11. Có bao nhiêu sản phẩm có giá > 300.000
SELECT COUNT(*) as 'Số sản phẩm có giá hơn 300.000'
FROM SanPham
WHERE Gia >  300000;


--12. Tìm khách hàng việt nam, ở đường lê lợi
SELECT HoTen as 'Họ và tên', DiaChi as 'Địa chỉ', QuocGia as 'Quốc gia'
FROM KhachHang
WHERE QuocGia = N'Việt Nam' and DiaChi LIKE N'%Lê Lợi';


--13. Có bao nhiêu khách hàng có mã bưu điện = 101
SELECT COUNT(*) as 'Số lượng KH có mã bưu điện 101'
FROM KhachHang
WHERE MaBuuDien = '101'


--14. Tìm TOP 5 sp rẻ nhất ở cửa hàng và cho biết giá tương ứng của mỗi sản phẩm
SELECT TOP 5 TenSanPham as 'Tên sản phẩm', Gia as 'Giá'
FROM SanPham
ORDER BY Gia;


--15. Khách hàng đến từ những quốc gia khác nhau nào?
SELECT DISTINCT QuocGia as 'Quốc gia'
FROM KhachHang;


--16. Tìm các sản phẩm có giá từ 15k đến 50k
SELECT * 
FROM SanPham
WHERE Gia BETWEEN 15000 AND 50000;


--17. Đếm số KH ở Cà Mau or Đồng Tháp nhưng Quốc Gia = Đức
SELECT COUNT(*) as 'Số lượng khách hàng'
FROM KhachHang
WHERE (ThanhPho = N'Cà Mau' or ThanhPho = N'Đồng Tháp') 
    and QuocGia = N'Đức'

    
--18.   Tìm khách hàng tên "Anh", họ "Trần" và đang ở Kiên Giang
        -- Không có ai họ Trần tên Anh nên đổi họ Hoàng để test
SELECT HoTen as 'Họ và tên', DiaChi as 'Địa chỉ', ThanhPho as 'Thành phố'
FROM KhachHang
WHERE ThanhPho = 'Kiên Giang'
and RTRIM(HoTen) LIKE N'% Anh'
and LTRIM(HoTen) LIKE N'Hoàng %';


--19. Update Mã Bưu Điện 100 thành 101
UPDATE KhachHang
SET  MaBuuDien = '101'
WHERE MaBuuDien = '100'


--20. Update giá của sản phẩm "Sữa Vinamilk Growplus" thành 350000
UPDATE SanPham
SET  Gia = 350000
WHERE TenSanPham = N'Sữa Vinamilk Growplus'


--21. Sản phẩm được nhập từ những thành phố nào?
SELECT Distinct
    ncc.ThanhPho as 'Thành phố'
FROM SanPham sp
INNER JOIN NhaCungCap ncc
    ON sp.NhaCungCapID = ncc.NhaCungCapID