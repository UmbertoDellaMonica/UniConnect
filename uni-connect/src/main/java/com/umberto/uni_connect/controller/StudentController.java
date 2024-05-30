package com.umberto.uni_connect.controller;

import com.umberto.uni_connect.controller.payload.request.StudentRequest;
import com.umberto.uni_connect.controller.payload.response.StudentResponse;
import com.umberto.uni_connect.model.StudentModel;
import com.umberto.uni_connect.service.StudentService;
import jakarta.validation.Valid;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(path = "/api/v1/student")
public class StudentController {

    @Autowired
    private ModelMapper mapper;

    @Autowired
    private StudentService studentService;


    /**
     * Route - SignUp
     * Registrazione Studente
     * @param studentRequest Dati dello Studente che si registra
     */
    @PostMapping(value = "/signup")
    public ResponseEntity<StudentResponse> signUpStudent(
           @Valid @RequestBody StudentRequest studentRequest
    ){
        StudentModel studentModel = mapper.map(studentRequest,StudentModel.class);

        studentModel = studentService.signUp(studentModel);

        if(studentModel != null) {
            StudentResponse studentResponse = mapper.map(studentModel, StudentResponse.class);
            return new ResponseEntity<>(studentResponse, HttpStatusCode.valueOf(200));
        }else{
            return new ResponseEntity<>(null,HttpStatusCode.valueOf(500));
        }
    }


    @GetMapping("")
    public String getHello(){
        return "Hello";
    }

    /**
     * Route - SignIn
     * Login Studente
     * @param studentRequest Dati dello Studente che si vuole loggare
     */
    @GetMapping("/login")
    public ResponseEntity<Boolean> signInStudent(
            @Valid @RequestBody StudentRequest studentRequest

    ){
        StudentModel studentModel = mapper.map(studentRequest,StudentModel.class);

        Boolean loginTag = studentService.signIn(studentModel);

        if(loginTag){
            return new ResponseEntity<>(Boolean.TRUE,HttpStatusCode.valueOf(200));
        }else{
            return new ResponseEntity<>(Boolean.FALSE,HttpStatusCode.valueOf(500));
        }
    }


}
