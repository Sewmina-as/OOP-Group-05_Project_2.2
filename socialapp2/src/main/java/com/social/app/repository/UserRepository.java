package com.social.app.repository;

import com.social.app.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Data access layer for User entities.
 * Spring Data JPA automatically implements CRUD methods.
 */
@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    /** Find user by email (used during login) */
    Optional<User> findByEmail(String email);

    /** Check if an email is already registered */
    boolean existsByEmail(String email);

    /**
     * Search users by first or last name (case-insensitive).
     * Used by the search functionality.
     *
     * @param keyword the search term
     */
    @Query("SELECT u FROM User u WHERE " +
           "LOWER(u.firstName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(u.lastName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(u.email) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<User> searchByName(@Param("keyword") String keyword);
}
