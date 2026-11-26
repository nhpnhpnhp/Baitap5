package vn.iotstar.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.iotstar.entity.Category;
import vn.iotstar.service.CategoryService;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
public class CategoryController {

    private final CategoryService categoryService;

    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @RequestMapping({"/categories", "/admin/categories/searchpaginated"})
    public String search(
            ModelMap model,
            HttpServletRequest request,
            @RequestParam(name = "name", required = false) String name,
            @RequestParam(name = "page", required = false) String pageParam,
            @RequestParam(name = "size", required = false) String sizeParam) {

        int currentPage = parseIntOrDefault(pageParam, 1);
        if (currentPage < 1) {
            currentPage = 1;
        }
        int pageSize = parseIntOrDefault(sizeParam, 3);
        if (pageSize < 1) {
            pageSize = 3;
        } else if (pageSize > 50) {
            pageSize = 50;
        }

        String keyword = StringUtils.hasText(name) ? name.trim() : null;
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
        Page<Category> resultPage = keyword != null
                ? categoryService.findByNameContaining(keyword, pageable)
                : categoryService.findAll(pageable);

        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0 && currentPage > totalPages) {
            currentPage = totalPages;
            pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
            resultPage = keyword != null
                    ? categoryService.findByNameContaining(keyword, pageable)
                    : categoryService.findAll(pageable);
        }

        if (keyword != null) {
            model.addAttribute("name", keyword);
        }

        if (totalPages > 0) {
            int start = Math.max(1, currentPage - 2);
            int end = Math.min(currentPage + 2, totalPages);
            List<Integer> pageNumbers = IntStream.rangeClosed(start, end)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

        model.addAttribute("categoryPage", resultPage);
        model.addAttribute("baseUrl", request.getServletPath());
        return "category/list";
    }

    private int parseIntOrDefault(String value, int defaultValue) {
        if (!StringUtils.hasText(value)) {
            return defaultValue;
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}
