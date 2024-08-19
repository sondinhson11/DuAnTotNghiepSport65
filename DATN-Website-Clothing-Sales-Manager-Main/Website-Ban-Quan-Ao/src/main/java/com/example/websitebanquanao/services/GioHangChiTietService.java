package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.GioHangChiTiet;
import com.example.websitebanquanao.entities.SanPhamChiTiet;
import com.example.websitebanquanao.infrastructures.requests.GioHangUserRequest;
import com.example.websitebanquanao.infrastructures.responses.GioHangUserResponse;
import com.example.websitebanquanao.repositories.GioHangChiTietRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class GioHangChiTietService {
    @Autowired
    private GioHangChiTietRepository gioHangChiTietRepository;

    @Autowired
    private SanPhamChiTietService sanPhamChiTietService;

    @Autowired
    private KhuyenMaiChiTietService khuyenMaiChiTietService;

    @Autowired
    private KhachHangService khachHangService;

    public List<GioHangUserResponse> getListByIdKhachHang(UUID idKhachHang) {
        return gioHangChiTietRepository.getListByIdKhachHang(idKhachHang);
    }

    public void add(UUID idSanPham, UUID idKhachHang, GioHangUserRequest gioHangUserRequest) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietService.getByIdSanPhamAndIdMauSacAndIdKichCo(idSanPham, gioHangUserRequest.getIdMauSac(), gioHangUserRequest.getIdKichCo());

        GioHangChiTiet gioHangChiTiet = gioHangChiTietRepository.findByIdSanPhamChiTietIdAndIdGioHangId(sanPhamChiTiet.getId(), idKhachHang);

        if (gioHangChiTiet != null) {
            gioHangChiTiet.setSoLuong(gioHangChiTiet.getSoLuong() + gioHangUserRequest.getSoLuong());

            gioHangChiTietRepository.save(gioHangChiTiet);

            System.out.println("GioHangChiTietService.update: " + gioHangChiTiet.getId());
        } else {
            Integer soPhanTramGiamGia = khuyenMaiChiTietService.getSoPhanTramGiamByIdSanPhamChiTiet(sanPhamChiTiet.getId());
            BigDecimal giaBan = sanPhamChiTiet.getGia();
            BigDecimal giaBanSauKhuyenMai = giaBan.subtract(giaBan.multiply(new BigDecimal(soPhanTramGiamGia)).divide(new BigDecimal(100)));

            gioHangChiTiet = new GioHangChiTiet();

            gioHangChiTiet.setIdKhachHang(khachHangService.getById1(idKhachHang));
            java.util.Date currentDate = new java.util.Date();
            gioHangChiTiet.setNgay_tao(new java.sql.Date(currentDate.getTime()));
            gioHangChiTiet.setNgay_sua(new java.sql.Date(currentDate.getTime()));
            gioHangChiTiet.setIdSanPhamChiTiet(sanPhamChiTiet);
            gioHangChiTiet.setSoLuong(gioHangUserRequest.getSoLuong());
            gioHangChiTiet.setGia(giaBanSauKhuyenMai);

            gioHangChiTietRepository.save(gioHangChiTiet);

            System.out.println("GioHangChiTietService.add: " + gioHangChiTiet.getId());
        }
    }

    @Transactional
    public void updateByIdSanPhamChiTietAndIdKhachHang(UUID idSanPhamChiTiet, UUID idKhachHang, Integer soLuong) {

        GioHangChiTiet gioHangChiTiet = gioHangChiTietRepository.findByIdSanPhamChiTietIdAndIdGioHangId(idSanPhamChiTiet, idKhachHang);
        java.util.Date currentDate = new java.util.Date();
        gioHangChiTiet.setNgay_sua(new java.sql.Date(currentDate.getTime()));
        gioHangChiTiet.setSoLuong(soLuong);

        gioHangChiTietRepository.save(gioHangChiTiet);

        System.out.println("GioHangChiTietService.updateByIdSanPhamChiTietAndIdKhachHang: " + gioHangChiTiet.getId());
    }

    @Transactional
    public void deleteByIdSanPhamChiTietAndIdKhachHang(UUID idSanPhamChiTiet, UUID idKhachHang) {
        gioHangChiTietRepository.deleteByIdSanPhamChiTietAndIdKhachHang(idSanPhamChiTiet, idKhachHang);
        System.out.println("GioHangChiTietService.deleteByIdSanPhamChiTietAndIdKhachHang: " + idSanPhamChiTiet + " " + idKhachHang);
    }

    @Transactional
    public void deleteByIdKhachHang(UUID idKhachHang) {
        gioHangChiTietRepository.deleteByIdKhachHang(idKhachHang);
        System.out.println("GioHangChiTietService.deleteByIdKhachHang: " + idKhachHang);
    }

    public BigDecimal getTongTienByIdKhachHang(UUID idKhachHang) {
        if (gioHangChiTietRepository.getTongTienByIdKhachHang(idKhachHang) == null) {
            return new BigDecimal(0);
        } else {
            return gioHangChiTietRepository.getTongTienByIdKhachHang(idKhachHang);
        }
    }

    public Integer sumSoLuongByIdKhachHang(UUID idKhachHang) {
        Integer sumSoLuong = gioHangChiTietRepository.sumSoLuongByIdKhachHang(idKhachHang);
        if (sumSoLuong == null) {
            return 0;
        } else {
            return sumSoLuong;
        }
    }
}
