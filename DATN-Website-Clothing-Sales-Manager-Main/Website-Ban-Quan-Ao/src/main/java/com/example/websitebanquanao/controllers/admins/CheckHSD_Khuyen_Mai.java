package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.entities.KhuyenMai;
import com.example.websitebanquanao.repositories.GiamGiaRepository;
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

    @Scheduled(fixedRate = 30000) // Phương thức sẽ được gọi mỗi 30 giây
    public void updateKhuyenMaiStatus() {
        Date today = new Date(); // Lấy ngày hiện tại
        List<KhuyenMai> khuyenMais = khuyenMaiRepository.findAll(); // Lấy tất cả các bản ghi khuyến mãi

        for (KhuyenMai khuyenMai : khuyenMais) {
            Date ngayKetThuc = khuyenMai.getNgayKetThuc(); // Ngày kết thúc của khuyến mãi

            if (ngayKetThuc != null) {
                // Kiểm tra nếu ngày kết thúc <= ngày hiện tại thì trạng thái chuyển thành 1 (hết hạn), ngược lại là 0 (còn hạn)
                int newTrangThai = (ngayKetThuc.compareTo(today) <= 0) ? 1 : 0;

                // Kiểm tra nếu trạng thái mới khác với trạng thái hiện tại
                if (newTrangThai != khuyenMai.getTrangThai()) {
                    // Cập nhật trạng thái mới và lưu vào cơ sở dữ liệu
                    khuyenMai.setTrangThai(newTrangThai);
                    khuyenMaiRepository.save(khuyenMai);

                    // Hiển thị thông báo trạng thái mới của khuyến mãi
                    if (newTrangThai == 1) {
                        System.out.println("Cập nhật trạng thái Khuyến Mãi thành: Hết hạn " + khuyenMai.getMa());
                    } else {
                        System.out.println("Cập nhật trạng thái Khuyến Mãi thành: Còn hạn " + khuyenMai.getMa());
                    }
                }
            }
        }
    }


}
