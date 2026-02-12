USE NewWorld;

-- Scénario: Fusion des 2 Corées et conquête Chine + Japon (Great Korea)

-- Création de Great Korea (fusion PRK, KOR, CHN, JPN)
INSERT INTO Country (
    Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, 
    LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, 
    Capital, Code2
)
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
    NULL,
    'Daehan Guk' AS LocalName,
    'Empire' AS GovernmentForm,
    'Emperor Kim' AS HeadOfState,
    (SELECT ID FROM City WHERE Name = 'Seoul') AS Capital,
    'GK' AS Code2
FROM Country
WHERE Code IN ('PRK', 'KOR', 'CHN', 'JPN');

-- Transfert des villes vers Great Korea
UPDATE City 
SET CountryCode = 'GKR' 
WHERE CountryCode IN ('PRK', 'KOR', 'CHN', 'JPN');

-- Langues officielles
INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage) 
VALUES ('GKR', 'Korean', 'T', 5.0);

INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage) 
VALUES ('GKR', 'Chinese', 'T', 86.0);

INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage) 
VALUES ('GKR', 'Japanese', 'T', 9.0);

-- Création de l'armée
INSERT INTO ARMEE (code_pays, nombre_soldats, nombre_chars, nombre_avions) 
VALUES ('GKR', 4500000, 28000, 15000);

-- Suppression des anciens pays absorbés
DELETE FROM CountryLanguage WHERE CountryCode IN ('PRK', 'KOR', 'CHN', 'JPN');
DELETE FROM Country WHERE Code IN ('PRK', 'KOR', 'CHN', 'JPN');
