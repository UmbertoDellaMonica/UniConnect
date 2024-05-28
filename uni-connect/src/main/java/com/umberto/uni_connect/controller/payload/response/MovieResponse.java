package com.umberto.uni_connect.controller.payload.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@JsonIgnoreProperties(ignoreUnknown = true)
@Getter
@Setter
public class MovieResponse implements Serializable {
    private Long id;

    private String title;

    private  String description;
}
