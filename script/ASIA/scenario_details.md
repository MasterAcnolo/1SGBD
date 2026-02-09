# ASIE - Scenarios detailles

## Donnees de reference (base World)

PRK (Coree du Nord) : Population PRK | Surface PRK | GNP PRK | LifeExpectancy PRK
KOR (Coree du Sud) : Population KOR | Surface KOR | GNP KOR | LifeExpectancy KOR
CHN (Chine) : Population CHN | Surface CHN | GNP CHN | LifeExpectancy CHN
JPN (Japon) : Population JPN | Surface JPN | GNP JPN | LifeExpectancy JPN

Ville importante :
- Seoul : id Seoul (Capitale Coree du Sud)

## Scenario unique : La Grande Coree

Etapes :
1. Fusion : Coree du Nord + Coree du Sud
2. Conquete : Chine
3. Conquete : Japon

Nouveau pays GKR (Great Korea)

Calculs totaux :
Population : Population PRK + Population KOR + Population CHN + Population JPN
Surface : Surface PRK + Surface KOR + Surface CHN + Surface JPN
GNP : GNP PRK + GNP KOR + GNP CHN + GNP JPN

LifeExpectancy (moyenne ponderee) :
Moyenne ponderee par population des 4 pays

Table Country - Creation :
INSERT INTO Country VALUES (
  'GKR', 'Great Korea', 'Asia', 'Eastern Asia',
  SUM(Surface PRK+KOR+CHN+JPN),
  SUM(Population PRK+KOR+CHN+JPN),
  id Seoul,
  LifeExpectancy moyenne ponderee,
  SUM(GNP PRK+KOR+CHN+JPN),
  NULL,
  'Daehan Guk',
  'Empire',
  'Emperor Kim',
  'GK',
  2026
);

Table City - Transferer toutes les villes :
UPDATE City SET CountryCode = 'GKR' 
WHERE CountryCode IN ('PRK', 'KOR', 'CHN', 'JPN');

Table CountryLanguage - Pour GKR :
INSERT INTO CountryLanguage VALUES ('GKR', 'Korean', 'T', 5.0);
INSERT INTO CountryLanguage VALUES ('GKR', 'Chinese', 'T', 86.0);
INSERT INTO CountryLanguage VALUES ('GKR', 'Japanese', 'T', 9.0);

Table CountryLanguage - Supprimer :
DELETE FROM CountryLanguage WHERE CountryCode IN ('PRK', 'KOR', 'CHN', 'JPN');

Table Country - Supprimer :
DELETE FROM Country WHERE Code IN ('PRK', 'KOR', 'CHN', 'JPN');

Impact geopolitique :
- 1ere puissance demographique mondiale
- 1ere puissance economique mondiale
- 2eme plus grand pays par superficie (apres Russie)
- Controle de la mer de Chine et Pacifique Ouest

Ordre d'execution :
1. Creer GKR
2. Transferer villes
3. Supprimer langues
4. Supprimer pays
