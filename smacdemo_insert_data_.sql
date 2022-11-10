    -- STEP 1 - table LOCALITES
COPY localites(localite, dept, pays)
FROM 'C:\Users\Public\TABLE_LOCALITES_insertions.csv'
DELIMITER ','
CSV HEADER;

-- pour recuperer la derniere mise a jour & recuperer localite_id
COPY localites
TO 'C:\Users\Public\TABLE_LOCALITES_updated.csv'
DELIMITER ','
CSV HEADER;

    -- STEP 2 - table LIEUDITS
COPY lieudits(localite_id, lieudit, lat, lon)
FROM 'C:\Users\Public\TABLE_LIEUDITS_insertions.csv'
DELIMITER ','
CSV HEADER;

-- pour recuperer la derniere mise a jour & lieudit_id
COPY lieudits
TO 'C:\Users\Public\TABLE_LIEUDITS_updated.csv'
DELIMITER ','
CSV HEADER;

    -- STEP 3 - table INTERVENANTS
COPY intervenants(interv_nom, interv_prenom, initiales, organisme)
FROM 'C:\Users\Public\TABLE_INTERVENANTS_insertions.csv'
DELIMITER ','
CSV HEADER;

-- pour recuperer la derniere mise a jour & intervenant_id
COPY intervenants
TO 'C:\Users\Public\TABLE_INTERVENANTS_updated.csv'
DELIMITER ','
CSV HEADER;

    -- STEP 4 - table PROTOCOLES
    
INSERT INTO protocoles (theme, protocole_nom)
VALUES
('Lutte_predateur', 'deratisation'),
('Lutte_predateur', 'dechatisation'),
('Prospection', 'acoustique'),
('Prospection', 'jumelle_thermique'),
('Prospection', 'pedestre'),
('Prospection', 'corde'),
('Prospection', 'PEQ_la_kour'),
('Demo', 'CMR'),
('Demo', 'denombrement'),
('Tracking', 'GPS'),
('Tracking',	'GLS'),
('Tracking',	'ARGOS'),
('Prelevement', 'genetique'),
('Prelevement', 'isotope_mercure'),
('Prelevement', 'dissection_genetique'),
('Prelevement', 'dissection_plastique'),
('Suivi', 'camera_oiseau'),
('Suivi', 'camera_predateur'),
('Suivi', 'jumelle_thermique'),
('Suivi', 'acoustique'),
('Detection', 'obs_opportuniste');

-- pour recuperer la derniere mise a jour & intervenant_id
COPY protocoles
TO 'C:\Users\Public\TABLE_PROTOCOLES_updated.csv'
DELIMITER ','
CSV HEADER;

    -- STEP 5 - table MISSIONS
COPY missions(mission_nom, mission_date_debut, mission_date_fin, cr, lieudit_id)
FROM 'C:\Users\Public\TABLE_MISSIONS_insertions.csv'
DELIMITER ','
CSV HEADER;

-- pour recuperer la derniere mise a jour & intervenant_id
COPY missions
TO 'C:\Users\Public\TABLE_MISSIONS_updated.csv'
DELIMITER ','
CSV HEADER;

    -- STEP 6 - table MISSIONS_PROTOCOLES
COPY missions_protocoles(mission_id, protocole_id)
FROM 'C:\Users\Public\TABLE_MISSIONS_PROTOCOLES_insertions.csv'
DELIMITER ','
CSV HEADER;

-- pour recuperer la derniere mise a jour & intervenant_id
COPY missions_protocoles
TO 'C:\Users\Public\TABLE_MISSIONS_PROTOCOLES_updated.csv'
DELIMITER ','
CSV HEADER;

    -- STEP 7 - table MISSIONS_PROTOCOLES
COPY missions_intervenants(mission_id, intervenant_id)
FROM 'C:\Users\Public\TABLE_MISSIONS_INTERVENANTS_insertions.csv'
DELIMITER ','
CSV HEADER;

-- pour recuperer la derniere mise a jour & intervenant_id
COPY missions_intervenants
TO 'C:\Users\Public\TABLE_MISSIONS_INTERVENANTS_updated.csv'
DELIMITER ','
CSV HEADER;