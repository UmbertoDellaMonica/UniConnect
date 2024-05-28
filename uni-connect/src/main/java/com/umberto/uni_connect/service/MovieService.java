package com.umberto.uni_connect.service;

import com.umberto.uni_connect.model.MovieModel;

public interface MovieService {

    /**
     * Aggiungi un film al DB
     * @param movieModel
     */
    MovieModel addMovie(MovieModel movieModel);

    MovieModel getMovieByTitle(String title);
}
