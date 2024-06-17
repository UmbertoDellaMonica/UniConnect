package com.umberto.uni_connect.controller.payload.request;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.umberto.uni_connect.utils.DepartementUnisa;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter @Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class StudentRequest implements Serializable {

    @JsonProperty("email")
    @NotNull @NotBlank
    private String email;

    @JsonProperty("passwordHash")
    @NotNull @NotBlank
    private String passwordHash;

    @JsonProperty("fullName")
    private String fullName;

    @JsonProperty(value = "biography")
    private String biography;

    @JsonProperty("department")
    @Enumerated(EnumType.STRING)
    @NotNull
    private DepartementUnisa departementUnisa;

}
