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