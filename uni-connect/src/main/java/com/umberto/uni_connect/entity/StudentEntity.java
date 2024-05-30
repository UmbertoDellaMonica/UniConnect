package com.umberto.uni_connect.entity;


import com.umberto.uni_connect.utils.DepartementUnisa;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.neo4j.core.schema.GeneratedValue;
import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;
import org.springframework.data.neo4j.core.schema.Property;

import java.util.UUID;

@Node("Student")
@Getter
@Setter
public class StudentEntity {

    // ID dello studente
    @Id @GeneratedValue(GeneratedValue.UUIDGenerator.class)
    private UUID ID;

    @Property("fullName")
    private String fullName;

    @Property("email")
    private String email;

    private String passwordHash;

    @Enumerated(EnumType.STRING)
    private DepartementUnisa departementUnisa;


}
