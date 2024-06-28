<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag@3.0.1/dist/css/multi-select-tag.css">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
    .image-input {
        display: none;
    }

    .image-preview-container {
        position: relative;
        width: 100px;
        height: 100px;
        margin: 10px;
        border: 1px dashed #ccc;
        text-align: center;
        cursor: pointer; /* Sử dụng con trỏ kiểu tay khi di chuột vào */
    }

    .image-preview {
        max-width: 100%;
        max-height: 100%;
        display: none;
    }

    .image-placeholder {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        font-size: 36px;
        color: #333;
    }

    /* Ẩn label khi đã chọn ảnh */
    .image-input-label.selected {
        display: none;
    }
    a {
        display: inline-block;
        margin-right: 5px; /* Điều chỉnh khoảng cách giữa các phần tử theo nhu cầu */
    }
</style>
<script>
    <%--    ctsp--%>

    function displayImage(index, imageId, placeholderId) {
        var input = document.getElementById("imageInput" + index);
        var imageDisplay = document.getElementById(imageId);
        var placeholder = document.getElementById(placeholderId);
        var base64ImagesInput = document.getElementById("base64Images" + index);

        var file = input.files[0];
        var reader = new FileReader();

        reader.onload = function (e) {
            var base64Image = e.target.result;
            imageDisplay.style.display = "block";
            imageDisplay.src = base64Image;
            placeholder.style.display = "none";

            // Update the hidden input field with base64 data
            base64ImagesInput.value = base64Image;
            console.log(base64Image);
        };

        reader.readAsDataURL(file);
    }

    function convertImageToBase64(index) {
        var input = document.getElementById("imageInput" + index);
        var base64ImagesInput = document.getElementById("base64Images" + index);

        var file = input.files[0];
        var reader = new FileReader();

        reader.onload = function (e) {
            var base64Image = e.target.result;
            // Update the hidden input field with base64 data
            base64ImagesInput.value = base64Image;
        };

        reader.readAsDataURL(file);
    }

    //     sp
    function displayImageProduct() {
        var input = document.getElementById('imageInput');
        var imageDisplayProduct = document.getElementById('imageDisplayProduct');
        var placeholder = document.getElementById('placeholder1'); // Đã thêm id vào placeholder

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                imageDisplayProduct.src = e.target.result;
                imageDisplayProduct.style.display = 'block';
                placeholder.style.display = 'none';
                // Chuyển đổi ảnh thành base64 và hiển thị nó
                convertToBase64(input.files[0], function (base64Image) {
                    // Lưu base64Image vào một biến hoặc gửi nó điều kiện cần thiết
                });
            };
            console.log(input.files[0]);

            reader.readAsDataURL(input.files[0]);
        } else {
            imageDisplayProduct.src = ''; // Xóa ảnh nếu không có tệp được chọn
            imageDisplayProduct.style.display = 'none';
            placeholder.style.display = 'block';
        }
    }

    function convertToBase64(file, callback) {
        var reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function () {
            var base64Image = reader.result.split(',')[1];
            callback(base64Image);
        };
        reader.onerror = function (error) {
            console.error('Error reading file: ', error);
        };
    }
</script>

