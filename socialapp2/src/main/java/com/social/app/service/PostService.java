package com.social.app.service;

import com.social.app.exception.ResourceNotFoundException;
import com.social.app.exception.UnauthorizedException;
import com.social.app.model.Post;
import com.social.app.model.User;
import com.social.app.repository.PostRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Handles all Post-related business logic:
 * feed, create, edit, delete, search.
 */
@Service
public class PostService {

    private final PostRepository postRepository;

    public PostService(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    /** Get home feed posts for a user (own + friends only) */
    public List<Post> getFeedForUser(User user) {
        return postRepository.findFeedPostsForUser(user);
    }

    /** Get ALL posts for the public Discover tab */
    public List<Post> getDiscoverPosts() {
        return postRepository.findAllPostsForDiscover();
    }

    /** Get all posts by a specific user */
    public List<Post> getPostsByUser(User user) {
        return postRepository.findByAuthorOrderByCreatedAtDesc(user);
    }

    /** Create a new post */
    @Transactional
    public Post createPost(String content, User author) {
        Post post = new Post(content, author);
        return postRepository.save(post);
    }

    /** Get a single post by ID */
    public Post getPostById(Long postId) {
        return postRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Post not found: " + postId));
    }

    /** Edit a post — only the author can edit */
    @Transactional
    public Post editPost(Long postId, String newContent, User currentUser) {
        Post post = getPostById(postId);

        if (!post.getAuthor().getId().equals(currentUser.getId())) {
            throw new UnauthorizedException("You can only edit your own posts.");
        }

        post.editPost(newContent);
        return postRepository.save(post);
    }

    /** Delete a post — only the author can delete */
    @Transactional
    public void deletePost(Long postId, User currentUser) {
        Post post = getPostById(postId);

        if (!post.getAuthor().getId().equals(currentUser.getId())) {
            throw new UnauthorizedException("You can only delete your own posts.");
        }

        postRepository.delete(post);
    }

    /** Search posts by keyword */
    public List<Post> searchPosts(String keyword) {
        return postRepository.searchByContent(keyword);
    }
}
