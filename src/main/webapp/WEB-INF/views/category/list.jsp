<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="vi">
<head>
    <title>Danh sách danh mục</title>
</head>
<body>
<section class="app-page-header">
    <div class="container">
        <div class="d-flex flex-wrap justify-content-between align-items-end gap-3">
            <div>
                <span class="ah-eyebrow mb-2">Spring Data JPA</span>
                <h1 class="h2 mb-1">Danh sách danh mục</h1>
                <p class="mb-0 text-secondary">
                    Tìm kiếm theo tên và phân trang với <code>Pageable</code> / <code>Page&lt;Category&gt;</code>.
                </p>
            </div>
            <span class="app-meta-pill">Tổng kết quả: <strong class="text-white">${categoryPage.totalElements}</strong></span>
        </div>
    </div>
</section>

<section class="app-section">
    <div class="container">
        <c:if test="${message != null}">
            <div class="alert app-alert-success mb-3" role="alert">
                <c:out value="${message}"/>
            </div>
        </c:if>

        <div class="app-card mb-4">
            <div class="app-card-body">
                <div class="row g-3 align-items-end">
                    <div class="col-md-8">
                        <form method="get" action="${pageContext.request.contextPath}${baseUrl}" class="d-flex gap-2">
                            <input type="hidden" name="size" value="${categoryPage.size}">
                            <div class="flex-grow-1">
                                <label for="name" class="form-label">Từ khóa tìm kiếm</label>
                                <input type="text"
                                       id="name"
                                       name="name"
                                       value="<c:out value='${name}'/>"
                                       placeholder="Nhập từ khóa tên danh mục để tìm..."
                                       class="form-control">
                            </div>
                            <div class="align-self-end">
                                <button type="submit" class="btn btn-ah">Search</button>
                            </div>
                            <c:if test="${not empty name}">
                                <div class="align-self-end">
                                    <a href="${pageContext.request.contextPath}${baseUrl}?size=${categoryPage.size}" class="btn btn-ghost">Xóa lọc</a>
                                </div>
                            </c:if>
                        </form>
                    </div>

                    <div class="col-md-4">
                        <form method="get" action="${pageContext.request.contextPath}${baseUrl}">
                            <c:if test="${not empty name}">
                                <input type="hidden" name="name" value="<c:out value='${name}'/>">
                            </c:if>
                            <label for="size" class="form-label">Số bản ghi mỗi trang (Page size)</label>
                            <select name="size" id="size" class="form-select" onchange="this.form.submit()">
                                <option ${categoryPage.size == 3 ? 'selected' : ''} value="3">3</option>
                                <option ${categoryPage.size == 5 ? 'selected' : ''} value="5">5</option>
                                <option ${categoryPage.size == 10 ? 'selected' : ''} value="10">10</option>
                                <option ${categoryPage.size == 15 ? 'selected' : ''} value="15">15</option>
                                <option ${categoryPage.size == 20 ? 'selected' : ''} value="20">20</option>
                            </select>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <c:choose>
            <c:when test="${!categoryPage.hasContent()}">
                <div class="app-card p-5 text-center">
                    <h2 class="h5 mb-2">Không tìm thấy danh mục nào</h2>
                    <p class="text-secondary mb-0">
                        <c:choose>
                            <c:when test="${not empty name}">
                                Không có danh mục phù hợp với từ khóa "<strong><c:out value="${name}"/></strong>".
                            </c:when>
                            <c:otherwise>
                                Danh sách danh mục hiện đang trống.
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="app-card overflow-hidden">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle app-table">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>ID</th>
                                    <th>Tên danh mục</th>
                                    <th>Hình ảnh</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${categoryPage.content}" var="cate" varStatus="STT">
                                    <tr>
                                        <td>${categoryPage.number * categoryPage.size + STT.index + 1}</td>
                                        <td>${cate.id}</td>
                                        <td class="text-white fw-semibold"><c:out value="${cate.name}"/></td>
                                        <td class="text-secondary small"><c:out value="${cate.images}"/></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${cate.status == 1}">
                                                    <span class="badge bg-success bg-opacity-25 text-success">Hoạt động</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary bg-opacity-25 text-secondary">Khóa</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <c:if test="${categoryPage.totalPages > 0}">
                    <nav aria-label="Phân trang danh mục" class="mt-4 d-flex flex-wrap justify-content-between align-items-center gap-3">
                        <span class="text-secondary small">
                            Trang ${categoryPage.number + 1} / ${categoryPage.totalPages}
                        </span>
                        <c:if test="${categoryPage.totalPages > 1}">
                            <ul class="pagination app-pagination mb-0">
                                <c:url var="prevUrl" value="${baseUrl}">
                                    <c:if test="${not empty name}"><c:param name="name" value="${name}"/></c:if>
                                    <c:param name="size" value="${categoryPage.size}"/>
                                    <c:param name="page" value="${categoryPage.number}"/>
                                </c:url>
                                <li class="page-item ${categoryPage.first ? 'disabled' : ''}">
                                    <a class="page-link" href="${categoryPage.first ? '#' : prevUrl}">Previous</a>
                                </li>

                                <c:forEach items="${pageNumbers}" var="pageNumber">
                                    <c:url var="pageUrl" value="${baseUrl}">
                                        <c:if test="${not empty name}"><c:param name="name" value="${name}"/></c:if>
                                        <c:param name="size" value="${categoryPage.size}"/>
                                        <c:param name="page" value="${pageNumber}"/>
                                    </c:url>
                                    <li class="page-item ${pageNumber == categoryPage.number + 1 ? 'active' : ''}">
                                        <a class="page-link" href="${pageUrl}">${pageNumber}</a>
                                    </li>
                                </c:forEach>

                                <c:url var="nextUrl" value="${baseUrl}">
                                    <c:if test="${not empty name}"><c:param name="name" value="${name}"/></c:if>
                                    <c:param name="size" value="${categoryPage.size}"/>
                                    <c:param name="page" value="${categoryPage.number + 2}"/>
                                </c:url>
                                <li class="page-item ${categoryPage.last ? 'disabled' : ''}">
                                    <a class="page-link" href="${categoryPage.last ? '#' : nextUrl}">Next</a>
                                </li>
                            </ul>
                        </c:if>
                    </nav>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</section>
</body>
</html>
