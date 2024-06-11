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

    /**
     *
     * @param IDStudent
     * @param postRequest
     * @return
     */

    @PostMapping(path = "",produces = "application/json; charset=UTF-8")
    public ResponseEntity<PostResponse> createPost(
            @RequestHeader("IDStudent") UUID IDStudent,
            @RequestBody PostRequest postRequest
    ){
        PostModel postModel = mapper.map(postRequest, PostModel.class);
        PostModel createdPost = postService.createPost(IDStudent, postModel);
        PostResponse response = mapper.map(createdPost, PostResponse.class);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    /**
     *
     * @param IDStudent
     * @param postId
     * @return
     */
    @GetMapping(path = "/{IDPost}",produces = "application/json; charset=UTF-8")
    public ResponseEntity<PostResponse> getPost(
            @RequestHeader("IDStudent") UUID IDStudent,
            @PathVariable("IDPost") UUID postId
    ){
        PostModel postModel = postService.getPost(IDStudent, postId);
        if (postModel != null) {
            PostResponse response = mapper.map(postModel, PostResponse.class);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    /**
     *
     * @param studentId
     */
    @GetMapping(path = "/all",produces = "application/json; charset=UTF-8")
    public ResponseEntity<List<PostResponse>> getListPost(
            @RequestHeader("IDStudent") UUID studentId
    ){
        List<PostModel> postModels = postService.getListPost(studentId);
        if(postModels.isEmpty()){
            return new ResponseEntity<>(null,HttpStatus.NO_CONTENT);
        }
        List<PostResponse> responses = postModels.stream()
                .map(postModel -> mapper.map(postModel, PostResponse.class))
                .collect(Collectors.toList());
        return new ResponseEntity<>(responses, HttpStatus.OK);
    }


    /**
     *
     * @param IDStudent
     * @param IDPost
     * @param postRequest
     * @return
     */
    @PutMapping(path = "/{IDPost}",produces = "application/json; charset=UTF-8")
    public ResponseEntity<PostResponse> updatePost(
            @RequestHeader("IDStudent") UUID IDStudent,
            @PathVariable("IDPost") UUID IDPost,
            @RequestBody PostRequest postRequest
    ){
        PostModel newPostModel = mapper.map(postRequest, PostModel.class);
        newPostModel.setID(IDPost);
        PostModel updatedPost = postService.updatePost(IDStudent, newPostModel);
        if (updatedPost != null) {
            PostResponse response = mapper.map(updatedPost, PostResponse.class);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping(path = "/{IDPost}", produces = "application/json; charset=UTF-8")
    public ResponseEntity<Boolean> deletePost(
            @RequestHeader("IDStudent") UUID IDStudent,
            @PathVariable("IDPost") UUID IDPost
    ){
        Boolean deleted = postService.deletePost(IDStudent, IDPost);
        if (deleted) {
            return new ResponseEntity<>(true,HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(false,HttpStatus.NOT_FOUND);
        }
    }
}
