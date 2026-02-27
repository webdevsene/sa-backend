package tech.chilo.sa.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tech.chilo.sa.dto.SentimentRequestDto;
import tech.chilo.sa.entites.Client;
import tech.chilo.sa.entites.Sentiment;
import tech.chilo.sa.enums.TypeSentiment;
import tech.chilo.sa.repository.ClientRepository;
import tech.chilo.sa.repository.SentimentRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@Slf4j
public class SentimentService {

    private ClientService clientService;

    @Autowired
    private ClientRepository clientRepository;
    private SentimentRepository sentimentRepository;

    @Autowired
    private SentimentRepository repository;

    @Autowired
    private SentimentProducerService producerService;

    public SentimentService(ClientService clientService, SentimentRepository sentimentRepository) {
        this.clientService = clientService;
        this.sentimentRepository = sentimentRepository;
    }

    public void creer(Sentiment sentiment) {
        Client client = this.clientService.lireOuCreer(sentiment.getClient());
        sentiment.setClient(client);

        //TODO sentiment analyzr à l-aide d-une API externe
        sentiment.setType(TypeSentiment.POSITIF);

        if (sentiment.getTexte().contains("pas")){
            sentiment.setType(TypeSentiment.NEGATIF);
        }
        this.sentimentRepository.save(sentiment);
    }

    public List<Sentiment> rechercher(TypeSentiment type) {

        if (type == null) {
            return this.sentimentRepository.findAll();
        } else {
            return this.sentimentRepository.findByType(type);
        }
    }

    public void supprimer(UUID id) {
        this.sentimentRepository.deleteById(id);
    }

    public void analyzeSentiment(SentimentRequestDto request) {

        String email = request.getClientEmail();
        log.info("Analyse du sentiment du client {}: {}", email, request.getTexte());

        // Recuperer le client correspondant en base de données
        Client client = clientRepository.findByEmail(email);

        if (client == null) {
            log.warn("Client non trouvé pour l'email: " + email);
            throw new RuntimeException("Client non trouvé pour l'email: " + email);
        }

        // Sauvegarde en base de données
        Sentiment sentiment = new Sentiment();
        sentiment.setClient(client);
        sentiment.setType(TypeSentiment.valueOf(request.getSentimentType()));
        sentiment.setTexte(request.getTexte());
        sentiment.setIntensity(request.getIntensity());
        sentiment.setCategory(request.getCategory());
        sentiment.setTimestamp(LocalDateTime.now());

        repository.save(sentiment);
        log.info("Sentiment sauvegardé en base: ID={}", sentiment.getId());

        // Logique d'analyse
        if (request.getIntensity() > 8) {
            log.info("Sentiment intense détecté pour {}", request.getClientEmail());
        }

        // Détection de tendances négatives et alerte si nécessaire
        if (request.getSentimentType().equals("NEGATIVE")) {
            checkNegativePattern(client);
        }

        // Envoi d'un rapport si c'est le 4ème or 100ème sentiment
        long count = repository.countByClient(client);
        if (count % 4 == 0) {
            producerService.sendNotification(
                    request.getClientEmail(),
                    "Vous avez partagé " + count + " sentiments! Merci pour votre participation.",
                    "SUMMARY"
            );
        }
    }

    /**
     * Cette methode determine le nombre de sentiments négatifs consécutifs d'un client donné.
     * @param userId L'identifiant du client
     * @param userId
     */
    private void checkNegativePattern(Client userId) {
        long negativeCount = repository.countByClientAndType(userId, TypeSentiment.NEGATIF);
        if (negativeCount >= 5) {
            log.warn("⚠️ Le client {} a {} sentiments négatifs consécutifs",
                    userId, negativeCount);
        }
    }
}
