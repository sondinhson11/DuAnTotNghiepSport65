<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/bootstrap.min.css">

</head>
<style>
    .selected {
        text-decoration: underline;
    }
</style>
<script>
    function filterByStatus(trangThai) {
        var url;
        if (trangThai === '') {
            url = "/admin/hoa-don"; // Trả về trang chủ nếu không có trạng thái
        } else {
            url = "/admin/hoa-don/filter?trangThai=" + trangThai;
        }
        window.location.href = url;
    }
</script>
<body>
<div class="px-4">
    <div class="row mt-2">
        <div class="col-lg-3">
            <h3>Hoá đơn</h3>
        </div>
    </div>
    <div class="row mt-2">
        <div class="col-12">
            <div class="btn-group">
                <button class="btn btn-toolbar ms-2 ${param.trangThai == null ? 'selected' : ''}" onclick="filterByStatus('')">Tất cả</button>
                <button class="btn btn-toolbar ms-2 ${param.trangThai == '2' ? 'selected' : ''}" onclick="filterByStatus('2')">Chờ xác nhận</button>
                <button class="btn btn-toolbar ms-2 ${param.trangThai == '3' ? 'selected' : ''}" onclick="filterByStatus('3')">Chờ giao</button>
                <button class="btn btn-toolbar ms-2 ${param.trangThai == '6' ? 'selected' : ''}" onclick="filterByStatus('6')">Đã xác nhận</button>
                <button class="btn btn-toolbar ms-2 ${param.trangThai == '4' ? 'selected' : ''}" onclick="filterByStatus('4')">Đang giao</button>
                <button class="btn btn-toolbar ms-2 ${param.trangThai == '1' ? 'selected' : ''}" onclick="filterByStatus('1')">Đã hoàn thành</button>
                <button class="btn btn-toolbar ms-2 ${param.trangThai == '10' ? 'selected' : ''}" onclick="filterByStatus('10')">Đã huỷ/Chờ hoàn tiền</button>
                <button class="btn btn-toolbar ms-2 ${param.trangThai == '5' ? 'selected' : ''}" onclick="filterByStatus('5')">Đã huỷ</button>
            </div>
        </div>
    </div>
    <hr>
    <div class="row mt-3">
        <section class="col-lg-12">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Mã Hoá Đơn</th>
                        <th>Nhân Viên</th>
                        <th>Khách Hàng</th>
                        <th>Ngày tạo</th>
                        <th>Loại hoá đơn</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${listHoaDon}" var="hoaDon" varStatus="index">
                        <tr class="show-tabs" data-tab="tabs-${index.count}">
                            <td>${index.count}</td>
                            <td>${hoaDon.ma}</td>
                            <td>${hoaDon.idNhanVien.hoVaTen}</td>
                            <td>
                                <c:if test="${hoaDon.idKhachHang != null}">
                                    ${hoaDon.idKhachHang.hoVaTen}
                                </c:if>
                                <c:if test="${hoaDon.idKhachHang == null}">
                                    Khách lẻ
                                </c:if>
                            </td>
                            <td>${hoaDon.ngayTao}</td>
                            <td>
                                <c:if test="${hoaDon.loaiHoaDon == 0}">
                                    <span class="text-black">Bán tại quầy</span>
                                </c:if>
                                <c:if test="${hoaDon.loaiHoaDon == 1}">
                                    <span class="text-black">Bán Online</span>
                                </c:if>
                                <c:if test="${hoaDon.loaiHoaDon == 2}">
                                    <span class="text-black">Giao Hàng</span>
                                </c:if>

                                <c:if test="${hoaDon.loaiHoaDon == null}">
                                    <span class="text-black">Hóa đơn chờ</span>
                                </c:if>
                            </td>
                            <td>
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
                            </td>
                            <td>
                                <a href="/admin/hoa-don/${hoaDon.id}" class="btn btn-primary detail-link"
                                   data-tab="tabs-${index.count}">Chi tiết</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>
    </div>
</div>

</body>
</html>

