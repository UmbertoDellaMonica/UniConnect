package com.umberto.uni_connect.exception;

public class NotFoundException extends RuntimeException{
    public NotFoundException(String s) {
        super("Student Not Found!"+s);
    }
}
