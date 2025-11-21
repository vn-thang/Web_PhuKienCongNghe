<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Lịch Sử Mua Hàng</title>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container mt-5">
        <h2 class="mb-4">Lịch Sử Mua Hàng Của Bạn</h2>
        
        <c:choose>
            <c:when test="${empty orderList}">
                <div class="alert alert-info">Bạn chưa có đơn hàng nào.</div>
            </c:when>
            <c:otherwise>
                <table class="table table-bordered table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th scope="col">Mã ĐH</th>
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
                                <td>
                                    <fmt:formatDate value="${o.ngayDat}" pattern="dd-MM-yyyy HH:mm"/>
                                </td>
                                <td class="text-danger fw-bold">
                                    <fmt:formatNumber value="${o.tongTien}" type="currency" currencyCode="VND" minFractionDigits="0"/>
                                </td>
                                <td>
                                    <%-- Badge trạng thái --%>
                                    <c:choose>
                                        <c:when test="${o.trangThai == 'Dang xu ly'}">
                                            <span class="badge bg-warning text-dark">${o.trangThai}</span>
                                        </c:when>
                                        <c:when test="${o.trangThai == 'Da Thanh Toan'}">
                                            <span class="badge bg-info">${o.trangThai}</span>
                                        </c:when>
                                        <c:when test="${o.trangThai == 'Dang giao'}">
                                            <span class="badge bg-primary">${o.trangThai}</span>
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
                                    <a href="order-history?action=view&id=${o.maDonHang}" class="btn btn-primary btn-sm">
                                        Xem chi tiết
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>