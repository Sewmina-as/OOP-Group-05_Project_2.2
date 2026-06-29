package com.social.app.controller;

import com.social.app.model.User;
import com.social.app.service.NotificationService;
import com.social.app.service.UserService;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;

/**
 * Web (non-REST) notification actions that need to redirect after POST.
 * The REST API endpoints (for JS polling) live in NotificationController.
 */
@Controller
public class NotificationWebController {

    private final NotificationService notificationService;
    private final UserService userService;

    public NotificationWebController(@Lazy NotificationService notificationService,
                                     UserService userService) {
        this.notificationService = notificationService;
        this.userService = userService;
    }

    /** Called from the "Mark all read" button in the navbar bell dropdown. */
    @PostMapping("/notifications/read-all")
    public String markAllRead(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestHeader(value = "Referer", defaultValue = "/feed") String referer) {

        User currentUser = userService.getUserByEmail(userDetails.getUsername());
        notificationService.markAllAsRead(currentUser.getId());
        return "redirect:" + referer;
    }
}
