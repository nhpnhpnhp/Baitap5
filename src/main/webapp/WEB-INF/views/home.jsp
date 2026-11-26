<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="vi">
<head>
    <title>Trang chủ</title>
</head>
<body>
<section class="app-page-header">
    <div class="container">
        <span class="ah-eyebrow mb-2">Spring Boot 4 &middot; Spring MVC</span>
        <h1 class="h2 mb-2"><c:out value="${appTitle}"/></h1>
        <c:choose>
            <c:when test="${sessionScope.account != null}">
                <p class="mb-0 text-secondary">
                    Xin chào, <strong class="text-white"><c:out value="${sessionScope.account.fullName}"/></strong>
                    (<c:out value="${sessionScope.account.userName}"/>).
                </p>
            </c:when>
            <c:otherwise>
                <p class="mb-0 text-secondary">
                    Bạn đang ở chế độ khách. Hãy đăng nhập hoặc đăng ký tài khoản mới.
                </p>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<section class="app-section">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-8">
                <div class="app-card h-100">
                    <div class="app-card-header">
                        <h2 class="h5 mb-0">Các chức năng đã triển khai</h2>
                    </div>
                    <div class="app-card-body">
                        <ul class="mb-4">
                            <c:forEach items="${features}" var="item">
                                <li class="mb-2"><c:out value="${item}"/></li>
                            </c:forEach>
                        </ul>
                        <div class="d-flex flex-wrap gap-2">
                            <a href="${pageContext.request.contextPath}/categories" class="btn btn-ah">
                                Xem danh mục (Tìm kiếm &amp; Phân trang)
                            </a>
                            <c:if test="${sessionScope.account == null}">
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-ghost">Đăng nhập</a>
                                <a href="${pageContext.request.contextPath}/register" class="btn btn-ghost">Đăng ký</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="app-card h-100">
                    <div class="app-card-header">
                        <h2 class="h5 mb-0">Trạng thái phiên</h2>
                    </div>
                    <div class="app-card-body">
                        <c:choose>
                            <c:when test="${sessionScope.account != null}">
                                <p class="mb-2">Tài khoản: <strong class="text-white"><c:out value="${sessionScope.account.userName}"/></strong></p>
                                <p class="mb-2">Họ tên: <strong class="text-white"><c:out value="${sessionScope.account.fullName}"/></strong></p>
                                <p class="mb-3">Email: <strong class="text-white"><c:out value="${sessionScope.account.email}"/></strong></p>
                                <form method="post" action="${pageContext.request.contextPath}/logout">
                                    <button type="submit" class="btn btn-outline-danger btn-sm w-100">Đăng xuất</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <p class="text-secondary mb-3">Chưa đăng nhập vào hệ thống.</p>
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-ah btn-sm w-100">Đăng nhập ngay</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
