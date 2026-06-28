package com.social.app.dto;

import jakarta.validation.constraints.*;

/**
 * Data Transfer Object for updating a user's profile.
 */
public class UpdateProfileDTO {

    @NotBlank(message = "First name is required")
    @Size(max = 50)
    private String firstName;

    @NotBlank(message = "Last name is required")
    @Size(max = 50)
    private String lastName;

    @Size(max = 500, message = "Bio must be under 500 characters")
    private String bio;

    public UpdateProfileDTO() {}

    public UpdateProfileDTO(String firstName, String lastName, String bio) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.bio = bio;
    }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }
}
