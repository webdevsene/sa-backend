package tech.chilo.sa.service;

import tech.chilo.sa.config.RabbitMQConfig;
import tech.chilo.sa.dto.SentimentRequestDto;
import tech.chilo.sa.dto.SentimentNotificationDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class SentimentConsumerService {

    @Autowired
    private SentimentService sentimentService;

    @RabbitListener(queues = RabbitMQConfig.SENTIMENT_QUEUE)
    public void receiveSentiment(SentimentRequestDto sentiment) {
        log.info("Réception d'un sentiment: Utilisateur={}, Type={}, Intensité={}",
                sentiment.getClientEmail(),
                sentiment.getSentimentType(),
                sentiment.getIntensity());

        // Traitement du sentiment
        sentimentService.analyzeSentiment(sentiment);

        // Exemple de logique métier
        if (sentiment.getSentimentType().equals("POSITIVE")) {
            log.info("Sentiment positif détecté! Envoyons une récompense virtuelle.");
        }
    }

    @RabbitListener(queues = RabbitMQConfig.NOTIFICATION_QUEUE)
    public void receiveNotification(SentimentNotificationDto notification) {
        log.info("Notification reçue: Type={}, Message={}, Time={}",
                notification.getNotificationType(),
                notification.getMessage(),
                notification.getTimestamp());

        // Traitement de la notification
        switch (notification.getNotificationType()) {
            case "ALERT":
                handleAlert(notification);
                break;
            case "SUMMARY":
                handleSummary(notification);
                break;
            case "REPORT":
                handleReport(notification);
                break;
        }
    }

    private void handleAlert(SentimentNotificationDto notification) {
        log.warn("⚠️ ALERTE pour l'utilisateur {}: {}",
                notification.getUserId(), notification.getMessage());
        // Envoyer un email, SMS, ou notifier un modérateur
    }

    private void handleSummary(SentimentNotificationDto notification) {
        log.info("📊 Résumé quotidien: {}", notification.getMessage());
        // Générer un rapport statistique
    }

    private void handleReport(SentimentNotificationDto notification) {
        log.info("📈 Rapport hebdomadaire: {}", notification.getMessage());
        // Envoyer le rapport par email
    }
}
