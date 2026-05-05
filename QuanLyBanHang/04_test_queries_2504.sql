USE QuanLyBanHang;


--	1. Tìm tất cả khách hàng ở đường Lê Lợi
SELECT *
FROM KhachHang as kh
WHERE kh.DiaChi LIKE N'%Lê Lợi';

-- 2. Tìm tất cả khách hàng tên "Anh"
SELECT *
FROM KhachHang as kh
WHERE kh.HoTen LIKE N'% Anh';

-- 3. Tìm khách hàng tên "Anh" ở Đức
SELECT *
FROM KhachHang as kh
WHERE kh.HoTen LIKE N'% Anh' and kh.QuocGia = N'Đức';

-- 4. Tìm tất cả khách hàng họ "Vũ"
SELECT *
FROM KhachHang as kh
WHERE kh.HoTen LIKE N'Vũ %';

-- 5. Liệt kê các nhà cung cấp ở Hà Nội
SELECT *
FROM NhaCungCap as ncc
WHERE ncc.ThanhPho = N'Hà Nội';

-- 6. Tìm các sản phẩm có giá lớn hơn 50.000
SELECT *
FROM SanPham as sp
WHERE sp.Gia > 50000;

-- 7. Tìm các sản phẩm sửa và bánh ở cửa hàng
SELECT *
FROM SanPham as sp
WHERE sp.TenSanPham LIKE N'%Sữa%' or sp.TenSanPham LIKE N'%Bánh%';

-- 8. Liệt kê Họ và Tên của nhân viên sinh năm 1995
SELECT CONCAT(nv.Ho, ' ', nv.Ten) as [HoVaTen]
FROM NhanVien as nv
WHERE YEAR(nv.NgaySinh) = 1995;

-- 9. Có bao nhiêu khách hàng tên "Bình"
SELECT COUNT(kh.KhachHangID) as [SoLuongKhachHangTenBinh]
FROM KhachHang as kh
WHERE kh.HoTen LIKE N'% Bình';

-- 10. Tìm nhân viên nhỏ tuổi nhất / lớn tuổi nhất ở cửa hàng
SELECT CONCAT(nv.Ho, ' ', nv.Ten) as [HoVaTen], nv.NgaySinh as NgaySinh
FROM NhanVien as nv
WHERE YEAR(nv.NgaySinh) = (SELECT MAX(YEAR(NgaySinh)) FROM NhanVien);

SELECT CONCAT(nv.Ho, ' ', nv.Ten) as [HoVaTen], nv.NgaySinh as NgaySinh
FROM NhanVien as nv
WHERE YEAR(nv.NgaySinh) = (SELECT MIN(YEAR(NgaySinh)) FROM NhanVien);

-- 11. Có bao nhiêu sản phẩm có giá > 300.000
SELECT COUNT(sp.SanPhamID) as [SoLuongGiaLonHon300000]
FROM SanPham as sp
WHERE sp.Gia > 300000

-- 12. Tìm khách hàng việt nam, ở đường lê lợi
SELECT *
FROM KhachHang as kh
WHERE kh.DiaChi LIKE N'%Lê Lợi' and kh.QuocGia = N'Việt Nam';

-- 13. Có bao nhiêu khách hàng có mã bưu điện = 101
SELECT COUNT(kh.KhachHangID) as [KhachHangCoMaBuuDien101]
FROM KhachHang as kh
WHERE kh.MaBuuDien = 101

-- 14. Tìm tóp 5 sp rẻ nhất ở cửa hàng và cho biết giá tương ứng của mỗi sản phẩm
SELECT top 5 *
FROM SanPham as sp
ORDER BY sp.Gia;

-- 15. Khách hàng đến từ những quốc gia khác nhau nào?
SELECT DISTINCT kh.QuocGia
FROM KhachHang as kh

-- 16. Tìm các sản phẩm có giá từ 15k đến 50k
SELECT *
FROM SanPham as sp
WHERE sp.Gia BETWEEN 15000 AND 50000;

-- 17 .Đếm số KH ở Cà Mau or Đồng Tháp nhưng Quốc Gia = Đức
SELECT COUNT(kh.KhachHangID) as SoKhachHang
FROM KhachHang as kh
WHERE kh.QuocGia = N'Đức' and (kh.ThanhPho = N'Cà Mau' or kh.ThanhPho = N'Đồng Tháp');

-- 18. Tìm khách hàng tên "Anh", họ "Trần" và đang ở Kiên Giang
SELECT *
FROM KhachHang as kh
WHERE kh.ThanhPho = N'Kiên Giang' and (kh.HoTen LIKE N'% Anh' and kh.HoTen LIKE N'Hoàng %');

-- 19. Sản phẩm được nhập từ những thành phố nào?
SELECT DISTINCT ncc.ThanhPho as SanPhamDuocNhapTu
FROM NhaCungCap as ncc


-- 20. Tìm giá tiền đắt nhất
SELECT MAX(sp.Gia) as GiaTienDatNhat
FROM SanPham as sp;

-- 21. Tìm sản phẩm có giá tiền rẻ nhất ở cửa hàng
SELECT *
FROM SanPham
WHERE Gia = (
	SELECT MIN(Gia) as GiaTienReNhat
	FROM SanPham
)

