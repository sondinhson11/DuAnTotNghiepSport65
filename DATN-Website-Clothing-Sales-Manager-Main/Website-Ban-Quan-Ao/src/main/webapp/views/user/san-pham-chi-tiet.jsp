<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style>
    .carousel-item img {
        max-height: 300px; /* Điều chỉnh kích thước tối đa của ảnh */
        width: auto; /* Để ảnh tự động điều chỉnh chiều rộng */
    }

</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<div class="container pt-3">
    <div class="row">
        <section class="col-lg-6">
            <div class="row mb-3">
                <div>
                    <div id="carouselExampleIndicators" class="carousel slide">
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0"
                                    class="active" aria-current="true" aria-label="Slide 1"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
                                    aria-label="Slide 2"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"
                                    aria-label="Slide 3"></button>
                        </div>
                        <div class="carousel-inner">
                            <c:forEach items="${listAnh}" var="hinhAnh" varStatus="loop">
                                <c:if test="${loop.index == 0}">
                                    <div class="carousel-item active">
                                        <img src="${hinhAnh.duongDan}" class="d-block w-100" alt="...">
                                    </div>
                                </c:if>
                                <c:if test="${loop.index != 0}">
                                    <div class="carousel-item">
                                        <img src="${hinhAnh.duongDan}" class="d-block w-100" alt="...">
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"
                                data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"
                                data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>
            </div>
        </section>
        <section class="col-lg-6">
            <div class="col-lg-12">
                <h3 class="fw-bold text-uppercase">${sanPham.ten}</h3>
            </div>
            <div class="justify-content-between mt-4">
                <div>
                    <h5 class="fw-bold gia-cu" id="gia-san-pham">${sanPham.gia}</h5>
                    <script>
                        var giaSanPhamElement = document.getElementById("gia-san-pham");
                        var giaSanPhamText = giaSanPhamElement.innerText;
                        var formattedGia = parseInt(giaSanPhamText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                        giaSanPhamElement.innerHTML = '<span style="color: red;">' + formattedGia + ' vnđ</span>';
                    </script>
                    <h5 class="fw-bold gia-moi" id="gia-moi"></h5>
                </div>
                <script>
                    $(document).ready(function () {
                        var idSanPham = '${sanPham.id}';
                        $.ajax({
                            url: "/so-phan-tram-giam/" + idSanPham,
                            method: "GET",
                            success: function (data) {
                                var giaSpan = $("#gia-san-pham");
                                var giaCu = giaSpan.html();

                                if (data != null) {
                                    var giaSanPham = ${sanPham.gia};
                                    var soPhanTramGiam = data;
                                    var giaSauGiam = giaSanPham - (giaSanPham * soPhanTramGiam / 100);
                                    giaSauGiam = Math.floor(giaSauGiam);
                                    giaSpan.hide();
                                    if (data > 0) {
                                        giaSpan.after('<h5 class="fw-bold gia-moi">' + giaSauGiam.toLocaleString('en-US') + ' vnđ</h5>');
                                        giaSpan.after('<h5 class="fw-bold gia-cu " style="text-decoration: line-through;">' + giaCu + '</h5>');
                                    } else {
                                        giaSpan.show();
                                    }
                                }
                            },
                            error: function () {
                            }
                        });
                    });
                </script>

            </div>

            <hr/>
            <div class="input-group pt-2">
                <h6 class="me-2" id="product-name">Mô tả</h6>
            </div>
            <div class="content" id="content-mota">
                <div class="mota-desc">
                    <p>${sanPham.moTa}</p>
                </div>
            </div>
            <hr/>
            <form:form modelAttribute="gioHang" action="/gio-hang/${sanPham.id}" method="post">
                <div class="mt-3 row">
                    <div class="col-3">
                        <div class="title">
                            <p>Màu sắc:</p>
                        </div>
                        <form:select path="idMauSac" class="form-select w-75" aria-label="Color Select"
                                     id="mauSacSelect">
                            <c:forEach items="${listMauSac}" var="mauSac">
                                <option value="${mauSac.id}" ${mauSac.id == idMauSac ? "selected" : ""}>${mauSac.ten}</option>
                            </c:forEach>
                        </form:select>

                        <script>
                            // Lấy thẻ select
                            var selectElement = document.getElementById("mauSacSelect");

                            // Thêm sự kiện onchange để theo dõi khi người dùng thay đổi giá trị
                            selectElement.addEventListener("change", function () {
                                // Lấy giá trị value của select
                                var selectedValue = selectElement.value;

                                // Cập nhật đường link với giá trị mới
                                var newURL = "http://localhost:8080/san-pham/${sanPham.id}/" + selectedValue;

                                // Tải lại trang với đường link mới
                                window.location.href = newURL;
                            });
                        </script>
                    </div>

                    <div class="col-3">
                        <div class="title">
                            <p>Kích cỡ:</p>
                        </div>
                        <form:select path="idKichCo" class="form-select w-75" aria-label="Size Select"
                                     id="kichCoSelect">
                            <option selected>Chọn</option>
                            <c:forEach items="${listKichCo}" var="kichCo">
                                <option value="${kichCo.id}">${kichCo.ten}</option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="col-3">
                        <div class="quantity">
                            <div class="title">
                                <p>Số lượng:</p>
                            </div>
                            <div class="input-group">
                                <button class="btn btn-outline-dark" type="button"
                                        onclick="decrement()">-
                                </button>
                                <form:input path="soLuong" type="number" class="form-control text-center w-50"
                                            id="quantity" name="quantity"
                                            value="1" min="1" readonly="true"/>
                                <button class="btn btn-outline-dark" type="button"
                                        onclick="increment()">+
                                </button>
                            </div>
                            <script>
                                function decrement() {
                                    var quantityInput = document.getElementById("quantity");
                                    var currentValue = parseInt(quantityInput.value);
                                    var max = parseInt(quantityInput.getAttribute('max'));
                                    if (currentValue > 1) {
                                        quantityInput.value = currentValue - 1;
                                    }
                                }

                                function increment() {
                                    var quantityInput = document.getElementById("quantity");
                                    var currentValue = parseInt(quantityInput.value);
                                    var max = parseInt(quantityInput.getAttribute('max'));
                                    if (currentValue < max) {
                                        quantityInput.value = currentValue + 1;
                                    }
                                }

                            </script>
                        </div>
                    </div>
                    <div id="soLuongSanPham" class="mt-3"></div>

                    <script>
                        const mauSacSelect = document.getElementById('mauSacSelect');
                        const kichCoSelect = document.getElementById('kichCoSelect');
                        const soLuongSanPhamDiv = document.getElementById('soLuongSanPham');

                        mauSacSelect.addEventListener('change', fetchData);
                        kichCoSelect.addEventListener('change', fetchData);

                        function fetchData() {
                            const idMauSac = mauSacSelect.value;
                            const idKichCo = kichCoSelect.value;

                            fetch(`/so-luong-san-pham/${sanPham.id}/` + idMauSac + `/` + idKichCo)
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error('Network response was not ok');
                                    }
                                    return response.json();
                                })
                                .then(data => {
                                    soLuongSanPhamDiv.innerText = `Số lượng sản phẩm: ` + data;
                                    const quantityInput = document.getElementById('quantity');
                                    quantityInput.setAttribute('max', data);

                                    quantityInput.value = 1;
                                })
                                .catch(error => {
                                    console.error('There was a problem with the fetch operation:', error);
                                });
                        }

                    </script>
                </div>

                <div class="mt-5">
                    <div class="justify-content-between">
                        <c:if test="${khachHang != null}">
                            <button type="submit" id="btnThemVaoGioHang"
                                    class="btn btn-outline-dark btn-lg">Thêm vào giỏ hàng
                            </button>
                            <p class="text-danger ms-3 mt-2" id="textKichCo" style="display: none">Bạn cần chọn kích
                                cỡ</p>
                            <p class="text-danger ms-3 mt-2" id="textMauSac" style="display: none">Bạn cần chọn màu
                                sắc</p>
                        </c:if>
                        <c:if test="${khachHang == null}">
                            <a href="/dang-nhap" class="btn btn-outline-dark btn-lg">Bạn cần đăng nhập để mua hàng</a>
                        </c:if>
                    </div>
                </div>
            </form:form>
        </section>

    </div>

</div>
<script>
    // nếu khi ấn nút thêm vào giỏ hàng mà chưa chọn kích cỡ thì yêu cầu chọn kích cỡ
    $(document).ready(function () {
        $("#btnThemVaoGioHang").click(function () {
            var kichCo = $("#kichCoSelect").val();
            if (kichCo == "Chọn") {
                $("#textKichCo").show();
                return false;
            }
        });
    });
    //    nếu đã chọn kích cỡ thì ẩn thông báo
    $(document).ready(function () {
        $("#kichCoSelect").change(function () {
            $("#textKichCo").hide();
        });
    });
    // không cho phép click vào option "chọn" ở màu sắc. disable option "chọn" ở màu sắc, không được phép chọn
    $(document).ready(function () {
        $("#mauSacSelect").change(function () {
            $("#mauSacSelect option[value='']").attr("disabled", "disabled");
        });
    });


</script>

