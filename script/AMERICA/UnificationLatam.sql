USE NewWorld;

START TRANSACTION;

-- En réaction, tous les pays hispanophones au sud de la Colombie et du Brésil forment désormais un unique pays : les Nouveaux États-Unis d'Amérique.

-- Affichage des pays avant l'unification
SELECT * FROM Country WHERE Code IN ('ARG', 'BOL', 'CHL', 'ECU', 'PER', 'PRY', 'URY');

-- Calcul des statistiques totales des pays qui vont fusionner
SET @totalSurface := (
    SELECT SUM(SurfaceArea) 
    FROM Country 
    WHERE Code IN ('ARG', 'BOL', 'CHL', 'ECU', 'PER', 'PRY', 'URY')
);

SET @totalPop := (
    SELECT SUM(Population) 
    FROM Country 
    WHERE Code IN ('ARG', 'BOL', 'CHL', 'ECU', 'PER', 'PRY', 'URY')
);

SET @totalGNP := (
    SELECT SUM(GNP) 
    FROM Country 
    WHERE Code IN ('ARG', 'BOL', 'CHL', 'ECU', 'PER', 'PRY', 'URY')
);

SET @totalGNPOld := (
    SELECT SUM(GNPOld) 
    FROM Country 
    WHERE Code IN ('ARG', 'BOL', 'CHL', 'ECU', 'PER', 'PRY', 'URY')
);

SET @avgLifeExpectancy := (
    SELECT AVG(LifeExpectancy) 
    FROM Country 
    WHERE Code IN ('ARG', 'BOL', 'CHL', 'ECU', 'PER', 'PRY', 'URY')
);

-- Création du nouveau pays : Nouveaux États-Unis d'Amérique
INSERT INTO Country 
(Code, Name, Continent, Region, Population, Capital, SurfaceArea, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, IndepYear)
SELECT 
    'NEA', 
    'Nouveaux États-Unis d''Amérique', 
    'South America', 
    'South America', 
    @totalPop,
    69,  -- Buenos Aires (capitale temporaire)
    @totalSurface,
    @avgLifeExpectancy,
    @totalGNP,
    @totalGNPOld,
    'Nouveaux États-Unis d''Amérique', 
    'República Federal',
    'Shakira',
    2026
FROM Country
WHERE Code = 'ARG' 
LIMIT 1;

-- Transfert de toutes les villes des pays unifiés vers le nouveau pays
UPDATE City
SET CountryCode = 'NEA'
WHERE CountryCode IN ('ARG', 'BOL', 'CHL', 'ECU', 'PER', 'PRY', 'URY');

-- Suppression des langues des pays unifiés
DELETE FROM CountryLanguage
WHERE CountryCode IN ('ARG', 'BOL', 'CHL', 'ECU', 'PER', 'PRY', 'URY');

-- Ajout de la langue officielle du nouveau pays
INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage)
VALUES ('NEA', 'Spanish', 'T', 95.0);

-- Suppression des pays unifiés
DELETE FROM Country
WHERE Code IN ('ARG', 'BOL', 'CHL', 'ECU', 'PER', 'PRY', 'URY');

-- Vérification des résultats
SELECT * FROM Country WHERE Code = 'NEA';
SELECT * FROM City WHERE CountryCode = 'NEA';

COMMIT;