# RECAPITULATIF GLOBAL - SUPSIMULATION

## Vue d'ensemble

Document recapitulatif des scenarios a implementer dans la base de donnees World pour SupSimulation.

## Statistiques globales

### Nouveaux pays crees : 10
1. QON - Quebec-Ontario (Amerique)
2. NEU - New United States of America (Amerique du Sud)
3. BZH - Bretagne (Europe)
4. VDL - Republique du Val de Loire (Europe)
5. LYO - Lyon (Europe)
6. CAE - Caen (Europe)
7. LIL - Lille (Europe)
8. GKR - Great Korea (Asie)

### Pays agrandis : 2
1. CAN - Canada (annexe 5 etats americains)
2. LIE - Liechtenstein (annexe Suisse + Lombardie)

### Pays conquerants : 1
1. USA - Etats-Unis (conquiert 4 pays d'Amerique latine)

### Pays supprimes : 13

Amerique :
- MEX (Mexique) vers USA
- CUB (Cuba) vers USA
- VEN (Venezuela) vers USA
- COL (Colombie) vers USA
- PER (Perou) vers NEU
- BOL (Bolivie) vers NEU
- CHL (Chili) vers NEU
- ARG (Argentine) vers NEU
- PRY (Paraguay) vers NEU
- URY (Uruguay) vers NEU
- ECU (Equateur) vers NEU

Europe :
- CHE (Suisse) vers LIE

Asie :
- PRK (Coree du Nord) vers GKR
- KOR (Coree du Sud) vers GKR
- CHN (Chine) vers GKR
- JPN (Japon) vers GKR

### Pays diminues : 3
1. USA - Etats-Unis (perd 5 etats)
2. FRA - France (perd plusieurs regions)
3. ITA - Italie (perd la Lombardie)

---

## Resume par continent

### AMERIQUE (4 scenarios)

Scenario 1 : Canada annexe 5 etats americains
- Michigan, Wisconsin, Illinois, Alaska, Washington
- Impact : +Population villes des 5 etats pour Canada

Scenario 2 : Quebec-Ontario devient souverain
- Nouveau pays : QON (Quebec-Ontario)
- Capitale : Montreal (id Montreal)
- Impact : Canada perd Quebec et Ontario

Scenario 3 : USA conquiert 4 pays
- Mexique, Cuba, Venezuela, Colombie
- Impact : USA +Population MEX+CUB+VEN+COL, +Surface MEX+CUB+VEN+COL

Scenario 4 : Fusion hispanique du sud
- 7 pays fusionnent en NEU (New United States of America)
- Capitale : Buenos Aires (id Buenos Aires)
- Total : Population PER+BOL+CHL+ARG+PRY+URY+ECU, Surface PER+BOL+CHL+ARG+PRY+URY+ECU

Details : [ACTIONS/AMERICA/scenario_details.md](ACTIONS/AMERICA/scenario_details.md)

### EUROPE (4 scenarios)

Scenario 1 : Bretagne independante
- Nouveau pays : BZH (Bretagne)
- Colonise la Normandie, Capitale : Rennes (id Rennes)
- Langue officielle : Breton

Scenario 2 : Republique du Val de Loire
- Nouveau pays : VDL, Capitale : Tours (id Tours)
- Region Centre devient independante

Scenario 3 : Trois cites-Etats
- LYO (Lyon, id Lyon), CAE (Caen, id Caen), LIL (Lille, id Lille)

Scenario 4 : Liechtenstein devient une puissance
- Annexe Suisse + Lombardie (Italie)
- Impact : LIE passe de Population LIE a Population LIE+CHE+Lombardie

Details : [ACTIONS/EUROPA/scenario_details.md](ACTIONS/EUROPA/scenario_details.md)

### ASIE (1 scenario)

Scenario unique : La Grande Coree
- Fusion : Coree du Nord + Coree du Sud
- Conquete : Chine + Japon
- Nouveau pays : GKR (Great Korea)
- Total : Population PRK+KOR+CHN+JPN, Surface PRK+KOR+CHN+JPN
- GNP : GNP PRK+KOR+CHN+JPN

Details : [ACTIONS/ASIA/scenario_details.md](ACTIONS/ASIA/scenario_details.md)

---

## Ordre d'execution global recommande

### Phase 1 : ASIE (simple, pas de dependances)
1. Creer GKR
2. Transferer toutes les villes (PRK, KOR, CHN, JPN vers GKR)
3. Gerer les langues
4. Supprimer les 4 pays

### Phase 2 : AMERIQUE
1. USA conquiert (MEX, CUB, VEN, COL)
   - Transferer villes vers USA
   - Supprimer 4 pays
   
2. Canada annexe 5 etats
   - Transferer villes vers CAN
   - Ajuster USA et CAN
   
3. Quebec-Ontario independant
   - Creer QON
   - Transferer villes vers QON
   - Ajuster CAN
   
4. Fusion hispanique
   - Creer NEU
   - Transferer villes vers NEU
   - Supprimer 7 pays

### Phase 3 : EUROPE
1. Caen devient cite-Etat (Creer CAE, transferer Caen vers CAE)
2. Bretagne independante (Creer BZH, transferer Bretagne + Normandie sauf Caen vers BZH)
3. Lyon devient cite-Etat (Creer LYO, transferer Lyon vers LYO)
4. Lille devient cite-Etat (Creer LIL, transferer Lille vers LIL)
5. Val de Loire independant (Creer VDL, transferer Centre vers VDL)
6. Liechtenstein annexe (Transferer Suisse vers LIE, transferer Lombardie vers LIE, supprimer CHE)

## Operations SQL principales

Niveau debutant :

1. INSERT - Creer un nouveau pays
INSERT INTO Country (Code, Name, Continent, Region, SurfaceArea, Population, ...)
VALUES ('GKR', 'Great Korea', 'Asia', 'Eastern Asia', Surface calculee, Population calculee, ...);

2. UPDATE - Modifier des villes
UPDATE City SET CountryCode = 'GKR' WHERE CountryCode = 'CHN';

3. UPDATE - Modifier un pays existant
UPDATE Country 
SET Population = Population + Population a ajouter,
    SurfaceArea = SurfaceArea + Surface a ajouter
WHERE Code = 'CAN';

4. DELETE - Supprimer des langues
DELETE FROM CountryLanguage WHERE CountryCode = 'CHN';

5. DELETE - Supprimer un pays
DELETE FROM Country WHERE Code = 'CHN';

6. SELECT - Calculer des sommes (pour validation)
SELECT SUM(Population) FROM City WHERE CountryCode = 'CHN';

## Points d'attention critiques

ORDRE IMPERATIF pour respecter les cles etrangeres :
1. Creer le nouveau pays (si necessaire)
2. Transferer les villes (UPDATE City)
3. Supprimer les langues (DELETE CountryLanguage)
4. Supprimer les pays (DELETE Country)

JAMAIS l'inverse sinon erreur de contrainte.

Calculs de population : Utiliser les sommes des villes
SELECT SUM(Population) FROM City WHERE District = 'Michigan';

Identification des villes :
- Amerique : Par District (nom des etats)
- Europe France : Par nom de ville
- Lombardie : District = 'Lombardia' en Italie
- Suisse : CountryCode = 'CHE'
- Asie : Par CountryCode directement

## Validation des donnees

Apres chaque scenario, verifier :

-- Villes orphelines (ne devrait retourner aucune ligne)
SELECT * FROM City c WHERE NOT EXISTS (SELECT 1 FROM Country co WHERE co.Code = c.CountryCode);

-- Coherence population
SELECT co.Name, co.Population AS CountryPop, SUM(ci.Population) AS CitiesPop
FROM Country co LEFT JOIN City ci ON co.Code = ci.CountryCode
GROUP BY co.Code, co.Name;

## Ressources

- Base World originale : https://downloads.mysql.com/docs/world-db.zip
- Init script : init.sql
- Details Amerique : ACTIONS/AMERICA/scenario_details.md
- Details Europe : ACTIONS/EUROPA/scenario_details.md
- Details Asie : ACTIONS/ASIA/scenario_details.md
