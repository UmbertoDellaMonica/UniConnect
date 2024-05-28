package com.umberto.uni_connect.service;

import com.umberto.uni_connect.entity.MovieEntity;
import com.umberto.uni_connect.model.MovieModel;
import com.umberto.uni_connect.repository.MovieRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class MovieServiceImpl implements MovieService {

    @Autowired
    private MovieRepository movieRepository;

    @Autowired
    private ModelMapper mapper;

    @Override
    public MovieModel addMovie(MovieModel movieModel){
        MovieEntity movieEntity = mapper.map(movieModel,MovieEntity.class);

        movieRepository.save(movieEntity);

        return movieModel;
    }

    @Override
    public MovieModel getMovieByTitle(String title){
        Optional<MovieEntity> optionalMovieEntity = movieRepository.findOneByTitle(title).blockOptional();
        if(optionalMovieEntity.isEmpty()) {
            return null;
        }else{
            MovieEntity movieEntity = optionalMovieEntity.get();
            MovieModel movieModel = mapper.map(movieEntity,MovieModel.class);
            return movieModel;
        }
    }


}
