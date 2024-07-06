<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>


<body>
<c:if test="${not empty sessionScope.successMessage}">
    <div class="alert alert-success" role="alert">
            ${sessionScope.successMessage}
    </div>
    <script>
        setTimeout(function () {
            $('.alert').alert('close');
        }, 3000);
    </script>
    <% session.removeAttribute("successMessage"); %>
</c:if>
<c:if test="${not empty sessionScope.errorMessage}">
    <div class="alert alert-danger" role="alert">
            ${sessionScope.errorMessage}
    </div>
    <% session.removeAttribute("errorMessage"); %>
    <script>
        setTimeout(function () {
            $('.alert').alert('close');
        }, 3000);
    </script>
</c:if>
<c:set var="tongTien" value="0"/>
<c:forEach items="${listSanPhamTrongGioHang}" var="sp" varStatus="status">
    <c:set var="tongTien" value="${tongTien + (sp.soLuong * sp.gia)}"/>
</c:forEach>
<c:set var="tongTien" value="${tongTien + hoaDon.phiVanChuyen}"/>
<div class="">
    <div class="row">
            <span class="d-flex">
                <p class="text-warning me-2"> Danh sách hoá đơn</p> / <p class="ms-2">${hoaDon.ma}</p>
            </span>

    </div>
    <div class="row">
       <span class="text-uppercase">
           Trạng thái hiện tại:
            <c:if test="${hoaDon.trangThai == 0}">
                <span class="text-secondary">Chờ thanh toán</span>
            </c:if>
            <c:if test="${hoaDon.trangThai == 1}">
                <span class="text-success">Đã hoàn thành</span>
            </c:if>
           <c:if test="${hoaDon.trangThai == 2}">
               <span class="text-secondary">Chờ xác nhận</span>
           </c:if>
            <c:if test="${hoaDon.trangThai == 3}">
                <span class="text-secondary">Chờ giao</span>
            </c:if>
            <c:if test="${hoaDon.trangThai == 4}">
                <span class="text-success">Đang giao</span>
            </c:if>
            <c:if test="${hoaDon.trangThai == 5}">
                <span class="text-danger">Đã huỷ</span>
            </c:if>
           <c:if test="${hoaDon.trangThai == 6}">
               <span class="text-secondary">Đã xác nhận</span>
           </c:if>
            <c:if test="${hoaDon.trangThai == 7}">
                <span class="text-secondary">Khách delay giao hàng lần 1</span>
            </c:if>
            <c:if test="${hoaDon.trangThai == 8}">
                <span class="text-secondary">Khách delay giao hàng lần 2</span>
            </c:if>
            <c:if test="${hoaDon.trangThai == 9}">
                <span class="text-secondary">Khách delay giao hàng lần 3</span>
            </c:if>
            <c:if test="${hoaDon.trangThai == 10}">
                <span class="text-secondary">Đã huỷ/Chờ hoàn tiền</span>
            </c:if>
       </span>
    </div>
    <c:if test="${hoaDon.loaiHoaDon != null}">
    <div class="row mt-2">
        <div>
            <div class="float-start">
                <c:if test="${hoaDon.trangThai == 0 || hoaDon.trangThai == 2 || hoaDon.trangThai == 3 || hoaDon.trangThai == 9 || hoaDon.trangThai == 10 || hoaDon.trangThai == 6}">
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modalHuy">
                        Huỷ đơn hàng
                    </button>
                </c:if>
                <c:if test="${hoaDon.trangThai !=4}">
                    <c:if test="${hoaDon.trangThai == 0 || hoaDon.trangThai == 2 || hoaDon.trangThai == 3 || hoaDon.trangThai == 6 || hoaDon.trangThai == 7 || hoaDon.trangThai == 8 || hoaDon.trangThai == 9}">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                data-bs-target="#modalXacNhan">
                            Xác nhận
                        </button>
                    </c:if>
                </c:if>
                <c:if test="${hoaDon.trangThai == 4 || hoaDon.trangThai == 7 || hoaDon.trangThai == 8 }">
                    <button type="button" class="btn btn-danger me-5 " data-bs-toggle="modal"
                            data-bs-target="#ModalDelay">
                        Khách delay
                    </button>
                </c:if>
                <c:if test="${hoaDon.trangThai == 4}">
                    <button type="button" class="btn btn-primary float-end" data-bs-toggle="modal"
                            data-bs-target="#exampleModal">
                        Xác nhận
                    </button>
                </c:if>
            </div>
        </div>
    </div>
    </c:if>
    <div class="card mt-4">
        <div class="card-header">
            <p class="fw-bold text-uppercase">Thông tin đơn hàng</p>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-4">
                    <p>Mã hoá đơn: ${hoaDon.ma}</p>
                    <p>Ngày tạo:
                        <%--format ngày tạo--%>
                        <span id="ngay-tao-1"></span>
                        <script>
                            var originalDate = "${hoaDon.ngayTao}";
                            var formattedDate = new Date(originalDate).toLocaleString();
                            document.getElementById("ngay-tao-1").textContent = formattedDate;
                        </script>
                    </p>
                    <p>Khách hàng:
                        <c:if test="${hoaDon.idKhachHang != null}">
                            ${hoaDon.idKhachHang.hoVaTen}
                        </c:if>
                        <c:if test="${hoaDon.idKhachHang == null}">
                            Khách lẻ
                        </c:if>
                    </p>
                    <p>Nhân viên: ${hoaDon.idNhanVien.hoVaTen}</p>
                    <p>Địa chỉ: ${hoaDon.xaPhuong}, ${hoaDon.quanHuyen}, ${hoaDon.tinhThanhPho}</p>
                    <c:if test="${hoaDon.trangThai == 3}">
                        <p>Số điện thoại: ${hoaDon.soDienThoai}</p>
                        <p>Mã vận đơn: ${hoaDon.maVanChuyen}</p>
                        <p>Đơn vị vận chuyển: ${hoaDon.tenDonViVanChuyen}</p>
                    </c:if>
                    <c:if test="${hoaDon.loaiHoaDon == 2}">
                        Ảnh chuyển khoản:
                        <img src="${hoaDon.anhHoaDonChuyenKhoan}" alt="" style="width: 300px; height: 300px">
                    </c:if>
                </div>
                <div class="col-4">
                    <p id="phi-van-chuyen">Phí vận chuyển: ${hoaDon.phiVanChuyen}</p>
                    <p id="tong_tien_1">${tongTien}</p>
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            var giaElement = document.getElementById('tong_tien_1');
                            // Lấy giá trị không định dạng từ thẻ p
                            var giaValue = parseFloat(giaElement.textContent.replace(/[^\d.]/g, '')) || 0;
                            // Định dạng lại giá trị và gán lại vào thẻ p
                            giaElement.textContent = giaValue.toLocaleString('en-US');
                            // thêm chữ tônhr tiền trước giá trị
                            giaElement.insertAdjacentText('afterbegin', 'Tổng tiền: ');
                            giaElement.insertAdjacentHTML('beforeend', 'VNĐ ');

                            // format phí vânj chuyển
                            var phiVanChuyenElement = document.getElementById('phi-van-chuyen');
                            // Lấy giá trị không định dạng từ thẻ p
                            var phiVanChuyenValue = parseFloat(phiVanChuyenElement.textContent.replace(/[^\d.]/g, '')) || 0;
                            // Định dạng lại giá trị và gán lại vào thẻ p
                            phiVanChuyenElement.textContent = phiVanChuyenValue.toLocaleString('en-US');
                            // thêm chữ tônhr tiền trước giá trị
                            phiVanChuyenElement.insertAdjacentText('afterbegin', 'Phí vận chuyển: ');
                            phiVanChuyenElement.insertAdjacentHTML('beforeend', 'VNĐ ');
                        });
                    </script>
                    <p>Trạng thái:
                        <c:if test="${hoaDon.trangThai == 0}">
                            <span class="text-secondary">Chờ thanh toán</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 1}">
                            <span class="text-success">Đã hoàn thành</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 2}">
                            <span class="text-secondary">Chờ xác nhận</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 3}">
                            <span class="text-secondary">Chờ giao</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 4}">
                            <span class="text-success">Đang giao</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 5}">
                            <span class="text-danger">Đã huỷ</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 6}">
                            <span class="text-secondary">Đã xác nhận</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 7}">
                            <span class="text-secondary">Khách delay giao hàng lần 1</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 8}">
                            <span class="text-secondary">Khách delay giao hàng lần 2</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 9}">
                            <span class="text-secondary">Khách delay giao hàng lần 3</span>
                        </c:if>
                        <c:if test="${hoaDon.trangThai == 10}">
                            <span class="text-secondary">Đã huỷ/Chờ hoàn tiền</span>
                        </c:if>

                    </p>
                    <p>Ngày thanh toán:
                        <%--format ngày tạo--%>
                        <span id="ngay-tt-1"></span>
                        <script>
                            var originalDate = "${hoaDon.ngayThanhToan}";
                            var formattedDate = new Date(originalDate).toLocaleString();
                            document.getElementById("ngay-tt-1").textContent = formattedDate;
                        </script>
                    </p>
                    <p>Loại hoá
                        đơn:
                        <c:if test="${hoaDon.loaiHoaDon == 0}">
                            <span class="text-secondary">Bán tại quầy</span>
                        </c:if>
                        <c:if test="${hoaDon.loaiHoaDon == 1}">
                            <span class="text-success">Bán Online</span>
                        </c:if>
                        <c:if test="${hoaDon.loaiHoaDon == 2}">
                            <span class="text-secondary">Giao Hàng</span>
                        </c:if>
                    </p>
                </div>
                <div class="col-4">
                        <textarea name="" id="" cols="30" rows="5" class="form-control" placeholder="Ghi chú"
                                  readonly>${hoaDon.ghiChu}
                        </textarea>
                </div>
            </div>
        </div>
    </div>



    <div class="card mt-4 mb-4">
        <div class="card-header">
            <p class="fw-bold text-uppercase">Sản phẩm - <span>
        </span></p>
        </div>
        <div class="card-body">
            <div class="">
                <table class="table text-center">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col" style="width: 150px;"><i class="fas fa-image"></i></th>
                        <th scope="col">Sản phẩm</th>
                        <th scope="col">Giá</th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Tổng tiền</th>
                        <th scope="col">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${listSanPhamTrongGioHang}" var="sp" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>
                                <!-- Ảnh -->
                                <div id="carouselExampleSlidesOnly_${sp.idSanPhamChiTiet}"
                                     class="carousel slide" data-bs-ride="carousel" data-bs-interval="1000">
                                    <div class="carousel-inner" style="width: 150px; height: 150px">
                                        <c:forEach items="${listAnhSanPham}" var="anhSanPham" varStatus="status">
                                            <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                                <img src="${anhSanPham.duongDan}" class="d-block" id="custom-anh"
                                                     style="width: 150px; height: 150px">
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <p>${sp.tenSanPham}</p>
                                <p>${sp.tenMau}/${sp.tenSize}</p>
                            </td>
                            <td id="gia_sp_${sp.idSanPhamChiTiet}">${sp.gia}</td>
                            <td>${sp.soLuong}</td>
                            <td id="tong_tien_${sp.idSanPhamChiTiet}">
                                    ${sp.soLuong * sp.gia}
                            </td>
                            <td>
                                <form id="returnForm_${sp.idSanPhamChiTiet}" action="/admin/san-pham-chi-tiet/tra-hang-vao-kho" method="post" display="none">
                                    <input type="hidden" name="idSanPhamChiTiet" value="${sp.idSanPhamChiTiet}">
                                    <input type="hidden" name="soLuongTraHang" value="${sp.soLuong}">
                                    <input type="hidden" name="idHoaDon" value="${hoaDon.id}">
                                    <c:if test="${hoaDon.trangThai == 5}">
                                        <button type="submit" class="btn btn-success" style="display: inline-block">Hoàn lại kho</button>
                                    </c:if>
                                </form>
                            </td>
                            <c:if test="${hoaDon.trangThai == 5}">
                                <!-- Thêm script để tự động submit form nếu chưa hoàn -->
                                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                            </c:if>
                            <script>
                                // format tổng tiền
                                document.addEventListener('DOMContentLoaded', function () {
                                    var giaElement = document.getElementById('tong_tien_${sp.idSanPhamChiTiet}');
                                    var giaValue = parseFloat(giaElement.textContent.replace(/[^\d.]/g, '')) || 0;
                                    giaElement.textContent = giaValue.toLocaleString('en-US');

                                    var giaElement = document.getElementById('gia_sp_${sp.idSanPhamChiTiet}');
                                    var giaValue = parseFloat(giaElement.textContent.replace(/[^\d.]/g, '')) || 0;
                                    giaElement.textContent = giaValue.toLocaleString('en-US');
                                });
                            </script>
                            <script>
                                // get ảnh sản phẩm
                                $(document).ready(function () {
                                    var idSanPham = '${sp.idSanPhamChiTiet}';
                                    $.ajax({
                                        url: '/api/kho/soLuong/' + idSanPham,
                                        type: 'GET',
                                        dataType: 'json',
                                        success: function (soLuong) {
                                            console.log('Số lượng trong kho:', soLuong);
                                        },
                                        error: function () {
                                            console.log('Lỗi khi lấy số lượng trong kho');
                                        }
                                    });

                                    // get ảnh sản phẩm
                                    $.ajax({
                                        url: '/get-anh-san-pham/' + idSanPham,
                                        type: 'GET',
                                        dataType: 'json',
                                        success: function (data) {
                                            var listAnhSanPham = data;
                                            var carouselInner = $('#carouselExampleSlidesOnly_${sp.idSanPhamChiTiet} .carousel-inner');
                                            carouselInner.empty();

                                            $.each(listAnhSanPham, function (index, anhSanPham) {
                                                var isActive = index === 0 ? 'active' : '';
                                                var carouselItem = '<div class="carousel-item ' + isActive + '">'
                                                    + '<img src="' + anhSanPham.duongDan + '" class="d-block" id="custom-anh" style="width: 150px; height: 150px">'
                                                    + '</div>';
                                                carouselInner.append(carouselItem);
                                            });
                                        },
                                        error: function () {
                                            console.log('Lỗi khi lấy danh sách ảnh sản phẩm');
                                        }
                                    });
                                });
                            </script>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>
