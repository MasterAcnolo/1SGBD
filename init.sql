-- base de destination
CREATE DATABASE IF NOT EXISTS WorldCopy;
USE WorldCopy;

-- reset tables
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
