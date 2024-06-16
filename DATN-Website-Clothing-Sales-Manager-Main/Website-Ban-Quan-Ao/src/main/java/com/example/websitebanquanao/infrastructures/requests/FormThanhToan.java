package com.example.websitebanquanao.infrastructures.requests;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class FormThanhToan {
    private String hoTen;
    private String tinhThanhPho;
    private String quanHuyen;
    private String xaPhuong;
    private String diaChi;
    private String soDienThoai;
    private String email;
    private int hinhThucThanhToan;
    private String ghiChu;
}