<div class="container mt-3">
    <h1 class="text-center">Quản lý chi tiết sản phẩm</h1>
    <div class="row mt-3">
        <div class="col-12">
            <form:form action="${action}"
                       method="post" modelAttribute="sanPhamChiTiet" id="formSP">
                <div class="row">
                    <div class="col-4">
                        <label for="idSanPham" class="form-label">Sản Phẩm</label>
                        <i class="fas fa-plus-circle" data-bs-toggle="modal" data-bs-target="#modalSanPham"
                           title="Thêm Sản phẩm"></i>
                        <form:select path="idSanPham" id="idSanPham" class="form-select">
                            <c:forEach items="${listSanPham}" var="sanPham">
                                <option value="${sanPham.id}" ${sanPham.id == sanPhamChiTiet.idSanPham.id ? 'selected' : ''}>${sanPham.ten}</option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="col-4">
                        <label for="idMauSac" class="form-label">Màu Sắc</label>
                        <i class="fas fa-plus-circle" data-bs-toggle="modal" data-bs-target="#staticBackdrop"
                           title="Thêm màu sắc"></i>
                            <%--                        <form:select path="idMauSac" id="idMauSac" class="form-select">--%>
                            <%--                            <c:forEach items="${listMauSac}" var="mauSac">--%>
                            <%--                                <option value="${mauSac.id}" ${mauSac.id == sanPhamChiTiet.idMauSac.id ? 'selected' : ''}>${mauSac.ten}</option>--%>
                            <%--                            </c:forEach>--%>
                            <%--                        </form:select>--%>
                        <form:select name="idMauSac" id="idMauSac" path="idMauSac" multiple="true"  >
                            <c:forEach items="${listMauSac}" var="mauSac">
                                <option value="${mauSac.id}" ${mauSac.id == sanPhamChiTiet.idMauSac.id ? 'selected' : ''}>${mauSac.ten}</option>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-4">
                        <label for="idKichCo" class="form-label">Kích Cỡ</label>
                        <i class="fas fa-plus-circle" data-bs-toggle="modal" data-bs-target="#modalKichCo"
                           title="Thêm Kích cỡ"></i>

                        <form:select path="idKichCo" id="idKichCo"  name="idMauSac" multiple="true" >

                            <c:forEach items="${listKichCo}" var="kichCo">
                                <option value="${kichCo.id}"
                                        label="${kichCo.ten}" ${kichCo.id == sanPhamChiTiet.idKichCo.id ? 'selected' : ''}>${kichCo.ten}</option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="col-4">
                        <label for="gia" class="form-label">Giá Bán</label>
                        <form:input path="gia" id="gia" class="form-control" type="number" value="${sanPhamChiTiet.gia}"/>
                    </div>
                    <div class="col-4">
                        <label for="soLuong" class="form-label">Số lượng</label>
                        <form:input path="soLuong" id="soLuong" class="form-control" type="number"
                                    value="${sanPhamChiTiet.soLuong}" />
                    </div>
                </div>
                <div class="mt-3">
                    <label for="moTa" class="form-label">Mô tả</label>
                    <form:textarea path="moTa" id="moTa" class="form-control" style="height: 130px"
                                   value="${sanPhamChiTiet.moTa}"/>
                </div>

                <%--                <div class="mt-3">--%>
                <%--                    <label for="trangThai" class="form-label">Trạng thái</label>--%>
                <%--                    <form:select path="trangThai" id="trangThai" class="form-select">--%>
                <%--                        <option value="1"  ${sanPhamChiTiet.trangThai == 1 ? 'selected' : ''}>Đang bán</option>--%>
                <%--                        <option value="0"  ${sanPhamChiTiet.trangThai == 0 ? 'selected' : ''} >Ngừng bán</option>--%>
                <%--                    </form:select>--%>
                <%--                </div>--%>


                <div class="mt-3">
                    <button type="button" class="btn btn-secondary">Làm Mới</button>
                    <button type="submit" class="btn btn-primary">Tạo</button>
                </div>
                <!-- Kiểm tra xem danh sách 'listtam' có phần tử nào không -->
                <c:if test="${not empty listtam}">
                    <!-- Hiển thị bảng nếu 'listtam' không rỗng -->
                    <table class="table table-bordered text-center mt-3">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th>Mã sản phẩm</th>
                            <th>Tên sản phẩm</th>
                            <th>Màu Sắc</th>
                            <th>Kích cỡ</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Trạng thái</th>
                            <th colspan="2">Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${listtam}" var="sanPhamChiTiet" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${sanPhamChiTiet.maSanPham}</td>
                                <td>${sanPhamChiTiet.tenSanPham}</td>
                                <td>${sanPhamChiTiet.tenMauSac}</td>
                                <td>${sanPhamChiTiet.tenKichCo}</td>
                                <td>
                                    <fmt:formatNumber value="${sanPhamChiTiet.gia}" pattern="#,##0 ₫"/>
                                </td>
                                <td>${sanPhamChiTiet.soLuong}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${sanPhamChiTiet.trangThai == 1}">
                                            <span class="badge bg-success">Đang bán</span>
                                        </c:when>
                                        <c:when test="${sanPhamChiTiet.trangThai == 0}">
                                            <span class="badge bg-danger">Ngừng bán</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Tạm</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="/admin/san-pham-chi-tiet/updatetam/${sanPhamChiTiet.id}">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
                                            <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.5.5 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11z"/>
                                        </svg>
                                    </a>
                                    <a href="/admin/san-pham-chi-tiet/delete/${sanPhamChiTiet.id}">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
                                            <path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5"/>
                                        </svg>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>


                <c:if test="${empty listtam}">
                    <p class="text-center mt-3">NO DATA</p>
                </c:if>

                <div class="mt-3">
                    <a type="button" href="/admin/san-pham-chi-tiet/addlist" class="btn btn-primary">Lưu</a>
                </div>


            </form:form>

            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    const form = document.getElementById('formSP');
                    const idSanPhamSelect = document.getElementById('idSanPham');
                    const idMauSacSelect = document.getElementById('idMauSac');
                    const idKichCoSelect = document.getElementById('idKichCo');
                    const giaInput = document.getElementById('gia');
                    const soLuongInput = document.getElementById('soLuong');
                    const moTaTextarea = document.getElementById('moTa');

                    form.addEventListener('submit', function(event) {
                        // Check if the "Sản Phẩm" select is not selected
                        if (idSanPhamSelect.value === '') {
                            event.preventDefault();
                            alert('Vui lòng chọn Sản Phẩm.');
                            return;
                        }

                        // Check if the "Màu Sắc" select is not selected
                        if (idMauSacSelect.value === '') {
                            event.preventDefault();
                            alert('Vui lòng chọn Màu Sắc.');
                            return;
                        }

                        // Check if the "Kích Cỡ" select is not selected
                        if (idKichCoSelect.value === '') {
                            event.preventDefault();
                            alert('Vui lòng chọn Kích Cỡ.');
                            return;
                        }

                        // Check if the "Giá Bán" input is empty
                        if (giaInput.value.trim() === '') {
                            event.preventDefault();
                            alert('Vui lòng nhập Giá Bán.');
                            return;
                        }

                        // Check if the "Số lượng" input is empty
                        if (soLuongInput.value.trim() === '') {
                            event.preventDefault();
                            alert('Vui lòng nhập Số lượng.');
                            return;
                        }

                        // Check if the "Mô tả" textarea is empty
                        if (moTaTextarea.value.trim() === '') {
                            event.preventDefault();
                            alert('Vui lòng nhập Mô tả.');
                            return;
                        }

                        <%--for (let i = 0; i < 2; i++) {--%>
                        <%--    const fileInput = document.getElementById(`base64Images${i}`);--%>
                        <%--    if (!fileInput.files || fileInput.files.length === 0) {--%>
                        <%--        event.preventDefault();--%>
                        <%--        alert(`Vui lòng chọn ảnh.`);--%>
                        <%--        return;--%>
                        <%--    }--%>
                        <%--}--%>
                    });
                });
            </script>
        </div>
    </div>
