package com.social.app.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Represents a post created by a user.
 *
 * OOP Concepts:
 *  - Encapsulation: private fields with getters/setters
 *  - Association: belongs to User, has many Comments and Likes
 */
@Entity
@Table(name = "posts")
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Post content cannot be empty")
    @Size(max = 1000, message = "Post cannot exceed 1000 characters")
    @Column(nullable = false, columnDefinition = "TEXT")
    private String content;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "image_filename")
    private String imageFilename;

    // =========================================================
    // Relationships
    // =========================================================

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "author_id", nullable = false)
    private User author;

    @OneToMany(mappedBy = "post", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("createdAt ASC")
    private List<Comment> comments = new ArrayList<>();

    @OneToMany(mappedBy = "post", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Like> likes = new ArrayList<>();

    // =========================================================
    // Constructors
    // =========================================================

    public Post() {}

    public Post(String content, User author) {
        this.content = content;
        this.author = author;
    }

    // =========================================================
    // Lifecycle
    // =========================================================

    @PrePersist
    public void setCreatedAt() {
        this.createdAt = LocalDateTime.now();
    }

    // =========================================================
    // Business Logic
    // =========================================================

    /** Update the content of this post */
    public void editPost(String newContent) {
        this.content = newContent;
    }

    /** Get total like count */
    public int getLikeCount() {
        return likes != null ? likes.size() : 0;
    }

    /** Check if a specific user has liked this post */
    public boolean isLikedByUser(Long userId) {
        return likes.stream()
                .anyMatch(like -> like.getUser().getId().equals(userId));
    }

    // =========================================================
    // Getters and Setters
    // =========================================================

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public String getImageFilename() { return imageFilename; }
    public void setImageFilename(String imageFilename) { this.imageFilename = imageFilename; }

    public User getAuthor() { return author; }
    public void setAuthor(User author) { this.author = author; }

    public List<Comment> getComments() { return comments; }
    public void setComments(List<Comment> comments) { this.comments = comments; }

    public List<Like> getLikes() { return likes; }
    public void setLikes(List<Like> likes) { this.likes = likes; }
}
