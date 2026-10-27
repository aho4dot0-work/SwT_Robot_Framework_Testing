# Repository kiểm thử chức năng hộp đen

Repository này dùng để xây dựng và quản lý các kịch bản **kiểm thử chức năng hộp đen (Black-box Functional Testing)** cho ứng dụng , tự động hóa giao diện bằng **Robot Framework**.

Mã nguồn ứng dụng được kiểm thử nằm ở repository riêng; repository hiện tại dành cho mã kiểm thử, tài nguyên dùng chung, biến cấu hình và kết quả chạy test.

## 1. Cấu trúc repository

```text
swt-robot-tests/
├── README.md
├── requirements.txt
├── .gitignore
├── docs/
│   ├── repository-structure.md
│   └── reference/
│       ├── SwT_Overview.md
│       ├── SwT_Robot_Framework.md
│       └── SwT_Browser.md
├── tests/
│   └── ui/
│       └── smoke/
│           └── browser_smoke.robot
├── resources/
│   ├── common/
│   │   └── browser.resource
│   └── ui/
│       └── README.md
└── variables/
    └── README.md
```

Vai trò của các thư mục:

- `tests/ui/`: chứa các test case giao diện, nên tổ chức theo nhóm nghiệp vụ hoặc mục tiêu kiểm thử khi bộ test phát triển.
- `resources/common/`: chứa các keyword và cấu hình trình duyệt dùng chung; file tài nguyên sử dụng phần mở rộng `.resource`.
- `resources/ui/`: chứa tài nguyên dùng chung dành cho từng nhóm kiểm thử giao diện.
- `variables/`: lưu biến cấu hình dùng chung khi cần tách biến khỏi test case.
- `docs/reference/`: lưu các ghi chú kỹ thuật được nhóm sử dụng làm quy ước triển khai.
- `results/`: thư mục đầu ra khi chạy test; các log và báo cáo được loại khỏi Git theo `.gitignore`.

Khi bổ sung test cho đề tài, có thể mở rộng `tests/ui/` theo các nhóm như `auth/`, `catalog/`, `cart/`, `orders/`, `favorites/` và `manager/`. Chỉ tạo các thư mục hoặc tệp khi bắt đầu triển khai test tương ứng.

## 2. Môi trường và yêu cầu

Môi trường đã được ghi nhận trong lần thực nghiệm:

| Thành phần | Phiên bản/thông tin |
| :--- | :-- |
| Hệ điều hành | Windows |
| Python | 3.14.5 (64-bit) |
| Robot Framework | 7.5 |
| Browser Library | `robotframework-browser` 20.6.0 |
| Ứng dụng kiểm thử | Django 6.1.2 trong môi trường thực nghiệm |
| Trình duyệt tự động hóa | |

