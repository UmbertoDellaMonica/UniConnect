package com.umberto.uni_connect.controller.payload.request;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter @Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class PostRequest implements Serializable {
    @JsonProperty("content")
    private String content;
    @JsonProperty("created_at")
    private String createdAt;
    @JsonProperty("likes")
    private int likes;
}