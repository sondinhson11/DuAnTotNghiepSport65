package com.example.websitebanquanao.infrastructures.requests;

import io.micrometer.common.util.StringUtils;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Component
public class KhachHangRequest {
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

    public boolean validNull() {
        return
                StringUtils.isEmpty(hoVaTen) ||
                        email == null ||
                        soDienThoai == null ||
                        matKhau == null ||
                        diaChi == null ||
                        xaPhuong == null ||
                        quanHuyen == null ||
                        tinhThanhPho == null;
    }

}
