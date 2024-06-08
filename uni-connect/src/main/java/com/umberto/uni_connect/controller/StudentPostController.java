package com.umberto.uni_connect.controller;

import com.umberto.uni_connect.controller.payload.request.PostRequest;
import com.umberto.uni_connect.controller.payload.response.PostResponse;
import com.umberto.uni_connect.model.PostModel;
import com.umberto.uni_connect.service.PostService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@RestController
@RequestMapping(path="/api/v1/student/post")
public class StudentPostController {


    @Autowired
    private ModelMapper mapper;

    @Autowired
    private PostService postService;


    @PostMapping
    public ResponseEntity<PostResponse> createPost(
            @RequestHeader("studentId") UUID studentId,
            @RequestBody PostRequest postRequest
    ){
        PostModel postModel = mapper.map(postRequest, PostModel.class);
        PostModel createdPost = postService.createPost(studentId, postModel);
        PostResponse response = mapper.map(createdPost, PostResponse.class);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @GetMapping("/{postId}")
    public ResponseEntity<PostResponse> getPost(
            @RequestHeader("studentId") UUID studentId,
            @PathVariable("postId") UUID postId
    ){
        PostModel postModel = postService.getPost(studentId, postId);
        if (postModel != null) {
            PostResponse response = mapper.map(postModel, PostResponse.class);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping
    public ResponseEntity<List<PostResponse>> getListPost(
            @RequestHeader("studentId") UUID studentId
    ){
        List<PostModel> postModels = postService.getListPost(studentId);
        List<PostResponse> responses = postModels.stream()
                .map(postModel -> mapper.map(postModel, PostResponse.class))
                .collect(Collectors.toList());
        return new ResponseEntity<>(responses, HttpStatus.OK);
    }

    @PutMapping("/{postId}")
    public ResponseEntity<PostResponse> updatePost(
            @RequestHeader("studentId") UUID studentId,
            @PathVariable("postId") UUID postId,
            @RequestBody PostRequest postRequest
    ){
        PostModel newPostModel = mapper.map(postRequest, PostModel.class);
        newPostModel.setID(postId);
        PostModel updatedPost = postService.updatePost(studentId, newPostModel);
        if (updatedPost != null) {
            PostResponse response = mapper.map(updatedPost, PostResponse.class);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{postId}")
    public ResponseEntity<Void> deletePost(
            @RequestHeader("studentId") UUID studentId,
            @PathVariable("postId") UUID postId
    ){
        boolean deleted = postService.deletePost(studentId, postId);
        if (deleted) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
