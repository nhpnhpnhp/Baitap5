package vn.iotstar.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

@Controller
public class LoginController {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    private final UserService userService;

    public LoginController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String showLogin(HttpSession session) {
        if (session.getAttribute("account") != null) {
            return "redirect:/home";
        }
        return "login";
    }

    @PostMapping("/login")
    public String doLogin(
            @RequestParam(name = "username", defaultValue = "") String username,
            @RequestParam(name = "password", defaultValue = "") String password,
            HttpSession session,
            Model model) {

        String trimmedUser = username.trim();
        model.addAttribute("username", trimmedUser);

        Map<String, String> errors = new HashMap<>();
        if (trimmedUser.isEmpty()) {
            errors.put("username", "Vui lòng nhập tên đăng nhập hoặc email.");
        } else if (trimmedUser.contains("@") && !EMAIL_PATTERN.matcher(trimmedUser).matches()) {
            errors.put("username", "Email không đúng định dạng.");
        }

        if (password.isEmpty()) {
            errors.put("password", "Vui lòng nhập mật khẩu.");
        }

        if (!errors.isEmpty()) {
            model.addAttribute("errors", errors);
            return "login";
        }

        User user = userService.login(trimmedUser, password);
        if (user == null) {
            model.addAttribute("alert", "Tài khoản hoặc mật khẩu không đúng.");
            return "login";
        }

        if (!user.isActive()) {
            model.addAttribute("alert", "Tài khoản chưa được kích hoạt.");
            return "login";
        }

        // Luu thong tin user vao session, khong luu password
        User sessionUser = new User();
        sessionUser.setId(user.getId());
        sessionUser.setUserName(user.getUserName());
        sessionUser.setFullName(user.getFullName());
        sessionUser.setEmail(user.getEmail());
        sessionUser.setPhone(user.getPhone());
        sessionUser.setRoleid(user.getRoleid());
        sessionUser.setActive(user.isActive());

        session.setAttribute("account", sessionUser);
        return "redirect:/home";
    }
}
