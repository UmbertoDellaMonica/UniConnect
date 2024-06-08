package com.umberto.uni_connect.service.profile;

import com.umberto.uni_connect.entity.StudentEntity;
import com.umberto.uni_connect.exception.NotFoundException;
import com.umberto.uni_connect.exception.StudentNotFoundException;
import com.umberto.uni_connect.model.StudentModel;
import com.umberto.uni_connect.repository.StudentRepository;
import com.umberto.uni_connect.service.StudentService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class StudentProfileServiceImpl implements StudentProfileService{

    @Autowired
    private ModelMapper mapper;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private StudentService studentService;


    /**
     * UpdateStudent - Aggiorna i dati dell'utente
     * @param newStudentModel nuovi dati dell'utente
     * Mi permette di aggiornare
     *                        - NomeCognome
     *                        - Password
     */
    @Override
    public StudentModel updateStudent(StudentModel newStudentModel, UUID IDStudent){

        // Recupero delle informazioni dello Studente
        StudentModel studentModel = studentService.getStudentData(IDStudent);
        studentModel.setFullName(newStudentModel.getFullName());
        studentModel.setPasswordHash(newStudentModel.getPasswordHash());

        StudentEntity studentEntityNew = mapper.map(studentModel,StudentEntity.class);
        studentEntityNew = studentRepository.save(studentEntityNew);

        return studentModel;
    }

    

    /**
     * Eliminazione dello Studente - mediante il suo ID
     * @param IDStudent id dello Studente
     */
    @Override
    public Boolean deleteStudent(UUID IDStudent){
        try {
            // Verifico se lo Studente esiste attraverso l'ID
            if (studentRepository.existsById(IDStudent)) {
                // Eliminazione dello studente tramite l'ID
                studentRepository.deleteById(IDStudent);

                return Boolean.TRUE;
            }else{
                throw new StudentNotFoundException("Student not Found ! ID: "+IDStudent);
            }
        }catch(NotFoundException e){
            // Studente non trovato
            return Boolean.FALSE;
        }
    }
}
