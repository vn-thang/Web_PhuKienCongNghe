<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Phụ Kiện Store</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
body {
    margin: 0;
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #fff6f2, #fffaf8); /* giữ sáng nhẹ như cũ */
    color: #333;
}
h2, h5 {
    font-weight: 600;
}

/* ====== HERO BANNER ====== */
.hero-section {
    position: relative;
    height: 420px;
    border-radius: 16px;
    overflow: hidden;
    margin-bottom: 2rem;
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
}
.hero-slide {
    position: absolute;
    inset: 0;
    
    background-size: cover;
    background-position: center;
    opacity: 0;
    transition: opacity 1s ease-in-out;
}
.hero-slide.active { opacity: 1; }
.hero-overlay {
    position: absolute;
    inset: 0;
    background: rgba(0,0,0,0);
}
.hero-btn {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background-color: rgba(228,74,10,0.8); /* cam chủ đạo */
    color: #fff;
    border: none;
    border-radius: 50%;
    width: 45px;
    height: 45px;
    font-size: 1.2rem;
    cursor: button;
    z-index: 10;
    transition: 0.3s;
}
.hero-btn:hover {
    background-color: #FF7A3D; /* hover nhạt hơn */
    transform: scale(1.1) translateY(-50%);
}
.hero-btn.prev { left: 20px; }
.hero-btn.next { right: 20px; }

/* ====== KHỐI SẢN PHẨM BÁN CHẠY ====== */
.best-sellers-section {
    background: #fff;
    border-radius: 18px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.08);
    overflow: hidden;
    margin-bottom: 2rem;
}
.best-sellers-header {
    padding: 1.2rem 1.5rem;
    background: linear-gradient(90deg, #E44A0A, #FF7A3D); /* gradient cam */
    color: white;
    font-size: 1.4rem;
    font-weight: 600;
    text-transform: uppercase;
}
.top-1-card, .small-card {
    display: block;
    text-decoration: none;
    color: #333;
    transition: all 0.3s ease;
}
.top-1-card:hover, .small-card:hover {
    transform: translateY(-5px);
}
.top-1-image-wrapper, .small-card-image {
    position: relative;
    overflow: hidden;
    border-radius: 10px;
}
.top-1-image-wrapper img,
.small-card-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.4s ease;
}
.top-1-card:hover img,
.small-card:hover img {
    transform: scale(1.05);
}
.top-badge {
    position: absolute;
    top: 10px;
    left: 10px;
    background: linear-gradient(135deg, #E44A0A, #FF7A3D);
    color: #fff;
    font-weight: 700;
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 0.85rem;
    box-shadow: 0 3px 6px rgba(0,0,0,0.2);
}

/* ====== THẺ SẢN PHẨM ====== */
.product-card {
    background: #fff;
    border-radius: 14px;
    box-shadow: 0 3px 10px rgba(0,0,0,0.08);
    transition: all 0.3s ease;
}
.product-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
}
/* === FIX HIỆN ĐẦY ĐỦ ẢNH KHÔNG BỊ CẮT === */
.product-img {
    width: 100%;
    height: 220px;          /* giữ đúng chiều cao card của bạn */
    object-fit: contain;    /* hiển thị toàn bộ ảnh, không crop */
    background-color: #fff; /* tránh lộ khoảng trống gây xấu */
    border-radius: 14px 14px 0 0;
}

.product-title {
    font-size: 1.05rem;
    font-weight: 600;
    color: #222;
    height: 48px;
    overflow: hidden;
}
.product-price {
    color: #E44A0A; /* đổi màu giá sang cam */
    font-weight: 700;
    font-size: 1.15rem;
}
.card-footer a {
    border-radius: 20px;
    padding: 6px 12px;
    font-size: 0.9rem;
    font-weight: 500;
}
.btn-warning {
    background-color: #E44A0A; /* nút chính */
    border: none;
}
.btn-warning:hover {
    background-color: #FF7A3D;
}
.btn-outline-success {
    border: 1px solid #E44A0A;
    color: #E44A0A;
}
.btn-outline-success:hover {
    background-color: #E44A0A;
    color: white;
}

/* ====== PHÂN TRANG ====== */
.pagination .page-link {
    border-radius: 10px;
    margin: 0 4px;
    color: #E44A0A;
    border: 1px solid #ffc1b0;
}
.pagination .page-link:hover {
    background-color: #E44A0A;
    color: white;
}
.pagination .active .page-link {
    background-color: #E44A0A;
    border-color: #E44A0A;
    color: white;
}
/* === CHUYỂN TẤT CẢ NÚT SANG TONE CAM === */

