package com.social.app.service;

import com.social.app.dto.RegisterDTO;
import com.social.app.dto.UpdateProfileDTO;
import com.social.app.exception.ResourceNotFoundException;
import com.social.app.model.User;
import com.social.app.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Handles all User-related business logic:
 * registration, retrieval, profile updates, search.
 */
@Service
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    /** Register a new user account */
    @Transactional
    public User registerUser(RegisterDTO dto) {
        if (userRepository.existsByEmail(dto.getEmail())) {
            throw new IllegalArgumentException("An account with this email already exists.");
        }

        User user = new User(
                dto.getFirstName(),
                dto.getLastName(),
                dto.getEmail(),
                passwordEncoder.encode(dto.getPassword())
        );

        return userRepository.save(user);
    }

    /** Get user by ID */
    public User getUserById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with id: " + id));
    }

    /** Get user by email */
    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found: " + email));
    }

    /** Search users by name keyword */
    public List<User> searchUsers(String keyword) {
        return userRepository.searchByName(keyword);
    }

    /** Update profile info */
    @Transactional
    public User updateProfile(Long userId, UpdateProfileDTO dto) {
        User user = getUserById(userId);
        user.updateProfile(dto.getFirstName(), dto.getLastName(), dto.getBio());
        return userRepository.save(user);
    }

    /** Save updated profile picture filename */
    @Transactional
    public void updateProfilePicture(Long userId, String filename) {
        User user = getUserById(userId);
        user.setProfilePicture(filename);
        userRepository.save(user);
    }
}
