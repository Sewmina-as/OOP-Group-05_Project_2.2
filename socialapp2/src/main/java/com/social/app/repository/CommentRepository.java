package com.social.app.repository;

import com.social.app.model.Comment;
import com.social.app.model.Post;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Data access layer for Comment entities.
 */
@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {

    /** All comments on a given post, ordered oldest first */
    List<Comment> findByPostOrderByCreatedAtAsc(Post post);

    /** Count comments on a post */
    long countByPost(Post post);
}
