USE NewWorld;

START TRANSACTION;

-- La région Centre a déclaré son indépendance, s'est baptisée « République du Val de Loire » et a fait de Tours sa capitale.

-- Affichage de la France avant la sécession
SELECT * FROM Country WHERE Code = 'FRA';

-- Calcul de la population de la région Centre
SET @populationCentre := (
    SELECT SUM(Population)
    FROM City
    WHERE CountryCode = 'FRA'
      AND District = 'Centre'
);

-- Création du nouveau pays : République du Val de Loire
INSERT INTO Country 
(Code, Name, Continent, Region, Population, Capital, SurfaceArea, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, IndepYear)
SELECT 
    'VDL', 
    'République du Val de Loire', 
    'Europe', 
    'Western Europe', 
    @populationCentre,
    2999,  -- ID de Tours
    39151,  -- Surface de la région Centre
    LifeExpectancy, 
    GNP * 0.04,  -- Environ 4% du GNP français
    GNPOld * 0.04, 
    'République du Val de Loire', 
    'République',
    'Conseil du Val de Loire',
    2026
FROM Country
WHERE Code = 'FRA';

-- Mise à jour de la France : réduction de la population
UPDATE Country
SET Population = Population - @populationCentre,
    GNP = GNP * 0.96,
    GNPOld = GNPOld * 0.96
WHERE Code = 'FRA';

-- Transfert des villes vers la République du Val de Loire
UPDATE City
SET CountryCode = 'VDL'
WHERE CountryCode = 'FRA'
  AND District = 'Centre';

-- Ajout de la langue officielle du nouveau pays
INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage)
VALUES ('VDL', 'French', 'T', 100.0);

-- Vérification des résultats
SELECT * FROM Country WHERE Code = 'VDL';
SELECT * FROM Country WHERE Code = 'FRA';
SELECT COUNT(*) AS NbVillesVDL FROM City WHERE CountryCode = 'VDL';

COMMIT;
