<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="container pt-5">
    <style>
        .discount-percentage {
            position: absolute; /* Vị trí tuyệt đối */
            top: 0; /* Đặt ở đỉnh */
            left: 0; /* Đặt ở bên trái */
            background-color: red; /* Màu nền đỏ */
            color: white; /* Màu chữ trắng */
            padding: 5px; /* Khoảng cách nội dung từ viền */
            font-weight: bold; /* In đậm */
        }
    </style>

    <div class="float-end mt-3">
        <select id="sort" class=" form-select" aria-label="Default select example">
            <option selected>Sắp xếp theo</option>
            <option value="1">Giá: thấp đến cao</option>
            <option value="2">Giá: cao đến thấp</option>
        </select>
        <script>
            document.getElementById("sort").onchange = function () {
                var selectedValue = this.value; // Lấy giá trị được chọn trong thẻ select
                // Chuyển hướng đến liên kết tương ứng với giá trị đã chọn
                if (selectedValue === "1") {
                    window.location.href = "/sale?sort=asc";
                } else if (selectedValue === "2") {
                    window.location.href = "/sale?sort=desc";
                }
            };
        </script>
    </div>
    <div class="product px-5 mt-5">
        <!-- repeat -->
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
            <!-- Sử dụng col-lg-3 để hiển thị 4 sản phẩm trong mỗi hàng và làm cho sản phẩm lớn hơn -->
            <c:forEach items="${listSanPham}" var="sanPham">
                <div class="col">
                    <a href="/san-pham/${sanPham.id}/${sanPham.idMauSac}" class="text-decoration-none text-dark">
                        <div class="card border-0">
                            <img src="${sanPham.anh}" class="card-img-top" alt="${sanPham.ten}"style="width: 19rem; height: 19rem;">
                            <span class="discount-percentage" id="so-phan-tram-giam_${sanPham.id}"></span>
                            <div class="card-body text-center">
                                <p class="text-uppercase">${sanPham.ten}</p>
                                <p class="fw-bold gia-san-pham" id="gia-san-pham_${sanPham.id}">${sanPham.gia}</p>
                                <script>
                                    var giaSanPhamElement = document.getElementById("gia-san-pham_${sanPham.id}");
                                    var giaSanPhamText = giaSanPhamElement.innerText;
                                    var formattedGia = parseInt(giaSanPhamText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                                    giaSanPhamElement.innerText = formattedGia + " vnđ";
                                </script>
                                <p class="fw-bold gia-moi" id="gia-moi_${sanPham.id}"></p>
                            </div>
                        </div>
                    </a>
                </div>
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <script>
                    $(document).ready(function () {
                        var idSanPham = '${sanPham.id}';
                        $.ajax({
                            url: "/so-phan-tram-giam/" + idSanPham,
                            method: "GET",
                            success: function (data) {
                                var span = $("#so-phan-tram-giam_" + idSanPham);
                                var giaSpan = $("#gia-san-pham_" + idSanPham);
                                var giaCu = giaSpan.html();

                                if (data != null) {
                                    // nếu tồn tại khuyến mãi thì mới hiển thị thẻ span
                                    if (data > 0) {
                                        span.show();
                                        span.html(data + "% off");
                                    } else {
                                        span.hide();
                                    }
                                    // Tính giá sản phẩm sau khi giảm và hiển thị nó
                                    var giaSanPham = ${sanPham.gia};
                                    var soPhanTramGiam = data;
                                    var giaSauGiam = giaSanPham - (giaSanPham * soPhanTramGiam / 100);
                                    giaSauGiam = Math.floor(giaSauGiam);
                                    giaSpan.hide();
                                    if (data > 0) {
                                        giaSpan.after('<p class="fw-bold gia-moi">' + giaSauGiam.toLocaleString('en-US') + ' vnđ</p>');
                                        giaSpan.after('<p class="fw-bold gia-cu " style="text-decoration: line-through;">' + giaCu + '</p>');
                                    } else {
                                        giaSpan.show();
                                    }
                                }
                            },
                            error: function () {
                                // Xử lý lỗi nếu có
                            }
                        });
                    });
                </script>

            </c:forEach>
        </div>
    </div>

    <h5 class="text-center">Bạn đã xem hết!</h5>

</section>