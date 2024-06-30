package com.example.websitebanquanao.controllers.users;

import com.example.websitebanquanao.infrastructures.requests.DangKyUserRequest;
import com.example.websitebanquanao.infrastructures.requests.DangNhapUserRequest;
import com.example.websitebanquanao.infrastructures.requests.FormThanhToan;
import com.example.websitebanquanao.infrastructures.requests.GioHangUserRequest;
import com.example.websitebanquanao.infrastructures.requests.KhachHangRequest;
import com.example.websitebanquanao.infrastructures.responses.*;
import com.example.websitebanquanao.services.AnhSanPhamService;
import com.example.websitebanquanao.services.GiamGiaService;
import com.example.websitebanquanao.services.GioHangChiTietService;
import com.example.websitebanquanao.services.GioHangService;
import com.example.websitebanquanao.services.HoaDonChiTietService;
import com.example.websitebanquanao.services.HoaDonService;
import com.example.websitebanquanao.services.KhachHangService;
import com.example.websitebanquanao.services.KhuyenMaiChiTietService;
import com.example.websitebanquanao.services.KichCoService;
import com.example.websitebanquanao.services.MauSacService;
import com.example.websitebanquanao.services.SanPhamService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Controller
public class TrangChuController {

    @Autowired
    private SanPhamService sanPhamService;

    @Autowired
    private MauSacService mauSacService;

    @Autowired
    private KichCoService kichCoService;

    @Autowired
    private AnhSanPhamService anhSanPhamService;

    @Autowired
    private KhachHangService khachHangService;

    @Autowired
    private GioHangService gioHangService;

    @Autowired
    private GioHangChiTietService gioHangChiTietService;

    @Autowired
    private KhuyenMaiChiTietService khuyenMaiChiTietService;

    @Autowired
    private GiamGiaService giamGiaService;

    @Autowired
    private HoaDonService hoaDonService;

    @Autowired
    private HoaDonChiTietService hoaDonChiTietService;

    @Autowired
    private HttpSession session;

    @Autowired
    private KhachHangRequest khachHangRequest;

    private static final String redirect = "redirect:/";
    // trang chủ
    @GetMapping("")
    public String trangChu(Model model) {
        List<TrangChuResponse> productList = sanPhamService.getListTrangChu("");

        List<TrangChuResponse> firstEightProducts = productList.subList(0, Math.min(productList.size(), 8));
        model.addAttribute("listTrangChu", firstEightProducts);
        model.addAttribute("kh", khachHangRequest);
        model.addAttribute("listBanChay", sanPhamService.getListBanChay(""));
        model.addAttribute("viewBanner", "/views/user/banner.jsp");
        model.addAttribute("viewContent", "/views/user/trang-chu.jsp");
        return "user/layout";
    }

    // trang sản phẩm tất cả
    @GetMapping("/san-pham")
    public String sanPham(Model model, @RequestParam(defaultValue = "", name = "sort", required = false) String sort) {
        model.addAttribute("idLoai", -1);
        model.addAttribute("kh", khachHangRequest);
        model.addAttribute("listLoai", sanPhamService.getListLoai());
        model.addAttribute("listSanPham", sanPhamService.getListTrangChu(sort));
        model.addAttribute("viewContent", "/views/user/san-pham.jsp");
        return "user/layout";
    }

    // trang sản phẩm theo loại
    @GetMapping("/san-pham/{idLoai}")
    public String sanPhamById(Model model, @PathVariable("idLoai") Integer idLoai, @RequestParam(defaultValue = "", name = "sort", required = false) String sort) {
        System.out.println("idLoai: " + idLoai);
        model.addAttribute("listLoai", sanPhamService.getListLoai());
        model.addAttribute("listSanPham", sanPhamService.getListSanPhamByIdLoai(idLoai, sort));
        model.addAttribute("kh", khachHangRequest);
        model.addAttribute("idLoai", idLoai);
        model.addAttribute("viewContent", "/views/user/san-pham.jsp");
        return "user/layout";
    }

