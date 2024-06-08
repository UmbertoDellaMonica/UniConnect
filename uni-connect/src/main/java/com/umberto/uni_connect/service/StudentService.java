package com.umberto.uni_connect.service;

import com.umberto.uni_connect.model.StudentModel;

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
}
