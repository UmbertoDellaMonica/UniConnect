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


    @Query("MATCH (s:Student) WHERE toLower(s.fullName) CONTAINS toLower($query) AND s.ID <> $studentId RETURN s")
    List<StudentEntity> searchStudents(String query, UUID studentId);


}