</div>

<!-- Modal -->
<c:if test="${sanPhamChiTiet.id == null}">
    <%--mau sac--%>
    <div class="modal fade" id="staticBackdrop" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form:form modelAttribute="ms" method="post" action="/admin/mau-sac/them-nhanh">
                        <div class="row mb-3">
                            <div class="form-group row">
                                <div class="col-12">
                                    <label for="ten" class="form-label">Tên Màu</label>
                                    <form:input type="text" path="ten" id="ten" class="form-control" required="true"/>
                                    <form:errors path="ten" cssClass="text-danger"/>
                                </div>
                            </div>
                        </div>
                        <!-- ... -->
                        <button type="submit" class="btn btn-success mt-3 col-2 offset-5 save-button">Lưu</button>
                    </form:form>
                </div>
            </div>
        </div>
    </div>

    <%--kich co--%>
    <div class="modal fade" id="modalKichCo"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form:form id="edit-form" modelAttribute="kc" method="post" action="/admin/kich-co/them-nhanh">
                        <div class="form-group text-center">
                            <label for="ten" class="form-label">Kích cỡ</label>
                            <form:input type="text" path="ten" id="ten" class="form-control" required="true"/>
                            <form:errors path="ten" cssClass="text-danger"/>
                            <button type="submit" class="btn btn-success mt-3">Lưu</button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
    <%--san pham--%>
    <div class="modal fade" id="modalSanPham" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-body">
            <form:form id="edit-form" modelAttribute="sp" method="post" action="/admin/san-pham/them-nhanh"
                       enctype="multipart/form-data">
            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label for="ten" class="form-label">Tên Sản Phẩm</label>
                        <form:input type="text" path="ten" id="ten" class="form-control"
                                    required="true"/>
                        <form:errors path="ten" cssClass="text-danger"/>
                    </div>
                </div>
                <div class="col">
                    <div class="form-group">
                        <label class="form-label">Loại</label>
                        <form:select class="form-select" path="idLoai">
                            <c:forEach items="${listLoai}" var="loai">
                                <option value="${loai.id}">${loai.ten}</option>
                            </c:forEach>
                        </form:select>

                    </div>


                    <div class="mt-3 text-center">
                        <label class="form-label">Ảnh sản phẩm</label>
                        <div class="text-center">
                            <label for="imageInput" class="image-preview-container">
                                <img id="imageDisplayProduct" class="image-preview" src="" alt="Image">
                                <span class="image-placeholder" id="placeholder1">+</span>
                            </label>
                            <form:input path="anh" type="file" id="imageInput" class="image-input" accept="image/*"
                                        onchange="displayImageProduct()"/>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-success mt-3 col-2 offset-5">Lưu</button>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</c:if>


