# EUROPE - Scenarios detailles

## Donnees de reference (base World)

FRA : Population FRA | Surface FRA | GNP FRA | LifeExpectancy FRA | Capital id Paris
CHE : Population CHE | Surface CHE | GNP CHE | LifeExpectancy CHE
ITA : Population ITA | Surface ITA | GNP ITA | LifeExpectancy ITA
LIE : Population LIE | Surface LIE | GNP LIE | LifeExpectancy LIE

Villes importantes :
- Rennes : id Rennes
- Tours : id Tours
- Lyon : id Lyon
- Caen : id Caen
- Lille : id Lille

Lombardie (Italie) :
- Population villes Lombardia
- Surface estimee Lombardie

## Scenario 1 : Bretagne independante (colonise Normandie)

Nouveau pays BZH (Bretagne)

Table Country - Creation :
INSERT INTO Country VALUES (
  'BZH', 'Bretagne', 'Europe', 'Western Europe',
  Surface estimee Bretagne + Normandie,
  SUM(Population villes Bretagne + Normandie),
  id Rennes,
  LifeExpectancy moyenne FRA,
  GNP proportionnel,
  NULL,
  'Breizh',
  'Republic',
  'President',
  'BZ',
  2026
);

Table City :
Identifier les villes de Bretagne et Normandie (sauf Caen deja cite-Etat)
UPDATE City SET CountryCode = 'BZH'
WHERE CountryCode = 'FRA' 
AND Name IN ('Rennes', 'Brest', 'Nantes', 'Saint-Nazaire', 'Lorient', 'Le Havre', 'Rouen', 'Cherbourg');

Table CountryLanguage - Pour BZH :
INSERT INTO CountryLanguage VALUES ('BZH', 'Breton', 'T', 50.0);
INSERT INTO CountryLanguage VALUES ('BZH', 'French', 'T', 100.0);

Table Country - France (FRA) :
Soustraire population et surface de Bretagne + Normandie

## Scenario 2 : Republique du Val de Loire

Nouveau pays VDL

Table Country - Creation :
INSERT INTO Country VALUES (
  'VDL', 'Republique du Val de Loire', 'Europe', 'Western Europe',
  Surface estimee region Centre,
  SUM(Population villes region Centre),
  id Tours,
  LifeExpectancy moyenne FRA,
  GNP proportionnel,
  NULL,
  'Republique du Val de Loire',
  'Republic',
  'President',
  'VL',
  2026
);

Table City :
UPDATE City SET CountryCode = 'VDL'
WHERE CountryCode = 'FRA' 
AND Name IN ('Tours', 'Orleans', 'Bourges', 'Blois', 'Chartres');

Table CountryLanguage - Pour VDL :
INSERT INTO CountryLanguage VALUES ('VDL', 'French', 'T', 100.0);

Table Country - France (FRA) :
Soustraire population et surface

## Scenario 3 : Lyon, Caen, Lille deviennent cites-Etats

A. Lyon (LYO)

Table Country - Creation :
INSERT INTO Country VALUES (
  'LYO', 'Lyon', 'Europe', 'Western Europe',
  Surface estimee agglomeration Lyon,
  Population ville Lyon,
  id Lyon,
  LifeExpectancy moyenne FRA,
  GNP proportionnel,
  NULL,
  'Lyon',
  'City State',
  'Mayor',
  'LY',
  2026
);

Table City :
UPDATE City SET CountryCode = 'LYO' WHERE Name = 'Lyon' AND CountryCode = 'FRA';

Table CountryLanguage :
INSERT INTO CountryLanguage VALUES ('LYO', 'French', 'T', 100.0);

B. Caen (CAE)

Table Country - Creation :
INSERT INTO Country VALUES (
  'CAE', 'Caen', 'Europe', 'Western Europe',
  Surface estimee agglomeration Caen,
  Population ville Caen,
  id Caen,
  LifeExpectancy moyenne FRA,
  GNP proportionnel,
  NULL,
  'Caen',
  'City State',
  'Mayor',
  'CA',
  2026
);

Table City :
UPDATE City SET CountryCode = 'CAE' WHERE Name = 'Caen' AND CountryCode = 'FRA';

Table CountryLanguage :
INSERT INTO CountryLanguage VALUES ('CAE', 'French', 'T', 100.0);

NOTE : Caen doit devenir independant AVANT le scenario Bretagne

C. Lille (LIL)

Table Country - Creation :
INSERT INTO Country VALUES (
  'LIL', 'Lille', 'Europe', 'Western Europe',
  Surface estimee metropole Lille,
  Population ville Lille,
  id Lille,
  LifeExpectancy moyenne FRA,
  GNP proportionnel,
  NULL,
  'Lille',
  'City State',
  'Mayor',
  'LI',
  2026
);

Table City :
UPDATE City SET CountryCode = 'LIL' WHERE Name = 'Lille' AND CountryCode = 'FRA';

Table CountryLanguage :
INSERT INTO CountryLanguage VALUES ('LIL', 'French', 'T', 100.0);

## Scenario 4 : Liechtenstein annexe Suisse et Lombardie

Donnees :
- Suisse : Population CHE | Surface CHE | GNP CHE
- Lombardie : Population villes Lombardia | Surface estimee Lombardie

Population totale LIE : Population LIE + Population CHE + Population villes Lombardia
Surface totale : Surface LIE + Surface CHE + Surface estimee Lombardie
GNP total : GNP LIE + GNP CHE + GNP proportionnel Lombardie

Table City - Suisse :
UPDATE City SET CountryCode = 'LIE' WHERE CountryCode = 'CHE';

Table City - Lombardie :
UPDATE City SET CountryCode = 'LIE' 
WHERE CountryCode = 'ITA' AND District = 'Lombardia';

Table Country - Liechtenstein (LIE) :
UPDATE Country SET
  Population = Population LIE + Population CHE + Population villes Lombardia,
  SurfaceArea = Surface LIE + Surface CHE + Surface Lombardie,
  GNP = GNP LIE + GNP CHE + GNP proportionnel Lombardie,
  LifeExpectancy = Moyenne ponderee des 3 entites
WHERE Code = 'LIE';

Table Country - Italie (ITA) :
UPDATE Country SET
  Population = Population ITA - Population villes Lombardia,
  SurfaceArea = SurfaceArea ITA - Surface Lombardie,
  GNP = GNP ITA - GNP proportionnel Lombardie
WHERE Code = 'ITA';

Table CountryLanguage - Pour LIE :
INSERT INTO CountryLanguage VALUES ('LIE', 'German', 'T', 60.0);
INSERT INTO CountryLanguage VALUES ('LIE', 'Italian', 'T', 35.0);
INSERT INTO CountryLanguage VALUES ('LIE', 'French', 'T', 4.0);
INSERT INTO CountryLanguage VALUES ('LIE', 'Romansh', 'T', 1.0);

Table CountryLanguage - Supprimer :
DELETE FROM CountryLanguage WHERE CountryCode = 'CHE';

Table Country - Supprimer :
DELETE FROM Country WHERE Code = 'CHE';

## Ordre d'execution

1. Caen devient cite-Etat (CAE)
2. Bretagne independante (BZH) - sans Caen
3. Lyon devient cite-Etat (LYO)
4. Lille devient cite-Etat (LIL)
5. Val de Loire independant (VDL)
6. Liechtenstein annexe (LIE)
