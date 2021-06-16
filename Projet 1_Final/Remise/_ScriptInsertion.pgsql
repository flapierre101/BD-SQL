-- Début


INSERT INTO joueurs
	VALUES	(DEFAULT, 'Vincent*', 'mon.courriel@unCourriel.com', 'admin', 'h', '2020-01-02', '1991-01-09'),
            (DEFAULT, 'Dany', 'test123@pasfake.com', 'admin', 'h', DEFAULT, '1987-04-07'),
			(DEFAULT, 'Caroline', 'caro@gmail.com', 'password123', 'F', DEFAULT, '1987-04-30'),
            (DEFAULT, 'Francois', 'fl@123.testlocal', 'qwerty', 'H', DEFAULT, '1984-10-10');

INSERT INTO avatars
	VALUES (DEFAULT, 'unNom*', (SELECT id FROM joueurs WHERE alias = 'Vincent*'), 'vert', 'bleu', null, '2020-01-01', 500),
		   (DEFAULT, 'unAutreNom', (SELECT id FROM joueurs WHERE alias = 'Vincent*'), 'fushia', null, null, '2020-05-05', 236),
		   (DEFAULT, 'encoreUnNom', (SELECT id FROM joueurs WHERE alias = 'Vincent*'), 'brun', NULL, null, '2020-07-07', 0),
           (DEFAULT, 'Raggok', (SELECT id FROM joueurs WHERE alias = 'Francois'), 'Vert', 'Jaune', 'Noir', DEFAULT, DEFAULT),
           (DEFAULT, 'Vizir', (SELECT id FROM joueurs WHERE alias = 'Dany'), 'vert', NULL, NULL, DEFAULT, 65535),           
           (DEFAULT, 'Hexen', (SELECT id FROM joueurs WHERE alias = 'Caroline'), 'noir',null,null, DEFAULT, DEFAULT);


