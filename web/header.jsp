<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ========== CSS & ICONS ========== -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
/* ===========================================
   COLOR PALETTE
   =========================================== */
:root {
  --primary: #ff6600;
  --primary-dark: #d65a3a;
  --primary-soft: #f4a261;
  --primary-light: #ffe8d9;

  --text-dark: #2d2d2d;
  --text-light: #555;
  --bg-soft: #fafafa;
  --border-soft: #f0f0f0;
}

/* ===========================================
   GLOBAL
   =========================================== */
body {
  font-family: "Inter", sans-serif;
  background-color: #fffbf8;
  padding-top: 125px;
  color: var(--text-dark);
}

a { color: var(--text-dark); text-decoration: none; }

/* ===========================================
   NAVBAR
   =========================================== */
.navbar.shopee-nav {
  background: #ffeee3;
  padding: 1rem 0;
  border-bottom: 1px solid var(--border-soft);
  position: fixed;
  width: 100%;
  z-index: 1200;
 
  transition: transform 0.1s cubic-bezier(0.25, 0.1, 0.25, 1), 
              opacity 0.1s ease;
  will-change: transform;


   
}

.navbar.shopee-nav.hidden { transform: translateY(-100%); }

.navbar-brand {
  font-size: 1.6rem;
  font-weight: 700;
  color: var(--primary) !important;
}

/* ===========================================
   SEARCH BAR
   =========================================== */
.shopee-search-form {
  max-width: 550px;
  width: 100%;
  position: relative;
}

.shopee-search-form .form-control {
  height: 42px;
  border-radius: 6px;
  border: 1.5px solid var(--border-soft);
  padding-left: 14px;
  background-color: var(--bg-soft);
}

.shopee-search-form .form-control:focus {
  border-color: var(--primary);
  box-shadow: 0 0 6px rgba(231, 111, 81, 0.25);
}

.btn-search {
  position: absolute;
  right: 8px;
  top: 50%;
  transform: translateY(-50%);
  background: var(--primary);
  border: none;
  color: #fff;
  width: 36px;
  height: 32px;
  border-radius: 6px;
  transition: 0.25s;
}

.btn-search:hover { background: var(--primary-dark); }

/* ===========================================
   NAV ICONS
   =========================================== */
.nav-icons .nav-link,
.nav-icons .dropdown-toggle {
  color: #ff6600;
  font-weight: 500;
  font-size: 1rem;
  transition: 0.2s;
  margin-right: 8px;
}

.nav-icons .nav-link:hover {
  color: var(--primary-dark);
}

.cart-icon {
  position: relative;
}

.cart-icon .badge {
  position: absolute;
  top: 0;
  right: -4px;
  font-size: 0.65rem;
  background: var(--primary);
  color: white;
  border: 1px solid #fff;
}

/* ===========================================
   CATEGORY BAR
   =========================================== */
.category-bar {
  background: #fff;
  border-bottom: 1px solid var(--border-soft);
  padding: 10px 0;
  position: fixed;
  width: 100%;
  top: 74px;
  z-index: 1100;
  overflow-x: auto;
  white-space: nowrap;
    
}

.navbar.shopee-nav.hidden + .category-bar {
  top: 0;
}

.category-menu {
  display: flex;
  gap: 12px;
}

.category-link {
  padding: 6px 14px;
  font-size: 0.92rem;
  border-radius: 20px;
  background: var(--bg-soft);
  color: var(--text-dark);
  transition: all 0.2s;
}

.category-link:hover {
  background: var(--primary-light);
  color: var(--primary);
}

.category-link.active {
  background: var(--primary-light);
  color: var(--primary);
  border: 1px solid var(--primary);
  font-weight: 600;
}

/* ===========================================
   PRODUCT CARD
   =========================================== */
.shopee-product-card {
  background: #fff;
  border-radius: 6px;
  padding: 0;
  border: 1px solid var(--border-soft);
  transition: 0.25s;
}

.shopee-product-card:hover {
  transform: translateY(-3px);
  border-color: var(--primary);
  box-shadow: 0 4px 14px rgba(0,0,0,0.08);
}

/* IMAGE */
.product-image {
  width: 100%;
  padding-top: 100%;
  position: relative;
}

.product-image img {
  position: absolute;
  width: 100%;
  height: 100%;
  object-fit: contain;
}

/* INFO */
.product-info {
  padding: 10px;
}

