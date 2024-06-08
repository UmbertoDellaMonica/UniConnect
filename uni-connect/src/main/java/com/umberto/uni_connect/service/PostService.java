package com.umberto.uni_connect.service;

import com.umberto.uni_connect.model.PostModel;

import java.util.List;
import java.util.UUID;

public interface PostService {
    /**
     * Creates a new post for the specified student.
     *
     * @param studentId The ID of the student who creates the post.
     * @param postModel The model containing post data.
     * @return The created post model.
     */
    PostModel createPost(UUID studentId, PostModel postModel);

    /**
     * Retrieves a specific post belonging to the specified student.
     *
     * @param studentId The ID of the student who owns the post.
     * @param postId The ID of the post to retrieve.
     * @return The post model if found, otherwise null.
     */
    PostModel getPost(UUID studentId, UUID postId);

    /**
     * Retrieves a list of all posts belonging to the specified student.
     *
     * @param studentId The ID of the student.
     * @return A list of post models owned by the student.
     */
    List<PostModel> getListPost(UUID studentId);

    /**
     * Updates a specific post belonging to the specified student.
     *
     * @param studentId The ID of the student who owns the post.
     * @param newPostModel The updated post model.
     * @return The updated post model if successful, otherwise null.
     */
    PostModel updatePost(UUID studentId, PostModel newPostModel);

    /**
     * Deletes a specific post belonging to the specified student.
     *
     * @param studentId The ID of the student who owns the post.
     * @param postId The ID of the post to delete.
     * @return True if the post was successfully deleted, otherwise false.
     */
    Boolean deletePost(UUID studentId, UUID postId);

}
