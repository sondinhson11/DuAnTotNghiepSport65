<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<div class="container">
    <h1 class="text-center mt-3">Quản Lý Nhân Viên </h1>

    <div class="row mt-3">
        <div class="col-6">
            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">
                Thêm nhân viên
            </button>
        </div>
    </div>

    <table class="table table-bordered text-center mt-3">
        <thead>
        <tr>
            <th>STT</th>
            <th>Mã</th>
            <th>Họ và tên</th>
            <th>Email</th>
            <th>SĐT</th>
            <th>Địa Chỉ</th>
            <th>Xá/Phường</th>
            <th>Quận/Huyện</th>
            <th>Tỉnh/Thành Phố</th>
            <th>Ngày vào làm</th>
            <th>Trạng thái</th>
            <th>Chức vụ</th>
            <th>Thao Tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach varStatus="index" items="${nhanVienPage.content}" var="nv">
            <tr>
                <td>${index.index + nhanVienPage.number * nhanVienPage.size + 1}</td>
                <td>${ nv.ma }</td>
                <td>${ nv.hoVaTen}</td>
                <td>${ nv.email }</td>
                <td>${ nv.soDienThoai }</td>
                <td>${ nv.diaChi }</td>
                <td>${ nv.xaPhuong }</td>
                <td>${ nv.quanHuyen }</td>
                <td>${ nv.tinhThanhPho }</td>
                <td>${ nv.ngayVaoLam }</td>
                <td>
                    <c:if test="${nv.trangThai == '0'}">Đang làm</c:if>
                    <c:if test="${nv.trangThai == '1'}">Đã nghỉ</c:if>
                </td>
                <td>
                    <c:if test="${nv.chucVu == '0'}">Quản lý</c:if>
                    <c:if test="${nv.chucVu == '1'}">Nhân Viên</c:if>
                </td>

                <td>
                    <a href="#" class=" update-button col-10"
                       data-bs-toggle="modal" data-bs-target="#exampleModal"
                       data-id="${nv.id}" data-ma="${nv.ma}" data-hoVaTen="${nv.hoVaTen}"
                       data-email="${nv.email}" data-soDienThoai="${nv.soDienThoai}"
                       data-diaChi="${nv.diaChi}" data-xaPhuong="${nv.xaPhuong}" data-quanHuyen="${nv.quanHuyen}"
                       data-tinhThanhPho="${nv.tinhThanhPho}" data-ngayVaoLam="${nv.ngayVaoLam}"
                       data-trangThai="${nv.trangThai}" data-chucVu="${nv.chucVu}">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
                            <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.5.5 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11z"/>
                        </svg>
                    </a>
