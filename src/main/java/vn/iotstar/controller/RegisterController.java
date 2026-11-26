package vn.iotstar.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.iotstar.service.UserService;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

@Controller
public class RegisterController {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9._-]{3,100}$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^0[0-9]{9}$");

    private final UserService userService;

    public RegisterController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/register")
    public String showRegister(HttpSession session) {
        if (session.getAttribute("account") != null) {
            return "redirect:/home";
        }
        return "register";
    }

    @PostMapping("/register")
    public String doRegister(
            @RequestParam(name = "username", defaultValue = "") String username,
            @RequestParam(name = "email", defaultValue = "") String email,
            @RequestParam(name = "fullname", defaultValue = "") String fullname,
            @RequestParam(name = "phone", defaultValue = "") String phone,
            @RequestParam(name = "password", defaultValue = "") String password,
            @RequestParam(name = "confirmPassword", defaultValue = "") String confirmPassword,
            Model model,
            RedirectAttributes redirectAttributes) {

        String u = username.trim();
        String e = email.trim();
        String f = fullname.trim();
        String p = phone.trim();

        model.addAttribute("username", u);
        model.addAttribute("email", e);
        model.addAttribute("fullname", f);
        model.addAttribute("phone", p);

        Map<String, String> errors = new HashMap<>();
        if (u.isEmpty()) {
            errors.put("username", "Tên đăng nhập không được để trống.");
        } else if (!USERNAME_PATTERN.matcher(u).matches()) {
            errors.put("username", "Tên đăng nhập dài 3-100 ký tự, chỉ gồm chữ, số và . _ -");
        } else if (userService.existsByUsername(u)) {
            errors.put("username", "Tên đăng nhập đã tồn tại.");
        }

        if (e.isEmpty()) {
            errors.put("email", "Email không được để trống.");
        } else if (e.length() > 255 || !EMAIL_PATTERN.matcher(e).matches()) {
            errors.put("email", "Email không đúng định dạng.");
        } else if (userService.existsByEmail(e)) {
            errors.put("email", "Email đã được sử dụng.");
        }

        if (f.isEmpty()) {
            errors.put("fullname", "Họ tên không được để trống.");
        } else if (f.length() < 2 || f.length() > 255) {
            errors.put("fullname", "Họ tên phải từ 2 đến 255 ký tự.");
        }

        if (p.isEmpty()) {
            errors.put("phone", "Số điện thoại không được để trống.");
        } else if (!PHONE_PATTERN.matcher(p).matches()) {
            errors.put("phone", "Số điện thoại phải bắt đầu bằng 0 và gồm 10 chữ số.");
        }

        if (password.isEmpty()) {
            errors.put("password", "Mật khẩu không được để trống.");
        } else if (password.length() < 6 || password.length() > 100) {
            errors.put("password", "Mật khẩu phải từ 6 đến 100 ký tự.");
        }

        if (confirmPassword.isEmpty()) {
            errors.put("confirmPassword", "Vui lòng xác nhận mật khẩu.");
        } else if (!confirmPassword.equals(password)) {
            errors.put("confirmPassword", "Mật khẩu xác nhận không khớp.");
        }

        if (!errors.isEmpty()) {
            model.addAttribute("errors", errors);
            return "register";
        }

        userService.register(u, password, e, f, p);
        redirectAttributes.addFlashAttribute("message", "Đăng ký tài khoản thành công! Vui lòng đăng nhập.");
        return "redirect:/login";
    }
}
