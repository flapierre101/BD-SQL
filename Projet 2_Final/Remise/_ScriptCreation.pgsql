DROP INDEX IF EXISTS idx_rue_nom;
DROP VIEW IF EXISTS nbr_ins_oplas CASCADE;
DROP VIEW IF EXISTS nbr_ins_conduct CASCADE;
DROP VIEW IF EXISTS nbr_ins_km CASCADE;
DROP VIEW IF EXISTS nbr_ins_hrs CASCADE;
DROP VIEW IF EXISTS sum_inst_met CASCADE;
DROP VIEW IF EXISTS avg_insp_temps CASCADE;
DROP VIEW IF EXISTS sum_inst_voi CASCADE;
DROP VIEW IF EXISTS nb_ins_inter1 CASCADE;
DROP VIEW IF EXISTS nb_ins_inter2 CASCADE;
DROP VIEW IF EXISTS cnt_dep_ins CASCADE;

ALTER TABLE IF EXISTS employe
    DROP CONSTRAINT IF EXISTS fk_emp_pos;
ALTER TABLE IF EXISTS employe
    DROP CONSTRAINT IF EXISTS fk_emp_dep;
ALTER TABLE IF EXISTS troncon
    DROP CONSTRAINT IF EXISTS fk_tro_int1;
ALTER TABLE IF EXISTS troncon
    DROP CONSTRAINT IF EXISTS fk_tro_int2;
ALTER TABLE IF EXISTS troncon
    DROP CONSTRAINT IF EXISTS fk_tro_rue;
ALTER TABLE IF EXISTS laser
    DROP CONSTRAINT IF EXISTS fk_las_lmm;
ALTER TABLE IF EXISTS vehicule
    DROP CONSTRAINT IF EXISTS fk_veh_vmm;
ALTER TABLE IF EXISTS intersection
	DROP CONSTRAINT IF EXISTS fk_int_rueNS;
ALTER TABLE IF EXISTS intersection
	DROP CONSTRAINT IF EXISTS fk_int_rueEO;
ALTER TABLE IF EXISTS inspection
    DROP CONSTRAINT IF EXISTS fk_ins_vut;
ALTER TABLE IF EXISTS inspection
    DROP CONSTRAINT IF EXISTS fk_ins_con;
ALTER TABLE IF EXISTS inspection
    DROP CONSTRAINT IF EXISTS fk_ins_lau;
ALTER TABLE IF EXISTS inspection
    DROP CONSTRAINT IF EXISTS fk_ins_opl;
ALTER TABLE IF EXISTS inspect_tronc
    DROP CONSTRAINT IF EXISTS fk_it_ins;
ALTER TABLE IF EXISTS inspect_tronc
    DROP CONSTRAINT IF EXISTS fk_it_tro;

DROP TABLE IF EXISTS employe;
DROP TABLE IF EXISTS poste;

DROP TABLE IF EXISTS inspect_tronc;
DROP TABLE IF EXISTS inspection;
DROP TABLE IF EXISTS troncon;
DROP TABLE IF EXISTS intersection;
DROP TABLE IF EXISTS laser;
DROP TABLE IF EXISTS las_marq_mod;
DROP TABLE IF EXISTS vehicule;
DROP TABLE IF EXISTS veh_marq_mod;
DROP TABLE IF EXISTS rue;
DROP TABLE IF EXISTS departement;
DROP TYPE IF EXISTS genre;
DROP TYPE IF EXISTS pavage;
DROP TYPE IF EXISTS sens;
DROP SEQUENCE IF EXISTS seq_intersection_id;


CREATE TYPE genre AS ENUM ('F', 'H', 'X');
CREATE TYPE pavage AS ENUM ('Asphalte', 'Ciment', 'Pavé brique', 'Pavé pierre');
CREATE TYPE sens AS ENUM ('Nord', 'Sud', 'Est', 'Ouest');

CREATE SEQUENCE seq_intersection_id
  INCREMENT BY 1 START WITH 10000 NO CYCLE;

CREATE TABLE employe (
  id            SERIAL        ,
  nom           varchar(32)   NOT NULL,
  prenom        varchar(32)   NOT NULL,
  genre         genre         NOT NULL,
  nas           varchar(9)    NOT NULL,
  date_embauche date          NOT NULL,
  salaire       NUMERIC(5,2)  NOT NULL DEFAULT 27.50,
  poste         int           NOT NULL,
  departement   int           NOT NULL,

  CONSTRAINT    pk_emp        PRIMARY KEY(id),
  CONSTRAINT    un_emp_nas    UNIQUE(nas),
  CONSTRAINT    cc_emp_de     CHECK(date_embauche > '2018-01-01'),
  CONSTRAINT    cc_emp_sal    CHECK(salaire BETWEEN 15.00 AND 250.00)
);

