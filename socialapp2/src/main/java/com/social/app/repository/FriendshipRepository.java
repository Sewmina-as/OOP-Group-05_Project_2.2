package com.social.app.repository;

import com.social.app.model.Friendship;
import com.social.app.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Data access layer for Friendship entities.
 */
@Repository
public interface FriendshipRepository extends JpaRepository<Friendship, Long> {

    /**
     * Get all friends of a user.
     * Checks both user1 and user2 positions since friendship is symmetric.
     */
    @Query("SELECT f FROM Friendship f WHERE f.user1 = :user OR f.user2 = :user")
    List<Friendship> findAllFriendshipsForUser(@Param("user") User user);

    /**
     * Check if two users are already friends.
     */
    @Query("SELECT f FROM Friendship f WHERE " +
           "(f.user1 = :u1 AND f.user2 = :u2) OR (f.user1 = :u2 AND f.user2 = :u1)")
    Optional<Friendship> findFriendshipBetween(@Param("u1") User u1, @Param("u2") User u2);

    /**
     * Check friendship status as a boolean.
     */
    @Query("SELECT COUNT(f) > 0 FROM Friendship f WHERE " +
           "(f.user1 = :u1 AND f.user2 = :u2) OR (f.user1 = :u2 AND f.user2 = :u1)")
    boolean areFriends(@Param("u1") User u1, @Param("u2") User u2);
}
