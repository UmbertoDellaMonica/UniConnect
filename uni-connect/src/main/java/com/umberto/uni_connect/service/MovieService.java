package com.umberto.uni_connect.service;

import com.umberto.uni_connect.model.MovieModel;

public interface MovieService {

    /**
     * Aggiungi un film al DB
     * @param movieModel
     */
    MovieModel addMovie(MovieModel movieModel);
    /**
     * Recupera un Film , ricercando un titolo
     * @param title il titolo del film che sto ricercando
     */
    MovieModel getMovieByTitle(String title);
}
