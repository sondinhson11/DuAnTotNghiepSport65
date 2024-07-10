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
<div class="container">
    <div class="p-4">
        <div class="row row-cols-1 row-cols-lg-2 g-4">
            <div class="col">
                <img src="https://placehold.co/400x600?text=Product+Image" alt="Product Image" class="img-fluid rounded-lg shadow" />
                <div class="d-flex mt-4 gap-2">
                    <img src="https://placehold.co/80x80?text=Image1" alt="Thumbnail 1" class="img-thumbnail" />
                    <img src="https://placehold.co/80x80?text=Image2" alt="Thumbnail 2" class="img-thumbnail" />
                    <img src="https://placehold.co/80x80?text=Image3" alt="Thumbnail 3" class="img-thumbnail" />
                    <img src="https://placehold.co/80x80?text=Image4" alt="Thumbnail 4" class="img-thumbnail" />
                    <img src="https://placehold.co/80x80?text=Image5" alt="Thumbnail 5" class="img-thumbnail" />
                </div>
            </div>

            <div class="col">
                <h1 class="h2">${sanPham.ten}</h1>
                <p class="text-muted">Mã sản phẩm: FABK00101CT00SB_DBU-29 | Tình trạng: <span class="text-danger">Hết hàng</span> | Thương hiệu: TORANO</p>

                <div class="mt-4 p-4 bg-light rounded-lg shadow-sm">
                    <div class="d-flex justify-content-between align-items-center flex-wrap">
                        <span class="h4">Giá:</span>
                        <div class="text-end d-flex align-items-center">
                            <span class="text-danger fw-bold fs-4" id="gia-moi"></span>
                            <span id="gia-san-pham">${sanPham.gia}</span>
                            <div class="bg-danger text-white fw-bold py-05 px-2 rounded-pill ms-3" id="so-phan-tram-giam_${sanPham.id}" style="font-size: 14px; display: none;"></div>
                        </div>
                    </div>
                </div>

                <script>
                    document.addEventListener("DOMContentLoaded", function() {
                        var giaSanPhamElement = document.getElementById("gia-san-pham");
                        var giaSanPhamText = giaSanPhamElement.innerText;
                        var formattedGia = parseInt(giaSanPhamText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                        giaSanPhamElement.innerHTML = '<span style="color: #212529bf; margin-left: 10px">' + formattedGia + 'đ</span>';

                        var idSanPham = '${sanPham.id}';
                        fetch(`/so-phan-tram-giam/${idSanPham}`)
                            .then(response => response.json())
                            .then(data => {
                                if (data != null && data > 0) {
                                    var giaSanPham = ${sanPham.gia};
                                    var giaSauGiam = Math.floor(giaSanPham - (giaSanPham * data / 100));

                                    var giaMoiElement = document.getElementById("gia-moi");
                                    giaMoiElement.innerText = giaSauGiam.toLocaleString('en-US') + 'đ';
                                    giaMoiElement.style.color = "red";  // Set new price color

                                    giaSanPhamElement.classList.add("text-decoration-line-through", "text-muted");

                                    var discountElement = document.getElementById("so-phan-tram-giam_${sanPham.id}");
                                    discountElement.innerText = data + "%";
                                    discountElement.style.display = "inline-block";
                                } else {
                                    var giaMoiElement = document.getElementById("gia-moi");
                                    giaMoiElement.innerText = formattedGia + 'đ';
                                    giaMoiElement.style.color = "#ff2c26";  // Set new price color
                                    giaSanPhamElement.style.display = "none";
                                }
                            })
                            .catch(error => console.error('Error:', error));
                    });
                </script>




                <form:form modelAttribute="gioHang" action="/gio-hang/${sanPham.id}" method="post">
                    <div class="mt-4">
                        <span class="fw-bold">Màu sắc:</span>
                        <div class="d-flex flex-wrap gap-2 mt-2">
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


                        <div class="mt-4">
                            <span class="fw-bold">Kích cỡ:</span>

                            <div class="d-flex flex-wrap gap-2 mt-2">
                                <c:forEach items="${listKichCo}" var="kichCo">
                                    <input class="btn-check" type="radio" name="idKichCo" id="kichCo${kichCo.id}" value="${kichCo.id}">
                                    <label class="btn btn-outline-secondary d-inline-block me-2 mb-2"  for="kichCo${kichCo.id}">
                                            ${kichCo.ten}
                                    </label>
                                </c:forEach>
                            </div>
                            <div>
                                <p class="text-danger ms-3 mt-2" id="textKichCo" style="display: none">Bạn cần chọn kích cỡ</p>
                                <a href="#" class="text-primary text-decoration-none mt-2 d-block">Hướng dẫn chọn size</a>
                            </div>

                        </div>



                        <div class="mt-4">
                            <div class="quantity">
                                <span class="fw-bold">Số lượng:</span>
                                <div class="d-flex align-items-center mt-2">
                                    <button class="btn btn-outline-secondary d-inline-block me-2 mb-2" onclick="decrement(event)">-</button>
                                    <form:input path="soLuong" id="quantity" type="text" value="1" min="1"  max="100" class="form-control text-center border-top-0 border-bottom-0" style="width: 80px;" />
                                    <button class="btn btn-outline-secondary d-inline-block me-2 mb-2" onclick="increment(event)">+</button>
                                </div>
                                <script>
                                    function decrement(event) {
                                        event.preventDefault();
                                        var quantityInput = document.getElementById("quantity");
                                        var currentValue = parseInt(quantityInput.value);
                                        if (currentValue > 1) {
                                            quantityInput.value = currentValue - 1;
                                        }
                                    }

                                    function increment(event) {
                                        event.preventDefault();
                                        var kichCoSelected = $("input[name='idKichCo']:checked").length > 0;
                                        if (!kichCoSelected) {
                                            $("#textKichCo").show();
                                            return;
                                        }
                                        $("#textKichCo").hide();
                                        var quantityInput = document.getElementById("quantity");
                                        var currentValue = parseInt(quantityInput.value);
                                        var max = parseInt(quantityInput.getAttribute('max'));
                                        if (currentValue < max) {
                                            quantityInput.value = currentValue + 1;
                                        }
                                    }
                                </script>
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

                    </div>
                    <div class="mt-4 d-flex gap-3">
                        <c:if test="${khachHang != null}">
                            <button class="btn btn-secondary flex-grow-1" type="submit" id="btnThemVaoGioHang">THÊM VÀO GIỎ</button>
                            <p class="text-danger ms-3 mt-2" id="textKichCo" style="display: none">Bạn cần chọn kích
                                cỡ</p>
                            <p class="text-danger ms-3 mt-2" id="textMauSac" style="display: none">Bạn cần chọn màu
                                sắc</p>
                        </c:if>
                    </div>

                    <div class="mt-4">
                        <c:if test="${khachHang == null}">
                            <button class="btn btn-danger flex-grow-1 w-100">BẠN CẦN ĐĂNG NHẬP ĐỂ MUA HÀNG</button>
                        </c:if>
                    </div>
                </form:form>
                <div class="mt-4 d-flex align-items-center gap-2 text-muted">
                    <a href="#" class="text-primary"><img src="https://openui.fly.dev/openui/24x24.svg?text=S" alt="Facebook" /></a>
                    <a href="#" class="text-primary"><img src="https://openui.fly.dev/openui/24x24.svg?text=P" alt="Messenger" /></a>
                    <a href="#" class="text-primary"><img src="https://openui.fly.dev/openui/24x24.svg?text=O" alt="Twitter" /></a>
                    <a href="#" class="text-danger"><img src="https://openui.fly.dev/openui/24x24.svg?text=R" alt="Pinterest" /></a>
                    <a href="#" class="text-primary"><img src="https://openui.fly.dev/openui/24x24.svg?text=T" alt="Email" /></a>
                    <a href="#" class="text-primary"><img src="https://openui.fly.dev/openui/24x24.svg?text=6" alt="Email" /></a>
                    <a href="#" class="text-primary"><img src="https://openui.fly.dev/openui/24x24.svg?text=5" /></a>
                </div>

                <div class="mt-4 d-flex gap-2 text-muted">
                    <div class="d-flex align-items-center gap-2">
                        <img src="https://openui.fly.dev/openui/24x24.svg?text=🔒" alt="Secure Payment" />
                        <span>Hàng phân phối chính hãng 100%</span>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <img src="https://openui.fly.dev/openui/24x24.svg?text=📞" alt="Customer Support" />
                        <span>TỔNG ĐÀI 24/7 : 0383349871</span>
                    </div>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                // Handle the 'Add to Cart' button click
                $("#btnThemVaoGioHang").click(function (event) {
                    // Check if a size is selected
                    var kichCoSelected = $("input[name='idKichCo']:checked").length > 0;
                    var mauSacSelected = $("input[name='idMauSac']:checked").length > 0;

                    if (!kichCoSelected || !mauSacSelected) {
                        // Prevent form submission
                        event.preventDefault();

                        // Show appropriate error messages
                        if (!kichCoSelected) {
                            $("#textKichCo").show();
                        } else {
                            $("#textKichCo").hide();
                        }

                        if (!mauSacSelected) {
                            $("#textMauSac").show();
                        } else {
                            $("#textMauSac").hide();
                        }
                    }
                });

                // Hide error messages when a size or color is selected
                $("input[name='idKichCo']").change(function () {
                    $("#textKichCo").hide();
                });

                $("input[name='idMauSac']").change(function () {
                    $("#textMauSac").hide();
                });

                // Disable the "Chọn" option for color
                $("#mauSacSelect input[value='']").attr("disabled", "disabled");
            });
        </script>
    </div>
</div>
