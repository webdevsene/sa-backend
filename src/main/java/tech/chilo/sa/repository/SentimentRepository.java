package tech.chilo.sa.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import tech.chilo.sa.entites.Sentiment;
import tech.chilo.sa.enums.TypeSentiment;

import java.util.List;
import java.util.UUID;

public interface SentimentRepository extends JpaRepository<Sentiment, UUID> {

    List<Sentiment> findByType(TypeSentiment type);
}