    // lấy số phần trăm khuyến mãi để hiển thị lên sản phẩm
    @GetMapping("/so-phan-tram-giam/{idSanPham}")
    @ResponseBody
    public ResponseEntity<Integer> soPhanTramGiamKhuyenMai(@PathVariable("idSanPham") UUID idSanPham) {
        return ResponseEntity.ok(khuyenMaiChiTietService.getSoPhanTramGiamByIdSanPham(idSanPham));
    }

    // trang sản phẩm chi tiết
    @GetMapping("/san-pham/{idSanPham}/{idMauSac}")
    public String sanPhamChiTiet(@PathVariable("idSanPham") UUID idSanPham, @PathVariable("idMauSac") Integer idMauSac, Model model) {
        model.addAttribute("sanPham", sanPhamService.getByIdSanPham(idSanPham));
        model.addAttribute("kh", khachHangRequest);
        model.addAttribute("listMauSac", mauSacService.getListMauSacByIdSanPham(idSanPham));
        model.addAttribute("listKichCo", kichCoService.getListKichCoByIdSanPhamAndMauSac(idSanPham, idMauSac));
        model.addAttribute("listAnh", anhSanPhamService.getListAnhByIdSanPham(idSanPham));
        model.addAttribute("idMauSac", idMauSac);
        model.addAttribute("viewContent", "/views/user/san-pham-chi-tiet.jsp");
        return "user/layout";
    }

    // trang sản phẩm sale
    @GetMapping("/sale")
    public String sanPhamSale(Model model, @RequestParam(defaultValue = "", name = "sort", required = false) String sort) {
        model.addAttribute("listSanPham", sanPhamService.getListSale(sort));
        model.addAttribute("kh", khachHangRequest);
        model.addAttribute("viewContent", "/views/user/khuyen-mai.jsp");
        return "user/layout";
    }

    @ModelAttribute("gioHang")
    public GioHangUserRequest taoGioHangUserRequest() {
        return new GioHangUserRequest();
    }

    // trang giỏ hàng
    @GetMapping("/gio-hang")
    public String gioHang(Model model, @ModelAttribute("thongBaoGiamGia") String thoangBaoGiamGia) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        model.addAttribute("kh", khachHangRequest);
        GiamGiaResponse giamGiaResponse = (GiamGiaResponse) session.getAttribute("giamGia");
        if (khachHangResponse == null) {
            return "redirect:/dang-nhap";
        } else {
            BigDecimal tongTien = gioHangChiTietService.getTongTienByIdKhachHang(khachHangResponse.getId());
            List<GioHangUserResponse> listGioHang = gioHangService.getListByIdKhachHang(khachHangResponse.getId());
            model.addAttribute("listGioHang", listGioHang);
            if (listGioHang.isEmpty()) {
                model.addAttribute("nutThanhToan", 0);
            } else {
                model.addAttribute("nutThanhToan", 1);
            }
            model.addAttribute("tongTien", tongTien.intValue());
            if (giamGiaResponse != null) {
                int soPhanTramGiam = giamGiaResponse.getSoPhanTramGiam();
                BigDecimal soTienDuocGiam = tongTien.multiply(new BigDecimal(soPhanTramGiam).divide(new BigDecimal(100)));
                BigDecimal soTienSauKhiGiam = tongTien.subtract(soTienDuocGiam);
                model.addAttribute("soTienDuocGiam", soTienDuocGiam.intValue());
                model.addAttribute("soTienSauKhiGiam", soTienSauKhiGiam.intValue());
                model.addAttribute("thongBaoGiamGia", thoangBaoGiamGia);
            } else {
                model.addAttribute("soTienDuocGiam", 0);
                model.addAttribute("soTienSauKhiGiam", tongTien.intValue());
                model.addAttribute("thongBaoGiamGia", "");
            }
        }

        String thongBaoGiamGia = (String) session.getAttribute("thongBaoGiamGia");
        if (thongBaoGiamGia != null) {
            model.addAttribute("thongBaoGiamGia", thongBaoGiamGia);
            session.removeAttribute("thongBaoGiamGia");
        }

