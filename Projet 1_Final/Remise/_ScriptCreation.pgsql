ALTER TABLE IF EXISTS habilete
    DROP CONSTRAINT IF EXISTS fk_hab_jeu;

ALTER TABLE IF EXISTS items
    DROP CONSTRAINT IF EXISTS fk_item_jeu;

ALTER TABLE IF EXISTS avatar_item
    DROP CONSTRAINT IF EXISTS fk_avit_ava;

ALTER TABLE IF EXISTS avatar_item
    DROP CONSTRAINT IF EXISTS fk_avit_item;

ALTER TABLE IF EXISTS avatar_hab
    DROP CONSTRAINT IF EXISTS fk_avhb_avatar;

ALTER TABLE IF EXISTS avatar_hab
    DROP CONSTRAINT IF EXISTS fk_avhb_hab;

ALTER TABLE IF EXISTS leitmotiv
    DROP CONSTRAINT IF EXISTS fk_leit_ava;

ALTER TABLE IF EXISTS avatars
    DROP CONSTRAINT IF EXISTS fk_avat_joueur;

ALTER TABLE IF EXISTS achat
    DROP CONSTRAINT IF EXISTS fk_achat_item;

ALTER TABLE IF EXISTS achat
    DROP CONSTRAINT IF EXISTS fk_achat_joueur;

ALTER TABLE IF EXISTS achat
    DROP CONSTRAINT IF EXISTS fk_achat_mode;

ALTER TABLE IF EXISTS activite_avatar_jeu
    DROP CONSTRAINT IF EXISTS fk_aaj_jeu;

ALTER TABLE IF EXISTS activite_avatar_jeu
    DROP CONSTRAINT IF EXISTS fk_aaj_avat;

ALTER TABLE IF EXISTS activite_avatar_jeu
    DROP CONSTRAINT IF EXISTS fk_aaj_acti;

ALTER TABLE IF EXISTS activite
	DROP CONSTRAINT IF EXISTS fk_act_joueur;

DROP TABLE IF EXISTS joueurs;
DROP TABLE IF EXISTS jeu;
DROP TABLE IF EXISTS habilete;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS avatar_item;
DROP TABLE IF EXISTS avatars;
DROP TABLE IF EXISTS avatar_hab;
DROP TABLE IF EXISTS leitmotiv;
DROP TABLE IF EXISTS achat;
DROP TABLE IF EXISTS mode_paiement;
DROP TABLE IF EXISTS activite;
DROP TABLE IF EXISTS activite_avatar_jeu;


CREATE TABLE joueurs (
  id	            SERIAL,
  alias           VARCHAR(32)     NOT NULL,
  courriel        VARCHAR         NOT NULL,
  mdp             VARCHAR(32)     NOT NULL,
  genre           VARCHAR(1)      NOT NULL,
  date_inscript   DATE            NOT NULL DEFAULT NOW(),
  date_naissance  DATE,

  CONSTRAINT pk_jou PRIMARY KEY (id),
  CONSTRAINT cc_jou_gen CHECK(genre ~* ('[hfx]')),
  CONSTRAINT un_jou_cr UNIQUE(courriel),
  CONSTRAINT cc_jou_di CHECK(date_inscript > '2020-01-01'),
  CONSTRAINT cc_jou_dn CHECK(date_naissance > '1900-01-01' AND NOW() >= date_naissance + INTERVAL'13 YEARS')

);

CREATE TABLE jeu (
  id            SERIAL          ,
  nom           VARCHAR(16)     NOT NULL,
  sigle         VARCHAR(6)      NOT NULL,
  description   VARCHAR(2048),

  CONSTRAINT pk_jeu PRIMARY KEY (id),

  CONSTRAINT un_jeu_nm UNIQUE(nom),
  CONSTRAINT un_jeu_sg UNIQUE(sigle),
  CONSTRAINT cc_jeu_sg CHECK(char_length(sigle) = 6)
);

