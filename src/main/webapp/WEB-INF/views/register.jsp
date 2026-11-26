<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="vi">
<head>
    <title>Đăng ký tài khoản</title>
</head>
<body>
<section class="app-section">
    <div class="container">
        <div class="app-auth-wrap">
            <div class="app-card">
                <div class="app-card-header">
                    <span class="ah-eyebrow mb-2">Thành viên mới</span>
                    <h1 class="h3 mb-1">Tạo tài khoản mới</h1>
                    <p class="mb-0 text-secondary">Điền đầy đủ thông tin để đăng ký tài khoản.</p>
                </div>
                <div class="app-card-body">
                    <c:if test="${alert != null}">
                        <div class="alert app-alert-danger mb-3" role="alert">
                            <c:out value="${alert}"/>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post" novalidate>
                        <div class="mb-3">
                            <label for="username" class="form-label">Tên đăng nhập</label>
                            <input type="text"
                                   id="username"
                                   name="username"
                                   value="<c:out value='${username}'/>"
                                   placeholder="VD: nguyenvana"
                                   class="form-control ${not empty errors.username ? 'is-invalid' : ''}">
                            <c:if test="${not empty errors.username}">
                                <div class="invalid-feedback"><c:out value="${errors.username}"/></div>
                            </c:if>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email"
                                   id="email"
                                   name="email"
                                   value="<c:out value='${email}'/>"
                                   placeholder="you@example.com"
                                   class="form-control ${not empty errors.email ? 'is-invalid' : ''}">
                            <c:if test="${not empty errors.email}">
                                <div class="invalid-feedback"><c:out value="${errors.email}"/></div>
                            </c:if>
                        </div>

                        <div class="mb-3">
                            <label for="fullname" class="form-label">Họ và tên</label>
                            <input type="text"
                                   id="fullname"
                                   name="fullname"
                                   value="<c:out value='${fullname}'/>"
                                   placeholder="Nguyễn Văn A"
                                   class="form-control ${not empty errors.fullname ? 'is-invalid' : ''}">
                            <c:if test="${not empty errors.fullname}">
                                <div class="invalid-feedback"><c:out value="${errors.fullname}"/></div>
                            </c:if>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Số điện thoại</label>
                            <input type="text"
                                   id="phone"
                                   name="phone"
                                   value="<c:out value='${phone}'/>"
                                   placeholder="0901234567"
                                   class="form-control ${not empty errors.phone ? 'is-invalid' : ''}">
                            <c:if test="${not empty errors.phone}">
                                <div class="invalid-feedback"><c:out value="${errors.phone}"/></div>
                            </c:if>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Mật khẩu</label>
                            <input type="password"
                                   id="password"
                                   name="password"
                                   placeholder="Tối thiểu 6 ký tự"
                                   class="form-control ${not empty errors.password ? 'is-invalid' : ''}">
                            <c:if test="${not empty errors.password}">
                                <div class="invalid-feedback"><c:out value="${errors.password}"/></div>
                            </c:if>
                        </div>

                        <div class="mb-4">
                            <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                            <input type="password"
                                   id="confirmPassword"
                                   name="confirmPassword"
                                   placeholder="Nhập lại mật khẩu"
                                   class="form-control ${not empty errors.confirmPassword ? 'is-invalid' : ''}">
                            <c:if test="${not empty errors.confirmPassword}">
                                <div class="invalid-feedback"><c:out value="${errors.confirmPassword}"/></div>
                            </c:if>
                        </div>

                        <button type="submit" class="btn btn-ah w-100">Đăng ký</button>
                    </form>

                    <hr class="ah-divider my-4">
                    <p class="text-center mb-0">
                        Đã có tài khoản?
                        <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
