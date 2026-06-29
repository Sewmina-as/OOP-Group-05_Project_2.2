package com.social.app.repository;

import com.social.app.model.Post;
import com.social.app.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Data access layer for Post entities.
 */
@Repository
public interface PostRepository extends JpaRepository<Post, Long> {

    /** All posts by a specific user, newest first */
    List<Post> findByAuthorOrderByCreatedAtDesc(User author);

    /**
     * Fetch posts for the Friends feed:
     * - Posts by the current user
     * - Posts by users who are friends with the current user (in either Friendship position)
     *
     * NOTE: JPQL does not support UNION; the subquery uses OR across both friendship directions.
     */
    @Query("SELECT DISTINCT p FROM Post p WHERE p.author = :user " +
           "OR p.author IN (" +
           "  SELECT f.user2 FROM Friendship f WHERE f.user1 = :user" +
           ") " +
           "OR p.author IN (" +
           "  SELECT f.user1 FROM Friendship f WHERE f.user2 = :user" +
           ") " +
           "ORDER BY p.createdAt DESC")
    List<Post> findFeedPostsForUser(@Param("user") User user);

    /**
     * Fetch ALL posts for the Discover / public timeline tab, newest first.
     */
    @Query("SELECT p FROM Post p ORDER BY p.createdAt DESC")
    List<Post> findAllPostsForDiscover();

    /**
     * Full-text search across post content (case-insensitive).
     */
    @Query("SELECT p FROM Post p WHERE LOWER(p.content) LIKE LOWER(CONCAT('%', :keyword, '%')) ORDER BY p.createdAt DESC")
    List<Post> searchByContent(@Param("keyword") String keyword);
}
