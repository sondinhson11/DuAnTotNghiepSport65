package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.infrastructures.requests.NhanVienRequest;
import com.example.websitebanquanao.infrastructures.responses.NhanVienResponse;
import com.example.websitebanquanao.services.NhanVienService;
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
@RequestMapping("/admin/nhan-vien")
public class NhanVienController {

    @Autowired
    private NhanVienService nhanVienService;

    @Autowired
    private NhanVienRequest nhanVienRequest;

    private static final String redirect = "redirect:/admin/nhan-vien/index";

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page, @RequestParam(name = "pageSize", defaultValue = "5") int pageSize, Model model, @ModelAttribute("successMessage") String successMessage) {
        Page<NhanVienResponse> nhanVienPage = nhanVienService.getPage(page, pageSize);
        model.addAttribute("nhanVienPage", nhanVienPage);
        model.addAttribute("nv", nhanVienRequest);
        model.addAttribute("successMessage", successMessage);
        model.addAttribute("view", "/views/admin/nhan-vien/index.jsp");
        return "admin/layout";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") UUID id, RedirectAttributes redirectAttributes) {
        nhanVienService.delete(id);
        // Lưu thông báo xoá thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Xoá nhân viên thành công");
        return redirect; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @PostMapping("store")
    public String store(@Valid @ModelAttribute("nv") NhanVienRequest nhanVienRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("list", nhanVienService.getAll());
            model.addAttribute("view", "/views/admin/nhan-vien/index.jsp");
            return "admin/layout"; // Trả về trang index nếu có lỗi
        }
        nhanVienService.add(nhanVienRequest);
        // Lưu thông báo thêm thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Thêm nhân viên thành công");
        return redirect; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @PostMapping("update/{id}")
    public String update(@PathVariable("id") UUID id, @Valid @ModelAttribute("nv") NhanVienRequest nhanVienRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("list", nhanVienService.getAll());
            model.addAttribute("view", "/views/admin/nhan-vien/index.jsp");
            return "admin/layout"; // Trả về trang index nếu có lỗi
        }
        nhanVienService.update(nhanVienRequest, id);
        // Lưu thông báo cập nhật thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật nhân viên thành công");
        return redirect; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @GetMapping("get/{id}")
    @ResponseBody
    public ResponseEntity<NhanVienResponse> getGiamGia(@PathVariable("id") UUID id) {
        return ResponseEntity.ok(nhanVienService.getById(id));
    }
}
