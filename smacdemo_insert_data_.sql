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