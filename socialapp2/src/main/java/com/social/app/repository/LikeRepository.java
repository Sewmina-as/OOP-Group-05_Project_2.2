package com.social.app.repository;

import com.social.app.model.Like;
import com.social.app.model.Post;
import com.social.app.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Data access layer for Like entities.
 */
@Repository
public interface LikeRepository extends JpaRepository<Like, Long> {

    /** Check if a specific user has already liked a specific post */
    boolean existsByUserAndPost(User user, Post post);

    /** Find the Like record for a user-post pair (to delete it on unlike) */
    Optional<Like> findByUserAndPost(User user, Post post);

    /** Total number of likes on a post */
    long countByPost(Post post);
}
