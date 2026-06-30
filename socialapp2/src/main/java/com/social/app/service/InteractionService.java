package com.social.app.service;

import com.social.app.exception.ResourceNotFoundException;
import com.social.app.exception.UnauthorizedException;
import com.social.app.model.Comment;
import com.social.app.model.Like;
import com.social.app.model.Post;
import com.social.app.model.User;
import com.social.app.repository.CommentRepository;
import com.social.app.repository.LikeRepository;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Handles Like and Comment interactions on posts.
 */
@Service
public class InteractionService {

    private final LikeRepository likeRepository;
    private final CommentRepository commentRepository;
    private final NotificationService notificationService;

    public InteractionService(LikeRepository likeRepository,
                              CommentRepository commentRepository,
                              @Lazy NotificationService notificationService) {
        this.likeRepository = likeRepository;
        this.commentRepository = commentRepository;
        this.notificationService = notificationService;
    }

    /**
     * Toggle like on a post.
     * @return true if now liked, false if now unliked
     */
    @Transactional
    public boolean toggleLike(Post post, User user) {
        if (likeRepository.existsByUserAndPost(user, post)) {
            Like existing = likeRepository.findByUserAndPost(user, post)
                    .orElseThrow(() -> new ResourceNotFoundException("Like not found"));
            likeRepository.delete(existing);
            return false;
        } else {
            likeRepository.save(new Like(user, post));
            notificationService.notifyLike(post.getAuthor(), user, post.getId());
            return true;
        }
    }

    /** Check if user has liked a post */
    public boolean hasUserLiked(User user, Post post) {
        return likeRepository.existsByUserAndPost(user, post);
    }

    /** Add a new comment to a post */
    @Transactional
    public Comment addComment(Post post, User author, String content) {
        Comment comment = new Comment(content, author, post);
        Comment saved = commentRepository.save(comment);
        notificationService.notifyComment(post.getAuthor(), author, post.getId(), saved.getId());
        return saved;
    }

    /** Get all comments for a post */
    public List<Comment> getCommentsForPost(Post post) {
        return commentRepository.findByPostOrderByCreatedAtAsc(post);
    }

    /** Delete a comment — only the author can delete */
    @Transactional
    public void deleteComment(Long commentId, User currentUser) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Comment not found: " + commentId));

        if (!comment.getAuthor().getId().equals(currentUser.getId())) {
            throw new UnauthorizedException("You can only delete your own comments.");
        }

        commentRepository.delete(comment);
    }
}
