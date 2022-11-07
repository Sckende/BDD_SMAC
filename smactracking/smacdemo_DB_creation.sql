-- CREATE DATABASE smacdemo;

-- List creation
    -- demo::type_piege
CREATE TYPE type_piege_list
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

    -- demo::effort_capture
CREATE TYPE effort_capture_list
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
         'ZOSBOR');

    -- nid_metadatas::categorie_nid
CREATE TYPE categorie_nid_list
AS ENUM ('NPO',
         'NPB',
         'NOC');

    -- nid_metadatas::type_nid
CREATE TYPE type_nid_list
AS ENUM ('TH',
         'TSB',
         'THSB',
         'CR');

    -- nid_metadatas::condition_nid
CREATE TYPE condition_nid_list
AS ENUM ('OK',
         'EFF1',
         'EFF2',
         'REHAB',
         'STOP_SUIVI');

    -- nid_visites::statut_nid
CREATE TYPE statut_nid_list
AS ENUM ('TPROF',
         'OCC',
         'VIDE',
         'NRT',
         'NC');

    -- nid_visites::contenu_nid
CREATE TYPE contenu_nid_list
AS ENUM ('AUCUN',
         'INCONNU',
         'O',
         'ONV',
         'OINAX',
         'PUL',
         'PULINAX',
         'PULDEAD',
         'AD',
         '2AD',
         'ADINAX',
         'INAX',
         'ADDEAD');

    -- nid_visites::methode_contenu
CREATE TYPE methode_contenu_list
AS ENUM ('MAIN',
         'BURROWSCOPE',
         'REGLE');

    -- demo::origine_data
CREATE TYPE origine_data_list
AS ENUM ('COLONIE',
         'SEOR',
         'PEQ_LA_KOUR');

    -- demo::id_prog
CREATE TYPE id_prog_list
AS ENUM ('609',
         '616');

    -- manip_oiseaux::bird_action
CREATE TYPE bird_action_list
AS ENUM ('B',
         'C',
         'R',
         'BREDOUILLE',
         'SANS',
         'PERDUE',
         'DETRUITE');

    -- manip_oiseaux::bird_age
CREATE TYPE bird_age_list
AS ENUM ('PUL',
         '1A',
         '2A',
         '1A?',
         '2A?',
         '+1A',
         '+2A',
         '+1?',
         '+2?',
         'VOL');

    -- manip_oiseaux::etat_sante
CREATE TYPE etat_sante_list
AS ENUM ('0',
         'BLESS_ANCIEN',
         'BLESS_MARQUE',
         'PLUME_VOL',
         'ENVOL',
         'BLESS_LEG',
         'LANGUE',
         'STRESS',
         'BLESS_MOD',
         'BLESS_SEV',
         'MORT'); -- peut être null

    -- manip_oiseaux::etat_mue
CREATE TYPE etat_mue_list
AS ENUM ('J',
         '0',
         'C',
         'Q',
         'R'); -- peu être null

    -- baguages::bird_sexe
CREATE TYPE bird_sexe_list
AS ENUM ('?',
         'F',
         'M',
         'F?',
         'M?');

    -- baguages::methode_sexage
CREATE TYPE methode_sexage_list
AS ENUM ('genetique',
         'phenotypique',
         'sanguin',
         'autres');

    -- reprises::cond_repr
CREATE TYPE cond_repr_list
AS ENUM ('0',
         '1',
         '2',
         '3',
         '4',
         '5',
         '6',
         '7',
         '8',
         '9');

    -- reprises::cirs_repr
