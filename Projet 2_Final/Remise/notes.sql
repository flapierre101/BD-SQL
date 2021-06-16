index:
- nom de rue
- troncons
- table inspection

SELECT nom, prenom, salaire, genre
FROM employe WHERE UPPER(ville) IN ( 'MONTRÉAL', 'LONGUEUIL' );

CREATE INDEX idx_emp_ville
ON employe( (UPPER(ville)) ASC NULLS LAST);

*faire un drop if exist

insertions a faire:

- 6 employes
- tous les departements et postes
- 1 inspection pour 2 employes
- 1 troncon par inspection
- 1 troncon implique deux intercections
- 1 inspection implique 1 voiture et 1 laser

- creation troncons non impliques par inspection


ORDRE:

- departement
- rue
- poste
- employe
- las_marq_mod
- laser
- veh_marq_mod
- vehicule
- intercection
- troncon
- inspection
- inspect_tronc


View:

 *faire un drop if exist
 
 
CREATE VIEW nbr_emp_ins AS
SELECT departement AS id, COUNT(*) AS nbr
FROM employe
GROUP BY departement;
-- donne le nom des départements et du nombre d’employé y travaillant
SELECT inspection, nbr_emp_dep.nbr
FROM departement
INNER JOIN nbr_emp_dep
ON nbr_emp_dep.id = departement.id;


 - reseau routier pour inspection, 
 - pour nom, prenom, poste
 
 
 REQUETES 7
 
 
 - inventaire (vehicule, km, nb inspection
 
 - tous les vehicules ayant ete utilises
 
 - quel troncon pas inspecte (inspection, inspection_troncon, troncon, rue)
 
 - parmis troncon inspecte, quelles voies reste a inspecter (inspection, inspection_troncon, troncon, rue)
 
 
 
 