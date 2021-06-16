INSERT INTO departement
	VALUES	(DEFAULT, 'Administration'),
			(DEFAULT, 'Ventes et Représentation'),
			(DEFAULT, 'Achats'),
			(DEFAULT, 'Mécanique'),
			(DEFAULT, 'Électrique'),
			(DEFAULT, 'Informatique et Recherche');

INSERT INTO poste
	VALUES	(DEFAULT, 'Professionnel'),
			(DEFAULT, 'Technicien'),
			(DEFAULT, 'Ingénieur'),
			(DEFAULT, 'Scientifique'),
			(DEFAULT, 'Manutentionnaire et soutient'),
			(DEFAULT, 'Big boss');

INSERT INTO employe
	VALUES (DEFAULT, 'Gratton', 'Bob', 'H','114752369','2018-02-05', '250.00', (SELECT id FROM poste WHERE nom = 'Big boss'), (SELECT id FROM departement WHERE nom = 'Mécanique' )),
			(DEFAULT, 'Dubois', 'Yvan', 'H', '125763114', '2018-03-14', '60.00', (SELECT id FROM poste WHERE nom = 'Professionnel'), (SELECT id FROM departement WHERE nom = 'Ventes et Représentation')),
			(DEFAULT, 'Desfleurs', 'Yvan', 'H', '241321456', '2018-04-01', '75.00', (SELECT id FROM poste WHERE nom = 'Technicien'), (SELECT id FROM departement WHERE nom = 'Électrique')),
			(DEFAULT, 'Desenfants', 'Yvan', 'H', '666999666', '2019-06-06', '66.60', (SELECT id FROM poste WHERE nom = 'Professionnel'), (SELECT id FROM departement WHERE nom = 'Administration')),
			(DEFAULT, 'Deschamps', 'Yvan', 'H', '236899357', '2019-09-11', '150.00', (SELECT id FROM poste WHERE nom = 'Technicien'), (SELECT id FROM departement WHERE nom = 'Mécanique')),
			(DEFAULT, 'Destouches', 'Yvan', 'H', '369428747', '2019-10-28', '125.00', (SELECT id FROM poste WHERE nom = 'Technicien'), (SELECT id FROM departement WHERE nom = 'Informatique et Recherche')),
			(DEFAULT, 'Desbiens', 'Yvan', 'H', '193472682', '2019-11-21', '175.00', (SELECT id FROM poste WHERE nom = 'Professionnel'), (SELECT id FROM departement WHERE nom = 'Achats')),
			(DEFAULT, 'Desponts', 'Yvan', 'H', '236566932', '2019-09-11', '150.00', (SELECT id FROM poste WHERE nom = 'Technicien'), (SELECT id FROM departement WHERE nom = 'Mécanique')),
			(DEFAULT, 'Laplante-Lafleur', 'Yvan', 'H', '186255159', '2020-02-06', '50.00', (SELECT id FROM poste WHERE nom = 'Technicien'), (SELECT id FROM departement WHERE nom = 'Mécanique'));

INSERT INTO rue
	VALUES  (DEFAULT, 'Viau'),
			(DEFAULT, 'Rosemont'),
			(DEFAULT, 'Pie-IX'),
			(DEFAULT, 'Sherbrooke'),
			(DEFAULT, 'Pierre-De Coubertin'),
			(DEFAULT, 'Jeanne-d’Arc');

INSERT INTO veh_marq_mod
	VALUES (DEFAULT, 'Ford', 'F150'),
			(DEFAULT, 'Ford', 'F350'),
			(DEFAULT, 'Yugo', 'GV'),
			(DEFAULT, 'Dodge', 'Ram'),
			(DEFAULT, 'Geo', 'Metro');

INSERT INTO vehicule
	VALUES  (DEFAULT, (SELECT id FROM veh_marq_mod WHERE modele = 'F150'), 'pie314', 'brun', '2020-04-20'),
			(DEFAULT, (SELECT id FROM veh_marq_mod WHERE modele = 'Ram'), 'reboot', 'blanc', '2019-05-12' ),
			(DEFAULT, (SELECT id FROM veh_marq_mod WHERE modele = 'GV'), 'ALT-F4', 'rouille', '1984-10-10');

INSERT INTO las_marq_mod
	VALUES 	(DEFAULT, 'NextEngine 3D', 'Multi-Stripe 3000'),
			(DEFAULT, 'Leica', 'ProScan'),
			(DEFAULT, 'RIEGL', 'VZ-400i');

