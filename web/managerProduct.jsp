<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        body {
            background-color: #fff;
            font-family: 'Segoe UI', sans-serif;
            color: #333;
        }

        h2 {
            color: #ff6600;
            font-weight: 600;
        }

        .btn-success {
            background-color: #ff6600;
            border: none;
            transition: 0.3s;
        }
        .btn-success:hover {
            background-color: #e35500;
        }

        .btn-info {
            background-color: #ffa733;
            border: none;
            color: #fff;
            transition: 0.3s;
        }
        .btn-info:hover {
            background-color: #ff6600;
        }

        .btn-warning {
            background-color: #ffc107;
            color: #000;
            border: none;
            transition: 0.3s;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
            transition: 0.3s;
        }
        .btn-danger:hover {
            background-color: #bb2d3b;
        }

        table {
            border-radius: 10px;
            overflow: hidden;
        }

        thead.table-dark {
            background-color: #ff6600 !important;
            border: none;
        }

        thead.table-dark th {
            background-color: #ff6600 !important;
            color: #fff;
            text-align: center;
            vertical-align: middle;
        }

        tbody tr:hover {
            background-color: #fff5ec;
        }

        .table td, .table th {
            vertical-align: middle;
        }

        /* Thống kê */
        .statistic-btn {
            background-color: #ffa733;
            border: none;
            color: white;
            transition: 0.3s;
            border-radius: 8px;
        }

        .statistic-btn:hover {
            background-color: #ff6600;
            color: #fff;
        }
        .btn-outline-danger{
            background-color: #ff6600;
            color: #fff;
        }
    </style>
</head>
<body>  
    <jsp:include page="header.jsp" />
    
    <c:if test="${sessionScope.acc != null && sessionScope.acc.vaiTro == 'admin'}">
        <div style =" position: fixed; z-index: 1000;" >
        <div class="mt-2 mb-2">
            <a href="home" class="btn btn-outline-danger shadow-sm">
                <i class="fa-regular fa-hand-point-left"></i></i> Trang sản phẩm
            </a>
        </div></div>
    </c:if>
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-box"></i> Quản Lý Sản Phẩm</h2>

            <form action="statistic" method="get">
                <button type="submit" class="btn statistic-btn">
                    <i class="fas fa-chart-bar"></i> Xem thống kê
                </button>
            </form>
        </div>

        <div class="mb-3">
            <a href="manager-product?action=show-add-form" class="btn btn-success">
                <i class="fas fa-plus"></i> Thêm Sản Phẩm Mới
            </a>
        </div>

        <table class="table table-hover align-middle shadow-sm">
            <thead class="table-dark">
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col" style="width: 35%;">Tên Sản Phẩm</th>
                    <th scope="col">Hình Ảnh</th>
                    <th scope="col">Giá</th>
                    <th scope="col">Số Lượng Tồn</th>
                    <th scope="col" class="text-center">Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${productList}" var="p">
                    <tr>
                        <th scope="row">${p.maSanPham}</th>
                        <td>${p.tenSanPham}</td>
                        <td>
                            <img src="${p.hinhAnh}" class="img-fluid rounded" 
                                 style="width: 70px; height: 70px; object-fit: cover;" 
                                 alt="${p.tenSanPham}">
                        </td>
                        <td><fmt:formatNumber value="${p.gia}" type="currency" currencyCode="VND"/></td>
                        <td>${p.soLuongTon}</td>
                        <td class="text-center">
                            <a href="manager-product?action=load&pid=${p.maSanPham}" class="btn btn-warning btn-sm me-2">
                                <i class="fas fa-edit"></i> Sửa
                            </a>
                            <a href="manager-product?action=delete&pid=${p.maSanPham}" class="btn btn-danger btn-sm" 
                               onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?')">
                                <i class="fas fa-trash-alt"></i> Xóa
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>
