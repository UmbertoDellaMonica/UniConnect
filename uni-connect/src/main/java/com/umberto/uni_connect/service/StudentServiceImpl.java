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
import java.util.stream.Collectors;

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
     * Update value of Student
     * @param IDStudent IDStudent
     * @param newStudent new data of Student
     */
    @Override
    public StudentModel updateStudent(UUID IDStudent, StudentModel newStudent) {

        StudentModel oldStudentModel = getStudentData(IDStudent);

        oldStudentModel.setBiography(newStudent.getBiography());
        oldStudentModel.setPasswordHash(newStudent.getPasswordHash());

        StudentEntity newStudentEntity = mapper.map(oldStudentModel,StudentEntity.class);
        newStudentEntity = studentRepository.save(newStudentEntity);

        return oldStudentModel;
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

    /**
     * Follow Student - Permette allo studente di Followare una persona
     * @param IDStudent
     * @param OtherIDStudent
     * @return
     */
    @Override
    public Boolean followStudent(UUID IDStudent, UUID OtherIDStudent) {
        Optional<StudentEntity> student = studentRepository.findById(IDStudent);
        Optional<StudentEntity> targetStudent = studentRepository.findById(OtherIDStudent);
        if (student.isPresent()  && targetStudent.isPresent()) {
            // Aggiungi targetId alla lista dei follower di student
            /*student.get().getFollowing().add(targetStudent.get());
            StudentEntity studentEntity = studentRepository.save(student.get());
            return Boolean.TRUE;*/
            return studentRepository.followUser(IDStudent, OtherIDStudent);
            //return studentRepository.unfollowUser(IDStudent, OtherIDStudent);
        }
        return Boolean.FALSE;
    }

    /**
     * Unfollow Student - Permette all'utente di unfolloware una persona
     * @param IDStudent
     * @param OtherIDStudent
     * @return
     */
    @Override
    public Boolean unfollowStudent(UUID IDStudent, UUID OtherIDStudent) {
        Optional<StudentEntity> student = studentRepository.findById(IDStudent);
        Optional<StudentEntity> targetStudent = studentRepository.findById(OtherIDStudent);
        if (student.isPresent() && targetStudent.isPresent()) {
            return studentRepository.unfollowUser(IDStudent, OtherIDStudent);
        }
        return Boolean.FALSE;
    }

    /**
     * Check if the Student follows the other student
     * @param IDStudent
     * @param otherIDStudent
     * @return
     */
    @Override
    public Boolean isFollowing(UUID IDStudent, UUID otherIDStudent) {
        Optional<StudentEntity> student = studentRepository.findById(IDStudent);
        Optional<StudentEntity> targetStudent = studentRepository.findById(otherIDStudent);

        if(student.isPresent() && targetStudent.isPresent()){

            return studentRepository.isFollowing(IDStudent, otherIDStudent);
        }
        return Boolean.FALSE;
    }

    /**
     * Retrieve all Follower
     * @param IDStudent ID of the student that i want find followers
     */
    @Override
    public List<StudentModel> getFollowers(UUID IDStudent) {
        List<StudentEntity>studentEntityList = studentRepository.findFollowersByStudentId(IDStudent);
        if(studentEntityList.isEmpty()){
            return null;
        }
        List<StudentModel> studentModelList = mapper.map(studentEntityList,new TypeToken<List<StudentModel>>(){}.getType());
        return studentModelList;
    }

    @Override
    public List<StudentModel> getMutualConnections(UUID IDStudent) {
        List<StudentEntity> studentEntities = studentRepository.findMutualConnections(IDStudent);
        return studentEntities.stream()
                .map(student -> mapper.map(student, StudentModel.class))
                .collect(Collectors.toList());
    }
}
