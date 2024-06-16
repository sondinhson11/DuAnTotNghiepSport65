package com.example.websitebanquanao.infrastructures.requests;

import com.example.websitebanquanao.entities.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;
import java.time.LocalDate;

@AllArgsConstructor
@Getter
@Setter

public class HoaDonRequest {

    private Instant ngayTao;

    private Instant ngayThanhToan;

    private Instant ngayVanChuyen;

    private Instant ngayNhan;

    private KhachHang idKhachHang;

    private NhanVien idNhanVien;

    private KhuyenMai idKhuyenMai;

    private GiamGia idGiamGia;

    private String nguoiNhan;

    private String email;

    private String soDienThoai;

    private Integer hinhThucThanhToan;

    private String diaChi;

    private String xaPhuong;

    private String quanHuyen;

    private String tinhThanhPho;

    private Integer trangThai;

    private Integer loaiHoaDon;
}
