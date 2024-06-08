package com.umberto.uni_connect.service.profile;


import com.umberto.uni_connect.model.StudentModel;

import java.util.UUID;

/**
 * Service per la parte del Profilo
 * - UpdloadImage *Opzionale
 * - UpdateStudent
 * - DeleteStudent
 */
public interface StudentProfileService {
    StudentModel updateStudent(StudentModel newStudentModel, UUID IDStudente);

    Boolean deleteStudent(UUID IDStudent);
}
