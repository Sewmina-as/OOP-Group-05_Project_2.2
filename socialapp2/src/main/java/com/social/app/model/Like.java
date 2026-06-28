package com.social.app.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

/**
 * Represents a like given by a user to a post.
 * Unique constraint prevents a user from liking the same post twice.
 */
@Entity
@Table(
    name = "likes",
    uniqueConstraints = @UniqueConstraint(
        name = "uq_user_post_like",
        columnNames = {"user_id", "post_id"}
    )
)
public class Like {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    // =========================================================
    // Relationships
    // =========================================================

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "post_id", nullable = false)
    private Post post;

    // =========================================================
    // Constructors
    // =========================================================

    public Like() {}

    public Like(User user, Post post) {
        this.user = user;
        this.post = post;
    }

    // =========================================================
    // Lifecycle
    // =========================================================

    @PrePersist
    public void setCreatedAt() {
        this.createdAt = LocalDateTime.now();
    }

    // =========================================================
    // Getters and Setters
    // =========================================================

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Post getPost() { return post; }
    public void setPost(Post post) { this.post = post; }
}
