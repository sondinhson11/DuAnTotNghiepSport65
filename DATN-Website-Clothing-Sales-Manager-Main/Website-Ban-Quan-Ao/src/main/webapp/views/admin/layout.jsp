<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Admin</title>
    <link href="/../views/admin/css/styles.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>


</head>
<style>
    <%--    bo tròn hình ảnh--%>
    .img-fluid {
        border-radius: 50%;
    }

    .custom-sidebar {
        background-color: #fff;
        border-right: 1px solid #dee2e6;
    }

    .custom-sidebar .list-group-item {
        border: none;
    }

    .custom-sidebar .list-group-item:hover {
        background-color: #f8f9fa;
    }

    .custom-sidebar .list-group-item.active {
        background-color: #fff;
        border-right: 3px solid #007bff;
    }
    .custom-sidebar .list-group-item.active:hover {
        background-color: #fff;
    }
    .custom-sidebar .list-group-item.active i {
        color: #007bff;
    }
    .custom-sidebar .list-group-item i {
        margin-right: 10px;
    }
    .custom-sidebar .sidebar-heading {
        text-align: center;
        padding: 20px 0;
        border-bottom: 1px solid #dee2e6;
    }

    .custom-sidebar .sidebar-heading img {
        width: 100px;
    }

    .custom-sidebar .sidebar-heading h3 {
        font-size: 1.5rem;
        font-weight: 700;
        margin-bottom: 0;
    }

    .custom-sidebar .sidebar-heading p {
        font-size: 0.875rem;
        font-weight: 400;
        margin-bottom: 0;
    }
    .dropdown {
        position: relative;
        display: inline-block;
    }
    .dropdown:hover .dropdown-menu {
        display: block;
        margin-left: 50px;
    }

    /* Adjusted style to handle mouseout */
    .dropdown-menu:hover {
        display: block;
    }

    .dropdown-menu a {
        display: block;
        padding: 10px;
        text-decoration: none;
        color: #212529;
    }

</style>
<body>
<div class="d-flex " id="wrapper">
    <!-- Sidebar-->
    <div class="border-end custom-sidebar" id="sidebar-wrapper">
        <div class="sidebar-heading border-bottom bg-light">
            <c:if test="${admin.chucVu == 0}">
                <h3>Quản lý</h3>
            </c:if>
            <c:if test="${admin.chucVu == 1}">
                <h3>Nhân viên</h3>
            </c:if>
<%--            <img src="/../views/admin/css/logo.png" alt="" class="img-fluid" style="width: 150px">--%> Logo
        </div>
        <div class="list-group list-group-flush">
            <c:if test="${admin.chucVu == 0}">
                <!-- Hiển thị menu cho quản lý -->
                <div class="dropdown">
                    <a class="list-group-item list-group-item-action list-group-item-light p-3 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Quản lí sản phẩm
                    </a>

                    <ul class="dropdown-menu">
                        <a class="dropdown-item" href="/admin/san-pham/index">Sản phẩm</a>
                        <a class="dropdown-item"  href="/admin/san-pham-chi-tiet/index">Sản Phẩm Chi Tiết</a>
                        <a class="dropdown-item"  href="/admin/loai/index">Loại</a>
                        <a class="dropdown-item"  href="/admin/kich-co/index">Kích cỡ</a>
                        <a class="dropdown-item"  href="/admin/mau-sac/index">Màu sắc</a>
                        <a class="dropdown-item"  href="/admin/thuong-hieu/index">Thương hiệu</a>
                        <a class="dropdown-item"  href="/admin/cau-lac-bo/index">Câu lạc bộ</a>
                    </ul>
                </div>

                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/khach-hang/index">Khách Hàng</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/nhan-vien/index">Nhân viên</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/giam-gia/index">Giảm giá</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/khuyen-mai/index">Khuyến mãi</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/thong-ke/index">Thống kê</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/hinh-thuc-thanh-toan/index">Hình Thức Thanh Toán</a>

            </c:if>
            <c:if test="${admin.chucVu == 1}">
                <!-- Hiển thị menu cho nhân viên -->
                <div class="dropdown">
                    <a class="list-group-item list-group-item-action list-group-item-light p-3 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Quản lí sản phẩm
                    </a>

                    <ul class="dropdown-menu">
                        <a class="dropdown-item" href="/admin/san-pham/index">Sản phẩm</a>
                        <a class="dropdown-item"  href="/admin/san-pham-chi-tiet/index">Sản Phẩm Chi Tiết</a>
                        <a class="dropdown-item"  href="/admin/loai/index">Loại</a>
                        <a class="dropdown-item"  href="/admin/kich-co/index">Kích cỡ</a>
                        <a class="dropdown-item"  href="/admin/mau-sac/index">Màu sắc</a>
                        <a class="dropdown-item"  href="/admin/thuong-hieu/index">Thương hiệu</a>
                        <a class="dropdown-item"  href="/admin/cau-lac-bo/index">Câu lạc bộ</a>
                    </ul>
                </div>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/khach-hang/index">Khách Hàng</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/giam-gia/index">Giảm giá</a>
                <a class="list-group-item list-group-item-action list-group-item-light p-3"
                   href="/admin/khuyen-mai/index">Khuyến mãi</a>
            </c:if>
        </div>
    </div>
    <!-- Page content wrapper-->
    <div id="page-content-wrapper">
        <!-- Top navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
            <div class="container-fluid">
                <button class="btn btn-primary" id="sidebarToggle">Menu</button>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
                        <li class="nav-item active">
                            <a class="nav-link" href="/logout">
                                <i class="fas fa-sign-out-alt"></i>
                                Đăng xuất
                            </a>
                        </li>
                        <li class="nav-item active"><a class="nav-link" href="/admin/ban-hang">
                            <i class="fas fa-cart-plus"></i>
                            Bán hàng tại quầy
                        </a>
                        </li>
                        <li class="nav-item active"><a class="nav-link" href="/admin/hoa-don">
                            <i class="fas fa-file-invoice"></i>
                            Hoá đơn
                        </a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Page content-->
        <div class="container-fluid">
            <h1></h1>
            <jsp:include page="${ view }"/>
        </div>
    </div>
</div>
<!-- Bootstrap core JS-->
<script src="/../js/bootstrap.min.js"></script>
<!-- Core theme JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
<!-- Bao gồm các tập lệnh Spring form và các tập lệnh khác -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
    window.addEventListener('load', event => {
        const sidebarToggle = document.body.querySelector('#sidebarToggle');

        // Function to toggle sidebar and save the state to localStorage
        const toggleSidebar = () => {
            document.body.classList.toggle('sb-sidenav-toggled');
            localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
        };

        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', event => {
                event.preventDefault();
                toggleSidebar();
            });
        }

        // Check localStorage for the sidebar state and apply it
        const savedSidebarState = localStorage.getItem('sb|sidebar-toggle');
        if (savedSidebarState && savedSidebarState === 'true') {
            document.body.classList.add('sb-sidenav-toggled');
        }
    });


</script>
</body>
</html>
