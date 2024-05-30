package com.umberto.uni_connect.repository;


import com.umberto.uni_connect.entity.MovieEntity;
import org.springframework.data.neo4j.repository.query.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface MovieRepository extends Neo4jRepository<MovieEntity, Long> {

    /**
     * Metodo per Ricercare un Film dal Titolo
     * @param title title of Film
     */
    MovieEntity findOneByTitle(String title);
}
