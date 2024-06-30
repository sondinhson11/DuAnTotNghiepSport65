package com.example.websitebanquanao.infrastructures.requests;

import io.micrometer.common.util.StringUtils;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

import java.sql.Date;
import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Component
public class NhanVienRequest {
    @NotBlank(message = "Họ và tên không được trống")
    private String hoVaTen;

    @Email(message = "Địa chỉ email không hợp lệ")
    private String email;

    @NotBlank(message = "Họ và tên không được trống")
    private String soDienThoai;

    @NotEmpty(message = "Mật Khẩu không được để trống")
    private String matKhau;

    @NotBlank(message = "Địa chỉ không được trống")
    private String diaChi;

    @NotBlank(message = "Xã/Phường không được trống")
    private String xaPhuong;

    @NotBlank(message = "Quận/Huyện không được trống")
    private String quanHuyen;

    @NotBlank(message = "Tỉnh/Thành phố không được trống")
    private String tinhThanhPho;

    private UUID id;
    @NotBlank(message = "Mã không được trống")
    private String ma;
    private Integer chucVu;
    private Date ngayTao;
    private Date ngaySua;
    private Integer trangThai;

    public boolean validNull() {
        return
                StringUtils.isEmpty(hoVaTen) ||
                        email == null ||
                        soDienThoai == null ||
                        matKhau == null ||
                        ma == null ||
                        diaChi == null ||
                        xaPhuong == null ||
                        quanHuyen == null ||
                        tinhThanhPho == null;
    }

    public boolean validUpdate() {
        return
                StringUtils.isEmpty(hoVaTen) ||
                        email == null ||
                        soDienThoai == null ||
                        diaChi == null ||
                        xaPhuong == null ||
                        quanHuyen == null ||
                        tinhThanhPho == null;
    }
}
