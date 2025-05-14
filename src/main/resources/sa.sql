CREATE DATABASE sa;

CREATE TABLE client (
    ID varchar(255) primary key,
    EMAIL varchar(50) UNIQUE NOT NULL
);

CREATE TABLE sentiment (
    ID UUID primary key,
    TEXTE varchar(50),
    TYPE varchar(10),
    CLIENT_ID integer,
    CONSTRAINT client_fk foreign key (CLIENT_ID) REFERENCES client(ID)
);

ALTER TABLE client
ADD COLUMN telephone varchar(255);


-- Supprimer la contrainte de clé primaire existante si elle existe
ALTER TABLE client DROP CONSTRAINT IF EXISTS client_pkey;

-- Modifier le type de données de la colonne ID en UUID
ALTER TABLE client ALTER COLUMN ID TYPE UUID USING ID::UUID;

-- Définir la colonne ID comme clé primaire
ALTER TABLE client ADD PRIMARY KEY (ID);

CREATE TABLE bon_commande (
    ID UUID primary key
);
