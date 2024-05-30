package com.umberto.uni_connect.entity;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.neo4j.core.schema.GeneratedValue;
import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;
import org.springframework.data.neo4j.core.schema.Property;


@Getter @Setter
@Node("Movie")
public class MovieEntity {

    @Id @GeneratedValue()
    private Long id;

    @Property("title")
    private String title;

    @Property("tagline")
    private  String description;

}