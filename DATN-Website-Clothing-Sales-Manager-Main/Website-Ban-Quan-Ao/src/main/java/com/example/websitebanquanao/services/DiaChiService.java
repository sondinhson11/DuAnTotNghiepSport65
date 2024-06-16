package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.DiaChi;
import com.example.websitebanquanao.entities.HinhThucThanhToan;
import com.example.websitebanquanao.infrastructures.requests.DiaChiRequest;
import com.example.websitebanquanao.infrastructures.requests.HinhThucThanhToanRequest;
import com.example.websitebanquanao.infrastructures.responses.DiaChiResponse;
import com.example.websitebanquanao.infrastructures.responses.HinhThucThanhToanResponse;
import com.example.websitebanquanao.repositories.DiaChiRepository;
import com.example.websitebanquanao.repositories.HinhThucThanhToanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.util.UUID;

@Service
@Transactional
public class DiaChiService {
    @Autowired
    private DiaChiRepository diaChiRepository;

    // admin
    public Page<DiaChiResponse> getPage(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        return diaChiRepository.getPage(pageable);
    }
    public boolean isTenValid(String ma) {
        return ma != null && !ma.trim().isEmpty(); }

    public void add(DiaChiRequest diaChiRequest) {
            DiaChi diaChi = new DiaChi();
            diaChi.setMa(diaChiRequest.getMa());
            diaChi.setDiaChi(diaChiRequest.getDiaChi());
            diaChi.setSoDienThoaiNhan(diaChiRequest.getSoDienThoaiNhan());
            diaChi.setXaPhuong(diaChiRequest.getXaPhuong());
            diaChi.setQuanHuyen(diaChiRequest.getQuanHuyen());
            diaChi.setTinhThanhPho(diaChiRequest.getTinhThanhPho());
            diaChi.setTrangThai(diaChiRequest.getTrangThai());
            java.util.Date currentDate = new java.util.Date();
            if (diaChiRequest.getNgayTao() == null) {
                diaChi.setNgayTao(new Date(currentDate.getTime()));
            } else {
                diaChi.setNgayTao(diaChiRequest.getNgayTao());
            }
            diaChi.setNgaySua(new Date(currentDate.getTime()));
            diaChiRepository.save(diaChi);
            System.out.println("DiaChiService.add: " + diaChiRequest.getMa());
    }

    public void update(DiaChiRequest diaChiRequest, UUID id) {
        DiaChi diaChi = diaChiRepository.findById(id).orElse(null);

        if (diaChi != null) {
            // Kiểm tra mã đã tồn tại chưa (ngoại trừ mã hiện tại)
            DiaChiResponse existingDiaChi = diaChiRepository.findByMa(diaChiRequest.getMa());

            if (existingDiaChi != null && !existingDiaChi.getId().equals(id)) {
                System.out.println("DiaChiService.update: Code already exists for another discount");
                return;
            }

            // Cập nhật thông tin giảm giá
            diaChi.setMa(diaChiRequest.getMa());
            diaChi.setDiaChi(diaChiRequest.getDiaChi());
            diaChi.setSoDienThoaiNhan(diaChiRequest.getSoDienThoaiNhan());
            diaChi.setXaPhuong(diaChiRequest.getXaPhuong());
            diaChi.setQuanHuyen(diaChiRequest.getQuanHuyen());
            diaChi.setTinhThanhPho(diaChiRequest.getTinhThanhPho());
            diaChi.setTrangThai(diaChiRequest.getTrangThai());

            // Cập nhật ngày sửa đổi
            java.util.Date currentDate = new java.util.Date();
            diaChi.setNgaySua(new Date(currentDate.getTime()));

            // Lưu giảm giá đã được cập nhật
            diaChiRepository.save(diaChi);

            System.out.println("DiaChiService.update: " + diaChi.getMa());
        } else {
            System.out.println("DiaChiService.update: null");
        }
    }


    public void delete(UUID id) {
        DiaChi diaChi = diaChiRepository.findById(id).orElse(null);
        if (diaChi != null) {
            diaChiRepository.deleteById(id);

            System.out.println("DiaChiService.delete: " + id);
        } else {
            System.out.println("DiaChiService.delete: null");
        }
    }

    public DiaChiResponse getById(UUID id) {
        DiaChiResponse diaChiResponse = diaChiRepository.getByIdResponse(id);
        if (diaChiResponse != null) {
            System.out.println("DiaChiService.findById: " + diaChiResponse.getMa());
            return diaChiResponse;
        } else {
            System.out.println("DiaChiService.findById: null");
            return null;
        }
    }

    public boolean isMaValid(String ma) {
        return ma != null && !ma.trim().isEmpty(); }

    public DiaChiResponse getByMa(String ma) {
        return diaChiRepository.getByMa(ma);
    }

    // user
    public DiaChiResponse findByMa(String ma) {
        DiaChiResponse diaChiResponse = diaChiRepository.findByMa(ma);
        if (diaChiResponse != null) {
            System.out.println("DiaChiService.findByMa: " + diaChiResponse.getMa());
            return diaChiResponse;
        } else {
            System.out.println("DiaChiService.findByMa: null");
            return null;
        }
    }


}
