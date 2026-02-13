USE NewWorld;

START TRANSACTION;

-- En France, la Bretagne a colonisé la Normandie et forme désormais un nouvel état souverain, dont la langue officielle est le breton et dont la capitale est Rennes.

-- Calcul de la population des régions qui font sécession
SET @populationBretagne := (
    SELECT SUM(Population)
    FROM City
    WHERE CountryCode = 'FRA'
      AND District IN ('Bretagne', 'Haute-Normandie', 'Basse-Normandie')
);

-- Création du nouveau pays : Bretagne
INSERT INTO Country 
(Code, Name, Continent, Region, Population, Capital, SurfaceArea, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, IndepYear)
SELECT 
    'BRZ', 
    'Bretagne', 
    'Europe', 
    'Western Europe', 
    @populationBretagne,
    2983,  -- ID de Rennes
    62000,  -- Surface de la Bretagne + Normandie (estimation)
    LifeExpectancy, 
    GNP * 0.10,  -- Environ 10% du GNP français
    GNPOld * 0.10, 
    'Breizh', 
    'République de Bretagne',
    'Conseil Breton de Libération',
    2026
FROM Country
WHERE Code = 'FRA';

-- Mise à jour de la France : réduction de la population
UPDATE Country
SET Population = Population - @populationBretagne,
    GNP = GNP * 0.90,
    GNPOld = GNPOld * 0.90
WHERE Code = 'FRA';

-- Transfert des villes vers la Bretagne
UPDATE City
SET CountryCode = 'BRZ'
WHERE CountryCode = 'FRA'
  AND District IN ('Bretagne', 'Haute-Normandie', 'Basse-Normandie');

-- Ajout de la langue officielle du nouveau pays
INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage)
VALUES ('BRZ', 'Breton', 'T', 85.0);

INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage)
VALUES ('BRZ', 'French', 'F', 15.0);

COMMIT; 