        model.addAttribute("viewContent", "/views/user/gio-hang.jsp");
        return "user/layout";
    }

    // thêm sản phẩm vào giả hàng trang chi tiết
    @PostMapping("/gio-hang/{id}")
    public String themGioHang(@ModelAttribute("gioHang") GioHangUserRequest gioHangUserRequest, Model model, @PathVariable("id") UUID id) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        gioHangChiTietService.add(id, khachHangResponse.getId(), gioHangUserRequest);
        return "redirect:/gio-hang";
    }

    // thay dổi số lượng sản phẩm trong giỏ hàng
    @PostMapping("/gio-hang/update/{id}")
    public String capNhatGioHang(@PathVariable("id") UUID id, @RequestParam("soLuong") Integer soLuong) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        gioHangChiTietService.updateByIdSanPhamChiTietAndIdKhachHang(id, khachHangResponse.getId(), soLuong);
        return "redirect:/gio-hang";
    }

    // xóa sản phẩm trong giỏ hàng
    @GetMapping("/gio-hang/{id}")
    public String xoaGioHang(@PathVariable("id") UUID id) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        gioHangChiTietService.deleteByIdSanPhamChiTietAndIdKhachHang(id, khachHangResponse.getId());
        return "redirect:/gio-hang";
    }

    // add voucher
    @PostMapping("/ap-dung-voucher")
    public String apDungVoucher(@RequestParam("ma") String ma, HttpSession session) {
        GiamGiaResponse giamGiaResponse = giamGiaService.findByMa(ma);
        session.setAttribute("giamGia", giamGiaResponse);

        String thongBaoGiamGia = "";
        if (giamGiaResponse == null) {
            thongBaoGiamGia = "Mã giảm giá không tồn tại.";
        } else {
            thongBaoGiamGia = "Đã áp dụng mã giảm giá.";
        }

        session.setAttribute("thongBaoGiamGia", thongBaoGiamGia);

        return "redirect:/gio-hang";
    }

    // trang thanh toán
    @GetMapping("thanh-toan")
    public String thanhToan(Model model) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        GiamGiaResponse giamGiaResponse = (GiamGiaResponse) session.getAttribute("giamGia");
        model.addAttribute("kh", khachHangRequest);
        if (khachHangResponse == null) {
            return "redirect:/dang-nhap";
        } else {
            BigDecimal tongTien = gioHangChiTietService.getTongTienByIdKhachHang(khachHangResponse.getId());
            model.addAttribute("listGioHang", gioHangService.getListByIdKhachHang(khachHangResponse.getId()));
            model.addAttribute("sumSoLuong", gioHangChiTietService.sumSoLuongByIdKhachHang(khachHangResponse.getId()));
            model.addAttribute("khachHang", khachHangService.getById(khachHangResponse.getId()));
            model.addAttribute("kh", khachHangResponse);
            model.addAttribute("tongTien", tongTien.intValue());
            if (giamGiaResponse != null) {
                int soPhanTramGiam = giamGiaResponse.getSoPhanTramGiam();
                BigDecimal soTienDuocGiam = tongTien.multiply(new BigDecimal(soPhanTramGiam).divide(new BigDecimal(100)));
                BigDecimal soTienSauKhiGiam = tongTien.subtract(soTienDuocGiam);
                model.addAttribute("soTienDuocGiam", soTienDuocGiam.intValue());
                model.addAttribute("soTienSauKhiGiam", soTienSauKhiGiam.intValue());
            } else {
                model.addAttribute("soTienDuocGiam", 0);
                model.addAttribute("soTienSauKhiGiam", tongTien.intValue());
            }
        }
        model.addAttribute("viewContent", "/views/user/thanh-toan.jsp");
        return "user/layout";
    }

    @ModelAttribute("formThanhToan")
    public FormThanhToan formThanhToan() {
        return new FormThanhToan();
    }

    // form thanh toán
    @PostMapping("thanh-toan")
    public String formThanhToan(@ModelAttribute("formThanhToan") FormThanhToan formThanhToan, @RequestParam(value = "diaChiMacDinh", required = false) Integer diaChiMacDinh) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        GiamGiaResponse giamGiaResponse = (GiamGiaResponse) session.getAttribute("giamGia");
        if (khachHangResponse == null) {
            return "redirect:/dang-nhap";
        } else {

            if (diaChiMacDinh == null) {
                diaChiMacDinh = 0;
            }

            if (giamGiaResponse == null) {
                UUID id = hoaDonService.addHoaDonUser(formThanhToan, khachHangResponse, null, diaChiMacDinh);
                return "redirect:/hoa-don/" + id;
            } else {
                UUID id = hoaDonService.addHoaDonUser(formThanhToan, khachHangResponse, giamGiaResponse, diaChiMacDinh);
                session.setAttribute("giamGia", null);
                return "redirect:/hoa-don/" + id;
            }
        }
    }

    // xem danh sách hoá đơn
    @GetMapping("/hoa-don")
    public String hoaDon(Model model) {
        KhachHangResponse khachHangResponse = (KhachHangResponse) session.getAttribute("khachHang");
        model.addAttribute("kh", khachHangRequest);
        if (khachHangResponse == null) {
            return "redirect:/dang-nhap";
        } else {
            model.addAttribute("listHoaDon", hoaDonChiTietService.findListHoaDonByKhachHang(khachHangResponse.getId()));
        }
        model.addAttribute("viewContent", "/views/user/hoa-don.jsp");
        return "user/layout";
    }

    @GetMapping("/so-phan-tram-giam-gia/{id}")
    @ResponseBody
    public ResponseEntity<Integer> soPhanTramGiamGiamGia(@PathVariable("id") UUID id) {
        return ResponseEntity.ok(hoaDonService.getSoPhanTramGiamByIdHoaDon(id));
    }

    // xem hoá đơn chi tiết
    @GetMapping("/hoa-don/{id}")
    public String hoaDonChiTiet(@PathVariable("id") UUID id, Model model) {
        model.addAttribute("hoaDon", hoaDonService.findHoaDonUserResponseById(id));
        model.addAttribute("listSanPhamTrongHoaDon", hoaDonChiTietService.getListByIdHoaDon(id));
        model.addAttribute("kh", khachHangRequest);
        model.addAttribute("id", id);
        session.setAttribute("idHoaDon", id);

        BigDecimal tongTien = hoaDonService.sumTongTienByIdHoaDon(id);
        Integer soPhanTramGiam = hoaDonService.getSoPhanTramGiamByIdHoaDon(id);
        BigDecimal soTienDuocGiam = tongTien.multiply(new BigDecimal(soPhanTramGiam).divide(new BigDecimal(100)));

        model.addAttribute("soTienTruocGiam", hoaDonChiTietService.sumTongTien(id).intValue());
        model.addAttribute("soTienDuocGiam", soTienDuocGiam.intValue());
        model.addAttribute("soTienSauKhiGiam", tongTien.intValue());

        model.addAttribute("viewContent", "/views/user/hoa-don-chi-tiet.jsp");
        return "user/layout";
    }

    // trang đăng nhập
    @GetMapping("/dang-nhap")
    public String dangNhap(Model model, @ModelAttribute("loginError") String loginError) {
        model.addAttribute("dangNhap", new DangNhapUserRequest());
        model.addAttribute("dangKy", new DangKyUserRequest());
        model.addAttribute("loginError", loginError);
        model.addAttribute("kh", khachHangRequest);
        model.addAttribute("viewContent", "/views/user/dang-nhap.jsp");
        return "user/layout";
    }

    // lấy form đăng nhập
    @PostMapping("/dang-nhap")
    public String dangNhap(@ModelAttribute("dangNhap") DangNhapUserRequest dangNhapUserRequest, RedirectAttributes redirectAttributes) {
        String email = dangNhapUserRequest.getEmail();
        String matKhau = dangNhapUserRequest.getMatKhau();

        if (email == null || email.isEmpty() || matKhau == null || matKhau.isEmpty()) {
            redirectAttributes.addFlashAttribute("loginError", "Vui lòng điền đầy đủ thông tin.");
            return "redirect:/dang-nhap";
        }

        KhachHangResponse khachHangResponse = khachHangService.getByEmailAndMatKhau(email, matKhau);

        if (khachHangResponse != null) {
            session.setAttribute("khachHang", khachHangResponse);
            gioHangService.checkAndAdd(khachHangResponse.getId());
            return "redirect:/";
        } else {
            redirectAttributes.addFlashAttribute("loginError", "Tài khoản hoặc mật khẩu không đúng.");
            return "redirect:/dang-nhap";
        }
    }

    // lấy form đăng ký
    @PostMapping("/dang-ky")
    public String dangKy(@ModelAttribute("dangKy") DangKyUserRequest dangKyUserRequest, RedirectAttributes redirectAttributes) {
        String email = dangKyUserRequest.getEmailDK();
        String matKhau = dangKyUserRequest.getMatKhauDK();
        String hoTen = dangKyUserRequest.getHoTen();

        if (hoTen == null || hoTen.isEmpty() || matKhau == null || matKhau.isEmpty() || hoTen == null || hoTen.isEmpty()) {
            redirectAttributes.addFlashAttribute("loginError", "Vui lòng điền đầy đủ thông tin");
            return "redirect:/dang-nhap#register";
        }
        if (!khachHangService.isPasswordValid(matKhau)) {
            redirectAttributes.addFlashAttribute("loginError", "Mật khẩu phải có ít nhất 6 ký tự và chứa ít nhất một chữ và một số");
            return "redirect:/dang-nhap#register";
        }
        if (khachHangService.existsByEmail(dangKyUserRequest.getEmailDK())) {
            redirectAttributes.addFlashAttribute("loginError", "Tài khoản đã tồn tại");
            return "redirect:/dang-nhap#register";
        }

        KhachHangRequest khachHangRequest = new KhachHangRequest();
        khachHangRequest.setEmail(email);
        khachHangRequest.setMatKhau(matKhau);
        khachHangRequest.setHoVaTen(hoTen);

        khachHangService.add(khachHangRequest);
        redirectAttributes.addFlashAttribute("successMessage", "Đăng ký thành công");

        return "redirect:/dang-nhap#register";
    }

    // đăng xuất
    @GetMapping("/dang-xuat")
    public String dangXuat() {
        session.setAttribute("khachHang", null);
        return "redirect:/";
    }

    // trang giới thiệu
    @GetMapping("/gioi-thieu")
    public String gioiThieu(Model model) {
        model.addAttribute("kh", khachHangRequest);
        model.addAttribute("viewContent", "/views/user/gioi-thieu.jsp");
        return "user/layout";
    }

    // trang chính sách bảo mật
    @GetMapping("/chinh-sach-bao-mat")
    public String chinhSachBaoMat(Model model) {
        model.addAttribute("viewContent", "/views/user/chinh-sach-bao-mat.jsp");
        return "user/layout";
    }

    // trang chính sách đổi trả
    @GetMapping("/chinh-sach-doi-tra")
    public String chinhSachDoiTra(Model model) {
        model.addAttribute("kh", khachHangRequest);
        model.addAttribute("viewContent", "/views/user/chinh-sach-doi-tra.jsp");
        return "user/layout";
    }
    @PostMapping("update/{id}")
    public String update(@PathVariable("id") UUID id, @Valid @ModelAttribute("kh") KhachHangRequest khachHangRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (khachHangRequest.validUpdate()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin.");
            return redirect;
        }

        if (!khachHangService.isSoDienThoai(khachHangRequest.getSoDienThoai())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Số điện thoại không đúng định dạng.");
            return redirect;
        }

        if (khachHangRequest.getHoVaTen().trim().length() == 0) {
            redirectAttributes.addFlashAttribute("errorMessage", "Họ và tên không được để trống.");
            return redirect;
        }
        khachHangService.update(khachHangRequest, id);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật khách hàng thành công");
        return "redirect:/";
    }

    @GetMapping("get/{id}")
    @ResponseBody
    public ResponseEntity<KhachHangResponse> getKhachHang(@PathVariable("id") UUID id) {
        return ResponseEntity.ok(khachHangService.getById(id));
    }
}
