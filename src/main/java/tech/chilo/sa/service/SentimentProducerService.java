package tech.chilo.sa.service;


import tech.chilo.sa.config.RabbitMQConfig;
import tech.chilo.sa.dto.SentimentRequestDto;
import tech.chilo.sa.dto.SentimentNotificationDto;

import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;

@Service
@Slf4j
public class SentimentProducerService {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    public void sendSentiment(SentimentRequestDto sentiment) {
        log.info("Envoi du sentiment de l'utilisateur {}: {}",
                sentiment.getClientEmail(), sentiment.getTexte());

        rabbitTemplate.convertAndSend(
                RabbitMQConfig.SENTIMENT_EXCHANGE,
                RabbitMQConfig.SENTIMENT_ROUTING_KEY,
                sentiment
        );
    }

    public void sendNotification(String userId, String message, String type) {
        SentimentNotificationDto notification = new SentimentNotificationDto(
                userId,
                message,
                LocalDateTime.now(),
                type
        );

        log.info("Envoi de notification pour l'utilisateur {}: {}", userId, message);

        rabbitTemplate.convertAndSend(
                RabbitMQConfig.SENTIMENT_EXCHANGE,
                "notification." + type.toLowerCase(),
                notification
        );
    }

    /**
     * Méthode pour envoyer un sentiment négatif urgent
     * @param sentiment Le sentiment à envoyer
     *
     */
    public void sendCriticalSentiment(SentimentRequestDto sentiment) {
        log.warn("Sentiment critique détecté pour l'utilisateur {}!",
                sentiment.getClientEmail());

        // Envoi du sentiment normal
        sendSentiment(sentiment);

        // Envoi d'une notification d'alerte
        if (sentiment.getSentimentType().equals("NEGATIVE") && sentiment.getIntensity() > 7) {
            sendNotification(
                    sentiment.getClientEmail(),
                    "Alerte: Sentiment négatif détecté avec intensité élevée",
                    "ALERT"
            );
        }
    }
}
