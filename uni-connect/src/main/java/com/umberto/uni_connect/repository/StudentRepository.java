package com.umberto.uni_connect.repository;

import com.umberto.uni_connect.entity.StudentEntity;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.data.neo4j.repository.query.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface StudentRepository extends Neo4jRepository<StudentEntity, UUID> {

    /**
     * ExistsByEmail - Metodo che verifica se uno Studente esiste
     * @param email dello studente
     * @return True se esiste , False se non esiste
     */
    @Query("MATCH (s:Student) WHERE s.email = $email RETURN COUNT(s) = 1")
    Boolean existsByEmail(String email);

    /**
     * RetrieveByEmail - Metodo che recupera i Dati dello studente esistente
     * @param email dello studente
     * @return Uno Studente singolo
     */
    @Query("MATCH (s:Student) WHERE s.email = $email RETURN s")
    Optional<StudentEntity> retrieveByEmail(String email);

    /**
     * Retrieve all User with that name
     * @param query contains the letter of that name
     * @param IDStudent IDStudent ID of Student
     */
    @Query("MATCH (s:Student) WHERE toLower(s.fullName) CONTAINS toLower($query) AND s.ID <> $IDStudent RETURN s")
    List<StudentEntity> searchStudents(String query, UUID IDStudent);

    /**
     * Follow - Perform action where user follow the other user
     * @param followerId ID of user logged
     * @param followeeId ID of user that will be followed
     * @return true if the relationship was created successfully, false otherwise
     */
    @Query("MATCH (follower:Student {id: $followerId}), (followee:Student {id: $followeeId}) " +
            "MERGE (follower)-[r:FOLLOWS]->(followee) " +
            "RETURN CASE WHEN r IS NOT NULL THEN true ELSE false END AS result")
    Boolean followUser(UUID followerId, UUID followeeId);

    /**
     * UnFollow - Perform action where user unfollow the other user
     * @param followerId ID of user logged
     * @param followeeId ID of user that will be followed
     * @return true if the relationship was deleted successfully, false otherwise
     */
    @Query("MATCH (follower:Student {id: $followerId})-[r:FOLLOWS]->(followee:Student {id: $followeeId}) " +
            "DELETE r " +
            "RETURN COUNT(r) > 0")
    boolean unfollowUser(UUID followerId, UUID followeeId);


}
