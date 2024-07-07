package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.infrastructures.requests.KhuyenMaiRequest;
import com.example.websitebanquanao.infrastructures.responses.GiamGiaResponse;
import com.example.websitebanquanao.infrastructures.responses.KhuyenMaiResponse;
import com.example.websitebanquanao.repositories.KhuyenMaiRepository;
import com.example.websitebanquanao.services.KhuyenMaiChiTietService;
import com.example.websitebanquanao.services.KhuyenMaiService;
import com.example.websitebanquanao.services.SanPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.UUID;

@Controller
@RequestMapping("/admin/khuyen-mai")
public class KhuyenMaiController {

    @Autowired
    private KhuyenMaiService khuyenMaiService;

    @Autowired
    private KhuyenMaiChiTietService khuyenMaiChiTietService;

    @Autowired
    private SanPhamService sanPhamService;

    @Autowired
    private KhuyenMaiRequest khuyenMaiRequest;

    @Autowired
    private KhuyenMaiRepository khuyenMaiRepository;

    // KhuyenMai
    private static final String redirect = "redirect:/admin/khuyen-mai/index";

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page, Model model, @ModelAttribute("successMessage") String successMessage, @ModelAttribute("errorMessage") String errorMessage) {
        Page<KhuyenMaiResponse> khuyenMaiPage = khuyenMaiService.getPage(page, 5);
        model.addAttribute("khuyenMaiPage", khuyenMaiPage);
        model.addAttribute("km", khuyenMaiRequest);
        model.addAttribute("successMessage", successMessage);
        model.addAttribute("errorMessage", errorMessage);
        model.addAttribute("view", "/views/admin/khuyen-mai/index.jsp");
        return "admin/layout";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") UUID id, RedirectAttributes redirectAttributes) {
        khuyenMaiService.delete(id);
        redirectAttributes.addFlashAttribute("successMessage", "Xoá khuyến mãi thành công");
        return redirect;
    }

    @PostMapping("store")
    public String store(@ModelAttribute("km") KhuyenMaiRequest khuyenMaiRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/khuyen-mai/index.jsp");
            return "admin/layout";
        }

        if (khuyenMaiRequest.getMa().trim().length() == 0) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng nhập mã.");
            return redirect;
        }
        if (khuyenMaiRequest.getTen().trim().length() == 0) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng nhập tên.");
            return redirect;
        }
        // Kiểm tra xem mã giảm giá đã tồn tại
        if (khuyenMaiRepository.existsByMa(khuyenMaiRequest.getMa())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Thêm khuyến mãi thất bại");
            return redirect;
        }

        // Kiểm tra số phần trăm giảm
        if (khuyenMaiRequest.getSoPhanTramGiam() < 1 || khuyenMaiRequest.getSoPhanTramGiam() > 100) {
            redirectAttributes.addFlashAttribute("errorMessage", "Phần trăm giảm không hợp lệ");
            return redirect;
        }


        // Kiểm tra xem ngày kết thúc sau ngày bắt đầu

        if (khuyenMaiRequest.getNgayKetThuc().compareTo(khuyenMaiRequest.getNgayBatDau()) < 0) {
            redirectAttributes.addFlashAttribute("errorMessage", "Ngày bắt đầu và ngày kết thúc không hợp lệ");
            return redirect;
        }


        khuyenMaiService.add(khuyenMaiRequest);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm khuyến mãi thành công");
        return redirect;
    }

    @PostMapping("update/{id}")
    public String update(@ModelAttribute("km") KhuyenMaiRequest khuyenMaiRequest, @PathVariable("id") UUID id, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/khuyen-mai/index.jsp");
            return "admin/layout";
        }

        if (!khuyenMaiService.isTenValid(khuyenMaiRequest.getTen())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên toàn khoảng trắng không hợp lệ");
            return redirect;
        }

        if (khuyenMaiRequest.getSoPhanTramGiam() < 1 || khuyenMaiRequest.getSoPhanTramGiam() > 100) {
            redirectAttributes.addFlashAttribute("errorMessage", "Phần trăm giảm không hợp lệ");
            return redirect;
        }
        if (!khuyenMaiService.isMaValid(khuyenMaiRequest.getMa())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Mã toàn khoảng trắng không hợp lệ");
            return redirect;
        }

        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/khuyen-mai/index.jsp");
            return "admin/layout"; // Trả về trang index nếu có lỗi
        }

        KhuyenMaiResponse existingGiamgia = khuyenMaiService.getByMa(khuyenMaiRequest.getMa());
        if (existingGiamgia != null && !existingGiamgia.getId().equals(id)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Cập nhật khuyễn mãi thất bại. Mã đã tồn tại.");
            return redirect;
        }


        khuyenMaiService.update(khuyenMaiRequest, id);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật khuyến mãi thành công");
        return redirect;
    }

    @GetMapping("update-trang-thai/{id}/{trangThai}")
    public String updateTrangThai(@PathVariable("id") UUID id, @PathVariable("trangThai") int trangThai, RedirectAttributes redirectAttributes) {
        khuyenMaiService.updateTrangThai(id, trangThai);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật trạng thái khuyến mãi thành công");
        return redirect;
    }

    @GetMapping("get/{id}")
    @ResponseBody
    public ResponseEntity<KhuyenMaiResponse> getKhuyenMai(@PathVariable("id") UUID id) {
        return ResponseEntity.ok(khuyenMaiService.getById(id));
    }

    // KhuyenMaiChiTiet
    @GetMapping("/chi-tiet/{id}")
    public String chiTiet(@PathVariable("id") UUID id, Model model) {
        model.addAttribute("khuyenMaiChiTietPage", sanPhamService.getAllKhuyenMai2());
        model.addAttribute("idKhuyenMai", id);
        model.addAttribute("view", "/views/admin/khuyen-mai/chi-tiet.jsp");
        return "admin/layout";
    }

    @GetMapping("/add-chi-tiet/{idKhuyenMai}/{idSanPham}")
    public String addChiTiet(@PathVariable("idKhuyenMai") UUID idKhuyenMai, @PathVariable("idSanPham") UUID idSanPham, RedirectAttributes redirectAttributes) {
        khuyenMaiChiTietService.save(idKhuyenMai, idSanPham);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm sản phẩm vào khuyến mãi thành công");
        return "redirect:/admin/khuyen-mai/chi-tiet/" + idKhuyenMai;
    }

    @GetMapping("/delete-chi-tiet/{idKhuyenMai}/{idSanPham}")
    public String deleteChiTiet(@PathVariable("idKhuyenMai") UUID idKhuyenMai, @PathVariable("idSanPham") UUID idSanPham, RedirectAttributes redirectAttributes) {
        khuyenMaiChiTietService.delete(idKhuyenMai, idSanPham);
        redirectAttributes.addFlashAttribute("successMessage", "Xoá sản phẩm khỏi khuyến mãi thành công");
        return "redirect:/admin/khuyen-mai/chi-tiet/" + idKhuyenMai;
    }

    @GetMapping("/chi-tiet/getTrangThai/{idKhuyenMai}/{idSanPham}")
    @ResponseBody
    public ResponseEntity<Integer> getTrangThai(@PathVariable("idKhuyenMai") UUID idKhuyenMai, @PathVariable("idSanPham") UUID idSanPham) {
        return ResponseEntity.ok(khuyenMaiChiTietService.getTrangThai(idKhuyenMai, idSanPham));
    }
}