-- 22. Đếm số đơn hàng trong tháng 8 năm 2022
SELECT COUNT(dh.DonHangID) AS SoDonHang
FROM DonHang as dh
WHERE NgayDatHang >= '2022-08-01'
	AND NgayDatHang < '2022-09-01';

-- 22. Liệt kê đơn hàng đặt trong tháng 7
SELECT *
FROM DonHang
WHERE MONTH(NgayDatHang) = 7;



-- 1. Tìm các sản phẩm thuộc danh mục "Ngũ Cốc"
SELECT *
FROM SanPham as sp
INNER JOIN DanhMuc as dm ON sp.DanhMucID=dm.DanhMucID
WHERE dm.TenDanhMuc = N'Ngũ Cốc';

-- 2. Tìm các sản phẩm "Gia Vị" thuộc nhà cung cấp "ABC"
SELECT *
FROM SanPham as sp
INNER JOIN DanhMuc as dm ON sp.DanhMucID = dm.DanhMucID
INNER JOIN NhaCungCap as ncc ON sp.NhaCungCapID = ncc.NhaCungCapID
WHERE dm.TenDanhMuc = N'Gia vị' and sp.NhaCungCapID = 'CC_001';

-- 3. Cho biết dịch vụ Grab đã giao được tổng cộng bao nhiêu đơn hàng?
SELECT count(dh.DonHangID) as SoLuongDonDaGiaoCuaGrap
FROM DonHang as dh
JOIN Shippers as sper on dh.ShipperID = sper.ShipperID
WHERE sper.ShiperName = 'Grab';


-- 4. Cho biết tên khách hàng, tên nhân viên bán hàng và tên dịch vụ  giao hàng của đơn hàng "10248"
SELECT kh.HoTen as TenKhachHang, nv.Ho + ' ' + nv.Ten AS TenNhanVien, sper.ShiperName
FROM DonHang as dh
JOIN NhanVien as nv on dh.NhanVienID = nv.NhanVienID
JOIN KhachHang as kh on kh.KhachHangID = dh.KhachHangID
JOIN Shippers as sper on dh.ShipperID = sper.ShipperID
WHERE dh.DonHangID = 10248;

-- 5. Cho biết số lượng, đơn giá, thành tiền của từng sản phẩm trong đơn hàng "10248"
SELECT sp.TenSanPham, sp.Gia, dhct.Soluong, (sp.Gia * dhct.Soluong) as ThanhTien
FROM DonHangChiTiet as dhct
JOIN SanPham as sp on dhct.SanPhamID = sp.SanPhamID
JOIN DonHang as dh on dh.DonHangID = dhct.DonHangID
WHERE dh.DonHangID = 10248

-- 6. Tính tổng tiền của đơn hàng "10248"
SELECT dh.DonHangID, sum(sp.Gia * dhct.Soluong) as TongTien
FROM DonHangChiTiet as dhct
JOIN SanPham as sp on dhct.SanPhamID = sp.SanPhamID
JOIN DonHang as dh on dh.DonHangID = dhct.DonHangID
WHERE dh.DonHangID = 10248
GROUP BY dh.DonHangID;

-- 7. Tìm danh mục chưa có sản phẩm nào
SELECT sp.DanhMucID, dm.TenDanhMuc
FROM DanhMuc dm
LEFT JOIN SanPham sp ON dm.DanhMucID = sp.DanhMucID
WHERE sp.DanhMucID IS NULL;

---- 7. Tìm danh mục chưa có sản phẩm nào
SELECT dm.TenDanhMuc AS DanhMucChuaCoSP 
FROM DanhMuc AS dm
LEFT JOIN SanPham AS sp ON dm.DanhMucID = sp.DanhMucID
WHERE sp.SanPhamID IS NULL;


-- 8. Tìm số lượng đơn hàng bán được
	-- a/ Theo ngày
SELECT NgayDatHang, COUNT(DonHangID) AS SoLuongDon
FROM DonHang
GROUP BY NgayDatHang;

	-- b/ Theo tháng
SELECT 
    YEAR(NgayDatHang) AS Nam,
    MONTH(NgayDatHang) AS Thang,
    COUNT(DonHangID) AS SoLuongDon
FROM DonHang
GROUP BY 
    YEAR(NgayDatHang), 
    MONTH(NgayDatHang)
ORDER BY Nam, Thang;


    -- c/ Theo năm
SELECT YEAR(NgayDatHang) AS Nam,COUNT(DonHangID) AS SoLuongDon
FROM DonHang
GROUP BY YEAR(NgayDatHang);


-- 9. Tìm tháng bán được nhiều đơn hàng nhất và bán được bao nhiêu đơn
SELECT TOP 1
    YEAR(NgayDatHang) AS Nam,
    MONTH(NgayDatHang) AS Thang,
    COUNT(dh.DonHangID) AS SoLuongDonHang
FROM DonHang as dh
GROUP BY
    YEAR(NgayDatHang),
    MONTH(NgayDatHang)
ORDER BY SoLuongDonHang DESC;
