-- 1. USA conquiert MEX, CUB, VEN, COL
-- 2. Canada annexe 5 etats americains
-- 3. Quebec-Ontario devient souverain (QON)
-- 4. Fusion hispanique du sud (NEU)

USE NewWorld;

-- SCENARIO 1 : USA conquiert 4 pays

-- Etape 1.1 : Transferer les villes vers USA
UPDATE City 
SET CountryCode = 'USA' 
WHERE CountryCode IN ('MEX', 'CUB', 'VEN', 'COL');

-- Etape 1.2 : Mettre a jour USA (population, surface, GNP, esperance de vie)
UPDATE Country
SET Population = Population + (SELECT SUM(Population) FROM (SELECT Population FROM Country WHERE Code IN ('MEX', 'CUB', 'VEN', 'COL')) AS temp),
    SurfaceArea = SurfaceArea + (SELECT SUM(SurfaceArea) FROM (SELECT SurfaceArea FROM Country WHERE Code IN ('MEX', 'CUB', 'VEN', 'COL')) AS temp),
    GNP = GNP + (SELECT SUM(GNP) FROM (SELECT GNP FROM Country WHERE Code IN ('MEX', 'CUB', 'VEN', 'COL')) AS temp),
    LifeExpectancy = (
        (LifeExpectancy * Population + 
         (SELECT SUM(LifeExpectancy * Population) FROM (SELECT LifeExpectancy, Population FROM Country WHERE Code IN ('MEX', 'CUB', 'VEN', 'COL')) AS temp2))
        / 
        (Population + (SELECT SUM(Population) FROM (SELECT Population FROM Country WHERE Code IN ('MEX', 'CUB', 'VEN', 'COL')) AS temp3))
    )
WHERE Code = 'USA';

-- Etape 1.3 : Creer/Mettre a jour l'armee USA (renforcee par conquetes)
INSERT INTO ARMEE (code_pays, nombre_soldats, nombre_chars, nombre_avions)
VALUES ('USA', 2500000, 15000, 8000)
ON DUPLICATE KEY UPDATE
    nombre_soldats = 2500000,
    nombre_chars = 15000,
    nombre_avions = 8000;

-- Etape 1.4 : Supprimer les guerres impliquant ces pays
DELETE FROM GUERRE 
WHERE code_pays_1 IN ('MEX', 'CUB', 'VEN', 'COL') 
   OR code_pays_2 IN ('MEX', 'CUB', 'VEN', 'COL');

-- Etape 1.5 : Supprimer les langues des pays annexes
DELETE FROM CountryLanguage 
WHERE CountryCode IN ('MEX', 'CUB', 'VEN', 'COL');

-- Etape 1.6 : Supprimer les pays annexes
DELETE FROM Country 
WHERE Code IN ('MEX', 'CUB', 'VEN', 'COL');

-- ============================================
-- SCENARIO 2 : Canada annexe 5 etats americains
-- ============================================

-- Etape 2.1 : Transferer les villes des 5 etats vers Canada
UPDATE City 
SET CountryCode = 'CAN' 
WHERE CountryCode = 'USA' 
AND District IN ('Michigan', 'Wisconsin', 'Illinois', 'Alaska', 'Washington');

-- Etape 2.2 : Calculer et mettre a jour Canada
UPDATE Country
SET Population = Population + (SELECT SUM(Population) FROM City WHERE CountryCode = 'CAN' AND District IN ('Michigan', 'Wisconsin', 'Illinois', 'Alaska', 'Washington')),
    SurfaceArea = SurfaceArea + 2475000,
    GNP = GNP + ((SELECT SUM(Population) FROM City WHERE CountryCode = 'CAN' AND District IN ('Michigan', 'Wisconsin', 'Illinois', 'Alaska', 'Washington')) / 
                 (SELECT Population FROM Country WHERE Code = 'USA') * 
                 (SELECT GNP FROM Country WHERE Code = 'USA'))
WHERE Code = 'CAN';

-- Etape 2.3 : Mettre a jour USA (perd population et territoire)
UPDATE Country
SET Population = Population - (SELECT SUM(Population) FROM City WHERE CountryCode = 'CAN' AND District IN ('Michigan', 'Wisconsin', 'Illinois', 'Alaska', 'Washington')),
    SurfaceArea = SurfaceArea - 2475000,
    GNP = GNP - ((SELECT SUM(Population) FROM City WHERE CountryCode = 'CAN' AND District IN ('Michigan', 'Wisconsin', 'Illinois', 'Alaska', 'Washington')) / 
                 Population * GNP)
WHERE Code = 'USA';

-- Etape 2.4 : Creer/Mettre a jour l'armee Canada (renforcee par annexion)
INSERT INTO ARMEE (code_pays, nombre_soldats, nombre_chars, nombre_avions)
VALUES ('CAN', 850000, 5500, 3200)
ON DUPLICATE KEY UPDATE
    nombre_soldats = 850000,
    nombre_chars = 5500,
    nombre_avions = 3200;

-- ============================================
-- SCENARIO 3 : Quebec-Ontario devient souverain
-- ============================================

