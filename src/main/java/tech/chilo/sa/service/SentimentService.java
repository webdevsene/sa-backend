package tech.chilo.sa.service;

import org.springframework.stereotype.Service;
import tech.chilo.sa.entites.Client;
import tech.chilo.sa.entites.Sentiment;
import tech.chilo.sa.enums.TypeSentiment;
import tech.chilo.sa.repository.SentimentRepository;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.List;

@Service
public class SentimentService {

    private ClientService clientService;
    private SentimentRepository sentimentRepository;

    public SentimentService(ClientService clientService, SentimentRepository sentimentRepository) {
        this.clientService = clientService;
        this.sentimentRepository = sentimentRepository;
    }

    public void creer(Sentiment sentiment) {
        Client client = this.clientService.lireOuCreer(sentiment.getClient());
        sentiment.setClient(client);

        //TODO sentiment analyzr à l-aide d-une API externe
        sentiment.setType(TypeSentiment.POSITIF);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://sentiment-analysis4.p.rapidapi.com/reviews"))
                .header("x-rapidapi-key", "54811bf497msh81808e3b67f7d4bp14dd71jsn77562e082304")
                .header("x-rapidapi-host", "sentiment-analysis4.p.rapidapi.com")
                .header("Content-Type", "application/json")
                .method("POST", HttpRequest.BodyPublishers.ofString("{"+"text"+":"+sentiment.getTexte()+"}"))
                .build();

        try {
            HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            System.out.println(response.body());
        }catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }

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

    public void supprimer(int id) {
        this.sentimentRepository.deleteById(id);
    }
}