.product-title {
  font-size: 0.92rem;
  font-weight: 500;
  height: 42px;
  line-height: 1.3;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.product-price {
  font-size: 1.15rem;
  font-weight: 700;
  color: var(--primary);
  margin-top: 8px;
}

/* ===========================================
   GRID
   =========================================== */
.row-cols-shopee {
  --bs-gutter-x: 10px;
  --bs-gutter-y: 12px;
}

.row-cols-shopee > * {
  width: 20%;
  flex: 0 0 auto;
}

</style>

<!-- ========== NAVBAR ========== -->
<nav class="navbar navbar-expand-lg shopee-nav fixed-top">
  <div class="container">
    <!-- Logo -->
    <a class="navbar-brand" href="home">
       <i class="fa-solid fa-shop"></i>T store
    </a>

    <!-- Toggle -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsMain">
      <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Navbar Content -->
    <div class="collapse navbar-collapse" id="navbarsMain">
      <!-- Search -->
      <form class="shopee-search-form d-flex mx-lg-auto my-2 my-lg-0" action="home" method="get">
        <input class="form-control" type="search" name="search" placeholder="Tìm kiếm sản phẩm..." value="${searchQuery}">
        <button class="btn btn-search" type="submit"><i class="fas fa-search"></i></button>
      </form>

      <!-- Icons & User -->
      <div class="nav-icons d-flex align-items-center ms-lg-3">
        <!-- Cart -->
        <a class="nav-link cart-icon px-3" href="cart">
          <i class="fas fa-shopping-cart fs-4"></i>
          <c:if test="${not empty sessionScope.cart && not empty sessionScope.cart.items}">
            <span class="badge rounded-pill">${sessionScope.cart.totalItems}</span>
          </c:if>
        </a>

        <!-- User -->
        <c:choose>
  <c:when test="${sessionScope.acc != null}">
    <div class="dropdown">
      <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
        <i class="fas fa-user-circle fs-4"></i>
        <span class="d-none d-lg-inline ms-1">${sessionScope.acc.hoTen}</span>
      </a>
      <ul class="dropdown-menu dropdown-menu-end">
        <c:if test="${sessionScope.acc.vaiTro == 'admin'}">
          <li><a class="dropdown-item" href="manager-product">Quản Lý Sản Phẩm</a></li>
          <li><a class="dropdown-item" href="manage-user">Quản Lý Tài Khoản</a></li>
          <li><a class="dropdown-item" href="manage-order">Quản Lý Đơn Hàng</a></li>
          <li><a class="dropdown-item" href="statistic">Xem Thống Kê</a></li>
          <li><hr class="dropdown-divider"></li>
        </c:if>
        <li><a class="dropdown-item" href="profile">Thông Tin Tài Khoản</a></li>
        <li><a class="dropdown-item" href="change-password">Đổi Mật Khẩu</a></li>
        <li><a class="dropdown-item" href="order-history">Lịch sử mua hàng</a></li> 
        <li><a class="dropdown-item" href="logout">Đăng Xuất</a></li>
      </ul>
    </div>
  </c:when>
  <c:otherwise>
    <a href="login" class="nav-link px-3">Đăng Nhập</a>
    <a href="register" class="nav-link px-2">Đăng Ký</a>
  </c:otherwise>
</c:choose>

      </div>
    </div>
  </div>
</nav>

<!-- ========== CATEGORY BAR ========== -->
<div class="category-bar">
  <div class="container">
    <div class="category-menu">
      <a href="home" class="category-link ${empty activeCategoryId ? 'active' : ''}">Tất Cả</a>
      <c:forEach items="${categoryList}" var="c">
        <a href="home?cid=${c.maDanhMuc}" 
           class="category-link ${activeCategoryId == c.maDanhMuc ? 'active' : ''}">
          ${c.tenDanhMuc}
        </a>
      </c:forEach>
    </div>
  </div>
</div>

<!-- ========== JS ========== -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Ẩn/hiện navbar khi cuộn
  let lastScrollTop = 0;
  const navbar = document.querySelector(".navbar.shopee-nav");

  if (navbar) {
    const navbarHeight = navbar.offsetHeight;
    window.addEventListener("scroll", function() {
      let scrollTop = window.pageYOffset || document.documentElement.scrollTop;
      if (scrollTop > lastScrollTop && scrollTop > navbarHeight) {
        navbar.classList.add("hidden");
      } else {
        navbar.classList.remove("hidden");
      }
      lastScrollTop = scrollTop <= 0 ? 0 : scrollTop;
    });
  }
</script>
