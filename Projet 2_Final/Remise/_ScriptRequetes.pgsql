
--Requête 1
-- Donner la liste des employés : nom, prénom, poste, nom du département, ancienneté (en année), leur salaire annuel (considérant qu’ils travaillent
-- 35 heures par semaine et 52 semaines par année) et leur salaire annuel augmenté de 15%.
SELECT 	emp.nom as "Nom employé",
		emp.prenom as "Prénom employé",
		pos.nom as "Poste",
		dep.nom as "Département",
		DATE_PART('year', AGE(NOW(), emp.date_embauche)) AS "Ancienneté en année",
		round(emp.salaire*1820,2) as "Salaire annuel",
		round((emp.salaire*1820)*1.15,2) as "Salaire majoré à 15%"
FROM
		employe as emp
JOIN departement as dep
	ON dep.id = emp.departement
JOIN poste as pos
	ON pos.id = emp.poste;


-- =======================================================

-- =======================================================
--Requête 2
-- Donner le nombre d’inspections que chaque employé a fait (qu’il ait participé au inspection par la conduite du véhicule ou par l’opération du profilomètre).


-- View à rajouter dans script création


SELECT 	emp.nom as "Employe prénom",
	   	emp.prenom as "Nom employé",
		COALESCE(nbr_ins_conduct.nbr,0)+COALESCE(nbr_ins_oplas.nbr,0) as "Nombre d'inspection"

FROM employe as emp
FULL OUTER JOIN nbr_ins_conduct
	ON nbr_ins_conduct.id = emp.id
FULL OUTER JOIN nbr_ins_oplas
	ON nbr_ins_oplas.id = emp.id
WHERE nbr_ins_conduct.nbr > 0 OR  nbr_ins_oplas.nbr > 0;

-- =======================================================

-- =======================================================

--Requête 3
-- Pour chaque véhicule, combien de kilomètres d’inspection ont été parcourus pour les inspections.
SELECT DISTINCT
	marmod.marque as "Marque",
	marmod.modele as "Modèle",
	veh.immatr as "Immatriculation",
	veh.couleur as "Couleur",
	nbr_ins_km.nbrK as "Nombre kilomètres"
FROM inspection as ins
INNER JOIN vehicule as veh
	ON veh.id = ins.vehiUti
INNER JOIN veh_marq_mod as marmod
	ON marmod.id = veh.veh_marq_mod
INNER JOIN nbr_ins_km
	ON nbr_ins_km.id = ins.vehiUti;

-- =======================================================

-- =======================================================

--Requête 4
-- Pour chaque profileur laser, donner le nombre d’heures totales utilisées pour des inspections.

SELECT DISTINCT
	marmod.marque as "Marque",
	marmod.modele as "Modèle",
	las.numSerie as "Numéro de série",
	EXTRACT(hour FROM nbr_ins_hrs.heures) as "Nombre d'heures"
FROM inspection as ins
INNER JOIN laser as las
	ON las.id = ins.laserUti
INNER JOIN las_marq_mod as marmod
	ON marmod.id = las.las_marq_mod
INNER JOIN nbr_ins_hrs
	ON nbr_ins_hrs.id = ins.id;


-- =======================================================

-- =======================================================

--Requête 5
-- Pour une inspection donnée, combien de kilomètres ont été parcourus.


SELECT
	id as "Numéro d'inspection",
	kiloFin - kilodebut as "Kilomètre parcouru"
FROM inspection;

-- Merci pour celle-ci :)

-- =======================================================

-- =======================================================
--Requête 6
-- Pour chacune des inspections, on désire savoir quels ont été les frais associés (vous devez tenir compte du temps passé pour
-- les deux employés lors de l’inspection, des coûts d’exploitation du véhicule à 1.55$ par kilomètre).

