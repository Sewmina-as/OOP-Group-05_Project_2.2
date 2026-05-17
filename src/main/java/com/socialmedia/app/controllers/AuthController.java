package com.socialmedia.app.controllers;

import com.socialmedia.app.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {
    private final UserService userService;

    public AuthController(UserService userService){
        this.userService = userService;
    }

    @GetMapping("/register")
    public String register(){
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(
            @RequestParam String email,
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam String password){

        userService.create(email, firstName, lastName, password);
        return "redirect:/register?success=true";
    }
}
