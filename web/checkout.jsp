<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Thanh Toán</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --main-color: #FF6600;
        }

        body {
            background-color: #fffaf5;
        }

        h2, h4 {
            color: var(--main-color);
            font-weight: bold;
        }

        .btn-primary {
            background-color: var(--main-color);
            border-color: var(--main-color);
            transition: 0.3s;
        }

        .btn-primary:hover {
            background-color: #e05500;
            border-color: #e05500;
        }

        .text-primary {
            color: var(--main-color) !important;
        }

        .badge.bg-primary {
            background-color: var(--main-color) !important;
        }

        .list-group-item.active {
            background-color: var(--main-color);
            border-color: var(--main-color);
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--main-color);
            box-shadow: 0 0 0 0.25rem rgba(255, 102, 0, 0.25);
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container mt-5 mb-5">
        <c:if test="${empty sessionScope.cart || empty sessionScope.cart.itemsToCheckout}">
            <div class="alert alert-warning">
                Không có sản phẩm nào được chọn để thanh toán. Vui lòng quay lại <a href="cart">giỏ hàng</a>.
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.cart.itemsToCheckout}">
            <div class="row g-5">
                <div class="col-md-7">
                    <h2 class="mb-4">Thông tin thanh toán</h2>
                    
                    <form action="order" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="paymentMethod" value="${param.paymentMethod}">
                        <input type="hidden" name="paypalTransactionId" value="${param.paypalTransactionId}">
                        
                        <c:forEach items="${sessionScope.cart.itemsToCheckout}" var="entry">
                             <input type="hidden" name="checkedIds" value="${entry.value.product.maSanPham}">
                        </c:forEach>


                        <div class="row g-3">
                            <div class="col-12">
                                <label for="fullName" class="form-label">Họ và tên</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" value="${sessionScope.account.hoTen}" required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập họ và tên.
                                </div>
                            </div>

                            <div class="col-12">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="${sessionScope.account.email}" required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập email hợp lệ.
                                </div>
                            </div>

                            <div class="col-12">
                                <label for="phone" class="form-label">Số điện thoại</label>
                                <input type="tel" class="form-control" id="phone" name="phone" value="${sessionScope.account.sdt}" required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập số điện thoại.
                                </div>
                            </div>

                            <div class="col-12">
                                <label for="address" class="form-label">Địa chỉ nhận hàng</label>
                                <textarea class="form-control" id="address" name="address" rows="3" required>${sessionScope.account.diaChi}</textarea>
                                <div class="invalid-feedback">
                                    Vui lòng nhập địa chỉ nhận hàng.
                                </div>
                            </div>

                            <div class="col-12">
                                <label for="note" class="form-label">Ghi chú (Tùy chọn)</label>
                                <textarea class="form-control" id="note" name="note" rows="2"></textarea>
                            </div>
                        </div>

                        <hr class="my-4">

                        <h4 class="mb-3">Phương thức thanh toán</h4>
                        <div class="my-3">
                            <c:choose>
                                <c:when test="${param.paymentMethod == 'paypal'}">
                                    <div class
="form-check">
                                        <input id="paypal" name="paymentMethodDisplay" type="radio" class="form-check-input" checked disabled>
                                        <label class="form-check-label" for="paypal">PayPal (Đã thanh toán)</label>
                                    </div>
                                    <div class="text-muted small">Mã giao dịch: ${param.paypalTransactionId}</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="form-check">
                                        <input id="cod" name="paymentMethodDisplay" type="radio" class="form-check-input" checked disabled>
                                        <label class="form-check-label" for="cod">Thanh toán khi nhận hàng (COD)</label>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <hr class="my-4">

                        <button class="w-100 btn btn-primary btn-lg" type="submit">
                            <i class="fas fa-check-circle"></i> Xác Nhận Đặt Hàng
                        </button>
                    </form>
                </div>

                <div class="col-md-5">
                    <h4 class="d-flex justify-content-between align-items-center mb-3">
                        <span>Đơn hàng của bạn</span>
                        <span class="badge bg-primary rounded-pill">${sessionScope.cart.itemsToCheckout.size()}</span>
                    </h4>
                    <ul class="list-group mb-3">
                        <c:forEach items="${sessionScope.cart.itemsToCheckout}" var="entry">
                            <li class="list-group-item d-flex justify-content-between lh-sm">
                                <div>
                                    <h6 class="my-0">${entry.value.product.tenSanPham} (x${entry.value.quantity})</h6>
                                    <small class="text-muted">Giá: <fmt:formatNumber value="${entry.value.product.gia}" type="currency" currencyCode="VND"/></small>
                                </div>
                                <span class="text-muted"><fmt:formatNumber value="${entry.value.totalPrice}" type="currency" currencyCode="VND"/></span>
                            </li>
                        </c:forEach>
                        
                        <li class="list-group-item d-flex justify-content-between bg-light">
                            <div class="text-success">
                                <h6 class="my-0">Tổng cộng (VNĐ)</h6>
                            </div>
                            <strong class="text-success"><fmt:formatNumber value="${sessionScope.cart.totalCartPrice}" type="currency" currencyCode="VND"/></strong>
                        </li>
                    </ul>
                </div>
            </div>
        </c:if>
    </div>

    <jsp:include page="footer.jsp" />

    <script>
        // Script để bật validation của Bootstrap
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        form.classList.add('was-validated')
                    }, false)
                })
        })()
    </script>
</body>
</html>