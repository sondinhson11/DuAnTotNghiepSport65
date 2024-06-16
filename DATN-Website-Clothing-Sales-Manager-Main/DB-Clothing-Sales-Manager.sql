CREATE DATABASE DB_Clothing_Sales_Manager
GO
USE DB_Clothing_Sales_Manager
GO

CREATE TABLE loai
(
    id  INT IDENTITY (1, 1) PRIMARY KEY,
    ten NVARCHAR(50) NOT NULL
)

CREATE TABLE san_pham
(
    id       UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ten      NVARCHAR(MAX) NOT NULL,
    ngay_tao DATE,
    anh      NVARCHAR(MAX),
    id_loai  INT           NOT NULL,
)

CREATE TABLE mau_sac
(
    id  INT IDENTITY (1, 1) PRIMARY KEY,
    ten NVARCHAR(50) NOT NULL
)

CREATE TABLE kich_co
(
    id  INT IDENTITY (1, 1) PRIMARY KEY,
    ten NVARCHAR(50) NOT NULL
)

CREATE TABLE san_pham_chi_tiet
(
    id          UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ma_san_pham VARCHAR(20),
    id_san_pham UNIQUEIDENTIFIER,
    id_kich_co  INT,
    id_mau_sac  INT,
    gia         DECIMAL(20, 0)               DEFAULT 0,
    so_luong    INT,
    mo_ta       NVARCHAR(MAX),
    trang_thai  INT
)

CREATE TABLE anh_san_pham
(
    id                   UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_san_pham_chi_tiet UNIQUEIDENTIFIER,
    duong_dan            NVARCHAR(MAX) NOT NULL
)

CREATE TABLE khach_hang
(
    id             UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ho_va_ten      NVARCHAR(100),
    email          NVARCHAR(50),
    so_dien_thoai  NVARCHAR(15),
    mat_khau       NVARCHAR(50),
    dia_chi        NVARCHAR(100),
    xa_phuong      NVARCHAR(80),
    quan_huyen     NVARCHAR(80),
    tinh_thanh_pho NVARCHAR(80),
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
    trang_thai     INT,
    chuc_vu        INT
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
    so_luong             INT
)

CREATE TABLE khuyen_mai
(
    id                UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ma                VARCHAR(10) UNIQUE NOT NULL,
    ten               NVARCHAR(50),
    so_phan_tram_giam INT,
    ngay_bat_dau      DATE,
    ngay_ket_thuc     DATE,
    trang_thai        INT
)

CREATE TABLE khuyen_mai_chi_tiet
(
    id                   UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_khuyen_mai        UNIQUEIDENTIFIER,
    id_san_pham_chi_tiet UNIQUEIDENTIFIER,
)


CREATE TABLE giam_gia
(
    id                UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ma                VARCHAR(10) NOT NULL,
    so_phan_tram_giam INT,
    so_luong          INT,
    ngay_bat_dau      DATE,
    ngay_ket_thuc     DATE,
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
    nguoi_nhan               NVARCHAR(100),
    email                    NVARCHAR(50),
    so_dien_thoai            NVARCHAR(15),
    hinh_thuc_thanh_toan     INT,
    dia_chi                  NVARCHAR(100),
    xa_phuong                NVARCHAR(80),
    quan_huyen               NVARCHAR(80),
    tinh_thanh_pho           NVARCHAR(80),
    trang_thai               INT,
    loai_hoa_don             INT,
    ma_van_chuyen            VARCHAR(50),
    ten_don_vi_van_chuyen    NVARCHAR(MAX),
    phi_van_chuyen           DECIMAL(20, 0)               DEFAULT 0,
    anh_hoa_don_chuyen_khoan NVARCHAR(MAX),
    ghi_chu                  NVARCHAR(MAX)
)

CREATE TABLE hoa_don_chi_tiet
(
    id                   UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_hoa_don           UNIQUEIDENTIFIER,
    id_san_pham_chi_tiet UNIQUEIDENTIFIER,
    id_khuyen_mai        UNIQUEIDENTIFIER,
    gia                  DECIMAL(20, 0)               DEFAULT 0,
    so_luong             INT
)

-- loai - san_pham
ALTER TABLE san_pham
    ADD FOREIGN KEY (id_loai) REFERENCES loai (id)
-- san_pham - san_pham_chi_tiet
ALTER TABLE san_pham_chi_tiet
    ADD FOREIGN KEY (id_san_pham) REFERENCES san_pham (id)
-- mau_sac - san_pham_chi_tiet
ALTER TABLE san_pham_chi_tiet
    ADD FOREIGN KEY (id_mau_sac) REFERENCES mau_sac (id)
-- kich_co - san_pham_chi_tiet
ALTER TABLE san_pham_chi_tiet
    ADD FOREIGN KEY (id_kich_co) REFERENCES kich_co (id)
-- san_pham_chi_tiet - anh_san_pham
ALTER TABLE anh_san_pham
    ADD FOREIGN KEY (id_san_pham_chi_tiet) REFERENCES san_pham_chi_tiet (id)


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

-- hoa_don - hoa_don_chi_tiet
ALTER TABLE hoa_don_chi_tiet
    ADD FOREIGN KEY (id_hoa_don) REFERENCES hoa_don (id)
-- san_pham_chi_tiet - hoa_don_chi_tiet
ALTER TABLE hoa_don_chi_tiet
    ADD FOREIGN KEY (id_san_pham_chi_tiet) REFERENCES san_pham_chi_tiet (id)


