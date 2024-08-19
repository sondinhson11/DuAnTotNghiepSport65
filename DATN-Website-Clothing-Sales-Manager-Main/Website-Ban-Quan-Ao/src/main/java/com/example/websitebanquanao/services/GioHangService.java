package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.GioHang;
import com.example.websitebanquanao.entities.SanPhamChiTiet;
import com.example.websitebanquanao.infrastructures.requests.GioHangUserRequest;
import com.example.websitebanquanao.infrastructures.responses.GioHangUserResponse;
import com.example.websitebanquanao.repositories.GioHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class GioHangService {

    @Autowired
    private GioHangRepository gioHangRepository;

    @Autowired
    private SanPhamChiTietService sanPhamChiTietService;

    @Autowired
    private KhuyenMaiChiTietService khuyenMaiChiTietService;

    @Autowired
    private KhachHangService khachHangService;

    public List<GioHangUserResponse> getListByIdKhachHang(UUID idKhachHang) {
        return gioHangRepository.getListByIdKhachHang(idKhachHang);
    }

    public void add(UUID idSanPham, UUID idKhachHang, GioHangUserRequest gioHangUserRequest) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietService.getByIdSanPhamAndIdMauSacAndIdKichCo(idSanPham, gioHangUserRequest.getIdMauSac(), gioHangUserRequest.getIdKichCo());

        GioHang gioHang = gioHangRepository.findByIdSanPhamChiTietIdAndIdGioHangId(sanPhamChiTiet.getId(), idKhachHang);

        if (gioHang != null) {
            gioHang.setSoLuong(gioHang.getSoLuong() + gioHangUserRequest.getSoLuong());

            gioHangRepository.save(gioHang);

            System.out.println("GioHangService.update: " + gioHang.getId());
        } else {
            Integer soPhanTramGiamGia = khuyenMaiChiTietService.getSoPhanTramGiamByIdSanPhamChiTiet(sanPhamChiTiet.getId());
            BigDecimal giaBan = sanPhamChiTiet.getGia();
            BigDecimal giaBanSauKhuyenMai = giaBan.subtract(giaBan.multiply(new BigDecimal(soPhanTramGiamGia)).divide(new BigDecimal(100)));

            gioHang = new GioHang();

            gioHang.setIdKhachHang(khachHangService.getById1(idKhachHang));
            java.util.Date currentDate = new java.util.Date();
            gioHang.setNgay_tao(new java.sql.Date(currentDate.getTime()));
            gioHang.setNgay_sua(new java.sql.Date(currentDate.getTime()));
            gioHang.setIdSanPhamChiTiet(sanPhamChiTiet);
            gioHang.setSoLuong(gioHangUserRequest.getSoLuong());
            gioHang.setGia(giaBanSauKhuyenMai);

            gioHangRepository.save(gioHang);

            System.out.println("GioHangChiTietService.add: " + gioHang.getId());
        }
    }

    @Transactional
    public void updateByIdSanPhamChiTietAndIdKhachHang(UUID idSanPhamChiTiet, UUID idKhachHang, Integer soLuong) {

        GioHang gioHang = gioHangRepository.findByIdSanPhamChiTietIdAndIdGioHangId(idSanPhamChiTiet, idKhachHang);
        java.util.Date currentDate = new java.util.Date();
        gioHang.setNgay_sua(new java.sql.Date(currentDate.getTime()));
        gioHang.setSoLuong(soLuong);

        gioHangRepository.save(gioHang);

        System.out.println("GioHangService.updateByIdSanPhamChiTietAndIdKhachHang: " + gioHang.getId());
    }

    @Transactional
    public void deleteByIdSanPhamChiTietAndIdKhachHang(UUID idSanPhamChiTiet, UUID idKhachHang) {
        gioHangRepository.deleteByIdSanPhamChiTietAndIdKhachHang(idSanPhamChiTiet, idKhachHang);
        System.out.println("GioHangService.deleteByIdSanPhamChiTietAndIdKhachHang: " + idSanPhamChiTiet + " " + idKhachHang);
    }

    @Transactional
    public void deleteByIdKhachHang(UUID idKhachHang) {
        gioHangRepository.deleteByIdKhachHang(idKhachHang);
        System.out.println("GioHangService.deleteByIdKhachHang: " + idKhachHang);
    }

    public BigDecimal getTongTienByIdKhachHang(UUID idKhachHang) {
        if (gioHangRepository.getTongTienByIdKhachHang(idKhachHang) == null) {
            return new BigDecimal(0);
        } else {
            return gioHangRepository.getTongTienByIdKhachHang(idKhachHang);
        }
    }

    public Integer sumSoLuongByIdKhachHang(UUID idKhachHang) {
        Integer sumSoLuong = gioHangRepository.sumSoLuongByIdKhachHang(idKhachHang);
        if (sumSoLuong == null) {
            return 0;
        } else {
            return sumSoLuong;
        }
    }
}
