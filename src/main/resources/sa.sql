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


ALTER TABLE client
    ALTER COLUMN EMAIL TYPE date;

SELECT * FROM public.beneficiary as b
WHERE b.email='velijo6431@betzenn.com';

-- SQL requête native basique de jointure
SELECT *
FROM public.branch b
WHERE b.id='087ee743-7e59-422b-aa0b-07a1bf0e7d83';

SELECT h.id, h.operation_date, h.amount, h.type,
       h.branch_id, b.code as branch_code, b.name as branch_name
FROM historical_operation h
INNER JOIN branch b ON h.branch_id = b.id
WHERE b.name = :branchLibelle
ORDER BY h.operation_date DESC;

SELECT *
FROM public.historical_operation as ho
WHERE ho.id='46253181-c4e5-4e06-b3e1-23692eca008e'
limit	10;

-- ici la bonne requête sql native [ postgresql ] pour recuperer les H_ops selon la station (branch)
SELECT ho.id,
       ho.operation_number,
       ho.amount,
       ho.event_code,
       ho.account_code_from,
       ho.account_code_to,
       ho.operation_date,
       b.label as branch_label
FROM public.historical_operation as ho
         INNER JOIN public.branch b
                    ON ho.branch_id = b.id
WHERE b.label = :branchLabel


@Query(value = "SELECT c.*, o.*, p.* "
  + " from Customer c, CustomerOrder o ,Product p "
  + " where c.id=o.customer_id "
  + " and o.id=p.customerOrder_id "
  + " and c.id=?1 "
  , nativeQuery = true)
List<Map<String, Object>> findByCustomer(Long id);


INSERT INTO "public"."matrice_version" (
id,
"action",
date_created,
date_version_mobile,
date_version_serveur,
deleted,
last_updated,
user_create,
user_update,
version,
version_mobile,
version_serveur,
etablissement_id ) VALUES (
    782330,
    'OK',
    '2025-04-22 10:29:29',
    '2025-04-22 10:29:29',
    '2025-04-22 10:29:29',
    '0',
    '2025-04-22 10:29:29',
    '',
    '',
    1,
    '3.1.22',
    '3.8.6_RC55',
    'b893c0c2-6e48-4b62-bb66-53461abe2217');


INSERT INTO "public"."matrice_version" ("id", "version", "action", "date_created", "date_version_mobile", "date_version_serveur", "deleted", "etablissement_id", "last_updated", "user_create", "user_update", "version_mobile", "version_serveur") VALUES
(782330,
 'OK',
 '2025-04-22 10:29:29',
 '2025-04-22 10:29:29',
 '2025-04-22 10:29:29',
 '0',
 '2025-04-22 10:29:29',
 '',
 '',
 1,
 '3.1.22',
 '3.8.6_RC55'),
 'fdd7375c-10c8-4e7e-8338-2afaea76e901',

                                                                                                                                                                                                                                                        (782331, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.21', '3.8.6_RC55'), (782332, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.20', '3.8.6_RC55'), (782333, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.19', '3.8.6_RC55'), (782334, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.18', '3.8.6_RC55'), (782335, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.17', '3.8.6_RC55'), (782336, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.16', '3.8.6_RC55'), (782337, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.15', '3.8.6_RC55'), (782338, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.14', '3.8.6_RC55'), (782339, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.13', '3.8.6_RC55'), (782340, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.12', '3.8.6_RC55'), (782341, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.11', '3.8.6_RC55'), (782342, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.10', '3.8.6_RC55'), (782343, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.9', '3.8.6_RC55'), (782344, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.8', '3.8.6_RC55'), (782345, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.7', '3.8.6_RC55'), (782346, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.6', '3.8.6_RC55'), (782347, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.5', '3.8.6_RC55'), (782348, 1, 'OK', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '2025-04-22 10:29:29', '0', 'fdd7375c-10c8-4e7e-8338-2afaea76e901', '2025-04-22 10:29:29', '', '', '3.1.4', '3.8.6_RC55'),