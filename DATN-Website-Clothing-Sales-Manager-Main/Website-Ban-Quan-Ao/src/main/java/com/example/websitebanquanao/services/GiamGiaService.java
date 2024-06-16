package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.GiamGia;
import com.example.websitebanquanao.infrastructures.requests.GiamGiaRequest;
import com.example.websitebanquanao.infrastructures.responses.GiamGiaResponse;
import com.example.websitebanquanao.repositories.GiamGiaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.time.LocalDate;
import java.util.UUID;

@Service
@Transactional
public class GiamGiaService {
    @Autowired
    private GiamGiaRepository giamGiaRepository;

    // admin
    public Page<GiamGiaResponse> getPage(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        return giamGiaRepository.getPage(pageable);
    }
    public boolean isTenValid(String ma) {
        return ma != null && !ma.trim().isEmpty(); }

    public void add(GiamGiaRequest giamGiaRequest) {
            GiamGia giamGia = new GiamGia();
            giamGia.setMa(giamGiaRequest.getMa());
            giamGia.setSoPhanTramGiam(giamGiaRequest.getSoPhanTramGiam());
            giamGia.setSoLuong(giamGiaRequest.getSoLuong());
            giamGia.setNgayBatDau(giamGiaRequest.getNgayBatDau());
            giamGia.setNgayKetThuc(giamGiaRequest.getNgayKetThuc());
            giamGia.setTrang_thai(1);
            java.util.Date currentDate = new java.util.Date();
            if (giamGiaRequest.getNgay_tao() == null) {
                giamGia.setNgay_tao(new java.sql.Date(currentDate.getTime()));
            } else {
                giamGia.setNgay_tao(giamGiaRequest.getNgay_tao());
            }
            giamGia.setNgay_sua(new java.sql.Date(currentDate.getTime()));
            giamGiaRepository.save(giamGia);
            System.out.println("GiamGiaService.add: " + giamGia.getMa());
    }

    public void update(GiamGiaRequest giamGiaRequest, UUID id) {
        GiamGia giamGia = giamGiaRepository.findById(id).orElse(null);

        if (giamGia != null) {
            // Kiểm tra mã đã tồn tại chưa (ngoại trừ mã hiện tại)
            GiamGiaResponse existingGiamGia = giamGiaRepository.findByMa(giamGiaRequest.getMa());

            if (existingGiamGia != null && !existingGiamGia.getId().equals(id)) {
                // Mã đã tồn tại cho một giảm giá khác
                System.out.println("GiamGiaService.update: Code already exists for another discount");
                return;
            }

            // Cập nhật thông tin giảm giá
            giamGia.setMa(giamGiaRequest.getMa());
            giamGia.setSoPhanTramGiam(giamGiaRequest.getSoPhanTramGiam());
            giamGia.setSoLuong(giamGiaRequest.getSoLuong());
            giamGia.setNgayBatDau(giamGiaRequest.getNgayBatDau());
            giamGia.setNgayKetThuc(giamGiaRequest.getNgayKetThuc());

            // Cập nhật ngày sửa đổi
            java.util.Date currentDate = new java.util.Date();
            giamGia.setNgay_sua(new java.sql.Date(currentDate.getTime()));

            // Lưu giảm giá đã được cập nhật
            giamGiaRepository.save(giamGia);

            System.out.println("GiamGiaService.update: " + giamGia.getMa());
        } else {
            System.out.println("GiamGiaService.update: null");
        }
    }


    public void delete(UUID id) {
        GiamGia giamGia = giamGiaRepository.findById(id).orElse(null);
        if (giamGia != null) {
            giamGiaRepository.deleteById(id);

            System.out.println("GiamGiaService.delete: " + id);
        } else {
            System.out.println("GiamGiaService.delete: null");
        }
    }

    public GiamGiaResponse getById(UUID id) {
        GiamGiaResponse giamGiaResponse = giamGiaRepository.getByIdResponse(id);
        if (giamGiaResponse != null) {
            System.out.println("GiamGiaService.findById: " + giamGiaResponse.getMa());
            return giamGiaResponse;
        } else {
            System.out.println("GiamGiaService.findById: null");
            return null;
        }
    }

    public boolean isMaValid(String ma) {
        return ma != null && !ma.trim().isEmpty(); }

    public GiamGiaResponse getByMa(String ma) {
        return giamGiaRepository.getByMa(ma);
    }

    // user
    public GiamGiaResponse findByMa(String ma) {
        GiamGiaResponse giamGiaResponse = giamGiaRepository.findByMa(ma);
        if (giamGiaResponse != null) {
            System.out.println("GiamGiaService.findByMa: " + giamGiaResponse.getMa());
            return giamGiaResponse;
        } else {
            System.out.println("GiamGiaService.findByMa: null");
            return null;
        }
    }

    @Transactional
    public void updateSoLuongByMa(String ma, int soLuong) {
        giamGiaRepository.updateSoLuongByMa(ma, soLuong);
    }
}
