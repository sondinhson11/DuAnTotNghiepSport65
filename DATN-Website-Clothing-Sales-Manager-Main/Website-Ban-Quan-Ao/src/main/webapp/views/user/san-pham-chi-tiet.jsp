<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style>
    .carousel-item img {
        max-height: 300px;
        width: auto;
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
                    <div class="col">
                        <div class="title">
                            <p>Màu sắc:</p>
                        </div>
                        <div id="mauSacSelect">
                            <c:forEach items="${listMauSac}" var="mauSac">
                                <input class="btn-check" type="radio" id="mauSac${mauSac.id}" name="idMauSac" value="${mauSac.id}" ${mauSac.id == idMauSac ? "checked" : ""}>
                                <label class="btn btn-outline-secondary d-inline-block me-2 mb-2" for="mauSac${mauSac.id}">
                                        ${mauSac.ten}
                                </label>
                            </c:forEach>
                        </div>


                        <script>
                            const checkboxes = document.querySelectorAll('input[name="idMauSac"]');
                            checkboxes.forEach((checkbox) => {
                                checkbox.addEventListener('change', function () {
                                    const selectedValues = [...document.querySelectorAll('input[name="idMauSac"]:checked')].map(cb => cb.value);
                                    const newURL = "http://localhost:8080/san-pham/${sanPham.id}/" + selectedValues.join("/");
                                    window.location.href = newURL;
                                });
                            });
                        </script>
                    </div>

                    <div class="col"  >
                        <div class="title">
                            <p>Kích cỡ:</p>
                        </div>
                            <div class="col">
                                <div class="form-check">
                                    <c:forEach items="${listKichCo}" var="kichCo">
                                        <input class="btn-check" type="radio" name="idKichCo" id="kichCo${kichCo.id}" value="${kichCo.id}">
                                        <label class="btn btn-outline-secondary d-inline-block me-2 mb-2"  for="kichCo${kichCo.id}">
                                                ${kichCo.ten}
                                        </label>
                                    </c:forEach>
                                </div>
                                <p class="text-danger ms-3 mt-2" id="textKichCo" style="display: none">Bạn cần chọn kích cỡ</p>

                            </div>
                    </div>


                    <div class="col-4">
                        <div class="quantity">
                            <div class="title">
                                <p>Số lượng:</p>
                            </div>
                            <div class="input-group d-flex align-items-center">
                                <button class="btn btn-outline-dark me-2" type="button" onclick="decrement()">-</button>
                                <form:input path="soLuong" type="text" class="form-control text-center w-35"
                                            id="quantity" name="quantity" value="1" min="1"/>
                                <button class="btn btn-outline-dark ms-2" type="button" onclick="increment()">+</button>
                            </div>
                        </div>
                    </div>

                    <script>
                        // Function to decrement the quantity
                        function decrement() {
                            var quantityInput = document.getElementById("quantity");
                            var currentValue = parseInt(quantityInput.value) || 0; // Default to 0 if input is not a number
                            if (currentValue > 1) { // Ensure the quantity doesn't go below 1
                                quantityInput.value = currentValue - 1;
                            }
                        }

                        // Function to increment the quantity
                        function increment() {
                            var quantityInput = document.getElementById("quantity");
                            var currentValue = parseInt(quantityInput.value) || 0; // Default to 0 if input is not a number
                            var max = parseInt(quantityInput.getAttribute('max')); // Get the max value allowed
                            if (!isNaN(max) && currentValue < max) { // Only increment if current value is less than max
                                quantityInput.value = currentValue + 1;
                            } else if (isNaN(max)) { // If max is not defined, allow unlimited increment
                                quantityInput.value = currentValue + 1;
                            }
                        }

                        // Function to validate and correct the quantity input
                        function validateQuantity() {
                            var quantityInput = document.getElementById("quantity");
                            var value = parseInt(quantityInput.value) || 0; // Default to 0 if input is not a number
                            var min = parseInt(quantityInput.getAttribute('min')) || 1; // Default to 1 if min is not set
                            var max = parseInt(quantityInput.getAttribute('max')); // Get the max value allowed

                            // Correct the value if it's out of bounds
                            if (value < min) {
                                quantityInput.value = min;
                            } else if (!isNaN(max) && value > max) {
                                quantityInput.value = max;
                            } else {
                                quantityInput.value = value;
                            }
                        }

                        // Add event listener to validate quantity on input change
                        document.getElementById("quantity").addEventListener("input", validateQuantity);
                    </script>

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


    <script>
        $(document).ready(function () {
            // Kiểm tra khi người dùng nhấn nút "Thêm vào giỏ hàng"
            $("#btnThemVaoGioHang").click(function (e) {
                // Kiểm tra nếu không có nút radio nào cho kích cỡ được chọn
                var kichCoChecked = $('input[name="idKichCo"]:checked').length > 0;

                if (!kichCoChecked) {
                    $("#textKichCo").show();
                    e.preventDefault();
                }
            });

            // Ẩn thông báo cảnh báo khi kích cỡ được chọn
            $('input[name="idKichCo"]').change(function () {
                $("#textKichCo").hide();
            });
            
            $("#mauSacSelect").change(function () {
                $("#mauSacSelect option[value='']").attr("disabled", "disabled");
            });
        });
    </script>

</div>