CREATE TABLE client
(
    id        UUID         NOT NULL,
    email     VARCHAR(255) NOT NULL,
    telephone VARCHAR(255),
    CONSTRAINT pk_client PRIMARY KEY (id)
);

CREATE TABLE sentiment
(
    id        UUID NOT NULL,
    texte     VARCHAR(255),
    type      VARCHAR(255),
    client_id UUID,
    timestamp TIMESTAMP WITHOUT TIME ZONE,
    intensity INTEGER,
    category  VARCHAR(255),
    CONSTRAINT pk_sentiment PRIMARY KEY (id)
);

ALTER TABLE client
    ADD CONSTRAINT uc_client_email UNIQUE (email);

ALTER TABLE sentiment
    ADD CONSTRAINT FK_SENTIMENT_ON_CLIENT FOREIGN KEY (client_id) REFERENCES client (id);