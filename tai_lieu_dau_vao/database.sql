CREATE
DATABASE case_study;
USE
case_study;

-- Bảng tài khoản dùng chung
CREATE TABLE `account`
(
    account_id    INT AUTO_INCREMENT PRIMARY KEY,
    username      VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255)       NOT NULL,
    `role`        ENUM('ADMIN', 'STAFF', 'USER') NOT NULL
);

-- Bảng nhân viên
CREATE TABLE employee
(
    employee_id  INT AUTO_INCREMENT PRIMARY KEY,
    account_id   INT                NOT NULL,
    `full_name`  VARCHAR(100)       NOT NULL,
    dob          DATE,
    phone_number VARCHAR(15),
    salary       DECIMAL(12, 2),
    email        VARCHAR(50),
    cccd         VARCHAR(20) UNIQUE NOT NULL,
    FOREIGN KEY (account_id) REFERENCES `account` (account_id)
);

-- Bảng khách hàng (có CCCD)
CREATE TABLE customer
(
    customer_id  INT AUTO_INCREMENT PRIMARY KEY,
    account_id   INT                NOT NULL,
    full_name    VARCHAR(100)       NOT NULL,
    cccd         VARCHAR(20) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    address      VARCHAR(255),
    email        VARCHAR(50),
    dob          DATE,
    FOREIGN KEY (account_id) REFERENCES account (account_id)
);

-- Sản phẩm cầm
CREATE TABLE product
(
    product_id    INT AUTO_INCREMENT PRIMARY KEY,
    product_name  VARCHAR(100)   NOT NULL,
    `description` TEXT,
    pawn_price    DECIMAL(12, 2) NOT NULL,
    `status`      VARCHAR(100)
);