INSERT INTO leitmotiv
	VALUES  (DEFAULT, (SELECT id FROM avatars WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Vincent*') AND nom = 'unNom*'), 'une phrase originale et poignante'),
            (DEFAULT, (SELECT id FROM avatars WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Francois')), 'La nuit porte… porte… porte de garage.'),
            (DEFAULT, (SELECT id FROM avatars WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Dany') AND nom = 'Vizir'),'Question 8C : You asked for 5 tables, we give you all of them!!!'),
            (DEFAULT,
			 	(SELECT id FROM avatars WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Caroline')),
            'Nuke it from orbit, it''s the only way to be sure'),
			(DEFAULT,
			 	(SELECT id FROM avatars WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Caroline')),
            'I''ve got 2 guns:1 to end trouble, and another to make trouble');

INSERT INTO mode_paiement
	VALUES  (1, 'Carte de Crédit'),
			(2, 'Paypal');


INSERT INTO jeu
    VALUES  (DEFAULT, 'DeepHorizonX', 'DEEPHX', 'Deepwater Horizon était une plate-forme pétrolière louée par la compagnie pétrolière britannique BP pour forer dans le golfe du Mexique (dans la zone économique exclusive des États-Unis) le puits le plus profond jamais foré en offshore. Elle explose le 20 avril 2010 en tuant 11 personnes, générant un incendie, puis une marée noire de grande envergure.
                Le désastre écologique est sans précédent aux États-Unis.'),
            (DEFAULT, 'FreeZoneX', 'FRZONX', 'Sandbox ou rien n est impossible'),
            (DEFAULT, 'SpaceX', 'SPACEX', 'Control the management of colonies, technology development, ship construction, inter-species diplomacy, and combat.');


INSERT INTO items
    VALUES  (DEFAULT, 'Botte de Rapidité', 'ISWB', 0.1, 10000, 'Ça va vite vite vite', (SELECT id FROM jeu WHERE nom = 'FreeZoneX')),
            (DEFAULT, 'Gants du Dragon', 'IGDD', 0.001, 1000000, 'Parfait pour les hivers rigoureux', (SELECT id FROM jeu WHERE nom = 'FreeZoneX')),
            (DEFAULT, 'Collier du soleil', 'ICDS', 0.002, 100500, 'Wow ça brille!', (SELECT id FROM jeu WHERE nom = 'FreeZoneX')),
            (DEFAULT, 'Pantalons des gens du village', 'IPGV', 0.5, 100, 'YMCA!', (SELECT id FROM jeu WHERE nom = 'FreeZoneX')),
            (DEFAULT, 'Casque du caméléon', 'ICDC', 0.08, 11111, 'N a pas la langue dans la poche', (SELECT id FROM jeu WHERE nom = 'FreeZoneX')),
            (DEFAULT, 'Anneau de pourvoirie', 'IADP', 0.0001, 10000, 'Note de l ancien proprio: j ai attrapé un brochet gros dmême avec ça', (SELECT id FROM jeu WHERE nom = 'FreeZoneX')),
            (DEFAULT, 'Épée de feu et de glace', 'IEFG', 0.003, 100000, 'Attention épée bipolaire', (SELECT id FROM jeu WHERE nom = 'FreeZoneX')),
            (DEFAULT, 'Fragile Pouch', 'IFRB', 0.327670000, 255, 'Full of glitters', (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
            (DEFAULT, 'Smoking Rod', 'ISMO', 0.327671000,   511, 'Smells of sulfur', (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
            (DEFAULT, 'Drum of the Red Spores', 'IDRS', 0.000072200, 1023, 'Do not hit too hard', (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
            (DEFAULT, 'Cittern of Anxiety', 'ICTA', 0.000073330, 2047, 'Is it half full or half empty?', (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
            (DEFAULT, 'Crystal of the Brown Tentacles', 'ICBT', 0.000074444, 4095, 'Propriety of the Old Gods', (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
            (DEFAULT, 'Sword of Looking Blink', 'ISLB', 0.000001254, 8192, 'Now you see me, now you--', (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
            (DEFAULT, 'Cosmic Drill', 'ICDR', 0.000005874, 1575000, 'Mine resources from hostile planets directly from orbit ', (SELECT id FROM jeu WHERE sigle = 'SPACEX')),
		    (DEFAULT, 'Sonic Screwdriver', 'ISSC', 0.000000112, 8995000, 'Powerful omni-tool that can affect space and time', (SELECT id FROM jeu WHERE sigle = 'SPACEX')),
		    (DEFAULT, 'Bio-Nanobots', 'IBIN', 0.000007423, 1300000, 'Your colonies gain +10 in Medecine and Technology', (SELECT id FROM jeu WHERE sigle = 'SPACEX')),
		    (DEFAULT, 'Subspace Ansible', 'ISAN', 0.000458874, 850000, 'Gain lightspeed communication between colonies for superior coordination', (SELECT id FROM jeu WHERE sigle = 'SPACEX')),
		    (DEFAULT, 'Neural Manipulator', 'INMA', 0.000321874,250000, 'Affect your enemy''s thoughts in your favor from a safe distance', (SELECT id FROM jeu WHERE sigle = 'SPACEX')),
		    (DEFAULT, 'Enhanced Shield', 'IESH', 0.002521874, 425000, 'Update your ship''s shield and gain +5 in Damage Resistance and +7 in Energy Resistance', (SELECT id FROM jeu WHERE sigle = 'SPACEX'));


INSERT INTO achat
	VALUES  (DEFAULT, '2020-01-01', 1, 5.50, 1, '2020-01-01', '2021-01-01',(SELECT id FROM joueurs WHERE alias = 'Vincent*'), NULL),
			(DEFAULT, '2020-05-05', 1, 12.13, 2, NULL, NULL, (SELECT id FROM joueurs WHERE alias = 'Vincent*'), (SELECT id FROM items WHERE sigle = 'ISMO')),
            (DEFAULT, DEFAULT, 1, 100.50, 2, NULL, NULL, (SELECT id FROM joueurs WHERE alias = 'Francois'), (SELECT id FROM items WHERE sigle = 'IADP')),
            (DEFAULT, DEFAULT, 1, 19.99, 1, '2020-10-10', '2020-11-10', (SELECT id FROM joueurs WHERE alias = 'Francois'), NULL),
			(DEFAULT, DEFAULT, 2, 255,1, '2020-12-01', '2021-05-30', (SELECT id FROM joueurs WHERE alias = 'Dany'), NULL),
            (DEFAULT, DEFAULT, 1, 255,2, NULL, NULL, (SELECT id FROM joueurs WHERE alias = 'Dany'), (SELECT id FROM items WHERE sigle = 'ICTA')),
            (DEFAULT, DEFAULT, (SELECT id FROM mode_paiement WHERE type = 'Paypal'), 45.00, 2, NULL, NULL, (SELECT id FROM joueurs WHERE alias = 'Caroline'), (SELECT id FROM items WHERE sigle = 'ISAN')),
			(DEFAULT, DEFAULT, (SELECT id FROM mode_paiement WHERE type = 'Paypal'), 125.00, 2, NULL, NULL, (SELECT id FROM joueurs WHERE alias = 'Caroline'), (SELECT id FROM items WHERE sigle = 'ISSC'));


INSERT INTO habilete
    VALUES  (DEFAULT, 'visée automatique', 'SVA', 30.00, 333.33, 'amélioration : précision', (SELECT id FROM jeu WHERE nom = 'FreeZoneX')),
            (DEFAULT, 'ubiquité', 'SUB', 55.55, 555.55, 'amélioration : durée du multiprésence', (SELECT id FROM jeu WHERE nom = 'FreeZoneX')),
            (DEFAULT, 'IWINBUTTON', 'SIW', 250.00, 999.00, 'Amène la paix dans le monde, justice pour tous, fin du racisme, etc', (SELECT id FROM jeu WHERE nom = 'FreeZoneX')),
            (DEFAULT, 'Auto guérison', 'SD1', 100.00, 450.000, 'amélioration : capacité d’auto guérison de plus en plus fréquente', (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
            (DEFAULT, 'Implant d’un zoom oculaire', 'SD2', 250.00, 0.000, 'amélioration : niveau du zoom', (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
            (DEFAULT, 'Eau grasseuse', 'SD3', 30.00, 150.000, 'Dommage : ralenti les ennemis', (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
            (DEFAULT, 'Intergalactic Terraforming', 'SIT', 195.00, 650.000, 'You and your colonies grow faster and thrive with +5 in Survival, +5 in Science and + 10 in Agriculture', (SELECT id FROM jeu WHERE sigle = 'SPACEX')),
			(DEFAULT, 'Genetic Engineering 101', 'SGE', 210.00, 780.000, 'Modifies your DNA. Health damage from exposure on hostile planets, thirst or hunger is reduced by 25%', (SELECT id FROM jeu WHERE sigle = 'SPACEX')),
			(DEFAULT, 'Inter-System Pharmacology', 'SIP', 182.00, 990.000, 'Your intergalactic chemistry skills lets you create powerful health potions on every planet', (SELECT id FROM jeu WHERE sigle = 'SPACEX'));



INSERT INTO activite
	VALUES	(DEFAULT, (SELECT id FROM joueurs WHERE alias = 'Vincent*'), '2020-01-01 23:00:00', 18000),
			(DEFAULT,  (SELECT id FROM joueurs WHERE alias = 'Vincent*'), '2020-05-02 23:00:00', 3600),
			(DEFAULT,  (SELECT id FROM joueurs WHERE alias = 'Vincent*'), '2020-05-03 23:00:00', 3600),
			(DEFAULT,  (SELECT id FROM joueurs WHERE alias = 'Vincent*'), '2020-05-04 23:00:00', 3600),
			(DEFAULT,  (SELECT id FROM joueurs WHERE alias = 'Vincent*'), '2020-05-05 23:00:00', 3600),
			(DEFAULT,  (SELECT id FROM joueurs WHERE alias = 'Vincent*'), '2020-05-06 23:00:00', 3600),
			(DEFAULT,  (SELECT id FROM joueurs WHERE alias = 'Vincent*'), '2020-05-07 23:00:00', 18000),
			(DEFAULT,  (SELECT id FROM joueurs WHERE alias = 'Vincent*'), '2020-05-08 23:00:00', 15750),
			(DEFAULT,  (SELECT id FROM joueurs WHERE alias = 'Vincent*'), '2020-05-09 23:00:00', 1730),
			(DEFAULT,  (SELECT id FROM joueurs WHERE alias = 'Vincent*'), '2020-05-10 23:00:00', 36000),
            (DEFAULT, (SELECT id FROM joueurs WHERE alias = 'Caroline'), '2020-09-14 14:29:11', 3600),
            (DEFAULT, (SELECT id FROM joueurs WHERE alias = 'Caroline'), '2020-09-22 18:44:11', 500),
            (DEFAULT, (SELECT id FROM joueurs WHERE alias = 'Caroline'), '2020-10-01 20:12:22', 3600);


INSERT INTO activite_avatar_jeu
	VALUES  (DEFAULT, (SELECT id FROM activite WHERE date_debut = '2020-01-01 23:00:00'), (SELECT id FROM avatars WHERE nom = 'unNom*'), '2020-01-01 23:00:00', 18000, (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
			(DEFAULT, (SELECT id FROM activite WHERE date_debut = '2020-05-02 23:00:00'), (SELECT id FROM avatars WHERE nom = 'unNom*'), '2020-05-02 23:00:00', 3600, (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
			(DEFAULT, (SELECT id FROM activite WHERE date_debut = '2020-05-03 23:00:00'), (SELECT id FROM avatars WHERE nom = 'unNom*'), '2020-05-03 23:00:00',  3600, (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
			(DEFAULT, (SELECT id FROM activite WHERE date_debut = '2020-05-04 23:00:00'), (SELECT id FROM avatars WHERE nom = 'unNom*'), '2020-05-04 23:00:00',  3600, (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
			(DEFAULT, (SELECT id FROM activite WHERE date_debut = '2020-05-05 23:00:00'), (SELECT id FROM avatars WHERE nom = 'unNom*'), '2020-05-05 23:00:00',  3600, (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
			(DEFAULT, (SELECT id FROM activite WHERE date_debut = '2020-05-06 23:00:00'), (SELECT id FROM avatars WHERE nom = 'unNom*'), '2020-05-06 23:00:00',  3600, (SELECT id FROM jeu WHERE sigle = 'FRZONX')),
			(DEFAULT, (SELECT id FROM activite WHERE date_debut = '2020-05-07 23:00:00'), (SELECT id FROM avatars WHERE nom = 'unNom*'), '2020-05-07 23:00:00',  18000, (SELECT id FROM jeu WHERE sigle = 'FRZONX')),
			(DEFAULT, (SELECT id FROM activite WHERE date_debut = '2020-05-08 23:00:00'), (SELECT id FROM avatars WHERE nom = 'unNom*'), '2020-05-08 23:00:00',  15750, (SELECT id FROM jeu WHERE sigle = 'FRZONX')),
			(DEFAULT, (SELECT id FROM activite WHERE date_debut = '2020-05-09 23:00:00'), (SELECT id FROM avatars WHERE nom = 'unAutreNom'), '2020-05-09 23:00:00', 1730, (SELECT id FROM jeu WHERE sigle = 'FRZONX')),
			(DEFAULT, (SELECT id FROM activite WHERE date_debut = '2020-05-10 23:00:00'), (SELECT id FROM avatars WHERE nom = 'encoreUnNom'), '2020-05-10 23:00:00', 36000, (SELECT id FROM jeu WHERE sigle = 'FRZONX')),
            (DEFAULT, (SELECT id FROM activite WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Caroline') AND date_debut = '2020-09-14 14:29:11') , (SELECT id FROM avatars WHERE nom = 'Hexen'), '2020-09-14 14:29:11', 3600, (SELECT id FROM jeu WHERE sigle = 'SPACEX')),
	        (DEFAULT, (SELECT id FROM activite WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Caroline') AND date_debut = '2020-09-22 18:44:11'), (SELECT id FROM avatars WHERE nom = 'Hexen'), '2020-08-14 18:24:11', 500, (SELECT id FROM jeu WHERE sigle = 'SPACEX')),
            (DEFAULT, (SELECT id FROM activite WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Caroline') AND date_debut = '2020-10-01 20:12:22') , (SELECT id FROM avatars WHERE nom = 'Hexen'), '2020-10-01 20:12:22', 1800, (SELECT id FROM jeu WHERE sigle = 'SPACEX')),
            (DEFAULT, (SELECT id FROM activite WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Caroline') AND date_debut = '2020-10-01 20:12:22') , (SELECT id FROM avatars WHERE nom = 'Hexen'), '2020-10-01 20:12:22', 1800, (SELECT id FROM jeu WHERE sigle = 'SPACEX'));


INSERT INTO activite
    VALUES  (DEFAULT, (SELECT id FROM joueurs WHERE alias = 'Francois'), '2020-09-30 1:02:03', 250),
            (DEFAULT, (SELECT id FROM joueurs WHERE alias = 'Francois'), '2020-09-30 11:11:11', 500),
            (DEFAULT, (SELECT id FROM joueurs WHERE alias = 'Francois'), '2020-09-28 22:22:22', 9999);

INSERT INTO activite_avatar_jeu
    VALUES  (DEFAULT, (SELECT id FROM activite WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Francois') AND date_debut = '2020-09-30 1:02:03') , (SELECT id FROM avatars WHERE nom = 'Raggok'), DEFAULT, 222, (SELECT id FROM jeu WHERE nom = 'FreeZoneX')),
            (DEFAULT, (SELECT id FROM activite WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Francois') AND date_debut = '2020-09-30 11:11:11') , (SELECT id FROM avatars WHERE nom = 'Raggok'), DEFAULT, 222, (SELECT id FROM jeu WHERE nom = 'FreeZoneX')),
            (DEFAULT, (SELECT id FROM activite WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Francois') AND date_debut = '2020-09-28 22:22:22') , (SELECT id FROM avatars WHERE nom = 'Raggok'), DEFAULT, 222, (SELECT id FROM jeu WHERE nom = 'FreeZoneX'));


INSERT INTO activite
    VALUES  (DEFAULT, (SELECT id FROM joueurs WHERE alias = 'Dany'), '2020-08-14 12:22:11', 3600),
            (DEFAULT, (SELECT id FROM joueurs WHERE alias = 'Dany'), '2020-08-14 18:24:11', 500),
            (DEFAULT, (SELECT id FROM joueurs WHERE alias = 'Dany'), '2020-08-22 17:22:22', 3600);

INSERT INTO activite_avatar_jeu
    VALUES  (DEFAULT, (SELECT id FROM activite WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Dany') AND date_debut = '2020-08-14 12:22:11') , (SELECT id FROM avatars WHERE nom = 'Vizir'), '2020-08-14 12:22:11', 222, (SELECT id FROM jeu WHERE sigle = 'DEEPHX')),
            (DEFAULT, (SELECT id FROM activite WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Dany') AND date_debut = '2020-08-14 18:24:11'), (SELECT id FROM avatars WHERE nom = 'Vizir'), '2020-08-14 18:24:11', 500, (SELECT id FROM jeu WHERE nom = 'FreeZoneX')),
            (DEFAULT, (SELECT id FROM activite WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Dany') AND date_debut = '2020-08-22 17:22:22') , (SELECT id FROM avatars WHERE nom = 'Vizir'), '2020-08-22 17:22:22', 1800, (SELECT id FROM jeu WHERE nom = 'FreeZoneX')),
            (DEFAULT, (SELECT id FROM activite WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Dany') AND date_debut = '2020-08-22 17:22:22') , (SELECT id FROM avatars WHERE nom = 'Vizir'), '2020-08-22 17:52:22', 1800, (SELECT id FROM jeu WHERE sigle = 'DEEPHX'));



INSERT INTO avatar_item
    VALUES  (DEFAULT, (SELECT id FROM avatars WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Francois') and nom = 'Raggok'),
                (SELECT id FROM items WHERE sigle = 'IEFG'), DEFAULT, DEFAULT, (SELECT cout FROM items WHERE sigle = 'IEFG')),
            (DEFAULT, (SELECT id FROM avatars WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Vincent*') and nom = 'unNom*'),
                (SELECT id FROM items WHERE sigle = 'ICTA'), '2020-08-22', DEFAULT, (SELECT cout FROM items WHERE sigle = 'ICTA')),
            (DEFAULT, (SELECT id FROM avatars WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Vincent*') and nom = 'unNom*'),
                (SELECT id FROM items WHERE sigle = 'ISSC'), '2020-08-28', DEFAULT, (SELECT cout FROM items WHERE sigle = 'ISSC')),
            (DEFAULT, (SELECT id FROM avatars WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Caroline') and nom = 'Hexen'),
                (SELECT id FROM items WHERE sigle = 'ISAN'), DEFAULT, DEFAULT, (SELECT cout FROM items WHERE sigle = 'ISAN'));


INSERT INTO avatar_hab
    VALUES  (DEFAULT, (SELECT id FROM habilete WHERE sigle = 'SIW'), (SELECT id FROM avatars WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Francois') and nom = 'Raggok'), DEFAULT, 3),
            (DEFAULT, (SELECT id FROM habilete WHERE sigle = 'SIW'), (SELECT id FROM avatars WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Vincent*') and nom = 'unNom*'), '2020-08-22', 3),      
            (DEFAULT, (SELECT id FROM habilete WHERE sigle = 'SUB'), (SELECT id FROM avatars WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Vincent*') and nom = 'unNom*'), '2020-08-28', 3),      
            (DEFAULT, (SELECT id FROM habilete WHERE sigle = 'SGE'), (SELECT id FROM avatars WHERE joueur = (SELECT id FROM joueurs WHERE alias = 'Caroline') and nom = 'Hexen'), DEFAULT, 2);
