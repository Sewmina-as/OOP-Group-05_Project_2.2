package com.social.app.service;

import com.social.app.NotificationType;
import com.social.app.model.Notification;
import com.social.app.model.User;
import com.social.app.repository.NotificationRepository;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Handles creation and retrieval of notifications.
 * Call the notify* methods from services that perform the triggering action.
 */
@Service
public class NotificationService {

    private final NotificationRepository notificationRepository;

    public NotificationService(NotificationRepository notificationRepository) {
        this.notificationRepository = notificationRepository;
    }

    // ============================================================
    // CREATE
    // ============================================================

    /** Call after a like is saved. */
    @Transactional
    public void notifyLike(User postAuthor, User liker, Long postId) {
        if (postAuthor.getId().equals(liker.getId())) return; // don't notify yourself
        if (notificationRepository.existsByRecipientIdAndActorIdAndTypeAndPostId(
                postAuthor.getId(), liker.getId(), NotificationType.LIKE, postId)) {
            return; // avoid duplicate spam from rapid like/unlike/like
        }
        Notification n = new Notification(postAuthor, liker, NotificationType.LIKE);
        n.setPostId(postId);
        notificationRepository.save(n);
    }

    /** Call after a comment is saved. */
    @Transactional
    public void notifyComment(User postAuthor, User commenter, Long postId, Long commentId) {
        if (postAuthor.getId().equals(commenter.getId())) return;
        Notification n = new Notification(postAuthor, commenter, NotificationType.COMMENT);
        n.setPostId(postId);
        n.setCommentId(commentId);
        notificationRepository.save(n);
    }

    /** Call after a friend request is sent. */
    @Transactional
    public void notifyFriendRequest(User receiver, User sender, Long friendRequestId) {
        Notification n = new Notification(receiver, sender, NotificationType.FRIEND_REQUEST);
        n.setFriendRequestId(friendRequestId);
        notificationRepository.save(n);
    }

    /** Call after a friend request is accepted. */
    @Transactional
    public void notifyFriendAccepted(User originalSender, User accepter, Long friendRequestId) {
        Notification n = new Notification(originalSender, accepter, NotificationType.FRIEND_ACCEPTED);
        n.setFriendRequestId(friendRequestId);
        notificationRepository.save(n);
    }

    // ============================================================
    // READ
    // ============================================================

    /** Latest N notifications for the navbar dropdown. */
    public List<Notification> getRecent(Long userId, int limit) {
        return notificationRepository.findByRecipientIdOrderByCreatedAtDesc(
                userId, PageRequest.of(0, limit));
    }

    public long getUnreadCount(Long userId) {
        return notificationRepository.countByRecipientIdAndReadFalse(userId);
    }

    // ============================================================
    // UPDATE
    // ============================================================

    @Transactional
    public void markAsRead(Long notificationId, Long userId) {
        notificationRepository.markAsRead(notificationId, userId);
    }

    @Transactional
    public void markAllAsRead(Long userId) {
        notificationRepository.markAllAsRead(userId);
    }
}
