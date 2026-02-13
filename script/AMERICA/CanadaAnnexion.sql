USE WorldCopy;

START TRANSACTION;

-- Calcul population des états annexés
SET @populationEtats := (
    SELECT SUM(Population)
    FROM city
    WHERE CountryCode = 'USA'
      AND District IN ('Michigan','Wisconsin','Illinois','Alaska','Washington')
);

-- Mise à jour population USA (soustraction)
UPDATE country
SET Population = Population - @populationEtats
WHERE Code = 'USA';

-- Mise à jour population Canada (addition)
UPDATE country
SET Population = Population + @populationEtats
WHERE Code = 'CAN';

-- Transfert des villes vers le Canada
UPDATE city
SET CountryCode = 'CAN'
WHERE CountryCode = 'USA'
  AND District IN ('Michigan','Wisconsin','Illinois','Alaska','Washington');

COMMIT;