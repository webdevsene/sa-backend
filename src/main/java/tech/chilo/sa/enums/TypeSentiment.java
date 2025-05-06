package tech.chilo.sa.enums;

import com.fasterxml.jackson.annotation.JsonProperty;

public enum TypeSentiment {
    @JsonProperty("positif")
    POSITIF,
    @JsonProperty("negatif")
    NEGATIF
}
