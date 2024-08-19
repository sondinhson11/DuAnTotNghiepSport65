package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.infrastructures.requests.GiamGiaRequest;
import com.example.websitebanquanao.infrastructures.requests.HinhThucThanhToanRequest;
import com.example.websitebanquanao.infrastructures.responses.GiamGiaResponse;
import com.example.websitebanquanao.infrastructures.responses.HinhThucThanhToanResponse;
import com.example.websitebanquanao.repositories.GiamGiaRepository;
import com.example.websitebanquanao.repositories.HinhThucThanhToanRepository;
import com.example.websitebanquanao.services.GiamGiaService;
import com.example.websitebanquanao.services.HinhThucThanhToanService;
import jakarta.validation.Valid;
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
@RequestMapping("/admin/hinh-thuc-thanh-toan")
public class HinhThucThanhToanController {
    @Autowired
    private HinhThucThanhToanService hinhThucThanhToanService;
    @Autowired
    private HinhThucThanhToanRequest hinhThucThanhToanRequest;

    @Autowired
    private HinhThucThanhToanRepository hinhThucThanhToanRepository;

    private static final String redirect = "redirect:/admin/hinh-thuc-thanh-toan/index";

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page, Model model, @ModelAttribute("successMessage") String successMessage, @ModelAttribute("errorMessage") String errorMessage) {
        Page<HinhThucThanhToanResponse> htttPage = hinhThucThanhToanService.getPage(page, 5);
        model.addAttribute("htttPage", htttPage);
        model.addAttribute("gg", hinhThucThanhToanRequest);
        model.addAttribute("successMessage", successMessage); // Hiển thị thông báo thành công
        model.addAttribute("errorMessage", errorMessage); // Hiển thị thông báo thành công
        model.addAttribute("view", "/views/admin/hinh-thuc-thanh-toan/index.jsp");
        return "admin/layout";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        hinhThucThanhToanService.delete(id);
        // Lưu thông báo xoá thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Xoá hình thức thanh toán thành công");
        return redirect; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @PostMapping("store")
    public String store(@Valid @ModelAttribute("gg") HinhThucThanhToanRequest hinhThucThanhToanRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {

        String ten = hinhThucThanhToanRequest.getMa().trim();

        if (ten.isEmpty() || !ten.equals(hinhThucThanhToanRequest.getMa())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên không hợp lệ (không được có khoảng trắng ở đầu )");
            return redirect; // Replace with your actual redirect path
        }

        if (!hinhThucThanhToanService.isTenValid(hinhThucThanhToanRequest.getMa())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên toàn khoảng trắng không hợp lệ");
            return redirect;
        }

        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/hinh-thuc-thanh-toan/index.jsp");
            return "admin/layout";
        }

        if (hinhThucThanhToanRepository.existsByMa(hinhThucThanhToanRequest.getMa())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Thêm hình thức thanh toán không thành công - Mã hình thức thanh toán đã tồn tại");
            return redirect;
        }

        hinhThucThanhToanService.add(hinhThucThanhToanRequest);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm hình thức thanh toán thành công");
        return redirect;
    }

    @PostMapping("update/{id}")
    public String update(@PathVariable("id") Integer id, @Valid @ModelAttribute("gg") HinhThucThanhToanRequest hinhThucThanhToanRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (!hinhThucThanhToanService.isMaValid(hinhThucThanhToanRequest.getMa())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Mã toàn khoảng trắng không hợp lệ");
            return redirect;
        }

        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/hinh-thuc-thanh-toan/index.jsp");
            return "admin/layout"; // Trả về trang index nếu có lỗi
        }

        HinhThucThanhToanResponse existingGiamgia = hinhThucThanhToanService.getByMa(hinhThucThanhToanRequest.getMa());
        if (existingGiamgia != null && !existingGiamgia.getId().equals(id)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Cập nhật hình thức thanh toán thất bại. Mã đã tồn tại.");
            return redirect;
        }

        hinhThucThanhToanService.update(hinhThucThanhToanRequest, id);
        // Lưu thông báo cập nhật thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật hình thức thanh toán thành công");
        return redirect;
    }

    @GetMapping("get/{id}")
    @ResponseBody
    public ResponseEntity<HinhThucThanhToanResponse> getGiamGia(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(hinhThucThanhToanService.getById(id));
    }

}
