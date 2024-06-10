package com.umberto.uni_connect.service;

import com.umberto.uni_connect.entity.StudentEntity;
import com.umberto.uni_connect.exception.NotFoundException;
import com.umberto.uni_connect.exception.StudentNotFoundException;
import com.umberto.uni_connect.model.StudentModel;
import com.umberto.uni_connect.repository.StudentRepository;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private ModelMapper mapper;

    @Autowired
    private StudentRepository studentRepository;


    /**
     * signUp - Registrazione dello Studente
     *
     * @param studentModel dati dello Studente
     */
    @Override
    public StudentModel signUp(StudentModel studentModel) {

        StudentModel newStudentModel = null;
        System.out.println("La mail è : "+studentModel.getEmail());
        // Verifica se lo Studente esiste
        Boolean studentExists = studentRepository.existsByEmail(studentModel.getEmail());

        if (studentExists) {
            // TODO: Errore di già avvenuta registrazione
            return newStudentModel;
        } else {
            // Create a new Entity
            StudentEntity studentEntity = new StudentEntity();
            studentEntity = mapper.map(studentModel, StudentEntity.class);
            studentEntity = studentRepository.save(studentEntity);
            // Return the Entity
            newStudentModel = mapper.map(studentEntity, StudentModel.class);
        }

        return newStudentModel;
    }

    /**
     * signIn - Studente effettua il Login
     *
     * @param studentModel dati dello Studente
     * @return
     */
    @Override
    public Boolean signIn(StudentModel studentModel) {
        Optional<StudentEntity> studentEntityOptional = studentRepository.retrieveByEmail(studentModel.getEmail());
        if (studentEntityOptional.isPresent()) {
            if (
                    studentEntityOptional.get().getPasswordHash().equals(studentModel.getPasswordHash()) &&
                            studentEntityOptional.get().getDepartementUnisa().getDepartementName()
                                    .equalsIgnoreCase(studentModel.getDepartementUnisa().getDepartementName())
            ) {
                return Boolean.TRUE;
            } else {
                return Boolean.FALSE;
            }
        } else {
            return Boolean.FALSE;
        }
    }

    /**
     * getStudentData - Studente recupera i suoi dati mediante la sua email
     *
     * @param email dello studente
     */
    @Override
    public StudentModel getStudentData(String email) {
        try {
            // Recupera lo studente
            Optional<StudentEntity> studentEntityOptional = studentRepository.retrieveByEmail(email);

            if (studentEntityOptional.isPresent()) {
                // Retrieve Student Data
                StudentModel studentModel = mapper.map(studentEntityOptional.get(), StudentModel.class);
                return studentModel;
            } else {
                // TODO: Student Not Found
                throw new StudentNotFoundException("Email Not Found !:" + email);
            }
        } catch (NotFoundException e) {
            // Return Null
            return null;
        }
    }


    /**
     * getStudentData - Recupero dei dati dello Studente mediante l'ID
     * Questa azione viene eseguita solo nel momento in cui, l'utente ha effettuato il Login
     * @param IDStudent id dello studente
     */
    @Override
    public StudentModel getStudentData(UUID IDStudent) {
        Optional<StudentEntity> studentEntityOptional = studentRepository.findById(IDStudent);
        try {
            if (studentEntityOptional.isPresent()) {
                StudentModel studentModel = mapper.map(studentEntityOptional.get(), StudentModel.class);
                return studentModel;
            } else {
                throw new StudentNotFoundException("ID Student Not Found : " + IDStudent);
            }
        } catch (NotFoundException e) {
            return null;
        }
    }

    /**
     *
     * @param query contiene le lettere che il nome dello studente o il full Name dovrebbe contenere
     * @param IDStudent ID dello studente che sta ricercando
     * @return
     */
    @Override
    public List<StudentModel> searchStudentByFullName(String query, UUID IDStudent) {
        // Search Student about query in FullName
        List<StudentEntity>studentEntityList = studentRepository.searchStudents(query,IDStudent);

        List<StudentModel> studentModelList = mapper.map(studentEntityList,new TypeToken<List<StudentModel>>(){}.getType());

        return studentModelList;
    }
}
