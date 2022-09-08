-- CREATE DATABASE smactracking;

CREATE TYPE action_list
AS ENUM ('installation',
         'controle',
         'recuperation');


CREATE TYPE meth_list
AS ENUM ('harnais',
         'tesa_sur_queue',
         'sous_cutane');

CREATE TYPE gls_extr_list
AS ENUM ('ok/echec',
         'labo/echec',
         'envoye/echec',
         'echec/echec',
         'ok/ok');

CREATE TYPE gps_extr_list
AS ENUM ('en_stock',
         'sur_station_acquisition',
         'extraction_defaillante');

CREATE TYPE argos_extr_list
AS ENUM ('en_stock',
         'extraction_defaillante');

CREATE TABLE intervenants (
    intervenant_id BIGSERIAL NOT NULL PRIMARY KEY,
    interv_nom varchar(50),
    interv_prenom varchar(50),
    initiale varchar(6),
    organisme varchar(50)
);
        
CREATE TABLE missions (
    mission_id BIGSERIAL NOT NULL PRIMARY KEY,
    mission_nom VARCHAR(50),
    localisation VARCHAR(50),
    mission_date_debut DATE,
    mission_date_fin DATE,
    fonds VARCHAR(50),
    cr BOOLEAN,
    nom_cr VARCHAR(50)
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
    protocole_id INT REFERENCES protocoles (protocole_id),
    mission_id INT REFERENCES missions (mission_id),
    PRIMARY KEY (protocole_id, mission_id)
);

CREATE TABLE balises (
    balise_id BIGSERIAL NOT NULL PRIMARY KEY,
    balise_type VARCHAR(20),
    balise_marque varchar(50),
    balise_modele VARCHAR(20),
    balise_num_serie VARCHAR(20),
    balise_poids FLOAT
);
    
CREATE TABLE balise_actions (
    balise_action_id BIGSERIAL NOT NULL PRIMARY KEY,
    balise_id INT REFERENCES balises (balise_id),
    intervenant_id INT REFERENCES intervenants (intervenant_id),
    CMR_bague VARCHAR(9),
    balise_action action_list,
    action_date DATE,
    action_heure TIME,
    action_remarque TEXT
);
-- Surclasse A --
CREATE TABLE balise_data_acquisitions (
    balise_data_acquisition_id BIGSERIAL NOT NULL PRIMARY KEY,
    balise_action_id INT REFERENCES balise_actions (balise_action_id),
    acqui_date DATE NOT NULL,
    data_analyse BOOLEAN NOT NULL,
    data_stockage VARCHAR(20) NOT NULL,
    nom_fichier VARCHAR(20) NOT NULL,
    acqui_remarque TEXT
);
-- Sous-classe A1 --
CREATE TABLE gps_extractions (
    gps_extraction_id BIGSERIAL NOT NULL PRIMARY KEY,
    balise_data_acquisition_id INT REFERENCES balise_data_acquisitions (balise_data_acquisition_id),
    gps_statut_extraction gps_extr_list,
    gps_extr_last_update TIMESTAMP
);
-- Sous-classe A2 --
CREATE TABLE gls_extractions (
    gls_extraction_id BIGSERIAL NOT NULL PRIMARY KEY,
    balise_data_acquisition_id INT REFERENCES balise_data_acquisitions (balise_data_acquisition_id),
    gps_statut_extraction gls_extr_list,
    gls_extr_last_update TIMESTAMP
);
-- Sous-classe A3 --
CREATE TABLE argos_extractions (
    argos_extraction_id BIGSERIAL NOT NULL PRIMARY KEY,
    balise_data_acquisition_id INT REFERENCES balise_data_acquisitions (balise_data_acquisition_id),
    argos_statut_extraction argos_extr_list,
    argos_extr_last_update TIMESTAMP
);
-- Surclasse B --
CREATE TABLE action_deploiements (
    action_deploiement_id BIGSERIAL NOT NULL PRIMARY KEY,
    balise_action_id INT REFERENCES balise_actions (balise_action_id),
    balise_date_allumage DATE,
    balise_heure_allumage TIME
);
-- Sous-classe B1 --
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
-- Sous-classe B2 --
CREATE TABLE argos_depl_metadatas (
    argos_depl_metadata_id BIGSERIAL NOT NULL PRIMARY KEY,
    action_deploiement_id INT REFERENCES action_deploiements (action_deploiement_id),
    methode_depl meth_list,
    argos_remarque TEXT
    );
-- Sous-classe B3 --
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