CREATE DATABASE cynodedb;

CREATE TABLE sentiment (
                           ID SERIAL primary key,
                           TEXTE varchar(50),
                           TYPE varchar(10),
                           CLIENT_ID integer,
                           CONSTRAINT client_fk foreign key (CLIENT_ID) REFERENCES client(ID)
);


CREATE TABLE etablissement (
    ID SERIAL primary key,
    CODE varchar(10),
    LIBELLE varchar(255),
    AFFICHAGE_SOLDE boolean,
    TRANSACTION_ESPECE boolean,
    GESTION_FIDELITE boolean,
    PREFIXE_ETS varchar(100),
    PREFIXE_CARTE varchar(100),
    MNT_CHARGE decimal(10, 3),
    MNT_FRAIS decimal(10, 3),
    PRODUIT_PRESTATAIRE_CARTE decimal(10, 3),
    PRODUIT_PRESTATAIRE_CARTE decimal(10, 3),
    PRODUIT_PRESTATAIRE_TICKET decimal(10, 3),
    VILLE varchar(100),
    ADRESSE varchar(100),
    TELEPHONE varchar(100),
    FAXE varchar(100),
    EMAIL varchar(100),
    SITEWEB varchar(100),
    CODE_BPM varchar(100),
    CODE_SMS varchar(100),
    CODESMS_SERVICE varchar(100),
    SENDERID varchar(100),
    PREFIXE_URL varchar(100),
    EMAIL boolean,
    SMS boolean,
    PAYS varchar(100),
    LOGO varchar(250)
);


CREATE TABLE terminal (
    ID SERIAL primary key,
    REFERENCE varchar(50),
    REFERENCE_COURT varchar(10),
    MARQUE varchar(50),
    MODELE varchar(50),
    NOSERIE varchar(50),
    ANNEE_FABRICATION varchar(5),
    INITIALISATION boolean,
    CONNECTIVITE varchar(10)

);


CREATE TABLE region (
    ID SERIAL primary key,
    CODEREG varchar(10),
    LIBELLE varchar(50)
);

CREATE TABLE naturepiece (
        ID SERIAL primary key,
        LIBELLE varchar(50)
);


-- définit les types de pièces d'identité fournis par les clients .
CREATE TABLE typepiece (
        ID SERIAL primary key,
        NATUREPIECE_ID integer,
        CONSTRAINT naturepiece_fk foreign key (NATUREPIECE_ID) REFERENCES naturepiece(ID),
        LIBELLE varchar(50)
);


CREATE TABLE civilite (
        ID SERIAL primary key,
        CODE varchar(10),
        LIBELLE varchar(50),
        LIBELLE_COURT varchar(10)
);

-- Elle permet d'indiquez les périodicités de recharges automatiques des cartes carburants des clients.
CREATE TABLE frequencerecharge (
        ID SERIAL primary key,
        CODE varchar(10),
        LIBELLE varchar(50),
        NBR_JOUR integer,
        NBR_MOIS integer
);


-- Dans la tble service sont config les services disponibles dans un point de service d'un etablissement
-- service possible : carburant, espace auto, boutique, ticket, dotation
CREATE TABLE service (
        ID SERIAL primary key,
        CODE varchar(10),
        LIBELLE varchar(50)
);

CREATE TABLE typerecharge (
        ID SERIAL primary key,
        LIBELLE varchar(50)
);

-- cette tble gere les types de carte utilisés par les client Ex: ANDANDO ELTON GOLD
-- Indique egalement les services pris en compte par type de carte.
CREATE TABLE profilecarte (
    ID SERIAL primary key,
    CODE varchar(10),
    LIBELLE varchar(50),
    PRIX_UNITAIRE decimal(10,3),
    UNITE_ID  integer,
    FOND_CARTE varchar(100),
    MAQUETTE varchar(100),
    DEMANDE_CARTE boolean,
    PAIEMENT_DEPLACE boolean,
    DUREE_VALIDITE integer, --duree de validite en nbr de mois Ex: 60
    PLAFOND_OFFLINE decimal(10,3),
    TYPERECHARGE_ID integer,
    SERVICE_AUTORISE boolean,
    TRANSFERT_AUTORISE boolean,
    RECHARGEABLE boolean,
    DEBITRICE booelan,
    TYPE_FACTURATION_ID integer,
    MNT_MAX_TRANSACTION decimal(10,3),
    CONSTRAINT typerecharge_fk foreign key (TYPERECHARGE_ID) REFERENCES typerecharge(ID),
    CONSTRAINT unite_fk foreign key (UNITE_ID) REFERENCES unite(ID),
    CONSTRAINT type_facturation_fk foreign key (TYPE_FACTURATION_ID) REFERENCES type_facturation(ID)
);

-- determine les unites de mesure de la monnai Ex : Franc CFA(FCFA)
CREATE TABLE unite (
    ID SERIAL primary key,
    LIBELLE varchar(50),
    LIBELLE_COURT varchar(50)
);

CREATE TABLE type_facturation (
    ID SERIAL primary key,
    LIBELLE varchar(50)
);

-- caracterise les differents motifs d'opposition(blocage) de carte. Ex: opposition sur vol
CREATE TABLE type_opposition (
    ID SERIAL primary key,
    CODE varchar(10),
    LIBELLE varchar(50)
);

