CREATE DATABASE Sport65_SD65_SU24
GO
USE Sport65_SD65_SU24
GO

CREATE TABLE loai
(
    id  INT IDENTITY (1, 1) PRIMARY KEY,
    ten NVARCHAR(50) NOT NULL,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE thuong_hieu
(
    id  INT IDENTITY (1, 1) PRIMARY KEY,
    ten NVARCHAR(50) NOT NULL,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT
)

CREATE TABLE cau_lac_bo
(
    id  INT IDENTITY (1, 1) PRIMARY KEY,
    ten NVARCHAR(50) NOT NULL,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE san_pham
(
    id       UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ten      NVARCHAR(MAX) NOT NULL,
    anh      NVARCHAR(MAX),
    id_loai  INT           NOT NULL,
	id_thuong_hieu  INT  NOT NULL,
	id_cau_lac_bo  INT  NOT NULL,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT
)

CREATE TABLE mau_sac
(
    id  INT IDENTITY (1, 1) PRIMARY KEY,
    ten NVARCHAR(50) NOT NULL,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE kich_co
(
    id  INT IDENTITY (1, 1) PRIMARY KEY,
    ten NVARCHAR(50) NOT NULL,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE san_pham_chi_tiet
(
    id          UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ma_san_pham VARCHAR(20),
    id_san_pham UNIQUEIDENTIFIER,
    id_kich_co  INT,
    id_mau_sac  INT,
    so_luong    INT,
    mo_ta       NVARCHAR(MAX),
	gia         DECIMAL(20, 0)               DEFAULT 0,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT
)

CREATE TABLE anh_san_pham
(
    id                   UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_san_pham UNIQUEIDENTIFIER,
    duong_dan            NVARCHAR(MAX) NOT NULL,
    trang_thai  INT 
)

CREATE TABLE khach_hang
(
    id             UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ho_va_ten      NVARCHAR(100) NOT NULL,
    email          NVARCHAR(50) NOT NULL,
    so_dien_thoai  NVARCHAR(15)	,
	dia_chi        NVARCHAR(100) , 
    xa_phuong      NVARCHAR(80) ,
    quan_huyen     NVARCHAR(80) ,
    tinh_thanh_pho NVARCHAR(80) ,
    mat_khau       NVARCHAR(50) ,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE nhan_vien
(
    id             UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ma             VARCHAR(20) UNIQUE NOT NULL,
    ho_va_ten      NVARCHAR(100),
    email          NVARCHAR(50),
    so_dien_thoai  NVARCHAR(15),
    mat_khau       NVARCHAR(50),
    dia_chi        NVARCHAR(100),
    xa_phuong      NVARCHAR(80),
    quan_huyen     NVARCHAR(80),
    tinh_thanh_pho NVARCHAR(80),
    ngay_vao_lam   DATE,
    chuc_vu        INT,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE gio_hang
(
    id            UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_khach_hang UNIQUEIDENTIFIER,
    id_nhan_vien  UNIQUEIDENTIFIER
)

CREATE TABLE gio_hang_chi_tiet
(
    id                   UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_gio_hang          UNIQUEIDENTIFIER,
    id_san_pham_chi_tiet UNIQUEIDENTIFIER,
    gia                  DECIMAL(20, 0)               DEFAULT 0,
    so_luong             INT,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE khuyen_mai
(
    id                UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ma                VARCHAR(10) UNIQUE NOT NULL,
    ten               NVARCHAR(50),
    so_phan_tram_giam INT,
    ngay_bat_dau      DATE,
    ngay_ket_thuc     DATE,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE khuyen_mai_chi_tiet
(
    id                   UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_khuyen_mai        UNIQUEIDENTIFIER,
    id_san_pham_chi_tiet UNIQUEIDENTIFIER,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)


CREATE TABLE giam_gia
(
    id                UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ma                VARCHAR(10) NOT NULL,
    so_phan_tram_giam INT,
	 so_phan_tien_giam_toi_thieu INT,
    so_luong          INT,
    ngay_bat_dau      DATE,
    ngay_ket_thuc     DATE,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE hinh_thuc_thanh_toan
(
   id  INT IDENTITY (1, 1) PRIMARY KEY,
    ten NVARCHAR(50) NOT NULL,
	ma NVARCHAR(50) NOT NULL,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE hoa_don
(
    id                       UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ma                       VARCHAR(50) UNIQUE NOT NULL,
    -- Ngày tạo hoá đơn
    ngay_tao                 DATETIME                     DEFAULT GETDATE(),
    -- Ngày thanh toán
    ngay_thanh_toan          DATETIME,
    -- Ngày vận chuyển
    ngay_van_chuyen          DATETIME,
    -- Ngày nhận hàng
    ngay_nhan                DATETIME,
    -- id người mua
    id_khach_hang            UNIQUEIDENTIFIER,
    -- id người duyệt
    id_nhan_vien             UNIQUEIDENTIFIER,
    id_giam_gia              UNIQUEIDENTIFIER,
    id_hinh_thuc_thanh_toan  INTEGER NULL,
    nguoi_nhan               NVARCHAR(100),
    email                    NVARCHAR(50),
    so_dien_thoai            NVARCHAR(15),
    dia_chi                  NVARCHAR(100),
    xa_phuong                NVARCHAR(80),
    quan_huyen               NVARCHAR(80),
    tinh_thanh_pho           NVARCHAR(80),
    loai_hoa_don             INT,
    ma_van_chuyen            VARCHAR(50),
    ten_don_vi_van_chuyen    NVARCHAR(MAX),
    phi_van_chuyen           DECIMAL(20, 0)               DEFAULT 0,
    anh_hoa_don_chuyen_khoan NVARCHAR(MAX),
    ghi_chu                  NVARCHAR(MAX),
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE hoa_don_chi_tiet
(
    id                   UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_hoa_don           UNIQUEIDENTIFIER,
    id_san_pham_chi_tiet UNIQUEIDENTIFIER,
    id_khuyen_mai        UNIQUEIDENTIFIER,
    gia                  DECIMAL(20, 0)               DEFAULT 0,
    so_luong             INT,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

-- loai - san_pham
ALTER TABLE san_pham
    ADD FOREIGN KEY (id_loai) REFERENCES loai (id)
ALTER TABLE san_pham
	ADD FOREIGN KEY (id_cau_lac_bo) REFERENCES cau_lac_bo (id)
ALTER TABLE san_pham
    ADD FOREIGN KEY (id_thuong_hieu) REFERENCES thuong_hieu (id)

-- san_pham - san_pham_chi_tiet
ALTER TABLE san_pham_chi_tiet
    ADD FOREIGN KEY (id_san_pham) REFERENCES san_pham (id)

-- mau_sac - san_pham_chi_tiet
ALTER TABLE san_pham_chi_tiet
    ADD FOREIGN KEY (id_mau_sac) REFERENCES mau_sac (id)

-- kich_co - san_pham_chi_tiet
ALTER TABLE san_pham_chi_tiet
    ADD FOREIGN KEY (id_kich_co) REFERENCES kich_co (id)

-- san_pham - anh_san_pham
ALTER TABLE anh_san_pham
    ADD FOREIGN KEY (id_san_pham) REFERENCES san_pham (id)

-- khach_hang - gio_hang
ALTER TABLE gio_hang
    ADD FOREIGN KEY (id_khach_hang) REFERENCES khach_hang (id)

-- nhan_vien - gio_hang
ALTER TABLE gio_hang
    ADD FOREIGN KEY (id_nhan_vien) REFERENCES nhan_vien (id)

-- gio_hang - gio_hang_chi_tiet
ALTER TABLE gio_hang_chi_tiet
    ADD FOREIGN KEY (id_gio_hang) REFERENCES gio_hang (id)

-- san_pham - gio_hang_chi_tiet
ALTER TABLE gio_hang_chi_tiet
    ADD FOREIGN KEY (id_san_pham_chi_tiet) REFERENCES san_pham_chi_tiet (id)

-- khuyen_mai - khuyen_mai_chi_tiet
ALTER TABLE khuyen_mai_chi_tiet
    ADD FOREIGN KEY (id_khuyen_mai) REFERENCES khuyen_mai (id)

-- san_pham_chi_tiet - khuyen_mai_chi_tiet
ALTER TABLE khuyen_mai_chi_tiet
    ADD FOREIGN KEY (id_san_pham_chi_tiet) REFERENCES san_pham_chi_tiet (id)

-- khach_hang - hoa_don
ALTER TABLE hoa_don
    ADD FOREIGN KEY (id_khach_hang) REFERENCES khach_hang (id)

-- nhanh_vien - hoa_don
ALTER TABLE hoa_don
    ADD FOREIGN KEY (id_nhan_vien) REFERENCES nhan_vien (id)

-- khuyen_mai - hoa_don_chi_tiet
ALTER TABLE hoa_don_chi_tiet
    ADD FOREIGN KEY (id_khuyen_mai) REFERENCES khuyen_mai (id)

-- giam_gia - hoa_don
ALTER TABLE hoa_don
    ADD FOREIGN KEY (id_giam_gia) REFERENCES giam_gia (id)
ALTER TABLE hoa_don
    ADD FOREIGN KEY (id_hinh_thuc_thanh_toan) REFERENCES hinh_thuc_thanh_toan (id)

-- hoa_don - hoa_don_chi_tiet
ALTER TABLE hoa_don_chi_tiet
    ADD FOREIGN KEY (id_hoa_don) REFERENCES hoa_don (id)

-- san_pham_chi_tiet - hoa_don_chi_tiet
ALTER TABLE hoa_don_chi_tiet
    ADD FOREIGN KEY (id_san_pham_chi_tiet) REFERENCES san_pham_chi_tiet (id)


------------ INSERT HÌNH THỨC THANH TOÁN -----------------

INSERT INTO hinh_thuc_thanh_toan ( ten, ma, ngay_tao, trang_thai) 
VALUES ('Tiền mặt', 1, GETDATE(), 1);
INSERT INTO hinh_thuc_thanh_toan ( ten, ma, ngay_tao, trang_thai) 
VALUES ('Chuyển khoản', 2, GETDATE(), 1);

------------ INSERT MÀU SẮC-----------------
INSERT INTO mau_sac ( ten,  ngay_tao, trang_thai) 
VALUES ('Đỏ',  GETDATE(), 1);
INSERT INTO mau_sac ( ten,  ngay_tao, trang_thai) 
VALUES ('Tím',  GETDATE(), 1);
INSERT INTO mau_sac ( ten,  ngay_tao, trang_thai) 
VALUES ('Đen', GETDATE(), 0);

------------ INSERT KÍCH CỠ -----------------

INSERT INTO kich_co ( ten,  ngay_tao, trang_thai) 
VALUES ('L',  GETDATE(), 1);
INSERT INTO kich_co ( ten,  ngay_tao, trang_thai) 
VALUES ('XL',  GETDATE(), 1);
INSERT INTO kich_co ( ten,  ngay_tao, trang_thai) 
VALUES ('S',  GETDATE(), 1);

------------ INSERT LOẠI-----------------

INSERT INTO loai ( ten,  ngay_tao, trang_thai) 
VALUES ('Euro 2024',  GETDATE(), 1);
INSERT INTO loai ( ten,  ngay_tao, trang_thai) 
VALUES ('WC',  GETDATE(), 1);
INSERT INTO loai ( ten,  ngay_tao, trang_thai) 
VALUES ('FA',  GETDATE(), 1);

------------ INSERT CÂU LẠC BỘ-----------------

INSERT INTO cau_lac_bo ( ten,  ngay_tao, trang_thai) 
VALUES ('Đức', GETDATE(), 1);
INSERT INTO cau_lac_bo ( ten,  ngay_tao, trang_thai) 
VALUES ('Anh', GETDATE(), 1);
INSERT INTO cau_lac_bo ( ten,  ngay_tao, trang_thai) 
VALUES ('Bỉ',  GETDATE(), 1);

------------ INSERT THƯƠNG HIỆU-----------------

INSERT INTO thuong_hieu ( ten, ngay_tao, trang_thai) 
VALUES ('Adidas',  GETDATE(), 1);
INSERT INTO thuong_hieu ( ten, ngay_tao, trang_thai) 
VALUES ('Sport65',  GETDATE(), 1);
INSERT INTO thuong_hieu ( ten,  ngay_tao, trang_thai) 
VALUES ('Pepsi',  GETDATE(), 1);