-- Hợp đồng cầm đồ (liên kết KH - NV - SP)
CREATE TABLE pawn_contract
(
    pawn_contract_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id      INT            NOT NULL,
    employee_id      INT            NOT NULL,
    product_id       INT            NOT NULL,
    pawn_date        DATE           NOT NULL,
    pawn_price       DECIMAL(12, 2) NOT NULL,
    interest_rate    DECIMAL(5, 2),
    due_date         DATE,
    return_date      DATE, -- ngày khách thực tế trả/chuộc
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    FOREIGN KEY (employee_id) REFERENCES employee (employee_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);


-- Hợp đồng thanh lý (liên kết NV - SP; KH có thể NULL nếu bán cho người ngoài)
CREATE TABLE liquidation_contract
(
    liquidation_contract_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id             INT            NOT NULL,
    product_id              INT            NOT NULL,
    customer_id             INT, -- nếu cần ghi nhận người mua
    liquidation_date        DATE           NOT NULL,
    price                   DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employee (employee_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id),
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);

USE
case_study;

-- ==========================
-- 1. Account (20 tài khoản)
-- ==========================
INSERT INTO account (username, password_hash, `role`)
VALUES ('user1', 'pass1', 'USER'),
       ('user2', 'pass2', 'USER'),
       ('user3', 'pass3', 'USER'),
       ('user4', 'pass4', 'USER'),
       ('user5', 'pass5', 'USER'),
       ('user6', 'pass6', 'USER'),
       ('user7', 'pass7', 'USER'),
       ('user8', 'pass8', 'USER'),
       ('user9', 'pass9', 'USER'),
       ('user10', 'pass10', 'USER'),
       ('user11', 'pass11', 'USER'),
       ('user12', 'pass12', 'USER'),
       ('user13', 'pass13', 'USER'),
       ('user14', 'pass14', 'USER'),
       ('user15', 'pass15', 'USER'),
       ('staff1', 'passstaff1', 'STAFF'),
       ('staff2', 'passstaff2', 'STAFF'),
       ('staff3', 'passstaff3', 'STAFF'),
       ('staff4', 'passstaff4', 'STAFF'),
       ('staff5', 'passstaff5', 'STAFF');

-- ==========================
-- 2. Employee (5 nhân viên)
-- ==========================
INSERT INTO employee (account_id, full_name, dob, phone_number, salary, email, cccd)
VALUES (16, 'Nguyen Van A', '1995-05-10', '0901111111', 12000000, 'nva@company.com', '012345678901'),
       (17, 'Tran Thi B', '1998-07-22', '0902222222', 10000000, 'ttb@company.com', '012345678902'),
       (18, 'Le Van C', '1990-01-15', '0903333333', 15000000, 'lvc@company.com', '012345678903'),
       (19, 'Pham Thi D', '1992-03-12', '0904444444', 11000000, 'ptd@company.com', '012345678904'),
       (20, 'Hoang Van E', '1988-08-08', '0905555555', 13000000, 'hve@company.com', '012345678905');

-- ==========================
-- 3. Customer (15 khách hàng)
-- ==========================
INSERT INTO customer (account_id, full_name, cccd, phone_number, address, email, dob)
VALUES (1, 'Pham Van F', '111111111111', '0911111111', 'Ha Noi', 'c1@mail.com', '2000-03-12'),
       (2, 'Le Thi G', '222222222222', '0922222222', 'Hai Phong', 'c2@mail.com', '1999-10-05'),
       (3, 'Hoang Van H', '333333333333', '0933333333', 'Nam Dinh', 'c3@mail.com', '1997-01-21'),
       (4, 'Tran Thi I', '444444444444', '0944444444', 'Ha Nam', 'c4@mail.com', '1996-07-15'),
       (5, 'Nguyen Van J', '555555555555', '0955555555', 'Hai Duong', 'c5@mail.com', '2001-11-30'),
       (6, 'Do Thi K', '666666666666', '0966666666', 'Ha Noi', 'c6@mail.com', '2002-06-18'),
       (7, 'Pham Van L', '777777777777', '0977777777', 'Thanh Hoa', 'c7@mail.com', '1995-12-25'),
       (8, 'Nguyen Thi M', '888888888888', '0988888888', 'Nghe An', 'c8@mail.com', '1998-04-10'),
       (9, 'Le Van N', '999999999999', '0912345678', 'Hai Phong', 'c9@mail.com', '1999-09-09'),
       (10, 'Tran Van O', '101010101010', '0923456789', 'Ha Noi', 'c10@mail.com', '2000-01-01'),
       (11, 'Pham Thi P', '111213141516', '0934567890', 'Nam Dinh', 'c11@mail.com', '1997-12-12'),
       (12, 'Hoang Van Q', '121314151617', '0945678901', 'Ha Nam', 'c12@mail.com', '1996-06-06'),
       (13, 'Nguyen Van R', '131415161718', '0956789012', 'Hai Duong', 'c13@mail.com', '2001-03-03'),
       (14, 'Do Thi S', '141516171819', '0967890123', 'Ha Noi', 'c14@mail.com', '2002-02-02'),
       (15, 'Pham Van T', '151617181920', '0978901234', 'Thanh Hoa', 'c15@mail.com', '1995-05-05');

-- ==========================
-- 4. Product (30 sản phẩm)
-- ==========================
INSERT INTO product (product_name, description, pawn_price, status)
VALUES ('Laptop Dell XPS', 'Laptop i7 đời 2020', 15000000, 'Đang cầm'),
       ('Xe máy Vision', 'Honda Vision 2019', 20000000, 'Đang cầm'),
       ('Iphone 13', '128GB màu đen', 18000000, 'Đã chuộc'),
       ('Nhẫn vàng 18K', 'Trang sức vàng', 10000000, 'Thanh lý'),
       ('Máy ảnh Canon', 'Canon 700D + lens 50mm', 12000000, 'Đang cầm'),
       ('Tivi Samsung 55 inch', 'Smart TV 4K', 14000000, 'Đang cầm'),
       ('Laptop Macbook Pro', 'Macbook Pro M1 2021', 25000000, 'Đang cầm'),
       ('Xe AirBlade', 'Honda AirBlade 2020', 30000000, 'Đang cầm'),
       ('Điện thoại Oppo Reno6', 'Oppo chính hãng', 8000000, 'Đã chuộc'),
       ('Vàng 24K', 'Dây chuyền vàng 24K', 22000000, 'Thanh lý'),
       ('Máy giặt LG', 'Máy giặt LG Inverter 9kg', 7000000, 'Đang cầm'),
       ('Tủ lạnh Toshiba', 'Tủ lạnh 300L', 9000000, 'Đang cầm'),
       ('Điện thoại Samsung S21', 'Samsung S21 256GB', 20000000, 'Đang cầm'),
       ('Xe máy Exciter', 'Yamaha Exciter 150', 28000000, 'Đang cầm'),
       ('Laptop HP Envy', 'Laptop HP đời 2021', 16000000, 'Đang cầm'),
       ('Iphone 12', '128GB màu trắng', 15000000, 'Đã chuộc'),
       ('Nhẫn bạc 925', 'Trang sức bạc', 5000000, 'Thanh lý'),
       ('Máy ảnh Nikon', 'Nikon D5600 + lens', 13000000, 'Đang cầm'),
       ('Tivi LG 50 inch', 'Smart TV 4K', 12000000, 'Đang cầm'),
       ('Laptop Asus ROG', 'Laptop chơi game', 30000000, 'Đang cầm'),
       ('Xe máy Lead', 'Honda Lead 2020', 18000000, 'Đang cầm'),
       ('Điện thoại Xiaomi Mi 11', '128GB', 9000000, 'Đã chuộc'),
       ('Vàng 18K', 'Lắc vàng 18K', 20000000, 'Thanh lý'),
       ('Máy giặt Electrolux', '9kg Inverter', 8000000, 'Đang cầm'),
       ('Tủ lạnh Panasonic', '300L', 10000000, 'Đang cầm'),
       ('Laptop Lenovo', 'Core i5 2020', 12000000, 'Đang cầm'),
       ('Xe máy Winner', 'Honda Winner X', 25000000, 'Đang cầm'),
       ('Iphone 11', '128GB', 13000000, 'Đã chuộc'),
       ('Nhẫn vàng 24K', 'Vàng nữ trang', 25000000, 'Thanh lý'),
       ('Máy ảnh Sony', 'Sony Alpha 7', 22000000, 'Đang cầm'),
       ('Tivi Sony 55 inch', 'Smart TV', 18000000, 'Đang cầm');

-- ==========================
-- 5. Pawn Contract (30 hợp đồng)
-- ==========================
INSERT INTO pawn_contract (customer_id, employee_id, product_id, pawn_date, pawn_price, interest_rate, due_date,
                           return_date)
VALUES (1, 1, 1, '2025-01-01', 15000000, 3.5, '2025-04-01', '2025-03-01'),
       (2, 2, 2, '2025-01-05', 20000000, 4.0, '2025-04-05', NULL),
       (3, 3, 3, '2025-01-10', 18000000, 3.0, '2025-04-10', '2025-03-15'),
       (4, 4, 4, '2025-01-12', 10000000, 3.2, '2025-04-12', NULL),
       (5, 5, 5, '2025-01-15', 12000000, 3.8, '2025-04-15', '2025-03-20'),
       (6, 1, 6, '2025-01-20', 14000000, 3.0, '2025-04-20', NULL),
       (7, 2, 7, '2025-01-22', 25000000, 4.5, '2025-04-22', '2025-03-25'),
       (8, 3, 8, '2025-01-25', 30000000, 3.9, '2025-04-25', NULL),
       (9, 4, 9, '2025-01-28', 8000000, 3.5, '2025-04-28', '2025-03-30'),
       (10, 5, 10, '2025-02-01', 22000000, 4.0, '2025-05-01', NULL),
       (11, 1, 11, '2025-02-05', 7000000, 3.1, '2025-05-05', NULL),
       (12, 2, 12, '2025-02-10', 9000000, 3.7, '2025-05-10', NULL),
       (13, 3, 13, '2025-02-12', 20000000, 4.0, '2025-05-12', '2025-04-15'),
       (14, 4, 14, '2025-02-15', 28000000, 4.5, '2025-05-15', NULL),
       (15, 5, 15, '2025-02-18', 16000000, 3.2, '2025-05-18', NULL),
       (1, 1, 16, '2025-02-20', 15000000, 3.3, '2025-05-20', '2025-04-22'),
       (2, 2, 17, '2025-02-25', 13000000, 3.7, '2025-05-25', NULL),
       (3, 3, 18, '2025-03-01', 13000000, 3.5, '2025-06-01', NULL),
       (4, 4, 19, '2025-03-05', 30000000, 4.0, '2025-06-05', '2025-05-01'),
       (5, 5, 20, '2025-03-10', 18000000, 3.9, '2025-06-10', NULL),
       (6, 1, 21, '2025-03-12', 9000000, 3.1, '2025-06-12', NULL),
       (7, 2, 22, '2025-03-15', 20000000, 4.2, '2025-06-15', '2025-05-12'),
       (8, 3, 23, '2025-03-18', 8000000, 3.6, '2025-06-18', NULL),
       (9, 4, 24, '2025-03-20', 10000000, 3.5, '2025-06-20', NULL),
       (10, 5, 25, '2025-03-22', 12000000, 3.7, '2025-06-22', NULL),
       (11, 1, 26, '2025-03-25', 14000000, 4.0, '2025-06-25', NULL),
       (12, 2, 27, '2025-03-28', 25000000, 3.9, '2025-06-28', NULL),
       (13, 3, 28, '2025-03-30', 22000000, 3.7, '2025-06-30', NULL),
       (14, 4, 29, '2025-04-01', 25000000, 4.2, '2025-07-01', '2025-05-30'),
       (15, 5, 30, '2025-04-03', 18000000, 3.6, '2025-07-03', NULL);

-- ==========================
-- 6. Liquidation Contract (15 hợp đồng)
-- ==========================
INSERT INTO liquidation_contract (employee_id, product_id, customer_id, liquidation_date, price)
VALUES (1, 4, NULL, '2025-04-05', 9500000),
       (2, 3, 2, '2025-04-06', 17000000),
       (3, 10, NULL, '2025-04-08', 21000000),
       (4, 15, 5, '2025-04-10', 12000000),
       (5, 20, NULL, '2025-04-12', 22000000),
       (1, 22, 8, '2025-04-15', 20000000),
       (2, 24, NULL, '2025-04-18', 8000000),
       (3, 28, 12, '2025-04-20', 23000000),
       (4, 29, NULL, '2025-04-22', 25000000),
       (5, 30, 15, '2025-04-25', 18000000),
       (1, 19, NULL, '2025-04-27', 30000000),
       (2, 18, 7, '2025-04-28', 13000000),
       (3, 16, NULL, '2025-04-29', 15000000),
       (4, 12, 3, '2025-04-30', 9000000),
       (5, 7, NULL, '2025-05-01', 25000000);


select *
from `account`;
select *
from employee;
select *
from customer;
select *
from product;
select *
from pawn_contract;
select *
from liquidation_contract;
