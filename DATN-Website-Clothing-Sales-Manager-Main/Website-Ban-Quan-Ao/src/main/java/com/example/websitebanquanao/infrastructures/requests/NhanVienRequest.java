package com.example.websitebanquanao.infrastructures.requests;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Component
public class NhanVienRequest {
    private UUID id;
    private String ma;
    private String hoVaTen;
    private String email;
    private String soDienThoai;
    private String matKhau;
    private String diaChi;
    private String xaPhuong;
    private String quanHuyen;
    private String tinhThanhPho;
    private Integer chucVu;
    private Integer trangThai;
}
