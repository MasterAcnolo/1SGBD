USE NewWorld;

START TRANSACTION;

-- Calculer la population totale de Québec + Ontario
SET @populationQuebecOntario := (
    SELECT SUM(Population)
    FROM city
    WHERE District IN ('Ontario','Québec')
);

INSERT INTO country 
(Code, Name, Continent, Region ,Population, Capital, SurfaceArea ,LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, IndepYear)
SELECT 
    'QCO', 
    'Québec-Ontario', 
    'North America', 
    'North America', 
    @populationQuebecOntario,
    1810,  -- ID de Montréal dans city
    2744000, -- Tiré d'internet ça, addition en brut, c'est pas bien mais bon pas trop le choix
    LifeExpectancy, 
    GNP * 0.60,
    GNPOld * 0.60, 
    LocalName, 
    'Confédération Du Québec et de l''Ontario', 
    'Keanu Reeves',
    2077
FROM country
WHERE Code = 'CAN';  -- copier les valeurs du Canada

-- Mise à jour du Canada : réduction des statistiques
UPDATE country
SET 
    Population = Population - @populationQuebecOntario,
    GNP = GNP * 0.40,
    GNPOld = GNPOld * 0.40
WHERE Code = 'CAN';

-- Déplacer les villes vers le nouveau pays
UPDATE city
SET CountryCode = 'QCO'
WHERE District IN ('Ontario','Québec');

COMMIT;
