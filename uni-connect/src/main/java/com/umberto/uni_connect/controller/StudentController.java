package com.umberto.uni_connect.controller;

import com.umberto.uni_connect.controller.payload.request.StudentRequest;
import com.umberto.uni_connect.controller.payload.response.StudentResponse;
import com.umberto.uni_connect.model.StudentModel;
import com.umberto.uni_connect.service.StudentService;
import jakarta.validation.Valid;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
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

        HttpHeaders headers = new HttpHeaders();
        headers.set("Access-Control-Allow-Origin","*");

        StudentModel studentModel = mapper.map(studentRequest,StudentModel.class);

        studentModel = studentService.signUp(studentModel);

        if(studentModel != null) {
            StudentResponse studentResponse = mapper.map(studentModel, StudentResponse.class);

            ResponseEntity<StudentResponse>studentResponseResponseEntity = new ResponseEntity<>(studentResponse,headers,HttpStatusCode.valueOf(200));

            return studentResponseResponseEntity;
        }else{
            return new ResponseEntity<>(null,headers,HttpStatusCode.valueOf(500));
        }
    }

    /**
     * Route - SignIn
     * Login Studente
     * @param studentRequest Dati dello Studente che si vuole loggare
     */
    @PostMapping(value = "/signin")
    public ResponseEntity<Boolean> signInStudent(
            @Valid @RequestBody StudentRequest studentRequest

    ){
        HttpHeaders headers = new HttpHeaders();
        headers.set("Access-Control-Allow-Origin","*");

        StudentModel studentModel = mapper.map(studentRequest,StudentModel.class);

        Boolean loginTag = studentService.signIn(studentModel);

        if(loginTag){
            return new ResponseEntity<>(Boolean.TRUE,headers,HttpStatusCode.valueOf(200));
        }else{
            return new ResponseEntity<>(Boolean.FALSE,headers,HttpStatusCode.valueOf(500));
        }
    }

    /**
     * getStudent - Controller per inviare i dati dello Studente alla mia web app
     * @param email
     */
    @GetMapping("")
    public ResponseEntity<StudentResponse>getStudent(
            @RequestHeader(name = "email")String email
    ){
        StudentModel studentModel = studentService.getStudentData(email);
        if(studentModel.equals(null)){
            return new ResponseEntity<>(null,HttpStatusCode.valueOf(500));
        }else{
            StudentResponse studentResponse = mapper.map(studentModel,StudentResponse.class);
            return new ResponseEntity<>(studentResponse,HttpStatusCode.valueOf(200));
        }
    }


}