-- Etape 3.1 : Creer le nouveau pays Quebec-Ontario (QON)
INSERT INTO Country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2)
VALUES (
    'QON',
    'Quebec-Ontario',
    'North America',
    'North America',
    2618000,
    2026,
    (SELECT SUM(Population) FROM City WHERE CountryCode = 'CAN' AND (District = 'Quebec' OR District = 'Québec' OR District = 'Ontario')),
    79.4,
    (SELECT SUM(Population) FROM City WHERE CountryCode = 'CAN' AND (District = 'Quebec' OR District = 'Québec' OR District = 'Ontario')) / 
    (SELECT Population FROM Country WHERE Code = 'CAN') * 
    (SELECT GNP FROM Country WHERE Code = 'CAN'),
    NULL,
    'Quebec-Ontario',
    'Federal Republic',
    'Prime Minister',
    (SELECT ID FROM City WHERE Name = 'Montréal' LIMIT 1),
    'QO'
);

-- Etape 3.2 : Transferer les villes du Quebec et Ontario vers QON
UPDATE City 
SET CountryCode = 'QON' 
WHERE CountryCode = 'CAN' 
AND (District = 'Quebec' OR District = 'Québec' OR District = 'Ontario');

-- Etape 3.3 : Creer l'armee pour QON
INSERT INTO ARMEE (code_pays, nombre_soldats, nombre_chars, nombre_avions)
VALUES ('QON', 300000, 2000, 800);

-- Etape 3.4 : Ajouter les langues pour QON
INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage) VALUES
('QON', 'French', 'T', 40.0),
('QON', 'English', 'T', 60.0);

-- Etape 3.5 : Mettre a jour Canada (perd Quebec et Ontario)
UPDATE Country
SET Population = Population - (SELECT SUM(Population) FROM City WHERE CountryCode = 'QON'),
    SurfaceArea = SurfaceArea - 2618000,
    GNP = GNP - (SELECT GNP FROM Country WHERE Code = 'QON')
WHERE Code = 'CAN';

-- ============================================
-- SCENARIO 4 : Fusion hispanique du sud (NEU)
-- ============================================

-- Etape 4.1 : Creer le nouveau pays NEU
INSERT INTO Country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2)
SELECT 
    'NEU' AS Code,
    'New United States of America' AS Name,
    'South America' AS Continent,
    'South America' AS Region,
    SUM(SurfaceArea) AS SurfaceArea,
    2026 AS IndepYear,
    SUM(Population) AS Population,
    SUM(LifeExpectancy * Population) / SUM(Population) AS LifeExpectancy,
    SUM(GNP) AS GNP,
    NULL AS GNPOld,
    'Nuevos Estados Unidos de America' AS LocalName,
    'Federal Republic' AS GovernmentForm,
    'President' AS HeadOfState,
    (SELECT ID FROM City WHERE Name = 'Buenos Aires' LIMIT 1) AS Capital,
    'NU' AS Code2
FROM Country
WHERE Code IN ('PER', 'BOL', 'CHL', 'ARG', 'PRY', 'URY', 'ECU');

-- Etape 4.2 : Transferer toutes les villes vers NEU
UPDATE City 
SET CountryCode = 'NEU' 
WHERE CountryCode IN ('PER', 'BOL', 'CHL', 'ARG', 'PRY', 'URY', 'ECU');

-- Etape 4.3 : Creer l'armee NEU
INSERT INTO ARMEE (code_pays, nombre_soldats, nombre_chars, nombre_avions)
VALUES ('NEU', 800000, 4500, 2500);

-- Etape 4.4 : Supprimer les guerres impliquant ces pays
DELETE FROM GUERRE 
WHERE code_pays_1 IN ('PER', 'BOL', 'CHL', 'ARG', 'PRY', 'URY', 'ECU') 
   OR code_pays_2 IN ('PER', 'BOL', 'CHL', 'ARG', 'PRY', 'URY', 'ECU');

-- Etape 4.5 : Supprimer les langues des anciens pays
DELETE FROM CountryLanguage 
WHERE CountryCode IN ('PER', 'BOL', 'CHL', 'ARG', 'PRY', 'URY', 'ECU');

-- Etape 4.6 : Ajouter les langues pour NEU
INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage) VALUES
('NEU', 'Spanish', 'T', 95.0),
('NEU', 'Quechua', 'F', 3.0);

-- Etape 4.7 : Supprimer les anciens pays
DELETE FROM Country 
WHERE Code IN ('PER', 'BOL', 'CHL', 'ARG', 'PRY', 'URY', 'ECU');

-- ============================================
-- VERIFICATIONS
-- ============================================

-- USA apres conquetes et perte d'etats
SELECT Code, Name, Population, SurfaceArea, GNP, LifeExpectancy
FROM Country
WHERE Code = 'USA';

-- Canada apres annexion et perte de Quebec-Ontario
SELECT Code, Name, Population, SurfaceArea, GNP, LifeExpectancy
FROM Country
WHERE Code = 'CAN';

-- Quebec-Ontario
SELECT Code, Name, Population, SurfaceArea, GNP, Capital
FROM Country
WHERE Code = 'QON';

-- NEU (Nouveaux Etats-Unis d'Amerique)
SELECT Code, Name, Population, SurfaceArea, GNP, Capital
FROM Country
WHERE Code = 'NEU';

-- Verification des villes
SELECT CountryCode, COUNT(*) AS NombreVilles, SUM(Population) AS PopulationVilles
FROM City
WHERE CountryCode IN ('USA', 'CAN', 'QON', 'NEU')
GROUP BY CountryCode;

-- Verification des armees
SELECT code_pays, nombre_soldats, nombre_chars, nombre_avions
FROM ARMEE
WHERE code_pays IN ('USA', 'CAN', 'QON', 'NEU');