INSERT INTO intervenants (interv_nom, interv_prenom, initiale, organisme)
VALUES
        ('Le Corre', 'Matthieu', 'MLC', 'ENTROPIE'),
        ('Jaeger', 'Audrey', 'AJ', 'ENTROPIE'),
        ('Humeau', 'Laurence', 'LH', 'PVBMT'),
        ('Soulaimana-Mattoir', 'Yahaia', 'YSM', 'ENTROPIE'),
        ('Orlowski ', 'Sabine', 'SO', 'ENTROPIE'),
        ('Avargues', 'Naïs', 'NA', 'ENTROPIE'),
        ('Dubos', 'Jérôme', 'JD', 'ENTROPIE'),
        ('Chaurand', 'Marie-Laure', 'MLCh', 'ENTROPIE'),
        ('Juhasz', 'Claire-Cécile', 'CCJ', 'ENTROPIE');
 
INSERT INTO protocoles (protocole_nom, theme)
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

INSERT INTO balises (balise_type, balise_marque, balise_modele,  balise_num_serie, balise_poids)
VALUES 
        ('ARGOS', 'Microwave telemetry', 'PPT solaire', '167204', '2'),
        ('ARGOS', 'Microwave telemetry', 'PPT solaire', '167256', '2'),
        ('ARGOS', 'Microwave telemetry', 'PPT solaire', '145899', '2'),
        ('ARGOS', 'Microwave telemetry', 'PPT solaire', '123656', '2'),
        ('ARGOS', 'Microwave telemetry', 'PPT solaire', '123589', '2'),
        ('ARGOS', 'Microwave telemetry', 'PPT solaire', '123666', '2'),
        ('ARGOS', 'Microwave telemetry', 'PPT solaire', '147555', '2'),
        ('ARGOS', 'Microwave telemetry', 'PPT solaire', '147877', '2'),
        ('ARGOS', 'Microwave telemetry', 'PPT solaire', '163222', '2'),
        ('ARGOS', 'Microwave telemetry', 'PPT solaire', '145789', '2'),
        ('ARGOS', 'Microwave telemetry', 'PPT solaire', '145200', '2'),
        ('GLS', 'Biotrack', 'MK4082', '147856g', '1'),
        ('GLS', 'Biotrack', 'MK4082', '147856g', '1'),
        ('GLS', 'Biotrack', 'MK4082', '147856g', '1'),
        ('GLS', 'Biotrack', 'MK4082', '147856g', '1'),
        ('GLS', 'Biotrack', 'MK4082', '147856g', '1'),
        ('GPS', 'Biotrack', 'PICA solaire', '173001', '5'),
        ('GPS', 'Biotrack', 'PICA solaire', '173002', '5'),
        ('GPS', 'Biotrack', 'PICA solaire', '173004', '5'),
        ('GPS', 'Biotrack', 'PICA solaire', '172345', '5'),
        ('GPS', 'Pathtrack', 'PICA solaire', '172346', '5'),
        ('GPS', 'Pathtrack', 'NANO', '245678', '10'),
        ('GPS', 'Pathtrack', 'NANO', '245677', '10'),
        ('GPS', 'Pathtrack', 'NANO', '245777', '10'),
        ('GPS', 'Pathtrack', 'NANO', '245778', '10');
       
INSERT INTO missions (mission_nom, localisation, mission_date_debut, mission_date_fin, cr, nom_cr)
VALUES
        ('GB1', 'Grand Benare', '2019-01-15', '2019-01-17', '0', ''),
        ('GB2', 'Grand Benare', '2019-02-15', '2019-02-17', '1', 'cr_GB2'),
        ('GB3', 'Grand Benare', '2019-03-15', '2019-03-17', '1', 'cr_GB3'),
        ('GB4', 'Grand Benare', '2019-04-15', '2019-04-17', '0', ''),
        ('GB5', 'Grand Benare', '2020-01-15', '2020-01-17', '0', ''),
        ('GB6', 'Grand Benare', '2020-02-15', '2020-02-17', '1', 'cr_GB6'),
        ('BDE1', 'Bas des Etangs', '2019-01-20', '2019-01-24', '1', 'cr_BDE1'),
        ('BDE2', 'Bas des Etangs', '2019-02-20', '2019-02-24', '1', 'cr_BDE2'),
        ('BDE3', 'Bas des Etangs', '2019-03-20', '2019-03-24', '1', 'cr_BDE3'),
        ('BDE4', 'Bas des Etangs', '2019-04-20', '2019-04-24', '1', 'cr_BDE4'),
        ('BDE5', 'Bas des Etangs', '2020-01-20', '2020-01-24', '1', 'cr_BDE5'),
        ('BDE6', 'Bas des Etangs', '2020-02-20', '2020-02-24', '0', ''),
        ('BDE7', 'Bas des Etangs', '2020-03-20', '2020-03-24', '0', ''),
        ('BDE8', 'Bas des Etangs', '2020-04-20', '2020-04-24', '1', 'cr_BDE8'),
        ('BDE9', 'Bas des Etangs', '2021-01-20', '2021-01-24', '1', 'cr_BDE9'),
        ('BDE10', 'Bas des Etangs', '2021-02-20', '2021-02-24', '0', '');
        
