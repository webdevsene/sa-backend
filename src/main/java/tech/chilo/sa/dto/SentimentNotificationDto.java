package tech.chilo.sa.dto;



import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class SentimentNotificationDto {
    private String userId;
    private String message;
    private LocalDateTime timestamp;
    private String notificationType; // "ALERT", "SUMMARY", "REPORT"
}
