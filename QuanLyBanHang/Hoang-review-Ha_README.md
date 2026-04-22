# 📋 Review & Góp Ý SQL Bài Làm

Dưới đây là một số nhận xét và đề xuất cải thiện cho các câu truy vấn SQL:

---

## 🔹 Câu 3: Tìm khách hàng tên "Anh" ở Đức

### ❗ Vấn đề:

* Tên cột `KHtenAnhoDuc` chưa rõ nghĩa, khó hiểu
* Thiếu thông tin về quốc gia trong kết quả

### ✅ Đề xuất:

* Đổi tên cột rõ ràng hơn (ví dụ: `TenKhachHang`)
* Bổ sung thêm cột `QuocGia`

---

## 🔹 Câu 7: Tìm các sản phẩm sữa và bánh

### ❗ Vấn đề:

* Điều kiện:

  ```sql
  TenSanpham LIKE N'Sữa %' OR TenSanPham LIKE N'Bánh %'
  ```

  chỉ tìm các sản phẩm **bắt đầu bằng** "Sữa" hoặc "Bánh"

* 👉 Bị sót các trường hợp như:

  * *“Hộp bánh Cookies Đại Phát (240g)”*
  * *“Thùng 24 Hộp Sữa Đậu Dalat Milk”*

### ✅ Đề xuất:

* Sử dụng:

  ```sql
  LIKE N'%sữa%' OR LIKE N'%bánh%'
  ```

  để tìm kiếm linh hoạt hơn

---

## 🔹 Câu 10.1 & 10.2: Nhân viên nhỏ tuổi nhất / lớn tuổi nhất

### ❗ Vấn đề:

* Kết quả chỉ hiển thị **họ tên**, thiếu thông tin **ngày sinh**
* Khó kiểm chứng và không rõ ràng

### ✅ Đề xuất:

* Bổ sung thêm cột `NgaySinh`
* Hiển thị đầy đủ thông tin giúp dễ đối chiếu

---

## ✅ Tổng kết

* Nên đặt **alias (tên cột)** rõ ràng, dễ hiểu
* Cần đảm bảo điều kiện tìm kiếm **không bỏ sót dữ liệu**
* Kết quả nên hiển thị **đầy đủ thông tin cần thiết** để dễ kiểm tra

---

👉 Nhìn chung bài làm tốt, chỉ cần chỉnh lại một số chi tiết nhỏ để tối ưu và chính xác hơn.
