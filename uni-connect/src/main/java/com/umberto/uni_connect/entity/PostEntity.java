package com.umberto.uni_connect.entity;


import lombok.Getter;
import lombok.Setter;
import org.springframework.data.neo4j.core.schema.*;

import java.util.UUID;

@Node("Post")
@Getter
@Setter
public class PostEntity {

    @Id
    @GeneratedValue(GeneratedValue.UUIDGenerator.class)
    private UUID ID;

    @Property("content")
    private String content;
    @Property("created_at")
    private String createdAt;

    private int likes;

    @Relationship(type = "CREATED_BY", direction = Relationship.Direction.INCOMING)
    private StudentEntity student;

}
