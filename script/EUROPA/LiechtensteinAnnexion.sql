USE NewWorld;

START TRANSACTION;

-- Le Liechtenstein a annexé la Suisse et la Lombardie.

-- Calcul des statistiques de la Suisse
SET @surfaceSuisse := (
    SELECT SurfaceArea
    FROM Country
    WHERE Code = 'CHE'
);

SET @populationSuisse := (
    SELECT Population
    FROM Country
    WHERE Code = 'CHE'
);

SET @gnpSuisse := (
    SELECT GNP
    FROM Country
    WHERE Code = 'CHE'
);

SET @gnpOldSuisse := (
    SELECT GNPOld
    FROM Country
    WHERE Code = 'CHE'
);

-- Calcul de la population de la Lombardie
SET @populationLombardie := (
    SELECT SUM(Population)
    FROM City
    WHERE CountryCode = 'ITA'
      AND District = 'Lombardia'
);

-- Estimation du GNP de la Lombardie (environ 20% du GNP italien)
SET @gnpLombardie := (
    SELECT GNP * 0.20
    FROM Country
    WHERE Code = 'ITA'
);

SET @gnpOldLombardie := (
    SELECT GNPOld * 0.20
    FROM Country
    WHERE Code = 'ITA'
);

-- Mise à jour du Liechtenstein : absorption de la Suisse et de la Lombardie
UPDATE Country
SET 
    SurfaceArea = SurfaceArea + @surfaceSuisse + 23800,  -- Surface Suisse + Lombardie (~23800 km²)
    Population = Population + @populationSuisse + @populationLombardie,
    GNP = GNP + @gnpSuisse + @gnpLombardie,
    GNPOld = GNPOld + @gnpOldSuisse + @gnpOldLombardie,
    Name = 'Grand-Duché du Liechtenstein',
    GovernmentForm = 'Empire du Liechtenstein'
WHERE Code = 'LIE';

-- Mise à jour de l'Italie : réduction des statistiques après perte de la Lombardie
UPDATE Country
SET 
    Population = Population - @populationLombardie,
    GNP = GNP * 0.80,
    GNPOld = GNPOld * 0.80
WHERE Code = 'ITA';

-- Transfert de toutes les villes suisses vers le Liechtenstein
UPDATE City
SET CountryCode = 'LIE'
WHERE CountryCode = 'CHE';

-- Transfert de toutes les villes de Lombardie vers le Liechtenstein
UPDATE City
SET CountryCode = 'LIE'
WHERE CountryCode = 'ITA'
  AND District = 'Lombardia';

-- Suppression des langues de la Suisse
DELETE FROM CountryLanguage
WHERE CountryCode = 'CHE';

-- Suppression de la Suisse
DELETE FROM Country
WHERE Code = 'CHE';

COMMIT;