Cần cài Python và môi trường chạy Browser Library. Với cách cài đặt Browser Library sử dụng Node.js riêng, hãy cài Node.js cùng npm trước khi khởi tạo thư viện. Để biết các phương án cài đặt phù hợp với cấu hình máy, xem [hướng dẫn cài đặt Browser Library](https://robotframework-browser.org/docs/start/installation/).

## 3. Cài đặt repository kiểm thử

Các lệnh dưới đây dành cho Windows PowerShell. Thực hiện tại thư mục repository kiểm thử:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt
```

Nếu `requirements.txt` cài Browser Library theo phương án sử dụng Node.js riêng, khởi tạo các dependency và trình duyệt bằng:

```powershell
rfbrowser init
```

Nếu nhóm thay đổi cách cài Browser Library, hãy đồng bộ lại lệnh khởi tạo tương ứng trong README và `requirements.txt`. Không cần cài gói Python `playwright` độc lập để viết test bằng các keyword của Robot Framework Browser Library.

Kiểm tra các lệnh đã được cài đặt:

```powershell
python --version
robot --version
rfbrowser --version
```

## 4. Khởi chạy ứng dụng được kiểm thử

Ứng dụng cần kiểm thử phải được clone và chạy riêng; repository kiểm thử này không chứa mã nguồn ứng dụng.

Trong thư mục mã nguồn ứng dụng, tạo/kích hoạt môi trường Python và cài các dependency theo cấu hình của project. Sau đó thực hiện các bước khởi tạo cơ sở dữ liệu và dữ liệu demo theo môi trường đã chuẩn bị nếu có



Mở đường dẫn giao diện của ứng dụng kiểm thử để xác nhận ứng dụng đã sẵn sàng trước khi chạy test giao diện.



 Khi viết test, nên đặt URL và thông tin đăng nhập trong biến cấu hình dùng chung, thay vì lặp lại chúng ở nhiều test case.

## 5. Chạy kiểm thử

### 5.1. Chạy bài smoke test khởi tạo

```powershell
robot --outputdir results tests/ui/smoke/browser_smoke.robot
```

Bài `browser_smoke.robot` trong bộ khung ban đầu mở `about:blank` và kiểm tra URL. Nó chỉ xác minh quá trình khởi tạo và vòng đời Browser Library, **chưa kiểm thử chức năng của Simple Online Shop**.

### 5.2. Chạy các test giao diện trong repository

```powershell
robot --outputdir results tests/ui
```

Lệnh này chạy các test đang có dưới `tests/ui/`. Khi bổ sung bộ test chức năng, hãy kiểm tra lại đường dẫn tệp và đảm bảo ứng dụng đích đang chạy trước khi thực thi.

### 5.3. Chạy theo tag

Khi các test case đã được gắn tag theo nghiệp vụ hoặc mục đích kiểm thử, có thể chạy chọn lọc, ví dụ:

```powershell
robot --include smoke --outputdir results tests/ui
robot --include cart --outputdir results tests/ui
```

Các ví dụ theo tag chỉ hoạt động khi test case tương ứng đã được gắn tag `smoke` hoặc `cart`.

## 6. Kết quả và báo cáo test

Robot Framework có thể sinh các tệp đầu ra như:

- `output.xml`: kết quả có cấu trúc của phiên chạy.
- `log.html`: nhật ký chi tiết theo từng test và keyword.
- `report.html`: báo cáo tổng hợp PASS/FAIL.

Ví dụ, khi dùng lệnh `robot --outputdir results tests/ui`, các tệp đầu ra được lưu trong `results/`. Không nên commit log và báo cáo sinh tự động trừ khi nhóm có yêu cầu lưu bằng chứng cho một phiên kiểm thử cụ thể.

## 7. Quy ước phát triển test

1. Mỗi test case nên có tên mô tả hành vi được kiểm tra và kết quả mong đợi.
2. Ưu tiên kiểm tra đầu ra nhìn thấy được qua giao diện: tiêu đề, văn bản, URL, thông báo, nội dung giỏ hàng và trạng thái đơn hàng.
3. Tái sử dụng keyword trong các tệp `.resource` để tránh lặp lại thao tác đăng nhập, điều hướng và xác minh.
4. Tổ chức biến cấu hình tập trung, nhất là URL ứng dụng và dữ liệu đăng nhập demo.
5. Dùng locator đủ cụ thể; ưu tiên locator theo vai trò và tên accessible khi phù hợp, hoặc các thuộc tính ổn định như `data-testid` nếu ứng dụng có cung cấp.
6. Với lỗi được phát hiện, ghi lại điều kiện tiền đề, bước tái hiện, dữ liệu đầu vào, kết quả mong đợi, kết quả thực tế và đường dẫn bằng chứng.
7. Không ghi nhận chức năng đã kiểm thử chỉ vì đã đọc mã nguồn hoặc đưa nó vào kế hoạch; cần có test đã chạy hoặc bằng chứng thao tác tương ứng.

## 8. Tài liệu tham khảo và liên kết

- [Robot Framework Browser Library — hướng dẫn cài đặt](https://robotframework-browser.org/docs/start/installation/)
- [Robot Framework Browser Library — trang chính](https://robotframework-browser.org/)

---

**Trạng thái repository:** Bộ khung ban đầu phục vụ phát triển kiểm thử giao diện. Cần bổ sung dần test case theo phạm vi đề tài và chỉ cập nhật trạng thái bao phủ sau khi có kết quả chạy tương ứng.