CREATE TYPE circ_repr_list
AS ENUM ('99',
         '00',
         '01',
         '02',
         '03',
         '06',
         '07',
         '08',
         '09',
         '10',
         '11',
         '12',
         '13',
         '14',
         '15',
         '16',
         '19',
         '20',
         '21',
         '22',
         '23',
         '24',
         '25',
         '26',
         '27',
         '28',
         '30',
         '31',
         '32',
         '33',
         '34',
         '35',
         '36',
         '37',
         '38',
         '40',
         '41',
         '42',
         '43',
         '44',
         '45',
         '46',
         '47',
         '48',
         '49',
         '91',
         '50',
         '51',
         '52',
         '53',
         '54',
         '55',
         '56',
         '57',
         '58',
         '59',
         '60',
         '61',
         '62',
         '63',
         '64',
         '65',
         '66',
         '67',
         '68',
         '69',
         '70',
         '71',
         '72',
         '73',
         '74',
         '75',
         '76',
         '77',
         '78',
         '80',
         '81',
         '82',
         '83',
         '84',
         '85',
         '86',
         '87',
         '88',
         '89');

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
    lieudit_id INT REFERENCES lieudits (lieudit_id),
    id_prog id_prog_list, -- CRBPO
    centre VARCHAR(3) NOT NULL DEFAULT 'FRP', -- CRBPO
    theme_session VARCHAR(9) NOT NULL DEFAULT 'PROG PERS', -- CRBPO
    theme VARCHAR(9) NOT NULL DEFAULT 'PROG PERS', -- CRBPO
    origine_data origine_data_list,
    type_piege type_piege_list, -- CRBPO
    effort_capture effort_capture_list, -- CRBPO
    espece espece_list, -- CRBPO
    bagueur  INT REFERENCES intervenants (intervenant_id), -- CRBPO
    modif_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE manip_oiseaux (
    manip_oiseau_id BIGSERIAL NOT NULL PRIMARY KEY,
    dateheure_manip TIMESTAMP, -- CRBPO
    action bird_action_list, -- CRBPO, need to CREATE TYPE
    bague_pd VARCHAR(8) NOT NULL, -- voir la taille et le format du code
    bague_pg VARCHAR(8) NOT NULL,
    code_darvik VARCHAR(10), -- voir taille et format du code
    couleur_darvik VARCHAR(20),
    pds FLOAT,
    plaque_incub BOOLEAN,
    age bird_age_list, -- CRBPO, need to CREATE TYPE
    etat_sante etat_sante_list, -- CRBPO,  need to CREATE TYPE
    etat_mue etat_mue_list, -- CRBPO,  need to CREATE TYPE
    bagueur_vrai INT REFERENCES intervenants (intervenant_id), -- CRBPO, TO CHECK
    stagiaire_formation INT REFERENCES intervenants (intervenant_id), -- CRBPO, TO CHECK
    remarque_manip TEXT,
    modif_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE nid_metadatas (
    nid_metadata_id BIGSERIAL NOT NULL PRIMARY KEY,
    lat_nid FLOAT,
    lon_nid FLOAT,
    date_nid DATE,
    hauteur_initiale FLOAT,
    largeur_initiale FLOAT,
    profondeur_initiale FLOAT,
    categorie_nid categorie_nid_list, 
    type_nid type_nid_list,
    condition_nid condition_nid_list, 
    intervenant_id INT REFERENCES intervenants (intervenant_id),
    remarque_nid TEXT    
);

CREATE TABLE nid_visites (
    nid_visite_id BIGSERIAL NOT NULL PRIMARY KEY,
    nid_metadata_id INT REFERENCES nid_metadatas (nid_metadata_id),
    intervenant_id INT REFERENCES intervenants (intervenant_id),
    manip_oiseau_id INT REFERENCES manip_oiseaux (manip_oiseau_id),
    contenu_nid contenu_nid_list, 
    methode_contenu methode_contenu_list 
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
    sexe bird_sexe_list, -- CRBPO, NEED TO CREATE TYPE
    methode_sexage methode_sexage_list, -- NEED TO CREATE TYPE
    groupe_genetique VARCHAR(30)-- TO DEFINE
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
    localite_relache INT REFERENCES localites (localite_id), 
    date_decouverte DATE, -- voir si equivalent a la date de baguage
    date_relache DATE,
    centre_soins VARCHAR(30) NOT NULL DEFAULT 'Couzi - UFCS, François-Xavier', -- CRBPO, toujours le meme ?
    memo TEXT, -- CRBPO, a garder ?
    couleir_iris TEXT, -- CRBPO, a garder ?
    type_marque VARCHAR(10), -- CRBPO, a garder ?
    couleur_gauche VARCHAR(10), -- CRBPO, a garder ?
    couleur_droite VARCHAR(10), -- CRBPO, a garder ?
    sens_lecture_gauche VARCHAR(10), -- CRBPO, a garder ?
    sens_lecture_droite VARCHAR(10), -- CRBPO, a garder ?
    inscription_gauche VARCHAR(10), -- CRBPO, a garder ?
    inscription_droite VARCHAR(10), -- CRBPO, a garder ?
    numero_inventaire INT,
    tete_reseau INT REFERENCES intervenants (intervenant_id)
);