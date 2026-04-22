USE QuanLyBanHang;


-- 1. Liệt kê report với các thông tin tên sản phẩm, danh mục và nhà cung cấp tương ứng với mỗi sản phầm
SELECT sp.TenSanPham, dm.TenDanhMuc, ncc.TenDayDu
FROM SanPham as sp
JOIN DanhMuc as dm on sp.DanhMucID = dm.DanhMucID
JOIN NhaCungCap as ncc on sp.NhaCungCapID = ncc.NhaCungCapID


-- 1. Tìm các sản phẩm thuộc danh mục "Ngũ Cốc"
SELECT sp.TenSanPham, dm.TenDanhMuc
FROM SanPham as sp
JOIN DanhMuc as dm on sp.DanhMucID = dm.DanhMucID
WHERE dm.TenDanhMuc = N'Ngũ cốc'


-- 2. Tìm các sản phẩm "Gia Vị" thuộc nhà cung cấp "ABC"
SELECT sp.TenSanPham, dm.TenDanhMuc, ncc.TenDayDu, ncc.TenLienHe
FROM SanPham as sp
JOIN DanhMuc as dm on sp.DanhMucID = dm.DanhMucID
JOIN NhaCungCap as ncc on sp.NhaCungCapID = ncc.NhaCungCapID
WHERE dm.TenDanhMuc = N'Gia vị' and ncc.TenLienHe = N'ABC'


-- 3. Cho biết dịch vụ Grab đã giao được tổng cộng bao nhiêu đơn hàng?
SELECT count(dh.DonHangID)
FROM DonHang as dh
JOIN Shippers as sper on dh.ShipperID = sper.ShipperID
WHERE sper.ShiperName = 'Grab'


-- 4. Cho biết tên khách hàng, tên nhân viên bán hàng và tên dịch vụ  giao hàng của đơn hàng "10248"
SELECT kh.HoTen, nv.Ho + ' ' + nv.Ten AS [Họ và tên], sper.ShiperName
FROM DonHang as dh
JOIN NhanVien as nv on dh.NhanVienID = nv.NhanVienID
JOIN KhachHang as kh on kh.KhachHangID = dh.KhachHangID
JOIN Shippers as sper on dh.ShipperID = sper.ShipperID
WHERE dh.DonHangID = 10248

-- 5. Cho biết số lượng, đơn giá, thành tiền của từng sản phẩm trong đơn hàng "10248"
SELECT sp.TenSanPham, sp.Gia, dhct.Soluong, (sp.Gia * dhct.Soluong) as ThanhTien
FROM DonHangChiTiet as dhct
JOIN SanPham as sp on dhct.SanPhamID = sp.SanPhamID
JOIN DonHang as dh on dh.DonHangID = dhct.DonHangID
WHERE dh.DonHangID = 10248

-- 6. Tính tổng tiền của đơn hàng "10248"
SELECT sum(sp.Gia * dhct.Soluong) as TongTien
FROM DonHangChiTiet as dhct
JOIN SanPham as sp on dhct.SanPhamID = sp.SanPhamID
JOIN DonHang as dh on dh.DonHangID = dhct.DonHangID
WHERE dh.DonHangID = 10248

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


-- 9. Đếm tổng sổ đơn hàng bán được trong tháng 7.2022
SELECT COUNT(DonHangID) AS TongSoDon
FROM DonHang
WHERE NgayDatHang >= '2022-07-01'
  AND NgayDatHang < '2022-08-01';

-- 10. Liệt kê những đơn hàng bán trong T7.2022
SELECT NgayDatHang
FROM DonHang
WHERE NgayDatHang >= '2022-07-01'
  AND NgayDatHang < '2022-08-01';