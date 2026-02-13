USE NewWorld;

START TRANSACTION;

-- Les États-Uniens ont conquis de nouvelles terres au sud : ils occupent désormais le Mexique, Cuba, le Venezuela et la Colombie. 

-- Calcul des statistiques des pays annexés
SET @totalSurface := (
    SELECT SUM(SurfaceArea) 
    FROM Country 
    WHERE Code IN ('MEX', 'CUB', 'VEN', 'COL')
);

SET @totalPop := (
    SELECT SUM(Population) 
    FROM Country 
    WHERE Code IN ('MEX', 'CUB', 'VEN', 'COL')
);

SET @totalGNP := (
    SELECT SUM(GNP) 
    FROM Country 
    WHERE Code IN ('MEX', 'CUB', 'VEN', 'COL')
);

SET @totalGNPOld := (
    SELECT SUM(GNPOld) 
    FROM Country 
    WHERE Code IN ('MEX', 'CUB', 'VEN', 'COL')
);

-- Mise à jour des États-Unis : absorption des statistiques des pays annexés
UPDATE Country
SET 
    SurfaceArea = SurfaceArea + @totalSurface,
    Population = Population + @totalPop,
    GNP = GNP + @totalGNP,
    GNPOld = GNPOld + @totalGNPOld
WHERE Code = 'USA';

-- Transfert de toutes les villes des pays annexés vers les USA
UPDATE City
SET CountryCode = 'USA'
WHERE CountryCode IN ('MEX', 'CUB', 'VEN', 'COL');

-- Suppression des langues des pays annexés
DELETE FROM CountryLanguage
WHERE CountryCode IN ('MEX', 'CUB', 'VEN', 'COL');

-- Suppression des pays annexés
DELETE FROM Country
WHERE Code IN ('MEX', 'CUB', 'VEN', 'COL');

COMMIT;