CREATE TABLE poste (
  id            SERIAL        ,
  nom           varchar(32)   NOT NULL,

  CONSTRAINT    pk_pst        PRIMARY KEY(id),
  CONSTRAINT    un_pst_nom    UNIQUE(nom)
);

CREATE TABLE departement (
  id            SERIAL        ,
  nom           varchar(32)   NOT NULL,

  CONSTRAINT    pk_dpt        PRIMARY KEY(id),
  CONSTRAINT    un_dpt_nom    UNIQUE(nom)
);

CREATE TABLE troncon (
  id            SERIAL      ,
  rue           int           NOT NULL,
  longueur      NUMERIC(7,1)  NOT NULL,
  limiteVitesse NUMERIC(3)    NOT NULL,
  nombreVoies   NUMERIC(1)    NOT NULL DEFAULT 1,
  typePav       pavage        NOT NULL,
  direction     sens		  NOT NULL,
  intersection1 int			  NOT NULL,
  intersection2 int		      NOT NULL,

  CONSTRAINT    pk_tron       PRIMARY KEY (id),
  CONSTRAINT    cc_tron_long  CHECK(longueur BETWEEN 0.0 AND 100000.0),
  CONSTRAINT    cc_tron_limv  CHECK(limiteVitesse BETWEEN 25 AND 120)

);

CREATE TABLE rue (
  id            SERIAL      ,
  nom           varchar(32)   NOT NULL,
  CONSTRAINT    pk_rue        PRIMARY KEY (id)
);

CREATE TABLE intersection (
  id            NUMERIC(5)    ,
  latitude      NUMERIC(8,6)  NOT NULL,
  longitude     NUMERIC(9,6)  NOT NULL,
  typePav       pavage        NOT NULL,
  rueEO			INTEGER		  NOT NULL,
  rueNS			INTEGER       NOT NULL,

  CONSTRAINT    pk_int        PRIMARY KEY (id),
  CONSTRAINT    cc_int_lat    CHECK(latitude BETWEEN -90.000000 AND 90.000000),
  CONSTRAINT    cc_int_long   CHECK(longitude BETWEEN -180.000000 AND 180.000000)
);

CREATE TABLE laser (
  id            SERIAL ,
  las_marq_mod  int           NOT NULL,
  numSerie      varchar(16)   NOT NULL,

   CONSTRAINT   pk_las        PRIMARY KEY (id),
   CONSTRAINT   cc_las_num    CHECK(char_length(numSerie) = 16)
);

CREATE TABLE las_marq_mod (
  id            SERIAL ,
  marque        varchar(32)   NOT NULL,
  modele        varchar(32)   NOT NULL,

  CONSTRAINT    pk_lmm        PRIMARY KEY (id)
);

CREATE TABLE vehicule (
  id            SERIAL ,
  veh_marq_mod  int           NOT NULL,
  immatr        varchar(6)    NOT NULL,
  couleur       varchar(10),
  dernierEntr   DATE,

  CONSTRAINT    pk_veh        PRIMARY KEY (id),
  CONSTRAINT    cc_veh_imm    CHECK(char_length(immatr) = 6)

);

CREATE TABLE veh_marq_mod (
  id            SERIAL,
  marque        VARCHAR(32)   NOT NULL,
  modele        VARCHAR(32)   NOT NULL,

  CONSTRAINT    pk_vmm        PRIMARY KEY (id)
);

CREATE TABLE inspection (
  id            SERIAL,
  dateDebut     TIMESTAMP     NOT NULL,
  dateFin       TIMESTAMP     NOT NULL,
  vehiUti       INTEGER       NOT NULL,
  conducteur    INTEGER       NOT NULL,
  kiloDebut     INTEGER       NOT NULL,
  kiloFin       INTEGER       NOT NULL,
  laserUti      INTEGER       NOT NULL,
  opLaser       INTEGER       NOT NULL,
  filePath      VARCHAR(512)  NOT NULL,
  fileName      VARCHAR(18)   NOT NULL,

  CONSTRAINT    pk_ins        PRIMARY KEY (id),
  CONSTRAINT    cc_ins_fna    CHECK(fileName ~* ('^PZW_[a-zA-Z0-9]{3}\d{3}-\d{2}.xdat$'))
);

CREATE TABLE inspect_tronc (
  id            SERIAL,
  inspect       INTEGER		NOT NULL,
  troncon       INTEGER		NOT NULL,
  voie          VARCHAR(1)	NOT NULL,

  CONSTRAINT    pk_inTr       PRIMARY KEY (id)
);

ALTER TABLE employe ADD CONSTRAINT fk_emp_pos FOREIGN KEY (poste) REFERENCES poste (id);

ALTER TABLE employe ADD CONSTRAINT fk_emp_dep FOREIGN KEY (departement) REFERENCES departement (id);

