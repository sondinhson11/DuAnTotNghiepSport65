package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.entities.GiamGia;
import com.example.websitebanquanao.repositories.GiamGiaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.List;

@Component
public class CheckHSDGiamGia {
    @Autowired
    private GiamGiaRepository giamGiaRepository;

    //  30s Chạy 1 lần
    @Scheduled(fixedRate = 30000)
    public void updateGiamGiaStatus() {
        LocalDate today = LocalDate.now();
        List<GiamGia> giamGias = giamGiaRepository.findAll();

        for (GiamGia giamGia : giamGias) {
            LocalDate ngayKetThuc = giamGia.getNgayKetThuc();

            if (ngayKetThuc != null) {
                // Cập nhật trạng thái thành 0 nếu ngày kết thúc nhỏ hơn hoặc bằng hôm nay và trạng thái hiện tại không phải là 0
                if ((ngayKetThuc.isEqual(today) || ngayKetThuc.isBefore(today)) && giamGia.getTrang_thai() != 0) {
                    giamGia.setTrang_thai(0);
                    giamGiaRepository.save(giamGia);
                    System.out.println("Cập nhật trạng thái Giảm Giá thành : Hết hạn " + giamGia.getMa());
                }
                // Cập nhật trạng thái thành 1 nếu ngày kết thúc lớn hơn hôm nay và trạng thái hiện tại không phải là 1
                else if (ngayKetThuc.isAfter(today) && giamGia.getTrang_thai() != 1) {
                    giamGia.setTrang_thai(1);
                    giamGiaRepository.save(giamGia);
                    System.out.println("Cập nhật trạng thái Giảm Giá thành : Còn hạn  " + giamGia.getMa());
                }
            }
        }
    }
}

