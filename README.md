# Baitap5 - Spring Boot 4 + JSP/JSTL

Bài tập Spring Boot 4 gồm: cấu hình JSP/JSTL + SiteMesh 3, tìm kiếm và phân trang Category, đăng ký/đăng nhập/đăng xuất.

## Yêu cầu
- JDK 17+
- Maven 3.9+
- SQL Server

## Cấu hình Database
Copy `db.properties.example` thành `.runtime/db.properties` và điền thông tin SQL Server của bạn (hoặc set biến môi trường `DB_URL`, `DB_USER`, `DB_PASSWORD`).

## Cách chạy
```bash
mvn spring-boot:run
```
Hoặc build file war:
```bash
mvn clean package -DskipTests
java -jar target/baitap5-0.0.1-SNAPSHOT.war
```

## Đường dẫn kiểm tra
- Trang chủ: `http://localhost:8090/home`
- Tìm kiếm & phân trang Category: `http://localhost:8090/categories`
- Đăng ký: `http://localhost:8090/register`
- Đăng nhập: `http://localhost:8090/login`
