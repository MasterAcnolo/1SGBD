-- Script pour la partie 2 ou il faut créer une base newWorld.

DROP DATABASE IF EXISTS NewWorld;
CREATE DATABASE NewWorld;
USE NewWorld;

-- Table Monnaie
CREATE TABLE Monnaie (
    Id_Monnaie INT AUTO_INCREMENT,
    Nom VARCHAR(50) NOT NULL,
    Symbole VARCHAR(5) NOT NULL,
    PRIMARY KEY (Id_Monnaie),
    UNIQUE KEY uk_nom_monnaie (Nom),
    UNIQUE KEY uk_symbole (Symbole)
) ENGINE=InnoDB;

-- Table Pays
CREATE TABLE Pays (
    id_pays INT AUTO_INCREMENT,
    Code CHAR(3) NOT NULL,
    Name CHAR(52) NOT NULL,
    Continent ENUM('Asia', 'Europe', 'North America', 'Africa', 'Oceania', 'Antarctica', 'South America') NOT NULL,
    Region CHAR(26) NOT NULL,
    SurfaceArea DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    IndependanceYear SMALLINT NULL,
    Population INT NOT NULL DEFAULT 0,
    LifeExpectancy DECIMAL(3,1) NULL,
    PIB DECIMAL(10,2) NULL,
    PIB_OLD DECIMAL(10,2) NULL,
    LocalName CHAR(45) NOT NULL,
    GovernmentForm CHAR(45) NOT NULL,
    HeadOfState CHAR(60) NULL,
    Capital INT NULL,
    Code2 CHAR(2) NOT NULL,
    Id_Monnaie INT NULL,
    PRIMARY KEY (id_pays),
    UNIQUE KEY uk_code (Code),
    UNIQUE KEY uk_code2 (Code2),
    KEY idx_continent (Continent),
    KEY idx_region (Region),
    KEY fk_pays_monnaie (Id_Monnaie),
    CONSTRAINT fk_pays_monnaie FOREIGN KEY (Id_Monnaie) REFERENCES Monnaie(Id_Monnaie) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Table Ville
CREATE TABLE Ville (
    id_ville INT AUTO_INCREMENT,
    Nom CHAR(35) NOT NULL,
    Code_de_Pays CHAR(3) NOT NULL,
    District CHAR(20) NOT NULL,
    Population INT NOT NULL DEFAULT 0,
    Surface DECIMAL(10,2) NULL,
    PIB DECIMAL(10,2) NULL,
    id_pays INT NOT NULL,
    PRIMARY KEY (id_ville),
    KEY idx_nom_ville (Nom),
    KEY idx_population (Population),
    KEY fk_ville_pays (id_pays),
    CONSTRAINT fk_ville_pays FOREIGN KEY (id_pays) REFERENCES Pays(id_pays) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

ALTER TABLE Pays 
    ADD CONSTRAINT fk_pays_capitale FOREIGN KEY (Capital) REFERENCES Ville(id_ville) ON DELETE SET NULL ON UPDATE CASCADE;

-- Table Armee
CREATE TABLE Armee (
    id_armee INT AUTO_INCREMENT,
    nombre_infanterie INT NOT NULL DEFAULT 0,
    nombre_chars INT NOT NULL DEFAULT 0,
    nombre_aviations INT NOT NULL DEFAULT 0,
    nombre_portes_avions INT NOT NULL DEFAULT 0,
    nombre_sous_marins INT NOT NULL DEFAULT 0,
    qualite_armee TINYINT UNSIGNED NOT NULL DEFAULT 0,
    haveNuclear BOOLEAN NOT NULL DEFAULT FALSE,
    id_pays INT NOT NULL,
    PRIMARY KEY (id_armee),
    UNIQUE KEY uk_armee_pays (id_pays),
    CONSTRAINT fk_armee_pays FOREIGN KEY (id_pays) REFERENCES Pays(id_pays) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_qualite CHECK (qualite_armee <= 255)
) ENGINE=InnoDB;

-- Table Langue
CREATE TABLE Langue (
    id_langue INT AUTO_INCREMENT,
    Code_de_Pays CHAR(3) NOT NULL,
    Langue CHAR(30) NOT NULL,
    EstOfficiel BOOLEAN NOT NULL DEFAULT FALSE,
    Pourcentage DECIMAL(4,1) NOT NULL DEFAULT 0.0,
    id_pays INT NOT NULL,
    PRIMARY KEY (id_langue),
    KEY idx_langue_pays (id_pays, Langue),
    CONSTRAINT fk_langue_pays FOREIGN KEY (id_pays) REFERENCES Pays(id_pays) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_pourcentage CHECK (Pourcentage >= 0 AND Pourcentage <= 100)
) ENGINE=InnoDB;

-- Table Guerre
CREATE TABLE Guerre (
    id_pays INT NOT NULL,
    id_pays_1 INT NOT NULL,
    date_debut DATE NULL,
    date_fin DATE NULL,
    statut ENUM('en_cours', 'terminee', 'cessez_le_feu') DEFAULT 'en_cours',
    PRIMARY KEY (id_pays, id_pays_1),
    KEY fk_guerre_pays2 (id_pays_1),
    CONSTRAINT fk_guerre_pays1 FOREIGN KEY (id_pays) REFERENCES Pays(id_pays) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_guerre_pays2 FOREIGN KEY (id_pays_1) REFERENCES Pays(id_pays) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;