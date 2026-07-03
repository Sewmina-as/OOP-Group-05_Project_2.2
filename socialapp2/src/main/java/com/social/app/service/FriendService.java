package com.social.app.service;

import com.social.app.exception.ResourceNotFoundException;
import com.social.app.model.FriendRequest;
import com.social.app.model.Friendship;
import com.social.app.model.User;
import com.social.app.repository.FriendRequestRepository;
import com.social.app.repository.FriendshipRepository;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Handles friend requests and friendships.
 * Lifecycle: Send → Accept/Reject → Friendship created if accepted.
 */
@Service
public class FriendService {

    private final FriendRequestRepository friendRequestRepository;
    private final FriendshipRepository friendshipRepository;
    private final NotificationService notificationService;

    public FriendService(FriendRequestRepository friendRequestRepository,
                         FriendshipRepository friendshipRepository,
                         @Lazy NotificationService notificationService) {
        this.friendRequestRepository = friendRequestRepository;
        this.friendshipRepository = friendshipRepository;
        this.notificationService = notificationService;
    }

    /** Send a friend request */
    @Transactional
    public FriendRequest sendFriendRequest(User sender, User receiver) {
        if (sender.getId().equals(receiver.getId())) {
            throw new IllegalStateException("You cannot send a friend request to yourself.");
        }
        if (friendshipRepository.areFriends(sender, receiver)) {
            throw new IllegalStateException("You are already friends with this user.");
        }
        if (friendRequestRepository.existsBySenderAndReceiver(sender, receiver)) {
            throw new IllegalStateException("Friend request already sent.");
        }

        FriendRequest request = new FriendRequest(sender, receiver);
        FriendRequest saved = friendRequestRepository.save(request);
        notificationService.notifyFriendRequest(receiver, sender, saved.getId());
        return saved;
    }

    /** Accept a friend request — creates a Friendship */
    @Transactional
    public Friendship acceptFriendRequest(Long requestId, User currentUser) {
        FriendRequest request = getRequestById(requestId);

        if (!request.getReceiver().getId().equals(currentUser.getId())) {
            throw new IllegalStateException("You cannot accept this request.");
        }

        request.accept();
        friendRequestRepository.save(request);

        Friendship friendship = new Friendship(request.getSender(), request.getReceiver());
        Friendship saved = friendshipRepository.save(friendship);
        notificationService.notifyFriendAccepted(request.getSender(), currentUser, requestId);
        return saved;
    }

    /** Reject a friend request */
    @Transactional
    public void rejectFriendRequest(Long requestId, User currentUser) {
        FriendRequest request = getRequestById(requestId);

        if (!request.getReceiver().getId().equals(currentUser.getId())) {
            throw new IllegalStateException("You cannot reject this request.");
        }

        request.decline();
        friendRequestRepository.save(request);
    }

    /** Get all friends of a user as a list of User objects */
    public List<User> getFriendsOf(User user) {
        return friendshipRepository.findAllFriendshipsForUser(user)
                .stream()
                .map(f -> f.getOtherUser(user))
                .collect(Collectors.toList());
    }

    /** Get all pending friend requests for a user */
    public List<FriendRequest> getPendingRequestsFor(User user) {
        return friendRequestRepository.findByReceiverAndStatus(user, FriendRequest.Status.PENDING);
    }

    /** Check if two users are friends */
    public boolean areFriends(User u1, User u2) {
        return friendshipRepository.areFriends(u1, u2);
    }

    /** Check if a friend request already exists */
    public boolean hasExistingRequest(User sender, User receiver) {
        return friendRequestRepository.existsBySenderAndReceiver(sender, receiver);
    }

    private FriendRequest getRequestById(Long id) {
        return friendRequestRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Friend request not found: " + id));
    }
}
