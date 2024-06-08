package com.umberto.uni_connect.repository;

import com.umberto.uni_connect.entity.PostEntity;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface PostRepository extends Neo4jRepository<PostEntity,UUID> {

}
