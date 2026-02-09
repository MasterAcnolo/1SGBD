-- La Corée du Nord et la Corée du Sud ont fusionné et ont uni leurs forces afin de conquérir la Chine et le Japon. Ce nouvel empire s’appelle désormais « La Grande Corée ».

USE NewWorld;

-- Etape 1 : Creer le nouveau pays Great Korea (GKR)
INSERT INTO Country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2)
SELECT 
    'GKR' AS Code,
    'Great Korea' AS Name,
    'Asia' AS Continent,
    'Eastern Asia' AS Region,
    SUM(SurfaceArea) AS SurfaceArea,
    2026 AS IndepYear,
    SUM(Population) AS Population,
    SUM(LifeExpectancy * Population) / SUM(Population) AS LifeExpectancy,
    SUM(GNP) AS GNP,
    NULL AS GNPOld,
    'Daehan Guk' AS LocalName,
    'Empire' AS GovernmentForm,
    'Emperor Kim' AS HeadOfState,
    (SELECT ID FROM City WHERE Name = 'Seoul' LIMIT 1) AS Capital,
    'GK' AS Code2
FROM Country
WHERE Code IN ('PRK', 'KOR', 'CHN', 'JPN');

-- Etape 2 : Transferer toutes les villes vers Great Korea
UPDATE City 
SET CountryCode = 'GKR' 
WHERE CountryCode IN ('PRK', 'KOR', 'CHN', 'JPN');

-- Etape 3 : Supprimer les langues des anciens pays
DELETE FROM CountryLanguage 
WHERE CountryCode IN ('PRK', 'KOR', 'CHN', 'JPN');

-- Etape 4 : Ajouter les langues pour Great Korea
INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage) VALUES
('GKR', 'Korean', 'T', 5.0),
('GKR', 'Chinese', 'T', 86.0),
('GKR', 'Japanese', 'T', 9.0);

-- Etape 5 : Supprimer les anciens pays
DELETE FROM Country 
WHERE Code IN ('PRK', 'KOR', 'CHN', 'JPN');

SELECT * FROM city WHERE CountryCode LIKE "GKR";