CREATE TABLE habilete (
  id            SERIAL            ,
  nom           VARCHAR(32)       NOT NULL,
  sigle         VARCHAR(3)        NOT NULL,
  ener_acq      NUMERIC(5,2)      NOT NULL,
  ener_uti      NUMERIC(7,3)      NOT NULL,
  description   VARCHAR(512),
  jeu           INT               NOT NULL,

  CONSTRAINT pk_hbt PRIMARY KEY (id),
  CONSTRAINT un_hbt_nm UNIQUE(nom),
  CONSTRAINT un_hbt_sg UNIQUE(sigle),
  CONSTRAINT cc_hbt_sg CHECK(sigle ~~ ('S__') AND char_length(sigle) = 3),
  CONSTRAINT cc_hbt_nrga CHECK(ener_acq BETWEEN 25.00 AND 250.00),
  CONSTRAINT cc_hbt_nrgu CHECK(ener_uti > (-1000.000) AND ener_uti < 1000.000)
);

CREATE TABLE items (
  id            SERIAL,
  nom           VARCHAR(32)       NOT NULL,
  sigle         VARCHAR(4)        NOT NULL,
  prob          NUMERIC(10,9)     NOT NULL,
  cout          NUMERIC(12,2)     NOT NULL,
  description   VARCHAR(512),
  jeu           INT               NOT NULL,

  CONSTRAINT pk_ite               PRIMARY KEY(id),
  CONSTRAINT uc_ite_nom				    UNIQUE(nom),
  CONSTRAINT uc_ite_sigle			    UNIQUE(sigle),
  CONSTRAINT cc_ite_sigle         CHECK(SUBSTR(sigle,1,1) = 'I' AND char_length(sigle) = 4),
  CONSTRAINT cc_ite_prob			    CHECK(prob BETWEEN 0.000000000 AND 1.000000000),
  CONSTRAINT cc_ite_cout			    CHECK(cout BETWEEN 0.00 AND 1000000000)
);

CREATE TABLE avatar_item (
  id            SERIAL,
  avatar        INT               NOT NULL,
  item          INT               NOT NULL,
  date_opt      DATE              NOT NULL DEFAULT NOW(),
  qty           NUMERIC(3)        DEFAULT 1 NOT NULL,
  valeur        NUMERIC(10)       NOT NULL,

  CONSTRAINT pk_av_ite            PRIMARY KEY(id),
  CONSTRAINT cc_av_ite_qty				CHECK(qty BETWEEN 1 AND 100),
  CONSTRAINT cc_av_ite_valeur			CHECK(valeur BETWEEN 1 AND 1000000000)
);

CREATE TABLE avatars (
  id              SERIAL,
  nom             VARCHAR(32)   NOT NULL,
  joueur          INT           NOT NULL,
  couleur1        VARCHAR(32)   NOT NULL,
  couleur2        VARCHAR(32),
  couleur3        VARCHAR(32),
  date_creation   DATE          NOT NULL DEFAULT NOW(),
  nb_mox          BIGINT        DEFAULT 0 NOT NULL,

  CONSTRAINT pk_av              PRIMARY KEY(id),
  CONSTRAINT cc_av_nb_mox			  CHECK(nb_mox BETWEEN -1000000000 AND 1000000000)
);

CREATE TABLE avatar_hab (
  id          SERIAL,
  habilete    INTEGER           NOT NULL,
  avatar      INTEGER           NOT NULL,
  date_opt    DATE              NOT NULL DEFAULT NOW(),
  niveau      NUMERIC(3)        NOT NULL DEFAULT 0,

  CONSTRAINT pk_avHab PRIMARY KEY (id)
);

CREATE TABLE leitmotiv (
  id          SERIAL,
  nomavatar   INTEGER           NOT NULL,
  leitmotiv   VARCHAR(64),

  CONSTRAINT pf_lei PRIMARY KEY (id)
);

