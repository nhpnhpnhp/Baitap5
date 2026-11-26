<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="vi">
<head>
    <script>document.documentElement.classList.add('js')</script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><sitemesh:write property="title"/> | SpringBoot Web</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/autohaus/css/vendor/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/autohaus/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
    <sitemesh:write property="head"/>
</head>
<body class="app-body">
    <a class="ah-skip" href="#main">Chuyển đến nội dung</a>

    <header>
        <nav class="ah-nav scrolled" aria-label="Điều hướng chính">
            <div class="container">
                <a class="ah-brand" href="${pageContext.request.contextPath}/home">
                    <span class="ah-brand-mark" aria-hidden="true">
                        <svg viewBox="0 0 24 24" fill="none">
                            <path d="M5 12h14M12 5l7 7-7 7" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </span>
                    Spring<b>Web</b>
                </a>

                <ul class="ah-nav-links ah-nav-desktop" role="list">
                    <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/categories">Danh mục (Tìm kiếm &amp; Phân trang)</a></li>
                </ul>

                <div class="ah-nav-cta ah-nav-desktop">
                    <c:choose>
                        <c:when test="${sessionScope.account != null}">
                            <span class="text-white small me-2">
                                Xin chào, <strong><c:out value="${sessionScope.account.fullName}"/></strong>
                            </span>
                            <form method="post" action="${pageContext.request.contextPath}/logout" class="d-inline m-0">
                                <button type="submit" class="btn btn-ah btn-sm">Đăng xuất</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-ghost btn-sm">Đăng nhập</a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-ah btn-sm">Đăng ký</a>
                        </c:otherwise>
                    </c:choose>
                </div>

                <button class="ah-burger" type="button" aria-label="Mở menu" aria-expanded="false" aria-controls="mobileMenu">
                    <span></span><span></span><span></span>
                </button>
            </div>
        </nav>

        <div class="ah-overlay" aria-hidden="true"></div>
        <div class="ah-mobile-menu" id="mobileMenu" aria-label="Menu di động">
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/categories">Danh mục</a>
            <hr>
            <c:choose>
                <c:when test="${sessionScope.account != null}">
                    <span class="text-white small mb-2">
                        Xin chào, <strong><c:out value="${sessionScope.account.fullName}"/></strong>
                    </span>
                    <form method="post" action="${pageContext.request.contextPath}/logout" class="m-0">
                        <button type="submit" class="btn btn-ah w-100">Đăng xuất</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-ghost">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-ah">Đăng ký</a>
                </c:otherwise>
            </c:choose>
        </div>
    </header>

    <main id="main" class="app-main">
        <sitemesh:write property="body"/>
    </main>

    <footer class="ah-footer">
        <div class="container">
            <div class="ah-footer-bottom mt-0 pt-0 border-0">
                <p class="m-0">&copy; 2026 SpringBoot Web &middot; JSP/JSTL &middot; Spring Data JPA</p>
                <p class="m-0">Spring Boot 4 &middot; Bootstrap 5 &middot; SiteMesh 3</p>
            </div>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/assets/autohaus/js/vendor/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/autohaus/js/main.js"></script>
</body>
</html>
