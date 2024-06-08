package com.umberto.uni_connect.model;

import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class PostModel {

    private UUID ID;

    private String content;
    private String createdAt;

    private int likes;

    private StudentModel student;

    // Getters and Setters
}