<!--modal xác nhận thanh toán-->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Xác nhận thanh toán</h1>
                <button type="button" class="btn-Đóng" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <form action="/admin/hoa-don/xac-nhan-thanh-toan/${hoaDon.id}" method="post">
                <input type="hidden" name="trangThai" value="1">
                <c:if test="${hoaDon.trangThai == 4}">
                    <input type="hidden" name="httt" value=${listhttt.id}>
                </c:if>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Tổng tiền cần thanh toán</label>
                        <label class="form-label float-end" id="tong-tien">${tongTien}</label>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ghi chú </label>
                        <textarea class="form-control" name="ghiChu" rows="3"
                                  placeholder="Ghi chú"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- modal xác nhận đơn hàng -->
<div class="modal fade" id="modalXacNhan" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <c:if test="${hoaDon.trangThai != 2 && hoaDon.trangThai != 6}">
                <form id="form" action="/admin/hoa-don/update-trang-thai/${hoaDon.id}" method="post">
                    <input type="hidden" name="trangThai" value="" id="trang-thai">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Ghi chú </label>
                            <textarea class="form-control" name="ghiChu" rows="3"
                                      placeholder="Ghi chú"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </div>
                </form>
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const form = document.getElementById('form');
                        form.addEventListener('submit', function (event) {
                            // Validate the form fields
                            const ghiChu = document.querySelector('#form textarea[name="ghiChu"]');
                            if (ghiChu.value.trim() === '') {
                                event.preventDefault();
                                alert('Vui lòng điền đầy đủ thông tin.');
                            }
                        });
                    });
                </script>
            </c:if>
            <c:if test="${hoaDon.trangThai == 2 || hoaDon.trangThai == 6}">
                <form id="form1" action="/admin/hoa-don/update-trang-thai-online/${hoaDon.id}" method="post">
                    <input type="hidden" name="trangThai" value="" id="trang-thai">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Ghi chú </label>
                            <textarea id="ghiChu" class="form-control" name="ghiChu" rows="3"
                                      placeholder="Ghi chú"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mã vận đơn </label>
                            <input id="maVanChuyen" type="text" class="form-control" name="maVanChuyen" placeholder="Mã vận đơn">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Đơn vị vận chuyển </label>
                            <input id="tenDonVi" type="text" class="form-control" name="tenDonViVanChuyen"
                                   placeholder="Đơn vị vận chuyển">
                        </div>
                        <div class="mb-3">
                            <label id="phiVanChuyen" class="form-label">Phí vận chuyển </label>
                            <input type="number" class="form-control" name="phiVanChuyen" placeholder="Phí vận chuyển">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </div>
                </form>
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const form = document.getElementById('form1');
                        form.addEventListener('submit', function (event) {
                            // Validate the form fields
                            const ghiChu = document.getElementById('ghiChu');
                            const maVanChuyen = document.getElementById('maVanChuyen');
                            const tenDonViVanChuyen = document.getElementById('tenDonVi');
                            const phiVanChuyen = document.getElementById('phiVanChuyen');
                            if (
                                ghiChu.value.trim() === '' ||
                                maVanChuyen.value.trim() === '' ||
                                tenDonViVanChuyen.value.trim() === '' ||
                                phiVanChuyen.value.trim() === ''
                            ) {
                                event.preventDefault();
                                alert('Vui lòng điền đầy đủ thông tin.');
                            }
                        });
                    });
                </script>
            </c:if>
        </div>
    </div>
