package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.entities.KhuyenMai;
import com.example.websitebanquanao.repositories.KhuyenMaiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

@Component
public class CheckHSD_Khuyen_Mai {

    @Autowired
    private KhuyenMaiRepository khuyenMaiRepository;

    // Chạy mỗi 30 giây
    @Scheduled(fixedRate = 30000)
    public void updateGiamGiaStatus() {
        List<KhuyenMai> khuyenMais = khuyenMaiRepository.findAll();
        Date today = new Date(); // Lấy ngày hiện tại

        for (KhuyenMai khuyenMai : khuyenMais) {
            Date ngayKetThuc = khuyenMai.getNgayKetThuc();

            if (ngayKetThuc != null) {
                if (ngayKetThuc.compareTo(today) <= 0 && khuyenMai.getTrangThai() != 0) {
                    khuyenMai.setTrangThai(0);
                    khuyenMaiRepository.save(khuyenMai);
                    System.out.println("Cập nhật trạng thái Khuyến Mại thành: Hết hạn " + khuyenMai.getMa());
                } else if (ngayKetThuc.compareTo(today) > 0 && khuyenMai.getTrangThai() != 1) {
                    khuyenMai.setTrangThai(1);
                    khuyenMaiRepository.save(khuyenMai);
                    System.out.println("Cập nhật trạng thái Khuyến Mại thành: Còn hạn  " + khuyenMai.getMa());
                }
            }
        }
    }
}