/* Nút vàng Xem chi tiết */
.btn-warning {
    background-color: #E44A0A !important;   /* cam */
    border-color: #E44A0A !important;
    color: #fff !important;
}

.btn-warning:hover {
    background-color: #FF7A3D !important;   /* cam nhạt */
    border-color: #FF7A3D !important;
    color: #fff !important;
}

/* Nút + Giỏ hàng (màu xanh lá cũ) */
.btn-outline-success {
    border-color: #E44A0A !important;
    color: #E44A0A !important;              /* cam viền + chữ */
}

.btn-outline-success:hover {
    background-color: #E44A0A !important;
    border-color: #E44A0A !important;
    color: #fff !important;
}



</style>

</head>

<body>
    <jsp:include page="header.jsp" />

    <div class="container mt-5">
 <c:if test="${sessionScope.acc != null && sessionScope.acc.vaiTro == 'admin'}">
        <div style="position: fixed; z-index: 1000; top: 80px; left: 20px;">
            <a href="manager-product" class="btn btn-outline-danger shadow-sm">
                <i class="fa-regular fa-hand-point-left"></i> Admin
            </a>
        </div>
    </c:if>
        <!-- ==== SLIDER ==== -->
        <c:if test="${empty param.cid && empty param.search && currentPage == 1}">
            <div class="hero-section">
                <div class="hero-slide active" style="background-image: url('https://cf.shopee.vn/file/vn-11134258-820l4-mfxo13pqr09af9');"><div class="hero-overlay"></div></div>
                <div class="hero-slide" style="background-image: url('https://cf.shopee.vn/file/vn-50009109-727a24a85a60935da5ccb9008298f681');"><div class="hero-overlay"></div></div>
                <div class="hero-slide" style="background-image: url('https://cf.shopee.vn/file/vn-11134258-820l4-mfxo3ih8jzt51a');"><div class="hero-overlay"></div></div>
                <button class="hero-btn prev"><i class="fas fa-chevron-left"></i></button>
                <button class="hero-btn next"><i class="fas fa-chevron-right"></i></button>
            </div>
        </c:if>

        <!-- ==== THÔNG BÁO ==== -->
        <c:if test="${not empty sessionScope.orderSuccess}">
            <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                <strong>Đặt hàng thành công!</strong> Cảm ơn bạn đã mua sắm tại Phụ Kiện Store.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="orderSuccess" scope="session"/>
        </c:if>

        <!-- ==== TOP BÁN CHẠY ==== -->
        <c:if test="${empty param.cid && empty param.search && currentPage == 1 && not empty top1BestSeller}">
            <div class="best-sellers-section">
                <div class="best-sellers-header"><i class="fa-solid fa-fire me-2"></i> Sản Phẩm Bán Chạy</div>
                <div class="row g-0">
                    <div class="col-lg-5 col-md-6 border-end">
                        <a href="detail?pid=${top1BestSeller.maSanPham}" class="top-1-card p-3">
                            <div class="top-1-image-wrapper">
                                <span class="top-badge"><i class="fa-solid fa-crown me-1"></i>TOP 1</span>
                                <img src="${top1BestSeller.hinhAnh}" alt="${top1BestSeller.tenSanPham}">
                            </div>
                            <h5 class="mt-3">${top1BestSeller.tenSanPham}</h5>
                            <div class="product-price">
                                <fmt:formatNumber value="${top1BestSeller.gia}" type="currency" currencyCode="VND" minFractionDigits="0"/>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-7 col-md-6 p-3">
                        <div class="row row-cols-3 g-3">
                            <c:forEach items="${top2to7BestSellers}" var="p" varStatus="loop">
                                <div class="col">
                                    <a href="detail?pid=${p.maSanPham}" class="small-card">
                                        <div class="small-card-image">
                                            <span class="top-badge">TOP ${loop.count + 1}</span>
                                            <img src="${p.hinhAnh}" alt="${p.tenSanPham}">
                                        </div>
                                        <div class="p-2">
                                            <div class="product-title">${p.tenSanPham}</div>
                                            <div class="product-price">
                                                <fmt:formatNumber value="${p.gia}" type="currency" currencyCode="VND" minFractionDigits="0"/>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- ==== DANH SÁCH SẢN PHẨM ==== -->
        <h2 class="mb-4 text-center">
            <c:choose>
                <c:when test="${not empty activeCategoryId}">
                    Sản phẩm thuộc danh mục: 
                    <span style="color:#ee4d2d;">
                        ${categoryList.stream().filter(c -> c.maDanhMuc == activeCategoryId).findFirst().get().tenDanhMuc}
                    </span>
                </c:when>
                <c:when test="${not empty searchQuery}">
                    Kết quả tìm kiếm cho: "<span style="color:#ee4d2d;">${searchQuery}</span>"
                </c:when>
                <c:otherwise>Tất Cả Sản Phẩm</c:otherwise>
            </c:choose>
        </h2>

        <div class="row row-cols-1 row-cols-md-4 g-4">
            <c:forEach items="${productList}" var="p">
                <div class="col">
                    <div class="card product-card h-100">
                        <a href="detail?pid=${p.maSanPham}">
                            <img src="${p.hinhAnh}" class="product-img" alt="${p.tenSanPham}">
                        </a>
                        <div class="card-body">
                            <h5 class="product-title">
                                <a href="detail?pid=${p.maSanPham}" class="text-decoration-none">${p.tenSanPham}</a>
                            </h5>
                            <p class="product-price">
                                <fmt:formatNumber value="${p.gia}" type="currency" currencyCode="VND" minFractionDigits="0"/>
                            </p>
                        </div>
                        <div class="card-footer bg-transparent text-center">
                            <a href="detail?pid=${p.maSanPham}" class="btn btn-warning btn-sm me-1 text-white">Xem chi tiết</a>
                            <a href="cart?action=add&productId=${p.maSanPham}" class="btn btn-outline-success btn-sm">Thêm giỏ hàng</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <c:if test="${empty productList}">
            <div class="alert alert-warning mt-4">Không tìm thấy sản phẩm nào phù hợp.</div>
        </c:if>
     
       <!-- ==== PHÂN TRANG ==== -->
