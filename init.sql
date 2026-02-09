-- base de destination
CREATE DATABASE IF NOT EXISTS NewWorld;
USE NewWorld;

-- reset tables
DROP TABLE IF EXISTS ARMEE;
DROP TABLE IF EXISTS GUERRE;
DROP TABLE IF EXISTS CountryLanguage;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Country;

-- copie des tables world
CREATE TABLE Country LIKE world.Country;
INSERT INTO Country SELECT * FROM world.Country;

CREATE TABLE City LIKE world.City;
INSERT INTO City SELECT * FROM world.City;

CREATE TABLE CountryLanguage LIKE world.CountryLanguage;
INSERT INTO CountryLanguage SELECT * FROM world.CountryLanguage;

-- tables du jeu
CREATE TABLE GUERRE(
    id INT NOT NULL AUTO_INCREMENT,
    code_pays_attaquant CHAR(3) NOT NULL,
    code_pays_defenseur CHAR(3) NOT NULL,
    estActive BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id)
);

CREATE TABLE ARMEE(
    id INT NOT NULL AUTO_INCREMENT,
    code_pays CHAR(3) NOT NULL,
    nombre_soldats INT DEFAULT 0,
    nombre_chars INT DEFAULT 0,
    nombre_avions INT DEFAULT 0,
    PRIMARY KEY (id)
);

-- FK
ALTER TABLE GUERRE
ADD CONSTRAINT fk_guerre_attaquant FOREIGN KEY (code_pays_attaquant) REFERENCES Country(Code),
ADD CONSTRAINT fk_guerre_defenseur FOREIGN KEY (code_pays_defenseur) REFERENCES Country(Code);

ALTER TABLE ARMEE
ADD CONSTRAINT fk_armee_code_pays FOREIGN KEY (code_pays) REFERENCES Country(Code);