-- determine ou définit les valeurs des tickets de carburant vendus aux clients.
-- la vue liste correspondante est affichee avec les informations : Code, Intitulé, Valeur, Unité, Types d'énergie associés
CREATE TABLE valeur_ticket_carburant (
    ID SERIAL primary key,
    CODE varchar(10),
    LIBELLE varchar(50),
    VALEUR decimal(10,3),
    UNITE_ID integer,
    TYPE_ENERGIE_ID integer,
    CONSTRAINT unite_fk foreign key (UNITE_ID) REFERENCES unite(ID),
    CONSTRAINT type_energie_fk foreign key (TYPE_ENERGIE_ID) REFERENCES type_energie(ID)
);


-- Les types d'énergie sont utilisés pour définir les différents types d'énergie qui sont vendus dans le cadre des transactions où le carburant est impliqué.
CREATE TABLE type_energie (
    ID SERIAL primary key,
    CODE varchar(10),
    LIBELLE varchar(50),
    DATE_EFFET date,
    MNT_TTC decimal(10, 3),
    MNT_HTVA decimal(10, 3),
    MNT_HTHD decimal(10, 3),
    MNT_HTT decimal(10, 3)
);


-- Dans cette partie on determine le parametrage des notifications. Ex : 1 priorite la plus faible
CREATE TABLE priorite (
    ID SERIAL primary key,
    CODE varchar(10),
    LIBELLE varchar(50),
    NOORDRE integer,
    DEFAULT_PRIORITY boolean
);

-- définit les modèles de messages utilisés pour les envois automatisés
CREATE TABLE modele_message (
    ID SERIAL primary key,
    CODE varchar(10),
    ETABLISSEMENT_ID integer,
    LIBELLE varchar(250),
    CONTENUE_SMS varchar(250),
    OBJET_EMAIL varchar(250),
    CONTENUE_EMAIL text,
    CONSTRAINT etablissement_fk foreign key (ETABLISSEMENT_ID) REFERENCES etablissement(ID)
);


CREATE TABLE fonction_sms (
    ID SERIAL primary key,
    LIBELLE varchar(100)
);

-- Fonction Sms et Service Sms en souffrance. On n'a pas trouver suffisament de documentation

-- permet de parametrer les categories de report. il existe 3 categories Ex : Etablisement /Client, Reseau
CREATE TABLE categorie_report (
    ID SERIAL primary key,
    LIBELLE varchar(100)
);

CREATE TABLE report (
    ID SERIAL primary key,
    LIBELLE varchar(100)
);


-- definit les mode de paiement pendant les reglements des factures
CREATE TABLE mode_paiement (
    ID SERIAL primary key,
    CODE varchar(100),
    LIBELLE varchar(100),
    NOORDRE integer
);


CREATE TABLE condition_facturation (
    ID SERIAL primary key,
    LIBELLE varchar(100),
    MODE_FACTURATION varchar(50) -- enum ça va être pour Au comptant, En fin de mois, A une date fixe
    --enum ModeFacturation { AUCOMPTANT, EN_FIN_DE_MOIS }
);



-----------------------------------------------

-- Secion Securite
-- gere la conception DDM de la partie securite
-- utilisateurs --
-- rôles --
-- permissions /droits acces --
-- groupes --

CREATE TABLE utilisateur (
    ID SERIAL primary key,
    NOM varchar(255), -- concatenation prenom+nom
    CIVILITE_ID integer,
    ADRESSE varchar(255),
    TELEPHONE varchar(255),
    EMAIL varchar(255),
    TYPE_UTILISATEUR_ID integer, -- ROLE / TYPE Utilisateur
    NOM_UTILISATEUR varchar(255) unique not null,
    MDP varchar(255),
    FIRST_LOGIN boolean default true, -- par defaut à true forer l'utilisater dans la logique de changer e mdp à la 1ere cnx
    STATUT boolean,
    DESCRIPTION varchar(255),
    ETABLISSEMENT varchar(100), -- / CONSTRAINT etablissement_fk foreign key (ETABLISSEMENT_ID) REFERENCES etablissement(ID)
    CONSTRAINT type_utilisateur_fk foreign key (TYPE_UTILISATEUR_ID) REFERENCES type_utilisateur(ID)

);


CREATE TABLE type_utilisateur (
    ID SERIAL primary key,
    LIBELLE varchar(255),
    ROLE_ID integer,

);


--- voilà l'approche utilise pour gerer les utilisateurs - roles - permissions
CREATE TABLE user_roles (
    UTILISATEUR_ID INTEGER REFERENCES utilisateur(ID) ON DELETE CASCADE,
    ROLE_ID INTEGER REFERENCES ROLE(ID) ON DELETE CASCADE,
    PRIMARY KEY (user_id, role_id)
);


CREATE TABLE role (
    ID SERIAL primary key,
    POUVOIR varchar(255),  -- Ex : ROLE_AFFECTATION_CARTE
    LIBELLE varchar(255),
    DESCRIPTION varchar(255),
    ATTRIBUTION_UNIQUE boolean,
    ROLE_SYSTEM boolean
);



