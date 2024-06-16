package com.example.websitebanquanao.infrastructures.requests;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

import java.sql.Date;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Component

public class DiaChiRequest {
    @NotBlank(message = "Mã không được để trống")
    private String ma;
    @NotBlank(message = "Địa chỉ không được để trống")
    private String diaChi;
    @NotBlank(message = "Số điện thoại nhận không được để trống")
    private String soDienThoaiNhan;
    @NotBlank(message = "Xã phường không được để trống")
    private String xaPhuong;
    @NotBlank(message = "Quận guyện không được để trống")
    private String quanHuyen;
    @NotBlank(message = "Tinh thành phố không được để trống")
    private String tinhThanhPho;
    private Date ngayTao;
    private Date ngaySua;
    private Integer trangThai;

}
