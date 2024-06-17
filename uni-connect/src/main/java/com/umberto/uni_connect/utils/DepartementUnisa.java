package com.umberto.uni_connect.utils;

import lombok.Getter;

@Getter
public enum DepartementUnisa {

    AGRICOLA("Dipartimento di Agraria"),
    ARCHITETTURA("Dipartimento di Architettura"),
    BIOMEDICHE("Dipartimento di Scienze Biomediche"),
    FORMAZIONE_BENICULTURALI("Dipartimento di Scienze della Formazione, Beni Culturali e Turismo"),
    CHIMICHE("Dipartimento di Scienze Chimiche"),
    ECONOMICHE_STATISTICHE("Dipartimento di Scienze Economiche e Statistiche"),
    GIURIDICHE("Dipartimento di Scienze Giuridiche"),
    INGEGNERIA_ELETTRICA("Dipartimento di Ingegneria dell'Informazione ed Elettrica"),
    INGEGNERIA_EDILE("Dipartimento di Ingegneria Civile, Edile e Ambientale"),
    INGEGNERIA_INDUSTRIALE("Dipartimento di Ingegneria Industriale"),
    INFORMATICA("Dipartimento di Informatica"),
    MATEMATICA_FISICA("Dipartimento di Matematica e Fisica"),
    MEDICINA_CHIRURGIA_ODONTOIATRIA("Dipartimento di Medicina, Chirurgia e Odontoiatria"),
    FARMACIA("Dipartimento di Farmacia"),
    MOTORIE_UMANE_SOCIALI("Dipartimento di Scienze Motorie, Umane e Sociali"),
    POLITICHE_SOCIALI("Dipartimento di Scienze Politiche e Sociali"),
    LINGUAGGIO_BENICULTURALI("Dipartimento di Scienze del Linguaggio e Beni Culturali"),
    FISICA("Dipartimento di Fisica"),
    SCUOLA_MEDICINA("Scuola di Medicina");

    private final String departementName;

    DepartementUnisa(String departementName) {
        this.departementName = departementName;
    }

}
