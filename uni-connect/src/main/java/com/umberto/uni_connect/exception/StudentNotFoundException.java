package com.umberto.uni_connect.exception;

public class StudentNotFoundException extends NotFoundException{
    public StudentNotFoundException(String message) {
        super("Student Not Found Exception : "+message);
    }
}