</div>
<!-- modal huỷ -->
<div class="modal fade" id="modalHuy" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="form2" action="/admin/hoa-don/update-trang-thai/${hoaDon.id}" method="post">
                <c:if test="${hoaDon.trangThai == 2 && hoaDon.loaiHoaDon == 1}">
                    <input type="hidden" name="trangThai" value="5">
                </c:if>
                <c:if test="${hoaDon.trangThai == 3}">
                    <input type="hidden" name="trangThai" value="10">
                </c:if>
                <c:if test="${hoaDon.trangThai == 6}">
                    <input type="hidden" name="trangThai" value="10">
                </c:if>
                <c:if test="${hoaDon.trangThai == 9}">
                    <input type="hidden" name="trangThai" value="10">
                </c:if>
                <c:if test="${hoaDon.trangThai == 10}">
                    <input type="hidden" name="trangThai" value="5">
                </c:if>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Ghi chú </label>
                        <textarea class="form-control" id="ghi-chu" name="ghiChu" rows="3"
                                  placeholder="Ghi chú"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-danger">Lưu</button>
                </div>
            </form>

            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const form = document.getElementById('form2');
                    form.addEventListener('submit', function (event) {
                        // Validate the form fields
                        const ghiChu = document.querySelector('#form2 textarea[name="ghiChu"]');
                        if (ghiChu.value.trim() === '') {
                            event.preventDefault();
                            alert('Vui lòng điền đầy đủ thông tin.');
                        }
                    });
                });
            </script>
        </div>
    </div>