ALTER TABLE troncon ADD CONSTRAINT fk_tro_int1 FOREIGN KEY (intersection1) REFERENCES intersection (id);

ALTER TABLE troncon ADD CONSTRAINT fk_tro_int2 FOREIGN KEY (intersection2) REFERENCES intersection (id);

ALTER TABLE troncon ADD CONSTRAINT fk_tro_rue FOREIGN KEY (rue) REFERENCES rue (id);

ALTER TABLE intersection ADD CONSTRAINT fk_int_rueNS FOREIGN KEY (rueNS) REFERENCES rue (id);

ALTER TABLE intersection ADD CONSTRAINT fk_int_rueEO FOREIGN KEY (rueEO) REFERENCES rue (id);

ALTER TABLE laser ADD CONSTRAINT fk_las_lmm FOREIGN KEY (las_marq_mod) REFERENCES las_marq_mod (id);

ALTER TABLE vehicule ADD CONSTRAINT fk_veh_vmm FOREIGN KEY (veh_marq_mod) REFERENCES veh_marq_mod (id);

ALTER TABLE inspection ADD CONSTRAINT fk_ins_vut FOREIGN KEY (vehiUti) REFERENCES vehicule (id);

ALTER TABLE inspection ADD CONSTRAINT fk_ins_con FOREIGN KEY (conducteur) REFERENCES employe (id);

ALTER TABLE inspection ADD CONSTRAINT fk_ins_lau FOREIGN KEY (laserUti) REFERENCES laser (id);

ALTER TABLE inspection ADD CONSTRAINT fk_ins_opl FOREIGN KEY (opLaser) REFERENCES employe (id);

ALTER TABLE inspect_tronc ADD CONSTRAINT fk_it_ins FOREIGN KEY (inspect) REFERENCES inspection (id);

ALTER TABLE inspect_tronc ADD CONSTRAINT fk_it_tro FOREIGN KEY (troncon) REFERENCES troncon (id);

CREATE INDEX idx_rue_nom
	ON rue (UPPER(nom));

CREATE VIEW nbr_ins_conduct AS
SELECT conducteur AS id, COUNT(*) AS nbr
FROM inspection
GROUP BY conducteur;

CREATE VIEW nbr_ins_oplas AS
SELECT opLaser AS id, COUNT(*) AS nbr
FROM inspection
GROUP BY opLaser;

CREATE VIEW nbr_ins_km AS
SELECT 	ins.vehiUti as id,
		SUM(ins.kiloFin - ins.kiloDebut) as nbrK
FROM inspection as ins
GROUP BY ins.vehiUti;

CREATE VIEW nbr_ins_hrs AS
SELECT 	ins.id as id,
		SUM(ins.datefin - ins.datedebut) as heures
FROM inspection as ins
GROUP BY ins.id;

CREATE VIEW sum_inst_met AS
SELECT  inst.inspect as inspection,
        SUM(tronc.longueur)	as sumMetreIns
FROM inspect_tronc as inst
JOIN troncon as tronc
  on tronc.id = inst.troncon
GROUP BY inst.inspect;

CREATE VIEW avg_insp_temps AS
SELECT
	ROUND(AVG(sum_inst_met.sumMetreIns / CAST(EXTRACT(hour FROM hrs.heures)as numeric)),2) as moyMetH
FROM nbr_ins_hrs as hrs
JOIN sum_inst_met
ON sum_inst_met.inspection = hrs.id;

CREATE VIEW sum_inst_voi AS
SELECT  inst.troncon as idTroncon,
        COUNT(inst.troncon)    as sumVoiesIns
FROM inspect_tronc as inst
JOIN troncon as tronc
  on tronc.id = inst.troncon
GROUP BY inst.troncon;

CREATE VIEW nb_ins_inter1 AS
SELECT DISTINCT
	inter2.typepav as pavage,
	count(inter2.typepav) as nb
from troncon as tron
JOIN intersection as inter2
	ON inter2.id = tron.intersection2
JOIN inspect_tronc
	ON inspect_tronc.troncon = tron.id
GROUP BY inter2.typepav;


CREATE VIEW nb_ins_inter2 AS
SELECT DISTINCT
	inter1.typepav as pavage,
	count(inter1.typepav) as nb
from troncon as tron
JOIN intersection as inter1
	ON inter1.id = tron.intersection1
JOIN inspect_tronc
	ON inspect_tronc.troncon = tron.id
GROUP BY inter1.typepav;

CREATE VIEW cnt_dep_ins AS
SELECT
	dep.id AS Id,
	COUNT(dep.nom) AS nbr
FROM departement AS dep
JOIN employe as emp
	ON emp.departement = dep.id
JOIN inspection as ins
	ON ((ins.conducteur = emp.id) OR (ins.opLaser = emp.id))
GROUP BY dep.id ;