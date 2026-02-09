# AMERIQUE - Scenarios detailles

## Donnees de reference (base World)

USA : Population USA | Surface USA | GNP USA | LifeExpectancy USA
CAN : Population CAN | Surface CAN | GNP CAN | LifeExpectancy CAN
MEX : Population MEX | Surface MEX | GNP MEX | LifeExpectancy MEX
CUB : Population CUB | Surface CUB | GNP CUB | LifeExpectancy CUB
VEN : Population VEN | Surface VEN | GNP VEN | LifeExpectancy VEN
COL : Population COL | Surface COL | GNP COL | LifeExpectancy COL

## Scenario 1 : Canada annexe 5 etats americains

Etats annexes : Michigan, Wisconsin, Illinois, Alaska, Washington

Population des etats (base sur villes) : SUM(Population villes des 5 etats)
- Illinois : Population villes Illinois
- Michigan : Population villes Michigan
- Wisconsin : Population villes Wisconsin
- Washington : Population villes Washington
- Alaska : Population villes Alaska

Table City :
UPDATE City SET CountryCode = 'CAN' 
WHERE CountryCode = 'USA' 
AND District IN ('Michigan', 'Wisconsin', 'Illinois', 'Alaska', 'Washington');

Table Country - Canada (CAN) :
UPDATE Country SET 
  Population = Population CAN + SUM(Population villes 5 etats),
  SurfaceArea = SurfaceArea CAN + Surface estimee 5 etats,
  GNP = GNP CAN + (SUM(Population villes 5 etats) / Population USA * GNP USA)
WHERE Code = 'CAN';

Table Country - USA :
UPDATE Country SET 
  Population = Population USA - SUM(Population villes 5 etats),
  SurfaceArea = SurfaceArea USA - Surface estimee 5 etats,
  GNP = GNP USA - (SUM(Population villes 5 etats) / Population USA * GNP USA)
WHERE Code = 'USA';

## Scenario 2 : Quebec-Ontario devient souverain

Nouveau pays QON (Quebec-Ontario)

Table Country - Creation :
INSERT INTO Country VALUES (
  'QON', 'Quebec-Ontario', 'North America', 'North America',
  Surface estimee Quebec+Ontario,
  SUM(Population villes Quebec + Ontario),
  id Montreal,
  LifeExpectancy moyenne CAN,
  GNP proportionnel,
  NULL,
  'Quebec-Ontario',
  'Federal Republic',
  'Prime Minister',
  'QO',
  NULL
);

Table City :
UPDATE City SET CountryCode = 'QON'
WHERE CountryCode = 'CAN' 
AND (District = 'Quebec' OR District = 'Québec' OR District = 'Ontario');

Table CountryLanguage - Pour QON :
INSERT INTO CountryLanguage VALUES ('QON', 'French', 'T', 40.0);
INSERT INTO CountryLanguage VALUES ('QON', 'English', 'T', 60.0);

Table Country - Canada (CAN) :
Soustraire population et surface de Quebec-Ontario
Changer capitale si necessaire (Ottawa est en Ontario)

## Scenario 3 : USA conquiert 4 pays

Pays conquis : Mexique (MEX), Cuba (CUB), Venezuela (VEN), Colombie (COL)

Population totale : Population MEX + Population CUB + Population VEN + Population COL
Surface totale : Surface MEX + Surface CUB + Surface VEN + Surface COL
GNP total : GNP MEX + GNP CUB + GNP VEN + GNP COL

Table City :
UPDATE City SET CountryCode = 'USA' 
WHERE CountryCode IN ('MEX', 'CUB', 'VEN', 'COL');

Table Country - USA :
UPDATE Country SET
  Population = Population USA + (Population MEX + Population CUB + Population VEN + Population COL),
  SurfaceArea = SurfaceArea USA + (Surface MEX + Surface CUB + Surface VEN + Surface COL),
  GNP = GNP USA + (GNP MEX + GNP CUB + GNP VEN + GNP COL),
  LifeExpectancy = Moyenne ponderee des 5 pays
WHERE Code = 'USA';

Table CountryLanguage - Pour USA :
Ajouter ou mettre a jour l'espagnol avec pourcentage plus eleve

Table CountryLanguage - Supprimer :
DELETE FROM CountryLanguage WHERE CountryCode IN ('MEX', 'CUB', 'VEN', 'COL');

Table Country - Supprimer :
DELETE FROM Country WHERE Code IN ('MEX', 'CUB', 'VEN', 'COL');

## Scenario 4 : Fusion pays hispanophones du sud

Pays fusionnes : Perou (PER), Bolivie (BOL), Chili (CHL), Argentine (ARG), Paraguay (PRY), Uruguay (URY), Equateur (ECU)

Donnees base World :
PER : Population PER | Surface PER | GNP PER | LifeExpectancy PER
BOL : Population BOL | Surface BOL | GNP BOL | LifeExpectancy BOL
CHL : Population CHL | Surface CHL | GNP CHL | LifeExpectancy CHL
ARG : Population ARG | Surface ARG | GNP ARG | LifeExpectancy ARG
PRY : Population PRY | Surface PRY | GNP PRY | LifeExpectancy PRY
URY : Population URY | Surface URY | GNP URY | LifeExpectancy URY
ECU : Population ECU | Surface ECU | GNP ECU | LifeExpectancy ECU

Population totale : SUM(Population 7 pays)
Surface totale : SUM(Surface 7 pays)
GNP total : SUM(GNP 7 pays)
LifeExpectancy : Moyenne ponderee par population

Nouveau pays NEU (New United States of America)

Table Country - Creation :
INSERT INTO Country VALUES (
  'NEU', 'New United States of America', 'South America', 'South America',
  SUM(Surface 7 pays),
  SUM(Population 7 pays),
  id Buenos Aires,
  LifeExpectancy moyenne ponderee,
  SUM(GNP 7 pays),
  NULL,
  'Nuevos Estados Unidos de America',
  'Federal Republic',
  'President',
  'NU',
  2026
);

Table City :
UPDATE City SET CountryCode = 'NEU'
WHERE CountryCode IN ('PER', 'BOL', 'CHL', 'ARG', 'PRY', 'URY', 'ECU');

Table CountryLanguage - Pour NEU :
INSERT INTO CountryLanguage VALUES ('NEU', 'Spanish', 'T', 95.0);
INSERT INTO CountryLanguage VALUES ('NEU', 'Quechua', 'F', 3.0);

Table CountryLanguage - Supprimer :
DELETE FROM CountryLanguage WHERE CountryCode IN ('PER', 'BOL', 'CHL', 'ARG', 'PRY', 'URY', 'ECU');

Table Country - Supprimer :
DELETE FROM Country WHERE Code IN ('PER', 'BOL', 'CHL', 'ARG', 'PRY', 'URY', 'ECU');

## Ordre d'execution

1. Scenario 3 (USA conquetes)
2. Scenario 1 (Canada annexe)
3. Scenario 2 (Quebec-Ontario)
4. Scenario 4 (Fusion hispanique)
