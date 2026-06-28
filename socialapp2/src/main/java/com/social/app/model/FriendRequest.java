package com.social.app.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

/**
 * Represents a friend request between two users.
 * Status moves from PENDING → ACCEPTED or REJECTED.
 */
@Entity
@Table(
    name = "friend_requests",
    uniqueConstraints = @UniqueConstraint(
        name = "uq_sender_receiver",
        columnNames = {"sender_id", "receiver_id"}
    )
)
public class FriendRequest {

    /** Possible states of a friend request */
    public enum Status {
        PENDING, ACCEPTED, REJECTED
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Status status = Status.PENDING;

    @Column(name = "sent_at", nullable = false)
    private LocalDateTime sentAt;

    // =========================================================
    // Relationships
    // =========================================================

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sender_id", nullable = false)
    private User sender;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "receiver_id", nullable = false)
    private User receiver;

    // =========================================================
    // Constructors
    // =========================================================

    public FriendRequest() {}

    public FriendRequest(User sender, User receiver) {
        this.sender = sender;
        this.receiver = receiver;
    }

    // =========================================================
    // Lifecycle
    // =========================================================

    @PrePersist
    public void setSentAt() {
        this.sentAt = LocalDateTime.now();
    }

    // =========================================================
    // Business Logic
    // =========================================================

    /** Accept this friend request */
    public void accept() {
        this.status = Status.ACCEPTED;
    }

    /** Decline this friend request */
    public void decline() {
        this.status = Status.REJECTED;
    }

    /** Check if still pending */
    public boolean isPending() {
        return this.status == Status.PENDING;
    }

    // =========================================================
    // Getters and Setters
    // =========================================================

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }

    public LocalDateTime getSentAt() { return sentAt; }
    public void setSentAt(LocalDateTime sentAt) { this.sentAt = sentAt; }

    public User getSender() { return sender; }
    public void setSender(User sender) { this.sender = sender; }

    public User getReceiver() { return receiver; }
    public void setReceiver(User receiver) { this.receiver = receiver; }
}