CREATE TABLE achat (
  id              SERIAL,
  date_paiement   DATE      	  NOT NULL DEFAULT NOW(),
  mode_paiement   INTEGER       NOT NULL,
  montant         NUMERIC(7,2)  NOT NULL,
  type_achat      NUMERIC(1)    NOT NULL,  -- 1 = temps  2 = mox
  date_debut      DATE,
  date_fin        DATE,
  joueur          INTEGER       NOT NULL,
  item            INTEGER,

  CONSTRAINT pk_ac PRIMARY KEY (id),
  CONSTRAINT cc_ac_nu CHECK ( montant BETWEEN 0.01 AND 10000.00 ),
  CONSTRAINT cc_ac_dtD CHECK ( date_debut < date_fin ),
  CONSTRAINT cc_ac_type CHECK ( type_achat BETWEEN 1 AND 2),
  CONSTRAINT cc_ach_item CHECK(
        (type_achat = 1 AND date_debut IS NOT NULL AND date_fin IS NOT NULL AND item IS NULL)
    OR (type_achat = 2 AND item IS NOT NULL AND date_debut IS NULL AND date_fin IS NULL))
);

CREATE TABLE mode_paiement (
  id    SERIAL,
  type  VARCHAR(32),

  CONSTRAINT pk_mo PRIMARY KEY (id)
);

CREATE TABLE activite (
  id            SERIAL,
  joueur        INTEGER				    NOT NULL,
  date_debut    TIMESTAMP     	  NOT NULL DEFAULT NOW(),
  duree         NUMERIC(8)        NOT NULL,

  CONSTRAINT pk_act PRIMARY KEY (id),
  CONSTRAINT cc_act_du CHECK (duree > 0)
);

CREATE TABLE activite_avatar_jeu (
  id            SERIAL,
  activite      INTEGER   		NOT NULL,
  avatar        INTEGER   		NOT NULL,
  date_debut    TIMESTAMP	    NOT NULL DEFAULT NOW(),
  duree         NUMERIC(8)    NOT NULL,
  jeu           INTEGER   		NOT NULL,

  CONSTRAINT pk_actAvJe     PRIMARY KEY (id),
  CONSTRAINT cc_actAvJe_dd  CHECK (duree > 0)
);

ALTER TABLE habilete ADD CONSTRAINT fk_hab_jeu FOREIGN KEY (jeu) REFERENCES jeu (id);

ALTER TABLE items ADD CONSTRAINT fk_item_jeu FOREIGN KEY (jeu) REFERENCES jeu (id);

ALTER TABLE avatar_item ADD CONSTRAINT fk_avit_ava FOREIGN KEY (avatar) REFERENCES avatars (id);

ALTER TABLE avatar_item ADD CONSTRAINT fk_avit_item FOREIGN KEY (item) REFERENCES items (id);

ALTER TABLE avatar_hab ADD CONSTRAINT fk_avhb_avatar FOREIGN KEY (avatar) REFERENCES avatars (id);

ALTER TABLE avatar_hab ADD CONSTRAINT fk_avhb_hab FOREIGN KEY (habilete) REFERENCES habilete (id);

ALTER TABLE leitmotiv ADD CONSTRAINT fk_leit_ava FOREIGN KEY (nomavatar) REFERENCES avatars (id);

ALTER TABLE avatars ADD CONSTRAINT fk_avat_joueur FOREIGN KEY (joueur) REFERENCES joueurs (id);

ALTER TABLE achat ADD CONSTRAINT fk_achat_item FOREIGN KEY (item) REFERENCES items (id);

ALTER TABLE achat ADD CONSTRAINT fk_achat_joueur FOREIGN KEY (joueur) REFERENCES joueurs (id);

ALTER TABLE achat ADD CONSTRAINT fk_achat_mode FOREIGN KEY (mode_paiement) REFERENCES mode_paiement (id);

ALTER TABLE activite_avatar_jeu ADD CONSTRAINT fk_aaj_jeu FOREIGN KEY (jeu) REFERENCES jeu (id);

ALTER TABLE activite_avatar_jeu ADD CONSTRAINT fk_aaj_avat FOREIGN KEY (avatar) REFERENCES avatars (id);

ALTER TABLE activite_avatar_jeu ADD CONSTRAINT fk_aaj_acti FOREIGN KEY (activite) REFERENCES activite (id);

ALTER TABLE activite ADD CONSTRAINT fk_act_joueur FOREIGN KEY (joueur) REFERENCES joueurs (id);