<c:if test="${totalPages > 1}">
    <nav class="mt-5 d-flex justify-content-center">
        <ul class="pagination">
            <!-- Nút Previous -->
            <c:url var="prevUrl" value="home">
                <c:param name="page" value="${currentPage - 1}" />
                <c:if test="${not empty activeCategoryId}">
                    <c:param name="cid" value="${activeCategoryId}" />
                </c:if>
                <c:if test="${not empty searchQuery}">
                    <c:param name="search" value="${searchQuery}" />
                </c:if>
            </c:url>
            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                <a class="page-link" href="${prevUrl}">&laquo;</a>
            </li>

            <!-- Nút số trang -->
            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:url var="pageUrl" value="home">
                    <c:param name="page" value="${i}" />
                    <c:if test="${not empty activeCategoryId}">
                        <c:param name="cid" value="${activeCategoryId}" />
                    </c:if>
                    <c:if test="${not empty searchQuery}">
                        <c:param name="search" value="${searchQuery}" />
                    </c:if>
                </c:url>
                <li class="page-item ${currentPage == i ? 'active' : ''}">
                    <a class="page-link" href="${pageUrl}">${i}</a>
                </li>
            </c:forEach>

            <!-- Nút Next -->
            <c:url var="nextUrl" value="home">
                <c:param name="page" value="${currentPage + 1}" />
                <c:if test="${not empty activeCategoryId}">
                    <c:param name="cid" value="${activeCategoryId}" />
                </c:if>
                <c:if test="${not empty searchQuery}">
                    <c:param name="search" value="${searchQuery}" />
                </c:if>
            </c:url>
            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                <a class="page-link" href="${nextUrl}">&raquo;</a>
            </li>
        </ul>
    </nav>
</c:if>
 

    </div>

    <jsp:include page="footer.jsp" />

    <script>
        // ==== SLIDER ====
        const slides = document.querySelectorAll(".hero-slide");
        const prevBtn = document.querySelector(".hero-btn.prev");
        const nextBtn = document.querySelector(".hero-btn.next");
        let index = 0;
        function showSlide(i){slides.forEach(s=>s.classList.remove("active"));slides[i].classList.add("active");}
        function nextSlide(){index=(index+1)%slides.length;showSlide(index);}
        function prevSlide(){index=(index-1+slides.length)%slides.length;showSlide(index);}
        if(slides.length>0&&prevBtn&&nextBtn){
            nextBtn.addEventListener("click",nextSlide);
            prevBtn.addEventListener("click",prevSlide);
            setInterval(nextSlide,4000);
        }
    </script>
</body>
</html>