</div>
<%--modal delay giao hàng--%>
<div class="modal fade" id="ModalDelay" tabindex="-1" aria-labelledby="ModalDelay" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Delay giao hàng</h1>
                <button type="button" class="btn-Đóng" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <form id="form3" action="/admin/hoa-don/update-trang-thai/${hoaDon.id}" method="post">
                <c:if test="${hoaDon.trangThai == 4}">
                    <input type="hidden" name="trangThai" value="7">
                </c:if>
                <c:if test="${hoaDon.trangThai == 7}">
                    <input type="hidden" name="trangThai" value="8">
                </c:if>
                <c:if test="${hoaDon.trangThai == 8}">
                    <input type="hidden" name="trangThai" value="9">
                </c:if>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Ghi chú </label>
                        <textarea class="form-control" name="ghiChu" rows="3"
                                  placeholder="Ghi chú"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </div>
            </form>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const form = document.getElementById('form3');
                    form.addEventListener('submit', function (event) {
                        // Validate the form fields
                        const ghiChu = document.querySelector('#form3 textarea[name="ghiChu"]');
                        if (ghiChu.value.trim() === '') {
                            event.preventDefault();
                            alert('Vui lòng điền đầy đủ thông tin.');
                        }
                    });
                });
            </script>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    const trangThai = document.getElementById('trang-thai');
    const trangThaiHoaDon = ${hoaDon.trangThai};
    if (trangThaiHoaDon == 2) {
        trangThai.value = 3;
    }
    if (trangThaiHoaDon == 3) {
        trangThai.value = 4;
    }
    if (trangThaiHoaDon == 6) {
        trangThai.value = 3;
    }

</script>

</body>

</html>