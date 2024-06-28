<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container">
    <h1 class="text-center mt-3">Quản Lý Nhân Viên </h1>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
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
                                    <label for="tinhThanhPho" class="form-label">Tỉnh/Thành phố</label>
                                    <select id="provinceSelect" class="form-select">
                                        <option value="" disabled selected>Chọn tỉnh/thành phố</option>
                                    </select>
                                    <form:input type="hidden" path="tinhThanhPho" id="provinceName" class="form-control" />
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="quanHuyen" class="form-label">Quận/Huyện</label>
                                    <select id="districtSelect" class="form-select">
                                        <option value="" disabled selected>Chọn quận/huyện</option>
                                    </select>
                                    <form:input type="hidden" path="quanHuyen" id="districtName" class="form-control"/>
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
                                    <select id="wardSelect" class="form-select">
                                        <option value="" disabled selected>Chọn phường/xã</option>
                                    </select>
                                    <form:input type="hidden" path="xaPhuong" id="wardName" class="form-control"/>
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
    $(document).ready(function () {
        // Biến kiểm tra trạng thái đã chọn
        var isDistrictSelected = false;
        var isWardSelected = false;
        var isServiceSelected = false;
        // Gọi API để lấy dữ liệu tỉnh/thành phố
        $.ajax({
            url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/province',
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
            },
            success: function (data) {
                if (data.code === 200) {
                    const select = document.getElementById('provinceSelect');
                    const input = document.getElementById('provinceName'); // Get the input element

                    data.data.forEach(province => {
                        const option = document.createElement('option');
                        option.value = province.ProvinceID;
                        option.text = province.ProvinceName;
                        select.appendChild(option);
                    });

                    // Set province name in the input field when a province is selected
                    $('#provinceSelect').change(function () {
                        const selectedProvinceName = $('#provinceSelect option:selected').text();
                        input.value = selectedProvinceName; // Set the value of the input field
                    });
                }
            },
            error: function (error) {
                console.error(error);
            }
        });

        // Gọi API để lấy dữ liệu quận/huyện khi thay đổi tỉnh/thành phố
        $('#provinceSelect').change(function () {
            isDistrictSelected = false; // Đặt lại trạng thái khi thay đổi tỉnh/thành phố
            isWardSelected = false; // Đặt lại trạng thái khi thay đổi tỉnh/thành phố

            const provinceID = $(this).val();
            $.ajax({
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/district',
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                },
                data: {
                    province_id: provinceID
                },
                success: function (data) {
                    if (data.code === 200) {
                        const select = document.getElementById('districtSelect');
                        const input = document.getElementById('districtName');
                        select.innerHTML = '';
                        data.data.forEach(district => {
                            const option = document.createElement('option');
                            option.value = district.DistrictID;
                            option.text = district.DistrictName;
                            select.appendChild(option);
                        });
                        $('#districtSelect').change(function () {
                            const selectedDistrictName = $('#districtSelect option:selected').text();
                            input.value = selectedDistrictName; // Set the value of the input field
                        });
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });
        });

        // Gọi API để lấy dữ liệu phường/xã khi thay đổi quận/huyện
        $('#districtSelect').change(function () {
            isDistrictSelected = true; // Đánh dấu trạng thái khi đã chọn quận/huyện
            isWardSelected = false; // Đặt lại trạng thái khi thay đổi quận/huyện

            const districtID = $(this).val();
            $.ajax({
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=' + districtID,
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                },
                data: {
                    district_id: districtID
                },
                success: function (data) {
                    if (data.code === 200) {
                        const select = document.getElementById('wardSelect');
                        const input = document.getElementById('wardName');
                        select.innerHTML = '';
                        data.data.forEach(ward => {
                            const option = document.createElement('option');
                            option.value = ward.WardCode;
                            option.text = ward.WardName;
                            select.appendChild(option);
                        })
                        $('#wardSelect').change(function () {
                            const selectedWardName = $('#wardSelect option:selected').text();
                            input.value = selectedWardName; // Set the value of the input field
                        });
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });
        });


        // tính tiền
        $(document).ready(function () {
            var selectElement = $("#hinh-thuc-thanh-toan");
            var tienKhachDuaInput = $("#tien-khach-dua");
            var tongTienInput = $("#tong-tien"); // Lấy ô input của tổng tiền
            var tienThuaLabel = $("#tien-thua");


            // Sự kiện change cho hình thức thanh toán
            selectElement.on("change", function () {
                updateTienKhachDua(); // Cập nhật tiền khách đưa khi thay đổi hình thức thanh toán
            });

            // Sự kiện blur cho tiền khách đưa
            tienKhachDuaInput.on("blur", function () {
                updateTienThua(); // Cập nhật tiền thừa khi blur khỏi trường tiền khách đưa
            });

            // Sự kiện khi thay đổi giá trị phí vận chuyển
            $('#feeInput, #tong-tien').on('input', function () {
                formatCurrency(this);
                updateTotal(); // Cập nhật tổng tiền khi giá trị phí vận chuyển hoặc tổng tiền thay đổi
            });

            // Sự kiện input để ngăn chặn việc nhập chữ trong trường tiền khách đưa
            tienKhachDuaInput.on("input", function () {
                formatCurrency(this); // Gọi hàm formatCurrency để giữ lại chỉ số và dấu phẩy
            });

            function formatCurrency(input) {
                // Giữ lại chỉ các ký tự số và dấu phẩy
                let inputValue = input.value.replace(/[^\d,]/g, '');

                // Định dạng lại giá trị
                inputValue = inputValue.replace(/,/g, '');

                // Gán giá trị đã định dạng lại vào trường input
                input.value = inputValue.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }

            function updateTotal() {
                // Use jQuery to get the value of the feeInput
                let feeInput = $('#feeInput');

                // Giữ lại chỉ các ký tự số và dấu phẩy
                let phiVanChuyen = parseFloat(feeInput.val().replace(/,/g, '')) || 0;

                // Lấy giá trị tổng tiền từ JSP
                let tongTien = parseFloat('${tongTien}') || 0;

                // Thêm phí vận chuyển vào tổng tiền
                tongTien += phiVanChuyen;

                // Định dạng lại tổng tiền và hiển thị trên giao diện
                let formattedTongTien = tongTien.toLocaleString('en-US');
                tongTienInput.val(formattedTongTien);

                // Gán giá trị phiVanChuyen cho trường phiVanChuyen ẩn để submit lên server
                feeInput.val(phiVanChuyen);
            }

            function updateTienKhachDua() {
                var hinhThucThanhToan = selectElement.val();
                var tongTien = parseFloat(tongTienInput.val());

                if (hinhThucThanhToan === "2" || hinhThucThanhToan === "3") {
                    tienKhachDuaInput.val(tongTien.toLocaleString('en-US'));
                } else {
                    tienKhachDuaInput.val("");
                }
            }

            function updateTienThua() {
                var tienKhachDua = parseFloat(tienKhachDuaInput.val().replace(/[^\d]/g, '')) || 0;
                var tongTien = parseFloat(tongTienInput.val());

                if (tienKhachDua >= tongTien) {
                    var tienThua = tienKhachDua - tongTien;
                    tienThuaLabel.text(tienThua.toLocaleString('en-US'));
                } else {
                    tienThuaLabel.text("0");
                    alert("Tiền khách đưa phải lớn hơn hoặc bằng tổng tiền!");
                }
            }
        });
        <%--// api vietqr--%>
        <%--$(document).ready(function () {--%>
        <%--    var clientId = '01d6d8e1-f32f-49c2-b2ed-569c35d2d407';--%>
        <%--    var apiKey = 'd662918e-19bd-4947-8ddd-fb8a1474dfe0';--%>
        <%--    var apiUrl = 'https://api.vietqr.io/v2/generate';--%>

        <%--    // Sự kiện change trên phần tử select--%>
        <%--    $('#hinh-thuc-thanh-toan').on('change', function () {--%>
        <%--        var selectedValue = $(this).val();--%>

        <%--        // Kiểm tra giá trị được chọn và hiển thị modal tương ứng--%>
        <%--        if (selectedValue === '1') {--%>
        <%--            // Tiền mặt - không hiển thị modal--%>
        <%--            // Có thể ẩn modal nếu nó đang hiển thị--%>
        <%--            $('#qrCodeModal').modal('hide');--%>
        <%--        } else if (selectedValue === '2') {--%>
        <%--            // Chuyển khoản - hiển thị modal và gửi yêu cầu API--%>
        <%--            $('#qrCodeModal').modal('show');--%>
        <%--            sendApiRequest();--%>
        <%--        }--%>
        <%--    });--%>

        <%--    function sendApiRequest() {--%>
        <%--        // Dữ liệu để gửi lên API--%>
        <%--        let tongTien = parseFloat('${tongTien}') || 0;--%>
        <%--        const maHoaDon = '${hoaDon.ma}';--%>
        <%--        var requestData = {--%>
        <%--            "accountNo": "0866613082003",--%>
        <%--            "accountName": "PHAM LE QUYEN ANH",--%>
        <%--            "acqId": "970422",--%>
        <%--            "addInfo": "Thanh toan hoa don " + maHoaDon,--%>
        <%--            "amount": tongTien,--%>
        <%--            "template": "compact",--%>
        <%--        };--%>

        <%--        // Gửi yêu cầu API sử dụng jQuery AJAX--%>
        <%--        $.ajax({--%>
        <%--            url: apiUrl,--%>
        <%--            type: 'POST',--%>
        <%--            headers: {--%>
        <%--                'x-client-id': clientId,--%>
        <%--                'x-api-key': apiKey,--%>
        <%--                'Content-Type': 'application/json'--%>
        <%--            },--%>
        <%--            data: JSON.stringify(requestData),--%>
        <%--            success: function (response) {--%>
        <%--                $('#qrCodeModal .modal-body').html('<img src="' + response.data.qrDataURL + '" class="img-fluid" />');--%>
        <%--            },--%>
        <%--            error: function (error) {--%>
        <%--                // Xử lý lỗi nếu có--%>
        <%--                console.error('API Error:', error);--%>
        <%--            }--%>
        <%--        });--%>
        <%--    }--%>
        <%--});--%>
        // api vietqr
        $(document).ready(function () {
            // Sự kiện change trên phần tử select
            $('#hinh-thuc-thanh-toan').on('change', function () {
                var selectedValue = $(this).val();

                // Kiểm tra giá trị được chọn và thực hiện hành động tương ứng
                if (selectedValue === '1') {
                    // Tiền mặt - ẩn form
                    $('#paymentForm').hide();
                } else if (selectedValue === '2') {
                    // Chuyển khoản - hiển thị form và tự động submit form
                    $('#paymentForm').show().submit();
                }
            });
        });
        // Lấy giá trị từ input có id="tong-tien"
        var tongTienInput = document.getElementById('tong-tien');
        var tongTienValue = tongTienInput.value;

        // Gán giá trị vào input có id="total"
        var totalInput = document.getElementById('total');
        totalInput.value = tongTienValue;
    });
</script>
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

    function hideErrorMessage() {
        // Sử dụng jQuery để ẩn thông báo sau 5 giây
        setTimeout(function () {
            $('.alert-danger').fadeOut('slow');
        }, 1000);
    }

    function hideErrorMessage2() {
        // Sử dụng jQuery để ẩn thông báo sau 5 giây
        setTimeout(function () {
            $('.alert-success').fadeOut('slow');
        }, 1000);
    }
</script>