INSERT INTO missions_intervenants (mission_id, intervenant_id)
VALUES 
        (1, 4),
        (1, 5),
        (1, 6),
        (1, 7),
        (2, 4),
        (2, 5),
        (2, 6),
        (2, 7),
        (2, 1),
        (2, 2),
        (3, 1),
        (3, 2),
        (3, 3),
        (4, 4),
        (4, 5),
        (4, 6),
        (4, 7),
        (5, 1),
        (5, 2),
        (5, 3),
        (5, 4),
        (5, 5),
        (5, 6),
        (5, 7),
        (5, 8),
        (5, 9),
        (6, 1),
        (7, 2),
        (8, 2),
        (9, 1),
        (9, 2),
        (9, 3),
        (9, 4),
        (9, 5),
        (9, 6),
        (9, 7),
        (9, 8),
        (9, 9),
        (10, 9),
        (11, 4),
        (11, 5),
        (11, 6),
        (11, 7),
        (12, 4),
        (12, 5),
        (12, 6),
        (12, 7),
        (13, 4),
        (14, 5),
        (15, 4),
        (15, 5),
        (15, 6),
        (15, 7),
        (16, 1),
        (16, 2),
        (16, 3),
        (16, 4),
        (16, 5),
        (16, 6),
        (16, 7),
        (16, 8),
        (16, 9);
        
INSERT INTO missions_protocoles (mission_id, protocole_id)
VALUES
        (1, 10),
        (1, 11),
        (2, 11),
        (2, 12),
        (3, 10),
        (4, 10),
        (10, 10),
        (10, 12),
        (10, 11),
        (11, 11),
        (12, 12),
        (13, 12),
        (13, 10),
        (15, 10),
        (15, 11),
        (15, 12),
        (16, 12);
        
INSERT INTO balise_actions (balise_id, balise_action, action_date, action_heure, intervenant_id, CMR_bague)
VALUES 
        (17, 'installation', '2020-01-04', '14:40', 5, 'FX5567890'),
        (18, 'installation', '2020-01-04', '14:50', 5, 'FX5561230'),
        (19, 'installation', '2020-01-04', '18:07', 5, 'FX5548640'),
        (20, 'installation', '2020-01-04', '10:30', 5, 'FS5560000'),
        (21, 'installation', '2020-01-04', '5:15', 5, 'FX5542890'),
        (12, 'installation', '2018-04-10', '5:15', 6, 'FX9942890'),
        (13, 'installation', '2018-04-10', '6:15', 6, 'FX9842890'),
        (14, 'installation', '2018-04-10', '7:45', 6, 'FX9942444'),
        (15, 'installation', '2018-04-10', '10:42', 7, 'FS9947790'),
        (16, 'installation', '2018-04-10', '15:22', 7, 'FX9940000'),
        (16, 'controle', '2018-05-11', '16:22', 2, 'FX9940000'),
        (1, 'installation', '2017-10-10', '15:22', 7, 'FX0000001'),
        (2, 'installation', '2017-10-10', '16:22', 7, 'FX0000011'),
        (3, 'installation', '2017-10-10', '17:22', 7, 'FX0000111'),
        (5, 'installation', '2017-10-10', '20:45', 7, 'FX0011111'),
        (6, 'installation', '2017-10-10', '22:00', 7, 'FX0000222'),
        (7, 'installation', '2017-10-10', '8:10', 7, 'FX0000333'),
        (8, 'installation', '2017-10-10', '10:07', 7, 'FX0000444'),
        (9, 'installation', '2017-10-10', '10:34', 7, 'FX0000123'),
        (10, 'installation', '2017-10-10', '11:00', 7, 'FX0001231'),
        (11, 'installation', '2017-10-10', '15:24', 7, 'FX0004561'),
        (1, 'installation', '2017-10-10', '15:52', 7, 'FX0006543'),
        (1, 'controle', '2017-12-24', '15:22', 4, 'FX0000001'),
        (2, 'controle', '2017-12-24', '16:22', 4, 'FX0000011'),
        (3, 'controle', '2017-12-24', '17:22', 4, 'FX0000111'),
        (1, 'recuperation', '2022-01-15', '20:45', 4, 'FX0000001'),
        (2, 'recuperation', '2022-01-16', '19:00', 5, 'FX0000011'),
        (3, 'recuperation', '2022-01-17', '12:23', 7, 'FX0000111'),
        (8, 'recuperation', '2022-01-15', '14:09', 7, 'FX0000444'),
        (5, 'recuperation', '2022-01-15', '16:56', 4, 'FX0011111'),
        (6, 'recuperation', '2022-02-24', '15:45', 2, 'FX0000222'),
        (7, 'recuperation', '2022-02-24', '21:45', 1, 'FX0000333');
        
        
-- REQUETES --
-- DELETE FROM missions_protocoles;

SELECT * FROM missions_intervenants
INNER JOIN intervenants
ON missions_intervenants.intervenant_id = intervenants.intervenant_id
WHERE mission_id = 1;

-------------------------------------------------------------------------------------
-- requete pour recuperer le detail des protocoles et des intervenants par mission -- 
-------------------------------------------------------------------------------------
SELECT * FROM missions_protocoles
INNER JOIN protocoles
ON missions_protocoles.protocole_id = protocoles.protocole_id
INNER JOIN missions_intervenants
ON missions_protocoles.mission_id = missions_intervenants.mission_id
INNER JOIN intervenants
ON missions_intervenants.intervenant_id = intervenants.intervenant_id
WHERE missions_protocoles.mission_id = 1
ORDER by missions_protocoles.mission_id, missions_protocoles.protocole_id ASC;

-- Plus simple --
SELECT * FROM missions_protocoles
INNER JOIN protocoles
ON missions_protocoles.protocole_id = protocoles.protocole_id
INNER JOIN missions_intervenants
ON missions_protocoles.mission_id = missions_intervenants.mission_id
INNER JOIN intervenants
ON missions_intervenants.intervenant_id = intervenants.intervenant_id

WHERE missions_protocoles.mission_protocole_id = 1;

--------------------------------------------------------------------
-- requete pour recuperer la liste des balises d'un certains type -- 
--------------------------------------------------------------------
SELECT * FROM balises
WHERE balise_type = 'GPS';