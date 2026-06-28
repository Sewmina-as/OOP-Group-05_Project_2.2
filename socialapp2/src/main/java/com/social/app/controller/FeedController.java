package com.social.app.controller;

import com.social.app.model.Post;
import com.social.app.model.User;
import com.social.app.service.FriendService;
import com.social.app.service.InteractionService;
import com.social.app.service.PostService;
import com.social.app.service.UserService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

/**
 * Controller for the home feed and post/comment/like actions.
 */
@Controller
public class FeedController {

    private final PostService postService;
    private final UserService userService;
    private final InteractionService interactionService;
    private final FriendService friendService;

    public FeedController(PostService postService,
                          UserService userService,
                          InteractionService interactionService,
                          FriendService friendService) {
        this.postService = postService;
        this.userService = userService;
        this.interactionService = interactionService;
        this.friendService = friendService;
    }

    @GetMapping("/feed")
    public String showFeed(
            @RequestParam(value = "tab", defaultValue = "friends") String tab,
            @AuthenticationPrincipal UserDetails userDetails,
            Model model) {

        User currentUser = userService.getUserByEmail(userDetails.getUsername());

        List<Post> posts = tab.equals("discover")
                ? postService.getDiscoverPosts()
                : postService.getFeedForUser(currentUser);

        model.addAttribute("currentUser", currentUser);
        model.addAttribute("posts", posts);
        model.addAttribute("activeTab", tab);
        model.addAttribute("friends", friendService.getFriendsOf(currentUser));
        model.addAttribute("pendingRequests", friendService.getPendingRequestsFor(currentUser));

        return "feed";
    }

    @PostMapping("/posts/create")
    public String createPost(
            @RequestParam String content,
            @RequestParam(value = "tab", defaultValue = "friends") String tab,
            @AuthenticationPrincipal UserDetails userDetails,
            RedirectAttributes redirectAttrs) {

        User currentUser = userService.getUserByEmail(userDetails.getUsername());

        if (content == null || content.trim().isEmpty()) {
            redirectAttrs.addFlashAttribute("errorMessage", "Post content cannot be empty.");
            return "redirect:/feed?tab=" + tab;
        }

        postService.createPost(content.trim(), currentUser);
        redirectAttrs.addFlashAttribute("successMessage", "Post created!");
        return "redirect:/feed?tab=" + tab;
    }

    @PostMapping("/posts/{postId}/delete")
    public String deletePost(
            @PathVariable Long postId,
            @AuthenticationPrincipal UserDetails userDetails,
            RedirectAttributes redirectAttrs) {

        User currentUser = userService.getUserByEmail(userDetails.getUsername());

        try {
            postService.deletePost(postId, currentUser);
            redirectAttrs.addFlashAttribute("successMessage", "Post deleted.");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/feed";
    }

    @PostMapping("/posts/{postId}/like")
    public String toggleLike(
            @PathVariable Long postId,
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestHeader(value = "Referer", defaultValue = "/feed") String referer) {

        User currentUser = userService.getUserByEmail(userDetails.getUsername());
        Post post = postService.getPostById(postId);
        interactionService.toggleLike(post, currentUser);

        return "redirect:" + referer;
    }

    @PostMapping("/posts/{postId}/comment")
    public String addComment(
            @PathVariable Long postId,
            @RequestParam String content,
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestHeader(value = "Referer", defaultValue = "/feed") String referer,
            RedirectAttributes redirectAttrs) {

        User currentUser = userService.getUserByEmail(userDetails.getUsername());
        Post post = postService.getPostById(postId);

        if (content == null || content.trim().isEmpty()) {
            redirectAttrs.addFlashAttribute("errorMessage", "Comment cannot be empty.");
        } else {
            interactionService.addComment(post, currentUser, content.trim());
        }

        return "redirect:" + referer;
    }

    @PostMapping("/comments/{commentId}/delete")
    public String deleteComment(
            @PathVariable Long commentId,
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestHeader(value = "Referer", defaultValue = "/feed") String referer,
            RedirectAttributes redirectAttrs) {

        User currentUser = userService.getUserByEmail(userDetails.getUsername());

        try {
            interactionService.deleteComment(commentId, currentUser);
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:" + referer;
    }
}