<script>
    new MultiSelectTag('countries')
    new MultiSelectTag('countries', {
        rounded: true,    // default true
        shadow: true,      // default false
        placeholder: 'Search',  // default Search...
        tagColor: {
            textColor: '#327b2c',
            borderColor: '#92e681',
            bgColor: '#eaffe6',
        },
        onChange: function(values) {
            console.log(values)
        }
    }); // id
    new MultiSelectTag('idMauSac');

    new MultiSelectTag('idMauSac', {
        rounded: true,    // default true
        shadow: true,      // default false
        placeholder: 'Search',  // default Search...
        tagColor: {
            textColor: '#327b2c',
            borderColor: '#92e681',
            bgColor: '#eaffe6',
        },
        onChange: function(values) {
            console.log(values)
        }
    })
</script>
<script src="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag@3.0.1/dist/js/multi-select-tag.js"></script>
<script>
    new MultiSelectTag('idMauSac');  // id

    new MultiSelectTag('idKichCo');
</script>

<script>
    let tempData = [];

    function addToTable() {
        const idSanPham = document.getElementById('idSanPham').value;
        const idMauSac = Array.from(document.getElementById('idMauSac').selectedOptions).map(option => option.text).join(', ');
        const idKichCo = Array.from(document.getElementById('idKichCo').selectedOptions).map(option => option.text).join(', ');
        const gia = document.getElementById('gia').value;
        const soLuong = document.getElementById('soLuong').value;
        const moTa = document.getElementById('moTa').value;

        const newItem = {
            idSanPham,
            idMauSac,
            idKichCo,
            gia,
            soLuong,
            moTa
        };

        tempData.push(newItem);
        renderTable();
    }

    function renderTable() {
        const tableBody = document.getElementById('tempTableBody');
        tableBody.innerHTML = '';

        tempData.forEach((item, index) => {
            const row = `
                <tr>
                    <td>${index + 1}</td>
                    <td>${item.idSanPham}</td>
                    <td>${item.idMauSac}</td>
                    <td>${item.idKichCo}</td>
                    <td>${item.gia}</td>
                    <td>${item.soLuong}</td>
                    <td>${item.moTa}</td>
                    <td><button onclick="removeItem(${index})">Xóa</button></td>
                </tr>
            `;
            tableBody.insertAdjacentHTML('beforeend', row);
        });
    }

    function removeItem(index) {
        tempData.splice(index, 1);
        renderTable();
    }

    function saveData() {
        fetch('<c:url value="/admin/saveTemporaryData"/>', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(tempData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Thành công!',
                        text: 'Dữ liệu đã được lưu thành công.',
                        showConfirmButton: false,
                        timer: 1500
                    });
                    tempData = [];
                    renderTable();
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Lỗi!',
                        text: 'Lưu dữ liệu thất bại.',
                        showConfirmButton: false,
                        timer: 1500
                    });
                }
            })
            .catch(error => console.error('Lỗi:', error));
    }

</script>
