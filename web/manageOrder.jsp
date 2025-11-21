<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Đơn Hàng</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* ===================================
           🎨 TONE MÀU CAM #ff6600
        ===================================== */
        h2 {
            color: #ff6600;
            font-weight: 700;
        }

        .table thead {
            background-color: #ff6600 !important;
            color: white !important;
        }

        .btn-primary {
            background-color: #ff6600;
            border-color: #ff6600;
        }
        .btn-primary:hover {
            background-color: #e65a00;
            border-color: #e65a00;
        }

        /* Tăng độ mềm UI */
        table, th, td {
            vertical-align: middle;
        }

        /* Badge màu trạng thái tùy chỉnh */
        .badge-warning-custom {
            background-color: #ffcc80;
            color: #663300;
        }

        .badge-info-custom {
            background-color: #ff9966;
            color: #fff;
        }

        /* Bo góc + bóng nhẹ */
        .table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp" />

    <div class="container mt-5">
        <h2 class="mb-4">Quản Lý Đơn Hàng</h2>
        
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th scope="col">Mã ĐH</th>
                    <th scope="col">Người Đặt</th>
                    <th scope="col">Ngày Đặt</th>
                    <th scope="col">Tổng Tiền</th>
                    <th scope="col">Trạng Thái</th>
                    <th scope="col">Chi Tiết</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach items="${orderList}" var="o">
                    <tr>
                        <th scope="row">#${o.maDonHang}</th>

                        <td>${o.tenNguoiDat} (ID: ${o.maNguoiDung})</td>

                        <td>
                            <fmt:formatDate value="${o.ngayDat}" pattern="dd-MM-yyyy HH:mm"/>
                        </td>

                        <td class="text-danger fw-bold">
                            <fmt:formatNumber value="${o.tongTien}" type="currency" currencyCode="VND" minFractionDigits="0"/>
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${o.trangThai == 'Dang xu ly'}">
                                    <span class="badge badge-warning-custom">${o.trangThai}</span>
                                </c:when>

                                <c:when test="${o.trangThai == 'Da Thanh Toan'}">
                                    <span class="badge badge-info-custom">${o.trangThai}</span>
                                </c:when>

                                <c:when test="${o.trangThai == 'Da giao'}">
                                    <span class="badge bg-success">${o.trangThai}</span>
                                </c:when>

                                <c:otherwise>
                                    <span class="badge bg-danger">${o.trangThai}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <a href="manage-order?action=view&id=${o.maDonHang}" class="btn btn-primary btn-sm">
                                Xem
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
