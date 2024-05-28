package com.umberto.uni_connect.repository;


import com.umberto.uni_connect.entity.MovieEntity;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Mono;

import org.springframework.data.neo4j.repository.ReactiveNeo4jRepository;


@Repository
public interface MovieRepository extends ReactiveNeo4jRepository<MovieEntity, Long> {

    /**
     * Metodo per Ricercare un Film dal Titolo
     * @param title
     * @return
     */
    Mono<MovieEntity> findOneByTitle(String title);
}
