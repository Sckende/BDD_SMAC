CREATE TABLE demo (
    lieudit_id INT REFERENCES lieudits (lieudit_id) 
    prog_id prog_id_list,
    centre centre_list,
    theme_session "PROG PERS",
    theme "PROG PERS",
    origine_data origine_data_list, -- need to CREATE TYPE
    ge ge_list,
    fs fs_list,
    espece espece_list -- need to CREATE TYPE ou CREATE TABLE?
    bagueur 
    
);

CREATE TABLE nid_metadatas (
    nid_metadata_id BIGSERIAL NOT NULL PRIMARY KEY,
    lat_nid FLOAT,
    lon_nid FLOAT,
    date_nid DATE,
    hauteur_initiale FLOAT,
    largeur_initiale FLOAT,
    profondeur_initiale FLOAT,
    categorie_nid categorie_nid_list, -- need to CREATE TYPE
    type_nid type_nid_list, -- need to CREATE TYPE
    condition_nid condition_nid_list, -- need to CREATE TYPE
    intervenant_id INT REFERENCES intervenants (intervenant_id),
    remarque_nid TEXT    
);

CREATE TABLE manip_oiseaux (
    manip_oiseau_id BIGSERIAL NOT NULL PRIMARY KEY,
    dateheure_manip DATETIME,
    action bird_action_list, -- need to CREATE TYPE
    bague_pd VARCHAR(8), -- voir la taille et le format du code
    bague_pg VARCHAR(8),
    code_darvik VARCHAR(10), -- voir taille et format du code
    couleur_darvik VARCHAR(20),
    pds FLOAT,
    plaque_incub BOOLEAN,
    age bird_age_list, -- need to CREATE TYPE
    es etat_sante_list, -- need to CREATE TYPE
    mu etat_mue_list, -- need to CREATE TYPE
    bg INT REFERENCES intervenants (intervenant_id), -- TO CHECK
    sg INT REFERENCES intervenants (intervenant_id), -- TO CHECK
    remarque_manip TEXT
);

CREATE TABLE nid_visites (
    nid_visite_id BIGSERIAL NOT NULL PRIMARY KEY,
    nid_metadata_id INT REFERENCES nid_metadatas (nid_metadata_id),
    intervenant_id INT REFERENCES intervenants (intervenant_id),
    manip_oiseau_id INT REFERENCES manip_oiseaux (manip_oiseau_id),
    contenu_nid contenu_list_nid, -- need to CREATE TYPE
    methode_contenu methode_contenu_list -- need to CREATE TYPE
);

CREATE TABLE baguages (
    baguage_id BIGSERIAL NOT NULL PRIMARY KEY,
    manip_oiseau_id INT REFERENCES manip_oiseaux (manip_oiseau_id),
    lt FLOAT, -- TO CONFIRME
    lp FLOAT, -- TO CONFIRME
    bc FLOAT, -- TO CONFIRME
    cr FLOAT, -- TO CONFIRME
    bh FLOAT, -- TO CONFIRME
    morpho_complete BOOLEAN,
    sexe oiseau_sexe_list, -- NEED TO CREATE TYPE
    methode_sexage methode_sexage_list, -- NEED TO CREATE TYPE
    groupe_genetique -- TO DEFINE
);