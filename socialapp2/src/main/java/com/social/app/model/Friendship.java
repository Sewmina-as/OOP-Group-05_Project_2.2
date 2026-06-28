package com.social.app.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

/**
 * Represents an established friendship between two users.
 * Created when a FriendRequest is accepted.
 */
@Entity
@Table(
    name = "friendships",
    uniqueConstraints = @UniqueConstraint(
        name = "uq_friendship",
        columnNames = {"user1_id", "user2_id"}
    )
)
public class Friendship {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "since", nullable = false)
    private LocalDateTime since;

    // =========================================================
    // Relationships
    // =========================================================

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user1_id", nullable = false)
    private User user1;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user2_id", nullable = false)
    private User user2;

    // =========================================================
    // Constructors
    // =========================================================

    public Friendship() {}

    public Friendship(User user1, User user2) {
        this.user1 = user1;
        this.user2 = user2;
    }

    // =========================================================
    // Lifecycle
    // =========================================================

    @PrePersist
    public void setSince() {
        this.since = LocalDateTime.now();
    }

    // =========================================================
    // Business Logic
    // =========================================================

    /**
     * Returns the other user in this friendship from a given user's perspective.
     *
     * @param currentUser the user whose perspective we're viewing from
     * @return the other user in this friendship
     */
    public User getOtherUser(User currentUser) {
        return user1.getId().equals(currentUser.getId()) ? user2 : user1;
    }

    // =========================================================
    // Getters and Setters
    // =========================================================

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public LocalDateTime getSince() { return since; }
    public void setSince(LocalDateTime since) { this.since = since; }

    public User getUser1() { return user1; }
    public void setUser1(User user1) { this.user1 = user1; }

    public User getUser2() { return user2; }
    public void setUser2(User user2) { this.user2 = user2; }
}
