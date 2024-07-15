package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.entities.SanPhamChiTiet;
import com.example.websitebanquanao.infrastructures.requests.*;
import com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietResponse;
import com.example.websitebanquanao.repositories.SanPhamChiTietRepository;
import com.example.websitebanquanao.services.*;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin/san-pham-chi-tiet")
public class SanPhamChiTietController {

    @Autowired
    private SanPhamChiTietService sanPhamChiTietService;

    @Autowired
    private SanPhamService sanPhamService;

    @Autowired
    private MauSacService mauSacService;

    @Autowired
    private KichCoService kichCoService;

    @Autowired
    private AnhSanPhamService anhSanPhamService;
    @Autowired
    private MauSacRequest mauSacRequest;
    @Autowired
    private KichCoRequest kichCoRequest;
    @Autowired
    private LoaiService loaiService;
    @Autowired
    private SanPhamRequest sanPhamRequest;
    @Autowired
    HttpSession session;
    @Autowired
    private SanPhamChiTietRepository sanPhamChiTietRepository;
    @GetMapping("/index")
    public String index(Model model) {
        model.addAttribute("list", sanPhamChiTietService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/index.jsp");
        return "admin/layout";
    }
    @GetMapping("/create")
    public String create(Model model) {
        List<SanPhamChiTietResponse> listtam = sanPhamChiTietService.getlisttam();
        model.addAttribute("listtam",listtam);
        model.addAttribute("listSanPham", sanPhamService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());
        model.addAttribute("list", sanPhamChiTietService.getAll());
        model.addAttribute("ms", mauSacRequest);
        model.addAttribute("kc",new KichCoRequest());
        model.addAttribute("listLoai", loaiService.getAll());
        model.addAttribute("sp", sanPhamRequest);
        model.addAttribute("sanPhamChiTiet", new SanPhamChiTietRequest());
        model.addAttribute("action", "/admin/san-pham-chi-tiet/add");
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/create.jsp");
        return "admin/layout";
    }
    @GetMapping("addlist")
    public String addlist(){
        sanPhamChiTietService.updateList();
        return "redirect:/admin/san-pham-chi-tiet/index";
    }
    @PostMapping("/add")
    public String add(@ModelAttribute("sanPhamChiTiet") SanPhamChiTietRequest sanPhamChiTietRequest) {

//        String kichco = kichCoRequest.getTen();
//        String mausac = mauSacRequest.getTen();
//        session.removeAttribute("error");
//        if(kichco.equals(sanPhamChiTietRequest) || mausac.equals(sanPhamChiTietRequest)){
//            session.setAttribute("error", "Tồn tại");
//
//        }else{
//            sanPhamChiTietRequest.setTrangThai(2);
//            sanPhamChiTietService.add(sanPhamChiTietRequest);
//            return "redirect:/admin/san-pham-chi-tiet/create";
//        }
        sanPhamChiTietRequest.setTrangThai(2);
        sanPhamChiTietService.add(sanPhamChiTietRequest);
        return "redirect:/admin/san-pham-chi-tiet/create";
    }


    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") UUID id) {
        sanPhamChiTietService.delete(id);
        return "redirect:/admin/san-pham-chi-tiet/create";
    }
    @PostMapping("update/{id}")
    public String update(@PathVariable("id") UUID id, @Valid @ModelAttribute("sanPhamChiTiet") SanPhamChiTietRequest sanPhamChiTietRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("list", sanPhamChiTietService.getAll());
            model.addAttribute("view", "/views/admin/san-pham-chi-tiet/index.jsp");
            return "admin/layout";
        }
        sanPhamChiTietService.update(sanPhamChiTietRequest, id);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật chi tiết sản phẩm thành công");
        return "redirect:/admin/san-pham-chi-tiet/index";
    }

    //    @PostMapping("updatetam/{id}")
