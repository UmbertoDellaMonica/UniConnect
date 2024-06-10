package com.umberto.uni_connect.service;

import com.umberto.uni_connect.model.StudentModel;

import java.util.List;
import java.util.UUID;

public interface StudentService {

    /**
     * Registrazione dello studente
     * @param studentModel dati dello Studente
     */
    StudentModel signUp(StudentModel studentModel);

    /**
     * Login dello Studente
     * @param studentModel dati dello Studente
     */
    Boolean signIn(StudentModel studentModel);

    /**
     * Recupero dei Dati dello Studente
     * @param email dello studente
     */
    StudentModel getStudentData(String email);

    /**
     * Recupero dei dello Studente mediante l'ID
     * @param IDStudent id dello studente
     */
    StudentModel getStudentData(UUID IDStudent);

    /**
     * Ricerca gli studenti mediante la query che viene passata
     * @param query contiene le lettere che il nome dello studente o il full Name dovrebbe contenere
     * @param IDStudent ID dello studente che sta ricercando
     */
    List<StudentModel> searchStudentByFullName(String query, UUID IDStudent);

    /**
     * Follow permette di seguire uno studente
     * @param IDStudent
     * @param otherIDStudent
     */
    Boolean followStudent(UUID IDStudent, UUID otherIDStudent);
    /**
     * UnFollow permette di seguire uno studente
     * @param IDStudent
     * @param otherIDStudent
     */
    Boolean unfollowStudent(UUID IDStudent, UUID otherIDStudent);

    /**
     * Check if the user follow the other student
     * @param IDStudent
     * @param otherIDStudent
     */
    Boolean isFollowing(UUID IDStudent, UUID otherIDStudent);
}
