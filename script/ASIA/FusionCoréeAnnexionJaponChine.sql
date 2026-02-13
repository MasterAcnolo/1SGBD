USE WorldCopy;

START TRANSACTION;

-- La Corée du Nord et la Corée du Sud ont fusionné et ont uni leurs forces afin de conquérir la Chine et le Japon. Ce nouvel empire s'appelle désormais « La Grande Corée ».

-- Calcul des statistiques totales des pays conquis
SET @totalSurface := (
    SELECT SUM(SurfaceArea) 
    FROM Country 
    WHERE Code IN ('PRK', 'KOR', 'CHN', 'JPN')
);

SET @totalPop := (
    SELECT SUM(Population) 
    FROM Country 
    WHERE Code IN ('PRK', 'KOR', 'CHN', 'JPN')
);

SET @totalGNP := (
    SELECT SUM(GNP) 
    FROM Country 
    WHERE Code IN ('PRK', 'KOR', 'CHN', 'JPN')
);

SET @totalGNPOld := (
    SELECT SUM(GNPOld) 
    FROM Country 
    WHERE Code IN ('PRK', 'KOR', 'CHN', 'JPN')
);

SET @avgLifeExpectancy := (
    SELECT AVG(LifeExpectancy) 
    FROM Country 
    WHERE Code IN ('PRK', 'KOR', 'CHN', 'JPN')
);

SET @capitalSeoul := (
    SELECT ID 
    FROM City 
    WHERE Name = 'Seoul' 
    LIMIT 1
);

-- Création du nouveau pays : La Grande Corée
INSERT INTO Country 
(Code, Name, Continent, Region, Population, Capital, SurfaceArea, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, IndepYear)
SELECT 
    'GKR', 
    'Grande Corée', 
    'Asia', 
    'Eastern Asia', 
    @totalPop,
    @capitalSeoul,
    @totalSurface,
    @avgLifeExpectancy,
    @totalGNP,
    @totalGNPOld,
    'Daehan Guk', 
    'Empire',
    'Empereur Kim',
    2026
FROM Country
WHERE Code = 'KOR' 
LIMIT 1;

-- Transfert de toutes les villes des pays conquis vers la Grande Corée
UPDATE City
SET CountryCode = 'GKR'
WHERE CountryCode IN ('PRK', 'KOR', 'CHN', 'JPN');

-- Suppression des langues des pays conquis
DELETE FROM CountryLanguage
WHERE CountryCode IN ('PRK', 'KOR', 'CHN', 'JPN');

-- Ajout des langues officielles de la Grande Corée
INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage)
VALUES ('GKR', 'Korean', 'T', 25.0);

INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage)
VALUES ('GKR', 'Chinese', 'T', 65.0);

INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage)
VALUES ('GKR', 'Japanese', 'T', 10.0);

-- Suppression des pays conquis
DELETE FROM Country
WHERE Code IN ('PRK', 'KOR', 'CHN', 'JPN');

COMMIT;
