package com.socialmedia.app.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    @NotBlank
    @Email(message = "Please enter a valid email!")
    private String email;

    @Column(nullable = false)
    @NotBlank(message = "First name is required!")
    private String firstName;

    @Column(nullable = false)
    @NotBlank(message = "Last name is required!")
    private String lastName;

    @Column(nullable = false)
    @NotBlank(message = "Password cannot be empty!")
    @Min(value = 8)
    private String password;
}
