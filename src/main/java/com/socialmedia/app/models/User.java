package com.socialmedia.app.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;

import java.time.LocalDateTime;
import java.util.Locale;

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

    @Column(length = 300)
    private String bio;


    public User(){

    }

    public User(Long id, String email, String firstName, String lastName, String password, String bio, LocalDateTime joinDate){
        this.id = id;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.bio = bio;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