SELECT
	ins.id as "Numéro d'inspection",
	ROUND(CAST((EXTRACT(hour FROM nbr_ins_hrs.heures))*chauffeur.salaire as numeric),2) as "Salaire chauffeur",
	ROUND(CAST((EXTRACT(hour FROM nbr_ins_hrs.heures))*operateur.salaire as numeric),2) as "Salaire opérateur laser",
	ROUND((ins.kiloFin - ins.kilodebut) * 1.55,2) as "Coûts d'exploitation du véhicule",

	ROUND(CAST((EXTRACT(hour FROM nbr_ins_hrs.heures))*chauffeur.salaire as numeric),2)+
	ROUND(CAST((EXTRACT(hour FROM nbr_ins_hrs.heures))*operateur.salaire as numeric),2)+
	ROUND((ins.kiloFin - ins.kilodebut) * 1.55,2) as "Total"
FROM inspection as ins
JOIN employe as chauffeur
	ON ins.conducteur = chauffeur.id
JOIN employe as operateur
	ON ins.opLaser = operateur.id
JOIN nbr_ins_hrs
	ON nbr_ins_hrs.id = ins.id;

--- ****************************************

-- =======================================================
-- Requête # 1
-- Objectif :
-- Parmi toutes les inspections, calculer le nombre d'intersection inspectées classés par type de pavage (2 vues, inspect_tronc, intersection, troncon)

-- Évaluation :
-- Le requête utile deux vues utilisant trois tables chacunes. Nous considérons que les vues font parties des 4 tables requises.
--
-- Réalisé par : Équipe
-- =======================================================
SELECT
		inter1.pavage as "Type de pavage d'intersection",
		inter1.nb + inter2.nb as "Nombre d'inspections"
FROM nb_ins_inter2 as inter2
CROSS JOIN nb_ins_inter1 as inter1
WHERE inter1.pavage = inter2.pavage;

-- =======================================================

-- =======================================================
-- Requête # 2
-- Objectif : Quel département possède le plus d'employés ayant participé à des inspections (departement, employé, inspection, inspect_tronc )

-- Évaluation : La requête répond à l'objectif.

-- Réalisé par : Équipe

-- =======================================================
SELECT
	dep.nom AS "Départements",
	cntD.nbr AS "Nombre employés reliés aux inspections"

FROM departement AS dep
JOIN cnt_dep_ins AS cntD
	ON cntD.id = dep.id
WHERE cntD.nbr >= ALL(
	SELECT
	COUNT(dep.nom) AS nbr
	FROM departement AS dep
	JOIN employe as emp
	ON emp.departement = dep.id
	JOIN inspection as ins
	on ((ins.conducteur = emp.id) OR (ins.opLaser = emp.id))
	GROUP BY dep.id
)
order by cntD.nbr DESC

-- =======================================================

-- =======================================================
-- Requête # 3
-- Objectif : Parmi troncon inspecte, le nombre de voies non-inspecté (inspection, inspection_troncon, troncon, rue)

-- Évaluation : La requête répond à l'objectif.

-- Réalisé par : Équipe

-- =======================================================
--votre requête
SELECT DISTINCT
		inst.troncon as "Id Troncon",
		rue.nom as "Nom rue",
		tronc.direction as "Direction",
		tronc.nombreVoies - siv.sumVoiesIns AS "Nombre de voies non-inspectées",
		tronc.intersection1 as "Identifiant Intersection 1",
		tronc.intersection2 as "Identifiant Intersection 2"
FROM inspect_tronc as inst
JOIN troncon as tronc
  on tronc.id = inst.troncon
JOIN sum_inst_voi as siv
  on siv.idTroncon = tronc.id
JOIN rue AS rue
	on rue.id = tronc.rue;
-- =======================================================

-- =======================================================
-- Requête # 4
-- Objectif : En se basant sur le temps moyen parcouru par les inspections,
-- donner pour chaque tronçon le temps moyen estimé pour les futures inspections.

-- Évaluation :
-- Bien que les chiffres données ne sont pas réalistes. L'utilisation des deux views
-- Réalisé par : Équipe

-- =======================================================
SELECT
	rue.nom as "Nom rue",
	tron.direction as "Direction",
	ROUND(tron.longueur::decimal / (SELECT moyMetH FROM avg_insp_temps),2) as "Nombre d'heures estimé pour l'inspection",
	tron.intersection1 as "Identifiant Intersection 1",
	tron.intersection2 as "Identifiant Intersection 2"

FROM troncon as tron
INNER JOIN rue as rue
	ON rue.id = tron.rue;
-- =======================================================
