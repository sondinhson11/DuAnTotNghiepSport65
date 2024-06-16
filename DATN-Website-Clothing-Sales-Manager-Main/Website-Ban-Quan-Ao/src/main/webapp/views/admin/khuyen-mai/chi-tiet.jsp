<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container mt-3">
    <h1 class="text-center">Quản Lý Khuyến Mãi Chi Tiết</h1>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>

    <table class="table table-bordered mt-3 text-center">
        <thead>
        <tr>
            <th>STT</th>
            <th>Tên Sản Phẩm</th>
            <th>Loại</th>
            <th>Thao Tác</th>
        </tr>
        </thead>
        <tbody>
        <!-- Bắt đầu tải thư viện jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <c:forEach varStatus="index" items="${khuyenMaiChiTietPage}" var="kmct">
            <tr>
                <td>${index.index + 1}</td>
                <td>${kmct.ten}</td>
                <td>${kmct.idLoai.ten}</td>
                <td>
                    <div id="trangThai_${kmct.id}">
                    </div>
                    <script>
                        $(document).ready(function () {
                            var idKhuyenMai = '${idKhuyenMai}';
                            var kmctId = '${kmct.id}';
                            $.ajax({
                                url: "/admin/khuyen-mai/chi-tiet/getTrangThai/" + idKhuyenMai + "/" + kmctId,
                                method: "GET",
                                success: function (data) {
                                    var trangThaiDiv = $("#trangThai_" + kmctId);
                                    if (data === 0) {
                                        trangThaiDiv.html('<a href="/admin/khuyen-mai/add-chi-tiet/' + idKhuyenMai + '/' + kmctId + '" class="btn btn-success">Thêm</a>');
                                    } else if (data === 1) {
                                        trangThaiDiv.html('<a href="/admin/khuyen-mai/delete-chi-tiet/' + idKhuyenMai + '/' + kmctId + '" class="btn btn-danger">Xoá</a>');
                                    }
                                },
                                error: function () {
                                    // Xử lý lỗi nếu có
                                }
                            });
                        });
                    </script>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>

</div>
