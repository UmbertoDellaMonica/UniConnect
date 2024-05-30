package com.umberto.uni_connect.service;

import com.umberto.uni_connect.entity.StudentEntity;
import com.umberto.uni_connect.model.StudentModel;
import com.umberto.uni_connect.repository.StudentRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentServiceImpl implements StudentService{

    @Autowired
    private ModelMapper mapper;

    @Autowired
    private StudentRepository studentRepository;


    /**
     * SignUp - Registrazione dello Studente
     * @param studentModel dati dello Studente
     */
    @Override
    public StudentModel signUp(StudentModel studentModel) {

        StudentModel newStudentModel = null;
        // Verifica se lo Studente esiste
        Boolean studentExists = studentRepository.existsByEmail(studentModel.getEmail());

        if(studentExists){
            // TODO: Errore di già avvenuta registrazione
            return newStudentModel;
        }else{
            // Create a new Entity
            StudentEntity studentEntity = new StudentEntity();
            studentEntity = mapper.map(studentModel,StudentEntity.class);
            studentEntity = studentRepository.save(studentEntity);
            // Return the Entity
            newStudentModel = mapper.map(studentEntity,StudentModel.class);
        }

        return newStudentModel;
    }

    /**
     * signIn - Studente effettua il Login
     * @param studentModel dati dello Studente
     * @return
     */
    @Override
    public Boolean signIn(StudentModel studentModel) {
        return Boolean.TRUE;
    }
}
