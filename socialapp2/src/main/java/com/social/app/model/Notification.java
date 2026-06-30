package com.social.app.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * A single notification belonging to one recipient.
 *
 * postId / commentId / friendRequestId are kept as plain Long FKs rather than
 * full @ManyToOne relations on purpose — notifications outlive their source
 * (e.g. a comment can be deleted later), and we don't want a dangling
 * relation to break notification rendering.
 */
@Entity
@Table(name = "notifications", indexes = {
        @Index(name = "idx_notif_recipient_created", columnList = "recipient_id, created_at"),
        @Index(name = "idx_notif_recipient_read", columnList = "recipient_id, is_read")
})
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "recipient_id", nullable = false)
    private User recipient;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "actor_id", nullable = false)
    private User actor;

    @Enumerated(EnumType.STRING)
    @Column(name = "type", nullable = false, length = 30)
    private com.social.app.NotificationType type;

    @Column(name = "post_id")
    private Long postId;

    @Column(name = "comment_id")
    private Long commentId;

    @Column(name = "friend_request_id")
    private Long friendRequestId;

    @Column(name = "is_read", nullable = false)
    private boolean read = false;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    public Notification() {}

    public Notification(User recipient, User actor, com.social.app.NotificationType type) {
        this.recipient = recipient;
        this.actor = actor;
        this.type = type;
    }

    // ---- getters / setters ----

    public Long getId() { return id; }

    public User getRecipient() { return recipient; }
    public void setRecipient(User recipient) { this.recipient = recipient; }

    public User getActor() { return actor; }
    public void setActor(User actor) { this.actor = actor; }

    public com.social.app.NotificationType getType() { return type; }
    public void setType(com.social.app.NotificationType type) { this.type = type; }

    public Long getPostId() { return postId; }
    public void setPostId(Long postId) { this.postId = postId; }

    public Long getCommentId() { return commentId; }
    public void setCommentId(Long commentId) { this.commentId = commentId; }

    public Long getFriendRequestId() { return friendRequestId; }
    public void setFriendRequestId(Long friendRequestId) { this.friendRequestId = friendRequestId; }

    public boolean isRead() { return read; }
    public void setRead(boolean read) { this.read = read; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    /** Convenience: where should clicking this notification link to? */
    public String resolveLink() {
        switch (type) {
            case LIKE:
            case COMMENT:
                return "/feed#post-" + postId;
            case FRIEND_REQUEST:
            case FRIEND_ACCEPTED:
                return "/profile/" + actor.getId();
            default:
                return "/feed";
        }
    }

    /** Convenience: human-readable message body for the dropdown / email / etc. */
    public String resolveMessage() {
        switch (type) {
            case LIKE:           return " liked your post";
            case COMMENT:        return " commented on your post";
            case FRIEND_REQUEST: return " sent you a friend request";
            case FRIEND_ACCEPTED: return " accepted your friend request";
            default:             return "";
        }
    }
}
