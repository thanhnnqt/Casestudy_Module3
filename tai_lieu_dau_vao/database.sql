CREATE DATABASE case_study;
USE case_study;

-- Bảng tài khoản dùng chung
CREATE TABLE account (
    account_id     INT AUTO_INCREMENT PRIMARY KEY,
    username       VARCHAR(50) UNIQUE NOT NULL,
    password_hash  VARCHAR(255) NOT NULL,
    role           ENUM('KHACH_HANG','NHAN_VIEN') NOT NULL
);

-- Bảng nhân viên
CREATE TABLE nhan_vien (
    nhan_vien_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id   INT NOT NULL,
    ho_ten       VARCHAR(100) NOT NULL,
    ngay_sinh    DATE,
    sdt          VARCHAR(15),
    luong        DECIMAL(12,2),
    email        VARCHAR(50),
    CONSTRAINT fk_nv_account FOREIGN KEY (account_id) REFERENCES account(account_id)
);

-- Bảng khách hàng (có CCCD)
CREATE TABLE khach_hang (
    khach_hang_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id    INT NOT NULL,
    ho_ten        VARCHAR(100) NOT NULL,
    cccd          VARCHAR(20) UNIQUE NOT NULL,
    sdt           VARCHAR(15),
    dia_chi       VARCHAR(255),
    email         VARCHAR(50),
    ngay_sinh     DATE,
    CONSTRAINT fk_kh_account FOREIGN KEY (account_id) REFERENCES account(account_id)
);

-- Sản phẩm cầm
CREATE TABLE san_pham (
    san_pham_id   INT AUTO_INCREMENT PRIMARY KEY,
    ten_san_pham  VARCHAR(100) NOT NULL,
    mo_ta         TEXT,
    gia_tri_cam   DECIMAL(12,2) NOT NULL,
    tinh_trang    VARCHAR(100)
);

-- Hợp đồng cầm đồ (liên kết KH - NV - SP)
CREATE TABLE hop_dong_cam_do (
    hop_dong_cam_id INT AUTO_INCREMENT PRIMARY KEY,
    khach_hang_id   INT NOT NULL,
    nhan_vien_id    INT NOT NULL,
    san_pham_id     INT NOT NULL,
    ngay_cam        DATE NOT NULL,
    so_tien_cam     DECIMAL(12,2) NOT NULL,
    lai_suat        DECIMAL(5,2),
    han_tra         DATE,
    ngay_tra        DATE,                  -- ngày khách thực tế trả/chuộc
    CONSTRAINT fk_cam_kh FOREIGN KEY (khach_hang_id) REFERENCES khach_hang(khach_hang_id),
    CONSTRAINT fk_cam_nv FOREIGN KEY (nhan_vien_id) REFERENCES nhan_vien(nhan_vien_id),
    CONSTRAINT fk_cam_sp FOREIGN KEY (san_pham_id) REFERENCES san_pham(san_pham_id)
);


-- Hợp đồng thanh lý (liên kết NV - SP; KH có thể NULL nếu bán cho người ngoài)
CREATE TABLE hop_dong_thanh_ly (
    hop_dong_thanh_ly_id INT AUTO_INCREMENT PRIMARY KEY,
    nhan_vien_id         INT NOT NULL,
    san_pham_id          INT NOT NULL,
    khach_hang_id        INT,  -- nếu cần ghi nhận người mua
    ngay_thanh_ly        DATE NOT NULL,
    gia_ban              DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_tl_nv  FOREIGN KEY (nhan_vien_id)  REFERENCES nhan_vien(nhan_vien_id),
    CONSTRAINT fk_tl_sp  FOREIGN KEY (san_pham_id)   REFERENCES san_pham(san_pham_id),
    CONSTRAINT fk_tl_kh  FOREIGN KEY (khach_hang_id) REFERENCES khach_hang(khach_hang_id)
);
