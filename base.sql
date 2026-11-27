-- =============================================================================
--  Base de données du projet Medecine (PostgreSQL)
--  Exécution :  psql -U postgres -f base.sql
-- =============================================================================

-- Création de la base (à commenter si elle existe déjà)
DROP DATABASE IF EXISTS medecine;
CREATE DATABASE medecine ENCODING 'UTF8';

\c medecine

-- -----------------------------------------------------------------------------
--  Table patient : informations personnelles
-- -----------------------------------------------------------------------------
CREATE TABLE patient (
    id             SERIAL        PRIMARY KEY,
    nom            VARCHAR(100)  NOT NULL,
    prenom         VARCHAR(100)  NOT NULL,
    date_naissance DATE          NOT NULL CHECK (date_naissance <= CURRENT_DATE),
    sexe           CHAR(1)       CHECK (sexe IN ('M', 'F')),
    telephone      VARCHAR(30),
    email          VARCHAR(150),
    adresse        VARCHAR(255),
    date_creation  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_patient_nom ON patient (LOWER(nom), LOWER(prenom));

-- -----------------------------------------------------------------------------
--  Données de test
-- -----------------------------------------------------------------------------
INSERT INTO patient (nom, prenom, date_naissance, sexe, telephone, email, adresse) VALUES
    ('Rakoto',       'Hery',     '1992-03-14', 'M', '0341234567', 'hery.rakoto@mail.mg', 'Lot II A 12, Antananarivo'),
    ('Rasoa',        'Voahangy', '1999-07-02', 'F', '0329876543', NULL,                  'Analakely, Antananarivo'),
    ('Randriamanga', 'Fidy',     '1965-11-20', 'M', NULL,         NULL,                  'Ambohidratrimo'),
    ('Rabe',         'Miora',    '2018-05-09', 'F', '0335551122', NULL,                  NULL);
