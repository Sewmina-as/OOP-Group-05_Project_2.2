package com.social.app.controller;

import com.social.app.dto.NotificationDTO;
import com.social.app.dto.UpdateProfileDTO;
import com.social.app.model.User;
import com.social.app.service.FriendService;
import com.social.app.service.NotificationService;
import com.social.app.service.PostService;
import com.social.app.service.UserService;
import jakarta.validation.Valid;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.stream.Collectors;

@Controller
public class ProfileController {

    private final UserService userService;
    private final PostService postService;
    private final FriendService friendService;
    private final NotificationService notificationService;

    public ProfileController(UserService userService,
                             PostService postService,
                             FriendService friendService,
                             @Lazy NotificationService notificationService) {
        this.userService = userService;
        this.postService = postService;
        this.friendService = friendService;
        this.notificationService = notificationService;
    }

    /** Injects notification data into every GET response from this controller. */
    private void addNotifData(User currentUser, Model model) {
        long unreadCount = notificationService.getUnreadCount(currentUser.getId());
        List<NotificationDTO> recent = notificationService
                .getRecent(currentUser.getId(), 20)
                .stream()
                .map(NotificationDTO::from)
                .collect(Collectors.toList());
        model.addAttribute("unreadNotificationCount", unreadCount);
        model.addAttribute("recentNotifications", recent);
    }

    @GetMapping("/profile/{userId}")
    public String viewProfile(
            @PathVariable Long userId,
            @AuthenticationPrincipal UserDetails userDetails,
            Model model) {

        User currentUser = userService.getUserByEmail(userDetails.getUsername());
        User profileUser = userService.getUserById(userId);

        addNotifData(currentUser, model);

        model.addAttribute("currentUser", currentUser);
        model.addAttribute("profileUser", profileUser);
        model.addAttribute("posts", postService.getPostsByUser(profileUser));
        model.addAttribute("friends", friendService.getFriendsOf(profileUser));
        model.addAttribute("isFriend", friendService.areFriends(currentUser, profileUser));
        model.addAttribute("hasRequestSent", friendService.hasExistingRequest(currentUser, profileUser));
        model.addAttribute("hasRequestReceived", friendService.hasExistingRequest(profileUser, currentUser));
        model.addAttribute("isOwnProfile", currentUser.getId().equals(profileUser.getId()));
        model.addAttribute("pendingRequests", friendService.getPendingRequestsFor(currentUser));

        return "profile/view";
    }

    @GetMapping("/profile/edit")
    public String showEditProfileForm(
            @AuthenticationPrincipal UserDetails userDetails,
            Model model) {

        User currentUser = userService.getUserByEmail(userDetails.getUsername());
        addNotifData(currentUser, model);

        UpdateProfileDTO dto = new UpdateProfileDTO(
                currentUser.getFirstName(),
                currentUser.getLastName(),
                currentUser.getBio()
        );

        model.addAttribute("currentUser", currentUser);
        model.addAttribute("updateProfileDTO", dto);
        return "profile/edit";
    }

    @PostMapping("/profile/edit")
    public String handleEditProfile(
            @Valid @ModelAttribute("updateProfileDTO") UpdateProfileDTO dto,
            BindingResult bindingResult,
            @AuthenticationPrincipal UserDetails userDetails,
            Model model,
            RedirectAttributes redirectAttrs) {

        User currentUser = userService.getUserByEmail(userDetails.getUsername());

        if (bindingResult.hasErrors()) {
            model.addAttribute("currentUser", currentUser);
            return "profile/edit";
        }

        userService.updateProfile(currentUser.getId(), dto);
        redirectAttrs.addFlashAttribute("successMessage", "Profile updated successfully!");
        return "redirect:/profile/" + currentUser.getId();
    }

    @PostMapping("/friends/request/{receiverId}")
    public String sendFriendRequest(
            @PathVariable Long receiverId,
            @AuthenticationPrincipal UserDetails userDetails,
            RedirectAttributes redirectAttrs) {

        User currentUser = userService.getUserByEmail(userDetails.getUsername());
        User receiver = userService.getUserById(receiverId);

        try {
            friendService.sendFriendRequest(currentUser, receiver);
            redirectAttrs.addFlashAttribute("successMessage", "Friend request sent!");
        } catch (IllegalStateException e) {
            redirectAttrs.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/profile/" + receiverId;
    }

    @PostMapping("/friends/accept/{requestId}")
    public String acceptFriendRequest(
            @PathVariable Long requestId,
            @AuthenticationPrincipal UserDetails userDetails,
            RedirectAttributes redirectAttrs) {

        User currentUser = userService.getUserByEmail(userDetails.getUsername());

        try {
            friendService.acceptFriendRequest(requestId, currentUser);
            redirectAttrs.addFlashAttribute("successMessage", "Friend request accepted!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/feed";
    }

    @PostMapping("/friends/reject/{requestId}")
    public String rejectFriendRequest(
            @PathVariable Long requestId,
            @AuthenticationPrincipal UserDetails userDetails,
            RedirectAttributes redirectAttrs) {

        User currentUser = userService.getUserByEmail(userDetails.getUsername());

        try {
            friendService.rejectFriendRequest(requestId, currentUser);
            redirectAttrs.addFlashAttribute("infoMessage", "Friend request declined.");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/feed";
    }

    @GetMapping("/search")
    public String search(
            @RequestParam(required = false, defaultValue = "") String keyword,
            @AuthenticationPrincipal UserDetails userDetails,
            Model model) {

        User currentUser = userService.getUserByEmail(userDetails.getUsername());
        addNotifData(currentUser, model);

        model.addAttribute("currentUser", currentUser);
        model.addAttribute("keyword", keyword);
        model.addAttribute("pendingRequests", friendService.getPendingRequestsFor(currentUser));
        model.addAttribute("users", keyword.isEmpty() ? List.of() : userService.searchUsers(keyword));
        model.addAttribute("posts", keyword.isEmpty() ? List.of() : postService.searchPosts(keyword));

        return "search";
    }
}
