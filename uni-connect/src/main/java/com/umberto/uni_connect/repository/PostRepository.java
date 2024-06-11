package com.umberto.uni_connect.repository;

import com.umberto.uni_connect.entity.PostEntity;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.data.neo4j.repository.query.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface PostRepository extends Neo4jRepository<PostEntity,UUID> {

    /**
     * Find all Post that are made up from my followee in the last 24h
     * @param IDStudent ID dello studente
     */
    @Query("MATCH (u:Student {ID: $IDStudent})-[:FOLLOWS]->(f:Student)-[:CREATED_BY]->(p:Post) " +
            "RETURN p ORDER BY p.created_at DESC")
    List<PostEntity> findRecentPostsByFollowedUsers(UUID IDStudent);
}
