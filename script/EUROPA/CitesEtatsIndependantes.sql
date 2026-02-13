USE WorldCopy;

START TRANSACTION;

-- Lyon, Caen et Lille sont désormais trois cités-États indépendantes.

-- Calcul de la population des trois cités
SET @populationLyon := (
    SELECT Population
    FROM City
    WHERE ID = 2976
);

SET @populationLille := (
    SELECT Population
    FROM City
    WHERE ID = 2986
);

SET @populationCaen := (
    SELECT Population
    FROM City
    WHERE ID = 3003
);

SET @populationTotale := @populationLyon + @populationLille + @populationCaen;

-- Création de la cité-État de Lyon
INSERT INTO Country 
(Code, Name, Continent, Region, Population, Capital, SurfaceArea, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, IndepYear)
SELECT 
    'LYO', 
    'Cité-État de Lyon', 
    'Europe', 
    'Western Europe', 
    @populationLyon,
    2976,  -- ID de Lyon
    50,  -- Petit territoire urbain
    LifeExpectancy, 
    GNP * 0.03,  -- 3% du GNP français
    GNPOld * 0.03, 
    'Lyon', 
    'Cité-État',
    'Conseil Municipal de Lyon',
    2026
FROM Country
WHERE Code = 'FRA';

-- Création de la cité-État de Lille
INSERT INTO Country 
(Code, Name, Continent, Region, Population, Capital, SurfaceArea, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, IndepYear)
SELECT 
    'LIL', 
    'Cité-État de Lille', 
    'Europe', 
    'Western Europe', 
    @populationLille,
    2986,  -- ID de Lille
    35,  -- Petit territoire urbain
    LifeExpectancy, 
    GNP * 0.015,  -- 1.5% du GNP français
    GNPOld * 0.015, 
    'Lille', 
    'Cité-État',
    'Conseil Municipal de Lille',
    2026
FROM Country
WHERE Code = 'FRA';

-- Création de la cité-État de Caen
INSERT INTO Country 
(Code, Name, Continent, Region, Population, Capital, SurfaceArea, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, IndepYear)
SELECT 
    'CAE', 
    'Cité-État de Caen', 
    'Europe', 
    'Western Europe', 
    @populationCaen,
    3003,  -- ID de Caen
    25,  -- Petit territoire urbain
    LifeExpectancy, 
    GNP * 0.01,  -- 1% du GNP français
    GNPOld * 0.01, 
    'Caen', 
    'Cité-État',
    'Conseil Municipal de Caen',
    2026
FROM Country
WHERE Code = 'FRA';

-- Mise à jour de la France : réduction de la population et du GNP
UPDATE Country
SET Population = Population - @populationTotale,
    GNP = GNP * 0.945,
    GNPOld = GNPOld * 0.945
WHERE Code = 'FRA';

-- Transfert de Lyon vers sa cité-État
UPDATE City
SET CountryCode = 'LYO'
WHERE ID = 2976;

-- Transfert de Lille vers sa cité-État
UPDATE City
SET CountryCode = 'LIL'
WHERE ID = 2986;

-- Transfert de Caen vers sa cité-État
UPDATE City
SET CountryCode = 'CAE'
WHERE ID = 3003;

-- Ajout de la langue officielle pour Lyon
INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage)
VALUES ('LYO', 'French', 'T', 100.0);

-- Ajout de la langue officielle pour Lille
INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage)
VALUES ('LIL', 'French', 'T', 100.0);

-- Ajout de la langue officielle pour Caen
INSERT INTO CountryLanguage (CountryCode, Language, IsOfficial, Percentage)
VALUES ('CAE', 'French', 'T', 100.0);

COMMIT;
