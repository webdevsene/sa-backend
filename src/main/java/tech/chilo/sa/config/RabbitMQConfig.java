package tech.chilo.sa.config;

import org.springframework.amqp.core.*;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMQConfig {

    // Noms des queues, exchanges et routing keys
    public static final String SENTIMENT_QUEUE = "sentiment.queue";
    public static final String SENTIMENT_EXCHANGE = "sentiment.exchange";
    public static final String SENTIMENT_ROUTING_KEY = "sentiment.routingkey";
    public static final String NOTIFICATION_QUEUE = "notification.queue";

    @Bean
    public Queue sentimentQueue() {
        return new Queue(SENTIMENT_QUEUE, true);
    }

    @Bean
    public Queue notificationQueue() {
        return new Queue(NOTIFICATION_QUEUE, true);
    }

    @Bean
    public TopicExchange sentimentExchange() {
        return new TopicExchange(SENTIMENT_EXCHANGE);
    }

    @Bean
    public Binding sentimentBinding() {
        return BindingBuilder
                .bind(sentimentQueue())
                .to(sentimentExchange())
                .with(SENTIMENT_ROUTING_KEY);
    }

    @Bean
    public Binding notificationBinding() {
        return BindingBuilder
                .bind(notificationQueue())
                .to(sentimentExchange())
                .with("notification.#");
    }

    @Bean
    public Jackson2JsonMessageConverter messageConverter() {
        return new Jackson2JsonMessageConverter();
    }

    @Bean
    public RabbitTemplate rabbitTemplate(ConnectionFactory connectionFactory) {
        RabbitTemplate rabbitTemplate = new RabbitTemplate(connectionFactory);
        rabbitTemplate.setMessageConverter(messageConverter());
        return rabbitTemplate;
    }
}
