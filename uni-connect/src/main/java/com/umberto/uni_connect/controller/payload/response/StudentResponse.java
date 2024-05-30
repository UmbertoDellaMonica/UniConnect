package com.umberto.uni_connect.controller.payload.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.umberto.uni_connect.utils.DepartementUnisa;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.UUID;

@JsonIgnoreProperties(ignoreUnknown = true)
@Getter
@Setter
public class StudentResponse implements Serializable {

    // ID dello studente
    @JsonProperty("ID")
    private UUID ID;

    @JsonProperty("fullName")
    private String fullName;

    @JsonProperty("email")
    private String email;

    @JsonProperty("passwordHash")
    private String passwordHash;

    @JsonProperty("departementUnisa")
    @Enumerated(EnumType.STRING)
    private DepartementUnisa departementUnisa;
}
