package com.social.app.controller;

import com.social.app.dto.NotificationDTO;
import com.social.app.model.User;
import com.social.app.service.NotificationService;
import com.social.app.service.UserService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * JSON REST endpoints consumed by app.js to keep the notification bell live
 * without a full page reload. The initial render of the dropdown on page
 * load is done server-side in the navbar fragment (progressive enhancement).
 */
@RestController
@RequestMapping("/api/notifications")
public class NotificationController {

    private final NotificationService notificationService;
    private final UserService userService;

    public NotificationController(NotificationService notificationService,
                                  UserService userService) {
        this.notificationService = notificationService;
        this.userService = userService;
    }

    /** Polled every ~30s by app.js to update the badge count live. */
    @GetMapping("/unread-count")
    public Map<String, Long> unreadCount(@AuthenticationPrincipal UserDetails userDetails) {
        User currentUser = userService.getUserByEmail(userDetails.getUsername());
        return Map.of("count", notificationService.getUnreadCount(currentUser.getId()));
    }

    /** Fetched when the bell is opened, to refresh the dropdown contents. */
    @GetMapping("/recent")
    public List<NotificationDTO> recent(@AuthenticationPrincipal UserDetails userDetails) {
        User currentUser = userService.getUserByEmail(userDetails.getUsername());
        return notificationService.getRecent(currentUser.getId(), 20)
                .stream()
                .map(NotificationDTO::from)
                .collect(Collectors.toList());
    }

    @PostMapping("/{id}/read")
    public void markAsRead(@PathVariable Long id,
                           @AuthenticationPrincipal UserDetails userDetails) {
        User currentUser = userService.getUserByEmail(userDetails.getUsername());
        notificationService.markAsRead(id, currentUser.getId());
    }

    @PostMapping("/read-all")
    public void markAllAsRead(@AuthenticationPrincipal UserDetails userDetails) {
        User currentUser = userService.getUserByEmail(userDetails.getUsername());
        notificationService.markAllAsRead(currentUser.getId());
    }
}
