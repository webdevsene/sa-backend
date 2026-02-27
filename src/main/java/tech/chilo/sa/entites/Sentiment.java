package tech.chilo.sa.entites;

import jakarta.persistence.*;
import lombok.*;
import tech.chilo.sa.enums.TypeSentiment;

import java.time.LocalDateTime;
import java.util.UUID;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "sentiment")
public class Sentiment {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    private String texte;

    @Enumerated(EnumType.STRING)
    @Column(name = "type")
    private TypeSentiment type;

    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "client_id")
    private Client client;

    private LocalDateTime timestamp;


    private Integer intensity;
    private String category;

    @PrePersist
    protected void onCreate() {
        timestamp = LocalDateTime.now();
    }

}
