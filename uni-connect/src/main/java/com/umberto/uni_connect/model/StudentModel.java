package com.umberto.uni_connect.model;


import com.umberto.uni_connect.utils.DepartementUnisa;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.UUID;

@Getter
@Setter @ToString
public class StudentModel {

    // ID dello studente
    private UUID ID;

    private String fullName;

    private String email;

    private String passwordHash;

    @Enumerated(EnumType.STRING)
    private DepartementUnisa departementUnisa;


}
