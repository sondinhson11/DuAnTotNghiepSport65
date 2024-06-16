package com.example.websitebanquanao.infrastructures.responses;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Date;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DiaChiResponse {
    private UUID id;
    private String ma;
    private String diaChi;
    private String soDienThoaiNhan;
    private String xaPhuong;
    private String quanHuyen;
    private String tinhThanhPho;
    private Date ngayTao;
    private Date ngaySua;
    private Integer trangThai;
}