//    public String updatetam(@PathVariable("id") UUID id, @Valid @ModelAttribute("sanPhamChiTiet") SanPhamChiTietRequest sanPhamChiTietRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
//        if (result.hasErrors()) {
//            model.addAttribute("list", sanPhamChiTietService.getAll());
//            model.addAttribute("view", "/views/admin/san-pham-chi-tiet/create.jsp");
//            return "admin/layout";
//        }
//        sanPhamChiTietService.update(sanPhamChiTietRequest, id);
//        sanPhamChiTietRequest.setTrangThai(2);
//        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật chi tiết sản phẩm thành công");
//        return "redirect:/admin/san-pham-chi-tiet/create";
//    }
    @PostMapping("updatetam/{id}")
    public String updatetam(@PathVariable("id") UUID id, @Valid @ModelAttribute("sanPhamChiTiet") SanPhamChiTietRequest sanPhamChiTietRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("list", sanPhamChiTietService.getAll());
            model.addAttribute("view", "/views/admin/san-pham-chi-tiet/create.jsp");
            System.out.println("Validation errors: " + result.getAllErrors());
            return "admin/layout";
        }

        try {
            System.out.println("Updating product details with id: " + id);
            sanPhamChiTietService.updatetam(sanPhamChiTietRequest, id);
            sanPhamChiTietRequest.setTrangThai(2);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật chi tiết sản phẩm thành công");
        } catch (Exception e) {
            System.err.println("Error updating product details: " + e.getMessage());
            model.addAttribute("list", sanPhamChiTietService.getAll());
            model.addAttribute("view", "/views/admin/san-pham-chi-tiet/create.jsp");
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật chi tiết sản phẩm.");
            return "admin/layout";
        }

        return "redirect:/admin/san-pham-chi-tiet/create";
    }


    @GetMapping("/updatetam/{id}")
    public String updatetam(@PathVariable("id") SanPhamChiTiet sanPhamChiTiet, Model model) {
        model.addAttribute("listSanPham", sanPhamService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());

        model.addAttribute("list", sanPhamChiTietService.getAll());

        model.addAttribute("sanPhamChiTiet", sanPhamChiTiet);
        model.addAttribute("action", "/admin/san-pham-chi-tiet/updatetam/" + sanPhamChiTiet.getId());
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/updatetam.jsp");
        return "admin/layout";
    }


    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") SanPhamChiTiet sanPhamChiTiet, Model model) {
        model.addAttribute("listSanPham", sanPhamService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());

        model.addAttribute("list", sanPhamChiTietService.getAll());

        model.addAttribute("sanPhamChiTiet", sanPhamChiTiet);
        model.addAttribute("action", "/admin/san-pham-chi-tiet/update/" + sanPhamChiTiet.getId());
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/update.jsp");
        return "admin/layout";
    }
    @GetMapping("/get-anh/{id}")
    public String getAnh(@PathVariable("id") UUID id, Model model) {
        model.addAttribute("list", sanPhamChiTietService.getAll());
        model.addAttribute("sanPhamChiTiet", new SanPhamChiTietRequest());
        model.addAttribute("listAnh", anhSanPhamService.getAll(id));
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/create.jsp");
        return "admin/layout";
    }
    @GetMapping("/filter")
    public String filter(@RequestParam(name = "status", required = false) Integer status, Model model) {
        List<SanPhamChiTietResponse> filteredList;

        if (status != null && status != -1) {
            filteredList = sanPhamChiTietService.getByStatus(status);
        } else {
            // If no status is selected, show all products.
            filteredList = sanPhamChiTietService.getAll();
        }
        model.addAttribute("list", sanPhamChiTietService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());
        model.addAttribute("list", filteredList);
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/index.jsp");
        return "admin/layout";
    }
    @GetMapping("/filter-mau-sac")
    public String filterMauSac(@RequestParam(name = "tenMauSac", required = false) String tenMauSac, Model model) {
        List<SanPhamChiTietResponse> filteredList;

        if (tenMauSac != null && !tenMauSac.isEmpty()) {
            filteredList = sanPhamChiTietService.getByTenMauSac(tenMauSac);
        } else {
            // If no status is selected, show all products.
            filteredList = sanPhamChiTietService.getAll();
        }
        model.addAttribute("list", sanPhamChiTietService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());
        model.addAttribute("list", filteredList);
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/index.jsp");
        return "admin/layout";
    }
    @GetMapping("/filter-kich-co")
    public String filterKichCo(@RequestParam(name = "tenKichCo", required = false) String tenKichCo, Model model) {
        List<SanPhamChiTietResponse> filteredList;

        if (tenKichCo != null && !tenKichCo.isEmpty()) {
            filteredList = sanPhamChiTietService.getByTenKichCo(tenKichCo);
        } else {
            // If no status is selected, show all products.
            filteredList = sanPhamChiTietService.getAll();
        }
        model.addAttribute("list", sanPhamChiTietService.getAll());
        model.addAttribute("listMauSac", mauSacService.getAll());
        model.addAttribute("listKichCo", kichCoService.getAll());
        model.addAttribute("list", filteredList);
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/index.jsp");
        return "admin/layout";
    }
    @PostMapping("/tra-hang-vao-kho")
    public String traHangVaoKho(@RequestParam("idHoaDon") UUID idHoaDon,
                                @RequestParam("idSanPhamChiTiet") UUID idSanPhamChiTiet,
                                @RequestParam("soLuongTraHang") int soLuongTraHang,
                                Model model) {
        try {
            // Kiểm tra trạng thái đã hoàn từ session trước khi thực hiện
            String sessionKey = "daHoan_" + idSanPhamChiTiet + "_" + idHoaDon;
            if (session.getAttribute(sessionKey) != null) {
                session.setAttribute("errorMessage", "Sản phẩm này đã được hoàn trước đó.");
                // Nếu đã hoàn thì không thực hiện trả hàng vào kho nữa
                throw new Exception("Sản phẩm này đã được hoàn trước đó.");
            }

            // Thực hiện trả hàng vào kho
            sanPhamChiTietService.xuLyTraHangVaoKho(idSanPhamChiTiet, soLuongTraHang);

            // Lưu trạng thái đã hoàn vào session
            session.setAttribute(sessionKey, true);

            // Trả về view với thông điệp hoặc dữ liệu cần thiết
            session.setAttribute("successMessage", "Trả hàng vào kho thành công.");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Lỗi khi trả hàng vào kho: " + e.getMessage());
        }

        return "redirect:/admin/hoa-don/" + idHoaDon;
    }
    // Mapping for searching by name
//    @GetMapping("/search")
//    public String searchByName(@RequestParam("name") String tenSanPham, Model model) {
//        List<SanPhamChiTietResponse> list = sanPhamChiTietService.searchByTenSanPham(tenSanPham);
//        model.addAttribute("list", list);
//        return "admin/san-pham-chi-tiet/index"; // Trả về view đúng
//}
    @GetMapping("/search")
    public String searchByName(@RequestParam("name") String tenSanPham, Model model) {
        List<SanPhamChiTietResponse> list = sanPhamChiTietService.searchByTenSanPham(tenSanPham);
        model.addAttribute("list", list);
        model.addAttribute("listMauSac", mauSacService.getAll()); // Thêm danh sách màu sắc
        model.addAttribute("listKichCo", kichCoService.getAll()); // Thêm danh sách kích cỡ
        model.addAttribute("view", "/views/admin/san-pham-chi-tiet/index.jsp"); // Đường dẫn view
        return "admin/layout"; // Trả về layout của admin
    }





}
