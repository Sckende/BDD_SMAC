-- List creation
    -- demo::ge
CREATE TYPE ge_list
AS ENUM ('a la main',
         'au nid',
         'balchatri',
         'canonnet',
         'cage-piege',
         'clapnet',
         'corral',
         'epuisette',
         'filet canopee',
         'filet horizontal',
         'filet rabattant',
         'filet vertical',
         'filets superposes',
         'inconnu',
         'motole',
         'nasse',
         'netgun',
         'noeud coulant',
         'soins', -- <== point d'entree pour les oiseaux de la SEOr
         'trappe helgoland',
         'wooshnet',
         'autre');

    -- demo::fs
CREATE TYPE fs_list
AS ENUM ('a la main',
         'au nid',
         'balchatri',
         'canonnet',
         'cage-piege',
         'clapnet',
         'corral',
         'epuisette',
         'filet horizontal',
         'filet rabattant',
         'filet vertical',
         'filets superposes',
         'inconnu',
         'motole',
         'noeud coulant',
         'trappe helgoland',
         'wooshnet');

    -- demo::espece
CREATE TYPE espece_list
AS ENUM ('ACRTRI',
         'FOUMAD',
         'GEOSTR',
         'PASDOM',
         'PHALEP',
         'PLOCUC',
         'PSEATE',
         'PTEBAR',
         'PUFLHE',
         'PUFPAC',
         'PYCJOC',
         'STEFUS',
         'STRPIC',
         'ZOSBOR')

-- Table creation
CREATE TABLE localites (
    localite_id BIGSERIAL NOT NULL PRIMARY KEY,
    localite VARCHAR(60), -- CRBPO
    dpt VARCHAR(4), -- CRBPO
    pays VARCHAR(2) -- CRBPO
);

CREATE TABLE lieudits (
    lieudit_id BIGSERIAL NOT NULL PRIMARY KEY,
    localite_id INT REFERENCES localites (localite_id),
    lieudit VARCHAR(60), -- CRBPO
    lat FLOAT, -- CRBPO
    lon FLOAT -- CRBPO
);

CREATE TABLE protocoles (
    protocole_id BIGSERIAL NOT NULL PRIMARY KEY,
    protocole_nom VARCHAR(20) NOT NULL,
    theme VARCHAR(20) NOT NULL
);

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

-- Association 2 --
CREATE TABLE missions_protocoles (
    protocole_id INT REFERENCES protocoles (protocole_id),
    mission_id INT REFERENCES missions (mission_id),
    PRIMARY KEY (protocole_id, mission_id)
);

-- Table parent
CREATE TABLE demo (
    lieudit_id INT REFERENCES lieudits (lieudit_id) 
    prog_id prog_id_list, -- CRBPO
    centre centre_list, -- CRBPO
    theme_session "PROG PERS", -- CRBPO
    theme "PROG PERS", -- CRBPO
    origine_data origine_data_list, -- need to CREATE TYPE
    ge ge_list, -- CRBPO
    fs fs_list, -- CRBPO
    espece espece_list -- CRBPO, need to CREATE TYPE ou CREATE TABLE?
    bagueur  INT REFERENCES intervenants (intervenant_id) -- CRBPO
    
);

CREATE TABLE manip_oiseaux (
    manip_oiseau_id BIGSERIAL NOT NULL PRIMARY KEY,
    dateheure_manip DATETIME, -- CRBPO
    action bird_action_list, -- CRBPO, need to CREATE TYPE
    bague_pd VARCHAR(8), -- voir la taille et le format du code
    bague_pg VARCHAR(8),
    code_darvik VARCHAR(10), -- voir taille et format du code
    couleur_darvik VARCHAR(20),
    pds FLOAT,
    plaque_incub BOOLEAN,
    age bird_age_list, -- CRBPO, need to CREATE TYPE
    es etat_sante_list, -- CRBPO,  need to CREATE TYPE
    mu etat_mue_list, -- CRBPO,  need to CREATE TYPE
    bg INT REFERENCES intervenants (intervenant_id), -- CRBPO, TO CHECK
    sg INT REFERENCES intervenants (intervenant_id), -- CRBPO, TO CHECK
    remarque_manip TEXT
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
    sexe oiseau_sexe_list, -- CRBPO, NEED TO CREATE TYPE
    methode_sexage methode_sexage_list, -- NEED TO CREATE TYPE
    groupe_genetique -- TO DEFINE
);

CREATE TABLE reprises (
    reprise_id BIGSERIAL NOT NULL PRIMARY KEY,
    manip_oiseau_id INT REFERENCES manip_oiseaux (manip_oiseau_id),
    cond_repr cond_repr_list, -- CRBPO, NEED TO CREATE TYPE
    circ_repr circ_repr_list -- CRBPO, NEED TO CREATE TYPE
);

CREATE TABLE oiseau_soins (
    oiseau_soin_id BIGSERIAL NOT NULL PRIMARY KEY,
    manip_oiseau_id INT REFERENCES manip_oiseaux (manip_oiseau_id),
    localite_relache INT REFERENCES localites (localite_id), -- NEED TO CREATE TABLE
    date_decouverte DATE, -- voir si equivalent a la date de baguage
    date_relache DATE,
    un un_list, -- CRBPO, NEED TO CREATE TYPE, toujours le meme ?
    MEMO TEXT, -- CRBPO, a garder ?
    ir TEXT, -- CRBPO, a garder ?
    type_marque ??, -- CRBPO, a garder ?
    couleur_gauche ??, -- CRBPO, a garder ?
    couleur_droite ??, -- CRBPO, a garder ?
    sens_lecture_gauche ??, -- CRBPO, a garder ?
    sens_lecture_droite ??, -- CRBPO, a garder ?
    inscription_gauche ??, -- CRBPO, a garder ?
    inscription_droite ??, -- CRBPO, a garder ?
    numero_inventaire INT,
    tete_reseau INT REFERENCES intervenants (intervenant_id)
);