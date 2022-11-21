-- CREATE DATABASE smactracking;

CREATE TYPE balise_action_list
AS ENUM ('deploiement',
         'controle',
         'recuperation');


CREATE TYPE methode_deploiement_list
AS ENUM ('harnais',
         'tesa_sur_queue',
         'sous_cutane');

CREATE TYPE acquisition_mode_list
AS ENUM ('balise',
         'station',
         'online');

CREATE TYPE acquisition_donnees_list
AS ENUM ('donnees_dispo',
         'donnees_non_dispo',
         'envoi_constructeur');

CREATE TYPE data_lieu_stockage_list
AS ENUM ('ordinateur',
         'serveur',
         'ordinateur_serveur');

CREATE TABLE localites (
    localite_id BIGSERIAL NOT NULL PRIMARY KEY,
    localite VARCHAR(60), -- CRBPO
    dept VARCHAR(4), -- CRBPO
    pays VARCHAR(2) -- CRBPO
);

CREATE TABLE lieudits (
    lieudit_id BIGSERIAL NOT NULL PRIMARY KEY,
    localite_id INT REFERENCES localites (localite_id),
    lieudit VARCHAR(60), -- CRBPO
    lat FLOAT NOT NULL DEFAULT 99.99, -- CRBPO
    lon FLOAT NOT NULL DEFAULT 99.99-- CRBPO
);

CREATE TABLE intervenants (
    intervenant_id BIGSERIAL NOT NULL PRIMARY KEY,
    interv_nom varchar(50),
    interv_prenom varchar(50),
    initiales varchar(6) UNIQUE,
    organisme varchar(50)
);
        
CREATE TABLE missions (
    mission_id BIGSERIAL NOT NULL PRIMARY KEY,
    mission_nom VARCHAR(50),
    mission_date_debut DATE,
    mission_date_fin DATE,
    lieudit_id INT REFERENCES lieudits (lieudit_id),
    fonds VARCHAR(50),
    cr BOOLEAN
);

-- Association 1 --
CREATE TABLE missions_intervenants (
    mission_id INT REFERENCES missions (mission_id),
    intervenant_id INT REFERENCES intervenants (intervenant_id),
    PRIMARY KEY (mission_id, intervenant_id)
);

CREATE TABLE protocoles (
    protocole_id BIGSERIAL NOT NULL PRIMARY KEY,
    protocole_nom VARCHAR(20) NOT NULL,
    theme VARCHAR(20) NOT NULL
);
-- Association 2 --
CREATE TABLE missions_protocoles (
    mission_protocole_id BIGSERIAL NOT NULL PRIMARY KEY,
    protocole_id INT REFERENCES protocoles (protocole_id),
    mission_id INT REFERENCES missions (mission_id)
);

CREATE TABLE balises (
    balise_id BIGSERIAL NOT NULL PRIMARY KEY,
    balise_type VARCHAR(20),
    balise_marque VARCHAR(50),
    balise_modele VARCHAR(20),
    balise_identifiant VARCHAR(20),
    balise_poids FLOAT
);
    
CREATE TABLE balise_actions (
    balise_action_id BIGSERIAL NOT NULL PRIMARY KEY,
    balise_id INT REFERENCES balises (balise_id),
    intervenant_id INT REFERENCES intervenants (intervenant_id),
    cmr_bague VARCHAR(9),
    balise_action balise_action_list,
    action_date DATE,
    action_heure TIME,
    action_remarque TEXT
);

CREATE TABLE balise_data_acquisitions (
    balise_data_acquisition_id BIGSERIAL NOT NULL PRIMARY KEY,
    balise_action_id INT REFERENCES balise_actions (balise_action_id),
    acquisition_mode acquisition_mode_list,
    acquisition_date DATE NOT NULL,
    acquisition_donnees acquisition_donnees_list,
    data_pre_processing BOOLEAN NOT NULL,
    data_exploitable BOOLEAN NOT NULL,
    data_analyse BOOLEAN NOT NULL,
    data_lieu_stockage data_lieu_stockage_list,
    nom_fichier VARCHAR(20) NOT NULL,
    acqui_remarque TEXT
);

CREATE TABLE gls_fichiers_disponibles (
    gls_fichiers_disponible_id BIGSERIAL NOT NULL PRIMARY KEY,
    balise_data_acquisition_id INT REFERENCES balise_data_acquisitions (balise_data_acquisition_id),
    lig BOOLEAN NOT NULL,
    lig_filtre BOOLEAN NOT NULL,
    act BOOLEAN NOT NULL,
    temp BOOLEAN NOT NULL
);

-- Surclasse A --
CREATE TABLE action_deploiements (
    action_deploiement_id BIGSERIAL NOT NULL PRIMARY KEY,
    balise_action_id INT REFERENCES balise_actions (balise_action_id),
    balise_date_allumage DATE,
    balise_heure_allumage TIME
);
-- Sous-classe A1 --
CREATE TABLE gps_depl_metadatas (
    gps_depl_metadata_id BIGSERIAL NOT NULL PRIMARY KEY,
    action_deploiement_id INT REFERENCES action_deploiements (action_deploiement_id),
    gps_intervalle VARCHAR(10),
    nb_skipped_pos INT,
    nb_pos INT,
    records_in_logs_alt BOOLEAN,
    records_in_logs_speed BOOLEAN,
    diving_sensor BOOLEAN,
    start_delay INT,
    radio_act INT,
    work_time_limit INT,
    base_range BOOLEAN,
    work_hour_start TIME,
    work_hour_end TIME,
    gps_remarque TEXT
);
-- Sous-classe A2 --
CREATE TABLE argos_depl_metadatas (
    argos_depl_metadata_id BIGSERIAL NOT NULL PRIMARY KEY,
    action_deploiement_id INT REFERENCES action_deploiements (action_deploiement_id),
    methode_depl methode_deploiement_list,
    argos_remarque TEXT
    );
-- Sous-classe A3 --
CREATE TABLE gls_depl_metadatas (
    gls_depl_metadata_id BIGSERIAL NOT NULL PRIMARY KEY,
    action_deploiement_id INT REFERENCES action_deploiements (action_deploiement_id),
    date_debut_pre_calibrage DATE NOT NULL,
    heure_debut_pre_calibrage TIME NOT NULL,
    date_fin_pre_calibrage DATE NOT NULL,
    heure_fin_pre_calibrage TIME NOT NULL,
    lat_pre_calibrage FLOAT NOT NULL,
    lon_pre_calibrage FLOAT NOT NULL,
    date_debut_post_calibrage DATE NOT NULL,
    heure_debut_post_calibrage TIME NOT NULL,
    date_fin_post_calibrage DATE NOT NULL,
    heure_fin_post_calibrage TIME NOT NULL,
    lat_post_calibrage FLOAT NOT NULL,
    lon_post_calibrage FLOAT NOT NULL,
    gls_remarque TEXT
    );