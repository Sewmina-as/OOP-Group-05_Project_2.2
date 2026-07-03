package com.social.app.controller;

import com.social.app.dto.RegisterDTO;
import com.social.app.service.UserService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Controller for authentication: registration and login pages.
 * Spring Security automatically handles POST /auth/login.
 */
@Controller
@RequestMapping("/auth")
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    // =========================================================
    // Login
    // =========================================================

    @GetMapping("/login")
    public String showLoginPage(
            @RequestParam(required = false) String error,
            @RequestParam(required = false) String logout,
            Model model) {

        if (error != null) {
            model.addAttribute("errorMessage", "Invalid email or password. Please try again.");
        }
        if (logout != null) {
            model.addAttribute("logoutMessage", "You have been logged out successfully.");
        }

        return "auth/login";
    }

    // =========================================================
    // Registration
    // =========================================================

    @GetMapping("/register")
    public String showRegisterPage(Model model) {
        model.addAttribute("registerDTO", new RegisterDTO());
        return "auth/register";
    }

    @PostMapping("/register")
    public String handleRegistration(
            @Valid @ModelAttribute("registerDTO") RegisterDTO registerDTO,
            BindingResult bindingResult,
            RedirectAttributes redirectAttrs) {

        if (bindingResult.hasErrors()) {
            return "auth/register";
        }

        if (!registerDTO.passwordsMatch()) {
            bindingResult.rejectValue("confirmPassword", "error.registerDTO",
                    "Passwords do not match.");
            return "auth/register";
        }

        try {
            userService.registerUser(registerDTO);
            redirectAttrs.addFlashAttribute("successMessage",
                    "Account created! Please log in.");
            return "redirect:/auth/login";

        } catch (IllegalArgumentException ex) {
            bindingResult.rejectValue("email", "error.registerDTO", ex.getMessage());
            return "auth/register";
        }
    }
}
