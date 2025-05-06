CREATE DATABASE sa;

CREATE TABLE client (
    ID SERIAL primary key,
    EMAIL varchar(50) UNIQUE NOT NULL
);

CREATE TABLE sentiment (
    ID SERIAL primary key,
    TEXTE varchar(50),
    TYPE varchar(10),
    CLIENT_ID integer,
    CONSTRAINT client_fk foreign key (CLIENT_ID) REFERENCES client(ID)
);

ALTER TABLE client
ADD COLUMN telephone varchar(15);