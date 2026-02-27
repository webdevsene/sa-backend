package tech.chilo.sa.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SentimentRequestDto {

    private String clientEmail;
    private String sentimentType; // "POSITIVE", "NEGATIVE", "NEUTRAL"
    private String texte;
    private int intensity; // 1-10
    private String category; // "work", "personal", "health", etc.
}
