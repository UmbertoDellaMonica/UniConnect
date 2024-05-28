package com.umberto.uni_connect.controller;


import com.umberto.uni_connect.controller.payload.response.MovieResponse;
import com.umberto.uni_connect.model.MovieModel;
import com.umberto.uni_connect.service.MovieService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/movie")
public class MovieController {

    @Autowired
    private ModelMapper mapper;

    @Autowired
    private MovieService movieService;

    @GetMapping("")
    public ResponseEntity<MovieResponse>getByTitle(
            @RequestParam(name = "title")String title
    ){
        MovieModel movieModel = movieService.getMovieByTitle(title);
        MovieResponse movieResponse = mapper.map(movieModel,MovieResponse.class);
        return new ResponseEntity<MovieResponse>(movieResponse, HttpStatus.OK);
    }
}