INSERT INTO laser
	VALUES 	(DEFAULT, (SELECT id from las_marq_mod WHERE marque = 'NextEngine 3D' and modele = 'Multi-Stripe 3000'),
				'TST5LABZ6K8DBBLA'),
			(DEFAULT,(SELECT id from las_marq_mod WHERE marque = 'Leica' and modele = 'ProScan'),
				'NES6K6X4CZ2CTBPR'),
			(DEFAULT,(SELECT id from las_marq_mod WHERE marque = 'RIEGL' and modele = 'VZ-400i'),
				'TPXF3VA84Y2N3FSD');

INSERT INTO intersection
	VALUES 	(nextval('seq_intersection_id'), 45.560792, -73.573835, 'Pavé brique',
			(SELECT id FROM rue WHERE UPPER(nom) = 'ROSEMONT'), (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX')),
			(nextval('seq_intersection_id'), 45.569087, -73.566254, 'Asphalte',
			(SELECT id FROM rue WHERE UPPER(nom) = 'ROSEMONT'), (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU')),
			(nextval('seq_intersection_id'), 45.565361, -73.554497, 'Asphalte',
			(SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE'), (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU')),
			(nextval('seq_intersection_id'), 45.562556, -73.545894, 'Ciment',
			(SELECT id FROM rue WHERE UPPER(nom) = 'PIERRE-DE COUBERTIN'), (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU')),
			(nextval('seq_intersection_id'), 45.553658, -73.551749, 'Pavé brique',
			(SELECT id FROM rue WHERE UPPER(nom) = 'PIERRE-DE COUBERTIN'), (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX')),
			(nextval('seq_intersection_id'), 45.554642, -73.554528, 'Pavé pierre',
			(SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE'), (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX'));

INSERT INTO troncon
    VALUES  (DEFAULT, (SELECT id FROM rue WHERE UPPER (nom) = 'ROSEMONT'), 199.5, 40, 3, 'Asphalte', 'Est',
            (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'ROSEMONT')),
            (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'ROSEMONT'))),


            (DEFAULT, (SELECT id FROM rue WHERE UPPER (nom) = 'ROSEMONT'), 199.5, 40, 3, 'Asphalte', 'Ouest',
            (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'ROSEMONT')),
            (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'ROSEMONT'))),

            (DEFAULT, (SELECT id FROM rue WHERE UPPER (nom) = 'VIAU'), 150.5, 40, 3, 'Asphalte', 'Nord',
            (SELECT id FROM intersection WHERE rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE') AND rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU')),
            (SELECT id FROM intersection WHERE rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'ROSEMONT') AND rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU'))),

            (DEFAULT, (SELECT id FROM rue WHERE UPPER (nom) = 'VIAU'), 150.5, 40, 3, 'Asphalte', 'Sud',
            (SELECT id FROM intersection WHERE rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'ROSEMONT') AND rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU')),
            (SELECT id FROM intersection WHERE rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE') AND rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU'))),

            (DEFAULT, (SELECT id FROM rue WHERE UPPER (nom) = 'VIAU'), 100, 40, 3, 'Asphalte', 'Nord',
            (SELECT id FROM intersection WHERE rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'PIERRE-DE COUBERTIN') AND rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU')),
            (SELECT id FROM intersection WHERE rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE') AND rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU'))),

            (DEFAULT, (SELECT id FROM rue WHERE UPPER (nom) = 'VIAU'), 100, 40, 3, 'Asphalte', 'Sud',
            (SELECT id FROM intersection WHERE rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE') AND rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU')),
            (SELECT id FROM intersection WHERE rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'PIERRE-DE COUBERTIN') AND rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU'))),

            (DEFAULT, (SELECT id FROM rue WHERE UPPER (nom) = 'PIERRE-DE COUBERTIN'), 175.1, 40, 4, 'Asphalte', 'Est',
            (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'PIERRE-DE COUBERTIN')),
            (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'PIERRE-DE COUBERTIN'))),

            (DEFAULT, (SELECT id FROM rue WHERE UPPER (nom) = 'PIERRE-DE COUBERTIN'), 175.1, 40, 4, 'Asphalte', 'Ouest',
            (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'PIERRE-DE COUBERTIN')),
            (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'PIERRE-DE COUBERTIN'))),

            (DEFAULT, (SELECT id FROM rue WHERE UPPER (nom) = 'PIE-IX'), 50, 40, 3, 'Asphalte', 'Nord',
            (SELECT id FROM intersection WHERE rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'PIERRE-DE COUBERTIN') AND rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX')),
            (SELECT id FROM intersection WHERE rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE' ) AND rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX'))),

            (DEFAULT, (SELECT id FROM rue WHERE UPPER (nom) = 'PIE-IX'), 50, 40, 3, 'Asphalte', 'Sud',
            (SELECT id FROM intersection WHERE rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE' ) AND rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX')),
            (SELECT id FROM intersection WHERE rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'PIERRE-DE COUBERTIN') AND rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX'))),

            (DEFAULT, (SELECT id FROM rue WHERE UPPER (nom) = 'SHERBROOKE'), 150.5, 60, 3, 'Asphalte', 'Est',
            (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE')),
            (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE'))),

            (DEFAULT, (SELECT id FROM rue WHERE UPPER (nom) = 'SHERBROOKE'), 150.5, 60, 3, 'Asphalte', 'Ouest',
            (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE')),
            (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE')));

INSERT INTO inspection -- id, dateDebut, dateFin, vehiUti, conducteur, kiloDebut, kiloFin, laserUti, opLaser, filepath, filename
	VALUES 	(DEFAULT, '2020-10-22 10:52:22', '2020-10-22 16:57:45', (SELECT id FROM vehicule WHERE immatr = 'pie314'),
			(SELECT id from employe WHERE nas = '666999666'), '10256', '10345',
			(SELECT id from laser WHERE las_marq_mod = (SELECT id from las_marq_mod WHERE marque = 'NextEngine 3D' and modele = 'Multi-Stripe 3000') and numSerie = 'TST5LABZ6K8DBBLA'),
			(SELECT id from employe WHERE nas = '236899357'), 'c:\important\nepassupprimer\svp\inspections', 'PZW_GPT101-00.xdat'),

			(DEFAULT, '2020-10-23 9:22:22', '2020-10-23 11:11:11', (SELECT id FROM vehicule WHERE immatr = 'pie314'),
			(SELECT id from employe WHERE nas = '193472682'), '2', '16',
			(SELECT id from laser WHERE las_marq_mod = (SELECT id from las_marq_mod WHERE marque = 'Leica' and modele = 'ProScan') and numSerie = 'NES6K6X4CZ2CTBPR'),
			(SELECT id from employe WHERE nas = '236566932'), 'c:\important\nepassupprimer\svp\inspections', 'PZW_AFK961-13.xdat'),

			(DEFAULT, '2020-10-25 08:52:22', '2020-10-25 18:23:23', (SELECT id FROM vehicule WHERE immatr = 'ALT-F4'),
			(SELECT id from employe WHERE nas = '666999666'), '465843', '469834',
			(SELECT id from laser WHERE las_marq_mod = (SELECT id from las_marq_mod WHERE marque = 'RIEGL' and modele = 'VZ-400i') and numSerie = 'TPXF3VA84Y2N3FSD'),
			(SELECT id from employe WHERE nas = '186255159'), 'c:\important\nepassupprimer\svp\inspections', 'PZW_BTW131-00.xdat');

INSERT INTO inspect_tronc
    VALUES  (DEFAULT, (SELECT id FROM inspection WHERE fileName = 'PZW_GPT101-00.xdat'),
			(SELECT id from troncon
				WHERE 	intersection1 = (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE'))
					and intersection2 = (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE'))),
			1),

            (DEFAULT, (SELECT id FROM inspection WHERE fileName = 'PZW_BTW131-00.xdat'),
			 (SELECT id from troncon
				WHERE 	intersection1 = (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'PIE-IX') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE'))
					and intersection2 = (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE'))),
			 2),

			 (DEFAULT, (SELECT id FROM inspection WHERE fileName = 'PZW_BTW131-00.xdat'),
			 (SELECT id from troncon
				WHERE 	intersection1 = (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE'))
					and intersection2 = (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'ROSEMONT'))),
			 2),

            (DEFAULT, (SELECT id FROM inspection WHERE fileName = 'PZW_AFK961-13.xdat'),
			 (SELECT id from troncon
				WHERE 	intersection1 = (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'ROSEMONT'))
					and intersection2 = (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE'))),
			 3),

			 (DEFAULT, (SELECT id FROM inspection WHERE fileName = 'PZW_BTW131-00.xdat'),
			 (SELECT id from troncon
				WHERE 	intersection1 = (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'SHERBROOKE'))
					and intersection2 = (SELECT id FROM intersection WHERE rueNS = (SELECT id FROM rue WHERE UPPER(nom) = 'VIAU') AND rueEO = (SELECT id FROM rue WHERE UPPER(nom) = 'ROSEMONT'))),
			 1);