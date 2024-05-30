package com.umberto.uni_connect.service;

import com.umberto.uni_connect.model.StudentModel;

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
}
