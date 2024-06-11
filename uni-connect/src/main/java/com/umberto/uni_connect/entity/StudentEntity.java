package com.umberto.uni_connect.entity;


import com.umberto.uni_connect.utils.DepartementUnisa;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.neo4j.core.schema.*;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Node("Student")
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

    @Relationship(type = "CREATED_BY", direction = Relationship.Direction.OUTGOING)
    private List<PostEntity> posts;

    @Relationship(type = "FOLLOWS", direction = Relationship.Direction.OUTGOING)
    private List<StudentEntity> following;

}
