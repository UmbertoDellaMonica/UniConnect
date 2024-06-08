package com.umberto.uni_connect.service;

import com.umberto.uni_connect.entity.PostEntity;
import com.umberto.uni_connect.entity.StudentEntity;
import com.umberto.uni_connect.model.PostModel;
import com.umberto.uni_connect.model.StudentModel;
import com.umberto.uni_connect.repository.PostRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class PostServiceImpl implements PostService{
    @Autowired
    private ModelMapper mapper;

    @Autowired
    private PostRepository postRepository;

    @Autowired
    private StudentService studentService;

    /**
     *
     * @param studentId The ID of the student who creates the post.
     * @param postModel The model containing post data.
     * @return
     */
    @Override
    public PostModel createPost(UUID studentId, PostModel postModel) {
        StudentModel student = studentService.getStudentData(studentId);
        PostEntity postEntity = mapper.map(postModel, PostEntity.class);
        postEntity.setStudent(mapper.map(student,StudentEntity.class));
        return mapper.map(postRepository.save(postEntity), PostModel.class);
    }

    /**
     *
     * @param studentId The ID of the student who owns the post.
     * @param postId The ID of the post to retrieve.
     * @return
     */
    @Override
    public PostModel getPost(UUID studentId, UUID postId) {
        Optional<PostEntity> postEntityOptional = postRepository.findById(postId);
        if (postEntityOptional.isPresent() && postEntityOptional.get().getStudent().getID().equals(studentId)) {
            return mapper.map(postEntityOptional.get(), PostModel.class);
        }
        return null; // Post not found or does not belong to the student
    }

    /**
     *
     * @param studentId The ID of the student.
     * @return
     */
    @Override
    public List<PostModel> getListPost(UUID studentId) {
        StudentModel studentModel =  studentService.getStudentData(studentId);
        return studentModel.getPosts();
    }

    /**
     *
     * @param studentId The ID of the student who owns the post.
     * @param newPostModel The updated post model.
     * @return
     */
    @Override
    public PostModel updatePost(UUID studentId, PostModel newPostModel) {
        Optional<PostEntity> postEntityOptional = postRepository.findById(newPostModel.getID());
        if (postEntityOptional.isPresent() && postEntityOptional.get().getStudent().getID().equals(studentId)) {
            PostEntity postEntity = postEntityOptional.get();
            postEntity.setContent(newPostModel.getContent());
            return mapper.map(postRepository.save(postEntity), PostModel.class);
        }
        return null; // Post not found or does not belong to the student
    }

    /**
     *
     * @param studentId The ID of the student who owns the post.
     * @param postId The ID of the post to delete.
     * @return
     */
    @Override
    public Boolean deletePost(UUID studentId, UUID postId) {
        Optional<PostEntity> postEntityOptional = postRepository.findById(postId);
        if (postEntityOptional.isPresent() && postEntityOptional.get().getStudent().getID().equals(studentId)) {
            postRepository.deleteById(postId);
            return Boolean.TRUE;
        }
        return Boolean.FALSE; // Post not found or does not belong to the student
    }


}
