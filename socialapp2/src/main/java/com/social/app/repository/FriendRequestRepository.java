package com.social.app.repository;

import com.social.app.model.FriendRequest;
import com.social.app.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Data access layer for FriendRequest entities.
 */
@Repository
public interface FriendRequestRepository extends JpaRepository<FriendRequest, Long> {

    /** All pending requests received by a user */
    List<FriendRequest> findByReceiverAndStatus(User receiver, FriendRequest.Status status);

    /** All pending requests sent by a user */
    List<FriendRequest> findBySenderAndStatus(User sender, FriendRequest.Status status);

    /** Find a request between two specific users (any status) */
    Optional<FriendRequest> findBySenderAndReceiver(User sender, User receiver);

    /** Check if any request exists between two users in either direction */
    boolean existsBySenderAndReceiver(User sender, User receiver);
}
