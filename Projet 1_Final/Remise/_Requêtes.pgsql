--1 Donnez la liste des joueurs : alias, date d’inscription.
select alias as "Liste des joueurs", date_inscript as "Date d''inscription"
from joueurs;

--2 Donnez la liste des avatars d’un joueur quelconque 
-- (pour l’exemple, prendre le joueur principal) : nom, la couleur préférée (1), date de création suivant le format 2000 | 12 | 25.
select nom as "Liste des avatars de Vincent", couleur1 as "Couleur préféré"
from avatars
where joueur = (SELECT id FROM joueurs WHERE alias = 'Vincent*');


--3 Pour l’avatar principal, donnez toutes les habiletés qu’il possède : 
-- les noms, les dates d’obtention et les niveaux.
SELECT av.nom as "Avatar principal",
		hab.nom as "Habileté",
		ah.date_opt as "Date d''obtention",
		ah.niveau as "Niveau"
		FROM avatar_hab as ah 
		INNER JOIN avatars as av
			ON ah.avatar = av.id
		INNER JOIN habilete as hab
			ON ah.habilete = hab.id
		WHERE av.nom = 'unNom*';

--4 Pour l’avatar principal, donnez la valeur totale des tous les items qu’il possède.
SELECT (SELECT nom FROM avatars as av2 WHERE av2.nom = 'unNom*') as "Avatar principal",
		SUM(ai.valeur) as "Valeur en Mox"
		FROM avatars as av
		INNER JOIN avatar_item as ai
			ON av.id = ai.avatar
		WHERE ai.avatar = (SELECT id from joueurs where alias = 'Vincent*') and av.nom = 'unNom*';
			

--5 Pour le joueur principal, donnez le nombre total d’heure passées dans chaque jeu joué.
SELECT ROUND(((SUM(aaj.duree)/60)/60),2) as "Durée en heures",
		jeu.nom as "Jeu"
		FROM activite_avatar_jeu as aaj
		INNER JOIN jeu as jeu
			ON jeu.id = aaj.jeu
		WHERE aaj.avatar IN (SELECT id FROM avatars WHERE joueur = (SELECT id from joueurs where alias = 'Vincent*'))
		GROUP BY jeu.nom;
		

--6 Donnez la liste de chaque joueur et du montant total dépensé.

SELECT SUM(ach.montant) as "Montant total dépensé",
		jou.alias as "Joueur"
		FROM achat as ach
		INNER JOIN joueurs as jou
			ON ach.joueur = jou.id
		GROUP BY jou.alias;

--7 Donnez la liste de tous les avatars qui possède plus de 1 item : nom de l’avatar et du joueur.
SELECT av.nom as "Avatars",
    jou.alias as "Joueurs"
    FROM avatars as av
    INNER JOIN joueurs as jou
        on jou.id = av.joueur
    INNER JOIN avatar_item as ai
        ON av.id = ai.avatar
    GROUP BY jou.alias, av.nom
    HAVING COUNT(ai.avatar) >= 1;
	
--8 Vous devez réaliser 3 [2]1 requêtes pertinentes de votre cru impliquant au minimum 3, 4 et 5 [3 et 5]1 tables. 
--À même le script et avant ces requêtes, vous devez ajouter un commentaire expliquant précisément ce que fait la requête. Le pointage associé à chacune de ces requêtes est autant basé sur la pertinence que la qualité de la réalisation technique.


--8.A (3 TABLES)
-- joueur, avatar, leitmotiv avec leitmotiv le plus long
SELECT 	jou.alias AS "Joueur",
		av.nom AS "Avatar",
		lei.leitmotiv AS "Leitmotiv le plus long du moooooonnnde"
	FROM avatars as av
    INNER JOIN joueurs as jou
        on jou.id = av.joueur
	INNER JOIN leitmotiv as lei
		on lei.nomavatar = av.id
	WHERE LENGTH(lei.leitmotiv) = (SELECT MAX(LENGTH(leitmotiv))
							FROM leitmotiv);



--8.B (4 TABLES)
-- Joueur(s) et avatar(s), le nom de l'item le plus rare (probabilité) dans son inventaire, et de quel jeu est originaire l'item.
SELECT 	jou.alias AS "Joueur",
		av.nom AS "Avatar",
		it.nom AS "Item le plus rare",
		jeu.nom AS "Monde d'origine"
	FROM avatars AS av
    INNER JOIN joueurs AS jou
        on jou.id = av.joueur
	INNER JOIN avatar_item AS avit
		on avit.avatar = av.id
	INNER JOIN items AS it
		on it.id = avit.item
	INNER JOIN jeu AS jeu
		on jeu.id = it.jeu
	WHERE it.prob = (SELECT MIN(prob) FROM ITEMS);


--8.C (5 TABLES)
-- Nom du joueur principal, nom de l'avatar principal, dernier item obtenu, dernier jeu connecté, dernière habileté obtenue

SELECT DISTINCT 	jou.alias AS "Joueur",
		av.nom AS "Avatar",
		it.nom AS "Dernier item obtenu",
		jeu.nom AS "Dernier jeu connecté",
		hab.nom AS "Dernière habilité obtenue"
	FROM avatars AS av
    INNER JOIN joueurs AS jou
        on jou.id = av.joueur
	INNER JOIN avatar_item AS avit
		on avit.avatar = av.id
	INNER JOIN items AS it
		on it.id = avit.item
	INNER JOIN activite_avatar_jeu as aaj
		ON aaj.avatar = av.id
	INNER JOIN avatar_hab as ahab
		ON ahab.avatar = av.id
	INNER JOIN jeu AS jeu
		on jeu.id = aaj.jeu
	INNER JOIN habilete as hab
		ON hab.id = ahab.habilete
	WHERE 	av.nom = 'unNom*'
			AND jou.alias = 'Vincent*'
			AND avit.date_opt = (SELECT date_opt 
									FROM avatar_item 
									WHERE avatar = (SELECT id FROM avatars WHERE nom = 'unNom*') 
									ORDER BY date_opt DESC LIMIT 1)
			AND aaj.date_debut = (SELECT date_debut 
									FROM activite_avatar_jeu 
									WHERE avatar = (SELECT id FROM avatars WHERE nom = 'unNom*') 
									ORDER BY date_debut DESC LIMIT 1)
			AND ahab.date_opt = (SELECT date_opt 
									FROM avatar_hab 
									WHERE avatar = (SELECT id FROM avatars WHERE nom = 'unNom*') 
									ORDER BY date_opt DESC LIMIT 1);