<%--                    <a href="/admin/nhan-vien/delete/${nv.id}" class="btn btn-danger mt-1 col-10"--%>
<%--                       onclick="return confirm('Bạn có chắc chắn muốn xoá không?')">Xoá</a>--%>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="mt-3">
        <div class="text-center">
            <c:if test="${nhanVienPage.totalPages > 1}">
                <ul class="pagination">
                    <li class="page-item <c:if test="${nhanVienPage.number == 0}">disabled</c:if>">
                        <a class="page-link" href="?page=1">First</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${nhanVienPage.totalPages}">
                        <li class="page-item <c:if test="${nhanVienPage.number + 1 == i}">active</c:if>">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item <c:if test="${nhanVienPage.number == nhanVienPage.totalPages - 1}">disabled</c:if>">
                        <a class="page-link" href="?page=${nhanVienPage.totalPages - 1}">Last</a>
                    </li>
                </ul>
            </c:if>
        </div>
    </div>

    <!-- Modal Thêm và Cập Nhật -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"
         data-bs-backdrop="static">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Thêm Nhân Viên</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form:form id="edit-form" modelAttribute="nv" method="post" action="/admin/nhan-vien/store">
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="hoVaTen" class="form-label">Họ Và Tên</label>
                                    <form:input type="text" path="hoVaTen" id="hoVaTen" class="form-control"
                                                required="true"/>
                                    <form:errors path="hoVaTen" cssClass="text-danger"/>
                                </div>
                            </div>


                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="email" class="form-label">Email</label>
                                    <form:input type="text" path="email" id="email" class="form-control"
                                                required="true"/>
                                    <form:errors path="email" cssClass="text-danger"/>
                                </div>
                            </div>

                            <div class="col">
                                <div class="form-group">
                                    <label for="soDienThoai" class="form-label">Số điện thoại</label>
                                    <form:input type="tel" path="soDienThoai" id="soDienThoai" class="form-control"
                                                required="true"/>
                                    <form:errors path="soDienThoai" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="matKhau" class="form-label">Mật Khẩu</label>
                                    <form:input type="password" path="matKhau" id="matKhau" class="form-control"
                                                required="true"/>
                                    <form:errors path="matKhau" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="diaChi" class="form-label">Địa chỉ</label>
                                    <form:input type="text" path="diaChi" id="diaChi" class="form-control"
                                                required="true"/>
                                    <form:errors path="diaChi" cssClass="text-danger"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="xaPhuong" class="form-label">Xã/Phường</label>
                                    <form:input type="text" path="xaPhuong" id="xaPhuong" class="form-control"
                                                required="true"/>
                                    <form:errors path="xaPhuong" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="quanHuyen" class="form-label">Quận/Huyện</label>
                                    <form:input type="text" path="quanHuyen" id="quanHuyen" class="form-control"
                                                required="true"/>
                                    <form:errors path="quanHuyen" cssClass="text-danger"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="quanHuyen" class="form-label">Tỉnh</label>
                                    <form:input type="text" path="tinhThanhPho" id="tinhThanhPho" class="form-control"
                                                required="true"/>
                                    <form:errors path="tinhThanhPho" cssClass="text-danger"/>
                                </div>
                            </div>

                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="trangThai" class="form-label">Trạng thái</label>
                                    <form:select path="trangThai" id="trangThai" class="form-control" required="true">
                                        <option value="0">Đang làm</option>
                                        <option value="1">Đã nghỉ</option>
                                    </form:select>
                                </div>
                            </div>


                            <div class="col">
                                <div class="form-group">
                                    <label class="form-label">Chức vụ</label>
                                    <form:select path="chucVu" id="chucVu" class="form-control">
                                        <option value="0">Quản lý</option>
                                        <option value="1">Nhân Viên</option>
                                    </form:select>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-success mt-3">Lưu</button>
                    </form:form>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- Bao gồm các tập lệnh Spring form và các tập lệnh khác -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(".update-button").click(function () {
        let id = $(this).data("id");

        // Thực hiện yêu cầu AJAX để lấy dữ liệu khách hàng dựa trên id
        $.ajax({
            url: "/admin/nhan-vien/get/" + id,
            type: "GET",
            success: function (data) {
                // Đặt giá trị cho các trường trong modal bằng dữ liệu từ yêu cầu AJAX
                $("#ma").val(data.ma);
                $("#hoVaTen").val(data.hoVaTen);
                $("#email").val(data.email);
                $("#soDienThoai").val(data.soDienThoai);
                $("#matKhau").val(data.matKhau);
                $("#diaChi").val(data.diaChi);
                $("#xaPhuong").val(data.xaPhuong);
                $("#quanHuyen").val(data.quanHuyen);
                $("#tinhThanhPho").val(data.tinhThanhPho);
                $("#ngayVaoLam").val(data.ngayVaoLam);
                $("#trangThai").val(data.trangThai);
                $("#chucVu").val(data.chucVu);

                // Đặt action của form trong modal (action cập nhật với ID của khách hàng)
                $("#edit-form").attr("action", "/admin/nhan-vien/update/" + id);
            },
            error: function (error) {
                console.error("Error:", error);
            },
        });
    });
    document.addEventListener("DOMContentLoaded", function () {
        var updateButtons = document.querySelectorAll(".update-button");
        var clickClose = document.querySelector(".btn-close");

        updateButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                var modalTitle = document.querySelector(".modal-title");
                var matKhauInput = document.querySelector("#matKhau");

                // Đặt tiêu đề modal thành "Cập Nhật Nhân Viên"
                modalTitle.textContent = "Cập Nhật Nhân Viên";

                // Vô hiệu hoá ô input mật khẩu
                matKhauInput.setAttribute("disabled", "disabled");
            });
        });
        clickClose.addEventListener("click", function () {
            var modalTitle = document.querySelector(".modal-title");
            var matKhauInput = document.querySelector("#matKhau");

            // Đặt tiêu đề modal thành "Thêm Khách Hàng"
            modalTitle.textContent = "Thêm Nhân Viên";

            // Bỏ vô hiệu hoá ô input mật khẩu
            matKhauInput.removeAttribute("disabled");
            // reset form
            $("#edit-form").trigger("reset");
            $("#edit-form").attr("action", "/admin/nhan-vien/store");

        });
    });
    $(document).ready(function () {
        hideErrorMessage();
        hideErrorMessage2();
    });

    document.addEventListener("DOMContentLoaded", function () {
        // Kiểm tra thông báo thành công
        <c:if test="${not empty successMessage}">
        Swal.fire({
            position: 'center',
            icon: 'success',
            title: '${successMessage}',
            showConfirmButton: false,
            timer: 2000
        });
        </c:if>

        // Kiểm tra thông báo lỗi
        <c:if test="${not empty errorMessage}">
        Swal.fire({
            position: 'center',
            icon: 'error',
            title: '${errorMessage}',
            showConfirmButton: false,
            timer: 2000
        });
        </c:if>
    });
</script>

