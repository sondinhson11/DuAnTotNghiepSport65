<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Sport65</title>
    <link rel="stylesheet" href="/../views/user/css/index.css"/>
    <link rel="stylesheet" href="/../views/user/css/styleguide.css"/>
    <link rel="stylesheet" href="/../views/user/css/productdetail.css"/>
    <link rel="stylesheet" href="/../views/user/css/product.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"
          integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous"/>
</head>
<style>
    <%--        fixed navbar--%>
    body {
        padding-top: 70px; /* Adjust this value based on your navbar height */
    }

    .custom-nav {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        z-index: 1000;
        transition: background-color 0.3s;
    }

    .custom-nav.scrolled {
        background-color: #ffffff;
    }
    .menu-div-2 {
        display: flex;
        align-items: center;
    }
    /* Optional: Add margin to the right of the last item to separate it from the dropdown */
    .menu-div-2 .nav-item.dropdown {
        margin-right: 10px; /* Adjust as needed */
    }


</style>
<body>
<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark custom-nav">
        <div class="container">
            <a class="navbar-brand" href="/">Logo</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                <ul class="navbar-nav m-auto"> <!-- Use 'mr-auto' here -->
                    <li class="nav-item  ">
                        <a style="color: #ffffff" class="nav-link" href="/">Trang chủ</a>
                    </li>
                    <li class="nav-item  ">
                        <a style="color: #ffffff" class="nav-link" href="/san-pham">Sản Phẩm</a>
                    </li>
                    <li class="nav-item  ">
                        <a style="color: #ffffff" class="nav-link" href="/sale">Sale</a>
                    </li>
                    <li class="nav-item">
                        <a style="color: #ffffff" class="nav-link" href="/gioi-thieu">Giới Thiệu</a>
                    </li>
                </ul>
                <div class="menu-div-2 ">
                  <div class="d-flex">

                      <li class="nav-item dropdown">
                          <a class="nav-link" href="/gio-hang" role="button">
                              <i class="fas fa-shopping-cart" style="color: #ffffff;"></i>
                          </a>
                      </li>
                      <li class="nav-item dropdown">
                          <a class="nav-link mb-4 ms-4 " href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                              <i class="fas fa-user" style="color: #ffffff;"></i>
                          </a>
                          <ul class="dropdown-menu">
                              <c:choose>
                                  <c:when test="${not empty sessionScope.khachHang}">
                                      <li><a class="dropdown-item" href="/hoa-don">Đơn hàng của tôi</a></li>
                                      <li><a class="dropdown-item" href="/dang-xuat">Đăng xuất</a></li>
                                  </c:when>
                                  <c:otherwise>
                                      <li><a class="dropdown-item" href="/dang-nhap">Đăng nhập</a></li>
                                  </c:otherwise>
                              </c:choose>
                          </ul>
                      </li>
                  </div>
                </div>
            </div>
        </div>
    </nav>
    <!-- Carousel -->
    <jsp:include page="${ viewBanner }"/>
</header>
<!-- Content -->
<main>
    <!-- content -->
    <jsp:include page="${ viewContent }"/>
</main>
<footer>
    <div class="container mt-5">
        <div class="row pt-4">
            <div class="col-md-3 col-12 ">
                <div class="d-flex mb-2">
                    <i class="fas fa-caret-down fa-rotate-270"></i>
                    <div class="text-sm ">
                        <a href="/chinh-sach-bao-mat" class="text-decoration-none text-dark">Chính sách bảo mật</a>
                    </div>
                </div>
<%--                <div class="d-flex mb-2">--%>
<%--                    <i class="fas fa-caret-down fa-rotate-270"></i>--%>
<%--                    <div class="text-sm">--%>
<%--                        <a href="/chinh-sach-doi-tra" class="text-decoration-none text-dark">Chính sách đổi trả</a>--%>
<%--                    </div>--%>
<%--                </div>--%>
            </div>
            <div class="col-md-5 col-12">
                <div class="d-flex mb-2">
                    <div class="text-sm font-weight-bold mr-1">Địa chỉ: </div>
                    <div class="text-sm flex-fill"> Tiền Yên -Hoài Đức- Hà Nội</div>
                </div>
                <div class="d-flex mb-2">
                    <div class="text-sm font-weight-bold mr-1">Hotline:</div>
                    <div class="text-sm"> 038-334-9871</div>
                </div>
            </div>
            <div class="col-md-4 col-12">
                <div class="d-flex">
                    <div class="text-sm">Theo dõi chúng tôi trên mạng xã hội</div>
                </div>
                <div class="d-flex mt-3">
                    <a href="https://www.facebook.com/profile.php?id=100035163965914" class="text-decoration-none text-dark">
                        <i class="fab fa-facebook-f fa-lg"></i>
                    </a>
                    <a href="https://www.facebook.com/profile.php?id=100035163965914" class="ms-4 text-dark">
                        <i class="fab fa-instagram fa-lg"></i>
                    </a>
                </div>
            </div>
        </div>

    </div>
    <hr>
    <div class="row col-4 offset-5 pb-3">
        <p> © 2024 Sport65 . Đã đăng ký Bản quyền</p>
    </div>
</footer>
<!-- Include Bootstrap JS and jQuery (if needed) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>

</html>