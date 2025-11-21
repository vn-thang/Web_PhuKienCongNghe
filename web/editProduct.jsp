<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>${not empty productDetail ? 'Chỉnh Sửa Sản Phẩm' : 'Thêm Sản Phẩm Mới'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-dark text-white">
                        <h3>${not empty productDetail ? 'Chỉnh Sửa Sản Phẩm' : 'Thêm Sản Phẩm Mới'}</h3>
                    </div>
                    <div class="card-body">
                        <form action="manager-product" method="post">
                            <input type="hidden" name="action" value="${not empty productDetail ? 'update' : 'add'}">
                            
                            <c:if test="${not empty productDetail}">
                                <input type="hidden" name="id" value="${productDetail.maSanPham}">
                            </c:if>

                            <div class="mb-3">
                                <label for="name" class="form-label">Tên Sản Phẩm</label>
                                <input type="text" class="form-control" id="name" name="name" value="${productDetail.tenSanPham}" required>
                            </div>
                            <div class="mb-3">
                                <label for="image" class="form-label">Link Hình Ảnh</label>
                                <input type="text" class="form-control" id="image" name="image" value="${productDetail.hinhAnh}" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="price" class="form-label">Giá (VNĐ)</label>
                                    <input type="number" class="form-control" id="price" name="price" value="${productDetail.gia}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="stock" class="form-label">Số Lượng Kho</label>
                                    <input type="number" class="form-control" id="stock" name="stock" value="${productDetail.soLuongTon}" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="category" class="form-label">Danh Mục</label>
                                <select class="form-select" id="category" name="category" required>
                                    <c:forEach items="${categoryList}" var="c">
                                        <option value="${c.maDanhMuc}" ${productDetail.maDanhMuc == c.maDanhMuc ? 'selected' : ''}>
                                            ${c.tenDanhMuc}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Mô Tả</label>
                                <textarea class="form-control" id="description" name="description" rows="4" required>${productDetail.moTa}</textarea>
                            </div>
                            <a href="manager-product" class="btn btn-secondary">Quay Lại</a>
                            <button type="submit" class="btn btn-primary">${not empty productDetail ? 'Cập Nhật' : 'Thêm Mới'}</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>