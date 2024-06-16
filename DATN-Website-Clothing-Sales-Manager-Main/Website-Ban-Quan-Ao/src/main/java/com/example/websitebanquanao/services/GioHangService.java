package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.GioHang;
import com.example.websitebanquanao.entities.KhachHang;
import com.example.websitebanquanao.infrastructures.requests.GioHangUserRequest;
import com.example.websitebanquanao.infrastructures.responses.GioHangUserResponse;
import com.example.websitebanquanao.repositories.GioHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Service
public class GioHangService {
    @Autowired
    private GioHangRepository gioHangRepository;

    public List<GioHangUserResponse> getListByIdKhachHang(UUID idKhachHang) {
        return gioHangRepository.getListByIdKhachHang(idKhachHang);
    }

    public boolean checkAndAdd(UUID idKhachHang) {
        GioHang gioHang = gioHangRepository.checkByIdKhachHang(idKhachHang);
        if (gioHang == null) {
            gioHang = new GioHang();

            KhachHang khachHang = new KhachHang();
            khachHang.setId(idKhachHang);

            gioHang.setIdKhachHang(khachHang);

            gioHangRepository.save(gioHang);
            System.out.println("gioHangService:check account -- Da tao gio hang cho " + idKhachHang);
        } else {
            System.out.println("gioHangService:check account -- Gio hang da ton tai");
        }
        return true;
    }

    public GioHang findByIdKhachHang(UUID idKhachHang) {
        System.out.println("gioHangService:findByIdKhachHang -- Da tim thay gio hang cua " + idKhachHang);
        return gioHangRepository.findByIdKhachHang(idKhachHang);
    }
}
