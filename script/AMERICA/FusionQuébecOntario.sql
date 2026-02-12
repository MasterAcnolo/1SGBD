USE NewWorld;

START TRANSACTION;

INSERT INTO country 
(Code, Name, Continent, Region ,Population, Capital, SurfaceArea ,LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, IndepYear)
SELECT 
    'QCO', 
    'Québec-Ontario', 
    'North America', 
    'North America', 
    0,  -- population temporaire, on mettra la vraie après
    1810,  -- ID de Montréal dans city
    2744000, -- Tiré d'internet ça, addition en brut, c'est pas bien mais bon pas trop le choix
    LifeExpectancy, 
    GNP, 
    GNPOld, 
    LocalName, 
    'Confédération Du Québec et de l''Ontario', 
    'Keanu Reeves',
    2077
FROM country
WHERE Code = 'CAN';  -- copier les valeurs du Canada

-- Calculer la population totale de Québec + Ontario
SET @populationQuebecOntario := (
    SELECT SUM(Population)
    FROM city
    WHERE District IN ('Ontario','Québec')
);

-- Mettre à jour la population du nouveau pays
UPDATE country
SET Population = @populationQuebecOntario
WHERE Code = 'QCO';

-- Déplacer les villes vers le nouveau pays
UPDATE city
SET CountryCode = 'QCO'
WHERE District IN ('Ontario','Québec');

COMMIT;

-- Vérification
SELECT * FROM country WHERE Code = 'QCO';
SELECT * FROM city WHERE CountryCode = 'QCO';
