<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="vi">
<head>
    <title>Đăng nhập</title>
</head>
<body>
<section class="app-section">
    <div class="container">
        <div class="app-auth-wrap">
            <div class="app-card">
                <div class="app-card-header">
                    <span class="ah-eyebrow mb-2">Tài khoản</span>
                    <h1 class="h3 mb-1">Đăng nhập</h1>
                    <p class="mb-0 text-secondary">Nhập tên đăng nhập hoặc email để tiếp tục.</p>
                </div>
                <div class="app-card-body">
                    <c:if test="${message != null}">
                        <div class="alert app-alert-success mb-3" role="alert">
                            <c:out value="${message}"/>
                        </div>
                    </c:if>
                    <c:if test="${alert != null}">
                        <div class="alert app-alert-danger mb-3" role="alert">
                            <c:out value="${alert}"/>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post" novalidate>
                        <div class="mb-3">
                            <label for="username" class="form-label">Tên đăng nhập hoặc Email</label>
                            <input type="text"
                                   id="username"
                                   name="username"
                                   value="<c:out value='${username}'/>"
                                   placeholder="Nhập tài khoản hoặc email"
                                   class="form-control ${not empty errors.username ? 'is-invalid' : ''}">
                            <c:if test="${not empty errors.username}">
                                <div class="invalid-feedback"><c:out value="${errors.username}"/></div>
                            </c:if>
                        </div>

                        <div class="mb-4">
                            <label for="password" class="form-label">Mật khẩu</label>
                            <input type="password"
                                   id="password"
                                   name="password"
                                   placeholder="Nhập mật khẩu"
                                   class="form-control ${not empty errors.password ? 'is-invalid' : ''}">
                            <c:if test="${not empty errors.password}">
                                <div class="invalid-feedback"><c:out value="${errors.password}"/></div>
                            </c:if>
                        </div>

                        <button type="submit" class="btn btn-ah w-100">Đăng nhập</button>
                    </form>

                    <hr class="ah-divider my-4">
                    <p class="text-center mb-0">
                        Chưa có tài khoản?
                        <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
