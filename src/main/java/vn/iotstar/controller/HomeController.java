package vn.iotstar.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HomeController {

    @GetMapping({"/", "/home"})
    public String home(Model model, HttpSession session) {
        model.addAttribute("appTitle", "Bài tập Spring Boot 4 - JSP/JSTL");
        model.addAttribute("features", List.of(
                "Cấu hình Spring Boot 4 chạy JSP/JSTL + SiteMesh 3",
                "Tìm kiếm và phân trang Category với Pageable / Page<T>",
                "Đăng ký, Đăng nhập (BCrypt + Session) và Đăng xuất"
        ));
        if (session.getAttribute("account") != null) {
            model.addAttribute("loggedIn", true);
        }
        return "home";
    }
}
